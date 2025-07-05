#!/usr/bin/env bash
#
# archive_legacy.sh
#
# Purpose:
#   Move obsolete, duplicated, or legacy files into bin/legacy
#   folder to declutter the main project structure.
#
# Usage:
#   bash archive_legacy.sh
#
# Requirements:
#   - Run from the root of the repository
#   - Git must be initialized (moves are tracked)

set -e

LEGACY_DIR="bin/legacy"

# Ensure legacy folder exists
mkdir -p "$LEGACY_DIR"

# List of known legacy files
legacy_files=(
  "init_environment.sh"
  "import_check.py"
  # Add other filenames here as needed
)

echo "Archiving legacy files..."

for file in "${legacy_files[@]}"; do
  if [ -f "$file" ]; then
    echo "Moving $file → $LEGACY_DIR/"
    git mv "$file" "$LEGACY_DIR/"
  else
    echo "Skipping $file (not found)"
  fi
done

echo "✅ Archiving complete. Review bin/legacy/ for moved files."
