---
name: pr-review-style
description: High-signal PR and code review guidance for actionable correctness-focused feedback. Use when reviewing pull requests, diffs, review comments, or code changes; when asked for a PR review style; or when drafting review comments or replies for the user to post, for scientific, data, ML, backend, security, or cache-sensitive code.
---

# PR Review Style

## Gathering Context

Pull the full context before reviewing, not just the diff: the PR description,
the commit history, and the comments. Comments include both the top-level
discussion and the inline review threads, which are a separate feed.

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
- Write-path changes that need a backfill or audit trail, or that silently
  hide or dedupe rows (duplicates may be intentional). Ask whether the change
  is always correct or only under an assumption.

Avoid leaving comments for:

- Speculative future problems
- Latent issues whose impact depends on usage or state you haven't checked,
  such as a path nothing calls or old jobs that won't rerun. Check it, ask it
  as a question, or leave it out.
- Merely imperfect architecture
- Cleanup that is not connected to the PR's risk
- Lifecycle/resource concerns unless they are likely to matter in normal use
- Style preferences already covered by formatters or linters

When a bug extends an existing risky contract, say that clearly. Do not
overstate it as newly introduced if the PR only widens the blast radius.

Hold another reviewer's findings (Codex, a sub-agent) to the same bar instead
of merging their list into yours: "verified in code" is not "worth a comment".
Before suggesting a fix, trace its side effects.

When fixing review findings yourself, keep the code no more complex than
before the review. Prefer a loud, exact check or a documented limit over a
heuristic that guesses intent (tolerant matching, inferred units or rates),
and add a valid-input test next to each refusal test. Heuristic fixes tend to
cause the next round's regressions.

When a subclass overrides a base-class template method (`fit_transform`,
`transform`, `fit`, ...) instead of the hook the base class provides (`_fit`,
`_transform`), list what the base version does that the override skips:
selection, history, validation, caching, timing. Ask for the override to call
through the base, unless skipping is the point. "Nothing observable changes
today" is not a reason to leave it: the skip goes silently wrong the first time
the base class adds a step or the subclass gains a parameter the base handles.
If the base class has no hook for what the subclass needs, say so; the fix is
usually to pass the missing signal through, not to bypass the base.

Before calling code unused or proposing to delete it, search where its users
actually live: investigation branches, archive tags, and other worktrees, not
just the PR branch. Library PRs are often carved out of experiment branches
whose scripts aren't in the PR.

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

## Text for the user to post

Anything the user will paste somewhere themselves (PR or review comments, thread
replies, PR descriptions, Slack messages) goes in a fenced `markdown` code
block, so the raw markdown survives copying. Never post it yourself unless they
ask you to.
