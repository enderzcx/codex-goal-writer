[English version](README.en.md)

# codex-goal-writer

把模糊的长期任务改写成可执行的 `/goal` 契约。

`codex-goal-writer` 是一个 Codex skill。它不连接模型、不调度任务、不自动执行任何工作。它只做一件事：帮你把「做完这个」「优化一下」「完整跑到 v1.6」这类模糊请求，改写成一份安全、可验证、可迭代的 `/goal` 提示词。

## 为什么需要它

日常开发里，我们很容易把长期任务说成这样：

- 帮我把这个路线图完整做完。
- 重构这个模块。
- 修复所有已知 bug。
- 把这个项目迁移到新架构。

这些任务通常不是一个回合能做完的。它们需要多轮迭代、外部验证、写文件，有时还会碰到生产环境、凭证、删除、部署或权限变更。

如果 goal 写得太松，Codex 可能会跑偏：反复尝试同一种失败方案、为了过测试破坏真实行为、越界修改共享模块，或者提前宣布完成。

`goal-writer` 强制 goal 写清楚六件事：

| 元素 | 作用 |
|---|---|
| Outcome | 最终状态，不只是“做事动作” |
| Verification | 用什么命令、产物、截图、报告或外部状态证明完成 |
| Constraints | 哪些行为、安全规则、兼容性要求不能被破坏 |
| Boundaries | 允许写哪里，禁止碰哪里 |
| Iteration policy | 每一轮怎么改、怎么验证、怎么记录进度 |
| Stop/Pause conditions | 什么时候算完成，什么时候必须停下来问人 |

说人话：它让 Codex 知道目标是什么、证据在哪里、边界到哪、什么时候该停。

## 安装

```bash
git clone https://github.com/enderzcx/codex-goal-writer.git
cd codex-goal-writer
bash scripts/install.sh
```

安装脚本会把 `skills/goal-writer/` 复制到：

```text
~/.agents/skills/goal-writer/
```

常用选项：

```bash
bash scripts/install.sh --dry-run
bash scripts/install.sh --repo-local
bash scripts/install.sh --force
```

- `--dry-run`：只打印安装目标，不复制文件。
- `--repo-local`：安装到当前 git 仓库的 `.agents/skills/goal-writer/`，适合团队共享。
- `--force`：替换已有的 `goal-writer` skill 目录。默认不会覆盖已有目录。

如果你想手动安装：

```bash
mkdir -p ~/.agents/skills
cp -R skills/goal-writer ~/.agents/skills/
```

然后把 [AGENTS_SNIPPET.md](./AGENTS_SNIPPET.md) 里的触发规则加入你的 `AGENTS.md`。这一步不会由安装脚本自动修改，避免误写你的全局规则文件。

## 使用

在 Codex 里可以直接说：

```text
Use $goal-writer to turn this task into a strong /goal prompt:
把 Codex Flow 完整推进到 v1.6。
```

这个 skill 默认要求显式调用：你可以在提示词里写 `$goal-writer`，或者把 [AGENTS_SNIPPET.md](./AGENTS_SNIPPET.md) 加到 `AGENTS.md` 里作为路由规则。它不会依赖隐式触发来拦截普通小任务。

装好 AGENTS 路由规则后，当你要求写 `/goal`、目标模式提示词、开目标模式，或者让一个超过当前回合的任务“完整跑完”时，agent 应该先判断是否需要 `goal-writer`。

如果任务需要验证命令、写入边界、停止/暂停条件，就应该先走 `goal-writer`，再输出可复制的 `/goal`。

如果生成的 goal 太长，不应该把所有细节硬塞进 `/goal`。更好的做法是把详细契约写入或草拟到 `GOAL.md` / `GOAL_CHECKLIST.md`，然后让 `/goal` 指向这个文件。

## 示例

不好的目标：

```text
帮我优化这个项目。
```

更好的目标：

