---
id: 20260925-guide-composable-simplicity
status: completed
queue: current
depends_on: []
created: 2026-09-25
updated: 2026-09-25
---

# Goal

Teach both releases the three design lessons from the vectori cleanup that current policy does not already cover, plus
two Daoist refinements that sharpen them. Place each with the existing rule it extends, in a few sentences, without
making the package text materially longer.

## Acceptance

- Shared preferences in both releases (Claude `releases/claude/default-guide.md`, Codex
  `releases/codex/skills/oh-my-guide/references/core.md`) say that one source of truth covers values, models, and rules:
  one representation per concept rather than parallel models joined by translators, and each invariant enforced where
  the data is created rather than rechecked at every use. The rule carries its reason: code whose only job is keeping
  copies or rules in line is where size and bugs accumulate. A derived copy stays allowed when it has a clear source
  and semantics or a measured need justify it (for example a render scene or a cache).
- The same shared preferences extend the "check before concluding something is missing" rule to what the project's
  existing dependencies already provide.
- Guide in both releases (Claude `releases/claude/skills/guide/SKILL.md` "Shape the design", Codex
  `references/guide.md` "Resolve the design") judges a design, within the task's scope, by the structure it leaves rather
  than the size of its diff. It prefers a few domain operations with clear inputs and effects, divided where things
  change independently and composed per task, over a method per case or a flag-driven engine.
- Each lesson is folded into an existing bullet. Each touched file grows by no more than about three lines. No new
  section, list, command, schema, routine gate, or mandatory report appears.
- The Claude and Codex releases make the same decisions. Mode authority, the behavior-preservation guard, the
  compatibility rules, and the single Codex Skill layout are unchanged. `bash scripts/install.sh --check` and
  `git diff --check` pass.

## Design

Evidence (read-only vectori comparison, 2026-09-25, `dev-composer` `7ff83a2` to `claude/determined-ritchie-jyhygs`
`af72595`; the repository is not on this machine). Tracked `.cs`/`.axaml` lines: all `src` 77,844 to 29,542, Canvas
60,448 to 13,823. The following policy already covers most of the result: reuse order, one source of truth for values,
opt-in compatibility, code volume as a signal, and preserved behavior. Three lessons remain:

1. Parallel representations joined by translators were the largest cost. `CanvasFormat.cs` (2,125 lines) bridged UI
   objects, DTOs, resource tables, and Timeline reconstruction; `CanvasMapsuiFeatureProvider.cs` (1,318) adapted objects
   into Mapsui features. The replacement serializes one UI-free immutable model and derives a `Scene` for rendering.
2. A dependency's capability went unused. `NetTopologySuite.IO.Esri.Shapefile` was already referenced while
   `ShapefileArchiveReader.cs` (1,631 lines) parsed SHP/DBF bytes by hand. The new importer calls `Shapefile.OpenRead`.
3. Operations as data compose. One affine delta (`Operations.cs`) serves both preview and commit in `SelectTool` instead
   of separate code paths for translate, rotate, and scale.

No new rule is needed for the rest of the evidence. The size grew as locally minimal changes piled up. Removing it
took replacement authority (Reduce/Redesign already grant it) plus user-owned cuts: legacy formats, Snapshots, and
Notebook were dropped. The first rewrite overshot (Canvas 8,707 lines, restored to 13,823 after UI regressions), so the
existing behavior guard stays as it is. The speedup claim was not reproduced; FPS alone does not prove less work.

