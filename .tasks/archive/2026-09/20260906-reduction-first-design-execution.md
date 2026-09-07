---
id: 20260906-reduction-first-design-execution
status: completed
queue: current
depends_on: []
created: 2026-09-06
updated: 2026-09-06
---

# Goal

Make Guide design and Task execution prefer the smallest complete behavioral change through verified reuse and
reduction of unnecessary implementation. Prevent small features from generating duplicate controls, owners, state,
and speculative abstractions. Add an explicit scoped reduction execution mode and streamline instructions primarily for
GPT-5.6 Sol and GPT-6 Astra. Deliver equivalent policy in OpenCode and the single Codex Skill.

## Acceptance

- Preserve Guide's core progressive dialogue: turn an initially vague idea into one or more executable tasks through
  evidence, proactive recommendations, meaningful user choices, and incremental clarification. Prompt reduction must
  not remove this responsibility or make Guide a passive question-answering mode.
- Automatically create a designing task once an objective is worth preserving, and update its affected sections in the
  same turn whenever discussion materially changes requirements, constraints, decisions, scope, or readiness. No reminder
  or explicit save request is needed for task state. Keep unaccepted proposals and unknowns distinct from accepted decisions.
- While material intent remains unresolved, Guide leads with a recommendation and presents a focused next decision,
  offering a small set of meaningful alternatives with tradeoffs when useful. Do not wait for the user to ask what is next.
  Once ready, give the executable command for each independently executable task; do not invent questions to prolong design.
- Both core contracts prioritize required behavior and explicit project constraints, verified reuse, and the smallest
  necessary implementation. Code volume is a diagnostic, never a quota or a reason to hide complexity.
- Guide traces the required observable result to relevant existing owners and actual definitions/call sites before
  proposing additions. Explicitly mandated components are binding, not a preference.
- Existing task sections carry concrete reuse anchors, prohibited substitutes, necessary additions and their capability
  gaps, and applicable verification. No new schema, ledger, Skill, Agent, approval gate, or mandatory essay is added.
- Task checks live reuse anchors, implements the smallest coherent slice, and reviews its own changed implementation
  for removable structure. It does not silently substitute primitives for mandated components.
- Reduction preserves required behavior and integrations. Missing evidence is not proof of safe deletion. No unrelated
  cleanup, erasure of user work, automatic broad rewrite, or test deletion to obtain a pass is authorized.
- Task and Quick apply proportional reuse/reduction rules. Ship and Clean retain their current behavior.
- OpenCode /reduce <scope> and Codex $oh-my-guide reduce <scope> directly authorize bounded semantics-preserving cleanup
  through existing execution ownership. They are implemented in the release sources; real-home installation remains a separate explicit action.
- Reduction uses existing .tasks/ state for resumable work and preserves all required behavior, project-mandated controls,
  public contracts, integrations, and relevant nonfunctional constraints. It never defaults to editing the entire repository
  when scope is absent. Uncertain candidates do not prevent independent, supported reductions.
- Instructions express outcomes, evidence, hard constraints, and stopping conditions without obligatory theory-by-theory
  rituals. Runtime/model availability and prompt efficacy must not be inferred from descriptions or static package checks.
- Package checks pass; report separately that static instruction validation cannot establish future model compliance.

## Design

Replace or tighten existing smallest-change and design/execution bullets instead of appending a theory catalog.

Core: establish a decision order, not an unconditional transformation sequence: required behavior and mandatory project
boundaries first; avoid unnecessary work and reuse approved capabilities; simplify within accepted scope; extend the real
owner only for a demonstrated gap; create new structure only when necessary. Never inline or unwrap a mandated boundary
merely to save lines. New state, dependency, branch, wrapper, or abstraction needs a current requirement or independent
responsibility; derived state should normally use its authoritative source unless measured or semantic needs justify storage.

Guide: apply backward-slicing thinking to find the smallest relevant behavior path, not to declare unrelated code dead.
Inspect relevant definitions and a representative use, including project instructions/import conventions. Within Design,
record the concrete owner/component/API to reuse and the smallest gap requiring an addition. Within Acceptance/Scope,
record binding prohibitions. First consider whether wiring, configuration, reuse, or local simplification already solves
the request. Use counterfactual reduction on the proposed design before execution: which accepted result fails if a
proposed layer/state/configuration is omitted? Do not invent future requirements to justify retaining it.

