// Função para exibir ou ocultar o spinner de carregamento
function toggleLoading(show) {
    const loadingElement = document.getElementById('loading');
    if (show) {
        loadingElement.classList.remove('hidden'); // Exibe o spinner
    } else {
        loadingElement.classList.add('hidden'); // Oculta o spinner
    }
}

// Função para enviar os arquivos para o backend
document.getElementById('uploadForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevenir o envio padrão do formulário

    const formData = new FormData(); // Cria um objeto FormData
    const fileInput = document.getElementById('fileInput');
    
    // Adiciona todos os arquivos selecionados
    for (let i = 0; i < fileInput.files.length; i++) {
        formData.append('files', fileInput.files[i]); // Adiciona cada arquivo ao FormData
    }

    // Exibe o spinner enquanto processa
    toggleLoading(true);

    // Envia os arquivos via POST usando fetch
    fetch('http://127.0.0.1:8000/upload/', { // URL do backend
        method: 'POST',
        body: formData,
    })
    .then(response => response.json()) // A resposta esperada é um JSON
    .then(data => {
        toggleLoading(false); // Oculta o spinner após receber a resposta

        // Verifique o que foi retornado (inspecione a resposta completa)
        console.log(data); // Adicionando o log para inspecionar a resposta

        if (data.status === 'success') {
            // Exibir a mensagem de sucesso
            document.getElementById('response').innerHTML = `<p>${data.mensagem}</p>`;

            // Inicia a variável de resultados gerais
            let output = "";

            // Percorrer os arquivos e seus resultados
            data.resultados.forEach(arquivo => {
                // Adiciona o nome do arquivo
                output += `<strong>Resultados para o arquivo:</strong>
            <br>
            <br>
            <strong>${arquivo.arquivo}</strong>
            <br>
            <br>`;

                // Filtra as disciplinas com similaridade acima de 70%
                const resultados = arquivo.resultados.filter(resultado => resultado.similaridade_media > 70);

                // Se houver resultados, exibe-os
                if (resultados.length > 0) {
                    output += `<ul>`;
                    resultados.forEach(resultado => {
                        let similaridade = resultado.similaridade_media; // A similaridade já está em porcentagem
                        output += `
                        <li class="resultado-caixa">
                            <strong>Disciplina:</strong> ${resultado.nome_disciplina}<br>
                            <br>
                            <strong>Ementa:</strong> ${resultado.ementa}<br>
                            <br>
                            <strong>Carga Horária:</strong> ${resultado.carga_horaria}<br>
                            <br>
                            <strong>Similaridade:</strong> ${similaridade}%<br>
                        </li>`;
                    });
                    output += `</ul>`;
                } else {
                    output += `<li class="resultado-caixa">
                    <p>Nenhuma disciplina com similaridade acima de 70%.</p>
                    </li>`;
                }
                output += `<br>
                <hr>
                
                <br>
                <br>`;
            });

            // Coloca os resultados no elemento da página
            document.getElementById('resultados').innerHTML = output;

        } else {
            // Caso ocorra um erro
            document.getElementById('response').innerHTML = `<p>Erro: ${data.message}</p>`;
        }
    })
    .catch(error => {
        toggleLoading(false); // Oculta o spinner caso ocorra erro
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
