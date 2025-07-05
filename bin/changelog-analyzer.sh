#!/usr/bin/env bash
#
# move_to_legacy.sh <filename>
#
# Moves a single file to bin/legacy/ with Git tracking.

set -e

# Check if filename is provided
if [ -z "$1" ]; then
  echo "Usage: bash move_to_legacy.sh <filename>"
  exit 1
fi

FILE="$1"
DEST="bin/legacy"

CHANGELOG_FILE="CHANGELOG.md"

if [ ! -f "$CHANGELOG_FILE" ]; then
    echo "CHANGELOG.md not found in current directory."
    exit 1
fi

echo "== CHANGELOG SUMMARY =="
echo

awk '
BEGIN { RS = ""; version = "" }
/^## \[.*\]/ {
    split($1, v, "[\[\]]")
    version = v[2]
    print "Version: " version
    print "----------------------"
    print $0
    print ""
}
' "$CHANGELOG_FILE" > changelog_summary.txt

echo "Summary written to changelog_summary.txt"

# Optional cleanup: remove empty entries or normalize formatting
# You can uncomment and adjust this line as needed:
# sed -i '/^## \[.*\]/,/^$/!d' "$CHANGELOG_FILE"
