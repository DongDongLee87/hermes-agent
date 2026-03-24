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

RUN mkdir -p /data

CMD ["hermes", "gateway"]
