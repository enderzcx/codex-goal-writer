# Valid Goal Example

```text
/goal Ship the package validation command so contributors can verify changes before handoff.

Verification:
- npm test
- npm run lint

Constraints:
- Do not change runtime behavior outside package validation.
- Do not publish or push unless the user explicitly asks.

Boundaries:
Allowed writes:
- package.json
- scripts/**
- tests/**
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
- The validation command passes and the final response lists files changed and commands run.

Pause if:
- A GitHub publish, production write, credential, or business decision is needed.
```
