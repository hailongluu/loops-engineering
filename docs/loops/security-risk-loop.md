# Security And Risk Overlay Loop

Use this as an overlay on top of the selected domain loop whenever a task
touches a Harness hard gate: auth, authorization, data loss or migration,
audit/security, external provider behavior, or validation weakening.

## Triggers

Apply this overlay for:

- Login, logout, sessions, JWTs, passwords, refresh tokens.
- Roles, permissions, tenant/company scope.
- Schema migrations, deletions, retention, or ownership rules.
- Audit logs, sensitive data, access logs, privacy, or secrets.
- Payments, email, cloud services, provider SDKs, queues, or webhooks.
- Public API or client-visible contract changes.
- Removing, bypassing, or weakening validation.

## Loop

```text
Task
  -> Core intake escalates lane
  -> Identify asset, actor, boundary, and threat
  -> Read relevant decisions and product docs
  -> Create high-risk story packet when required
  -> Define proof and rollback
  -> Implement only approved safe slice
  -> Verify negative and positive cases
  -> Record decision, proof, trace, and friction
```

## Required Questions

- What asset or user data can be affected?
- Who is the actor and what are they allowed to do?
- What boundary is crossed?
- What can go wrong?
- What proof catches both allowed and denied behavior?
- What is the rollback or recovery path?
- Is a durable decision required?

## Story And Decision Rules

High-risk work should use `docs/templates/high-risk-story/`.

Add a decision record when the work meaningfully changes:

- Behavior.
- Architecture.
- Authorization.
- Data ownership.
- API shape.
- Audit/security.
- Validation requirements.

The trace can summarize a decision, but it does not replace a durable decision
record under `docs/decisions/`.

## Verification

| Layer | Proof examples |
| --- | --- |
| Unit | allow/deny rules, parser rejection, redaction |
| Integration | database constraints, auth middleware, provider callback |
| E2E | role-specific success and denial flows |
| Platform | secret/env checks, deploy smoke, webhook signature verification |

Required negative proof examples:

- Unauthorized actor denied.
- Wrong tenant/company scope denied.
- Invalid provider payload rejected.
- Missing required audit event fails test or is manually blocked.
- Secret or sensitive data is not logged.

## Stop And Escalate

Stop and ask when:

- Role or ownership rule is ambiguous.
- A migration, deletion, or production data operation is needed.
- Provider credentials or production callbacks are required.
- Validation would need to be weakened.
- No rollback or negative proof exists for a high-risk change.

## Done Definition

- Hard gate and lane are recorded.
- High-risk story packet exists when required.
- Decision record exists when required.
- Positive and negative proof ran or blocker is documented.
- Rollback/recovery expectations are clear.
- Trace names risk, proof, errors, and friction.

## Prompt Template

```text
Read docs/loops/core-loop.md, the primary domain loop, and
docs/loops/security-risk-loop.md.

Task: <high-risk task>

Identify asset, actor, boundary, risk, proof, rollback, and decision needs.
Do not implement beyond the approved safe slice. Verify positive and negative
cases. Record decision, story proof, trace, and friction.
```
