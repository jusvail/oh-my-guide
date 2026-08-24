---
name: git
description: Use when an accepted task needs Git status or history evidence, or the user explicitly requests a commit or history rewrite.
---

# Git

Use Git deliberately and preserve unrelated work. Classify the request before acting:

- **Status or history:** inspect branch, worktree, diff, commits, blame, or search history without mutation.
- **Commit:** stage and commit only when the user explicitly requests a commit.
- **Rewrite:** rebase, squash, fixup, or force-push only when the user explicitly requests that exact history operation.

## Read-only evidence

Establish branch, worktree, relevant diff, and recent local message style before drawing a conclusion. Use the narrowest
history command that answers the question: `git log -S` for an exact text change, `git log -G` for matching diff lines,
`git blame -L` for line ownership, `git log --follow -- <path>` across a rename, and `git show <commit>` for the actual
change. Cite the commit and path that support a history claim.

## Commit

Only after explicit user authority:

1. Inspect the full diff and account for every existing dirty path.
2. Stage only the accepted coherent change, except that `/ship` explicitly authorizes staging all current changes.
3. Match the repository's recent commit-message style.
4. Inspect the staged diff and run proportional verification before committing.
5. Report the commit hash, message, and remaining worktree state.

## Rewrite

Only after explicit user authority for the exact rewrite. Identify the base, upstream, pushed status, dirty work, and a
recovery path before changing history. Do not rewrite protected branches, use plain force-push, reset, clean, stash, or
discard work as a shortcut. If a force push is explicitly required, use `--force-with-lease`.

This Skill does not make commits, pushes, branches, rebases, or publication implicit in ordinary implementation work.
