#!/bin/bash
set -euo pipefail

# setup_agent.sh
# Automated setup script for Awesome ChatGPT Prompts (prompts.chat)

echo "🤖 Agent: Starting automated setup for prompts.chat..."

# 1. Check for Prerequisites
echo "🔍 Agent: Checking prerequisites..."
if ! command -v git &> /dev/null; then
    echo "❌ git is not installed. Please install git first."
    exit 1
fi

if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install Node.js (v18+) first."
    exit 1
fi

# 2. Clone the Repository
REPO_DIR="awesome-chatgpt-prompts"
if [ -d "$REPO_DIR" ]; then
    echo "📂 Agent: Directory '$REPO_DIR' already exists. Entering directory..."
    cd "$REPO_DIR" || { echo "❌ Failed to enter directory"; exit 1; }
else
    echo "📥 Agent: Cloning repository..."
    git clone https://github.com/f/awesome-chatgpt-prompts.git "$REPO_DIR" || { echo "❌ Failed to clone repository"; exit 1; }
    cd "$REPO_DIR" || { echo "❌ Failed to enter directory"; exit 1; }
fi

# 3. Setup Environment Variables
if [ ! -f ".env" ]; then
    echo "⚙️ Agent: Creating .env file from .env.example..."
    if [ -f ".env.example" ]; then
        cp .env.example .env
        echo "✅ Agent: .env file created."
        echo "⚠️  IMPORTANT: You will need to edit .env later to add your specific Database URL and Auth Secrets."
    else
        echo "⚠️  Agent: .env.example not found. Skipping .env creation."
    fi
else
    echo "ℹ️  Agent: .env file already exists. Skipping creation."
fi

# 4. Install Dependencies
echo "📦 Agent: Installing dependencies (this may take a minute)..."
npm install || { echo "❌ Failed to install dependencies"; exit 1; }

# 5. Run the Interactive Setup Wizard
echo "🚀 Agent: Launching the project setup wizard..."
echo "👉 Follow the on-screen instructions below:"
echo "---------------------------------------------------"
npm run setup || { echo "❌ Setup wizard failed"; exit 1; }
