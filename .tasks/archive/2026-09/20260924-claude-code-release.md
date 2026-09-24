---
id: 20260924-claude-code-release
status: completed
queue: current
depends_on: []
created: 2026-09-24
updated: 2026-09-24
---

# Goal

Replace the retired OpenCode release with a Claude Code release that carries the Guide workflow in text written for
current Claude models, installable globally through `scripts/install.sh --claude`, and refine Codex wording that the
retirement leaves stale.

## Acceptance

- `releases/claude/` provides one marked global `CLAUDE.md` block and the Guide, Redesign, Task, Quick, Reduce, Ship,
  Debugging, and AST-Grep Skills. Guide is model-invocable and stays in the main conversation; Redesign, Task, Quick,
  Reduce, and Ship are user-only.
- The Claude text states each rule once with its reason, omits behavior Claude Code already provides, and says Guide
  relies on asking so auto mode does not turn user-owned choices into assumptions.
- `install.sh --claude` installs into `${CLAUDE_CONFIG_DIR:-~/.claude}` (overridable by `OH_MY_GUIDE_CLAUDE_DIR`), owns
  only its Skills, manifest, and marked block, refuses to replace an unowned same-named Skill, and removes Skills it
  previously owned but no longer ships. `--codex` keeps its effect, `--check` validates both releases, and no argument
  prints usage.
- `.opencode/`, `releases/opencode/`, `preferences/`, and the root ship helper are gone; README and AGENTS.md describe
  only Claude Code and Codex.
- Codex wording no longer references Scout, clean mode, or OpenCode.

## Design

- Guide lives in the main conversation as a Skill plus a global `CLAUDE.md` routing block, mirroring the Codex release:
  subagents cannot ask the user, and `--agent` replaces Claude Code's system prompt.
- Execution Skills use `disable-model-invocation: true`, so only the user starts execution; Guide reads the Task Skill
  file for the equivalent plain-language instruction.
- The block carries the engineering preferences trimmed of rules Claude Code already enforces. Scratch files use Claude
  Code's session scratchpad instead of project `.tmp/`.
- Ship runs `git add -A`, `git commit`, and `git push` directly with those commands pre-approved; no helper script.
- Browser and Git are dropped: `agent-browser` is not installed and Claude Code has built-in browser and Git guidance.
- Both releases keep byte-identical copies of `templates/task.md`; `--check` enforces it.

## Scope

Included: `releases/claude/`, `scripts/install.sh`, `README.md`, `AGENTS.md`, Codex Skill wording, removal of OpenCode
sources. Excluded: real-home installation, hooks, plugins, settings, output styles, Codex behavior changes, Git history.

## Execution slices

- [x] Claude release text: block, Guide, Task, and the remaining Skills.
- [x] Installer: `--claude`, `--check` for both releases, OpenCode removal.
- [x] Retire OpenCode sources; align README, AGENTS.md, and Codex wording.
- [x] Validate: package check, isolated installs, headless Claude Code run in a scratch repository.

## Current state

Completed. The Claude Code release, `--claude` installer, OpenCode retirement, documentation, and Codex wording
refinements are in place and validated. Active real-home installs are not updated.

## Validation

- PASS: `bash scripts/install.sh --check` reports 8 Claude Code Skills and one Codex Skill; `bash -n`, `shellcheck`, and
  `git diff --check` pass. No argument and the retired `--takeover` print usage and exit 1.
- PASS: Isolated `--claude` under `.tmp/` installs the eight Skills, manifest, and a block matching its source ahead of
  existing user `CLAUDE.md` content; reinstall is byte-identical; a retired owned Skill is removed while user files and
  unrelated Skills stay; an unowned same-named Skill, a misplaced block, and unsafe manifest paths are refused before
  any write; `CLAUDE.md` is created when absent.
- PASS: Isolated `--codex` twice installs a Skill identical to its source, an executable helper, and one block ahead of
  existing user content.
- PASS: Headless Claude Code 2.1.281 (Opus 5.5, auto mode) in a scratch repository with the release as project-level
  `.claude/`: a lookup answered directly without task writes; an implementation-worded objective auto-invoked `guide`,
  created a `designing` task before one recommended question, and left source untouched; the answer made the task
  `ready` and presented `/task`; "looks good" did not start implementation; `/task <id>` in a fresh session implemented,
  validated four cases, archived, refreshed the index, and did not commit. Behavior was re-verified independently.
- FIXED: The first run wrote a project fact into `context.md`; Guide now creates it with only a heading.
- LIMIT: One small scenario cannot establish compliance across real projects; actual use remains the feedback mechanism.

## Decisions

- 2026-09-24: The user approved a Claude-specific rewrite over a straight port of the GPT-tuned text.
- 2026-09-24: Retire the OpenCode release; add `--claude` to `scripts/install.sh` (the user's "publish.sh") for global
  local installation; refine Codex wording where needed.
- 2026-09-24: Ship runs Git directly instead of a bundled helper; Browser and Git Skills are dropped for Claude Code.
