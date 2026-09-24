---
name: ship
description: Stage every current change, commit, and push the current branch.
disable-model-invocation: true
argument-hint: "[commit message]"
allowed-tools: Bash(git add -A) Bash(git commit *) Bash(git push)
---

# Ship

Commit message: $ARGUMENTS

Running `/ship` authorizes exactly three effects in the current repository: stage all current changes, commit them, and
push the current branch to its upstream.

1. Inspect the branch, the status, the full and staged diffs, and recent commit messages, and account for every dirty
   path. If a path looks like it must never be published, such as credentials, ask before staging it.
2. Use the given message, or write a concise English message in the repository's style for the coherent change.
3. Run `git add -A`, then `git commit`. If nothing is staged, skip the commit and push the current branch.
4. Run `git push`. If the branch has no upstream, report that and ask instead of choosing a remote.

Hooks run normally; if one fails, report its output instead of bypassing it. Shipping never includes amend, force-push,
`--no-verify`, branch switching, discarding work, installation, or a release. Finish with the commit hash, the push
result, and the remaining worktree state.
