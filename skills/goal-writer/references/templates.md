# Goal Templates

## Minimal Template

```text
/goal [Outcome].

Verification:
- [commands/artifacts/evidence]

Constraints:
- [what must not change]

Boundaries:
Allowed writes:
- [paths]
Do not edit:
- [paths/systems]

Iteration policy:
- Make one focused change at a time.
- Run the smallest relevant check after each meaningful change.
- Keep GOAL_CHECKLIST.md updated with requirement, evidence, status, and notes.
- Do not repeat an identical failed approach.

Stop when:
- [evidence proves completion]

Pause if:
- [missing credentials / risky write / business decision / repeated failure / no progress]
```

## Goal + CWF

Use when the user wants Goal Mode to supervise repeated CWF runs.

```text
/goal Complete [outcome] with Goal Mode as the outer supervisor and CWF as bounded execution episodes.

Verification:
- [goal-level acceptance evidence]
- Each CWF episode records commands/artifacts/evidence in its run plan and returns `goal_delta`.

Constraints:
- Do not treat one CWF episode as completion unless goal-level acceptance is met.
- Do not spawn workflow workers unless the EWC CWF Trigger Boundary is satisfied.
- Do not continue blindly after repeated no-progress CWF episodes.

Boundaries:
Allowed writes:
- [paths]
Do not edit:
- [paths/systems]

Iteration policy:
- Maintain GOAL_CHECKLIST.md or GOAL_PROGRESS.md with current slice, completed work, evidence, blockers, and next slice.
- Before each CWF episode, define the slice, trigger boundary, budget, and stop rule.
- After each CWF episode, return `goal_delta` with `run_id`, `completed`, `evidence_added`, `blockers`, `next_slice`, `next_cwf_run`, `continue_or_stop`, and `progress_artifact_update`.

CWF episode policy:
- Use CWF for fan-out, clean contexts, adversarial verification, safe-fix-loop, background/resume, or workflow state.
- Prefer direct Codex work when one turn is smaller and safer.

Stop when:
- Goal-level acceptance is met and final evidence is summarized.

Pause if:
- The same blocker repeats, budget is exhausted, CWF trigger boundary is no longer met, or a risky external action is needed.
```

## Software Delivery

```text
/goal Ship [feature/fix] so [user-visible or system-visible final state].

Verification:
- [lint/typecheck/test/build]
- [smoke command or browser check]
- [artifact or report path]

Constraints:
- Do not change public API or runtime behavior outside [scope].
- Do not disable tests.
- Do not edit generated files unless explicitly required.

Boundaries:
Allowed writes:
- [repo paths]
Do not edit:
- [forbidden paths]

Iteration policy:
- Create/update GOAL_CHECKLIST.md before implementation.
- Work in small vertical slices.
- Run the smallest relevant check first, then full verification before completion.
- Commit only after the phase has evidence.

Stop when:
- All verification passes and final response includes commands run, pass/fail, changed files, commit hash, and push status if requested.

Pause if:
- More than 3 focused attempts fail without measurable progress.
- A production write, credential, deploy, delete, merge, or external permission change is needed.
```

For high-risk work, add:

```text
High-risk safety:
- Do not release without review until GO.
- Include rollback plan and exact verification evidence.
- Pause before schema, credential, payment, permission, deploy, delete, or irreversible external changes.
```

## Multi-Phase Roadmap

Use only when the user explicitly wants one long goal. Otherwise split into separate goals.

```text
/goal Complete [roadmap name] through phases [v1.x-v1.y], with each phase independently verified, documented, and committed before proceeding.

Verification:
- [global commands]
- [phase-specific smoke/evidence list]

Constraints:
- Do not proceed to the next phase if current core acceptance is unverified.
- Do not overclaim mock/fallback evidence as live support.
- Keep docs aligned with actual behavior.

Boundaries:
Allowed writes:
- [project paths]
Do not edit:
- unrelated repositories
- global config unless explicitly approved

Iteration policy:
- Maintain GOAL_CHECKLIST.md with one section per phase.
- For each phase: implement, verify, update docs, commit, record evidence.
- Use real capability probes before claiming native integration.

Stop when:
- Every phase has passing evidence, commits are present, docs match implementation, and final response summarizes capabilities in plain language.

Pause if:
- A platform API cannot support a claimed phase.
- A phase needs a risky external write.
- The same blocker repeats twice or 3 focused attempts make no progress.
```

## Docs Sync

```text
/goal Sync documentation so [docs] accurately describe [implemented behavior/source of truth].

Verification:
- [source files inspected]
- [docs commands/checks]
- [claim audit result]

Constraints:
- Do not introduce future-tense claims as current behavior.
- Mark unsupported or fallback-only behavior clearly.

Boundaries:
Allowed writes:
- [docs paths]
Do not edit:
- runtime code unless documentation exposes a real bug and user approves.

Iteration policy:
- Build a claim/evidence matrix.
- Update docs in small sections.
- Run formatting or docs checks when available.

Stop when:
- Every major claim has a source, docs are internally consistent, and final response names any remaining unknowns.

Pause if:
- The source of truth is missing or contradictory.
```

## Research Or Investigation

```text
/goal Produce [report/decision] answering [question] using verifiable sources and a clear recommendation.

Verification:
- [source list]
- [report path]
- [cross-check method]

Constraints:
- Mark unavailable facts as [UNVERIFIED].
- Do not rely on screenshots or secondary commentary when primary sources are available.
- Do not make purchases, signups, posts, or external writes.

Boundaries:
Allowed writes:
- [report paths]
Do not edit:
- project code unless explicitly requested.

Iteration policy:
- Gather sources first.
- Separate facts, user reports, and inference.
- Keep a short evidence table.

Stop when:
- Report includes conclusion, evidence, uncertainty, and recommended next action.

Pause if:
- Required sources are inaccessible or the decision depends on user preference.
```
