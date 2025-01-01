import json
import fitz  # PyMuPDF para extração de texto do PDF
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import mysql.connector
from django.http import HttpResponse
import re
from typing import List

# Função para conectar ao banco de dados MySQL
def conectar_bd_mysql():
    try:
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="22022002",
            database="bd_projeto",
            port="3307",
        )
        if conn.is_connected():
            cursor = conn.cursor(dictionary=True)
            return conn, cursor
    except mysql.connector.Error as e:
        raise Exception(f"Erro ao conectar ao banco de dados: {str(e)}")

# Função para extrair texto de um PDF
def extrair_texto_pdf(caminho_pdf: str) -> str:
    texto_completo = ""
    with fitz.open(caminho_pdf) as pdf:
        for pagina in pdf:
            texto_completo += pagina.get_text("text")  # Usar o modo "text" é mais rápido
    return texto_completo

# Função para pré-processar o texto (limpeza)
def preprocessar_texto(texto: str) -> str:
    texto = re.sub(r'\s+', ' ', texto).strip().lower()
    return re.sub(r'[^a-zA-Zá-úÁ-Ú0-9\s]', '', texto)

# Função fictícia para extrair carga horária do texto
def extrair_carga_horaria_do_texto(texto: str) -> int:
    match = re.search(r'(\d+)\s*horas?', texto.lower())
    return int(match.group(1)) if match else 0

# Gerar streaming de resultados para o frontend via SSE
def gerar_streaming_comparacao(caminho_pdf, disciplinas_db, modelo):
    texto_pdf = extrair_texto_pdf(caminho_pdf)
    texto_processado = preprocessar_texto(texto_pdf)
    carga_horaria_pdf = extrair_carga_horaria_do_texto(texto_pdf)

    embedding_pdf = modelo.encode([texto_processado])[0]

    for disciplina in disciplinas_db:
        embedding_banco = disciplina["embedding"]  # Usar o embedding pré-calculado
        carga_horaria_bd = disciplina["carga_horaria"]

        similaridade_ementa = cosine_similarity([embedding_pdf], [embedding_banco])[0][0]
        similaridade_carga_horaria = 1.0 if carga_horaria_pdf >= carga_horaria_bd else 0.0
        similaridade_final = (0.7 * similaridade_ementa) + (0.3 * similaridade_carga_horaria)

        if similaridade_final > 0.7:
            resultado = {
                "id_disciplina": disciplina["id_disciplina"],
                "nome_disciplina": disciplina["nome_disciplina"],
                "ementa": disciplina["ementa"],
                "carga_horaria": disciplina["carga_horaria"],
                "similaridade_ementa": similaridade_ementa,
                "similaridade_carga_horaria": similaridade_carga_horaria,
                "similaridade_final": similaridade_final,
            }
            # Envia o resultado como um evento SSE
            yield f"data: {json.dumps(resultado)}\n\n"

# Função principal para processar PDFs e enviar os resultados via SSE
def processar_pdf(caminho_pdf: str):
    conn, cursor = conectar_bd_mysql()
    try:
        cursor.execute("SELECT id_disciplina, nome_disciplina, ementa, carga_horaria, embedding FROM disciplinas")
        disciplinas_db = cursor.fetchall()

        modelo = SentenceTransformer('paraphrase-MiniLM-L6-v2')

        # Salvar os embeddings no banco de dados caso não existam (caso nunca tenha sido feito)
        for disciplina in disciplinas_db:
            if "embedding" not in disciplina:
                embedding = modelo.encode([disciplina["ementa"]])[0]
                cursor.execute(
                    "UPDATE disciplinas SET embedding = %s WHERE id_disciplina = %s",
                    (embedding.tolist(), disciplina["id_disciplina"])
                )
                conn.commit()

        response = HttpResponse(
            gerar_streaming_comparacao(caminho_pdf, disciplinas_db, modelo),
            content_type="text/event-stream",
        )
        response["Cache-Control"] = "no-cache"
        response["Connection"] = "keep-alive"
        return response
    finally:
        conn.close()
