---
name: ux-review
description: Independently critique, audit, and test an existing website, app, screen, screenshot, HTML mockup, prototype, or frontend implementation. Use for UI or UX reviews, usability issues, interaction bugs, visual hierarchy and layout audits, accessibility and responsive checks, prioritized recommendations, and comparison of design revisions. Distinguish visible evidence, browser-verified behavior, inferred risks, and unknowns. Do not use as the primary UI-building workflow; use frontend-workflow to build or change an app's UI.
---

# UX Review

## Objective
Find consequential obstacles between a user and their intended outcome, not merely deviations from a stylistic preference. Deliver evidence-grounded, prioritized, implementable changes. Preserve strengths, acknowledge tradeoffs, and avoid hallucinating user research or interaction testing.

## Review modes

- **Screenshot / static design:** Inspect only what is visible. Flag possible interaction risks as hypotheses; do not claim to have clicked controls, checked keyboard access, or seen hidden states.
- **HTML / source code:** Review rendered UI if available and inspect relevant semantics, styles, and event handling. Code inspection alone does not prove behavior in a browser.
- **Working application:** If browser automation or computer-use tools are available, perform representative tasks and capture viewport-specific evidence. Do not assume tools exist.
- **Comparison / regression:** Use the same tasks, viewport, and evidence standard for before/after. Identify genuine improvements and new regressions.
- **Fix requested:** After reporting, apply narrowly scoped repairs and re-verify if editing tools are available. If the user requested critique only, do not change files.

## Workflow

1. **Establish context.** Identify target user, task, screen role (overview/focus/make/do), platform, constraints, and any known success metric. If unknown, state the task assumption rather than inventing product research.
2. **Gather inspectable evidence.** Examine supplied images, mockups, application, or code. If available and proportionate to the request, test primary flows, open menus, exercise keyboard controls, and check narrow/mobile and wide viewports. See [browser-review.md](references/browser-review.md).
3. **Audit user outcomes before polish.** Inspect: task clarity; navigation and wayfinding; scanability and hierarchy; collection and disclosure patterns; action feedback and recovery; content clarity and trust; responsive behavior; accessibility; visual coherence. Use [review-heuristics.md](references/review-heuristics.md). Don't assume the same pattern is optimal for every task.
4. **Separate evidence from inference.** Tag findings: **V** visible in supplied artifact, **T** personally tested in a working UI, **C** verified in code but not executed, **H** plausible hypothesis, **U** unknown/needs measurement. Report exactly what was observed. Never call model simulation a user study.
5. **Prioritize.** Assign **Critical** (blocks completion, serious harm, loss), **High** (major friction in common/important task), **Medium** (meaningful but nonblocking cost), or **Low** (minor polish). Consider task impact, likely exposure, recoverability, and evidence confidence; do not manufacture numeric certainty.
6. **Recommend actionable fixes.** For each substantive finding include: where, evidence, why it matters, concrete modification, and verification step. Prefer 3-7 high-value findings; more only when warranted. Preserve good choices explicitly and offer alternatives when a tradeoff is genuine.
7. **Close the loop.** If editing was requested, make targeted changes, rerun affected checks, and report remaining limitations. If research is needed, propose a small realistic user task or experiment rather than guessing preferences. See [reporting-and-evaluation.md](references/reporting-and-evaluation.md).

## Guardrails

- Do not turn critique into an unsolicited rebrand or rebuild; keep the application's identity and working features unless they cause a concrete problem.
- Do not reward sparse screens indiscriminately. Evaluate information density against scanning, comparison, and decision-making needs.
- Do not score visual taste as a usability defect. Label subjective preference separately.
- Do not claim a menu is broken based solely on its static screenshot; distinguish awkward appearance from tested clipping or inaccessible choices.
- Do not use generic findings such as "improve spacing" without a location, consequence, and recommended change.
- Do not assert that a design will increase conversions or satisfaction without measuring it.
- Do not conflate heuristic review, automated checks, and observing real people: all provide different evidence.
- When source data, screenshots, or code are insufficient, state the limitation and provide a narrow next test.

## Default report

1. **Verdict:** One paragraph describing fitness for the stated task; include what works.
2. **Priority findings:** Ordered by severity and user impact; each finding follows `location -> evidence tag -> consequence -> fix -> verification`.
3. **Keep:** Important strengths not to accidentally regress.
4. **Unknowns / tests:** Separate uncertain product decisions from visually demonstrable problems.
5. **If changes were made:** Changed artifacts, actual checks, and unverified states.

Use the short form for simple screenshot critiques. Do not let a formal template obscure the useful answer.

## Reference loading

- [review-heuristics.md](references/review-heuristics.md): conditional inspection rubric and common failure patterns.
- [browser-review.md](references/browser-review.md): browser-based task protocol, viewport and accessibility smoke tests, evidence rules.
- [reporting-and-evaluation.md](references/reporting-and-evaluation.md): severity, evidence labels, concrete examples, comparing revisions.
