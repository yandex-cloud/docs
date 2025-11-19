#!/usr/bin/env bash
# Yandex Cloud Skill - Bus Interface
# Provides unified API for event bus and key-value storage
# Supports: json, sqlite, redis, graph backends

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(git rev-parse --show-toplevel 2>/dev/null || echo "$SCRIPT_DIR/../../../..")"
BUS_CFG="${BUS_CFG:-$ROOT_DIR/.claude/skills/yandex-cloud/templates/bus.config.yaml}"
BACKEND="${BUS_BACKEND:-json}"

# Paths from config (requires yq)
if command -v yq >/dev/null 2>&1; then
  JSON_PATH="$(yq eval '.json.path' "$BUS_CFG" 2>/dev/null || echo "$ROOT_DIR/.claude/bus/shared-context.jsonl")"
  SQLITE_PATH="$(yq eval '.sqlite.path' "$BUS_CFG" 2>/dev/null || echo "$ROOT_DIR/.claude/bus/shared-context.db")"
  REDIS_URL="$(yq eval '.redis.url' "$BUS_CFG" 2>/dev/null || echo "redis://localhost:6379/0")"
else
  JSON_PATH="$ROOT_DIR/.claude/bus/shared-context.jsonl"
  SQLITE_PATH="$ROOT_DIR/.claude/bus/shared-context.db"
  REDIS_URL="redis://localhost:6379/0"
fi

# Ensure directories exist
mkdir -p "$(dirname "$JSON_PATH")" "$ROOT_DIR/.claude/context/events"
touch "$JSON_PATH" 2>/dev/null || true

# Timestamp helper
ts_now() {
  date -u +"%Y-%m-%dT%H:%M:%SZ"
}

# Event Publishing
publish_event() {
  local topic="$1"
  shift
  local payload="$*"

  # Validate topic
  [[ -z "$topic" ]] && { echo "ERROR: topic required" >&2; return 1; }

  # Create event structure
  local evt
  if command -v jq >/dev/null 2>&1; then
    evt="$(jq -cn \
      --arg t "$topic" \
      --arg ts "$(ts_now)" \
      --argjson p "${payload:-{}}" \
      '{topic:$t, timestamp:$ts, payload:$p, backend:env.BACKEND}' \
      BACKEND="$BACKEND")"
  else
    evt="{\"topic\":\"$topic\",\"timestamp\":\"$(ts_now)\",\"payload\":$payload,\"backend\":\"$BACKEND\"}"
  fi

  case "$BACKEND" in
    json)
      echo "$evt" >> "$JSON_PATH"
      ;;

    sqlite)
      if command -v sqlite3 >/dev/null 2>&1; then
        sqlite3 "$SQLITE_PATH" <<EOF
CREATE TABLE IF NOT EXISTS events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  timestamp TEXT NOT NULL,
  topic TEXT NOT NULL,
  payload TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_topic ON events(topic);
CREATE INDEX IF NOT EXISTS idx_timestamp ON events(timestamp);

INSERT INTO events (timestamp, topic, payload)
VALUES ('$(ts_now)', '$topic', '$(echo "$payload" | sed "s/'/''/g")');
EOF
      else
        echo "WARN: sqlite3 not found, falling back to json" >&2
        echo "$evt" >> "$JSON_PATH"
      fi
      ;;

    redis)
      if command -v redis-cli >/dev/null 2>&1; then
        redis-cli -u "$REDIS_URL" PUBLISH "$topic" "$evt" >/dev/null 2>&1 || {
          echo "WARN: redis publish failed, falling back to json" >&2
          echo "$evt" >> "$JSON_PATH"
        }
      else
        echo "WARN: redis-cli not found, falling back to json" >&2
        echo "$evt" >> "$JSON_PATH"
      fi
      ;;

    graph)
      echo "WARN: Neo4j backend not yet implemented, falling back to json" >&2
      echo "$evt" >> "$JSON_PATH"
      ;;

    *)
      echo "ERROR: Unknown backend: $BACKEND" >&2
      return 1
      ;;
  esac

  # Also log to context/events for audit
  echo "$evt" >> "$ROOT_DIR/.claude/context/events/$(date +%Y-%m-%d).jsonl" 2>/dev/null || true
}

