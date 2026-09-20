---
id: 20260919-restore-active-guide-tracer-slices
status: completed
queue: current
depends_on: []
created: 2026-09-19
updated: 2026-09-19
---

# Goal

Restore default Guide as the active owner of project design, instruction-aware decisions, and durable task maintenance,
and add conditional tracer-bullet execution slicing for new features. Guide should turn rough thoughts into an explicitly
confirmed, executable task instead of silently treating design discussion as disposable advice, interrogating the user
about ordinary coding details, or proceeding directly to implementation.

## Acceptance

- With no explicit alternate workflow or mode, project work enters Guide and remains design-owned until the task is ready.
- Guide creates a task as soon as a distinct project objective is worth preserving. A project-direction question such as
  whether tracer-bullet development belongs in oh-my-guide qualifies. Pure general-knowledge questions and read-only
  status lookups do not create a task or cause a non-material rewrite of existing task state.
- Every material change to requirements, design, scope, execution slices, validation, decisions, or readiness updates the
  same task in that turn without a save reminder. Follow-up discussion does not create a duplicate task.
- Guide actively investigates relevant evidence, recommends a direction, and asks the next consequential question until
  all material product and architecture ambiguity is resolved. It does not replace clarification with silent assumptions
  or a passive answer, nor impose a fixed questionnaire for routine local details.
- Clarification is progressive: ask one highest-impact product, architecture, scope, or user-visible tradeoff at a time;
  first apply each answer to the task, then advance. Guide and Task decide ordinary coding, file-level, library-usage, and
  other local implementation details themselves instead of repeatedly asking the user.
- Guide and Task proactively read applicable loaded/project/topic instructions before making a decision or editing, apply
  instruction priority, and treat those instructions as binding defaults. They do not repeatedly violate an existing
  instruction and then ask the user to restate it.
- A task becomes `ready` only when observable acceptance, design, scope, execution slices, and validation allow execution
  without guessing a material choice. Guide then presents the execution instruction and waits for the user's explicit
  confirmation before implementation begins.
- The platform task command (`/task <id>` or `$oh-my-guide task <id>`) and a clear natural-language instruction to execute
  the identified ready task are equivalent authorization. A vague acknowledgement such as "okay" or "looks good" is not.
- Explicit `quick` and `task <id>` invocations remain direct execution authorization. Ordinary default-Guide conversation
  cannot bypass the ready-task confirmation transition merely because the initial request mentions implementation.
- For a new feature that crosses meaningful boundaries or has solution-changing integration risk, Guide makes the first
  execution slice the thinnest production-intent path from a real input to an observable result through the actual owners.
  The task records the risk proved and the deliberately deferred breadth. Local low-risk changes do not acquire this ritual.
- Tracer-bullet code evolves into the final implementation; a disposable spike remains a separate tool. Validation must
  not mock away the boundary the slice is intended to prove.
- OpenCode and Codex express equivalent behavior while preserving their runtime differences. No new Agent, Skill, command,
  ledger, execution lock, checkpoint, framework profile, or routine multi-stage acceptance protocol is introduced.
- Package and isolated installation checks pass. Static prompt checks are reported honestly as insufficient to prove future
  model compliance.

## Design

Verified regression: commit `265797b` replaced default Guide ownership with intent-based direct routing. It added explicit
"one-off ... without task writes" paths, changed durable state from automatic to only "when useful", removed the hard
requirement to update affected task sections on every material discussion change, and allowed clear implementation
requests to proceed without the former ready-task confirmation transition. The change spans
`releases/codex/default-guide.md`, the Codex Skill router and Guide reference, `.opencode/agents/guide.md`, and `README.md`.

Restore the prior active Guide invariants selectively rather than reverting the whole commit. Preserve useful simplification
and natural-language commands where they do not bypass design ownership. Separate automatic task state from opt-in
long-term context/instruction saves. Keep one explicit transition from a ready design to execution, not repeated approvals.

Limit Guide questions to unresolved choices whose answers can materially change required behavior, architecture, scope,
compatibility, or another user-owned tradeoff. Evidence, repository conventions, and applicable instructions settle
routine engineering choices; Task owns local implementation decisions within the accepted contract.

Verified instruction regression in `265797b`: the earlier Task contract explicitly inspected `AGENTS.md`, project
instructions, package core preferences, and user preferences before editing; the earlier Guide explicitly read
`docs/instructions/README.md` and relevant topic files. The patch replaced these discovery points with discretionary
phrases such as "if needed", "relevant source and topic instructions", and "instructions that can change the current
answer", while deleting the concrete topic-index route. `templates/instructions/README.md` remains, but Guide/Task no
longer reliably discover its installed project counterpart. Priority language survived, so the primary failure is weakened
discovery and timing, compounded by generic wording that lets an Agent decide the instructions are unnecessary.

Restore deterministic instruction discovery without rescanning everything on every turn: at a new project objective,
after context loss, or when scope changes, Guide reads the applicable loaded/repository instructions and the project topic
index when present, then only affected topics. Before editing, Task rechecks the accepted task and applicable instructions
for the affected paths, reusing unchanged instruction content already in context. Apply runtime instruction priority;
instructions and repository conventions settle local implementation details instead of generating user questions.

Restore the pre-`265797b` ready-task handoff while retaining one useful clarification from the newer routing: historically,
Guide displayed the platform task command and invocation authorized implementation, but natural-language equivalence was
not explicit. The revised contract accepts either the exact command or an unambiguous instruction to execute the named
ready task, while rejecting vague assent and initial default-Guide implementation wording as execution authorization.

