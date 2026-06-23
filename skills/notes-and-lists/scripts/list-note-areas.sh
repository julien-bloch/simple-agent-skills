#!/usr/bin/env bash
# Regenerate a current map of where you keep local note areas.
# Read-only. Personalize this by editing NOTE_ROOTS below.
set -euo pipefail

# Directories whose top-level folders are note areas/vaults.
# Leave empty if you do not keep readable markdown notes on disk.
NOTE_ROOTS=(
  # "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents"
)

echo "# Note areas (generated $(date '+%Y-%m-%d %H:%M'))"
echo

found_any=0

for notes in ${NOTE_ROOTS[@]+"${NOTE_ROOTS[@]}"}; do
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
  echo "No configured note roots exist yet. Edit NOTE_ROOTS at the top of this"
  echo "script to point at where you keep readable notes."
fi
