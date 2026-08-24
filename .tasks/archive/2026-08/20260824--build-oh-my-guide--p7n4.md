---
id: 20260824--build-oh-my-guide--p7n4
status: completed
queue: current
created: 2026-08-24
updated: 2026-08-24
depends_on: []
owned_paths:
  - AGENTS.md
  - README.md
  - .opencode/
  - preferences/
  - releases/
  - scripts/
  - templates/
---

# Build the first clean oh-my-guide package

## Acceptance

- The package is project-independent and contains exactly three Agents: Guide, Scout, and Task.
- Guide owns continuous conversation, evidence synthesis, design, natural-language task/context/preference/instruction
  management, and the readiness decision. Discovery and deeper reasoning stay internal.
- Scout is Guide's bounded evidence worker. Product repositories remain read-only; disposable temporary copies may be
  modified, built, tested, or used for feasibility proofs.
- Task is the only execution engine. Exactly six commands exist: `/guide`, `/redesign`, `/task`, `/quick`, `/ship`, and
  `/clean`; the latter three use command-specific Task modes rather than additional Agents.
- The published task contract uses one concise file, IDs shaped `YYYYMMDD-short-slug`, statuses `designing`, `ready`,
  `active`, and `blocked`, queues `current` and `deferred`, and terminal states `completed`, `cancelled`, and
  `superseded`. It contains no claim, checkpoint, runtime owner, handoff-ready, paused, or routine acceptance protocol.
- `/task <id>` starts or adopts executable non-terminal work, treats invocation as modification authority, rechecks real
  blockers, and automatically completes objectively verified work. Task never invents a missing material design.
- Only generic `debugging`, `browser`, `computer-use`, `git`, and `ast-grep` Skills remain. There is no RTK, framework-
  specific, Memory, or Design Skill or guidance.
- `scripts/install.sh --check` validates only. Default installation updates manifest-owned files additively, preserves
  unrelated OpenCode content, does not write `opencode.json`, and never modifies project repositories. `--takeover`
  manages only the global OpenCode target, writes the recommended profile, and preserves the user preference file.
- Default Agents inherit user models. Only the takeover profile supplies recommended models and reasoning strengths.
- `/ship` stages all current changes after inspection, commits with a supplied or inferred message, and pushes without
  force or implicit install/release hooks. `/clean` and `/clean all` retain bounded OpenCode Session cleanup.
- README and AGENTS guidance are concise and generic. No case-insensitive `vectori` or `rtk` reference, project profile,
  sibling-repository assumption, compatibility alias, real-home installation, publication, or Git-history mutation is
  introduced.
- Guide, Scout, and Task never write outside the opened project root unless the user explicitly requests that external
  effect. Every implicit scratch copy, screenshot, log, generated validation artifact, and temporary file lives under the
  opened root's `.tmp/`; no operating-system-specific absolute temporary path is encoded.

## Plan

- [x] Establish the minimal package layout, task template, generic preference boundary, and recommended profile.
- [x] Implement the three Agent contracts and six command entry points.
- [x] Add the five retained generic Skills and deterministic utility scripts.
- [x] Add the additive/takeover installer plus concise repository documentation.
- [x] Perform one acceptance-and-ownership self-review and proportional isolated validation.
- [x] Move every implicit temporary artifact into project-root `.tmp/` and revalidate permissions, docs, and package.
- [x] Replace broad home-directory permission globs with documented exact home expansion and revalidate resolution.

## Current state

The user explicitly accepted the first version on 2026-08-24 and declined a native PowerShell installer. The package is
complete at the accepted scope. No real-home installation, publication, or Git-history action occurred.

## Verified facts

- `/Users/yuki/Project/oh-my-guide` is on `main` at `047ffc81684aa55cef355ba0e121e0e33a19ec4e` with a clean worktree before
  this task ledger was created.
- The repository initially contains only `README.md` and `LICENSE`; it has no AGENTS, project instructions, package files,
  or prior task ledger.
- The accepted design explicitly removes RTK and every project-specific profile, name, path, and framework rule.
- The old publisher replaced complete global directories, wrote global `opencode.json`, and assumed a sibling project;
  those behaviors are failure evidence and are not design authority.
- Current OpenCode documentation confirms that plural `agents/`, `commands/`, and `skills/` directories are canonical;
  omitted Agent models inherit the user's configured model, while a profile may override each Agent explicitly.
- The candidate has no plugin or shared-instruction package. Its recommended profile is isolated from default install and
  the installer targets only the configured global OpenCode root.
- Final source ownership is limited to the accepted package: three Agent files, six command files, five generic Skills,
  core preferences, one recommended profile, task/instruction templates, two scripts, README, AGENTS, and task ledger.
- Default resolved configuration contains Guide and Task as primary Agents, hidden Scout as the only subagent, exactly the
  six accepted custom commands, and no Agent model override.
- Takeover resolved configuration selects Guide as default, Guide and Scout on Sol/max, Task on Luna/max, and the same six
  commands.
- Resolved default permissions restrict Scout edits to root `.tmp/` and deny Scout external-directory access. Guide and
  Task ask for unknown external paths while allowing only their explicit package preference and Ship-helper paths.
- Package source contains no operating-system absolute scratch path. Browser screenshots, Computer Use logs/screenshots,
  Scout experiments, and Agent-generated validation artifacts all use project-root `.tmp/`.
