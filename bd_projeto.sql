-- phpMyAdmin SQL Dump
-- version 5.2.1
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
(2, 'INTRODUÇÃO À ENGENHARIA', 'Conceitos fundamentais de Engenharia. Motivação dos estudantes em relação à \r\nengenharia. Desenvolvimento de aptidões para a resolução de problemas. O processo de \r\num projeto de engenharia. Tabelas e gráficos. Sistemas de unidades e conversão de unidades.', 60, NULL),
(3, 'CÁLCULO', 'Operações no Conjunto dos Números Reais. Polinômios: conceito e operações. \r\nExpressões Fracionárias Algébricas. Equações de 1º e 2º graus. Inequações de 1º e 2º graus. Conceito e noções de Função. Estudo dos diversos tipos de Funções: Polinomial de 1º grau; Polinomial de 2º grau; Modular; Potência; Polinomial de grau maior que 2; Exponencial; Logarítmica ; Compostas e Inversas. Sistemas de equações e matrizes. Noções de \r\nTrigonometria. Funções Trigonométricas.', 60, NULL),
(4, 'GEOMETRIA ANALÍTICA', 'Espaço dos vetores da geometria; Soma de vetores e multiplicação de vetores por \r\nnúmeros reais; dependência linear; base; coordenadas; mudança de base; produto escalar; \r\nproduto vetorial. Geometria analítica no espaço - sistemas de coordenadas; equações \r\nvetorial e paramétrica de retas e de planos; equação geral do plano; vetor normal a um plano. Posições relativas entre reta e plano; Distância entre dois pontos; Distância de ponto à reta; Distância de ponto a plano; Distância de reta a reta; Distância de reta a plano; Distância de plano a plano; Ângulos entre duas retas. Mudança de coordenadas. \r\nCircunferências e Esferas: Equação e gráfico; Planos tangentes. Coordenadas Polares: Esboço de Curvas em coordenadas polares; Retas e Circunferência em Coordenadas Polares. Cônicas: Elipse: Equação e gráfico; Parábola: Equação e gráfico; Hipérbole: Equação e gráfico. Equação Geral do segundo Grau. Quádricas: Esfera; Paraboloide; Elipsoide; Hiperboloide de uma folha; Hiperboloide de duas folhas. Parametrizações', 60, NULL),
(5, 'QUÍMICA GERAL TECNOLÓGICA', 'Ligações químicas: iônica, covalente, metálica, van der Waals, pontes de \r\nhidrogênio; Eletroquímica; Corrosão de materiais metálicos; Tenso ativos; Combustão e \r\nCombustíveis. Laboratório: experimentos de laboratório sobre: Análise de misturas \r\ngasosas; Poder calorífico de combustíveis; Viscosidade de óleos lubrificantes; Pilhas e acumuladores; Obtenção e caracterização de revestimentos; Corrosão  galvânica.', 60, NULL),
(6, 'COMUNICAÇÃO E EXPRESSÃO', 'Estudo dos princípios e regras básicas de comunicação oral e escrita da Língua \r\nPortuguesa e sua aplicabilidade na interpretação e construção do texto acadêmico.', 60, NULL),
(7, 'ÁLGEBRA LINEAR PARA ENGENHARIA', 'Matrizes e Determinantes. Sistema de Equações Lineares. Vetores no Plano e no \r\nEspaço. Espaços Vetoriais. Base e Dimensão. Transformações Lineares. Autovalores e \r\nautovetores. Diagonalização de Matrizes.', 60, NULL),
(8, 'CÁCULO I', 'Derivadas; Integral Simples; Funções de Várias Variáveis; Limites; Derivadas \r\nParciais.', 60, NULL),
(9, 'FÍSICA', 'Unidades, Grandezas Físicas e Vetores. Movimento Retilíneo. Movimento em \r\nDuas ou Três Dimensões. Leis de Newton do Movimento. Aplicações das Leis de Newton. \r\nTrabalho e Energia Cinética. Energia Potencial e Conservação da Energia. Momento Linear, Impulso e Colisões.', 60, NULL),
(10, 'MATERIAIS PARA ENGENHARIA', 'Utilização de diferentes materiais: metálicos, cerâmicos, poliméricos, \r\ncompósitos; conceituação de ciência e engenharia de materiais; aplicações dos diversos \r\ntipos de materiais; relação entre tipos de ligações dos materiais e suas propriedades; Meio -\r\nambiente e a legislação pertinente Políticas de educação ambiental. Estrutura da matéria: estrutura dos sólidos: sólidos cri stalinos: sólidos amorfos: sólidos parcialmente cristalinos; \r\nDefeitos em sólidos: defeitos puntiformes; defeitos de linha (discordâncias); Defeitos planos ou bidimensionais; Formação da microestrutura: Relação entre a microestrutura e propriedades do mater ial; processamento dos materiais metálicos; processamento dos \r\nmateriais cerâmicos; processamento dos materiais poliméricos.', 60, NULL),
(11, 'METODOLOGIA CIENTÍFICA', 'A construção do conhecimento. Tipos de conhecimento. A produção do \r\nconhecimento científico. Modalidades de trabalhos acadêmicos: resumo, pesquisa \r\nbibliográfica, relatório, artigo, resenha e projetos. Cita ções. Referências. Estrutura e \r\napresentação de trabalhos acadêmicos de acordo com a ABNT.', 60, NULL),
(12, 'MECÂNICA GERAL', 'Estática de corpo rígido: Equilíbrio de forças e momentos, e diagrama de corpo \r\nlivre; Esforços em estruturas; Centroide, Centro de Massa e Centro de Gravidade; Momento de Inércia, Módulo de Resistência e Momento Polar de Inércia.', 60, NULL),
(13, 'NOÇÕES DE DESENHO TÉCNICO EM CAD', 'Interpretação de desenhos técnicos por meio manual e computacional. \r\nConceituação de computação gráfica e áreas de aplicação. Conceituação e classificação de \r\naplicativos gráficos. Uso de bibliotecas e aplicativos gráficos: aplicações em projeto do \r\nproduto, projeto de posto de trabalho, layout, ergonomia e fluxos. Laboratório:  Realização \r\ndos exercícios práticos de desenho de Geometria Descritiva, representação bidimensional e tridimensional. Uso do instrumental de desenho técnico completo. Desenvolvimento dos exercícios práticos de desenho técnico em computador, plataforma CAD.', 60, NULL),
(14, 'ELETRICIDADE E MAGNETISMO', 'Carga Elétrica e Campo Elétrico. Potencial Elétrico. Capacitância e Dielétricos. \r\nCorrente, Resistência e Força Eletromotriz. Resistores em Série e em Paralelo. Campo \r\nmagnético: princípios e definições: Movimento de cargas em campos magnéticos; Lei de Ampe re; Lei da Indução de Faraday; Indutância: capacitores e indutores, circuitos RL; \r\nMagnetismo; Lei de Gauss; Propriedades Magnéticas da Matéria; Oscilações Eletromagnéticas: Correntes Alternadas; Equações de Maxwell. A parte laboratorial da disciplina deve conter experiências ligadas ao objetivo do curso, versando sobre reflexão e propagação de ondas, interferência eletromagnética, campo magnético de uma corrente e forças magnéticas sobre correntes, correntes alternadas, ondas eletromagnéticas.', 60, NULL),
(15, 'PROBABILIDADE E ESTATÍSTICA', 'Estudo das ideias básicas de probabilidades. Distribuições de Probabilidade. \r\nAnálise de Regressão e Correlação lineares simples e Aplicações. Estatística Descritiva. \r\nPrincipais distribuições de frequência. Medidas de Posição. Medidas de Dispersão. \r\n \r\nBiblio grafia Básica \r\nOLIVEIRA, Francisco Estevam Martins de. Estatística e probabilidade: exercícios \r\nresolvidos e propostos. 2.ed. São Paulo: Atlas, 2012. \r\nMORETTIN, Pedro A.; BUSSAB, Wilton de O. Estatística básica. 8. ed. São Paulo: \r\nSaraiva, 2013. \r\nMARTINS, Gilberto de Andrade; DOMINGUES, Osmar. Estatística geral e aplicada. 5. \r\ned. rev. São Paulo: Atlas, 2014.', 60, NULL),
(16, 'CIRCUITOS ELÉTRICOS I', 'Grandezas elétricas, instrumentos e métodos para medição de grandezas elétricas; \r\nfontes controladas, circuitos de corrente continua, leis fundamentais de circuitos elétricos, \r\nteoremas de circuitos. Elementos armazenadores de energia. Estudo de transitório de circuitos elétricos de primeira e segunda ordem.', 60, NULL),
(17, 'GESTÃO DE PROJETOS', 'Fundamentos de gestão de projetos. A estrutura do gerenciamento de projetos. O \r\nciclo de vida e organização do projeto. Os grupos de processos do projeto (iniciação, \r\nplanejamento, execução, monitoramento e controle, e encerramento). As áreas do conhecimento (integração, escopo, tempo, custo, qualidade, recursos humanos, comunicação, riscos, aquisição e partes interessadas do projeto). MS Project Professional 2013. WBS  Chart Pro. Casos de sucesso/insucesso no uso de projetos. Project Model \r\nCanvas.', 60, NULL),
(18, 'CÁLCULO NUMÉRICO', 'Erros de arredondamento; Zeros de funções: localização, determinação por \r\nmétodos iterativos, precisão pré -fixada, zeros reais de polinômios; Sistemas de equações \r\nalgébricas lineares: método de eliminação de Gauss, condensação pivotal, refinamento da \r\nsoluç ão, inversão de matrizes; método iterativo de Gauss -Seidel, critério das linhas e de \r\nSassenfeld; Ajuste e Interpolação.', 60, NULL),
(19, 'EQUAÇÕES DIFERENCIAIS', 'Equações diferenciais ordinárias. Noções da transformada de Laplace. Sistema \r\nde equações diferenciais ordinárias lineares. Equações diferenciais lineares. Séries de \r\nTaylor. Séries Fourier.', 60, NULL),
(20, 'SEGURANÇA DO TRABALHO E LEGISLAÇÃO', 'Instalações e Serviços em Eletricidade. Transporte, Movimentação. Máquinas e \r\nEquipamentos. Armazenagem e Manuseio de Materiais. Atividades e Operações \r\nInsalubres. Condições e Meio Ambiente de Trabalho na Indústri a da Construção. \r\nExplosivos. Sinalização de Segurança.', 60, NULL),
(21, 'TOPOGRAFIA', 'Técnicas de medições de ângulos e distâncias. Ângulos de orientação. Métodos \r\nde levantamentos planimétricos. Equipamentos topográficos. Coleta de informações \r\ntopográficas em campo. Cálculos de coordenadas através de métodos utilizados na topografia. Representação dos levantamentos topográficos. Laboratório: Medição de distâncias. Medição de ângulos. Reprodução geométrica de alinhamentos. Cálculo das coordenadas. Determinação da declinação magnética e suas variações. Métodos de levantamento planimétrico. Cálculo de áreas. Desenho de plantas. Geodésia. Astronomia.', 60, NULL),
(22, 'GEOTECNIA I', 'Geologia geral e petrografia; intemperismo e formação dos solos; processos \r\nexternos e seus efeitos; elementos estruturais das rochas; geologia na engenharia. Origem e', 60, NULL),
(23, 'MATERIAIS DE CONSTRUÇÃO CIVIL I', 'Estudo das características físico -química das substâncias e suas reações nos \r\nmateriais usados na construção civil. Tecnologia, propriedades, normalização técnica e aplicações dos  materiais usados na construção civil: agregados, aglomerantes, aço, materiais \r\ncerâmicos, materiais betuminosos, vidro e madeira. Laboratório: ensaios tecnológicos de: agregados, aço, materiais cerâmicos. Visitas técnicas.', 60, NULL),
(24, 'LEITURA DE PROJETOS ARQUITETÔNICOS', 'Visualização, interpretação e identificação de simbologias no projeto \r\narquitetônico (planta baixa, cortes e fachadas, locação e coberta, situação, legenda) e nos projetos complementares (Projeto elétrico - simbologia, planta baixa; Projeto \r\nhidros sanitário - simbologia, planta baixa, diagrama em perspectiva; Projeto de combate a', 60, NULL),
(25, 'INFORMAÇÕES ESPACIAIS E GEOPROCESSAMENTO', 'Altimetria. Métodos de Levantamentos Altimétricos. Curvas de nível. Perfil \r\nLongitudinal. Seções Transversais. Greide, rampas e declividades. Cálculo de volumes de terraplenagem. Controle de obras. Sensoriamento remoto. Laboratório: Medição de distâncias. M edição de ângulos. Nivelamentos. Reprodução geométrica e trigonométrica de \r\nalinhamentos. Cálculo das coordenadas. Cálculo trigonométrico. Métodos de levantamento planialtimétrico. Cálculo de áreas. Desenho de plantas. Geodésia. Astronomia.', 60, NULL),
(26, 'MATERIAIS DE CONSTRUÇÃO CIVIL II', 'Argamassa – conceitos, classificação, propriedades, dosa gem e emprego na \r\nconstrução civil. Concreto – generalidades, conceitos, classificação, propriedades, materiais \r\nconstituintes, dosagem, ensaios e emprego na construção civil. Aço - conceito, classificação, \r\nfabricação, normalização propriedades, controle tec nológico e ensaios de tração e \r\ndobramento. Argamassa armada – conceito, propriedades, composição do material, \r\ncomparação com o concreto armado. Laboratório: Ensaios tecnológicos de argamassa e \r\nconcreto. Visitas técnicas.', 60, NULL),
(27, 'GEOTECNIA II', 'Resistência ao cisalhamento dos solos, trajetória de tensões, adensamento, \r\ncolapsividade. Empuxos de terra; estruturas de contenção; movimentos de terra e noções de estabilidade de taludes. Laboratório: ensaios de resistência triaxial, ensaios de adensamento.', 60, NULL),
(28, 'TÉCNICAS CONSTRUTIVAS I', 'Implementação inicial de uma obra: documentação, r egulamentação, projetos \r\nEstudo das etapas executivas (conceitos, tipos, metodologia, normatização): instalações \r\nprovisórias, serviços preliminares, locação de obra, movimento de terra, fundações, estrutura, alvenarias (estrutural e de vedação), telhado e i nstalações. Visitas técnicas. \r\nConceito de orçamento, planejamento e incorporação', 60, NULL),
(29, 'ESTRUTURAS ISOSTÁTICAS', 'Reações de apoio em estruturas isostáticas planas. Esforços simples (normal, \r\ncortante e momento flet or). Linhas de estado. Diagramas de esforços solicitantes em vigas \r\ne pórticos isostáticos. Esforços em barras de treliças isostáticas.', 60, NULL),
(30, 'RESISTÊNCIA DOS MATERIAIS II', 'A resistência dos materiais é responsável pelo estudo dos seguintes fenômenos \r\nestruturais: Flexão, Cisalhamento transversal, Flambagem de colunas, Deflexão em vigas e \r\neixos. Noções básicas de torção em eixos/vigas.', 60, NULL),
(31, 'PROJETOS DE ESTRADAS', 'Características dos sistemas de transportes, veículos e vias. Projeto geométrico de \r\nestradas: características técnicas, condicio nantes topográficos, geotécnicos, hidrológicos, \r\nambientais e de uso do solo. Fases de elaboração do projeto: reconhecimento, exploração e locação. Elementos básicos de projeto: planta, perfil e seções transversais. Introdução ao Projeto Geométrico Estradas  de Rodagem. Elementos Geométricos das Estradas. \r\nCaracterísticas Técnicas para Projeto. Projetos de Curvas Horizontais Circulares. Projetos de Curvas Horizontais de Transição. Projetos de Superelevação. Projetos de Superlargura. Projetos de Curvas Verticai s. Alinhamentos Horizontal e Vertical. Introdução ao cálculo de \r\nterraplanagem. Laboratório: Classificação de rodovias quanto ao relevo; Estudos de traçados em uma planta topográfica fornecida; Cálculo dos elementos de concordância horizontal; Memorial desc ritivo e demais elementos do projeto geométrico horizontal. \r\nCálculo das cotas do estaqueamento do eixo; Lançamento de greides retos; Concordância vertical; Cálculos de superlargura e superelevação; Memorial descrito e demais elementos do projeto vertical; Cálculo dos elementos transversais.', 60, NULL),
(32, 'TEORIA DAS ESTRUTURAS I', 'Grau de hiperestaticidade de estruturas planas. Teoremas gerais de Energia. \r\nDeslocamentos em estruturas isostáticas. Método dos Esforços. Esforços solicitantes em treliças, vigas e pórticos hiperestáticos.', 60, NULL),
(33, 'HIDRÁULICA GERAL', 'Orifícios, Bocais e Tubos Curtos. Vertedores. Condutos Forçados. Bombas.  \r\nCondutos livres. Hidrossedimentologia Fluvial. Ondas. Hidráulica Estuarina. Laboratório: \r\nDetermi nação dos coeficientes de descarga, contração e velocidade no orifício de fundo. \r\nDeterminação da vazão real no Tubo Diafragma. Determinação da vazão no Vertedor \r\nRetangular com duas contrações. Determinação da vazão no Vertedor Triangular. \r\nDeterminação do coeficiente de rugosidade de Hazen -Willians no tubo liso e rugoso. \r\nDeterminação do fator de atrito no tubo liso e rugoso. Visualização e determinação dos \r\nparâmetros dos três reservatórios. Visualização e determinação dos parâmetros do \r\nfenômeno do Ressalto Hidráulico.', 60, NULL),
(34, 'DESENHO ARQUITETÔNICO', 'Aprimoramento da representação gráfica e da capacidade de aprimoramento \r\ntridimensional através da visualização espacial. Desenho arquitetônico utilizando elementos \r\ngráficos e descritivos da composição arquitetônica. Aspectos físicos e estruturais do \r\nambiente no processo projetual. Metodologia e fases do projeto. Laboratório: Realização \r\ndos exercícios práticos de Representação Técnica de Projeto de Arquitetura, em grandes \r\nformatos (A2, A1).  Uso do instrumental de desenho técnico completo.', 60, NULL),
(35, 'NOÇÕES DE ARQUITETURA E URBANISMO', 'Noções básicas de Arquitetura e de Urbanismo; anteprojeto e projeto; projetos \r\ncomplementares; planejamento urbano; legislação de urbanização, sistema de \r\ninfraestrutura -urbana. Estudo de plano diretor.', 60, NULL),
(36, 'TÉCNICAS CONSTRUTIVAS II', 'Estudo das etapas executivas (conceitos, tipos, metodologia, normatização): \r\nimpermeabilizações, revestimentos, forros, pavimentação, esquadrias, pintura, instalações complementares (ar condicionado, pressurização, elevadores). Industrialização da construção - conceitos e finalidade, técnicas modernas de construção civil, produtividade, \r\ncustos, industrialização e mo dulação, transporte, elevação e execução. Controle e \r\ndesperdício na construção civil – histórico de desperdícios na construção civil, causas do \r\ndesperdício, custo, indicadores de perdas, controle de desperdícios. Introdução a engenharia de avaliações. Visitas técnicas', 60, NULL),
(37, 'ESTRUTURAS DE CONCRETO I', 'Propriedades do concreto e do aço. Princípios da verificação da segurança: estados \r\nlimites últimos e de utilização. Aderência entre concreto e aço.  Dimensionamento no estado limite último de seções sujeitas a solicitações normais. Cisalhamento com flexão. Torção. Verificação dos estados limites de fissuração e deformação. Detalhamento de vigas e pilares. Análise, dimensionamento e detalhamento de lajes.', 60, NULL),
(38, 'SISTEMAS DE GESTÃO DA QUALIDADE DA CONSTRUÇÃO CIVIL', 'Sistemas de gestão da qualidade, conceitos. Ferramentas da qualidade, \r\nplanejamento da qualidade, controles. Normas da Série ISO 9000. PBQP -H. Metodologia \r\nde solução de problemas. Auditorias internas de qualidade. Elementos do sistema de gestão da qualidade e documentação para o gerenciamento.  Certificação e garantia da qualidade.', 60, NULL),
(39, 'PLANEJAMENT O E CONTROLE DE OBRAS', 'Orçamento e custo da construção civil. Métodos de planejamento e controle de \r\nobras aplicáveis a construção civil.', 60, NULL),
(40, 'PAVIMENTAÇÃO', 'Introdução a pavimentos; interferências do meio físico; análise de tensões, \r\ndeformações e deslocamentos de pavimentos; materiais utilizados em pavimentação; ensaios d e laboratório e campo; revestimentos asfálticos; dimensionamento de pavimentos \r\nflexíveis; dimensionamento de pavimentos rígidos.', 60, NULL),
(41, 'HIDROLOGIA', 'Ciclo hidrológico; Bacia hidrográfica; Umidade; Precipitação; Hidrologia \r\nestatística; Infiltração; Evaporação; Hidrometria; Escoamento; Vazão de projeto; Regularização de vazões.', 60, NULL),
(42, 'TEORIA DAS ESTRUTURAS II', 'Determinação do grau de hipergeometria. Fatores de segunda espécie. Método dos \r\ndeslocamentos. Processo de Cross.', 60, NULL),
(43, 'ESTRUTURAS METÁLICAS', 'Introdução as Estruturas de aço. Ações e Segurança nas Estruturas. Elementos \r\nTracionados. Elementos Comprimidos. Elementos Fletidos. Elementos sob Flexão \r\nComposta. Ligações. Noções sobre Detalhamento, Fabricação e Montagem. Laboratório: Representação Técnica de Projetos de Estrutura Metálica de forma manual e em \r\ncomputador, plataforma CAD.', 60, NULL),
(44, 'SANEAMENTO', 'Saneamento e saúde. Tratamento de Água. Tratamento de Esgoto. Rede de \r\ndistribuição de água. Rede de coleta e afastamento de esgoto. Estações elevatórias.', 60, NULL),
(45, 'FUNDAÇÕES', 'Introdução a Engenharia de Fundações, Conceitos Básicos, Investigação \r\nGeotécnica, Execução de Fundações, Fundações Rasas e Profundas, Recalque de Fundações, Capacidade de Carga de Fundações Rasas P rofundas, Ante -Projeto de \r\nFundações, Escolha de Fundações e Provas de carga.', 60, NULL),
(46, 'ESTRUTURAS DE MADEIRA', 'Propriedades físicas e químicas da madeira, Ações em estruturas de madeira. \r\nCombinação de ações. Propriedades de resistência e rigidez da madeira, Dimensionamento de elementos estruturais: flexão simples, tração, cisalhamento e estabilidade lateral, Dimensionamento de elementos estruturais: compressão paralela, normal e inclinada às fibras, Dimensionamento de elementos estruturais: flexão composta e flexão oblíqua; peças compostas de madeira, Projeto: Roteiro e lançamento da estrutura, Determinação dos esforços e dimensionamento das barras, Projeto: Ligações entre peças estruturais, Flecha, \r\ncontraventamento, detalhes construtivos, desenhos e quantificação de material, noções de preservação de madeiras e outros sistemas construtivos, industrialização da madeira.', 60, NULL),
(47, 'ESTRUTURA DE CONCRETO II', 'Dimensionamento de seções retangulares de concreto armado à flexão composta \r\nnormal; Dimensioname nto de seções retangulares à flexão composta oblíqua; \r\nDimensionamento de seções retangulares à torção. Lajes especiais – nervurada e cogumelo. \r\nPunção em lajes de concreto armado.', 60, NULL),
(48, 'PROJETOS ESTRUTURAIS', 'Análise do projeto estrutural de uma edificação de múltiplos andares. Concepção e lançamento das formas; carregamento; dimensionamento e detalhamento dos elementos estruturais. Apresentação do projeto segundo as normas brasileiras. Laboratório: Representação Técnica de Projeto Estrutural, em grandes formatos (A2, A1) de forma manual e em computador, plataforma CAD.', 60, NULL),
(49, 'SISTEMA DE INSTALAÇÕES PREDIAIS', 'Sistema s prediais de água fria, água quente, esgotos sanitários, águas pluviais, gás \r\ne de combate a incêndio. Laboratório: Determinação da perda de carga no tubo liso. \r\nDeterminação da perda de carga nas conexões. Verificação da pressão e potência de bombas de recalque.', 60, NULL),
(50, 'TÓPICOS CONTEMPORÂNEOS EM ENGENHARIA CIVIL', 'Disciplina livre para ter sua ementa adaptada conforme as tecnologias existentes \r\nno mercado com a finalidade de tornar mais dinâmica a formação do corpo discente.', 60, NULL),
(51, 'CONCRETO PROTENDIDO', 'Pontes de concreto: definições, nomenclatura, classificação; ações; sistemas \r\nestruturais e seções transversais; aparelhos de apoio, pilares e fundações; cálculo dos esforços na superestrutura e na infraestrutura; dimensionamento e detalhamento das seções de concreto e das armaduras.', 60, NULL),
(52, 'PONTES', 'Pontes de concreto: definições, nomenclatura, classificação; ações; sistemas \r\nestruturais e seções transversais; aparelhos de apoio, pilares e fundações; cálculo dos \r\nesforços na superestrutura e na infraestrutura; dimensionamento e detalhamento das seções de concreto e das armaduras.', 60, NULL),
(53, 'LINGUAGENS DIGITAIS I', 'Conhecimento da informática na pesquisa, projeto e ensino da arquitetura e \r\nurbanismo, enfocando recursos gráficos, metodológicos e operacionais. Princípios de \r\nlinguagens de arquitetura em 2D. Operação de softwares específicos para arquitetura e urbanismo.', 60, NULL),
(54, 'LINGUAGENS DIGITAIS II', 'Modelagem tridimensional (linhas, planos, volumes). Simulações: insolação, \r\nluz artificial e materiais. Percepção do espaço através de animações. Leitura digital do \r\nespaço. Fotografia. Imagem digita l. Plástica bidimensional - composição. Relações entre \r\nartes plásticas e arquitetura.', 60, NULL),
(55, 'INFRAESTRUTURA URBANA E DE TRÂNSITO', '-Revisão histórica das infraestruturas urbanas da cidade moderna; Saneamento \r\ne saúde; Visão integrada dos sistemas urbanos; Competências; Atribuições e \r\nprocedimentos no planejamento; Projeto; Implantação e Operação de Infraestrutura; Relação da Concepção d e projetos de infraestrutura com condicionantes ambientais; \r\nConceituação dos espaços próprios, públicos e condominiais; Sistema de abastecimento de água; Sistema de esgotamento sanitário; Sistemas de águas pluviais; Sistema viário.', 60, NULL),
(56, 'ELETRÔNICA DE POTÊNCIA', 'Introdução à eletrônica de potência. Diodos e transistores de potência. Tiristores. \r\nRetificadores monofásicos não controlados. Retificadores monofásicos controlados. \r\nRetificadores trifásicos não controlados, semi controlados e controla -dos. Chopper s DC. \r\nInversores. Controlador de tensão AC. Chaves estáticas.', 60, NULL),
(57, 'MATEMÁTICA BÁSICA', 'Conjuntos Numéricos, Operações nos conjuntos, Funções Polinomiais, Funções \r\nLogarítmicas, Funções Exponenciais, Aplicações.', 60, NULL),
(58, 'ESTATÍSTICA BÁSICA', 'Organização e apresentação de dados estatísticos. Noções de probabilidade.', 60, NULL),
(59, 'SOCIEDADE E ORGANIZAÇÕES', 'Sociologia como ciência. As principais correntes sociológicas. Classes Sociais, indivíduo \r\ne sociedade. Estado e Sociedade Industrial. Fundamentos sociológicos da teoria da sociedade e do \r\npoder. Tipos de organizações sociais, as relações de trabalho e as relações do indivíduo com as organizações. O papel da burocracia. Formas de poder na sociedade política e civil da contemporaneidade. A organização do espaço social urbano. Questões sociais contemporâneas: Pobreza, Violência, Educação, Criminalidade, Meio A mbiente, Cidadania e movimentos sociais. \r\nÉtica nas Organizações. Direitos humanos e de educação das relações étnicos -raciais. Ensino de \r\nhistória e cultura afro -brasileira, africana e indígena.', 60, NULL),
(60, 'TÉCNICAS DE LEITURA E PRODUÇÃO DE TEXTO', 'Noções de texto. Texto verbal e não -verbal. Linguagem, língua e fala. Denotação e \r\nConotação. Funções de Linguagem. Figuras de Linguagem. Níveis de Linguagem. Leitura: as \r\npossibilidades de leitura. Texto: gêneros. Palavras -chave. Ideias -chave. Parágrafo. E strutura simples \r\ne mista, parágrafo -chave, formas de construção, articulação. Coerência. Processo de expansão das \r\npalavras -chave. Coesão. Recursos de coesão. Paralelismos. Elementos conectivos. Resumo. Síntese. \r\nOralidade: técnicas de expressão oral. Desenv olvimento de competências e habilidades disposição \r\npara ouvir, falar e redigir.', 60, NULL),
(61, 'FUNDAMENTOS DE ENGENHARIA DE SOFTWARE', 'Histórico da Computação. Introdução a teoria geral dos sistemas. Áreas de conhecimento \r\nda Engenharia de Software (requisitos, projeto, construção, teste, manutenção, gerência de \r\nconfiguração, gerência de projeto, processo, modelos e métodos, qualidade, prática profissional, economia e fundamentos de engenharia). Engenharia de Sistemas (fundamentos, metodologias, stakeholder s e ciclo de vida).', 60, NULL),
(62, 'OFICINA DE PROGRAMAÇÃO', 'Introdução ao desenvolvimento de sistemas: HTML5, CSS e Javascript. Noções de \r\nprogramação funcional. Versionamento de código.', 60, NULL),
(63, 'ALGORITMOS E PROGRAMAÇÃO DE COMPUTADORES', 'Software básico, linguagens, compilação e representação interna dos dados. Resolução de \r\nproblemas e desenvolvimento de algoritmos. Estruturação de programas: seleção e repetição. Tipos \r\nde dados. Vetores e Matrizes. Linguagem de programação e transcrição de algoritmos.', 60, NULL),
(64, 'GOVERNANÇA E GESTÃO DE SERVIÇOS DE SOFTWARE', 'Planejamento e controle estratégico de gestão de software. Gestão de Serviços de Software. \r\nCiclo de vida de serviços de software. Manutenção de serviços de software.', 60, NULL),
(65, 'ARQUITETURA E ORGANIZAÇÃO DE COMPUTADORES', 'Conceitos básicos da arquitetura e organização de computadores. Histórico dos sistemas \r\ncomputacionais. Conversão de base e aritmética em outras bases. Componentes de um Computador: \r\nModelo Von Neumann. Execução de programas. Conjunto de Instruções, Mecanismos de Interrupção e de Exceção. Modos de endereçamento. Interfaces paralela, serial e USB. Dispositivos de entrada e saída. Hierarquia de Memória. Multiprocessadores. Multicomputadores. Arquiteturas Paralelas Arquiteturas RISC e CISC', 60, NULL),
(66, 'CÁLCULO', 'Funções de uma variável real. Derivadas e diferenciais. Máximos e mínimos. Integração \r\nindefinida e definida. Aplicações.', 60, NULL),
(67, 'MATEMÁTICA DISCRETA', 'Teoria de conjuntos, funções e sequências, relações binárias, relações n -árias, introdução \r\na teoria dos núme ros: divisibilidade, números primos, aritmética modular.', 60, NULL),
(68, 'MÁQUINA', 'Princípios e conceitos de interação homem -computador (IHC). Engenharia semiótica e \r\ncognitiva. Modelos e técnicas modelagem IHC. Conceitos de usabilidade e métodos de avaliação. \r\nProjeto de Interfaces.', 60, NULL),
(69, 'MATEMÁTICA DISCRETA II', 'Teorema da contagem, análise combinatório, probabilidades.', 60, NULL),
(70, 'LÓGICA COMPUTACIONAL II', 'Lógica de Predicados. Tableaux Semântico. Sentenças abertas e quantificadores. \r\nLinguagem de Programação PROLOG.', 60, NULL),
(71, 'PROJETO DE BANCO DE DADOS', 'Apresentação dos conceitos fundamentais para o projeto, utilização e implementação de \r\nbanco de dados. Modelagem de dados usando o Modelo E/R. O Modelo relacional: conceitos, \r\nintegridade de dados. Álgebra relacional. Principais comandos SQL. Restrições de integridade, depen dência funcional, formas normais.', 60, NULL),
(72, 'ALGORITMOS E ESTRUTURA DE DADOS I', 'Modularização de programas: procedimentos e funções. Passagem de parâmetros. Tipo \r\nabstrato de dados. Alocação estática e dinâmica de memória. Estrutura de dados e aplicações: Listas, \r\npilhas e filas. Estruturas encadeadas.', 60, NULL),
(73, 'TÓPICOS CONTEMPORÂNEOS EM ENGENHARIA DE SOFTWARE', 'Tópicos variáveis na área de sistemas de informação, segundo interesse dos alunos e', 60, NULL),
(74, 'ADMINISTRAÇÃO E ORGANIZAÇÃO DE BANCO DE DADOS', 'SQL procedural: gatilhos e procedimentos armazenados. Definição e utilização de Visões. \r\nOrganização física dos dados, indexação e hashing. Processamento e otimização de consultas. \r\nGerenciamento de transações Mecanismos de proteção: recuperação e segurança e integridade de dados. Processamento multiusuário: controle de concorrência. Tuning do banco. Implementação prática de bases de dados.', 60, NULL),
(75, 'ALGORITMOS E ESTRUTURA DE DADOS II', 'Recursividade. Métodos de ordenação interna: classificação por inserção, classificação por \r\ntroca, classificação por seleção, classificação por intercalação, classificação por partição. Métodos \r\nde busca: sequencial, binária e indexada. Árvores: Binárias, AVL, Preto Vermelho; Heaps. Tabelas Hash. Conjuntos. Mapas. Compactação: códigos de Huffman e Shannon. Grafos: conceitos, Isomorfismo, Matrizes de Adjacência e Incidência, Caminhos e Ciclos. Algoritmo Djikstra. Cortes de Arestas, Cortes de Vértices. Conectividade: Conectividade de Vértices e Arestas; Ciclos Eulerianos e  Hamiltonianos. Emparelhamentos. Coloração de Vértices e de Arestas. Planaridade.', 60, NULL),
(76, 'REDE DE COMPUTADORES I', 'Introdução/Conceitos Básicos. Organização de Padronização. Modelo de Referência \r\nOSI/ISO. Protocolos; Arquitetura TCP/IP: Camada de aplicação, camada de transporte.', 60, NULL),
(77, 'TEORIA DA COMPUTAÇÃO', 'Noções de Programas e Máquinas. Noção de computabilidade efetiva. Máquinas de \r\nRegistradores e Máquina de Turing. Teste de Church.', 60, NULL),
(78, 'PROJETO E MODELAGEM DE SOFTWARE', 'Projeto lógico e físico. Modelos de arquitetura de softwares. Diagramas da Linguagem de \r\nModelagem Unificada (UML): atividade, interação, estados, componentes e implantação. Padrões', 60, NULL),
(79, 'PARADIGMAS DE PROGRAMAÇÃO', 'Definição e classificação de paradigmas de programação. Paradigmas declarativos, \r\nimperativos e funcionais.', 60, NULL),
(80, 'CONSTRUÇÃO DE SOFTWARE', 'Técnicas para minimizar complexidade, antecipar mudanças, construção para a verificação \r\ne padrões em construção de software. Integração Contínua. Gerência de Configuração. Testes \r\nunitários, teste de integração, testes persistência. Introdução a qualidade de software. Métricas de Software.', 60, NULL),
(81, 'GERENCIAMENTRO DE PROJETOS', 'Introdução ao gerenciamento de projetos. Gerenciamento de: escopo, tempo, custo, \r\ncomunicação, riscos, recursos humanos, qualidade, aquisição e integração.  Modelos, metodologias \r\ne técnicas de gerenciamento de projetos.', 60, NULL),
(82, 'FÁBRICA DE SOFTWARE I', 'Aplicação dos conhecimentos de Engenharia de Software no contexto de projetos práticos, \r\ntendo como objetivo vivenciar todas as fases do ciclo de desenvolvimento de software. O aluno deverá ao final da disciplina entregar um conjunto de documentação de análise e projeto de um', 60, NULL),
(83, 'SISTEMAS COMPUTACIONAIS DISTRIBUÍDOS E APLICAÇÕES EM \r\nNUVENS', 'Introdução aos Sistemas Distribuídos. Caracterização de um Sistema Distribuído. Desafios \r\nde sistemas distribuídos. Middlewares e Máquinas Virtuais. Requisitos de Software para Sistemas \r\nDistribuídos. Transparência. Flexibilidade. Confiabilidade. Desempenho. Escalabilidade. \r\nParadigmas dos Sistemas Distribuídos. Trocas de Mensagens. Comunicação em Grupo. Time e Clocks. Operações Remotas .', 60, NULL),
(84, 'PROCESSOS DE SOFTWARE', 'O processo de software e o produto de software. Ciclo de vida de sistemas e seus \r\nparadigmas. Processos, metodologias, técnicas e ferramentas de análise e projeto de sistemas de \r\nsoftware segundo um paradigma de desenvolvimento atual.', 60, NULL),
(85, 'REDE DE COMPUTADORES II', 'Introdução/Conceitos Básicos. Organização de Padronização. Modelo de Referência \r\nOSI/ISO. Protocolos; Arquitetura TCP/IP: Camada de rede e camada de enlace.', 60, NULL),
(86, 'PADRÕES ARQUITETURAIS', 'Estudo de documentação arquitetural e padrões de arquiteturais: Arquitetura em Camadas, \r\nPipes, MVC, Repositório, MVP, MVVP, e Microserviços. Padrões de Projeto.', 60, NULL),
(87, 'FRAMEWORKS DE PERSISTÊNCIA DE DADOS', 'Conceitos sobre frameworks de persistência de dados: descrição de dados, formatos de \r\ndados (XML, JSON, Texto, Binário). Mapeamento objeto- relacional. Modelagem e Implementação \r\nde Banco de dados.', 60, NULL),
(88, 'METODOLOGIAS ÁGEIS DE DESENVOLVIMENTO  DE SOFTWARE', 'Conceitos de metodologias ágeis, Extreme Programming, Scrum e Lean.', 60, NULL),
(89, 'EMPREENDEDORISMO', 'O empreendedor. Características de um empreendedor. O papel do empreendedor na \r\ncriação de uma empresa. Qualidades, habilidades e competências do empreendedor. Análise para a competitividade: análise de mercado, recursos humanos, prática de competitividade. Atitude \r\nempreendedora em indústrias, comércio e serviços. Elaboração de Plano de Negócios. O sucesso e o fracasso de novos empreendimentos. O Intra- empreendedor.', 60, NULL),
(90, 'PESQUISA OPERACIONAL E OTIMIZAÇÃO', 'Programação linear. Programação inteira. Teoria dos jogos. Análise de decisão. Simulação \r\nde Monte Carlo.', 60, NULL),
(91, 'SEGURANÇA E AUDITORIA NO DESENVOLVIMENTO DE SISTEMAS', 'Princípios de segurança da informação. Métodos de criptografia. ISO/IEC 27.001, \r\nISO/IEC 27.002, ISO/27.005, ISO/IEC 15.408.', 60, NULL),
(92, 'COMPLEXIDADE DE ALGORITMOS', 'Conceitos sobre análise de complexidade. Técnicas de cálculo de complexidade. Classes \r\nde Problemas.', 60, NULL),
(93, 'MACHINE LEARNING E MINERAÇÃO DE DADOS', 'Aprendizado Supervisionado. Aprendizado não supervisionado. Técnicas de agrupamento. \r\nTécnicas de reconhecimento de padrões.', 60, NULL),
(94, 'FÁBRICA DE SOFTWARE II', 'Aplicação dos conhecimentos de Engenharia de Software no contexto de projetos práticos, \r\ntendo como objetivo vivenciar todas as fases do ciclo de desenvolvimento de software. O aluno \r\ndeverá ao final da disciplina entregar um produto de software junt amente com os casos de testes.', 60, NULL),
(95, 'MODELAGEM DE PROCESSOS DE NEGÓCIO', 'Conceitos de gestão organizacional e contextualização de processos nas organizações. \r\nConceitos de modelagem organizcional. Melhori a de processos e reengenharia organizacional. \r\nGestão de Processos de Negócios: fundamentos, ciclo de vida e sistemas para a gestão de processos \r\nde negócio (BPMS). Análise e modelo orientados a processos. Modelagem de Processos de Negócios: \r\nconceitos básico s, notações, ferramentas, elementos essenciais das linguagens BPMN (Business \r\nProcess Modeling Notation). Relação entre BPM e soluções tecnológicas (ERP, ECM, CRM). \r\nGerenciamento da mudança em BPM. Melhoria contínua dos processos de negócio', 60, NULL),
(96, 'GESTÃO DA INFORMAÇÃO E DO CONHECIMENTO', 'Conceitos sobre dados, informação e conhecimento. Cultura informacional. Mapeamento \r\nde necessidades informacionais. Processos de informação, arquitetura, estilo e gerenciamento. \r\nMétodos e técnicas de gestão da informação e do conhecimento. Inteligência co mpetitiva \r\norganizacional. Ferramentas utilizadas na gestão da informação.', 60, NULL),
(97, 'LINGUAGENS FORMAIS E AUTÔMATOS', 'Linguagens Regulares e Autômantos Finitos; Linguagens Livre de Contexto e Autômatos \r\nde Pilha; Linguagens Sensível ao Contexto e Autômatos Limitados Linearmente; Máquinas de \r\nTuring', 60, NULL),
(98, 'LINGUAGENS DE MONTAGEM', 'Computadores: unidades básicas, instruções, programa armazenado, endereçamento,', 60, NULL),
(99, 'CIÊNCIAS AMBIENTAIS', 'Introdução ao estudo da Ecologia. Organização geral dos ecossistemas. Transferência de \r\nmatéria e energia nos ecossistemas. Fatores abióticos. Saúde coletiva e meio ambiente. Poluição e \r\nimpacto ambiental. Caracterização ambiental regional. Legislação ambiental existente', 60, NULL),
(100, 'GESTÃO DE NEGÓCIOS E ECONOMIA', 'Conceito e Objetivos da Administração. Funções da Administração. Empresas e \r\nprincípios. Visão Holística. Processos de negócios. Introdução ao empreendedorismo. Modelo de empresas. Conceito de Economia. Principais problemas econômicos. Divisão da Economia. A Economia de mercado, origens e destino da produção. A unidade produtora, sua inserção no sistema. A circulação numa economia de mercado. Estruturas  de Mercado. Cenários Econômicos.', 60, NULL),
(101, 'CÁLCULO II', 'Otimização; Integral Dupla; Integral Tripla; Integral de Linha; Integral de Superfície; \r\nSequências e Séries', 60, NULL),
(102, 'ONDAS', 'Movimento harmônico. Oscilador harmônico simples angular. Movimento circular \r\nuniforme. Ressonância. Ondas. Acústica.', 60, NULL),
(103, 'ELETRÔNICA DIGITAL I', 'Sistemas de numeração e códigos. Circuitos lógicos. Circuitos lógicos combinatórios. \r\nFlip-Flops. Aritmética Digital. Contadores e registradores. Famílias lógicas e circuitos integrados. \r\nCircuitos lógicos MSI.', 60, NULL),
(104, 'ELETROMAGNETISMO', 'Operações matemáticas com vetores no espaço: conceito e aplicação de produtos  \r\nescalares  e vetoriais.  Lei experimental  de Coulomb, campo  elétrico  e densidade de fluxo: \r\naplicações para diversas distribuições de carga. Lei de Gauss: cálculo de carga para diversas \r\ndistribuições espaciais. Energia e Potencial Elétrico para cargas em movimento. Equações de Poisson e Laplace aplicadas para cálculo de potencial e campo elétrico no espaço. Campos magnéticos estacionários, forças magnéticas e materiais. Campos variáveis e as equações de Maxwell, aplicadas para a determinação de campos elétricos e magnéticos no espaço.', 60, NULL),
(105, 'REDES DE COMPUTADORES I', 'Introdução/Conceitos Básicos. Organização de Padronização. Modelo de Referência \r\nOSI/ISO. Protocolos; Arquitetura TCP/IP: Camada de aplicação, camada de transporte.', 60, NULL),
(106, 'TÓPICOS ESPECIAIS EM ENGENHARIA ELÉTRICA', 'Definição de fenômenos de transferência; conceitos fundamentais; características e \r\npropriedades dos fluidos; estática dos fluídos; conservação de massa e de  energia;  equação  de \r\nBernoulli; perda de carga.  Fundamentos de transferência  de calor. Fundamentos de transferência \r\nde massa. Laboratório: Determinação da massa específica e peso específico;  Verificação  da pressão  \r\nestática a baixa pressão;  Verificação  da pressão estática a alta pressão; Determinação da velocidade \r\nà baixa pressão no tubo de Pitot; Determina ção da velocidade à alta pressão  no tubo de Prandtl; \r\nDeterminação  da vazão  no tubo Diafragma; Calibração do tubo Venturi; Empuxo e flutuação.', 60, NULL),
(107, 'MODELAGEM DE LINHAS DE TRANSMISSÃO', 'Características gerais da linhas de transmissão (estrutura, materiais, operação). Cálculo  \r\ndos parâmetros  característicos  de linhas de transmissão  (indutância, capacitância e resistência). \r\nCálculo matricial de Parâmetros de Linhas de Transmissão. Estudo de linhas  de transmissão  curtas,  \r\nmédias  e longas. Relações  entre  correntes  e tensões  em uma linha de transmissão; Noções de ondas \r\nviajantes em linhas de transmissão. Circuito equivalente π e T de uma linha de transmissão e modelo de quadripolo equivalente. Rendimento e regulação de tensão em linhas de transmissão; \r\nCompensação de reativos em linhas de transmissão. Fluxo de potência em linhas de transmissão.', 60, NULL),
(108, 'INSTALAÇÕES ELÉTRICAS INDUSTRIAIS E SISTEMA DE PROTEÇÃO \r\nELÉTRICA', 'Condutores de média tensão. Barramentos. Condutos utilizados em instalações  elétricas \r\nindustriais. Equipamentos e dispositivos elétricos utilizados em instalações elétricas industriais. \r\nSubestações de consumidor. Curto- circuito nas instalações  elétricas. Proteção e coordenação.', 60, NULL),
(109, 'SISTEMAS ELÉTRICOS DE POTÊNCIA', 'Introdução aos sistemas de potência (elementos constituintes do sistema na geração, \r\ntransmissão e distribuição); Modelagem de linhas de transmissão, transformadores, reatores, geradores e carga. Sistema PU (por unidade); Fluxo de potência em sistemas elétricos de potência (montagem das matrizes de rede); Métodos para resolução do fluxo de potência (Método iterativo de Newton e Método iterativo de Gauss -Seidel); Estabilidade de um sistema de potência; \r\nCom ponentes simétricas; Curto - Circuito (monofásico, bifásico e trifásico).', 60, NULL),
(110, 'LABORATÓRIO DE MÁQUINAS ELÉTRICAS', 'Estudo prático de Máquinas elétricas CC e CA e seus acionamentos.', 60, NULL),
(111, 'FONTES ALTERNATIVAS DE ENERGIA', 'Centrais Hidrelétricas; Centrais Termelétricas; Energia dos Oceanos; Células a \r\nCombustível; Sistemas Eólicos de Geração de Energia Elétrica; Energia Solar Fotovoltaica - Conceitos e Aplicações; Sistemas Híbridos.', 60, NULL),
(112, 'SISTEMAS DE PROTEÇÃO CONTRA DESCARGAS ATMOSFÉRICAS', 'Gerenciamento de risco. Danos físicos a estruturas e perigos à vida. Sistemas elétricos e \r\neletrônicos internos na estrutura.', 60, NULL),
(113, 'DISTRIBUIÇÃO DE ENERGIA ELÉTRICA', 'Constituição dos Sistemas Elétricos de Potência; Corrente Admissível em Linhas; \r\nConstantes Quilométricas de Linhas Aéreas e Subterrâneas; Fluxo de Potência', 60, NULL),
(114, 'QUALIDADE DA ENERGIA ELÉTRICA', 'Qualidade de serviço de fornecimento de energia elétrica. A natureza das interrupções \r\ndo fornecimento. Indicadores da qualidade de serviço: DEC, FEC e outros indicadores. Cálculo de indicadores. Variação de tensão de longa duração. Variação de tensão de curta duração. \r\nInterrupção. Ruído. Flicker.  Notching. Transitório  ou transiente. Surto de tensão ou Spike. \r\nVariação de Frequência. Desequilíbrio de tensão. Redu ção do Fator de Potência. Harmônica. Inter -\r\nHarmônica. Interferência  eletromagnética.', 60, NULL),
(115, 'PROJETOS DE CIRCUITOS DE CONTROLE', 'Aplicações. Problemas do cotidiano resolvidos com controle. Pesquisa com geração de \r\nartigos científicos na área.', 60, NULL),
(116, 'TÓPICOS CONTEMPORÂNEOS EM ENGENHARIA ELÉTRICA', 'Disciplina  livre para ter sua ementa adaptada conforme as tecnologias existentes no \r\nmercado com a finalidade de tornar mais dinâmica a formação do corpo  discente.', 60, NULL),
(117, 'AUTOMAÇÃO INDUSTRIAL E CONTROLE', 'Metodologia de projeto. Fases de desenvolvimento de um projeto de Engenharia. A \r\nprocura de soluções alternativas. Inventividade. O processo de solução de problemas; formulação do problema e técnicas de solução. Processos de tomada de decisão: Aspectos comportamentais; teoria de decisão; matriz de decisões, árvore de decisão. Projeto de um sistema mecânico. Desenvolvimento do projeto de um sistema mecânico, visando a aplicação e consolidação dos relativos  ao processo de projeto.', 60, NULL),
(118, 'ESTRUTURAS DE DADOS I', 'Métodos de programação modular; Recursividade; Ponteiros; Alocação dinâmica de \r\nmemória; Uniões; Tipos de dados estruturados; Estruturas de dados homogêneas: listas; filas; \r\npilhas;', 60, NULL),
(119, 'ESTRUTURAS DE DADOS II', 'Estruturas de dados hierárquicas: Árvore binária; Árvore n- ária; Árvore AVL; Árvore -\r\nB; Árvore B+; Grafos; Busca; Ordenação;', 60, NULL),
(120, 'PLANEJAMENTO DE RECURSOS ENERGÉTICOS', 'Planejamento de Serviços de Energia e o Planejamento Integrado de Recursos; A \r\nEstrutura Tecnológica das Projeções e dos Cenários da Demanda de Energia; Programas de \r\nEficiência Energética, gerenciamento do Lado da Demanda (DSM) e Fontes Renováveis; Integrando as Opções do Lado da Oferta e da Demanda', 60, NULL),
(121, 'USO RACIONAL DE ENERGIA E SUSTENTABILIDADE', 'Educação ambienta. Energias Alternativas. Construções Sustentáveis. Soluções \r\nSustentáveis para a Indústria.', 60, NULL),
(122, 'MATERIAIS DE CONSTRUÇÃO MECÂNICA', 'Propriedades mecânicas dos materiais, revisão de elasticidade, conceito de \r\nresistência ideal, deformação de monocristais; Deformação de polímeros; Tensões e deformações principais, teoria das discordâncias; Dureza de materiais; Mecanismos de endure cimento dos materiais (solidificação, solução sólida, precipitação, encruamento, \r\ntransformação martensítica e tratamento de superfície); Transformação isomorfas; eutética e peritética. Transformação eutetóide e curvas TTT e de resfriamento contínuo; Tratam ento \r\ntérmico de metais: ligas ferrosas, ligas de alumínio (Recozimento, normalização, austêmpera, martêmpera, têmpera e revenido. Envelhecimento); Materiais metálicos para construção mecânica: aços, aços ferramenta, aços inoxidáveis, ferros fundidos, ligas  de: \r\nalumínio, de cobre, estanho e anti -fricção; Materiais poliméricos: termorrígidos, plásticos; \r\nelastômeros; Materiais cerâmicos e vidros; cerâmicas avançadas; cerâmicas para sensores (piezoelétricos) e ferramentas (corte e conformação); Materiais compósitos (Aplicação aeronáutica e Ferramentas); Principais tratamentos de superfície: com e sem mudança de composição (têmpera superficial, cementação, nitretação, carbonitretação, boretação); PVD, CVD, aspersão térmica (HVOF, plasma). Análise de ensaios mecânicos de tração, torção, compressão, impacto, fluência e flambagem.', 60, NULL),
(123, 'RESISTÊNCIA DOS MATERIAIS I', 'Conceitos da Resistência dos Materiais; propriedades mecânicas dos materiais; \r\nTração, compressão e cisalhamento; Análise de tensões e deformações.', 60, NULL),
(124, 'ELETRÔNICA ANALÓGICA', 'Introdução à eletrônica; amplificadores operacionais; diod os; transistores de efeito \r\nde campo; transistores bipolares de junção. Circuitos integrados para amplificadores de um único estágio; amplificadores diferenciais e de múltiplos estágios; realimentação', 60, NULL),
(125, 'TERMODINÂMICA', 'Definições básicas; propriedades termodinâmicas; substâncias puras; trabalho e \r\ncalor; primeira lei da termodinâmica para sistemas e volume de controle; segunda lei da \r\ntermodinâmica e entropia, Irreversibilidade e disponibilidade.', 60, NULL),
(126, 'DESENHO MECÂNICO', 'Desenho Técnico: Vistas, Formatos, Legendas, Escalas, Cotas, Linhas de \r\nRepresentação, Normas de Desenho Técnico, Cortes, Vistas Ext raordinárias e Parciais, \r\nDistribuição de Vistas e Cortes nos Desenhos, Projeções, Tipos de Documentação em \r\nProjeto Mecânico. Ajustes, Tolerâncias, Soldas, Acabamentos Superficiais. Inserção de elementos padronizados de máquinas: Roscas, molas, Rebites, Cha vetas, Polias e correias; \r\nRolamentos e Engrenagens. Desenho definitivo: Componentes; Conjuntos Mecânicos. Interpretação e elaboração de desenhos por meio computacional, técnicas fundamentais de desenho CAD, parametrização, comandos por modelação, montagens  e desenho de vistas \r\nortográficas e estudo das tensões e deformações mecânicas. Geração de desenhos por intermédio da biblioteca de projetos. Desenho de Postos de Trabalho.', 60, NULL),
(127, 'ELETRÔNICA DIGITAL', 'Sistemas de numeração e códigos. Circuitos lógicos. Circuitos lógicos \r\ncombinatórios. Flip- Flops. Aritmética Digital. Contadores e registradores. Famílias lógicas \r\ne circuitos integrados. Circuitos lógicos MSI.', 60, NULL),
(128, 'ELEMENTOS DE MÁQUINAS I', 'Modelagem, carregamento e equilíbrio; Resultantes internas; Diagramas; \r\nComposição de tensões; Teorias de Falhas Estáticas: Von Mises, Tresca, Coulomb-Mohr, \r\nTeorias de Falha Por fadiga: Goodman, Soderberger, Gerber; Falha por impacto, Falha por \r\nInstabilidad e: Flambagem, Falha por Desgaste; Tensões de Hertz. Introdução à mecânica de \r\nfratura. Análise e dimensionamento de componentes mecânicos: Eixos (dimensionamento \r\ne análise para diversos modos de falha); Especificação de elementos de fixação; \r\nEngrenagens: dentes retos, helicoidais, cônicas e rosca -sem-fim, geometria, esforços de \r\ncontato, tensões de raiz e contato; molas: helicoidais e planas; Parafusos de fixação e \r\npotência.', 60, NULL),
(129, 'MÁQUINAS DE FLUXO', 'Máquinas de Transformação de Energia: análise energética, rendimentos \r\nhidráulicos, parâmetros de escolha, equação fundamental, análise dimensional; Cavitação: \r\nconceito, identificação, parâmetros; Aproveitamentos hidrelétricos: tipos de aproveitamento, bombas -turbina, turbinas hidráulicas; Máquinas de fluxo em paralelo ou \r\nem série. Sistemas de Recalque: configurações, instalação e regulação, formas construtivas, \r\ntransformação de energia; Compressores e Ventiladores: tipos, componentes, equipamentos auxiliares, operação, eficiência e critérios de seleção.', 60, NULL),
(130, 'INSTRUMENTAÇÃO INDUSTRIAL E ACIONAMENTOS ELÉTRICOS', 'Instrumentação básica: multímetros, osciloscópios analógicos e digitais, \r\nanalisadores lógicos digitais. Características Estáticas e Dinâmicas dos Instrumentos e \r\nSensores. Análise de dados experimentais. Medida e Análise de Deslocamento, Velocidade, Aceleração, Força, Torque, Potência Mecânica. Problemas na Amplificação, Transmissão e Armazenamento de Sinais. Medições de Som. Medidas de pressão, vazão e temperatura. Medidas de propriedades térmicas e de transporte.  Motores Elétricos, Tipos de Motores \r\nElétricos, Características dos Motores de Indução Trifásicos, Dispositivos de Proteção e de Comando, Chaves de Partida, Chaves de Partida Eletrônicas, Conversores de Frequência.', 60, NULL);
INSERT INTO `disciplinas` (`id_disciplina`, `nome_disciplina`, `ementa`, `carga_horaria`, `id_curso`) VALUES
(131, 'LABORATÓRIO DE CIRCUITOS ELÉTRICOS E ELETRÔNICA', 'Componentes passivos. Introdução aos dispositivos eletrônicos. Fontes de tensão. \r\nAmplificadores operacionais. Conversores analógico- digital e digital analógico. \r\nInstrumentos de laboratório.', 60, NULL),
(132, 'DINÂMICA DAS MÁQUINAS', 'Estudo de conceitos e definições básicas de mecanismos; análise de características \r\ncinemáticas e cinéticas (dinâmica) de mecanismos; Análise de posição, velocidades e de \r\naceleração; Técnicas usuais de síntese de mecanismos; estudo de alguns mecanismos especiais: came-seguidor, redutores e engrenamentos planetários.', 60, NULL),
(133, 'MODELAGEM DE PROCESSOS DE NEGÓCIO', 'Conceitos de gestão organizacional e contextualização de processos nas \r\norganizações. Conceitos de modelagem organizcional. Melhoria de processos e \r\nreengenharia organizacional. Gestão de Processos de Negócios: fundamentos, ci clo de vida \r\ne sistemas para a gestão de processos de negócio (BPMS). Análise e modelo orientados a processos. Modelagem de Processos de Negócios: conceitos básicos, notações, ferramentas, elementos essenciais das linguagens BPMN (Business Process Modeling Notation). Relação \r\nentre BPM e soluções tecnológicas (ERP, ECM, CRM). Gerenciamento da mudança em \r\nBPM. Melhoria contínua dos processos de negócio', 60, NULL),
(134, 'CÁLCULO', 'Estudo de limite e continuidade, derivadas e suas aplicações. Estudo das integrais \r\nindefinidas e definidas, dos métodos de integração e suas aplicações.', 60, NULL),
(135, 'ARQUITETURA DE COMPUTADORES E SISTEMAS OPERACIONAIS', 'Conceitos básicos da arquitetura e organização de computadores. Histórico dos \r\nsistemas computacionais. Conversão de base e aritmética em outras bases. Componentes de um Computador: Modelo Von Neumann. Execução de programas. Conjunto de Instruções, Mecanismos de Interrupção e de Exceção. Modos de endereçamento. Interfaces paralela, serial e USB. Dispositivos de entrada e saída. Hierarquia de Memória. Multiprocessadores. Multicomputadores. Arquiteturas Pa ralelas Arquiteturas RISC e CISCVisões. Processos: \r\nconceito, estados. Gerência de filas. Proteção entre processos. Sessões críticas. Semáforos. Deadlock. Gerência do processador. Técnicas de escalonamento. Gerenciamento de memória. Paginação e segmentação.', 60, NULL),
(136, 'PROGRAMAÇÃO BÁSICA', 'Breve história da computação. Algoritmos: caracterização, notação, estruturas \r\nbásicas. Conceitos de linguagens algorítmicas: expressões, comandos sequenciais, seletivos e repetitivos; entrada/saída; variáveis estruturadas, funções. Desenvolvimento e docum entação de programas. Exemplos de processamento não- numérico. Laboratório: \r\nExtensa prática de programação e depuração de programas utilizando uma das linguagens de programação.', 60, NULL),
(137, 'INOVAÇÃO E ECONOMIA CRIATIVA', 'O empreendedor. Características de um empreendedor. O papel do empreendedor \r\nna criação de uma empresa. Qualidades, habilidades e competências do empreendedor. Empreendedorismo Social. Análise para a competitividade: análise de mercado, recursos humanos, prática de competitividade. Atitude empreendedora em indústrias, comércio e serviços. Elaboração de Plano de Negócios. O sucesso e o fracasso de novos empreendimentos. O Intraempreendedor. Novas ferramentas para modelagem de negócios: Design thinking;, Storytelling, Oceano Azul e Canvas. Conceito de economia Criativa. Indústrias Criativas. Princípios norteadores da Economia Criativa: diversidade cultural, sustentabilidade, inovação e inclusão social. Inovação. Os tipos de inovação.', 60, NULL),
(138, 'NEGÓCIOS E TIMES DE TRABALHO', 'Estudo do estabelecimento da relação entre as necessidades constantemente \r\nrenovadas de aplicação de gerenciamento de pessoas por parte das organizações e atendimento às diversas legislações, com destaque para as legislações trabalhistas e previdenciárias.  Este gerenciamento de pessoas abrange desde a busca de profissionais no \r\nmercado de trabalho, manutenção dos mesmos nos ambientes de trabalho e seu desligamento, completando a abordagem de gestão de pessoas.', 60, NULL),
(139, 'REDES DE COMPUTADORES', 'Introdução/Conceitos Básicos. Organização de Padronização. Modelo de \r\nReferência OSI/ISO. Protocolos; Arquitetura TCP/IP: Camada de aplicação, camada de transporte; camada de rede e camada de enlace.', 60, NULL),
(140, 'SEGURANÇA DA INFORMAÇÃO', 'Auditoria e avaliação de sistemas . Auditoria em tecnologia da informação: \r\nplanejamento, implementação, ambiente computacional e técnicas. Segurança da informação: segurança física, lógica e de comunicações. Planos de contingência e \r\nrecuperação de desastres. Avaliação quantitativa x qualitativa. Classificação e caracterização dos métodos de avaliação.', 60, NULL),
(141, 'SOCIEDADE E ORGANIZAÇÃO', 'Sociologia como ciência. As principais correntes sociológicas. Classes Sociais, \r\nindivíduo e sociedade. Estado e Sociedade Industrial. Fundamentos sociológicos da teoria da sociedade e do poder. Tipos de organizações sociais, as relações de trabalho e as r elações \r\ndo indivíduo com as organizações. O papel da burocracia. Formas de poder na sociedade política e civil da contemporaneidade. Relações Étnico -raciais. Conceitos de raça e etnia, \r\nmestiçagem, racismo e racialismo, preconceito e discriminação. Configurações dos conceitos de raça, etnia e cor no Brasil: entre as abordagens acadêmicas e sociais. Cultura afro-brasileira e indígena. Políticas de Ações Afirmativas e Discriminação Positiva – a \r\nquestão das cotas. Trabalho, produtividade e diversidade cultural. Estudo do conceito, \r\nfundamentos, evolução e significado contemporâneo dos direitos garantias fundamentais. Visão panorâmica dos direitos e garantias fundamentais: direitos e deveres individuais e coletivos, sociais, da nacionalidade e políticos.  Bibliogr afia básica: \r\n \r\n1. CASTELLS, Manuel. A sociedade em rede. 6.ed. São Paulo: Paz e Terra, \r\n2011.  \r\n2. MATTOS, Regiane Augusto de. História e cultura afro- brasileira . 2.ed. São \r\nPaulo: Contexto, 2013.  \r\n3. TOMAZI, Nelson Dacio (coord.). Iniciação à sociologia. 2. ed. São Paulo: \r\nAtual, 2000..', 60, NULL),
(142, 'BANCO DE DADOS II', 'SQL procedural: gatilhos e procedimentos armazenados. Definição e utilização \r\nde Visões. Organização física dos dados, indexação e hashing. Processamento e otimização \r\nde consultas. Gerenciamento de transações Mecanismos de proteção: recuperação e segurança e integridade de dados. Processamento multiusuário: controle de concorrência. \r\nTuning do banco. Implementação prática de bases de dados. NoSQL.', 60, NULL),
(143, 'DESENVOLVIMENTO ÁGIL DE SOFTWARE', 'Fundamentos de construção de software (minimizar complexidade, antecipar \r\nmudanças, construção para a verificação e padrões em construção de software). Gerência \r\nde construção (modelos de processos de construção, planejamento de construção, medidas \r\nde construção). Gerência de Configuração de Software. Projeto detalhado e construção de \r\nsoftware. Linguagens empregadas na construção de software. Codificação. Testes de \r\nunidade, persistência e de integração. Reutilização de software. Qualidade de Software. \r\nConceitos de Metodologias Ágeis. Integração Contínua. Entrega Contínua. Git. Docker. \r\nKubernetes. Scrum. Kanban. Lean.', 60, NULL),
(144, 'ARQUITETURA DE SOFTWARE', 'Padrões de Arquitetura. Padrões de Projeto. Arquitetura de Software. \r\nDesenvolvimento orientado ao domínio (Domain-Driven Design).', 60, NULL),
(145, 'DESIGN DE INTERFACES', 'Conhecer os conceitos de cognição do usuário, percepção. Interface de sistemas: \r\ninteração homem -máquina. Desenvolvimento de interfaces digitais: usabilidade das \r\ninterfaces frente ao sistema; Avaliar a usabilidade em sistemas de informação: web e \r\ndesktop. Projeto de Design: desenvolver uma interface interativa.', 60, NULL),
(146, 'CLOUD COMPUTING', 'Introdução ao paradigma de computação em nuvem. Conceitos, vantagens, \r\ndesvantagens e características. Arquitetura da Computação em Nuvem: Infraestrutura como \r\nServiço (Infrastructure as a Service - IaaS ). Plataforma como Serviço (Platform as a Service \r\n- PaaS ) e Software como Serviço (Software as a Service - SaaS ). Ferramentas de \r\nImplementação. Infraestrutura de Armazenamento: SimpleDB, Big Table, Simple Storage Service, storage virtualization, cloud storage. Segurança no armazenamento de dados em Computa ção em Nuvem. Introdução a Confiança e Reputação em Computação em Nuvens \r\ne aplicações.', 60, NULL),
(147, 'PROGRAMAÇÃO WEB I', 'Introdução à Internet e Web. Servidores e ambientes Web. Linguagem HTML. \r\nLinguagem CSS. Linguagem Javascript e jQuery. Bootstrap. Web Design (responsivo e não-responsivo). Bibliotecas. Plug-ins e frameworks de desenvolvimento Web client- side.', 60, NULL),
(148, 'TESTE DE SOFTWARE', 'Fundamentos de Testes de Software. Testes de Unidade. Test -Driven \r\nDevelopment (TDD). Mock Objects. Testes de Integração. Testes de Sistema. Testes de \r\nServiços Web. Automação de testes de software.', 60, NULL),
(149, 'DESIGN THINKING', 'O Design Thinking, seus métodos e ferramentas. A criatividade como processo \r\npassível de aprendizado e gerenciamento. Criatividade e processos criativos. Criatividade e inovação. Princípios, método e processos do Design Thinking. Criatividade baseada em problemas. Co- criação: desafios e oportunidades. Experimentação como parte do processo \r\ncriativo. Gerenciando as incertezas do processo criativo (erro, imprevisibilidade e estruturas abertas).', 60, NULL),
(150, 'ÉTICA E LEGISLAÇÃO', 'Legislações: Lei de software. Tratamento e sigilo de dados. Propriedade imaterial. \r\nPropriedade intelectual. Propriedade industrial. Responsabilidade civil e penal sobre a tutela \r\nda informação. Códigos de Ética: humano e profissional.', 60, NULL),
(151, 'PROGRAMAÇÃO WEB II', 'Frameworks especiais de Desenvolvimento para Web. WebServices (SOAP, \r\nWSDL, SaaS, IaaS e PaaS). Arquitetura REST e sistemas RESTful. Desenvolvimento de backend.  GraphQL. Tecnologia Docker.', 60, NULL),
(152, 'DESENVOLVIMENTO DE JOGOS', 'Apresentação do histórico, categorias e plataformas de jogos digitais. Análise do \r\nmercado de jogos digitais no Brasil e no mundo. Descrição do processo de desenvolvimento \r\nde jogos digitais. Estudo de arquiteturas para motores de jogos (engines). Estudo de \r\nelementos de design para jogos digitais. Análise de ferramentas utilizadas no \r\ndesenvolvimento de jogos digitais. Apresentação de um framework para o desenvolvimento \r\nde jogos digitais. Discussão de algoritmos e estruturas de dados para jogos digitais. Projeto \r\ne implementação de um protótipo de jogo digital.', 60, NULL),
(153, 'DESENVOLVIMENTO MOBILE', 'Introdução ao desenvolvimento de softwares para dispositivos móveis. \r\nArquitetura do framework. Interface do usuário. Controlador, eventos e interatividade. Persistência de dados. Uso de recursos dos aparelhos portáteis. Networking e acesso à serviços na nuvem. Depuração. Publicar a aplicação nas lojas de aplicativos.', 60, NULL),
(154, 'GOVERNANÇA E TECNOLOGIA DA INFORMAÇÃO', 'Fundamentos de governança de tecnologia da informação. Normas e modelos de \r\nsuporte à governança. Melhores práticas de gestão de sistemas de informação e serviços de \r\nTI. Ferramentas, técnicas e processos da Governança de TI. Projeto de Governança em TI', 60, NULL),
(155, 'INTELIGÊNCIA ARTIFICIAL', 'Introdução, histórico e estado da arte em Inteligência Artificial. Resolução de \r\nproblemas e buscas. Conhecimento e raciocínio. Sistemas Especialistas. Projetos de IA e ferramentas voltadas para IA. Representação do conhecimento. Sistemas Conexionistas: Redes Neurais Artificiais, Sistemas Fuzzy e Algoritmos Genéticos.', 60, NULL);

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
  MODIFY `id_bibliografia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id_curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `disciplinas`
--
ALTER TABLE `disciplinas`
  MODIFY `id_disciplina` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;

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
