Projeto de Teste Prático - Golang/Flutter
Este projeto é um teste prático para avaliar as habilidades de programação em Golang e Flutter. O backend foi desenvolvido utilizando o framework Gin para o servidor, Swaggo para a documentação e PostgreSQL como banco de dados. Já o frontend foi implementado em Flutter, utilizando MobX para gerenciamento de estado, Dio para consumo de API, e Clean Architecture em ambas as partes.

Backend
Requisitos
Docker
Docker Compose
Golang
Instruções para execução
Navegue até o diretório backend.
bash
Copy code
cd backend
Execute o seguinte comando para construir e iniciar o servidor utilizando o Docker Compose.
bash
Copy code
docker-compose up --build
Isso iniciará o backend, configurando o banco de dados PostgreSQL e expondo os endpoints através do framework Gin.

Documentação da API
A documentação da API pode ser acessada através do Swagger. Após iniciar o servidor, acesse:

http://localhost:8080/swagger/index.html

Rotas
GET /course/list: Lista todos os cursos disponíveis.
POST /course/create: Cria um novo curso.
POST /course/add-student: Adiciona um aluno a um curso.
PUT /course/update: Atualiza informações de um curso.
GET /course/list-student: Lista todos os alunos de um curso.
GET /student/list: Lista todos os alunos cadastrados.
POST /student/create: Cria um novo aluno.
PUT /student/update: Atualiza informações de um aluno.
As rotas do backend estão disponíveis na porta 3000.

Frontend
Requisitos
Flutter
Visual Studio Code (ou IDE de sua escolha)
Instruções para execução
Navegue até o diretório frontend/workspace.
bash
Copy code
cd frontend/workspace
Abra o arquivo main.dart em sua IDE.

Pressione F5 para iniciar a aplicação Flutter.

Isso iniciará o frontend, onde você poderá interagir com a aplicação desenvolvida. O MobX será responsável pelo gerenciamento de estado, e o Dio será utilizado para consumir a API do backend.

Clean Architecture
O projeto foi estruturado seguindo os princípios da Clean Architecture tanto no backend quanto no frontend. Isso proporciona uma separação clara de responsabilidades, facilitando a manutenção e testabilidade do código.

Observação: Certifique-se de que todos os requisitos estão instalados corretamente antes de executar o projeto. Boa sorte no teste prático!