Guide's conversational ownership is a protected behavior, especially in the Codex instructions. Accept rough initial ideas;
infer what evidence can settle, identify the highest-impact remaining intent decision, and guide the user toward clarity.
Each material answer or correction must first be incorporated into the durable contract, then inform the next recommendation
and focused question. Offer a few genuinely distinct choices when they help the user decide, explaining the recommended
choice and its tradeoff; do not turn this into a compulsory questionnaire or require approval for routine engineering details.
Keep task state current throughout discussion, not only at final handoff. If later discussion reopens a material decision,
return the affected ready task to designing and update the index; preserve unaffected tasks and split only independent goals.
Task updates are automatic coordination, distinct from explicitly saving long-term context or global/project instructions.
The latter's opt-in rule must never suppress task updates. User-requested pauses and side questions are respected without
losing the active objective. When no material choice remains, mark ready and return the appropriate execution command(s).
Reduce reasoning boilerplate and repetition, not these observable behaviors. 'Avoid unnecessary questions' applies to
redundant permission and settled/local details, not to resolving the user's unclear product intent.

Tighten existing Guide clauses to remove specific ambiguity rather than adding a second dialogue protocol:
- In the Codex opening, separate automatic .tasks/ writes from explicitly requested instruction-state writes. The current
  '.tasks/ state and instruction state the user explicitly asks to save' can be read as requiring save authority for both.
- Port OpenCode's explicit recommendation-first responsibility into Codex; Codex currently has a question restriction
  without the matching affirmative recommendation rule. Preserve platform differences, not this behavioral omission.
- Classify each unresolved issue by how it can be settled: inspect repository facts directly; decide routine reversible
  engineering details within constraints; ask the user about material intent/value tradeoffs. Give 2-3 credible choices
  when useful, preferred choice first with its cost. Do not offer artificial alternatives or use engineering judgment to
  silently settle a product preference. Translate vague adjectives into a concrete user scenario or observable example
  where that resolves ambiguity, without imposing a requirements questionnaire.
- A substantive design response should make the current conclusion and next useful action apparent: a focused user
  decision, a bounded evidence step Guide performs, or execution command(s) when ready. This is an outcome expectation,
  not mandatory headings or a repeated recap. Explain meaningful changes or tradeoffs briefly; keep bookkeeping quiet.
- Update all affected task sections together, removing superseded recommendations from the operative design rather than
  merely appending corrections to Decisions. Record only material unresolved issues and the next design action in Current
  state, enough to resume after compaction without repeating settled questions. No new fields or mirrored checklist.
- Readiness means execution will not have to guess a material product/architecture choice, not that every possible detail
  is specified. Unanswered material preference questions prevent readiness; minor local details and clearly disclosed
  non-blocking assumptions do not. Suggested user choices are not accepted through silence or a generic acknowledgement.
  A user's explicit request for Guide to choose authorizes a reasoned recommendation within the existing constraints.
- Permit command(s) and dependency order for multiple independent ready tasks; replace the current single-command-only
  wording where needed. Follow-up discussion continues the same objective, not a frozen handoff or a new duplicate task.

These are repository-grounded failure risks, not a verified diagnosis of the user's earlier Astra session. Implement them
by rewriting the affected opening, design, persistence, and readiness clauses compactly; do not paste this rationale into
the shipped prompts or expand every turn into a fixed ritual.

Task: read the task's actual anchors before editing; absence from one search is not evidence of a missing capability.
Recheck candidates at relevant definitions and usage sites. A mandatory component gap must be addressed within the accepted
extension scope; a material contradiction uses the existing blocked mechanism, without a silent fallback or routine
permission request. Ordinary local implementation choices continue autonomously.

During each coherent implementation slice, prefer direct composition and existing state. Before final validation inspect
the task-owned diff for duplicate wrappers, synchronized derived state, unused flexibility, and unrelated edits. Apply
ablation/delta-reduction thinking only to plausible unnecessary parts, using bounded reversible removals and relevant
behavior checks. Keep supported simplifications; if behavior fails, restore the needed part without discarding unrelated
work. Unknown results do not prove dispensability. Stop when no supported in-scope reduction remains; do not claim global
minimality or exhaustively delete/retest every line. Reuse existing validation; no new test framework or test code is requested.

Validation reports should briefly name reused anchors, material additions and their necessity, and meaningful reductions
when present. Inspect addition/deletion counts alongside new files, owners, state, and dependency edges; reject line-count
gaming, compressed unreadable code, and unrelated deletions offsetting additions. No hard numeric budget or formal report
is required for every small change. Performance-specific additions require relevant measurements, not speculative caching.

