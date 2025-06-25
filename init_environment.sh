#!/bin/bash
# Check for common tools and prepare environment

TOOLS=(openssl git pandoc python3)

echo "Checking environment readiness..."

for tool in "${TOOLS[@]}"; do
  if ! command -v "$tool" &> /dev/null; then
    echo "❌ $tool not found"
  else
    echo "✅ $tool is installed"
  fi
done

mkdir -p files logs
echo "Directories initialized: files/, logs/"
