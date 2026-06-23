#!/usr/bin/env bash
# Regenerate a current map of where you keep code repositories on disk.
# Read-only. Personalize this by editing CODE_ROOTS below.
set -euo pipefail

# Directories that hold your repositories, one git repo per folder underneath.
# It scans up to MAXDEPTH deep, so light nesting is fine.
CODE_ROOTS=(
  "$HOME/dev"        # e.g. work
  "$HOME/projects"   # e.g. personal
)

MAXDEPTH=3

echo "# Repo map (generated $(date '+%Y-%m-%d %H:%M'))"
echo

found_any=0

for root in ${CODE_ROOTS[@]+"${CODE_ROOTS[@]}"}; do
  [ -d "$root" ] || continue
  found_any=1
  echo "## $root"
  while IFS= read -r gitdir; do
    repo="$(dirname "$gitdir")"
    summary=""
    for rd in "$repo/README.md" "$repo/README" "$repo/readme.md"; do
      if [ -f "$rd" ]; then
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

if [ "$found_any" -eq 0 ]; then
  echo "No configured repo roots exist yet. Edit CODE_ROOTS at the top of this"
  echo "script to point at where you keep code."
fi
