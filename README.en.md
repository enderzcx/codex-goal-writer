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

Useful options:

```bash
bash scripts/install.sh --dry-run
bash scripts/install.sh --repo-local
bash scripts/install.sh --force
```

- `--dry-run`: print the install target without copying files.
- `--repo-local`: install into `.agents/skills/goal-writer/` under the current git repository.
- `--force`: replace an existing `goal-writer` skill directory. Existing directories are not overwritten by default.

Or copy it manually:

```bash
mkdir -p ~/.agents/skills
cp -R skills/goal-writer ~/.agents/skills/
```

Then add the trigger snippet from [AGENTS_SNIPPET.md](AGENTS_SNIPPET.md) to your `AGENTS.md` if you want routing rules for long-running goals.

## Use

Ask Codex for a goal prompt:

```text
Use $goal-writer to turn this task into a strong /goal prompt:
Ship Codex Flow through v1.6.
```

The output should be a copy-ready `/goal` prompt with verification commands, write boundaries, and pause conditions.

The skill defaults to explicit invocation: type `$goal-writer`, or add [AGENTS_SNIPPET.md](AGENTS_SNIPPET.md) to `AGENTS.md` as a routing rule. It does not rely on implicit invocation for ordinary small tasks.

If the goal contract would be too long for a clean `/goal` body, put the detailed contract in `GOAL.md` or `GOAL_CHECKLIST.md` and make the short `/goal` point to that file.

## Validate

```bash
bash scripts/validate.sh
```

The validation checks required files, frontmatter, app metadata, explicit invocation policy, long-goal guidance, eval scenarios, and installer options.

## References

- [OpenAI Codex — Goal mode](https://developers.openai.com/codex/prompting#goal-mode): highlights durable objectives, verifiable stopping conditions, and validation loops for long-running work.
- [OpenAI Codex — Agent Skills](https://developers.openai.com/codex/skills): describes skills as reusable bundles of instructions, resources, and scripts, which is the structure used here.
- [Feishu /goal research doc](https://xiangyangqiaomu.feishu.cn/wiki/YQn6wZ1hzijlRvkU1E6cEL5mnic): the main inspiration for the six-element structure and local workflow rules.
- This repo's [goal-quality-standard.md](./skills/goal-writer/references/goal-quality-standard.md) and [templates.md](./skills/goal-writer/references/templates.md): the localized implementation of those references inside the Codex skill.
- This repo's [eval-scenarios.md](./skills/goal-writer/references/eval-scenarios.md): pressure scenarios for vague delivery, high-risk external writes, oversized roadmaps, and missing verification surfaces.

## Repo Layout

```text
skills/goal-writer/
  SKILL.md
  references/
    eval-scenarios.md
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
