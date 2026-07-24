#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$ROOT/skills/goal-writer"
TARGET="${AGENTS_SKILLS_DIR:-$HOME/.agents/skills}/goal-writer"

if [[ ! -f "$SOURCE/SKILL.md" ]]; then
  echo "Missing source skill: $SOURCE" >&2
  exit 1
fi

case "$TARGET" in
  */goal-writer) ;;
  *)
    echo "Refusing unexpected install target: $TARGET" >&2
    exit 1
    ;;
esac

rm -rf "$TARGET"
mkdir -p "$TARGET"
cp -R "$SOURCE"/. "$TARGET"/

echo "Installed goal-writer skill to $TARGET"
