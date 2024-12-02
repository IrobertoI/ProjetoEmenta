import mysql.connector
import spacy
from fuzzywuzzy import fuzz
from django.shortcuts import render
from django.http import JsonResponse
from django.core.files.storage import FileSystemStorage
from . import extracao_npl
import re

# Carregar o modelo de linguagem em português do spaCy
nlp = spacy.load('pt_core_news_sm')

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

# Função para tokenizar e remover stopwords usando spaCy
def preprocessar_texto(texto):
    # Usar o spaCy para processar o texto
    doc = nlp(texto.lower())
    
    # Filtra as palavras (tokens) removendo stopwords e pontuação
    tokens_filtrados = [token.text for token in doc if not token.is_stop and not token.is_punct and token.is_alpha]
    
    return " ".join(tokens_filtrados)

# Função para comparar a carga horária extraída com a carga horária no banco
def comparar_carga_horaria(carga_horaria_pdf: int, carga_horaria_bd: int) -> float:
    if carga_horaria_pdf < carga_horaria_bd:
        return 0.0  # Similaridade 0 se a carga horária extraída for menor
    # Caso contrário, calcula uma similaridade proporcional
    similaridade = 1 - (carga_horaria_pdf - carga_horaria_bd) / carga_horaria_bd
    return max(0, similaridade)  # Garante que a similaridade nunca seja negativa

# Função para comparar as disciplinas no banco de dados (nome, ementa e carga horária)
def comparar_disciplina(texto_disciplina: str, carga_horaria_pdf: int, cursor):
    cursor.execute("SELECT nome_disciplina, ementa, carga_horaria FROM disciplinas")
    disciplinas_db = cursor.fetchall()
    
    # Lista para armazenar os resultados
    resultados = []
    
    # Pré-processar o texto extraído e as descrições do banco de dados
    texto_disciplina_processado = preprocessar_texto(texto_disciplina)
    
    for nome_disciplina, ementa, carga_horaria_bd in disciplinas_db:
        # Pré-processa o nome da disciplina, a ementa e a carga horária
        nome_disciplina_processado = preprocessar_texto(nome_disciplina)
        ementa_processada = preprocessar_texto(ementa)
        
        # Usando partial_ratio para comparar e ignorar variações pequenas no texto
        similaridade_nome = fuzz.partial_ratio(texto_disciplina_processado, nome_disciplina_processado)
        similaridade_ementa = fuzz.partial_ratio(texto_disciplina_processado, ementa_processada)

        # Comparar a carga horária
        similaridade_carga_horaria = comparar_carga_horaria(carga_horaria_pdf, carga_horaria_bd)
        
        # Verificar se a carga horária foi encontrada e ajustar os pesos
        if carga_horaria_pdf == 0:
            # Se a carga horária não foi encontrada, não inclui-la na similaridade final
            similaridade_media = (0.5 * similaridade_nome + 0.5 * similaridade_ementa)
        else:
            # Caso contrário, calcular a similaridade com base em todos os fatores
            similaridade_media = (0.2 * similaridade_nome + 0.6 * similaridade_ementa + 0.2 * similaridade_carga_horaria)
        
        # Se a similaridade for maior que 50%, adicionar ao resultado
        if similaridade_media > 70:
            resultados.append({
                "nome_disciplina": nome_disciplina,
                "ementa": ementa,
                "carga_horaria": carga_horaria_bd,
                "similaridade_media": similaridade_media
            })

    # Ordena por similaridade de forma decrescente
    resultados_ordenados = sorted(resultados, key=lambda x: x['similaridade_media'], reverse=True)
    return resultados_ordenados

def index(request):
    return render(request, 'index.html')

def upload_file(request):
    if request.method == 'POST' and request.FILES.getlist('files'):
        # Passo 1: Receber os arquivos do upload
        uploaded_files = request.FILES.getlist('files')  # Recebe múltiplos arquivos

        # Lista para armazenar os resultados de todos os arquivos
        resultados_gerais = []

        # Passo 2: Conectar ao banco de dados MySQL
        conn, cursor = conectar_bd_mysql()
        if conn is None:
            return JsonResponse({'status': 'error', 'message': 'Erro ao conectar ao banco de dados.'})

        try:
            fs = FileSystemStorage()  # Gerenciador de arquivos
            for uploaded_file in uploaded_files:
                # Passo 3: Salvar cada arquivo temporariamente
                file_path = fs.save(uploaded_file.name, uploaded_file)
                full_path = fs.path(file_path)  # Caminho completo no servidor

                # Passo 4: Extrair texto do arquivo PDF
                extracted_data = extracao_npl.extrair_texto_pdf(full_path)

                # Passo 5: Extrair a carga horária do texto (ajustar conforme necessário)
                carga_horaria_pdf = extrair_carga_horaria_do_texto(extracted_data)

                # Passo 6: Comparar o texto extraído com o banco de dados
                resultados_comparacao = comparar_disciplina(extracted_data, carga_horaria_pdf, cursor)

                # Passo 7: Adicionar os resultados ao retorno
                resultados_gerais.append({
                    'arquivo': uploaded_file.name,
                    'resultados': resultados_comparacao
                })

            # Fechar a conexão com o banco de dados
            conn.close()

            # Passo 8: Retornar os resultados em formato JSON
            return JsonResponse({
                'status': 'success',
                'mensagem': 'Arquivos processados com sucesso!',
                'resultados': resultados_gerais
            })

        except Exception as e:
            conn.close()  # Garantir que a conexão seja fechada em caso de erro
            return JsonResponse({'status': 'error', 'message': str(e)})

    return JsonResponse({'error': 'Nenhum arquivo enviado.'}, status=400)

# Função fictícia para extrair carga horária do texto (substitua com uma implementação real)
def extrair_carga_horaria_do_texto(texto: str) -> int:
    # Simplesmente procura por números no texto; ajuste conforme o formato esperado
    match = re.search(r'(\d+)\s*horas?', texto.lower())
    return int(match.group(1)) if match else 0
