# Failure Modes & Troubleshooting

## When To Read This

Read this reference when a `/goal` is looping, finishing too early, consuming budget without progress, touching files outside scope, or producing unsafe side effects.

## 1. `/goal` Not Showing

**Symptoms:** Slash command missing in App/IDE/CLI; command picker shows "No commands".

**Checks:**

```bash
codex --version
codex features list
codex features enable goals
```

**Config:**

```toml
# ~/.codex/config.toml or project-level .codex/config.toml
[features]
goals = true
```

If still missing: restart App/IDE/CLI, confirm config path, check platform-specific issues. Some Windows Desktop builds may lack the UI entry; fall back to CLI.

## 2. Goal Always Fails / Set Fails

**Possible causes:** version mismatch, app-server bug, thread state corruption, oversized objective, attachment issues.

**Steps:**

1. Test with a minimal goal to confirm feature works.
2. Avoid pasting very long text as the objective; keep it concise and put detail in referenced files.
3. Clear current goal, then reset: `/goal clear` then `/goal <new>`.
4. Restart the application.
5. Try CLI if App/IDE has issues.

## 3. Goal Loops Forever

**Common causes:**

- No stop condition in the goal.
- Verification command is flaky or non-deterministic.
- External service keeps failing.
- Dangerous-operation confirmation prompt repeats.
- Context compaction causes the agent to lose track and restart.

**Prevention:**

```text
Pause after 5 focused attempts without measurable improvement.
If a command fails for the same infrastructure reason twice, stop and report.
If confirmation is required for delete/deploy/send/close/merge, stop and wait for me.
```

**Budget protection:** Always set `tokenBudget` or include a budget-aware pause condition. Open issues report goals consuming all Pro tokens through uncontrolled looping.

## 4. Goal Declares Completion Too Early

**Common causes:**

- Goal only describes the task, not the evidence.
- Code was changed but tests were not run.
- Partial success is treated as full completion.
- Report lacks command outputs.

**Prevention:**

```text
Do not mark the goal complete until every item in GOAL_CHECKLIST.md is pass or explicitly blocked.
Before completion, run the full verification commands and include exact command outputs in the final summary.
Treat uncertainty as not complete.
```

## 5. Tests Broken To Pass

**Symptoms:** Tests skipped, assertions weakened, failing tests deleted, errors swallowed, behavior changed to dodge constraints.

**Prevention:**

```text
Do not skip, delete, weaken, or silence tests.
Do not swallow errors merely to pass tests.
Preserve public behavior.
If a test appears wrong, pause and explain instead of changing it unilaterally.
```

## 6. Scope Creep

**Symptoms:** Unrelated files modified, shared modules changed without justification, generated files edited.

**Prevention:** Use the triple guard:

1. `Allowed writes` in the goal.
2. `Do not edit` in the goal.
3. Post-completion `git diff --name-only` audit.

```text
If changes touch files outside allowed scope, justify each file or revert.
```

## 7. Sandbox / Permission Issues

**Symptoms:** Dependency install blocked, network access denied, database unreachable, external API rejected.

**Before relaxing permissions, check:**

- Is this operation truly necessary?
- Can fixtures/mocks/exports replace the live call?
- Is read-only access sufficient?
- Can logs be provided manually?
- Can this run in a temporary environment?
- Will this produce production side effects?

## 8. Goal Too Large

**Rule of thumb:** If a goal has not converged after one day, split it.

**Suggested split order:**

1. Fix the verification command first.
2. Fix the smallest failing subset.
3. Migrate one package.
4. Expand to the full repo.
5. Update docs and open PR.

## 9. Unsafe External Writes

**Applies to:** Email, Slack, Linear, Jira, Sentry, GitHub, payment systems, deployment pipelines.

**Default:**

```text
Draft-only. Read-only. No external writes without explicit approval.
```

Even when tools support writes, do not let the goal auto-send, auto-close, auto-delete, auto-merge, auto-deploy, auto-refund, or modify customer data.

## Supervision Phrases

When the goal drifts, insert these directly:

```text
Pause after the current command and summarize progress against the original goal.
```

```text
Do not make further code edits until you update GOAL_PROGRESS.md with the attempts so far.
```

```text
You are touching files outside the allowed scope. Re-evaluate and either justify each file or revert unrelated changes.
```

```text
Before continuing, create a checklist mapping each requirement to evidence.
```

```text
The current approach is repeating. Try a different hypothesis or pause with blockers after one more attempt.
```

```text
Do not mark complete yet. Run the full verification suite and include exact outputs.
```

```text
This requires a product decision. Stop and list the decision options instead of choosing one.
```

## References

- Source: OpenAI Codex Issues [#25812](https://github.com/openai/codex/issues/25812), [#24269](https://github.com/openai/codex/issues/24269), [#23003](https://github.com/openai/codex/issues/23003), [#22245](https://github.com/openai/codex/issues/22245)
- Source: [OpenAI Cookbook — Using Goals in Codex](https://cookbook.openai.com/articles/using_goals_in_codex)
