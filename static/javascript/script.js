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
document.getElementById('uploadForm').addEventListener('submit', function (event) {
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
    fetch('http://127.0.0.1:8000/upload/', {
        method: 'POST',
        body: formData,
    })
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }
            return response.json(); // Transforma a resposta em JSON
        })
        .then(data => {
            toggleLoading(false); // Oculta o spinner ao finalizar

            const resultsElement = document.getElementById('resultados');
            resultsElement.innerHTML = ''; // Limpa os resultados anteriores

            if (data.status === 'success' && Array.isArray(data.resultados) && data.resultados.length > 0) {
                // Itera sobre os arquivos no JSON
                data.resultados.forEach(arquivo => {
                    let output = `<strong>Resultados para o arquivo:</strong>
                    <br><br><strong>${arquivo.arquivo}</strong><br><br><ul>`;
                    
                    let hasValidResults = false; // Flag para verificar se há resultados válidos

                    // Verifica se há resultados e itera sobre eles
                    if (Array.isArray(arquivo.resultados) && arquivo.resultados.length > 0) {
                        arquivo.resultados.forEach(resultado => {
                            if (resultado.similaridade_media > 70) {
                                hasValidResults = true; // Se algum resultado tiver mais de 70% de similaridade, marca como válido
                            }
                            output += `
                                <li class="resultado-caixa">
                                    <strong>Disciplina:</strong> ${resultado.nome_disciplina}<br><br>
                                    <strong>Ementa:</strong> ${resultado.ementa}<br><br>
                                    <strong>Carga Horária:</strong> ${resultado.carga_horaria}<br><br>
                                    <strong>Similaridade:</strong> ${resultado.similaridade_media}%<br>
                                </li>`;
                        });
                    }

                    // Se não houver resultados com mais de 70% de similaridade, exibe a mensagem
                    if (!hasValidResults) {
                        output += '<li class="resultado-caixa">Nenhuma matéria aproveitada neste arquivo.</li>';
                    }

                    output += '</ul>';
                    resultsElement.innerHTML += output; // Adiciona os resultados ao HTML
                });
            } else {
                // Caso não haja resultados, exibe mensagem
                resultsElement.innerHTML = '<li class="resultado-caixa">Nenhuma matéria foi aproveitada neste arquivo.</li>';
            }
        })
        .catch(error => {
            toggleLoading(false); // Oculta o spinner caso ocorra erro
            console.error('Erro ao enviar arquivo:', error);
            document.getElementById('response').innerHTML = `<p>Erro ao enviar o arquivo: ${error.message}</p>`;
        });
});

// Função para alternar entre tema claro e escuro
document.getElementById('theme-toggle').addEventListener('click', toggleDarkMode);

function toggleDarkMode() {
    document.body.classList.toggle('dark-mode');
    document.querySelector('header').classList.toggle('dark-mode');
    document.getElementById('theme-toggle').classList.toggle('dark-mode');
}