# Read events by topic
read_events() {
  local topic="${1:-}"
  local limit="${2:-100}"

  case "$BACKEND" in
    json)
      if [[ -n "$topic" ]]; then
        grep "\"topic\":\"$topic\"" "$JSON_PATH" 2>/dev/null | tail -n "$limit" || true
      else
        tail -n "$limit" "$JSON_PATH" 2>/dev/null || true
      fi
      ;;

    sqlite)
      if command -v sqlite3 >/dev/null 2>&1; then
        local where_clause=""
        [[ -n "$topic" ]] && where_clause="WHERE topic='$topic'"

        sqlite3 "$SQLITE_PATH" <<EOF 2>/dev/null || true
SELECT json_object(
  'topic', topic,
  'timestamp', timestamp,
  'payload', json(payload)
) FROM events
$where_clause
ORDER BY id DESC
LIMIT $limit;
EOF
      fi
      ;;

    redis)
      echo "WARN: read_events not supported for redis backend" >&2
      ;;

    *)
      echo "ERROR: Unknown backend: $BACKEND" >&2
      return 1
      ;;
  esac
}

# Key-Value Storage
put_kv() {
  local key="$1"
  local value="$2"

  [[ -z "$key" ]] && { echo "ERROR: key required" >&2; return 1; }

  case "$BACKEND" in
    json)
      local kv_evt
      kv_evt="{\"topic\":\"kv.set\",\"timestamp\":\"$(ts_now)\",\"payload\":{\"key\":\"$key\",\"value\":$value}}"
      echo "$kv_evt" >> "$JSON_PATH"
      ;;

    sqlite)
      if command -v sqlite3 >/dev/null 2>&1; then
        sqlite3 "$SQLITE_PATH" <<EOF
CREATE TABLE IF NOT EXISTS kv (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO kv (key, value) VALUES ('$key', '$(echo "$value" | sed "s/'/''/g")')
ON CONFLICT(key) DO UPDATE SET value=excluded.value, updated_at=CURRENT_TIMESTAMP;
EOF
      fi
      ;;

    redis)
      if command -v redis-cli >/dev/null 2>&1; then
        redis-cli -u "$REDIS_URL" SET "kv:$key" "$value" >/dev/null 2>&1 || true
      fi
      ;;

    *)
      echo "ERROR: Unknown backend: $BACKEND" >&2
      return 1
      ;;
  esac
}

get_kv() {
  local key="$1"

  [[ -z "$key" ]] && { echo "ERROR: key required" >&2; return 1; }

  case "$BACKEND" in
    json)
      if command -v jq >/dev/null 2>&1; then
        jq -r "select(.topic==\"kv.set\" and .payload.key==\"$key\") | .payload.value // empty" "$JSON_PATH" 2>/dev/null | tail -n1
      else
        grep "\"key\":\"$key\"" "$JSON_PATH" 2>/dev/null | tail -n1 | sed -n 's/.*"value":\s*\(.*\)}.*/\1/p'
      fi
      ;;

    sqlite)
      if command -v sqlite3 >/dev/null 2>&1; then
        sqlite3 "$SQLITE_PATH" "SELECT value FROM kv WHERE key='$key' LIMIT 1;" 2>/dev/null || true
      fi
      ;;

    redis)
      if command -v redis-cli >/dev/null 2>&1; then
        redis-cli -u "$REDIS_URL" GET "kv:$key" 2>/dev/null || true
      fi
      ;;

    *)
      echo "ERROR: Unknown backend: $BACKEND" >&2
      return 1
      ;;
  esac
}

