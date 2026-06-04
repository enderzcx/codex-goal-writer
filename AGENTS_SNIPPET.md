# Goal Prompt Quality Gate

Add this to `AGENTS.md` if you want agents to invoke `goal-writer` whenever they draft long-running Codex goals.

```md
## Goal Prompt Quality Gate

When the user asks for `/goal`, a goal prompt, 目标模式提示词, goal mode, or asks a task beyond the current turn to "run to completion", first decide whether the task needs a durable goal contract. If it needs verification, write boundaries, or stop/pause conditions, invoke `$goal-writer`.

AGENTS.md is the trigger gate; `$goal-writer` is the generator. If the current session does not auto-load the skill, read `~/.agents/skills/goal-writer/SKILL.md` directly.

A valid goal must define Outcome, Verification surface, Constraints, Boundaries, Iteration policy, and Blocked stop condition. If verification commands, allowed writes, forbidden paths, or stop conditions are missing and cannot be discovered from repo/docs, ask the user before finalizing. Do not invent them.

Use for G2/G3 long-running tasks, cross-file engineering, agent/workflow/prompt/pipeline work, migrations, release preparation, docs sync, research reproduction, and external-system cleanup.

Skip for one-turn explanations, ordinary planning chat, simple commands, trivial typo/import fixes, or cases where the user explicitly rejects goal mode and the task has no G2/G3 risk.
```
