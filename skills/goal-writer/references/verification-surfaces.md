# Verification Surface Design

## When To Read This

Read this reference when designing the `Verification` section of a goal, or when a goal lacks a concrete way to prove completion.

## What Is A Verification Surface

A verification surface is any machine-readable or human-reviewable evidence that proves the goal's outcome has been achieved. The best verification surfaces are:

1. **Runnable by Codex** — a command, script, or tool Codex can execute.
2. **Unambiguous** — pass/fail is clear from the output.
3. **Reviewable by humans** — output can be inspected, diffed, or audited.

## Common Verification Surfaces

```text
npm test                    # unit + integration tests
npm run typecheck           # type checking
npm run lint                # code style
npm run build               # compilation
npm run bench:checkout      # performance benchmark
pytest tests/payments       # Python tests
cargo test                  # Rust tests
go test ./...               # Go tests
pnpm build                  # monorepo build
python scripts/evaluate.py --json  # custom evaluation
coverage/lcov-report/index.html    # coverage report
reports/analysis.md         # generated report
```

## Task-Specific Verification Map

| Task Type | Recommended Verification | Supplemental Evidence |
|---|---|---|
| Performance optimization | benchmark command, profiling output | baseline vs final comparison, flame graphs |
| Test repair | unit tests, integration tests, CI logs | failure signature, consecutive pass count |
| Migration | typecheck, build, test | migration notes, error classification |
| Refactoring | test, lint, public API snapshot | diff summary, behavior-preserving statement |
| Coverage increase | coverage report | list of newly covered behaviors |
| Security audit | lockfile scan, static search | reachability analysis, risk rating |
| Data analysis | reproducible script, output files | data quality notes, charts |
| Documentation sync | docs build, link check, example tests | change summary, screenshots |
| Email cleanup | inbox count, label counts | retention reasons, drafted reply list |
| Backlog cleanup | issue classification table | evidence links, items requiring human confirmation |

## Creating Verification When It Does Not Exist

If the project has no test suite, benchmark, or evaluation script, the goal can include creating one before changing production code:

```text
Before changing production code, create scripts/evaluate_recommendations.py that computes precision, recall, and coverage on fixtures/reco_eval.csv.
Use that script as the stopping rule for subsequent iterations.
```

## Verification Anti-Patterns

- **"Looks good to me"** — subjective, not machine-readable.
- **"Tests pass" without running them** — claims without output.
- **Partial verification** — only checking one dimension (e.g., lint passes but tests not run).
- **Flaky verification** — non-deterministic commands that pass/fail randomly.
- **Verification that Codex cannot run** — requires manual browser check, external API key, or human judgment.

## Designing Multi-Layer Verification

Strong goals often combine multiple layers:

```text
Verification:
1. pnpm typecheck --filter checkout    # structural correctness
2. pnpm test --filter checkout         # behavioral correctness
3. pnpm run bench:checkout             # performance target
4. git diff --name-only                # scope audit
```

Each layer catches a different class of failure. The goal should specify which layers are required for completion and which are informational.

## References

- Source: OpenAI Developers — [Iterate on difficult problems](https://developers.openai.com/codex/use-cases/iterate-on-difficult-problems)
- Source: OpenAI Cookbook — [Using Goals in Codex](https://cookbook.openai.com/articles/using_goals_in_codex)
- Source: J.D. Hodges — [How to use Codex Goal Mode](https://www.jd-hodges.com/blog/how-to-use-codex-goal-mode/)
