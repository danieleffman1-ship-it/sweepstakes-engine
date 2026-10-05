#!/bin/bash
set -e

echo "🚀 Starting background services (PostgreSQL & Redis)..."

# Ensure Postgres service is running
sudo service postgresql start || true

# Set default password for postgres superuser and create sweepstakes database
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"
sudo -u postgres psql -c "CREATE DATABASE sweepstakes_engine;" || true

# Ensure Redis service is running
sudo service redis-server start || true

echo "📦 Initializing Node.js project dependencies..."
if [ -f "package.json" ]; then
  npm install
else
  npm init -y
  npm install fastify pg dotenv zod cors
  npm install -D typescript @types/node tsx
  npx tsc --init
fi

echo "✅ Cloud environment ready! You can now start coding directly from your mobile device."