Explicit reduction: add one reduce command routed to existing OpenCode Task and one mode routed to existing Codex
references/task.md. No Reduction Agent, extra Skill/reference, or alias. Invocation authorizes inspection, a concise local
behavior-preserving reduction contract, edits, and validation in the requested scope, without another Task invocation.
Ordinary Task remains bound to a ready accepted design; Reduce is explicitly allowed to derive local simplifications under
its preservation constraints, not to invent product behavior, interfaces, ownership reorganizations, or migrations.

Resolve scope from supplied paths, subsystem, current diff, or unambiguous conversation context. Without a clear target,
perform bounded inventory and request the one missing scope choice before editing; do not interpret omission as whole-repo
authority. An explicit whole-repository target permits inventory and sequential subsystem slices, not an upfront global
rewrite. Exclude unrelated user changes, generated/vendor code, and independent behavior fixes unless explicitly included.

Use this dependency-aware order, skipping inapplicable passes: establish observable behavior, integrations, required
controls and available baseline evidence; trace relevant paths and reuse owners; eliminate verified unnecessary work and
duplicate implementations; reduce redundant stored state and synchronization only when semantics/performance allow;
collapse unjustified layers, branches, and flexibility; validate bounded removal hypotheses and inspect the final diff.
Program Reduction is the objective; slicing guides scope; ablation/delta-reduction supplies the experiment loop; Out of
the Tar Pit guides state/control-flow scrutiny. They are not separate mandatory full-repository sweeps. A failed removal
may be narrowed to isolate its necessary part; unknown evidence is not permission to delete. Existing baseline failures
must be distinguished from regressions. Static checks alone do not prove runtime/visual equivalence.

Create or resume one ordinary durable task for explicit reduction; track subsystem slices and evidence in existing sections.
For fresh work resolve a unique normal task ID internally; resumption by /task <id> follows its recorded contract.
No extra checkpoint or ledger. Continue independently verifiable slices if one candidate is unsupported. Record retained
candidates and reasons; stop when no supported in-scope reduction remains or a material decision blocks remaining work.
Report the actual coverage, reductions, retained uncertainty, and verification. Do not label a partially scanned large
repository fully reduced, or a no-change result globally minimal. No automatic commits, installations, or test deletion.

Model alignment: use one shared concise outcome-led policy for Sol and Astra; no model-specific process profiles or prompt
forks. Keep project reuse constraints explicit, allow routine local judgment, clarify existing authorization, and end
validation after required checks pass unless new evidence warrants more. Remove duplicate generic reasoning instructions;
retain tool/ownership boundaries. Skill/Agent descriptions should state selection triggers, responsibilities, and exclusions,
not model praise or lists of theory names. Preserve Scout's bounded evidence-only role; Codex remains one Skill without
delegation. Do not claim Astra needs no Skills or that deleting instructions necessarily improves results.

The current OpenCode recommended profile has Guide=Sol/max and Task=Scout=Luna/max. Proposed workload alignment is
Guide=Astra, Task=Sol, Scout=Luna, retaining existing effort values initially rather than simultaneously changing effort.
Before changing profile IDs, verify target provider availability/schema in the supported OpenCode environment; API model
availability alone is insufficient. If this cannot be verified, preserve the profile and disclose this portion as unverified
rather than introducing a guessed fallback. Codex model selection remains with the user/runtime; do not edit user config.

## Scope

- Edit preferences/core.md and .opencode/agents/{guide,task}.md.
- Mirror applicable semantics in releases/codex/skills/oh-my-guide/references/{core,guide,task}.md.
- Add concise prompts inside existing sections of templates/task.md and the Codex assets/task.md, without new headings
  or frontmatter keys. Keep inline task shapes consistent; they need no expanded checklist.
- Add .opencode/commands/reduce.md; update the Codex SKILL.md mode router, README, installer command inventory, and the
  repository AGENTS.md canonical command list to acknowledge the requested seventh OpenCode command. This explicitly
  requested functional entry supersedes the old six-command inventory; it is not a reasoning-phase command.
- Update descriptions and remove demonstrably redundant prose only on these affected surfaces. Preserve Scout, existing
  utility command semantics, other Skills, bootstrap, and runtime permissions. The recommended OpenCode profile may change
  only the verified Guide/Task model IDs described above; no new framework profile or model routing machinery.
- V-series controls are the user's motivating example, not a universal package dependency or hard-coded framework rule.
- No product implementation, global installation, new tests, Git staging, commits, or pushes are included.

## Execution slices

- [x] Tighten the two core contracts and Guide design rules with equivalent reuse/reduction semantics.
- [x] Preserve and clarify Guide's progressive recommendations, meaningful choices, automatic task updates, and command handoff.
- [x] Tighten Task/Quick execution and both existing templates without adding a process layer.
- [x] Implement explicit Reduce routing and its scoped resumable execution contract; update inventory and documentation.
- [x] Streamline affected descriptions/instructions for Sol/Astra and verify any recommended profile model changes.
- [x] Review the final instruction diff for contradictions and instruction bloat; run package validation.

