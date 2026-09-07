---
id: 20260907-reduce-search-depth
status: completed
queue: current
depends_on: []
created: 2026-09-07
updated: 2026-09-07
---

# Goal

Make Reduce an autonomous architecture-simplification workflow with deeper investigation, explicitly named reduction
methods, and user-owned GUI acceptance, while preserving required behavior and binding project constraints. A user-reported VPS run over 60k+ lines removed 134 production lines and 46 configuration lines; its progress
messages describe mostly local consolidation and an unavailable GUI validation environment.

## Acceptance

- Both Reduce definitions distinguish subsystem enumeration, substantive investigation, edits, and verification. Do not
  imply that all significant opportunities are exhausted merely because one pass and a build finished.
- Investigate plausible high-impact duplicate flows, internal forwarding chains, repeated state/synchronization, and
  existing-capability reuse before treating only local cleanup as a sufficient search. No compulsory candidate count.
- Distinguish a necessary responsibility from the necessity of its current implementation. Retention reasons for material
  candidates address a concrete alternative and required invariant rather than simply naming a subsystem's purpose.
- Reduce invocation authorizes redesign of internal architecture, responsibility allocation, state ownership, interfaces,
  and cross-file/module structure within the selected scope. Current architecture is evidence, not a preservation constraint.
  Do not require a separate Guide/Redesign invocation for these decisions. Preserve required product behavior, public
  contracts, data semantics, and explicitly mandated components; changing those still requires user direction.
- GUI acceptance belongs to the user. Lack of agent GUI access must not block development, internal redesign, or delivery.
  Agent performs available proportional checks and provides a concrete manual checklist without claiming GUI equivalence.
- Both Reduce instructions explicitly name and operationalize Program Slicing, Essential / Accidental Complexity, YAGNI,
  ablation study, Program Reduction, Delta Debugging, and Out of the Tar Pit in a dependency-aware sequence.
- Preserve Guide dialogue, task/quick boundaries, utilities, permissions, single-Skill layout, and existing task schema.
- No deletion quota, time quota, repeated full sweep requirement, new command, separate ledger, or new test framework.

## Design

Rewrite the two existing Reduce sections and narrowly conflicting shared execution clauses. Keep the policy compact.

Search: for the selected scope, identify subsystem boundaries and plausible sources of avoidable work/state/indirection.
Use targeted searches plus definitions/callers to investigate promising candidates, including cross-file ones, instead of
limiting discovery to obvious unused variables and identical statements. Prioritize likely eliminated complexity relative
to validation cost, not file size alone. A subsystem's important name or necessary responsibility does not settle whether
its implementation can be simplified. Do not manufacture a candidate when bounded evidence shows no useful opportunity.

Candidate reasoning: for significant opportunities, record concrete anchors, required behavior/invariants, the simpler
existing-capability alternative, the work/state/indirection it eliminates, and a validation route. Then reduce or retain
with evidence. Keep concise entries in existing Design/Execution slices/Validation, not a mandatory report for each symbol.
Necessary object identity, transactions, threading, or history behavior must survive; their current scaffolding may still
be simplified. Do not infer removability from static-reference absence alone.

Authority: Reduce is explicitly an autonomous internal redesign mode as well as a cleanup mode. It may reassign internal
responsibilities/state ownership, redesign internal interfaces, collapse layers/modules, and replace redundant architecture.
Derive the simpler target from required behavior and actual reuse opportunities; record the relevant design in the same
ordinary task and execute without a second approval or Guide handoff. Current types, file boundaries, ownership splits,
and call graphs are evidence rather than authority. When scope is the entire repository, this includes coherent architecture
changes across subsystems, implemented in verifiable slices rather than leaving old/new paths indefinitely side by side.
Preserve public behavior/contracts, persisted-data meaning, necessary lifecycle/concurrency semantics, and mandated
components. Real user-facing tradeoffs or changed requirements need user direction; internal design decisions do not.
Ordinary Task/Quick remain governed by their accepted scope. Update conflicting shared/core wording with an explicit
Reduce exception, not a general relaxation of authority in all modes.

Named method sequence (write these names literally in the shipped instructions, not only in descriptions or documentation):
1. Program Slicing: trace required outputs, persisted effects, integrations, and their dependencies to understand behavior.
   Follow relevant callers/data paths; untraced code is not thereby dead.
2. Essential / Accidental Complexity: separate necessary behavior from implementation-imposed layers, state, coupling,
   and control flow. A needed responsibility does not establish the necessity of its current structure.
3. YAGNI plus Out of the Tar Pit: identify hypothetical flexibility, duplicate implementations, derived stored state,
   synchronization, and unnecessary work. Prefer reuse or elimination over creating a new general-purpose framework.
4. ablation study: formulate a concrete omission/replacement hypothesis for significant structures and examine which
   required result actually depends on them. Use bounded experiments and available checks; deferred manual GUI evidence
   does not require retaining the whole structure before development can proceed.
5. Program Reduction: implement the simpler design by deletion, consolidation, reuse, reduced state/control flow, and
   architecture replacement where needed. Keep target behavior and mandated boundaries; optimize retained complexity,
   not raw line counts or compressed syntax.
6. Delta Debugging: when a reduction introduces a failure, narrow the responsible change and restore only necessary
   behavior rather than abandoning the whole simplification. Revisit affected candidates as evidence changes.
