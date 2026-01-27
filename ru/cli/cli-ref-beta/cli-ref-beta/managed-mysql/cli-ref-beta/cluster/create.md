---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-mysql/cli-ref-beta/cluster/create.md
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
    data-lens = bool,
    data-transfer = bool,
    web-sql = bool,
    yandex-query = bool
  },
  backup-retain-period-days = int,
  backup-window-start = timeofday,
  disk-size-autoscaling = {
    disk-size-limit = int,
    emergency-usage-threshold = int,
    planned-usage-threshold = int
  },
  mysql-config = mysql-config-5-7={
    audit-log = bool,
    audit-log-policy = ALL|LOGINS|QUERIES|NONE,
    auto-increment-increment = int,
    auto-increment-offset = int,
    autocommit = bool,
    binlog-cache-size = int,
    binlog-group-commit-sync-delay = int,
    binlog-row-image = FULL|MINIMAL|NOBLOB,
    binlog-rows-query-log-events = bool,
    binlog-transaction-dependency-tracking = COMMIT_ORDER|WRITESET|WRITESET_SESSION,
    character-set-server = str,
    collation-server = str,
    default-authentication-plugin = MYSQL_NATIVE_PASSWORD|CACHING_SHA2_PASSWORD|SHA256_PASSWORD|MYSQL_NO_LOGIN|MDB_IAMPROXY_AUTH,
    default-time-zone = str,
    explicit-defaults-for-timestamp = bool,
    general-log = bool,
    group-concat-max-len = int,
    innodb-adaptive-hash-index = bool,
    innodb-buffer-pool-size = int,
    innodb-change-buffering = INNODB_CHANGE_BUFFERING_NONE|INNODB_CHANGE_BUFFERING_INSERTS|INNODB_CHANGE_BUFFERING_DELETES|INNODB_CHANGE_BUFFERING_CHANGES|INNODB_CHANGE_BUFFERING_PURGES|INNODB_CHANGE_BUFFERING_ALL,
    innodb-compression-level = int,
    innodb-flush-log-at-trx-commit = int,
    innodb-ft-max-token-size = int,
    innodb-ft-min-token-size = int,
    innodb-io-capacity = int,
    innodb-io-capacity-max = int,
    innodb-lock-wait-timeout = int,
    innodb-log-buffer-size = int,
    innodb-log-file-size = int,
    innodb-lru-scan-depth = int,
    innodb-numa-interleave = bool,
    innodb-online-alter-log-max-size = int,
    innodb-page-size = int,
    innodb-print-all-deadlocks = bool,
    innodb-print-lock-wait-timeout-info = bool,
    innodb-purge-threads = int,
    innodb-read-io-threads = int,
    innodb-status-output = bool,
    innodb-strict-mode = bool,
    innodb-temp-data-file-max-size = int,
    innodb-thread-concurrency = int,
    innodb-write-io-threads = int,
    interactive-timeout = int,
    join-buffer-size = int,
    lock-wait-timeout = int,
    log-error-verbosity = int,
    log-slow-filter = [
      FULL_SCAN|FULL_JOIN|TMP_TABLE|TMP_TABLE_ON_DISK|FILESORT|FILESORT_ON_DISK, ...
    ],
    log-slow-rate-limit = int,
    log-slow-rate-type = SESSION|QUERY,
    log-slow-sp-statements = bool,
    long-query-time = double,
    lower-case-table-names = int,
    max-allowed-packet = int,
    max-connections = int,
    max-digest-length = int,
    max-execution-time = int,
    max-heap-table-size = int,
    max-prepared-stmt-count = int,
    max-sp-recursion-depth = int,
    max-write-lock-count = int,
    mdb-force-ssl = bool,
    mdb-offline-mode-disable-lag = int,
    mdb-offline-mode-enable-lag = int,
    mdb-preserve-binlog-bytes = int,
    mdb-priority-choice-max-lag = int,
    net-read-timeout = int,
    net-write-timeout = int,
    optimizer-search-depth = int,
    optimizer-switch = str,
    query-cache-limit = int,
    query-cache-size = int,
    query-cache-type = int,
    query-response-time-stats = bool,
    range-optimizer-max-mem-size = int,
    rpl-semi-sync-master-wait-for-slave-count = int,
    show-compatibility-56 = bool,
    slave-parallel-type = DATABASE|LOGICAL_CLOCK,
    slave-parallel-workers = int,
    slow-query-log = bool,
    slow-query-log-always-write-time = double,
    sort-buffer-size = int,
    sql-mode = [
      ALLOW_INVALID_DATES|ANSI_QUOTES|ERROR_FOR_DIVISION_BY_ZERO|HIGH_NOT_PRECEDENCE|IGNORE_SPACE|NO_AUTO_VALUE_ON_ZERO|NO_BACKSLASH_ESCAPES|NO_ENGINE_SUBSTITUTION|NO_UNSIGNED_SUBTRACTION|NO_ZERO_DATE|NO_ZERO_IN_DATE|NO_FIELD_OPTIONS|NO_KEY_OPTIONS|NO_TABLE_OPTIONS|ONLY_FULL_GROUP_BY|PAD_CHAR_TO_FULL_LENGTH|PIPES_AS_CONCAT|REAL_AS_FLOAT|STRICT_ALL_TABLES|STRICT_TRANS_TABLES|ANSI|TRADITIONAL|DB2|MAXDB|MSSQL|MYSQL323|MYSQL40|ORACLE|POSTGRESQL|NO_AUTO_CREATE_USER|NO_DIR_IN_CREATE, ...
    ],
    sync-binlog = int,
    table-definition-cache = int,
    table-open-cache = int,
    table-open-cache-instances = int,
    thread-cache-size = int,
    thread-stack = int,
    tmp-table-size = int,
    transaction-isolation = READ_COMMITTED|REPEATABLE_READ|SERIALIZABLE,
    userstat = bool,
    wait-timeout = int
  } | mysql-config-8-0={
    audit-log = bool,
    audit-log-policy = ALL|LOGINS|QUERIES|NONE,
    auto-increment-increment = int,
    auto-increment-offset = int,
    autocommit = bool,
    binlog-cache-size = int,
    binlog-group-commit-sync-delay = int,
    binlog-row-image = FULL|MINIMAL|NOBLOB,
    binlog-rows-query-log-events = bool,
    binlog-transaction-dependency-tracking = COMMIT_ORDER|WRITESET|WRITESET_SESSION,
    character-set-server = str,
    collation-server = str,
    default-authentication-plugin = MYSQL_NATIVE_PASSWORD|CACHING_SHA2_PASSWORD|SHA256_PASSWORD|MYSQL_NO_LOGIN|MDB_IAMPROXY_AUTH,
    default-time-zone = str,
    explicit-defaults-for-timestamp = bool,
    general-log = bool,
    group-concat-max-len = int,
    innodb-adaptive-hash-index = bool,
    innodb-buffer-pool-size = int,
    innodb-change-buffering = INNODB_CHANGE_BUFFERING_NONE|INNODB_CHANGE_BUFFERING_INSERTS|INNODB_CHANGE_BUFFERING_DELETES|INNODB_CHANGE_BUFFERING_CHANGES|INNODB_CHANGE_BUFFERING_PURGES|INNODB_CHANGE_BUFFERING_ALL,
    innodb-compression-level = int,
    innodb-flush-log-at-trx-commit = int,
    innodb-ft-max-token-size = int,
    innodb-ft-min-token-size = int,
    innodb-io-capacity = int,
    innodb-io-capacity-max = int,
    innodb-lock-wait-timeout = int,
    innodb-log-buffer-size = int,
    innodb-log-file-size = int,
    innodb-lru-scan-depth = int,
    innodb-numa-interleave = bool,
    innodb-online-alter-log-max-size = int,
    innodb-page-size = int,
    innodb-print-all-deadlocks = bool,
    innodb-print-lock-wait-timeout-info = bool,
    innodb-purge-threads = int,
    innodb-read-io-threads = int,
    innodb-status-output = bool,
    innodb-strict-mode = bool,
    innodb-temp-data-file-max-size = int,
    innodb-thread-concurrency = int,
    innodb-write-io-threads = int,
    interactive-timeout = int,
    join-buffer-size = int,
    lock-wait-timeout = int,
    log-error-verbosity = int,
    log-slow-filter = [
      FULL_SCAN|FULL_JOIN|TMP_TABLE|TMP_TABLE_ON_DISK|FILESORT|FILESORT_ON_DISK, ...
    ],
    log-slow-rate-limit = int,
    log-slow-rate-type = SESSION|QUERY,
    log-slow-sp-statements = bool,
    long-query-time = double,
    lower-case-table-names = int,
    max-allowed-packet = int,
    max-connections = int,
    max-digest-length = int,
    max-execution-time = int,
    max-heap-table-size = int,
    max-prepared-stmt-count = int,
    max-sp-recursion-depth = int,
    max-write-lock-count = int,
    mdb-force-ssl = bool,
    mdb-offline-mode-disable-lag = int,
    mdb-offline-mode-enable-lag = int,
    mdb-preserve-binlog-bytes = int,
    mdb-priority-choice-max-lag = int,
    net-read-timeout = int,
    net-write-timeout = int,
    optimizer-search-depth = int,
    optimizer-switch = str,
    range-optimizer-max-mem-size = int,
    regexp-time-limit = int,
    replication-optimize-for-static-plugin-config = bool,
    replication-sender-observe-commit-only = bool,
    rpl-semi-sync-master-wait-for-slave-count = int,
    slave-parallel-type = DATABASE|LOGICAL_CLOCK,
    slave-parallel-workers = int,
    slow-query-log = bool,
    slow-query-log-always-write-time = double,
    sort-buffer-size = int,
    sql-mode = [
      ALLOW_INVALID_DATES|ANSI_QUOTES|ERROR_FOR_DIVISION_BY_ZERO|HIGH_NOT_PRECEDENCE|IGNORE_SPACE|NO_AUTO_VALUE_ON_ZERO|NO_BACKSLASH_ESCAPES|NO_ENGINE_SUBSTITUTION|NO_UNSIGNED_SUBTRACTION|NO_ZERO_DATE|NO_ZERO_IN_DATE|ONLY_FULL_GROUP_BY|PAD_CHAR_TO_FULL_LENGTH|PIPES_AS_CONCAT|REAL_AS_FLOAT|STRICT_ALL_TABLES|STRICT_TRANS_TABLES|TIME_TRUNCATE_FRACTIONAL|ANSI|TRADITIONAL|NO_DIR_IN_CREATE, ...
    ],
    sql-require-primary-key = bool,
    sync-binlog = int,
    table-definition-cache = int,
    table-open-cache = int,
    table-open-cache-instances = int,
    thread-cache-size = int,
    thread-stack = int,
    tmp-table-size = int,
    transaction-isolation = READ_COMMITTED|REPEATABLE_READ|SERIALIZABLE,
    userstat = bool,
    wait-timeout = int
  } | mysql-config-8-4={
    audit-log = bool,
    audit-log-policy = ALL|LOGINS|QUERIES|NONE,
    auto-increment-increment = int,
    auto-increment-offset = int,
    autocommit = bool,
    binlog-cache-size = int,
    binlog-group-commit-sync-delay = int,
    binlog-row-image = FULL|MINIMAL|NOBLOB,
    binlog-rows-query-log-events = bool,
    character-set-server = str,
    collation-server = str,
    default-time-zone = str,
    explicit-defaults-for-timestamp = bool,
    group-concat-max-len = int,
    innodb-adaptive-hash-index = bool,
    innodb-buffer-pool-size = int,
    innodb-change-buffering = INNODB_CHANGE_BUFFERING_NONE|INNODB_CHANGE_BUFFERING_INSERTS|INNODB_CHANGE_BUFFERING_DELETES|INNODB_CHANGE_BUFFERING_CHANGES|INNODB_CHANGE_BUFFERING_PURGES|INNODB_CHANGE_BUFFERING_ALL,
    innodb-compression-level = int,
    innodb-flush-log-at-trx-commit = int,
    innodb-ft-max-token-size = int,
    innodb-ft-min-token-size = int,
    innodb-io-capacity = int,
    innodb-io-capacity-max = int,
    innodb-lock-wait-timeout = int,
    innodb-log-buffer-size = int,
    innodb-log-file-size = int,
    innodb-lru-scan-depth = int,
    innodb-numa-interleave = bool,
    innodb-online-alter-log-max-size = int,
    innodb-page-size = int,
    innodb-print-all-deadlocks = bool,
    innodb-print-lock-wait-timeout-info = bool,
    innodb-purge-threads = int,
    innodb-read-io-threads = int,
    innodb-status-output = bool,
    innodb-strict-mode = bool,
    innodb-temp-data-file-max-size = int,
    innodb-thread-concurrency = int,
    innodb-write-io-threads = int,
    interactive-timeout = int,
    join-buffer-size = int,
    lock-wait-timeout = int,
    log-error-verbosity = int,
    log-slow-filter = [
      FULL_SCAN|FULL_JOIN|TMP_TABLE|TMP_TABLE_ON_DISK|FILESORT|FILESORT_ON_DISK, ...
    ],
    log-slow-rate-limit = int,
    log-slow-rate-type = SESSION|QUERY,
    log-slow-sp-statements = bool,
    long-query-time = double,
    lower-case-table-names = int,
    max-allowed-packet = int,
    max-connections = int,
    max-digest-length = int,
    max-execution-time = int,
    max-heap-table-size = int,
    max-prepared-stmt-count = int,
    max-sp-recursion-depth = int,
    max-write-lock-count = int,
    mdb-async-allowed-lag = int,
    mdb-force-ssl = bool,
    mdb-offline-mode-disable-lag = int,
    mdb-offline-mode-enable-lag = int,
    mdb-preserve-binlog-bytes = int,
    mdb-priority-choice-max-lag = int,
    mdb-use-async-replication = bool,
    net-read-timeout = int,
    net-write-timeout = int,
    optimizer-search-depth = int,
    optimizer-switch = str,
    range-optimizer-max-mem-size = int,
    regexp-time-limit = int,
    replication-optimize-for-static-plugin-config = bool,
    replication-sender-observe-commit-only = bool,
    rpl-semi-sync-master-wait-for-slave-count = int,
    slave-parallel-type = DATABASE|LOGICAL_CLOCK,
    slave-parallel-workers = int,
    slow-query-log = bool,
    slow-query-log-always-write-time = double,
    sort-buffer-size = int,
    sql-mode = [
      ALLOW_INVALID_DATES|ANSI_QUOTES|ERROR_FOR_DIVISION_BY_ZERO|HIGH_NOT_PRECEDENCE|IGNORE_SPACE|NO_AUTO_VALUE_ON_ZERO|NO_BACKSLASH_ESCAPES|NO_ENGINE_SUBSTITUTION|NO_UNSIGNED_SUBTRACTION|NO_ZERO_DATE|NO_ZERO_IN_DATE|ONLY_FULL_GROUP_BY|PAD_CHAR_TO_FULL_LENGTH|PIPES_AS_CONCAT|REAL_AS_FLOAT|STRICT_ALL_TABLES|STRICT_TRANS_TABLES|TIME_TRUNCATE_FRACTIONAL|ANSI|TRADITIONAL|NO_DIR_IN_CREATE, ...
    ],
    sql-require-primary-key = bool,
    sync-binlog = int,
    table-definition-cache = int,
    table-open-cache = int,
    table-open-cache-instances = int,
    thread-cache-size = int,
    thread-stack = int,
    tmp-table-size = int,
    transaction-isolation = READ_COMMITTED|REPEATABLE_READ|SERIALIZABLE,
    userstat = bool,
    wait-timeout = int
  },
  performance-diagnostics = {
    enabled = bool,
    sessions-sampling-interval = int,
    statements-sampling-interval = int
  },
  resources = {
    disk-size = int,
    disk-type-id = str,
    resource-preset-id = str
  },
  version = str
}
```

JSON Syntax:

```json
{
  "access": {
    "data-lens": "bool",
    "data-transfer": "bool",
    "web-sql": "bool",
    "yandex-query": "bool"
  },
  "backup-retain-period-days": "int",
  "backup-window-start": "timeofday",
  "disk-size-autoscaling": {
    "disk-size-limit": "int",
    "emergency-usage-threshold": "int",
    "planned-usage-threshold": "int"
  },
  "mysql-config": {
    "mysql-config-5-7": {
      "audit-log": "bool",
      "audit-log-policy": "ALL|LOGINS|QUERIES|NONE",
      "auto-increment-increment": "int",
      "auto-increment-offset": "int",
      "autocommit": "bool",
      "binlog-cache-size": "int",
      "binlog-group-commit-sync-delay": "int",
      "binlog-row-image": "FULL|MINIMAL|NOBLOB",
      "binlog-rows-query-log-events": "bool",
      "binlog-transaction-dependency-tracking": "COMMIT_ORDER|WRITESET|WRITESET_SESSION",
      "character-set-server": "str",
      "collation-server": "str",
      "default-authentication-plugin": "MYSQL_NATIVE_PASSWORD|CACHING_SHA2_PASSWORD|SHA256_PASSWORD|MYSQL_NO_LOGIN|MDB_IAMPROXY_AUTH",
      "default-time-zone": "str",
      "explicit-defaults-for-timestamp": "bool",
      "general-log": "bool",
      "group-concat-max-len": "int",
      "innodb-adaptive-hash-index": "bool",
      "innodb-buffer-pool-size": "int",
      "innodb-change-buffering": "INNODB_CHANGE_BUFFERING_NONE|INNODB_CHANGE_BUFFERING_INSERTS|INNODB_CHANGE_BUFFERING_DELETES|INNODB_CHANGE_BUFFERING_CHANGES|INNODB_CHANGE_BUFFERING_PURGES|INNODB_CHANGE_BUFFERING_ALL",
      "innodb-compression-level": "int",
      "innodb-flush-log-at-trx-commit": "int",
      "innodb-ft-max-token-size": "int",
      "innodb-ft-min-token-size": "int",
      "innodb-io-capacity": "int",
      "innodb-io-capacity-max": "int",
      "innodb-lock-wait-timeout": "int",
      "innodb-log-buffer-size": "int",
      "innodb-log-file-size": "int",
      "innodb-lru-scan-depth": "int",
      "innodb-numa-interleave": "bool",
      "innodb-online-alter-log-max-size": "int",
      "innodb-page-size": "int",
      "innodb-print-all-deadlocks": "bool",
      "innodb-print-lock-wait-timeout-info": "bool",
      "innodb-purge-threads": "int",
      "innodb-read-io-threads": "int",
      "innodb-status-output": "bool",
      "innodb-strict-mode": "bool",
      "innodb-temp-data-file-max-size": "int",
      "innodb-thread-concurrency": "int",
      "innodb-write-io-threads": "int",
      "interactive-timeout": "int",
      "join-buffer-size": "int",
      "lock-wait-timeout": "int",
      "log-error-verbosity": "int",
      "log-slow-filter": [
        "FULL_SCAN|FULL_JOIN|TMP_TABLE|TMP_TABLE_ON_DISK|FILESORT|FILESORT_ON_DISK", ...
      ],
      "log-slow-rate-limit": "int",
      "log-slow-rate-type": "SESSION|QUERY",
      "log-slow-sp-statements": "bool",
      "long-query-time": "double",
      "lower-case-table-names": "int",
      "max-allowed-packet": "int",
      "max-connections": "int",
      "max-digest-length": "int",
      "max-execution-time": "int",
      "max-heap-table-size": "int",
      "max-prepared-stmt-count": "int",
      "max-sp-recursion-depth": "int",
      "max-write-lock-count": "int",
      "mdb-force-ssl": "bool",
      "mdb-offline-mode-disable-lag": "int",
      "mdb-offline-mode-enable-lag": "int",
      "mdb-preserve-binlog-bytes": "int",
      "mdb-priority-choice-max-lag": "int",
      "net-read-timeout": "int",
      "net-write-timeout": "int",
      "optimizer-search-depth": "int",
      "optimizer-switch": "str",
      "query-cache-limit": "int",
      "query-cache-size": "int",
      "query-cache-type": "int",
      "query-response-time-stats": "bool",
      "range-optimizer-max-mem-size": "int",
      "rpl-semi-sync-master-wait-for-slave-count": "int",
      "show-compatibility-56": "bool",
      "slave-parallel-type": "DATABASE|LOGICAL_CLOCK",
      "slave-parallel-workers": "int",
      "slow-query-log": "bool",
      "slow-query-log-always-write-time": "double",
      "sort-buffer-size": "int",
      "sql-mode": [
        "ALLOW_INVALID_DATES|ANSI_QUOTES|ERROR_FOR_DIVISION_BY_ZERO|HIGH_NOT_PRECEDENCE|IGNORE_SPACE|NO_AUTO_VALUE_ON_ZERO|NO_BACKSLASH_ESCAPES|NO_ENGINE_SUBSTITUTION|NO_UNSIGNED_SUBTRACTION|NO_ZERO_DATE|NO_ZERO_IN_DATE|NO_FIELD_OPTIONS|NO_KEY_OPTIONS|NO_TABLE_OPTIONS|ONLY_FULL_GROUP_BY|PAD_CHAR_TO_FULL_LENGTH|PIPES_AS_CONCAT|REAL_AS_FLOAT|STRICT_ALL_TABLES|STRICT_TRANS_TABLES|ANSI|TRADITIONAL|DB2|MAXDB|MSSQL|MYSQL323|MYSQL40|ORACLE|POSTGRESQL|NO_AUTO_CREATE_USER|NO_DIR_IN_CREATE", ...
      ],
      "sync-binlog": "int",
      "table-definition-cache": "int",
      "table-open-cache": "int",
      "table-open-cache-instances": "int",
      "thread-cache-size": "int",
      "thread-stack": "int",
      "tmp-table-size": "int",
      "transaction-isolation": "READ_COMMITTED|REPEATABLE_READ|SERIALIZABLE",
      "userstat": "bool",
      "wait-timeout": "int"
    },
    "mysql-config-8-0": {
      "audit-log": "bool",
      "audit-log-policy": "ALL|LOGINS|QUERIES|NONE",
      "auto-increment-increment": "int",
      "auto-increment-offset": "int",
      "autocommit": "bool",
      "binlog-cache-size": "int",
      "binlog-group-commit-sync-delay": "int",
      "binlog-row-image": "FULL|MINIMAL|NOBLOB",
      "binlog-rows-query-log-events": "bool",
      "binlog-transaction-dependency-tracking": "COMMIT_ORDER|WRITESET|WRITESET_SESSION",
      "character-set-server": "str",
      "collation-server": "str",
      "default-authentication-plugin": "MYSQL_NATIVE_PASSWORD|CACHING_SHA2_PASSWORD|SHA256_PASSWORD|MYSQL_NO_LOGIN|MDB_IAMPROXY_AUTH",
      "default-time-zone": "str",
      "explicit-defaults-for-timestamp": "bool",
      "general-log": "bool",
      "group-concat-max-len": "int",
      "innodb-adaptive-hash-index": "bool",
      "innodb-buffer-pool-size": "int",
      "innodb-change-buffering": "INNODB_CHANGE_BUFFERING_NONE|INNODB_CHANGE_BUFFERING_INSERTS|INNODB_CHANGE_BUFFERING_DELETES|INNODB_CHANGE_BUFFERING_CHANGES|INNODB_CHANGE_BUFFERING_PURGES|INNODB_CHANGE_BUFFERING_ALL",
      "innodb-compression-level": "int",
      "innodb-flush-log-at-trx-commit": "int",
      "innodb-ft-max-token-size": "int",
      "innodb-ft-min-token-size": "int",
      "innodb-io-capacity": "int",
      "innodb-io-capacity-max": "int",
      "innodb-lock-wait-timeout": "int",
      "innodb-log-buffer-size": "int",
      "innodb-log-file-size": "int",
      "innodb-lru-scan-depth": "int",
      "innodb-numa-interleave": "bool",
      "innodb-online-alter-log-max-size": "int",
      "innodb-page-size": "int",
      "innodb-print-all-deadlocks": "bool",
      "innodb-print-lock-wait-timeout-info": "bool",
      "innodb-purge-threads": "int",
      "innodb-read-io-threads": "int",
      "innodb-status-output": "bool",
      "innodb-strict-mode": "bool",
      "innodb-temp-data-file-max-size": "int",
      "innodb-thread-concurrency": "int",
      "innodb-write-io-threads": "int",
      "interactive-timeout": "int",
      "join-buffer-size": "int",
      "lock-wait-timeout": "int",
      "log-error-verbosity": "int",
      "log-slow-filter": [
        "FULL_SCAN|FULL_JOIN|TMP_TABLE|TMP_TABLE_ON_DISK|FILESORT|FILESORT_ON_DISK", ...
      ],
      "log-slow-rate-limit": "int",
      "log-slow-rate-type": "SESSION|QUERY",
      "log-slow-sp-statements": "bool",
      "long-query-time": "double",
      "lower-case-table-names": "int",
      "max-allowed-packet": "int",
      "max-connections": "int",
      "max-digest-length": "int",
      "max-execution-time": "int",
      "max-heap-table-size": "int",
      "max-prepared-stmt-count": "int",
      "max-sp-recursion-depth": "int",
      "max-write-lock-count": "int",
      "mdb-force-ssl": "bool",
      "mdb-offline-mode-disable-lag": "int",
      "mdb-offline-mode-enable-lag": "int",
      "mdb-preserve-binlog-bytes": "int",
      "mdb-priority-choice-max-lag": "int",
      "net-read-timeout": "int",
      "net-write-timeout": "int",
      "optimizer-search-depth": "int",
      "optimizer-switch": "str",
      "range-optimizer-max-mem-size": "int",
      "regexp-time-limit": "int",
      "replication-optimize-for-static-plugin-config": "bool",
      "replication-sender-observe-commit-only": "bool",
      "rpl-semi-sync-master-wait-for-slave-count": "int",
      "slave-parallel-type": "DATABASE|LOGICAL_CLOCK",
      "slave-parallel-workers": "int",
      "slow-query-log": "bool",
      "slow-query-log-always-write-time": "double",
      "sort-buffer-size": "int",
      "sql-mode": [
        "ALLOW_INVALID_DATES|ANSI_QUOTES|ERROR_FOR_DIVISION_BY_ZERO|HIGH_NOT_PRECEDENCE|IGNORE_SPACE|NO_AUTO_VALUE_ON_ZERO|NO_BACKSLASH_ESCAPES|NO_ENGINE_SUBSTITUTION|NO_UNSIGNED_SUBTRACTION|NO_ZERO_DATE|NO_ZERO_IN_DATE|ONLY_FULL_GROUP_BY|PAD_CHAR_TO_FULL_LENGTH|PIPES_AS_CONCAT|REAL_AS_FLOAT|STRICT_ALL_TABLES|STRICT_TRANS_TABLES|TIME_TRUNCATE_FRACTIONAL|ANSI|TRADITIONAL|NO_DIR_IN_CREATE", ...
      ],
      "sql-require-primary-key": "bool",
      "sync-binlog": "int",
      "table-definition-cache": "int",
      "table-open-cache": "int",
      "table-open-cache-instances": "int",
      "thread-cache-size": "int",
      "thread-stack": "int",
      "tmp-table-size": "int",
      "transaction-isolation": "READ_COMMITTED|REPEATABLE_READ|SERIALIZABLE",
      "userstat": "bool",
      "wait-timeout": "int"
    },
    "mysql-config-8-4": {
      "audit-log": "bool",
      "audit-log-policy": "ALL|LOGINS|QUERIES|NONE",
      "auto-increment-increment": "int",
      "auto-increment-offset": "int",
      "autocommit": "bool",
      "binlog-cache-size": "int",
      "binlog-group-commit-sync-delay": "int",
      "binlog-row-image": "FULL|MINIMAL|NOBLOB",
      "binlog-rows-query-log-events": "bool",
      "character-set-server": "str",
      "collation-server": "str",
      "default-time-zone": "str",
      "explicit-defaults-for-timestamp": "bool",
      "group-concat-max-len": "int",
      "innodb-adaptive-hash-index": "bool",
      "innodb-buffer-pool-size": "int",
      "innodb-change-buffering": "INNODB_CHANGE_BUFFERING_NONE|INNODB_CHANGE_BUFFERING_INSERTS|INNODB_CHANGE_BUFFERING_DELETES|INNODB_CHANGE_BUFFERING_CHANGES|INNODB_CHANGE_BUFFERING_PURGES|INNODB_CHANGE_BUFFERING_ALL",
      "innodb-compression-level": "int",
      "innodb-flush-log-at-trx-commit": "int",
      "innodb-ft-max-token-size": "int",
      "innodb-ft-min-token-size": "int",
      "innodb-io-capacity": "int",
      "innodb-io-capacity-max": "int",
      "innodb-lock-wait-timeout": "int",
      "innodb-log-buffer-size": "int",
      "innodb-log-file-size": "int",
      "innodb-lru-scan-depth": "int",
      "innodb-numa-interleave": "bool",
      "innodb-online-alter-log-max-size": "int",
      "innodb-page-size": "int",
      "innodb-print-all-deadlocks": "bool",
      "innodb-print-lock-wait-timeout-info": "bool",
      "innodb-purge-threads": "int",
      "innodb-read-io-threads": "int",
      "innodb-status-output": "bool",
      "innodb-strict-mode": "bool",
      "innodb-temp-data-file-max-size": "int",
      "innodb-thread-concurrency": "int",
      "innodb-write-io-threads": "int",
      "interactive-timeout": "int",
      "join-buffer-size": "int",
      "lock-wait-timeout": "int",
      "log-error-verbosity": "int",
      "log-slow-filter": [
        "FULL_SCAN|FULL_JOIN|TMP_TABLE|TMP_TABLE_ON_DISK|FILESORT|FILESORT_ON_DISK", ...
      ],
      "log-slow-rate-limit": "int",
      "log-slow-rate-type": "SESSION|QUERY",
      "log-slow-sp-statements": "bool",
      "long-query-time": "double",
      "lower-case-table-names": "int",
      "max-allowed-packet": "int",
      "max-connections": "int",
      "max-digest-length": "int",
      "max-execution-time": "int",
      "max-heap-table-size": "int",
      "max-prepared-stmt-count": "int",
      "max-sp-recursion-depth": "int",
      "max-write-lock-count": "int",
      "mdb-async-allowed-lag": "int",
      "mdb-force-ssl": "bool",
      "mdb-offline-mode-disable-lag": "int",
      "mdb-offline-mode-enable-lag": "int",
      "mdb-preserve-binlog-bytes": "int",
      "mdb-priority-choice-max-lag": "int",
      "mdb-use-async-replication": "bool",
      "net-read-timeout": "int",
      "net-write-timeout": "int",
      "optimizer-search-depth": "int",
      "optimizer-switch": "str",
      "range-optimizer-max-mem-size": "int",
      "regexp-time-limit": "int",
      "replication-optimize-for-static-plugin-config": "bool",
      "replication-sender-observe-commit-only": "bool",
      "rpl-semi-sync-master-wait-for-slave-count": "int",
      "slave-parallel-type": "DATABASE|LOGICAL_CLOCK",
      "slave-parallel-workers": "int",
      "slow-query-log": "bool",
      "slow-query-log-always-write-time": "double",
      "sort-buffer-size": "int",
      "sql-mode": [
        "ALLOW_INVALID_DATES|ANSI_QUOTES|ERROR_FOR_DIVISION_BY_ZERO|HIGH_NOT_PRECEDENCE|IGNORE_SPACE|NO_AUTO_VALUE_ON_ZERO|NO_BACKSLASH_ESCAPES|NO_ENGINE_SUBSTITUTION|NO_UNSIGNED_SUBTRACTION|NO_ZERO_DATE|NO_ZERO_IN_DATE|ONLY_FULL_GROUP_BY|PAD_CHAR_TO_FULL_LENGTH|PIPES_AS_CONCAT|REAL_AS_FLOAT|STRICT_ALL_TABLES|STRICT_TRANS_TABLES|TIME_TRUNCATE_FRACTIONAL|ANSI|TRADITIONAL|NO_DIR_IN_CREATE", ...
      ],
      "sql-require-primary-key": "bool",
      "sync-binlog": "int",
      "table-definition-cache": "int",
      "table-open-cache": "int",
      "table-open-cache-instances": "int",
      "thread-cache-size": "int",
      "thread-stack": "int",
      "tmp-table-size": "int",
      "transaction-isolation": "READ_COMMITTED|REPEATABLE_READ|SERIALIZABLE",
      "userstat": "bool",
      "wait-timeout": "int"
    }
  },
  "performance-diagnostics": {
    "enabled": "bool",
    "sessions-sampling-interval": "int",
    "statements-sampling-interval": "int"
  },
  "resources": {
    "disk-size": "int",
    "disk-type-id": "str",
    "resource-preset-id": "str"
  },
  "version": "str"
}
```

Fields:

```
access -> (struct)
  Access policy for external services. If the specific services need to access the cluster, then set the necessary values in this policy.
  data-lens -> (bool)
    Allows access from DataLens. See documentation for details.
  data-transfer -> (bool)
    Allow access for DataTransfer.
  web-sql -> (bool)
    Allows SQL queries to the cluster databases from management console. See documentation for details.
  yandex-query -> (bool)
    Allow access for YandexQuery.
