#!/usr/bin/env bash
# Yandex Cloud Skill - Undo/Cleanup
# Removes skill artifacts (use with caution)

set -euo pipefail

ROOT_DIR="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
SKILL_DIR="$ROOT_DIR/.claude/skills/yandex-cloud"

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}WARNING: This will remove the Yandex Cloud skill${NC}"
echo "Skill directory: $SKILL_DIR"
echo ""

# Confirmation
read -p "Are you sure? (type 'yes' to confirm): " confirmation

if [[ "$confirmation" != "yes" ]]; then
  echo "Aborting."
  exit 0
fi

echo ""
echo "Removing skill artifacts..."

# Remove skill directory
if [[ -d "$SKILL_DIR" ]]; then
  rm -rf "$SKILL_DIR"
  echo "✓ Removed $SKILL_DIR"
fi

# Remove bus data (optional)
read -p "Remove event bus data? (y/N): " remove_bus
if [[ "$remove_bus" =~ ^[Yy]$ ]]; then
  rm -rf "$ROOT_DIR/.claude/bus"
  echo "✓ Removed bus data"
fi

# Remove context data (optional)
read -p "Remove context data? (y/N): " remove_context
if [[ "$remove_context" =~ ^[Yy]$ ]]; then
  rm -rf "$ROOT_DIR/.claude/context"
  echo "✓ Removed context data"
fi

echo ""
echo "Skill removed successfully."
echo ""
echo "To completely revert, you may also want to:"
echo "  git restore --staged ."
echo "  git reset --hard <previous-commit>"
