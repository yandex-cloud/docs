#!/usr/bin/env bash
# Yandex Cloud Skill - Self Test
# Validates dependencies and environment

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Counters
PASS=0
WARN=0
FAIL=0

check_tool() {
  local tool="$1"
  local required="${2:-no}"

  if command -v "$tool" >/dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} $tool: $(command -v "$tool")"
    PASS=$((PASS + 1))
    return 0
  else
    if [[ "$required" == "yes" ]]; then
      echo -e "${RED}✗${NC} $tool: NOT FOUND (required)"
      FAIL=$((FAIL + 1))
      return 1
    else
      echo -e "${YELLOW}⚠${NC} $tool: not found (recommended)"
      WARN=$((WARN + 1))
      return 0
    fi
  fi
}

echo "=== Yandex Cloud Skill - Self Test ==="
echo ""

# Required tools
echo "Required Tools:"
check_tool bash yes
check_tool git yes
check_tool jq yes

echo ""

# Recommended tools
echo "Recommended Tools:"
check_tool yq no
check_tool yc no
check_tool terraform no
check_tool kubectl no
check_tool docker no
check_tool curl no
check_tool sqlite3 no

echo ""

# Check bus.sh
echo "Skill Components:"
if [[ -x "$SCRIPT_DIR/bus.sh" ]]; then
  echo -e "${GREEN}✓${NC} bus.sh is executable"
  PASS=$((PASS + 1))
else
  echo -e "${RED}✗${NC} bus.sh not found or not executable"
  FAIL=$((FAIL + 1))
fi

if [[ -f "$SCRIPT_DIR/../skill.yaml" ]]; then
  echo -e "${GREEN}✓${NC} skill.yaml exists"
  PASS=$((PASS + 1))
else
  echo -e "${RED}✗${NC} skill.yaml not found"
  FAIL=$((FAIL + 1))
fi

# Test bus
echo ""
echo "Event Bus Test:"
if bash "$SCRIPT_DIR/bus.sh" publish test.selftest '{"status":"testing"}' 2>/dev/null; then
  echo -e "${GREEN}✓${NC} Event bus publish works"
  PASS=$((PASS + 1))
else
  echo -e "${RED}✗${NC} Event bus publish failed"
  FAIL=$((FAIL + 1))
fi

if bash "$SCRIPT_DIR/bus.sh" put test.key '"test_value"' 2>/dev/null; then
  echo -e "${GREEN}✓${NC} Event bus put works"
  PASS=$((PASS + 1))
else
  echo -e "${RED}✗${NC} Event bus put failed"
  FAIL=$((FAIL + 1))
fi

value=$(bash "$SCRIPT_DIR/bus.sh" get test.key 2>/dev/null || echo "")
if [[ "$value" == "\"test_value\"" ]] || [[ "$value" == "test_value" ]]; then
  echo -e "${GREEN}✓${NC} Event bus get works"
  PASS=$((PASS + 1))
else
  echo -e "${YELLOW}⚠${NC} Event bus get returned unexpected value: $value"
  WARN=$((WARN + 1))
fi

# Summary
echo ""
echo "=== Summary ==="
echo -e "${GREEN}Passed: $PASS${NC}"
[[ $WARN -gt 0 ]] && echo -e "${YELLOW}Warnings: $WARN${NC}"
[[ $FAIL -gt 0 ]] && echo -e "${RED}Failed: $FAIL${NC}"

if [[ $FAIL -gt 0 ]]; then
  echo ""
  echo "Some required components are missing. Please install them before using the skill."
  exit 1
elif [[ $WARN -gt 0 ]]; then
  echo ""
  echo "All required components are present. Some recommended tools are missing."
  exit 0
else
  echo ""
  echo "All tests passed! ✨"
  exit 0
fi
