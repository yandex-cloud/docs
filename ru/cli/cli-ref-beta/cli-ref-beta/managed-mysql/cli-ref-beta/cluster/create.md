---
editable: false
noIndex: true
---

# yc beta managed-mysql cluster create

Creates a cluster in a folder.

#### Command Usage

Syntax:

`yc beta managed-mysql cluster create <FOLDER-ID>`

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

Configuration of the cluster.

Shorthand Syntax:

```hcl
{
  access = {
    data-lens = boolean,
    data-transfer = boolean,
    web-sql = boolean,
    yandex-query = boolean
  },
  backup-retain-period-days = integer,
  backup-window-start = timeofday,
  disk-size-autoscaling = {
    disk-size-limit = integer,
    emergency-usage-threshold = integer,
    planned-usage-threshold = integer
  },
  mysql-config = mysql-config-5-7={
    audit-log = boolean,
    audit-log-policy = ALL|LOGINS|QUERIES|NONE,
    auto-increment-increment = integer,
    auto-increment-offset = integer,
    autocommit = boolean,
    binlog-cache-size = integer,
    binlog-group-commit-sync-delay = integer,
    binlog-row-image = FULL|MINIMAL|NOBLOB,
    binlog-rows-query-log-events = boolean,
    binlog-transaction-dependency-tracking = COMMIT_ORDER|WRITESET|WRITESET_SESSION,
    character-set-server = string,
    collation-server = string,
    default-authentication-plugin = MYSQL_NATIVE_PASSWORD|CACHING_SHA2_PASSWORD|SHA256_PASSWORD|MYSQL_NO_LOGIN|MDB_IAMPROXY_AUTH,
    default-time-zone = string,
    explicit-defaults-for-timestamp = boolean,
    general-log = boolean,
    group-concat-max-len = integer,
    innodb-adaptive-hash-index = boolean,
    innodb-buffer-pool-size = integer,
    innodb-change-buffering = INNODB_CHANGE_BUFFERING_NONE|INNODB_CHANGE_BUFFERING_INSERTS|INNODB_CHANGE_BUFFERING_DELETES|INNODB_CHANGE_BUFFERING_CHANGES|INNODB_CHANGE_BUFFERING_PURGES|INNODB_CHANGE_BUFFERING_ALL,
    innodb-compression-level = integer,
    innodb-flush-log-at-trx-commit = integer,
    innodb-ft-max-token-size = integer,
    innodb-ft-min-token-size = integer,
    innodb-io-capacity = integer,
    innodb-io-capacity-max = integer,
    innodb-lock-wait-timeout = integer,
    innodb-log-buffer-size = integer,
    innodb-log-file-size = integer,
    innodb-lru-scan-depth = integer,
    innodb-numa-interleave = boolean,
    innodb-online-alter-log-max-size = integer,
    innodb-page-size = integer,
    innodb-print-all-deadlocks = boolean,
    innodb-print-lock-wait-timeout-info = boolean,
    innodb-purge-threads = integer,
    innodb-read-io-threads = integer,
    innodb-status-output = boolean,
    innodb-strict-mode = boolean,
    innodb-temp-data-file-max-size = integer,
    innodb-thread-concurrency = integer,
    innodb-write-io-threads = integer,
    interactive-timeout = integer,
    join-buffer-size = integer,
    lock-wait-timeout = integer,
    log-error-verbosity = integer,
    log-slow-filter = [
      FULL_SCAN|FULL_JOIN|TMP_TABLE|TMP_TABLE_ON_DISK|FILESORT|FILESORT_ON_DISK, ...
    ],
    log-slow-rate-limit = integer,
    log-slow-rate-type = SESSION|QUERY,
    log-slow-sp-statements = boolean,
    long-query-time = float64,
    lower-case-table-names = integer,
    max-allowed-packet = integer,
    max-connections = integer,
    max-digest-length = integer,
    max-execution-time = integer,
    max-heap-table-size = integer,
    max-prepared-stmt-count = integer,
    max-sp-recursion-depth = integer,
    max-write-lock-count = integer,
    mdb-force-ssl = boolean,
    mdb-offline-mode-disable-lag = integer,
    mdb-offline-mode-enable-lag = integer,
    mdb-preserve-binlog-bytes = integer,
    mdb-priority-choice-max-lag = integer,
    net-read-timeout = integer,
    net-write-timeout = integer,
    optimizer-search-depth = integer,
    optimizer-switch = string,
    query-cache-limit = integer,
    query-cache-size = integer,
    query-cache-type = integer,
    query-response-time-stats = boolean,
    range-optimizer-max-mem-size = integer,
    rpl-semi-sync-master-wait-for-slave-count = integer,
    show-compatibility-56 = boolean,
    slave-parallel-type = DATABASE|LOGICAL_CLOCK,
    slave-parallel-workers = integer,
    slow-query-log = boolean,
    slow-query-log-always-write-time = float64,
    sort-buffer-size = integer,
    sql-mode = [
      ALLOW_INVALID_DATES|ANSI_QUOTES|ERROR_FOR_DIVISION_BY_ZERO|HIGH_NOT_PRECEDENCE|IGNORE_SPACE|NO_AUTO_VALUE_ON_ZERO|NO_BACKSLASH_ESCAPES|NO_ENGINE_SUBSTITUTION|NO_UNSIGNED_SUBTRACTION|NO_ZERO_DATE|NO_ZERO_IN_DATE|NO_FIELD_OPTIONS|NO_KEY_OPTIONS|NO_TABLE_OPTIONS|ONLY_FULL_GROUP_BY|PAD_CHAR_TO_FULL_LENGTH|PIPES_AS_CONCAT|REAL_AS_FLOAT|STRICT_ALL_TABLES|STRICT_TRANS_TABLES|ANSI|TRADITIONAL|DB2|MAXDB|MSSQL|MYSQL323|MYSQL40|ORACLE|POSTGRESQL|NO_AUTO_CREATE_USER|NO_DIR_IN_CREATE, ...
    ],
    sync-binlog = integer,
    table-definition-cache = integer,
    table-open-cache = integer,
    table-open-cache-instances = integer,
    thread-cache-size = integer,
    thread-stack = integer,
    tmp-table-size = integer,
    transaction-isolation = READ_COMMITTED|REPEATABLE_READ|SERIALIZABLE,
    userstat = boolean,
    wait-timeout = integer
  } | mysql-config-8-0={
    audit-log = boolean,
    audit-log-policy = ALL|LOGINS|QUERIES|NONE,
    auto-increment-increment = integer,
    auto-increment-offset = integer,
    autocommit = boolean,
    binlog-cache-size = integer,
    binlog-group-commit-sync-delay = integer,
    binlog-row-image = FULL|MINIMAL|NOBLOB,
    binlog-rows-query-log-events = boolean,
    binlog-transaction-dependency-tracking = COMMIT_ORDER|WRITESET|WRITESET_SESSION,
    character-set-server = string,
    collation-server = string,
    default-authentication-plugin = MYSQL_NATIVE_PASSWORD|CACHING_SHA2_PASSWORD|SHA256_PASSWORD|MYSQL_NO_LOGIN|MDB_IAMPROXY_AUTH,
    default-time-zone = string,
    explicit-defaults-for-timestamp = boolean,
    general-log = boolean,
    group-concat-max-len = integer,
    innodb-adaptive-hash-index = boolean,
    innodb-buffer-pool-size = integer,
    innodb-change-buffering = INNODB_CHANGE_BUFFERING_NONE|INNODB_CHANGE_BUFFERING_INSERTS|INNODB_CHANGE_BUFFERING_DELETES|INNODB_CHANGE_BUFFERING_CHANGES|INNODB_CHANGE_BUFFERING_PURGES|INNODB_CHANGE_BUFFERING_ALL,
    innodb-compression-level = integer,
    innodb-flush-log-at-trx-commit = integer,
    innodb-ft-max-token-size = integer,
    innodb-ft-min-token-size = integer,
    innodb-io-capacity = integer,
    innodb-io-capacity-max = integer,
    innodb-lock-wait-timeout = integer,
    innodb-log-buffer-size = integer,
    innodb-log-file-size = integer,
    innodb-lru-scan-depth = integer,
    innodb-numa-interleave = boolean,
    innodb-online-alter-log-max-size = integer,
    innodb-page-size = integer,
    innodb-print-all-deadlocks = boolean,
    innodb-print-lock-wait-timeout-info = boolean,
    innodb-purge-threads = integer,
    innodb-read-io-threads = integer,
    innodb-status-output = boolean,
    innodb-strict-mode = boolean,
    innodb-temp-data-file-max-size = integer,
    innodb-thread-concurrency = integer,
    innodb-write-io-threads = integer,
    interactive-timeout = integer,
    join-buffer-size = integer,
    lock-wait-timeout = integer,
    log-error-verbosity = integer,
    log-slow-filter = [
      FULL_SCAN|FULL_JOIN|TMP_TABLE|TMP_TABLE_ON_DISK|FILESORT|FILESORT_ON_DISK, ...
    ],
    log-slow-rate-limit = integer,
    log-slow-rate-type = SESSION|QUERY,
    log-slow-sp-statements = boolean,
    long-query-time = float64,
    lower-case-table-names = integer,
    max-allowed-packet = integer,
    max-connections = integer,
    max-digest-length = integer,
    max-execution-time = integer,
    max-heap-table-size = integer,
    max-prepared-stmt-count = integer,
    max-sp-recursion-depth = integer,
    max-write-lock-count = integer,
    mdb-force-ssl = boolean,
    mdb-offline-mode-disable-lag = integer,
    mdb-offline-mode-enable-lag = integer,
    mdb-preserve-binlog-bytes = integer,
    mdb-priority-choice-max-lag = integer,
    net-read-timeout = integer,
    net-write-timeout = integer,
    optimizer-search-depth = integer,
    optimizer-switch = string,
    range-optimizer-max-mem-size = integer,
    regexp-time-limit = integer,
    replication-optimize-for-static-plugin-config = boolean,
    replication-sender-observe-commit-only = boolean,
    rpl-semi-sync-master-wait-for-slave-count = integer,
    slave-parallel-type = DATABASE|LOGICAL_CLOCK,
    slave-parallel-workers = integer,
    slow-query-log = boolean,
    slow-query-log-always-write-time = float64,
    sort-buffer-size = integer,
    sql-mode = [
      ALLOW_INVALID_DATES|ANSI_QUOTES|ERROR_FOR_DIVISION_BY_ZERO|HIGH_NOT_PRECEDENCE|IGNORE_SPACE|NO_AUTO_VALUE_ON_ZERO|NO_BACKSLASH_ESCAPES|NO_ENGINE_SUBSTITUTION|NO_UNSIGNED_SUBTRACTION|NO_ZERO_DATE|NO_ZERO_IN_DATE|ONLY_FULL_GROUP_BY|PAD_CHAR_TO_FULL_LENGTH|PIPES_AS_CONCAT|REAL_AS_FLOAT|STRICT_ALL_TABLES|STRICT_TRANS_TABLES|TIME_TRUNCATE_FRACTIONAL|ANSI|TRADITIONAL|NO_DIR_IN_CREATE, ...
    ],
    sql-require-primary-key = boolean,
    sync-binlog = integer,
    table-definition-cache = integer,
    table-open-cache = integer,
    table-open-cache-instances = integer,
    thread-cache-size = integer,
    thread-stack = integer,
    tmp-table-size = integer,
    transaction-isolation = READ_COMMITTED|REPEATABLE_READ|SERIALIZABLE,
    userstat = boolean,
    wait-timeout = integer
  } | mysql-config-8-4={
    audit-log = boolean,
    audit-log-policy = ALL|LOGINS|QUERIES|NONE,
    auto-increment-increment = integer,
    auto-increment-offset = integer,
    autocommit = boolean,
    binlog-cache-size = integer,
    binlog-group-commit-sync-delay = integer,
    binlog-row-image = FULL|MINIMAL|NOBLOB,
    binlog-rows-query-log-events = boolean,
    character-set-server = string,
    collation-server = string,
    default-time-zone = string,
    explicit-defaults-for-timestamp = boolean,
    group-concat-max-len = integer,
    innodb-adaptive-hash-index = boolean,
    innodb-buffer-pool-size = integer,
    innodb-change-buffering = INNODB_CHANGE_BUFFERING_NONE|INNODB_CHANGE_BUFFERING_INSERTS|INNODB_CHANGE_BUFFERING_DELETES|INNODB_CHANGE_BUFFERING_CHANGES|INNODB_CHANGE_BUFFERING_PURGES|INNODB_CHANGE_BUFFERING_ALL,
    innodb-compression-level = integer,
    innodb-flush-log-at-trx-commit = integer,
    innodb-ft-max-token-size = integer,
    innodb-ft-min-token-size = integer,
    innodb-io-capacity = integer,
    innodb-io-capacity-max = integer,
    innodb-lock-wait-timeout = integer,
    innodb-log-buffer-size = integer,
    innodb-log-file-size = integer,
    innodb-lru-scan-depth = integer,
    innodb-numa-interleave = boolean,
    innodb-online-alter-log-max-size = integer,
    innodb-page-size = integer,
    innodb-print-all-deadlocks = boolean,
    innodb-print-lock-wait-timeout-info = boolean,
    innodb-purge-threads = integer,
    innodb-read-io-threads = integer,
    innodb-status-output = boolean,
    innodb-strict-mode = boolean,
    innodb-temp-data-file-max-size = integer,
    innodb-thread-concurrency = integer,
    innodb-write-io-threads = integer,
    interactive-timeout = integer,
    join-buffer-size = integer,
    lock-wait-timeout = integer,
    log-error-verbosity = integer,
    log-slow-filter = [
      FULL_SCAN|FULL_JOIN|TMP_TABLE|TMP_TABLE_ON_DISK|FILESORT|FILESORT_ON_DISK, ...
    ],
    log-slow-rate-limit = integer,
    log-slow-rate-type = SESSION|QUERY,
    log-slow-sp-statements = boolean,
    long-query-time = float64,
    lower-case-table-names = integer,
    max-allowed-packet = integer,
    max-connections = integer,
    max-digest-length = integer,
    max-execution-time = integer,
    max-heap-table-size = integer,
    max-prepared-stmt-count = integer,
    max-sp-recursion-depth = integer,
    max-write-lock-count = integer,
    mdb-async-allowed-lag = integer,
    mdb-force-ssl = boolean,
    mdb-offline-mode-disable-lag = integer,
    mdb-offline-mode-enable-lag = integer,
    mdb-preserve-binlog-bytes = integer,
    mdb-priority-choice-max-lag = integer,
    mdb-use-async-replication = boolean,
    net-read-timeout = integer,
    net-write-timeout = integer,
    optimizer-search-depth = integer,
    optimizer-switch = string,
    range-optimizer-max-mem-size = integer,
    regexp-time-limit = integer,
    replication-optimize-for-static-plugin-config = boolean,
    replication-sender-observe-commit-only = boolean,
    rpl-semi-sync-master-wait-for-slave-count = integer,
    slave-parallel-type = DATABASE|LOGICAL_CLOCK,
    slave-parallel-workers = integer,
    slow-query-log = boolean,
    slow-query-log-always-write-time = float64,
    sort-buffer-size = integer,
    sql-mode = [
      ALLOW_INVALID_DATES|ANSI_QUOTES|ERROR_FOR_DIVISION_BY_ZERO|HIGH_NOT_PRECEDENCE|IGNORE_SPACE|NO_AUTO_VALUE_ON_ZERO|NO_BACKSLASH_ESCAPES|NO_ENGINE_SUBSTITUTION|NO_UNSIGNED_SUBTRACTION|NO_ZERO_DATE|NO_ZERO_IN_DATE|ONLY_FULL_GROUP_BY|PAD_CHAR_TO_FULL_LENGTH|PIPES_AS_CONCAT|REAL_AS_FLOAT|STRICT_ALL_TABLES|STRICT_TRANS_TABLES|TIME_TRUNCATE_FRACTIONAL|ANSI|TRADITIONAL|NO_DIR_IN_CREATE, ...
    ],
    sql-require-primary-key = boolean,
    sync-binlog = integer,
    table-definition-cache = integer,
    table-open-cache = integer,
    table-open-cache-instances = integer,
    thread-cache-size = integer,
    thread-stack = integer,
    tmp-table-size = integer,
    transaction-isolation = READ_COMMITTED|REPEATABLE_READ|SERIALIZABLE,
    userstat = boolean,
    wait-timeout = integer
  },
  performance-diagnostics = {
    enabled = boolean,
    sessions-sampling-interval = integer,
    statements-sampling-interval = integer
  },
  resources = {
    disk-size = integer,
    disk-type-id = string,
    resource-preset-id = string
  },
  version = string
}
```

