# Projeto_BD
# Banco de Dados `bd_projeto`

## Índice

1. [Visão Geral](#visão-geral)
2. [Estrutura do Banco de Dados](#estrutura-do-banco-de-dados)
   - [Tabela `alunos`](#tabela-alunos)
   - [Tabela `cursos`](#tabela-cursos)
   - [Tabela `disciplinas`](#tabela-disciplinas)
   - [Tabela `bibliografia`](#tabela-bibliografia)
   - [Tabela `curso_disciplina`](#tabela-curso_disciplina)
3. [Relacionamentos do Banco](#relacionamentos-do-banco)
4. [Configuração e Requisitos](#configuração-e-requisitos)
5. [Instruções de Uso](#instruções-de-uso)
6. [Considerações Finais](#considerações-finais)

---

## Visão Geral

O banco de dados **`bd_projeto`** foi projetado para gerenciar informações de alunos, cursos, disciplinas e suas respectivas bibliografias em um sistema acadêmico. Ele é implementado utilizando MariaDB e segue uma estrutura relacional, com o objetivo de ser utilizado em ambientes acadêmicos para o controle e gerenciamento de dados relacionados a currículos de cursos superiores.

### Tecnologias Utilizadas

- **Banco de Dados**: MariaDB (versão 10.4.32)
- **Ferramenta de Exportação**: phpMyAdmin (versão 5.2.1)
- **Collation**: `utf8mb4_general_ci`
- **Charset**: `utf8mb4`

---

## Estrutura do Banco de Dados

Abaixo estão as principais tabelas e suas estruturas:

### Tabela `alunos`

Esta tabela armazena os dados dos alunos.

| Coluna         | Tipo            | Descrição                                                    |
|----------------|-----------------|--------------------------------------------------------------|
| `id_aluno`     | `int(11)`        | Chave primária, identificador único do aluno.                 |
| `nome_aluno`   | `varchar(255)`   | Nome completo do aluno.                                       |
| `curso_origem` | `varchar(255)`   | Nome do curso de origem do aluno (se aplicável).              |
| `id_curso`     | `int(11)`        | Chave estrangeira que faz referência à tabela `cursos`.       |

### Tabela `cursos`

Esta tabela armazena os cursos oferecidos.

| Coluna             | Tipo            | Descrição                                      |
|--------------------|-----------------|------------------------------------------------|
| `id_curso`         | `int(11)`        | Chave primária, identificador único do curso.   |
| `nome_curso`       | `varchar(255)`   | Nome do curso (ex: Engenharia de Software).     |
| `duracao_periodos` | `int(11)`        | Duração do curso em períodos acadêmicos.        |

### Tabela `disciplinas`

Esta tabela armazena as disciplinas que fazem parte dos cursos oferecidos.

| Coluna           | Tipo            | Descrição                                                  |
|------------------|-----------------|------------------------------------------------------------|
| `id_disciplina`  | `int(11)`        | Chave primária, identificador único da disciplina.          |
| `nome_disciplina`| `varchar(255)`   | Nome da disciplina.                                         |
| `ementa`         | `text`           | Descrição da ementa da disciplina.                         |
| `carga_horaria`  | `int(11)`        | Carga horária da disciplina (em horas).                    |
| `id_curso`       | `int(11)`        | Chave estrangeira que faz referência à tabela `cursos`.     |

### Tabela `bibliografia`

Armazena as referências bibliográficas (básicas e complementares) associadas às disciplinas.

| Coluna             | Tipo            | Descrição                                                   |
|--------------------|-----------------|-------------------------------------------------------------|
| `id_bibliografia`  | `int(11)`        | Chave primária, identificador único da bibliografia.         |
| `tipo`             | `enum`           | Tipo de bibliografia: 'Básica' ou 'Complementar'.            |
| `referencia`       | `text`           | Referência bibliográfica completa.                          |
| `id_disciplina`    | `int(11)`        | Chave estrangeira que faz referência à tabela `disciplinas`. |

### Tabela `curso_disciplina`

Tabela intermediária que mapeia o relacionamento muitos-para-muitos entre `cursos` e `disciplinas`.

| Coluna           | Tipo            | Descrição                                                |
|------------------|-----------------|----------------------------------------------------------|
| `id_curso`       | `int(11)`        | Chave estrangeira que faz referência à tabela `cursos`.   |
| `id_disciplina`  | `int(11)`        | Chave estrangeira que faz referência à tabela `disciplinas`.|

---

## Relacionamentos do Banco

O banco de dados foi estruturado para garantir a integridade dos relacionamentos entre os dados, utilizando chaves estrangeiras com a regra de **`ON DELETE CASCADE`**. Isso significa que, ao excluir um curso ou disciplina, todas as referências relacionadas (como alunos e bibliografias) serão automaticamente removidas para manter a consistência.

- **alunos** → **cursos**: Um aluno está associado a um curso.
- **disciplinas** → **cursos**: Um curso pode ter várias disciplinas, e uma disciplina pode ser oferecida em vários cursos.
- **bibliografia** → **disciplinas**: Cada disciplina pode ter bibliografias (básicas e complementares) associadas.

---

## Configuração e Requisitos

Requisitos do Sistema

- **Servidor de Banco de Dados**: MariaDB 10.4 ou superior
- **Ferramenta de Gerenciamento**: phpMyAdmin (Opcional)
- **Charset e Collation**: UTF8MB4 para suportar uma ampla gama de caracteres, incluindo emojis e outros síbolos especiais.

---

## Instruções de Uso

Após importar o banco de dados, você pode começar a interagir com as tabelas conforme sua aplicação requer. Algumas das funcionalidades do banco de dados incluem:

- **Cadastro de Alunos**: Permite a adição e consulta de informações de alunos e seus respectivos cursos.
- **Gerenciamento de Disciplinas**: Atribuição de disciplinas a cursos e controle da carga horária de cada uma.
- **Bibliografia de Disciplinas**:  Gestão das bibliografias básicas e complementares associadas às disciplinas.

 ---

## Considerações Finais

Este banco de dados foi projetado com foco em flexibilidade e integridade referencial, garantindo que as operações CRUD mantenham a consistência dos dados. Utilize as consultas SQL de exemplo para adaptar o banco às necessidades específicas de sua aplicação.

---

- **Autor**: Guilherme Campos Leite
- **Data**: 2024
- **Licença**: MIT license.

# Front-End do Sistema

## Introdução 

O sistema de aproveitamento de ementas desenvolvido para o Centro Universitário Unialfa
é uma aplicação web que permite aos alunos fazer o upload de ementas acadêmicas, avaliar
o aproveitamento das disciplinas e exibir o resultado do processamento. O front-end da 
aplicação foi projetado para ser simples, eficiente e responsivo, utilizando tecnologias
amplamente adotadas para o desenvolvimento de aplicações web modernas.

Este documento descreve de forma detalhada as tecnologias utilizadas, a estrutura do código
e os principais componentes envolvidos no front-end do sistema.

### Tecnologias Utilizadas

**HTML (HyperText Markup Language)**

O HTML é a principal linguagem de marcação utilizada para estruturar o conteúdo da página web.
No caso deste sistema, ele é responsável por definir a estrutura dos elementos da página, 
como cabeçalhos, formulários, botões e a exibição dos resultados. As principais características
do uso do HTML no sistema são:

**Estruturação de Formulários:**

Utilizamos um formulário para o envio de arquivos PDF, permitindo
que o aluno envie a sua ementa para ser processada pelo sistema.
Exibição de Resultados: Os resultados do processamento, como o período do aluno e as disciplinas
com suas porcentagens de aproveitamento, são exibidos dinamicamente utilizando elementos HTML como
listas e parágrafos.
Referências Estáticas: A página faz uso de arquivos estáticos (CSS, imagens e JavaScript) que são
carregados pelo Django, usando o recurso {% static %}.

**CSS (Cascading Style Sheets)**

O CSS é utilizado para definir a aparência e o layout da página. No sistema, o CSS foi empregado para:

- Design Responsivo: A página foi desenvolvida para ser responsiva, ou seja, ela se adapta a diferentes
tamanhos de tela, proporcionando uma boa experiência de usuário em dispositivos móveis e desktops.
Estilização do Tema Claro e Escuro: Foi implementada a funcionalidade de alternância entre tema claro
e tema escuro, permitindo ao usuário escolher a aparência da página.
Estilização de Elementos de Interação: Botões, campos de input e outras interações foram estilizados
para garantir uma aparência moderna e atraente.
O arquivo de estilo é carregado a partir da pasta estática do Django, e a mudança de tema é feita 
dinamicamente com o uso de classes CSS.

 **JavaScript**
 
O JavaScript é a linguagem de programação utilizada para dar interatividade ao sistema. Ele é responsável
por controlar o comportamento da página, como o envio de dados para o backend e a exibição dos resultados. 
Abaixo estão as principais funcionalidades implementadas com JavaScript:

# Envio de Arquivo para o Backend
A funcionalidade de envio de arquivos é implementada utilizando a API FormData do JavaScript. Quando o 
usuário clica no botão "Enviar", o arquivo PDF é enviado ao servidor através de uma requisição POST utilizando
a API fetch. O backend, ao processar o arquivo, retorna uma resposta contendo informações sobre o período e as 
disciplinas, que são então exibidas na página.

# Criação do Formulário de Envio: O arquivo selecionado pelo usuário é anexado a um objeto FormData, que é enviado
ao backend.
**Tratamento da Resposta do Backend:** A resposta do servidor, que é no formato JSON, contém as informações do período
e das disciplinas. Essas informações são exibidas dinamicamente na página.
Alternância entre Tema Claro e Escuro.
A alternância entre tema claro e escuro foi implementada utilizando a manipulação de classes CSS através do 
JavaScript. Ao clicar no botão de alternância, o JavaScript adiciona ou remove a classe dark-mode do corpo da 
página, do cabeçalho e do botão, alterando a aparência de acordo com o tema selecionado.

---

**Exibição de Resultados**

Os resultados são exibidos dinamicamente utilizando a manipulação de elementos HTML com JavaScript. Quando o 
backend envia os dados das disciplinas e do período, o JavaScript atualiza o conteúdo das seções da página, como:

**Exibindo o período em um parágrafo.**

Exibindo as disciplinas e seus aproveitamentos em uma lista.
Esses dados são extraídos da resposta JSON do backend e inseridos na estrutura HTML da página.

---

**Integração com o Backend (Django)**

A integração com o backend é feita através de requisições HTTP, utilizando a API fetch para enviar e receber 
dados do servidor. O front-end comunica-se com o backend por meio da URL configurada, que recebe a requisição 
de upload do arquivo e retorna os dados necessários para o processamento.
O backend, implementado em Django, é responsável por processar o arquivo PDF enviado, calcular o aproveitamento 
das disciplinas e retornar os dados necessários, como o período do aluno e a lista de disciplinas com suas 
porcentagens de aproveitamento.

A comunicação entre front-end e back-end segue o padrão RESTful, onde as requisições são feitas utilizando o 
método POST para o envio de arquivos e o método GET ou POST para a recuperação de dados processados.

---

# Fluxo de Funcionamento

- **Envio de Arquivo:** O aluno seleciona um arquivo PDF e clica no botão "Enviar".
- **Requisição ao Backend:** O JavaScript coleta o arquivo selecionado e envia para o backend via fetch (requisição POST).
- **Processamento no Backend:** O backend processa o arquivo e calcula as disciplinas e o aproveitamento.
- **Resposta do Backend:** O backend envia os dados do processamento (período, disciplinas e aproveitamento) em formato JSON.
- **Exibição dos Resultados:** O JavaScript recebe os dados e exibe-os dinamicamente na página.

# Conclusão

O sistema de aproveitamento de ementas foi desenvolvido utilizando tecnologias modernas e amplamente adotadas, como HTML, 
CSS e JavaScript. O front-end é responsável por fornecer uma interface intuitiva para o aluno, permitindo o envio de 
arquivos e a visualização dos resultados de maneira simples e eficiente.

---

A interação com o backend foi cuidadosamente planejada, garantindo que a comunicação entre o front-end e o back-end 
ocorra de forma fluida e que as informações retornadas sejam exibidas adequadamente.

---

Com a implementação do tema escuro e da manipulação dinâmica de dados, o sistema proporciona uma experiência 
agradável e interativa para os usuários.
