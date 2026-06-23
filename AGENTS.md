# Agent Instructions

Add project-specific agent instructions here.

## Loop Engineering

For implementation, documentation, automation, or research work, read:

- `docs/loops/README.md`
- `docs/loops/core-loop.md`
- the relevant domain loop under `docs/loops/`

Every task follows the Core Loop:

```text
Intake -> Context -> Lane -> Plan -> Verify strategy -> Act -> Verify -> Repair -> Stop -> Trace
```

Use one primary domain loop for the main work type. Add
`docs/loops/security-risk-loop.md` when the task touches auth, authorization,
data loss, audit/security, external providers, payments, privacy, or validation
weakening. Do not finish implementation work without running the configured
verifier or documenting the blocker in the trace.

<!-- HARNESS:BEGIN -->
## Harness

This repo uses Harness. Before work, read:

- `README.md`
- `docs/HARNESS.md`
- `docs/FEATURE_INTAKE.md`
- `docs/ARCHITECTURE.md`
- `docs/CONTEXT_RULES.md`
- `docs/TOOL_REGISTRY.md`
- `scripts/bin/harness-cli query matrix` on macOS/Linux, or `.\scripts\bin\harness-cli.exe query matrix` on Windows

Use the Rust Harness CLI at `scripts/bin/harness-cli` on macOS/Linux or
`scripts/bin/harness-cli.exe` on Windows as the main operational tool. Before a
step that could use an external tool, run `scripts/bin/harness-cli query tools
--capability <name> --status present` to see what is equipped; an absent
capability is a clean skip.
<!-- HARNESS:END -->
