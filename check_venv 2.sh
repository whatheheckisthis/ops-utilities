#!/bin/bash
# Check if Python virtual environment is active

if [[ "$VIRTUAL_ENV" != "" ]]; then
  echo "Virtual environment is active: $VIRTUAL_ENV"
else
  echo "No virtual environment detected"
fi
