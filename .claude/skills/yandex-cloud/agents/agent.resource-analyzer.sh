#!/usr/bin/env bash
# Yandex Cloud Skill - Resource Analyzer Agent
# Analyzes cloud resource configurations

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
ROOT_DIR="$(git rev-parse --show-toplevel 2>/dev/null || echo "$SKILL_DIR/../../..")"

source "$SKILL_DIR/scripts/bus.sh"

publish_event "yc.agent.resource-analyzer.started" '{"status":"running"}'

# Analyze Terraform files
tf_count=$(find "$ROOT_DIR" -name "*.tf" -o -name "*.tfvars" 2>/dev/null | wc -l || echo "0")

# Analyze Docker files
docker_count=$(find "$ROOT_DIR" -name "Dockerfile*" -o -name "docker-compose*.yml" 2>/dev/null | wc -l || echo "0")

# Analyze Kubernetes manifests
k8s_count=$(find "$ROOT_DIR" -name "*.yaml" -o -name "*.yml" 2>/dev/null | \
  xargs grep -l "kind:" 2>/dev/null | wc -l || echo "0")

# Build analysis result
analysis=$(jq -n \
  --argjson terraform "$tf_count" \
  --argjson docker "$docker_count" \
  --argjson kubernetes "$k8s_count" \
  --arg timestamp "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
  '{
    terraform_files: $terraform,
    docker_files: $docker,
    kubernetes_manifests: $kubernetes,
    timestamp: $timestamp,
    has_infrastructure: ($terraform > 0 or $docker > 0 or $kubernetes > 0)
  }')

# Store results
put_kv "yc.resources.analysis" "$analysis"

echo "[resource-analyzer] Found: Terraform=$tf_count, Docker=$docker_count, K8s=$k8s_count"

# Publish completion
publish_event "yc.agent.resource-analyzer.completed" "$analysis"

exit 0
