param(
  [string]$Directory = ".",
  [switch]$Merge,
  [switch]$Override,
  [switch]$Yes,
  [switch]$DryRun,
  [string]$Repo = $(if ($env:LOOP_ENGINEERING_REPO) { $env:LOOP_ENGINEERING_REPO } else { "hailongluu/loops-engineering" }),
  [string]$Ref = $(if ($env:LOOP_ENGINEERING_REF) { $env:LOOP_ENGINEERING_REF } else { "main" }),
  [string]$BaseUrl = $env:LOOP_ENGINEERING_BASE_URL
)

$ErrorActionPreference = "Stop"

if (-not $BaseUrl) {
  $BaseUrl = "https://raw.githubusercontent.com/$Repo/$Ref"
}

$target = (Resolve-Path -LiteralPath $Directory).Path
$mode = "stop"
if ($Merge) { $mode = "merge" }
if ($Override) { $mode = "override" }
if ($mode -eq "stop" -and $Yes) { $mode = "merge" }
if ($mode -eq "stop") {
  if ([Console]::IsInputRedirected) {
    throw "Non-interactive install requires -Merge or -Override."
  }
  Write-Host "Install mode for $target"
  Write-Host "1) merge"
  Write-Host "2) override"
  Write-Host "3) stop"
  $choice = Read-Host "Choose [1-3]"
  if ($choice -eq "1") { $mode = "merge" }
  elseif ($choice -eq "2") { $mode = "override" }
  else { Write-Host "Stopped."; exit 0 }
}

$loopFiles = @(
  "docs/loops/README.md",
  "docs/loops/core-loop.md",
  "docs/loops/web-build-loop.md",
  "docs/loops/web-app-loop.md",
  "docs/loops/api-backend-loop.md",
  "docs/loops/data-pipeline-loop.md",
  "docs/loops/automation-loop.md",
  "docs/loops/research-doc-loop.md",
  "docs/loops/security-risk-loop.md",
  "scripts/verify-loop-docs.ps1",
  "scripts/verify-loop-docs.sh"
)

$loopBlock = @'
## Loop Engineering

For implementation, documentation, automation, or research work, read:

- `docs/loops/README.md`
- `docs/loops/core-loop.md`
- the relevant domain loop under `docs/loops/`

Every task follows this loop:

```text
Goal -> Context -> Plan -> Act -> Verify -> Repair -> Trace
```

Use one primary domain loop for the main work type. Add
`docs/loops/security-risk-loop.md` when the task touches auth, authorization,
data loss, security, external providers, payments, privacy, or validation
weakening. Do not finish implementation work without running the chosen
verifier or documenting the blocker.
'@

function Invoke-WriteStep {
  param([scriptblock]$Action, [string]$Message)
  if ($DryRun) {
    Write-Host "[dry-run] $Message"
  } else {
    & $Action
  }
}

function Install-RemoteFile {
  param([string]$RelativePath)
  $dest = Join-Path $target $RelativePath
  $url = "$BaseUrl/$RelativePath"
  Write-Host "Installing $RelativePath"
  Invoke-WriteStep -Message "create directory for $RelativePath" -Action {
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $dest) | Out-Null
  }
  if (-not $DryRun) {
    Invoke-WebRequest -Uri $url -OutFile $dest
  }
}

function Set-MarkedBlock {
  param(
    [string]$RelativePath,
    [string]$Marker,
    [string]$Block
  )
  $path = Join-Path $target $RelativePath
  $begin = "<!-- ${Marker}:BEGIN -->"
  $end = "<!-- ${Marker}:END -->"
  $newBlock = "$begin`n$Block`n$end"
  Write-Host "Updating $RelativePath"
  if ($DryRun) {
    Write-Host "[dry-run] patch marked block $Marker in $RelativePath"
    return
  }
  New-Item -ItemType Directory -Force -Path (Split-Path -Parent $path) | Out-Null
  if (Test-Path -LiteralPath $path) {
    $text = Get-Content -Raw -Encoding UTF8 -LiteralPath $path
    $pattern = [regex]::Escape($begin) + "[\s\S]*?" + [regex]::Escape($end)
    if ($text -match $pattern) {
      $text = [regex]::Replace($text, $pattern, [System.Text.RegularExpressions.MatchEvaluator]{ param($m) $newBlock })
    } else {
      if ($text -and -not $text.EndsWith("`n")) { $text += "`n" }
      $text += "`n$newBlock`n"
    }
  } else {
    $text = "$newBlock`n"
  }
  Set-Content -Encoding UTF8 -LiteralPath $path -Value $text
}

foreach ($file in $loopFiles) {
  Install-RemoteFile -RelativePath $file
}

Set-MarkedBlock -RelativePath "AGENTS.md" -Marker "LOOP-ENGINEERING" -Block $loopBlock

Write-Host "Loop Engineering Pack installed in $target"
Write-Host "Verify with:"
Write-Host "  powershell -NoProfile -ExecutionPolicy Bypass -File scripts\verify-loop-docs.ps1"
