# Scripts

Installer and verifier for the Loop Engineering Pack.

## Install

macOS/Linux:

```bash
curl -fsSL "https://raw.githubusercontent.com/hailongluu/loops-engineering/main/scripts/install-loop-engineering.sh?$(date +%s)" | bash -s -- --merge --yes
```

Windows PowerShell:

```powershell
& ([scriptblock]::Create((irm "https://raw.githubusercontent.com/hailongluu/loops-engineering/main/scripts/install-loop-engineering.ps1"))) -Merge -Yes
```

## Verify

```bash
bash scripts/verify-loop-docs.sh
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\verify-loop-docs.ps1
```
