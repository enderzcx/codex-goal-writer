#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test -f "$ROOT/skills/goal-writer/SKILL.md"
test -f "$ROOT/skills/goal-writer/references/goal-quality-standard.md"
test -f "$ROOT/skills/goal-writer/references/templates.md"
test -f "$ROOT/skills/goal-writer/agents/openai.yaml"

ruby -ryaml -e '
  skill = ARGV[0]
  text = File.read(skill)
  abort("missing frontmatter") unless text.start_with?("---\n")
  yaml = text.split("---\n", 3)[1]
  data = YAML.safe_load(yaml)
  abort("missing name") unless data["name"]
  abort("missing description") unless data["description"]
' "$ROOT/skills/goal-writer/SKILL.md"

ruby -ryaml -e 'YAML.safe_load(File.read(ARGV[0]))' "$ROOT/skills/goal-writer/agents/openai.yaml"

echo "goal-writer skill OK"
