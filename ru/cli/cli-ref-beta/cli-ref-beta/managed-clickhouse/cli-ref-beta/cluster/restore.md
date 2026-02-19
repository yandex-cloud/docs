---
editable: false
noIndex: true
---

# yc beta managed-clickhouse cluster restore

Creates a new ClickHouse cluster using the specified backup.

#### Command Usage

Syntax:

`yc beta managed-clickhouse cluster restore <BACKUP-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--additional-backup-ids` | `[]string`

Additional IDs of the backups to restore from. Each additional backup is responsible for restoring separate shard. Restored cluster will have len(additional_backup_ids)+1 shards in total. To get the backup ID, use a [ClusterService.ListBackups] request. ||
|| `--backup-id` | `string`

ID of the backup to restore from. This backup will be used to create one cluster shard. To get the backup ID, use a [ClusterService.ListBackups] request. ||
|| `--config-spec` | `shorthand/json`

Configuration for the ClickHouse cluster to be created.

Shorthand Syntax:

```hcl
{
  access = {
    data-lens = boolean,
    data-transfer = boolean,
    metrika = boolean,
    serverless = boolean,
    web-sql = boolean,
    yandex-query = boolean
  },
  admin-password = string,
  backup-retain-period-days = integer,
  backup-window-start = timeofday,
  clickhouse = {
    config = {
      access-control-improvements = {
        select-from-information-schema-requires-grant = boolean,
        select-from-system-db-requires-grant = boolean
      },
      async-insert-threads = integer,
      asynchronous-insert-log-enabled = boolean,
      asynchronous-insert-log-retention-size = integer,
      asynchronous-insert-log-retention-time = integer,
      asynchronous-metric-log-enabled = boolean,
      asynchronous-metric-log-retention-size = integer,
      asynchronous-metric-log-retention-time = integer,
      background-buffer-flush-schedule-pool-size = integer,
      background-common-pool-size = integer,
      background-distributed-schedule-pool-size = integer,
      background-fetches-pool-size = integer,
      background-merges-mutations-concurrency-ratio = integer,
      background-message-broker-schedule-pool-size = integer,
      background-move-pool-size = integer,
      background-pool-size = integer,
      background-schedule-pool-size = integer,
      backup-threads = integer,
      builtin-dictionaries-reload-interval = integer,
      compression = [
        {
          level = integer,
          method = LZ4|ZSTD|LZ4HC,
          min-part-size = integer,
          min-part-size-ratio = float64
        }, ...
      ],
      custom-macros = [
        {
          name = string,
          value = string
        }, ...
      ],
      default-database = string,
      dictionaries = [
        {
          layout = {
            access-to-key-from-attributes = boolean,
            allow-read-expired-keys = boolean,
            initial-array-size = integer,
            max-array-size = integer,
            max-threads-for-updates = integer,
            max-update-queue-size = integer,
            query-wait-timeout-milliseconds = integer,
            size-in-cells = integer,
            type = FLAT|HASHED|COMPLEX_KEY_HASHED|RANGE_HASHED|CACHE|COMPLEX_KEY_CACHE|SPARSE_HASHED|COMPLEX_KEY_SPARSE_HASHED|COMPLEX_KEY_RANGE_HASHED|DIRECT|COMPLEX_KEY_DIRECT|IP_TRIE,
            update-queue-push-timeout-milliseconds = integer
          },
          lifetime = fixed-lifetime=integer | lifetime-range={
            max = integer,
            min = integer
          },
          name = string,
          source = clickhouse-source={
            db = string,
            host = string,
            password = string,
            port = integer,
            secure = boolean,
            table = string,
            user = string,
            where = string
          } | http-source={
            format = string,
            headers = [
              {
                name = string,
                value = string
              }, ...
            ],
            url = string
          } | mongodb-source={
            collection = string,
            db = string,
            host = string,
            options = string,
            password = string,
            port = integer,
            user = string
          } | mysql-source={
            close-connection = boolean,
            db = string,
            invalidate-query = string,
            password = string,
            port = integer,
            replicas = [
              {
                host = string,
                password = string,
                port = integer,
                priority = integer,
                user = string
              }, ...
            ],
            share-connection = boolean,
            table = string,
            user = string,
            where = string
          } | postgresql-source={
            db = string,
            hosts = string,...,
            invalidate-query = string,
            password = string,
            port = integer,
            ssl-mode = DISABLE|ALLOW|PREFER|VERIFY_CA|VERIFY_FULL,
            table = string,
            user = string
          },
          structure = {
            attributes = [
              {
                expression = string,
                hierarchical = boolean,
                injective = boolean,
                name = string,
                null-value = string,
                type = string
              }, ...
            ],
            id = {
              name = string
            },
            key = {
              attributes = [
                {
                  expression = string,
                  hierarchical = boolean,
                  injective = boolean,
                  name = string,
                  null-value = string,
                  type = string
                }, ...
              ]
            },
            range-max = {
              expression = string,
              hierarchical = boolean,
              injective = boolean,
              name = string,
              null-value = string,
              type = string
            },
            range-min = {
              expression = string,
              hierarchical = boolean,
              injective = boolean,
              name = string,
              null-value = string,
              type = string
            }
          }
        }, ...
      ],
      dictionaries-lazy-load = boolean,
      error-log-enabled = boolean,
      error-log-retention-size = integer,
      error-log-retention-time = integer,
      geobase-enabled = boolean,
      geobase-uri = string,
      graphite-rollup = [
        {
          name = string,
          path-column-name = string,
          patterns = [
            {
              function = string,
              regexp = string,
              retention = [
                {
                  age = integer,
                  precision = integer
                }, ...
              ]
            }, ...
          ],
          time-column-name = string,
          value-column-name = string,
          version-column-name = string
        }, ...
      ],
      jdbc-bridge = {
        host = string,
        port = integer
      },
      kafka = {
        auto-offset-reset = AUTO_OFFSET_RESET_SMALLEST|AUTO_OFFSET_RESET_EARLIEST|AUTO_OFFSET_RESET_BEGINNING|AUTO_OFFSET_RESET_LARGEST|AUTO_OFFSET_RESET_LATEST|AUTO_OFFSET_RESET_END|AUTO_OFFSET_RESET_ERROR,
        batch-size = integer,
        debug = DEBUG_GENERIC|DEBUG_BROKER|DEBUG_TOPIC|DEBUG_METADATA|DEBUG_FEATURE|DEBUG_QUEUE|DEBUG_MSG|DEBUG_PROTOCOL|DEBUG_CGRP|DEBUG_SECURITY|DEBUG_FETCH|DEBUG_INTERCEPTOR|DEBUG_PLUGIN|DEBUG_CONSUMER|DEBUG_ADMIN|DEBUG_EOS|DEBUG_MOCK|DEBUG_ASSIGNOR|DEBUG_CONF|DEBUG_TELEMETRY|DEBUG_ALL,
        enable-ssl-certificate-verification = boolean,
        max-poll-interval-ms = integer,
        message-max-bytes = integer,
        sasl-mechanism = SASL_MECHANISM_GSSAPI|SASL_MECHANISM_PLAIN|SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512,
        sasl-password = string,
        sasl-username = string,
        security-protocol = SECURITY_PROTOCOL_PLAINTEXT|SECURITY_PROTOCOL_SSL|SECURITY_PROTOCOL_SASL_PLAINTEXT|SECURITY_PROTOCOL_SASL_SSL,
        session-timeout-ms = integer
      },
      kafka-topics = [
        {
          name = string,
          settings = {
            auto-offset-reset = AUTO_OFFSET_RESET_SMALLEST|AUTO_OFFSET_RESET_EARLIEST|AUTO_OFFSET_RESET_BEGINNING|AUTO_OFFSET_RESET_LARGEST|AUTO_OFFSET_RESET_LATEST|AUTO_OFFSET_RESET_END|AUTO_OFFSET_RESET_ERROR,
            batch-size = integer,
            debug = DEBUG_GENERIC|DEBUG_BROKER|DEBUG_TOPIC|DEBUG_METADATA|DEBUG_FEATURE|DEBUG_QUEUE|DEBUG_MSG|DEBUG_PROTOCOL|DEBUG_CGRP|DEBUG_SECURITY|DEBUG_FETCH|DEBUG_INTERCEPTOR|DEBUG_PLUGIN|DEBUG_CONSUMER|DEBUG_ADMIN|DEBUG_EOS|DEBUG_MOCK|DEBUG_ASSIGNOR|DEBUG_CONF|DEBUG_TELEMETRY|DEBUG_ALL,
            enable-ssl-certificate-verification = boolean,
            max-poll-interval-ms = integer,
            message-max-bytes = integer,
            sasl-mechanism = SASL_MECHANISM_GSSAPI|SASL_MECHANISM_PLAIN|SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512,
            sasl-password = string,
            sasl-username = string,
            security-protocol = SECURITY_PROTOCOL_PLAINTEXT|SECURITY_PROTOCOL_SSL|SECURITY_PROTOCOL_SASL_PLAINTEXT|SECURITY_PROTOCOL_SASL_SSL,
            session-timeout-ms = integer
          }
        }, ...
      ],
      keep-alive-timeout = integer,
      log-level = TRACE|DEBUG|INFORMATION|WARNING|ERROR,
      mark-cache-size = integer,
      max-build-vector-similarity-index-thread-pool-size = integer,
      max-concurrent-queries = integer,
      max-connections = integer,
      max-partition-size-to-drop = integer,
      max-table-size-to-drop = integer,
      merge-tree = {
        allow-remote-fs-zero-copy-replication = boolean,
        check-sample-column-is-correct = boolean,
        cleanup-delay-period = integer,
        deduplicate-merge-projection-mode = DEDUPLICATE_MERGE_PROJECTION_MODE_IGNORE|DEDUPLICATE_MERGE_PROJECTION_MODE_THROW|DEDUPLICATE_MERGE_PROJECTION_MODE_DROP|DEDUPLICATE_MERGE_PROJECTION_MODE_REBUILD,
        fsync-after-insert = boolean,
        fsync-part-directory = boolean,
        inactive-parts-to-delay-insert = integer,
        inactive-parts-to-throw-insert = integer,
        lightweight-mutation-projection-mode = LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW|LIGHTWEIGHT_MUTATION_PROJECTION_MODE_DROP|LIGHTWEIGHT_MUTATION_PROJECTION_MODE_REBUILD,
        materialize-ttl-recalculate-only = boolean,
        max-avg-part-size-for-too-many-parts = integer,
        max-bytes-to-merge-at-max-space-in-pool = integer,
        max-bytes-to-merge-at-min-space-in-pool = integer,
        max-cleanup-delay-period = integer,
        max-merge-selecting-sleep-ms = integer,
        max-number-of-merges-with-ttl-in-pool = integer,
        max-parts-in-total = integer,
        max-replicated-merges-in-queue = integer,
        merge-max-block-size = integer,
        merge-selecting-sleep-ms = integer,
        merge-with-recompression-ttl-timeout = integer,
        merge-with-ttl-timeout = integer,
        min-age-to-force-merge-on-partition-only = boolean,
        min-age-to-force-merge-seconds = integer,
        min-bytes-for-wide-part = integer,
        min-compressed-bytes-to-fsync-after-fetch = integer,
        min-compressed-bytes-to-fsync-after-merge = integer,
        min-rows-for-wide-part = integer,
        min-rows-to-fsync-after-merge = integer,
        number-of-free-entries-in-pool-to-execute-mutation = integer,
        number-of-free-entries-in-pool-to-lower-max-size-of-merge = integer,
        parts-to-delay-insert = integer,
        parts-to-throw-insert = integer,
        replicated-deduplication-window = integer,
        replicated-deduplication-window-seconds = integer,
        ttl-only-drop-parts = boolean
      },
      metric-log-enabled = boolean,
      metric-log-retention-size = integer,
      metric-log-retention-time = integer,
      mysql-protocol = boolean,
      opentelemetry-span-log-enabled = boolean,
      opentelemetry-span-log-retention-size = integer,
      opentelemetry-span-log-retention-time = integer,
      part-log-retention-size = integer,
      part-log-retention-time = integer,
      processors-profile-log-enabled = boolean,
      processors-profile-log-retention-size = integer,
      processors-profile-log-retention-time = integer,
      query-cache = {
        max-entries = integer,
        max-entry-size-in-bytes = integer,
        max-entry-size-in-rows = integer,
        max-size-in-bytes = integer
      },
      query-log-retention-size = integer,
      query-log-retention-time = integer,
      query-masking-rules = [
        {
          name = string,
          regexp = string,
          replace = string
        }, ...
      ],
      query-metric-log-enabled = boolean,
      query-metric-log-retention-size = integer,
      query-metric-log-retention-time = integer,
      query-thread-log-enabled = boolean,
      query-thread-log-retention-size = integer,
      query-thread-log-retention-time = integer,
      query-views-log-enabled = boolean,
      query-views-log-retention-size = integer,
      query-views-log-retention-time = integer,
      rabbitmq = {
        password = string,
        username = string,
        vhost = string
      },
      restore-threads = integer,
      session-log-enabled = boolean,
      session-log-retention-size = integer,
      session-log-retention-time = integer,
      text-log-enabled = boolean,
      text-log-level = TRACE|DEBUG|INFORMATION|WARNING|ERROR,
      text-log-retention-size = integer,
      text-log-retention-time = integer,
      timezone = string,
      total-memory-profiler-step = integer,
      total-memory-tracker-sample-probability = float64,
      trace-log-enabled = boolean,
      trace-log-retention-size = integer,
      trace-log-retention-time = integer,
      uncompressed-cache-size = integer,
      vector-similarity-index-cache-max-entries = integer,
      vector-similarity-index-cache-size = integer,
      zookeeper-log-enabled = boolean,
      zookeeper-log-retention-size = integer,
      zookeeper-log-retention-time = integer
    },
    disk-size-autoscaling = {
      disk-size-limit = integer,
      emergency-usage-threshold = integer,
      planned-usage-threshold = integer
    },
    resources = {
      disk-size = integer,
      disk-type-id = string,
      resource-preset-id = string
    }
  },
  cloud-storage = {
    data-cache-enabled = boolean,
    data-cache-max-size = integer,
    enabled = boolean,
    move-factor = float64,
    prefer-not-to-merge = boolean
  },
  embedded-keeper = boolean,
  sql-database-management = boolean,
  sql-user-management = boolean,
  version = string,
  zookeeper = {
    disk-size-autoscaling = {
      disk-size-limit = integer,
      emergency-usage-threshold = integer,
      planned-usage-threshold = integer
    },
    resources = {
      disk-size = integer,
      disk-type-id = string,
      resource-preset-id = string
    }
  }
}
```

JSON Syntax:

