import os
import re
import fitz  # PyMuPDF

def extract_pdf_data_with_fitz(pdf_path):
    """Extrai informações de um PDF usando PyMuPDF."""
    with fitz.open(pdf_path) as doc:
        text = ""
        for page in doc:
            text += page.get_text()

    # Regex para capturar nome da disciplina, ementa e créditos
    disciplina_pattern = r"Disciplina:\s*(.+)"
    ementa_pattern = r"EMENTA\s+(.+?)(?:OBJETIVOS|CONTEÚDO|BIBLIOGRAFIA)"
    # Captura "Nº de Créditos" ou um número logo após o código da disciplina
    creditos_pattern = r"(?:Nº de Créditos\s+|CMP\d{4}\s+)(\d{1,2})"

    disciplina = re.search(disciplina_pattern, text, re.IGNORECASE)
    ementa = re.search(ementa_pattern, text, re.IGNORECASE | re.DOTALL)
    creditos = re.search(creditos_pattern, text, re.IGNORECASE)

    disciplina = disciplina.group(1).strip() if disciplina else "Não encontrada"
    ementa = ementa.group(1).strip() if ementa else "Não encontrada"
    creditos = int(creditos.group(1)) if creditos else None  # None para créditos ausentes

    return {"Disciplina": disciplina, "Ementa": ementa, "Créditos": creditos}

def process_pdfs(directory_path):
    """Processa todos os PDFs em um diretório e consolida as informações."""
    output_data = []
    total_creditos = 0

    for filename in os.listdir(directory_path):
        if filename.endswith(".pdf"):
            pdf_path = os.path.join(directory_path, filename)
            data = extract_pdf_data_with_fitz(pdf_path)
            if data["Créditos"] is not None:
                total_creditos += data["Créditos"]
            output_data.append(data)

    return output_data, total_creditos

def save_to_txt(data, total_creditos, output_file):
    """Salva os dados extraídos em um arquivo TXT."""
    with open(output_file, 'w', encoding='utf-8') as file:
        for item in data:
            file.write(f"Disciplina: {item['Disciplina']}\n")
            file.write(f"Ementa: {item['Ementa']}\n")
            if item["Créditos"] is not None:
                file.write(f"Créditos: {item['Créditos']} créditos\n")
            else:
                file.write("Créditos: Não encontrados (verificar manualmente)\n")
            file.write("-" * 50 + "\n")
        
        # Adicionando o total consolidado
        total_horas = total_creditos * 20
        file.write(f"\nTotal de Créditos: {total_creditos}\n")
        file.write(f"Total de Horas: {total_horas} horas\n")

def main():
    directory_path = input("Digite o caminho do diretório com os PDFs: ")
    output_file = "dados_extraidos.txt"

    if not os.path.exists(directory_path):
        print("Diretório não encontrado!")
        return

    print("Processando PDFs...")
    extracted_data, total_creditos = process_pdfs(directory_path)
    save_to_txt(extracted_data, total_creditos, output_file)
    print(f"Dados salvos em: {output_file}")

if __name__ == "__main__":
    main()
