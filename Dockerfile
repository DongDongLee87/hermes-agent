FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git curl build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN pip install uv

COPY . .

RUN uv venv venv --python 3.11 && \
    . venv/bin/activate && \
    uv pip install -e ".[all]"

ENV PATH="/app/venv/bin:$PATH"
ENV HERMES_DATA_DIR="/data"
ENV HERMES_HOME="/data"

RUN mkdir -p /data

# 啟動腳本
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