```json
{
  "access": {
    "data-lens": "boolean",
    "data-transfer": "boolean",
    "metrika": "boolean",
    "serverless": "boolean",
    "web-sql": "boolean",
    "yandex-query": "boolean"
  },
  "admin-password": "string",
  "backup-retain-period-days": "integer",
  "backup-window-start": "timeofday",
  "clickhouse": {
    "config": {
      "access-control-improvements": {
        "select-from-information-schema-requires-grant": "boolean",
        "select-from-system-db-requires-grant": "boolean"
      },
      "async-insert-threads": "integer",
      "asynchronous-insert-log-enabled": "boolean",
      "asynchronous-insert-log-retention-size": "integer",
      "asynchronous-insert-log-retention-time": "integer",
      "asynchronous-metric-log-enabled": "boolean",
      "asynchronous-metric-log-retention-size": "integer",
      "asynchronous-metric-log-retention-time": "integer",
      "background-buffer-flush-schedule-pool-size": "integer",
      "background-common-pool-size": "integer",
      "background-distributed-schedule-pool-size": "integer",
      "background-fetches-pool-size": "integer",
      "background-merges-mutations-concurrency-ratio": "integer",
      "background-message-broker-schedule-pool-size": "integer",
      "background-move-pool-size": "integer",
      "background-pool-size": "integer",
      "background-schedule-pool-size": "integer",
      "backup-threads": "integer",
      "builtin-dictionaries-reload-interval": "integer",
      "compression": [
        {
          "level": "integer",
          "method": "LZ4|ZSTD|LZ4HC",
          "min-part-size": "integer",
          "min-part-size-ratio": "float64"
        }, ...
      ],
      "custom-macros": [
        {
          "name": "string",
          "value": "string"
        }, ...
      ],
      "default-database": "string",
      "dictionaries": [
        {
          "layout": {
            "access-to-key-from-attributes": "boolean",
            "allow-read-expired-keys": "boolean",
            "initial-array-size": "integer",
            "max-array-size": "integer",
            "max-threads-for-updates": "integer",
            "max-update-queue-size": "integer",
            "query-wait-timeout-milliseconds": "integer",
            "size-in-cells": "integer",
            "type": "FLAT|HASHED|COMPLEX_KEY_HASHED|RANGE_HASHED|CACHE|COMPLEX_KEY_CACHE|SPARSE_HASHED|COMPLEX_KEY_SPARSE_HASHED|COMPLEX_KEY_RANGE_HASHED|DIRECT|COMPLEX_KEY_DIRECT|IP_TRIE",
            "update-queue-push-timeout-milliseconds": "integer"
          },
          "lifetime": {
            "fixed-lifetime": "integer",
            "lifetime-range": {
              "max": "integer",
              "min": "integer"
            }
          },
          "name": "string",
          "source": {
            "clickhouse-source": {
              "db": "string",
              "host": "string",
              "password": "string",
              "port": "integer",
              "secure": "boolean",
              "table": "string",
              "user": "string",
              "where": "string"
            },
            "http-source": {
              "format": "string",
              "headers": [
                {
                  "name": "string",
                  "value": "string"
                }, ...
              ],
              "url": "string"
            },
            "mongodb-source": {
              "collection": "string",
              "db": "string",
              "host": "string",
              "options": "string",
              "password": "string",
              "port": "integer",
              "user": "string"
            },
            "mysql-source": {
              "close-connection": "boolean",
              "db": "string",
              "invalidate-query": "string",
              "password": "string",
              "port": "integer",
              "replicas": [
                {
                  "host": "string",
                  "password": "string",
                  "port": "integer",
                  "priority": "integer",
                  "user": "string"
                }, ...
              ],
              "share-connection": "boolean",
              "table": "string",
              "user": "string",
              "where": "string"
            },
            "postgresql-source": {
              "db": "string",
              "hosts": [
                "string", ...
              ],
              "invalidate-query": "string",
              "password": "string",
              "port": "integer",
              "ssl-mode": "DISABLE|ALLOW|PREFER|VERIFY_CA|VERIFY_FULL",
              "table": "string",
              "user": "string"
            }
          },
          "structure": {
            "attributes": [
              {
                "expression": "string",
                "hierarchical": "boolean",
                "injective": "boolean",
                "name": "string",
                "null-value": "string",
                "type": "string"
              }, ...
            ],
            "id": {
              "name": "string"
            },
            "key": {
              "attributes": [
                {
                  "expression": "string",
                  "hierarchical": "boolean",
                  "injective": "boolean",
                  "name": "string",
                  "null-value": "string",
                  "type": "string"
                }, ...
              ]
            },
            "range-max": {
              "expression": "string",
              "hierarchical": "boolean",
              "injective": "boolean",
              "name": "string",
              "null-value": "string",
              "type": "string"
            },
            "range-min": {
              "expression": "string",
              "hierarchical": "boolean",
              "injective": "boolean",
              "name": "string",
              "null-value": "string",
              "type": "string"
            }
          }
        }, ...
      ],
      "dictionaries-lazy-load": "boolean",
      "error-log-enabled": "boolean",
      "error-log-retention-size": "integer",
      "error-log-retention-time": "integer",
      "geobase-enabled": "boolean",
      "geobase-uri": "string",
      "graphite-rollup": [
        {
          "name": "string",
          "path-column-name": "string",
          "patterns": [
            {
              "function": "string",
              "regexp": "string",
              "retention": [
                {
                  "age": "integer",
                  "precision": "integer"
                }, ...
              ]
            }, ...
          ],
          "time-column-name": "string",
          "value-column-name": "string",
          "version-column-name": "string"
        }, ...
      ],
      "jdbc-bridge": {
        "host": "string",
        "port": "integer"
      },
      "kafka": {
        "auto-offset-reset": "AUTO_OFFSET_RESET_SMALLEST|AUTO_OFFSET_RESET_EARLIEST|AUTO_OFFSET_RESET_BEGINNING|AUTO_OFFSET_RESET_LARGEST|AUTO_OFFSET_RESET_LATEST|AUTO_OFFSET_RESET_END|AUTO_OFFSET_RESET_ERROR",
        "batch-size": "integer",
        "debug": "DEBUG_GENERIC|DEBUG_BROKER|DEBUG_TOPIC|DEBUG_METADATA|DEBUG_FEATURE|DEBUG_QUEUE|DEBUG_MSG|DEBUG_PROTOCOL|DEBUG_CGRP|DEBUG_SECURITY|DEBUG_FETCH|DEBUG_INTERCEPTOR|DEBUG_PLUGIN|DEBUG_CONSUMER|DEBUG_ADMIN|DEBUG_EOS|DEBUG_MOCK|DEBUG_ASSIGNOR|DEBUG_CONF|DEBUG_TELEMETRY|DEBUG_ALL",
        "enable-ssl-certificate-verification": "boolean",
        "max-poll-interval-ms": "integer",
        "message-max-bytes": "integer",
        "sasl-mechanism": "SASL_MECHANISM_GSSAPI|SASL_MECHANISM_PLAIN|SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512",
        "sasl-password": "string",
        "sasl-username": "string",
        "security-protocol": "SECURITY_PROTOCOL_PLAINTEXT|SECURITY_PROTOCOL_SSL|SECURITY_PROTOCOL_SASL_PLAINTEXT|SECURITY_PROTOCOL_SASL_SSL",
        "session-timeout-ms": "integer"
      },
      "kafka-topics": [
        {
          "name": "string",
          "settings": {
            "auto-offset-reset": "AUTO_OFFSET_RESET_SMALLEST|AUTO_OFFSET_RESET_EARLIEST|AUTO_OFFSET_RESET_BEGINNING|AUTO_OFFSET_RESET_LARGEST|AUTO_OFFSET_RESET_LATEST|AUTO_OFFSET_RESET_END|AUTO_OFFSET_RESET_ERROR",
            "batch-size": "integer",
            "debug": "DEBUG_GENERIC|DEBUG_BROKER|DEBUG_TOPIC|DEBUG_METADATA|DEBUG_FEATURE|DEBUG_QUEUE|DEBUG_MSG|DEBUG_PROTOCOL|DEBUG_CGRP|DEBUG_SECURITY|DEBUG_FETCH|DEBUG_INTERCEPTOR|DEBUG_PLUGIN|DEBUG_CONSUMER|DEBUG_ADMIN|DEBUG_EOS|DEBUG_MOCK|DEBUG_ASSIGNOR|DEBUG_CONF|DEBUG_TELEMETRY|DEBUG_ALL",
            "enable-ssl-certificate-verification": "boolean",
            "max-poll-interval-ms": "integer",
            "message-max-bytes": "integer",
            "sasl-mechanism": "SASL_MECHANISM_GSSAPI|SASL_MECHANISM_PLAIN|SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512",
            "sasl-password": "string",
            "sasl-username": "string",
            "security-protocol": "SECURITY_PROTOCOL_PLAINTEXT|SECURITY_PROTOCOL_SSL|SECURITY_PROTOCOL_SASL_PLAINTEXT|SECURITY_PROTOCOL_SASL_SSL",
            "session-timeout-ms": "integer"
          }
        }, ...
      ],
      "keep-alive-timeout": "integer",
      "log-level": "TRACE|DEBUG|INFORMATION|WARNING|ERROR",
      "mark-cache-size": "integer",
      "max-build-vector-similarity-index-thread-pool-size": "integer",
      "max-concurrent-queries": "integer",
      "max-connections": "integer",
      "max-partition-size-to-drop": "integer",
      "max-table-size-to-drop": "integer",
      "merge-tree": {
        "allow-remote-fs-zero-copy-replication": "boolean",
        "check-sample-column-is-correct": "boolean",
        "cleanup-delay-period": "integer",
        "deduplicate-merge-projection-mode": "DEDUPLICATE_MERGE_PROJECTION_MODE_IGNORE|DEDUPLICATE_MERGE_PROJECTION_MODE_THROW|DEDUPLICATE_MERGE_PROJECTION_MODE_DROP|DEDUPLICATE_MERGE_PROJECTION_MODE_REBUILD",
        "fsync-after-insert": "boolean",
        "fsync-part-directory": "boolean",
        "inactive-parts-to-delay-insert": "integer",
        "inactive-parts-to-throw-insert": "integer",
        "lightweight-mutation-projection-mode": "LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW|LIGHTWEIGHT_MUTATION_PROJECTION_MODE_DROP|LIGHTWEIGHT_MUTATION_PROJECTION_MODE_REBUILD",
        "materialize-ttl-recalculate-only": "boolean",
        "max-avg-part-size-for-too-many-parts": "integer",
        "max-bytes-to-merge-at-max-space-in-pool": "integer",
        "max-bytes-to-merge-at-min-space-in-pool": "integer",
        "max-cleanup-delay-period": "integer",
        "max-merge-selecting-sleep-ms": "integer",
        "max-number-of-merges-with-ttl-in-pool": "integer",
        "max-parts-in-total": "integer",
        "max-replicated-merges-in-queue": "integer",
        "merge-max-block-size": "integer",
        "merge-selecting-sleep-ms": "integer",
        "merge-with-recompression-ttl-timeout": "integer",
        "merge-with-ttl-timeout": "integer",
        "min-age-to-force-merge-on-partition-only": "boolean",
        "min-age-to-force-merge-seconds": "integer",
        "min-bytes-for-wide-part": "integer",
        "min-compressed-bytes-to-fsync-after-fetch": "integer",
        "min-compressed-bytes-to-fsync-after-merge": "integer",
        "min-rows-for-wide-part": "integer",
        "min-rows-to-fsync-after-merge": "integer",
        "number-of-free-entries-in-pool-to-execute-mutation": "integer",
        "number-of-free-entries-in-pool-to-lower-max-size-of-merge": "integer",
        "parts-to-delay-insert": "integer",
        "parts-to-throw-insert": "integer",
        "replicated-deduplication-window": "integer",
        "replicated-deduplication-window-seconds": "integer",
        "ttl-only-drop-parts": "boolean"
      },
      "metric-log-enabled": "boolean",
      "metric-log-retention-size": "integer",
      "metric-log-retention-time": "integer",
      "mysql-protocol": "boolean",
      "opentelemetry-span-log-enabled": "boolean",
      "opentelemetry-span-log-retention-size": "integer",
      "opentelemetry-span-log-retention-time": "integer",
      "part-log-retention-size": "integer",
      "part-log-retention-time": "integer",
      "processors-profile-log-enabled": "boolean",
      "processors-profile-log-retention-size": "integer",
      "processors-profile-log-retention-time": "integer",
      "query-cache": {
        "max-entries": "integer",
        "max-entry-size-in-bytes": "integer",
        "max-entry-size-in-rows": "integer",
        "max-size-in-bytes": "integer"
      },
      "query-log-retention-size": "integer",
      "query-log-retention-time": "integer",
      "query-masking-rules": [
        {
          "name": "string",
          "regexp": "string",
          "replace": "string"
        }, ...
      ],
      "query-metric-log-enabled": "boolean",
      "query-metric-log-retention-size": "integer",
      "query-metric-log-retention-time": "integer",
      "query-thread-log-enabled": "boolean",
      "query-thread-log-retention-size": "integer",
      "query-thread-log-retention-time": "integer",
      "query-views-log-enabled": "boolean",
      "query-views-log-retention-size": "integer",
      "query-views-log-retention-time": "integer",
      "rabbitmq": {
        "password": "string",
        "username": "string",
        "vhost": "string"
      },
      "restore-threads": "integer",
      "session-log-enabled": "boolean",
      "session-log-retention-size": "integer",
      "session-log-retention-time": "integer",
      "text-log-enabled": "boolean",
      "text-log-level": "TRACE|DEBUG|INFORMATION|WARNING|ERROR",
      "text-log-retention-size": "integer",
      "text-log-retention-time": "integer",
      "timezone": "string",
      "total-memory-profiler-step": "integer",
      "total-memory-tracker-sample-probability": "float64",
      "trace-log-enabled": "boolean",
      "trace-log-retention-size": "integer",
      "trace-log-retention-time": "integer",
      "uncompressed-cache-size": "integer",
      "vector-similarity-index-cache-max-entries": "integer",
      "vector-similarity-index-cache-size": "integer",
      "zookeeper-log-enabled": "boolean",
      "zookeeper-log-retention-size": "integer",
      "zookeeper-log-retention-time": "integer"
    },
    "disk-size-autoscaling": {
      "disk-size-limit": "integer",
      "emergency-usage-threshold": "integer",
      "planned-usage-threshold": "integer"
    },
    "resources": {
      "disk-size": "integer",
      "disk-type-id": "string",
      "resource-preset-id": "string"
    }
  },
  "cloud-storage": {
    "data-cache-enabled": "boolean",
    "data-cache-max-size": "integer",
    "enabled": "boolean",
    "move-factor": "float64",
    "prefer-not-to-merge": "boolean"
  },
  "embedded-keeper": "boolean",
  "sql-database-management": "boolean",
  "sql-user-management": "boolean",
  "version": "string",
  "zookeeper": {
    "disk-size-autoscaling": {
      "disk-size-limit": "integer",
      "emergency-usage-threshold": "integer",
      "planned-usage-threshold": "integer"
    },
    "resources": {
      "disk-size": "integer",
      "disk-type-id": "string",
      "resource-preset-id": "string"
    }
  }
}
```

Fields:

