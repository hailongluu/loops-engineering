# Research And Documentation Loop

Use this loop for product briefs, technical research, architecture notes,
decision support, documentation, runbooks, summaries, and knowledge artifacts.
Always run it after `core-loop.md`.

## Suitable Tasks

Use for:

- Product or technical research.
- Requirements breakdown.
- Architecture notes.
- Decision records.
- Runbooks and checklists.
- Summaries of supplied documents.
- Documentation updates.
- Evaluation reports.

Add `security-risk-loop.md` when content involves private data, regulated
advice, legal/medical/financial claims, credentials, or security-sensitive
details.

## Inputs

Gather or infer:

- Audience.
- Decision or action the doc supports.
- Source materials and freshness requirements.
- Required citations or evidence.
- Output format.
- Review criteria.
- Unknowns and assumptions.

## Loop

```text
Task
  -> Core intake and lane
  -> Define audience and decision need
  -> Gather bounded sources
  -> Extract claims and evidence
  -> Draft artifact
  -> Verify coverage, citations, and uncertainty
  -> Repair
  -> Record trace
```

## Source Rules

- Prefer primary sources for technical, legal, medical, financial, or current
  factual claims.
- Use repo-local product docs as source of truth for project behavior.
- Browse current sources when facts may have changed.
- Keep direct quotes short and cite sources.
- Separate sourced facts, assumptions, and recommendations.

## Artifact Checklist

- Audience is clear.
- Scope and non-scope are clear.
- Key claims have evidence.
- Unknowns are named.
- Recommendations include tradeoffs.
- Action items are concrete.
- The doc points to product docs, stories, or decisions when it changes future
  work.

## Verification

| Layer | Proof examples |
| --- | --- |
| Coverage | all requested topics addressed |
| Source | citations present and current where required |
| Consistency | no contradiction with repo product docs or decisions |
| Actionability | next steps, owners, or story candidates are clear |

## Stop And Escalate

Stop and ask when:

- The requested recommendation needs unavailable private context.
- Source materials conflict and no source hierarchy exists.
- The doc would make regulated advice without proper authority.
- A product or architecture decision is required before writing a final answer.

## Done Definition

- Audience, purpose, sources, assumptions, and recommendations are clear.
- Citations or evidence are included where needed.
- Product docs, stories, decisions, or backlog are updated when future work
  changes.
- Trace records sources read, files changed, and friction.

## Prompt Template

```text
Read docs/loops/core-loop.md and docs/loops/research-doc-loop.md.

Task: <research or documentation task>

Identify audience, decision need, source hierarchy, freshness requirements, and
output format. Gather bounded evidence, draft the artifact, verify coverage and
uncertainty, update durable docs if future work changed, then record trace.
```
