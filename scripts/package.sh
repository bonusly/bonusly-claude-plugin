#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PLUGIN_JSON="$REPO_ROOT/.claude-plugin/plugin.json"

PLUGIN_VERSION=$(python3 -c "import json; print(json.load(open('$PLUGIN_JSON'))['version'])")

DIST_DIR="$REPO_ROOT/dist"
mkdir -p "$DIST_DIR"

# Zip files only (no directory entries) from a staging dir, then list contents.
build_zip() {
  local zip_path="$1" staging="$2"
  rm -f "$zip_path"
  (cd "$staging" && find . -type f | zip "$zip_path" -@ --quiet)
  echo "Built: $zip_path"
  echo "Contents:"
  unzip -l "$zip_path" | grep -v "^Archive\|^--\|files$"
  echo ""
}

# Copy skills/<name>/SKILL.md preserving paths into $1.
copy_skills() {
  local staging="$1"
  [ -d "$REPO_ROOT/skills" ] || return 0
  find "$REPO_ROOT/skills" -name 'SKILL.md' | while read -r skill_file; do
    local rel="${skill_file#$REPO_ROOT/}"
    mkdir -p "$(dirname "$staging/$rel")"
    cp "$skill_file" "$staging/$rel"
  done
}

# --- Claude package ---
CLAUDE_STAGING=$(mktemp -d)
trap 'rm -rf "$CLAUDE_STAGING" "${CODEX_STAGING:-}"' EXIT

mkdir -p "$CLAUDE_STAGING/.claude-plugin"
cp "$PLUGIN_JSON" "$CLAUDE_STAGING/.claude-plugin/plugin.json"
cp "$REPO_ROOT/README.md" "$CLAUDE_STAGING/README.md"
copy_skills "$CLAUDE_STAGING"
build_zip "$DIST_DIR/bonusly-claude-${PLUGIN_VERSION}.zip" "$CLAUDE_STAGING"

# --- Codex package ---
CODEX_STAGING=$(mktemp -d)
cp "$REPO_ROOT/.mcp.json" "$CODEX_STAGING/.mcp.json"
cp -R "$REPO_ROOT/.agents" "$CODEX_STAGING/.agents"
cp -R "$REPO_ROOT/.codex-plugin" "$CODEX_STAGING/.codex-plugin"
cp -R "$REPO_ROOT/assets" "$CODEX_STAGING/assets"
copy_skills "$CODEX_STAGING"  # .codex-plugin/plugin.json references ./skills
build_zip "$DIST_DIR/bonusly-codex-${PLUGIN_VERSION}.zip" "$CODEX_STAGING"
