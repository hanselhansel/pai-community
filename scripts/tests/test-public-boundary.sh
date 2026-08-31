#!/bin/bash
set -euo pipefail

TEST_DIR=$(cd "$(dirname "$0")" && pwd)
CHECKER=$(cd "$TEST_DIR/.." && pwd)/check-public-boundary.sh
passed=0
failed=0

run_case() {
  case_name=$1
  expected=$2
  fixture=$3
  root=$(mktemp -d)
  git -C "$root" init -q -b main
  git -C "$root" config user.name Test
  git -C "$root" config user.email test@example.com
  mkdir -p "$root/networking"
  printf 'public categories\n' > "$root/networking/target-list.md"
  printf 'public template\n' > "$root/networking/message-templates.md"
  case "$fixture" in
    clean) ;;
    private_filename) printf 'private\n' > "$root/contact-export.csv" ;;
    private_tracking_instruction) printf 'track who you contacted and when\n' >> "$root/networking/message-templates.md" ;;
  esac
  git -C "$root" add -f .
  if "$CHECKER" --root "$root" >/dev/null 2>&1; then status=0; else status=$?; fi
  if test "$status" -eq "$expected"; then
    printf '[PASS] %s\n' "$case_name"
    passed=$((passed + 1))
  else
    printf '[FAIL] %s expected=%s observed=%s\n' "$case_name" "$expected" "$status" >&2
    failed=$((failed + 1))
  fi
  rm -rf "$root"
}

run_case clean 0 clean
run_case private_filename 1 private_filename
run_case private_tracking_instruction 1 private_tracking_instruction

printf 'tests=%s failures=%s\n' "$((passed + failed))" "$failed"
test "$failed" -eq 0
