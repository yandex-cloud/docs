---
editable: false
noIndex: true
---

# yc beta managed-postgresql cluster restore

Creates a new PostgreSQL cluster using the specified backup.

#### Command Usage

Syntax:

`yc beta managed-postgresql cluster restore <BACKUP-ID>`

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
|| `--backup-id` | `string`

ID of the backup to create a cluster from. To get the backup ID, use a [ClusterService.ListBackups] request. ||
|| `--config-spec` | `shorthand/json`

Configuration for the PostgreSQL cluster to be created.

Shorthand Syntax:

```hcl
{
  access = {
    data-lens = bool,
    data-transfer = bool,
    serverless = bool,
    web-sql = bool,
    yandex-query = bool
  },
  autofailover = bool,
  backup-retain-period-days = int,
  backup-window-start = timeofday,
  disk-size-autoscaling = {
    disk-size-limit = int,
    emergency-usage-threshold = int,
    planned-usage-threshold = int
  },
  performance-diagnostics = {
    enabled = bool,
    sessions-sampling-interval = int,
    statements-sampling-interval = int
  },
  pooler-config = {
    pool-discard = bool,
    pooling-mode = SESSION|TRANSACTION|STATEMENT
  },
  postgresql-config = postgresql-config-10={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-bitmapscan = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    idle-in-transaction-session-timeout = int,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-temp-files = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-stack-depth = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    old-snapshot-threshold = int,
    operator-precedence-warning = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    quote-all-identifiers = bool,
    random-page-cost = double,
    replacement-sort-tuples = int,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    transform-null-equals = bool,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-10-1c={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-bitmapscan = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    idle-in-transaction-session-timeout = int,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-temp-files = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-stack-depth = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    old-snapshot-threshold = int,
    online-analyze-enable = bool,
    operator-precedence-warning = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    plantuner-fix-empty-table = bool,
    quote-all-identifiers = bool,
    random-page-cost = double,
    replacement-sort-tuples = int,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    transform-null-equals = bool,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-11={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-bitmapscan = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-parallel-append = bool,
    enable-parallel-hash = bool,
    enable-partition-pruning = bool,
    enable-partitionwise-aggregate = bool,
    enable-partitionwise-join = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    idle-in-transaction-session-timeout = int,
    jit = bool,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-temp-files = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-parallel-maintenance-workers = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-stack-depth = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    old-snapshot-threshold = int,
    operator-precedence-warning = bool,
    parallel-leader-participation = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    pg-trgm-similarity-threshold = double,
    pg-trgm-strict-word-similarity-threshold = double,
    pg-trgm-word-similarity-threshold = double,
    quote-all-identifiers = bool,
    random-page-cost = double,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    transform-null-equals = bool,
    vacuum-cleanup-index-scale-factor = double,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-11-1c={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-bitmapscan = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-parallel-append = bool,
    enable-parallel-hash = bool,
    enable-partition-pruning = bool,
    enable-partitionwise-aggregate = bool,
    enable-partitionwise-join = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    idle-in-transaction-session-timeout = int,
    jit = bool,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-temp-files = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-parallel-maintenance-workers = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-stack-depth = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    old-snapshot-threshold = int,
    online-analyze-enable = bool,
    operator-precedence-warning = bool,
    parallel-leader-participation = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    pg-trgm-similarity-threshold = double,
    pg-trgm-strict-word-similarity-threshold = double,
    pg-trgm-word-similarity-threshold = double,
    plantuner-fix-empty-table = bool,
    quote-all-identifiers = bool,
    random-page-cost = double,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    transform-null-equals = bool,
    vacuum-cleanup-index-scale-factor = double,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-12={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-bitmapscan = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-parallel-append = bool,
    enable-parallel-hash = bool,
    enable-partition-pruning = bool,
    enable-partitionwise-aggregate = bool,
    enable-partitionwise-join = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    idle-in-transaction-session-timeout = int,
    jit = bool,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-temp-files = int,
    log-transaction-sample-rate = double,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-parallel-maintenance-workers = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-stack-depth = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    old-snapshot-threshold = int,
    operator-precedence-warning = bool,
    parallel-leader-participation = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    pg-trgm-similarity-threshold = double,
    pg-trgm-strict-word-similarity-threshold = double,
    pg-trgm-word-similarity-threshold = double,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    quote-all-identifiers = bool,
    random-page-cost = double,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    transform-null-equals = bool,
    vacuum-cleanup-index-scale-factor = double,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-12-1c={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-bitmapscan = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-parallel-append = bool,
    enable-parallel-hash = bool,
    enable-partition-pruning = bool,
    enable-partitionwise-aggregate = bool,
    enable-partitionwise-join = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    idle-in-transaction-session-timeout = int,
    jit = bool,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-temp-files = int,
    log-transaction-sample-rate = double,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-parallel-maintenance-workers = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-stack-depth = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    old-snapshot-threshold = int,
    online-analyze-enable = bool,
    operator-precedence-warning = bool,
    parallel-leader-participation = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    pg-trgm-similarity-threshold = double,
    pg-trgm-strict-word-similarity-threshold = double,
    pg-trgm-word-similarity-threshold = double,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    plantuner-fix-empty-table = bool,
    quote-all-identifiers = bool,
    random-page-cost = double,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    transform-null-equals = bool,
    vacuum-cleanup-index-scale-factor = double,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-13={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-insert-scale-factor = double,
    autovacuum-vacuum-insert-threshold = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-bitmapscan = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-incremental-sort = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-parallel-append = bool,
    enable-parallel-hash = bool,
    enable-partition-pruning = bool,
    enable-partitionwise-aggregate = bool,
    enable-partitionwise-join = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    hash-mem-multiplier = double,
    idle-in-transaction-session-timeout = int,
    jit = bool,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-sample = int,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = int,
    log-parameter-max-length-on-error = int,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = double,
    log-temp-files = int,
    log-transaction-sample-rate = double,
    logical-decoding-work-mem = int,
    maintenance-io-concurrency = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-parallel-maintenance-workers = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-slot-wal-keep-size = int,
    max-stack-depth = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    old-snapshot-threshold = int,
    operator-precedence-warning = bool,
    parallel-leader-participation = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    pg-trgm-similarity-threshold = double,
    pg-trgm-strict-word-similarity-threshold = double,
    pg-trgm-word-similarity-threshold = double,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    quote-all-identifiers = bool,
    random-page-cost = double,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    transform-null-equals = bool,
    vacuum-cleanup-index-scale-factor = double,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    wal-keep-size = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-13-1c={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-insert-scale-factor = double,
    autovacuum-vacuum-insert-threshold = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-bitmapscan = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-incremental-sort = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-parallel-append = bool,
    enable-parallel-hash = bool,
    enable-partition-pruning = bool,
    enable-partitionwise-aggregate = bool,
    enable-partitionwise-join = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    hash-mem-multiplier = double,
    idle-in-transaction-session-timeout = int,
    jit = bool,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-sample = int,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = int,
    log-parameter-max-length-on-error = int,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = double,
    log-temp-files = int,
    log-transaction-sample-rate = double,
    logical-decoding-work-mem = int,
    maintenance-io-concurrency = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-parallel-maintenance-workers = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-slot-wal-keep-size = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    old-snapshot-threshold = int,
    online-analyze-enable = bool,
    operator-precedence-warning = bool,
    parallel-leader-participation = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    pg-trgm-similarity-threshold = double,
    pg-trgm-strict-word-similarity-threshold = double,
    pg-trgm-word-similarity-threshold = double,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    plantuner-fix-empty-table = bool,
    quote-all-identifiers = bool,
    random-page-cost = double,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    transform-null-equals = bool,
    vacuum-cleanup-index-scale-factor = double,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    wal-keep-size = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-14={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-insert-scale-factor = double,
    autovacuum-vacuum-insert-threshold = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-connection-check-interval = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-async-append = bool,
    enable-bitmapscan = bool,
    enable-gathermerge = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-incremental-sort = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-memoize = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-parallel-append = bool,
    enable-parallel-hash = bool,
    enable-partition-pruning = bool,
    enable-partitionwise-aggregate = bool,
    enable-partitionwise-join = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    hash-mem-multiplier = double,
    idle-in-transaction-session-timeout = int,
    jit = bool,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-sample = int,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = int,
    log-parameter-max-length-on-error = int,
    log-recovery-conflict-waits = bool,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = double,
    log-temp-files = int,
    log-transaction-sample-rate = double,
    logical-decoding-work-mem = int,
    maintenance-io-concurrency = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-parallel-maintenance-workers = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-slot-wal-keep-size = int,
    max-stack-depth = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    old-snapshot-threshold = int,
    parallel-leader-participation = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    pg-trgm-similarity-threshold = double,
    pg-trgm-strict-word-similarity-threshold = double,
    pg-trgm-word-similarity-threshold = double,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    quote-all-identifiers = bool,
    random-page-cost = double,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    transform-null-equals = bool,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    vacuum-failsafe-age = int,
    vacuum-multixact-failsafe-age = int,
    wal-keep-size = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-14-1c={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-insert-scale-factor = double,
    autovacuum-vacuum-insert-threshold = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-connection-check-interval = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-async-append = bool,
    enable-bitmapscan = bool,
    enable-gathermerge = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-incremental-sort = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-memoize = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-parallel-append = bool,
    enable-parallel-hash = bool,
    enable-partition-pruning = bool,
    enable-partitionwise-aggregate = bool,
    enable-partitionwise-join = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    hash-mem-multiplier = double,
    idle-in-transaction-session-timeout = int,
    jit = bool,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-sample = int,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = int,
    log-parameter-max-length-on-error = int,
    log-recovery-conflict-waits = bool,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = double,
    log-temp-files = int,
    log-transaction-sample-rate = double,
    logical-decoding-work-mem = int,
    maintenance-io-concurrency = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-parallel-maintenance-workers = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-slot-wal-keep-size = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    old-snapshot-threshold = int,
    online-analyze-enable = bool,
    parallel-leader-participation = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    pg-trgm-similarity-threshold = double,
    pg-trgm-strict-word-similarity-threshold = double,
    pg-trgm-word-similarity-threshold = double,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    plantuner-fix-empty-table = bool,
    quote-all-identifiers = bool,
    random-page-cost = double,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    transform-null-equals = bool,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    vacuum-failsafe-age = int,
    vacuum-multixact-failsafe-age = int,
    wal-keep-size = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-15={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-insert-scale-factor = double,
    autovacuum-vacuum-insert-threshold = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-connection-check-interval = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-async-append = bool,
    enable-bitmapscan = bool,
    enable-gathermerge = bool,
    enable-group-by-reordering = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-incremental-sort = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-memoize = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-parallel-append = bool,
    enable-parallel-hash = bool,
    enable-partition-pruning = bool,
    enable-partitionwise-aggregate = bool,
    enable-partitionwise-join = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    hash-mem-multiplier = double,
    idle-in-transaction-session-timeout = int,
    jit = bool,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-sample = int,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = int,
    log-parameter-max-length-on-error = int,
    log-recovery-conflict-waits = bool,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = double,
    log-temp-files = int,
    log-transaction-sample-rate = double,
    logical-decoding-work-mem = int,
    maintenance-io-concurrency = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-parallel-maintenance-workers = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-slot-wal-keep-size = int,
    max-stack-depth = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    old-snapshot-threshold = int,
    parallel-leader-participation = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    pg-trgm-similarity-threshold = double,
    pg-trgm-strict-word-similarity-threshold = double,
    pg-trgm-word-similarity-threshold = double,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    quote-all-identifiers = bool,
    random-page-cost = double,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    transform-null-equals = bool,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    vacuum-failsafe-age = int,
    vacuum-multixact-failsafe-age = int,
    wal-keep-size = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-15-1c={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-insert-scale-factor = double,
    autovacuum-vacuum-insert-threshold = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-connection-check-interval = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-async-append = bool,
    enable-bitmapscan = bool,
    enable-gathermerge = bool,
    enable-group-by-reordering = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-incremental-sort = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-memoize = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-parallel-append = bool,
    enable-parallel-hash = bool,
    enable-partition-pruning = bool,
    enable-partitionwise-aggregate = bool,
    enable-partitionwise-join = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    hash-mem-multiplier = double,
    idle-in-transaction-session-timeout = int,
    jit = bool,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-sample = int,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = int,
    log-parameter-max-length-on-error = int,
    log-recovery-conflict-waits = bool,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = double,
    log-temp-files = int,
    log-transaction-sample-rate = double,
    logical-decoding-work-mem = int,
    maintenance-io-concurrency = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-parallel-maintenance-workers = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-slot-wal-keep-size = int,
    max-stack-depth = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    old-snapshot-threshold = int,
    online-analyze-enable = bool,
    parallel-leader-participation = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    pg-trgm-similarity-threshold = double,
    pg-trgm-strict-word-similarity-threshold = double,
    pg-trgm-word-similarity-threshold = double,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    plantuner-fix-empty-table = bool,
    quote-all-identifiers = bool,
    random-page-cost = double,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    transform-null-equals = bool,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    vacuum-failsafe-age = int,
    vacuum-multixact-failsafe-age = int,
    wal-keep-size = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-16={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-insert-scale-factor = double,
    autovacuum-vacuum-insert-threshold = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-connection-check-interval = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-async-append = bool,
    enable-bitmapscan = bool,
    enable-gathermerge = bool,
    enable-group-by-reordering = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-incremental-sort = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-memoize = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-parallel-append = bool,
    enable-parallel-hash = bool,
    enable-partition-pruning = bool,
    enable-partitionwise-aggregate = bool,
    enable-partitionwise-join = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    hash-mem-multiplier = double,
    idle-in-transaction-session-timeout = int,
    jit = bool,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-sample = int,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = int,
    log-parameter-max-length-on-error = int,
    log-recovery-conflict-waits = bool,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = double,
    log-temp-files = int,
    log-transaction-sample-rate = double,
    logical-decoding-work-mem = int,
    maintenance-io-concurrency = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-parallel-maintenance-workers = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-slot-wal-keep-size = int,
    max-stack-depth = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    old-snapshot-threshold = int,
    parallel-leader-participation = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    pg-trgm-similarity-threshold = double,
    pg-trgm-strict-word-similarity-threshold = double,
    pg-trgm-word-similarity-threshold = double,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    quote-all-identifiers = bool,
    random-page-cost = double,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    transform-null-equals = bool,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    vacuum-failsafe-age = int,
    vacuum-multixact-failsafe-age = int,
    wal-keep-size = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-16-1c={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-insert-scale-factor = double,
    autovacuum-vacuum-insert-threshold = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-connection-check-interval = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-async-append = bool,
    enable-bitmapscan = bool,
    enable-gathermerge = bool,
    enable-group-by-reordering = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-incremental-sort = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-memoize = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-parallel-append = bool,
    enable-parallel-hash = bool,
    enable-partition-pruning = bool,
    enable-partitionwise-aggregate = bool,
    enable-partitionwise-join = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    hash-mem-multiplier = double,
    idle-in-transaction-session-timeout = int,
    jit = bool,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-sample = int,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = int,
    log-parameter-max-length-on-error = int,
    log-recovery-conflict-waits = bool,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = double,
    log-temp-files = int,
    log-transaction-sample-rate = double,
    logical-decoding-work-mem = int,
    maintenance-io-concurrency = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-parallel-maintenance-workers = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-slot-wal-keep-size = int,
    max-stack-depth = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    old-snapshot-threshold = int,
    online-analyze-enable = bool,
    parallel-leader-participation = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    pg-trgm-similarity-threshold = double,
    pg-trgm-strict-word-similarity-threshold = double,
    pg-trgm-word-similarity-threshold = double,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    plantuner-fix-empty-table = bool,
    quote-all-identifiers = bool,
    random-page-cost = double,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    transform-null-equals = bool,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    vacuum-failsafe-age = int,
    vacuum-multixact-failsafe-age = int,
    wal-keep-size = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-17={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-insert-scale-factor = double,
    autovacuum-vacuum-insert-threshold = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-connection-check-interval = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-async-append = bool,
    enable-bitmapscan = bool,
    enable-gathermerge = bool,
    enable-group-by-reordering = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-incremental-sort = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-memoize = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-parallel-append = bool,
    enable-parallel-hash = bool,
    enable-partition-pruning = bool,
    enable-partitionwise-aggregate = bool,
    enable-partitionwise-join = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    hash-mem-multiplier = double,
    idle-in-transaction-session-timeout = int,
    jit = bool,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-sample = int,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = int,
    log-parameter-max-length-on-error = int,
    log-recovery-conflict-waits = bool,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = double,
    log-temp-files = int,
    log-transaction-sample-rate = double,
    logical-decoding-work-mem = int,
    maintenance-io-concurrency = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-logical-replication-workers = int,
    max-parallel-maintenance-workers = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-replication-slots = int,
    max-slot-wal-keep-size = int,
    max-stack-depth = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-senders = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    parallel-leader-participation = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    pg-trgm-similarity-threshold = double,
    pg-trgm-strict-word-similarity-threshold = double,
    pg-trgm-word-similarity-threshold = double,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    quote-all-identifiers = bool,
    random-page-cost = double,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    track-commit-timestamp = bool,
    transform-null-equals = bool,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    vacuum-failsafe-age = int,
    vacuum-multixact-failsafe-age = int,
    wal-keep-size = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-17-1c={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-insert-scale-factor = double,
    autovacuum-vacuum-insert-threshold = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-connection-check-interval = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-async-append = bool,
    enable-bitmapscan = bool,
    enable-gathermerge = bool,
    enable-group-by-reordering = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-incremental-sort = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-memoize = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-parallel-append = bool,
    enable-parallel-hash = bool,
    enable-partition-pruning = bool,
    enable-partitionwise-aggregate = bool,
    enable-partitionwise-join = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    hash-mem-multiplier = double,
    idle-in-transaction-session-timeout = int,
    jit = bool,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-sample = int,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = int,
    log-parameter-max-length-on-error = int,
    log-recovery-conflict-waits = bool,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = double,
    log-temp-files = int,
    log-transaction-sample-rate = double,
    logical-decoding-work-mem = int,
    maintenance-io-concurrency = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-logical-replication-workers = int,
    max-parallel-maintenance-workers = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-replication-slots = int,
    max-slot-wal-keep-size = int,
    max-stack-depth = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-senders = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    online-analyze-enable = bool,
    parallel-leader-participation = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    pg-trgm-similarity-threshold = double,
    pg-trgm-strict-word-similarity-threshold = double,
    pg-trgm-word-similarity-threshold = double,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    plantuner-fix-empty-table = bool,
    quote-all-identifiers = bool,
    random-page-cost = double,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    track-commit-timestamp = bool,
    transform-null-equals = bool,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    vacuum-failsafe-age = int,
    vacuum-multixact-failsafe-age = int,
    wal-keep-size = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-18={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-insert-scale-factor = double,
    autovacuum-vacuum-insert-threshold = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-connection-check-interval = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-async-append = bool,
    enable-bitmapscan = bool,
    enable-gathermerge = bool,
    enable-group-by-reordering = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-incremental-sort = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-memoize = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-parallel-append = bool,
    enable-parallel-hash = bool,
    enable-partition-pruning = bool,
    enable-partitionwise-aggregate = bool,
    enable-partitionwise-join = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    hash-mem-multiplier = double,
    idle-in-transaction-session-timeout = int,
    jit = bool,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-sample = int,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = int,
    log-parameter-max-length-on-error = int,
    log-recovery-conflict-waits = bool,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = double,
    log-temp-files = int,
    log-transaction-sample-rate = double,
    logical-decoding-work-mem = int,
    maintenance-io-concurrency = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-logical-replication-workers = int,
    max-parallel-maintenance-workers = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-replication-slots = int,
    max-slot-wal-keep-size = int,
    max-stack-depth = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-senders = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    parallel-leader-participation = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    pg-trgm-similarity-threshold = double,
    pg-trgm-strict-word-similarity-threshold = double,
    pg-trgm-word-similarity-threshold = double,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    quote-all-identifiers = bool,
    random-page-cost = double,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    track-commit-timestamp = bool,
    transform-null-equals = bool,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    vacuum-failsafe-age = int,
    vacuum-multixact-failsafe-age = int,
    wal-keep-size = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-18-1c={
    archive-timeout = int,
    array-nulls = bool,
    auto-explain-log-analyze = bool,
    auto-explain-log-buffers = bool,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = int,
    auto-explain-log-nested-statements = bool,
    auto-explain-log-timing = bool,
    auto-explain-log-triggers = bool,
    auto-explain-log-verbose = bool,
    auto-explain-sample-rate = double,
    autovacuum-analyze-scale-factor = double,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-vacuum-insert-scale-factor = double,
    autovacuum-vacuum-insert-threshold = int,
    autovacuum-vacuum-scale-factor = double,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-connection-check-interval = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = bool,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    enable-async-append = bool,
    enable-bitmapscan = bool,
    enable-gathermerge = bool,
    enable-group-by-reordering = bool,
    enable-hashagg = bool,
    enable-hashjoin = bool,
    enable-incremental-sort = bool,
    enable-indexonlyscan = bool,
    enable-indexscan = bool,
    enable-material = bool,
    enable-memoize = bool,
    enable-mergejoin = bool,
    enable-nestloop = bool,
    enable-parallel-append = bool,
    enable-parallel-hash = bool,
    enable-partition-pruning = bool,
    enable-partitionwise-aggregate = bool,
    enable-partitionwise-join = bool,
    enable-seqscan = bool,
    enable-sort = bool,
    enable-tidscan = bool,
    escape-string-warning = bool,
    exit-on-error = bool,
    from-collapse-limit = int,
    geqo = bool,
    geqo-effort = int,
    geqo-generations = int,
    geqo-pool-size = int,
    geqo-seed = double,
    geqo-selection-bias = double,
    geqo-threshold = int,
    gin-pending-list-limit = int,
    hash-mem-multiplier = double,
    idle-in-transaction-session-timeout = int,
    jit = bool,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-autovacuum-min-duration = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-sample = int,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = int,
    log-parameter-max-length-on-error = int,
    log-recovery-conflict-waits = bool,
    log-replication-commands = bool,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = double,
    log-temp-files = int,
    log-transaction-sample-rate = double,
    logical-decoding-work-mem = int,
    maintenance-io-concurrency = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-logical-replication-workers = int,
    max-parallel-maintenance-workers = int,
    max-parallel-workers = int,
    max-parallel-workers-per-gather = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-replication-slots = int,
    max-slot-wal-keep-size = int,
    max-stack-depth = int,
    max-standby-archive-delay = int,
    max-standby-streaming-delay = int,
    max-wal-senders = int,
    max-wal-size = int,
    max-worker-processes = int,
    min-wal-size = int,
    online-analyze-enable = bool,
    parallel-leader-participation = bool,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = bool,
    pg-hint-plan-enable-hint-table = bool,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = bool,
    pg-qualstats-max = int,
    pg-qualstats-resolve-oids = bool,
    pg-qualstats-sample-rate = double,
    pg-qualstats-track-constants = bool,
    pg-trgm-similarity-threshold = double,
    pg-trgm-strict-word-similarity-threshold = double,
    pg-trgm-word-similarity-threshold = double,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    plantuner-fix-empty-table = bool,
    quote-all-identifiers = bool,
    random-page-cost = double,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    session-duration-timeout = int,
    shared-buffers = int,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON, ...
    ],
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    timezone = str,
    track-activity-query-size = int,
    track-commit-timestamp = bool,
    transform-null-equals = bool,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    vacuum-failsafe-age = int,
    vacuum-multixact-failsafe-age = int,
    wal-keep-size = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-9-6={
    archive-timeout = int,
    array-nulls = bool,
    autovacuum-max-workers = int,
    autovacuum-naptime = int,
    autovacuum-vacuum-cost-delay = int,
    autovacuum-vacuum-cost-limit = int,
    autovacuum-work-mem = int,
    backend-flush-after = int,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = int,
    bgwriter-flush-after = int,
    bgwriter-lru-maxpages = int,
    bgwriter-lru-multiplier = double,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = double,
    checkpoint-flush-after = int,
    checkpoint-timeout = int,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = double,
    deadlock-timeout = int,
    default-statistics-target = int,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-with-oids = bool,
    effective-cache-size = int,
    effective-io-concurrency = int,
    escape-string-warning = bool,
    exit-on-error = bool,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = int,
    gin-pending-list-limit = int,
    idle-in-transaction-session-timeout = int,
    join-collapse-limit = int,
    lo-compat-privileges = bool,
    lock-timeout = int,
    log-checkpoints = bool,
    log-connections = bool,
    log-disconnections = bool,
    log-duration = bool,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = bool,
    log-min-duration-statement = int,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-temp-files = int,
    maintenance-work-mem = int,
    max-connections = int,
    max-locks-per-transaction = int,
    max-pred-locks-per-transaction = int,
    max-prepared-transactions = int,
    max-standby-streaming-delay = int,
    max-wal-size = int,
    min-wal-size = int,
    old-snapshot-threshold = int,
    operator-precedence-warning = bool,
    quote-all-identifiers = bool,
    random-page-cost = double,
    replacement-sort-tuples = int,
    row-security = bool,
    search-path = str,
    seq-page-cost = double,
    shared-buffers = int,
    sql-inheritance = bool,
    standard-conforming-strings = bool,
    statement-timeout = int,
    synchronize-seqscans = bool,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = int,
    temp-file-limit = int,
    track-activity-query-size = int,
    transform-null-equals = bool,
    vacuum-cost-delay = int,
    vacuum-cost-limit = int,
    vacuum-cost-page-dirty = int,
    vacuum-cost-page-hit = int,
    vacuum-cost-page-miss = int,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = int,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
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
    "serverless": "bool",
    "web-sql": "bool",
    "yandex-query": "bool"
  },
  "autofailover": "bool",
  "backup-retain-period-days": "int",
  "backup-window-start": "timeofday",
  "disk-size-autoscaling": {
    "disk-size-limit": "int",
    "emergency-usage-threshold": "int",
    "planned-usage-threshold": "int"
  },
  "performance-diagnostics": {
    "enabled": "bool",
    "sessions-sampling-interval": "int",
    "statements-sampling-interval": "int"
  },
  "pooler-config": {
    "pool-discard": "bool",
    "pooling-mode": "SESSION|TRANSACTION|STATEMENT"
  },
  "postgresql-config": {
    "postgresql-config-10": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-bitmapscan": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "idle-in-transaction-session-timeout": "int",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-temp-files": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-stack-depth": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "old-snapshot-threshold": "int",
      "operator-precedence-warning": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "replacement-sort-tuples": "int",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "transform-null-equals": "bool",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-10-1c": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-bitmapscan": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "idle-in-transaction-session-timeout": "int",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-temp-files": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-stack-depth": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "old-snapshot-threshold": "int",
      "online-analyze-enable": "bool",
      "operator-precedence-warning": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "plantuner-fix-empty-table": "bool",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "replacement-sort-tuples": "int",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "transform-null-equals": "bool",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-11": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-bitmapscan": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-parallel-append": "bool",
      "enable-parallel-hash": "bool",
      "enable-partition-pruning": "bool",
      "enable-partitionwise-aggregate": "bool",
      "enable-partitionwise-join": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "idle-in-transaction-session-timeout": "int",
      "jit": "bool",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-temp-files": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-parallel-maintenance-workers": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-stack-depth": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "old-snapshot-threshold": "int",
      "operator-precedence-warning": "bool",
      "parallel-leader-participation": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "pg-trgm-similarity-threshold": "double",
      "pg-trgm-strict-word-similarity-threshold": "double",
      "pg-trgm-word-similarity-threshold": "double",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "transform-null-equals": "bool",
      "vacuum-cleanup-index-scale-factor": "double",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-11-1c": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-bitmapscan": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-parallel-append": "bool",
      "enable-parallel-hash": "bool",
      "enable-partition-pruning": "bool",
      "enable-partitionwise-aggregate": "bool",
      "enable-partitionwise-join": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "idle-in-transaction-session-timeout": "int",
      "jit": "bool",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-temp-files": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-parallel-maintenance-workers": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-stack-depth": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "old-snapshot-threshold": "int",
      "online-analyze-enable": "bool",
      "operator-precedence-warning": "bool",
      "parallel-leader-participation": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "pg-trgm-similarity-threshold": "double",
      "pg-trgm-strict-word-similarity-threshold": "double",
      "pg-trgm-word-similarity-threshold": "double",
      "plantuner-fix-empty-table": "bool",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "transform-null-equals": "bool",
      "vacuum-cleanup-index-scale-factor": "double",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-12": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-bitmapscan": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-parallel-append": "bool",
      "enable-parallel-hash": "bool",
      "enable-partition-pruning": "bool",
      "enable-partitionwise-aggregate": "bool",
      "enable-partitionwise-join": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "idle-in-transaction-session-timeout": "int",
      "jit": "bool",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-temp-files": "int",
      "log-transaction-sample-rate": "double",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-parallel-maintenance-workers": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-stack-depth": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "old-snapshot-threshold": "int",
      "operator-precedence-warning": "bool",
      "parallel-leader-participation": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "pg-trgm-similarity-threshold": "double",
      "pg-trgm-strict-word-similarity-threshold": "double",
      "pg-trgm-word-similarity-threshold": "double",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "transform-null-equals": "bool",
      "vacuum-cleanup-index-scale-factor": "double",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-12-1c": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-bitmapscan": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-parallel-append": "bool",
      "enable-parallel-hash": "bool",
      "enable-partition-pruning": "bool",
      "enable-partitionwise-aggregate": "bool",
      "enable-partitionwise-join": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "idle-in-transaction-session-timeout": "int",
      "jit": "bool",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-temp-files": "int",
      "log-transaction-sample-rate": "double",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-parallel-maintenance-workers": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-stack-depth": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "old-snapshot-threshold": "int",
      "online-analyze-enable": "bool",
      "operator-precedence-warning": "bool",
      "parallel-leader-participation": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "pg-trgm-similarity-threshold": "double",
      "pg-trgm-strict-word-similarity-threshold": "double",
      "pg-trgm-word-similarity-threshold": "double",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "plantuner-fix-empty-table": "bool",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "transform-null-equals": "bool",
      "vacuum-cleanup-index-scale-factor": "double",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-13": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-insert-scale-factor": "double",
      "autovacuum-vacuum-insert-threshold": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-bitmapscan": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-incremental-sort": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-parallel-append": "bool",
      "enable-parallel-hash": "bool",
      "enable-partition-pruning": "bool",
      "enable-partitionwise-aggregate": "bool",
      "enable-partitionwise-join": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "hash-mem-multiplier": "double",
      "idle-in-transaction-session-timeout": "int",
      "jit": "bool",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-sample": "int",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "int",
      "log-parameter-max-length-on-error": "int",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "double",
      "log-temp-files": "int",
      "log-transaction-sample-rate": "double",
      "logical-decoding-work-mem": "int",
      "maintenance-io-concurrency": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-parallel-maintenance-workers": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-slot-wal-keep-size": "int",
      "max-stack-depth": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "old-snapshot-threshold": "int",
      "operator-precedence-warning": "bool",
      "parallel-leader-participation": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "pg-trgm-similarity-threshold": "double",
      "pg-trgm-strict-word-similarity-threshold": "double",
      "pg-trgm-word-similarity-threshold": "double",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "transform-null-equals": "bool",
      "vacuum-cleanup-index-scale-factor": "double",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "wal-keep-size": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-13-1c": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-insert-scale-factor": "double",
      "autovacuum-vacuum-insert-threshold": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-bitmapscan": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-incremental-sort": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-parallel-append": "bool",
      "enable-parallel-hash": "bool",
      "enable-partition-pruning": "bool",
      "enable-partitionwise-aggregate": "bool",
      "enable-partitionwise-join": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "hash-mem-multiplier": "double",
      "idle-in-transaction-session-timeout": "int",
      "jit": "bool",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-sample": "int",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "int",
      "log-parameter-max-length-on-error": "int",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "double",
      "log-temp-files": "int",
      "log-transaction-sample-rate": "double",
      "logical-decoding-work-mem": "int",
      "maintenance-io-concurrency": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-parallel-maintenance-workers": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-slot-wal-keep-size": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "old-snapshot-threshold": "int",
      "online-analyze-enable": "bool",
      "operator-precedence-warning": "bool",
      "parallel-leader-participation": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "pg-trgm-similarity-threshold": "double",
      "pg-trgm-strict-word-similarity-threshold": "double",
      "pg-trgm-word-similarity-threshold": "double",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "plantuner-fix-empty-table": "bool",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "transform-null-equals": "bool",
      "vacuum-cleanup-index-scale-factor": "double",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "wal-keep-size": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-14": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-insert-scale-factor": "double",
      "autovacuum-vacuum-insert-threshold": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-connection-check-interval": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-async-append": "bool",
      "enable-bitmapscan": "bool",
      "enable-gathermerge": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-incremental-sort": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-memoize": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-parallel-append": "bool",
      "enable-parallel-hash": "bool",
      "enable-partition-pruning": "bool",
      "enable-partitionwise-aggregate": "bool",
      "enable-partitionwise-join": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "hash-mem-multiplier": "double",
      "idle-in-transaction-session-timeout": "int",
      "jit": "bool",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-sample": "int",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "int",
      "log-parameter-max-length-on-error": "int",
      "log-recovery-conflict-waits": "bool",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "double",
      "log-temp-files": "int",
      "log-transaction-sample-rate": "double",
      "logical-decoding-work-mem": "int",
      "maintenance-io-concurrency": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-parallel-maintenance-workers": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-slot-wal-keep-size": "int",
      "max-stack-depth": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "old-snapshot-threshold": "int",
      "parallel-leader-participation": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "pg-trgm-similarity-threshold": "double",
      "pg-trgm-strict-word-similarity-threshold": "double",
      "pg-trgm-word-similarity-threshold": "double",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "transform-null-equals": "bool",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "vacuum-failsafe-age": "int",
      "vacuum-multixact-failsafe-age": "int",
      "wal-keep-size": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-14-1c": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-insert-scale-factor": "double",
      "autovacuum-vacuum-insert-threshold": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-connection-check-interval": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-async-append": "bool",
      "enable-bitmapscan": "bool",
      "enable-gathermerge": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-incremental-sort": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-memoize": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-parallel-append": "bool",
      "enable-parallel-hash": "bool",
      "enable-partition-pruning": "bool",
      "enable-partitionwise-aggregate": "bool",
      "enable-partitionwise-join": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "hash-mem-multiplier": "double",
      "idle-in-transaction-session-timeout": "int",
      "jit": "bool",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-sample": "int",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "int",
      "log-parameter-max-length-on-error": "int",
      "log-recovery-conflict-waits": "bool",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "double",
      "log-temp-files": "int",
      "log-transaction-sample-rate": "double",
      "logical-decoding-work-mem": "int",
      "maintenance-io-concurrency": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-parallel-maintenance-workers": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-slot-wal-keep-size": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "old-snapshot-threshold": "int",
      "online-analyze-enable": "bool",
      "parallel-leader-participation": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "pg-trgm-similarity-threshold": "double",
      "pg-trgm-strict-word-similarity-threshold": "double",
      "pg-trgm-word-similarity-threshold": "double",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "plantuner-fix-empty-table": "bool",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "transform-null-equals": "bool",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "vacuum-failsafe-age": "int",
      "vacuum-multixact-failsafe-age": "int",
      "wal-keep-size": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-15": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-insert-scale-factor": "double",
      "autovacuum-vacuum-insert-threshold": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-connection-check-interval": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-async-append": "bool",
      "enable-bitmapscan": "bool",
      "enable-gathermerge": "bool",
      "enable-group-by-reordering": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-incremental-sort": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-memoize": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-parallel-append": "bool",
      "enable-parallel-hash": "bool",
      "enable-partition-pruning": "bool",
      "enable-partitionwise-aggregate": "bool",
      "enable-partitionwise-join": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "hash-mem-multiplier": "double",
      "idle-in-transaction-session-timeout": "int",
      "jit": "bool",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-sample": "int",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "int",
      "log-parameter-max-length-on-error": "int",
      "log-recovery-conflict-waits": "bool",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "double",
      "log-temp-files": "int",
      "log-transaction-sample-rate": "double",
      "logical-decoding-work-mem": "int",
      "maintenance-io-concurrency": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-parallel-maintenance-workers": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-slot-wal-keep-size": "int",
      "max-stack-depth": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "old-snapshot-threshold": "int",
      "parallel-leader-participation": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "pg-trgm-similarity-threshold": "double",
      "pg-trgm-strict-word-similarity-threshold": "double",
      "pg-trgm-word-similarity-threshold": "double",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "transform-null-equals": "bool",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "vacuum-failsafe-age": "int",
      "vacuum-multixact-failsafe-age": "int",
      "wal-keep-size": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-15-1c": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-insert-scale-factor": "double",
      "autovacuum-vacuum-insert-threshold": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-connection-check-interval": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-async-append": "bool",
      "enable-bitmapscan": "bool",
      "enable-gathermerge": "bool",
      "enable-group-by-reordering": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-incremental-sort": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-memoize": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-parallel-append": "bool",
      "enable-parallel-hash": "bool",
      "enable-partition-pruning": "bool",
      "enable-partitionwise-aggregate": "bool",
      "enable-partitionwise-join": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "hash-mem-multiplier": "double",
      "idle-in-transaction-session-timeout": "int",
      "jit": "bool",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-sample": "int",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "int",
      "log-parameter-max-length-on-error": "int",
      "log-recovery-conflict-waits": "bool",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "double",
      "log-temp-files": "int",
      "log-transaction-sample-rate": "double",
      "logical-decoding-work-mem": "int",
      "maintenance-io-concurrency": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-parallel-maintenance-workers": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-slot-wal-keep-size": "int",
      "max-stack-depth": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "old-snapshot-threshold": "int",
      "online-analyze-enable": "bool",
      "parallel-leader-participation": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "pg-trgm-similarity-threshold": "double",
      "pg-trgm-strict-word-similarity-threshold": "double",
      "pg-trgm-word-similarity-threshold": "double",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "plantuner-fix-empty-table": "bool",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "transform-null-equals": "bool",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "vacuum-failsafe-age": "int",
      "vacuum-multixact-failsafe-age": "int",
      "wal-keep-size": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-16": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-insert-scale-factor": "double",
      "autovacuum-vacuum-insert-threshold": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-connection-check-interval": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-async-append": "bool",
      "enable-bitmapscan": "bool",
      "enable-gathermerge": "bool",
      "enable-group-by-reordering": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-incremental-sort": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-memoize": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-parallel-append": "bool",
      "enable-parallel-hash": "bool",
      "enable-partition-pruning": "bool",
      "enable-partitionwise-aggregate": "bool",
      "enable-partitionwise-join": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "hash-mem-multiplier": "double",
      "idle-in-transaction-session-timeout": "int",
      "jit": "bool",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-sample": "int",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "int",
      "log-parameter-max-length-on-error": "int",
      "log-recovery-conflict-waits": "bool",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "double",
      "log-temp-files": "int",
      "log-transaction-sample-rate": "double",
      "logical-decoding-work-mem": "int",
      "maintenance-io-concurrency": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-parallel-maintenance-workers": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-slot-wal-keep-size": "int",
      "max-stack-depth": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "old-snapshot-threshold": "int",
      "parallel-leader-participation": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "pg-trgm-similarity-threshold": "double",
      "pg-trgm-strict-word-similarity-threshold": "double",
      "pg-trgm-word-similarity-threshold": "double",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "transform-null-equals": "bool",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "vacuum-failsafe-age": "int",
      "vacuum-multixact-failsafe-age": "int",
      "wal-keep-size": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-16-1c": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-insert-scale-factor": "double",
      "autovacuum-vacuum-insert-threshold": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-connection-check-interval": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-async-append": "bool",
      "enable-bitmapscan": "bool",
      "enable-gathermerge": "bool",
      "enable-group-by-reordering": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-incremental-sort": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-memoize": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-parallel-append": "bool",
      "enable-parallel-hash": "bool",
      "enable-partition-pruning": "bool",
      "enable-partitionwise-aggregate": "bool",
      "enable-partitionwise-join": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "hash-mem-multiplier": "double",
      "idle-in-transaction-session-timeout": "int",
      "jit": "bool",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-sample": "int",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "int",
      "log-parameter-max-length-on-error": "int",
      "log-recovery-conflict-waits": "bool",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "double",
      "log-temp-files": "int",
      "log-transaction-sample-rate": "double",
      "logical-decoding-work-mem": "int",
      "maintenance-io-concurrency": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-parallel-maintenance-workers": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-slot-wal-keep-size": "int",
      "max-stack-depth": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "old-snapshot-threshold": "int",
      "online-analyze-enable": "bool",
      "parallel-leader-participation": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "pg-trgm-similarity-threshold": "double",
      "pg-trgm-strict-word-similarity-threshold": "double",
      "pg-trgm-word-similarity-threshold": "double",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "plantuner-fix-empty-table": "bool",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "transform-null-equals": "bool",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "vacuum-failsafe-age": "int",
      "vacuum-multixact-failsafe-age": "int",
      "wal-keep-size": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-17": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-insert-scale-factor": "double",
      "autovacuum-vacuum-insert-threshold": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-connection-check-interval": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-async-append": "bool",
      "enable-bitmapscan": "bool",
      "enable-gathermerge": "bool",
      "enable-group-by-reordering": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-incremental-sort": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-memoize": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-parallel-append": "bool",
      "enable-parallel-hash": "bool",
      "enable-partition-pruning": "bool",
      "enable-partitionwise-aggregate": "bool",
      "enable-partitionwise-join": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "hash-mem-multiplier": "double",
      "idle-in-transaction-session-timeout": "int",
      "jit": "bool",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-sample": "int",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "int",
      "log-parameter-max-length-on-error": "int",
      "log-recovery-conflict-waits": "bool",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "double",
      "log-temp-files": "int",
      "log-transaction-sample-rate": "double",
      "logical-decoding-work-mem": "int",
      "maintenance-io-concurrency": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-logical-replication-workers": "int",
      "max-parallel-maintenance-workers": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-replication-slots": "int",
      "max-slot-wal-keep-size": "int",
      "max-stack-depth": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-senders": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "parallel-leader-participation": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "pg-trgm-similarity-threshold": "double",
      "pg-trgm-strict-word-similarity-threshold": "double",
      "pg-trgm-word-similarity-threshold": "double",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "track-commit-timestamp": "bool",
      "transform-null-equals": "bool",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "vacuum-failsafe-age": "int",
      "vacuum-multixact-failsafe-age": "int",
      "wal-keep-size": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-17-1c": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-insert-scale-factor": "double",
      "autovacuum-vacuum-insert-threshold": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-connection-check-interval": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-async-append": "bool",
      "enable-bitmapscan": "bool",
      "enable-gathermerge": "bool",
      "enable-group-by-reordering": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-incremental-sort": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-memoize": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-parallel-append": "bool",
      "enable-parallel-hash": "bool",
      "enable-partition-pruning": "bool",
      "enable-partitionwise-aggregate": "bool",
      "enable-partitionwise-join": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "hash-mem-multiplier": "double",
      "idle-in-transaction-session-timeout": "int",
      "jit": "bool",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-sample": "int",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "int",
      "log-parameter-max-length-on-error": "int",
      "log-recovery-conflict-waits": "bool",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "double",
      "log-temp-files": "int",
      "log-transaction-sample-rate": "double",
      "logical-decoding-work-mem": "int",
      "maintenance-io-concurrency": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-logical-replication-workers": "int",
      "max-parallel-maintenance-workers": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-replication-slots": "int",
      "max-slot-wal-keep-size": "int",
      "max-stack-depth": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-senders": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "online-analyze-enable": "bool",
      "parallel-leader-participation": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "pg-trgm-similarity-threshold": "double",
      "pg-trgm-strict-word-similarity-threshold": "double",
      "pg-trgm-word-similarity-threshold": "double",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "plantuner-fix-empty-table": "bool",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "track-commit-timestamp": "bool",
      "transform-null-equals": "bool",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "vacuum-failsafe-age": "int",
      "vacuum-multixact-failsafe-age": "int",
      "wal-keep-size": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-18": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-insert-scale-factor": "double",
      "autovacuum-vacuum-insert-threshold": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-connection-check-interval": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-async-append": "bool",
      "enable-bitmapscan": "bool",
      "enable-gathermerge": "bool",
      "enable-group-by-reordering": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-incremental-sort": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-memoize": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-parallel-append": "bool",
      "enable-parallel-hash": "bool",
      "enable-partition-pruning": "bool",
      "enable-partitionwise-aggregate": "bool",
      "enable-partitionwise-join": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "hash-mem-multiplier": "double",
      "idle-in-transaction-session-timeout": "int",
      "jit": "bool",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-sample": "int",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "int",
      "log-parameter-max-length-on-error": "int",
      "log-recovery-conflict-waits": "bool",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "double",
      "log-temp-files": "int",
      "log-transaction-sample-rate": "double",
      "logical-decoding-work-mem": "int",
      "maintenance-io-concurrency": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-logical-replication-workers": "int",
      "max-parallel-maintenance-workers": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-replication-slots": "int",
      "max-slot-wal-keep-size": "int",
      "max-stack-depth": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-senders": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "parallel-leader-participation": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "pg-trgm-similarity-threshold": "double",
      "pg-trgm-strict-word-similarity-threshold": "double",
      "pg-trgm-word-similarity-threshold": "double",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "track-commit-timestamp": "bool",
      "transform-null-equals": "bool",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "vacuum-failsafe-age": "int",
      "vacuum-multixact-failsafe-age": "int",
      "wal-keep-size": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-18-1c": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "auto-explain-log-analyze": "bool",
      "auto-explain-log-buffers": "bool",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "int",
      "auto-explain-log-nested-statements": "bool",
      "auto-explain-log-timing": "bool",
      "auto-explain-log-triggers": "bool",
      "auto-explain-log-verbose": "bool",
      "auto-explain-sample-rate": "double",
      "autovacuum-analyze-scale-factor": "double",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-vacuum-insert-scale-factor": "double",
      "autovacuum-vacuum-insert-threshold": "int",
      "autovacuum-vacuum-scale-factor": "double",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-connection-check-interval": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "bool",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "enable-async-append": "bool",
      "enable-bitmapscan": "bool",
      "enable-gathermerge": "bool",
      "enable-group-by-reordering": "bool",
      "enable-hashagg": "bool",
      "enable-hashjoin": "bool",
      "enable-incremental-sort": "bool",
      "enable-indexonlyscan": "bool",
      "enable-indexscan": "bool",
      "enable-material": "bool",
      "enable-memoize": "bool",
      "enable-mergejoin": "bool",
      "enable-nestloop": "bool",
      "enable-parallel-append": "bool",
      "enable-parallel-hash": "bool",
      "enable-partition-pruning": "bool",
      "enable-partitionwise-aggregate": "bool",
      "enable-partitionwise-join": "bool",
      "enable-seqscan": "bool",
      "enable-sort": "bool",
      "enable-tidscan": "bool",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "from-collapse-limit": "int",
      "geqo": "bool",
      "geqo-effort": "int",
      "geqo-generations": "int",
      "geqo-pool-size": "int",
      "geqo-seed": "double",
      "geqo-selection-bias": "double",
      "geqo-threshold": "int",
      "gin-pending-list-limit": "int",
      "hash-mem-multiplier": "double",
      "idle-in-transaction-session-timeout": "int",
      "jit": "bool",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-autovacuum-min-duration": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-sample": "int",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "int",
      "log-parameter-max-length-on-error": "int",
      "log-recovery-conflict-waits": "bool",
      "log-replication-commands": "bool",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "double",
      "log-temp-files": "int",
      "log-transaction-sample-rate": "double",
      "logical-decoding-work-mem": "int",
      "maintenance-io-concurrency": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-logical-replication-workers": "int",
      "max-parallel-maintenance-workers": "int",
      "max-parallel-workers": "int",
      "max-parallel-workers-per-gather": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-replication-slots": "int",
      "max-slot-wal-keep-size": "int",
      "max-stack-depth": "int",
      "max-standby-archive-delay": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-senders": "int",
      "max-wal-size": "int",
      "max-worker-processes": "int",
      "min-wal-size": "int",
      "online-analyze-enable": "bool",
      "parallel-leader-participation": "bool",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "bool",
      "pg-hint-plan-enable-hint-table": "bool",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "bool",
      "pg-qualstats-max": "int",
      "pg-qualstats-resolve-oids": "bool",
      "pg-qualstats-sample-rate": "double",
      "pg-qualstats-track-constants": "bool",
      "pg-trgm-similarity-threshold": "double",
      "pg-trgm-strict-word-similarity-threshold": "double",
      "pg-trgm-word-similarity-threshold": "double",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "plantuner-fix-empty-table": "bool",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "session-duration-timeout": "int",
      "shared-buffers": "int",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON", ...
      ],
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "timezone": "str",
      "track-activity-query-size": "int",
      "track-commit-timestamp": "bool",
      "transform-null-equals": "bool",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "vacuum-failsafe-age": "int",
      "vacuum-multixact-failsafe-age": "int",
      "wal-keep-size": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-9-6": {
      "archive-timeout": "int",
      "array-nulls": "bool",
      "autovacuum-max-workers": "int",
      "autovacuum-naptime": "int",
      "autovacuum-vacuum-cost-delay": "int",
      "autovacuum-vacuum-cost-limit": "int",
      "autovacuum-work-mem": "int",
      "backend-flush-after": "int",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "int",
      "bgwriter-flush-after": "int",
      "bgwriter-lru-maxpages": "int",
      "bgwriter-lru-multiplier": "double",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "double",
      "checkpoint-flush-after": "int",
      "checkpoint-timeout": "int",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "double",
      "deadlock-timeout": "int",
      "default-statistics-target": "int",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-with-oids": "bool",
      "effective-cache-size": "int",
      "effective-io-concurrency": "int",
      "escape-string-warning": "bool",
      "exit-on-error": "bool",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "int",
      "gin-pending-list-limit": "int",
      "idle-in-transaction-session-timeout": "int",
      "join-collapse-limit": "int",
      "lo-compat-privileges": "bool",
      "lock-timeout": "int",
      "log-checkpoints": "bool",
      "log-connections": "bool",
      "log-disconnections": "bool",
      "log-duration": "bool",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "bool",
      "log-min-duration-statement": "int",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-temp-files": "int",
      "maintenance-work-mem": "int",
      "max-connections": "int",
      "max-locks-per-transaction": "int",
      "max-pred-locks-per-transaction": "int",
      "max-prepared-transactions": "int",
      "max-standby-streaming-delay": "int",
      "max-wal-size": "int",
      "min-wal-size": "int",
      "old-snapshot-threshold": "int",
      "operator-precedence-warning": "bool",
      "quote-all-identifiers": "bool",
      "random-page-cost": "double",
      "replacement-sort-tuples": "int",
      "row-security": "bool",
      "search-path": "str",
      "seq-page-cost": "double",
      "shared-buffers": "int",
      "sql-inheritance": "bool",
      "standard-conforming-strings": "bool",
      "statement-timeout": "int",
      "synchronize-seqscans": "bool",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "int",
      "temp-file-limit": "int",
      "track-activity-query-size": "int",
      "transform-null-equals": "bool",
      "vacuum-cost-delay": "int",
      "vacuum-cost-limit": "int",
      "vacuum-cost-page-dirty": "int",
      "vacuum-cost-page-hit": "int",
      "vacuum-cost-page-miss": "int",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "int",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    }
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
  Access policy to DB
  data-lens -> (bool)
    Allow access for DataLens
  data-transfer -> (bool)
    Allow access for DataTransfer.
  serverless -> (bool)
    Allow access for Serverless
  web-sql -> (bool)
    Allow SQL queries to the cluster databases from the management console. See documentation for more details.
  yandex-query -> (bool)
    Allow access for YandexQuery.
autofailover -> (bool)
  Configuration setting which enables/disables autofailover in cluster.
backup-retain-period-days -> (int)
  Retention policy of automated backups.
backup-window-start -> (timeofday)
  Time to start the daily backup, in the UTC timezone.
disk-size-autoscaling -> (struct)
  Disk size autoscaling
  disk-size-limit -> (int)
    New storage size (in bytes) that is set when one of the thresholds is achieved.
  emergency-usage-threshold -> (int)
    Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold.
  planned-usage-threshold -> (int)
    Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold.
performance-diagnostics -> (struct)
  Configuration of the performance diagnostics service.
  enabled -> (bool)
    Configuration setting which enables/disables performance diagnostics service in cluster.
  sessions-sampling-interval -> (int)
    Interval (in seconds) for pg_stat_activity sampling
  statements-sampling-interval -> (int)
    Interval (in seconds) for pg_stat_statements sampling
pooler-config -> (struct)
  Configuration of the connection pooler.
  pool-discard -> (bool)
    Setting 'server_reset_query_always' parameter in PgBouncer.
  pooling-mode -> (struct)
    Mode that the connection pooler is working in. See descriptions of all modes in the documentation for PgBouncer.
resources -> (struct)
  Resources allocated to PostgreSQL hosts.
  disk-size -> (int)
    Volume of the storage available to a host, in bytes.
  disk-type-id -> (string)
    Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
  resource-preset-id -> (string)
    ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
version -> (string)
  Version of PostgreSQL used in the cluster. Possible values: '9.6', '10', '10_1c', '11', '12', '13', '14', '15', '16', '17', '18'
postgresql-config -> (oneof<postgresql-config-10|postgresql-config-10-1c|postgresql-config-11|postgresql-config-11-1c|postgresql-config-12|postgresql-config-12-1c|postgresql-config-13|postgresql-config-13-1c|postgresql-config-14|postgresql-config-14-1c|postgresql-config-15|postgresql-config-15-1c|postgresql-config-16|postgresql-config-16-1c|postgresql-config-17|postgresql-config-17-1c|postgresql-config-18|postgresql-config-18-1c|postgresql-config-9-6>)
  Oneof postgresql-config field
  postgresql-config-9-6 -> (struct)
    Configuration for a PostgreSQL 9.6 cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (int)
    gin-pending-list-limit -> (int)
    idle-in-transaction-session-timeout -> (int)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-statement -> (struct)
    log-temp-files -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-size -> (int)
    min-wal-size -> (int)
    old-snapshot-threshold -> (int)
    operator-precedence-warning -> (bool)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    replacement-sort-tuples -> (int)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    shared-buffers -> (int)
    sql-inheritance -> (bool)
      This option has been removed in PostgreSQL 10.
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    track-activity-query-size -> (int)
    transform-null-equals -> (bool)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-10-1c -> (struct)
    Configuration for a PostgreSQL 10 1C cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-bitmapscan -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    idle-in-transaction-session-timeout -> (int)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-temp-files -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-stack-depth -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    old-snapshot-threshold -> (int)
    online-analyze-enable -> (bool)
    operator-precedence-warning -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    plantuner-fix-empty-table -> (bool)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    replacement-sort-tuples -> (int)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    transform-null-equals -> (bool)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-10 -> (struct)
    Configuration for a PostgreSQL 10 cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-bitmapscan -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    idle-in-transaction-session-timeout -> (int)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-temp-files -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-stack-depth -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    old-snapshot-threshold -> (int)
    operator-precedence-warning -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    replacement-sort-tuples -> (int)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    transform-null-equals -> (bool)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-11 -> (struct)
    Configuration for a PostgreSQL 11 cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-bitmapscan -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-parallel-append -> (bool)
    enable-parallel-hash -> (bool)
    enable-partition-pruning -> (bool)
    enable-partitionwise-aggregate -> (bool)
    enable-partitionwise-join -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    idle-in-transaction-session-timeout -> (int)
    jit -> (bool)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-temp-files -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-parallel-maintenance-workers -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-stack-depth -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    old-snapshot-threshold -> (int)
    operator-precedence-warning -> (bool)
    parallel-leader-participation -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    pg-trgm-similarity-threshold -> (double)
    pg-trgm-strict-word-similarity-threshold -> (double)
    pg-trgm-word-similarity-threshold -> (double)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    transform-null-equals -> (bool)
    vacuum-cleanup-index-scale-factor -> (double)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-11-1c -> (struct)
    Configuration for a PostgreSQL 11 1C cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-bitmapscan -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-parallel-append -> (bool)
    enable-parallel-hash -> (bool)
    enable-partition-pruning -> (bool)
    enable-partitionwise-aggregate -> (bool)
    enable-partitionwise-join -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    idle-in-transaction-session-timeout -> (int)
    jit -> (bool)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-temp-files -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-parallel-maintenance-workers -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-stack-depth -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    old-snapshot-threshold -> (int)
    online-analyze-enable -> (bool)
    operator-precedence-warning -> (bool)
    parallel-leader-participation -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    pg-trgm-similarity-threshold -> (double)
    pg-trgm-strict-word-similarity-threshold -> (double)
    pg-trgm-word-similarity-threshold -> (double)
    plantuner-fix-empty-table -> (bool)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    transform-null-equals -> (bool)
    vacuum-cleanup-index-scale-factor -> (double)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-12 -> (struct)
    Configuration for a PostgreSQL 12 cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-bitmapscan -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-parallel-append -> (bool)
    enable-parallel-hash -> (bool)
    enable-partition-pruning -> (bool)
    enable-partitionwise-aggregate -> (bool)
    enable-partitionwise-join -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    idle-in-transaction-session-timeout -> (int)
    jit -> (bool)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-temp-files -> (int)
    log-transaction-sample-rate -> (double)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-parallel-maintenance-workers -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-stack-depth -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    old-snapshot-threshold -> (int)
    operator-precedence-warning -> (bool)
    parallel-leader-participation -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    pg-trgm-similarity-threshold -> (double)
    pg-trgm-strict-word-similarity-threshold -> (double)
    pg-trgm-word-similarity-threshold -> (double)
    plan-cache-mode -> (struct)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    transform-null-equals -> (bool)
    vacuum-cleanup-index-scale-factor -> (double)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-12-1c -> (struct)
    Configuration for a PostgreSQL 12 1C cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-bitmapscan -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-parallel-append -> (bool)
    enable-parallel-hash -> (bool)
    enable-partition-pruning -> (bool)
    enable-partitionwise-aggregate -> (bool)
    enable-partitionwise-join -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    idle-in-transaction-session-timeout -> (int)
    jit -> (bool)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-temp-files -> (int)
    log-transaction-sample-rate -> (double)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-parallel-maintenance-workers -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-stack-depth -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    old-snapshot-threshold -> (int)
    online-analyze-enable -> (bool)
    operator-precedence-warning -> (bool)
    parallel-leader-participation -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    pg-trgm-similarity-threshold -> (double)
    pg-trgm-strict-word-similarity-threshold -> (double)
    pg-trgm-word-similarity-threshold -> (double)
    plan-cache-mode -> (struct)
    plantuner-fix-empty-table -> (bool)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    transform-null-equals -> (bool)
    vacuum-cleanup-index-scale-factor -> (double)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-13 -> (struct)
    Configuration for a PostgreSQL 13 cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-insert-scale-factor -> (double)
    autovacuum-vacuum-insert-threshold -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-bitmapscan -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-incremental-sort -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-parallel-append -> (bool)
    enable-parallel-hash -> (bool)
    enable-partition-pruning -> (bool)
    enable-partitionwise-aggregate -> (bool)
    enable-partitionwise-join -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    hash-mem-multiplier -> (double)
    idle-in-transaction-session-timeout -> (int)
    jit -> (bool)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-sample -> (int)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (int)
    log-parameter-max-length-on-error -> (int)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-statement-sample-rate -> (double)
    log-temp-files -> (int)
    log-transaction-sample-rate -> (double)
    logical-decoding-work-mem -> (int)
    maintenance-io-concurrency -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-parallel-maintenance-workers -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-slot-wal-keep-size -> (int)
    max-stack-depth -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    old-snapshot-threshold -> (int)
    operator-precedence-warning -> (bool)
    parallel-leader-participation -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    pg-trgm-similarity-threshold -> (double)
    pg-trgm-strict-word-similarity-threshold -> (double)
    pg-trgm-word-similarity-threshold -> (double)
    plan-cache-mode -> (struct)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    transform-null-equals -> (bool)
    vacuum-cleanup-index-scale-factor -> (double)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    wal-keep-size -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-13-1c -> (struct)
    Configuration for a PostgreSQL 13 1C cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-insert-scale-factor -> (double)
    autovacuum-vacuum-insert-threshold -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-bitmapscan -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-incremental-sort -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-parallel-append -> (bool)
    enable-parallel-hash -> (bool)
    enable-partition-pruning -> (bool)
    enable-partitionwise-aggregate -> (bool)
    enable-partitionwise-join -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    hash-mem-multiplier -> (double)
    idle-in-transaction-session-timeout -> (int)
    jit -> (bool)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-sample -> (int)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (int)
    log-parameter-max-length-on-error -> (int)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-statement-sample-rate -> (double)
    log-temp-files -> (int)
    log-transaction-sample-rate -> (double)
    logical-decoding-work-mem -> (int)
    maintenance-io-concurrency -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-parallel-maintenance-workers -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-slot-wal-keep-size -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    old-snapshot-threshold -> (int)
    online-analyze-enable -> (bool)
    operator-precedence-warning -> (bool)
    parallel-leader-participation -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    pg-trgm-similarity-threshold -> (double)
    pg-trgm-strict-word-similarity-threshold -> (double)
    pg-trgm-word-similarity-threshold -> (double)
    plan-cache-mode -> (struct)
    plantuner-fix-empty-table -> (bool)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    transform-null-equals -> (bool)
    vacuum-cleanup-index-scale-factor -> (double)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    wal-keep-size -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-14 -> (struct)
    Configuration for a PostgreSQL 14 cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-insert-scale-factor -> (double)
    autovacuum-vacuum-insert-threshold -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-connection-check-interval -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-async-append -> (bool)
    enable-bitmapscan -> (bool)
    enable-gathermerge -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-incremental-sort -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-memoize -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-parallel-append -> (bool)
    enable-parallel-hash -> (bool)
    enable-partition-pruning -> (bool)
    enable-partitionwise-aggregate -> (bool)
    enable-partitionwise-join -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    hash-mem-multiplier -> (double)
    idle-in-transaction-session-timeout -> (int)
    jit -> (bool)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-sample -> (int)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (int)
    log-parameter-max-length-on-error -> (int)
    log-recovery-conflict-waits -> (bool)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-statement-sample-rate -> (double)
    log-temp-files -> (int)
    log-transaction-sample-rate -> (double)
    logical-decoding-work-mem -> (int)
    maintenance-io-concurrency -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-parallel-maintenance-workers -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-slot-wal-keep-size -> (int)
    max-stack-depth -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    old-snapshot-threshold -> (int)
    parallel-leader-participation -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    pg-trgm-similarity-threshold -> (double)
    pg-trgm-strict-word-similarity-threshold -> (double)
    pg-trgm-word-similarity-threshold -> (double)
    plan-cache-mode -> (struct)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    transform-null-equals -> (bool)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    vacuum-failsafe-age -> (int)
    vacuum-multixact-failsafe-age -> (int)
    wal-keep-size -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-14-1c -> (struct)
    Configuration for a PostgreSQL 14 1C cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-insert-scale-factor -> (double)
    autovacuum-vacuum-insert-threshold -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-connection-check-interval -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-async-append -> (bool)
    enable-bitmapscan -> (bool)
    enable-gathermerge -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-incremental-sort -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-memoize -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-parallel-append -> (bool)
    enable-parallel-hash -> (bool)
    enable-partition-pruning -> (bool)
    enable-partitionwise-aggregate -> (bool)
    enable-partitionwise-join -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    hash-mem-multiplier -> (double)
    idle-in-transaction-session-timeout -> (int)
    jit -> (bool)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-sample -> (int)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (int)
    log-parameter-max-length-on-error -> (int)
    log-recovery-conflict-waits -> (bool)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-statement-sample-rate -> (double)
    log-temp-files -> (int)
    log-transaction-sample-rate -> (double)
    logical-decoding-work-mem -> (int)
    maintenance-io-concurrency -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-parallel-maintenance-workers -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-slot-wal-keep-size -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    old-snapshot-threshold -> (int)
    online-analyze-enable -> (bool)
    parallel-leader-participation -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    pg-trgm-similarity-threshold -> (double)
    pg-trgm-strict-word-similarity-threshold -> (double)
    pg-trgm-word-similarity-threshold -> (double)
    plan-cache-mode -> (struct)
    plantuner-fix-empty-table -> (bool)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    transform-null-equals -> (bool)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    vacuum-failsafe-age -> (int)
    vacuum-multixact-failsafe-age -> (int)
    wal-keep-size -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-15 -> (struct)
    Configuration for a PostgreSQL 15 cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-insert-scale-factor -> (double)
    autovacuum-vacuum-insert-threshold -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-connection-check-interval -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-async-append -> (bool)
    enable-bitmapscan -> (bool)
    enable-gathermerge -> (bool)
    enable-group-by-reordering -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-incremental-sort -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-memoize -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-parallel-append -> (bool)
    enable-parallel-hash -> (bool)
    enable-partition-pruning -> (bool)
    enable-partitionwise-aggregate -> (bool)
    enable-partitionwise-join -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    hash-mem-multiplier -> (double)
    idle-in-transaction-session-timeout -> (int)
    jit -> (bool)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-sample -> (int)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (int)
    log-parameter-max-length-on-error -> (int)
    log-recovery-conflict-waits -> (bool)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-statement-sample-rate -> (double)
    log-temp-files -> (int)
    log-transaction-sample-rate -> (double)
    logical-decoding-work-mem -> (int)
    maintenance-io-concurrency -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-parallel-maintenance-workers -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-slot-wal-keep-size -> (int)
    max-stack-depth -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    old-snapshot-threshold -> (int)
    parallel-leader-participation -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    pg-trgm-similarity-threshold -> (double)
    pg-trgm-strict-word-similarity-threshold -> (double)
    pg-trgm-word-similarity-threshold -> (double)
    plan-cache-mode -> (struct)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    transform-null-equals -> (bool)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    vacuum-failsafe-age -> (int)
    vacuum-multixact-failsafe-age -> (int)
    wal-keep-size -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-15-1c -> (struct)
    Configuration for a PostgreSQL 15 1C cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-insert-scale-factor -> (double)
    autovacuum-vacuum-insert-threshold -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-connection-check-interval -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-async-append -> (bool)
    enable-bitmapscan -> (bool)
    enable-gathermerge -> (bool)
    enable-group-by-reordering -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-incremental-sort -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-memoize -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-parallel-append -> (bool)
    enable-parallel-hash -> (bool)
    enable-partition-pruning -> (bool)
    enable-partitionwise-aggregate -> (bool)
    enable-partitionwise-join -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    hash-mem-multiplier -> (double)
    idle-in-transaction-session-timeout -> (int)
    jit -> (bool)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-sample -> (int)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (int)
    log-parameter-max-length-on-error -> (int)
    log-recovery-conflict-waits -> (bool)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-statement-sample-rate -> (double)
    log-temp-files -> (int)
    log-transaction-sample-rate -> (double)
    logical-decoding-work-mem -> (int)
    maintenance-io-concurrency -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-parallel-maintenance-workers -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-slot-wal-keep-size -> (int)
    max-stack-depth -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    old-snapshot-threshold -> (int)
    online-analyze-enable -> (bool)
    parallel-leader-participation -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    pg-trgm-similarity-threshold -> (double)
    pg-trgm-strict-word-similarity-threshold -> (double)
    pg-trgm-word-similarity-threshold -> (double)
    plan-cache-mode -> (struct)
    plantuner-fix-empty-table -> (bool)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    transform-null-equals -> (bool)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    vacuum-failsafe-age -> (int)
    vacuum-multixact-failsafe-age -> (int)
    wal-keep-size -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-16 -> (struct)
    Configuration for a PostgreSQL 16 cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-insert-scale-factor -> (double)
    autovacuum-vacuum-insert-threshold -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-connection-check-interval -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    debug-parallel-query -> (struct)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-async-append -> (bool)
    enable-bitmapscan -> (bool)
    enable-gathermerge -> (bool)
    enable-group-by-reordering -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-incremental-sort -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-memoize -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-parallel-append -> (bool)
    enable-parallel-hash -> (bool)
    enable-partition-pruning -> (bool)
    enable-partitionwise-aggregate -> (bool)
    enable-partitionwise-join -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    hash-mem-multiplier -> (double)
    idle-in-transaction-session-timeout -> (int)
    jit -> (bool)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-sample -> (int)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (int)
    log-parameter-max-length-on-error -> (int)
    log-recovery-conflict-waits -> (bool)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-statement-sample-rate -> (double)
    log-temp-files -> (int)
    log-transaction-sample-rate -> (double)
    logical-decoding-work-mem -> (int)
    maintenance-io-concurrency -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-parallel-maintenance-workers -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-slot-wal-keep-size -> (int)
    max-stack-depth -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    old-snapshot-threshold -> (int)
    parallel-leader-participation -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    pg-trgm-similarity-threshold -> (double)
    pg-trgm-strict-word-similarity-threshold -> (double)
    pg-trgm-word-similarity-threshold -> (double)
    plan-cache-mode -> (struct)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    transform-null-equals -> (bool)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    vacuum-failsafe-age -> (int)
    vacuum-multixact-failsafe-age -> (int)
    wal-keep-size -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-16-1c -> (struct)
    Configuration for a PostgreSQL 16 1C cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-insert-scale-factor -> (double)
    autovacuum-vacuum-insert-threshold -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-connection-check-interval -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    debug-parallel-query -> (struct)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-async-append -> (bool)
    enable-bitmapscan -> (bool)
    enable-gathermerge -> (bool)
    enable-group-by-reordering -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-incremental-sort -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-memoize -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-parallel-append -> (bool)
    enable-parallel-hash -> (bool)
    enable-partition-pruning -> (bool)
    enable-partitionwise-aggregate -> (bool)
    enable-partitionwise-join -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    hash-mem-multiplier -> (double)
    idle-in-transaction-session-timeout -> (int)
    jit -> (bool)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-sample -> (int)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (int)
    log-parameter-max-length-on-error -> (int)
    log-recovery-conflict-waits -> (bool)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-statement-sample-rate -> (double)
    log-temp-files -> (int)
    log-transaction-sample-rate -> (double)
    logical-decoding-work-mem -> (int)
    maintenance-io-concurrency -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-parallel-maintenance-workers -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-slot-wal-keep-size -> (int)
    max-stack-depth -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    old-snapshot-threshold -> (int)
    online-analyze-enable -> (bool)
    parallel-leader-participation -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    pg-trgm-similarity-threshold -> (double)
    pg-trgm-strict-word-similarity-threshold -> (double)
    pg-trgm-word-similarity-threshold -> (double)
    plan-cache-mode -> (struct)
    plantuner-fix-empty-table -> (bool)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    transform-null-equals -> (bool)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    vacuum-failsafe-age -> (int)
    vacuum-multixact-failsafe-age -> (int)
    wal-keep-size -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-17 -> (struct)
    Configuration for a PostgreSQL 17 cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-insert-scale-factor -> (double)
    autovacuum-vacuum-insert-threshold -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-connection-check-interval -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    debug-parallel-query -> (struct)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-async-append -> (bool)
    enable-bitmapscan -> (bool)
    enable-gathermerge -> (bool)
    enable-group-by-reordering -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-incremental-sort -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-memoize -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-parallel-append -> (bool)
    enable-parallel-hash -> (bool)
    enable-partition-pruning -> (bool)
    enable-partitionwise-aggregate -> (bool)
    enable-partitionwise-join -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    hash-mem-multiplier -> (double)
    idle-in-transaction-session-timeout -> (int)
    jit -> (bool)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-sample -> (int)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (int)
    log-parameter-max-length-on-error -> (int)
    log-recovery-conflict-waits -> (bool)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-statement-sample-rate -> (double)
    log-temp-files -> (int)
    log-transaction-sample-rate -> (double)
    logical-decoding-work-mem -> (int)
    maintenance-io-concurrency -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-logical-replication-workers -> (int)
    max-parallel-maintenance-workers -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-replication-slots -> (int)
    max-slot-wal-keep-size -> (int)
    max-stack-depth -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-senders -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    parallel-leader-participation -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    pg-trgm-similarity-threshold -> (double)
    pg-trgm-strict-word-similarity-threshold -> (double)
    pg-trgm-word-similarity-threshold -> (double)
    plan-cache-mode -> (struct)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    track-commit-timestamp -> (bool)
    transform-null-equals -> (bool)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    vacuum-failsafe-age -> (int)
    vacuum-multixact-failsafe-age -> (int)
    wal-keep-size -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-17-1c -> (struct)
    Configuration for a PostgreSQL 17 1C cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-insert-scale-factor -> (double)
    autovacuum-vacuum-insert-threshold -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-connection-check-interval -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    debug-parallel-query -> (struct)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-async-append -> (bool)
    enable-bitmapscan -> (bool)
    enable-gathermerge -> (bool)
    enable-group-by-reordering -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-incremental-sort -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-memoize -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-parallel-append -> (bool)
    enable-parallel-hash -> (bool)
    enable-partition-pruning -> (bool)
    enable-partitionwise-aggregate -> (bool)
    enable-partitionwise-join -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    hash-mem-multiplier -> (double)
    idle-in-transaction-session-timeout -> (int)
    jit -> (bool)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-sample -> (int)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (int)
    log-parameter-max-length-on-error -> (int)
    log-recovery-conflict-waits -> (bool)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-statement-sample-rate -> (double)
    log-temp-files -> (int)
    log-transaction-sample-rate -> (double)
    logical-decoding-work-mem -> (int)
    maintenance-io-concurrency -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-logical-replication-workers -> (int)
    max-parallel-maintenance-workers -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-replication-slots -> (int)
    max-slot-wal-keep-size -> (int)
    max-stack-depth -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-senders -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    online-analyze-enable -> (bool)
    parallel-leader-participation -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    pg-trgm-similarity-threshold -> (double)
    pg-trgm-strict-word-similarity-threshold -> (double)
    pg-trgm-word-similarity-threshold -> (double)
    plan-cache-mode -> (struct)
    plantuner-fix-empty-table -> (bool)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    track-commit-timestamp -> (bool)
    transform-null-equals -> (bool)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    vacuum-failsafe-age -> (int)
    vacuum-multixact-failsafe-age -> (int)
    wal-keep-size -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-18 -> (struct)
    Configuration for a PostgreSQL 18 cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-insert-scale-factor -> (double)
    autovacuum-vacuum-insert-threshold -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-connection-check-interval -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    debug-parallel-query -> (struct)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-async-append -> (bool)
    enable-bitmapscan -> (bool)
    enable-gathermerge -> (bool)
    enable-group-by-reordering -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-incremental-sort -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-memoize -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-parallel-append -> (bool)
    enable-parallel-hash -> (bool)
    enable-partition-pruning -> (bool)
    enable-partitionwise-aggregate -> (bool)
    enable-partitionwise-join -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    hash-mem-multiplier -> (double)
    idle-in-transaction-session-timeout -> (int)
    jit -> (bool)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-sample -> (int)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (int)
    log-parameter-max-length-on-error -> (int)
    log-recovery-conflict-waits -> (bool)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-statement-sample-rate -> (double)
    log-temp-files -> (int)
    log-transaction-sample-rate -> (double)
    logical-decoding-work-mem -> (int)
    maintenance-io-concurrency -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-logical-replication-workers -> (int)
    max-parallel-maintenance-workers -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-replication-slots -> (int)
    max-slot-wal-keep-size -> (int)
    max-stack-depth -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-senders -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    parallel-leader-participation -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    pg-trgm-similarity-threshold -> (double)
    pg-trgm-strict-word-similarity-threshold -> (double)
    pg-trgm-word-similarity-threshold -> (double)
    plan-cache-mode -> (struct)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    track-commit-timestamp -> (bool)
    transform-null-equals -> (bool)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    vacuum-failsafe-age -> (int)
    vacuum-multixact-failsafe-age -> (int)
    wal-keep-size -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-18-1c -> (struct)
    Configuration for a PostgreSQL 18 1C cluster.
    archive-timeout -> (int)
    array-nulls -> (bool)
    auto-explain-log-analyze -> (bool)
    auto-explain-log-buffers -> (bool)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (int)
    auto-explain-log-nested-statements -> (bool)
    auto-explain-log-timing -> (bool)
    auto-explain-log-triggers -> (bool)
    auto-explain-log-verbose -> (bool)
    auto-explain-sample-rate -> (double)
    autovacuum-analyze-scale-factor -> (double)
    autovacuum-max-workers -> (int)
    autovacuum-naptime -> (int)
    autovacuum-vacuum-cost-delay -> (int)
    autovacuum-vacuum-cost-limit -> (int)
    autovacuum-vacuum-insert-scale-factor -> (double)
    autovacuum-vacuum-insert-threshold -> (int)
    autovacuum-vacuum-scale-factor -> (double)
    autovacuum-work-mem -> (int)
    backend-flush-after -> (int)
    backslash-quote -> (struct)
    bgwriter-delay -> (int)
    bgwriter-flush-after -> (int)
    bgwriter-lru-maxpages -> (int)
    bgwriter-lru-multiplier -> (double)
    bytea-output -> (struct)
    checkpoint-completion-target -> (double)
    checkpoint-flush-after -> (int)
    checkpoint-timeout -> (int)
    client-connection-check-interval -> (int)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (double)
    deadlock-timeout -> (int)
    debug-parallel-query -> (struct)
    default-statistics-target -> (int)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (bool)
    default-with-oids -> (bool)
    effective-cache-size -> (int)
    effective-io-concurrency -> (int)
    enable-async-append -> (bool)
    enable-bitmapscan -> (bool)
    enable-gathermerge -> (bool)
    enable-group-by-reordering -> (bool)
    enable-hashagg -> (bool)
    enable-hashjoin -> (bool)
    enable-incremental-sort -> (bool)
    enable-indexonlyscan -> (bool)
    enable-indexscan -> (bool)
    enable-material -> (bool)
    enable-memoize -> (bool)
    enable-mergejoin -> (bool)
    enable-nestloop -> (bool)
    enable-parallel-append -> (bool)
    enable-parallel-hash -> (bool)
    enable-partition-pruning -> (bool)
    enable-partitionwise-aggregate -> (bool)
    enable-partitionwise-join -> (bool)
    enable-seqscan -> (bool)
    enable-sort -> (bool)
    enable-tidscan -> (bool)
    escape-string-warning -> (bool)
    exit-on-error -> (bool)
    from-collapse-limit -> (int)
    geqo -> (bool)
    geqo-effort -> (int)
    geqo-generations -> (int)
    geqo-pool-size -> (int)
    geqo-seed -> (double)
    geqo-selection-bias -> (double)
    geqo-threshold -> (int)
    gin-pending-list-limit -> (int)
    hash-mem-multiplier -> (double)
    idle-in-transaction-session-timeout -> (int)
    jit -> (bool)
    join-collapse-limit -> (int)
    lo-compat-privileges -> (bool)
    lock-timeout -> (int)
    log-autovacuum-min-duration -> (int)
    log-checkpoints -> (bool)
    log-connections -> (bool)
    log-disconnections -> (bool)
    log-duration -> (bool)
    log-error-verbosity -> (struct)
    log-lock-waits -> (bool)
    log-min-duration-sample -> (int)
    log-min-duration-statement -> (int)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (int)
    log-parameter-max-length-on-error -> (int)
    log-recovery-conflict-waits -> (bool)
    log-replication-commands -> (bool)
    log-statement -> (struct)
    log-statement-sample-rate -> (double)
    log-temp-files -> (int)
    log-transaction-sample-rate -> (double)
    logical-decoding-work-mem -> (int)
    maintenance-io-concurrency -> (int)
    maintenance-work-mem -> (int)
    max-connections -> (int)
    max-locks-per-transaction -> (int)
    max-logical-replication-workers -> (int)
    max-parallel-maintenance-workers -> (int)
    max-parallel-workers -> (int)
    max-parallel-workers-per-gather -> (int)
    max-pred-locks-per-transaction -> (int)
    max-prepared-transactions -> (int)
    max-replication-slots -> (int)
    max-slot-wal-keep-size -> (int)
    max-stack-depth -> (int)
    max-standby-archive-delay -> (int)
    max-standby-streaming-delay -> (int)
    max-wal-senders -> (int)
    max-wal-size -> (int)
    max-worker-processes -> (int)
    min-wal-size -> (int)
    online-analyze-enable -> (bool)
    parallel-leader-participation -> (bool)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (bool)
    pg-hint-plan-enable-hint-table -> (bool)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (bool)
    pg-qualstats-max -> (int)
    pg-qualstats-resolve-oids -> (bool)
    pg-qualstats-sample-rate -> (double)
    pg-qualstats-track-constants -> (bool)
    pg-trgm-similarity-threshold -> (double)
    pg-trgm-strict-word-similarity-threshold -> (double)
    pg-trgm-word-similarity-threshold -> (double)
    plan-cache-mode -> (struct)
    plantuner-fix-empty-table -> (bool)
    quote-all-identifiers -> (bool)
    random-page-cost -> (double)
    row-security -> (bool)
    search-path -> (string)
    seq-page-cost -> (double)
    session-duration-timeout -> (int)
    shared-buffers -> (int)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (bool)
    statement-timeout -> (int)
    synchronize-seqscans -> (bool)
    synchronous-commit -> (struct)
    temp-buffers -> (int)
    temp-file-limit -> (int)
    timezone -> (string)
    track-activity-query-size -> (int)
    track-commit-timestamp -> (bool)
    transform-null-equals -> (bool)
    vacuum-cost-delay -> (int)
    vacuum-cost-limit -> (int)
    vacuum-cost-page-dirty -> (int)
    vacuum-cost-page-hit -> (int)
    vacuum-cost-page-miss -> (int)
    vacuum-failsafe-age -> (int)
    vacuum-multixact-failsafe-age -> (int)
    wal-keep-size -> (int)
    wal-level -> (struct)
    work-mem -> (int)
    xmlbinary -> (struct)
    xmloption -> (struct)
``` ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster ||
|| `--description` | `string`

