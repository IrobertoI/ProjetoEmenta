from django.shortcuts import render
from django.http import JsonResponse
from django.core.files.storage import FileSystemStorage

import mysql.connector
from fuzzywuzzy import fuzz
from . import extracao_npl


# Função para conectar ao banco de dados MySQL
def conectar_bd_mysql():
    try:
        conn = mysql.connector.connect(
            host="127.0.0.1",  # IP do servidor de banco de dados
            user="root",        # Seu usuário do MySQL
            password="22022002",        # Sua senha do MySQL
            database="bd_projeto", # Nome do banco de dados
            port="3307",  # Porta do banco de dados
        )
        if conn.is_connected():
            cursor = conn.cursor()
            return conn, cursor
    except mysql.connector.Error as e:
        print(f"Erro ao conectar ao MySQL: {e}")
        return None, None

# Função para comparar as disciplinas no banco de dados
def comparar_disciplina(texto_disciplina: str, cursor):
    cursor.execute("SELECT nome_disciplina, ementa FROM disciplinas")
    disciplinas_db = cursor.fetchall()
    resultados = []
    for id_disciplina, descricao_banco in disciplinas_db:
        similaridade = fuzz.ratio(texto_disciplina, descricao_banco)
        resultados.append({"id_disciplina": id_disciplina, "nome_disciplina": descricao_banco, "similaridade": similaridade})

    # Ordena por similaridade de forma decrescente
    resultados_ordenados = sorted(resultados, key=lambda x: x['similaridade'], reverse=True)
    return resultados_ordenados

def index(request):
    return render(request, 'index.html')

def upload_file(request):
    if request.method == 'POST' and request.FILES.get('file'):
        # Passo 1: Receber o arquivo do upload
        uploaded_file = request.FILES['file']

        # Passo 2: Salvar o arquivo temporariamente
        fs = FileSystemStorage()  # Usa o diretório padrão para salvar
        file_path = fs.save(uploaded_file.name, uploaded_file)  # Salva o arquivo
        full_path = fs.path(file_path)  # Caminho completo no servidor

        # Passo 3: Chamar o módulo de extração
        try:
            # Chama a função de extração no módulo `extracao_npl`
            extracted_data = extracao_npl.extrair_texto_pdf(full_path)

            # Passo 4: Conectar ao banco de dados MySQL
            conn, cursor = conectar_bd_mysql()
            if conn is None:
                raise Exception("Erro ao conectar ao banco de dados.")

            # Passo 5: Comparar as disciplinas extraídas com o banco de dados
            resultados_comparacao = comparar_disciplina(extracted_data, cursor)

            # Passo 6: Fechar a conexão com o banco de dados
            conn.close()

            # Passo 7: Retornar os resultados das comparações em formato JSON
            return JsonResponse({
                'status': 'success',
                'mensagem': 'Arquivo processado com sucesso!',
                'resultados': resultados_comparacao
            })

        except Exception as e:
            return JsonResponse({'status': 'error', 'message': str(e)})

    return JsonResponse({'error': 'Não foi possível enviar o arquivo.'}, status=400)
