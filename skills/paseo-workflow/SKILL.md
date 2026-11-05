---
name: paseo-workflow
description: A way to open isolated work in Paseo - reviewing a PR, working on a branch, or delegating a task in its own git worktree so it shows up in the Paseo app as a workspace with its own agent chat. Use when the user asks to open a new worktree, review PR N in a worktree, spin up a parallel agent on a branch, or clean one up. For the full command reference use the paseo skill; for Paseo product questions use paseo-help.
---

# Paseo Workflow

The Paseo app shows **workspaces**, and each workspace holds agent chats,
terminals and diffs. A git worktree is just how a workspace isolates its
files. So open work as a workspace, not as a bare worktree.

## Open it

One command creates the worktree, registers the workspace in the app and
starts an agent chat in it:

    paseo run -d --provider claude --mode auto \
      --new-workspace worktree --worktree-mode checkout-pr --pr-number <N> \
      --cwd <repo> --json "<prompt>"

- Pass `-d` (background). Without it `paseo run` blocks until the agent
  finishes, so a second launch in the same command waits behind the first.
- `--new-workspace worktree` creates a new git worktree under
  `~/.paseo/worktrees/`, one per workspace.
- Use `paseo run --new-workspace` (or `paseo workspace create` when the user
  wants the workspace without an agent). Not `paseo worktree create`: that
  makes a bare git worktree, and the docs don't say it appears in the app.
- `--provider` is required. Default to `claude`; use `codex` when the user asks.
- Pass `--mode auto`. Without it the agent starts in Always Ask and stalls on
  its first Bash call until the user approves it in the app. Never approve the
  agent's permissions on their behalf.
- Other modes: `--worktree-mode checkout-branch --branch <name>` for an
  existing branch, `--worktree-mode branch-off --new-branch <name> --base
  origin/main` for new work.
- First resolve the repo path (find-relevant-repos) and check that the PR or
  branch exists (`gh pr view <N>`).

## Prompt the agent

State the task and the bar it should meet, and say where results go. For a
PR review:

    Review PR <N> (<branch>, '<title>') against main. Use the pr-review-style
    skill's bar: high-signal correctness findings only. Run the relevant tests
    where useful. Do NOT post anything to GitHub; report findings in chat as
    draft comments (file:line + comment text) that the user can post themselves.

Add repo-specific checks when they apply, for example the leakage rules in a
repo's own agent guide.

## Verify and report

- `git -C <repo> worktree list` shows the new path under
  `~/.paseo/worktrees/`, and its HEAD matches
  `gh pr view <N> --json headRefOid`. `paseo inspect` shows `Worktree: null`
  for these agents; ignore that and trust git.
- Tell the user the workspace id and title, the agent id, the worktree path,
  the branch at its sha, and whether the agent is waiting on a permission.
- Polling is fine: check `paseo ls` / `paseo logs <agent-id>` every few
  minutes, and bring the findings back here when the agent finishes instead
  of waiting for the user to ask.

## Clean up

Only when the user says so. `paseo workspace archive <workspace-id>` archives
the workspace, its agents and terminals, and removes the worktree it owns.
`paseo worktree archive` also deletes the local branch, so check for
unpushed commits before either.