## Current state

Completed. Both release sources now preserve progressive Guide dialogue, automatic same-turn task updates, focused
recommendations/choices, reopening and recovery, and per-task execution commands. Verified reuse and bounded reduction
apply to design and execution. Reduce uses the existing Task/runtime and task schema; installer owns seven OpenCode commands.
No new Agent, Skill, schema, runtime permission, or permanent test artifact was introduced. Temporary validation files removed.
The isolated OpenCode model query returned `Provider not found: openai`; the accepted fallback preserves the recommended
profile. Sol/Astra prompt behavior has not been evaluated through independent model runs. No real-home installation,
staging, commit, or push was performed.

## Validation

- PASS: `bash scripts/install.sh --check` on final sources: 3 OpenCode Agents, 7 commands, 4 Skills, one Codex Skill.
- PASS: `git diff --check`; final diff inspected for scope, instructions, and contradictions.
- PASS: fresh and repeated isolated installs for both platforms under `.tmp/reduction-validation/install`, with all required
  destination variables set. Repeated installs were byte-identical; final source refresh matched every manifest-owned file.
  Personal command/Agent, preference, Skill, configuration, plugin, and global instruction fixtures survived unchanged;
  the marked Codex block appeared once. New Reduce command and single-Skill layout verified.
- PASS: shared core reduction policy, Guide design section, Reduce behavior, and task templates match across releases.
  Existing Agent permissions, Ship/Clean bodies, Scout, bootstrap, and recommended model profile match HEAD exactly.
- Static scenario review: vague intent is grounded with examples and recommendations; facts are inspected rather than
  asked; material preferences are not guessed; no-save discussion changes update operative task sections; generic
  acknowledgement does not select a choice; corrections reopen readiness; recovery avoids settled questions; multiple
  tasks receive commands and dependency order. These are instruction reviews, not executed model dialogues.
- Static scenario review: mandatory controls cannot be bypassed; existing APIs are inspected before additions; actual gaps
  stay within accepted ownership; speculative wrappers/state receive reduction scrutiny; narrow checks do not authorize
  unknown deletions; Quick gains no task ledger. Reduce requires scope, slices large repositories, preserves necessary
  caches and baseline evidence, resumes through its task ID, and does not block independent work on uncertain candidates.
- Verified conflicts resolved: Reduce explicitly permits local reduction design, missing scope uses plain text without
  changing OpenCode question-tool permissions, candidate uncertainty does not block independent reductions, and utilities
  retain their original preflight. Guide task-write authority is separate from explicit instruction-save authority.
- Model configuration limitation: isolated `opencode models openai` returned `Provider not found: openai`; proposed
  Guide=Astra/Task=Sol mapping was not applied, as specified by the accepted fallback. Existing profile remains unchanged.
- Sol/Astra behavioral evaluation: unperformed. No delegated model runtime was launched; static/install checks do not
  establish future compliance, reduction quality, or prompt efficacy.

## Decisions

- Guide's core remains proactive, progressive clarification leading to durable executable task(s). User explicitly rejects
  simplification that suppresses rolling task updates, recommendations, meaningful choices, or next-step command handoff.
- User requested an optimization proposal, with Program Reduction, Delta Debugging, and ablation informing both design
  and execution. Use existing workflow ownership and .tasks/ only; implementation follows explicit Task invocation.
- Apply stronger necessity scrutiny primarily to proposed and task-added structures; preserve required existing behavior
  and mandated reuse boundaries. A passing narrow test alone does not authorize deleting unfamiliar existing code.
- User additionally requested an explicit cleanup entry and model alignment. Recommend Reduce for execution while Redesign
  remains design of replacement structure. Explicit cleanup may examine existing in-scope code, subject to preservation.
- Official evidence: https://developers.openai.com/api/docs/guides/latest-model documents Astra's sensitivity to Skills and
  AGENTS.md, possible unnecessary clarification, and disproportionate testing. It does not establish that Skills are obsolete.
- Official evidence: https://developers.openai.com/api/docs/guides/latest-model?model=gpt-5.6 recommends domain context,
  hard constraints, approval boundaries, and success criteria without prescribing every step. The recommendation to use
  one concise policy and the proposed OpenCode role mapping are design judgments, not benchmark findings.

- Implementation completed with verified release parity and isolated installation preservation; model-profile changes
  used the accepted preserve-and-disclose fallback because provider availability could not be verified.
