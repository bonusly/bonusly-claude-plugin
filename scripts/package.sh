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

# Stage into a clean temp dir so the zip has a predictable top-level directory
STAGING=$(mktemp -d)
trap 'rm -rf "$STAGING"' EXIT

PLUGIN_DIR="$STAGING/$PLUGIN_NAME"
mkdir -p "$PLUGIN_DIR"

# plugin.json goes at the root of the plugin directory
cp "$PLUGIN_JSON" "$PLUGIN_DIR/plugin.json"

# Copy the skills directory tree (only SKILL.md files, no hidden files)
if [ -d "$REPO_ROOT/skills" ]; then
  find "$REPO_ROOT/skills" -name 'SKILL.md' | while read -r skill_file; do
    rel="${skill_file#$REPO_ROOT/}"
    dest="$PLUGIN_DIR/$rel"
    mkdir -p "$(dirname "$dest")"
    cp "$skill_file" "$dest"
  done
fi

# Build the zip from the staging directory
(cd "$STAGING" && zip -r "$ZIP_PATH" "$PLUGIN_NAME" --quiet)

echo "Built: $ZIP_PATH"
echo ""
echo "Contents:"
unzip -l "$ZIP_PATH" | grep -v "^Archive\|^--\|files$"
