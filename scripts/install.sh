#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$ROOT/skills/goal-writer"
TARGET="${AGENTS_SKILLS_DIR:-$HOME/.agents/skills}/goal-writer"

if [[ ! -f "$SOURCE/SKILL.md" ]]; then
  echo "Missing source skill: $SOURCE" >&2
  exit 1
fi

mkdir -p "$TARGET"
cp -R "$SOURCE"/. "$TARGET"/

echo "Installed goal-writer skill to $TARGET"
echo "Add AGENTS_SNIPPET.md to AGENTS.md if you want automatic goal prompt routing."
