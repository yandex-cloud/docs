---
editable: false
noIndex: true
---

# yc beta managed-clickhouse cluster create

Creates a ClickHouse cluster in the specified folder.

#### Command Usage

Syntax:

`yc beta managed-clickhouse cluster create <FOLDER-ID>`

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
|| `--config-spec` | `shorthand/json`

Configuration and resources for hosts that should be created for the ClickHouse cluster.

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
|| `--database-specs` | `shorthand/json`

Descriptions of databases to be created in the ClickHouse cluster.

Shorthand Syntax:

```hcl
[
  {
    engine = DATABASE_ENGINE_ATOMIC|DATABASE_ENGINE_REPLICATED,
    name = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "engine": "DATABASE_ENGINE_ATOMIC|DATABASE_ENGINE_REPLICATED",
    "name": "string"
  }, ...
]
```

Fields:

```
engine -> (struct)
  Database engine. For details, see ClickHouse documentation.
name -> (string)
  Name of the ClickHouse database. 1-63 characters long.
``` ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster ||
|| `--description` | `string`

Description of the ClickHouse cluster. ||
|| `--disk-encryption-key-id` | `string`

ID of the key to encrypt cluster disks. ||
|| `--environment` | `enum`

Deployment environment of the ClickHouse cluster. Possible Values: 'production', 'prestable' ||
|| `--folder-id` | `string`

ID of the folder to create the ClickHouse cluster in. ||
|| `--host-specs` | `shorthand/json`

Individual configurations for hosts that should be created for the ClickHouse cluster.

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

Name of the ClickHouse cluster. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the network to create the cluster in. ||
|| `--security-group-ids` | `[]string`

User security groups ||
|| `--service-account-id` | `string`

ID of the service account used for access to Object Storage. ||
|| `--shard-name` | `string`

Name of the first shard in cluster. If not set, defaults to the value 'shard1'. ||
|| `--shard-specs` | `shorthand/json`

Configuration(s) of the shard(s) to be created.

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
|| `--user-specs` | `shorthand/json`

Descriptions of database users to be created in the ClickHouse cluster.

Shorthand Syntax:

