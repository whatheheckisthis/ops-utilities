#!/bin/bash

# Auto-generate CHANGELOG.md based on Git commit history

# Default changelog file
CHANGELOG_FILE="AUTO_CHANGELOG.md"

# Get latest tag (if any)
LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null)

# Header
echo "# Changelog" > $CHANGELOG_FILE
echo "" >> $CHANGELOG_FILE

# Fallback if no tags are present
if [ -z "$LATEST_TAG" ]; then
    echo "No tags found. Using full commit history."
    git log --pretty=format:"- %s (%h)" >> $CHANGELOG_FILE
else
    echo "Generating changelog since tag: $LATEST_TAG"
    echo "## [Unreleased] - $(date +%Y-%m-%d)" >> $CHANGELOG_FILE
    echo "" >> $CHANGELOG_FILE
    git log "$LATEST_TAG"..HEAD --pretty=format:"- %s (%h)" >> $CHANGELOG_FILE
    echo "" >> $CHANGELOG_FILE
    echo "## [$LATEST_TAG] - Previous Release" >> $CHANGELOG_FILE
    echo "" >> $CHANGELOG_FILE
    git log --pretty=format:"- %s (%h)" "$LATEST_TAG"^.."$LATEST_TAG" >> $CHANGELOG_FILE
fi

echo "Changelog generated in $CHANGELOG_FILE"
