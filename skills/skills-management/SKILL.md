---
name: skills-management
description: Notice when something learned in a conversation should live in a skill - a correction or preference the user keeps repeating, a memory note that is really a general rule, a skill that is out of date or conflicts with memory or with what they just asked - and suggest the change to the user instead of letting it stay buried in one chat. Use during or at the end of long sessions, after corrections, and when a skill's guidance and the user's instructions disagree.
---

# Skills management

Skills in this repo are how the user's preferences carry across sessions and agents. Things learned in one long
chat (a correction, a better way of working, a rule that turned out wrong) are easy to lose: they stay in the
transcript or in a memory note that only one agent sees. This skill is about noticing those and **suggesting** the
update. The user decides.

## Signals worth a suggestion

- **A repeated correction or preference** ("run the tests before saying it's done", "keep review comments to
  correctness") that would apply beyond this task.
- **A memory note that reads like a general rule** rather than a fact about one project. Memory is per-agent and per-
  repo; a skill is shared and on-demand.
- **A skill that no longer matches practice:** the user asked for something the skill forbids, or a step it requires
  keeps getting skipped for a good reason.
- **A conflict** between a skill and memory, between two skills, or between a skill and what the user just said.
- **A workflow that worked well and was built ad hoc** (a review loop, a release checklist) and would help next time.

Not every lesson needs a skill. One-off facts, project state and anything the repo already records stay where they
are.

## How to suggest

- **Ask at a natural pause** (end of a task, a check-in, before the chat ends), not mid-flow, unless the conflict
  affects what you're about to do.
- **Be concrete:** which skill (or a new one), the proposed wording, and the conversation moment it comes from. One
  short message; the user can say yes, edit it, or drop it.
- **Prefer softer, general wording.** Capture the principle, not the one file or task it came up with. When in
  doubt, keep it a little softer.
- **Flag conflicts explicitly:** quote both sides and say which one you've been following.

## Where things go

- `skills/<name>/` in this repo is shared by Claude Code and Codex (and linked by `install.sh`).
- `AGENTS.md` is the always-on layer, loaded every turn; it's only for short dispositions that should always hold.
- Agent memory is for facts about the user, projects and references, not for rules every agent should follow.

## Editing

- **Edit only after the user agrees.** Keep the skill's existing style and section structure; fit the new rule where
  it belongs instead of appending a list at the end.
- **Don't commit this repo unless the user asks.** Say what changed and leave it for them to commit.
- After an edit, update or remove any memory note it supersedes, so the two don't drift apart.
