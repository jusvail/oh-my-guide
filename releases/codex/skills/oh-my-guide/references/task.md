# Execution modes

Apply the selected `task`, `quick`, `reduce`, or `ship` mode. Reduce authorizes internal architecture redesign under its
preservation contract; other modes retain their accepted boundaries. Do not delegate or repeat granted permission.

Never create or modify a file outside the opened project unless the request explicitly names that external effect. Put
implicit scratch files, logs, screenshots, generated validation artifacts, and temporary copies under project-root
`.tmp/`, then remove them when no longer needed.

## Shared execution rules

Implementation and reduction checks below apply to `task`, `quick`, and `reduce`; utilities use their stated preflight.

- For `task`, `quick`, and `reduce`, inspect the repository root, branch, HEAD, worktree, relevant source, loaded `AGENTS.md` files,
  current task/context, and available validation before editing. Preserve unrelated work.
- Implement the accepted result directly. In ordinary Task/Quick, local implementation details are yours; material
  ownership, interfaces, data semantics, compatibility, scope, and sequencing remain bound to the accepted design.
  Reduce may redesign internal architecture under its own contract, including when resuming that recorded task.
- If a material decision blocks required work, record the contradiction or missing decision as `blocked` rather than
  guessing. In Reduce, continue independent supported candidates first.
- Do not author tests, fixtures, mocks, snapshots, or test-only helpers unless the task explicitly requests test code.
- Read reuse anchors from the contract or current request before editing; inspect definitions and calls before declaring a gap.
  Never silently substitute for mandated components. Reuse existing capabilities within the authorized design; record a material
  contradiction instead of inventing a fallback. Routine local implementation decisions remain yours.
- Implement coherent slices using existing capabilities and authoritative state. Review task-owned changes for unnecessary
  layers, duplicate state, speculative flexibility, and unrelated edits as you proceed. Use bounded ablation/delta-reduction
  experiments on plausible removable parts, not every line; preserve required behavior and restore only your failed change.
  Missing evidence alone does not justify deletion; Reduce defers GUI acceptance to the user as specified below.
  Other user work must remain intact.
- Inspect the final diff and map acceptance to direct final-worktree evidence. Run required, proportional validation; expand
  or repeat it only for new changes, failures, or unresolved concerns. Briefly report concrete reuse, material additions and
  their necessity, useful reductions, and verification limits. Never remove tests to obtain a pass.
- Do not stage, commit, push, install, publish, or rewrite history except in explicit `ship` mode.

## `task`

Input is exactly one task ID shaped `YYYYMMDD-short-slug`.

1. Read `.tasks/open/<task-id>.md`. If absent, report that exact missing contract; if archived, report its terminal state.
2. `designing` is not executable. For `ready`, `active`, or `blocked`, inspect live reality and recheck recorded blockers.
3. Set executable work to `active`; invocation authorizes adopting current work, editing the accepted scope, validation,
   and task-state updates.
4. Respect a dependency only while its result remains a real prerequisite.
5. Update execution slices, current state, validation, and `index.md` after material progress.
6. When every acceptance condition is implemented and directly verified, mark `completed`, move the task to
   `.tasks/archive/YYYY-MM/`, and regenerate the index. Wait only for an explicitly named subjective review condition.

## `quick`

The supplied request authorizes one small, self-contained change. Inspect enough reality to prove there is no material
product or architecture decision. If one exists, make no product edit and report that Guide must design it. Otherwise
implement, self-review, validate, and report without durable task state.

## `reduce`

Invocation authorizes autonomous internal architecture redesign and code reduction within the selected scope. Reassign
internal responsibilities/state ownership, redesign internal interfaces, merge modules, and replace redundant architecture
when that removes complexity. Current files, types, ownership splits, and call graphs are evidence, not constraints to
preserve. Record the simpler design in the same task and execute; no additional Guide/Redesign approval is required.
Preserve required product behavior, public contracts, persisted-data meaning, lifecycle/concurrency semantics, integrations,
and mandated components. Ask only for changed requirements or real user-facing tradeoffs, not internal design decisions.

