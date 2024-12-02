import json
import fitz  # PyMuPDF para extração de texto do PDF
from sentence_transformers import SentenceTransformer  # Para gerar embeddings
from sklearn.metrics.pairwise import cosine_similarity  # Para calcular similaridade
import mysql.connector  # Biblioteca para conexão com o MySQL
from django.http import JsonResponse
import re

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
    # Remover caracteres especiais, números e normalizar o texto
    texto = re.sub(r'\s+', ' ', texto)  # Substituir múltiplos espaços por um único
    texto = texto.strip().lower()  # Remover espaços no início/fim e converter para minúsculas
    texto = re.sub(r'[^a-zA-Zá-úÁ-Ú0-9\s]', '', texto)  # Remover caracteres não alfanuméricos (exceto acentuação)
    return texto

# Função para gerar embeddings de textos
def gerar_embeddings(textos, modelo):
    return modelo.encode(textos)

# Função para comparar o texto extraído com o banco de dados (somente ementa)
def comparar_disciplina(texto_disciplina: str, cursor):
    # Alterando para consultar a tabela disciplinas com o campo ementa
    cursor.execute("SELECT id_disciplina, ementa FROM disciplinas")
    disciplinas_db = cursor.fetchall()
    
    # Lista de IDs e ementas do banco de dados
    ids_banco = [id_disciplina for id_disciplina, _ in disciplinas_db]
    ementas_banco = [ementa for _, ementa in disciplinas_db]
    
    # Carregar o modelo de embeddings (BERT)
    modelo = SentenceTransformer('paraphrase-MiniLM-L6-v2')
    
    # Gerar embeddings para o texto extraído e as ementas do banco
    texto_disciplina_processado = preprocessar_texto(texto_disciplina)
    embedding_pdf = gerar_embeddings([texto_disciplina_processado], modelo)[0]
    embeddings_banco = gerar_embeddings(ementas_banco, modelo)
    
    # Calcular similaridade de cosseno
    resultados = []
    for id_disciplina, embedding_banco in zip(ids_banco, embeddings_banco):
        similaridade = cosine_similarity([embedding_pdf], [embedding_banco])[0][0]
        
        # Adicionar apenas resultados com similaridade maior que 80%
        if similaridade > 0.7:
            resultados.append({"id_disciplina": id_disciplina, "similaridade": similaridade})
    
    # Ordenar os resultados pela maior similaridade
    resultados_ordenados = sorted(resultados, key=lambda x: x["similaridade"], reverse=True)
    return resultados_ordenados

# Função que vai processar o PDF e comparar com o banco de dados
def processar_pdf(caminho_pdf: str):
    conn, cursor = conectar_bd_mysql()
    
    if conn is not None:
        texto_disciplina = extrair_texto_pdf(caminho_pdf)
        resultados = comparar_disciplina(texto_disciplina, cursor)
        
        # Fechar a conexão com o banco de dados
        conn.close()

        # Retornar os resultados em formato JSON
        return JsonResponse({"status": "success", "resultados": resultados})
    else:
        return JsonResponse({"status": "error", "message": "Erro ao conectar ao banco de dados."})
