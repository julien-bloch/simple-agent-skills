#!/usr/bin/env bash
# Regenerate a current map of where you keep code and notes on disk.
# Read-only. This is the one file you personalize: edit the two lists below.
set -euo pipefail

# 1. CODE: directories that hold your repositories, one git repo per folder
#    underneath (it scans up to MAXDEPTH deep, so light nesting is fine).
#    Replace these examples with your real layout. The trailing comment after
#    each entry shows up nowhere — it's just a note to yourself.
CODE_ROOTS=(
  "$HOME/dev"        # e.g. work
  "$HOME/projects"   # e.g. personal
)

# 2. NOTES: directories whose top-level folders are note areas/vaults
#    (e.g. an Obsidian vault's Documents folder). Leave empty if you have none.
NOTES_DIRS=(
  # "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents"
)

MAXDEPTH=3

echo "# Filesystem map (generated $(date '+%Y-%m-%d %H:%M'))"
echo

found_any=0

# --- Code repositories ---
for root in ${CODE_ROOTS[@]+"${CODE_ROOTS[@]}"}; do
  [ -d "$root" ] || continue
  found_any=1
  echo "## $root"
  while IFS= read -r gitdir; do
    repo="$(dirname "$gitdir")"
    summary=""
    for rd in "$repo/README.md" "$repo/README" "$repo/readme.md"; do
      if [ -f "$rd" ]; then
        # prefer the first descriptive line, fall back to the heading
        summary="$(grep -m1 -E '^[[:space:]]*[^#[:space:]]' "$rd" 2>/dev/null | sed 's/^[[:space:]]*//' | cut -c1-100 || true)"
        if [ -z "$summary" ]; then
          summary="$(grep -m1 -E '\S' "$rd" 2>/dev/null | sed 's/^#\+ *//' | cut -c1-100 || true)"
        fi
        break
      fi
    done
    if [ -n "$summary" ]; then
      echo "- $repo | $summary"
    else
      echo "- $repo"
    fi
  done < <(find "$root" -maxdepth "$MAXDEPTH" -type d -name .git 2>/dev/null | sort)
  echo
done

# --- Note areas ---
# Guard the expansion: an empty array trips `set -u` on bash 3.2 (macOS default).
for notes in ${NOTES_DIRS[@]+"${NOTES_DIRS[@]}"}; do
  [ -d "$notes" ] || continue
  found_any=1
  echo "## Notes ($notes)"
  while IFS= read -r dir; do
    echo "- ${dir%/}"
  done < <(find "$notes" -mindepth 1 -maxdepth 1 -type d ! -name '.*' 2>/dev/null | sort)
  echo "  (match an area, then grep/find *.md inside it for a specific note)"
  echo
done

if [ "$found_any" -eq 0 ]; then
  echo "No configured locations exist yet. Edit CODE_ROOTS / NOTES_DIRS at the"
  echo "top of this script to point at where you keep code and notes."
fi
