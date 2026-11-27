#!/usr/bin/env bash
set -euo pipefail

# Validate Conventional Commits headers without external dependencies.
# CI uses this script while the application toolchain (and commitlint) is not
# yet scaffolded. The approved header shape is:
#   type(scope): description
# Types are limited to the list in the Walfolio constitution, Principle XIV.

event="${EVENT_NAME:-}"
valid_types='feat|fix|refactor|test|docs|style|perf|build|ci|chore'
pattern="^(${valid_types})(\([a-z0-9._/-]+\))?: .+"
zero_sha='0000000000000000000000000000000000000000'

collect_commits() {
  case "$event" in
    pull_request)
      : "${BASE_SHA:?BASE_SHA is required for pull_request}"
      : "${HEAD_SHA:?HEAD_SHA is required for pull_request}"
      git rev-list --no-merges "${BASE_SHA}..${HEAD_SHA}"
      ;;
    push)
      local before="${BEFORE_SHA:-}"
      local after="${AFTER_SHA:-}"

      if [ -z "$after" ] || [ "$after" = "$zero_sha" ]; then
        return 0
      fi

      if [ -z "$before" ] || [ "$before" = "$zero_sha" ]; then
        git rev-list --no-merges -n 1 "$after"
      else
        git rev-list --no-merges "${before}..${after}"
      fi
      ;;
    *)
      git rev-list --no-merges -n 1 HEAD
      ;;
  esac
}

commits="$(collect_commits)"
status=0

while IFS= read -r commit; do
  [ -n "$commit" ] || continue

  subject="$(git log -1 --format=%s "$commit")"

  if [ "${#subject}" -gt 100 ]; then
    echo "::error::Commit $commit subject exceeds 100 characters: $subject"
    status=1
  fi

  if [[ ! "$subject" =~ $pattern ]]; then
    echo "::error::Commit $commit does not follow Conventional Commits: $subject"
    status=1
  fi

  if [[ "$subject" == *"." ]]; then
    echo "::error::Commit $commit subject must not end with a period: $subject"
    status=1
  fi
done <<< "$commits"

if [ "$status" -ne 0 ]; then
  echo "Allowed types: feat, fix, refactor, test, docs, style, perf, build, ci, chore."
  echo "Expected form: type(scope): description"
  exit 1
fi

if [ -z "$commits" ]; then
  echo "No non-merge commits to validate."
else
  echo "Commit message validation passed."
fi
