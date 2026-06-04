---
name: goal-writer
description: Use when the user asks for a /goal, goal prompt, 目标模式提示词, goal-mode task contract, or critique of a goal prompt for work that exceeds the current turn or needs durable verification, write boundaries, and stop/pause conditions.
metadata:
  short-description: Write high-quality Codex /goal prompts
---

# goal-writer

Use this skill only when a Codex task needs a durable goal contract with verifiable evidence and safe boundaries. A good goal is bigger than one prompt and smaller than an open backlog.

Invocation should be explicit: either the user invokes `$goal-writer` or an AGENTS.md routing rule requires it for this request. Because goal mode adds process weight, skip this skill for ordinary one-turn tasks, simple status checks, or tasks the user wants handled immediately without goal mode.

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

## Long Goal Handling

Do not exceed the Codex /goal objective length. Keep the `/goal` body concise enough to paste into goal mode and move detailed contracts into a file when needed.

When the contract would be too long for a clean `/goal` body, produce one of these shapes:

- If file writes are allowed, create or update `GOAL.md` or `GOAL_CHECKLIST.md` with the full contract, then output a short `/goal` that points to that file.
- If file writes are not allowed, output a short `/goal` plus a separate `GOAL.md` draft block the user can save.

The short `/goal` must still name the outcome, the contract file path, and the evidence that proves completion.

## Question Budget

Ask at most 1-3 concise questions before finalizing. Ask only for information that cannot be discovered from repo/docs/context and would make the goal unsafe or unverifiable.

For low-risk or medium-risk work, proceed with clear assumptions when the missing detail is easy to infer. State those assumptions in the explanation before the goal. For high-risk work, do not assume approval, credentials, production access, deploy authority, destructive writes, or business decisions.

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
6. If the goal is too large, split it into staged goals or require phase-by-phase commit/evidence gates.

## Ask Before Finalizing When

- No evidence surface or safe write scope is known.
- The task may touch production, credentials, payments, deploys, deletes, permissions, customer data, or external messages.
- Success depends on taste, business judgment, or user preference.
- The user asks for "complete everything" but the backlog is open-ended.

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
- Read `references/eval-scenarios.md` when changing this skill or checking whether its outputs handle common failure modes.
