#!/usr/bin/env bash
# Yandex Cloud Skill - Auto-update Documentation
# Runs after skill execution to update documentation index

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
ROOT_DIR="$(git rev-parse --show-toplevel 2>/dev/null || echo "$SKILL_DIR/../../..")"

# Source bus interface
source "$SKILL_DIR/scripts/bus.sh"

# Paths
DOC_INDEX="$ROOT_DIR/.claude/context/docs/INDEX.md"
SKILL_YAML="$SKILL_DIR/skill.yaml"

# Create directories
mkdir -p "$(dirname "$DOC_INDEX")"

# Extract URLs from skill.yaml
update_doc_index() {
  local url="$1"
  local name="$2"

  # Try to get Last-Modified header
  local last_modified=""
  if command -v curl >/dev/null 2>&1; then
    last_modified=$(curl -sI "$url" 2>/dev/null | \
      awk -F': ' 'tolower($1)=="last-modified"{print $2}' | \
      tr -d '\r' || echo "")
  fi

  # Fallback to current date
  local checked_date=$(date -u +%Y-%m-%d)

  echo "- [$name]($url)"
  echo "  - Last checked: $checked_date"
  [[ -n "$last_modified" ]] && echo "  - Last modified: $last_modified"
  echo ""
}

# Generate index
{
  echo "# Yandex Cloud Documentation Index"
  echo ""
  echo "Auto-generated: $(date -u +"%Y-%m-%d %H:%M:%S UTC")"
  echo ""
  echo "## Official Documentation"
  echo ""

  # Extract from skill.yaml
  if command -v yq >/dev/null 2>&1 && [[ -f "$SKILL_YAML" ]]; then
    yq eval '.docs.official[]' "$SKILL_YAML" -o json 2>/dev/null | \
    jq -r '.name + "|" + .url' 2>/dev/null | \
    while IFS='|' read -r name url; do
      [[ -n "$name" ]] && update_doc_index "$url" "$name"
    done
  else
    # Fallback: hardcoded list
    update_doc_index "https://yandex.cloud/docs" "Yandex Cloud Documentation"
    update_doc_index "https://yandex.cloud/docs/cli/" "Yandex Cloud CLI"
    update_doc_index "https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs" "Terraform Yandex Provider"
  fi

  echo "## Local Documentation"
  echo ""
  echo "- Path: \`ru/\`"
  echo "- Services: $(ls "$ROOT_DIR/ru" 2>/dev/null | grep -v "^_" | wc -l || echo "N/A")"
  echo "- Files: $(find "$ROOT_DIR/ru" -name "*.md" 2>/dev/null | wc -l || echo "N/A")"
  echo ""

} > "$DOC_INDEX"

# Publish event
publish_event "yc.docs.updated" "$(jq -n \
  --arg file "$DOC_INDEX" \
  --arg timestamp "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
  '{file:$file, timestamp:$timestamp}')" 2>/dev/null || true

# Update skill.yaml last_checked dates
if command -v yq >/dev/null 2>&1 && [[ -f "$SKILL_YAML" ]]; then
  current_date=$(date -u +%Y-%m-%d)

  # Create temporary file with updated dates
  yq eval ".docs.official[].last_checked = \"$current_date\"" "$SKILL_YAML" > "${SKILL_YAML}.tmp" 2>/dev/null && \
    mv "${SKILL_YAML}.tmp" "$SKILL_YAML" 2>/dev/null || true
fi

exit 0
