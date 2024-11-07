-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 07/11/2024 às 20:24
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `bd_projeto`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `alunos`
--

CREATE TABLE `alunos` (
  `id_aluno` int(11) NOT NULL,
  `nome_aluno` varchar(255) NOT NULL,
  `curso_origem` varchar(255) DEFAULT NULL,
  `id_curso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `anexos`
--

CREATE TABLE `anexos` (
  `id_anexo` int(11) NOT NULL,
  `id_aluno` int(11) DEFAULT NULL,
  `nome_arquivo` varchar(255) NOT NULL,
  `caminho_arquivo` varchar(255) NOT NULL,
  `data_upload` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `bibliografia`
--

CREATE TABLE `bibliografia` (
  `id_bibliografia` int(11) NOT NULL,
  `tipo` enum('Básica','Complementar') NOT NULL,
  `referencia` text NOT NULL,
  `id_disciplina` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `bibliografia`
--

INSERT INTO `bibliografia` (`id_bibliografia`, `tipo`, `referencia`, `id_disciplina`) VALUES
(1, 'Básica', 'GOLDEMBERG, José; LUCON, Oswaldo. Energia, meio ambiente & desenvolvimento.\r\n3.ed. São Paulo: EDUSP, 2012.\r\nHOLTZAPPLE, Mark Thomas; REECE, W. Dan. Introdução à engenharia. Rio de Janeiro:\r\nLTC, 2015.\r\nBROCKMAN, Jay B. Introdução à engenharia: modelagem e solução de problemas. Rio\r\nde Janeiro: LTC, 2013. ', 250),
(2, 'Complementar', 'BRAGA, Benedito et al. Introdução à engenharia ambiental: o desafio do desenvolvimento\r\nsustentável. 2. ed. São Paulo: Pearson Prentice Hall, 2005.\r\nBOULOS, Paulo. Pré-cálculo. São Paulo: Pearson Makron Books, 2001.\r\nPEREIRA, Luiz Teixeira do Vale; BAZZO, Walter Antonio. Introdução à engenharia:\r\nconceitos, ferramentas e comportamentos. 2. ed. Florianópolis: UFSC, 2008.\r\nDANTAS, Rubens Alves. Engenharia de avaliações: uma introdução à metodologia\r\ncientífica. 3. ed. São Paulo: PINI, 2012.\r\nTÁBOAS, Plácido Zoega. Cálculo em uma variável real. São Paulo: EDUSP, 2008. ', 250),
(3, 'Básica', 'DEMANA, Franklin D.; WAITS, Bert K.; FOLEY, Gregory D. Pré-cálculo. 2.ed. São\r\nPaulo: Pearson, 2013.\r\nIEZZI, Gelson; MURAKAMI, Carlos. Fundamentos de matemática elementar: conjuntos,\r\nfunções. 9. ed. São Paulo: Atual, 2013. v.1.\r\nDANTE, Luiz Roberto. Matemática: contexto e aplicações. Volume único. 3. ed. São\r\nPaulo: Ática, 2009. ', 251),
(4, 'Complementar', 'IEZZI, Gelson. Fundamentos de matemática elementar: geometria analítica. 6.ed. São\r\nPaulo: Atual. 2013.\r\nIEZZI, Gelson et al. Matemática: volume único. São Paulo: Atual 2011.\r\nGIOVANNI, José Ruy; BONJORNO, José Roberto; GIOVANNI JR.; José Ruy.\r\nMatemática completa. Volume único. São Paulo: FTD, 2002.\r\nSTEWART, James. Cálculo. 7 ed. São Paulo: Cengage Learning, 2015.\r\nWINTERLE, Paulo. Vetores e geometria analítica. 2.ed. São Paulo: Pearson Education do\r\nBrasil, 2014. ', 251);

-- --------------------------------------------------------

--
-- Estrutura para tabela `cursos`
--

CREATE TABLE `cursos` (
  `id_curso` int(11) NOT NULL,
  `nome_curso` varchar(255) NOT NULL,
  `duracao_periodos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `cursos`
--

INSERT INTO `cursos` (`id_curso`, `nome_curso`, `duracao_periodos`) VALUES
(5, 'Analise e desenvolvimento de sistemas', 4),
(6, 'Engenharia de software', 10),
(7, 'Sistemas de informação', 10),
(8, 'Ciência da Computação', 10);

-- --------------------------------------------------------

--
-- Estrutura para tabela `curso_disciplina`
--

CREATE TABLE `curso_disciplina` (
  `id_curso` int(11) NOT NULL,
  `id_disciplina` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `curso_disciplina`
--

INSERT INTO `curso_disciplina` (`id_curso`, `id_disciplina`) VALUES
(5, 327),
(7, 327);

-- --------------------------------------------------------

--
-- Estrutura para tabela `disciplinas`
--

CREATE TABLE `disciplinas` (
  `id_disciplina` int(11) NOT NULL,
  `nome_disciplina` varchar(255) NOT NULL,
  `ementa` text NOT NULL DEFAULT current_timestamp(),
  `carga_horaria` int(11) DEFAULT NULL,
  `id_curso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `disciplinas`
--

INSERT INTO `disciplinas` (`id_disciplina`, `nome_disciplina`, `ementa`, `carga_horaria`, `id_curso`) VALUES
(250, 'INTRODUÇÃO À ENGENHARIA', 'Ementa: Conceitos fundamentais de Engenharia. Motivação dos estudantes em relação à\r\nengenharia. Desenvolvimento de aptidões para a resolução de problemas. O processo de\r\num projeto de engenharia. Tabelas e gráficos. Sistemas de unidades e conversão de\r\nunidades. ', 60, 7),
(251, 'PRÉ-CÁLCULO', 'Ementa: Operações no Conjunto dos Números Reais. Polinômios: conceito e operações.\r\nExpressões Fracionárias Algébricas. Equações de 1º e 2º graus. Inequações de 1º e 2º graus.\r\nConceito e noções de Função. Estudo dos diversos tipos de Funções: Polinomial de 1º grau;\r\nPolinomial de 2º grau; Modular; Potência; Polinomial de grau maior que 2; Exponencial;\r\nLogarítmica; Compostas e Inversas. Sistemas de equações e matrizes. Noções de\r\nTrigonometria. Funções Trigonométricas. \r\n', 60, 5),
(252, 'GEOMETRIA ANALÍTICA', 'Ementa: Espaço dos vetores da geometria; Soma de vetores e multiplicação de vetores por\r\nnúmeros reais; dependência linear; base; coordenadas; mudança de base; produto escalar;\r\nproduto vetorial. Geometria analítica no espaço - sistemas de coordenadas; equações\r\nvetorial e paramétrica de retas e de planos; equação geral do plano; vetor normal a um\r\nplano. Posições relativas entre reta e plano; Distância entre dois pontos; Distância de ponto\r\nà reta; Distância de ponto a plano; Distância de reta a reta; Distância de reta a plano;\r\nDistância de plano a plano; Ângulos entre duas retas. Mudança de coordenadas.\r\nCircunferências e Esferas: Equação e gráfico; Planos tangentes. Coordenadas Polares:\r\nEsboço de Curvas em coordenadas polares; Retas e Circunferência em Coordenadas\r\nPolares. Cônicas: Elipse: Equação e gráfico; Parábola: Equação e gráfico; Hipérbole:\r\nEquação e gráfico. Equação Geral do segundo Grau. Quádricas: Esfera; Paraboloide;\r\nElipsoide; Hiperboloide de uma folha; Hiperboloide de duas folhas. Parametrizações ', 60, 8),
(253, 'QUÍMICA GERAL TECNOLÓGICA', 'Ementa: Ligações químicas: iônica, covalente, metálica, van der Waals, pontes de\r\nhidrogênio; Eletroquímica; Corrosão de materiais metálicos; Tensoativos; Combustão e\r\nCombustíveis. Laboratório: experimentos de laboratório sobre: Análise de misturas\r\ngasosas; Poder calorífico de combustíveis; Viscosidade de óleos lubrificantes; Pilhas e\r\nacumuladores; Obtenção e caracterização de revestimentos; Corrosão galvânica.', 60, 8),
(254, 'COMUNICAÇÃO E EXPRESSÃO', 'Ementa: Estudo dos princípios e regras básicas de comunicação oral e escrita da Língua\r\nPortuguesa e sua aplicabilidade na interpretação e construção do texto acadêmico.', 60, 6),
(255, 'ÁLGEBRA LINEAR PARA ENGENHARIA', 'Ementa: Matrizes e Determinantes. Sistema de Equações Lineares. Vetores no Plano e no\r\nEspaço. Espaços Vetoriais. Base e Dimensão. Transformações Lineares. Autovalores e\r\nautovetores. Diagonalização de Matrizes.', 60, 8),
(256, 'CÁCULO I', 'Ementa: Derivadas; Integral Simples; Funções de Várias Variáveis; Limites; Derivadas\r\nParciais.', 60, 6),
(257, 'FÍSICA', 'Ementa: Unidades, Grandezas Físicas e Vetores. Movimento Retilíneo. Movimento em\r\nDuas ou Três Dimensões. Leis de Newton do Movimento. Aplicações das Leis de Newton.\r\nTrabalho e Energia Cinética. Energia Potencial e Conservação da Energia. Momento\r\nLinear, Impulso e Colisões. ', 60, 6),
(258, 'MATERIAIS PARA ENGENHARIA', 'Ementa: Utilização de diferentes materiais: metálicos, cerâmicos, poliméricos,\r\ncompósitos; conceituação de ciência e engenharia de materiais; aplicações dos diversos\r\ntipos de materiais; relação entre tipos de ligações dos materiais e suas propriedades; Meioambiente e a legislação pertinente Políticas de educação ambiental. Estrutura da matéria:\r\nestrutura dos sólidos: sólidos cristalinos: sólidos amorfos: sólidos parcialmente cristalinos;\r\nDefeitos em sólidos: defeitos puntiformes; defeitos de linha (discordâncias); Defeitos\r\nplanos ou bidimensionais; Formação da microestrutura: Relação entre a microestrutura e\r\npropriedades do material; processamento dos materiais metálicos; processamento dos\r\nmateriais cerâmicos; processamento dos materiais poliméricos.', 60, 6),
(259, 'METODOLOGIA CIENTÍFICA', 'Ementa: A construção do conhecimento. Tipos de conhecimento. A produção do\r\nconhecimento científico. Modalidades de trabalhos acadêmicos: resumo, pesquisa\r\nbibliográfica, relatório, artigo, resenha e projetos. Citações. Referências. Estrutura e apresentação de trabalhos acadêmicos de acordo com a ABNT. ', 60, 6),
(260, 'MECÂNICA GERAL', 'Ementa: Estática de corpo rígido: Equilíbrio de forças e momentos, e diagrama de corpo\r\nlivre; Esforços em estruturas; Centroide, Centro de Massa e Centro de Gravidade;\r\nMomento de Inércia, Módulo de Resistência e Momento Polar de Inércia.', 60, 8),
(261, 'NOÇÕES DE DESENHO TÉCNICO EM CAD', 'Ementa: Interpretação de desenhos técnicos por meio manual e computacional.\r\nConceituação de computação gráfica e áreas de aplicação. Conceituação e classificação de\r\naplicativos gráficos. Uso de bibliotecas e aplicativos gráficos: aplicações em projeto do\r\nproduto, projeto de posto de trabalho, layout, ergonomia e fluxos. Laboratório: Realização\r\ndos exercícios práticos de desenho de Geometria Descritiva, representação bidimensional\r\ne tridimensional. Uso do instrumental de desenho técnico completo. Desenvolvimento dos\r\nexercícios práticos de desenho técnico em computador, plataforma CAD.', 60, 6),
(262, 'ALGORITMOS E LINGUAGENS DE PROGRAMAÇÃO', 'Ementa: Breve história da computação. Algoritmos: caracterização, notação, estruturas\r\nbásicas. Computadores: unidades básicas, instruções, programa armazenado,\r\nendereçamento, programas em linguagem de máquina. Conceitos de linguagens\r\nalgorítmicas: expressões, comandos sequenciais, seletivos e repetitivos; entrada/saída;\r\nvariáveis estruturadas, funções. Desenvolvimento e documentação de programas.\r\nExemplos de processamento não-numérico. Laboratório: Extensa prática de programação\r\ne depuração de programas utilizando uma das linguagens de programação. ', 60, 6),
(263, 'ELETRICIDADE E MAGNETISMO', 'Ementa: Carga Elétrica e Campo Elétrico. Potencial Elétrico. Capacitância e Dielétricos.\r\nCorrente, Resistência e Força Eletromotriz. Resistores em Série e em Paralelo. Campo\r\nmagnético: princípios e definições: Movimento de cargas em campos magnéticos; Lei de\r\nAmpere; Lei da Indução de Faraday; Indutância: capacitores e indutores, circuitos RL;\r\nMagnetismo; Lei de Gauss; Propriedades Magnéticas da Matéria; Oscilações\r\nEletromagnéticas: Correntes Alternadas; Equações de Maxwell. A parte laboratorial da\r\ndisciplina deve conter experiências ligadas ao objetivo do curso, versando sobre reflexão e\r\npropagação de ondas, interferência eletromagnética, campo magnético de uma corrente e\r\nforças magnéticas sobre correntes, correntes alternadas, ondas eletromagnéticas.', 60, 8),
(264, 'PROBABILIDADE E ESTATÍSTICA', 'Ementa: Estudo das ideias básicas de probabilidades. Distribuições de Probabilidade.\r\nAnálise de Regressão e Correlação lineares simples e Aplicações. Estatística Descritiva.\r\nPrincipais distribuições de frequência. Medidas de Posição. Medidas de Dispersão. ', 60, 6),
(265, 'CIRCUITOS ELÉTRICOS I', 'Ementa: Grandezas elétricas, instrumentos e métodos para medição de grandezas elétricas;\r\nfontes controladas, circuitos de corrente continua, leis fundamentais de circuitos elétricos,\r\nteoremas de circuitos. Elementos armazenadores de energia. Estudo de transitório de\r\ncircuitos elétricos de primeira e segunda ordem.', 60, 7),
(266, 'GESTÃO DE PROJETOS', 'Ementa: Fundamentos de gestão de projetos. A estrutura do gerenciamento de projetos. O\r\nciclo de vida e organização do projeto. Os grupos de processos do projeto (iniciação,\r\nplanejamento, execução, monitoramento e controle, e encerramento). As áreas do\r\nconhecimento (integração, escopo, tempo, custo, qualidade, recursos humanos,\r\ncomunicação, riscos, aquisição e partes interessadas do projeto). MS Project Professional\r\n2013. WBS Chart Pro. Casos de sucesso/insucesso no uso de projetos. Project Model\r\nCanvas.', 60, 6),
(267, 'CÁLCULO NUMÉRICO', 'Ementa: Erros de arredondamento; Zeros de funções: localização, determinação por \r\nmétodos iterativos, precisão pré-fixada, zeros reais de polinômios; Sistemas de equações \r\nalgébricas lineares: método de eliminação de Gauss, condensação pivotal, refinamento da \r\nsolução, inversão de matrizes; método iterativo de Gauss-Seidel, critério das linhas e de \r\nSassenfeld; Ajuste e Interpolação.', 60, 5),
(268, 'EQUAÇÕES DIFERENCIAIS', 'Ementa: Equações diferenciais ordinárias. Noções da transformada de Laplace. Sistema \r\nde equações diferenciais ordinárias lineares. Equações diferenciais lineares. Séries de \r\nTaylor. Séries Fourier.', 60, 8),
(269, 'SEGURANÇA DO TRABALHO E LEGISLAÇÃO ', 'Ementa: Instalações e Serviços em Eletricidade. Transporte, Movimentação. Máquinas e \r\nEquipamentos. Armazenagem e Manuseio de Materiais. Atividades e Operações \r\nInsalubres. Condições e Meio Ambiente de Trabalho na Indústria da Construção. \r\nExplosivos. Sinalização de Segurança.', 60, 8),
(270, 'TOPOGRAFIA', 'Ementa: Técnicas de medições de ângulos e distâncias. Ângulos de orientação. Métodos \r\nde levantamentos planimétricos. Equipamentos topográficos. Coleta de informações \r\ntopográficas em campo. Cálculos de coordenadas através de métodos utilizados na \r\ntopografia. Representação dos levantamentos topográficos. Laboratório: Medição de \r\ndistâncias. Medição de ângulos. Reprodução geométrica de alinhamentos. Cálculo das \r\ncoordenadas. Determinação da declinação magnética e suas variações. Métodos de \r\nlevantamento planimétrico. Cálculo de áreas. Desenho de plantas. Geodésia. Astronomia.', 60, 8),
(271, 'GEOTECNIA I', 'Ementa: Geologia geral e petrografia; intemperismo e formação dos solos; processos \r\nexternos e seus efeitos; elementos estruturais das rochas; geologia na engenharia. Origem e \r\nNatureza dos Solos; Estados do Solo; Classificação dos Solos. Compactação e Índice de \r\nSuporte Califórnia, Tensões Geostáticas, Princípio de Tensões Efetivas, Capilaridade, \r\nIntrodução ao Fluxo de Água no Solo. Laboratório: Ensaios de caracterização, compactação, \r\nexpansão e índice de suporte Califórnia.', 60, 5),
(272, 'MATERIAIS DE CONSTRUÇÃO CIVIL I', 'Ementa: Estudo das características físico-química das substâncias e suas reações nos \r\nmateriais usados na construção civil. Tecnologia, propriedades, normalização técnica e \r\naplicações dos materiais usados na construção civil: agregados, aglomerantes, aço, materiais \r\ncerâmicos, materiais betuminosos, vidro e madeira. Laboratório: ensaios tecnológicos de: \r\nagregados, aço, materiais cerâmicos. Visitas técnicas.', 60, 5),
(273, 'LEITURA DE PROJETOS ARQUITETÔNICOS', 'Ementa: Visualização, interpretação e identificação de simbologias no projeto \r\narquitetônico (planta baixa, cortes e fachadas, locação e coberta, situação, legenda) e nos \r\nprojetos complementares (Projeto elétrico - simbologia, planta baixa; Projeto \r\nhidrossanitário - simbologia, planta baixa, diagrama em perspectiva; Projeto de combate a \r\nincêndio – simbologia e normatização e Projeto de layout - simbologia), locação de obra \r\n(interfaces entre desenho arquitetônico e estrutural), visualização, interpretação e\r\nidentificação de simbologias no projeto arquitetônico (planta baixa, cortes e fachadas, \r\nlocação e coberta, situação, legenda). Noções de acessibilidade - NBR 9050. Noções de \r\nMapa de Risco.', 60, 6),
(274, 'INFORMAÇÕES ESPACIAIS E GEOPROCESSAMENTO ', '2024-10-31 11:19:46', 0, NULL),
(275, 'MATERIAIS DE CONSTRUÇÃO CIVIL II', '2024-10-31 11:19:46', 0, NULL),
(276, 'GEOTECNIA II', '2024-10-31 11:19:46', 0, NULL),
(277, 'TÉCNICAS CONSTRUTIVAS I', '2024-10-31 11:19:46', 0, NULL),
(278, 'ESTRUTURAS ISOSTÁTICAS ', '2024-10-31 11:19:46', 0, NULL),
(279, 'RESISTÊNCIA DOS MATERIAIS II ', '2024-10-31 11:19:46', 0, NULL),
(280, 'PROJETOS DE ESTRADAS ', '2024-10-31 11:19:46', 0, NULL),
(281, 'TEORIA DAS ESTRUTURAS I \r\n', '2024-10-31 11:19:46', 0, NULL),
(282, 'HIDRÁULICA GERAL', '2024-10-31 11:19:46', 0, NULL),
(283, 'DESENHO ARQUITETÔNICO', '2024-10-31 11:19:46', 0, NULL),
(284, 'NOÇÕES DE ARQUITETURA E URBANISMO', '2024-10-31 11:19:46', 0, NULL),
(285, 'TÉCNICAS CONSTRUTIVAS II', '2024-10-31 11:19:46', 0, NULL),
(286, 'ESTRUTURAS DE CONCRETO I', '2024-10-31 11:19:46', 0, NULL),
(287, 'SISTEMAS DE GESTÃO DA QUALIDADE DA CONSTRUÇÃO CIVIL', '2024-10-31 11:19:46', 0, NULL),
(288, 'PLANEJAMENTO E CONTROLE DE OBRAS', '2024-10-31 11:19:46', 0, NULL),
(289, 'PAVIMENTAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(290, 'HIDROLOGIA', '2024-10-31 11:19:46', 0, NULL),
(291, 'TEORIA DAS ESTRUTURAS II', '2024-10-31 11:19:46', 0, NULL),
(292, 'ESTRUTURAS METÁLICAS', '2024-10-31 11:19:46', 0, NULL),
(293, 'SANEAMENTO', '2024-10-31 11:19:46', 0, NULL),
(294, 'FUNDAÇÕES', '2024-10-31 11:19:46', 0, NULL),
(295, 'ESTRUTURAS DE MADEIRA', '2024-10-31 11:19:46', 0, NULL),
(296, 'ESTRUTURA DE CONCRETO II', '2024-10-31 11:19:46', 0, NULL),
(297, 'PROJETOS ESTRUTURAIS', '2024-10-31 11:19:46', 0, NULL),
(298, 'SISTEMA DE INSTALAÇÕES PREDIAIS', '2024-10-31 11:19:46', 0, NULL),
(299, 'TÓPICOS CONTEMPORÂNEOS EM ENGENHARIA CIVIL', '2024-10-31 11:19:46', 0, NULL),
(300, 'CONCRETO PROTENDIDO', '2024-10-31 11:19:46', 0, NULL),
(301, 'PONTES', '2024-10-31 11:19:46', 0, NULL),
(302, 'LINGUAGENS DIGITAIS I', '2024-10-31 11:19:46', 0, NULL),
(303, 'LINGUAGENS DIGITAIS II', '2024-10-31 11:19:46', 0, NULL),
(304, 'INFRAESTRUTURA URBANA E DE TRÂNSITO', '2024-10-31 11:19:46', 0, NULL),
(305, 'CIRCUITOS ELÉTRICOS II', '2024-10-31 11:19:46', 0, NULL),
(306, 'ESTRUTURA DE DADOS I', '2024-10-31 11:19:46', 0, NULL),
(307, 'TÉCNICAS DE PROGRAMAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(308, 'SISTEMAS LINEARES', '2024-10-31 11:19:46', 0, NULL),
(309, 'ELETROMAGNETISMO PARA COMPUTAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(310, 'TÓPICOS ESPECIAIS EM ENGENHARIA DA COMPUTAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(311, 'ELETRÔNICA ANALÓGICA I', '2024-10-31 11:19:46', 0, NULL),
(312, 'PROCESSAMENTO DE SINAIS', '2024-10-31 11:19:46', 0, NULL),
(313, 'ARQUITETURA DE COMPUTADORES', '2024-10-31 11:19:46', 0, NULL),
(314, 'ESTRUTURA DE DADOS II', '2024-10-31 11:19:46', 0, NULL),
(315, 'BANCO DE DADOS', '2024-10-31 11:19:46', 0, NULL),
(316, 'CONTROLE I', '2024-10-31 11:19:46', 0, NULL),
(317, 'DESENVOLVIMENTO DE SISTEMAS PARA INTERNET', '2024-10-31 11:19:46', 0, NULL),
(318, 'ELETRÔNICA DIGITAL II', '2024-10-31 11:19:46', 0, NULL),
(319, 'ELETRÔNICA ANALÓGICA II', '2024-10-31 11:19:46', 0, NULL),
(320, 'LABORATÓRIO DE CIRCUITOS ELÉTRICOS E ELETRÔNICA\r\nANALÓGICA', '2024-10-31 11:19:46', 0, NULL),
(321, 'FILTROS DIGITAIS', '2024-10-31 11:19:46', 0, NULL),
(322, 'Redes De Computadores II', '2024-10-31 11:19:46', 0, NULL),
(323, 'SISTEMAS OPERACIONAIS', '2024-10-31 11:19:46', 0, NULL),
(324, 'LINGUAGEM DE MONTAGEM', '2024-10-31 11:19:46', 0, NULL),
(325, 'COMPILADORES', '2024-10-31 11:19:46', 0, NULL),
(326, 'CONTROLE II', '2024-10-31 11:19:46', 0, NULL),
(327, 'AUTOMAÇÃO INDUSTRIAL', '2024-10-31 11:19:46', 0, NULL),
(328, 'INFRAESTRUTURA DE TELECOMUNICAÇÕES', '2024-10-31 11:19:46', 0, NULL),
(329, 'MICROCONTROLADORES', '2024-10-31 11:19:46', 0, NULL),
(330, 'PROCESSAMENTO DIGITAL DE IMAGENS', '2024-10-31 11:19:46', 0, NULL),
(331, 'COMPUTAÇÃO GRÁFICA', '2024-10-31 11:19:46', 0, NULL),
(332, 'SISTEMAS DISTRIBUÍDOS', '2024-10-31 11:19:46', 0, NULL),
(333, 'REDES SEM FIO', '2024-10-31 11:19:46', 0, NULL),
(334, 'ROBÓTICA', '2024-10-31 11:19:46', 0, NULL),
(335, 'SISTEMAS EMBARCADOS', '2024-10-31 11:19:46', 0, NULL),
(336, 'TÓPICOS CONTEMPORÂNEOS EM ENGENHARIA DA\r\nCOMPUTAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(337, 'CONVERSÃO ELETROMECÂNICA DE ENERGIA I', '2024-10-31 11:19:46', 0, NULL),
(338, 'CONVERSÃO ELETROMECÂNICA DE ENERGIA II', '2024-10-31 11:19:46', 0, NULL),
(339, 'INSTALAÇÕES ELÉTRICAS PREDIAIS', '2024-10-31 11:19:46', 0, NULL),
(340, 'INSTALAÇÕES ELÉTRICAS INDUSTRIAIS E SISTEMAS DE\r\nPROTEÇÃO ELÉTRICA', '2024-10-31 11:19:46', 0, NULL),
(341, 'ANÁLISE DE SISTEMAS DE INFORMAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(342, 'DESENVOLVIMENTO DE APLICATIVOS MÓVEIS', '2024-10-31 11:19:46', 0, NULL),
(343, 'CONCEITOS DE COMUNICAÇÃO I', '2024-10-31 11:19:46', 0, NULL),
(344, 'DINÂMICA DE MÁQUINAS', '2024-10-31 11:19:46', 0, NULL),
(345, 'LABORATÓRIOS DE MÁQUNAS ELÉTRICAS', '2024-10-31 11:19:46', 0, NULL),
(346, 'GOVERNANÇA DE TECNOLOGIA DA INFORMAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(347, 'ELETRÔNICA DE POTÊNCIA', '2024-10-31 11:19:46', 0, NULL),
(348, 'PROJETO E ARQUITETURA DE SOFTWARE', '2024-10-31 11:19:46', 0, NULL),
(349, 'SEGURANÇA E AUDITORIA DE SISTEMAS', '2024-10-31 11:19:46', 0, NULL),
(350, 'PESQUISA OPERACIONAL', '2024-10-31 11:19:46', 0, NULL),
(351, 'CONCEITOS DE COMUNICAÇÃO II', '2024-10-31 11:19:46', 0, NULL),
(352, 'PLANEJAMENTO ESTRATÉGICO DE TECNOLOGIA DA\r\nINFORMAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(353, 'ORGANIZAÇÃO DO TRABALHO INDUSTRIAL', '2024-10-31 11:19:46', 0, NULL),
(354, 'PROJETO DE CIRCUITOS DE CONTROLE', '2024-10-31 11:19:46', 0, NULL),
(355, 'LÓGICA', '2024-10-31 11:19:46', 0, NULL),
(356, 'ECONOMIA APLICADA', '2024-10-31 11:19:46', 0, NULL),
(357, 'Planejamento de Métodos e Processos', '2024-10-31 11:19:46', 0, NULL),
(358, 'Engenharia da Qualidade', '2024-10-31 11:19:46', 0, NULL),
(359, 'METROLOGIA', '2024-10-31 11:19:46', 0, NULL),
(360, 'FENÔMENOS DE TRANSPORTE', '2024-10-31 11:19:46', 0, NULL),
(361, 'Planejamento e Controle da Produção I', '2024-10-31 11:19:46', 0, NULL),
(362, 'Modelagem e Simulação', '2024-10-31 11:19:46', 0, NULL),
(363, 'Bibliografia Complementar', '2024-10-31 11:19:46', 0, NULL),
(364, 'Ergonomia', '2024-10-31 11:19:46', 0, NULL),
(365, 'Introdução à Contabilidade', '2024-10-31 11:19:46', 0, NULL),
(366, 'Higiene e Segurança do Trabalho', '2024-10-31 11:19:46', 0, NULL),
(367, 'Gestão de Pessoas', '2024-10-31 11:19:46', 0, NULL),
(368, 'Administração de Empresas', '2024-10-31 11:19:46', 0, NULL),
(369, 'Logística', '2024-10-31 11:19:46', 0, NULL),
(370, 'PROCESSOS DE FABRICAÇÃO I', '2024-10-31 11:19:46', 0, NULL),
(371, 'Direito Empresarial', '2024-10-31 11:19:46', 0, NULL),
(372, 'Psicologia Aplicada', '2024-10-31 11:19:46', 0, NULL),
(373, 'Planejamento e Controle da Produção II', '2024-10-31 11:19:46', 0, NULL),
(374, 'Engenharia e Gerência da Informação', '2024-10-31 11:19:46', 0, NULL),
(375, 'Projeto de Produto', '2024-10-31 11:19:46', 0, NULL),
(376, 'Custos Industriais', '2024-10-31 11:19:46', 0, NULL),
(377, 'Gestão da Tecnologia', '2024-10-31 11:19:46', 0, NULL),
(378, 'Instalações Elétricas', '2024-10-31 11:19:46', 0, NULL),
(379, 'Gestão Estratégica', '2024-10-31 11:19:46', 0, NULL),
(380, 'Planejamento da Manutenção', '2024-10-31 11:19:46', 0, NULL),
(381, 'Gestão da Cadeia de Suprimentos', '2024-10-31 11:19:46', 0, NULL),
(382, 'Engenharia econômica', '2024-10-31 11:19:46', 0, NULL),
(383, 'Viabilidade econômica de projetos industriais', '2024-10-31 11:19:46', 0, NULL),
(384, 'Projeto de Instalações industriais', '2024-10-31 11:19:46', 0, NULL),
(385, 'TRABALHO DE CONCLUSÃO DE CURSO II', '2024-10-31 11:19:46', 0, NULL),
(386, 'TÓPICOS CONTEMPORÂNEOS EM ENGENHARIA DE PRODUÇÃO', '2024-10-31 11:19:46', 0, NULL),
(387, 'MATEMÁTICA BÁSICA', '2024-10-31 11:19:46', 0, NULL),
(388, 'ESTATÍSTICA BÁSICA', '2024-10-31 11:19:46', 0, NULL),
(389, 'SOCIEDADE E ORGANIZAÇÕES', '2024-10-31 11:19:46', 0, NULL),
(390, 'TÉCNICAS DE LEITURA E PRODUÇÃO DE TEXTO', '2024-10-31 11:19:46', 0, NULL),
(391, 'FUNDAMENTOS DE ENGENHARIA DE SOFTWARE', '2024-10-31 11:19:46', 0, NULL),
(392, 'OFICINA DE PROGRAMAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(393, 'ALGORITMOS E PROGRAMAÇÃO DE COMPUTADORES', '2024-10-31 11:19:46', 0, NULL),
(394, 'GOVERNANÇA E GESTÃO DE SERVIÇOS DE SOFTWARE', '2024-10-31 11:19:46', 0, NULL),
(395, 'ARQUITETURA E ORGANIZAÇÃO DE COMPUTADORES', '2024-10-31 11:19:46', 0, NULL),
(396, 'LEGISLAÇÃO APLICADA A ENGENHARIA DE SOFTWARE', '2024-10-31 11:19:46', 0, NULL),
(397, 'CÁLCULO', '2024-10-31 11:19:46', 0, NULL),
(398, 'MATEMÁTICA DISCRETA', '2024-10-31 11:19:46', 0, NULL),
(399, 'INTERAÇÃO HOMEM-MÁQUINA', '2024-10-31 11:19:46', 0, NULL),
(400, 'MATEMÁTICA DISCRETA II', '2024-10-31 11:19:46', 0, NULL),
(401, 'LÓGICA COMPUTACIONAL II', '2024-10-31 11:19:46', 0, NULL),
(402, 'ENGENHARIA DE SOFTWARE', '2024-10-31 11:19:46', 0, NULL),
(403, 'PROJETO DE BANCO DE DADOS', '2024-10-31 11:19:46', 0, NULL),
(404, 'ALGORITMOS E ESTRUTURA DE DADOS I', '2024-10-31 11:19:46', 0, NULL),
(405, 'TÓPICOS CONTEMPORÂNEOS EM ENGENHARIA DE SOFTWARE', '2024-10-31 11:19:46', 0, NULL),
(406, 'ADMINISTRAÇÃO E ORGANIZAÇÃO DE BANCO DE DADOS', '2024-10-31 11:19:46', 0, NULL),
(407, 'ALGORITMOS E ESTRUTURA DE DADOS II', '2024-10-31 11:19:46', 0, NULL),
(408, 'REDE DE COMPUTADORES I', '2024-10-31 11:19:46', 0, NULL),
(409, 'TEORIA DA COMPUTAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(410, 'PROJETO E MODELAGEM DE SOFTWARE', '2024-10-31 11:19:46', 0, NULL),
(411, 'PARADIGMAS DE PROGRAMAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(412, 'CONSTRUÇÃO DE SOFTWARE', '2024-10-31 11:19:46', 0, NULL),
(413, 'USABILIDADE DE SOFTWARE E EXPERIÊNCIA DO USUÁRIO', '2024-10-31 11:19:46', 0, NULL),
(414, 'GERENCIAMENTRO DE PROJETOS', '2024-10-31 11:19:46', 0, NULL),
(415, 'FÁBRICA DE SOFTWARE I', '2024-10-31 11:19:46', 0, NULL),
(416, 'SISTEMAS COMPUTACIONAIS DISTRIBUÍDOS E APLICAÇÕES EM\r\nNUVENS', '2024-10-31 11:19:46', 0, NULL),
(417, 'PROCESSOS DE SOFTWARE', '2024-10-31 11:19:46', 0, NULL),
(418, 'REDE DE COMPUTADORES II', '2024-10-31 11:19:46', 0, NULL),
(419, 'PADRÕES ARQUITETURAIS', '2024-10-31 11:19:46', 0, NULL),
(420, 'FRAMEWORKS DE PERSISTÊNCIA DE DADOS', '2024-10-31 11:19:46', 0, NULL),
(421, 'GESTÃO DE SERVIÇOS E GOVERNANÇA DE TECNOLOGIA DA\r\nINFORMAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(422, 'METODOLOGIAS ÁGEIS DE DESENVOLVIMENTO DE SOFTWARE', '2024-10-31 11:19:46', 0, NULL),
(423, 'EMPREENDEDORISMO', '2024-10-31 11:19:46', 0, NULL),
(424, 'PESQUISA OPERACIONAL E OTIMIZAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(425, 'SEGURANÇA E AUDITORIA NO DESENVOLVIMENTO DE SISTEMAS', '2024-10-31 11:19:46', 0, NULL),
(426, 'COMPLEXIDADE DE ALGORITMOS', '2024-10-31 11:19:46', 0, NULL),
(427, 'MACHINE LEARNING E MINERAÇÃO DE DADOS', '2024-10-31 11:19:46', 0, NULL),
(428, 'FÁBRICA DE SOFTWARE II', '2024-10-31 11:19:46', 0, NULL),
(429, 'MODELAGEM DE PROCESSOS DE NEGÓCIO', '2024-10-31 11:19:46', 0, NULL),
(430, 'GESTÃO DA INFORMAÇÃO E DO CONHECIMENTO', '2024-10-31 11:19:46', 0, NULL),
(431, 'LINGUAGENS FORMAIS E AUTÔMATOS', '2024-10-31 11:19:46', 0, NULL),
(432, 'LINGUAGENS DE MONTAGEM', '2024-10-31 11:19:46', 0, NULL),
(433, 'CIÊNCIAS AMBIENTAIS', '2024-10-31 11:19:46', 0, NULL),
(434, 'GESTÃO DE NEGÓCIOS E ECONOMIA', '2024-10-31 11:19:46', 0, NULL),
(435, 'CÁLCULO II', '2024-10-31 11:19:46', 0, NULL),
(436, 'ONDAS', '2024-10-31 11:19:46', 0, NULL),
(437, 'ELETRÔNICA DIGITAL I', '2024-10-31 11:19:46', 0, NULL),
(438, 'ELETROMAGNETISMO', '2024-10-31 11:19:46', 0, NULL),
(439, 'REDES DE COMPUTADORES I', '2024-10-31 11:19:46', 0, NULL),
(440, 'TÓPICOS ESPECIAIS EM ENGENHARIA ELÉTRICA', '2024-10-31 11:19:46', 0, NULL),
(441, 'MODELAGEM DE LINHAS DE TRANSMISSÃO', '2024-10-31 11:19:46', 0, NULL),
(442, 'INSTALAÇÕES ELÉTRICAS INDUSTRIAIS E SISTEMA DE PROTEÇÃO\r\nELÉTRICA', '2024-10-31 11:19:46', 0, NULL),
(443, 'SISTEMAS ELÉTRICOS DE POTÊNCIA', '2024-10-31 11:19:46', 0, NULL),
(444, 'LABORATÓRIO DE MÁQUINAS ELÉTRICAS', '2024-10-31 11:19:46', 0, NULL),
(445, 'FONTES ALTERNATIVAS DE ENERGIA', '2024-10-31 11:19:46', 0, NULL),
(446, 'SISTEMAS DE PROTEÇÃO CONTRA DESCARGAS ATMOSFÉRICAS', '2024-10-31 11:19:46', 0, NULL),
(447, 'DISTRIBUIÇÃO DE ENERGIA ELÉTRICA', '2024-10-31 11:19:46', 0, NULL),
(448, 'QUALIDADE DA ENERGIA ELÉTRICA', '2024-10-31 11:19:46', 0, NULL),
(449, 'PROJETOS DE CIRCUITOS DE CONTROLE', '2024-10-31 11:19:46', 0, NULL),
(450, 'TÓPICOS CONTEMPORÂNEOS EM ENGENHARIA ELÉTRICA\r\n', '2024-10-31 11:19:46', 0, NULL),
(451, 'AUTOMAÇÃO INDUSTRIAL E CONTROLE', '2024-10-31 11:19:46', 0, NULL),
(452, 'ESTRUTURAS DE DADOS I', '2024-10-31 11:19:46', 0, NULL),
(453, 'ESTRUTURAS DE DADOS II', '2024-10-31 11:19:46', 0, NULL),
(454, 'PLANEJAMENTO DE RECURSOS ENERGÉTICOS', '2024-10-31 11:19:46', 0, NULL),
(455, 'USO RACIONAL DE ENERGIA E SUSTENTABILIDADE', '2024-10-31 11:19:46', 0, NULL),
(456, 'MATERIAIS DE CONSTRUÇÃO MECÂNICA', '2024-10-31 11:19:46', 0, NULL),
(457, 'RESISTÊNCIA DOS MATERIAIS I', '2024-10-31 11:19:46', 0, NULL),
(458, 'ELETRÔNICA ANALÓGICA', '2024-10-31 11:19:46', 0, NULL),
(459, 'TERMODINÂMICA', '2024-10-31 11:19:46', 0, NULL),
(460, 'FENÔMENOS DE TRANSPORTE II', '2024-10-31 11:19:46', 0, NULL),
(461, 'TRANSFERÊNCIA DE CALOR', '2024-10-31 11:19:46', 0, NULL),
(462, 'DESENHO MECÂNICO', '2024-10-31 11:19:46', 0, NULL),
(463, 'ELETRÔNICA DIGITAL', '2024-10-31 11:19:46', 0, NULL),
(464, 'ELEMENTOS DE MÁQUINAS I', '2024-10-31 11:19:46', 0, NULL),
(465, 'MÁQUINAS TÉRMICAS', '2024-10-31 11:19:46', 0, NULL),
(466, 'MÁQUINAS DE FLUXO', '2024-10-31 11:19:46', 0, NULL),
(467, 'LABORATÓRIO DE FENÔMENOS DE TRANSPORTE E TRANSFERÊNCIA DE\r\nCALOR', '2024-10-31 11:19:46', 0, NULL),
(468, 'PROJETOS EM PROCESSOS INDUSTRIAIS', '2024-10-31 11:19:46', 0, NULL),
(469, 'PROCESSOS DE FABRICAÇÃO II', '2024-10-31 11:19:46', 0, NULL),
(470, 'INSTRUMENTAÇÃO INDUSTRIAL E ACIONAMENTOS ELÉTRICOS', '2024-10-31 11:19:46', 0, NULL),
(471, 'LABORATÓRIO DE CIRCUITOS ELÉTRICOS E ELETRÔNICA', '2024-10-31 11:19:46', 0, NULL),
(472, 'ELEMENTOS DE MÁQUINAS II', '2024-10-31 11:19:46', 0, NULL),
(473, 'VIBRAÇÕES', '2024-10-31 11:19:46', 0, NULL),
(474, 'SISTEMAS PNEUMÁTICOS E HIDRÁULICOS', '2024-10-31 11:19:46', 0, NULL),
(475, 'CLIMATIZAÇÃO E VENTILAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(476, 'DINÂMICA DAS MÁQUINAS', '2024-10-31 11:19:46', 0, NULL),
(477, 'PROJETOS DE SISTEMAS MECÂNICOS', '2024-10-31 11:19:46', 0, NULL),
(478, 'MANUTENÇÃO DE SISTEMAS', '2024-10-31 11:19:46', 0, NULL),
(479, 'MÁQUINAS DE ELEVAÇÃO E TRANSPORTE', '2024-10-31 11:19:46', 0, NULL),
(480, 'TÓPICOS CONTEMPORÂNEOS EM ENGENHARIA MECÂNICA', '2024-10-31 11:19:46', 0, NULL),
(481, 'ENGENHARIA AUTOMOTIVA', '2024-10-31 11:19:46', 0, NULL),
(482, 'Introdução ao Empreendedorismo e Tomada de Decisão', '2024-10-31 11:19:46', 0, NULL),
(483, 'Fundamentos de Sistemas de Informação', '2024-10-31 11:19:46', 0, NULL),
(484, 'Cálculo', '2024-10-31 11:19:46', 0, NULL),
(485, 'Probabilidade', '2024-10-31 11:19:46', 0, NULL),
(486, 'Lógica Computacional', '2024-10-31 11:19:46', 0, NULL),
(487, 'Construção de Software Comercial', '2024-10-31 11:19:46', 0, NULL),
(488, 'Gerenciamento de Projetos', '2024-10-31 11:19:46', 0, NULL),
(489, 'Projeto e Implantação de Data Warehouse', '2024-10-31 11:19:46', 0, NULL),
(490, 'Usabilidade e Experiência do Usuário', '2024-10-31 11:19:46', 0, NULL),
(491, 'Qualidade de Software', '2024-10-31 11:19:46', 0, NULL),
(492, 'Sistemas Computacionais Distribuídos e Aplicações em', '2024-10-31 11:19:46', 0, NULL),
(493, 'Pesquisa Operacional Aplicada à Sistemas', '2024-10-31 11:19:46', 0, NULL),
(494, 'Modelagem de Processo de Negócios', '2024-10-31 11:19:46', 0, NULL),
(495, 'Validação e Verificação de Software', '2024-10-31 11:19:46', 0, NULL),
(496, 'Trabalho de Conclusão de Curso I', '2024-10-31 11:19:46', 0, NULL),
(497, 'Tomada de Decisão usando\r\nBUSINESS INTELIGENCE e BUSINESS ANALYTICS', '2024-10-31 11:19:46', 0, NULL),
(498, 'Tópicos Contemporâneos em Sistemas de Informação', '2024-10-31 11:19:46', 0, NULL),
(499, 'Fundamentos de Administração', '2024-10-31 11:19:46', 0, NULL),
(500, 'ARQUITETURA DE COMPUTADORES E SISTEMAS OPERACIONAIS', '2024-10-31 11:19:46', 60, 5),
(501, 'BANCO DE DADOS I', '2024-10-31 11:19:46', 60, 5),
(502, 'PROGRAMAÇÃO BÁSICA', '2024-10-31 11:19:46', 60, 6),
(503, 'EMPREENDEDORISMO, INOVAÇÃO E ECONOMIA CRIATIVA', '2024-10-31 11:19:46', 60, 6),
(504, 'LIDERANÇA DE PESSOAL, NEGÓCIOS E TIMES DE TRABALHO', '2024-10-31 11:19:46', 60, 8),
(505, 'REDES DE COMPUTADORES', '2024-10-31 11:19:46', 60, 6),
(506, 'SEGURANÇA DA INFORMAÇÃO', '2024-10-31 11:19:46', 50, 6),
(507, 'SOCIEDADE E ORGANIZAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(508, 'BANCO DE DADOS II', '2024-10-31 11:19:46', 0, NULL),
(509, 'PROGRAMAÇÃO ORIENTADA À OBJETOS – JAVA', '2024-10-31 11:19:46', 0, NULL),
(510, 'DESENVOLVIMENTO ÁGIL DE SOFTWARE', '2024-10-31 11:19:46', 0, NULL),
(511, 'ARQUITETURA DE SOFTWARE', '2024-10-31 11:19:46', 0, NULL),
(512, 'DESIGN DE INTERFACES', '2024-10-31 11:19:46', 0, NULL),
(513, 'CLOUD COMPUTING', '2024-10-31 11:19:46', 0, NULL),
(514, 'PROGRAMAÇÃO WEB I', '2024-10-31 11:19:46', 0, NULL),
(515, 'TESTE DE SOFTWARE', '2024-10-31 11:19:46', 0, NULL),
(516, 'DESIGN THINKING', '2024-10-31 11:19:46', 0, NULL),
(517, 'ÉTICA E LEGISLAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(518, 'PROGRAMAÇÃO WEB II', '2024-10-31 11:19:46', 0, NULL),
(519, 'DESENVOLVIMENTO DE JOGOS', '2024-10-31 11:19:46', 0, NULL),
(520, 'DESENVOLVIMENTO MOBILE', '2024-10-31 11:19:46', 0, NULL),
(521, 'GOVERNANÇA E TECNOLOGIA DA INFORMAÇÃO', '2024-10-31 11:19:46', 0, NULL),
(522, 'INTELIGÊNCIA ARTIFICIAL', '2024-10-31 11:19:46', 0, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `historico_alunos`
--

CREATE TABLE `historico_alunos` (
  `id_historico` int(11) NOT NULL,
  `id_aluno` int(11) DEFAULT NULL,
  `id_disciplina` int(11) DEFAULT NULL,
  `nota` decimal(5,2) DEFAULT NULL,
  `carga_horaria_cursada` int(11) DEFAULT NULL,
  `status` enum('Aprovado','Reprovado','Em Andamento') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `alunos`
--
ALTER TABLE `alunos`
  ADD PRIMARY KEY (`id_aluno`),
  ADD KEY `id_curso` (`id_curso`);

--
-- Índices de tabela `anexos`
--
ALTER TABLE `anexos`
  ADD PRIMARY KEY (`id_anexo`),
  ADD KEY `id_aluno` (`id_aluno`);

--
-- Índices de tabela `bibliografia`
--
ALTER TABLE `bibliografia`
  ADD PRIMARY KEY (`id_bibliografia`),
  ADD KEY `id_disciplina` (`id_disciplina`);

--
-- Índices de tabela `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`id_curso`);

--
-- Índices de tabela `curso_disciplina`
--
ALTER TABLE `curso_disciplina`
  ADD PRIMARY KEY (`id_curso`,`id_disciplina`),
  ADD KEY `fk_disciplina` (`id_disciplina`);

--
-- Índices de tabela `disciplinas`
--
ALTER TABLE `disciplinas`
  ADD PRIMARY KEY (`id_disciplina`),
  ADD KEY `id_curso` (`id_curso`);

--
-- Índices de tabela `historico_alunos`
--
ALTER TABLE `historico_alunos`
  ADD PRIMARY KEY (`id_historico`),
  ADD KEY `id_aluno` (`id_aluno`),
  ADD KEY `id_disciplina` (`id_disciplina`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `alunos`
--
ALTER TABLE `alunos`
  MODIFY `id_aluno` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `anexos`
--
ALTER TABLE `anexos`
  MODIFY `id_anexo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `bibliografia`
--
ALTER TABLE `bibliografia`
  MODIFY `id_bibliografia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id_curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `disciplinas`
--
ALTER TABLE `disciplinas`
  MODIFY `id_disciplina` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=523;

--
-- AUTO_INCREMENT de tabela `historico_alunos`
--
ALTER TABLE `historico_alunos`
  MODIFY `id_historico` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `alunos`
--
ALTER TABLE `alunos`
  ADD CONSTRAINT `alunos_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE CASCADE;

--
-- Restrições para tabelas `anexos`
--
ALTER TABLE `anexos`
  ADD CONSTRAINT `anexos_ibfk_1` FOREIGN KEY (`id_aluno`) REFERENCES `alunos` (`id_aluno`) ON DELETE CASCADE;

--
-- Restrições para tabelas `bibliografia`
--
ALTER TABLE `bibliografia`
  ADD CONSTRAINT `bibliografia_ibfk_1` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplinas` (`id_disciplina`) ON DELETE CASCADE;

--
-- Restrições para tabelas `curso_disciplina`
--
ALTER TABLE `curso_disciplina`
  ADD CONSTRAINT `fk_curso` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_disciplina` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplinas` (`id_disciplina`) ON DELETE CASCADE;

--
-- Restrições para tabelas `disciplinas`
--
ALTER TABLE `disciplinas`
  ADD CONSTRAINT `disciplinas_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE CASCADE;

--
-- Restrições para tabelas `historico_alunos`
--
ALTER TABLE `historico_alunos`
  ADD CONSTRAINT `historico_alunos_ibfk_1` FOREIGN KEY (`id_aluno`) REFERENCES `alunos` (`id_aluno`) ON DELETE CASCADE,
  ADD CONSTRAINT `historico_alunos_ibfk_2` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplinas` (`id_disciplina`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
