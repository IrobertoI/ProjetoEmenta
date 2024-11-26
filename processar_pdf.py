import re
import fitz  # PyMuPDF

def extract_pdf_data(pdf_path):
    """
    Extrai informações de todas as disciplinas de um PDF, incluindo nome da disciplina, ementa e créditos.
    """
    with fitz.open(pdf_path) as doc:
        text = ""
        for page in doc:
            text += page.get_text()

    # Regex para capturar nome da disciplina, ementa e créditos
    disciplina_pattern = r"([A-ZÀ-Ú][A-ZÀ-Ú\s]+)\nEmenta:"  # Captura nomes de disciplinas em maiúsculas seguidos de "Ementa"
    ementa_pattern = r"Ementa:\s+(.+?)(?=Bibliografia|$)"  # Captura a ementa até a palavra "Bibliografia" ou fim do texto
    creditos_pattern = r"(?:Nº de Créditos|Créditos|CREDITS):?\s*(\d+)"  # Regex para capturar créditos

    disciplinas = []
    for match in re.finditer(disciplina_pattern, text):
        disciplina = match.group(1).strip()  # Nome da disciplina

        # Buscar a ementa para cada disciplina encontrada
        ementa_match = re.search(ementa_pattern, text[match.end():], re.DOTALL)
        ementa = ementa_match.group(1).strip() if ementa_match else "Ementa não encontrada"

        # Buscar créditos para cada disciplina
        creditos_match = re.search(creditos_pattern, text[match.end():], re.IGNORECASE)
        creditos = int(creditos_match.group(1)) if creditos_match else None

        disciplinas.append({
            "Disciplina": disciplina,
            "Ementa": ementa,
            "Créditos": creditos
        })

    return disciplinas

def save_to_txt(disciplinas, output_file):
    """
    Salva as informações extraídas de todas as disciplinas em um arquivo TXT.
    """
    with open(output_file, 'w', encoding='utf-8') as file:
        for data in disciplinas:
            file.write(f"Disciplina: {data['Disciplina']}\n")
            file.write(f"Ementa: {data['Ementa']}\n")
            
            if data["Créditos"] is not None:
                horas = data["Créditos"] * 20
                file.write(f"Créditos: {data['Créditos']} créditos\n")
                file.write(f"Carga Horária: {horas} horas\n")
            else:
                file.write("Créditos: Não encontrados (verificar manualmente)\n")
                file.write("Carga Horária: Não encontrada (verificar manualmente)\n")
            
            file.write("-" * 50 + "\n")

def main():
    pdf_path = input("Digite o caminho do arquivo PDF: ")
    output_file = "dados_extraidos.txt"

    try:
        print("Processando PDF...")
        disciplinas = extract_pdf_data(pdf_path)
        save_to_txt(disciplinas, output_file)
        print(f"Dados salvos em: {output_file}")
    except Exception as e:
        print(f"Erro ao processar o PDF: {e}")

if __name__ == "__main__":
    main()