```text
/goal 将项目 CI 流水线改成每次 push 自动运行，并保证测试和 lint 都通过。

Verification:
- 触发一次 push，等待 CI 运行完成。
- 查看 GitHub Actions 页面，确认所有 job 通过。
- 检查 CI 日志中包含 test 和 lint 步骤。

Constraints:
- 不修改业务逻辑。
- 不跳过或删除测试。
- 不改变部署流程。

Boundaries:
Allowed writes:
- .github/workflows/**
- 与 CI 直接相关的配置文件

Do not edit:
- src/**
- tests/**
- deploy/**

Iteration policy:
- 先创建或更新 GOAL_CHECKLIST.md，列出需求和证据。
- 每次只做一个聚焦改动。
- 每次改动后先跑最小验证，再在收口前跑完整验证。
- 不重复使用已经失败的同一种方案。

Stop when:
- 一次 push 后 CI 全部通过。
- 最终回复包含命令结果、改动文件、commit hash 和 push 状态。

Pause if:
- 需要生产环境凭证。
- 需要部署、删除数据、改权限或其他外部写操作。
- 同一个基础设施错误重复两次。
- 三次聚焦尝试后没有可衡量进展。
```

## 内置参考

skill 里带了两份参考材料：

- [goal-quality-standard.md](./skills/goal-writer/references/goal-quality-standard.md)：六要素标准、常见坏 goal、修法。
- [templates.md](./skills/goal-writer/references/templates.md)：软件交付、多阶段路线图、文档同步、调研报告等模板。
- [eval-scenarios.md](./skills/goal-writer/references/eval-scenarios.md)：改 skill 时用的压力场景，覆盖模糊交付、高风险外部写、过大路线图和缺少验证面的情况。

`SKILL.md` 保持短，详细内容放在 `references/` 里，避免每次触发都塞太多上下文。

## 风险分层

你不需要有任何内部流程体系，也可以直接使用 `goal-writer`。它默认只按任务风险粗分：

- 低风险：本地、可逆、只影响当前仓库的小改动，写清楚验证和边界即可。
- 中风险：CI、配置、workflow、prompt、pipeline、跨模块重构，需要更明确的回滚思路和阶段验收。
- 高风险：生产、凭证、权限、支付、部署、删除、客户数据、不可逆外部写，必须加入 review、rollback、explicit approval 和更强验证面。

如果你的团队本来就有自己的风险等级，也可以把它映射进 goal，但这不是使用前提。

高风险 goal 应该包含类似约束：

```text
High-risk safety:
- Do not release without review until GO.
- Include rollback plan and exact verification evidence.
- Pause before schema, credential, payment, permission, deploy, delete, or irreversible external changes.
```

## 不做什么

`codex-goal-writer` 是 skill，不是 runtime。它不做：

- 模型路由
- 后台 worker
- 自动执行任务
- 自动修改代码
- 自动部署或发布
- 自动操作 GitHub、Linear、Sentry、邮件或其他外部系统

它只负责生成更好的 `/goal` 契约。真正执行任务的仍然是 Codex。

## 校验

```bash
bash scripts/validate.sh
```

这个脚本会检查 skill 文件是否存在，`SKILL.md` frontmatter 是否包含 `name` 和 `description`，`agents/openai.yaml` 是否能被解析，触发策略是否要求显式调用，以及关键 reference / installer 规则是否存在。

## 参考来源

- [OpenAI Codex — Goal mode](https://developers.openai.com/codex/prompting#goal-mode)：强调长期任务需要 durable objective、可验证的完成条件和验证循环。
- [OpenAI Codex — Agent Skills](https://developers.openai.com/codex/skills)：说明 skill 可以沉淀 reusable instructions、resources、scripts，对应本仓库的 skill 结构。
- [飞书 /goal 调研文档](https://xiangyangqiaomu.feishu.cn/wiki/YQn6wZ1hzijlRvkU1E6cEL5mnic)：本仓库六要素和本地工作流规则整理的主要启发来源。
- 本仓库的 [goal-quality-standard.md](./skills/goal-writer/references/goal-quality-standard.md) 和 [templates.md](./skills/goal-writer/references/templates.md)：上述来源在 Codex skill 里的本地化落地。

## 仓库结构

```text
.
├── AGENTS_SNIPPET.md
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
        └── references/
            ├── goal-quality-standard.md
            ├── eval-scenarios.md
            └── templates.md
```

## 许可

MIT License.

一句话总结：`codex-goal-writer` 帮你把长期任务写成有证据、有边界、知道什么时候停的 `/goal` 提示词。
