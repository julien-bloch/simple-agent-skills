---
name: pr-review-style
description: High-signal PR and code review guidance for actionable correctness-focused feedback. Use when reviewing pull requests, diffs, review comments, or code changes; when asked for a PR review style; or when drafting review comments for scientific, data, ML, backend, security, or cache-sensitive code.
---

# PR Review Style

## Review Bar

Optimize for high-signal comments only. Prefer fewer comments that are clearly
actionable over a long list of possible concerns.

Prioritize:

- Silent wrong results
- Data leakage across folds, animals, sessions, subjects, batches, or splits
- Cache/key invalidation bugs
- Security or data-loss risks
- Regressions in public behavior
- Missing validation at trust boundaries

Avoid leaving comments for:

- Speculative future problems
- Merely imperfect architecture
- Cleanup that is not connected to the PR's risk
- Lifecycle/resource concerns unless they are likely to matter in normal use
- Style preferences already covered by formatters or linters

When a bug extends an existing risky contract, say that clearly. Do not
overstate it as newly introduced if the PR only widens the blast radius.

## Comment Style

Write comments in a short, concrete, direct, low-drama voice:

- Lead with the failure mode.
- Explain why it matters in one or two sentences.
- Ask for the smallest practical fix.
- Avoid formal review language like "it is recommended."
- Use "I think" when the fix is judgment-based, not when the bug is certain.
- Do not include broad rewrites, optional refactors, or multiple alternative
  designs unless needed.

For scientific and data code, be especially strict about anything that can run
cleanly and lie. Prefer comments on silent stale caches, wrong grouping,
cross-split contamination, implicit dtype/shape/unit assumptions, or reused
state over comments on memory or lifecycle cleanup unless cleanup affects
correctness.

## Output Shape

For review findings, lead with the findings ordered by severity and grounded in
file and line references when available. If there are no high-signal findings,
say that clearly and mention only meaningful residual test gaps or risk.
