#!/bin/bash
# Deletes logs older than 7 days

LOG_DIR="./logs"

if [ ! -d "$LOG_DIR" ]; then
  echo "No log directory found at $LOG_DIR"
  exit 1
fi

find "$LOG_DIR" -name "*.log" -type f -mtime +7 -exec rm -v {} \;