```hcl
[
  {
    generate-password = boolean,
    name = string,
    password = string,
    permissions = [
      {
        database-name = string
      }, ...
    ],
    quotas = [
      {
        errors = integer,
        execution-time = integer,
        interval-duration = integer,
        queries = integer,
        read-rows = integer,
        result-rows = integer
      }, ...
    ],
    settings = {
      add-http-cors-header = boolean,
      allow-ddl = boolean,
      allow-introspection-functions = boolean,
      allow-suspicious-low-cardinality-types = boolean,
      any-join-distinct-right-table-keys = boolean,
      async-insert = boolean,
      async-insert-busy-timeout = integer,
      async-insert-max-data-size = integer,
      async-insert-stale-timeout = integer,
      async-insert-threads = integer,
      async-insert-use-adaptive-busy-timeout = boolean,
      cancel-http-readonly-queries-on-client-close = boolean,
      compile = boolean,
      compile-expressions = boolean,
      connect-timeout = integer,
      connect-timeout-with-failover = integer,
      count-distinct-implementation = COUNT_DISTINCT_IMPLEMENTATION_UNIQ|COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED|COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED_64|COUNT_DISTINCT_IMPLEMENTATION_UNIQ_HLL_12|COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT,
      data-type-default-nullable = boolean,
      date-time-input-format = DATE_TIME_INPUT_FORMAT_BEST_EFFORT|DATE_TIME_INPUT_FORMAT_BASIC|DATE_TIME_INPUT_FORMAT_BEST_EFFORT_US,
      date-time-output-format = DATE_TIME_OUTPUT_FORMAT_SIMPLE|DATE_TIME_OUTPUT_FORMAT_ISO|DATE_TIME_OUTPUT_FORMAT_UNIX_TIMESTAMP,
      deduplicate-blocks-in-dependent-materialized-views = boolean,
      distinct-overflow-mode = OVERFLOW_MODE_THROW|OVERFLOW_MODE_BREAK,
      distributed-aggregation-memory-efficient = boolean,
      distributed-ddl-output-mode = DISTRIBUTED_DDL_OUTPUT_MODE_THROW|DISTRIBUTED_DDL_OUTPUT_MODE_NONE|DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT|DISTRIBUTED_DDL_OUTPUT_MODE_NEVER_THROW|DISTRIBUTED_DDL_OUTPUT_MODE_NONE_ONLY_ACTIVE|DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT_ONLY_ACTIVE|DISTRIBUTED_DDL_OUTPUT_MODE_THROW_ONLY_ACTIVE,
      distributed-ddl-task-timeout = integer,
      distributed-product-mode = DISTRIBUTED_PRODUCT_MODE_DENY|DISTRIBUTED_PRODUCT_MODE_LOCAL|DISTRIBUTED_PRODUCT_MODE_GLOBAL|DISTRIBUTED_PRODUCT_MODE_ALLOW,
      do-not-merge-across-partitions-select-final = boolean,
      empty-result-for-aggregation-by-empty-set = boolean,
      enable-analyzer = boolean,
      enable-http-compression = boolean,
      enable-reads-from-query-cache = boolean,
      enable-writes-to-query-cache = boolean,
      fallback-to-stale-replicas-for-distributed-queries = boolean,
      final = boolean,
      flatten-nested = boolean,
      force-index-by-date = boolean,
      force-primary-key = boolean,
      format-avro-schema-registry-url = string,
      format-regexp = string,
      format-regexp-escaping-rule = FORMAT_REGEXP_ESCAPING_RULE_ESCAPED|FORMAT_REGEXP_ESCAPING_RULE_QUOTED|FORMAT_REGEXP_ESCAPING_RULE_CSV|FORMAT_REGEXP_ESCAPING_RULE_JSON|FORMAT_REGEXP_ESCAPING_RULE_XML|FORMAT_REGEXP_ESCAPING_RULE_RAW,
      format-regexp-skip-unmatched = boolean,
      group-by-overflow-mode = GROUP_BY_OVERFLOW_MODE_THROW|GROUP_BY_OVERFLOW_MODE_BREAK|GROUP_BY_OVERFLOW_MODE_ANY,
      group-by-two-level-threshold = integer,
      group-by-two-level-threshold-bytes = integer,
      hedged-connection-timeout-ms = integer,
      http-connection-timeout = integer,
      http-headers-progress-interval = integer,
      http-max-field-name-size = integer,
      http-max-field-value-size = integer,
      http-receive-timeout = integer,
      http-send-timeout = integer,
      idle-connection-timeout = integer,
      ignore-materialized-views-with-dropped-target-table = boolean,
      input-format-defaults-for-omitted-fields = boolean,
      input-format-import-nested-json = boolean,
      input-format-null-as-default = boolean,
      input-format-parallel-parsing = boolean,
      input-format-values-interpret-expressions = boolean,
      input-format-with-names-use-header = boolean,
      insert-keeper-max-retries = integer,
      insert-null-as-default = boolean,
      insert-quorum = integer,
      insert-quorum-parallel = boolean,
      insert-quorum-timeout = integer,
      join-algorithm = [
        JOIN_ALGORITHM_HASH|JOIN_ALGORITHM_PARALLEL_HASH|JOIN_ALGORITHM_PARTIAL_MERGE|JOIN_ALGORITHM_DIRECT|JOIN_ALGORITHM_AUTO|JOIN_ALGORITHM_FULL_SORTING_MERGE|JOIN_ALGORITHM_PREFER_PARTIAL_MERGE, ...
      ],
      join-overflow-mode = OVERFLOW_MODE_THROW|OVERFLOW_MODE_BREAK,
      join-use-nulls = boolean,
      joined-subquery-requires-alias = boolean,
      load-balancing = LOAD_BALANCING_RANDOM|LOAD_BALANCING_NEAREST_HOSTNAME|LOAD_BALANCING_IN_ORDER|LOAD_BALANCING_FIRST_OR_RANDOM|LOAD_BALANCING_ROUND_ROBIN,
      local-filesystem-read-method = LOCAL_FILESYSTEM_READ_METHOD_READ|LOCAL_FILESYSTEM_READ_METHOD_PREAD_THREADPOOL|LOCAL_FILESYSTEM_READ_METHOD_PREAD|LOCAL_FILESYSTEM_READ_METHOD_NMAP|LOCAL_FILESYSTEM_READ_METHOD_IO_URING,
      log-processors-profiles = boolean,
      log-queries-probability = float64,
      log-query-threads = boolean,
      log-query-views = boolean,
      low-cardinality-allow-in-native-format = boolean,
      max-ast-depth = integer,
      max-ast-elements = integer,
      max-block-size = integer,
      max-bytes-before-external-group-by = integer,
      max-bytes-before-external-sort = integer,
      max-bytes-in-distinct = integer,
      max-bytes-in-join = integer,
      max-bytes-in-set = integer,
      max-bytes-to-read = integer,
      max-bytes-to-sort = integer,
      max-bytes-to-transfer = integer,
      max-columns-to-read = integer,
      max-concurrent-queries-for-user = integer,
      max-execution-time = integer,
      max-expanded-ast-elements = integer,
      max-final-threads = integer,
      max-http-get-redirects = integer,
      max-insert-block-size = integer,
      max-insert-threads = integer,
      max-memory-usage = integer,
      max-memory-usage-for-user = integer,
      max-network-bandwidth = integer,
      max-network-bandwidth-for-user = integer,
      max-parser-depth = integer,
      max-partitions-per-insert-block = integer,
      max-query-size = integer,
      max-read-buffer-size = integer,
      max-replica-delay-for-distributed-queries = integer,
      max-result-bytes = integer,
      max-result-rows = integer,
      max-rows-in-distinct = integer,
      max-rows-in-join = integer,
      max-rows-in-set = integer,
      max-rows-to-group-by = integer,
      max-rows-to-read = integer,
      max-rows-to-sort = integer,
      max-rows-to-transfer = integer,
      max-temporary-columns = integer,
      max-temporary-data-on-disk-size-for-query = integer,
      max-temporary-data-on-disk-size-for-user = integer,
      max-temporary-non-const-columns = integer,
      max-threads = integer,
      memory-overcommit-ratio-denominator = integer,
      memory-overcommit-ratio-denominator-for-user = integer,
      memory-profiler-sample-probability = float64,
      memory-profiler-step = integer,
      memory-usage-overcommit-max-wait-microseconds = integer,
      merge-tree-max-bytes-to-use-cache = integer,
      merge-tree-max-rows-to-use-cache = integer,
      merge-tree-min-bytes-for-concurrent-read = integer,
      merge-tree-min-rows-for-concurrent-read = integer,
      min-bytes-to-use-direct-io = integer,
      min-count-to-compile = integer,
      min-count-to-compile-expression = integer,
      min-execution-speed = integer,
      min-execution-speed-bytes = integer,
      min-insert-block-size-bytes = integer,
      min-insert-block-size-rows = integer,
      output-format-json-quote-64bit-integers = boolean,
      output-format-json-quote-denormals = boolean,
      prefer-localhost-replica = boolean,
      priority = integer,
      query-cache-max-entries = integer,
      query-cache-max-size-in-bytes = integer,
      query-cache-min-query-duration = integer,
      query-cache-min-query-runs = integer,
      query-cache-nondeterministic-function-handling = QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_THROW|QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_SAVE|QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_IGNORE,
      query-cache-share-between-users = boolean,
      query-cache-system-table-handling = QUERY_CACHE_SYSTEM_TABLE_HANDLING_THROW|QUERY_CACHE_SYSTEM_TABLE_HANDLING_SAVE|QUERY_CACHE_SYSTEM_TABLE_HANDLING_IGNORE,
      query-cache-tag = string,
      query-cache-ttl = integer,
      quota-mode = QUOTA_MODE_DEFAULT|QUOTA_MODE_KEYED|QUOTA_MODE_KEYED_BY_IP,
      read-overflow-mode = OVERFLOW_MODE_THROW|OVERFLOW_MODE_BREAK,
      readonly = integer,
      receive-timeout = integer,
      remote-filesystem-read-method = REMOTE_FILESYSTEM_READ_METHOD_READ|REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL,
      replication-alter-partitions-sync = integer,
      result-overflow-mode = OVERFLOW_MODE_THROW|OVERFLOW_MODE_BREAK,
      s3-use-adaptive-timeouts = boolean,
      select-sequential-consistency = boolean,
      send-progress-in-http-headers = boolean,
      send-timeout = integer,
      set-overflow-mode = OVERFLOW_MODE_THROW|OVERFLOW_MODE_BREAK,
      show-data-lake-catalogs-in-system-tables = boolean,
      skip-unavailable-shards = boolean,
      sort-overflow-mode = OVERFLOW_MODE_THROW|OVERFLOW_MODE_BREAK,
      timeout-before-checking-execution-speed = integer,
      timeout-overflow-mode = OVERFLOW_MODE_THROW|OVERFLOW_MODE_BREAK,
      transfer-overflow-mode = OVERFLOW_MODE_THROW|OVERFLOW_MODE_BREAK,
      transform-null-in = boolean,
      use-hedged-requests = boolean,
      use-hive-partitioning = boolean,
      use-query-cache = boolean,
      use-uncompressed-cache = boolean,
      wait-for-async-insert = boolean,
      wait-for-async-insert-timeout = integer
    }
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "generate-password": "boolean",
    "name": "string",
    "password": "string",
    "permissions": [
      {
        "database-name": "string"
      }, ...
    ],
    "quotas": [
      {
        "errors": "integer",
        "execution-time": "integer",
        "interval-duration": "integer",
        "queries": "integer",
        "read-rows": "integer",
        "result-rows": "integer"
      }, ...
    ],
    "settings": {
      "add-http-cors-header": "boolean",
      "allow-ddl": "boolean",
      "allow-introspection-functions": "boolean",
      "allow-suspicious-low-cardinality-types": "boolean",
      "any-join-distinct-right-table-keys": "boolean",
      "async-insert": "boolean",
      "async-insert-busy-timeout": "integer",
      "async-insert-max-data-size": "integer",
      "async-insert-stale-timeout": "integer",
      "async-insert-threads": "integer",
      "async-insert-use-adaptive-busy-timeout": "boolean",
      "cancel-http-readonly-queries-on-client-close": "boolean",
      "compile": "boolean",
      "compile-expressions": "boolean",
      "connect-timeout": "integer",
      "connect-timeout-with-failover": "integer",
      "count-distinct-implementation": "COUNT_DISTINCT_IMPLEMENTATION_UNIQ|COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED|COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED_64|COUNT_DISTINCT_IMPLEMENTATION_UNIQ_HLL_12|COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT",
      "data-type-default-nullable": "boolean",
      "date-time-input-format": "DATE_TIME_INPUT_FORMAT_BEST_EFFORT|DATE_TIME_INPUT_FORMAT_BASIC|DATE_TIME_INPUT_FORMAT_BEST_EFFORT_US",
      "date-time-output-format": "DATE_TIME_OUTPUT_FORMAT_SIMPLE|DATE_TIME_OUTPUT_FORMAT_ISO|DATE_TIME_OUTPUT_FORMAT_UNIX_TIMESTAMP",
      "deduplicate-blocks-in-dependent-materialized-views": "boolean",
      "distinct-overflow-mode": "OVERFLOW_MODE_THROW|OVERFLOW_MODE_BREAK",
      "distributed-aggregation-memory-efficient": "boolean",
      "distributed-ddl-output-mode": "DISTRIBUTED_DDL_OUTPUT_MODE_THROW|DISTRIBUTED_DDL_OUTPUT_MODE_NONE|DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT|DISTRIBUTED_DDL_OUTPUT_MODE_NEVER_THROW|DISTRIBUTED_DDL_OUTPUT_MODE_NONE_ONLY_ACTIVE|DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT_ONLY_ACTIVE|DISTRIBUTED_DDL_OUTPUT_MODE_THROW_ONLY_ACTIVE",
      "distributed-ddl-task-timeout": "integer",
      "distributed-product-mode": "DISTRIBUTED_PRODUCT_MODE_DENY|DISTRIBUTED_PRODUCT_MODE_LOCAL|DISTRIBUTED_PRODUCT_MODE_GLOBAL|DISTRIBUTED_PRODUCT_MODE_ALLOW",
      "do-not-merge-across-partitions-select-final": "boolean",
      "empty-result-for-aggregation-by-empty-set": "boolean",
      "enable-analyzer": "boolean",
      "enable-http-compression": "boolean",
      "enable-reads-from-query-cache": "boolean",
      "enable-writes-to-query-cache": "boolean",
      "fallback-to-stale-replicas-for-distributed-queries": "boolean",
      "final": "boolean",
      "flatten-nested": "boolean",
      "force-index-by-date": "boolean",
      "force-primary-key": "boolean",
      "format-avro-schema-registry-url": "string",
      "format-regexp": "string",
      "format-regexp-escaping-rule": "FORMAT_REGEXP_ESCAPING_RULE_ESCAPED|FORMAT_REGEXP_ESCAPING_RULE_QUOTED|FORMAT_REGEXP_ESCAPING_RULE_CSV|FORMAT_REGEXP_ESCAPING_RULE_JSON|FORMAT_REGEXP_ESCAPING_RULE_XML|FORMAT_REGEXP_ESCAPING_RULE_RAW",
      "format-regexp-skip-unmatched": "boolean",
      "group-by-overflow-mode": "GROUP_BY_OVERFLOW_MODE_THROW|GROUP_BY_OVERFLOW_MODE_BREAK|GROUP_BY_OVERFLOW_MODE_ANY",
      "group-by-two-level-threshold": "integer",
      "group-by-two-level-threshold-bytes": "integer",
      "hedged-connection-timeout-ms": "integer",
      "http-connection-timeout": "integer",
      "http-headers-progress-interval": "integer",
      "http-max-field-name-size": "integer",
      "http-max-field-value-size": "integer",
      "http-receive-timeout": "integer",
      "http-send-timeout": "integer",
      "idle-connection-timeout": "integer",
      "ignore-materialized-views-with-dropped-target-table": "boolean",
      "input-format-defaults-for-omitted-fields": "boolean",
      "input-format-import-nested-json": "boolean",
      "input-format-null-as-default": "boolean",
      "input-format-parallel-parsing": "boolean",
      "input-format-values-interpret-expressions": "boolean",
      "input-format-with-names-use-header": "boolean",
      "insert-keeper-max-retries": "integer",
      "insert-null-as-default": "boolean",
      "insert-quorum": "integer",
      "insert-quorum-parallel": "boolean",
      "insert-quorum-timeout": "integer",
      "join-algorithm": [
        "JOIN_ALGORITHM_HASH|JOIN_ALGORITHM_PARALLEL_HASH|JOIN_ALGORITHM_PARTIAL_MERGE|JOIN_ALGORITHM_DIRECT|JOIN_ALGORITHM_AUTO|JOIN_ALGORITHM_FULL_SORTING_MERGE|JOIN_ALGORITHM_PREFER_PARTIAL_MERGE", ...
      ],
      "join-overflow-mode": "OVERFLOW_MODE_THROW|OVERFLOW_MODE_BREAK",
      "join-use-nulls": "boolean",
      "joined-subquery-requires-alias": "boolean",
      "load-balancing": "LOAD_BALANCING_RANDOM|LOAD_BALANCING_NEAREST_HOSTNAME|LOAD_BALANCING_IN_ORDER|LOAD_BALANCING_FIRST_OR_RANDOM|LOAD_BALANCING_ROUND_ROBIN",
      "local-filesystem-read-method": "LOCAL_FILESYSTEM_READ_METHOD_READ|LOCAL_FILESYSTEM_READ_METHOD_PREAD_THREADPOOL|LOCAL_FILESYSTEM_READ_METHOD_PREAD|LOCAL_FILESYSTEM_READ_METHOD_NMAP|LOCAL_FILESYSTEM_READ_METHOD_IO_URING",
      "log-processors-profiles": "boolean",
      "log-queries-probability": "float64",
      "log-query-threads": "boolean",
      "log-query-views": "boolean",
      "low-cardinality-allow-in-native-format": "boolean",
      "max-ast-depth": "integer",
      "max-ast-elements": "integer",
      "max-block-size": "integer",
      "max-bytes-before-external-group-by": "integer",
      "max-bytes-before-external-sort": "integer",
      "max-bytes-in-distinct": "integer",
      "max-bytes-in-join": "integer",
      "max-bytes-in-set": "integer",
      "max-bytes-to-read": "integer",
      "max-bytes-to-sort": "integer",
      "max-bytes-to-transfer": "integer",
      "max-columns-to-read": "integer",
      "max-concurrent-queries-for-user": "integer",
      "max-execution-time": "integer",
      "max-expanded-ast-elements": "integer",
      "max-final-threads": "integer",
      "max-http-get-redirects": "integer",
      "max-insert-block-size": "integer",
      "max-insert-threads": "integer",
      "max-memory-usage": "integer",
      "max-memory-usage-for-user": "integer",
      "max-network-bandwidth": "integer",
      "max-network-bandwidth-for-user": "integer",
      "max-parser-depth": "integer",
      "max-partitions-per-insert-block": "integer",
      "max-query-size": "integer",
      "max-read-buffer-size": "integer",
      "max-replica-delay-for-distributed-queries": "integer",
      "max-result-bytes": "integer",
      "max-result-rows": "integer",
      "max-rows-in-distinct": "integer",
      "max-rows-in-join": "integer",
      "max-rows-in-set": "integer",
      "max-rows-to-group-by": "integer",
      "max-rows-to-read": "integer",
      "max-rows-to-sort": "integer",
      "max-rows-to-transfer": "integer",
      "max-temporary-columns": "integer",
      "max-temporary-data-on-disk-size-for-query": "integer",
      "max-temporary-data-on-disk-size-for-user": "integer",
      "max-temporary-non-const-columns": "integer",
      "max-threads": "integer",
      "memory-overcommit-ratio-denominator": "integer",
      "memory-overcommit-ratio-denominator-for-user": "integer",
      "memory-profiler-sample-probability": "float64",
      "memory-profiler-step": "integer",
      "memory-usage-overcommit-max-wait-microseconds": "integer",
      "merge-tree-max-bytes-to-use-cache": "integer",
      "merge-tree-max-rows-to-use-cache": "integer",
      "merge-tree-min-bytes-for-concurrent-read": "integer",
      "merge-tree-min-rows-for-concurrent-read": "integer",
      "min-bytes-to-use-direct-io": "integer",
      "min-count-to-compile": "integer",
      "min-count-to-compile-expression": "integer",
      "min-execution-speed": "integer",
      "min-execution-speed-bytes": "integer",
      "min-insert-block-size-bytes": "integer",
      "min-insert-block-size-rows": "integer",
      "output-format-json-quote-64bit-integers": "boolean",
      "output-format-json-quote-denormals": "boolean",
      "prefer-localhost-replica": "boolean",
      "priority": "integer",
      "query-cache-max-entries": "integer",
      "query-cache-max-size-in-bytes": "integer",
      "query-cache-min-query-duration": "integer",
      "query-cache-min-query-runs": "integer",
      "query-cache-nondeterministic-function-handling": "QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_THROW|QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_SAVE|QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_IGNORE",
      "query-cache-share-between-users": "boolean",
      "query-cache-system-table-handling": "QUERY_CACHE_SYSTEM_TABLE_HANDLING_THROW|QUERY_CACHE_SYSTEM_TABLE_HANDLING_SAVE|QUERY_CACHE_SYSTEM_TABLE_HANDLING_IGNORE",
      "query-cache-tag": "string",
      "query-cache-ttl": "integer",
      "quota-mode": "QUOTA_MODE_DEFAULT|QUOTA_MODE_KEYED|QUOTA_MODE_KEYED_BY_IP",
      "read-overflow-mode": "OVERFLOW_MODE_THROW|OVERFLOW_MODE_BREAK",
      "readonly": "integer",
      "receive-timeout": "integer",
      "remote-filesystem-read-method": "REMOTE_FILESYSTEM_READ_METHOD_READ|REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL",
      "replication-alter-partitions-sync": "integer",
      "result-overflow-mode": "OVERFLOW_MODE_THROW|OVERFLOW_MODE_BREAK",
      "s3-use-adaptive-timeouts": "boolean",
      "select-sequential-consistency": "boolean",
      "send-progress-in-http-headers": "boolean",
      "send-timeout": "integer",
      "set-overflow-mode": "OVERFLOW_MODE_THROW|OVERFLOW_MODE_BREAK",
      "show-data-lake-catalogs-in-system-tables": "boolean",
      "skip-unavailable-shards": "boolean",
      "sort-overflow-mode": "OVERFLOW_MODE_THROW|OVERFLOW_MODE_BREAK",
      "timeout-before-checking-execution-speed": "integer",
      "timeout-overflow-mode": "OVERFLOW_MODE_THROW|OVERFLOW_MODE_BREAK",
      "transfer-overflow-mode": "OVERFLOW_MODE_THROW|OVERFLOW_MODE_BREAK",
      "transform-null-in": "boolean",
      "use-hedged-requests": "boolean",
      "use-hive-partitioning": "boolean",
      "use-query-cache": "boolean",
      "use-uncompressed-cache": "boolean",
      "wait-for-async-insert": "boolean",
      "wait-for-async-insert-timeout": "integer"
    }
  }, ...
]
```

