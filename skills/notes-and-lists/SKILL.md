---
name: notes-and-lists
description: Resolve and work with personal notes, Obsidian areas, todos, tasks, and lists. Use when the user mentions "my notes", "Obsidian", a note by topic, meeting notes, todos, tasks, lists, TickTick, or asks where something from notes or lists lives before searching broadly or asking for a path.
---

# Notes and Lists

When the user points at notes or lists without giving a full path or tool, find
the intended source before acting.

## Notes

1. Regenerate the note-area map:

       bash scripts/list-note-areas.sh

2. Match the user's reference against note areas. If an area fits, drill into it
   with `find` or `rg` over `*.md` to locate the specific note before relying on
   its contents.

3. If several areas or notes fit, ask one short question and list the
   candidates. If none fit, ask for a pointer instead of searching the whole
   home directory.

## Lists

For todos, tasks, and lists, prefer the user's connected list tool when
available. Do not treat a local note as the task source unless the user points
there or the list clearly lives in notes.

## Caveats

Some note apps store data in encrypted local databases rather than readable
markdown files. Do not add those database paths to the map; use the app's API
or connector instead.

The note-area map is generated on demand, so do not carry paths from previous
runs into a new task. The script is read-only. If note locations change, edit
the root list in `scripts/list-note-areas.sh`.
