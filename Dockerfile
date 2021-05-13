# Dockerfile for record-linkage-lab
# Ryosuke Onose <dev@onose.ws>

# LAYER 1
FROM python:3.8.5 as resolve_requirements
WORKDIR /app
RUN pip install --upgrade pip
RUN pip install poetry
COPY pyproject.toml ./
RUN poetry install --no-dev
RUN poetry export -f requirements.txt > requirements.txt

# LAYER 2
FROM python:3.8.5 as install_requirements
ENV PYTHONUNBUFFERED=1
WORKDIR /app
RUN apt-get update && apt-get install -y git
RUN apt-get install -y mecab 
COPY --from=resolve_requirements /app/requirements.txt .
RUN pip install -r requirements.txt
