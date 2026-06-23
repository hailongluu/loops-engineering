# Web App Loop

Use this loop for authenticated or interactive browser applications such as
dashboards, SaaS workflows, settings screens, admin tools, editors, and
multi-step product flows. Always run it after `core-loop.md`.

## Suitable Tasks

Use for:

- Dashboard pages.
- Authenticated product surfaces.
- Forms with persisted user data.
- CRUD workflows.
- App navigation, filters, search, tables, editors, and settings.
- Responsive app-shell behavior.

Do not use as the only loop for auth, authorization, payments, private data,
or audit-sensitive workflows. Add `security-risk-loop.md`.

## Inputs

Gather or infer:

- User role and permission assumptions.
- Primary workflow and success state.
- Data source and loading/error/empty states.
- Mutations and side effects.
- Route and navigation context.
- API contracts or client calls.
- Accessibility and keyboard expectations.
- Verification command.

## Loop

```text
Task
  -> Core intake and lane
  -> Identify actor, workflow, state, and contract
  -> Model happy path plus empty/loading/error states
  -> Implement smallest vertical slice
  -> Verify behavior and regressions
  -> Repair
  -> Update story proof and trace
```

## Contract Checklist

For normal work, the story should define:

- Actor and role.
- Trigger.
- Input data and validation.
- System action.
- Success state.
- Error state.
- Empty/loading state.
- API or storage contract.
- Analytics/audit expectations when applicable.

## Implementation Order

1. Route or screen boundary.
2. Data contract and parsing at boundaries.
3. Read state: loading, success, empty, error.
4. Mutations or commands.
5. UI controls and accessibility.
6. Responsive app layout.
7. Regression tests or smoke checks.

Rules:

- Keep command and query behavior distinct.
- Parse unknown API data before it enters app state.
- Do not hide errors behind optimistic UI unless the story allows it.
- Preserve keyboard navigation and focus behavior.
- Keep controls compact and predictable for repeated use.

## Verification

| Layer | Proof examples |
| --- | --- |
| Unit | validators, reducers, formatting, state transitions |
| Integration | API client contract, persistence, mutation side effects |
| E2E | workflow from entry point to success and error path |
| Platform | app shell, route refresh, browser-specific smoke |

Minimum app UX checks:

- Loading state is not blank.
- Empty state tells the user what happened and what can be done.
- Error state preserves user input where useful.
- Mutating controls show pending/disabled/success/failure feedback.
- Destructive actions require appropriate confirmation.
- Tables, filters, and forms remain usable on mobile if mobile is supported.

## Stop And Escalate

Stop and ask when:

- Role, permission, or tenant scope is unclear.
- The UI exposes private or regulated data.
- The workflow changes saved data without a clear undo or audit policy.
- The API contract is ambiguous and cannot be inferred from docs/tests.
- The change requires a migration or provider integration.

## Done Definition

- Actor, workflow, states, and contract are documented in story or product docs.
- Happy path and key non-happy states are implemented.
- Existing behavior is preserved or intentionally changed.
- Verifier ran, or blocker is documented.
- Story proof and trace are current.

## Prompt Template

```text
Read docs/loops/core-loop.md and docs/loops/web-app-loop.md.

Task: <build or change this app workflow>

Identify actor, route, data contract, happy path, loading, empty, error, and
permission assumptions. Implement the smallest vertical slice, verify behavior
and regressions, then record proof and trace. Add security-risk-loop.md if the
task touches roles, private data, audit, or providers.
```
