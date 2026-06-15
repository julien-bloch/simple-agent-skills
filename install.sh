#!/usr/bin/env bash
# Install agent-config: symlink the always-on rules and skills into
# Claude Code and Codex (and optionally Hermes). Safe to re-run.
#
# Usage:
#   ./install.sh            # Claude Code + Codex
#   ./install.sh --hermes   # also link skills into ~/.agents/skills and
#                           # add a SOUL.md pointer for Hermes
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HERMES=0
[ "${1:-}" = "--hermes" ] && HERMES=1

backup_if_real() {
  # If a real (non-symlink) path exists at $1, move it aside.
  if [ -e "$1" ] && [ ! -L "$1" ]; then
    mv "$1" "$1.bak.$(date +%s)"
    echo "  backed up existing $1"
  fi
}

link_file() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  backup_if_real "$dst"
  ln -sfn "$src" "$dst"
  echo "  linked $dst -> $src"
}

link_skill() {
  local src="$1" dstdir="$2"
  mkdir -p "$dstdir"
  local name; name="$(basename "$src")"
  backup_if_real "$dstdir/$name"
  ln -sfn "$src" "$dstdir/$name"
  echo "  linked $dstdir/$name -> $src"
}

echo "Installing from $REPO"

echo "Always-on rules:"
link_file "$REPO/AGENTS.md" "$HOME/.codex/AGENTS.md"
link_file "$REPO/AGENTS.md" "$HOME/.claude/CLAUDE.md"

echo "Skills:"
for skill in "$REPO"/skills/*/; do
  [ -d "$skill" ] || continue
  skill="${skill%/}"
  link_skill "$skill" "$HOME/.claude/skills"
  link_skill "$skill" "$HOME/.codex/skills"
  [ "$HERMES" -eq 1 ] && link_skill "$skill" "$HOME/.agents/skills"
done

if [ "$HERMES" -eq 1 ]; then
  echo "Hermes:"
  SOUL="$HOME/.hermes/SOUL.md"
  mkdir -p "$(dirname "$SOUL")"
  touch "$SOUL"
  if ! grep -q "agent-config-begin" "$SOUL" 2>/dev/null; then
    {
      echo ""
      echo "<!-- agent-config-begin -->"
      echo "Follow the working agreements in $REPO/AGENTS.md. Pass them to any"
      echo "coding CLI you delegate to."
      echo "<!-- agent-config-end -->"
    } >> "$SOUL"
    echo "  added pointer to $SOUL"
  else
    echo "  pointer already present in $SOUL"
  fi
fi

echo
echo "Done. Restart any running Claude Code or Codex session so it picks up"
echo "newly created directories. If Claude Code doesn't hot-reload edits to a"
echo "symlinked skill, point ~/.claude/skills at the repo directly or copy."
