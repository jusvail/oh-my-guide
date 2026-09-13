---
id: 20260913-streamline-agent-workflow
status: completed
queue: current
depends_on: []
created: 2026-09-13
updated: 2026-09-13
---

# Goal

Apply the accepted agent audit items 1–8 to this package and remove obsolete workflow integration references.

## Acceptance

- Natural-language implementation authority reaches execution; explicit design and read-only requests retain their scope.
- Durable state, investigation, reduction, validation, and recovery have task-specific boundaries.
- Specific user authorization works independently of utility command names.
- Both releases and the installer agree; no obsolete workflow integration remains in the working tree.

## Design

Reuse the existing Guide, Task, core preferences, auxiliary Skills, and installer. OpenCode Guide invokes the existing
Task with mode and bounded authority; Codex transitions in its current runtime. No additional agent or ledger.

## Scope

Only this repository. Audit items concerning downstream project rules become project-independent defaults here;
do not edit that project, the active home installation, plugins, model settings, or Git history.

## Execution slices

- [x] Align entry, authority, task maintenance, and bounded execution in both releases.
- [x] Update auxiliary Skills, documentation, and installer requirements.
- [x] Validate package sources and isolated installation outputs.

## Current state

Implementation and package verification complete. Source worktree was clean before this task. Active home installs,
downstream project instructions, plugins, model settings, and Git history were not changed.

## Validation

- Existing `bash scripts/install.sh --check`, shell syntax checks for all three scripts, and `git diff --check` passed.
- Parsed YAML frontmatter for 15 Agents, commands, and Skills. Guide allows only Scout/Task delegation; Task uses
  `mode: all` and permits the Browser Skill. Configuration follows https://opencode.ai/docs/agents/#mode.
- Both isolated installations and reinstalls under `.tmp/` succeeded; installed release files and the generated Codex
  instruction block matched final source. Generated installation copies are disposable.
- Case-insensitive working-tree search found no remaining obsolete workflow integration references.
- No OpenCode executable is available here. Real model behavior and an actual delegated session were not validated;
  static and packaging evidence do not establish prompt efficacy.

## Decisions

Natural language is sufficient authority; no repeat design approval. Preserve explicit restrictions on external effects.