# Delete key
del_kv() {
  local key="$1"

  case "$BACKEND" in
    json)
      # Mark as deleted
      local kv_evt="{\"topic\":\"kv.del\",\"timestamp\":\"$(ts_now)\",\"payload\":{\"key\":\"$key\"}}"
      echo "$kv_evt" >> "$JSON_PATH"
      ;;

    sqlite)
      if command -v sqlite3 >/dev/null 2>&1; then
        sqlite3 "$SQLITE_PATH" "DELETE FROM kv WHERE key='$key';" 2>/dev/null || true
      fi
      ;;

    redis)
      if command -v redis-cli >/dev/null 2>&1; then
        redis-cli -u "$REDIS_URL" DEL "kv:$key" >/dev/null 2>&1 || true
      fi
      ;;
  esac
}

# List all keys
list_keys() {
  case "$BACKEND" in
    json)
      if command -v jq >/dev/null 2>&1; then
        jq -r 'select(.topic=="kv.set") | .payload.key' "$JSON_PATH" 2>/dev/null | sort -u
      fi
      ;;

    sqlite)
      if command -v sqlite3 >/dev/null 2>&1; then
        sqlite3 "$SQLITE_PATH" "SELECT key FROM kv ORDER BY key;" 2>/dev/null || true
      fi
      ;;

    redis)
      if command -v redis-cli >/dev/null 2>&1; then
        redis-cli -u "$REDIS_URL" KEYS "kv:*" 2>/dev/null | sed 's/^kv://' || true
      fi
      ;;
  esac
}

# Stats
stats() {
  echo "Backend: $BACKEND"
  echo "Config: $BUS_CFG"

  case "$BACKEND" in
    json)
      echo "Path: $JSON_PATH"
      if [[ -f "$JSON_PATH" ]]; then
        echo "Events: $(wc -l < "$JSON_PATH")"
        echo "Size: $(du -h "$JSON_PATH" | cut -f1)"
      fi
      ;;

    sqlite)
      echo "Path: $SQLITE_PATH"
      if [[ -f "$SQLITE_PATH" ]] && command -v sqlite3 >/dev/null 2>&1; then
        echo "Events: $(sqlite3 "$SQLITE_PATH" "SELECT COUNT(*) FROM events;" 2>/dev/null || echo "N/A")"
        echo "KV pairs: $(sqlite3 "$SQLITE_PATH" "SELECT COUNT(*) FROM kv;" 2>/dev/null || echo "N/A")"
        echo "Size: $(du -h "$SQLITE_PATH" | cut -f1)"
      fi
      ;;

    redis)
      echo "URL: $REDIS_URL"
      if command -v redis-cli >/dev/null 2>&1; then
        echo "Keys: $(redis-cli -u "$REDIS_URL" DBSIZE 2>/dev/null || echo "N/A")"
      fi
      ;;
  esac
}

# Help
usage() {
  cat <<EOF
Yandex Cloud Skill - Bus Interface

USAGE:
  $0 <command> [args...]

COMMANDS:
  publish <topic> <json_payload>  - Publish event to topic
  read [topic] [limit]            - Read events (optionally filtered by topic)
  put <key> <json_value>          - Set key-value pair
  get <key>                       - Get value by key
  del <key>                       - Delete key
  keys                            - List all keys
  stats                           - Show bus statistics
  help                            - Show this help

ENVIRONMENT:
  BUS_BACKEND     - Backend type: json (default), sqlite, redis, graph
  BUS_CFG         - Path to bus.config.yaml
  REDIS_URL       - Redis connection URL
  NEO4J_URI       - Neo4j connection URI
  NEO4J_USER      - Neo4j username
  NEO4J_PASSWORD  - Neo4j password

EXAMPLES:
  $0 publish skill.started '{"skill":"yandex-cloud","action":"analyze"}'
  $0 read skill.started 10
  $0 put project.name '"my-yc-project"'
  $0 get project.name
  $0 stats

EOF
}

# Main dispatcher
main() {
  local cmd="${1:-help}"
  shift || true

  case "$cmd" in
    publish) publish_event "$@" ;;
    read) read_events "$@" ;;
    put) put_kv "$@" ;;
    get) get_kv "$@" ;;
    del) del_kv "$@" ;;
    keys) list_keys ;;
    stats) stats ;;
    help|--help|-h) usage ;;
    *) echo "Unknown command: $cmd" >&2; usage; exit 1 ;;
  esac
}

# Run if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
