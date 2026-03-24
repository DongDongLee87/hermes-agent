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
                ENV HERMES_HOME="/data/.hermes"

                RUN mkdir -p /data/.hermes

                CMD ["sh", "-c", "mkdir -p /data/.hermes && printf 'OPENROUTER_API_KEY=%s\nTELEGRAM_BOT_TOKEN=%s\nTELEGRAM_ALLOWED_USERS=%s\nHERMES_MODEL=%s\n' \"$OPENROUTER_API_KEY\" \"$TELEGRAM_BOT_TOKEN\" \"$TELEGRAM_ALLOWED_USERS\" \"${HERMES_MODEL:-anthropic/claude-haiku-4-5}\" > /data/.hermes/.env && hermes gateway"]
                
