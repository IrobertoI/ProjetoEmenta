// Função para enviar o arquivo para o backend
document.getElementById('uploadForm').addEventListener('submit', function(event) {
    event.preventDefault();  // Prevenir o envio padrão do formulário

    const formData = new FormData();  // Cria um objeto FormData
    const fileInput = document.getElementById('fileInput');
    formData.append('file', fileInput.files[0]);  // Adiciona o arquivo selecionado ao FormData

    // Envia o arquivo via POST usando fetch
    fetch('http://127.0.0.1:8000/upload/', {  // URL do backend
        method: 'POST',
        body: formData,
    })
    .then(response => response.json())  // A resposta esperada é um JSON
    .then(data => {
        if (data.status === 'success') {
            // Exibir a mensagem de sucesso
            document.getElementById('response').innerHTML = `<p>${data.mensagem}</p>`;
            
            // Exibir as disciplinas com similaridade acima de 70
            const resultados = data.resultados.filter(resultado => resultado.similaridade > 7);  // Filtra apenas maior que 70%
            if (resultados.length > 0) {
                let output = `<h3>Resultados:</h3><ul>`;
                resultados.forEach(resultado => {
                    
                    
                    let similaridade = resultado.similaridade;
                    if (similaridade < 10) {
                    similaridade *= 10;  // Ajuste para valores abaixo de 10, se necessário.
                }
                    output += `<li>
                        <strong>Disciplina:</strong> ${resultado.nome_disciplina}<br>
                        <strong>Similaridade:</strong> ${similaridade}%  <!-- Exibe como porcentagem -->
                    </li>`;
                });
                
                output += `</ul>`;
                document.getElementById('resultados').innerHTML = output;
            } else {
                document.getElementById('resultados').innerHTML = `<p>Nenhuma disciplina com similaridade acima de 70%.</p>`;
            }
        } else {
            // Caso ocorra um erro
            document.getElementById('response').innerHTML = `<p>Erro: ${data.message}</p>`;
        }
    })
    .catch(error => {
        // Caso ocorra algum erro
        console.error('Erro ao enviar arquivo:', error);
        document.getElementById('response').innerHTML = `<p>Erro ao enviar o arquivo.</p>`;
    });
});

// Função para alternar entre tema claro e escuro
document.getElementById('theme-toggle').addEventListener('click', toggleDarkMode);

function toggleDarkMode() {
    document.body.classList.toggle('dark-mode');
    document.querySelector('header').classList.toggle('dark-mode');
    document.getElementById('theme-toggle').classList.toggle('dark-mode');
}