backup-retain-period-days -> (int)
  Retention policy of automated backups.
backup-window-start -> (timeofday)
  Time to start the daily backup, in the UTC timezone.
disk-size-autoscaling -> (struct)
  Disk size autoscaling
  disk-size-limit -> (int)
    Limit on how large the storage for database instances can automatically grow, in bytes.
  emergency-usage-threshold -> (int)
    Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
  planned-usage-threshold -> (int)
    Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
performance-diagnostics -> (struct)
  Configuration of the performance diagnostics service.
  enabled -> (bool)
    Flag that shows if performance statistics gathering is enabled for the cluster.
  sessions-sampling-interval -> (int)
    Interval (in seconds) for 'my_session' sampling.
  statements-sampling-interval -> (int)
    Interval (in seconds) for 'my_statements' sampling.
resources -> (struct)
  Resource preset for the cluster hosts.
  disk-size -> (int)
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
    audit-log -> (bool)
      Enable writing of audit log of MySQL. See MySQL documentation for details.
    audit-log-policy -> (struct)
      The policy controlling how the audit log plugin writes events to its log file For details, see MySQL documentation for the variable
    auto-increment-increment -> (int)
      Can be used to control the operation of AUTO_INCREMENT columns. See MySQL documentation for details.
    auto-increment-offset -> (int)
      Can be used to control the operation of AUTO_INCREMENT columns. See MySQL documentation for details.
    autocommit -> (bool)
      Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it. For details, see MySQL documentation for the variable.
    binlog-cache-size -> (int)
      The size of the cache to hold changes to the binary log during a transaction. See MySQL documentation for details.
    binlog-group-commit-sync-delay -> (int)
      Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk. See MySQL documentation for the variable for details.
    binlog-row-image -> (struct)
      For MySQL row-based replication, this variable determines how row images are written to the binary log. See MySQL documentation for details.
    binlog-rows-query-log-events -> (bool)
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
    explicit-defaults-for-timestamp -> (bool)
      Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns. See MySQL documentation for details.
    general-log -> (bool)
      Enable writing of general query log of MySQL. See MySQL documentation for details.
    group-concat-max-len -> (int)
      The maximum permitted result length in bytes for the GROUP_CONCAT() function. See MySQL documentation for details.
    innodb-adaptive-hash-index -> (bool)
      Enables InnoDB adaptive hash index. See MySQL documentation for details.
    innodb-buffer-pool-size -> (int)
      Size of the InnoDB buffer pool used for caching table and index data. See MySQL documentation for details.
    innodb-change-buffering -> (struct)
      An optimization for change buffering For details, see MySQL documentation for the variable.
    innodb-compression-level -> (int)
      The level of zlib compression to use for InnoDB compressed tables and indexes. For details, see MySQL documentation for the variable.
    innodb-flush-log-at-trx-commit -> (int)
      Transaction log flush behaviour. See MySQL documentation for details.
    innodb-ft-max-token-size -> (int)
      Maximum length of words that are stored in an InnoDB FULLTEXT index For details, see MySQL documentation for the variable.
    innodb-ft-min-token-size -> (int)
      Minimum length of words that are stored in an InnoDB FULLTEXT index For details, see MySQL documentation for the variable.
    innodb-io-capacity -> (int)
      Limits IO available for InnoDB background tasks. See MySQL documentation for details.
    innodb-io-capacity-max -> (int)
      Limits IO available for InnoDB background tasks. See MySQL documentation for details.
    innodb-lock-wait-timeout -> (int)
      Max time in seconds for a transaction to wait for a row lock. See MySQL documentation for details.
    innodb-log-buffer-size -> (int)
      The size in bytes of the buffer that InnoDB uses to write to the log files on disk. See MySQL documentation for details.
    innodb-log-file-size -> (int)
      The size in bytes of the single InnoDB Redo log file. See MySQL documentation for details.
    innodb-lru-scan-depth -> (int)
      A parameter that influences the algorithms and heuristics for the flush operation for the InnoDB buffer pool For details, see MySQL documentation for the variable
    innodb-numa-interleave -> (bool)
      Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool. See MySQL documentation for details.
    innodb-online-alter-log-max-size -> (int)
      The limit in bytes on the size of the temporary log files used during online DDL operations For details, see MySQL documentation for the variable.
    innodb-page-size -> (int)
      Specifies the page size for InnoDB tablespaces. For details, see MySQL documentation for the variable.
    innodb-print-all-deadlocks -> (bool)
      Print information about deadlocks in error log. See MySQL documentation for details.
    innodb-print-lock-wait-timeout-info -> (bool)
      Makes InnoDB to write information about all lock wait timeout errors into the log file. For details, see Percona documentation for the variable.
    innodb-purge-threads -> (int)
      The number of background threads devoted to the InnoDB purge operation. See MySQL documentation for details.
    innodb-read-io-threads -> (int)
      The number of I/O threads for read operations in InnoDB. See MySQL documentation for details.
    innodb-status-output -> (bool)
      Enables or disables periodic output for the standard InnoDB Monitor. For details, see MySQL documentation for the variable.
    innodb-strict-mode -> (bool)
      When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options. For details, see MySQL documentation for the variable.
    innodb-temp-data-file-max-size -> (int)
      Limits the max size of InnoDB temp tablespace. See MySQL documentation for details.
    innodb-thread-concurrency -> (int)
      Defines the maximum number of threads permitted inside of InnoDB. See MySQL documentation for details.
    innodb-write-io-threads -> (int)
      The number of I/O threads for write operations in InnoDB. See MySQL documentation for details.
    interactive-timeout -> (int)
      The number of seconds the server waits for activity on an interactive connection before closing it. See MySQL documentation for details.
    join-buffer-size -> (int)
      The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans. See MySQL documentation for details.
    lock-wait-timeout -> (int)
      // This variable specifies the timeout in seconds for attempts to acquire metadata locks For details, see MySQL documentation for the variable.
    log-error-verbosity -> (int)
      System variable specifies the verbosity for handling events intended for the error log For details, see MySQL documentation for the variable.
    log-slow-filter -> ([]struct)
      Filters the slow log by the query's execution plan. See Percona documentation for details.
    log-slow-rate-limit -> (int)
      Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query. See Percona documentation for details.
    log-slow-rate-type -> (struct)
      Specifies slow log granularity for 'log_slow_rate_limit' values QUERY or SESSION. See Percona documentation for details.
    log-slow-sp-statements -> (bool)
      When TRUE, statements executed by stored procedures are logged to the slow log. See Percona documentation for details.
    long-query-time -> (double)
      Time that it takes to process a query before it is considered slow. See MySQL documentation for details.
    lower-case-table-names -> (int)
      Table names storage and comparison strategy For details, see MySQL documentation for the variable.
    max-allowed-packet -> (int)
      The maximum size in bytes of one packet. See MySQL documentation for details.
    max-connections -> (int)
      The maximum permitted number of simultaneous client connections. See MySQL documentation for details.
    max-digest-length -> (int)
      The maximum number of bytes of memory reserved per session for computation of normalized statement digests. For details, see MySQL documentation for the variable.
    max-execution-time -> (int)
      The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled. For details, see MySQL documentation for the variable
    max-heap-table-size -> (int)
      This variable sets the maximum size to which user-created MEMORY tables are permitted to grow. See MySQL documentation for details.
    max-prepared-stmt-count -> (int)
      This variable limits the total number of prepared statements in the server. For details, see MySQL documentation for the variable.
    max-sp-recursion-depth -> (int)
      The number of times that any given stored procedure may be called recursively. For details, see MySQL documentation for the variable.
    max-write-lock-count -> (int)
      Permit some pending read lock requests interval P.S. Should be UInt64, but java fails to handle UInt64 limits For details, see Percona documentation for the variable.
    mdb-force-ssl -> (bool)
      Force ssl on all hosts (require_secure_transport)
    mdb-offline-mode-disable-lag -> (int)
      Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'. Should be less than mdb_offline_mode_enable_lag value.
    mdb-offline-mode-enable-lag -> (int)
      Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.
    mdb-preserve-binlog-bytes -> (int)
      The size of the binary log to hold.
    mdb-priority-choice-max-lag -> (int)
      Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from". Should be less than mdb_offline_mode_disable_lag.
    net-read-timeout -> (int)
      The number of seconds to wait for more data from a connection before aborting the read. See MySQL documentation for details.
    net-write-timeout -> (int)
      The number of seconds to wait for a block to be written to a connection before aborting the write. See MySQL documentation for details.
    optimizer-search-depth -> (int)
      The maximum depth of search performed by the query optimizer For details, see MySQL documentation for the variable
    optimizer-switch -> (string)
      The system variable enables control over optimizer behavior. For details, see MySQL documentation for the variable https://dev.mysql.com/doc/refman/5.7/en/switchable-optimizations.html
    query-cache-limit -> (int)
      Do not cache results that are larger than this number of bytes. For details, see MySQL documentation for the variable.
    query-cache-size -> (int)
      The amount of memory allocated for caching query results. For details, see MySQL documentation for the variable.
    query-cache-type -> (int)
      Set the query cache type. For details, see MySQL documentation for the variable.
    query-response-time-stats -> (bool)
      Enables and disables collection of query times For details, see Percona documentation for the variable.
    range-optimizer-max-mem-size -> (int)
      The limit on memory consumption for the range optimizer. See MySQL documentation for details.
    rpl-semi-sync-master-wait-for-slave-count -> (int)
      The number of replica acknowledgments the source must receive per transaction before proceeding. See MySQL documentation for details.
    show-compatibility-56 -> (bool)
      Manages MySQL 5.6 compatibility For details, see MySQL documentation for the variable.
    slave-parallel-type -> (struct)
      When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica. See MySQL documentation for details.
    slave-parallel-workers -> (int)
      Sets the number of applier threads for executing replication transactions in parallel. See MySQL documentation for details.
    slow-query-log -> (bool)
      Manages slow query log. See MySQL documentation for details.
    slow-query-log-always-write-time -> (double)
      Query execution time, after which query to be logged unconditionally, that is, 'log_slow_rate_limit'' will not apply to it. See Percona documentation for details.
    sort-buffer-size -> (int)
      Each session that must perform a sort allocates a buffer of this size. See MySQL documentation for details.
    sql-mode -> ([]struct)
      Server SQL mode of MySQL. See MySQL documentation for details.
    sync-binlog -> (int)
      Controls how often the MySQL server synchronizes the binary log to disk. See MySQL documentation for details.
    table-definition-cache -> (int)
      The number of table definitions that can be stored in the definition cache. See MySQL documentation for details.
    table-open-cache -> (int)
      The number of open tables for all threads. See MySQL documentation for details.
    table-open-cache-instances -> (int)
      The number of open tables cache instances. See MySQL documentation for details.
    thread-cache-size -> (int)
      A number of threads the server should cache for reuse. See MySQL documentation for details.
    thread-stack -> (int)
      The stack size for each thread. The default is large enough for normal operation. See MySQL documentation for details.
    tmp-table-size -> (int)
      The maximum size of internal in-memory temporary tables. See MySQL documentation for details.
    transaction-isolation -> (struct)
      Default transaction isolation level. See MySQL documentation for details.
    userstat -> (bool)
      Enables or disables collection of statistics For details, see Percona documentation for the variable.
    wait-timeout -> (int)
      The number of seconds the server waits for activity on a noninteractive connection before closing it. See MySQL documentation for details.
  mysql-config-8-0 -> (struct)
    Configuration for a MySQL 8.0 cluster.
    audit-log -> (bool)
      Enable writing of audit log of MySQL. See MySQL documentation for details.
    audit-log-policy -> (struct)
      The policy controlling how the audit log plugin writes events to its log file For details, see MySQL documentation for the variable
    auto-increment-increment -> (int)
      Can be used to control the operation of AUTO_INCREMENT columns. See MySQL documentation for details.
    auto-increment-offset -> (int)
      Can be used to control the operation of AUTO_INCREMENT columns. See MySQL documentation for details.
    autocommit -> (bool)
      Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it. For details, see MySQL documentation for the variable.
    binlog-cache-size -> (int)
      The size of the cache to hold changes to the binary log during a transaction. See MySQL documentation for details.
    binlog-group-commit-sync-delay -> (int)
      Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk. See MySQL documentation for details.
    binlog-row-image -> (struct)
      For MySQL row-based replication, this variable determines how row images are written to the binary log. See MySQL documentation for details.
    binlog-rows-query-log-events -> (bool)
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
    explicit-defaults-for-timestamp -> (bool)
      Determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns. See MySQL documentation for details.
    general-log -> (bool)
      Enable writing of general query log of MySQL. See MySQL documentation for details.
    group-concat-max-len -> (int)
      The maximum permitted result length in bytes for the GROUP_CONCAT() function. See MySQL documentation for details.
    innodb-adaptive-hash-index -> (bool)
      Enables InnoDB adaptive hash index. See MySQL documentation for details.
    innodb-buffer-pool-size -> (int)
      Size of the InnoDB buffer pool used for caching table and index data. See MySQL documentation for details.
    innodb-change-buffering -> (struct)
      An optimization for change buffering For details, see MySQL documentation for the variable.
    innodb-compression-level -> (int)
      The level of zlib compression to use for InnoDB compressed tables and indexes. For details, see MySQL documentation for the variable.
    innodb-flush-log-at-trx-commit -> (int)
      Transaction log flush behaviour. See MySQL documentation for details.
    innodb-ft-max-token-size -> (int)
      Maximum length of words that are stored in an InnoDB FULLTEXT index See MySQL documentation for the variable for details.
    innodb-ft-min-token-size -> (int)
      Minimum length of words that are stored in an InnoDB FULLTEXT index See MySQL documentation for the variable for details.
    innodb-io-capacity -> (int)
      Limits IO available for InnoDB background tasks. See MySQL documentation for details.
    innodb-io-capacity-max -> (int)
      Limits IO available for InnoDB background tasks. See MySQL documentation for details.
    innodb-lock-wait-timeout -> (int)
      Max time in seconds for a transaction to wait for a row lock. See MySQL documentation for details.
    innodb-log-buffer-size -> (int)
      The size in bytes of the buffer that InnoDB uses to write to the log files on disk. See MySQL documentation for details.
    innodb-log-file-size -> (int)
      The size in bytes of the single InnoDB Redo log file. See MySQL documentation for details.
    innodb-lru-scan-depth -> (int)
      A parameter that influences the algorithms and heuristics for the flush operation for the InnoDB buffer pool For details, see MySQL documentation for the variable
    innodb-numa-interleave -> (bool)
      Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool. See MySQL documentation for details.
    innodb-online-alter-log-max-size -> (int)
      The limit in bytes on the size of the temporary log files used during online DDL operations See MySQL documentation for the variable for details.
    innodb-page-size -> (int)
      Specifies the page size for InnoDB tablespaces. For details, see MySQL documentation for the variable.
    innodb-print-all-deadlocks -> (bool)
      Print information about deadlocks in error log. See MySQL documentation for details.
    innodb-print-lock-wait-timeout-info -> (bool)
      Makes InnoDB to write information about all lock wait timeout errors into the log file. For details, see Percona documentation for the variable.
    innodb-purge-threads -> (int)
      The number of background threads devoted to the InnoDB purge operation. See MySQL documentation for details.
    innodb-read-io-threads -> (int)
      The number of I/O threads for read operations in InnoDB. See MySQL documentation for details.
    innodb-status-output -> (bool)
      Enables or disables periodic output for the standard InnoDB Monitor. For details, see MySQL documentation for the variable.
    innodb-strict-mode -> (bool)
      When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options. For details, see MySQL documentation for the variable.
    innodb-temp-data-file-max-size -> (int)
      Limits the max size of InnoDB temp tablespace. See MySQL documentation for details.
    innodb-thread-concurrency -> (int)
      Defines the maximum number of threads permitted inside of InnoDB. See MySQL documentation for details.
    innodb-write-io-threads -> (int)
      The number of I/O threads for write operations in InnoDB. See MySQL documentation for details.
    interactive-timeout -> (int)
      The number of seconds the server waits for activity on an interactive connection before closing it. See MySQL documentation for details.
    join-buffer-size -> (int)
      The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans. See MySQL documentation for details.
    lock-wait-timeout -> (int)
      This variable specifies the timeout in seconds for attempts to acquire metadata locks For details, see MySQL documentation for the variable.
    log-error-verbosity -> (int)
      System variable specifies the verbosity for handling events intended for the error log For details, see MySQL documentation for the variable.
    log-slow-filter -> ([]struct)
      Filters the slow log by the query's execution plan. See Percona documentation for details.
    log-slow-rate-limit -> (int)
      Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query. See Percona documentation for details.
    log-slow-rate-type -> (struct)
      Specifies slow log granularity for 'log_slow_rate_limit' QUERY or SESSION value. See Percona documentation for details.
    log-slow-sp-statements -> (bool)
      When TRUE, statements executed by stored procedures are logged to the slow log. See Percona documentation for details.
    long-query-time -> (double)
      Time that it takes to process a query before it is considered slow. See MySQL documentation for details.
    lower-case-table-names -> (int)
      Table names storage and comparison strategy See MySQL documentation for the variable for details.
    max-allowed-packet -> (int)
      The maximum size in bytes of one packet. See MySQL documentation for details.
    max-connections -> (int)
      The maximum permitted number of simultaneous client connections. See MySQL documentation for details.
    max-digest-length -> (int)
      The maximum number of bytes of memory reserved per session for computation of normalized statement digests. For details, see MySQL documentation for the variable.
    max-execution-time -> (int)
      The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled. For details, see MySQL documentation for the variable
    max-heap-table-size -> (int)
      This variable sets the maximum size to which user-created MEMORY tables are permitted to grow. See MySQL documentation for details.
    max-prepared-stmt-count -> (int)
      This variable limits the total number of prepared statements in the server. For details, see MySQL documentation for the variable.
    max-sp-recursion-depth -> (int)
      The number of times that any given stored procedure may be called recursively. For details, see MySQL documentation for the variable.
    max-write-lock-count -> (int)
      Permit some pending read lock requests interval P.S. Should be UInt64, but java fails to handle UInt64 limits For details, see Percona documentation for the variable.
    mdb-force-ssl -> (bool)
      Force ssl on all hosts (require_secure_transport)
    mdb-offline-mode-disable-lag -> (int)
      Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'. Should be less than mdb_offline_mode_enable_lag.
    mdb-offline-mode-enable-lag -> (int)
      Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.
    mdb-preserve-binlog-bytes -> (int)
      The size of the binary log to hold.
    mdb-priority-choice-max-lag -> (int)
      Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from". Should be less than mdb_offline_mode_disable_lag.
    net-read-timeout -> (int)
      The number of seconds to wait for more data from a connection before aborting the read. See MySQL documentation for details.
    net-write-timeout -> (int)
      The number of seconds to wait for a block to be written to a connection before aborting the write. See MySQL documentation for details.
    optimizer-search-depth -> (int)
      The maximum depth of search performed by the query optimizer For details, see MySQL documentation for the variable
    optimizer-switch -> (string)
      The system variable enables control over optimizer behavior. For details, see MySQL documentation for the variable https://dev.mysql.com/doc/refman/8.0/en/switchable-optimizations.html
    range-optimizer-max-mem-size -> (int)
      The limit on memory consumption for the range optimizer. See MySQL documentation for details.
    regexp-time-limit -> (int)
      The time limit for regular expression matching operations performed by REGEXP_LIKE and similar functions. See MySQL documentation for details.
    replication-optimize-for-static-plugin-config -> (bool)
      Use shared locks, and avoid unnecessary lock acquisitions, to improve performance for semisynchronous replication For details, see MySQL documentation for the variable.
    replication-sender-observe-commit-only -> (bool)
      Limit callbacks to improve performance for semisynchronous replication For details, see MySQL documentation for the variable.
    rpl-semi-sync-master-wait-for-slave-count -> (int)
      The number of replica acknowledgments the source must receive per transaction before proceeding. See MySQL documentation for details.
    slave-parallel-type -> (struct)
      When using a multi-threaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica. See MySQL documentation for details.
    slave-parallel-workers -> (int)
      Sets the number of applier threads for executing replication transactions in parallel. See MySQL documentation for details.
    slow-query-log -> (bool)
      Manages slow query log. See MySQL documentation for details.
    slow-query-log-always-write-time -> (double)
      Query execution time, after which query to be logged unconditionally, that is, 'log_slow_rate_limit' will not apply to it. See Percona documentation for details.
    sort-buffer-size -> (int)
      Each session that must perform a sort allocates a buffer of this size. See MySQL documentation for details.
    sql-mode -> ([]struct)
      Server SQL mode of MySQL. See MySQL documentation for details.
    sql-require-primary-key -> (bool)
      Whether statements that create new tables or alter the structure of existing tables enforce the requirement that tables have a primary key For details, see MySQL documentation for the variable.
    sync-binlog -> (int)
      Controls how often the MySQL server synchronizes the binary log to disk. See MySQL documentation for details.
    table-definition-cache -> (int)
      The number of table definitions that can be stored in the definition cache. See MySQL documentation for details.
    table-open-cache -> (int)
      The number of open tables for all threads. See MySQL documentation for details.
    table-open-cache-instances -> (int)
      The number of open tables cache instances. See MySQL documentation for details.
    thread-cache-size -> (int)
      How many threads the server should cache for reuse. See MySQL documentation for details.
    thread-stack -> (int)
      The stack size for each thread. The default is large enough for normal operation. See MySQL documentation for details.
    tmp-table-size -> (int)
      The maximum size of internal in-memory temporary tables. See MySQL documentation for details.
    transaction-isolation -> (struct)
      Default transaction isolation level. See MySQL documentation for details.
    userstat -> (bool)
      Enables or disables collection of statistics For details, see Percona documentation for the variable.
    wait-timeout -> (int)
      The number of seconds the server waits for activity on a noninteractive connection before closing it. See MySQL documentation for details.
  mysql-config-8-4 -> (struct)
    Configuration for a MySQL 8.4 cluster.
    audit-log -> (bool)
      Enable writing of audit log of MySQL. For details, see MySQL documentation for the variable.
    audit-log-policy -> (struct)
      The policy controlling how the audit log plugin writes events to its log file For details, see MySQL documentation for the variable
    auto-increment-increment -> (int)
      Can be used to control the operation of AUTO_INCREMENT columns. For details, see MySQL documentation for the variable.
    auto-increment-offset -> (int)
      Can be used to control the operation of AUTO_INCREMENT columns. For details, see MySQL documentation for the variable.
    autocommit -> (bool)
      Config specific will be all changes to a table take effect immediately or you must use COMMIT to accept a transaction or ROLLBACK to cancel it. For details, see MySQL documentation for the variable.
    binlog-cache-size -> (int)
      The size of the cache to hold changes to the binary log during a transaction. For details, see MySQL documentation for the variable.
    binlog-group-commit-sync-delay -> (int)
      Controls how many microseconds the binary log commit waits before synchronizing the binary log file to disk. For details, see MySQL documentation for the variable.
    binlog-row-image -> (struct)
      For MySQL row-based replication, this variable determines how row images are written to the binary log. For details, see MySQL documentation for the variable.
    binlog-rows-query-log-events -> (bool)
      When enabled, it causes the server to write informational log events such as row query log events into its binary log. For details, see MySQL documentation for the variable.
    character-set-server -> (string)
      The servers default character set. For details, see MySQL documentation for the variable
    collation-server -> (string)
      Set the default server collation. For details, see MySQL documentation for the variable
    default-time-zone -> (string)
      The servers default time zone. For details, see MySQL documentation for the variable
    explicit-defaults-for-timestamp -> (bool)
      This system variable determines whether the server enables certain nonstandard behaviors for default values and NULL-value handling in TIMESTAMP columns. For details, see MySQL documentation for the variable.
    group-concat-max-len -> (int)
      The maximum permitted result length in bytes for the GROUP_CONCAT() function. For details, see MySQL documentation for the variable
    innodb-adaptive-hash-index -> (bool)
      Enables Innodb adaptive hash index For details, see MySQL documentation for the variable
    innodb-buffer-pool-size -> (int)
      Size of the InnoDB buffer pool used for caching table and index data. For details, see MySQL documentation for the parameter.
    innodb-change-buffering -> (struct)
      An optimization for change buffering For details, see Percona documentation for the variable.
    innodb-compression-level -> (int)
      The level of zlib compression to use for InnoDB compressed tables and indexes. For details, see MySQL documentation for the variable.
    innodb-flush-log-at-trx-commit -> (int)
      Transaction log flush behaviour. For details, see MySQL documentation for the variable
    innodb-ft-max-token-size -> (int)
      Maximum length of words that are stored in an InnoDB FULLTEXT index For details, see MySQL documentation for the variable.
    innodb-ft-min-token-size -> (int)
      Minimum length of words that are stored in an InnoDB FULLTEXT index For details, see MySQL documentation for the variable.
    innodb-io-capacity -> (int)
      Limits IO available for InnoDB background tasks For details, see MySQL documentation for the variable
    innodb-io-capacity-max -> (int)
      Limits IO available for InnoDB background tasks For details, see MySQL documentation for the variable
    innodb-lock-wait-timeout -> (int)
      Max time in seconds for a transaction to wait for a row lock For details, see MySQL documentation for the variable
    innodb-log-buffer-size -> (int)
      The size in bytes of the buffer that InnoDB uses to write to the log files on disk. For details, see MySQL documentation for the variable
    innodb-log-file-size -> (int)
      The size in bytes of the single Innodb Redo log file. For details, see MySQL documentation for the variable
    innodb-lru-scan-depth -> (int)
      A parameter that influences the algorithms and heuristics for the flush operation for the InnoDB buffer pool For details, see MySQL documentation for the variable
    innodb-numa-interleave -> (bool)
      Enables the NUMA interleave memory policy for allocation of the InnoDB buffer pool. For details, see MySQL documentation for the variable
    innodb-online-alter-log-max-size -> (int)
      The limit in bytes on the size of the temporary log files used during online DDL operations For details, see MySQL documentation for the variable.
    innodb-page-size -> (int)
      Specifies the page size for InnoDB tablespaces. For details, see MySQL documentation for the variable.
    innodb-print-all-deadlocks -> (bool)
      Print information about deadlocks in error log For details, see MySQL documentation for the variable
    innodb-print-lock-wait-timeout-info -> (bool)
      Makes InnoDB to write information about all lock wait timeout errors into the log file. For details, see Percona documentation for the variable.
    innodb-purge-threads -> (int)
      The number of background threads devoted to the InnoDB purge operation. For details, see MySQL documentation for the variable
    innodb-read-io-threads -> (int)
      The number of I/O threads for read operations in InnoDB. For details, see MySQL documentation for the variable
    innodb-status-output -> (bool)
      Enables or disables periodic output for the standard InnoDB Monitor. For details, see MySQL documentation for the variable.
    innodb-strict-mode -> (bool)
      When innodb_strict_mode is enabled, InnoDB returns errors rather than warnings when checking for invalid or incompatible table options. For details, see MySQL documentation for the variable.
    innodb-temp-data-file-max-size -> (int)
      Limits the max size of InnoDB temp tablespace For details, see MySQL documentation for the variable
    innodb-thread-concurrency -> (int)
      Defines the maximum number of threads permitted inside of InnoDB. For details, see MySQL documentation for the variable
    innodb-write-io-threads -> (int)
      The number of I/O threads for write operations in InnoDB. For details, see MySQL documentation for the variable
    interactive-timeout -> (int)
      The number of seconds the server waits for activity on an interactive connection before closing it. For details, see MySQL documentation for the variable.
    join-buffer-size -> (int)
      The minimum size of the buffer that is used for plain index scans, range index scans, and joins that do not use indexes and thus perform full table scans. For details, see MySQL documentation for the variable.
    lock-wait-timeout -> (int)
      This variable specifies the timeout in seconds for attempts to acquire metadata locks For details, see MySQL documentation for the variable.
    log-error-verbosity -> (int)
      System variable specifies the verbosity for handling events intended for the error log For details, see MySQL documentation for the variable.
    log-slow-filter -> ([]struct)
      Filters the slow log by the query's execution plan For details, see Percona documentation for the variable.
    log-slow-rate-limit -> (int)
      Specifies what fraction of session/query should be logged. Logging is enabled for every nth session/query. For details, see Percona documentation for the variable.
    log-slow-rate-type -> (struct)
      Specifies slow log granularity for log_slow_rate_limit: QUERY or SESSION For details, see Percona documentation for the variable.
    log-slow-sp-statements -> (bool)
      When TRUE, statements executed by stored procedures are logged to the slow log For details, see Percona documentation for the variable.
    long-query-time -> (double)
      Time that it takes to process a query before it is considered slow. For details, see MySQL documentation for the variable.
    lower-case-table-names -> (int)
      Table names storage and comparison strategy For details, see MySQL documentation for the variable.
    max-allowed-packet -> (int)
      The maximum size in bytes of one packet. For details, see MySQL documentation for the variable.
    max-connections -> (int)
      The maximum permitted number of simultaneous client connections. For details, see MySQL documentation for the variable.
    max-digest-length -> (int)
      The maximum number of bytes of memory reserved per session for computation of normalized statement digests. For details, see MySQL documentation for the variable.
    max-execution-time -> (int)
      The execution timeout for SELECT statements, in milliseconds. If the value is 0, timeouts are not enabled. For details, see MySQL documentation for the variable
    max-heap-table-size -> (int)
      This variable sets the maximum size to which user-created MEMORY tables are permitted to grow. For details, see MySQL documentation for the variable
    max-prepared-stmt-count -> (int)
      This variable limits the total number of prepared statements in the server. For details, see MySQL documentation for the variable.
    max-sp-recursion-depth -> (int)
      The number of times that any given stored procedure may be called recursively. For details, see MySQL documentation for the variable.
    max-write-lock-count -> (int)
      Permit some pending read lock requests interval P.S. Should be UInt64, but java fails to handle UInt64 limits For details, see Percona documentation for the variable.
    mdb-async-allowed-lag -> (int)
      Async replication allowed lag (seconds)
    mdb-force-ssl -> (bool)
      Force ssl on all hosts (require_secure_transport)
    mdb-offline-mode-disable-lag -> (int)
      Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = OFF'. Should be less than mdb_offline_mode_enable_lag.
    mdb-offline-mode-enable-lag -> (int)
      Replication lag threshold (seconds) which will switch MySQL to 'offline_mode = ON' to prevent users from reading stale data.
    mdb-preserve-binlog-bytes -> (int)
      The size of the binary log to hold.
    mdb-priority-choice-max-lag -> (int)
      Replication lag threshold (seconds) which allows replica to be promoted to master while executing "switchover from". Should be less than mdb_offline_mode_disable_lag.
    mdb-use-async-replication -> (bool)
      Enable async replication
    net-read-timeout -> (int)
      The number of seconds to wait for more data from a connection before aborting the read. For details, see MySQL documentation for the variable
    net-write-timeout -> (int)
      The number of seconds to wait for a block to be written to a connection before aborting the write. For details, see MySQL documentation for the variable
    optimizer-search-depth -> (int)
      The maximum depth of search performed by the query optimizer For details, see MySQL documentation for the variable
    optimizer-switch -> (string)
      The system variable enables control over optimizer behavior. For details, see [MySQL documentation for the variable] https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_optimizer_switch https://dev.mysql.com/doc/refman/8.4/en/switchable-optimizations.html
    range-optimizer-max-mem-size -> (int)
      The limit on memory consumption for the range optimizer. For details, see MySQL documentation for the variable.
    regexp-time-limit -> (int)
      The time limit for regular expression matching operations performed by REGEXP_LIKE and similar functions For details, see MySQL documentation for the variable.
    replication-optimize-for-static-plugin-config -> (bool)
      Use shared locks, and avoid unnecessary lock acquisitions, to improve performance for semisynchronous replication For details, see Percona documentation for the variable.
    replication-sender-observe-commit-only -> (bool)
      Limit callbacks to improve performance for semisynchronous replication For details, see Percona documentation for the variable.
    rpl-semi-sync-master-wait-for-slave-count -> (int)
      The number of replica acknowledgments the source must receive per transaction before proceeding. For details, see MySQL documentation for the variable.
    slave-parallel-type -> (struct)
      When using a multithreaded replica, this variable specifies the policy used to decide which transactions are allowed to execute in parallel on the replica. For details, see MySQL documentation for the variable.
    slave-parallel-workers -> (int)
      Sets the number of applier threads for executing replication transactions in parallel. For details, see MySQL documentation for the variable.
    slow-query-log -> (bool)
      Manages slow query log For details, see MySQL documentation for the variable.
    slow-query-log-always-write-time -> (double)
      Query execution time, after which query to be logged unconditionally, that is, log_slow_rate_limit will not apply to it For details, see Percona documentation for the variable.
    sort-buffer-size -> (int)
      Each session that must perform a sort allocates a buffer of this size. For details, see MySQL documentation for the variable.
    sql-mode -> ([]struct)
      Server SQL mode of MySQL. For details, see MySQL documentation for the variable.
    sql-require-primary-key -> (bool)
      Whether statements that create new tables or alter the structure of existing tables enforce the requirement that tables have a primary key For details, see Percona documentation for the variable.
    sync-binlog -> (int)
      Controls how often the MySQL server synchronizes the binary log to disk. For details, see MySQL documentation for the variable.
    table-definition-cache -> (int)
      The number of table definitions that can be stored in the definition cache. For details, see MySQL documentation for the variable.
    table-open-cache -> (int)
      The number of open tables for all threads. For details, see MySQL documentation for the variable.
    table-open-cache-instances -> (int)
      The number of open tables cache instances. For details, see MySQL documentation for the variable.
    thread-cache-size -> (int)
      How many threads the server should cache for reuse. For details, see MySQL documentation for the variable.
    thread-stack -> (int)
      The stack size for each thread. The default is large enough for normal operation. For details, see MySQL documentation for the variable.
    tmp-table-size -> (int)
      The maximum size of internal in-memory temporary tables. For details, see MySQL documentation for the variable
    transaction-isolation -> (struct)
      Default transaction isolation level. For details, see MySQL documentation for the variable
    userstat -> (bool)
      Enables or disables collection of statistics For details, see Percona documentation for the variable.
    wait-timeout -> (int)
      The number of seconds the server waits for activity on a noninteractive connection before closing it. For details, see MySQL documentation for the variable.
