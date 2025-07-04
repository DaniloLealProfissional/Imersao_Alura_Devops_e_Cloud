# Use uma imagem oficial do Python como base
FROM python:3.11-slim

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos de dependências (caso exista requirements.txt)
COPY requirements.txt ./

# Instala as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante dos arquivos da aplicação
COPY . .

# Expõe a porta que o app irá rodar (ajuste conforme necessário)
EXPOSE 8000

# Comando para rodar o app (ajuste conforme o framework utilizado)
CMD ["uvicorn", "app:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]