```
access -> (struct)
  Access policy for external services. If you want a specific service to access the ClickHouse cluster, then set the necessary values in this policy.
  data-lens -> (boolean)
    Allow to export data from the cluster to DataLens.
  data-transfer -> (boolean)
    Allow access for DataTransfer
  metrika -> (boolean)
    Allow to import data from Yandex Metrica and AppMetrica to the cluster. See AppMetrica documentation for more details.
  serverless -> (boolean)
    Allow access to cluster for Serverless.
  web-sql -> (boolean)
    Allow SQL queries to the cluster databases from the management console. See documentation for more details.
  yandex-query -> (boolean)
    Allow access for Query
admin-password -> (string)
  Password for user 'admin' that has SQL user management access.
backup-retain-period-days -> (integer)
  Retain period of automatically created backup in days
backup-window-start -> (timeofday)
  Time to start the daily backup, in the UTC timezone.
clickhouse -> (struct)
  Configuration and resources for a ClickHouse server.
  config -> (struct)
    Configuration for a ClickHouse server.
    access-control-improvements -> (struct)
      Access control settings.
      select-from-information-schema-requires-grant -> (boolean)
        Sets whether **SELECT * FROM information_schema.<table>** requires any grants and can be executed by any user. If set to true, then this query requires **GRANT SELECT ON information_schema.<table>**, just as for ordinary tables. Default value: **false**.
      select-from-system-db-requires-grant -> (boolean)
        Sets whether **SELECT * FROM system.<table>** requires any grants and can be executed by any user. If set to true then this query requires **GRANT SELECT ON system.<table>** just as for non-system tables. Default value: **false**.
    async-insert-threads -> (integer)
      Maximum number of threads to parse and insert data in background. If set to **0**, asynchronous mode is disabled. Default value: **16**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    asynchronous-insert-log-enabled -> (boolean)
      Enables or disables asynchronous_insert_log system table. Default value: **false**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    asynchronous-insert-log-retention-size -> (integer)
      The maximum size that asynchronous_insert_log can grow to before old data will be removed. If set to **0**, automatic removal of asynchronous_insert_log data based on size is disabled. Default value: **0**.
    asynchronous-insert-log-retention-time -> (integer)
      The maximum time that asynchronous_insert_log records will be retained before removal. If set to **0**, automatic removal of asynchronous_insert_log data based on time is disabled. Default value: **2592000000** (30 days).
    asynchronous-metric-log-enabled -> (boolean)
      Enables or disables asynchronous_metric_log system table. Default value: **false**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    asynchronous-metric-log-retention-size -> (integer)
      The maximum size that asynchronous_metric_log can grow to before old data will be removed. If set to **0**, automatic removal of asynchronous_metric_log data based on size is disabled. Default value: **0**.
    asynchronous-metric-log-retention-time -> (integer)
      The maximum time that asynchronous_metric_log records will be retained before removal. If set to **0**, automatic removal of asynchronous_metric_log data based on time is disabled. Default value: **2592000000** (30 days).
    background-buffer-flush-schedule-pool-size -> (integer)
      The maximum number of threads that will be used for performing flush operations for Buffer-engine tables in the background. Default value: **16**. Change of the setting is applied with restart on value decrease and without restart on value increase. For details, see ClickHouse documentation.
    background-common-pool-size -> (integer)
      The maximum number of threads that will be used for performing a variety of operations (mostly garbage collection) for MergeTree-engine tables in a background. Default value: **8**. Change of the setting is applied with restart on value decrease and without restart on value increase. For details, see ClickHouse documentation.
    background-distributed-schedule-pool-size -> (integer)
      The maximum number of threads that will be used for executing distributed sends. Default value: **16**. Change of the setting is applied with restart on value decrease and without restart on value increase. For details, see ClickHouse documentation.
    background-fetches-pool-size -> (integer)
      The maximum number of threads that will be used for fetching data parts from another replica for MergeTree-engine tables in a background. Default value: **32** for versions 25.1 and higher, **16** for versions 24.12 and lower. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    background-merges-mutations-concurrency-ratio -> (integer)
      Sets a ratio between the number of threads and the number of background merges and mutations that can be executed concurrently. For example, if the ratio equals to **2** and **background_pool_size** is set to **16** then ClickHouse can execute **32** background merges concurrently. This is possible, because background operations could be suspended and postponed. This is needed to give small merges more execution priority. Default value: **2**. Change of the setting is applied with restart on value decrease and without restart on value increase. For details, see ClickHouse documentation.
    background-message-broker-schedule-pool-size -> (integer)
      The maximum number of threads that will be used for executing background operations for message streaming. Default value: **16**. Change of the setting is applied with restart on value decrease and without restart on value increase. For details, see ClickHouse documentation.
    background-move-pool-size -> (integer)
      The maximum number of threads that will be used for moving data parts to another disk or volume for MergeTree-engine tables in a background. Default value: **8**. Change of the setting is applied with restart on value decrease and without restart on value increase. For details, see ClickHouse documentation.
    background-pool-size -> (integer)
      Sets the number of threads performing background merges and mutations for MergeTree-engine tables. Default value: **16**. Change of the setting is applied with restart on value decrease and without restart on value increase. For details, see ClickHouse documentation.
    background-schedule-pool-size -> (integer)
      The maximum number of threads that will be used for constantly executing some lightweight periodic operations for replicated tables, Kafka streaming, and DNS cache updates. Default value: **512**. Change of the setting is applied with restart on value decrease and without restart on value increase. For details, see ClickHouse documentation.
    backup-threads -> (integer)
      The maximum number of threads to execute **BACKUP** requests. Default value: **16**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    builtin-dictionaries-reload-interval -> (integer)
      The interval in seconds before reloading built-in dictionaries. Default value: **3600**. For details, see ClickHouse documentation.
    compression -> ([]struct)
      Data compression settings for MergeTree engine tables. Change of the settings of **compression** is applied with restart. For details, see ClickHouse documentation.
      level -> (integer)
        Compression level.
      method -> (struct)
        Compression method to use for the specified combination of **min_part_size** and **min_part_size_ratio**.
      min-part-size -> (integer)
        The minimum size of a data part.
      min-part-size-ratio -> (float64)
        The ratio of the data part size to the table size.
    custom-macros -> ([]struct)
      Custom ClickHouse macros.
      name -> (string)
        Name of the macro.
      value -> (string)
        Value of the macro.
    default-database -> (string)
      The default database. Default value: **default**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    dictionaries -> ([]struct)
      Configuration of external dictionaries. Change of the settings of **dictionaries** is applied with restart. For details, see ClickHouse documentation.
      layout -> (struct)
        Layout determining how to store the dictionary in memory. For details, see https://clickhouse.com/docs/sql-reference/dictionaries#ways-to-store-dictionaries-in-memory.
        access-to-key-from-attributes -> (boolean)
          Allows to retrieve key attribute using **dictGetString** function. Enabling this option increases memory usage. Applicable only for **IP_TRIE** layout type. For details, see ClickHouse documentation.
        allow-read-expired-keys -> (boolean)
          Allows to read expired keys. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **false**. For details, see ClickHouse documentation.
        initial-array-size -> (integer)
          Initial dictionary key size. Applicable only for **FLAT** layout type. Default value: **1024**. For details, see ClickHouse documentation.
        max-array-size -> (integer)
          Maximum dictionary key size. Applicable only for **FLAT** layout type. Default value: **500000**. For details, see ClickHouse documentation.
        max-threads-for-updates -> (integer)
          Max threads for cache dictionary update. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **4**. For details, see ClickHouse documentation.
        max-update-queue-size -> (integer)
          Max size of update queue. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **100000**. For details, see ClickHouse documentation.
        query-wait-timeout-milliseconds -> (integer)
          Max wait timeout in milliseconds for update task to complete. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **60000** (1 minute). For details, see ClickHouse documentation.
        size-in-cells -> (integer)
          Number of cells in the cache. Rounded up to a power of two. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **1000000000**. For details, see ClickHouse documentation.
        type -> (struct)
          Layout type. For details, see ClickHouse documentation.
        update-queue-push-timeout-milliseconds -> (integer)
          Max timeout in milliseconds for push update task into queue. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **10**. For details, see ClickHouse documentation.
      name -> (string)
        Name of the external dictionary.
      structure -> (struct)
        Structure of the external dictionary.
        attributes -> ([]struct)
          Description of the fields available for database queries. For details, see ClickHouse documentation.
          expression -> (string)
            Expression, describing the attribute, if applicable.
          hierarchical -> (boolean)
            Indication of hierarchy support. Default value: **false**.
          injective -> (boolean)
            Indication of injective mapping "id -> attribute". Default value: **false**.
          name -> (string)
            Name of the column.
          null-value -> (string)
            Default value for an element without data (for example, an empty string).
          type -> (string)
            Type of the column.
        id -> (struct)
          Single numeric key column for the dictionary.
          name -> (string)
            Name of the numeric key.
        key -> (struct)
          Composite key for the dictionary, containing of one or more key columns. For details, see ClickHouse documentation.
          attributes -> ([]struct)
            Attributes of a complex key.
            expression -> (string)
              Expression, describing the attribute, if applicable.
            hierarchical -> (boolean)
              Indication of hierarchy support. Default value: **false**.
            injective -> (boolean)
              Indication of injective mapping "id -> attribute". Default value: **false**.
            name -> (string)
              Name of the column.
            null-value -> (string)
              Default value for an element without data (for example, an empty string).
            type -> (string)
              Type of the column.
        range-max -> (struct)
          Field holding the end of the range for dictionaries with **RANGE_HASHED** layout. For details, see ClickHouse documentation.
          expression -> (string)
            Expression, describing the attribute, if applicable.
          hierarchical -> (boolean)
            Indication of hierarchy support. Default value: **false**.
          injective -> (boolean)
            Indication of injective mapping "id -> attribute". Default value: **false**.
          name -> (string)
            Name of the column.
          null-value -> (string)
            Default value for an element without data (for example, an empty string).
          type -> (string)
            Type of the column.
        range-min -> (struct)
          Field holding the beginning of the range for dictionaries with **RANGE_HASHED** layout. For details, see ClickHouse documentation.
          expression -> (string)
            Expression, describing the attribute, if applicable.
          hierarchical -> (boolean)
            Indication of hierarchy support. Default value: **false**.
          injective -> (boolean)
            Indication of injective mapping "id -> attribute". Default value: **false**.
          name -> (string)
            Name of the column.
          null-value -> (string)
            Default value for an element without data (for example, an empty string).
          type -> (string)
            Type of the column.
      lifetime -> (oneof<fixed-lifetime|lifetime-range>)
        Oneof lifetime field
        fixed-lifetime -> (integer)
          Fixed interval between dictionary updates.
        lifetime-range -> (struct)
          Range of intervals between dictionary updates for ClickHouse to choose from.
          max -> (integer)
            Maximum dictionary lifetime.
          min -> (integer)
            Minimum dictionary lifetime.
      source -> (oneof<clickhouse-source|http-source|mongodb-source|mysql-source|postgresql-source>)
        Oneof source field
        http-source -> (struct)
          HTTP source for the dictionary.
          format -> (string)
            The data format. Valid values are all formats supported by ClickHouse SQL dialect.
          headers -> ([]struct)
            HTTP headers.
            name -> (string)
              Header name.
            value -> (string)
              Header value.
          url -> (string)
            URL of the source dictionary available over HTTP.
        mysql-source -> (struct)
          MySQL source for the dictionary.
          close-connection -> (boolean)
            Should a connection be closed after each request.
          db -> (string)
            Database name.
          invalidate-query -> (string)
            Query for checking the dictionary status, to pull only updated data.
          password -> (string)
            Password of the user for replicas of the dictionary source.
          port -> (integer)
            Port to use when connecting to a replica of the dictionary source.
          replicas -> ([]struct)
            List of MySQL replicas of the database used as dictionary source.
            host -> (string)
              MySQL host of the replica.
            password -> (string)
              Password of the MySQL database user. If a password is not specified for a replica, ClickHouse uses the password specified for the source.
            port -> (integer)
              Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source.
            priority -> (integer)
              The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number.
            user -> (string)
              Name of the MySQL database user. If a user is not specified for a replica, ClickHouse uses the user specified for the source.
          share-connection -> (boolean)
            Should a connection be shared for some requests.
          table -> (string)
            Table name.
          user -> (string)
            Name of the user for replicas of the dictionary source.
          where -> (string)
            Selection criteria for the data in the specified MySQL table.
        clickhouse-source -> (struct)
          ClickHouse source for the dictionary.
          db -> (string)
            Database name.
          host -> (string)
            ClickHouse host.
          password -> (string)
            Password of the ClickHouse database user.
          port -> (integer)
            Port to use when connecting to the host.
          secure -> (boolean)
            Determines whether to use TLS for connection.
          table -> (string)
            Table name.
          user -> (string)
            Name of the ClickHouse database user.
          where -> (string)
            Selection criteria for the data in the specified ClickHouse table.
        mongodb-source -> (struct)
          MongoDB source for the dictionary.
          collection -> (string)
            Collection name.
          db -> (string)
            Database name.
          host -> (string)
            MongoDB host.
          options -> (string)
            Dictionary source options.
          password -> (string)
            Password of the MongoDB database user.
          port -> (integer)
            Port to use when connecting to the host.
          user -> (string)
            Name of the MongoDB database user.
        postgresql-source -> (struct)
          PostgreSQL source for the dictionary.
          db -> (string)
            Database name.
          hosts -> ([]string)
            PostgreSQL hosts.
          invalidate-query -> (string)
            Query for checking the dictionary status, to pull only updated data.
          password -> (string)
            Password of the PostrgreSQL database user.
          port -> (integer)
            Port to use when connecting to the PostgreSQL hosts.
          ssl-mode -> (struct)
            Mode of SSL TCP/IP connection to the PostgreSQL host.
          table -> (string)
            Table name.
          user -> (string)
            Name of the PostrgreSQL database user.
    dictionaries-lazy-load -> (boolean)
      Lazy loading of dictionaries. If enabled, then each dictionary is loaded on the first use. Otherwise, the server loads all dictionaries at startup. Default value: **true** for versions 25.1 and higher, **false** for versions 24.12 and lower. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    error-log-enabled -> (boolean)
      Enables or disables error_log system table. Default value: **false**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    error-log-retention-size -> (integer)
      The maximum size that error_log can grow to before old data will be removed. If set to **0**, automatic removal of error_log data based on size is disabled. Default value: **0**.
    error-log-retention-time -> (integer)
      The maximum time that error_log records will be retained before removal. If set to **0**, automatic removal of error_log data based on time is disabled. Default value: **2592000000** (30 days).
    geobase-enabled -> (boolean)
      Enables or disables geobase. Default value: **false** for versions 25.8 and higher, **true** for versions 25.7 and lower. Change of the setting is applied with restart.
    geobase-uri -> (string)
      Address of the archive with the user geobase in Object Storage. Change of the setting is applied with restart.
    graphite-rollup -> ([]struct)
      Rollup settings for the GraphiteMergeTree engine tables. Change of the settings of **graphite_rollup** is applied with restart. For details, see ClickHouse documentation.
      name -> (string)
        Name for the specified combination of settings for Graphite rollup.
      path-column-name -> (string)
        The name of the column storing the metric name (Graphite sensor). Default value: **Path**.
      patterns -> ([]struct)
        Pattern to use for the rollup.
        function -> (string)
          The name of the aggregating function to apply to data whose age falls within the range [age, age + precision]. Accepted functions: **min**, **max**, **any**, **avg**. The average is calculated imprecisely, like the average of the averages.
        regexp -> (string)
          A pattern for the metric name (a regular or DSL).
        retention -> ([]struct)
          Retention rules.
          age -> (integer)
            The minimum age of the data in seconds.
          precision -> (integer)
            Precision of determining the age of the data, in seconds. Should be a divisor for 86400 (seconds in a day).
      time-column-name -> (string)
        The name of the column storing the time of measuring the metric. Default value: **Time**.
      value-column-name -> (string)
        The name of the column storing the value of the metric at the time set in **time_column_name**. Default value: **Value**.
      version-column-name -> (string)
        The name of the column storing the version of the metric. Default value: **Timestamp**.
    jdbc-bridge -> (struct)
      JDBC bridge configuration for queries to external databases. Change of the settings of **jdbc_bridge** is applied with restart. For details, see ClickHouse documentation.
      host -> (string)
        Host of jdbc bridge.
      port -> (integer)
        Port of jdbc bridge. Default value: **9019**.
    kafka -> (struct)
      Kafka integration settings. Change of the settings of **kafka** is applied with restart.
      auto-offset-reset -> (struct)
        Action to take when there is no initial offset in offset store or the desired offset is out of range. Default value: **AUTO_OFFSET_RESET_LARGEST**.
      batch-size -> (integer)
        Maximum size (in bytes) of all messages batched in one MessageSet, including protocol framing overhead. Default value: **1000000**.
      debug -> (struct)
        Debug context to enable.
      enable-ssl-certificate-verification -> (boolean)
        Enable OpenSSL's builtin broker (server) certificate verification. Default value: **true**.
      max-poll-interval-ms -> (integer)
        Maximum allowed time between calls to consume messages for high-level consumers. If this interval is exceeded the consumer is considered failed and the group will rebalance in order to reassign the partitions to another consumer group member. Default value: **300000** (5 minutes).
      message-max-bytes -> (integer)
        Maximum Kafka protocol request message size. Default value: **1000000**.
      sasl-mechanism -> (struct)
        SASL mechanism to use for authentication. Default value: **SASL_MECHANISM_GSSAPI**.
      sasl-password -> (string)
        SASL password for use with the PLAIN and SASL-SCRAM mechanisms.
      sasl-username -> (string)
        SASL username for use with the PLAIN and SASL-SCRAM mechanisms.
      security-protocol -> (struct)
        Protocol used to communicate with brokers. Default value: **SECURITY_PROTOCOL_PLAINTEXT**.
      session-timeout-ms -> (integer)
        Client group session and failure detection timeout. The consumer sends periodic heartbeats (heartbeat.interval.ms) to indicate its liveness to the broker. If no hearts are received by the broker for a group member within the session timeout, the broker will remove the consumer from the group and trigger a rebalance. Default value: **45000** (45 seconds).
    kafka-topics -> ([]struct)
      Per-topic Kafka integration settings. Change of the settings of **kafka_topics** is applied with restart.
      name -> (string)
        Kafka topic name.
      settings -> (struct)
        Kafka topic settings.
        auto-offset-reset -> (struct)
          Action to take when there is no initial offset in offset store or the desired offset is out of range. Default value: **AUTO_OFFSET_RESET_LARGEST**.
        batch-size -> (integer)
          Maximum size (in bytes) of all messages batched in one MessageSet, including protocol framing overhead. Default value: **1000000**.
        debug -> (struct)
          Debug context to enable.
        enable-ssl-certificate-verification -> (boolean)
          Enable OpenSSL's builtin broker (server) certificate verification. Default value: **true**.
        max-poll-interval-ms -> (integer)
          Maximum allowed time between calls to consume messages for high-level consumers. If this interval is exceeded the consumer is considered failed and the group will rebalance in order to reassign the partitions to another consumer group member. Default value: **300000** (5 minutes).
        message-max-bytes -> (integer)
          Maximum Kafka protocol request message size. Default value: **1000000**.
        sasl-mechanism -> (struct)
          SASL mechanism to use for authentication. Default value: **SASL_MECHANISM_GSSAPI**.
        sasl-password -> (string)
          SASL password for use with the PLAIN and SASL-SCRAM mechanisms.
        sasl-username -> (string)
          SASL username for use with the PLAIN and SASL-SCRAM mechanisms.
        security-protocol -> (struct)
          Protocol used to communicate with brokers. Default value: **SECURITY_PROTOCOL_PLAINTEXT**.
        session-timeout-ms -> (integer)
          Client group session and failure detection timeout. The consumer sends periodic heartbeats (heartbeat.interval.ms) to indicate its liveness to the broker. If no hearts are received by the broker for a group member within the session timeout, the broker will remove the consumer from the group and trigger a rebalance. Default value: **45000** (45 seconds).
    keep-alive-timeout -> (integer)
      The number of seconds that ClickHouse waits for incoming requests for HTTP protocol before closing the connection. Default value: **3** for versions 25.10 and higher, **30** for versions 25.9 and lower. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    log-level -> (struct)
      Logging level.
    mark-cache-size -> (integer)
      Maximum size (in bytes) of the cache of "marks" used by MergeTree tables. For details, see ClickHouse documentation.
    max-build-vector-similarity-index-thread-pool-size -> (integer)
      The maximum number of threads to use for building vector indexes. **0** means unlimited. Default value: **16**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    max-concurrent-queries -> (integer)
      Maximum number of concurrently executed queries. Default value: **500**. For details, see ClickHouse documentation.
    max-connections -> (integer)
      Maximum number of inbound connections. Default value: **4096**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    max-partition-size-to-drop -> (integer)
      Maximum size of the partition that can be deleted using **DROP** or **TRUNCATE** query. Default value: **50000000000** (48828125 KiB). For details, see ClickHouse documentation.
    max-table-size-to-drop -> (integer)
      Maximum size of the table that can be deleted using **DROP** or **TRUNCATE** query. Default value: **50000000000** (48828125 KiB). For details, see ClickHouse documentation.
    merge-tree -> (struct)
      Settings for the MergeTree table engine family. Change of the settings of **merge_tree** is applied with restart.
      allow-remote-fs-zero-copy-replication -> (boolean)
        Setting is automatically enabled if cloud storage is enabled, disabled otherwise. Default value: **true**.
      check-sample-column-is-correct -> (boolean)
        Enables the check at table creation, that the data type of a column for sampling or sampling expression is correct. The data type must be one of unsigned integer types: UInt8, UInt16, UInt32, UInt64. Default value: **true**. For details, see ClickHouse documentation.
      cleanup-delay-period -> (integer)
        Minimum period to clean old queue logs, blocks hashes and parts. Default value: **30**. For details, see ClickHouse documentation.
      deduplicate-merge-projection-mode -> (struct)
        Determines the behavior of background merges for MergeTree tables with projections. Default value: **DEDUPLICATE_MERGE_PROJECTION_MODE_THROW**. For details, see ClickHouse documentation.
      fsync-after-insert -> (boolean)
        Do fsync for every inserted part. Significantly decreases performance of inserts, not recommended to use with wide parts. Default value: **false**. For details, see ClickHouse documentation.
      fsync-part-directory -> (boolean)
        Do fsync for part directory after all part operations (writes, renames, etc.). Default value: **false**. For details, see ClickHouse documentation.
      inactive-parts-to-delay-insert -> (integer)
        If the number of inactive parts in a single partition in the table exceeds the **inactive_parts_to_delay_insert** value, an **INSERT** is artificially slowed down. Default value: **0**. For details, see ClickHouse documentation.
      inactive-parts-to-throw-insert -> (integer)
        If the number of inactive parts in a single partition more than the **inactive_parts_to_throw_insert** value, **INSERT** is interrupted with an error. Default value: **0**. For details, see ClickHouse documentation.
      lightweight-mutation-projection-mode -> (struct)
        Determines the behavior of lightweight deletes for MergeTree tables with projections. Default value: **LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW**. For details, see ClickHouse documentation.
      materialize-ttl-recalculate-only -> (boolean)
        Only recalculate ttl info when **MATERIALIZE TTL**. Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower. For details, see ClickHouse documentation.
      max-avg-part-size-for-too-many-parts -> (integer)
        The "Too many parts" check according to **parts_to_delay_insert** and **parts_to_throw_insert** will be active only if the average part size (in the relevant partition) is not larger than the specified threshold. If it is larger than the specified threshold, **INSERT** queries will be neither delayed or rejected. This allows to have hundreds of terabytes in a single table on a single server if the parts are successfully merged to larger parts. This does not affect the thresholds on inactive parts or total parts. Default value: **1073741824** (1 GiB). For details, see ClickHouse documentation.
      max-bytes-to-merge-at-max-space-in-pool -> (integer)
        The maximum total parts size (in bytes) to be merged into one part, if there are enough resources available. Corresponds roughly to the maximum possible part size created by an automatic background merge. **0** means merges will be disabled. Default value: **161061273600** (150 GiB). For details, see ClickHouse documentation.
      max-bytes-to-merge-at-min-space-in-pool -> (integer)
        The maximum total part size (in bytes) to be merged into one part, with the minimum available resources in the background pool. Default value: **1048576** (1 MiB). For details, see ClickHouse documentation.
      max-cleanup-delay-period -> (integer)
        Maximum period to clean old queue logs, blocks hashes and parts. Default value: **300** (5 minutes). For details, see ClickHouse documentation.
      max-merge-selecting-sleep-ms -> (integer)
        Maximum time to wait before trying to select parts to merge again after no parts were selected. A lower setting value will trigger selecting tasks in background_schedule_pool frequently which result in large amount of requests to Keeper in large-scale clusters. Default value: **60000** (1 minute). For details, see ClickHouse documentation.
      max-number-of-merges-with-ttl-in-pool -> (integer)
        When there is more than specified number of merges with TTL entries in pool, do not assign new merge with TTL. This is to leave free threads for regular merges and avoid "Too many parts" errors. Default value: **2**. For details, see ClickHouse documentation.
      max-parts-in-total -> (integer)
        If the total number of active parts in all partitions of a table exceeds the **max_parts_in_total** value, an **INSERT** is interrupted with the error "Too many parts (N)". Default value: **20000** for versions 25.2 and higher, **100000** for versions 25.1 and lower. For details, see ClickHouse documentation.
      max-replicated-merges-in-queue -> (integer)
        How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. Default value: **32** for versions 25.8 and higher, **16** for versions 25.7 and lower. For details, see ClickHouse documentation.
      merge-max-block-size -> (integer)
        The number of rows that are read from the merged parts into memory. Default value: **8192**. For details, see ClickHouse documentation.
      merge-selecting-sleep-ms -> (integer)
        Minimum time to wait before trying to select parts to merge again after no parts were selected. A lower setting value will trigger selecting tasks in background_schedule_pool frequently which result in large amount of requests to Keeper in large-scale clusters. Default value: **5000** (5 seconds). For details, see ClickHouse documentation.
      merge-with-recompression-ttl-timeout -> (integer)
        Minimum delay in seconds before repeating a merge with recompression TTL. Default value: **14400** (4 hours). For details, see ClickHouse documentation.
      merge-with-ttl-timeout -> (integer)
        Minimum delay in seconds before repeating a merge with delete TTL. Default value: **14400** (4 hours). For details, see ClickHouse documentation.
      min-age-to-force-merge-on-partition-only -> (boolean)
        Whether **min_age_to_force_merge_seconds** should be applied only on the entire partition and not on subset. Default value: **false**. For details, see ClickHouse documentation.
      min-age-to-force-merge-seconds -> (integer)
        Merge parts if every part in the range is older than the specified value. **0** means disabled. Default value: **0**. For details, see ClickHouse documentation.
      min-bytes-for-wide-part -> (integer)
        Minimum number of bytes in a data part that can be stored in Wide format. Default value: **10485760** (10 MiB). For details, see ClickHouse documentation.
      min-compressed-bytes-to-fsync-after-fetch -> (integer)
        Minimal number of compressed bytes to do fsync for part after fetch. **0** means disabled. Default value: **0**. For details, see ClickHouse documentation.
      min-compressed-bytes-to-fsync-after-merge -> (integer)
        Minimal number of compressed bytes to do fsync for part after merge. **0** means disabled. Default value: **0**. For details, see ClickHouse documentation.
      min-rows-for-wide-part -> (integer)
        Minimum number of rows in a data part that can be stored in Wide format. Default value: **0**. For details, see ClickHouse documentation.
      min-rows-to-fsync-after-merge -> (integer)
        Minimal number of rows to do fsync for part after merge. **0** means disabled. Default value: **0**. For details, see ClickHouse documentation.
      number-of-free-entries-in-pool-to-execute-mutation -> (integer)
        When there is less than specified number of free entries in pool, do not execute part mutations. This is to leave free threads for regular merges and to avoid "Too many parts" errors. Default value: **20**. For details, see ClickHouse documentation.
      number-of-free-entries-in-pool-to-lower-max-size-of-merge -> (integer)
        When there is less than the specified number of free entries in pool (or replicated queue), start to lower maximum size of merge to process (or to put in queue). This is to allow small merges to process - not filling the pool with long running merges. Default value: **8**. For details, see ClickHouse documentation.
      parts-to-delay-insert -> (integer)
        If the number of active parts in a single partition exceeds the **parts_to_delay_insert** value, an **INSERT** artificially slows down. Default value: **1000** for versions 25.1 and higher, **150** for versions 24.12 and lower. For details, see ClickHouse documentation.
      parts-to-throw-insert -> (integer)
        If the number of active parts in a single partition exceeds the **parts_to_throw_insert** value, an **INSERT** is interrupted with the error "Too many parts (N). Merges are processing significantly slower than inserts". Default value: **3000** for versions 25.1 and higher, **300** for versions 24.12 and lower. For details, see ClickHouse documentation.
      replicated-deduplication-window -> (integer)
        The number of most recently inserted blocks for which ClickHouse Keeper stores hash sums to check for duplicates. Default value: **10000** for versions 25.9 and higher, **1000** for versions from 23.11 to 25.8, **100** for versions 23.10 and lower. For details, see ClickHouse documentation.
      replicated-deduplication-window-seconds -> (integer)
        The number of seconds after which the hash sums of the inserted blocks are removed from ClickHouse Keeper. Default value: **3600** (1 hour) for versions 25.10 and higher, **604800** (7 days) for versions 25.9 and lower. For details, see ClickHouse documentation.
      ttl-only-drop-parts -> (boolean)
        Controls whether data parts are fully dropped in MergeTree tables when all rows in that part have expired according to their **TTL** settings. * **true** - the entire part is dropped if all rows in that part have expired according to their **TTL** settings. * **false** - only the rows that have expired based on their **TTL** settings are removed. Default value: **false**. For details, see ClickHouse documentation.
    metric-log-enabled -> (boolean)
      Enables or disables metric_log system table. Default value: **false** for versions 25.1 and higher, **true** for versions 24.12 and lower. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    metric-log-retention-size -> (integer)
      The maximum size that metric_log can grow to before old data will be removed. If set to **0**, automatic removal of metric_log data based on size is disabled. Default value: **536870912** (512 MiB).
    metric-log-retention-time -> (integer)
      The maximum time that metric_log records will be retained before removal. If set to **0**, automatic removal of metric_log data based on time is disabled. Default value: **2592000000** (30 days).
    mysql-protocol -> (boolean)
      Enables or disables MySQL interface on ClickHouse server Default value: **false**. For details, see ClickHouse documentation.
    opentelemetry-span-log-enabled -> (boolean)
      Enables or disables opentelemetry_span_log system table. Default value: **false**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    opentelemetry-span-log-retention-size -> (integer)
      The maximum size that opentelemetry_span_log can grow to before old data will be removed. If set to **0**, automatic removal of opentelemetry_span_log data based on size is disabled. Default value: **0**.
    opentelemetry-span-log-retention-time -> (integer)
      The maximum time that opentelemetry_span_log records will be retained before removal. If set to **0**, automatic removal of opentelemetry_span_log data based on time is disabled. Default value: **2592000000** (30 days).
    part-log-retention-size -> (integer)
      The maximum size that part_log can grow to before old data will be removed. If set to **0**, automatic removal of part_log data based on size is disabled. Default value: **536870912** (512 MiB).
    part-log-retention-time -> (integer)
      The maximum time that part_log records will be retained before removal. If set to **0**, automatic removal of part_log data based on time is disabled. Default value: **2592000000** (30 days).
    processors-profile-log-enabled -> (boolean)
      Enables or disables processors_profile_log system table. Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    processors-profile-log-retention-size -> (integer)
      The maximum size that processors_profile_log can grow to before old data will be removed. If set to **0**, automatic removal of processors_profile_log data based on size is disabled. Default value: **0**.
    processors-profile-log-retention-time -> (integer)
      The maximum time that processors_profile_log records will be retained before removal. If set to **0**, automatic removal of processors_profile_log data based on time is disabled. Default value: **2592000000** (30 days).
    query-cache -> (struct)
      Query cache configuration. Change of the settings of **query_cache** is applied with restart.
      max-entries -> (integer)
        The maximum number of **SELECT** query results stored in the cache. Default value: **1024**.
      max-entry-size-in-bytes -> (integer)
        The maximum size in bytes **SELECT** query results may have to be saved in the cache. Default value: **1048576** (1 MiB).
      max-entry-size-in-rows -> (integer)
        The maximum number of rows **SELECT** query results may have to be saved in the cache. Default value: **30000000**.
      max-size-in-bytes -> (integer)
        The maximum cache size in bytes. Default value: **1073741824** (1 GiB).
    query-log-retention-size -> (integer)
      The maximum size that query_log can grow to before old data will be removed. If set to **0**, automatic removal of query_log data based on size is disabled. Default value: **1073741824** (1 GiB).
    query-log-retention-time -> (integer)
      The maximum time that query_log records will be retained before removal. If set to **0**, automatic removal of query_log data based on time is disabled. Default value: **2592000000** (30 days).
    query-masking-rules -> ([]struct)
      Regexp-based rules, which will be applied to queries as well as all log messages before storing them in server logs, system.query_log, system.text_log, system.processes tables, and in logs sent to the client. That allows preventing sensitive data leakage from SQL queries (like names, emails, personal identifiers or credit card numbers) to logs. Change of the settings of **query_masking_rules** is applied with restart. For details, see ClickHouse documentation.
      name -> (string)
        Name for the rule.
      regexp -> (string)
        RE2 compatible regular expression.
      replace -> (string)
        Substitution string for sensitive data. Default value: six asterisks.
    query-metric-log-enabled -> (boolean)
      Enables or disables query_metric_log system table. Default value: **false**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    query-metric-log-retention-size -> (integer)
      The maximum size that query_metric_log can grow to before old data will be removed. If set to **0**, automatic removal of query_metric_log data based on size is disabled. Default value: **536870912** (512 MiB).
    query-metric-log-retention-time -> (integer)
      The maximum time that query_metric_log records will be retained before removal. If set to **0**, automatic removal of query_metric_log data based on time is disabled. Default value: **2592000000** (30 days).
    query-thread-log-enabled -> (boolean)
      Enables or disables query_thread_log system table. Default value: **true**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    query-thread-log-retention-size -> (integer)
      The maximum size that query_thread_log can grow to before old data will be removed. If set to **0**, automatic removal of query_thread_log data based on size is disabled. Default value: **536870912** (512 MiB).
    query-thread-log-retention-time -> (integer)
      The maximum time that query_thread_log records will be retained before removal. If set to **0**, automatic removal of query_thread_log data based on time is disabled. Default value: **2592000000** (30 days).
    query-views-log-enabled -> (boolean)
      Enables or disables query_views_log system table. Default value: **false**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    query-views-log-retention-size -> (integer)
      The maximum size that query_views_log can grow to before old data will be removed. If set to **0**, automatic removal of query_views_log data based on size is disabled. Default value: **0**.
    query-views-log-retention-time -> (integer)
      The maximum time that query_views_log records will be retained before removal. If set to **0**, automatic removal of query_views_log data based on time is disabled. Default value: **2592000000** (30 days).
    rabbitmq -> (struct)
      RabbitMQ integration settings. Change of the settings of **rabbitmq** is applied with restart.
      password -> (string)
        RabbitMQ password.
      username -> (string)
        RabbitMQ username.
      vhost -> (string)
        RabbitMQ virtual host.
    restore-threads -> (integer)
      The maximum number of threads to execute **RESTORE** requests. Default value: **16**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    session-log-enabled -> (boolean)
      Enables or disables session_log system table. Default value: **true** for versions 25.3 and higher, **false** for versions 25.2 and lower. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    session-log-retention-size -> (integer)
      The maximum size that session_log can grow to before old data will be removed. If set to **0**, automatic removal of session_log data based on size is disabled. Default value: **536870912** (512 MiB) for versions 25.3 and higher, **0** for versions 25.2 and lower.
    session-log-retention-time -> (integer)
      The maximum time that session_log records will be retained before removal. If set to **0**, automatic removal of session_log data based on time is disabled. Default value: **2592000000** (30 days).
    text-log-enabled -> (boolean)
      Enables or disables text_log system table. Default value: **false**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    text-log-level -> (struct)
      Logging level for text_log system table. Default value: **TRACE**. Change of the setting is applied with restart.
    text-log-retention-size -> (integer)
      The maximum size that text_log can grow to before old data will be removed. If set to **0**, automatic removal of text_log data based on size is disabled. Default value: **536870912** (512 MiB).
    text-log-retention-time -> (integer)
      The maximum time that text_log records will be retained before removal. If set to **0**, automatic removal of text_log data based on time is disabled. Default value: **2592000000** (30 days).
    timezone -> (string)
      The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. Default value: **Europe/Moscow**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    total-memory-profiler-step -> (integer)
      Whenever server memory usage becomes larger than every next step in number of bytes the memory profiler will collect the allocating stack trace. **0** means disabled memory profiler. Default value: **0**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    total-memory-tracker-sample-probability -> (float64)
      Allows to collect random allocations and de-allocations and writes them in the system.trace_log system table with trace_type equal to a MemorySample with the specified probability. Default value: **0**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    trace-log-enabled -> (boolean)
      Enables or disables trace_log system table. Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    trace-log-retention-size -> (integer)
      The maximum size that trace_log can grow to before old data will be removed. If set to **0**, automatic removal of trace_log data based on size is disabled. Default value: **536870912** (512 MiB).
    trace-log-retention-time -> (integer)
      The maximum time that trace_log records will be retained before removal. If set to **0**, automatic removal of trace_log data based on time is disabled. Default value: **2592000000** (30 days).
    uncompressed-cache-size -> (integer)
      Cache size (in bytes) for uncompressed data used by table engines from the MergeTree family. **0** means disabled. For details, see ClickHouse documentation.
    vector-similarity-index-cache-max-entries -> (integer)
      Size of cache for vector similarity indexes, in entries. **0** means disabled. Default value: **10000000**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    vector-similarity-index-cache-size -> (integer)
      Size of cache for vector similarity indexes, in bytes. **0** means disabled. Default value: **5368709120** (5 GiB). Change of the setting is applied with restart. For details, see ClickHouse documentation.
    zookeeper-log-enabled -> (boolean)
      Enables or disables zookeeper_log system table. Default value: **false**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
    zookeeper-log-retention-size -> (integer)
      The maximum size that zookeeper_log can grow to before old data will be removed. If set to **0**, automatic removal of zookeeper_log data based on size is disabled. Default value: **0**.
    zookeeper-log-retention-time -> (integer)
      The maximum time that zookeeper_log records will be retained before removal. If set to **0**, automatic removal of zookeeper_log data based on time is disabled. Default value: **2592000000** (30 days).
  disk-size-autoscaling -> (struct)
    Disk size autoscaling settings.
    disk-size-limit -> (integer)
      Limit on how large the storage for database instances can automatically grow, in bytes.
    emergency-usage-threshold -> (integer)
      Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
    planned-usage-threshold -> (integer)
      Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
  resources -> (struct)
    Resources allocated to ClickHouse hosts.
    disk-size -> (integer)
      Volume of the storage available to a host, in bytes.
    disk-type-id -> (string)
      Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
    resource-preset-id -> (string)
      ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation
cloud-storage -> (struct)
  data-cache-enabled -> (boolean)
  data-cache-max-size -> (integer)
  enabled -> (boolean)
    Whether to use Object Storage for storing ClickHouse data.
  move-factor -> (float64)
  prefer-not-to-merge -> (boolean)
embedded-keeper -> (boolean)
  Whether cluster should use embedded Keeper instead of Zookeeper
sql-database-management -> (boolean)
  Whether database management through SQL commands is enabled.
sql-user-management -> (boolean)
  Whether user management through SQL commands is enabled.
version -> (string)
  Version of the ClickHouse server software.
zookeeper -> (struct)
  Configuration and resources for a ZooKeeper server.
  disk-size-autoscaling -> (struct)
    Disk size autoscaling settings.
    disk-size-limit -> (integer)
      Limit on how large the storage for database instances can automatically grow, in bytes.
    emergency-usage-threshold -> (integer)
      Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
    planned-usage-threshold -> (integer)
      Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
  resources -> (struct)
    Resources allocated to ZooKeeper hosts. If not set, minimal available resources will be used. All available resource presets can be retrieved with a [ResourcePresetService.List] request.
    disk-size -> (integer)
      Volume of the storage available to a host, in bytes.
    disk-type-id -> (string)
      Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
    resource-preset-id -> (string)
      ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation
``` ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster ||
|| `--description` | `string`

