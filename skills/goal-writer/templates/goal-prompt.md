# Goal Prompt

```text
/goal <Outcome: final world state, not activity>.

Verification:
- <command, artifact, screenshot, report, or external read-only proof>

Constraints:
- <behavior, API, data, safety, compatibility, or business rule that must not change>

Boundaries:
Allowed writes:
- <absolute or repo-relative path>
Do not edit:
- <paths, systems, credentials, production, deploys, external messages>

Iteration policy:
- Make one focused change at a time.
- Run the smallest relevant check after each meaningful change.
- Keep GOAL_CHECKLIST.md or GOAL_PROGRESS.md updated when the task spans multiple loops.
- Do not repeat an identical failed approach.

Stop when:
- <evidence proves completion>

Pause if:
- <credentials, production write, business decision, repeated failure, no measurable progress, or risky external action is needed>
```
