#!/bin/bash
set -e

mkdir -p /data
mkdir -p /data/.hermes

export HERMES_HOME=/data/.hermes

# 寫入環境變數檔
cat > /data/.hermes/.env << EOF
OPENROUTER_API_KEY=${OPENROUTER_API_KEY}
TELEGRAM_BOT_TOKEN=${TELEGRAM_BOT_TOKEN}
TELEGRAM_ALLOWED_USERS=${TELEGRAM_ALLOWED_USERS}
HERMES_MODEL=${HERMES_MODEL:-anthropic/claude-haiku-4-5}
LLM_MODEL=${LLM_MODEL:-anthropic/claude-haiku-4-5}
EOF

echo "Starting Hermes gateway..."
exec hermes gateway --telegram