Description of the new ClickHouse cluster. ||
|| `--disk-encryption-key-id` | `string`

ID of the key to encrypt cluster disks. ||
|| `--environment` | `enum`

Deployment environment of the new ClickHouse cluster. Possible Values: 'production', 'prestable' ||
|| `--folder-id` | `string`

ID of the folder to create the ClickHouse cluster in. ||
|| `--host-specs` | `shorthand/json`

Configurations for ClickHouse hosts that should be created for the cluster that is being created from the backup.

Shorthand Syntax:

```hcl
[
  {
    assign-public-ip = boolean,
    shard-name = string,
    subnet-id = string,
    type = CLICKHOUSE|ZOOKEEPER|KEEPER,
    zone-id = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "assign-public-ip": "boolean",
    "shard-name": "string",
    "subnet-id": "string",
    "type": "CLICKHOUSE|ZOOKEEPER|KEEPER",
    "zone-id": "string"
  }, ...
]
```

Fields:

```
assign-public-ip -> (boolean)
  Whether the host should get a public IP address on creation. After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with [assign_public_ip] set as needed. Possible values: * false - don't assign a public IP to the host. * true - the host should have a public IP address.
shard-name -> (string)
  Name of the shard that the host is assigned to.
subnet-id -> (string)
  ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the [Cluster.network_id] field.
type -> (struct)
  Type of the host to be deployed.
zone-id -> (string)
  ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request.
``` ||
|| `--labels` | `map<string><string>`

