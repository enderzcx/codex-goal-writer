#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL="$ROOT/skills/goal-writer"

test -f "$SKILL/SKILL.md"
test -f "$SKILL/agents/openai.yaml"
test -f "$SKILL/evals/trigger_cases.json"

for obsolete in references templates scripts examples; do
  if [[ -e "$SKILL/$obsolete" ]]; then
    echo "Obsolete package path remains: $SKILL/$obsolete" >&2
    exit 1
  fi
done

ruby -ryaml -e '
  skill = ARGV[0]
  text = File.read(skill)
  abort("missing frontmatter") unless text.start_with?("---\n")
  yaml = text.split("---\n", 3)[1]
  data = YAML.safe_load(yaml)
  abort("missing name") unless data["name"]
  abort("missing description") unless data["description"]
' "$SKILL/SKILL.md"

ruby -ryaml -e 'YAML.safe_load(File.read(ARGV[0]))' "$SKILL/agents/openai.yaml"
python3 -m json.tool "$SKILL/evals/trigger_cases.json" >/dev/null

echo "goal-writer skill OK"
