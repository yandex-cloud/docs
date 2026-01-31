#!/usr/bin/env bash
# Yandex Cloud Skill - Environment Check
# Shows current environment information

set -euo pipefail

ROOT_DIR="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

echo "=== Yandex Cloud Skill - Environment ==="
echo ""

echo "Repository:"
echo "  Path: $ROOT_DIR"
echo "  Branch: $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "N/A")"
echo "  Commit: $(git rev-parse --short HEAD 2>/dev/null || echo "N/A")"
echo ""

echo "System:"
echo "  OS: $(uname -s)"
echo "  Kernel: $(uname -r)"
echo "  Shell: $SHELL"
echo ""

echo "Tools:"
[[ -n "${NODE_VERSION:-}" ]] && echo "  Node: $NODE_VERSION" || echo "  Node: $(node -v 2>/dev/null || echo "N/A")"
echo "  Python: $(python3 --version 2>/dev/null || echo "N/A")"
echo "  Go: $(go version 2>/dev/null | awk '{print $3}' || echo "N/A")"
echo ""

echo "Yandex Cloud:"
if command -v yc >/dev/null 2>&1; then
  echo "  CLI: $(yc version 2>&1 | head -n1 || echo "installed")"

  if yc config list >/dev/null 2>&1; then
    echo "  Profile: $(yc config get profile 2>/dev/null || echo "default")"
    echo "  Cloud: $(yc config get cloud-id 2>/dev/null || echo "not set")"
    echo "  Folder: $(yc config get folder-id 2>/dev/null || echo "not set")"
  else
    echo "  Status: Not configured (run: yc init)"
  fi
else
  echo "  CLI: Not installed"
fi
echo ""

echo "Event Bus:"
echo "  Backend: ${BUS_BACKEND:-json}"
echo "  Config: ${BUS_CFG:-./.claude/skills/yandex-cloud/templates/bus.config.yaml}"
echo ""

echo "Environment Variables:"
env | grep -E "^(YC_|YANDEX_|BUS_|TERRAFORM_|TF_)" | sort || echo "  (none)"
echo ""