Implementation ownership is now concrete: OpenCode Guide and Codex Guide restore active design/task maintenance and the
single ready-task handoff; OpenCode Task and Codex execution guidance restore explicit instruction preflight and implement
conditional tracer slices. The default Codex bootstrap and Skill router restore Guide ownership. Shared core contracts
clarify instruction priority and execution authority; both task templates and README reflect the same behavior.
`templates/instructions/README.md` already supplies the relevant-topic and priority contract and can be reused unchanged.
No semantic checker or new runtime owner is needed.

The current `scripts/install.sh --check` validates file counts, ownership, frontmatter, required files, and only one generic
Codex-bootstrap phrase; it does not assert any active-Guide lifecycle invariant. This allowed source and installed outputs
to remain structurally valid after task creation, continuous update, and confirmation semantics were removed. The user
explicitly chose not to add semantic contract assertions: actual Guide usability remains the feedback mechanism, while
the existing structural/package checks continue to validate packaging rather than model behavior.

Encode tracer bullets as an optional execution-slicing rule inside existing Guide, Task, and `.tasks/` contracts. Reuse
`Design` for the real path and risk, `Scope` for deferred breadth, `Execution slices` for the first end-to-end slice, and
`Validation` for proof. Do not add a named mode or schema section.

## Scope

Included: default routing/bootstrap, instruction discovery and priority, OpenCode Guide/Task contracts, the single Codex
Skill and its Guide/Task references, shared core wording where execution authority and question ownership must be
distinguished, task templates, README, and existing validation needed to keep both releases aligned.

Excluded: real-home installation, new commands or runtime components, unrelated workflow cleanup, model changes, plugin
changes, semantic contract assertions in package checks, staging, commit, push, and publication.

## Execution slices

- [x] Restore one real default-Guide path from a rough project thought through immediate task creation, continuous task
      updates, readiness, and explicit user-confirmed execution handoff in both release contracts.
- [x] Restore instruction-first evidence gathering and keep progressive clarification limited to material product,
      architecture, scope, and user-owned tradeoffs; leave ordinary coding decisions to Guide/Task.
- [x] Add the conditional tracer-bullet rule to design, execution, templates, and validation without creating a new mode
      or making it mandatory for local low-risk work.
- [x] Align documentation and isolated installed outputs, then run package, syntax, ownership, and diff validation.

## Current state

Completed. OpenCode and Codex now implement the accepted active Guide lifecycle, instruction discovery/priority,
Agent-owned coding details, ready-task confirmation, and conditional retained tracer slice. README and both task templates
are aligned. Final package, syntax, contradiction, diff, and isolated-install checks passed. No real-home installation,
semantic contract checker, external write, or Git-history action occurred.

## Validation

- PASS: Final diff review preserves the useful execution/runtime simplifications from `265797b` while restoring the
  pre-regression active Guide, continuous task maintenance, instruction discovery, and confirmed ready-task handoff.
- PASS: `bash scripts/install.sh --check` reports exactly three OpenCode Agents, seven commands, four Skills, and one Codex
  Skill. Shell syntax checks passed for all three package scripts; `git diff --check` passed.
- PASS: A targeted source scan found no remaining direct-answer/no-task or automatic-initial-implementation clauses that
  contradict the accepted default Guide behavior.
- PASS: OpenCode and Codex isolated installs ran only under project-root `.tmp/`; installed Guide, Task, preferences,
  bootstrap, Skill, references, asset, and helper matched their release sources. Temporary validation output was removed.
- PASS: Both releases require event-based instruction discovery, progressive material design questions, Agent-owned coding
  details, and conditional retained tracer slices through real owners without mocking the boundary under proof.
- PASS: No new Agent, Skill, command, ledger, runtime owner, semantic behavior assertion, or routine multi-stage approval
  protocol was added. `scripts/install.sh` remains unchanged.
- LIMIT: Static source and isolated packaging evidence cannot establish future model compliance; actual use remains the
  accepted prompt-efficacy feedback mechanism.

## Decisions

- 2026-09-19: The user accepted adding tracer-bullet thinking as a conditional rule for new-feature development.
- 2026-09-19: Default Guide must actively create and update tasks, proactively resolve design ambiguity, and present a
  ready development instruction for explicit user confirmation before implementation.
- 2026-09-19: The missing task in the preceding tracer-bullet discussion was erroneous and this objective now owns that
  discussion rather than creating a separate task.
- 2026-09-19: Project design, change, investigation, and direction objectives create or update a task; pure general
  knowledge and read-only status requests do not. Explicit `quick`/`task` invocation authorizes execution directly, while
  ordinary default Guide requires a ready task followed by explicit user confirmation.
- 2026-09-19: Do not add deterministic semantic contract checks. Existing structural/package validation remains, and the
  user will request further adjustment if real Guide behavior is uncomfortable.
- 2026-09-19: Use progressive clarification: one highest-impact material design question at a time, updating the task before
  advancing. Discuss architecture and design with the user; Guide and Task decide ordinary coding details themselves.
- 2026-09-19: Applicable instructions are binding defaults and must be proactively read and respected by both Guide and
  Task rather than repeatedly rediscovered through user correction.
- 2026-09-19: Instruction discovery is event-based and scope-relevant rather than a full rescan on every message. This is
  an ordinary workflow implementation decision derived from the accepted instruction-first behavior.
- 2026-09-19: A platform task command or unambiguous natural-language instruction to execute the identified ready task
  authorizes implementation; vague assent does not. This restores the earlier ready-task handoff and makes its natural-
  language equivalent explicit.
