# Loop Engineering Pack

This folder defines reusable work loops for agent-driven engineering inside
this Harness repo. A loop is a repeatable operating protocol with a clear goal,
bounded context, a verifier, a repair policy, and an explicit stop condition.

The pack combines:

- The local Harness model in `docs/HARNESS.md` and `docs/FEATURE_INTAKE.md`.
- The provided Core Loop and Web Build Loop drafts.
- Loop-engineering patterns from the Tosea guide, checked on 2026-06-23:
  https://tosea.ai/blog/loop-engineering-ai-agents-complete-guide-2026

## How To Use

Every task starts with `core-loop.md`, then adds exactly the domain loop that
matches the selected work. Add `security-risk-loop.md` as an overlay when the
task touches auth, authorization, data ownership, audit/security, payments,
privacy, provider callbacks, or validation weakening.

```text
Human task
  -> Core Loop
  -> One primary domain loop
  -> Optional risk overlay
  -> Verifier
  -> Trace
```

## Loop Router

| Work type | Primary loop | Add overlay when needed |
| --- | --- | --- |
| Any repo task | `core-loop.md` | `security-risk-loop.md` for hard gates |
| Marketing site, portfolio, blog, landing page | `web-build-loop.md` | `security-risk-loop.md` for claims, forms, tracking, or payment |
| Authenticated UI, dashboard, SaaS workflow | `web-app-loop.md` | `security-risk-loop.md` for roles, tenant scope, private data |
| API, backend service, worker, CLI service | `api-backend-loop.md` | `security-risk-loop.md` for auth, data, contracts, webhooks |
| ETL, analytics, migration, import/export | `data-pipeline-loop.md` | `security-risk-loop.md` for PII, deletion, retention, migrations |
| Script, bot, scheduled task, internal tool | `automation-loop.md` | `security-risk-loop.md` for credentials or external side effects |
| Research, docs, product brief, strategy artifact | `research-doc-loop.md` | `security-risk-loop.md` for regulated or private content |

If two domain loops seem applicable, choose the loop for the main user-visible
outcome and borrow only the checklist items needed from the second loop.

## Loop Anatomy

Each loop in this pack follows the same shape:

1. Purpose and suitable tasks.
2. Required inputs.
3. Step-by-step loop.
4. Verification ladder.
5. Repair and retry policy.
6. Stop and escalate conditions.
7. Done definition.
8. Prompt template.

## Design Principles

- State the goal before acting.
- Load only context needed for the lane and phase.
- Pick a verifier before editing.
- Keep one loop run tied to one bounded story or direct tiny patch.
- Prefer deterministic checks over subjective review.
- Repair with small changes and stop when no progress is visible.
- Record durable intake, story proof, trace, decisions, and friction.

## Pattern Vocabulary

Use the simplest pattern that can finish the work safely:

| Pattern | Use when | Harness expression |
| --- | --- | --- |
| Plan -> act -> verify | Most normal implementation | Core Loop default |
| ReAct | Investigation and implementation are interleaved | Context load, act, verify, repair |
| Evaluator-optimizer | Output quality is subjective or iterative | Build, inspect, revise, verify |
| Orchestrator-workers | Several independent specialist tasks exist | Main agent coordinates; subagents are optional |
| Reflexion | A failure teaches a repeatable lesson | Trace friction, backlog, or doc update |

Do not use a heavier pattern just because it sounds more agentic. Heavier loops
must earn their cost through risk, ambiguity, or repeated failure.

## Minimal Agent Prompt

```text
Read:
- AGENTS.md
- docs/HARNESS.md
- docs/FEATURE_INTAKE.md
- docs/CONTEXT_RULES.md
- docs/loops/README.md
- docs/loops/core-loop.md
- the relevant domain loop under docs/loops/

Task: <task>

Follow the selected loop. Record intake, select the lane, define the verifier,
make the smallest safe change, verify, repair within attempt limits, update
story proof/docs, and record a trace. Do not claim completion unless the
verifier passed or the blocker is documented.
```
