#!/usr/bin/env python3
"""
changelog_analyzer.py

A script to analyze a CHANGELOG file and summarize key changes, categorize entries,
and provide release statistics.

Usage:
    python changelog_analyzer.py [path_to_changelog]

If no path is provided, defaults to ./CHANGELOG.md

Assumptions:
- The changelog follows the Keep a Changelog format (https://keepachangelog.com/en/1.0.0/)
  or similar, with sections for versions and categorized entries (Added, Changed, Fixed, etc.)
"""

import sys
import re
from collections import defaultdict

CHANGELOG_PATH = sys.argv[1] if len(sys.argv) > 1 else "CHANGELOG.md"

# Regex patterns
RE_VERSION = re.compile(r'^##\s*\[?([0-9]+\.[0-9]+\.[0-9]+[^\]]*)\]?\s*-\s*([0-9\-]+)?', re.IGNORECASE)
RE_CATEGORY = re.compile(r'^###?\s*(Added|Changed|Removed|Fixed|Security|Deprecated|Breaking)', re.IGNORECASE)
RE_ITEM = re.compile(r'^\s*[-*]\s+(.*)')

def parse_changelog(path):
    releases = []
    with open(path, encoding="utf-8") as f:
        lines = f.readlines()

    current_release = None
    current_cat = None

    for line in lines:
        version_match = RE_VERSION.match(line)
        cat_match = RE_CATEGORY.match(line)
        item_match = RE_ITEM.match(line)

        if version_match:
            if current_release:
                releases.append(current_release)
            version = version_match.group(1).strip()
            date = version_match.group(2).strip() if version_match.group(2) else "Unreleased"
            current_release = {"version": version, "date": date, "categories": defaultdict(list)}
            current_cat = None
        elif cat_match and current_release:
            current_cat = cat_match.group(1).capitalize()
        elif item_match and current_cat and current_release:
            current_release["categories"][current_cat].append(item_match.group(1).strip())
    if current_release:
        releases.append(current_release)
    return releases

def summarize_release(release):
    summary = f"Version {release['version']} ({release['date']}):"
    total = sum(len(items) for items in release['categories'].values())
    summary += f"\n  Total entries: {total}"
    for cat, items in release['categories'].items():
        summary += f"\n  {cat}: {len(items)}"
    return summary

def main():
    try:
        releases = parse_changelog(CHANGELOG_PATH)
        print(f"\nChangelog Analysis: {CHANGELOG_PATH}")
        print(f"Total releases found: {len(releases)}\n")
        for release in releases:
            print(summarize_release(release))
            print("-" * 40)
    except FileNotFoundError:
        print(f"ERROR: Changelog file not found at {CHANGELOG_PATH}")
    except Exception as e:
        print(f"ERROR: {e}")

if __name__ == "__main__":
    main()