JSON Syntax:

```json
{
  "access": {
    "data-lens": "boolean",
    "data-transfer": "boolean",
    "web-sql": "boolean",
    "yandex-query": "boolean"
  },
  "backup-retain-period-days": "integer",
  "backup-window-start": "timeofday",
  "disk-size-autoscaling": {
    "disk-size-limit": "integer",
    "emergency-usage-threshold": "integer",
    "planned-usage-threshold": "integer"
  },
  "mysql-config": {
    "mysql-config-5-7": {
      "audit-log": "boolean",
      "audit-log-policy": "ALL|LOGINS|QUERIES|NONE",
      "auto-increment-increment": "integer",
      "auto-increment-offset": "integer",
      "autocommit": "boolean",
      "binlog-cache-size": "integer",
      "binlog-group-commit-sync-delay": "integer",
      "binlog-row-image": "FULL|MINIMAL|NOBLOB",
      "binlog-rows-query-log-events": "boolean",
      "binlog-transaction-dependency-tracking": "COMMIT_ORDER|WRITESET|WRITESET_SESSION",
      "character-set-server": "string",
      "collation-server": "string",
      "default-authentication-plugin": "MYSQL_NATIVE_PASSWORD|CACHING_SHA2_PASSWORD|SHA256_PASSWORD|MYSQL_NO_LOGIN|MDB_IAMPROXY_AUTH",
      "default-time-zone": "string",
      "explicit-defaults-for-timestamp": "boolean",
      "general-log": "boolean",
      "group-concat-max-len": "integer",
      "innodb-adaptive-hash-index": "boolean",
      "innodb-buffer-pool-size": "integer",
      "innodb-change-buffering": "INNODB_CHANGE_BUFFERING_NONE|INNODB_CHANGE_BUFFERING_INSERTS|INNODB_CHANGE_BUFFERING_DELETES|INNODB_CHANGE_BUFFERING_CHANGES|INNODB_CHANGE_BUFFERING_PURGES|INNODB_CHANGE_BUFFERING_ALL",
      "innodb-compression-level": "integer",
      "innodb-flush-log-at-trx-commit": "integer",
      "innodb-ft-max-token-size": "integer",
      "innodb-ft-min-token-size": "integer",
      "innodb-io-capacity": "integer",
      "innodb-io-capacity-max": "integer",
      "innodb-lock-wait-timeout": "integer",
      "innodb-log-buffer-size": "integer",
      "innodb-log-file-size": "integer",
      "innodb-lru-scan-depth": "integer",
      "innodb-numa-interleave": "boolean",
      "innodb-online-alter-log-max-size": "integer",
      "innodb-page-size": "integer",
      "innodb-print-all-deadlocks": "boolean",
      "innodb-print-lock-wait-timeout-info": "boolean",
      "innodb-purge-threads": "integer",
      "innodb-read-io-threads": "integer",
      "innodb-status-output": "boolean",
      "innodb-strict-mode": "boolean",
      "innodb-temp-data-file-max-size": "integer",
      "innodb-thread-concurrency": "integer",
      "innodb-write-io-threads": "integer",
      "interactive-timeout": "integer",
      "join-buffer-size": "integer",
      "lock-wait-timeout": "integer",
      "log-error-verbosity": "integer",
      "log-slow-filter": [
        "FULL_SCAN|FULL_JOIN|TMP_TABLE|TMP_TABLE_ON_DISK|FILESORT|FILESORT_ON_DISK", ...
      ],
      "log-slow-rate-limit": "integer",
      "log-slow-rate-type": "SESSION|QUERY",
      "log-slow-sp-statements": "boolean",
      "long-query-time": "float64",
      "lower-case-table-names": "integer",
      "max-allowed-packet": "integer",
      "max-connections": "integer",
      "max-digest-length": "integer",
      "max-execution-time": "integer",
      "max-heap-table-size": "integer",
      "max-prepared-stmt-count": "integer",
      "max-sp-recursion-depth": "integer",
      "max-write-lock-count": "integer",
      "mdb-force-ssl": "boolean",
      "mdb-offline-mode-disable-lag": "integer",
      "mdb-offline-mode-enable-lag": "integer",
      "mdb-preserve-binlog-bytes": "integer",
      "mdb-priority-choice-max-lag": "integer",
      "net-read-timeout": "integer",
      "net-write-timeout": "integer",
      "optimizer-search-depth": "integer",
      "optimizer-switch": "string",
      "query-cache-limit": "integer",
      "query-cache-size": "integer",
      "query-cache-type": "integer",
      "query-response-time-stats": "boolean",
      "range-optimizer-max-mem-size": "integer",
      "rpl-semi-sync-master-wait-for-slave-count": "integer",
      "show-compatibility-56": "boolean",
      "slave-parallel-type": "DATABASE|LOGICAL_CLOCK",
      "slave-parallel-workers": "integer",
      "slow-query-log": "boolean",
      "slow-query-log-always-write-time": "float64",
      "sort-buffer-size": "integer",
      "sql-mode": [
        "ALLOW_INVALID_DATES|ANSI_QUOTES|ERROR_FOR_DIVISION_BY_ZERO|HIGH_NOT_PRECEDENCE|IGNORE_SPACE|NO_AUTO_VALUE_ON_ZERO|NO_BACKSLASH_ESCAPES|NO_ENGINE_SUBSTITUTION|NO_UNSIGNED_SUBTRACTION|NO_ZERO_DATE|NO_ZERO_IN_DATE|NO_FIELD_OPTIONS|NO_KEY_OPTIONS|NO_TABLE_OPTIONS|ONLY_FULL_GROUP_BY|PAD_CHAR_TO_FULL_LENGTH|PIPES_AS_CONCAT|REAL_AS_FLOAT|STRICT_ALL_TABLES|STRICT_TRANS_TABLES|ANSI|TRADITIONAL|DB2|MAXDB|MSSQL|MYSQL323|MYSQL40|ORACLE|POSTGRESQL|NO_AUTO_CREATE_USER|NO_DIR_IN_CREATE", ...
      ],
      "sync-binlog": "integer",
      "table-definition-cache": "integer",
      "table-open-cache": "integer",
      "table-open-cache-instances": "integer",
      "thread-cache-size": "integer",
      "thread-stack": "integer",
      "tmp-table-size": "integer",
      "transaction-isolation": "READ_COMMITTED|REPEATABLE_READ|SERIALIZABLE",
      "userstat": "boolean",
      "wait-timeout": "integer"
    },
    "mysql-config-8-0": {
      "audit-log": "boolean",
      "audit-log-policy": "ALL|LOGINS|QUERIES|NONE",
      "auto-increment-increment": "integer",
      "auto-increment-offset": "integer",
      "autocommit": "boolean",
      "binlog-cache-size": "integer",
      "binlog-group-commit-sync-delay": "integer",
      "binlog-row-image": "FULL|MINIMAL|NOBLOB",
      "binlog-rows-query-log-events": "boolean",
      "binlog-transaction-dependency-tracking": "COMMIT_ORDER|WRITESET|WRITESET_SESSION",
      "character-set-server": "string",
      "collation-server": "string",
      "default-authentication-plugin": "MYSQL_NATIVE_PASSWORD|CACHING_SHA2_PASSWORD|SHA256_PASSWORD|MYSQL_NO_LOGIN|MDB_IAMPROXY_AUTH",
      "default-time-zone": "string",
      "explicit-defaults-for-timestamp": "boolean",
      "general-log": "boolean",
      "group-concat-max-len": "integer",
      "innodb-adaptive-hash-index": "boolean",
      "innodb-buffer-pool-size": "integer",
      "innodb-change-buffering": "INNODB_CHANGE_BUFFERING_NONE|INNODB_CHANGE_BUFFERING_INSERTS|INNODB_CHANGE_BUFFERING_DELETES|INNODB_CHANGE_BUFFERING_CHANGES|INNODB_CHANGE_BUFFERING_PURGES|INNODB_CHANGE_BUFFERING_ALL",
      "innodb-compression-level": "integer",
      "innodb-flush-log-at-trx-commit": "integer",
      "innodb-ft-max-token-size": "integer",
      "innodb-ft-min-token-size": "integer",
      "innodb-io-capacity": "integer",
      "innodb-io-capacity-max": "integer",
      "innodb-lock-wait-timeout": "integer",
      "innodb-log-buffer-size": "integer",
      "innodb-log-file-size": "integer",
      "innodb-lru-scan-depth": "integer",
      "innodb-numa-interleave": "boolean",
      "innodb-online-alter-log-max-size": "integer",
      "innodb-page-size": "integer",
      "innodb-print-all-deadlocks": "boolean",
      "innodb-print-lock-wait-timeout-info": "boolean",
      "innodb-purge-threads": "integer",
      "innodb-read-io-threads": "integer",
      "innodb-status-output": "boolean",
      "innodb-strict-mode": "boolean",
      "innodb-temp-data-file-max-size": "integer",
      "innodb-thread-concurrency": "integer",
      "innodb-write-io-threads": "integer",
      "interactive-timeout": "integer",
      "join-buffer-size": "integer",
      "lock-wait-timeout": "integer",
      "log-error-verbosity": "integer",
      "log-slow-filter": [
        "FULL_SCAN|FULL_JOIN|TMP_TABLE|TMP_TABLE_ON_DISK|FILESORT|FILESORT_ON_DISK", ...
      ],
      "log-slow-rate-limit": "integer",
      "log-slow-rate-type": "SESSION|QUERY",
      "log-slow-sp-statements": "boolean",
      "long-query-time": "float64",
      "lower-case-table-names": "integer",
      "max-allowed-packet": "integer",
      "max-connections": "integer",
      "max-digest-length": "integer",
      "max-execution-time": "integer",
      "max-heap-table-size": "integer",
      "max-prepared-stmt-count": "integer",
      "max-sp-recursion-depth": "integer",
      "max-write-lock-count": "integer",
      "mdb-force-ssl": "boolean",
      "mdb-offline-mode-disable-lag": "integer",
      "mdb-offline-mode-enable-lag": "integer",
      "mdb-preserve-binlog-bytes": "integer",
      "mdb-priority-choice-max-lag": "integer",
      "net-read-timeout": "integer",
      "net-write-timeout": "integer",
      "optimizer-search-depth": "integer",
      "optimizer-switch": "string",
      "range-optimizer-max-mem-size": "integer",
      "regexp-time-limit": "integer",
      "replication-optimize-for-static-plugin-config": "boolean",
      "replication-sender-observe-commit-only": "boolean",
      "rpl-semi-sync-master-wait-for-slave-count": "integer",
      "slave-parallel-type": "DATABASE|LOGICAL_CLOCK",
      "slave-parallel-workers": "integer",
      "slow-query-log": "boolean",
      "slow-query-log-always-write-time": "float64",
      "sort-buffer-size": "integer",
      "sql-mode": [
        "ALLOW_INVALID_DATES|ANSI_QUOTES|ERROR_FOR_DIVISION_BY_ZERO|HIGH_NOT_PRECEDENCE|IGNORE_SPACE|NO_AUTO_VALUE_ON_ZERO|NO_BACKSLASH_ESCAPES|NO_ENGINE_SUBSTITUTION|NO_UNSIGNED_SUBTRACTION|NO_ZERO_DATE|NO_ZERO_IN_DATE|ONLY_FULL_GROUP_BY|PAD_CHAR_TO_FULL_LENGTH|PIPES_AS_CONCAT|REAL_AS_FLOAT|STRICT_ALL_TABLES|STRICT_TRANS_TABLES|TIME_TRUNCATE_FRACTIONAL|ANSI|TRADITIONAL|NO_DIR_IN_CREATE", ...
      ],
      "sql-require-primary-key": "boolean",
      "sync-binlog": "integer",
      "table-definition-cache": "integer",
      "table-open-cache": "integer",
      "table-open-cache-instances": "integer",
      "thread-cache-size": "integer",
      "thread-stack": "integer",
      "tmp-table-size": "integer",
      "transaction-isolation": "READ_COMMITTED|REPEATABLE_READ|SERIALIZABLE",
      "userstat": "boolean",
      "wait-timeout": "integer"
    },
    "mysql-config-8-4": {
      "audit-log": "boolean",
      "audit-log-policy": "ALL|LOGINS|QUERIES|NONE",
      "auto-increment-increment": "integer",
      "auto-increment-offset": "integer",
      "autocommit": "boolean",
      "binlog-cache-size": "integer",
      "binlog-group-commit-sync-delay": "integer",
      "binlog-row-image": "FULL|MINIMAL|NOBLOB",
      "binlog-rows-query-log-events": "boolean",
      "character-set-server": "string",
      "collation-server": "string",
      "default-time-zone": "string",
      "explicit-defaults-for-timestamp": "boolean",
      "group-concat-max-len": "integer",
      "innodb-adaptive-hash-index": "boolean",
      "innodb-buffer-pool-size": "integer",
      "innodb-change-buffering": "INNODB_CHANGE_BUFFERING_NONE|INNODB_CHANGE_BUFFERING_INSERTS|INNODB_CHANGE_BUFFERING_DELETES|INNODB_CHANGE_BUFFERING_CHANGES|INNODB_CHANGE_BUFFERING_PURGES|INNODB_CHANGE_BUFFERING_ALL",
      "innodb-compression-level": "integer",
      "innodb-flush-log-at-trx-commit": "integer",
      "innodb-ft-max-token-size": "integer",
      "innodb-ft-min-token-size": "integer",
      "innodb-io-capacity": "integer",
      "innodb-io-capacity-max": "integer",
      "innodb-lock-wait-timeout": "integer",
      "innodb-log-buffer-size": "integer",
      "innodb-log-file-size": "integer",
      "innodb-lru-scan-depth": "integer",
      "innodb-numa-interleave": "boolean",
      "innodb-online-alter-log-max-size": "integer",
      "innodb-page-size": "integer",
      "innodb-print-all-deadlocks": "boolean",
      "innodb-print-lock-wait-timeout-info": "boolean",
      "innodb-purge-threads": "integer",
      "innodb-read-io-threads": "integer",
      "innodb-status-output": "boolean",
      "innodb-strict-mode": "boolean",
      "innodb-temp-data-file-max-size": "integer",
      "innodb-thread-concurrency": "integer",
      "innodb-write-io-threads": "integer",
      "interactive-timeout": "integer",
      "join-buffer-size": "integer",
      "lock-wait-timeout": "integer",
      "log-error-verbosity": "integer",
      "log-slow-filter": [
        "FULL_SCAN|FULL_JOIN|TMP_TABLE|TMP_TABLE_ON_DISK|FILESORT|FILESORT_ON_DISK", ...
      ],
      "log-slow-rate-limit": "integer",
      "log-slow-rate-type": "SESSION|QUERY",
      "log-slow-sp-statements": "boolean",
      "long-query-time": "float64",
      "lower-case-table-names": "integer",
      "max-allowed-packet": "integer",
      "max-connections": "integer",
      "max-digest-length": "integer",
      "max-execution-time": "integer",
      "max-heap-table-size": "integer",
      "max-prepared-stmt-count": "integer",
      "max-sp-recursion-depth": "integer",
      "max-write-lock-count": "integer",
      "mdb-async-allowed-lag": "integer",
      "mdb-force-ssl": "boolean",
      "mdb-offline-mode-disable-lag": "integer",
      "mdb-offline-mode-enable-lag": "integer",
      "mdb-preserve-binlog-bytes": "integer",
      "mdb-priority-choice-max-lag": "integer",
      "mdb-use-async-replication": "boolean",
      "net-read-timeout": "integer",
      "net-write-timeout": "integer",
      "optimizer-search-depth": "integer",
      "optimizer-switch": "string",
      "range-optimizer-max-mem-size": "integer",
      "regexp-time-limit": "integer",
      "replication-optimize-for-static-plugin-config": "boolean",
      "replication-sender-observe-commit-only": "boolean",
      "rpl-semi-sync-master-wait-for-slave-count": "integer",
      "slave-parallel-type": "DATABASE|LOGICAL_CLOCK",
      "slave-parallel-workers": "integer",
      "slow-query-log": "boolean",
      "slow-query-log-always-write-time": "float64",
      "sort-buffer-size": "integer",
      "sql-mode": [
        "ALLOW_INVALID_DATES|ANSI_QUOTES|ERROR_FOR_DIVISION_BY_ZERO|HIGH_NOT_PRECEDENCE|IGNORE_SPACE|NO_AUTO_VALUE_ON_ZERO|NO_BACKSLASH_ESCAPES|NO_ENGINE_SUBSTITUTION|NO_UNSIGNED_SUBTRACTION|NO_ZERO_DATE|NO_ZERO_IN_DATE|ONLY_FULL_GROUP_BY|PAD_CHAR_TO_FULL_LENGTH|PIPES_AS_CONCAT|REAL_AS_FLOAT|STRICT_ALL_TABLES|STRICT_TRANS_TABLES|TIME_TRUNCATE_FRACTIONAL|ANSI|TRADITIONAL|NO_DIR_IN_CREATE", ...
      ],
      "sql-require-primary-key": "boolean",
      "sync-binlog": "integer",
      "table-definition-cache": "integer",
      "table-open-cache": "integer",
      "table-open-cache-instances": "integer",
      "thread-cache-size": "integer",
      "thread-stack": "integer",
      "tmp-table-size": "integer",
      "transaction-isolation": "READ_COMMITTED|REPEATABLE_READ|SERIALIZABLE",
      "userstat": "boolean",
      "wait-timeout": "integer"
    }
  },
  "performance-diagnostics": {
    "enabled": "boolean",
    "sessions-sampling-interval": "integer",
    "statements-sampling-interval": "integer"
  },
  "resources": {
    "disk-size": "integer",
    "disk-type-id": "string",
    "resource-preset-id": "string"
  },
  "version": "string"
}
```

