#!/usr/bin/env bash
# Push local slacksmith changes to GitHub.
# Usage:  ./update.sh "your commit message"
#         ./update.sh                        (uses a default message)
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

MSG="${1:-Update slacksmith}"

if [[ -z "$(git status --porcelain)" ]]; then
  echo "✓ Nothing to commit. Working tree clean."
  exit 0
fi

echo "📝 Changes staged:"
git status --short
echo

git add -A
git commit -m "$MSG"
git push

echo
echo "🚀 Pushed to $(git remote get-url origin)"
