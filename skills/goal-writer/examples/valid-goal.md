# Valid Goal Example

```text
/goal Ship the local skill checker so Sunny-style skills can be classified and validated before handoff.

Verification:
- python3 scripts/check_sunny_skill.py ~/.agents/skills/sunny-meta-skill

Constraints:
- Do not change unrelated skills.
- Do not publish or push unless the user explicitly asks.

Boundaries:
Allowed writes:
- ~/.agents/skills/sunny-meta-skill/**
Do not edit:
- credentials
- production systems
- unrelated repositories

Iteration policy:
- Make one focused change at a time.
- Run the smallest relevant check after each meaningful change.
- Keep GOAL_CHECKLIST.md or GOAL_PROGRESS.md updated when the task spans multiple loops.
- Do not repeat an identical failed approach.

Stop when:
- The checker passes and the final response lists files changed and commands run.

Pause if:
- A GitHub publish, production write, credential, or business decision is needed.
```