Fields:

```
access -> (struct)
  Access policy for external services. If the specific services need to access the cluster, then set the necessary values in this policy.
  data-lens -> (boolean)
    Allows access from DataLens. See documentation for details.
  data-transfer -> (boolean)
    Allow access for DataTransfer.
  web-sql -> (boolean)
    Allows SQL queries to the cluster databases from management console. See documentation for details.
  yandex-query -> (boolean)
    Allow access for YandexQuery.
backup-retain-period-days -> (integer)
  Retention policy of automated backups.
backup-window-start -> (timeofday)
  Time to start the daily backup, in the UTC timezone.
disk-size-autoscaling -> (struct)
  Disk size autoscaling
  disk-size-limit -> (integer)
    Limit on how large the storage for database instances can automatically grow, in bytes.
  emergency-usage-threshold -> (integer)
    Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
  planned-usage-threshold -> (integer)
    Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
performance-diagnostics -> (struct)
  Configuration of the performance diagnostics service.
  enabled -> (boolean)
    Flag that shows if performance statistics gathering is enabled for the cluster.
  sessions-sampling-interval -> (integer)
    Interval (in seconds) for 'my_session' sampling.
  statements-sampling-interval -> (integer)
    Interval (in seconds) for 'my_statements' sampling.
resources -> (struct)
  Resource preset for the cluster hosts.
  disk-size -> (integer)
    Volume of the storage (for each cluster host, in bytes).
  disk-type-id -> (string)
    Type of the storage. Possible values: * 'network-hdd' - standard network storage * 'network-ssd' - fast network storage * 'network-ssd-nonreplicated' - fast network nonreplicated storage * 'local-ssd' - fast local storage. See documentation for details.
  resource-preset-id -> (string)
    ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. All available presets are listed in documentation.
version -> (string)
  Version of MySQL used in the cluster. Possible values: '5.7', '8.0', '8.4'.
mysql-config -> (oneof<mysql-config-5-7|mysql-config-8-0|mysql-config-8-4>)
  Oneof mysql-config field
  mysql-config-5-7 -> (struct)
    Configuration for a MySQL 5.7 cluster.
    audit-log -> (boolean)
      Enable writing of audit log of MySQL. See MySQL documentation for details.
    audit-log-policy -> (struct)
      The policy controlling how the audit log plugin writes events to its log file For details, see MySQL documentation for the variable
    auto-increment-increment -> (integer)
      Can be used to control the operation of AUTO_INCREMENT columns. See MySQL documentation for details.
    auto-increment-offset -> (integer)
      Can be used to control the operation of AUTO_INCREMENT columns. See MySQL documentation for details.
    autocommit -> (boolean)
      Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it. For details, see MySQL documentation for the variable.
    binlog-cache-size -> (integer)
      The size of the cache to hold changes to the binary log during a transaction. See MySQL documentation for details.
    binlog-group-commit-sync-delay -> (integer)
      Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk. See MySQL documentation for the variable for details.
    binlog-row-image -> (struct)
      For MySQL row-based replication, this variable determines how row images are written to the binary log. See MySQL documentation for details.
    binlog-rows-query-log-events -> (boolean)
      When enabled, it causes the server to write informational log events such as row query log events into its binary log. See MySQL documentation for details.
    binlog-transaction-dependency-tracking -> (struct)
      Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel. For details, see MySQL documentation for the variable.
    character-set-server -> (string)
      The servers default character set. See MySQL documentation for details.
    collation-server -> (string)
      The server default collation. See MySQL documentation for details.
    default-authentication-plugin -> (struct)
      Authentication plugin used in the managed MySQL cluster. See MySQL documentation for details.
    default-time-zone -> (string)
      The servers default time zone. See MySQL documentation for details.
    explicit-defaults-for-timestamp -> (boolean)
      Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns. See MySQL documentation for details.
    general-log -> (boolean)
      Enable writing of general query log of MySQL. See MySQL documentation for details.
    group-concat-max-len -> (integer)
      The maximum permitted result length in bytes for the GROUP_CONCAT() function. See MySQL documentation for details.
    innodb-adaptive-hash-index -> (boolean)
      Enables InnoDB adaptive hash index. See MySQL documentation for details.
    innodb-buffer-pool-size -> (integer)
      Size of the InnoDB buffer pool used for caching table and index data. See MySQL documentation for details.
    innodb-change-buffering -> (struct)
      An optimization for change buffering For details, see MySQL documentation for the variable.
    innodb-compression-level -> (integer)
      The level of zlib compression to use for InnoDB compressed tables and indexes. For details, see MySQL documentation for the variable.
    innodb-flush-log-at-trx-commit -> (integer)
      Transaction log flush behaviour. See MySQL documentation for details.
    innodb-ft-max-token-size -> (integer)
      Maximum length of words that are stored in an InnoDB FULLTEXT index For details, see MySQL documentation for the variable.
    innodb-ft-min-token-size -> (integer)
      Minimum length of words that are stored in an InnoDB FULLTEXT index For details, see MySQL documentation for the variable.
    innodb-io-capacity -> (integer)
      Limits IO available for InnoDB background tasks. See MySQL documentation for details.
    innodb-io-capacity-max -> (integer)
      Limits IO available for InnoDB background tasks. See MySQL documentation for details.
    innodb-lock-wait-timeout -> (integer)
      Max time in seconds for a transaction to wait for a row lock. See MySQL documentation for details.
    innodb-log-buffer-size -> (integer)
      The size in bytes of the buffer that InnoDB uses to write to the log files on disk. See MySQL documentation for details.
    innodb-log-file-size -> (integer)
      The size in bytes of the single InnoDB Redo log file. See MySQL documentation for details.
    innodb-lru-scan-depth -> (integer)
      A parameter that influences the algorithms and heuristics for the flush operation for the InnoDB buffer pool For details, see MySQL documentation for the variable
    innodb-numa-interleave -> (boolean)
      Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool. See MySQL documentation for details.
    innodb-online-alter-log-max-size -> (integer)
      The limit in bytes on the size of the temporary log files used during online DDL operations For details, see MySQL documentation for the variable.
    innodb-page-size -> (integer)
      Specifies the page size for InnoDB tablespaces. For details, see MySQL documentation for the variable.
    innodb-print-all-deadlocks -> (boolean)
      Print information about deadlocks in error log. See MySQL documentation for details.
    innodb-print-lock-wait-timeout-info -> (boolean)
      Makes InnoDB to write information about all lock wait timeout errors into the log file. For details, see Percona documentation for the variable.
    innodb-purge-threads -> (integer)
      The number of background threads devoted to the InnoDB purge operation. See MySQL documentation for details.
    innodb-read-io-threads -> (integer)
      The number of I/O threads for read operations in InnoDB. See MySQL documentation for details.
    innodb-status-output -> (boolean)
      Enables or disables periodic output for the standard InnoDB Monitor. For details, see MySQL documentation for the variable.
    innodb-strict-mode -> (boolean)
      When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options. For details, see MySQL documentation for the variable.
    innodb-temp-data-file-max-size -> (integer)
      Limits the max size of InnoDB temp tablespace. See MySQL documentation for details.
    innodb-thread-concurrency -> (integer)
      Defines the maximum number of threads permitted inside of InnoDB. See MySQL documentation for details.
    innodb-write-io-threads -> (integer)
      The number of I/O threads for write operations in InnoDB. See MySQL documentation for details.
    interactive-timeout -> (integer)
      The number of seconds the server waits for activity on an interactive connection before closing it. See MySQL documentation for details.
    join-buffer-size -> (integer)
      The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans. See MySQL documentation for details.
    lock-wait-timeout -> (integer)
      // This variable specifies the timeout in seconds for attempts to acquire metadata locks For details, see MySQL documentation for the variable.
    log-error-verbosity -> (integer)
      System variable specifies the verbosity for handling events intended for the error log For details, see MySQL documentation for the variable.
    log-slow-filter -> ([]struct)
      Filters the slow log by the query's execution plan. See Percona documentation for details.
    log-slow-rate-limit -> (integer)
      Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query. See Percona documentation for details.
    log-slow-rate-type -> (struct)
      Specifies slow log granularity for 'log_slow_rate_limit' values QUERY or SESSION. See Percona documentation for details.
    log-slow-sp-statements -> (boolean)
      When TRUE, statements executed by stored procedures are logged to the slow log. See Percona documentation for details.
    long-query-time -> (float64)
      Time that it takes to process a query before it is considered slow. See MySQL documentation for details.
    lower-case-table-names -> (integer)
      Table names storage and comparison strategy For details, see MySQL documentation for the variable.
    max-allowed-packet -> (integer)
      The maximum size in bytes of one packet. See MySQL documentation for details.
    max-connections -> (integer)
      The maximum permitted number of simultaneous client connections. See MySQL documentation for details.
    max-digest-length -> (integer)
      The maximum number of bytes of memory reserved per session for computation of normalized statement digests. For details, see MySQL documentation for the variable.
    max-execution-time -> (integer)
      The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled. For details, see MySQL documentation for the variable
    max-heap-table-size -> (integer)
      This variable sets the maximum size to which user-created MEMORY tables are permitted to grow. See MySQL documentation for details.
    max-prepared-stmt-count -> (integer)
      This variable limits the total number of prepared statements in the server. For details, see MySQL documentation for the variable.
    max-sp-recursion-depth -> (integer)
      The number of times that any given stored procedure may be called recursively. For details, see MySQL documentation for the variable.
    max-write-lock-count -> (integer)
      Permit some pending read lock requests interval P.S. Should be UInt64, but java fails to handle UInt64 limits For details, see Percona documentation for the variable.
    mdb-force-ssl -> (boolean)
      Force ssl on all hosts (require_secure_transport)
    mdb-offline-mode-disable-lag -> (integer)
      Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'. Should be less than mdb_offline_mode_enable_lag value.
    mdb-offline-mode-enable-lag -> (integer)
      Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.
    mdb-preserve-binlog-bytes -> (integer)
      The size of the binary log to hold.
    mdb-priority-choice-max-lag -> (integer)
      Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from". Should be less than mdb_offline_mode_disable_lag.
    net-read-timeout -> (integer)
      The number of seconds to wait for more data from a connection before aborting the read. See MySQL documentation for details.
    net-write-timeout -> (integer)
      The number of seconds to wait for a block to be written to a connection before aborting the write. See MySQL documentation for details.
    optimizer-search-depth -> (integer)
      The maximum depth of search performed by the query optimizer For details, see MySQL documentation for the variable
    optimizer-switch -> (string)
      The system variable enables control over optimizer behavior. For details, see MySQL documentation for the variable https://dev.mysql.com/doc/refman/5.7/en/switchable-optimizations.html
    query-cache-limit -> (integer)
      Do not cache results that are larger than this number of bytes. For details, see MySQL documentation for the variable.
    query-cache-size -> (integer)
      The amount of memory allocated for caching query results. For details, see MySQL documentation for the variable.
    query-cache-type -> (integer)
      Set the query cache type. For details, see MySQL documentation for the variable.
    query-response-time-stats -> (boolean)
      Enables and disables collection of query times For details, see Percona documentation for the variable.
    range-optimizer-max-mem-size -> (integer)
      The limit on memory consumption for the range optimizer. See MySQL documentation for details.
    rpl-semi-sync-master-wait-for-slave-count -> (integer)
      The number of replica acknowledgments the source must receive per transaction before proceeding. See MySQL documentation for details.
    show-compatibility-56 -> (boolean)
      Manages MySQL 5.6 compatibility For details, see MySQL documentation for the variable.
    slave-parallel-type -> (struct)
      When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica. See MySQL documentation for details.
    slave-parallel-workers -> (integer)
      Sets the number of applier threads for executing replication transactions in parallel. See MySQL documentation for details.
    slow-query-log -> (boolean)
      Manages slow query log. See MySQL documentation for details.
    slow-query-log-always-write-time -> (float64)
      Query execution time, after which query to be logged unconditionally, that is, 'log_slow_rate_limit'' will not apply to it. See Percona documentation for details.
    sort-buffer-size -> (integer)
      Each session that must perform a sort allocates a buffer of this size. See MySQL documentation for details.
    sql-mode -> ([]struct)
      Server SQL mode of MySQL. See MySQL documentation for details.
    sync-binlog -> (integer)
      Controls how often the MySQL server synchronizes the binary log to disk. See MySQL documentation for details.
    table-definition-cache -> (integer)
      The number of table definitions that can be stored in the definition cache. See MySQL documentation for details.
    table-open-cache -> (integer)
      The number of open tables for all threads. See MySQL documentation for details.
    table-open-cache-instances -> (integer)
      The number of open tables cache instances. See MySQL documentation for details.
    thread-cache-size -> (integer)
      A number of threads the server should cache for reuse. See MySQL documentation for details.
    thread-stack -> (integer)
      The stack size for each thread. The default is large enough for normal operation. See MySQL documentation for details.
    tmp-table-size -> (integer)
      The maximum size of internal in-memory temporary tables. See MySQL documentation for details.
    transaction-isolation -> (struct)
      Default transaction isolation level. See MySQL documentation for details.
    userstat -> (boolean)
      Enables or disables collection of statistics For details, see Percona documentation for the variable.
    wait-timeout -> (integer)
      The number of seconds the server waits for activity on a noninteractive connection before closing it. See MySQL documentation for details.
  mysql-config-8-0 -> (struct)
    Configuration for a MySQL 8.0 cluster.
    audit-log -> (boolean)
      Enable writing of audit log of MySQL. See MySQL documentation for details.
    audit-log-policy -> (struct)
      The policy controlling how the audit log plugin writes events to its log file For details, see MySQL documentation for the variable
    auto-increment-increment -> (integer)
      Can be used to control the operation of AUTO_INCREMENT columns. See MySQL documentation for details.
    auto-increment-offset -> (integer)
      Can be used to control the operation of AUTO_INCREMENT columns. See MySQL documentation for details.
    autocommit -> (boolean)
      Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it. For details, see MySQL documentation for the variable.
    binlog-cache-size -> (integer)
      The size of the cache to hold changes to the binary log during a transaction. See MySQL documentation for details.
    binlog-group-commit-sync-delay -> (integer)
      Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk. See MySQL documentation for details.
    binlog-row-image -> (struct)
      For MySQL row-based replication, this variable determines how row images are written to the binary log. See MySQL documentation for details.
    binlog-rows-query-log-events -> (boolean)
      When enabled, it causes the server to write informational log events such as row query log events into its binary log. See MySQL documentation for details.
    binlog-transaction-dependency-tracking -> (struct)
      Specifies how the source mysqld generates the dependency information that it writes in the binary log to help replicas determine which transactions can be executed in parallel. For details, see MySQL documentation for the variable.
    character-set-server -> (string)
      The servers default character set. See MySQL documentation for details.
    collation-server -> (string)
      The server default collation. See MySQL documentation for details.
    default-authentication-plugin -> (struct)
      Authentication plugin used in the managed MySQL cluster. See MySQL documentation for details.
    default-time-zone -> (string)
      The servers default time zone. See MySQL documentation for details.
    explicit-defaults-for-timestamp -> (boolean)
      Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns. See MySQL documentation for details.
    general-log -> (boolean)
      Enable writing of general query log of MySQL. See MySQL documentation for details.
    group-concat-max-len -> (integer)
      The maximum permitted result length in bytes for the GROUP_CONCAT() function. See MySQL documentation for details.
    innodb-adaptive-hash-index -> (boolean)
      Enables InnoDB adaptive hash index. See MySQL documentation for details.
    innodb-buffer-pool-size -> (integer)
      Size of the InnoDB buffer pool used for caching table and index data. See MySQL documentation for details.
    innodb-change-buffering -> (struct)
      An optimization for change buffering For details, see MySQL documentation for the variable.
    innodb-compression-level -> (integer)
      The level of zlib compression to use for InnoDB compressed tables and indexes. For details, see MySQL documentation for the variable.
    innodb-flush-log-at-trx-commit -> (integer)
      Transaction log flush behaviour. See MySQL documentation for details.
    innodb-ft-max-token-size -> (integer)
      Maximum length of words that are stored in an InnoDB FULLTEXT index See MySQL documentation for the variable for details.
    innodb-ft-min-token-size -> (integer)
      Minimum length of words that are stored in an InnoDB FULLTEXT index See MySQL documentation for the variable for details.
    innodb-io-capacity -> (integer)
      Limits IO available for InnoDB background tasks. See MySQL documentation for details.
    innodb-io-capacity-max -> (integer)
      Limits IO available for InnoDB background tasks. See MySQL documentation for details.
    innodb-lock-wait-timeout -> (integer)
      Max time in seconds for a transaction to wait for a row lock. See MySQL documentation for details.
    innodb-log-buffer-size -> (integer)
      The size in bytes of the buffer that InnoDB uses to write to the log files on disk. See MySQL documentation for details.
    innodb-log-file-size -> (integer)
      The size in bytes of the single InnoDB Redo log file. See MySQL documentation for details.
    innodb-lru-scan-depth -> (integer)
      A parameter that influences the algorithms and heuristics for the flush operation for the InnoDB buffer pool For details, see MySQL documentation for the variable
    innodb-numa-interleave -> (boolean)
      Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool. See MySQL documentation for details.
    innodb-online-alter-log-max-size -> (integer)
      The limit in bytes on the size of the temporary log files used during online DDL operations See MySQL documentation for the variable for details.
    innodb-page-size -> (integer)
      Specifies the page size for InnoDB tablespaces. For details, see MySQL documentation for the variable.
    innodb-print-all-deadlocks -> (boolean)
      Print information about deadlocks in error log. See MySQL documentation for details.
    innodb-print-lock-wait-timeout-info -> (boolean)
      Makes InnoDB to write information about all lock wait timeout errors into the log file. For details, see Percona documentation for the variable.
    innodb-purge-threads -> (integer)
      The number of background threads devoted to the InnoDB purge operation. See MySQL documentation for details.
    innodb-read-io-threads -> (integer)
      The number of I/O threads for read operations in InnoDB. See MySQL documentation for details.
    innodb-status-output -> (boolean)
      Enables or disables periodic output for the standard InnoDB Monitor. For details, see MySQL documentation for the variable.
    innodb-strict-mode -> (boolean)
      When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options. For details, see MySQL documentation for the variable.
    innodb-temp-data-file-max-size -> (integer)
      Limits the max size of InnoDB temp tablespace. See MySQL documentation for details.
    innodb-thread-concurrency -> (integer)
      Defines the maximum number of threads permitted inside of InnoDB. See MySQL documentation for details.
    innodb-write-io-threads -> (integer)
      The number of I/O threads for write operations in InnoDB. See MySQL documentation for details.
    interactive-timeout -> (integer)
      The number of seconds the server waits for activity on an interactive connection before closing it. See MySQL documentation for details.
    join-buffer-size -> (integer)
      The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans. See MySQL documentation for details.
    lock-wait-timeout -> (integer)
      This variable specifies the timeout in seconds for attempts to acquire metadata locks For details, see MySQL documentation for the variable.
    log-error-verbosity -> (integer)
      System variable specifies the verbosity for handling events intended for the error log For details, see MySQL documentation for the variable.
    log-slow-filter -> ([]struct)
      Filters the slow log by the query's execution plan. See Percona documentation for details.
    log-slow-rate-limit -> (integer)
      Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query. See Percona documentation for details.
    log-slow-rate-type -> (struct)
      Specifies slow log granularity for 'log_slow_rate_limit' QUERY or SESSION value. See Percona documentation for details.
    log-slow-sp-statements -> (boolean)
      When TRUE, statements executed by stored procedures are logged to the slow log. See Percona documentation for details.
    long-query-time -> (float64)
      Time that it takes to process a query before it is considered slow. See MySQL documentation for details.
    lower-case-table-names -> (integer)
      Table names storage and comparison strategy See MySQL documentation for the variable for details.
    max-allowed-packet -> (integer)
      The maximum size in bytes of one packet. See MySQL documentation for details.
    max-connections -> (integer)
      The maximum permitted number of simultaneous client connections. See MySQL documentation for details.
    max-digest-length -> (integer)
      The maximum number of bytes of memory reserved per session for computation of normalized statement digests. For details, see MySQL documentation for the variable.
    max-execution-time -> (integer)
      The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled. For details, see MySQL documentation for the variable
    max-heap-table-size -> (integer)
      This variable sets the maximum size to which user-created MEMORY tables are permitted to grow. See MySQL documentation for details.
    max-prepared-stmt-count -> (integer)
      This variable limits the total number of prepared statements in the server. For details, see MySQL documentation for the variable.
    max-sp-recursion-depth -> (integer)
      The number of times that any given stored procedure may be called recursively. For details, see MySQL documentation for the variable.
    max-write-lock-count -> (integer)
      Permit some pending read lock requests interval P.S. Should be UInt64, but java fails to handle UInt64 limits For details, see Percona documentation for the variable.
    mdb-force-ssl -> (boolean)
      Force ssl on all hosts (require_secure_transport)
    mdb-offline-mode-disable-lag -> (integer)
      Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'. Should be less than mdb_offline_mode_enable_lag.
    mdb-offline-mode-enable-lag -> (integer)
      Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.
    mdb-preserve-binlog-bytes -> (integer)
      The size of the binary log to hold.
    mdb-priority-choice-max-lag -> (integer)
      Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from". Should be less than mdb_offline_mode_disable_lag.
    net-read-timeout -> (integer)
      The number of seconds to wait for more data from a connection before aborting the read. See MySQL documentation for details.
    net-write-timeout -> (integer)
      The number of seconds to wait for a block to be written to a connection before aborting the write. See MySQL documentation for details.
    optimizer-search-depth -> (integer)
      The maximum depth of search performed by the query optimizer For details, see MySQL documentation for the variable
    optimizer-switch -> (string)
      The system variable enables control over optimizer behavior. For details, see MySQL documentation for the variable https://dev.mysql.com/doc/refman/8.0/en/switchable-optimizations.html
    range-optimizer-max-mem-size -> (integer)
      The limit on memory consumption for the range optimizer. See MySQL documentation for details.
    regexp-time-limit -> (integer)
      The time limit for regular expression matching operations performed by REGEXP_LIKE and similar functions. See MySQL documentation for details.
    replication-optimize-for-static-plugin-config -> (boolean)
      Use shared locks, and avoid unnecessary lock acquisitions, to improve performance for semisynchronous replication For details, see MySQL documentation for the variable.
    replication-sender-observe-commit-only -> (boolean)
      Limit callbacks to improve performance for semisynchronous replication For details, see MySQL documentation for the variable.
    rpl-semi-sync-master-wait-for-slave-count -> (integer)
      The number of replica acknowledgments the source must receive per transaction before proceeding. See MySQL documentation for details.
    slave-parallel-type -> (struct)
      When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica. See MySQL documentation for details.
    slave-parallel-workers -> (integer)
      Sets the number of applier threads for executing replication transactions in parallel. See MySQL documentation for details.
    slow-query-log -> (boolean)
      Manages slow query log. See MySQL documentation for details.
    slow-query-log-always-write-time -> (float64)
      Query execution time, after which query to be logged unconditionally, that is, 'log_slow_rate_limit' will not apply to it. See Percona documentation for details.
    sort-buffer-size -> (integer)
      Each session that must perform a sort allocates a buffer of this size. See MySQL documentation for details.
    sql-mode -> ([]struct)
      Server SQL mode of MySQL. See MySQL documentation for details.
    sql-require-primary-key -> (boolean)
      Whether statements that create new tables or alter the structure of existing tables enforce the requirement that tables have a primary key For details, see MySQL documentation for the variable.
    sync-binlog -> (integer)
      Controls how often the MySQL server synchronizes the binary log to disk. See MySQL documentation for details.
    table-definition-cache -> (integer)
      The number of table definitions that can be stored in the definition cache. See MySQL documentation for details.
    table-open-cache -> (integer)
      The number of open tables for all threads. See MySQL documentation for details.
    table-open-cache-instances -> (integer)
      The number of open tables cache instances. See MySQL documentation for details.
    thread-cache-size -> (integer)
      How many threads the server should cache for reuse. See MySQL documentation for details.
    thread-stack -> (integer)
      The stack size for each thread. The default is large enough for normal operation. See MySQL documentation for details.
    tmp-table-size -> (integer)
      The maximum size of internal in-memory temporary tables. See MySQL documentation for details.
    transaction-isolation -> (struct)
      Default transaction isolation level. See MySQL documentation for details.
    userstat -> (boolean)
      Enables or disables collection of statistics For details, see Percona documentation for the variable.
    wait-timeout -> (integer)
      The number of seconds the server waits for activity on a noninteractive connection before closing it. See MySQL documentation for details.
  mysql-config-8-4 -> (struct)
    Configuration for a MySQL 8.4 cluster.
    audit-log -> (boolean)
      Enable writing of audit log of MySQL. For details, see MySQL documentation for the variable.
    audit-log-policy -> (struct)
      The policy controlling how the audit log plugin writes events to its log file For details, see MySQL documentation for the variable
    auto-increment-increment -> (integer)
      Can be used to control the operation of AUTO_INCREMENT columns. For details, see MySQL documentation for the variable.
    auto-increment-offset -> (integer)
      Can be used to control the operation of AUTO_INCREMENT columns. For details, see MySQL documentation for the variable.
    autocommit -> (boolean)
      Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it. For details, see MySQL documentation for the variable.
    binlog-cache-size -> (integer)
      The size of the cache to hold changes to the binary log during a transaction. For details, see MySQL documentation for the variable.
    binlog-group-commit-sync-delay -> (integer)
      Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk. For details, see MySQL documentation for the variable.
    binlog-row-image -> (struct)
      For MySQL row-based replication, this variable determines how row images are written to the binary log. For details, see MySQL documentation for the variable.
    binlog-rows-query-log-events -> (boolean)
      When enabled, it causes the server to write informational log events such as row query log events into its binary log. For details, see MySQL documentation for the variable.
    character-set-server -> (string)
      The servers default character set. For details, see MySQL documentation for the variable
    collation-server -> (string)
      Set the default server collation. For details, see MySQL documentation for the variable
    default-time-zone -> (string)
      The servers default time zone. For details, see MySQL documentation for the variable
    explicit-defaults-for-timestamp -> (boolean)
      This system variable determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns. For details, see MySQL documentation for the variable.
    group-concat-max-len -> (integer)
      The maximum permitted result length in bytes for the GROUP_CONCAT() function. For details, see MySQL documentation for the variable
    innodb-adaptive-hash-index -> (boolean)
      Enables Innodb adaptive hash index For details, see MySQL documentation for the variable
    innodb-buffer-pool-size -> (integer)
      Size of the InnoDB buffer pool used for caching table and index data. For details, see MySQL documentation for the parameter.
    innodb-change-buffering -> (struct)
      An optimization for change buffering For details, see Percona documentation for the variable.
    innodb-compression-level -> (integer)
      The level of zlib compression to use for InnoDB compressed tables and indexes. For details, see MySQL documentation for the variable.
    innodb-flush-log-at-trx-commit -> (integer)
      Transaction log flush behaviour. For details, see MySQL documentation for the variable
    innodb-ft-max-token-size -> (integer)
      Maximum length of words that are stored in an InnoDB FULLTEXT index For details, see MySQL documentation for the variable.
    innodb-ft-min-token-size -> (integer)
      Minimum length of words that are stored in an InnoDB FULLTEXT index For details, see MySQL documentation for the variable.
    innodb-io-capacity -> (integer)
      Limits IO available for InnoDB background tasks For details, see MySQL documentation for the variable
    innodb-io-capacity-max -> (integer)
      Limits IO available for InnoDB background tasks For details, see MySQL documentation for the variable
    innodb-lock-wait-timeout -> (integer)
      Max time in seconds for a transaction to wait for a row lock For details, see MySQL documentation for the variable
    innodb-log-buffer-size -> (integer)
      The size in bytes of the buffer that InnoDB uses to write to the log files on disk. For details, see MySQL documentation for the variable
    innodb-log-file-size -> (integer)
      The size in bytes of the single Innodb Redo log file. For details, see MySQL documentation for the variable
    innodb-lru-scan-depth -> (integer)
      A parameter that influences the algorithms and heuristics for the flush operation for the InnoDB buffer pool For details, see MySQL documentation for the variable
    innodb-numa-interleave -> (boolean)
      Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool. For details, see MySQL documentation for the variable
    innodb-online-alter-log-max-size -> (integer)
      The limit in bytes on the size of the temporary log files used during online DDL operations For details, see MySQL documentation for the variable.
    innodb-page-size -> (integer)
      Specifies the page size for InnoDB tablespaces. For details, see MySQL documentation for the variable.
    innodb-print-all-deadlocks -> (boolean)
      Print information about deadlocks in error log For details, see MySQL documentation for the variable
    innodb-print-lock-wait-timeout-info -> (boolean)
      Makes InnoDB to write information about all lock wait timeout errors into the log file. For details, see Percona documentation for the variable.
    innodb-purge-threads -> (integer)
      The number of background threads devoted to the InnoDB purge operation. For details, see MySQL documentation for the variable
    innodb-read-io-threads -> (integer)
      The number of I/O threads for read operations in InnoDB. For details, see MySQL documentation for the variable
    innodb-status-output -> (boolean)
      Enables or disables periodic output for the standard InnoDB Monitor. For details, see MySQL documentation for the variable.
    innodb-strict-mode -> (boolean)
      When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options. For details, see MySQL documentation for the variable.
    innodb-temp-data-file-max-size -> (integer)
      Limits the max size of InnoDB temp tablespace For details, see MySQL documentation for the variable
    innodb-thread-concurrency -> (integer)
      Defines the maximum number of threads permitted inside of InnoDB. For details, see MySQL documentation for the variable
    innodb-write-io-threads -> (integer)
      The number of I/O threads for write operations in InnoDB. For details, see MySQL documentation for the variable
    interactive-timeout -> (integer)
      The number of seconds the server waits for activity on an interactive connection before closing it. For details, see MySQL documentation for the variable.
    join-buffer-size -> (integer)
      The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans. For details, see MySQL documentation for the variable.
    lock-wait-timeout -> (integer)
      This variable specifies the timeout in seconds for attempts to acquire metadata locks For details, see MySQL documentation for the variable.
    log-error-verbosity -> (integer)
      System variable specifies the verbosity for handling events intended for the error log For details, see MySQL documentation for the variable.
    log-slow-filter -> ([]struct)
      Filters the slow log by the query's execution plan For details, see Percona documentation for the variable.
    log-slow-rate-limit -> (integer)
      Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query. For details, see Percona documentation for the variable.
    log-slow-rate-type -> (struct)
      Specifies slow log granularity for log_slow_rate_limit: QUERY or SESSION For details, see Percona documentation for the variable.
    log-slow-sp-statements -> (boolean)
      When TRUE, statements executed by stored procedures are logged to the slow log For details, see Percona documentation for the variable.
    long-query-time -> (float64)
      Time that it takes to process a query before it is considered slow. For details, see MySQL documentation for the variable.
    lower-case-table-names -> (integer)
      Table names storage and comparison strategy For details, see MySQL documentation for the variable.
    max-allowed-packet -> (integer)
      The maximum size in bytes of one packet. For details, see MySQL documentation for the variable.
    max-connections -> (integer)
      The maximum permitted number of simultaneous client connections. For details, see MySQL documentation for the variable.
    max-digest-length -> (integer)
      The maximum number of bytes of memory reserved per session for computation of normalized statement digests. For details, see MySQL documentation for the variable.
    max-execution-time -> (integer)
      The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled. For details, see MySQL documentation for the variable
    max-heap-table-size -> (integer)
      This variable sets the maximum size to which user-created MEMORY tables are permitted to grow. For details, see MySQL documentation for the variable
    max-prepared-stmt-count -> (integer)
      This variable limits the total number of prepared statements in the server. For details, see MySQL documentation for the variable.
    max-sp-recursion-depth -> (integer)
      The number of times that any given stored procedure may be called recursively. For details, see MySQL documentation for the variable.
    max-write-lock-count -> (integer)
      Permit some pending read lock requests interval P.S. Should be UInt64, but java fails to handle UInt64 limits For details, see Percona documentation for the variable.
    mdb-async-allowed-lag -> (integer)
      Async replication allowed lag (seconds)
    mdb-force-ssl -> (boolean)
      Force ssl on all hosts (require_secure_transport)
    mdb-offline-mode-disable-lag -> (integer)
      Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'. Should be less than mdb_offline_mode_enable_lag.
    mdb-offline-mode-enable-lag -> (integer)
      Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.
    mdb-preserve-binlog-bytes -> (integer)
      The size of the binary log to hold.
    mdb-priority-choice-max-lag -> (integer)
      Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from". Should be less than mdb_offline_mode_disable_lag.
    mdb-use-async-replication -> (boolean)
      Enable async replication
    net-read-timeout -> (integer)
      The number of seconds to wait for more data from a connection before aborting the read. For details, see MySQL documentation for the variable
    net-write-timeout -> (integer)
      The number of seconds to wait for a block to be written to a connection before aborting the write. For details, see MySQL documentation for the variable
    optimizer-search-depth -> (integer)
      The maximum depth of search performed by the query optimizer For details, see MySQL documentation for the variable
    optimizer-switch -> (string)
      The system variable enables control over optimizer behavior. For details, see [MySQL documentation for the variable] https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_optimizer_switch https://dev.mysql.com/doc/refman/8.4/en/switchable-optimizations.html
    range-optimizer-max-mem-size -> (integer)
      The limit on memory consumption for the range optimizer. For details, see MySQL documentation for the variable.
    regexp-time-limit -> (integer)
      The time limit for regular expression matching operations performed by REGEXP_LIKE and similar functions For details, see MySQL documentation for the variable.
    replication-optimize-for-static-plugin-config -> (boolean)
      Use shared locks, and avoid unnecessary lock acquisitions, to improve performance for semisynchronous replication For details, see Percona documentation for the variable.
    replication-sender-observe-commit-only -> (boolean)
      Limit callbacks to improve performance for semisynchronous replication For details, see Percona documentation for the variable.
    rpl-semi-sync-master-wait-for-slave-count -> (integer)
      The number of replica acknowledgments the source must receive per transaction before proceeding. For details, see MySQL documentation for the variable.
    slave-parallel-type -> (struct)
      When using a multithreaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica. For details, see MySQL documentation for the variable.
    slave-parallel-workers -> (integer)
      Sets the number of applier threads for executing replication transactions in parallel. For details, see MySQL documentation for the variable.
    slow-query-log -> (boolean)
      Manages slow query log For details, see MySQL documentation for the variable.
    slow-query-log-always-write-time -> (float64)
      Query execution time, after which query to be logged unconditionally, that is, log_slow_rate_limit will not apply to it For details, see Percona documentation for the variable.
    sort-buffer-size -> (integer)
      Each session that must perform a sort allocates a buffer of this size. For details, see MySQL documentation for the variable.
    sql-mode -> ([]struct)
      Server SQL mode of MySQL. For details, see MySQL documentation for the variable.
    sql-require-primary-key -> (boolean)
      Whether statements that create new tables or alter the structure of existing tables enforce the requirement that tables have a primary key For details, see Percona documentation for the variable.
    sync-binlog -> (integer)
      Controls how often the MySQL server synchronizes the binary log to disk. For details, see MySQL documentation for the variable.
    table-definition-cache -> (integer)
      The number of table definitions that can be stored in the definition cache. For details, see MySQL documentation for the variable.
    table-open-cache -> (integer)
      The number of open tables for all threads. For details, see MySQL documentation for the variable.
    table-open-cache-instances -> (integer)
      The number of open tables cache instances. For details, see MySQL documentation for the variable.
    thread-cache-size -> (integer)
      How many threads the server should cache for reuse. For details, see MySQL documentation for the variable.
    thread-stack -> (integer)
      The stack size for each thread. The default is large enough for normal operation. For details, see MySQL documentation for the variable.
    tmp-table-size -> (integer)
      The maximum size of internal in-memory temporary tables. For details, see MySQL documentation for the variable
    transaction-isolation -> (struct)
      Default transaction isolation level. For details, see MySQL documentation for the variable
    userstat -> (boolean)
      Enables or disables collection of statistics For details, see Percona documentation for the variable.
    wait-timeout -> (integer)
      The number of seconds the server waits for activity on a noninteractive connection before closing it. For details, see MySQL documentation for the variable.
``` ||
|| `--database-specs` | `shorthand/json`

