#!/usr/bin/env bash
# slacksmith installer — drops the skill into Claude Code and/or Codex skill dirs
set -euo pipefail

SKILL_NAME="slacksmith"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

TARGETS=()
[[ -d "$HOME/.claude" ]] && TARGETS+=("$HOME/.claude/skills")
[[ -d "$HOME/.codex"  ]] && TARGETS+=("$HOME/.codex/skills")

if [[ ${#TARGETS[@]} -eq 0 ]]; then
  echo "⚠  No ~/.claude or ~/.codex found. Create one first, then re-run."
  exit 1
fi

echo "🔨 Forging slacksmith into:"
for t in "${TARGETS[@]}"; do echo "    $t/$SKILL_NAME"; done
echo

for target in "${TARGETS[@]}"; do
  mkdir -p "$target"
  dest="$target/$SKILL_NAME"
  if [[ -e "$dest" || -L "$dest" ]]; then
    echo "↻  Replacing existing $dest"
    rm -rf "$dest"
  fi
  cp -R "$REPO_DIR" "$dest"
  # don't copy .git or installer artifacts into the skill dir
  rm -rf "$dest/.git" "$dest/install.sh" "$dest/README.md" "$dest/LICENSE" "$dest/.gitignore" 2>/dev/null || true
  echo "✓  Installed → $dest"
done

echo
echo "🎉 Done. Restart Claude Code (or /clear) and call it with:  /slacksmith"
