# oh-my-guide contributor instructions

Keep this package project-independent and make only the requested bounded change.

## Canonical package

- `.opencode/agents/` owns exactly Guide, Scout, and Task.
- `.opencode/commands/` owns exactly Guide, Redesign, Task, Quick, Ship, and Clean.
- `.opencode/skills/` owns only Browser, Debugging, Git, and AST-Grep.
- `preferences/core.md`, the OpenCode profile, templates, and existing helpers retain their current ownership.
- `releases/codex/skills/oh-my-guide/` owns exactly one Codex Skill; `releases/codex/default-guide.md` owns its silent
  default-Guide bootstrap. Do not add a Codex Agent, plugin, custom slash command, or second Codex Skill.
- `scripts/install.sh` is the only installation entry point. No argument and `--takeover` target OpenCode; `--codex`
  targets only Codex; `--check` validates both.

Preserve the OpenCode release when changing Codex. Codex installation may own only its `oh-my-guide` Skill, manifest, and
marked global instruction block. Preserve unrelated Skills, all user instruction content outside that block, Codex
configuration, plugins, project instructions, and Superpowers. Default Guide and Superpowers are exclusive process owners
for one objective; explicit user selection decides between them.

Do not add a reasoning-phase command, framework profile, project path, compatibility alias, execution lock, checkpoint,
runtime owner, or routine acceptance gate. `.tasks/` remains the only durable coordination contract.

Do not write outside the opened repository unless the user explicitly requests that external effect. Put every implicit
scratch copy, screenshot, log, and generated validation artifact under root `.tmp/` and remove it after use.

## Validation

Run `bash scripts/install.sh --check` after package changes. Exercise OpenCode only with
`OH_MY_GUIDE_OPENCODE_DIR` under project-root `.tmp/`. Exercise Codex only with both
`OH_MY_GUIDE_CODEX_SKILLS_DIR` and `OH_MY_GUIDE_CODEX_DIR` under `.tmp/`. Never install into the real home directory unless
the user explicitly requests it. Do not stage, commit, push, or write Git history without explicit authority.