Configuration of databases in the cluster.

Shorthand Syntax:

```hcl
[
  {
    name = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "name": "string"
  }, ...
]
```

Fields:

```
name -> (string)
  Name of the database.
``` ||
|| `--deletion-protection` | This option prevents unintended deletion of the cluster. ||
|| `--description` | `string`

Description of the cluster. ||
|| `--disk-encryption-key-id` | `string`

ID of the key to encrypt cluster disks. ||
|| `--environment` | `enum`

Deployment environment of the MySQL cluster. Possible Values: 'production', 'prestable' ||
|| `--folder-id` | `string`

ID of the folder to create the cluster in. To get this ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--host-group-ids` | `[]string`

Host groups hosting VMs of the cluster. ||
|| `--host-specs` | `shorthand/json`

Configuration of hosts in the cluster.

Shorthand Syntax:

```hcl
[
  {
    assign-public-ip = boolean,
    backup-priority = integer,
    priority = integer,
    replication-source = string,
    subnet-id = string,
    zone-id = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "assign-public-ip": "boolean",
    "backup-priority": "integer",
    "priority": "integer",
    "replication-source": "string",
    "subnet-id": "string",
    "zone-id": "string"
  }, ...
]
```

Fields:

```
assign-public-ip -> (boolean)
  Option that enables public IP address for the host so that the host can be accessed from the internet. After a host has been created, this setting cannot be changed. To remove an assigned public IP address, or to assign a public IP address to a host without one, recreate the host with the appropriate [assign_public_ip] value set. Possible values: * 'false' - don't assign a public IP address to the host. * 'true' - assign a public IP address to the host.
