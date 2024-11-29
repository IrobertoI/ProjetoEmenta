# Importações necessárias
import fitz  # PyMuPDF para extração de texto do PDF
from fuzzywuzzy import fuzz  # Biblioteca para comparação de similaridade de strings
from typing import List, Tuple  # Tipos de dados para anotações de tipos
import mysql.connector  # Biblioteca para conexão com o MySQL
from mysql.connector import Error  # Importando classe de erro para captura de exceções

# Função para conectar ao banco de dados MySQL
def conectar_bd_mysql(host: str, usuario: str, senha: str, db_name: str):
    try:
        # Estabelecendo a conexão com o banco de dados MySQL
        conn = mysql.connector.connect(
            host=host,
            user=usuario,
            password=senha,
            database=db_name
        )
        if conn.is_connected():
            print("Conexão bem-sucedida com o banco de dados MySQL!")
            cursor = conn.cursor()
            return conn, cursor
    except Error as e:
        print(f"Erro ao conectar ao MySQL: {e}")
        return None, None





# Função para extrair texto de um PDF
def extrair_texto_pdf(caminho_pdf: str) -> str:
    texto_completo = ""
    with fitz.open(caminho_pdf) as pdf:
        for pagina in pdf:
            texto_completo += pagina.get_text()
    return texto_completo

# Função para conectar ao banco de dados SQLite e criar a tabela



    # Função para inserir uma ementa no banco de dados MySQL
def inserir_ementa(codigo: str, texto: str, cursor, conn):
    cursor.execute("INSERT INTO ementas (codigo, texto) VALUES (%s, %s) ON DUPLICATE KEY UPDATE texto=%s", (codigo, texto, texto))
    conn.commit()


# Função para buscar ementas no banco de dados e comparar similaridade
def comparar_ementa(texto_ementa: str, cursor) -> List[Tuple[str, int]]:
    cursor.execute("SELECT codigo, texto FROM ementas")
    ementas_db = cursor.fetchall()
    resultados = []
    for codigo, texto_banco in ementas_db:
        similaridade = fuzz.ratio(texto_ementa, texto_banco)
        resultados.append((codigo, similaridade))  # Ordenar os resultados por similaridade em ordem decrescente
    resultados_ordenados = sorted(resultados, key=lambda x: x[1], reverse=True)
    return resultados_ordenados


# Função principal para processar o PDF e comparar com a base de dados
def processar_pdf(caminho_pdf: str, cursor, conn):
    texto_ementa = extrair_texto_pdf(caminho_pdf)
    print("Comparando a ementa extraída com as ementas na base de dados...\n")
    resultados = comparar_ementa(texto_ementa, cursor)
    
    # Se não houver resultados com similaridade >= 70%, informar ao usuário
    if not resultados:
        print("Nenhuma ementa com similaridade suficiente (>= 70%) encontrada.")
    else:
        # Exibir os resultados das comparações de similaridade
        for codigo, similaridade in resultados:
            print(f"Código: {codigo}, Similaridade: {similaridade}%")
    
    # Opcional: armazenar a ementa no banco de dados após extraí-la
    inserir_ementa("NOVA_EMENTA", texto_ementa, cursor, conn)


# Executar o pipeline completo
def main():
    # Informações de conexão (fornecidas pelo seu colega)
    host = "127.0.01"  # ou o IP do servidor de banco de dados
    usuario = "root"
    senha = ""
    db_name = "bd_projeto"
    
    # Conectar ao banco de dados MySQL
    conn, cursor = conectar_bd_mysql(host, usuario, senha, db_name)
    
    if conn is not None:
        # Caminho do PDF a ser analisado
        caminho_pdf = "ementa_exemplo.pdf"
        # Processar o PDF e comparar com a base de dados
        processar_pdf(caminho_pdf, cursor, conn)
        # Fechar a conexão com o banco de dados
        conn.close()

# Executa o programa principal
if __name__ == "__main__":
    main()

print("FIM")