Custom labels for the ClickHouse cluster as 'key:value' pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". ||
|| `--maintenance-window` | `shorthand/json`

Window of maintenance operations.

Shorthand Syntax:

```hcl
{
  policy = anytime={} | weekly-maintenance-window={
    day = MON|TUE|WED|THU|FRI|SAT|SUN,
    hour = integer
  }
}
```

JSON Syntax:

```json
{
  "policy": {
    "anytime": {},
    "weekly-maintenance-window": {
      "day": "MON|TUE|WED|THU|FRI|SAT|SUN",
      "hour": "integer"
    }
  }
}
```

Fields:

```
policy -> (oneof<anytime|weekly-maintenance-window>)
  Oneof policy field
  anytime -> (struct)
    Maintenance operation can be scheduled anytime.
  weekly-maintenance-window -> (struct)
    Maintenance operation can be scheduled on a weekly basis.
    day -> (struct)
      Day of the week (in 'DDD' format).
    hour -> (integer)
      Hour of the day in UTC (in 'HH' format).
``` ||
|| `--name` | `string`

Name of the new ClickHouse cluster. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the network to create the ClickHouse cluster in. ||
|| `--security-group-ids` | `[]string`

User security groups ||
|| `--service-account-id` | `string`

ID of the service account used for access to Object Storage. ||
|| `--shard-specs` | `shorthand/json`

Configuration(s) of the shard(s) in the restored cluster.

Shorthand Syntax:

```hcl
[
  {
    config-spec = {
      clickhouse = {
        config = {
          access-control-improvements = {
            select-from-information-schema-requires-grant = boolean,
            select-from-system-db-requires-grant = boolean
          },
          async-insert-threads = integer,
          asynchronous-insert-log-enabled = boolean,
          asynchronous-insert-log-retention-size = integer,
          asynchronous-insert-log-retention-time = integer,
          asynchronous-metric-log-enabled = boolean,
          asynchronous-metric-log-retention-size = integer,
          asynchronous-metric-log-retention-time = integer,
          background-buffer-flush-schedule-pool-size = integer,
          background-common-pool-size = integer,
          background-distributed-schedule-pool-size = integer,
          background-fetches-pool-size = integer,
          background-merges-mutations-concurrency-ratio = integer,
          background-message-broker-schedule-pool-size = integer,
          background-move-pool-size = integer,
          background-pool-size = integer,
          background-schedule-pool-size = integer,
          backup-threads = integer,
          builtin-dictionaries-reload-interval = integer,
          compression = [
            {
              level = integer,
              method = LZ4|ZSTD|LZ4HC,
              min-part-size = integer,
              min-part-size-ratio = float64
            }, ...
          ],
          custom-macros = [
            {
              name = string,
              value = string
            }, ...
          ],
          default-database = string,
          dictionaries = [
            {
              layout = {
                access-to-key-from-attributes = boolean,
                allow-read-expired-keys = boolean,
                initial-array-size = integer,
                max-array-size = integer,
                max-threads-for-updates = integer,
                max-update-queue-size = integer,
                query-wait-timeout-milliseconds = integer,
                size-in-cells = integer,
                type = FLAT|HASHED|COMPLEX_KEY_HASHED|RANGE_HASHED|CACHE|COMPLEX_KEY_CACHE|SPARSE_HASHED|COMPLEX_KEY_SPARSE_HASHED|COMPLEX_KEY_RANGE_HASHED|DIRECT|COMPLEX_KEY_DIRECT|IP_TRIE,
                update-queue-push-timeout-milliseconds = integer
              },
              lifetime = fixed-lifetime=integer | lifetime-range={
                max = integer,
                min = integer
              },
              name = string,
              source = clickhouse-source={
                db = string,
                host = string,
                password = string,
                port = integer,
                secure = boolean,
                table = string,
                user = string,
                where = string
              } | http-source={
                format = string,
                headers = [
                  {
                    name = string,
                    value = string
                  }, ...
                ],
                url = string
              } | mongodb-source={
                collection = string,
                db = string,
                host = string,
                options = string,
                password = string,
                port = integer,
                user = string
              } | mysql-source={
                close-connection = boolean,
                db = string,
                invalidate-query = string,
                password = string,
                port = integer,
                replicas = [
                  {
                    host = string,
                    password = string,
                    port = integer,
                    priority = integer,
                    user = string
                  }, ...
                ],
                share-connection = boolean,
                table = string,
                user = string,
                where = string
              } | postgresql-source={
                db = string,
                hosts = string,...,
                invalidate-query = string,
                password = string,
                port = integer,
                ssl-mode = DISABLE|ALLOW|PREFER|VERIFY_CA|VERIFY_FULL,
                table = string,
                user = string
              },
              structure = {
                attributes = [
                  {
                    expression = string,
                    hierarchical = boolean,
                    injective = boolean,
                    name = string,
                    null-value = string,
                    type = string
                  }, ...
                ],
                id = {
                  name = string
                },
                key = {
                  attributes = [
                    {
                      expression = string,
                      hierarchical = boolean,
                      injective = boolean,
                      name = string,
                      null-value = string,
                      type = string
                    }, ...
                  ]
                },
                range-max = {
                  expression = string,
                  hierarchical = boolean,
                  injective = boolean,
                  name = string,
                  null-value = string,
                  type = string
                },
                range-min = {
                  expression = string,
                  hierarchical = boolean,
                  injective = boolean,
                  name = string,
                  null-value = string,
                  type = string
                }
              }
            }, ...
          ],
          dictionaries-lazy-load = boolean,
          error-log-enabled = boolean,
          error-log-retention-size = integer,
          error-log-retention-time = integer,
          geobase-enabled = boolean,
          geobase-uri = string,
          graphite-rollup = [
            {
              name = string,
              path-column-name = string,
              patterns = [
                {
                  function = string,
                  regexp = string,
                  retention = [
                    {
                      age = integer,
                      precision = integer
                    }, ...
                  ]
                }, ...
              ],
              time-column-name = string,
              value-column-name = string,
              version-column-name = string
            }, ...
          ],
          jdbc-bridge = {
            host = string,
            port = integer
          },
          kafka = {
            auto-offset-reset = AUTO_OFFSET_RESET_SMALLEST|AUTO_OFFSET_RESET_EARLIEST|AUTO_OFFSET_RESET_BEGINNING|AUTO_OFFSET_RESET_LARGEST|AUTO_OFFSET_RESET_LATEST|AUTO_OFFSET_RESET_END|AUTO_OFFSET_RESET_ERROR,
            batch-size = integer,
            debug = DEBUG_GENERIC|DEBUG_BROKER|DEBUG_TOPIC|DEBUG_METADATA|DEBUG_FEATURE|DEBUG_QUEUE|DEBUG_MSG|DEBUG_PROTOCOL|DEBUG_CGRP|DEBUG_SECURITY|DEBUG_FETCH|DEBUG_INTERCEPTOR|DEBUG_PLUGIN|DEBUG_CONSUMER|DEBUG_ADMIN|DEBUG_EOS|DEBUG_MOCK|DEBUG_ASSIGNOR|DEBUG_CONF|DEBUG_TELEMETRY|DEBUG_ALL,
            enable-ssl-certificate-verification = boolean,
            max-poll-interval-ms = integer,
            message-max-bytes = integer,
            sasl-mechanism = SASL_MECHANISM_GSSAPI|SASL_MECHANISM_PLAIN|SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512,
            sasl-password = string,
            sasl-username = string,
            security-protocol = SECURITY_PROTOCOL_PLAINTEXT|SECURITY_PROTOCOL_SSL|SECURITY_PROTOCOL_SASL_PLAINTEXT|SECURITY_PROTOCOL_SASL_SSL,
            session-timeout-ms = integer
          },
          kafka-topics = [
            {
              name = string,
              settings = {
                auto-offset-reset = AUTO_OFFSET_RESET_SMALLEST|AUTO_OFFSET_RESET_EARLIEST|AUTO_OFFSET_RESET_BEGINNING|AUTO_OFFSET_RESET_LARGEST|AUTO_OFFSET_RESET_LATEST|AUTO_OFFSET_RESET_END|AUTO_OFFSET_RESET_ERROR,
                batch-size = integer,
                debug = DEBUG_GENERIC|DEBUG_BROKER|DEBUG_TOPIC|DEBUG_METADATA|DEBUG_FEATURE|DEBUG_QUEUE|DEBUG_MSG|DEBUG_PROTOCOL|DEBUG_CGRP|DEBUG_SECURITY|DEBUG_FETCH|DEBUG_INTERCEPTOR|DEBUG_PLUGIN|DEBUG_CONSUMER|DEBUG_ADMIN|DEBUG_EOS|DEBUG_MOCK|DEBUG_ASSIGNOR|DEBUG_CONF|DEBUG_TELEMETRY|DEBUG_ALL,
                enable-ssl-certificate-verification = boolean,
                max-poll-interval-ms = integer,
                message-max-bytes = integer,
                sasl-mechanism = SASL_MECHANISM_GSSAPI|SASL_MECHANISM_PLAIN|SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512,
                sasl-password = string,
                sasl-username = string,
                security-protocol = SECURITY_PROTOCOL_PLAINTEXT|SECURITY_PROTOCOL_SSL|SECURITY_PROTOCOL_SASL_PLAINTEXT|SECURITY_PROTOCOL_SASL_SSL,
                session-timeout-ms = integer
              }
            }, ...
          ],
          keep-alive-timeout = integer,
          log-level = TRACE|DEBUG|INFORMATION|WARNING|ERROR,
          mark-cache-size = integer,
          max-build-vector-similarity-index-thread-pool-size = integer,
          max-concurrent-queries = integer,
          max-connections = integer,
          max-partition-size-to-drop = integer,
          max-table-size-to-drop = integer,
          merge-tree = {
            allow-remote-fs-zero-copy-replication = boolean,
            check-sample-column-is-correct = boolean,
            cleanup-delay-period = integer,
            deduplicate-merge-projection-mode = DEDUPLICATE_MERGE_PROJECTION_MODE_IGNORE|DEDUPLICATE_MERGE_PROJECTION_MODE_THROW|DEDUPLICATE_MERGE_PROJECTION_MODE_DROP|DEDUPLICATE_MERGE_PROJECTION_MODE_REBUILD,
            fsync-after-insert = boolean,
            fsync-part-directory = boolean,
            inactive-parts-to-delay-insert = integer,
            inactive-parts-to-throw-insert = integer,
            lightweight-mutation-projection-mode = LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW|LIGHTWEIGHT_MUTATION_PROJECTION_MODE_DROP|LIGHTWEIGHT_MUTATION_PROJECTION_MODE_REBUILD,
            materialize-ttl-recalculate-only = boolean,
            max-avg-part-size-for-too-many-parts = integer,
            max-bytes-to-merge-at-max-space-in-pool = integer,
            max-bytes-to-merge-at-min-space-in-pool = integer,
            max-cleanup-delay-period = integer,
            max-merge-selecting-sleep-ms = integer,
            max-number-of-merges-with-ttl-in-pool = integer,
            max-parts-in-total = integer,
            max-replicated-merges-in-queue = integer,
            merge-max-block-size = integer,
            merge-selecting-sleep-ms = integer,
            merge-with-recompression-ttl-timeout = integer,
            merge-with-ttl-timeout = integer,
            min-age-to-force-merge-on-partition-only = boolean,
            min-age-to-force-merge-seconds = integer,
            min-bytes-for-wide-part = integer,
            min-compressed-bytes-to-fsync-after-fetch = integer,
            min-compressed-bytes-to-fsync-after-merge = integer,
            min-rows-for-wide-part = integer,
            min-rows-to-fsync-after-merge = integer,
            number-of-free-entries-in-pool-to-execute-mutation = integer,
            number-of-free-entries-in-pool-to-lower-max-size-of-merge = integer,
            parts-to-delay-insert = integer,
            parts-to-throw-insert = integer,
            replicated-deduplication-window = integer,
            replicated-deduplication-window-seconds = integer,
            ttl-only-drop-parts = boolean
          },
          metric-log-enabled = boolean,
          metric-log-retention-size = integer,
          metric-log-retention-time = integer,
          mysql-protocol = boolean,
          opentelemetry-span-log-enabled = boolean,
          opentelemetry-span-log-retention-size = integer,
          opentelemetry-span-log-retention-time = integer,
          part-log-retention-size = integer,
          part-log-retention-time = integer,
          processors-profile-log-enabled = boolean,
          processors-profile-log-retention-size = integer,
          processors-profile-log-retention-time = integer,
          query-cache = {
            max-entries = integer,
            max-entry-size-in-bytes = integer,
            max-entry-size-in-rows = integer,
            max-size-in-bytes = integer
          },
          query-log-retention-size = integer,
          query-log-retention-time = integer,
          query-masking-rules = [
            {
              name = string,
              regexp = string,
              replace = string
            }, ...
          ],
          query-metric-log-enabled = boolean,
          query-metric-log-retention-size = integer,
          query-metric-log-retention-time = integer,
          query-thread-log-enabled = boolean,
          query-thread-log-retention-size = integer,
          query-thread-log-retention-time = integer,
          query-views-log-enabled = boolean,
          query-views-log-retention-size = integer,
          query-views-log-retention-time = integer,
          rabbitmq = {
            password = string,
            username = string,
            vhost = string
          },
          restore-threads = integer,
          session-log-enabled = boolean,
          session-log-retention-size = integer,
          session-log-retention-time = integer,
          text-log-enabled = boolean,
          text-log-level = TRACE|DEBUG|INFORMATION|WARNING|ERROR,
          text-log-retention-size = integer,
          text-log-retention-time = integer,
          timezone = string,
          total-memory-profiler-step = integer,
          total-memory-tracker-sample-probability = float64,
          trace-log-enabled = boolean,
          trace-log-retention-size = integer,
          trace-log-retention-time = integer,
          uncompressed-cache-size = integer,
          vector-similarity-index-cache-max-entries = integer,
          vector-similarity-index-cache-size = integer,
          zookeeper-log-enabled = boolean,
          zookeeper-log-retention-size = integer,
          zookeeper-log-retention-time = integer
        },
        disk-size-autoscaling = {
          disk-size-limit = integer,
          emergency-usage-threshold = integer,
          planned-usage-threshold = integer
        },
        resources = {
          disk-size = integer,
          disk-type-id = string,
          resource-preset-id = string
        },
        weight = integer
      }
    },
    name = string,
    shard-group-names = string,...
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "config-spec": {
      "clickhouse": {
        "config": {
          "access-control-improvements": {
            "select-from-information-schema-requires-grant": "boolean",
            "select-from-system-db-requires-grant": "boolean"
          },
          "async-insert-threads": "integer",
          "asynchronous-insert-log-enabled": "boolean",
          "asynchronous-insert-log-retention-size": "integer",
          "asynchronous-insert-log-retention-time": "integer",
          "asynchronous-metric-log-enabled": "boolean",
          "asynchronous-metric-log-retention-size": "integer",
          "asynchronous-metric-log-retention-time": "integer",
          "background-buffer-flush-schedule-pool-size": "integer",
          "background-common-pool-size": "integer",
          "background-distributed-schedule-pool-size": "integer",
          "background-fetches-pool-size": "integer",
          "background-merges-mutations-concurrency-ratio": "integer",
          "background-message-broker-schedule-pool-size": "integer",
          "background-move-pool-size": "integer",
          "background-pool-size": "integer",
          "background-schedule-pool-size": "integer",
          "backup-threads": "integer",
          "builtin-dictionaries-reload-interval": "integer",
          "compression": [
            {
              "level": "integer",
              "method": "LZ4|ZSTD|LZ4HC",
              "min-part-size": "integer",
              "min-part-size-ratio": "float64"
            }, ...
          ],
          "custom-macros": [
            {
              "name": "string",
              "value": "string"
            }, ...
          ],
          "default-database": "string",
          "dictionaries": [
            {
              "layout": {
                "access-to-key-from-attributes": "boolean",
                "allow-read-expired-keys": "boolean",
                "initial-array-size": "integer",
                "max-array-size": "integer",
                "max-threads-for-updates": "integer",
                "max-update-queue-size": "integer",
                "query-wait-timeout-milliseconds": "integer",
                "size-in-cells": "integer",
                "type": "FLAT|HASHED|COMPLEX_KEY_HASHED|RANGE_HASHED|CACHE|COMPLEX_KEY_CACHE|SPARSE_HASHED|COMPLEX_KEY_SPARSE_HASHED|COMPLEX_KEY_RANGE_HASHED|DIRECT|COMPLEX_KEY_DIRECT|IP_TRIE",
                "update-queue-push-timeout-milliseconds": "integer"
              },
              "lifetime": {
                "fixed-lifetime": "integer",
                "lifetime-range": {
                  "max": "integer",
                  "min": "integer"
                }
              },
              "name": "string",
              "source": {
                "clickhouse-source": {
                  "db": "string",
                  "host": "string",
                  "password": "string",
                  "port": "integer",
                  "secure": "boolean",
                  "table": "string",
                  "user": "string",
                  "where": "string"
                },
                "http-source": {
                  "format": "string",
                  "headers": [
                    {
                      "name": "string",
                      "value": "string"
                    }, ...
                  ],
                  "url": "string"
                },
                "mongodb-source": {
                  "collection": "string",
                  "db": "string",
                  "host": "string",
                  "options": "string",
                  "password": "string",
                  "port": "integer",
                  "user": "string"
                },
                "mysql-source": {
                  "close-connection": "boolean",
                  "db": "string",
                  "invalidate-query": "string",
                  "password": "string",
                  "port": "integer",
                  "replicas": [
                    {
                      "host": "string",
                      "password": "string",
                      "port": "integer",
                      "priority": "integer",
                      "user": "string"
                    }, ...
                  ],
                  "share-connection": "boolean",
                  "table": "string",
                  "user": "string",
                  "where": "string"
                },
                "postgresql-source": {
                  "db": "string",
                  "hosts": [
                    "string", ...
                  ],
                  "invalidate-query": "string",
                  "password": "string",
                  "port": "integer",
                  "ssl-mode": "DISABLE|ALLOW|PREFER|VERIFY_CA|VERIFY_FULL",
                  "table": "string",
                  "user": "string"
                }
              },
              "structure": {
                "attributes": [
                  {
                    "expression": "string",
                    "hierarchical": "boolean",
                    "injective": "boolean",
                    "name": "string",
                    "null-value": "string",
                    "type": "string"
                  }, ...
                ],
                "id": {
                  "name": "string"
                },
                "key": {
                  "attributes": [
                    {
                      "expression": "string",
                      "hierarchical": "boolean",
                      "injective": "boolean",
                      "name": "string",
                      "null-value": "string",
                      "type": "string"
                    }, ...
                  ]
                },
                "range-max": {
                  "expression": "string",
                  "hierarchical": "boolean",
                  "injective": "boolean",
                  "name": "string",
                  "null-value": "string",
                  "type": "string"
                },
                "range-min": {
                  "expression": "string",
                  "hierarchical": "boolean",
                  "injective": "boolean",
                  "name": "string",
                  "null-value": "string",
                  "type": "string"
                }
              }
            }, ...
          ],
          "dictionaries-lazy-load": "boolean",
          "error-log-enabled": "boolean",
          "error-log-retention-size": "integer",
          "error-log-retention-time": "integer",
          "geobase-enabled": "boolean",
          "geobase-uri": "string",
          "graphite-rollup": [
            {
              "name": "string",
              "path-column-name": "string",
              "patterns": [
                {
                  "function": "string",
                  "regexp": "string",
                  "retention": [
                    {
                      "age": "integer",
                      "precision": "integer"
                    }, ...
                  ]
                }, ...
              ],
              "time-column-name": "string",
              "value-column-name": "string",
              "version-column-name": "string"
            }, ...
          ],
          "jdbc-bridge": {
            "host": "string",
            "port": "integer"
          },
          "kafka": {
            "auto-offset-reset": "AUTO_OFFSET_RESET_SMALLEST|AUTO_OFFSET_RESET_EARLIEST|AUTO_OFFSET_RESET_BEGINNING|AUTO_OFFSET_RESET_LARGEST|AUTO_OFFSET_RESET_LATEST|AUTO_OFFSET_RESET_END|AUTO_OFFSET_RESET_ERROR",
            "batch-size": "integer",
            "debug": "DEBUG_GENERIC|DEBUG_BROKER|DEBUG_TOPIC|DEBUG_METADATA|DEBUG_FEATURE|DEBUG_QUEUE|DEBUG_MSG|DEBUG_PROTOCOL|DEBUG_CGRP|DEBUG_SECURITY|DEBUG_FETCH|DEBUG_INTERCEPTOR|DEBUG_PLUGIN|DEBUG_CONSUMER|DEBUG_ADMIN|DEBUG_EOS|DEBUG_MOCK|DEBUG_ASSIGNOR|DEBUG_CONF|DEBUG_TELEMETRY|DEBUG_ALL",
            "enable-ssl-certificate-verification": "boolean",
            "max-poll-interval-ms": "integer",
            "message-max-bytes": "integer",
            "sasl-mechanism": "SASL_MECHANISM_GSSAPI|SASL_MECHANISM_PLAIN|SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512",
            "sasl-password": "string",
            "sasl-username": "string",
            "security-protocol": "SECURITY_PROTOCOL_PLAINTEXT|SECURITY_PROTOCOL_SSL|SECURITY_PROTOCOL_SASL_PLAINTEXT|SECURITY_PROTOCOL_SASL_SSL",
            "session-timeout-ms": "integer"
          },
          "kafka-topics": [
            {
              "name": "string",
              "settings": {
                "auto-offset-reset": "AUTO_OFFSET_RESET_SMALLEST|AUTO_OFFSET_RESET_EARLIEST|AUTO_OFFSET_RESET_BEGINNING|AUTO_OFFSET_RESET_LARGEST|AUTO_OFFSET_RESET_LATEST|AUTO_OFFSET_RESET_END|AUTO_OFFSET_RESET_ERROR",
                "batch-size": "integer",
                "debug": "DEBUG_GENERIC|DEBUG_BROKER|DEBUG_TOPIC|DEBUG_METADATA|DEBUG_FEATURE|DEBUG_QUEUE|DEBUG_MSG|DEBUG_PROTOCOL|DEBUG_CGRP|DEBUG_SECURITY|DEBUG_FETCH|DEBUG_INTERCEPTOR|DEBUG_PLUGIN|DEBUG_CONSUMER|DEBUG_ADMIN|DEBUG_EOS|DEBUG_MOCK|DEBUG_ASSIGNOR|DEBUG_CONF|DEBUG_TELEMETRY|DEBUG_ALL",
                "enable-ssl-certificate-verification": "boolean",
                "max-poll-interval-ms": "integer",
                "message-max-bytes": "integer",
                "sasl-mechanism": "SASL_MECHANISM_GSSAPI|SASL_MECHANISM_PLAIN|SASL_MECHANISM_SCRAM_SHA_256|SASL_MECHANISM_SCRAM_SHA_512",
                "sasl-password": "string",
                "sasl-username": "string",
                "security-protocol": "SECURITY_PROTOCOL_PLAINTEXT|SECURITY_PROTOCOL_SSL|SECURITY_PROTOCOL_SASL_PLAINTEXT|SECURITY_PROTOCOL_SASL_SSL",
                "session-timeout-ms": "integer"
              }
            }, ...
          ],
          "keep-alive-timeout": "integer",
          "log-level": "TRACE|DEBUG|INFORMATION|WARNING|ERROR",
          "mark-cache-size": "integer",
          "max-build-vector-similarity-index-thread-pool-size": "integer",
          "max-concurrent-queries": "integer",
          "max-connections": "integer",
          "max-partition-size-to-drop": "integer",
          "max-table-size-to-drop": "integer",
          "merge-tree": {
            "allow-remote-fs-zero-copy-replication": "boolean",
            "check-sample-column-is-correct": "boolean",
            "cleanup-delay-period": "integer",
            "deduplicate-merge-projection-mode": "DEDUPLICATE_MERGE_PROJECTION_MODE_IGNORE|DEDUPLICATE_MERGE_PROJECTION_MODE_THROW|DEDUPLICATE_MERGE_PROJECTION_MODE_DROP|DEDUPLICATE_MERGE_PROJECTION_MODE_REBUILD",
            "fsync-after-insert": "boolean",
            "fsync-part-directory": "boolean",
            "inactive-parts-to-delay-insert": "integer",
            "inactive-parts-to-throw-insert": "integer",
            "lightweight-mutation-projection-mode": "LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW|LIGHTWEIGHT_MUTATION_PROJECTION_MODE_DROP|LIGHTWEIGHT_MUTATION_PROJECTION_MODE_REBUILD",
            "materialize-ttl-recalculate-only": "boolean",
            "max-avg-part-size-for-too-many-parts": "integer",
            "max-bytes-to-merge-at-max-space-in-pool": "integer",
            "max-bytes-to-merge-at-min-space-in-pool": "integer",
            "max-cleanup-delay-period": "integer",
            "max-merge-selecting-sleep-ms": "integer",
            "max-number-of-merges-with-ttl-in-pool": "integer",
            "max-parts-in-total": "integer",
            "max-replicated-merges-in-queue": "integer",
            "merge-max-block-size": "integer",
            "merge-selecting-sleep-ms": "integer",
            "merge-with-recompression-ttl-timeout": "integer",
            "merge-with-ttl-timeout": "integer",
            "min-age-to-force-merge-on-partition-only": "boolean",
            "min-age-to-force-merge-seconds": "integer",
            "min-bytes-for-wide-part": "integer",
            "min-compressed-bytes-to-fsync-after-fetch": "integer",
            "min-compressed-bytes-to-fsync-after-merge": "integer",
            "min-rows-for-wide-part": "integer",
            "min-rows-to-fsync-after-merge": "integer",
            "number-of-free-entries-in-pool-to-execute-mutation": "integer",
            "number-of-free-entries-in-pool-to-lower-max-size-of-merge": "integer",
            "parts-to-delay-insert": "integer",
            "parts-to-throw-insert": "integer",
            "replicated-deduplication-window": "integer",
            "replicated-deduplication-window-seconds": "integer",
            "ttl-only-drop-parts": "boolean"
          },
          "metric-log-enabled": "boolean",
          "metric-log-retention-size": "integer",
          "metric-log-retention-time": "integer",
          "mysql-protocol": "boolean",
          "opentelemetry-span-log-enabled": "boolean",
          "opentelemetry-span-log-retention-size": "integer",
          "opentelemetry-span-log-retention-time": "integer",
          "part-log-retention-size": "integer",
          "part-log-retention-time": "integer",
          "processors-profile-log-enabled": "boolean",
          "processors-profile-log-retention-size": "integer",
          "processors-profile-log-retention-time": "integer",
          "query-cache": {
            "max-entries": "integer",
            "max-entry-size-in-bytes": "integer",
            "max-entry-size-in-rows": "integer",
            "max-size-in-bytes": "integer"
          },
          "query-log-retention-size": "integer",
          "query-log-retention-time": "integer",
          "query-masking-rules": [
            {
              "name": "string",
              "regexp": "string",
              "replace": "string"
            }, ...
          ],
          "query-metric-log-enabled": "boolean",
          "query-metric-log-retention-size": "integer",
          "query-metric-log-retention-time": "integer",
          "query-thread-log-enabled": "boolean",
          "query-thread-log-retention-size": "integer",
          "query-thread-log-retention-time": "integer",
          "query-views-log-enabled": "boolean",
          "query-views-log-retention-size": "integer",
          "query-views-log-retention-time": "integer",
          "rabbitmq": {
            "password": "string",
            "username": "string",
            "vhost": "string"
          },
          "restore-threads": "integer",
          "session-log-enabled": "boolean",
          "session-log-retention-size": "integer",
          "session-log-retention-time": "integer",
          "text-log-enabled": "boolean",
          "text-log-level": "TRACE|DEBUG|INFORMATION|WARNING|ERROR",
          "text-log-retention-size": "integer",
          "text-log-retention-time": "integer",
          "timezone": "string",
          "total-memory-profiler-step": "integer",
          "total-memory-tracker-sample-probability": "float64",
          "trace-log-enabled": "boolean",
          "trace-log-retention-size": "integer",
          "trace-log-retention-time": "integer",
          "uncompressed-cache-size": "integer",
          "vector-similarity-index-cache-max-entries": "integer",
          "vector-similarity-index-cache-size": "integer",
          "zookeeper-log-enabled": "boolean",
          "zookeeper-log-retention-size": "integer",
          "zookeeper-log-retention-time": "integer"
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        },
        "weight": "integer"
      }
    },
    "name": "string",
    "shard-group-names": [
      "string", ...
    ]
  }, ...
]
```

