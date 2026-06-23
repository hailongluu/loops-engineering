#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "docs/loops/README.md"
  "docs/loops/core-loop.md"
  "docs/loops/web-build-loop.md"
  "docs/loops/web-app-loop.md"
  "docs/loops/api-backend-loop.md"
  "docs/loops/data-pipeline-loop.md"
  "docs/loops/automation-loop.md"
  "docs/loops/research-doc-loop.md"
  "docs/loops/security-risk-loop.md"
)

required_headings=(
  "## Loop"
  "## Verification"
  "## Stop"
)

errors=()

for file in "${required_files[@]}"; do
  path="$root/$file"
  if [ ! -f "$path" ]; then
    errors+=("Missing required file: $file")
    continue
  fi
  if [ ! -s "$path" ]; then
    errors+=("Empty required file: $file")
    continue
  fi
  if [[ "$file" == docs/loops/*.md && "$file" != "docs/loops/README.md" ]]; then
    for heading in "${required_headings[@]}"; do
      if ! grep -Fq "$heading" "$path"; then
        errors+=("$file missing heading: $heading")
      fi
    done
  fi
done

for link in \
  "core-loop.md" \
  "web-build-loop.md" \
  "web-app-loop.md" \
  "api-backend-loop.md" \
  "data-pipeline-loop.md" \
  "automation-loop.md" \
  "research-doc-loop.md" \
  "security-risk-loop.md"; do
  if ! grep -Fq "$link" "$root/docs/loops/README.md"; then
    errors+=("docs/loops/README.md missing router reference: $link")
  fi
done

if [ ! -f "$root/AGENTS.md" ] || ! grep -Fq "docs/loops/core-loop.md" "$root/AGENTS.md"; then
  errors+=("AGENTS.md does not reference docs/loops/core-loop.md")
fi

if [ ! -f "$root/docs/README.md" ] || ! grep -Fq "loops/" "$root/docs/README.md"; then
  errors+=("docs/README.md does not mention docs/loops/")
fi

if [ "${#errors[@]}" -gt 0 ]; then
  printf '%s\n' "${errors[@]}" >&2
  exit 1
fi

echo "VERIFY_OK loop docs present and wired"
