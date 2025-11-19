#!/usr/bin/env bash
# Yandex Cloud Skill - Documentation Indexer Agent
# Indexes local Yandex Cloud documentation

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
ROOT_DIR="$(git rev-parse --show-toplevel 2>/dev/null || echo "$SKILL_DIR/../../..")"

# Source bus interface
source "$SKILL_DIR/scripts/bus.sh"

# Publish start event
publish_event "yc.agent.docs-indexer.started" '{"status":"running"}'

# Index documentation
docs_ru="$ROOT_DIR/ru"
index_data="{}"

if [[ -d "$docs_ru" ]]; then
  # Count services (directories not starting with _)
  service_count=$(ls "$docs_ru" 2>/dev/null | grep -v "^_" | wc -l)

  # Count documentation files
  doc_count=$(find "$docs_ru" -name "*.md" 2>/dev/null | wc -l || echo "0")

  # Get list of services
  services=$(ls "$docs_ru" 2>/dev/null | grep -v "^_" | head -n 20 | jq -R . | jq -s . || echo "[]")

  # Build index
  index_data=$(jq -n \
    --argjson service_count "$service_count" \
    --argjson doc_count "$doc_count" \
    --argjson services "$services" \
    --arg timestamp "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
    '{
      service_count: $service_count,
      doc_count: $doc_count,
      services: $services,
      timestamp: $timestamp,
      path: "ru/"
    }')

  # Store in bus
  put_kv "yc.docs.index" "$index_data"

  echo "[docs-indexer] Indexed $service_count services with $doc_count documents"
else
  echo "[docs-indexer] Documentation directory not found: $docs_ru"
  index_data='{"error":"docs_not_found"}'
fi

# Publish completion event
publish_event "yc.agent.docs-indexer.completed" "$index_data"

exit 0
