# Codex Goal Writer

A concise, Chinese-first Codex skill that turns vague or long-running work into a copy-ready `/goal`.

It keeps only the three things native Goal Mode needs from the prompt:

- **Outcome:** the final state, not merely an activity.
- **Material constraints:** boundaries, compatibility requirements, or approval points that prevent real problems.
- **Verification:** tests, measurements, artifacts, or review criteria that prove completion.

It does not force every goal into a long form or repeat planning, iteration, and state-management behavior already provided by Codex.

## Output

The default output is natural Chinese:

```text
/goal <最终结果>。<真正重要的约束>。<可验证的完成标准>。
```

For example:

```text
/goal 把这个代码库迁移到 TypeScript，保留现有行为，开启 strict mode 且不使用显式 any，并让完整测试套件通过。
```

The actual goal may be longer, but every sentence should materially help the task.

## Use It For

- Writing an explicit `/goal` or Goal Mode prompt.
- Giving long-running work a durable final objective.
- Handing an existing plan, spec, or roadmap to Goal Mode.
- Reviewing whether an existing goal has a clear outcome, constraints, and verification.

Do not use it for ordinary plans or PRDs, one-turn work, direct implementation, or prose polishing.

## Install

```bash
git clone https://github.com/enderzcx/codex-goal-writer.git
cd codex-goal-writer
bash scripts/install.sh
```

The skill is installed to:

```text
~/.agents/skills/goal-writer/
```

Running the installer again replaces the previous package so obsolete templates and checkers do not remain.

## Use

```text
Use $goal-writer to turn this migration into a concise, copy-ready Chinese /goal.
```

Implicit invocation is enabled through the skill description; no extra global `AGENTS.md` snippet is required.

## Boundary

This repository generates or reviews generic `/goal` prompts. It does not execute the goal, route models, provide a background worker, invent permissions or verification commands, or embed private operating frameworks.

For long or multi-stage work, the goal should reference the authoritative plan, spec, or roadmap instead of duplicating an orchestration protocol.

## Validate

```bash
bash scripts/validate.sh
```

## Layout

```text
skills/goal-writer/
  SKILL.md
  agents/openai.yaml
  evals/trigger_cases.json
scripts/
  install.sh
  validate.sh
```

## References

- [OpenAI Codex: Follow a goal](https://developers.openai.com/codex/use-cases/follow-goals)
- [OpenAI Codex: Save workflows as skills](https://developers.openai.com/codex/use-cases/reusable-codex-skills)
- [qiaomu-goal-meta-skill](https://github.com/joeseesun/qiaomu-goal-meta-skill)

## License

MIT License.
