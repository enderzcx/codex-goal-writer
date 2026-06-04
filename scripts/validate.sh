#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

require_file() {
  local path="$1"
  if [[ ! -f "$path" ]]; then
    echo "missing required file: $path" >&2
    exit 1
  fi
}

require_file "$ROOT/skills/goal-writer/SKILL.md"
require_file "$ROOT/skills/goal-writer/references/goal-quality-standard.md"
require_file "$ROOT/skills/goal-writer/references/templates.md"
require_file "$ROOT/skills/goal-writer/references/eval-scenarios.md"
require_file "$ROOT/skills/goal-writer/agents/openai.yaml"

ruby -ryaml -e '
  skill = ARGV[0]
  text = File.read(skill)
  abort("missing frontmatter") unless text.start_with?("---\n")
  yaml = text.split("---\n", 3)[1]
  data = YAML.safe_load(yaml)
  abort("missing name") unless data["name"]
  abort("missing description") unless data["description"]
' "$ROOT/skills/goal-writer/SKILL.md"

ruby -ryaml -e '
  data = YAML.safe_load(File.read(ARGV[0]))
  policy = data.fetch("policy", {})
  unless policy["allow_implicit_invocation"] == false
    abort("goal-writer should require explicit invocation or AGENTS.md routing")
  end
' "$ROOT/skills/goal-writer/agents/openai.yaml"

ruby -e '
  skill = File.read(ARGV[0])
  required = [
    "Long Goal Handling",
    "Ask at most 1-3 concise questions",
    "Do not exceed the Codex /goal objective length"
  ]
  required.each do |needle|
    abort("missing SKILL.md guidance: #{needle}") unless skill.include?(needle)
  end
' "$ROOT/skills/goal-writer/SKILL.md"

ruby -e '
  evals = File.read(ARGV[0])
  required = [
    "Vague software delivery",
    "High-risk external write",
    "Too-large roadmap",
    "Missing verification surface"
  ]
  required.each do |needle|
    abort("missing eval scenario: #{needle}") unless evals.include?(needle)
  end
' "$ROOT/skills/goal-writer/references/eval-scenarios.md"

grep -q -- "--dry-run" "$ROOT/scripts/install.sh"
grep -q -- "--repo-local" "$ROOT/scripts/install.sh"
grep -q "long goal" "$ROOT/AGENTS_SNIPPET.md"

echo "goal-writer skill OK"
