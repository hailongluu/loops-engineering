#!/usr/bin/env bash
set -euo pipefail

REPO="${LOOP_ENGINEERING_REPO:-hailongluu/loops-engineering}"
REF="${LOOP_ENGINEERING_REF:-main}"
BASE_URL="${LOOP_ENGINEERING_BASE_URL:-https://raw.githubusercontent.com/$REPO/$REF}"

TARGET_DIR="."
MODE="stop"
YES=0
DRY_RUN=0

usage() {
  cat <<'EOF'
Install Loop Engineering Pack into any repo.

Usage:
  install-loop-engineering.sh [--directory PATH] [--merge|--override] [--yes] [--dry-run]

Options:
  --directory PATH  Install into PATH instead of current directory.
  --merge           Create/update loop pack files without replacing unrelated files.
  --override        Replace loop pack files and marked AGENTS/docs blocks.
  --yes             Non-interactive yes.
  --dry-run         Print planned changes without writing.
  --help            Show this help.

Environment:
  LOOP_ENGINEERING_REPO      GitHub repo, default hailongluu/loops-engineering.
  LOOP_ENGINEERING_REF       Git ref, default main.
  LOOP_ENGINEERING_BASE_URL  Raw file base URL override.
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --directory)
      TARGET_DIR="${2:?--directory requires a path}"
      shift 2
      ;;
    --merge)
      MODE="merge"
      shift
      ;;
    --override)
      MODE="override"
      shift
      ;;
    --yes|-y)
      YES=1
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

if [ "$MODE" = "stop" ]; then
  if [ "$YES" -eq 1 ]; then
    MODE="merge"
  elif [ -t 0 ]; then
    printf "Install mode for %s:\n1) merge\n2) override\n3) stop\nChoose [1-3]: " "$TARGET_DIR"
    read -r choice
    case "$choice" in
      1) MODE="merge" ;;
      2) MODE="override" ;;
      *) echo "Stopped."; exit 0 ;;
    esac
  else
    echo "Non-interactive install requires --merge or --override." >&2
    exit 2
  fi
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "curl is required." >&2
  exit 1
fi

loop_files=(
  "docs/loops/README.md"
  "docs/loops/core-loop.md"
  "docs/loops/web-build-loop.md"
  "docs/loops/web-app-loop.md"
  "docs/loops/api-backend-loop.md"
  "docs/loops/data-pipeline-loop.md"
  "docs/loops/automation-loop.md"
  "docs/loops/research-doc-loop.md"
  "docs/loops/security-risk-loop.md"
  "scripts/verify-loop-docs.ps1"
  "scripts/verify-loop-docs.sh"
)

loop_block='## Loop Engineering

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
verifier or documenting the blocker.'

run_or_print() {
  if [ "$DRY_RUN" -eq 1 ]; then
    printf '[dry-run] %s\n' "$*"
  else
    "$@"
  fi
}

download_file() {
  local rel="$1"
  local dest="$TARGET_DIR/$rel"
  local url="$BASE_URL/$rel"
  if [ -e "$dest" ] && [ "$MODE" = "merge" ]; then
    case "$rel" in
      docs/loops/*|scripts/verify-loop-docs.*) ;;
      *) echo "Keeping existing $rel"; return ;;
    esac
  fi
  echo "Installing $rel"
  run_or_print mkdir -p "$(dirname "$dest")"
  if [ "$DRY_RUN" -eq 0 ]; then
    curl -fsSL "$url" -o "$dest"
  fi
}

patch_marked_block() {
  local file="$1"
  local marker="$2"
  local block="$3"
  local path="$TARGET_DIR/$file"
  local begin="<!-- $marker:BEGIN -->"
  local end="<!-- $marker:END -->"

  echo "Updating $file"
  if [ "$DRY_RUN" -eq 1 ]; then
    echo "[dry-run] patch marked block $marker in $file"
    return
  fi

  mkdir -p "$(dirname "$path")"
  if [ ! -f "$path" ]; then
    printf '%s\n%s\n%s\n' "$begin" "$block" "$end" > "$path"
    return
  fi

  tmp="$(mktemp)"
  awk -v begin="$begin" -v end="$end" -v block="$block" '
    index($0, begin) {
      print begin
      print block
      in_block = 1
      replaced = 1
      next
    }
    in_block && index($0, end) {
      print end
      in_block = 0
      next
    }
    !in_block { print }
    END {
      if (!replaced) {
        print ""
        print begin
        print block
        print end
      }
    }
  ' "$path" > "$tmp"
  mv "$tmp" "$path"
}

for rel in "${loop_files[@]}"; do
  download_file "$rel"
done

patch_marked_block "AGENTS.md" "LOOP-ENGINEERING" "$loop_block"

if [ "$DRY_RUN" -eq 0 ]; then
  chmod +x "$TARGET_DIR/scripts/verify-loop-docs.sh" || true
fi

echo "Loop Engineering Pack installed in $TARGET_DIR"
echo "Verify with:"
echo "  bash scripts/verify-loop-docs.sh"
