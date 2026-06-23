---
name: find-relevant-repos
description: Resolve vague references to code repositories, projects, worktrees, or codebases to their actual local paths. Use when the user mentions "that repo", "my project", a product or pipeline by topic, a codebase without a full path, or asks where code lives before editing, searching broadly, or asking for a path.
---

# Find Relevant Repos

When the user points at code without giving a full path, locate the most likely
repo first and use that as the working directory.

## Steps

1. Regenerate the repo map:

       bash scripts/list-repos.sh

2. Match the user's reference against repo names and README summaries. Prefer an
   exact repo or directory name. For topic references, use README summaries and
   nearby project names.

3. If exactly one repo fits, work there. If several fit, ask one short question
   and list the candidates. If none fit, ask for a path instead of searching the
   whole home directory.

## Notes

The map is generated on demand, so do not carry paths from previous runs into a
new task. The script is read-only and bounded in depth. If repo locations
change, edit the root list in `scripts/list-repos.sh`.
