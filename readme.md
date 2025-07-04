# Imersão DevOps - Alura Google Cloud

Este projeto é uma API desenvolvida com FastAPI para gerenciar alunos, cursos e matrículas em uma instituição de ensino. (Modificado com anotações pessoais minhas no dia 03/07/2025)

## Pré-requisitos

- [Python 3.10 ou superior instalado](https://www.python.org/downloads/)
- [Git](https://git-scm.com/downloads)
- [Docker](https://www.docker.com/get-started/)

## Passos para subir o projeto

1. **Faça o download do repositório:**
   [Clique aqui para realizar o download](https://github.com/guilhermeonrails/imersao-devops/archive/refs/heads/main.zip)

2. **Crie um ambiente virtual:**
   ```sh
   python3 -m venv ./venv
   ```

3. **Ative o ambiente virtual:**
   - No Linux/Mac:
     ```sh
     source venv/bin/activate
     ```
   - No Windows, abra um terminal no modo administrador e execute o comando:
   ```sh
   Set-ExecutionPolicy RemoteSigned
   ```

     ```sh
     venv\Scripts\activate
     ```

4. **Instale as dependências:**
   ```sh
   pip install -r requirements.txt
   ```

5. **Execute a aplicação:**
   ```sh
   uvicorn app:app --reload
   ```

6. **Acesse a documentação interativa:**

   Abra o navegador e acesse:  
   [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)

   Aqui você pode testar todos os endpoints da API de forma interativa.

7. **Crie o arquivo .dockerignore para otimizar a imagem Docker**

   - No diretório raiz do projeto, crie um arquivo chamado `.dockerignore`.
   - Adicione as linhas abaixo para evitar que arquivos e pastas desnecessárias sejam copiadas para a imagem Docker:

     ```
     venv/
     __pycache__/
     *.pyc
     *.pyo
     *.pyd
     .Python
     .git
     .gitignore
     escola.db
     *.sqlite3
     *.log
     ```

   - Salve o arquivo.

   **Ordem recomendada de criação:**
   1. Crie o arquivo `.dockerignore` primeiro, para garantir que arquivos desnecessários não sejam incluídos na imagem.
   2. Em seguida, crie o arquivo `Dockerfile` conforme o passo anterior.

   Dessa forma, ao construir a imagem Docker, apenas os arquivos essenciais do projeto serão copiados, tornando a imagem mais leve e segura.

8. **Crie o arquivo Dockerfile e configure o container da aplicação**

   - No diretório raiz do projeto, crie um arquivo chamado `Dockerfile` (sem extensão).
   - Adicione as instruções abaixo para criar a imagem Docker da sua aplicação:

     ```dockerfile
     # Use uma imagem oficial do Python como base
     FROM python:3.10

     # Defina o diretório de trabalho dentro do container
     WORKDIR /app

     # Copie os arquivos do projeto para o container
     COPY . .

     # Instale as dependências
     RUN pip install --no-cache-dir -r requirements.txt

     # Exponha a porta utilizada pela aplicação
     EXPOSE 8000

     # Comando para iniciar a aplicação
     CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--reload"]
     ```

   - Salve o arquivo.

   Agora você pode construir a imagem Docker com o comando:
   ```sh
   docker build -t nome-da-sua-imagem .
   ```

   E executar o container:
   ```sh
   docker run -p 8000:8000 nome-da-sua-imagem

---

## ***Utilizando o Docker Compose

O arquivo `docker-composer.yml` foi criado para facilitar a execução da aplicação e de serviços auxiliares (como banco de dados) usando containers Docker.

### O que foi feito no arquivo

- **build:** Constrói a imagem Docker a partir do `Dockerfile` do projeto.
- **container_name:** Define um nome fixo para o container da aplicação, facilitando sua identificação.
- **ports:** Mapeia a porta 8000 do container para a porta 8000 do seu computador, permitindo acessar a API em `http://localhost:8000`.
- **volumes:** Sincroniza o diretório do projeto no host com o diretório `/app` do container, permitindo hot reload durante o desenvolvimento.
- **command:** Inicia o servidor FastAPI com recarregamento automático sempre que houver mudanças no código.

### Como executar com Docker Compose

1. Certifique-se de que o Docker está instalado e em execução.
2. No terminal, navegue até o diretório do projeto.
3. Execute o comando abaixo para subir a aplicação:

   ```sh
   docker compose -f docker-composer.yml up
   ```

   > Caso esteja usando uma versão mais antiga do Docker Compose, use:
   > 
   > ```sh
   > docker-compose -f docker-composer.yml up
   > ```

4. Acesse a aplicação em [http://localhost:8000](http://localhost:8000).

---

### Observações

- Para parar a aplicação, pressione `Ctrl+C` no terminal ou execute:
  ```sh
  docker compose -f docker-composer.yml down
  ```
- O uso do Docker Compose facilita a expansão do projeto, permitindo adicionar facilmente outros serviços, como bancos de dados ou cache, no futuro.

## Estrutura do Projeto

- `app.py`: Arquivo principal da aplicação FastAPI.
- `models.py`: Modelos do banco de dados (SQLAlchemy).
- `schemas.py`: Schemas de validação (Pydantic).
- `database.py`: Configuração do banco de dados SQLite.
- `routers/`: Diretório com os arquivos de rotas (alunos, cursos, matrículas).
- `requirements.txt`: Lista de dependências do projeto.

---

- O banco de dados SQLite será criado automaticamente como `escola.db` na primeira execução.
- Para reiniciar o banco, basta apagar o arquivo `escola.db` (isso apagará todos os dados).

---
