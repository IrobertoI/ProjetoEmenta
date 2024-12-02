import json
import fitz  # PyMuPDF para extração de texto do PDF
from sentence_transformers import SentenceTransformer  # Para gerar embeddings
from sklearn.metrics.pairwise import cosine_similarity  # Para calcular similaridade
import mysql.connector  # Biblioteca para conexão com o MySQL
from django.http import JsonResponse
import re
from typing import List  # Necessário para processar múltiplos PDFs

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
            cursor = conn.cursor()
            return conn, cursor
    except mysql.connector.Error as e:
        return None, str(e)

# Função para extrair texto de um PDF
def extrair_texto_pdf(caminho_pdf: str) -> str:
    texto_completo = ""
    with fitz.open(caminho_pdf) as pdf:
        for pagina in pdf:
            texto_completo += pagina.get_text()
    return texto_completo

# Função para pré-processar o texto (limpeza)
def preprocessar_texto(texto: str) -> str:
    texto = re.sub(r'\s+', ' ', texto)  # Substituir múltiplos espaços por um único
    texto = texto.strip().lower()  # Remover espaços no início/fim e converter para minúsculas
    texto = re.sub(r'[^a-zA-Zá-úÁ-Ú0-9\s]', '', texto)  # Remover caracteres não alfanuméricos (exceto acentuação)
    return texto

# Função para gerar embeddings de textos
def gerar_embeddings(textos, modelo):
    return modelo.encode(textos)

# Comparação de carga horária
def comparar_carga_horaria(carga_horaria_pdf: int, carga_horaria_bd: int) -> float:
    # Se a carga horária do PDF for menor que a do banco de dados, a similaridade será zero
    if carga_horaria_pdf < carga_horaria_bd:
        return 0.0  # Similaridade zero se a carga horária for menor
    else:
        # Se a carga horária do PDF for maior ou igual à do banco, considera-se a similaridade
        margem = 0.1 * carga_horaria_bd
        if abs(carga_horaria_pdf - carga_horaria_bd) <= margem:
            return 1.0  # Similaridade máxima se estiver dentro da margem
        return max(0, 1 - abs(carga_horaria_pdf - carga_horaria_bd) / carga_horaria_bd)

# Função para comparar o texto extraído com o banco de dados (ementa, carga horária)
def comparar_disciplina(texto_disciplina: str, carga_horaria_pdf: int, cursor):
    cursor.execute("SELECT id_disciplina, ementa, carga_horaria FROM disciplinas")
    disciplinas_db = cursor.fetchall()
    
    ids_banco = [id_disciplina for id_disciplina, _, _ in disciplinas_db]
    ementas_banco = [ementa for _, ementa, _ in disciplinas_db]
    cargas_horarias_banco = [carga_horaria for _, _, carga_horaria in disciplinas_db]
    
    modelo = SentenceTransformer('paraphrase-MiniLM-L6-v2')
    texto_disciplina_processado = preprocessar_texto(texto_disciplina)
    embedding_pdf = gerar_embeddings([texto_disciplina_processado], modelo)[0]
    embeddings_banco = gerar_embeddings(ementas_banco, modelo)
    
    resultados = []
    for id_disciplina, embedding_banco, carga_horaria_bd in zip(ids_banco, embeddings_banco, cargas_horarias_banco):
        # Se a carga horária do PDF for maior ou igual à do banco, calcula a similaridade da ementa
        if carga_horaria_pdf >= carga_horaria_bd:
            similaridade_ementa = cosine_similarity([embedding_pdf], [embedding_banco])[0][0]
            similaridade_carga_horaria = 1.0  # Similaridade máxima para carga horária maior ou igual
        else:
            # Se a carga horária do PDF for menor que a do banco, a similaridade de carga horária será zero
            similaridade_ementa = 0  # A similaridade da ementa é ignorada
            similaridade_carga_horaria = 0  # A similaridade de carga horária é zero
        
        # Combinação ponderada das similaridades
        similaridade_final = (0.7 * similaridade_ementa) + (0.3 * similaridade_carga_horaria)
        
        if similaridade_final > 0.7:  # Limite para considerar relevante
            resultados.append({
                "id_disciplina": id_disciplina,
                "similaridade_ementa": similaridade_ementa,
                "similaridade_carga_horaria": similaridade_carga_horaria,
                "similaridade_final": similaridade_final
            })
    
    return sorted(resultados, key=lambda x: x["similaridade_final"], reverse=True)

# Função que processa múltiplos PDFs
def processar_varios_pdfs(caminhos_pdfs: List[str]):
    conn, cursor = conectar_bd_mysql()
    
    if conn is not None:
        resultados_gerais = []
        
        for caminho_pdf in caminhos_pdfs:
            texto_disciplina = extrair_texto_pdf(caminho_pdf)
            # Extração da carga horária fictícia do texto do PDF (ajustar conforme necessário)
            carga_horaria_pdf = extrair_carga_horaria_do_texto(texto_disciplina)
            
            resultados = comparar_disciplina(texto_disciplina, carga_horaria_pdf, cursor)
            resultados_gerais.append({
                "arquivo": caminho_pdf,
                "resultados": resultados
            })
        
        conn.close()
        return JsonResponse({"status": "success", "resultados": resultados_gerais})
    else:
        return JsonResponse({"status": "error", "message": "Erro ao conectar ao banco de dados."})

# Função fictícia para extrair carga horária do texto (substitua com uma implementação real)
def extrair_carga_horaria_do_texto(texto: str) -> int:
    # Simplesmente procura por números no texto; ajuste conforme o formato esperado
    match = re.search(r'(\d+)\s*horas?', texto.lower())
    return int(match.group(1)) if match else 0
