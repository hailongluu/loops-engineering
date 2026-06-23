# Core Loop Engineering

Use this loop for every engineering task before selecting a domain loop.
Harness decides what should be read, how risky the work is, what proof is
required, and what durable records must be left behind. The Core Loop decides
how the agent repeats safely.

## Purpose

The Core Loop prevents prompt-to-code jumps. It forces each task through
intake, context selection, lane choice, verifier selection, implementation,
repair, and trace.

## Loop

```text
Human intent
  -> Intake
  -> Context
  -> Lane
  -> Plan
  -> Verify strategy
  -> Act
  -> Verify
  -> Repair
  -> Stop or escalate
  -> Trace
```

## Inputs

Before editing, identify:

- Input type: new spec, spec slice, change request, new initiative,
  maintenance request, or harness improvement.
- Risk lane: tiny, normal, or high-risk.
- Affected product docs, story files, decisions, and code surfaces.
- Verifier command or documented manual proof.
- External tool capability, checked through `scripts/bin/harness-cli query tools`
  before use.

## Intake

Classify the request with `docs/FEATURE_INTAKE.md`, then record it:

```powershell
.\scripts\bin\harness-cli.exe intake --type "Harness improvement" --summary "<summary>" --lane normal
```

On macOS/Linux, use `scripts/bin/harness-cli` instead of the `.exe`.

Expected intake output:

```text
Input type: Change request
Lane: normal
Reason: touches implemented behavior and public contract.
Affected docs: docs/product/..., docs/stories/...
Verifier: scripts/bin/harness-cli story verify <id>
```

## Context

Read the Harness entrypoint docs first:

- `AGENTS.md`
- `README.md`
- `docs/HARNESS.md`
- `docs/FEATURE_INTAKE.md`
- `docs/CONTEXT_RULES.md`
- `docs/TOOL_REGISTRY.md`
- `scripts/bin/harness-cli query matrix`

Then read only the domain loop and files needed for the selected work. Escalate
context when `docs/CONTEXT_RULES.md` has a retrieval trigger.

## Lane Rules

Use the Harness lane model:

| Lane | Use for | Attempt budget |
| --- | --- | --- |
| tiny | Copy, docs, narrow style, small config | 2 repair attempts |
| normal | Story-sized behavior with bounded blast radius | 5 repair attempts |
| high-risk | Auth, authorization, data loss, security, providers, broad contracts | 1 repair attempt unless plan is approved |

Any hard gate from `docs/FEATURE_INTAKE.md` escalates to high-risk unless the
human narrows scope.

## Plan

Before editing, write or hold a plan that names:

- Goal and non-goals.
- Files to read or change.
- Smallest vertical slice.
- Verification command.
- Stop conditions.

For normal work, create or update one story packet from
`docs/templates/story.md` and add a durable story row. Tiny work may patch
directly after intake.

## Verification Strategy

Choose proof before editing:

1. Story verifier: `scripts/bin/harness-cli story verify <story-id>`.
2. Project verifier: for example `scripts/verify.sh` or a repo-specific script.
3. Domain verifier: build, test, lint, smoke check, query, or browser proof.
4. Manual evidence only when executable proof is unavailable.

Missing verifier is harness friction. Create the smallest useful verifier when
it is in scope; otherwise record the gap.

## Act

Make one focused change at a time:

- Preserve existing contracts unless the story changes them.
- Prefer structured parsers and local project patterns.
- Keep unrelated refactors out.
- Update product docs, stories, or decisions when truth changes.
- Never remove or weaken validation to make a task pass.

## Verify And Repair

When verification fails:

1. Read the exact failure.
2. Classify it: environment, syntax, type, test expectation, product ambiguity,
   missing dependency, external system, or design error.
3. Make the smallest targeted fix.
4. Run the verifier again.
5. Stop when the attempt budget is reached or the same failure repeats without
   new information.

No-progress signals:

- Same error repeats with no new evidence.
- Required credentials, data, or network access are missing.
- Product direction is ambiguous.
- The fix would cross a high-risk boundary without confirmation.

## Stop

Stop as completed when:

- Requested change is done.
- The configured verifier passed, or a blocker is documented.
- Relevant docs, story proof, and durable records are current.
- A trace has been recorded.

Stop as blocked when:

- Required environment, credentials, input data, or human decision is missing.
- High-risk direction is ambiguous.
- Verification cannot run in the current environment.

Stop as failed when:

- Attempt budget is exhausted.
- No smaller safe change is visible.

## Trace

Every task ends with:

```powershell
.\scripts\bin\harness-cli.exe trace `
  --summary "<what was done>" `
  --intake <id> `
  --agent codex `
  --actions "intake,context,plan,edit,verify" `
  --read "AGENTS.md,docs/HARNESS.md,docs/FEATURE_INTAKE.md" `
  --changed "<files changed>" `
  --errors "none" `
  --outcome completed `
  --friction "none"
```

Use `docs/TRACE_SPEC.md` for field depth. Normal work needs at least a Standard
trace.

## Done Definition

- Intake recorded.
- Lane selected.
- Story exists for normal or high-risk work.
- Verifier defined before editing.
- Verifier run, or blocker documented.
- Product docs, story proof, and decisions are current.
- Trace recorded.
- Harness friction fixed or added to backlog.

## Prompt Template

```text
Read AGENTS.md, docs/HARNESS.md, docs/FEATURE_INTAKE.md,
docs/CONTEXT_RULES.md, docs/loops/README.md, and
docs/loops/core-loop.md.

Task: <task>

Follow the Core Loop: intake, context, lane, plan, verify strategy, act,
verify, repair, stop, trace. Select the relevant domain loop after lane
classification. Do not claim completion unless the verifier passed or the
blocker is documented.
```