Fields:

```
config-spec -> (struct)
  Configuration of the shard to be created.
  clickhouse -> (struct)
    ClickHouse configuration for a shard.
    config -> (struct)
      ClickHouse settings for the shard.
      access-control-improvements -> (struct)
        Access control settings.
        select-from-information-schema-requires-grant -> (boolean)
          Sets whether **SELECT * FROM information_schema.<table>** requires any grants and can be executed by any user. If set to true, then this query requires **GRANT SELECT ON information_schema.<table>**, just as for ordinary tables. Default value: **false**.
        select-from-system-db-requires-grant -> (boolean)
          Sets whether **SELECT * FROM system.<table>** requires any grants and can be executed by any user. If set to true then this query requires **GRANT SELECT ON system.<table>** just as for non-system tables. Default value: **false**.
      async-insert-threads -> (integer)
        Maximum number of threads to parse and insert data in background. If set to **0**, asynchronous mode is disabled. Default value: **16**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      asynchronous-insert-log-enabled -> (boolean)
        Enables or disables asynchronous_insert_log system table. Default value: **false**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      asynchronous-insert-log-retention-size -> (integer)
        The maximum size that asynchronous_insert_log can grow to before old data will be removed. If set to **0**, automatic removal of asynchronous_insert_log data based on size is disabled. Default value: **0**.
      asynchronous-insert-log-retention-time -> (integer)
        The maximum time that asynchronous_insert_log records will be retained before removal. If set to **0**, automatic removal of asynchronous_insert_log data based on time is disabled. Default value: **2592000000** (30 days).
      asynchronous-metric-log-enabled -> (boolean)
        Enables or disables asynchronous_metric_log system table. Default value: **false**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      asynchronous-metric-log-retention-size -> (integer)
        The maximum size that asynchronous_metric_log can grow to before old data will be removed. If set to **0**, automatic removal of asynchronous_metric_log data based on size is disabled. Default value: **0**.
      asynchronous-metric-log-retention-time -> (integer)
        The maximum time that asynchronous_metric_log records will be retained before removal. If set to **0**, automatic removal of asynchronous_metric_log data based on time is disabled. Default value: **2592000000** (30 days).
      background-buffer-flush-schedule-pool-size -> (integer)
        The maximum number of threads that will be used for performing flush operations for Buffer-engine tables in the background. Default value: **16**. Change of the setting is applied with restart on value decrease and without restart on value increase. For details, see ClickHouse documentation.
      background-common-pool-size -> (integer)
        The maximum number of threads that will be used for performing a variety of operations (mostly garbage collection) for MergeTree-engine tables in a background. Default value: **8**. Change of the setting is applied with restart on value decrease and without restart on value increase. For details, see ClickHouse documentation.
      background-distributed-schedule-pool-size -> (integer)
        The maximum number of threads that will be used for executing distributed sends. Default value: **16**. Change of the setting is applied with restart on value decrease and without restart on value increase. For details, see ClickHouse documentation.
      background-fetches-pool-size -> (integer)
        The maximum number of threads that will be used for fetching data parts from another replica for MergeTree-engine tables in a background. Default value: **32** for versions 25.1 and higher, **16** for versions 24.12 and lower. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      background-merges-mutations-concurrency-ratio -> (integer)
        Sets a ratio between the number of threads and the number of background merges and mutations that can be executed concurrently. For example, if the ratio equals to **2** and **background_pool_size** is set to **16** then ClickHouse can execute **32** background merges concurrently. This is possible, because background operations could be suspended and postponed. This is needed to give small merges more execution priority. Default value: **2**. Change of the setting is applied with restart on value decrease and without restart on value increase. For details, see ClickHouse documentation.
      background-message-broker-schedule-pool-size -> (integer)
        The maximum number of threads that will be used for executing background operations for message streaming. Default value: **16**. Change of the setting is applied with restart on value decrease and without restart on value increase. For details, see ClickHouse documentation.
      background-move-pool-size -> (integer)
        The maximum number of threads that will be used for moving data parts to another disk or volume for MergeTree-engine tables in a background. Default value: **8**. Change of the setting is applied with restart on value decrease and without restart on value increase. For details, see ClickHouse documentation.
      background-pool-size -> (integer)
        Sets the number of threads performing background merges and mutations for MergeTree-engine tables. Default value: **16**. Change of the setting is applied with restart on value decrease and without restart on value increase. For details, see ClickHouse documentation.
      background-schedule-pool-size -> (integer)
        The maximum number of threads that will be used for constantly executing some lightweight periodic operations for replicated tables, Kafka streaming, and DNS cache updates. Default value: **512**. Change of the setting is applied with restart on value decrease and without restart on value increase. For details, see ClickHouse documentation.
      backup-threads -> (integer)
        The maximum number of threads to execute **BACKUP** requests. Default value: **16**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      builtin-dictionaries-reload-interval -> (integer)
        The interval in seconds before reloading built-in dictionaries. Default value: **3600**. For details, see ClickHouse documentation.
      compression -> ([]struct)
        Data compression settings for MergeTree engine tables. Change of the settings of **compression** is applied with restart. For details, see ClickHouse documentation.
        level -> (integer)
          Compression level.
        method -> (struct)
          Compression method to use for the specified combination of **min_part_size** and **min_part_size_ratio**.
        min-part-size -> (integer)
          The minimum size of a data part.
        min-part-size-ratio -> (float64)
          The ratio of the data part size to the table size.
      custom-macros -> ([]struct)
        Custom ClickHouse macros.
        name -> (string)
          Name of the macro.
        value -> (string)
          Value of the macro.
      default-database -> (string)
        The default database. Default value: **default**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      dictionaries -> ([]struct)
        Configuration of external dictionaries. Change of the settings of **dictionaries** is applied with restart. For details, see ClickHouse documentation.
        layout -> (struct)
          Layout determining how to store the dictionary in memory. For details, see https://clickhouse.com/docs/sql-reference/dictionaries#ways-to-store-dictionaries-in-memory.
          access-to-key-from-attributes -> (boolean)
            Allows to retrieve key attribute using **dictGetString** function. Enabling this option increases memory usage. Applicable only for **IP_TRIE** layout type. For details, see ClickHouse documentation.
          allow-read-expired-keys -> (boolean)
            Allows to read expired keys. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **false**. For details, see ClickHouse documentation.
          initial-array-size -> (integer)
            Initial dictionary key size. Applicable only for **FLAT** layout type. Default value: **1024**. For details, see ClickHouse documentation.
          max-array-size -> (integer)
            Maximum dictionary key size. Applicable only for **FLAT** layout type. Default value: **500000**. For details, see ClickHouse documentation.
          max-threads-for-updates -> (integer)
            Max threads for cache dictionary update. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **4**. For details, see ClickHouse documentation.
          max-update-queue-size -> (integer)
            Max size of update queue. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **100000**. For details, see ClickHouse documentation.
          query-wait-timeout-milliseconds -> (integer)
            Max wait timeout in milliseconds for update task to complete. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **60000** (1 minute). For details, see ClickHouse documentation.
          size-in-cells -> (integer)
            Number of cells in the cache. Rounded up to a power of two. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **1000000000**. For details, see ClickHouse documentation.
          type -> (struct)
            Layout type. For details, see ClickHouse documentation.
          update-queue-push-timeout-milliseconds -> (integer)
            Max timeout in milliseconds for push update task into queue. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **10**. For details, see ClickHouse documentation.
        name -> (string)
          Name of the external dictionary.
        structure -> (struct)
          Structure of the external dictionary.
          attributes -> ([]struct)
            Description of the fields available for database queries. For details, see ClickHouse documentation.
            expression -> (string)
              Expression, describing the attribute, if applicable.
            hierarchical -> (boolean)
              Indication of hierarchy support. Default value: **false**.
            injective -> (boolean)
              Indication of injective mapping "id -> attribute". Default value: **false**.
            name -> (string)
              Name of the column.
            null-value -> (string)
              Default value for an element without data (for example, an empty string).
            type -> (string)
              Type of the column.
          id -> (struct)
            Single numeric key column for the dictionary.
            name -> (string)
              Name of the numeric key.
          key -> (struct)
            Composite key for the dictionary, containing of one or more key columns. For details, see ClickHouse documentation.
            attributes -> ([]struct)
              Attributes of a complex key.
              expression -> (string)
                Expression, describing the attribute, if applicable.
              hierarchical -> (boolean)
                Indication of hierarchy support. Default value: **false**.
              injective -> (boolean)
                Indication of injective mapping "id -> attribute". Default value: **false**.
              name -> (string)
                Name of the column.
              null-value -> (string)
                Default value for an element without data (for example, an empty string).
              type -> (string)
                Type of the column.
          range-max -> (struct)
            Field holding the end of the range for dictionaries with **RANGE_HASHED** layout. For details, see ClickHouse documentation.
            expression -> (string)
              Expression, describing the attribute, if applicable.
            hierarchical -> (boolean)
              Indication of hierarchy support. Default value: **false**.
            injective -> (boolean)
              Indication of injective mapping "id -> attribute". Default value: **false**.
            name -> (string)
              Name of the column.
            null-value -> (string)
              Default value for an element without data (for example, an empty string).
            type -> (string)
              Type of the column.
          range-min -> (struct)
            Field holding the beginning of the range for dictionaries with **RANGE_HASHED** layout. For details, see ClickHouse documentation.
            expression -> (string)
              Expression, describing the attribute, if applicable.
            hierarchical -> (boolean)
              Indication of hierarchy support. Default value: **false**.
            injective -> (boolean)
              Indication of injective mapping "id -> attribute". Default value: **false**.
            name -> (string)
              Name of the column.
            null-value -> (string)
              Default value for an element without data (for example, an empty string).
            type -> (string)
              Type of the column.
        lifetime -> (oneof<fixed-lifetime|lifetime-range>)
          Oneof lifetime field
          fixed-lifetime -> (integer)
            Fixed interval between dictionary updates.
          lifetime-range -> (struct)
            Range of intervals between dictionary updates for ClickHouse to choose from.
            max -> (integer)
              Maximum dictionary lifetime.
            min -> (integer)
              Minimum dictionary lifetime.
        source -> (oneof<clickhouse-source|http-source|mongodb-source|mysql-source|postgresql-source>)
          Oneof source field
          http-source -> (struct)
            HTTP source for the dictionary.
            format -> (string)
              The data format. Valid values are all formats supported by ClickHouse SQL dialect.
            headers -> ([]struct)
              HTTP headers.
              name -> (string)
                Header name.
              value -> (string)
                Header value.
            url -> (string)
              URL of the source dictionary available over HTTP.
          mysql-source -> (struct)
            MySQL source for the dictionary.
            close-connection -> (boolean)
              Should a connection be closed after each request.
            db -> (string)
              Database name.
            invalidate-query -> (string)
              Query for checking the dictionary status, to pull only updated data.
            password -> (string)
              Password of the user for replicas of the dictionary source.
            port -> (integer)
              Port to use when connecting to a replica of the dictionary source.
            replicas -> ([]struct)
              List of MySQL replicas of the database used as dictionary source.
              host -> (string)
                MySQL host of the replica.
              password -> (string)
                Password of the MySQL database user. If a password is not specified for a replica, ClickHouse uses the password specified for the source.
              port -> (integer)
                Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source.
              priority -> (integer)
                The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number.
              user -> (string)
                Name of the MySQL database user. If a user is not specified for a replica, ClickHouse uses the user specified for the source.
            share-connection -> (boolean)
              Should a connection be shared for some requests.
            table -> (string)
              Table name.
            user -> (string)
              Name of the user for replicas of the dictionary source.
            where -> (string)
              Selection criteria for the data in the specified MySQL table.
          clickhouse-source -> (struct)
            ClickHouse source for the dictionary.
            db -> (string)
              Database name.
            host -> (string)
              ClickHouse host.
            password -> (string)
              Password of the ClickHouse database user.
            port -> (integer)
              Port to use when connecting to the host.
            secure -> (boolean)
              Determines whether to use TLS for connection.
            table -> (string)
              Table name.
            user -> (string)
              Name of the ClickHouse database user.
            where -> (string)
              Selection criteria for the data in the specified ClickHouse table.
          mongodb-source -> (struct)
            MongoDB source for the dictionary.
            collection -> (string)
              Collection name.
            db -> (string)
              Database name.
            host -> (string)
              MongoDB host.
            options -> (string)
              Dictionary source options.
            password -> (string)
              Password of the MongoDB database user.
            port -> (integer)
              Port to use when connecting to the host.
            user -> (string)
              Name of the MongoDB database user.
          postgresql-source -> (struct)
            PostgreSQL source for the dictionary.
            db -> (string)
              Database name.
            hosts -> ([]string)
              PostgreSQL hosts.
            invalidate-query -> (string)
              Query for checking the dictionary status, to pull only updated data.
            password -> (string)
              Password of the PostrgreSQL database user.
            port -> (integer)
              Port to use when connecting to the PostgreSQL hosts.
            ssl-mode -> (struct)
              Mode of SSL TCP/IP connection to the PostgreSQL host.
            table -> (string)
              Table name.
            user -> (string)
              Name of the PostrgreSQL database user.
      dictionaries-lazy-load -> (boolean)
        Lazy loading of dictionaries. If enabled, then each dictionary is loaded on the first use. Otherwise, the server loads all dictionaries at startup. Default value: **true** for versions 25.1 and higher, **false** for versions 24.12 and lower. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      error-log-enabled -> (boolean)
        Enables or disables error_log system table. Default value: **false**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      error-log-retention-size -> (integer)
        The maximum size that error_log can grow to before old data will be removed. If set to **0**, automatic removal of error_log data based on size is disabled. Default value: **0**.
      error-log-retention-time -> (integer)
        The maximum time that error_log records will be retained before removal. If set to **0**, automatic removal of error_log data based on time is disabled. Default value: **2592000000** (30 days).
      geobase-enabled -> (boolean)
        Enables or disables geobase. Default value: **false** for versions 25.8 and higher, **true** for versions 25.7 and lower. Change of the setting is applied with restart.
      geobase-uri -> (string)
        Address of the archive with the user geobase in Object Storage. Change of the setting is applied with restart.
      graphite-rollup -> ([]struct)
        Rollup settings for the GraphiteMergeTree engine tables. Change of the settings of **graphite_rollup** is applied with restart. For details, see ClickHouse documentation.
        name -> (string)
          Name for the specified combination of settings for Graphite rollup.
        path-column-name -> (string)
          The name of the column storing the metric name (Graphite sensor). Default value: **Path**.
        patterns -> ([]struct)
          Pattern to use for the rollup.
          function -> (string)
            The name of the aggregating function to apply to data whose age falls within the range [age, age + precision]. Accepted functions: **min**, **max**, **any**, **avg**. The average is calculated imprecisely, like the average of the averages.
          regexp -> (string)
            A pattern for the metric name (a regular or DSL).
          retention -> ([]struct)
            Retention rules.
            age -> (integer)
              The minimum age of the data in seconds.
            precision -> (integer)
              Precision of determining the age of the data, in seconds. Should be a divisor for 86400 (seconds in a day).
        time-column-name -> (string)
          The name of the column storing the time of measuring the metric. Default value: **Time**.
        value-column-name -> (string)
          The name of the column storing the value of the metric at the time set in **time_column_name**. Default value: **Value**.
        version-column-name -> (string)
          The name of the column storing the version of the metric. Default value: **Timestamp**.
      jdbc-bridge -> (struct)
        JDBC bridge configuration for queries to external databases. Change of the settings of **jdbc_bridge** is applied with restart. For details, see ClickHouse documentation.
        host -> (string)
          Host of jdbc bridge.
        port -> (integer)
          Port of jdbc bridge. Default value: **9019**.
      kafka -> (struct)
        Kafka integration settings. Change of the settings of **kafka** is applied with restart.
        auto-offset-reset -> (struct)
          Action to take when there is no initial offset in offset store or the desired offset is out of range. Default value: **AUTO_OFFSET_RESET_LARGEST**.
        batch-size -> (integer)
          Maximum size (in bytes) of all messages batched in one MessageSet, including protocol framing overhead. Default value: **1000000**.
        debug -> (struct)
          Debug context to enable.
        enable-ssl-certificate-verification -> (boolean)
          Enable OpenSSL's builtin broker (server) certificate verification. Default value: **true**.
        max-poll-interval-ms -> (integer)
          Maximum allowed time between calls to consume messages for high-level consumers. If this interval is exceeded the consumer is considered failed and the group will rebalance in order to reassign the partitions to another consumer group member. Default value: **300000** (5 minutes).
        message-max-bytes -> (integer)
          Maximum Kafka protocol request message size. Default value: **1000000**.
        sasl-mechanism -> (struct)
          SASL mechanism to use for authentication. Default value: **SASL_MECHANISM_GSSAPI**.
        sasl-password -> (string)
          SASL password for use with the PLAIN and SASL-SCRAM mechanisms.
        sasl-username -> (string)
          SASL username for use with the PLAIN and SASL-SCRAM mechanisms.
        security-protocol -> (struct)
          Protocol used to communicate with brokers. Default value: **SECURITY_PROTOCOL_PLAINTEXT**.
        session-timeout-ms -> (integer)
          Client group session and failure detection timeout. The consumer sends periodic heartbeats (heartbeat.interval.ms) to indicate its liveness to the broker. If no hearts are received by the broker for a group member within the session timeout, the broker will remove the consumer from the group and trigger a rebalance. Default value: **45000** (45 seconds).
      kafka-topics -> ([]struct)
        Per-topic Kafka integration settings. Change of the settings of **kafka_topics** is applied with restart.
        name -> (string)
          Kafka topic name.
        settings -> (struct)
          Kafka topic settings.
          auto-offset-reset -> (struct)
            Action to take when there is no initial offset in offset store or the desired offset is out of range. Default value: **AUTO_OFFSET_RESET_LARGEST**.
          batch-size -> (integer)
            Maximum size (in bytes) of all messages batched in one MessageSet, including protocol framing overhead. Default value: **1000000**.
          debug -> (struct)
            Debug context to enable.
          enable-ssl-certificate-verification -> (boolean)
            Enable OpenSSL's builtin broker (server) certificate verification. Default value: **true**.
          max-poll-interval-ms -> (integer)
            Maximum allowed time between calls to consume messages for high-level consumers. If this interval is exceeded the consumer is considered failed and the group will rebalance in order to reassign the partitions to another consumer group member. Default value: **300000** (5 minutes).
          message-max-bytes -> (integer)
            Maximum Kafka protocol request message size. Default value: **1000000**.
          sasl-mechanism -> (struct)
            SASL mechanism to use for authentication. Default value: **SASL_MECHANISM_GSSAPI**.
          sasl-password -> (string)
            SASL password for use with the PLAIN and SASL-SCRAM mechanisms.
          sasl-username -> (string)
            SASL username for use with the PLAIN and SASL-SCRAM mechanisms.
          security-protocol -> (struct)
            Protocol used to communicate with brokers. Default value: **SECURITY_PROTOCOL_PLAINTEXT**.
          session-timeout-ms -> (integer)
            Client group session and failure detection timeout. The consumer sends periodic heartbeats (heartbeat.interval.ms) to indicate its liveness to the broker. If no hearts are received by the broker for a group member within the session timeout, the broker will remove the consumer from the group and trigger a rebalance. Default value: **45000** (45 seconds).
      keep-alive-timeout -> (integer)
        The number of seconds that ClickHouse waits for incoming requests for HTTP protocol before closing the connection. Default value: **3** for versions 25.10 and higher, **30** for versions 25.9 and lower. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      log-level -> (struct)
        Logging level.
      mark-cache-size -> (integer)
        Maximum size (in bytes) of the cache of "marks" used by MergeTree tables. For details, see ClickHouse documentation.
      max-build-vector-similarity-index-thread-pool-size -> (integer)
        The maximum number of threads to use for building vector indexes. **0** means unlimited. Default value: **16**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      max-concurrent-queries -> (integer)
        Maximum number of concurrently executed queries. Default value: **500**. For details, see ClickHouse documentation.
      max-connections -> (integer)
        Maximum number of inbound connections. Default value: **4096**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      max-partition-size-to-drop -> (integer)
        Maximum size of the partition that can be deleted using **DROP** or **TRUNCATE** query. Default value: **50000000000** (48828125 KiB). For details, see ClickHouse documentation.
      max-table-size-to-drop -> (integer)
        Maximum size of the table that can be deleted using **DROP** or **TRUNCATE** query. Default value: **50000000000** (48828125 KiB). For details, see ClickHouse documentation.
      merge-tree -> (struct)
        Settings for the MergeTree table engine family. Change of the settings of **merge_tree** is applied with restart.
        allow-remote-fs-zero-copy-replication -> (boolean)
          Setting is automatically enabled if cloud storage is enabled, disabled otherwise. Default value: **true**.
        check-sample-column-is-correct -> (boolean)
          Enables the check at table creation, that the data type of a column for sampling or sampling expression is correct. The data type must be one of unsigned integer types: UInt8, UInt16, UInt32, UInt64. Default value: **true**. For details, see ClickHouse documentation.
        cleanup-delay-period -> (integer)
          Minimum period to clean old queue logs, blocks hashes and parts. Default value: **30**. For details, see ClickHouse documentation.
        deduplicate-merge-projection-mode -> (struct)
          Determines the behavior of background merges for MergeTree tables with projections. Default value: **DEDUPLICATE_MERGE_PROJECTION_MODE_THROW**. For details, see ClickHouse documentation.
        fsync-after-insert -> (boolean)
          Do fsync for every inserted part. Significantly decreases performance of inserts, not recommended to use with wide parts. Default value: **false**. For details, see ClickHouse documentation.
        fsync-part-directory -> (boolean)
          Do fsync for part directory after all part operations (writes, renames, etc.). Default value: **false**. For details, see ClickHouse documentation.
        inactive-parts-to-delay-insert -> (integer)
          If the number of inactive parts in a single partition in the table exceeds the **inactive_parts_to_delay_insert** value, an **INSERT** is artificially slowed down. Default value: **0**. For details, see ClickHouse documentation.
        inactive-parts-to-throw-insert -> (integer)
          If the number of inactive parts in a single partition more than the **inactive_parts_to_throw_insert** value, **INSERT** is interrupted with an error. Default value: **0**. For details, see ClickHouse documentation.
        lightweight-mutation-projection-mode -> (struct)
          Determines the behavior of lightweight deletes for MergeTree tables with projections. Default value: **LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW**. For details, see ClickHouse documentation.
        materialize-ttl-recalculate-only -> (boolean)
          Only recalculate ttl info when **MATERIALIZE TTL**. Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower. For details, see ClickHouse documentation.
        max-avg-part-size-for-too-many-parts -> (integer)
          The "Too many parts" check according to **parts_to_delay_insert** and **parts_to_throw_insert** will be active only if the average part size (in the relevant partition) is not larger than the specified threshold. If it is larger than the specified threshold, **INSERT** queries will be neither delayed or rejected. This allows to have hundreds of terabytes in a single table on a single server if the parts are successfully merged to larger parts. This does not affect the thresholds on inactive parts or total parts. Default value: **1073741824** (1 GiB). For details, see ClickHouse documentation.
        max-bytes-to-merge-at-max-space-in-pool -> (integer)
          The maximum total parts size (in bytes) to be merged into one part, if there are enough resources available. Corresponds roughly to the maximum possible part size created by an automatic background merge. **0** means merges will be disabled. Default value: **161061273600** (150 GiB). For details, see ClickHouse documentation.
        max-bytes-to-merge-at-min-space-in-pool -> (integer)
          The maximum total part size (in bytes) to be merged into one part, with the minimum available resources in the background pool. Default value: **1048576** (1 MiB). For details, see ClickHouse documentation.
        max-cleanup-delay-period -> (integer)
          Maximum period to clean old queue logs, blocks hashes and parts. Default value: **300** (5 minutes). For details, see ClickHouse documentation.
        max-merge-selecting-sleep-ms -> (integer)
          Maximum time to wait before trying to select parts to merge again after no parts were selected. A lower setting value will trigger selecting tasks in background_schedule_pool frequently which result in large amount of requests to Keeper in large-scale clusters. Default value: **60000** (1 minute). For details, see ClickHouse documentation.
        max-number-of-merges-with-ttl-in-pool -> (integer)
          When there is more than specified number of merges with TTL entries in pool, do not assign new merge with TTL. This is to leave free threads for regular merges and avoid "Too many parts" errors. Default value: **2**. For details, see ClickHouse documentation.
        max-parts-in-total -> (integer)
          If the total number of active parts in all partitions of a table exceeds the **max_parts_in_total** value, an **INSERT** is interrupted with the error "Too many parts (N)". Default value: **20000** for versions 25.2 and higher, **100000** for versions 25.1 and lower. For details, see ClickHouse documentation.
        max-replicated-merges-in-queue -> (integer)
          How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. Default value: **32** for versions 25.8 and higher, **16** for versions 25.7 and lower. For details, see ClickHouse documentation.
        merge-max-block-size -> (integer)
          The number of rows that are read from the merged parts into memory. Default value: **8192**. For details, see ClickHouse documentation.
        merge-selecting-sleep-ms -> (integer)
          Minimum time to wait before trying to select parts to merge again after no parts were selected. A lower setting value will trigger selecting tasks in background_schedule_pool frequently which result in large amount of requests to Keeper in large-scale clusters. Default value: **5000** (5 seconds). For details, see ClickHouse documentation.
        merge-with-recompression-ttl-timeout -> (integer)
          Minimum delay in seconds before repeating a merge with recompression TTL. Default value: **14400** (4 hours). For details, see ClickHouse documentation.
        merge-with-ttl-timeout -> (integer)
          Minimum delay in seconds before repeating a merge with delete TTL. Default value: **14400** (4 hours). For details, see ClickHouse documentation.
        min-age-to-force-merge-on-partition-only -> (boolean)
          Whether **min_age_to_force_merge_seconds** should be applied only on the entire partition and not on subset. Default value: **false**. For details, see ClickHouse documentation.
        min-age-to-force-merge-seconds -> (integer)
          Merge parts if every part in the range is older than the specified value. **0** means disabled. Default value: **0**. For details, see ClickHouse documentation.
        min-bytes-for-wide-part -> (integer)
          Minimum number of bytes in a data part that can be stored in Wide format. Default value: **10485760** (10 MiB). For details, see ClickHouse documentation.
        min-compressed-bytes-to-fsync-after-fetch -> (integer)
          Minimal number of compressed bytes to do fsync for part after fetch. **0** means disabled. Default value: **0**. For details, see ClickHouse documentation.
        min-compressed-bytes-to-fsync-after-merge -> (integer)
          Minimal number of compressed bytes to do fsync for part after merge. **0** means disabled. Default value: **0**. For details, see ClickHouse documentation.
        min-rows-for-wide-part -> (integer)
          Minimum number of rows in a data part that can be stored in Wide format. Default value: **0**. For details, see ClickHouse documentation.
        min-rows-to-fsync-after-merge -> (integer)
          Minimal number of rows to do fsync for part after merge. **0** means disabled. Default value: **0**. For details, see ClickHouse documentation.
        number-of-free-entries-in-pool-to-execute-mutation -> (integer)
          When there is less than specified number of free entries in pool, do not execute part mutations. This is to leave free threads for regular merges and to avoid "Too many parts" errors. Default value: **20**. For details, see ClickHouse documentation.
        number-of-free-entries-in-pool-to-lower-max-size-of-merge -> (integer)
          When there is less than the specified number of free entries in pool (or replicated queue), start to lower maximum size of merge to process (or to put in queue). This is to allow small merges to process - not filling the pool with long running merges. Default value: **8**. For details, see ClickHouse documentation.
        parts-to-delay-insert -> (integer)
          If the number of active parts in a single partition exceeds the **parts_to_delay_insert** value, an **INSERT** artificially slows down. Default value: **1000** for versions 25.1 and higher, **150** for versions 24.12 and lower. For details, see ClickHouse documentation.
        parts-to-throw-insert -> (integer)
          If the number of active parts in a single partition exceeds the **parts_to_throw_insert** value, an **INSERT** is interrupted with the error "Too many parts (N). Merges are processing significantly slower than inserts". Default value: **3000** for versions 25.1 and higher, **300** for versions 24.12 and lower. For details, see ClickHouse documentation.
        replicated-deduplication-window -> (integer)
          The number of most recently inserted blocks for which ClickHouse Keeper stores hash sums to check for duplicates. Default value: **10000** for versions 25.9 and higher, **1000** for versions from 23.11 to 25.8, **100** for versions 23.10 and lower. For details, see ClickHouse documentation.
        replicated-deduplication-window-seconds -> (integer)
          The number of seconds after which the hash sums of the inserted blocks are removed from ClickHouse Keeper. Default value: **3600** (1 hour) for versions 25.10 and higher, **604800** (7 days) for versions 25.9 and lower. For details, see ClickHouse documentation.
        ttl-only-drop-parts -> (boolean)
          Controls whether data parts are fully dropped in MergeTree tables when all rows in that part have expired according to their **TTL** settings. * **true** - the entire part is dropped if all rows in that part have expired according to their **TTL** settings. * **false** - only the rows that have expired based on their **TTL** settings are removed. Default value: **false**. For details, see ClickHouse documentation.
      metric-log-enabled -> (boolean)
        Enables or disables metric_log system table. Default value: **false** for versions 25.1 and higher, **true** for versions 24.12 and lower. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      metric-log-retention-size -> (integer)
        The maximum size that metric_log can grow to before old data will be removed. If set to **0**, automatic removal of metric_log data based on size is disabled. Default value: **536870912** (512 MiB).
      metric-log-retention-time -> (integer)
        The maximum time that metric_log records will be retained before removal. If set to **0**, automatic removal of metric_log data based on time is disabled. Default value: **2592000000** (30 days).
      mysql-protocol -> (boolean)
        Enables or disables MySQL interface on ClickHouse server Default value: **false**. For details, see ClickHouse documentation.
      opentelemetry-span-log-enabled -> (boolean)
        Enables or disables opentelemetry_span_log system table. Default value: **false**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      opentelemetry-span-log-retention-size -> (integer)
        The maximum size that opentelemetry_span_log can grow to before old data will be removed. If set to **0**, automatic removal of opentelemetry_span_log data based on size is disabled. Default value: **0**.
      opentelemetry-span-log-retention-time -> (integer)
        The maximum time that opentelemetry_span_log records will be retained before removal. If set to **0**, automatic removal of opentelemetry_span_log data based on time is disabled. Default value: **2592000000** (30 days).
      part-log-retention-size -> (integer)
        The maximum size that part_log can grow to before old data will be removed. If set to **0**, automatic removal of part_log data based on size is disabled. Default value: **536870912** (512 MiB).
      part-log-retention-time -> (integer)
        The maximum time that part_log records will be retained before removal. If set to **0**, automatic removal of part_log data based on time is disabled. Default value: **2592000000** (30 days).
      processors-profile-log-enabled -> (boolean)
        Enables or disables processors_profile_log system table. Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      processors-profile-log-retention-size -> (integer)
        The maximum size that processors_profile_log can grow to before old data will be removed. If set to **0**, automatic removal of processors_profile_log data based on size is disabled. Default value: **0**.
      processors-profile-log-retention-time -> (integer)
        The maximum time that processors_profile_log records will be retained before removal. If set to **0**, automatic removal of processors_profile_log data based on time is disabled. Default value: **2592000000** (30 days).
      query-cache -> (struct)
        Query cache configuration. Change of the settings of **query_cache** is applied with restart.
        max-entries -> (integer)
          The maximum number of **SELECT** query results stored in the cache. Default value: **1024**.
        max-entry-size-in-bytes -> (integer)
          The maximum size in bytes **SELECT** query results may have to be saved in the cache. Default value: **1048576** (1 MiB).
        max-entry-size-in-rows -> (integer)
          The maximum number of rows **SELECT** query results may have to be saved in the cache. Default value: **30000000**.
        max-size-in-bytes -> (integer)
          The maximum cache size in bytes. Default value: **1073741824** (1 GiB).
      query-log-retention-size -> (integer)
        The maximum size that query_log can grow to before old data will be removed. If set to **0**, automatic removal of query_log data based on size is disabled. Default value: **1073741824** (1 GiB).
      query-log-retention-time -> (integer)
        The maximum time that query_log records will be retained before removal. If set to **0**, automatic removal of query_log data based on time is disabled. Default value: **2592000000** (30 days).
      query-masking-rules -> ([]struct)
        Regexp-based rules, which will be applied to queries as well as all log messages before storing them in server logs, system.query_log, system.text_log, system.processes tables, and in logs sent to the client. That allows preventing sensitive data leakage from SQL queries (like names, emails, personal identifiers or credit card numbers) to logs. Change of the settings of **query_masking_rules** is applied with restart. For details, see ClickHouse documentation.
        name -> (string)
          Name for the rule.
        regexp -> (string)
          RE2 compatible regular expression.
        replace -> (string)
          Substitution string for sensitive data. Default value: six asterisks.
      query-metric-log-enabled -> (boolean)
        Enables or disables query_metric_log system table. Default value: **false**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      query-metric-log-retention-size -> (integer)
        The maximum size that query_metric_log can grow to before old data will be removed. If set to **0**, automatic removal of query_metric_log data based on size is disabled. Default value: **536870912** (512 MiB).
      query-metric-log-retention-time -> (integer)
        The maximum time that query_metric_log records will be retained before removal. If set to **0**, automatic removal of query_metric_log data based on time is disabled. Default value: **2592000000** (30 days).
      query-thread-log-enabled -> (boolean)
        Enables or disables query_thread_log system table. Default value: **true**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      query-thread-log-retention-size -> (integer)
        The maximum size that query_thread_log can grow to before old data will be removed. If set to **0**, automatic removal of query_thread_log data based on size is disabled. Default value: **536870912** (512 MiB).
      query-thread-log-retention-time -> (integer)
        The maximum time that query_thread_log records will be retained before removal. If set to **0**, automatic removal of query_thread_log data based on time is disabled. Default value: **2592000000** (30 days).
      query-views-log-enabled -> (boolean)
        Enables or disables query_views_log system table. Default value: **false**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      query-views-log-retention-size -> (integer)
        The maximum size that query_views_log can grow to before old data will be removed. If set to **0**, automatic removal of query_views_log data based on size is disabled. Default value: **0**.
      query-views-log-retention-time -> (integer)
        The maximum time that query_views_log records will be retained before removal. If set to **0**, automatic removal of query_views_log data based on time is disabled. Default value: **2592000000** (30 days).
      rabbitmq -> (struct)
        RabbitMQ integration settings. Change of the settings of **rabbitmq** is applied with restart.
        password -> (string)
          RabbitMQ password.
        username -> (string)
          RabbitMQ username.
        vhost -> (string)
          RabbitMQ virtual host.
      restore-threads -> (integer)
        The maximum number of threads to execute **RESTORE** requests. Default value: **16**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      session-log-enabled -> (boolean)
        Enables or disables session_log system table. Default value: **true** for versions 25.3 and higher, **false** for versions 25.2 and lower. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      session-log-retention-size -> (integer)
        The maximum size that session_log can grow to before old data will be removed. If set to **0**, automatic removal of session_log data based on size is disabled. Default value: **536870912** (512 MiB) for versions 25.3 and higher, **0** for versions 25.2 and lower.
      session-log-retention-time -> (integer)
        The maximum time that session_log records will be retained before removal. If set to **0**, automatic removal of session_log data based on time is disabled. Default value: **2592000000** (30 days).
      text-log-enabled -> (boolean)
        Enables or disables text_log system table. Default value: **false**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      text-log-level -> (struct)
        Logging level for text_log system table. Default value: **TRACE**. Change of the setting is applied with restart.
      text-log-retention-size -> (integer)
        The maximum size that text_log can grow to before old data will be removed. If set to **0**, automatic removal of text_log data based on size is disabled. Default value: **536870912** (512 MiB).
      text-log-retention-time -> (integer)
        The maximum time that text_log records will be retained before removal. If set to **0**, automatic removal of text_log data based on time is disabled. Default value: **2592000000** (30 days).
      timezone -> (string)
        The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. Default value: **Europe/Moscow**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      total-memory-profiler-step -> (integer)
        Whenever server memory usage becomes larger than every next step in number of bytes the memory profiler will collect the allocating stack trace. **0** means disabled memory profiler. Default value: **0**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      total-memory-tracker-sample-probability -> (float64)
        Allows to collect random allocations and de-allocations and writes them in the system.trace_log system table with trace_type equal to a MemorySample with the specified probability. Default value: **0**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      trace-log-enabled -> (boolean)
        Enables or disables trace_log system table. Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      trace-log-retention-size -> (integer)
        The maximum size that trace_log can grow to before old data will be removed. If set to **0**, automatic removal of trace_log data based on size is disabled. Default value: **536870912** (512 MiB).
      trace-log-retention-time -> (integer)
        The maximum time that trace_log records will be retained before removal. If set to **0**, automatic removal of trace_log data based on time is disabled. Default value: **2592000000** (30 days).
      uncompressed-cache-size -> (integer)
        Cache size (in bytes) for uncompressed data used by table engines from the MergeTree family. **0** means disabled. For details, see ClickHouse documentation.
      vector-similarity-index-cache-max-entries -> (integer)
        Size of cache for vector similarity indexes, in entries. **0** means disabled. Default value: **10000000**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      vector-similarity-index-cache-size -> (integer)
        Size of cache for vector similarity indexes, in bytes. **0** means disabled. Default value: **5368709120** (5 GiB). Change of the setting is applied with restart. For details, see ClickHouse documentation.
      zookeeper-log-enabled -> (boolean)
        Enables or disables zookeeper_log system table. Default value: **false**. Change of the setting is applied with restart. For details, see ClickHouse documentation.
      zookeeper-log-retention-size -> (integer)
        The maximum size that zookeeper_log can grow to before old data will be removed. If set to **0**, automatic removal of zookeeper_log data based on size is disabled. Default value: **0**.
      zookeeper-log-retention-time -> (integer)
        The maximum time that zookeeper_log records will be retained before removal. If set to **0**, automatic removal of zookeeper_log data based on time is disabled. Default value: **2592000000** (30 days).
    disk-size-autoscaling -> (struct)
      Disk size autoscaling settings.
      disk-size-limit -> (integer)
        Limit on how large the storage for database instances can automatically grow, in bytes.
      emergency-usage-threshold -> (integer)
        Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
      planned-usage-threshold -> (integer)
        Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
    resources -> (struct)
      Computational resources for the shard.
      disk-size -> (integer)
        Volume of the storage available to a host, in bytes.
      disk-type-id -> (string)
        Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
      resource-preset-id -> (string)
        ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation
    weight -> (integer)
      Relative weight of the shard considered when writing data to the cluster. For details, see ClickHouse documentation.
name -> (string)
  Name of the shard to be created.
shard-group-names -> ([]string)
  Shard groups that contain the shard.
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#