# loops-engineering

Harness is the frame. Loops are the operating rhythm.

This installer adds both:

- base Harness from [`repository-harness`](https://github.com/hoangnb24/repository-harness)
- `docs/loops/*` for core, web, app, API, data, automation, research, and risk loops

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

Only install loops when Harness is already handled:

```bash
curl -fsSL "https://raw.githubusercontent.com/hailongluu/loops-engineering/main/scripts/install-loop-engineering.sh?$(date +%s)" | bash -s -- --merge --yes --loops-only
```

```powershell
& ([scriptblock]::Create((irm "https://raw.githubusercontent.com/hailongluu/loops-engineering/main/scripts/install-loop-engineering.ps1"))) -Merge -Yes -LoopsOnly
```

## Verify

```bash
bash scripts/verify-loop-docs.sh
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\verify-loop-docs.ps1
```

Expected:

```text
VERIFY_OK loop docs present and wired
```

## What Gets Added

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

AGENTS.md
  <!-- LOOP-ENGINEERING:BEGIN --> block
```

Ask the agent to read `docs/loops/README.md`, `docs/loops/core-loop.md`, and the
relevant domain loop before it starts work.
