# simple-agent-skills

One place to own how your coding agents behave. This repo is the source of
truth; Claude Code and Codex (and optionally Hermes) are just readers of it,
wired up with symlinks. Edit a file here and both tools see the change.

## Layout

```
simple-agent-skills/
├── AGENTS.md            # always-on rules, loaded every turn
├── install.sh           # symlinks everything into both tools
└── skills/
    └── file-browsing/   # on-demand skill, pulled only when relevant
        ├── SKILL.md
        └── scripts/
            └── generate-map.sh
```

## Two layers

`AGENTS.md` is the **always-on** layer. It loads on every session in both
tools and stays in context the whole time, so it's for dispositions that
should always be true (like "write the least code that works"). Keep it short.

> The agreements in `AGENTS.md` are a minimalism credo — write as little code
> as possible, and as simple as possible. It's inspired by the **caveman**,
> **ponytail**, and **karpathy-coding-skills** skills, distilled down into a
> single always-on file instead of a separate plugin.

`skills/` is the **on-demand** layer. Each skill's name and description load at
session start, but its body only loads when the description matches what
you're doing. That's for capabilities you want pulled in when relevant and
otherwise out of the way — like resolving "this file" to a real path.

## A scaffold for global behavior

Think of this repo as the scaffold for agent behavior that should be **global**
— shared by both Claude Code and Codex, across every repo, not pinned to one
project. `AGENTS.md` holds the always-on rules; `skills/` holds the reusable,
on-demand capabilities. It ships with one skill (`file-browsing`) as a worked
example.

It's the right home for cross-cutting skills you want available everywhere,
added as you need them — for example a `code-review` skill or a
`data-analysis` skill. Drop each one in as its own folder under `skills/`,
rerun `./install.sh`, and it's live in both tools for all repos. Keep
project-specific skills in that project's own `.claude/skills` instead; only
what's genuinely global belongs here.

## Get started

> **If an agent is setting this up for you:** don't guess the answers below.
> Ask the human each question, then write their answers into the files as
> described. The only file that needs personalizing is
> `skills/file-browsing/scripts/generate-map.sh`.

Setup is five steps. Step 2 is required — the file-browsing skill finds
nothing until you point it at your code. Steps 3–4 are optional.

### 1. Put the repo somewhere permanent

The installer points symlinks at wherever this folder lives, so don't keep it
in Downloads. Somewhere like `~/simple-agent-skills` or
`~/dev/simple-agent-skills`. If you move it later, just rerun `./install.sh`
from the new location.

```bash
git clone <your-fork-url> ~/simple-agent-skills
cd ~/simple-agent-skills
chmod +x install.sh skills/file-browsing/scripts/generate-map.sh
```

### 2. Tell it where your code lives (required)

Open `skills/file-browsing/scripts/generate-map.sh` and edit the `CODE_ROOTS`
list. These are the directories that the file-browsing skill scans so it can
resolve "my X project" to a real path. Answer these questions:

- **Which top-level folders hold your repositories?** (e.g. `~/dev`,
  `~/work`, `~/code`.) List each one.
- **Do you separate work from personal?** If so, list both roots — the
  trailing `# comment` on each line is a note to yourself about what it is.
- **How are repos nested?** One git repo directly per folder is the common
  case and works out of the box. The scan goes 3 levels deep (`MAXDEPTH`), so
  light nesting like `~/code/<org>/<project>` is fine too.

```bash
CODE_ROOTS=(
  "$HOME/work"     # work repos
  "$HOME/dev"      # personal projects
)
```

### 3. Tell it where your notes live (optional)

Still in `generate-map.sh`, edit `NOTES_DIRS`. These are directories whose
**top-level folders** are treated as note areas (e.g. an Obsidian vault).
Leave it empty if you don't keep notes this way. Answer:

- **Do you keep markdown notes in one root?** If yes, give its path. For
  Obsidian on macOS that's usually
  `~/Library/Mobile Documents/iCloud~md~obsidian/Documents`.
- **Anything that *can't* be read as plain files?** Some apps encrypt their
  data at rest (e.g. Granola stores notes in an encrypted SQLCipher db). Don't
  list those — there's no readable path. Reach them via the app's API instead.

```bash
NOTES_DIRS=(
  "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents"
)
```

Sanity-check your edits by running the script — it should print your repos and
note areas:

```bash
bash skills/file-browsing/scripts/generate-map.sh
```

### 4. (Optional) Make the rules yours

`AGENTS.md` ships with a set of working agreements. Read it and adjust to your
taste — it loads on every turn, so it's the strongest lever you have.

### 5. Wire it into your tools

```bash
./install.sh            # Claude Code + Codex
./install.sh --hermes   # also wire up Hermes
```

This symlinks:

- `AGENTS.md` → `~/.codex/AGENTS.md` (Codex reads this name natively)
- `AGENTS.md` → `~/.claude/CLAUDE.md` (Claude Code reads this name; same file)
- each skill folder → `~/.claude/skills/` and `~/.codex/skills/`

With `--hermes` it also links skills into `~/.agents/skills/` (shared with
Codex) and appends a one-line pointer to `~/.hermes/SOUL.md`.

Existing real files at those paths are backed up before linking, and re-running
is safe. Then verify and restart any open session so it picks up the links:

```bash
ls -l ~/.codex/AGENTS.md ~/.claude/CLAUDE.md
ls -l ~/.claude/skills/ ~/.codex/skills/
```

## Editing vs. reinstalling

The install is symlinks, not copies, so **editing a file here changes what
both tools read** — no reinstall needed. Rerun `./install.sh` only when the
*set* of links changes: you add or rename a skill, or you move the repo.
(A session that's already running may need a restart to pick up an edit.)

## Adding a skill

Make a folder under `skills/`, drop in a `SKILL.md` with `name` and
`description` frontmatter, rerun `./install.sh`, and commit it. Claude Code
picks it up in-session; Codex on its next run.

Keep the description specific — it's the trigger. Write it to fire even on
casual phrasing, since these tools tend to under-use skills rather than
over-use them.

## Maintenance

Treat this like code. Prune skills that go stale, because a skill with wrong
instructions is worse than no skill. The file-browsing skill avoids this by
regenerating its map from the live filesystem on every run instead of
hardcoding paths.
