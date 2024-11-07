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