Description of the new PostgreSQL cluster. ||
|| `--disk-encryption-key-id` | `string`

ID of the key to encrypt cluster disks. ||
|| `--environment` | `enum`

Deployment environment of the new PostgreSQL cluster. Possible Values: 'production', 'prestable' ||
|| `--folder-id` | `string`

ID of the folder to create the PostgreSQL cluster in. ||
|| `--host-group-ids` | `strings`

Host groups hosting VMs of the cluster. ||
|| `--host-specs` | `shorthand/json`

Configurations for PostgreSQL hosts that should be created for the cluster that is being created from the backup.

Shorthand Syntax:

```hcl
[
  {
    assign-public-ip = bool,
    config-spec = {
      postgresql-config = postgresql-config-10={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        old-snapshot-threshold = int,
        operator-precedence-warning = bool,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        replacement-sort-tuples = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-10-1c={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        old-snapshot-threshold = int,
        operator-precedence-warning = bool,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        replacement-sort-tuples = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-11={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        old-snapshot-threshold = int,
        operator-precedence-warning = bool,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-11-1c={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        old-snapshot-threshold = int,
        operator-precedence-warning = bool,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-12={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        old-snapshot-threshold = int,
        operator-precedence-warning = bool,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-12-1c={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        old-snapshot-threshold = int,
        operator-precedence-warning = bool,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-13={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        old-snapshot-threshold = int,
        operator-precedence-warning = bool,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-13-1c={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        old-snapshot-threshold = int,
        operator-precedence-warning = bool,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-14={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        old-snapshot-threshold = int,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-14-1c={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        old-snapshot-threshold = int,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-15={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        old-snapshot-threshold = int,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-15-1c={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        old-snapshot-threshold = int,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-16={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        old-snapshot-threshold = int,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-16-1c={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        old-snapshot-threshold = int,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-17={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-17-1c={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-18={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-18-1c={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        enable-bitmapscan = bool,
        enable-hashagg = bool,
        enable-hashjoin = bool,
        enable-indexonlyscan = bool,
        enable-indexscan = bool,
        enable-material = bool,
        enable-mergejoin = bool,
        enable-nestloop = bool,
        enable-seqscan = bool,
        enable-sort = bool,
        enable-tidscan = bool,
        escape-string-warning = bool,
        exit-on-error = bool,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-parallel-workers = int,
        max-parallel-workers-per-gather = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        timezone = str,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-9-6={
        array-nulls = bool,
        backend-flush-after = int,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = double,
        deadlock-timeout = int,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
        default-with-oids = bool,
        effective-cache-size = int,
        effective-io-concurrency = int,
        escape-string-warning = bool,
        exit-on-error = bool,
        force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
        from-collapse-limit = int,
        gin-pending-list-limit = int,
        idle-in-transaction-session-timeout = int,
        join-collapse-limit = int,
        lo-compat-privileges = bool,
        lock-timeout = int,
        log-checkpoints = bool,
        log-connections = bool,
        log-disconnections = bool,
        log-duration = bool,
        log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
        log-lock-waits = bool,
        log-min-duration-statement = int,
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = int,
        max-locks-per-transaction = int,
        max-pred-locks-per-transaction = int,
        max-standby-streaming-delay = int,
        old-snapshot-threshold = int,
        operator-precedence-warning = bool,
        quote-all-identifiers = bool,
        random-page-cost = double,
        recovery-min-apply-delay = int,
        replacement-sort-tuples = int,
        row-security = bool,
        search-path = str,
        seq-page-cost = double,
        shared-buffers = int,
        sql-inheritance = bool,
        standard-conforming-strings = bool,
        statement-timeout = int,
        synchronize-seqscans = bool,
        temp-buffers = int,
        temp-file-limit = int,
        transform-null-equals = bool,
        work-mem = int,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      }
    },
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
    "config-spec": {
      "postgresql-config": {
        "postgresql-config-10": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "old-snapshot-threshold": "int",
          "operator-precedence-warning": "bool",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "replacement-sort-tuples": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-10-1c": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "old-snapshot-threshold": "int",
          "operator-precedence-warning": "bool",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "replacement-sort-tuples": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-11": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "old-snapshot-threshold": "int",
          "operator-precedence-warning": "bool",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-11-1c": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "old-snapshot-threshold": "int",
          "operator-precedence-warning": "bool",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-12": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "old-snapshot-threshold": "int",
          "operator-precedence-warning": "bool",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-12-1c": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "old-snapshot-threshold": "int",
          "operator-precedence-warning": "bool",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-13": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "old-snapshot-threshold": "int",
          "operator-precedence-warning": "bool",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-13-1c": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "old-snapshot-threshold": "int",
          "operator-precedence-warning": "bool",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-14": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "old-snapshot-threshold": "int",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-14-1c": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "old-snapshot-threshold": "int",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-15": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "old-snapshot-threshold": "int",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-15-1c": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "old-snapshot-threshold": "int",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-16": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "old-snapshot-threshold": "int",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-16-1c": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "old-snapshot-threshold": "int",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-17": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-17-1c": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-18": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-18-1c": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "enable-bitmapscan": "bool",
          "enable-hashagg": "bool",
          "enable-hashjoin": "bool",
          "enable-indexonlyscan": "bool",
          "enable-indexscan": "bool",
          "enable-material": "bool",
          "enable-mergejoin": "bool",
          "enable-nestloop": "bool",
          "enable-seqscan": "bool",
          "enable-sort": "bool",
          "enable-tidscan": "bool",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-parallel-workers": "int",
          "max-parallel-workers-per-gather": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "timezone": "str",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-9-6": {
          "array-nulls": "bool",
          "backend-flush-after": "int",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "double",
          "deadlock-timeout": "int",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
          "default-with-oids": "bool",
          "effective-cache-size": "int",
          "effective-io-concurrency": "int",
          "escape-string-warning": "bool",
          "exit-on-error": "bool",
          "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
          "from-collapse-limit": "int",
          "gin-pending-list-limit": "int",
          "idle-in-transaction-session-timeout": "int",
          "join-collapse-limit": "int",
          "lo-compat-privileges": "bool",
          "lock-timeout": "int",
          "log-checkpoints": "bool",
          "log-connections": "bool",
          "log-disconnections": "bool",
          "log-duration": "bool",
          "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
          "log-lock-waits": "bool",
          "log-min-duration-statement": "int",
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "int",
          "max-locks-per-transaction": "int",
          "max-pred-locks-per-transaction": "int",
          "max-standby-streaming-delay": "int",
          "old-snapshot-threshold": "int",
          "operator-precedence-warning": "bool",
          "quote-all-identifiers": "bool",
          "random-page-cost": "double",
          "recovery-min-apply-delay": "int",
          "replacement-sort-tuples": "int",
          "row-security": "bool",
          "search-path": "str",
          "seq-page-cost": "double",
          "shared-buffers": "int",
          "sql-inheritance": "bool",
          "standard-conforming-strings": "bool",
          "statement-timeout": "int",
          "synchronize-seqscans": "bool",
          "temp-buffers": "int",
          "temp-file-limit": "int",
          "transform-null-equals": "bool",
          "work-mem": "int",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        }
      }
    },
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
  Whether the host should get a public IP address on creation. After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with [assign_public_ip] set as needed. Possible values: * false - don't assign a public IP to the host. * true - the host should have a public IP address.
config-spec -> (struct)
  Configuration of a PostgreSQL server for the host.
  postgresql-config -> (oneof<postgresql-config-10|postgresql-config-10-1c|postgresql-config-11|postgresql-config-11-1c|postgresql-config-12|postgresql-config-12-1c|postgresql-config-13|postgresql-config-13-1c|postgresql-config-14|postgresql-config-14-1c|postgresql-config-15|postgresql-config-15-1c|postgresql-config-16|postgresql-config-16-1c|postgresql-config-17|postgresql-config-17-1c|postgresql-config-18|postgresql-config-18-1c|postgresql-config-9-6>)
    Oneof postgresql-config field
    postgresql-config-9-6 -> (struct)
      Configuration for a host with PostgreSQL 9.6 server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      force-parallel-mode -> (struct)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      old-snapshot-threshold -> (int)
      operator-precedence-warning -> (bool)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      replacement-sort-tuples -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      sql-inheritance -> (bool)
        This option has been removed in PostgreSQL 10.
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-10-1c -> (struct)
      Configuration for a host with PostgreSQL 10 1C server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      force-parallel-mode -> (struct)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      old-snapshot-threshold -> (int)
      operator-precedence-warning -> (bool)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      replacement-sort-tuples -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-10 -> (struct)
      Configuration for a host with PostgreSQL 10 server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      force-parallel-mode -> (struct)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      old-snapshot-threshold -> (int)
      operator-precedence-warning -> (bool)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      replacement-sort-tuples -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-11 -> (struct)
      Configuration for a host with PostgreSQL 11 server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      force-parallel-mode -> (struct)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      old-snapshot-threshold -> (int)
      operator-precedence-warning -> (bool)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-11-1c -> (struct)
      Configuration for a host with PostgreSQL 11 1C server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      force-parallel-mode -> (struct)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      old-snapshot-threshold -> (int)
      operator-precedence-warning -> (bool)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-12 -> (struct)
      Configuration for a host with PostgreSQL 12 server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      force-parallel-mode -> (struct)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      old-snapshot-threshold -> (int)
      operator-precedence-warning -> (bool)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-12-1c -> (struct)
      Configuration for a host with PostgreSQL 12 1C server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      force-parallel-mode -> (struct)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      old-snapshot-threshold -> (int)
      operator-precedence-warning -> (bool)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-13 -> (struct)
      Configuration for a host with PostgreSQL 13 server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      force-parallel-mode -> (struct)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      old-snapshot-threshold -> (int)
      operator-precedence-warning -> (bool)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-13-1c -> (struct)
      Configuration for a host with PostgreSQL 13 1C server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      force-parallel-mode -> (struct)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      old-snapshot-threshold -> (int)
      operator-precedence-warning -> (bool)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-14 -> (struct)
      Configuration for a host with PostgreSQL 14 server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      force-parallel-mode -> (struct)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      old-snapshot-threshold -> (int)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-14-1c -> (struct)
      Configuration for a host with PostgreSQL 14 1C server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      force-parallel-mode -> (struct)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      old-snapshot-threshold -> (int)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-15 -> (struct)
      Configuration for a host with PostgreSQL 15 server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      force-parallel-mode -> (struct)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      old-snapshot-threshold -> (int)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-15-1c -> (struct)
      Configuration for a host with PostgreSQL 15 1C server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      force-parallel-mode -> (struct)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      old-snapshot-threshold -> (int)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-16 -> (struct)
      Configuration for a host with PostgreSQL 16 server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      debug-parallel-query -> (struct)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      old-snapshot-threshold -> (int)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-16-1c -> (struct)
      Configuration for a host with PostgreSQL 16 1C server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      debug-parallel-query -> (struct)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      old-snapshot-threshold -> (int)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-17 -> (struct)
      Configuration for a host with PostgreSQL 17 1C server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      debug-parallel-query -> (struct)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-17-1c -> (struct)
      Configuration for a host with PostgreSQL 17 1C server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      debug-parallel-query -> (struct)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-18 -> (struct)
      Configuration for a host with PostgreSQL 18 1C server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      debug-parallel-query -> (struct)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-18-1c -> (struct)
      Configuration for a host with PostgreSQL 18 1C server deployed.
      array-nulls -> (bool)
      backend-flush-after -> (int)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (double)
      deadlock-timeout -> (int)
      debug-parallel-query -> (struct)
      default-transaction-isolation -> (struct)
      default-with-oids -> (bool)
      effective-cache-size -> (int)
      effective-io-concurrency -> (int)
      enable-bitmapscan -> (bool)
      enable-hashagg -> (bool)
      enable-hashjoin -> (bool)
      enable-indexonlyscan -> (bool)
      enable-indexscan -> (bool)
      enable-material -> (bool)
      enable-mergejoin -> (bool)
      enable-nestloop -> (bool)
      enable-seqscan -> (bool)
      enable-sort -> (bool)
      enable-tidscan -> (bool)
      escape-string-warning -> (bool)
      exit-on-error -> (bool)
      from-collapse-limit -> (int)
      gin-pending-list-limit -> (int)
      idle-in-transaction-session-timeout -> (int)
      join-collapse-limit -> (int)
      lo-compat-privileges -> (bool)
      lock-timeout -> (int)
      log-checkpoints -> (bool)
      log-connections -> (bool)
      log-disconnections -> (bool)
      log-duration -> (bool)
      log-error-verbosity -> (struct)
      log-lock-waits -> (bool)
      log-min-duration-statement -> (int)
      log-min-error-statement -> (struct)
      log-min-messages -> (struct)
      log-statement -> (struct)
      log-temp-files -> (int)
      max-locks-per-transaction -> (int)
      max-parallel-workers -> (int)
      max-parallel-workers-per-gather -> (int)
      max-pred-locks-per-transaction -> (int)
      max-standby-streaming-delay -> (int)
      quote-all-identifiers -> (bool)
      random-page-cost -> (double)
      recovery-min-apply-delay -> (int)
      row-security -> (bool)
      search-path -> (string)
      seq-page-cost -> (double)
      shared-buffers -> (int)
      standard-conforming-strings -> (bool)
      statement-timeout -> (int)
      synchronize-seqscans -> (bool)
      temp-buffers -> (int)
      temp-file-limit -> (int)
      timezone -> (string)
      transform-null-equals -> (bool)
      work-mem -> (int)
      xmlbinary -> (struct)
      xmloption -> (struct)
priority -> (int)
  Priority of the host as a replica. A higher value corresponds to higher priority. The host with the highest priority is the synchronous replica. All others are asynchronous. The synchronous replica replaces the master when needed. When a replica becomes the master, its priority is ignored.
replication-source -> (string)
  [Host.name] of the host to be used as the replication source (for cascading replication).
subnet-id -> (string)
  ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id].
zone-id -> (string)
  ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request.
``` ||
|| `--labels` | `stringToString`

Custom labels for the PostgreSQL cluster as '' key:value '' pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". ||
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

Name of the new PostgreSQL cluster. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the network to create the PostgreSQL cluster in. ||
|| `--security-group-ids` | `strings`

User security groups ||
|| `--time` | `time`

Timestamp of the moment to which the PostgreSQL cluster should be restored. (RFC3339) ||
|| `--time-inclusive` | Flag that indicates whether a database should be restored to the first backup point available just after the timestamp specified in the [time] field instead of just before. Possible values: * false (default) - the restore point refers to the first backup moment before [time]. * true - the restore point refers to the first backup point after [time]. ||
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