``` ||
|| `--database-specs` | `shorthand/json`

Configuration of databases in the cluster.

Shorthand Syntax:

```hcl
[
  {
    name = str
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "name": "str"
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
|| `--host-group-ids` | `strings`

Host groups hosting VMs of the cluster. ||
|| `--host-specs` | `shorthand/json`

Configuration of hosts in the cluster.

Shorthand Syntax:

```hcl
[
  {
    assign-public-ip = bool,
    backup-priority = int,
    priority = int,
    replication-source = str,
    subnet-id = str,
    zone-id = str
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "assign-public-ip": "bool",
    "backup-priority": "int",
    "priority": "int",
    "replication-source": "str",
    "subnet-id": "str",
    "zone-id": "str"
  }, ...
]
```

Fields:

```
assign-public-ip -> (bool)
  Option that enables public IP address for the host so that the host can be accessed from the internet. After a host has been created, this setting cannot be changed. To remove an assigned public IP address, or to assign a public IP address to a host without one, recreate the host with the appropriate [assign_public_ip] value set. Possible values: * 'false' - don't assign a public IP address to the host. * 'true' - assign a public IP address to the host.
backup-priority -> (int)
  Host backup priority
priority -> (int)
  Host master promotion priority
replication-source -> (string)
  [Host.name] of the host to be used as the replication source (for cascading replication).
subnet-id -> (string)
  ID of the subnet to assign to the host. This subnet should be a part of the cluster network (the network ID is specified in the [ClusterService.CreateClusterRequest.network_id]).
zone-id -> (string)
  ID of the availability zone where the host resides. To get a list of available zones, make the [yandex.cloud.compute.v1.ZoneService.List] request.
``` ||
|| `--labels` | `stringToString`

Custom labels for the cluster as 'key:value' pairs. ||
|| `--maintenance-window` | `shorthand/json`

Window of maintenance operations.

Shorthand Syntax:

```hcl
{
  policy = anytime={} | weekly-maintenance-window={
    day = MON|TUE|WED|THU|FRI|SAT|SUN,
    hour = int
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
      "hour": "int"
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
    hour -> (int)
      Hour of the day in UTC (in 'HH' format).
``` ||
|| `--name` | `string`

Name of the cluster. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the network to create the cluster in. ||
|| `--security-group-ids` | `strings`

List of security group IDs to apply to the cluster. ||
|| `--user-specs` | `shorthand/json`

Configuration of database users in the cluster.

Shorthand Syntax:

```hcl
[
  {
    authentication-plugin = MYSQL_NATIVE_PASSWORD|CACHING_SHA2_PASSWORD|SHA256_PASSWORD|MYSQL_NO_LOGIN|MDB_IAMPROXY_AUTH,
    connection-limits = {
      max-connections-per-hour = int,
      max-questions-per-hour = int,
      max-updates-per-hour = int,
      max-user-connections = int
    },
    generate-password = bool,
    global-permissions = [
      REPLICATION_CLIENT|REPLICATION_SLAVE|PROCESS|FLUSH_OPTIMIZER_COSTS|SHOW_ROUTINE|MDB_ADMIN, ...
    ],
    name = str,
    password = str,
    permissions = [
      {
        database-name = str,
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
      "max-connections-per-hour": "int",
      "max-questions-per-hour": "int",
      "max-updates-per-hour": "int",
      "max-user-connections": "int"
    },
    "generate-password": "bool",
    "global-permissions": [
      "REPLICATION_CLIENT|REPLICATION_SLAVE|PROCESS|FLUSH_OPTIMIZER_COSTS|SHOW_ROUTINE|MDB_ADMIN", ...
    ],
    "name": "str",
    "password": "str",
    "permissions": [
      {
        "database-name": "str",
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
  max-connections-per-hour -> (int)
    The maximum permitted number of simultaneous client connections per hour.
  max-questions-per-hour -> (int)
    The maximum permitted number of user questions per hour.
  max-updates-per-hour -> (int)
    The maximum permitted number of user updates per hour.
  max-user-connections -> (int)
    The maximum number of simultaneous connections permitted to any given MySQL user account.
generate-password -> (bool)
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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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