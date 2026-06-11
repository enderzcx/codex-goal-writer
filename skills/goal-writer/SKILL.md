---
name: goal-writer
description: Use when the user asks for a /goal, goal prompt, 目标模式提示词, goal-mode task contract, or critique of a goal prompt for a task that exceeds the current turn or needs durable verification, write boundaries, and stop/pause conditions. Turns vague work into a copy-ready /goal. Not for ordinary plans, PRDs/SPECs without goal-mode handoff, quick one-turn tasks, implementation work, or prose polish.
metadata:
  short-description: Write high-quality Codex /goal prompts
sunny_skill_type: contract
---

# goal-writer

Use this skill only when a Codex task needs a durable goal contract with verifiable evidence and safe boundaries. A good goal is bigger than one prompt and smaller than an open backlog.

AGENTS.md is the trigger gate; this skill is the generator. If AGENTS requires `$goal-writer`, follow this skill to produce or review the goal prompt.

If the caller provides a project risk label, reflect it in the goal strictness. Do not assume a specific framework; use plain labels such as low risk, medium risk, and high risk unless the user provides their own scheme. For high-risk work, include review, rollback, explicit approval, and stronger verification gates.

## Output Contract

Return a copy-ready goal prompt in a fenced `text` block. Default to Chinese explanation. Write the `/goal` body in the target runtime's best language; if no runtime preference is stated, use Chinese for user-facing control text and English for literal command keywords like `/goal`, `Verification`, and `Allowed writes`.

Every finalized goal must include at least one verifiable evidence surface, one safe write boundary, and these six elements:

- `Outcome`: final world state, not just activity.
- `Verification`: commands, artifacts, screenshots, reports, or external state that prove completion.
- `Constraints`: behavior, safety, compatibility, or business rules that must not change.
- `Boundaries`: allowed writes and forbidden paths/systems.
- `Iteration policy`: how to work each loop, log progress, and avoid repeated blind attempts.
- `Stop/Pause conditions`: when completion is proven and when to stop for the user.

If any required element is missing and cannot be discovered from repo/docs/context, ask the user concise questions before finalizing. Do not invent verification commands, risky write boundaries, credentials, production approval, or business decisions.

### Staged Goal Chain

For roadmap, version, or multi-phase work, first decide whether the requested end state is **stage execution** or **whole-plan execution**.

Default to the **next executable stage only** when the user asks for a bounded next slice, a safe first stage, or a goal prompt attached to planning docs. Do not turn the whole roadmap into one giant direct-execution `/goal`.

Default to an **orchestrator goal** when the user wants the whole roadmap/version/plan finished, not merely the next phase. Strong signals include:

- `搞完所有`, `完整跑完`, `全部做完`, `一路做完`, `finish the whole plan`, `complete everything`, or equivalent wording;
- an active Goal objective that points at a plan/spec file and says to continue working toward the objective;
- the user asks why only a child-stage goal was produced or expects the full plan to keep executing;
- the user asks for one durable goal to keep updating and continuing until the plan is complete.

The default chain is:

```text
roadmap/phase plan -> next-stage goal -> execute/verify stage -> evidence review -> next-stage goal -> continue until complete or paused
```

This is an agent operating rule, not automatic platform behavior. A later-stage child goal is created only after the previous stage has closeout evidence, blockers or deferred items are handled or carried forward, the next write boundary is known, and Ender or the active parent contract still authorizes continuation.

When whole-plan execution is intended, write an **orchestrator goal**. An orchestrator goal may cover the whole roadmap only by managing the staged loop: execute the current child stage, verify evidence, update a status ledger, generate or refresh the next child-stage goal, then continue unless a pause condition or human approval gate applies. It must not bypass per-stage evidence, write boundaries, or approval gates.

## Workflow

1. Classify the requested goal: software delivery, debugging, migration, docs sync, research, data/report, product/PM, external-system cleanup, or multi-phase roadmap.
2. Capture known risk context: production exposure, external writes, credentials, customer data, custom risk labels if provided, and whether the user wants one goal or staged goals.
3. Explore discoverable facts first: repo scripts, test commands, docs, existing plans, CI, package manager, target paths, and repo state when needed.
4. Draft the goal using the six-element contract.
5. Run a quality pass:
   - Is the outcome measurable or inspectable?
   - Can Codex run/read the verification surface?
   - Are allowed writes and forbidden areas clear?
   - Does it say what not to do?
   - Does it stop after repeated infrastructure or no-progress failures?
   - Is it one goal, not an unbounded backlog?
6. If the goal is too large, split it into staged goals. Produce only the next executable stage when the user wants a bounded slice; produce an orchestrator goal when the user wants the whole plan to keep executing through staged child goals.

## Ask Before Finalizing When

- No evidence surface or safe write scope is known.
- The task may touch production, credentials, payments, deploys, deletes, permissions, customer data, or external messages.
- Success depends on taste, business judgment, or user preference.
- The user asks for "complete everything" but there is no plan/spec/phase list/source of truth to bound the backlog. If a plan/spec already defines the stages, write an orchestrator goal instead of asking by default.

Ask only the questions needed to make the goal safe and executable.

## Do Not

- Do not output a broad roadmap and call it a goal.
- Do not let "run until done" replace explicit evidence.
- Do not hide risky actions behind vague words like "clean up", "optimize", "sync", or "fix all".
- Do not make current-thread, production, deployment, posting, closing, deleting, merge, send, or permission changes implicit.

## References

Reference paths are relative to this skill directory.

- Read `references/goal-quality-standard.md` when judging or rewriting a weak goal.
- Read `references/templates.md` when the user wants a reusable template or when the task type needs a starting shape.
- Use `templates/goal-prompt.md` as the copy-ready output skeleton when creating a new goal.
- Run `python3 scripts/check_goal_prompt.py <goal-file.md>` when a goal prompt is saved to a file or needs mechanical validation.
