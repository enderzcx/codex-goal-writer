[English](README.en.md)

# codex-goal-writer

一个简洁、中文优先的 Codex skill，用来把模糊或长期任务改写成可直接运行的 `/goal`。

它只保留原生 Goal Mode 真正需要的三类信息：

- **最终结果**：完成后世界应该是什么状态。
- **重要约束**：哪些边界、兼容要求或审批点不能忽略。
- **完成验证**：什么测试、指标、产物或验收结果可以证明完成。

它不会强迫每个 goal 套用长表格，也不会重复 Codex 已经具备的计划、迭代和状态管理能力。

## 输出形式

默认输出中文自然语言：

```text
/goal <最终结果>。<真正重要的约束>。<可验证的完成标准>。
```

例如：

```text
/goal 把这个代码库迁移到 TypeScript，保留现有行为，开启 strict mode 且不使用显式 any，并让完整测试套件通过。
```

实际内容可以更长，但应该只写对当前任务真正重要的信息。

## 适用范围

适合：

- 用户明确要求 `/goal` 或 Goal Mode 提示词。
- 长期任务需要一个持续有效的最终目标。
- 已有计划、规格或路线图需要交接给 Goal Mode。
- 审查现有 goal 的结果、约束或验证是否清楚。

不适合：

- 普通计划、PRD 或 SPEC。
- 可以在当前回合直接完成的小任务。
- 直接修代码、部署或操作外部系统。
- 单纯润色文字。

## 安装

```bash
git clone https://github.com/enderzcx/codex-goal-writer.git
cd codex-goal-writer
bash scripts/install.sh
```

安装位置：

```text
~/.agents/skills/goal-writer/
```

重新运行安装脚本会替换旧版本，因此旧模板和 checker 不会残留。

## 使用

```text
使用 $goal-writer，把这个迁移任务写成一个可以直接复制的中文 /goal。
```

skill 也允许隐式触发；是否触发由 `SKILL.md` 的描述决定，不要求额外修改全局 `AGENTS.md`。

## 设计边界

这个仓库只负责生成或审查通用 `/goal`：

- 不执行 goal 描述的任务。
- 不提供模型路由、后台 worker 或任务编排 runtime。
- 不虚构凭据、生产审批、业务决定、写入权限或验证命令。
- 不包含任何个人或团队私有的流程框架。

长期或多阶段任务应引用已有的权威计划、规格或路线图，而不是把整套编排协议复制进 goal。

## 校验

```bash
bash scripts/validate.sh
```

验证脚本会检查 skill 包结构、YAML frontmatter、agent 配置和触发评测 JSON。

## 仓库结构

```text
.
├── README.md
├── README.en.md
├── scripts/
│   ├── install.sh
│   └── validate.sh
└── skills/
    └── goal-writer/
        ├── SKILL.md
        ├── agents/
        │   └── openai.yaml
        └── evals/
            └── trigger_cases.json
```

## 参考

- [OpenAI Codex: Follow a goal](https://developers.openai.com/codex/use-cases/follow-goals)
- [OpenAI Codex: Save workflows as skills](https://developers.openai.com/codex/use-cases/reusable-codex-skills)
- [qiaomu-goal-meta-skill](https://github.com/joeseesun/qiaomu-goal-meta-skill)

## 许可

MIT License.
