#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$ROOT/skills/goal-writer"
TARGET_ROOT="${AGENTS_SKILLS_DIR:-$HOME/.agents/skills}"
DRY_RUN=0
FORCE=0

usage() {
  cat <<'EOF'
Usage: bash scripts/install.sh [options]

Options:
  --dry-run      Print the planned install target without copying files.
  --repo-local   Install into .agents/skills under the current git repo.
  --force        Replace an existing goal-writer skill directory.
  -h, --help     Show this help text.

Environment:
  AGENTS_SKILLS_DIR  Override the parent skills directory.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --repo-local)
      REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
      TARGET_ROOT="$REPO_ROOT/.agents/skills"
      shift
      ;;
    --force)
      FORCE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

TARGET="$TARGET_ROOT/goal-writer"

if [[ ! -f "$SOURCE/SKILL.md" ]]; then
  echo "Missing source skill: $SOURCE" >&2
  exit 1
fi

if [[ "$DRY_RUN" == "1" ]]; then
  echo "Would install goal-writer skill from $SOURCE to $TARGET"
  exit 0
fi

if [[ -e "$TARGET" && "$FORCE" != "1" ]]; then
  echo "Target already exists: $TARGET" >&2
  echo "Use --force to replace it, or choose a different AGENTS_SKILLS_DIR." >&2
  exit 1
fi

if [[ -e "$TARGET" ]]; then
  rm -rf "$TARGET"
fi

mkdir -p "$TARGET"
cp -R "$SOURCE"/. "$TARGET"/

echo "Installed goal-writer skill to $TARGET"
echo "Use \$goal-writer explicitly, or add AGENTS_SNIPPET.md to AGENTS.md for routing."
