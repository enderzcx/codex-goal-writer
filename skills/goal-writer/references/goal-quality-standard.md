# Goal Quality Standard

## Applicability

Use this standard for long-running tasks, multi-file engineering work, migrations, release preparation, workflow/agent work, docs sync, research loops, data/report generation, and external-system cleanup.

Skip it for one-line edits, simple explanations, quick command output, ordinary lint/test runs, or tasks the user explicitly wants handled in the current turn without goal mode.

## Six Elements

### Outcome

Write the final state. Avoid vague actions.

Bad:

```text
/goal Make the project better.
```

Good:

```text
/goal Ship the release checklist and CI smoke so documented Codex Flow commands are verified on every push.
```

### Verification

List evidence Codex can run or read:

- test/build/lint commands
- package dry-runs
- CLI smoke commands
- screenshots or browser checks
- generated reports
- artifact paths
- external system read-only checks

If verification does not exist, the goal can include creating a verification script before changing production code.

### Constraints

State what must not change:

- public API
- runtime behavior
- database schema
- auth/security rules
- deployment config
- generated files
- production state
- external messages or tickets

### Boundaries

State allowed writes and forbidden paths/systems. Use absolute paths when possible for local work.

```text
Allowed writes:
- /abs/repo/src/**
- /abs/repo/tests/**

Do not edit:
- /abs/repo/deploy/**
- credentials
- unrelated repositories
```

### Iteration Policy

Tell Codex how to loop:

- one focused change at a time
- smallest relevant check first
- full verification before completion
- keep `GOAL_CHECKLIST.md` or `GOAL_PROGRESS.md`
- log hypothesis, files changed, command, result, next step
- do not repeat an identical failed approach

### Stop And Pause Conditions

Completion stop:

- all acceptance items pass
- docs match implementation
- artifacts exist
- commits/push status reported when requested

Pause when:

- required credentials or APIs are missing
- production writes are needed
- user/business judgment is needed
- the same infrastructure failure repeats twice
- three focused attempts show no measurable progress
- risky actions like delete/deploy/post/merge/close/send/permission-change are required

## Quality Checklist

- Outcome is a final state.
- Verification is concrete and auditable.
- Constraints prevent shortcuts.
- Boundaries say where writes are allowed.
- Iteration policy prevents blind loops.
- Pause conditions are explicit.
- Risky external actions require user approval.
- G3 goals include review, rollback, approval, and stronger verification gates.
- The final answer is copy-ready.

## Common Fixes

- Replace "fix all bugs" with a bounded issue set and evidence.
- Replace "make it better" with a measurable target.
- Replace "complete roadmap" with staged goals and phase gates.
- Replace "review this" with expected output schema, evidence, and stop condition.
- Replace "sync docs" with exact docs, source of truth, and verification commands.
