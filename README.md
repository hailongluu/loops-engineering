# loops-engineering

Reusable engineering loops for AI coding agents.

Install this into any repo to give agents a clear way to work:

```text
Goal -> Context -> Plan -> Act -> Verify -> Repair -> Trace
```

## Install

macOS/Linux:

```bash
curl -fsSL "https://raw.githubusercontent.com/hailongluu/loops-engineering/main/scripts/install-loop-engineering.sh?$(date +%s)" | bash -s -- --merge --yes
```

Windows PowerShell:

```powershell
& ([scriptblock]::Create((irm "https://raw.githubusercontent.com/hailongluu/loops-engineering/main/scripts/install-loop-engineering.ps1"))) -Merge -Yes
```

Install into another folder:

```bash
curl -fsSL "https://raw.githubusercontent.com/hailongluu/loops-engineering/main/scripts/install-loop-engineering.sh?$(date +%s)" | bash -s -- --directory /path/to/project --merge --yes
```

```powershell
& ([scriptblock]::Create((irm "https://raw.githubusercontent.com/hailongluu/loops-engineering/main/scripts/install-loop-engineering.ps1"))) -Directory C:\path\to\project -Merge -Yes
```

Preview first:

```bash
curl -fsSL "https://raw.githubusercontent.com/hailongluu/loops-engineering/main/scripts/install-loop-engineering.sh?$(date +%s)" | bash -s -- --merge --dry-run
```

```powershell
& ([scriptblock]::Create((irm "https://raw.githubusercontent.com/hailongluu/loops-engineering/main/scripts/install-loop-engineering.ps1"))) -Merge -DryRun
```

## Verify

macOS/Linux:

```bash
bash scripts/verify-loop-docs.sh
```

Windows:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\verify-loop-docs.ps1
```

Expected:

```text
VERIFY_OK loop docs present and wired
```

## Installed Files

```text
docs/loops/
  README.md
  core-loop.md
  web-build-loop.md
  web-app-loop.md
  api-backend-loop.md
  data-pipeline-loop.md
  automation-loop.md
  research-doc-loop.md
  security-risk-loop.md

scripts/
  verify-loop-docs.sh
  verify-loop-docs.ps1

AGENTS.md
  <!-- LOOP-ENGINEERING:BEGIN --> block
```

## Use

Ask the agent to read:

- `docs/loops/README.md`
- `docs/loops/core-loop.md`
- the relevant domain loop under `docs/loops/`

Then give it the task. The loop tells the agent what to clarify, what to build,
how to verify, when to retry, and when to stop.
