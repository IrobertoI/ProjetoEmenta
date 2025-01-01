import mysql.connector
import spacy
from fuzzywuzzy import fuzz
from django.shortcuts import render
from django.http import JsonResponse
from django.core.files.storage import FileSystemStorage
from . import extracao_npl
import re
import os
import time


# Carregar o modelo de linguagem em português do spaCy
nlp = spacy.load('pt_core_news_sm')

# Função para conectar ao banco de dados MySQL
def conectar_bd_mysql():
    try:
        conn = mysql.connector.connect(
            host="127.0.0.1",
            user="root",
            password="22022002",
            database="bd_projeto",
            port="3307",
        )
        if conn.is_connected():
            cursor = conn.cursor()
            return conn, cursor
    except mysql.connector.Error as e:
        print(f"Erro ao conectar ao MySQL: {e}")
        return None, None

# Função para tokenizar e remover stopwords usando spaCy
def preprocessar_texto(texto):
    doc = nlp(texto.lower())
    tokens_filtrados = [token.text for token in doc if not token.is_stop and not token.is_punct and token.is_alpha]
    return " ".join(tokens_filtrados)

# Função para comparar a carga horária
def comparar_carga_horaria(carga_horaria_pdf: int, carga_horaria_bd: int) -> float:
    if carga_horaria_pdf < carga_horaria_bd:
        return 0.0
    similaridade = 1 - (carga_horaria_pdf - carga_horaria_bd) / carga_horaria_bd
    return max(0, similaridade)

# Função para garantir que o cursor e a conexão estão válidos antes de executar qualquer consulta
def verificar_conexao(cursor, conn):
    if cursor is None or conn is None or not conn.is_connected():
        conn, cursor = conectar_bd_mysql()
    return conn, cursor

# Função para comparar disciplinas no banco de dados
def comparar_disciplina(texto_disciplina: str, carga_horaria_pdf: int, cursor, conn):
    conn, cursor = verificar_conexao(cursor, conn)
    cursor.execute("SELECT nome_disciplina, ementa, carga_horaria FROM disciplinas")
    disciplinas_db = cursor.fetchall()

    texto_disciplina_processado = preprocessar_texto(texto_disciplina)

    for nome_disciplina, ementa, carga_horaria_bd in disciplinas_db:
        nome_disciplina_processado = preprocessar_texto(nome_disciplina)
        ementa_processada = preprocessar_texto(ementa)

        similaridade_nome = fuzz.partial_ratio(texto_disciplina_processado, nome_disciplina_processado)
        similaridade_ementa = fuzz.partial_ratio(texto_disciplina_processado, ementa_processada)
        similaridade_carga_horaria = comparar_carga_horaria(carga_horaria_pdf, carga_horaria_bd)

        if carga_horaria_pdf == 0:
            similaridade_media = (0.5 * similaridade_nome + 0.5 * similaridade_ementa)
        else:
            similaridade_media = (0.2 * similaridade_nome + 0.6 * similaridade_ementa + 0.2 * similaridade_carga_horaria)

        if similaridade_media > 70:
            yield {
                "nome_disciplina": nome_disciplina,
                "ementa": ementa,
                "carga_horaria": carga_horaria_bd,
                "similaridade_media": similaridade_media
            }

def index(request):
    return render(request, 'index.html')

def upload_file(request):
    if request.method == 'POST' and request.FILES.getlist('files'):
        uploaded_files = request.FILES.getlist('files')

        # Conectar ao banco de dados
        conn, cursor = conectar_bd_mysql()
        if conn is None or cursor is None:
            return JsonResponse({'status': 'error', 'message': 'Erro ao conectar ao banco de dados.'})

        try:
            fs = FileSystemStorage()

            all_results = []  # Lista para armazenar os resultados

            for uploaded_file in uploaded_files:
                file_path = fs.save(uploaded_file.name, uploaded_file)
                full_path = fs.path(file_path)

                # Extração de dados
                extracted_data = extracao_npl.extrair_texto_pdf(full_path)
                carga_horaria_pdf = extrair_carga_horaria_do_texto(extracted_data)

                # Processar as disciplinas e coletar os resultados
                resultados = []
                for resultado in comparar_disciplina(extracted_data, carga_horaria_pdf, cursor, conn):
                    resultados.append(resultado)

                # Remover o arquivo após o processamento, independentemente de similaridade
                if os.path.exists(full_path):
                    try:
                        os.remove(full_path)
                        print(f"Arquivo {full_path} removido com sucesso.")
                    except Exception as e:
                        print(f"Erro ao remover o arquivo {full_path}: {e}")

                # Armazenar os resultados
                if resultados:
                    all_results.append({
                        "arquivo": uploaded_file.name,
                        "resultados": resultados
                    })

            # Retornar os resultados como um JSON
            return JsonResponse({
                'status': 'success',
                'resultados': all_results
            })

        except Exception as e:
            if conn:
                conn.close()
            return JsonResponse({'status': 'error', 'message': str(e)})

        finally:
            if cursor:
                cursor.close()
            if conn:
                conn.close()

    return JsonResponse({'error': 'Nenhum arquivo enviado.'}, status=400)

def extrair_carga_horaria_do_texto(texto: str) -> int:
    match = re.search(r'(\d+)\s*horas?', texto.lower())
    return int(match.group(1)) if match else 0
