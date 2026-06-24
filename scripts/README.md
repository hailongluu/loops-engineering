# Scripts

Installer and verifier for Harness plus the Loop Engineering Pack.

## Install

```bash
curl -fsSL "https://raw.githubusercontent.com/hailongluu/loops-engineering/main/scripts/install-loop-engineering.sh?$(date +%s)" | bash -s -- --merge --yes
```

```powershell
& ([scriptblock]::Create((irm "https://raw.githubusercontent.com/hailongluu/loops-engineering/main/scripts/install-loop-engineering.ps1"))) -Merge -Yes
```

Use `--loops-only` / `-LoopsOnly` when the target repo already has Harness.

## Verify

```bash
bash scripts/verify-loop-docs.sh
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\verify-loop-docs.ps1
```