Resolve scope from supplied paths, a subsystem, current diff, or unambiguous context. If unclear, inspect enough to ask the
missing scope question in plain text before editing; never assume the whole repository. Exclude unrelated user changes
and generated/vendor code unless explicitly included. Create or resume one `.tasks/open/YYYYMMDD-short-slug.md` using the
existing task schema: Goal, Acceptance, Design, Scope, Execution slices, Current state, Validation, Decisions; frontmatter
id, status, queue, depends_on, created, updated. Record preserved behavior, reuse anchors, target design, baseline evidence,
and slices; set executable work active, normally queue current, and update the index. Resume through the same task ID.

Apply these named methods in dependency order, revisiting affected candidates as evidence changes. Program Reduction is
also the overall objective; skip inapplicable operations rather than performing a full-repository sweep for each term.

1. **Program Slicing**: trace required outputs, persisted effects, integrations, callers, and data dependencies. Untraced
   code or absence of static references is not proof that code is dead.
2. **Essential / Accidental Complexity**: distinguish necessary behavior from implementation-imposed layers, coupling,
   state, and control flow. A necessary responsibility does not justify all of its current implementation.
3. **YAGNI** and **Out of the Tar Pit**: identify speculative flexibility, duplicate flows/implementations, unnecessary
   work, derived stored state, and synchronization. Investigate reuse and elimination before building new abstractions.
4. **ablation study**: for significant structures, formulate an omission or replacement hypothesis and examine which
   required result depends on them. Use bounded experiments and available checks; pending manual GUI evidence does not
   require preserving the entire existing structure until the user can test it.
5. **Program Reduction**: implement the simpler design through deletion, reuse, consolidation, reduced state/control flow,
   and architecture replacement where useful. Preserve necessary identity/transaction/threading behavior, not redundant
   scaffolding. Remove superseded paths as replacement slices complete; do not merely relocate complexity into new layers.
6. **Delta Debugging**: when a reduction introduces a failure, narrow the responsible change and restore only what the
   required behavior needs instead of abandoning the simplification. Preserve unrelated work; fix known regressions.

For a large scope, inventory subsystem boundaries and investigate promising cross-file flows, forwarding chains, duplicate
capabilities, and state synchronization before settling for cosmetic cleanup. Prioritize eliminated complexity relative to
verification cost, not file size or easy line deletions alone. For material candidates, briefly record concrete anchors,
preserved invariants, a simpler alternative, eliminated work/state/indirection, and a validation route in existing task
sections. A retention reason must address the alternative, not merely say that history, identity, or transactions matter.
Do not manufacture candidates or demand a report for every symbol. Whole-repository scope permits cross-subsystem redesign;
implement coherent slices and re-examine affected callers and duplication when a reduction reveals another opportunity.

Distinguish enumerated, investigated, modified, and verified coverage. Stop when promising candidates within the requested
coverage have evidence-backed dispositions and no actionable candidate remains; one sweep or a passing build does not
establish this. Resolve candidate uncertainty with bounded investigation where feasible and continue independent work.
Report sampled/uninvestigated areas and concrete blockers honestly. No deletion/time quota, exhaustive search, or claim of
global minimality; a supported no-change result is valid. Missing required investigation is not completed coverage.

GUI acceptance belongs to the user. Lack of GUI access must not block development, redesign, or delivery. Complete source
reasoning and available proportional build/static/existing-test checks, distinguishing baseline failures from regressions.
Deliver concrete manual GUI flows and relevant event/state/lifecycle risks for the user to check. Never claim that a build
proves GUI equivalence or that missing GUI evidence proves a deletion safe. A missing GUI tool alone is not a blocker;
resolve known regressions and other concrete blockers normally. Continue implementation before requesting manual review.

Report implementation/agent checks complete separately from manual GUI acceptance pending. When GUI acceptance is part
of the task, leave it active with that pending condition in Current state; finish the turn without polling or inventing a
paused status. Archive after the user reports the required acceptance and other conditions pass. If GUI acceptance is
explicitly excluded from completion criteria, honor that scope. Otherwise apply ordinary task completion/archival rules.

## `ship`

The supplied text is the commit message; infer one concise English message from the current coherent change when blank.
Inspect repository root, branch, status, full and staged diffs, and recent commit style. Account for every dirty path, then
run the bundled `scripts/ship-project.sh` relative to this Skill with the repository root and chosen message.

`ship` explicitly authorizes staging all current changes, committing, and pushing the current branch. Honor hooks; never
amend, force-push, switch branches, discard work, install, release, or invoke a publishing hook. Report the commit and
remaining worktree state, or the exact failure.
