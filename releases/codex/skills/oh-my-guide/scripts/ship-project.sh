#!/usr/bin/env bash

set -euo pipefail

fail()
{
    printf 'ERROR: %s\n' "$1" >&2
    exit 1
}

[[ "$#" -eq 2 ]] || fail "Usage: ship-project.sh <project-root> <commit-message>"

project_root="$1"
commit_message="$2"

[[ -n "${commit_message}" ]] || fail "Commit message must not be empty."
git -C "${project_root}" rev-parse --show-toplevel >/dev/null 2>&1 || fail "Not a Git repository: ${project_root}"

git -C "${project_root}" status --short
git -C "${project_root}" add -A

if git -C "${project_root}" diff --cached --quiet; then
    git -C "${project_root}" push
    printf 'No new commit was required; pushed the current branch.\n'
    exit 0
fi

git -C "${project_root}" commit -m "${commit_message}"
git -C "${project_root}" push

commit="$(git -C "${project_root}" rev-parse HEAD)"
printf 'Shipped %s\n' "${commit}"