backup-priority -> (integer)
  Host backup priority
priority -> (integer)
  Host master promotion priority
replication-source -> (string)
  [Host.name] of the host to be used as the replication source (for cascading replication).
subnet-id -> (string)
  ID of the subnet to assign to the host. This subnet should be a part of the cluster network (the network ID is specified in the [ClusterService.CreateClusterRequest.network_id]).
zone-id -> (string)
  ID of the availability zone where the host resides. To get a list of available zones, make the [yandex.cloud.compute.v1.ZoneService.List] request.
``` ||
|| `--labels` | `map<string><string>`

Custom labels for the cluster as 'key:value' pairs. ||
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

Name of the cluster. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the network to create the cluster in. ||
|| `--security-group-ids` | `[]string`

List of security group IDs to apply to the cluster. ||
|| `--user-specs` | `shorthand/json`

Configuration of database users in the cluster.

Shorthand Syntax:

```hcl
[
  {
    authentication-plugin = MYSQL_NATIVE_PASSWORD|CACHING_SHA2_PASSWORD|SHA256_PASSWORD|MYSQL_NO_LOGIN|MDB_IAMPROXY_AUTH,
    connection-limits = {
      max-connections-per-hour = integer,
      max-questions-per-hour = integer,
      max-updates-per-hour = integer,
      max-user-connections = integer
    },
    generate-password = boolean,
    global-permissions = [
      REPLICATION_CLIENT|REPLICATION_SLAVE|PROCESS|FLUSH_OPTIMIZER_COSTS|SHOW_ROUTINE|MDB_ADMIN, ...
    ],
    name = string,
    password = string,
    permissions = [
      {
        database-name = string,
        roles = [
          ALL_PRIVILEGES|ALTER|ALTER_ROUTINE|CREATE|CREATE_ROUTINE|CREATE_TEMPORARY_TABLES|CREATE_VIEW|DELETE|DROP|EVENT|EXECUTE|INDEX|INSERT|LOCK_TABLES|SELECT|SHOW_VIEW|TRIGGER|UPDATE|REFERENCES, ...
        ]
      }, ...
    ]
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "authentication-plugin": "MYSQL_NATIVE_PASSWORD|CACHING_SHA2_PASSWORD|SHA256_PASSWORD|MYSQL_NO_LOGIN|MDB_IAMPROXY_AUTH",
    "connection-limits": {
      "max-connections-per-hour": "integer",
      "max-questions-per-hour": "integer",
      "max-updates-per-hour": "integer",
      "max-user-connections": "integer"
    },
    "generate-password": "boolean",
    "global-permissions": [
      "REPLICATION_CLIENT|REPLICATION_SLAVE|PROCESS|FLUSH_OPTIMIZER_COSTS|SHOW_ROUTINE|MDB_ADMIN", ...
    ],
    "name": "string",
    "password": "string",
    "permissions": [
      {
        "database-name": "string",
        "roles": [
          "ALL_PRIVILEGES|ALTER|ALTER_ROUTINE|CREATE|CREATE_ROUTINE|CREATE_TEMPORARY_TABLES|CREATE_VIEW|DELETE|DROP|EVENT|EXECUTE|INDEX|INSERT|LOCK_TABLES|SELECT|SHOW_VIEW|TRIGGER|UPDATE|REFERENCES", ...
        ]
      }, ...
    ]
  }, ...
]
```

Fields:

```
authentication-plugin -> (struct)
  User authentication plugin.
connection-limits -> (struct)
  Set of user connection limits.
  max-connections-per-hour -> (integer)
    The maximum permitted number of simultaneous client connections per hour.
  max-questions-per-hour -> (integer)
    The maximum permitted number of user questions per hour.
  max-updates-per-hour -> (integer)
    The maximum permitted number of user updates per hour.
  max-user-connections -> (integer)
    The maximum number of simultaneous connections permitted to any given MySQL user account.
generate-password -> (boolean)
  Generate password using Connection Manager.
global-permissions -> ([]struct)
  Set of global permissions to grant to the user.
name -> (string)
  Name of the user.
password -> (string)
  Password of the user.
permissions -> ([]struct)
  Set of permissions granted to the user to access specific databases. One permission per database. When a permission for a database is set, the user will have access to the database.
  database-name -> (string)
    Name of the database that the permission grants access to.
  roles -> ([]struct)
    Roles granted to the user within the database. See documentation for details.
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