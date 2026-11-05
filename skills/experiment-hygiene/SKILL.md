---
name: experiment-hygiene
description: Judgment rules for planning, running, comparing and reporting ML or data experiments (baselines, ablations, seeds, sweeps, tuning, benchmarks) so results are honest and decisions hold on new data. Use when running or comparing models, reading a benchmark result, choosing what to promote, or reporting experiment results.
---

# Experiment hygiene

Rules for experiments that produce numbers someone will act on. They apply to
any project; follow the project's own tooling for how runs are launched and
logged.

## Decisions and scope

- **Act only on an explicit go.** A question is not a decision: answer it,
  recommend, then ask. Work already approved continues after you answer.
- **Build exactly the set that was asked for.** When the user names models or
  arms, don't add extras. Propose a broader comparison in one line and run it
  only on a go.
- **Ask about experimental context** before using the structure of the data
  (repeated events, windows, blocks) as extra training data or labels. Whether
  a later event is the same condition as the first is domain knowledge the code
  doesn't encode.
- **Weigh insight against runtime.** Before launching, estimate the run time and
  say what the run will tell you.

## Evaluation design

- **Split by the unit you need to generalize to.** If the question is "does
  it work on a new subject, session, site or later time", whole subjects,
  sessions, sites or time blocks go to one side of each split. Windows from the
  same trial, duplicate records and neighbouring time points never straddle
  train and test. Assert the separation in code.
- **Fit every stateful step inside the fold:** scaling, alignment, feature
  selection, anything that learns from data. If a step is fitted on all the
  data to save compute, label it as leakage where the result is reported.
- **Use the same folds and seeds for every arm being compared.** Reuse earlier
  results only when the folds match.
- **Score exactly the subset the user specifies.** Restate the rule in a code
  comment, check in code that the scored set matches it, and show a broader
  view only as a labeled extra.
- **A tuned value must hold on data it never saw.** Fix the selection rule in
  advance and choose on validation data, not the test set.
- **Match the result to the question.** "How well does it work here" and "which
  method should we ship" need different evaluations; the second is decided on
  data that wasn't used to design or tune the method.
- **Watch for test-set reuse.** A test set used to choose between arms across
  many experiments slowly becomes development data. Keep some data untouched for
  the final check.
- **Screen fast, then confirm.** One seed to explore, then several seeds plus
  held-out data. Write the rule for dropping a losing arm before running, and
  record dropped arms as results.

## Before trusting a number

- **Sanity-check against the known ordering.** A result that contradicts the
  domain's expectations is a bug until proven otherwise.
- **Confirm a diagnosis by exact reproduction,** not plausibility.
- **Inspect what the pipeline actually receives:** shapes, axes, units, sampling
  rate. Library wrappers can silently drop data, so check what they pass on.
- **Look for confounds first,** such as order effects or drift over time.
- **Say what a gain is not yet attributed to** when a change touched several
  parts at once.
- **Re-run and separate verified from inferred** before presenting a
  sub-agent's claim.
- **Report per dataset or group, not only pooled.** A pooled gain can come from
  one group alone.

## Compute

- **Check the machine before launching** and leave headroom for other jobs.
  Run near 100% CPU but under it, count nested parallelism, and never let the
  machine swap.
- **Keep long runs alive and visible:** `caffeinate -i` on macOS, `tmux` or
  `nohup` on Linux, unbuffered output (`python -u`).

## Repo

- **Commit scripts, not data.** Leave result files untracked and say how to
  regenerate them.
- **Archive, don't squash, a finished investigation.** Results cite commit
  hashes, so tag the branch (for example `archive/<topic>`) with a note on what
  it holds, and extract what ships into small, separate branches.