This is a practical ordering of methods, not a claim that all are formal automated algorithms. Program Reduction is also
an overarching objective. Skip inapplicable operations; no seven full scans, exhaustive deletion experiment, or separate
report for every term. Prioritize duplicate/redundant code and unnecessary architecture over cosmetic cleanup.

Iteration/stop: re-evaluate affected callers and nearby duplication when a supported reduction exposes another concrete
opportunity. Stop when relevant promising candidates have evidence-backed dispositions and no unresolved actionable
candidate remains in the requested coverage. Do not require proof of global minimality or perpetual searching. If an area
was only enumerated, sampled, or cannot be investigated, report that limitation rather than claim it was substantively
reduced. A first sweep is progress, not automatically exhaustion; line counts/build success are not search-quality evidence.

Verification: the user owns GUI acceptance. Agent continues implementation and internal redesign with source analysis,
applicable build/static/existing-test checks, and concrete behavioral reasoning; GUI availability is not a development gate.
Report actual automated evidence and specific GUI flows for the user to verify, including meaningful risks introduced by
changed event/state/lifecycle paths. Do not claim a build proves GUI equivalence, silently remove functional requirements,
or ignore a known regression. Resolve concrete non-GUI failures normally; a missing GUI tool alone is not blocked work.
At delivery, distinguish implementation/agent checks complete from manual GUI acceptance pending. If manual GUI acceptance
is part of the task, leave the task active with that pending condition in Current state; do not add a paused status, keep
polling, or require manual acceptance before doing the development. Archive once the user reports the required acceptance;
if the user explicitly excludes it from completion criteria, honor that scope instead of inventing a gate.

## Scope

- .opencode/agents/task.md and releases/codex/skills/oh-my-guide/references/task.md: Reduce and conflicting shared wording.
- preferences/core.md and the Codex core reference only where a narrow Reduce exception is needed for internal redesign.
- README.md: clarify Reduce redesign authority, named methods, and user-owned GUI acceptance.
- Keep Guide and task templates unchanged; no new command, Agent, Skill, or coordination mechanism.
- No target-product edits, global installation, model configuration, new tests, Git staging, commits, or pushes.

## Execution slices

- [x] Rewrite both Reduce definitions with deeper search, autonomous internal redesign, the named sequence, and manual GUI handoff.
- [x] Resolve shared/core conflicts narrowly, preserving ordinary modes and explicit project constraints.
- [x] Review scenario coverage, preserve other modes, and run package validation.

## Current state

Completed against main at 139add5. Updated both Task/Reduce definitions, both core contracts with a narrow Reduce exception,
and README. Internal architecture redesign is authorized without another Guide approval; all seven requested method names
appear with concrete ordered operations. Search coverage and stopping evidence are explicit. GUI acceptance belongs to the
user and does not block agent development or delivery. Guide and normal mode contracts remain intact.
No global installation, target-repository edits, new test files, model changes, Git staging, commits, or pushes performed.
The user's remote progress excerpt remains the only evidence of that run; no target-code efficacy claim is made.

## Validation

- PASS: `bash scripts/install.sh --check`: 3 OpenCode Agents, 7 commands, 4 Skills, one Codex Skill.
- PASS: `git diff --check`; complete release diff reviewed for scope and conflicting rules.
- PASS: exact comparison of both Reduce bodies and ordered literal method names: Program Slicing, Essential / Accidental
  Complexity, YAGNI, Out of the Tar Pit, ablation study, Program Reduction, Delta Debugging.
- PASS: ordinary Task/Quick/Ship and OpenCode Clean bodies match HEAD; OpenCode permissions/frontmatter unchanged.
  Guide, Scout, templates, Skill router, and installer unchanged. Core changes consist only of the explicit Reduce exception.
  Changed tracked files are limited to the five accepted release files plus task index.
- Static scenario review: cross-file duplication and internal architecture replacement are investigated and executable
  without a new approval; required identity behavior need not preserve redundant scaffolding; mandated components remain
  binding; new opportunities trigger focused follow-through; sampled coverage cannot imply exhausted opportunities.
- Static scenario review: no significant candidate permits a supported no-change result; missing GUI access permits
  development and delivery with concrete user checks; required manual acceptance remains active, not blocked solely for
  missing GUI; a known regression is narrowed with Delta Debugging rather than ignored or used to abandon all reduction.
  Recovery via a recorded Reduce task retains its redesign authority.
- These are instruction/static checks, not independent model runs. Reduction effectiveness on the 60k+ line VPS codebase
  remains unverified; no deletion count or percentage is promised. Installation was not needed for unchanged routing/layout.

## Decisions

- Treat the supplied progress messages as the full available evidence. They support improving the prompt's depth and
  reporting requirements, not a definitive diagnosis of under-investigation or a claim that retained code is unnecessary.
- Retain /reduce as the single entry; improve defaults rather than add an aggressive mode or relax behavioral preservation.
- User explicitly expands Reduce authority to internal architecture redesign and owns manual GUI validation. Preserve
  behavior and binding constraints rather than current architecture; no extra approval for an internal redesign.
- Required method names appear literally in both runtime instructions with concrete operations and a sensible order.

- Implemented the accepted expanded Reduce authority and manual GUI handoff while preserving ordinary execution boundaries.
