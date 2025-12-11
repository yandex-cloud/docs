#!/usr/bin/env bash
# Yandex Cloud Skill - Cost Optimizer Agent
# Finds cost optimization opportunities

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"

source "$SKILL_DIR/scripts/bus.sh"

publish_event "yc.agent.cost-optimizer.started" '{"status":"running"}'

# Generate cost optimization recommendations
recommendations='[
  "Use preemptible VMs for non-critical workloads (70% cost reduction)",
  "Enable autoscaling for Kubernetes node groups",
  "Configure lifecycle policies for Object Storage buckets",
  "Review and delete unused snapshots and disk images",
  "Right-size VM instances based on actual usage",
  "Use committed use discounts for stable workloads",
  "Enable disk compression where applicable",
  "Schedule dev/test environments to run only during work hours"
]'

# Calculate potential savings (example values)
potential_savings=$(jq -n \
  --argjson preemptible_vms '{"monthly_savings_percent": 70, "applicable_to": "dev/test"}' \
  --argjson autoscaling '{"monthly_savings_percent": 30, "applicable_to": "variable_workloads"}' \
  --argjson lifecycle '{"monthly_savings_percent": 50, "applicable_to": "storage"}' \
  '{
    by_category: {
      preemptible_vms: $preemptible_vms,
      autoscaling: $autoscaling,
      lifecycle_policies: $lifecycle
    },
    estimated_total_savings_percent: 40
  }')

# Build result
result=$(jq -n \
  --argjson recommendations "$recommendations" \
  --argjson savings "$potential_savings" \
  --arg timestamp "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
  '{
    recommendations: $recommendations,
    potential_savings: $savings,
    timestamp: $timestamp
  }')

# Store results
put_kv "yc.cost.optimization" "$result"

echo "[cost-optimizer] Generated ${#recommendations[@]} recommendations"

# Publish completion
publish_event "yc.agent.cost-optimizer.completed" "$result"

exit 0
