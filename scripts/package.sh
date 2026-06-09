#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PLUGIN_JSON="$REPO_ROOT/.claude-plugin/plugin.json"

# Read name and version from plugin.json
PLUGIN_NAME=$(python3 -c "import json,sys; d=json.load(open('$PLUGIN_JSON')); print(d['name'])")
PLUGIN_VERSION=$(python3 -c "import json,sys; d=json.load(open('$PLUGIN_JSON')); print(d['version'])")

DIST_DIR="$REPO_ROOT/dist"
ZIP_NAME="${PLUGIN_NAME}-${PLUGIN_VERSION}.zip"
ZIP_PATH="$DIST_DIR/$ZIP_NAME"

mkdir -p "$DIST_DIR"

STAGING=$(mktemp -d)
trap 'rm -rf "$STAGING"' EXIT

# plugin.json must be at .claude-plugin/plugin.json
mkdir -p "$STAGING/.claude-plugin"
cp "$PLUGIN_JSON" "$STAGING/.claude-plugin/plugin.json"

cp "$REPO_ROOT/README.md" "$STAGING/README.md"

# Copy skill files, preserving their skills/<name>/SKILL.md paths
if [ -d "$REPO_ROOT/skills" ]; then
  find "$REPO_ROOT/skills" -name 'SKILL.md' | while read -r skill_file; do
    rel="${skill_file#$REPO_ROOT/}"
    dest="$STAGING/$rel"
    mkdir -p "$(dirname "$dest")"
    cp "$skill_file" "$dest"
  done
fi

# Build the zip with files only — no directory entries
rm -f "$ZIP_PATH"
(cd "$STAGING" && find . -type f | zip "$ZIP_PATH" -@ --quiet)

echo "Built: $ZIP_PATH"
echo ""
echo "Contents:"
unzip -l "$ZIP_PATH" | grep -v "^Archive\|^--\|files$"
