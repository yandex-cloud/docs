#!/usr/bin/env bash
# Yandex Cloud Skill - Main Entrypoint
# Executes skill tasks and coordinates micro-agents

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
ROOT_DIR="$(git rev-parse --show-toplevel 2>/dev/null || echo "$SKILL_DIR/../../..")"

# Source bus interface
source "$SCRIPT_DIR/bus.sh"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging
log_info() { echo -e "${BLUE}[INFO]${NC} $*"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $*"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
log_error() { echo -e "${RED}[ERROR]${NC} $*" >&2; }

# Task execution time tracking
start_time=$(date +%s)

# Cleanup on exit
cleanup() {
  local exit_code=$?
  local end_time=$(date +%s)
  local duration=$((end_time - start_time))

  # Publish completion event
  publish_event "yc.skill.completed" "$(jq -n \
    --arg task "$TASK" \
    --arg status "$([[ $exit_code -eq 0 ]] && echo "success" || echo "failed")" \
    --argjson duration "$duration" \
    --argjson exit_code "$exit_code" \
    '{task:$task, status:$status, duration:$duration, exit_code:$exit_code}')"

  # Run post hooks (non-blocking, time-limited)
  if [[ -d "$SKILL_DIR/hooks/post-skill-run.d" ]]; then
    for hook in "$SKILL_DIR/hooks/post-skill-run.d/"*.sh; do
      [[ -x "$hook" ]] || continue
      log_info "Running post-hook: $(basename "$hook")"
      (timeout 30s bash "$hook" "$TASK" 2>&1 | head -n 50) || log_warn "Hook $(basename "$hook") failed or timed out"
    done
  fi

  exit $exit_code
}

trap cleanup EXIT INT TERM

# Main tasks
TASK="${1:-help}"
shift || true

case "$TASK" in

  analyze)
    log_info "Analyzing Yandex Cloud infrastructure and documentation..."

    # Publish start event
    publish_event "yc.skill.started" '{"task":"analyze","skill":"yandex-cloud"}'

    # Run environment check
    bash "$SCRIPT_DIR/env-check.sh"

    # Launch parallel analysis agents
    if [[ "${SKIP_AGENTS:-0}" != "1" ]]; then
      log_info "Launching analysis agents..."
      bash "$SCRIPT_DIR/agents-runner.sh" analyze
    fi

    # Analyze documentation structure
    log_info "Analyzing documentation..."
    local doc_count=$(find "$ROOT_DIR/ru" -name "*.md" 2>/dev/null | wc -l || echo "0")
    local service_count=$(ls "$ROOT_DIR/ru" 2>/dev/null | grep -v "^_" | wc -l || echo "0")

    log_success "Found $service_count services with $doc_count documentation files"

    # Store results in bus
    put_kv "yc.analysis.doc_count" "$doc_count"
    put_kv "yc.analysis.service_count" "$service_count"
    put_kv "yc.analysis.timestamp" "\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\""

    log_success "Analysis complete. Results stored in shared context."
    ;;

  build)
    log_info "Building Yandex Cloud configurations..."

    publish_event "yc.skill.started" '{"task":"build","skill":"yandex-cloud"}'

    # Example: generate terraform configs, build docker images, etc.
    log_info "Checking for Terraform configurations..."
    if find "$ROOT_DIR" -name "*.tf" -o -name "*.tfvars" 2>/dev/null | grep -q .; then
      log_success "Terraform configurations found"
      # Could run terraform validate here
    fi

    log_success "Build complete"
    ;;

  test)
    log_info "Testing Yandex Cloud configurations..."

    publish_event "yc.skill.started" '{"task":"test","skill":"yandex-cloud"}'

    # Run self-test
    bash "$SCRIPT_DIR/self-test.sh"

    log_success "Tests passed"
    ;;

  deploy)
    log_info "Deploying Yandex Cloud resources..."

    publish_event "yc.skill.started" '{"task":"deploy","skill":"yandex-cloud"}'

    # Safety check
    if [[ "${ALLOW_DEPLOY:-0}" != "1" ]]; then
      log_error "Deploy requires ALLOW_DEPLOY=1"
      exit 1
    fi

    log_warn "Deploy functionality not yet implemented in this version"
    log_info "Use Yandex Cloud CLI or Terraform directly"

    ;;

  monitor)
    log_info "Setting up monitoring for Yandex Cloud resources..."

    publish_event "yc.skill.started" '{"task":"monitor","skill":"yandex-cloud"}'

    log_info "Monitoring setup guidance:"
    echo "  1. Use Yandex Monitoring for metrics"
    echo "  2. Configure Yandex Logging for logs"
    echo "  3. Enable Audit Trails for security events"
    echo "  4. See: https://yandex.cloud/docs/monitoring/"

    ;;

  troubleshoot)
    log_info "Running Yandex Cloud troubleshooting diagnostics..."

    publish_event "yc.skill.started" '{"task":"troubleshoot","skill":"yandex-cloud"}'

    # Basic diagnostics
    log_info "Checking Yandex Cloud CLI..."
    if command -v yc >/dev/null 2>&1; then
      log_success "yc CLI found: $(yc version 2>&1 | head -n1)"
    else
      log_warn "yc CLI not installed. Install: https://yandex.cloud/docs/cli/quickstart"
    fi

    log_info "Checking Terraform..."
    if command -v terraform >/dev/null 2>&1; then
      log_success "terraform found: $(terraform version -json 2>/dev/null | jq -r '.terraform_version' || terraform version | head -n1)"
    else
      log_warn "terraform not installed"
    fi

    log_info "Use /yc-troubleshoot command for detailed diagnostics"

    ;;

  optimize)
    log_info "Analyzing cost optimization opportunities..."

    publish_event "yc.skill.started" '{"task":"optimize","skill":"yandex-cloud"}'

    # Launch cost optimizer agent
    if [[ "${SKIP_AGENTS:-0}" != "1" ]] && [[ -x "$SKILL_DIR/agents/agent.cost-optimizer.sh" ]]; then
      bash "$SKILL_DIR/agents/agent.cost-optimizer.sh"
    else
      log_info "Cost optimization tips:"
      echo "  1. Use preemptible VMs for non-critical workloads (70% cheaper)"
      echo "  2. Enable autoscaling for Kubernetes node groups"
      echo "  3. Configure lifecycle policies for Object Storage"
      echo "  4. Review and delete unused snapshots and disks"
      echo "  5. Check quotas and right-size resources"
    fi

    ;;

  document)
    log_info "Generating/updating Yandex Cloud documentation..."

    publish_event "yc.skill.started" '{"task":"document","skill":"yandex-cloud"}'

    # Launch docs indexer
    if [[ "${SKIP_AGENTS:-0}" != "1" ]] && [[ -x "$SKILL_DIR/agents/agent.docs-indexer.sh" ]]; then
      bash "$SKILL_DIR/agents/agent.docs-indexer.sh"
    fi

    log_success "Documentation updated"

    ;;

  stats)
    log_info "Yandex Cloud Skill Statistics"
    echo ""

    # Bus stats
    bash "$SCRIPT_DIR/bus.sh" stats

    echo ""
    log_info "Recent events:"
    bash "$SCRIPT_DIR/bus.sh" read yc.skill 10

    ;;

  help|--help|-h)
    cat <<EOF
Yandex Cloud Skill - Task Runner

USAGE:
  $0 <task> [options...]

TASKS:
  analyze       - Analyze infrastructure and documentation
  build         - Build configurations and resources
  test          - Run tests and validation
  deploy        - Deploy resources (requires ALLOW_DEPLOY=1)
  monitor       - Setup monitoring and logging
  troubleshoot  - Run diagnostics
  optimize      - Find cost optimization opportunities
  document      - Generate/update documentation
  stats         - Show skill statistics
  help          - Show this help

ENVIRONMENT VARIABLES:
  BUS_BACKEND    - Event bus backend: json (default), sqlite, redis, graph
  SKIP_AGENTS    - Skip launching micro-agents (set to 1)
  ALLOW_DEPLOY   - Allow deployment operations (set to 1)
  FAST           - Fast mode, skip non-essential checks

EXAMPLES:
  $0 analyze
  $0 build
  SKIP_AGENTS=1 $0 analyze
  BUS_BACKEND=sqlite $0 stats

For detailed guidance, see:
  .claude/skills/yandex-cloud/README.md
  .claude/README.md

EOF
    exit 0
    ;;

  *)
    log_error "Unknown task: $TASK"
    echo "Run '$0 help' for usage information"
    exit 1
    ;;

esac
