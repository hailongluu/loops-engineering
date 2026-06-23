# Data Pipeline Loop

Use this loop for ETL, imports, exports, analytics jobs, migrations, backfills,
report generation, data quality checks, and sync workflows. Always run it after
`core-loop.md`.

## Suitable Tasks

Use for:

- CSV, JSON, spreadsheet, database, or API ingestion.
- Batch transforms.
- Report or metric generation.
- Data migrations and backfills.
- Export jobs.
- Reconciliation and data quality checks.

Add `security-risk-loop.md` when the data contains PII, secrets, financial
records, regulated content, production data, retention rules, or destructive
operations.

## Inputs

Gather or infer:

- Source and target.
- Schema or sample input.
- Volume and runtime expectations.
- Data ownership and sensitivity.
- Transform rules.
- Idempotency and resume behavior.
- Error quarantine strategy.
- Reconciliation proof.
- Rollback or recovery plan.

## Loop

```text
Task
  -> Core intake and lane
  -> Profile source data and schema
  -> Define transform and invariants
  -> Build a small sample path
  -> Verify quality and reconciliation
  -> Scale cautiously
  -> Repair
  -> Record proof and trace
```

## Contract Checklist

For normal work, define:

- Input schema and tolerated deviations.
- Output schema.
- Required invariants.
- Duplicate handling.
- Missing/invalid row handling.
- Time zone and date rules.
- Precision/rounding rules.
- Privacy and retention expectations.
- Reconciliation query or report.

## Implementation Order

1. Read-only profiling or fixture sample.
2. Parser and schema validation.
3. Transform on a tiny sample.
4. Idempotent write path or dry-run output.
5. Reconciliation checks.
6. Scale/run plan.

Rules:

- Prefer dry-run mode for destructive or broad updates.
- Keep raw input separate from normalized output.
- Do not drop invalid records silently.
- Make retries idempotent.
- Record counts before and after.
- Never run production backfills without explicit approval and rollback plan.

## Verification

| Layer | Proof examples |
| --- | --- |
| Unit | parser, transform, date/precision rules |
| Integration | source/target adapters, transaction boundaries |
| E2E | sample file or staging job from source to target |
| Platform | scheduled job, memory/runtime smoke, permissions |

Pipeline-specific proof:

- Source row count.
- Accepted/rejected row count.
- Duplicate count.
- Output count.
- Reconciliation result.
- Error sample or quarantine path.

## Stop And Escalate

Stop and ask when:

- Source schema is unknown or inconsistent beyond safe inference.
- Data sensitivity is unclear.
- The task can delete, overwrite, or migrate production data.
- Reconciliation proof cannot be produced.
- Credentials or environment access are missing.

## Done Definition

- Source, target, transform, invariants, and reconciliation are documented.
- Sample path is verified before scaling.
- Invalid data handling is explicit.
- Counts and proof are recorded.
- Trace includes skipped access, blockers, or friction.

## Prompt Template

```text
Read docs/loops/core-loop.md and docs/loops/data-pipeline-loop.md.

Task: <build or change this data workflow>

Identify source, target, schema, sensitivity, transform, invariants, duplicate
handling, invalid data handling, idempotency, and reconciliation proof. Build a
small sample path first, verify counts and quality, then scale only when the
story allows it.
```
