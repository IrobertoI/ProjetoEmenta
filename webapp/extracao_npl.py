import json
import fitz  # PyMuPDF para extração de texto do PDF
from fuzzywuzzy import fuzz  # Biblioteca para comparação de similaridade de strings
import mysql.connector  # Biblioteca para conexão com o MySQL
from django.http import JsonResponse

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

# Função para comparar o texto extraído com o banco de dados
def comparar_disciplina(texto_disciplina: str, cursor):
    # Alterando para consultar a tabela disciplinas
    cursor.execute("SELECT id_disciplina, descricao FROM disciplinas")
    disciplinas_db = cursor.fetchall()
    resultados = []
    for id_disciplina, descricao_banco in disciplinas_db:
        similaridade = fuzz.ratio(texto_disciplina, descricao_banco)
        resultados.append({"id_disciplina": id_disciplina, "similaridade": similaridade})
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
