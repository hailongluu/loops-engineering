# API Backend Loop

Use this loop for APIs, backend services, workers, queues, CLI services,
webhooks, and server-side application behavior. Always run it after
`core-loop.md`.

## Suitable Tasks

Use for:

- Endpoint or route changes.
- Service or worker behavior.
- Command/query handlers.
- Validation and response envelopes.
- Background jobs.
- Provider adapters and webhook receivers.
- CLI service commands.

Add `security-risk-loop.md` for auth, authorization, audit/security, private
data, provider callbacks, migrations, or public contract changes.

## Inputs

Gather or infer:

- Caller or producer.
- Command/query type.
- Request/input schema.
- Response/output schema.
- Domain rule.
- Data access boundary.
- Error taxonomy.
- Idempotency and retry expectations.
- Logging and audit expectations.
- Verifier command.

## Loop

```text
Task
  -> Core intake and lane
  -> Identify boundary and contract
  -> Parse unknown input at the edge
  -> Implement application/domain behavior
  -> Wire infrastructure
  -> Verify contract, errors, and side effects
  -> Repair
  -> Record proof and trace
```

## Boundary Contract

For normal work, define:

- Input parser and validation errors.
- Auth identity requirements if any.
- Command or query handler.
- Domain rule.
- Storage interaction.
- Output presenter or response envelope.
- Observability and audit difference.
- Backward compatibility expectations.

## Implementation Order

1. Parser or DTO at the boundary.
2. Application command/query.
3. Domain rule or value object.
4. Infrastructure adapter.
5. Interface route, job, webhook, or CLI command.
6. Contract tests and integration proof.

Rules:

- Inner layers must not depend on frameworks or concrete providers.
- Unknown data must be parsed before it enters inner code.
- Commands mutate state and own audit side effects.
- Queries read state and format for consumers.
- Provider payloads need explicit adapters.
- Public contract changes need story proof and, when meaningful, a decision.

## Verification

| Layer | Proof examples |
| --- | --- |
| Unit | domain rule, parser, command/query behavior |
| Integration | database, provider adapter, queue, route handler |
| E2E | client-visible API flow or full job path |
| Platform | deployment smoke, worker start, env config |

Backend-specific checks:

- Valid inputs succeed with expected response.
- Invalid inputs fail with expected status/error shape.
- Authorization or identity assumptions are explicit.
- Idempotency is tested where retries can happen.
- Logs include operational context without leaking secrets.
- Audit records are separate from application logs when required.

## Stop And Escalate

Stop and ask when:

- API compatibility requirements are unclear.
- The task can lose, migrate, or expose data.
- Provider behavior requires credentials or production access.
- Retry/idempotency policy is missing for side-effecting work.
- Audit/security expectations are ambiguous.

## Done Definition

- Boundary contract is documented.
- Parser, command/query, and output shape are implemented.
- Relevant unit/integration proof ran.
- Contract change is reflected in story/product docs.
- Trace names errors, proof, and friction.

## Prompt Template

```text
Read docs/loops/core-loop.md and docs/loops/api-backend-loop.md.

Task: <build or change this backend behavior>

Identify boundary, input parser, command/query, domain rule, data/provider
adapter, output contract, errors, idempotency, logging, and verifier. Implement
the smallest safe slice, verify contract and side effects, repair within the
attempt budget, then record proof and trace.
```
