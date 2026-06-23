$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..")

$requiredFiles = @(
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

$requiredHeadings = @(
  "## Loop",
  "## Verification",
  "## Stop"
)

$errors = New-Object System.Collections.Generic.List[string]

foreach ($file in $requiredFiles) {
  $path = Join-Path $root $file
  if (-not (Test-Path -LiteralPath $path)) {
    $errors.Add("Missing required file: $file")
    continue
  }

  $content = Get-Content -Raw -Encoding UTF8 -LiteralPath $path
  if ([string]::IsNullOrWhiteSpace($content)) {
    $errors.Add("Empty required file: $file")
    continue
  }

  if ($file -like "docs/loops/*.md" -and $file -ne "docs/loops/README.md") {
    foreach ($heading in $requiredHeadings) {
      if ($content -notmatch [regex]::Escape($heading)) {
        $errors.Add("$file missing heading: $heading")
      }
    }
  }
}

$router = Get-Content -Raw -Encoding UTF8 -LiteralPath (Join-Path $root "docs/loops/README.md")
$routerLinks = @(
  "core-loop.md",
  "web-build-loop.md",
  "web-app-loop.md",
  "api-backend-loop.md",
  "data-pipeline-loop.md",
  "automation-loop.md",
  "research-doc-loop.md",
  "security-risk-loop.md"
)

foreach ($link in $routerLinks) {
  if ($router -notmatch [regex]::Escape($link)) {
    $errors.Add("docs/loops/README.md missing router reference: $link")
  }
}

$agents = Get-Content -Raw -Encoding UTF8 -LiteralPath (Join-Path $root "AGENTS.md")
if ($agents -notmatch [regex]::Escape("docs/loops/core-loop.md")) {
  $errors.Add("AGENTS.md does not reference docs/loops/core-loop.md")
}

$docsReadme = Get-Content -Raw -Encoding UTF8 -LiteralPath (Join-Path $root "docs/README.md")
if ($docsReadme -notmatch [regex]::Escape("loops/")) {
  $errors.Add("docs/README.md does not mention docs/loops/")
}

if ($errors.Count -gt 0) {
  foreach ($err in $errors) {
    Write-Error $err
  }
  exit 1
}

Write-Output "VERIFY_OK loop docs present and wired"
