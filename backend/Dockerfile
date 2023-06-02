# Use a imagem oficial do Python como base
FROM python:latest

# Define o diretório de trabalho no contêiner
WORKDIR /app

# Copia o arquivo de requisitos e os arquivos do projeto para o contêiner
COPY backend/requirements.txt .
COPY backend/app.py .
COPY frontend/public /app/static
COPY frontend/src /app/templates

# Atualiza o pip e instala as dependências
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Executa o aplicativo quando o contêiner é iniciado
CMD ["python", "app.py"]
