---
id: 20260924-claude-web-availability
status: completed
queue: current
depends_on: []
created: 2026-09-24
updated: 2026-09-24
---

# Goal

Make oh-my-guide available in Claude Code on the web without per-project copies by running the existing installer from
the cloud environment's setup script, so one installer serves local and cloud sessions.

## Acceptance

- The repository's Claude delivery is back to commit `414875d`: no plugin manifest or hook, `install.sh --claude`
  installs the personal Skills and the marked `CLAUDE.md` block, and `.gitignore` has no `dist/` entry.
  `bash scripts/install.sh --check` passes.
- README documents the cloud setup script, which downloads `main` from codeload.github.com into a clean directory and
  runs `install.sh --claude` without blocking session start on failure. It also says when updates reach cloud sessions
  (environment cache rebuild, roughly weekly, or right after editing the script).
- The README script, run locally against isolated paths, installs the eight Skills and the block from the current
  `main` tarball.
- `~/project/vectori-vps/.claude/skills/` (the copied Skills) is removed, leaving the commit to the user.
- After the user's manual steps: a web session started after the script switch lists the Skills with the Guide block,
  `/task` typed in a web session resolves to the installed Skill, and local `claude plugin list` no longer shows
  `oh-my-guide@synced`.

## Design

Verified facts (2026-09-24):

- Cloud sessions do not carry over the local `~/.claude`. Plugins uploaded to claude.ai ("My Uploads") sync to terminal
  sessions but not to cloud sessions: in a cloud VM running Claude Code 2.1.281, the account plugin bucket was empty.
- A cloud environment setup script runs as root before Claude Code launches, once per environment cache (rebuilt when
  the script or network settings change, or after about seven days). A script that downloaded commit `414875d` and ran
  its `install.sh --claude` gave new cloud sessions the Skills and the `/root/.claude/CLAUDE.md` Guide block;
  `disable-model-invocation` kept the execution Skills out of Claude's own list.
- `jusvail/oh-my-guide` is public, and codeload.github.com is in the default Trusted allowlist.

Accepted design:

- One installer everywhere: locally `bash scripts/install.sh --claude`; in the cloud, the environment setup script:

  ```bash
  #!/bin/bash
  rm -rf /opt/oh-my-guide && mkdir -p /opt/oh-my-guide
  curl -fsSL https://codeload.github.com/jusvail/oh-my-guide/tar.gz/main \
    | tar -xz -C /opt/oh-my-guide --strip-components=1 \
    && bash /opt/oh-my-guide/scripts/install.sh --claude || true
  ```

- Revert the uncommitted plugin work (`releases/claude/.claude-plugin/`, `releases/claude/hooks/`, packaging
  `--claude`, `dist/` ignore, `dist/` output) to `414875d`. The existing installer and release stay unchanged.
- The user removes the claude.ai upload, so local sessions stop loading `oh-my-guide@synced` next to the personal
  Skills. Pushing to `main` is how changes reach cloud sessions.

## Scope

Included: reverting the plugin files, `scripts/install.sh`, and `.gitignore`; deleting `dist/`; README; removing the
vectori-vps Skills copy; a local run of the README script against `.tmp/` paths; task records.

Excluded: changes to the Skill texts or the Codex release, commits and pushes, and the manual claude.ai steps (editing the
environment setup script, removing the upload).

## Execution slices

- [x] Revert the plugin packaging to `414875d` and document the cloud setup script in README; verify the script locally
      against isolated paths.
- [x] Remove the vectori-vps Skills copy.
- [x] User steps: switch the environment setup script to the README version, remove the claude.ai upload, then confirm
      `/task` in a web session and the absence of `oh-my-guide@synced` locally.

## Current state

Completed. Cloud sessions get oh-my-guide from the environment setup script that runs `install.sh --claude` from `main`;
local sessions keep the personal install. The plugin route is withdrawn. vectori-vps has 225 uncommitted deletions of
its copied Skills for the user to commit.

## Validation

- PASS: `git diff 414875d -- scripts/install.sh .gitignore releases/claude` is empty; `bash scripts/install.sh --check`
  and `git diff --check` pass; `dist/` and the plugin files are gone.
- PASS: the README pipeline, pointed at `.tmp/` paths, downloaded the live `main` tarball and installed eight Skills
  identical to `releases/claude/skills` plus the marked block.
- PASS: `~/project/vectori-vps/.claude/` is gone after confirming its eight Skills matched the global install; its
  worktree shows only deletions of committed paths.
- PASS (earlier): a cloud session with the pinned-commit setup script loaded the Skills and the Guide block. FAIL
  (earlier): the uploaded plugin never reached cloud sessions.
- PASS (user): after switching to the README setup script and removing the upload, the user confirmed the web session
  works, including `/task`.
- PASS: after a fresh local session synced from claude.ai, `claude plugin list` reports no plugins; `oh-my-guide@synced`
  is no longer loaded.

## Decisions

- 2026-09-24: The user chose one claude.ai-synced plugin as the single Claude delivery.
- 2026-09-24: Reversed after cloud sessions proved not to sync uploaded plugins. The user chose the installer everywhere,
  with the cloud environment's setup script tracking `main`.
