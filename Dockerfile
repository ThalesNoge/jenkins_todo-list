# 1. Use uma imagem base moderna do Python
FROM python:3.10-slim

# 2. Defina o diretório de trabalho dentro do contêiner
WORKDIR /usr/src/app

# 3. Instale as dependências de sistema necessárias para compilar pacotes
RUN apt-get update && apt-get install -y gcc default-libmysqlclient-dev pkg-config && rm -rf /var/lib/apt/lists/*

# 4. Copie o arquivo de dependências primeiro (para otimizar o cache do Docker)
COPY requirements.txt ./

# 5. Instale as dependências do Python
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copie o resto do código da sua aplicação
COPY . .

# 7. Exponha a porta que a aplicação vai usar
EXPOSE 8000

# 8. Comando para iniciar a aplicação (para desenvolvimento)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