- OpenCode's current permission documentation defines `~` and `$HOME` expansion at the beginning of a permission pattern
  and last-match-wins evaluation. The previous `**/.config/...` form would be broader than necessary; the exact `~` form
  is the documented installed-user path.
- Current OpenCode source expands `~/` with `os.homedir()`, normalizes Windows backslashes before wildcard matching, and
  matches case-insensitively on Windows. The exact preference permission therefore works in native Windows; WSL uses its
  separate Linux home. The accepted first version intentionally keeps only the Bash installer.

## Open questions

None.

## Validation

- Run package source validation through `scripts/install.sh --check` and shell syntax validation for every script.
- Exercise default and takeover installation against isolated temporary OpenCode and Skills roots only.
- Prove default installation preserves unrelated files and `opencode.json`; prove takeover writes only the isolated global
  target and preserves the user preference file.
- Resolve the isolated OpenCode configuration and confirm exactly three Agents, six commands, inherited default models,
  and takeover-only recommended models.
- Search the complete package for prohibited names and concepts, inspect the real diff, and run `git diff --check`.
- Do not author test code, install into the real home directory, publish, stage, commit, or push.
- PASS: `bash scripts/install.sh --check`, both script syntax checks, and `git diff --check`.
- PASS: the package-source case-insensitive prohibited-content scan returned no match.
- PASS: isolated default installation preserved unrelated Agents, commands, Skills, preferences, plugins, instructions,
  scripts, and `opencode.json`; it removed only the stale path listed in its prior package manifest.
- PASS: isolated takeover removed prior singular/plural Agent and command directories plus unrelated Skills, installed
  exactly the package set and recommended profile, and preserved `preferences/user.md` plus an external plugin.
- PASS: isolated `opencode debug config` confirmed inherited default models and takeover-only recommended models.
- NOT RUN: Ship commit/push and Clean Session deletion because the task explicitly prohibits Git-history mutation and
  Session deletion; their deterministic script/prompt contracts and shell syntax were reviewed instead.
- PASS: the corrected package check rejects absolute system scratch paths and requires `.tmp/` in the repository
  `.gitignore`.
- PASS: additive, takeover, and resolved-configuration validation ran only under project-root `.tmp/`; generated files
  were removed afterward, and the previously created external validation directories were moved into `.tmp/` and removed.
- PASS: an additive project-local install and `opencode debug config` resolved the exact Guide edit/external rules and
  Task external rules with no broad `.config` prefix wildcard; its `.tmp/` validation files were removed afterward.
- PASS (source review): OpenCode's permission expansion and wildcard implementation confirm Windows home expansion,
  separator normalization, and case-insensitive matching. NOT RUN: a Windows-machine installation or runtime test.

## Discussion history

- 2026-08-24: Created from the user's accepted clean-slate architecture after verifying the new repository, branch, HEAD,
  worktree, absence of project instructions, and global engineering preferences. No package source or Git history was
  changed before task creation.
- 2026-08-24: Built the first coherent candidate: three Agent contracts, six commands, five generic Skills, the compact
  task and instruction templates, core preferences, recommended takeover profile, deterministic Ship helper, additive
  installer, and concise package documentation. No real-home installation, publication, or Git-history action occurred.
- 2026-08-24: Completed Root-owned acceptance and ownership review. Corrected Scout scratch cleanup permissions, removed
  a product-deletion restriction from Task, made Ship honor a custom OpenCode root, and kept Clean free of product
  preflight ceremony. No duplicate Agent, reasoning command, compatibility alias, plugin, or unrelated package owner
  remains.
- 2026-08-24: Final package, shell, isolated installation, manifest ownership, configuration resolution, prohibited-name,
  and whitespace validation passed. Released the execution claim and left the task ready for explicit acceptance under
  the currently running bootstrap Agent contract.
- 2026-08-24: User rejected absolute system temporary paths and established the cross-platform owner rule: Agents modify
  only the opened project unless the user explicitly requests an external effect; implicit scratch, screenshot, log, and
  validation files belong under project-root `.tmp/`. Reopened the existing task and claim for this bounded correction.
- 2026-08-24: Replaced every system scratch path with project-root `.tmp/`, narrowed Guide and Scout path permissions,
  permission-gated unknown Task external paths, updated both artifact-producing Skills and package guidance, and added a
  package validation guard plus `.gitignore` ownership. Final package, configuration, isolated install, whitespace, and
  cleanup validation passed; released the correction claim for acceptance.
- 2026-08-24: User questioned the installed global preference permission. Verified from current OpenCode documentation
  that permission patterns support explicit `~` and `$HOME` expansion and that last matching rules win. Reopened the task
  to replace the permissive prefix wildcard with the exact documented home path and validate the resolved Agent config.
- 2026-08-24: Replaced every package-owned home permission with its exact `~/.config/opencode/...` path. Package checking,
  isolated additive installation, resolved permission inspection, whitespace validation, and project-local cleanup
  passed; released the correction claim for acceptance.
- 2026-08-24: Confirmed from current OpenCode source that the exact home permission is Windows-compatible. User declined
  native PowerShell installation support and explicitly accepted the first version as-is; completed and archived the
  task for that reason.
