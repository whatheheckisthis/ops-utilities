#!/usr/bin/env bash
#
# archive_unplaced.sh
#
# Purpose:
#   Detects any .sh or .py files in the repo root that are not in designated
#   subdirectories, and moves them into bin/legacy/ for review.
#
# Usage:
#   chmod +x archive_unplaced.sh
#   bash archive_unplaced.sh
#
# Requirements:
#   - Run from repository root
#   - Git must track moves

set -e

# Directories to exclude
EXCLUDES=("ci" "scripts" "config" "docs" "tests" "examples" "bin" ".github")

DEST="bin/legacy"
mkdir -p "$DEST"

echo "Scanning for unplaced .sh/.py files..."

# Find all .sh/.py in current directory (excluding hidden)  
for file in *.sh *.py; do
  if [ ! -f "$file" ]; then
    continue
  fi

  # Check if file is within an excluded directory
  skip=false
  for dir in "${EXCLUDES[@]}"; do
    if [[ -e "$dir/$file" ]]; then
      skip=true
      break
    fi
  done

  if [ "$skip" = false ]; then
    echo "Archiving: $file → $DEST/"
    git mv "$file" "$DEST/"
  fi
done

echo "Archive complete. Run 'git status' and commit the changes."
