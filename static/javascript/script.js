// Função para enviar o arquivo para o backend
document.getElementById('uploadForm').addEventListener('submit', function(event) {
    event.preventDefault();  // Prevenir o envio padrão do formulário

    const formData = new FormData();  // Cria um objeto FormData
    const fileInput = document.getElementById('fileInput');
    formData.append('file', fileInput.files[0]);  // Adiciona o arquivo selecionado ao FormData

    // Envia o arquivo via POST usando fetch
    fetch('http://localhost:5000/upload', {  // URL do backend
        method: 'POST',
        body: formData,
    })
    .then(response => response.json())  // A resposta esperada é um JSON
    .then(data => {
        // Exibir a resposta do backend
        document.getElementById('response').innerHTML = `<p>Arquivo enviado com sucesso!</p>`;
        // Exibir as informações de aproveitamento
        const period = data.periodo;
        const aproveitamento = data.aproveitamento;

        let output = `<h3>Resultados do Aproveitamento:</h3>`;
        output += `<p>Período: ${period}</p>`;
        output += `<p>Aproveitamento: ${aproveitamento}%</p>`;

        document.getElementById('resultados').innerHTML = output;
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
