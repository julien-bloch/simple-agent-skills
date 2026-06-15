---
name: file-browsing
description: Resolve vague references to files, code, notes, or projects to their actual locations on disk. Use this whenever the user mentions "this file", "my project", "that repo", "my notes", a project/repo by name without a full path, or asks where something lives — before searching the filesystem blindly or asking them where it is. Trigger it even when the reference is casual or partial.
---

# File browsing

When the user points at something on disk without giving a full path, figure
out where it is before acting.

## Steps

1. Regenerate the map. Run the bundled script so you're working from the
   current state of the filesystem, not a cached guess:

       bash scripts/generate-map.sh

   It prints the configured code roots (with each repo's README first line, so
   you can match by topic, not just name) and any configured note areas.

2. Match the user's reference against that output. Prefer an exact directory
   or repo name. If the reference is a topic ("the decoding pipeline", "the
   figure thing"), match against the README summaries and note-area names.

3. If exactly one location fits, use it. If several fit, ask which one in a
   single short question and list the candidates. If none fit, say so and ask
   for a path rather than guessing.

## Notes

The map is generated on demand, so it never goes stale. Don't carry paths
from a previous run into your reasoning; rerun the script.

For a notes reference, the map gives you the **area** folder; drill into it
with `find`/`grep` over `*.md` to land on a specific note.

The script is read-only and bounded in depth. If it doesn't find your code or
notes, the locations aren't configured yet — edit `CODE_ROOTS` / `NOTES_DIRS`
at the top of `scripts/generate-map.sh`.
