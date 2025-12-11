#!/usr/bin/env bash
# Yandex Cloud Skill - Agents Runner
# Launches and coordinates micro-agents in parallel

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
AGENTS_DIR="$SKILL_DIR/agents"

# Source bus interface
source "$SCRIPT_DIR/bus.sh"

# Configuration
MAX_AGENTS="${AGENTS_MAX:-4}"
TASK="${1:-all}"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[AGENTS]${NC} $*"; }
log_success() { echo -e "${GREEN}[AGENTS]${NC} $*"; }

# Find agents to run
get_agents() {
  local task="$1"

  case "$task" in
    analyze)
      echo "agent.docs-indexer.sh agent.resource-analyzer.sh"
      ;;
    optimize)
      echo "agent.cost-optimizer.sh"
      ;;
    security)
      echo "agent.security-auditor.sh"
      ;;
    all)
      find "$AGENTS_DIR" -name "agent.*.sh" -executable 2>/dev/null | xargs -n1 basename || true
      ;;
    *)
      echo ""
      ;;
  esac
}

# Run single agent
run_agent() {
  local agent="$1"
  local agent_path="$AGENTS_DIR/$agent"

  if [[ ! -x "$agent_path" ]]; then
    log_info "Agent $agent not found or not executable, skipping"
    return 0
  fi

  log_info "Launching agent: $agent"

  # Run agent (it will publish results to bus)
  bash "$agent_path" 2>&1 | sed "s/^/  [$agent] /" &
}

# Main
log_info "Starting agents runner for task: $TASK"
log_info "Max parallel agents: $MAX_AGENTS"

# Get list of agents
agents=($(get_agents "$TASK"))

if [[ ${#agents[@]} -eq 0 ]]; then
  log_info "No agents to run for task: $TASK"
  exit 0
fi

log_info "Found ${#agents[@]} agent(s): ${agents[*]}"

# Publish start event
publish_event "yc.agents.started" "$(jq -n \
  --arg task "$TASK" \
  --argjson count "${#agents[@]}" \
  '{task:$task, agent_count:$count}')"

# Launch agents with parallelism limit
active=0
completed=0

for agent in "${agents[@]}"; do
  # Wait if at max capacity
  while [[ $active -ge $MAX_AGENTS ]]; do
    wait -n 2>/dev/null || true
    active=$((active - 1))
    completed=$((completed + 1))
  done

  # Launch agent
  run_agent "$agent"
  active=$((active + 1))
done

# Wait for remaining agents
log_info "Waiting for ${active} remaining agent(s)..."
wait

completed=$((completed + active))

log_success "All agents completed ($completed total)"

# Publish completion event
publish_event "yc.agents.completed" "$(jq -n \
  --arg task "$TASK" \
  --argjson count "$completed" \
  '{task:$task, completed:$count, status:"success"}')"
