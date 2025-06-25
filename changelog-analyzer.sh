#!/bin/bash

# changelog_analyzer.sh - Analyze and clean up a CHANGELOG.md file

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
