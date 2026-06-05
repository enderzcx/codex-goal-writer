# Product Manager Scenarios

## When To Read This

Read this reference when the user is a PM or product person who wants to use `/goal` for research, backlog triage, release readiness, or decision preparation — work that does not involve writing production code.

## Core Principle

PM `/goal` turns "fuzzy product wishes" into "verifiable work loops". PMs do not need to write code, but must define outcome, evidence, constraints, and decision boundaries.

**Codex can organize evidence, generate options, run analysis, and clean backlogs — but it should not make irreversible product decisions.**

## Converting Requirements To Goals

**Bad:**

```text
帮我整理一下用户反馈，看看要不要做导出功能。
```

**Better:**

```text
/goal Consolidate user feedback about export functionality from provided sources into export_feature_evidence.md.
Read-only only. Do not send messages or edit tickets.
Classify each feedback item by user segment, use case, pain severity, workaround, revenue/account signal, and linked evidence.
Group duplicates and separate direct user evidence from internal guesses.
Output:
1. top 5 use cases;
2. evidence table;
3. opportunity sizing caveats;
4. product decision options;
5. questions requiring PM judgment.
Pause if source access is missing or if privacy-sensitive data needs approval.
```

## General PM Constraints

Always include these unless the user explicitly overrides:

```text
Do not decide roadmap priority.
Do not close customer commitments.
Do not message customers.
Do not change public docs or pricing.
Prepare recommendations and evidence for human review.
```

## Scenario A: Backlog Deduplication

```text
/goal Deduplicate backlog items related to [theme] and produce a reviewable merge plan.
Do not close or edit issues.
Group duplicates under canonical issues, preserve customer evidence, and identify items that should remain separate.
Output backlog_dedup_plan.md with issue links, rationale, and proposed actions.
```

## Scenario B: Release Readiness Audit

```text
/goal Audit release readiness for [feature] against launch_checklist.md.
Read code, docs, tests, analytics events, and known issues.
Output pass/fail/blocked for each checklist item with evidence.
Do not deploy or change external systems.
Pause if an item requires PM/Legal/Support approval.
```

## Scenario C: Metric Anomaly Investigation

```text
/goal Investigate why [metric] changed during [time window] and produce a reproducible analysis report.
Inputs: dashboard export, event logs, release notes.
Output metric_investigation.md with timeline, hypotheses, supporting/refuting evidence, caveats, and recommended next checks.
Do not claim causality unless supported by controlled comparison.
Pause if required data definitions are missing.
```

## Scenario D: Competitive Brief

```text
/goal Create a competitive evidence brief for [competitor/feature] using the provided sources and public docs.
Output competitive_brief.md with feature comparison, pricing/packaging notes, screenshots/links if available, positioning implications, and uncertainties.
Do not scrape behind login or bypass access controls.
Separate sourced facts from interpretation.
```

## Scenario E: Research Reproduction

```text
/goal Reproduce the main quantitative claims in paper.pdf as far as this workspace allows.
Create a claim checklist that separates headline claims, supporting claims, and blocked claims.
For each claim, identify the required data/code/metric, implement the smallest runnable reproduction, run it, and record evidence in reproduction_report.md.
Do not claim a result is reproduced unless the report includes the command, parameters, output, and comparison against the paper.
If a claim depends on unavailable data, excessive compute, or ambiguous methodology, mark it blocked with the exact reason.
```

## How To Review Codex's Output

PMs should check:

- Evidence links are real, not hallucinated.
- Facts and interpretation are clearly separated.
- Key user segments are not omitted.
- Minority signals are not inflated into trends.
- Unverifiable causal claims are flagged.
- Privacy/permission issues are noted.
- Items requiring human decision are explicitly listed.

## References

- Source: Claire Vo (OpenAI) via Lenny's Podcast — Sentry cleanup, email triage, Linear backlog
- Source: OpenAI Developers — [Analyze datasets and ship reports](https://developers.openai.com/codex/use-cases/datasets-and-reports)
- Source: OpenAI Cookbook — [Using Goals in Codex](https://cookbook.openai.com/articles/using_goals_in_codex)
