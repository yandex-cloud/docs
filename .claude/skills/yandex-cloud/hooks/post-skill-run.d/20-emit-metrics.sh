#!/usr/bin/env bash
# Yandex Cloud Skill - Emit Metrics
# Collects and publishes execution metrics

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Source bus interface
source "$SKILL_DIR/scripts/bus.sh"

TASK="${1:-unknown}"

# Collect metrics
metrics=$(jq -n \
  --arg task "$TASK" \
  --arg timestamp "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
  --arg hostname "$(hostname)" \
  '{
    task: $task,
    timestamp: $timestamp,
    hostname: $hostname,
    backend: env.BUS_BACKEND
  }' BUS_BACKEND="${BUS_BACKEND:-json}")

# Publish metrics event
publish_event "yc.metrics" "$metrics" 2>/dev/null || true

exit 0
