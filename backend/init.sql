-- init.sql

-- Criação da tabela "cursos"
CREATE TABLE IF NOT EXISTS public.curso (
    codigo SERIAL PRIMARY KEY,
    descricao VARCHAR(50),
    ementa TEXT
);

-- Criação da tabela "aluno"
CREATE TABLE IF NOT EXISTS public.aluno (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(50)
);

-- Criação da tabela "curso_aluno"
CREATE TABLE IF NOT EXISTS public.curso_aluno (
    codigo SERIAL PRIMARY KEY,
    codigo_aluno INTEGER NOT NULL,
    codigo_curso INTEGER NOT NULL,
    FOREIGN KEY (codigo_aluno) REFERENCES aluno (codigo),
    FOREIGN KEY (codigo_curso) REFERENCES curso (codigo),
    UNIQUE (codigo_aluno, codigo_curso) -- Restrição para garantir que um aluno não entre no mesmo curso mais de uma vez
);

CREATE EXTENSION IF NOT EXISTS unaccent;

-- Preenche a tabela curso com dados
INSERT INTO curso (descricao, ementa) VALUES
    ('Introdução à Programação em Go', '- Sintaxe básica da linguagem Go - Estruturas de controle (if, for, switch) - Funções e pacotes - Manipulação de strings e arrays - Trabalhando com ponteiros'),
    ('Desenvolvimento Web com Go e Gin', '- Configuração de um servidor web usando o framework Gin - Roteamento de requisições HTTP - Manipulação de formulários - Conexão com banco de dados PostgreSQL - Autenticação e autorização'),
    ('APIs RESTful em Go', '- Conceitos de APIs RESTful - Criação de endpoints RESTful em Go - Serialização e desserialização de dados JSON - Autenticação de API - Testes de API'),
    ('Programação Concorrente em Go', '- Goroutines e Channels - Mutexes e Semáforos - Wait Groups - Select Statement'),
    ('Desenvolvimento de Aplicações CLI em Go', '- Leitura de argumentos da linha de comando - Manipulação de arquivos e diretórios - Formatação de saída'),
    ('Testes de Unidade e Integração em Go', '- Testes de unidade com o pacote "testing" - Testes de integração com banco de dados - Subtests e Table-Driven Tests'),
    ('Microservices com Go e gRPC', '- Introdução a arquitetura de microservices - Comunicação entre serviços usando gRPC - Implementação de endpoints gRPC em Go'),
    ('Desenvolvimento de Aplicações Web com Go e Vue.js', '- Construção de uma API com Go - Integração com Vue.js para o frontend - Roteamento e gerenciamento de estado no Vue.js');

-- Preenche a tabela aluno com dados
INSERT INTO aluno (nome) VALUES
    ('João da Silva'),
    ('Maria Oliveira'),
    ('Carlos Souza'),
    ('Ana Rodrigues'),
    ('Pedro Santos'),
    ('Lucia Lima'),
    ('Fernando Pereira'),
    ('Julia Oliveira'),
    ('Rafael Martins'),
    ('Larissa Costa'),
    ('JOÃO PAULO MANTOVANI');   

-- Inserção de dados na tabela curso_aluno (limitado a 3 cursos por aluno e 10 alunos por curso)
WITH AlunosNumerados AS (
    SELECT
        a.codigo AS codigo_aluno,
        c.codigo AS codigo_curso,
        ROW_NUMBER() OVER (PARTITION BY a.codigo ORDER BY RANDOM()) AS ordem
    FROM
        aluno a
    JOIN
        curso c ON 1 = 1
)
INSERT INTO curso_aluno (codigo_aluno, codigo_curso)
SELECT
    codigo_aluno,
    codigo_curso
FROM
    AlunosNumerados
WHERE
    ordem <= 3 -- Limite de 3 cursos por aluno
AND codigo_curso IN (SELECT codigo FROM curso WHERE (SELECT COUNT(*) FROM curso_aluno WHERE codigo_curso = curso.codigo) < 10); -- Limite de 10 alunos por curso
