# Codex Goal Writer

`goal-writer` is a small Codex skill for turning vague long-running work into a copy-ready `/goal` contract.

It helps Codex write goals that have evidence, boundaries, iteration rules, and stop conditions, instead of broad prompts like "finish the roadmap" or "make this better".

## What It Enforces

Every finalized goal should include:

- `Outcome`: the final state, not just activity.
- `Verification`: commands, artifacts, screenshots, reports, or external state that prove completion.
- `Constraints`: behavior and safety rules that must not change.
- `Boundaries`: allowed writes and forbidden paths or systems.
- `Iteration policy`: how Codex should work each loop.
- `Stop/Pause conditions`: when the goal is complete and when Codex must stop for the user.

## Install

Clone and install the skill:

```bash
git clone https://github.com/enderzcx/codex-goal-writer.git
cd codex-goal-writer
bash scripts/install.sh
```

Or copy it manually:

```bash
mkdir -p ~/.agents/skills
cp -R skills/goal-writer ~/.agents/skills/
```

Then add the trigger snippet from [AGENTS_SNIPPET.md](AGENTS_SNIPPET.md) to your `AGENTS.md`.

## Use

Ask Codex for a goal prompt:

```text
Use $goal-writer to turn this task into a strong /goal prompt:
Ship Codex Flow through v1.6.
```

The output should be a copy-ready `/goal` prompt with verification commands, write boundaries, and pause conditions.

## Validate

```bash
bash scripts/validate.sh
```

## References

- [OpenAI Codex — Follow a goal](https://developers.openai.com/codex/use-cases/follow-goals): highlights durable objectives, verifiable stopping conditions, and validation loops for long-running work.
- [OpenAI Codex — Save workflows as skills](https://developers.openai.com/codex/use-cases/reusable-codex-skills): describes skills as reusable bundles of instructions, resources, and scripts, which is the structure used here.
- [Feishu /goal research doc](https://xiangyangqiaomu.feishu.cn/wiki/YQn6wZ1hzijlRvkU1E6cEL5mnic): the main inspiration for the six-element structure and local workflow rules.
- This repo's [goal-quality-standard.md](./skills/goal-writer/references/goal-quality-standard.md) and [templates.md](./skills/goal-writer/references/templates.md): the localized implementation of those references inside the Codex skill.

## Repo Layout

```text
skills/goal-writer/
  SKILL.md
  references/
    goal-quality-standard.md
    templates.md
  agents/openai.yaml
scripts/
  install.sh
  validate.sh
AGENTS_SNIPPET.md
```

## Boundary

This repo does not add a runtime, model router, background worker, or GitHub automation. It is just a Codex skill plus a small AGENTS trigger rule.
