# Teste Prático Programador Flutter/Golang

Este repositório contém um projeto prático desenvolvido para avaliação de habilidades de programação em Flutter e Golang. O projeto foi estruturado seguindo os princípios da Clean Architecture, proporcionando uma separação clara entre as camadas de aplicação.

## Estrutura do Projeto

### Backend

Na pasta `backend`, encontra-se toda a implementação da API desenvolvida em Golang. Abaixo estão as principais características da implementação:

- **Clean Architecture:** A estrutura do projeto segue os princípios da Clean Architecture, dividindo a aplicação em camadas independentes.

- **PostgreSQL:** O banco de dados utilizado é o PostgreSQL para armazenamento de dados relacionais.

- **Gin:** O framework Gin foi utilizado para roteamento HTTP.

#### Rotas

- `course/list`: Lista todos os cursos disponíveis.
- `course/create`: Cria um novo curso.
- `course/add-student`: Adiciona um aluno a um curso.
- `course/update`: Atualiza informações de um curso.
- `course/list-student`: Lista todos os alunos de um curso.
- `student/list`: Lista todos os alunos cadastrados.
- `student/create`: Cria um novo aluno.
- `student/update`: Atualiza informações de um aluno.

### Frontend

O frontend foi desenvolvido em Flutter, utilizando `flutter_modular` e `mobx` para a gestão de estado. A estrutura do projeto segue os princípios da Clean Architecture.

#### Como Executar

Para rodar o projeto, utilize o Docker Compose na pasta raiz do projeto:

```bash
docker-compose up

Este comando iniciará tanto o backend quanto o frontend, disponibilizando a aplicação completa.

Contribuição
Fique à vontade para abrir issues, enviar pull requests ou contribuir de outras maneiras para melhorar este projeto. Sua contribuição é valiosa!