Daoist refinements (Agent-selected under the user's delegation):

- 善閉無關楗而不可開 (ch. 27: a good door needs no bolt): enforce an invariant once where data is created, so callers
  need no guards. This is the structural alternative to the existing ban on speculative defensive handling. Together
  with the user's favored diagnostic, "code that needs more code to control the code has gone wrong", it becomes
  the stated reason for one source of truth: syncing copies, translating models, and rechecking rules are all control
  code.
- 庖丁解牛 (Zhuangzi, Cook Ding cuts along the joints): divide operations where things change independently. This is
  the positive rule behind rejecting a flag-driven engine. It also stops "remove duplication" from merging code that
  only looks alike.
- Considered and excluded: "leave space", "soft beats rigid", and "preserve reversibility" read to a model as license
  for speculative flexibility, configuration, and compatibility shims, which the package deliberately makes opt-in.
  Reversibility comes from Git and user-owned decisions. The remaining maxims (do less, know when to stop, know what you
  do not know, fix while small, plain over clever) are already policy.

Placement: lessons 1 and 2 and the invariant rule are general engineering rules, so they extend the shared
preferences. Every mode loads those in both releases, so the releases stay equivalent. Lesson 3, "judge by the
structure left", and "divide at the joints" are design judgment, so they go in Guide. Draft wording, refined during
execution:

- One source of truth: "Keep one source of truth for each value, model, and rule: derive values instead of storing
  copies, give each concept one representation instead of parallel models joined by translators, and enforce an
  invariant where data is created instead of rechecking it at every use. Code that only keeps copies in line is where
  size and bugs accumulate, so keep a copy only when semantics or a measured need requires it."
- Reuse: "Check definitions, real call sites, and what existing dependencies already provide before concluding
  something is missing."
- Guide: "Within the task's scope, judge a design by the structure it leaves rather than the size of its diff: a few
  domain operations with clear inputs and effects, divided where things change independently and composed per task,
  beat a method per case or a flag-driven engine."

Codex `core.md` keeps its "Make the smallest complete change" heading, which is about scope. The Guide sentence says
"within the task's scope", so the two do not conflict. Execution confirms the final wording keeps that true.

## Scope

Edit only the existing bullets named in Acceptance: Claude `default-guide.md`, the Claude Guide `SKILL.md`, and Codex
`core.md` and `guide.md`. Change nothing else in the package: Task, Quick, Reduce, Redesign, other Skills, templates,
the Codex bootstrap, the installer, and the README all stay as they are. Wording and exact placement are Agent-owned. No
global installation, tests, vectori access, staging, commits, or pushes.

## Execution slices

- [x] Fold the two shared-preference lessons into Claude `default-guide.md` and Codex `core.md`.
- [x] Fold the design lesson into Claude Guide "Shape the design" and Codex `guide.md` "Resolve the design".
- [x] Compare the two releases' diffs for equivalence and size, then run the package checks.

## Current state

Completed. All four release files were edited in place; the installed Skills and global instruction blocks are not
updated until the user runs the installer.

## Validation

- Static review of both release diffs: the same three decisions, each folded into an existing bullet, the growth
  budget met, and no change to mode authority or the behavior and compatibility guards.
- Check that the new wording still allows a thin task orchestrator, two similar operations that change independently,
  a justified derived projection or cache, validation of external input at its boundary, and required product behavior.
  It must reject a flag-driven universal engine, and the invariant rule must not license new speculative checks.
- `bash scripts/install.sh --check` and `git diff --check`. Static checks do not predict future model behavior or
  guarantee code reduction.
- Baseline: `main` at `f47a075`; only `.tasks/` differs.

Results (2026-09-25):
- Growth: Claude `default-guide.md` +2 lines, Claude Guide `SKILL.md` +3, Codex `core.md` +3, Codex `guide.md` +3.
  Every lesson was folded into an existing bullet, and all new lines are at most 120 characters.
- Equivalence: both releases make the same three decisions. Claude states the Guide rule's reason ("which every later
  change pays for"), following its idiom. Codex keeps "Make the smallest complete change", which is about scope; the
  Guide sentence is limited to "within scope".
- Static cases: "composed per task" keeps thin orchestration; "divided where things change independently" keeps
  similar but independent operations apart; "such as a render scene or cache" keeps justified projections; "created
  or enters" keeps boundary validation; "instead of rechecking" removes checks rather than adding them, and the
  optional-work rule still governs whether a check exists. Behavior, compatibility, and mode-authority text is
  unchanged.
- `bash scripts/install.sh --check`: "Package is valid: 8 Claude Code Skills and one Codex Skill." `git diff --check`
  passed.

## Decisions

- 2026-09-25: The user prioritizes architectural simplicity, atomicity, cleanliness, and extensibility, and objects to
  duplicating existing common methods or writing a bespoke method for every task.
- 2026-09-25: The user authorized a read-only comparison of the two vectori branches to ground the design in real code.
- 2026-09-25: The user chose the small, owner-placed revision over a Guide-only change or the original contract. The
  shared lessons extend Claude `default-guide.md` and Codex `core.md`, and the design lesson extends Guide in both
  releases, with a no-growth budget.
- 2026-09-25: The user shared a Dao De Jing summary for software and authorized the Agent to add Daoist ideas to this
  task. The Agent added invariant-at-creation with the control-code reason, plus divide-at-the-joints. It excluded
  flexibility and reversibility maxims and relaxed the per-file budget from about two lines to about three.
