# Execution modes

Apply the selected `task`, `quick`, `reduce`, or `ship` mode. Reduce may choose local behavior-preserving simplifications;
do not invent material architecture, delegate, or repeat permission already granted by the invocation.

Never create or modify a file outside the opened project unless the request explicitly names that external effect. Put
implicit scratch files, logs, screenshots, generated validation artifacts, and temporary copies under project-root
`.tmp/`, then remove them when no longer needed.

## Shared execution rules

Implementation and reduction checks below apply to `task`, `quick`, and `reduce`; utilities use their stated preflight.

- For `task`, `quick`, and `reduce`, inspect the repository root, branch, HEAD, worktree, relevant source, loaded `AGENTS.md` files,
  current task/context, and available validation before editing. Preserve unrelated work.
- Implement the accepted result directly. Local syntax is yours; material ownership, API, schema, persistence,
  compatibility, scope, and sequencing are not yours to invent.
- If a material decision blocks required work, record the contradiction or missing decision as `blocked` rather than
  guessing. In Reduce, continue independent supported candidates first.
- Do not author tests, fixtures, mocks, snapshots, or test-only helpers unless the task explicitly requests test code.
- Read reuse anchors from the contract or current request before editing; inspect definitions and calls before declaring a gap.
  Never silently substitute for mandated components. Extend the real owner only within accepted scope; record a material
  contradiction instead of inventing a fallback. Routine local implementation decisions remain yours.
- Implement coherent slices using existing capabilities and authoritative state. Review task-owned changes for unnecessary
  layers, duplicate state, speculative flexibility, and unrelated edits as you proceed. Use bounded ablation/delta-reduction
  experiments on plausible removable parts, not every line; preserve required behavior and restore only your failed change.
  Unverified behavior is not evidence for deletion, and other user work must remain intact.
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

Invocation authorizes scoped, semantics-preserving cleanup, including its local reduction design, edits, and validation;
no separate Guide/Task approval is required. Preserve product behavior, public contracts, integrations, required controls,
and relevant nonfunctional constraints. Material product or architecture changes remain outside this authority.

1. Resolve scope from the supplied paths, subsystem, current diff, or unambiguous context. If missing, inspect only enough
   to identify the choice and ask for scope in plain text before editing. Never default to a whole-repository edit. Exclude
   unrelated user changes and generated/vendor code unless explicitly included.
2. Create or resume one ordinary `.tasks/open/YYYYMMDD-short-slug.md` contract with a unique ID and the existing schema:
   Goal, Acceptance, Design, Scope, Execution slices, Current state, Validation, Decisions; frontmatter id, status, queue,
   depends_on, created, updated. Use queue current and empty dependencies unless real prerequisites apply.
   Record behavior to preserve, reuse anchors, scope, slices, baseline checks/failures, and uncertainties before edits;
   set executable work active and update the index. This mode may derive local simplifications under those constraints.
3. Apply Program Reduction in dependency order, skipping inapplicable passes: trace outputs and side effects backward
   (Program Slicing); remove verified unnecessary work and duplicate implementations through reuse; reduce redundant state
   and synchronization (Out of the Tar Pit); collapse unjustified layers, branches, and hypothetical flexibility (YAGNI).
   Do not remove state whose lifecycle, concurrency, or measured performance role requires it.
4. Use ablation/delta-reduction thinking to validate bounded removal hypotheses against relevant behavior. Keep supported
   reductions; narrow a failed experiment to isolate what is necessary, restoring your failed edits. Unknown results are
   not permission to delete. Distinguish baseline failures from regressions; static checks alone do not prove runtime or
   visual equivalence. No exhaustive deletion search or mandatory full-repository sweep per theory.
5. For an explicitly selected large repository, inventory boundaries and work sequentially through verifiable subsystem
   slices. Keep progress, coverage, retained candidates/reasons, and validation in the same task. Continue independent
   supported reductions when one candidate is uncertain; do not quietly expand scope or redesign ownership.
6. Stop when no supported in-scope reduction remains. Report actual coverage, reductions, retained uncertainty, and final
   evidence; a valid no-change result is possible, not proof of global minimality. If a material decision or missing evidence
   prevents required coverage/validation, record it as blocked rather than claiming completion. Otherwise use task completion
   and archival rules. Resume interrupted work through the existing task ID and its recorded reduction contract.

## `ship`

The supplied text is the commit message; infer one concise English message from the current coherent change when blank.
Inspect repository root, branch, status, full and staged diffs, and recent commit style. Account for every dirty path, then
run the bundled `scripts/ship-project.sh` relative to this Skill with the repository root and chosen message.

`ship` explicitly authorizes staging all current changes, committing, and pushing the current branch. Honor hooks; never
amend, force-push, switch branches, discard work, install, release, or invoke a publishing hook. Report the commit and
remaining worktree state, or the exact failure.
