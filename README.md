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
    ├── clarity/
    ├── experiment-hygiene/
    ├── find-relevant-repos/
    ├── frontend-workflow/
    ├── landing-page-design/
    ├── notes-and-lists/
    ├── paseo-workflow/
    ├── pr-review-style/
    ├── skills-management/
    └── ux-review/
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
otherwise out of the way — like finding the right repo, reading notes, or
using a specific PR review style.

## A scaffold for global behavior

Think of this repo as the scaffold for agent behavior that should be **global**
— shared by both Claude Code and Codex, across every repo, not pinned to one
project. `AGENTS.md` holds the always-on rules; `skills/` holds the reusable,
on-demand capabilities. It ships with small skills for finding repos, working
with notes/lists, reviewing PRs in a high-signal style, and suggesting skill
updates learned in a conversation.

| Skill | What it's for |
| --- | --- |
| `find-relevant-repos` | Resolve "that repo" or "my X project" to a real path |
| `notes-and-lists` | Find notes and lists by topic before searching broadly |
| `pr-review-style` | High-signal, correctness-first code review |
| `skills-management` | Suggest skill updates learned in a conversation |
| `experiment-hygiene` | Honest ML and data experiments: folds, scoring, confounds |
| `clarity` | Draft, rewrite or review prose so it reads like you, not like AI |
| `frontend-workflow` | Build a web UI and check it in a real browser |
| `ux-review` | Critique and test an existing UI |
| `paseo-workflow` | Optional, for Paseo users: open a PR review or branch as its own workspace |
| `landing-page-design` | Distinctive landing and marketing pages |

### I work in Paseo

I run my agents in [Paseo](https://paseo.sh), an app that runs Claude Code and
Codex agents side by side, each in its own workspace with its chat, terminals
and diffs. These skills don't require it, but some of them were written around
it, so if you want to copy how I work, it's worth installing:

- `frontend-workflow` and `ux-review` check UIs with Paseo's built-in browser
  tools, and fall back to whatever browser tool your agent has.
- `paseo-workflow` (optional) is how I open a PR review or a branch as its own
  workspace, each in a separate git worktree with its own agent chat. Skip it
  if you don't use Paseo.
- I also use Paseo's own [orchestration skills](https://paseo.sh/docs/skills.md):
  `paseo` (the reference for launching and managing agents and workspaces),
  `paseo-handoff`, `paseo-advisor` (a second opinion) and `paseo-committee`
  (two independent analyses of a hard problem). They aren't in this repo and
  aren't installed by default: pick them in Paseo under **Settings → your host →
  Agents → Orchestration skills**, or run `npx skills add getpaseo/paseo`.
  `paseo-workflow` builds on the `paseo` skill.

### Design mockups

For UI mockups, prototypes and icons I don't ship a skill here. Get the
`claude-design` skill from [jimliu/baoyu-design](https://github.com/jimliu/baoyu-design),
which puts design options side by side on a canvas (check its `NOTICE.md` for
which parts are under which terms). The loop I run with it:

1. **Ask before drawing.** What it builds on (an existing app, a design system,
   screenshots, a brand), wireframe or polished, which screens, and how many
   options and what they should vary.
2. **Make several options at once,** side by side on one canvas, each labeled
   so you can name the one you mean.
3. **Check them in a browser.** Serve the folder over local HTTP rather than
   opening files directly, look at the sizes that matter, and fix console
   errors before showing anything.
4. **Show them the way you'll judge them:** screenshots in chat for quick
   picks, the canvas in a browser for a real comparison. To look from your
   phone or another machine, open a Cloudflare quick tunnel,
   `cloudflared tunnel --no-autoupdate --url http://localhost:PORT`, and send
   the `trycloudflare.com` link. Anyone with the link can see the folder, so
   stop the tunnel when you're done.
5. **Refine until one is picked.** Copy the file before a big revision, take
   feedback, and narrow down. Then build the winner into the app with
   `frontend-workflow`.

For icons or artwork that hand-drawn SVG can't carry, generate images with the
Codex CLI, for example `codex exec -C designs/<project> "<what to draw>. Save it
as <name>.png in this folder."`

Some skills build on others' work, under their licenses (kept next to the
files):

- `clarity` is [addyosmani/clarity](https://github.com/addyosmani/clarity)
  (MIT), lightly edited; its AI-patterns catalog is adapted from
  [blader/humanizer](https://github.com/blader/humanizer) (MIT).
- `landing-page-design` is Anthropic's `frontend-design` skill from
  [anthropics/skills](https://github.com/anthropics/skills) (Apache 2.0),
  narrowed to landing pages: its bold, distinctive styling suits pages that
  sell, not everyday app screens, which `frontend-workflow` covers. It also
  adds a step to confirm the page's main idea first.

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
> `skills/find-relevant-repos/scripts/list-repos.sh`, plus
> `skills/notes-and-lists/scripts/list-note-areas.sh` if they keep readable
> notes on disk.

Setup is five steps. Step 2 is required — the repo skill finds nothing until
you point it at your code. Steps 3–4 are optional.

### 1. Put the repo somewhere permanent

The installer points symlinks at wherever this folder lives, so don't keep it
in Downloads. Somewhere like `~/simple-agent-skills` or
`~/dev/simple-agent-skills`. If you move it later, just rerun `./install.sh`
from the new location.

```bash
git clone <your-fork-url> ~/simple-agent-skills
cd ~/simple-agent-skills
chmod +x install.sh skills/find-relevant-repos/scripts/list-repos.sh
chmod +x skills/notes-and-lists/scripts/list-note-areas.sh
```

### 2. Tell it where your code lives (required)

Open `skills/find-relevant-repos/scripts/list-repos.sh` and edit the
`CODE_ROOTS` list. These are the directories that the repo skill scans so it
can resolve "my X project" to a real path. Answer these questions:

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

Open `skills/notes-and-lists/scripts/list-note-areas.sh` and edit
`NOTE_ROOTS`. These are directories whose **top-level folders** are treated as
note areas (e.g. an Obsidian vault). Leave it empty if you don't keep notes
this way. Answer:

- **Do you keep markdown notes in one root?** If yes, give its path. For
  Obsidian on macOS that's usually
  `~/Library/Mobile Documents/iCloud~md~obsidian/Documents`.
- **Anything that *can't* be read as plain files?** Some apps encrypt their
  data at rest (e.g. Granola stores notes in an encrypted SQLCipher db). Don't
  list those — there's no readable path. Reach them via the app's API instead.

```bash
NOTE_ROOTS=(
  "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents"
)
```

Sanity-check your edits by running the scripts — they should print your repos
and note areas:

```bash
bash skills/find-relevant-repos/scripts/list-repos.sh
bash skills/notes-and-lists/scripts/list-note-areas.sh
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

A running session doesn't need restarting for skills: an edited `SKILL.md` is
read the next time that skill fires, and a newly linked skill shows up within
about a minute. `AGENTS.md` is the exception — it's read once at session start,
so an edit to it needs a restart.

## Adding a skill

Make a folder under `skills/`, drop in a `SKILL.md` with `name` and
`description` frontmatter, rerun `./install.sh`, and commit it. Claude Code
picks it up in-session; Codex on its next run.

Keep the description specific — it's the trigger. Write it to fire even on
casual phrasing, since these tools tend to under-use skills rather than
over-use them.

## Maintenance

Treat this like code. Prune skills that go stale, because a skill with wrong
instructions is worse than no skill. The repo and notes skills avoid this by
regenerating maps from the live filesystem on every run instead of hardcoding
specific repo or note paths.
