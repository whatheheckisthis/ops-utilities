#!/bin/bash

# init_dev_env.sh - One-click Dev Environment Setup Script

echo "🔧 Initializing Development Environment Setup..."

# Update and upgrade system packages
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install common development tools
echo "Installing essential packages..."
sudo apt install -y git curl wget unzip vim build-essential python3 python3-pip python3-venv

# Create and activate Python virtual environment
echo "Setting up Python virtual environment..."
mkdir -p ~/dev_env
cd ~/dev_env
python3 -m venv venv

echo "To activate your virtual environment, run:"
echo "source ~/dev_env/venv/bin/activate"

# Optional: Install default Python packages
echo "Installing helpful Python packages..."
source ~/dev_env/venv/bin/activate
pip install --upgrade pip
pip install requests flask fastapi uvicorn rich black

echo "✅ Development environment is ready."
