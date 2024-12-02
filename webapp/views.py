import mysql.connector
import spacy
from fuzzywuzzy import fuzz
from django.shortcuts import render 
from django.http import JsonResponse
from django.core.files.storage import FileSystemStorage
from . import extracao_npl

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

# Função para comparar as disciplinas no banco de dados
def comparar_disciplina(texto_disciplina: str, cursor):
    cursor.execute("SELECT nome_disciplina, ementa FROM disciplinas")
    disciplinas_db = cursor.fetchall()
    
    # Lista para armazenar os resultados
    resultados = []
    
    # Pré-processar o texto extraído e as descrições do banco de dados
    texto_disciplina_processado = preprocessar_texto(texto_disciplina)
    
    for nome_disciplina, ementa in disciplinas_db:
        # Pré-processa o nome da disciplina e a ementa
        nome_disciplina_processado = preprocessar_texto(nome_disciplina)
        ementa_processada = preprocessar_texto(ementa)
        
        # Usando partial_ratio para comparar e ignorar variações pequenas no texto
        similaridade_nome = fuzz.partial_ratio(texto_disciplina_processado, nome_disciplina_processado)
        similaridade_ementa = fuzz.partial_ratio(texto_disciplina_processado, ementa_processada)

        # A média das similaridades nome e ementa
        similaridade_media = (similaridade_nome + similaridade_ementa) / 2
        
        # Se a similaridade for maior que 70%, adicionar ao resultado
        if similaridade_media > 0.5:
            resultados.append({
                "nome_disciplina": nome_disciplina,
                "ementa": ementa,  
                "similaridade_media": similaridade_media
            })

    # Ordena por similaridade de forma decrescente
    resultados_ordenados = sorted(resultados, key=lambda x: x['similaridade_media'], reverse=True)
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
