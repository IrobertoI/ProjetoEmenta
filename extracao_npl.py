# Importações necessárias
import fitz  # PyMuPDF para extração de texto do PDF
import sqlite3  # Biblioteca para interação com banco de dados SQLite
from fuzzywuzzy import fuzz  # Biblioteca para comparação de similaridade de strings
from typing import List, Tuple  # Tipos de dados para anotações de tipos

# Função para extrair texto de um PDF
def extrair_texto_pdf(caminho_pdf: str) -> str:
    texto_completo = ""
    with fitz.open(caminho_pdf) as pdf:
        for pagina in pdf:
            texto_completo += pagina.get_text()
    return texto_completo

# Função para conectar ao banco de dados SQLite e criar a tabela
def conectar_bd(caminho_bd: str = "ementas.db"):
    conn = sqlite3.connect(caminho_bd)
    cursor = conn.cursor()
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS ementas (
        codigo TEXT PRIMARY KEY,
        texto TEXT
    )''')
    conn.commit()
    return conn, cursor

# Função para inserir uma ementa no banco de dados
def inserir_ementa(codigo: str, texto: str, cursor, conn):
    cursor.execute("INSERT OR REPLACE INTO ementas (codigo, texto) VALUES (?, ?)", (codigo, texto))
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
    # Exibir os resultados das comparações de similaridade
    for codigo, similaridade in resultados:
        print(f"Código: {codigo}, Similaridade: {similaridade}%")
    # Opcional: armazenar a ementa no banco de dados após extraí-la
    inserir_ementa("NOVA_EMENTA", texto_ementa, cursor, conn)

# Executar o pipeline completo
def main():
    # Caminho do PDF a ser analisado
    caminho_pdf = "ementa_exemplo.pdf"
    # Conectar ao banco de dados
    conn, cursor = conectar_bd()
    # Processar o PDF e comparar com a base de dados
    processar_pdf(caminho_pdf, cursor, conn)
    # Fechar a conexão com o banco de dados
    conn.close()

# Executa o programa principal
if __name__ == "__main__":
    main()

print("FIM")

