# oh-my-guide contributor instructions

Keep this package project-independent and make only the requested bounded change.

## Canonical package

- `releases/claude/skills/` owns exactly the Guide, Redesign, Task, Quick, Reduce, Ship, Debugging, and AST-Grep Skills;
  `releases/claude/default-guide.md` owns the marked default-Guide block for the global `CLAUDE.md`. Do not add a Claude
  Code Agent, plugin, hook, output style, or settings change unless the user requests it.
- `releases/codex/skills/oh-my-guide/` owns exactly one Codex Skill; `releases/codex/default-guide.md` owns its silent
  default-Guide bootstrap. Do not add a Codex Agent, plugin, custom slash command, or second Codex Skill.
- `templates/task.md` is the task template; both releases carry byte-identical copies. `templates/instructions/` and
  the Codex Ship helper retain their current ownership.
- `scripts/install.sh` is the only installation entry point. `--claude` targets only Claude Code, `--codex` targets only
  Codex, and `--check` validates both.

Keep the two releases behaviorally equivalent while each follows its runtime's idiom: Claude text states rules once with
their reasons and relies on Claude Code's built-in behavior; Codex text targets GPT models. Changing one release must not
change the other's installed effects.

Claude Code installation may own only its listed Skills, its manifest, and the marked block in the global `CLAUDE.md`.
Codex installation may own only its `oh-my-guide` Skill, manifest, and marked global instruction block. Preserve
unrelated Skills, all user instruction content outside the marked blocks, configuration, settings, plugins, and project
instructions.

Do not add a reasoning-phase command, framework profile, project path, compatibility alias, execution lock, checkpoint,
runtime owner, or routine acceptance gate. `.tasks/` remains the only durable coordination contract.

Do not write outside the opened repository unless the user explicitly requests that external effect. Put every implicit
scratch copy, screenshot, log, and generated validation artifact under root `.tmp/` and remove it after use.

## Validation

Run `bash scripts/install.sh --check` after package changes. Exercise Claude Code only with `OH_MY_GUIDE_CLAUDE_DIR`
under project-root `.tmp/`. Exercise Codex only with both `OH_MY_GUIDE_CODEX_SKILLS_DIR` and `OH_MY_GUIDE_CODEX_DIR`
under `.tmp/`. Never install into the real home directory unless the user explicitly requests it. Do not stage, commit,
push, or write Git history without explicit authority.
