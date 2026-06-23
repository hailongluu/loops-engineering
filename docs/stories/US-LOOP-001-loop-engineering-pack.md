# US-LOOP-001 Loop Engineering Pack

## Status

implemented

## Lane

normal

## Product Contract

The Harness repo provides a reusable loop pack that agents can use after
feature intake to choose a safe repeatable work protocol for common project
types.

## Relevant Product Docs

- `docs/HARNESS.md`
- `docs/FEATURE_INTAKE.md`
- `docs/CONTEXT_RULES.md`
- `docs/loops/README.md`
- `docs/loops/core-loop.md`

## Acceptance Criteria

- A loop router explains when to use each loop.
- The core loop defines intake, context, lane, plan, verifier, act, verify,
  repair, stop, and trace behavior.
- Domain loops exist for web build, web app, API/backend, data pipeline,
  automation, research/docs, and security/risk overlay work.
- `AGENTS.md` points future agents to the loop pack without replacing the
  existing Harness block.
- A mechanical verifier checks that the loop pack files and key headings exist.
- Durable story proof records the docs-only verification result.

## Design Notes

- Commands: `scripts/verify-loop-docs.ps1`
- Queries: `scripts/bin/harness-cli query matrix`
- API: none
- Tables: durable story and trace records through Harness CLI
- Domain rules: one core loop, one primary domain loop, optional risk overlay
- UI surfaces: none

## Validation

When updating durable proof status, use numeric booleans:
`scripts/bin/harness-cli story update --id <id> --unit 1 --integration 1 --e2e 0 --platform 0`.

| Layer | Expected proof |
| --- | --- |
| Unit | Markdown loop files include required headings and router references. |
| Integration | Harness story verifier runs `scripts/verify-loop-docs.ps1`. |
| E2E | Not applicable for docs-only Harness loop pack. |
| Platform | PowerShell verifier runs on the current Windows workspace. |
| Release | Not applicable. |

## Harness Delta

Adds `docs/loops/` as a reusable loop protocol layer. This is additive to the
existing Harness workflow and does not replace feature intake, context rules,
story packets, durable decisions, or trace requirements.

## Evidence

- 2026-06-23: `powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts\verify-loop-docs.ps1` returned `VERIFY_OK loop docs present and wired`.
- 2026-06-23: `scripts/bin/harness-cli.exe story verify US-LOOP-001` ran the configured verifier and returned `Story US-LOOP-001 verification: pass`.
