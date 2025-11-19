#!/usr/bin/env bash
# Yandex Cloud Skill - Security Auditor Agent
# Audits security configurations and finds potential issues

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
ROOT_DIR="$(git rev-parse --show-toplevel 2>/dev/null || echo "$SKILL_DIR/../../..")"

source "$SKILL_DIR/scripts/bus.sh"

publish_event "yc.agent.security-auditor.started" '{"status":"running"}'

# Check for common security issues
issues=()
warnings=()

# Check for potential secrets in code
if grep -r -i -E "(password|secret|api[_-]?key|token|credential)" \
  --include="*.tf" --include="*.yaml" --include="*.yml" --include="*.sh" \
  "$ROOT_DIR" 2>/dev/null | grep -v "password_env" | grep -v "secret_name" | head -n 1 >/dev/null; then
  warnings+=("Potential hardcoded secrets found in configuration files")
fi

# Check Terraform security
if [[ -d "$ROOT_DIR/terraform" ]] || find "$ROOT_DIR" -name "*.tf" 2>/dev/null | head -n 1 | grep -q .; then
  # Check for public access
  if grep -r "0.0.0.0/0" "$ROOT_DIR" --include="*.tf" 2>/dev/null | head -n 1 >/dev/null; then
    warnings+=("Found 0.0.0.0/0 CIDR in Terraform configs - review security groups")
  fi
fi

# Security best practices checklist
best_practices='[
  "Use IAM roles with least privilege principle",
  "Enable encryption at rest for disks and buckets",
  "Use Security Groups to restrict network access",
  "Enable Audit Trails for compliance",
  "Store secrets in Lockbox, not in code",
  "Enable TLS/SSL for all external endpoints",
  "Regularly rotate access keys and passwords",
  "Use service accounts instead of user accounts for automation"
]'

# Build audit result
audit=$(jq -n \
  --argjson issues "$(printf '%s\n' "${issues[@]}" | jq -R . | jq -s . || echo '[]')" \
  --argjson warnings "$(printf '%s\n' "${warnings[@]}" | jq -R . | jq -s . || echo '[]')" \
  --argjson best_practices "$best_practices" \
  --arg timestamp "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
  '{
    issues: $issues,
    warnings: $warnings,
    best_practices: $best_practices,
    severity: (if ($issues | length) > 0 then "high" elif ($warnings | length) > 0 then "medium" else "low" end),
    timestamp: $timestamp
  }')

# Store results
put_kv "yc.security.audit" "$audit"

echo "[security-auditor] Found: ${#issues[@]} issues, ${#warnings[@]} warnings"

# Publish completion
publish_event "yc.agent.security-auditor.completed" "$audit"

exit 0
