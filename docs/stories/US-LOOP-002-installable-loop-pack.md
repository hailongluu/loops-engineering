# US-LOOP-002 Installable Loop Pack

## Status

implemented

## Lane

normal

## Product Contract

The loop engineering pack can be published to GitHub and installed into another
Harness repo through raw GitHub Bash and PowerShell installer commands, similar
to the base `repository-harness` installer flow.

## Relevant Product Docs

- `README.md`
- `scripts/README.md`
- `scripts/install-loop-engineering.sh`
- `scripts/install-loop-engineering.ps1`
- `scripts/verify-loop-docs.sh`
- `scripts/verify-loop-docs.ps1`

## Acceptance Criteria

- Bash installer supports current-directory install, `--directory`, `--merge`,
  `--override`, `--yes`, and `--dry-run`.
- PowerShell installer supports `-Directory`, `-Merge`, `-Override`, `-Yes`,
  and `-DryRun`.
- Installers download loop files from raw GitHub URLs.
- Installers patch `AGENTS.md` with a marked Loop Engineering block.
- Installers ensure `docs/README.md` mentions `docs/loops/`.
- Cross-platform verifier exists for macOS/Linux and Windows.
- README shows install, verify, dry-run, custom-repo, and publish commands.

## Design Notes

- Commands: raw GitHub `curl | bash` and PowerShell `irm` flows.
- Queries: none.
- API: GitHub raw file URLs.
- Tables: durable story row through Harness CLI.
- Domain rules: installer is additive and does not install or replace the base
  Harness CLI.
- UI surfaces: none.

## Validation

When updating durable proof status, use numeric booleans:
`scripts/bin/harness-cli story update --id <id> --unit 1 --integration 1 --e2e 0 --platform 0`.

| Layer | Expected proof |
| --- | --- |
| Unit | Verifier scripts check required loop files and wiring. |
| Integration | Installer dry-runs complete without writing. |
| E2E | Not applicable until the repo is pushed to GitHub raw URLs. |
| Platform | PowerShell verifier runs on current Windows workspace. |
| Release | README contains publish commands. |

## Harness Delta

Adds an installable distribution layer for the loop pack while keeping the base
Harness installer separate.

## Evidence

- 2026-06-23: `powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts\verify-loop-docs.ps1` returned `VERIFY_OK loop docs present and wired`.
- 2026-06-23: `powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts\install-loop-engineering.ps1 -Merge -DryRun` completed and listed planned installs plus `AGENTS.md` and `docs/README.md` wiring.
- 2026-06-23: `scripts/bin/harness-cli.exe story verify US-LOOP-002` ran the configured verifier and returned `Story US-LOOP-002 verification: pass`.
- 2026-06-23: Bash syntax/execution was not run because this Windows machine has no installed WSL distribution.
