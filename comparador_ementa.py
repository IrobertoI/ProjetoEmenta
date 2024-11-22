
import sqlite3

def conectar_bd(bd_projeto: str = "bd_projeto"):
    # Conectar ao banco de dados
    conn = sqlite3.connect(bd_projeto)
    cursor = conn.cursor()
    
    # Criar a tabela se ela não existir
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS ementas (
        codigo TEXT PRIMARY KEY,
        texto TEXT
    )
    ''')
    
    # Salvar alterações
    conn.commit()
    
    return conn, cursor