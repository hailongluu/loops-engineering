# Automation Loop

Use this loop for scripts, bots, scheduled tasks, repository automation,
developer tooling, local utilities, and internal operations workflows. Always
run it after `core-loop.md`.

## Suitable Tasks

Use for:

- Repo maintenance scripts.
- One-off local utilities.
- Scheduled jobs.
- CLI helpers.
- File processing automation.
- Notifications or bot actions.
- Developer workflow improvements.

Add `security-risk-loop.md` when the automation uses credentials, writes to
external systems, deletes/moves files, posts messages, modifies production, or
runs with broad permissions.

## Inputs

Gather or infer:

- Trigger: manual, scheduled, webhook, CI, or local.
- Inputs and outputs.
- Scope of files, records, or external systems.
- Idempotency and rerun behavior.
- Permissions and credentials.
- Failure notification path.
- Dry-run or preview mode.
- Verifier command.

## Loop

```text
Task
  -> Core intake and lane
  -> Define trigger, inputs, outputs, permissions
  -> Add dry-run or preview where useful
  -> Implement smallest safe command
  -> Verify on fixture or harmless target
  -> Repair
  -> Record proof and trace
```

## Safety Checklist

- Command has clear usage and examples.
- Input paths are validated.
- Recursive write/delete operations are bounded.
- External side effects are explicit.
- Dry-run exists for broad changes.
- Secrets are read from environment or secure store, not committed.
- Logs are useful and do not leak secrets.
- Re-running is safe or documented as unsafe.

## Implementation Order

1. Fixture or sample input.
2. Argument parsing and validation.
3. Dry-run output.
4. Core operation.
5. Error handling and logs.
6. Verification script or smoke command.

## Verification

| Layer | Proof examples |
| --- | --- |
| Unit | path validation, parser, pure transform |
| Integration | fixture run, temp directory, mocked provider |
| E2E | full command on harmless target |
| Platform | CI, scheduled runner, shell compatibility |

For file automation, verify the resolved absolute target paths are inside the
intended directory before recursive moves or deletes.

## Stop And Escalate

Stop and ask when:

- File deletion or movement scope is broad or ambiguous.
- Credentials are missing or unsafe.
- The automation would post, email, deploy, bill, or notify externally.
- The command needs production access.
- There is no safe fixture, dry-run, or preview path.

## Done Definition

- Trigger, inputs, outputs, and permissions are documented.
- Dry-run or safe fixture path exists when needed.
- Verifier ran on harmless data.
- Logs and errors are understandable.
- Trace records side effects, skipped access, and friction.

## Prompt Template

```text
Read docs/loops/core-loop.md and docs/loops/automation-loop.md.

Task: <build or change this automation>

Identify trigger, inputs, outputs, side effects, credentials, idempotency,
dry-run strategy, and verifier. Implement the smallest safe command, verify on
fixtures or harmless targets, then record proof and trace.
```
