#!/bin/bash
set -euo pipefail

root=.
if test "${1:-}" = --root; then
  test "$#" -eq 2 || exit 64
  root=$2
fi

git -C "$root" rev-parse --git-dir >/dev/null 2>&1 || { printf '[FAIL] not_git_repo=%s\n' "$root" >&2; exit 1; }
failed=0

while IFS= read -r tracked_file; do
  case "$tracked_file" in
    contacts.*|contact-export*|outreach-tracker*|conversation-notes/*|meeting-notes/*|private/*)
      printf '[FAIL] private_path=%s\n' "$tracked_file" >&2
      failed=1
      ;;
  esac
done < <(git -C "$root" ls-files)

if git -C "$root" grep -n -i -E 'track who you contacted|date of first contact|notes from the conversation' -- README.md networking >/dev/null 2>&1; then
  git -C "$root" grep -n -i -E 'track who you contacted|date of first contact|notes from the conversation' -- README.md networking >&2
  failed=1
fi

test "$failed" -eq 0
