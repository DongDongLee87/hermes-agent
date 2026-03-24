#!/bin/bash
set -e

mkdir -p /data

# 寫入基本設定
cat > /data/config.yaml << EOF
gateway:
  telegram:
    bot_token: "${TELEGRAM_BOT_TOKEN}"
    allowed_users: [${TELEGRAM_ALLOWED_USERS}]
llm:
  provider: openrouter
  model: "${HERMES_MODEL:-anthropic/claude-haiku-4-5}"
EOF

# 寫入環境變數
cat > /data/.env << EOF
OPENROUTER_API_KEY=${OPENROUTER_API_KEY}
TELEGRAM_BOT_TOKEN=${TELEGRAM_BOT_TOKEN}
TELEGRAM_ALLOWED_USERS=${TELEGRAM_ALLOWED_USERS}
HERMES_MODEL=${HERMES_MODEL}
EOF

echo "Starting Hermes gateway..."
exec hermes gateway
