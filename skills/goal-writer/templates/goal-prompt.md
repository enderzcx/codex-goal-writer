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
- If CWF is used, treat each CWF run as one bounded execution episode and require `goal_delta` before deciding whether to continue.
- Do not repeat an identical failed approach.

CWF episode policy:
- Use CWF only when fan-out, clean contexts, adversarial verification, safe-fix-loop, background/resume, or workflow state is actually needed.
- After each CWF episode, report `goal_delta` with `run_id`, `completed`, `evidence_added`, `blockers`, `next_slice`, `next_cwf_run`, `continue_or_stop`, and `progress_artifact_update`.

Stop when:
- <evidence proves completion>

Pause if:
- <credentials, production write, business decision, repeated failure, no measurable progress, or risky external action is needed>
```