Fields:

```
generate-password -> (boolean)
  Enable or disable password generation using Connection Manager. Default value: **false**.
name -> (string)
  User name.
password -> (string)
  User password.
permissions -> ([]struct)
  Set of permissions to grant to the user. If not set, it's granted permissions to access all databases.
  database-name -> (string)
    Name of the database that the permission grants access to.
quotas -> ([]struct)
  Quotas assigned to the user.
  errors -> (integer)
    The number of queries that threw exception. **0** means unlimited.
  execution-time -> (integer)
    The total query execution time, in milliseconds (wall time). **0** means unlimited.
  interval-duration -> (integer)
    Duration of interval for quota in milliseconds.
  queries -> (integer)
    The total number of queries. **0** means unlimited.
  read-rows -> (integer)
    The total number of source rows read from tables for running the query, on all remote servers. **0** means unlimited.
  result-rows -> (integer)
    The total number of rows given as the result. **0** means unlimited.
settings -> (struct)
  User settings
  add-http-cors-header -> (boolean)
    Adds CORS header in HTTP responses. Default value: **false**. For details, see ClickHouse documentation.
  allow-ddl -> (boolean)
    Allows or denies DDL queries (e.g., **CREATE**, **ALTER**, **RENAME**, etc). Default value: **true**. For details, see ClickHouse documentation.
  allow-introspection-functions -> (boolean)
    Enables or disables introspection functions for query profiling. Default value: **false**. For details, see ClickHouse documentation.
  allow-suspicious-low-cardinality-types -> (boolean)
    Allows or restricts using LowCardinality with data types with fixed size of 8 bytes or less. Default value: **false**. For details, see ClickHouse documentation.
  any-join-distinct-right-table-keys -> (boolean)
    Enables legacy ClickHouse server behaviour in **ANY INNER|LEFT JOIN** operations. Default value: **false**. For details, see ClickHouse documentation.
  async-insert -> (boolean)
    If enabled, data from **INSERT** query is stored in queue and later flushed to table in background. Default value: **false**. For details, see ClickHouse documentation.
  async-insert-busy-timeout -> (integer)
    Maximum time to wait before dumping collected data per query since the first data appeared. Default value: **200**. For details, see ClickHouse documentation.
  async-insert-max-data-size -> (integer)
    The maximum size of the unparsed data in bytes collected per query before being inserted. Default value: **10485760** (10 MiB). For details, see ClickHouse documentation.
  async-insert-stale-timeout -> (integer)
    The setting is deprecated and has no effect.
  async-insert-threads -> (integer)
    The setting is deprecated and has no effect.
  async-insert-use-adaptive-busy-timeout -> (boolean)
    Enables of disables adaptive busy timeout for asynchronous inserts. Default value: **true**. For details, see ClickHouse documentation.
  cancel-http-readonly-queries-on-client-close -> (boolean)
    Cancels HTTP read-only queries (e.g. **SELECT**) when a client closes the connection without waiting for the response. Default value: **false**. For details, see ClickHouse documentation.
  compile -> (boolean)
    The setting is deprecated and has no effect.
  compile-expressions -> (boolean)
    Enable or disable expression compilation to native code. If you execute a lot of queries that contain identical expressions, then enable this setting. As a result, such queries may be executed faster due to use of compiled expressions. Use this setting in combination with **min_count_to_compile_expression** setting. Default value: **true** for versions 25.5 and higher, **false** for versions 25.4 and lower. For details, see ClickHouse documentation.
  connect-timeout -> (integer)
    Connection timeout in milliseconds. Default value: **10000** (10 seconds). For details, see ClickHouse documentation.
  connect-timeout-with-failover -> (integer)
    The timeout in milliseconds for connecting to a remote server for a Distributed table engine. Applies only if the cluster uses sharding and replication. If unsuccessful, several attempts are made to connect to various replicas. Default value: **1000** (1 second). For details, see ClickHouse documentation.
  count-distinct-implementation -> (struct)
    Specifies which of the uniq* functions should be used to perform the **COUNT(DISTINCT ...)** construction. Default value: **COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT**. For details, see ClickHouse documentation.
  data-type-default-nullable -> (boolean)
    Allows data types without explicit modifiers **NULL** or **NOT NULL** in column definition will be Nullable. Default value: **false**. For details, see ClickHouse documentation.
  date-time-input-format -> (struct)
    Specifies which of date time parsers to use. Default value: **DATE_TIME_INPUT_FORMAT_BASIC**. For details, see ClickHouse documentation.
  date-time-output-format -> (struct)
    Specifies which of date time output formats to use. Default value: **DATE_TIME_OUTPUT_FORMAT_SIMPLE**. For details, see ClickHouse documentation.
  deduplicate-blocks-in-dependent-materialized-views -> (boolean)
    Enables or disables the deduplication check for materialized views that receive data from replicated tables. Default value: **false**. For details, see ClickHouse documentation.
  distinct-overflow-mode -> (struct)
    Determines the behavior on exceeding limits while performing **DISTINCT**. Default value: **OVERFLOW_MODE_THROW**. For details, see ClickHouse documentation.
  distributed-aggregation-memory-efficient -> (boolean)
    Enables of disables memory saving mode when doing distributed aggregation. When ClickHouse works with a distributed query, external aggregation is done on remote servers. Enable this setting to achieve a smaller memory footprint on the server that sourced such a distributed query. Default value: **true**. For details, see ClickHouse documentation.
  distributed-ddl-output-mode -> (struct)
    Determines the format of distributed DDL query result. Default value: **DISTRIBUTED_DDL_OUTPUT_MODE_THROW**. For details, see ClickHouse documentation.
  distributed-ddl-task-timeout -> (integer)
    Timeout for DDL queries, in milliseconds. Default value: **180000** (3 minutes). For details, see ClickHouse documentation.
  distributed-product-mode -> (struct)
    Determines the behavior of distributed subqueries. Default value: **DISTRIBUTED_PRODUCT_MODE_DENY**. For details, see ClickHouse documentation.
  do-not-merge-across-partitions-select-final -> (boolean)
    Enable or disable independent processing of partitions for **SELECT** queries with **FINAL**. Default value: **false**. For details, see ClickHouse documentation.
  empty-result-for-aggregation-by-empty-set -> (boolean)
    Enables or disables returning of empty result when aggregating without keys (with **GROUP BY** operation absent) on empty set (e.g., **SELECT count(*) FROM table WHERE 0**). * **true** - ClickHouse will return an empty result for such queries. * **false** - ClickHouse will return a single-line result consisting of **NULL** values for aggregation functions, in accordance with SQL standard. Default value: **false**. For details, see ClickHouse documentation.
  enable-analyzer -> (boolean)
    Enables or disables new query analyzer. Default value: **true** for versions 25.9 and higher, **false** for version 25.8, **true** for versions from 25.5 to 25.7, **false** for versions 25.4 and lower. For details, see ClickHouse documentation.
  enable-http-compression -> (boolean)
    Enables or disables data compression in HTTP responses. By default, ClickHouse stores data compressed. When executing a query, its result is uncompressed. Use this setting to command ClickHouse to compress the result when sending it via HTTP. Enable this setting and add the **Accept-Encoding: <compression method>** HTTP header in a HTTP request to force compression of HTTP response from ClickHouse. ClickHouse support the following compression methods: **gzip**, **br** and **deflate**. Default value: **false**. For details, see ClickHouse documentation.
  enable-reads-from-query-cache -> (boolean)
    If turned on, results of **SELECT** queries are retrieved from the query cache. Default value: **true**. For details, see ClickHouse documentation.
  enable-writes-to-query-cache -> (boolean)
    If turned on, results of **SELECT** queries are stored in the query cache. Default value: **true**. For details, see ClickHouse documentation.
  fallback-to-stale-replicas-for-distributed-queries -> (boolean)
    Enables or disables query forcing to a stale replica in case the actual data is unavailable. If enabled, ClickHouse will choose the most up-to-date replica and force the query to use the data in this replica. This setting can be used when doing **SELECT** query from a distributed table that points to replicated tables. Default value: **true**. For details, see ClickHouse documentation.
  final -> (boolean)
    If enabled, automatically applies **FINAL** modifier to all tables in a query, to tables where **FINAL** is applicable, including joined tables and tables in sub-queries, and distributed tables. Default value: **false**. For details, see ClickHouse documentation.
  flatten-nested -> (boolean)
    Sets the data format of nested columns. Default value: **true**. For details, see ClickHouse documentation.
  force-index-by-date -> (boolean)
    Disables query execution if the index cannot be used by date. This setting has effect only for tables of the MergeTree family. Default value: **false**. For details, see ClickHouse documentation.
  force-primary-key -> (boolean)
    Disables query execution if indexing by the primary key cannot be used. This setting has effect only for tables of the MergeTree family. Default value: **false**. For details, see ClickHouse documentation.
  format-avro-schema-registry-url -> (string)
    Avro schema registry URL. For details, see ClickHouse documentation.
  format-regexp -> (string)
    Regular expression (for Regexp format). For details, see ClickHouse documentation.
  format-regexp-escaping-rule -> (struct)
    Field escaping rule (for Regexp format). Default value: **FORMAT_REGEXP_ESCAPING_RULE_RAW**. For details, see ClickHouse documentation.
  format-regexp-skip-unmatched -> (boolean)
    Skip lines unmatched by regular expression (for Regexp format) Default value: **false**. For details, see ClickHouse documentation.
  group-by-overflow-mode -> (struct)
    Determines the behavior on exceeding limits while doing aggregation. Default value: **GROUP_BY_OVERFLOW_MODE_THROW**. For details, see ClickHouse documentation.
  group-by-two-level-threshold -> (integer)
    Sets the threshold of the number of keys, after that the two-level aggregation should be used. **0** means threshold is not set. Default value: **100000**. For details, see ClickHouse documentation.
  group-by-two-level-threshold-bytes -> (integer)
    Sets the threshold of the number of bytes, after that the two-level aggregation should be used. **0** means threshold is not set. Default value: **50000000**. For details, see ClickHouse documentation.
  hedged-connection-timeout-ms -> (integer)
    Connection timeout for establishing connection with replica for Hedged requests. Default value: **50**. For details, see ClickHouse documentation.
  http-connection-timeout -> (integer)
    HTTP connection timeout, in milliseconds. Default value: **1000** (1 second). For details, see ClickHouse documentation.
  http-headers-progress-interval -> (integer)
    Minimum interval between progress notifications with **X-ClickHouse-Progress** HTTP header, in milliseconds. Default value: **100**. For details, see ClickHouse documentation.
  http-max-field-name-size -> (integer)
    Maximum length of field name in HTTP header. Default value: **131072**. For details, see ClickHouse documentation.
  http-max-field-value-size -> (integer)
    Maximum length of field value in HTTP header. Default value: **131072**. For details, see ClickHouse documentation.
  http-receive-timeout -> (integer)
    HTTP receive timeout, in milliseconds. Default value: **30000** (30 seconds). For details, see ClickHouse documentation.
  http-send-timeout -> (integer)
    HTTP send timeout, in milliseconds. Default value: **30000** (30 seconds). For details, see ClickHouse documentation.
  idle-connection-timeout -> (integer)
    Timeout to close idle TCP connections after specified time has elapsed, in milliseconds. Default value: **3600000** (1 hour). For details, see ClickHouse documentation.
  ignore-materialized-views-with-dropped-target-table -> (boolean)
    Ignore materialized views with dropped target table during pushing to views. Default value: **false**. For details, see ClickHouse documentation.
  input-format-defaults-for-omitted-fields -> (boolean)
    Enables or disables replacing omitted input values with default values of the respective columns when performing **INSERT** queries. Default value: **true**. For details, see ClickHouse documentation.
  input-format-import-nested-json -> (boolean)
    Enables or disables the insertion of JSON data with nested objects. Default value: **false**. For details, see ClickHouse documentation.
  input-format-null-as-default -> (boolean)
    Enables or disables the initialization of **NULL** fields with default values, if data type of these fields is not nullable. Default value: **true**. For details, see ClickHouse documentation.
  input-format-parallel-parsing -> (boolean)
    Enables or disables order-preserving parallel parsing of data formats. Supported only for TSV, TSKV, CSV and JSONEachRow formats. Default value: **true**. For details, see ClickHouse documentation.
  input-format-values-interpret-expressions -> (boolean)
    Enables or disables SQL parser if the fast stream parser cannot parse the data. Enable this setting, if the data that you want to insert into a table contains SQL expressions. For example, the stream parser is unable to parse a value that contains **now()** expression; therefore an **INSERT** query for this value will fail and no data will be inserted into a table. With enabled SQL parser, this expression is parsed correctly: the **now()** expression will be parsed as SQL function, interpreted, and the current date and time will be inserted into the table as a result. This setting has effect only if you use Values format when inserting data. Default value: **true**. For details, see ClickHouse documentation.
  input-format-with-names-use-header -> (boolean)
    Enables or disables checking the column order when inserting data. Default value: **true**. For details, see ClickHouse documentation.
  insert-keeper-max-retries -> (integer)
    The setting sets the maximum number of retries for ClickHouse Keeper (or ZooKeeper) requests during insert into replicated MergeTree tables. Only Keeper requests which failed due to network error, Keeper session timeout or request timeout are considered for retries. Default value: **20**. For details, see ClickHouse documentation.
  insert-null-as-default -> (boolean)
    Enables or disables the insertion of default values instead of **NULL** into columns with not nullable data type. If column type is not nullable and this setting is disabled, then inserting NULL causes an exception. If column type is nullable, then NULL values are inserted as is, regardless of this setting. Default value: **true**. For details, see ClickHouse documentation.
  insert-quorum -> (integer)
    Enables or disables the quorum writes. If the value is less than **2**, then the quorum writes is disabled, otherwise it is enabled. When used, write quorum guarantees that ClickHouse has written data to the quorum of **insert_quorum** replicas with no errors until the **insert_quorum_timeout** expires. All replicas in the quorum are in the consistent state, meaning that they contain linearized data from the previous **INSERT** queries. Employ write quorum, if you need the guarantees that the written data would not be lost in case of one or more replicas failure. You can use **select_sequential_consistency** setting to read the data written with write quorum. Default value: **0**. For details, see ClickHouse documentation.
  insert-quorum-parallel -> (boolean)
    Enables or disables parallelism for quorum **INSERT** queries. Default value: **true**. For details, see ClickHouse documentation.
  insert-quorum-timeout -> (integer)
    Quorum write timeout in milliseconds. If the write quorum is enabled in the cluster, this timeout expires and some data is not written to the **insert_quorum** replicas, then ClickHouse will abort the execution of **INSERT** query and return an error. In this case, the client must send the query again to write the data block into the same or another replica. Default value: **600000** (10 minutes). For details, see ClickHouse documentation.
  join-algorithm -> ([]struct)
    Specifies which JOIN algorithm to use. Default value: **JOIN_ALGORITHM_DIRECT,JOIN_ALGORITHM_PARALLEL_HASH,JOIN_ALGORITHM_HASH** for versions 24.12 and higher, **JOIN_ALGORITHM_DIRECT,JOIN_ALGORITHM_AUTO** for versions from 23.8 to 24.11, **JOIN_ALGORITHM_AUTO** for versions 23.7 and lower. For details, see ClickHouse documentation.
  join-overflow-mode -> (struct)
    Determines the behavior on exceeding max_rows_in_join or max_bytes_in_join limit. Default value: **OVERFLOW_MODE_THROW**. For details, see ClickHouse documentation.
  join-use-nulls -> (boolean)
    Determines **JOIN** behavior on filling empty cells when merging tables. If enabled, the empty cells are filled with **NULL**. Otherwise, the empty cells are filled with the default value of the corresponding field type. Default value: **false**. For details, see ClickHouse documentation.
  joined-subquery-requires-alias -> (boolean)
    Force joined subqueries and table functions to have aliases for correct name qualification. Default value: **true**. For details, see ClickHouse documentation.
  load-balancing -> (struct)
    Algorithm of replicas selection that is used for distributed query processing. Default value: **LOAD_BALANCING_RANDOM**. For details, see ClickHouse documentation.
  local-filesystem-read-method -> (struct)
    Method of reading data from local filesystem. The LOCAL_FILESYSTEM_READ_METHOD_IO_URING is experimental and does not work for Log, TinyLog, StripeLog, File, Set and Join, and other tables with append-able files in presence of concurrent reads and writes. For details, see ClickHouse documentation.
  log-processors-profiles -> (boolean)
    Enables or disables logging of processors level profiling data to the the system.processors_profile_log table. Default value: **false**. For details, see ClickHouse documentation.
  log-queries-probability -> (float64)
    Log queries with the specified probability. Default value: **1**. For details, see ClickHouse documentation.
  log-query-threads -> (boolean)
    Enables or disables query threads logging to the the system.query_thread_log table. This setting has effect only when **log_queries** setting is enabled. Default value: **false**. For details, see ClickHouse documentation.
  log-query-views -> (boolean)
    Enables or disables query views logging to the the system.query_views_log table. Default value: **true**. For details, see ClickHouse documentation.
  low-cardinality-allow-in-native-format -> (boolean)
    Allows or restricts using the LowCardinality data type with the Native format. LowCardinality columns (aka sparse columns) store data in more effective way, compared to regular columns, by using hash tables. If data to insert suits this storage format, ClickHouse will place them into LowCardinality column. If you use a third-party ClickHouse client that can't work with LowCardinality columns, then this client will not be able to correctly interpret the result of the query that asks for data stored in LowCardinality column. Disable this setting to convert LowCardinality column to regular column when creating the result, so such clients will be able to process the result. Official ClickHouse client works with LowCardinality columns out-of-the-box. Default value: **true**. For details, see ClickHouse documentation.
  max-ast-depth -> (integer)
    Limits the maximum depth of query syntax tree. Executing a big and complex query may result in building a syntax tree of enormous depth. By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables. Default value: **1000**. For details, see ClickHouse documentation.
  max-ast-elements -> (integer)
    Limits the maximum size of query syntax tree in number of nodes. Executing a big and complex query may result in building a syntax tree of enormous size. By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables. Default value: **50000**. For details, see ClickHouse documentation.
  max-block-size -> (integer)
    Sets the recommended maximum number of rows to include in a single block when loading data from tables. Blocks the size of **max_block_size** are not always loaded from the table: if ClickHouse determines that less data needs to be retrieved, a smaller block is processed. The block size should not be too small to avoid noticeable costs when processing each block. It should also not be too large to ensure that queries with a **LIMIT** clause execute quickly after processing the first block. When setting **max_block_size**, the goal should be to avoid consuming too much memory when extracting a large number of columns in multiple threads and to preserve at least some cache locality. Default value: **65409**. For details, see ClickHouse documentation.
  max-bytes-before-external-group-by -> (integer)
    Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the **GROUP BY** operation, should be flushed to disk to limit the RAM consumption. If set to **0**, **GROUP BY** in the external memory is disabled. By default, aggregation is done by employing hash table that resides in RAM. A query can result in aggregation of huge data volumes that can lead to memory exhaustion and abortion of the query (see the **max_memory_usage** setting). For such queries, you can use this setting to force ClickHouse to do flushing and complete aggregation successfully. Default value: **0**. For details, see ClickHouse documentation.
  max-bytes-before-external-sort -> (integer)
    Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the **ORDER BY** operation, should be flushed to disk to limit the RAM consumption. If set to **0**, **ORDER BY** in the external memory is disabled. Default value: **0**. For details, see ClickHouse documentation.
  max-bytes-in-distinct -> (integer)
    Limits the maximum number of bytes (uncompressed data) in the state, which is used for performing **DISTINCT**. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  max-bytes-in-join -> (integer)
    Limits the maximum number of bytes in the hash table that is used when joining tables. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  max-bytes-in-set -> (integer)
    Limits on the maximum number of bytes (uncompressed data) in the set resulting from the execution of the **IN** section. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  max-bytes-to-read -> (integer)
    Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  max-bytes-to-sort -> (integer)
    Limits the maximum number of bytes (uncompressed data) that can be read from a table for sorting. **0** means unlimited. This setting lets you to limit RAM consumption when sorting Default value: **0**. For details, see ClickHouse documentation.
  max-bytes-to-transfer -> (integer)
    Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary table when using **GLOBAL IN|JOIN**. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  max-columns-to-read -> (integer)
    Limits the maximum number of columns that can be read from a table in a single query. **0** means unlimited. If the query requires to read more columns to complete, then it will be aborted. Default value: **0**. For details, see ClickHouse documentation.
  max-concurrent-queries-for-user -> (integer)
    The maximum number of simultaneously processed queries per user. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  max-execution-time -> (integer)
    Limits the maximum query execution time in milliseconds. **0** means unlimited. The timeout is checked and the query can stop only in designated places during data processing. Default value: **0**. For details, see ClickHouse documentation.
  max-expanded-ast-elements -> (integer)
    Limits the maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk values. Executing a big and complex query may result in building a syntax tree of enormous size. By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables. Default value: **500000**. For details, see ClickHouse documentation.
  max-final-threads -> (integer)
    Sets the maximum number of parallel threads for the **SELECT** query data read phase with the **FINAL** modifier. For details, see ClickHouse documentation.
  max-http-get-redirects -> (integer)
    Limits the maximum number of HTTP GET redirect hops. If set to **0**, no hops is allowed. Default value: **0**. For details, see ClickHouse documentation.
  max-insert-block-size -> (integer)
    The size of blocks (in a count of rows) to form for insertion into a table. This setting only applies in cases when the server forms the blocks. For example, for an **INSERT** via the HTTP interface, the server parses the data format and forms blocks of the specified size. But when using clickhouse-client, the client parses the data itself, and the **max_insert_block_size** setting on the server does not affect the size of the inserted blocks. The setting also does not have a purpose when using **INSERT SELECT**, since data is inserted using the same blocks that are formed after **SELECT**. Default value: **1048449**. For details, see ClickHouse documentation.
  max-insert-threads -> (integer)
    The maximum number of threads to execute the **INSERT SELECT** query. Default value: **0**. For details, see ClickHouse documentation.
  max-memory-usage -> (integer)
    Limits the maximum memory usage (in bytes) for processing of a single user's query on a single server. **0** means unlimited. This limitation is enforced for any user's single query on a single server. If you use **max_bytes_before_external_group_by** or **max_bytes_before_external_sort** setting, then it is recommended to set their values twice as low as **max_memory_usage** setting value. Default value: **0**. For details, see ClickHouse documentation.
  max-memory-usage-for-user -> (integer)
    Limits the maximum memory usage (in bytes) for processing of user's queries on a single server. **0** means unlimited. This limitation is enforced for all queries that belong to one user and run simultaneously on a single server. Default value: **0**. For details, see ClickHouse documentation.
  max-network-bandwidth -> (integer)
    The maximum speed of data exchange over the network in bytes per second for a query. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  max-network-bandwidth-for-user -> (integer)
    The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  max-parser-depth -> (integer)
    Limits maximum recursion depth in the recursive descent parser. Allows controlling the stack size. If set to **0**, recursion depth is unlimited. Default value: **1000**. For details, see ClickHouse documentation.
  max-partitions-per-insert-block -> (integer)
    When inserting data, ClickHouse calculates the number of partitions in the inserted block. If the number of partitions is more than **max_partitions_per_insert_block**, ClickHouse throws an exception. Default value: **100**. For details, see ClickHouse documentation.
  max-query-size -> (integer)
    Limits the size of the part of a query that can be transferred to RAM for parsing with the SQL parser, in bytes. Data in the **VALUES** clause of **INSERT** queries is processed by a separate stream parser (that consumes O(1) RAM) and not affected by this restriction. Default value: **262144** (256 KiB). For details, see ClickHouse documentation.
  max-read-buffer-size -> (integer)
    The maximum size of the buffer to read from the filesystem. Default value: **1048576** (1 MiB). For details, see ClickHouse documentation.
  max-replica-delay-for-distributed-queries -> (integer)
    Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used and becomes a stale one. Default value: **300000** (5 minutes). For details, see ClickHouse documentation.
  max-result-bytes -> (integer)
    Limits the result size in bytes (uncompressed data). **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  max-result-rows -> (integer)
    Limits the number of rows in the result. **0** means unlimited. This limitation is also checked for subqueries and parts of distributed queries that run on remote servers. Default value: **0**. For details, see ClickHouse documentation.
  max-rows-in-distinct -> (integer)
    Limits the maximum number of different rows in the state, which is used for performing **DISTINCT**. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  max-rows-in-join -> (integer)
    Limits the maximum number of rows in the hash table that is used when joining tables. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  max-rows-in-set -> (integer)
    Limits on the maximum number of rows in the set resulting from the execution of the **IN** section. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  max-rows-to-group-by -> (integer)
    Limits the maximum number of unique keys received from aggregation. **0** means unlimited. This setting lets you limit RAM consumption when aggregating. Default value: **0**. For details, see ClickHouse documentation.
  max-rows-to-read -> (integer)
    Limits the maximum number of rows that can be read from a table when running a query. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  max-rows-to-sort -> (integer)
    Limits the maximum number of rows that can be read from a table for sorting. **0** means unlimited. This setting lets you to limit RAM consumption when sorting Default value: **0**. For details, see ClickHouse documentation.
  max-rows-to-transfer -> (integer)
    Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using **GLOBAL IN|JOIN**. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  max-temporary-columns -> (integer)
    Limits the maximum number of temporary columns that must be kept in RAM simultaneously when running a query, including constant columns. **0** means unlimited. If the query generates more than the specified number of temporary columns in memory as a result of intermediate calculation, then it will be aborted. Default value: **0**. For details, see ClickHouse documentation.
  max-temporary-data-on-disk-size-for-query -> (integer)
    The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running queries. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  max-temporary-data-on-disk-size-for-user -> (integer)
    The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running user queries. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  max-temporary-non-const-columns -> (integer)
    Limits the maximum number of temporary columns that must be kept in RAM simultaneously when running a query, not including constant columns. **0** means unlimited. If the query generates more than the specified number of temporary columns in memory as a result of intermediate calculation, then it will be aborted. Default value: **0**. For details, see ClickHouse documentation.
  max-threads -> (integer)
    Limits the maximum number of threads to process the request. If set to **0**, the number of threads is calculated automatically based on the number of available CPU cores. The setting applies to threads that perform the same stages of the query processing pipeline in parallel. It does not take threads that read data from remote servers into account. For details, see ClickHouse documentation.
  memory-overcommit-ratio-denominator -> (integer)
    It represents the soft memory limit when the hard limit is reached on the global level. This value is used to compute the overcommit ratio for the query. **0** means skip the query. Default value: **1073741824** (1 GiB). For details, see ClickHouse documentation.
  memory-overcommit-ratio-denominator-for-user -> (integer)
    It represents the soft memory limit when the hard limit is reached on the user level. This value is used to compute the overcommit ratio for the user. **0** means skip the query. Default value: **1073741824** (1 GiB). For details, see ClickHouse documentation.
  memory-profiler-sample-probability -> (float64)
    Collect random allocations and deallocations and write them into system.trace_log with MemorySample trace_type. The probability is for every alloc/free regardless to the size of the allocation. Default value: **0**. For details, see ClickHouse documentation.
  memory-profiler-step -> (integer)
    Sets the step of memory profiler. Whenever query memory usage becomes larger than every next step in number of bytes the memory profiler will collect the allocating stacktrace and will write it into trace_log. If set to **0**, memory profiler is disabled. Default value: **4194304**. For details, see ClickHouse documentation.
  memory-usage-overcommit-max-wait-microseconds -> (integer)
    Maximum time thread will wait for memory to be freed in the case of memory overcommit. If the timeout is reached and memory is not freed, an exception is thrown. Default value: **5000000** (5 seconds). For details, see ClickHouse documentation.
  merge-tree-max-bytes-to-use-cache -> (integer)
    Limits the maximum size in bytes of the request that can use the cache of uncompressed data. The cache is not used for requests larger than the specified value. Use this setting in combination with **use_uncompressed_cache** setting. Default value: **2013265920** (1920 MiB). For details, see ClickHouse documentation.
  merge-tree-max-rows-to-use-cache -> (integer)
    Limits the maximum size in rows of the request that can use the cache of uncompressed data. The cache is not used for requests larger than the specified value. Use this setting in combination with **use_uncompressed_cache** setting. Default value: **1048576**. For details, see ClickHouse documentation.
  merge-tree-min-bytes-for-concurrent-read -> (integer)
    Limits the number of bytes to be read from a file to enable concurrent read. If the number of bytes to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently. This setting has effect only for tables of the MergeTree family. Default value: **251658240** (240 MiB). For details, see ClickHouse documentation.
  merge-tree-min-rows-for-concurrent-read -> (integer)
    Limits the minimum number of rows to be read from a file to enable concurrent read. If the number of rows to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently. This setting has effect only for tables of the MergeTree family. Default value: **163840**. For details, see ClickHouse documentation.
  min-bytes-to-use-direct-io -> (integer)
    Limits the minimum number of bytes to enable unbuffered direct reads from disk (Direct I/O). If set to **0**, Direct I/O is disabled. By default, ClickHouse does not read data directly from disk, but relies on the filesystem and its cache instead. Such reading strategy is effective when the data volume is small. If the amount of the data to read is huge, it is more effective to read directly from the disk, bypassing the filesystem cache. Default value: **0**. For details, see ClickHouse documentation.
  min-count-to-compile -> (integer)
    The setting is deprecated and has no effect.
  min-count-to-compile-expression -> (integer)
    How many identical expressions ClickHouse has to encounter before they are compiled. For the **0** value compilation is synchronous: a query waits for expression compilation process to complete prior to continuing execution. It is recommended to set this value only for testing purposes. For all other values, compilation is asynchronous: the compilation process executes in a separate thread. When a compiled expression is ready, it will be used by ClickHouse for eligible queries, including the ones that are currently running. Default value: **3**. For details, see ClickHouse documentation.
  min-execution-speed -> (integer)
    Minimal execution speed in rows per second. Checked on every data block when timeout_before_checking_execution_speed expires. If the execution speed is lower, an exception is thrown. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  min-execution-speed-bytes -> (integer)
    Minimal execution speed in bytes per second. Checked on every data block when timeout_before_checking_execution_speed expires. If the execution speed is lower, an exception is thrown. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  min-insert-block-size-bytes -> (integer)
    Limits the minimum number of bytes in a block to be inserted in a table by **INSERT** query. Blocks that are smaller than the specified value, will be squashed together into the bigger blocks. If set to **0**, block squashing is disabled. Default value: **268402944**. For details, see ClickHouse documentation.
  min-insert-block-size-rows -> (integer)
    Limits the minimum number of rows in a block to be inserted in a table by **INSERT** query. Blocks that are smaller than the specified value, will be squashed together into the bigger blocks. If set to **0**, block squashing is disabled. Default value: **1048449**. For details, see ClickHouse documentation.
  output-format-json-quote-64bit-integers -> (boolean)
    Enables or disables quoting of 64-bit integers in JSON output format. If this setting is enabled, then 64-bit integers (**UInt64** and **Int64**) will be quoted when written to JSON output in order to maintain compatibility with the most of the JavaScript engines. Otherwise, such integers will not be quoted. Default value: **false** for versions 25.8 and higher, **true** for versions 25.7 and lower. For details, see ClickHouse documentation.
  output-format-json-quote-denormals -> (boolean)
    Enables special floating-point values (**+nan**, **-nan**, **+inf** and **-inf**) in JSON output format. Default value: **false**. For details, see ClickHouse documentation.
  prefer-localhost-replica -> (boolean)
    Enable or disable preferable using the localhost replica when processing distributed queries. Default value: **true**. For details, see ClickHouse documentation.
  priority -> (integer)
    Sets the priority of a query. * **0** - priorities are not used. * **1** - the highest priority. * and so on. The higher the number, the lower a query's priority. If ClickHouse is working with the high-priority queries, and a low-priority query enters, then the low-priority query is paused until higher-priority queries are completed. Default value: **0**. For details, see ClickHouse documentation.
  query-cache-max-entries -> (integer)
    The maximum number of query results the current user may store in the query cache. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  query-cache-max-size-in-bytes -> (integer)
    The maximum amount of memory (in bytes) the current user may allocate in the query cache. **0** means unlimited. Default value: **0**. For details, see ClickHouse documentation.
  query-cache-min-query-duration -> (integer)
    Minimum duration in milliseconds a query needs to run for its result to be stored in the query cache. Default value: **0**. For details, see ClickHouse documentation.
  query-cache-min-query-runs -> (integer)
    Minimum number of times a **SELECT** query must run before its result is stored in the query cache. Default value: **0**. For details, see ClickHouse documentation.
  query-cache-nondeterministic-function-handling -> (struct)
    Controls how the query cache handles **SELECT** queries with non-deterministic functions like rand() or now(). Default value: **QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_THROW**. For details, see ClickHouse documentation.
  query-cache-share-between-users -> (boolean)
    If turned on, the result of **SELECT** queries cached in the query cache can be read by other users. It is not recommended to enable this setting due to security reasons. Default value: **false**. For details, see ClickHouse documentation.
  query-cache-system-table-handling -> (struct)
    Controls how the query cache handles **SELECT** queries against system tables. Default value: **QUERY_CACHE_SYSTEM_TABLE_HANDLING_THROW**. For details, see ClickHouse documentation.
  query-cache-tag -> (string)
    A string which acts as a label for query cache entries. The same queries with different tags are considered different by the query cache. For details, see ClickHouse documentation.
  query-cache-ttl -> (integer)
    After this time in seconds entries in the query cache become stale. Default value: **60** (1 minute). For details, see ClickHouse documentation.
  quota-mode -> (struct)
    Quota accounting mode. Default value: **QUOTA_MODE_DEFAULT**.
  read-overflow-mode -> (struct)
    Determines the behavior on exceeding limits while reading the data. Default value: **OVERFLOW_MODE_THROW**. For details, see ClickHouse documentation.
  readonly -> (integer)
    Restricts permissions for non-DDL queries. To restrict permissions for DDL queries, use **allow_ddl** instead. * **0** - no restrictions. * **1** - only read data queries are allowed. * **2** - read data and change settings queries are allowed. Default value: **0**. For details, see ClickHouse documentation.
  receive-timeout -> (integer)
    Receive timeout in milliseconds. Default value: **300000** (5 minutes). For details, see ClickHouse documentation.
  remote-filesystem-read-method -> (struct)
    Method of reading data from remote filesystem. Default value: **REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL**. For details, see ClickHouse documentation.
  replication-alter-partitions-sync -> (integer)
    Wait mode for asynchronous actions in **ALTER** queries on replicated tables. * **0** - do not wait for replicas. * **1** - only wait for own execution. * **2** - wait for all replicas. Default value: **1**. For details, see ClickHouse documentation.
  result-overflow-mode -> (struct)
    Determines the behavior on exceeding limits while forming result. Default value: **OVERFLOW_MODE_THROW**. For details, see ClickHouse documentation.
  s3-use-adaptive-timeouts -> (boolean)
    Enables or disables adaptive timeouts for S3 requests. * **true** - for all S3 requests first two attempts are made with low send and receive timeouts. * **false** - all attempts are made with identical timeouts. Default value: **true**. For details, see ClickHouse documentation.
  select-sequential-consistency -> (boolean)
    Determines the behavior of **SELECT** queries from replicated tables. If enabled, ClickHouse will terminate a query with error message in case the replica does not have a chunk written with the quorum and will not read the parts that have not yet been written with the quorum. Default value: **true**. For details, see ClickHouse documentation.
  send-progress-in-http-headers -> (boolean)
    Enables or disables progress notifications using **X-ClickHouse-Progress** HTTP header. Default value: **false**. For details, see ClickHouse documentation.
  send-timeout -> (integer)
    Send timeout in milliseconds. Default value: **300000** (5 minutes). For details, see ClickHouse documentation.
  set-overflow-mode -> (struct)
    Determines the behavior on exceeding max_rows_in_set or max_bytes_in_set limit. Default value: **OVERFLOW_MODE_THROW**. For details, see ClickHouse documentation.
  show-data-lake-catalogs-in-system-tables -> (boolean)
    Enables or disables showing data lake catalogs in system tables. Default value: **false** for versions 25.10 and higher, **true** for versions 25.9 and lower. For details, see ClickHouse documentation.
  skip-unavailable-shards -> (boolean)
    Enables or disables silent skipping of unavailable shards. A shard is considered unavailable if all its replicas are also unavailable. Default value: **false**. For details, see ClickHouse documentation.
  sort-overflow-mode -> (struct)
    Determines the behavior on exceeding limits while sorting. Default value: **OVERFLOW_MODE_THROW**. For details, see ClickHouse documentation.
  timeout-before-checking-execution-speed -> (integer)
    Checks that the speed is not too low after the specified time has elapsed, in milliseconds. It is checked that execution speed is not less that specified in **min_execution_speed** parameter. Default value: **60000** (1 minute). For details, see ClickHouse documentation.
  timeout-overflow-mode -> (struct)
    Determines the behavior on exceeding limits of execution time. Default value: **OVERFLOW_MODE_THROW**. For details, see ClickHouse documentation.
  transfer-overflow-mode -> (struct)
    Determines the behavior on exceeding limits while transfering data. Default value: **OVERFLOW_MODE_THROW**. For details, see ClickHouse documentation.
  transform-null-in -> (boolean)
    Enables equality of **NULL** values for **IN** operator. By default, **NULL** values can't be compared because **NULL** means undefined value. Thus, comparison **expr = NULL** must always return false. With this setting enabled **NULL = NULL** returns true for **IN** operator. Default value: **false**. For details, see ClickHouse documentation.
  use-hedged-requests -> (boolean)
    Enables or disables hedged requests logic for remote queries. It allows to establish many connections with different replicas for query. New connection is enabled in case existent connection(s) with replica(s) were not established within **hedged_connection_timeout** or no data was received within **receive_data_timeout**. Query uses the first connection which send non empty progress packet, other connections are cancelled. Default value: **true**. For details, see ClickHouse documentation.
  use-hive-partitioning -> (boolean)
    When enabled, ClickHouse will detect Hive-style partitioning in path (/name=value/) in file-like table engines File/S3/URL/HDFS/AzureBlobStorage and will allow to use partition columns as virtual columns in the query. These virtual columns will have the same names as in the partitioned path, but starting with _. Default value: **true** for versions 25.1 and higher, **false** for versions 24.12 and lower. For details, see ClickHouse documentation.
  use-query-cache -> (boolean)
    If turned on, **SELECT** queries may utilize the query cache. Default value: **false**. For details, see ClickHouse documentation.
  use-uncompressed-cache -> (boolean)
    Determines whether to use the cache of uncompressed blocks, or not. Using this cache can significantly reduce latency and increase the throughput when a huge amount of small queries is to be processed. Enable this setting for the users who instantiates small queries frequently. This setting has effect only for tables of the MergeTree family. Default value: **false**. For details, see ClickHouse documentation.
  wait-for-async-insert -> (boolean)
    Enables or disables waiting for processing of asynchronous insertion. If enabled, server returns OK only after the data is inserted. Default value: **true**. For details, see ClickHouse documentation.
  wait-for-async-insert-timeout -> (integer)
    Timeout for waiting for processing asynchronous inserts, in seconds. Default value: **120** (2 minutes). For details, see ClickHouse documentation.
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