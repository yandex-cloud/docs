---
editable: false
noIndex: true
---

# yc beta managed-postgresql cluster update

Updates the specified PostgreSQL cluster.

#### Command Usage

Syntax:

`yc beta managed-postgresql cluster update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the PostgreSQL Cluster resource to update. To get the PostgreSQL cluster ID, use a [ClusterService.List] request. ||
|| `--config-spec` | `shorthand/json`

New configuration and resources for hosts in the cluster.

Shorthand Syntax:

```hcl
{
  access = {
    data-lens = boolean,
    data-transfer = boolean,
    serverless = boolean,
    web-sql = boolean,
    yandex-query = boolean
  },
  autofailover = boolean,
  backup-retain-period-days = integer,
  backup-window-start = timeofday,
  disk-size-autoscaling = {
    disk-size-limit = integer,
    emergency-usage-threshold = integer,
    planned-usage-threshold = integer
  },
  performance-diagnostics = {
    enabled = boolean,
    sessions-sampling-interval = integer,
    statements-sampling-interval = integer
  },
  pooler-config = {
    pool-discard = boolean,
    pooling-mode = SESSION|TRANSACTION|STATEMENT
  },
  postgresql-config = postgresql-config-10={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-bitmapscan = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    idle-in-transaction-session-timeout = integer,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-temp-files = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-stack-depth = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    old-snapshot-threshold = integer,
    operator-precedence-warning = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    replacement-sort-tuples = integer,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    transform-null-equals = boolean,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-10-1c={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-bitmapscan = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    idle-in-transaction-session-timeout = integer,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-temp-files = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-stack-depth = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    old-snapshot-threshold = integer,
    online-analyze-enable = boolean,
    operator-precedence-warning = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    plantuner-fix-empty-table = boolean,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    replacement-sort-tuples = integer,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    transform-null-equals = boolean,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-11={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-bitmapscan = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-parallel-append = boolean,
    enable-parallel-hash = boolean,
    enable-partition-pruning = boolean,
    enable-partitionwise-aggregate = boolean,
    enable-partitionwise-join = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    idle-in-transaction-session-timeout = integer,
    jit = boolean,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-temp-files = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-parallel-maintenance-workers = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-stack-depth = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    old-snapshot-threshold = integer,
    operator-precedence-warning = boolean,
    parallel-leader-participation = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    pg-trgm-similarity-threshold = float64,
    pg-trgm-strict-word-similarity-threshold = float64,
    pg-trgm-word-similarity-threshold = float64,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    transform-null-equals = boolean,
    vacuum-cleanup-index-scale-factor = float64,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-11-1c={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-bitmapscan = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-parallel-append = boolean,
    enable-parallel-hash = boolean,
    enable-partition-pruning = boolean,
    enable-partitionwise-aggregate = boolean,
    enable-partitionwise-join = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    idle-in-transaction-session-timeout = integer,
    jit = boolean,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-temp-files = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-parallel-maintenance-workers = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-stack-depth = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    old-snapshot-threshold = integer,
    online-analyze-enable = boolean,
    operator-precedence-warning = boolean,
    parallel-leader-participation = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    pg-trgm-similarity-threshold = float64,
    pg-trgm-strict-word-similarity-threshold = float64,
    pg-trgm-word-similarity-threshold = float64,
    plantuner-fix-empty-table = boolean,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    transform-null-equals = boolean,
    vacuum-cleanup-index-scale-factor = float64,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-12={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-bitmapscan = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-parallel-append = boolean,
    enable-parallel-hash = boolean,
    enable-partition-pruning = boolean,
    enable-partitionwise-aggregate = boolean,
    enable-partitionwise-join = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    idle-in-transaction-session-timeout = integer,
    jit = boolean,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-temp-files = integer,
    log-transaction-sample-rate = float64,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-parallel-maintenance-workers = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-stack-depth = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    old-snapshot-threshold = integer,
    operator-precedence-warning = boolean,
    parallel-leader-participation = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    pg-trgm-similarity-threshold = float64,
    pg-trgm-strict-word-similarity-threshold = float64,
    pg-trgm-word-similarity-threshold = float64,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    transform-null-equals = boolean,
    vacuum-cleanup-index-scale-factor = float64,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-12-1c={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-bitmapscan = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-parallel-append = boolean,
    enable-parallel-hash = boolean,
    enable-partition-pruning = boolean,
    enable-partitionwise-aggregate = boolean,
    enable-partitionwise-join = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    idle-in-transaction-session-timeout = integer,
    jit = boolean,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-temp-files = integer,
    log-transaction-sample-rate = float64,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-parallel-maintenance-workers = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-stack-depth = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    old-snapshot-threshold = integer,
    online-analyze-enable = boolean,
    operator-precedence-warning = boolean,
    parallel-leader-participation = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    pg-trgm-similarity-threshold = float64,
    pg-trgm-strict-word-similarity-threshold = float64,
    pg-trgm-word-similarity-threshold = float64,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    plantuner-fix-empty-table = boolean,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    transform-null-equals = boolean,
    vacuum-cleanup-index-scale-factor = float64,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-13={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-insert-scale-factor = float64,
    autovacuum-vacuum-insert-threshold = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-bitmapscan = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-incremental-sort = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-parallel-append = boolean,
    enable-parallel-hash = boolean,
    enable-partition-pruning = boolean,
    enable-partitionwise-aggregate = boolean,
    enable-partitionwise-join = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    hash-mem-multiplier = float64,
    idle-in-transaction-session-timeout = integer,
    jit = boolean,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-sample = integer,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = integer,
    log-parameter-max-length-on-error = integer,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = float64,
    log-temp-files = integer,
    log-transaction-sample-rate = float64,
    logical-decoding-work-mem = integer,
    maintenance-io-concurrency = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-parallel-maintenance-workers = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-slot-wal-keep-size = integer,
    max-stack-depth = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    old-snapshot-threshold = integer,
    operator-precedence-warning = boolean,
    parallel-leader-participation = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    pg-trgm-similarity-threshold = float64,
    pg-trgm-strict-word-similarity-threshold = float64,
    pg-trgm-word-similarity-threshold = float64,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    transform-null-equals = boolean,
    vacuum-cleanup-index-scale-factor = float64,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    wal-keep-size = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-13-1c={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-insert-scale-factor = float64,
    autovacuum-vacuum-insert-threshold = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-bitmapscan = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-incremental-sort = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-parallel-append = boolean,
    enable-parallel-hash = boolean,
    enable-partition-pruning = boolean,
    enable-partitionwise-aggregate = boolean,
    enable-partitionwise-join = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    hash-mem-multiplier = float64,
    idle-in-transaction-session-timeout = integer,
    jit = boolean,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-sample = integer,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = integer,
    log-parameter-max-length-on-error = integer,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = float64,
    log-temp-files = integer,
    log-transaction-sample-rate = float64,
    logical-decoding-work-mem = integer,
    maintenance-io-concurrency = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-parallel-maintenance-workers = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-slot-wal-keep-size = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    old-snapshot-threshold = integer,
    online-analyze-enable = boolean,
    operator-precedence-warning = boolean,
    parallel-leader-participation = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    pg-trgm-similarity-threshold = float64,
    pg-trgm-strict-word-similarity-threshold = float64,
    pg-trgm-word-similarity-threshold = float64,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    plantuner-fix-empty-table = boolean,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    transform-null-equals = boolean,
    vacuum-cleanup-index-scale-factor = float64,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    wal-keep-size = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-14={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-insert-scale-factor = float64,
    autovacuum-vacuum-insert-threshold = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-connection-check-interval = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-async-append = boolean,
    enable-bitmapscan = boolean,
    enable-gathermerge = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-incremental-sort = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-memoize = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-parallel-append = boolean,
    enable-parallel-hash = boolean,
    enable-partition-pruning = boolean,
    enable-partitionwise-aggregate = boolean,
    enable-partitionwise-join = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    hash-mem-multiplier = float64,
    idle-in-transaction-session-timeout = integer,
    jit = boolean,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-sample = integer,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = integer,
    log-parameter-max-length-on-error = integer,
    log-recovery-conflict-waits = boolean,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = float64,
    log-temp-files = integer,
    log-transaction-sample-rate = float64,
    logical-decoding-work-mem = integer,
    maintenance-io-concurrency = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-parallel-maintenance-workers = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-slot-wal-keep-size = integer,
    max-stack-depth = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    old-snapshot-threshold = integer,
    parallel-leader-participation = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    pg-trgm-similarity-threshold = float64,
    pg-trgm-strict-word-similarity-threshold = float64,
    pg-trgm-word-similarity-threshold = float64,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    transform-null-equals = boolean,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    vacuum-failsafe-age = integer,
    vacuum-multixact-failsafe-age = integer,
    wal-keep-size = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-14-1c={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-insert-scale-factor = float64,
    autovacuum-vacuum-insert-threshold = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-connection-check-interval = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-async-append = boolean,
    enable-bitmapscan = boolean,
    enable-gathermerge = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-incremental-sort = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-memoize = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-parallel-append = boolean,
    enable-parallel-hash = boolean,
    enable-partition-pruning = boolean,
    enable-partitionwise-aggregate = boolean,
    enable-partitionwise-join = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    hash-mem-multiplier = float64,
    idle-in-transaction-session-timeout = integer,
    jit = boolean,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-sample = integer,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = integer,
    log-parameter-max-length-on-error = integer,
    log-recovery-conflict-waits = boolean,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = float64,
    log-temp-files = integer,
    log-transaction-sample-rate = float64,
    logical-decoding-work-mem = integer,
    maintenance-io-concurrency = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-parallel-maintenance-workers = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-slot-wal-keep-size = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    old-snapshot-threshold = integer,
    online-analyze-enable = boolean,
    parallel-leader-participation = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    pg-trgm-similarity-threshold = float64,
    pg-trgm-strict-word-similarity-threshold = float64,
    pg-trgm-word-similarity-threshold = float64,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    plantuner-fix-empty-table = boolean,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    transform-null-equals = boolean,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    vacuum-failsafe-age = integer,
    vacuum-multixact-failsafe-age = integer,
    wal-keep-size = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-15={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-insert-scale-factor = float64,
    autovacuum-vacuum-insert-threshold = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-connection-check-interval = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-async-append = boolean,
    enable-bitmapscan = boolean,
    enable-gathermerge = boolean,
    enable-group-by-reordering = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-incremental-sort = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-memoize = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-parallel-append = boolean,
    enable-parallel-hash = boolean,
    enable-partition-pruning = boolean,
    enable-partitionwise-aggregate = boolean,
    enable-partitionwise-join = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    hash-mem-multiplier = float64,
    idle-in-transaction-session-timeout = integer,
    jit = boolean,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-sample = integer,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = integer,
    log-parameter-max-length-on-error = integer,
    log-recovery-conflict-waits = boolean,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = float64,
    log-temp-files = integer,
    log-transaction-sample-rate = float64,
    logical-decoding-work-mem = integer,
    maintenance-io-concurrency = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-parallel-maintenance-workers = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-slot-wal-keep-size = integer,
    max-stack-depth = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    old-snapshot-threshold = integer,
    parallel-leader-participation = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    pg-trgm-similarity-threshold = float64,
    pg-trgm-strict-word-similarity-threshold = float64,
    pg-trgm-word-similarity-threshold = float64,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    transform-null-equals = boolean,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    vacuum-failsafe-age = integer,
    vacuum-multixact-failsafe-age = integer,
    wal-keep-size = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-15-1c={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-insert-scale-factor = float64,
    autovacuum-vacuum-insert-threshold = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-connection-check-interval = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-async-append = boolean,
    enable-bitmapscan = boolean,
    enable-gathermerge = boolean,
    enable-group-by-reordering = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-incremental-sort = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-memoize = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-parallel-append = boolean,
    enable-parallel-hash = boolean,
    enable-partition-pruning = boolean,
    enable-partitionwise-aggregate = boolean,
    enable-partitionwise-join = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    hash-mem-multiplier = float64,
    idle-in-transaction-session-timeout = integer,
    jit = boolean,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-sample = integer,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = integer,
    log-parameter-max-length-on-error = integer,
    log-recovery-conflict-waits = boolean,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = float64,
    log-temp-files = integer,
    log-transaction-sample-rate = float64,
    logical-decoding-work-mem = integer,
    maintenance-io-concurrency = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-parallel-maintenance-workers = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-slot-wal-keep-size = integer,
    max-stack-depth = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    old-snapshot-threshold = integer,
    online-analyze-enable = boolean,
    parallel-leader-participation = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    pg-trgm-similarity-threshold = float64,
    pg-trgm-strict-word-similarity-threshold = float64,
    pg-trgm-word-similarity-threshold = float64,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    plantuner-fix-empty-table = boolean,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    transform-null-equals = boolean,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    vacuum-failsafe-age = integer,
    vacuum-multixact-failsafe-age = integer,
    wal-keep-size = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-16={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-insert-scale-factor = float64,
    autovacuum-vacuum-insert-threshold = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-connection-check-interval = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-async-append = boolean,
    enable-bitmapscan = boolean,
    enable-gathermerge = boolean,
    enable-group-by-reordering = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-incremental-sort = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-memoize = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-parallel-append = boolean,
    enable-parallel-hash = boolean,
    enable-partition-pruning = boolean,
    enable-partitionwise-aggregate = boolean,
    enable-partitionwise-join = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    hash-mem-multiplier = float64,
    idle-in-transaction-session-timeout = integer,
    jit = boolean,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-sample = integer,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = integer,
    log-parameter-max-length-on-error = integer,
    log-recovery-conflict-waits = boolean,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = float64,
    log-temp-files = integer,
    log-transaction-sample-rate = float64,
    logical-decoding-work-mem = integer,
    maintenance-io-concurrency = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-parallel-maintenance-workers = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-slot-wal-keep-size = integer,
    max-stack-depth = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    old-snapshot-threshold = integer,
    parallel-leader-participation = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    pg-trgm-similarity-threshold = float64,
    pg-trgm-strict-word-similarity-threshold = float64,
    pg-trgm-word-similarity-threshold = float64,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    transform-null-equals = boolean,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    vacuum-failsafe-age = integer,
    vacuum-multixact-failsafe-age = integer,
    wal-keep-size = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-16-1c={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-insert-scale-factor = float64,
    autovacuum-vacuum-insert-threshold = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-connection-check-interval = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-async-append = boolean,
    enable-bitmapscan = boolean,
    enable-gathermerge = boolean,
    enable-group-by-reordering = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-incremental-sort = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-memoize = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-parallel-append = boolean,
    enable-parallel-hash = boolean,
    enable-partition-pruning = boolean,
    enable-partitionwise-aggregate = boolean,
    enable-partitionwise-join = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    hash-mem-multiplier = float64,
    idle-in-transaction-session-timeout = integer,
    jit = boolean,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-sample = integer,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = integer,
    log-parameter-max-length-on-error = integer,
    log-recovery-conflict-waits = boolean,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = float64,
    log-temp-files = integer,
    log-transaction-sample-rate = float64,
    logical-decoding-work-mem = integer,
    maintenance-io-concurrency = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-parallel-maintenance-workers = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-slot-wal-keep-size = integer,
    max-stack-depth = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    old-snapshot-threshold = integer,
    online-analyze-enable = boolean,
    parallel-leader-participation = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    pg-trgm-similarity-threshold = float64,
    pg-trgm-strict-word-similarity-threshold = float64,
    pg-trgm-word-similarity-threshold = float64,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    plantuner-fix-empty-table = boolean,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    transform-null-equals = boolean,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    vacuum-failsafe-age = integer,
    vacuum-multixact-failsafe-age = integer,
    wal-keep-size = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-17={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-insert-scale-factor = float64,
    autovacuum-vacuum-insert-threshold = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-connection-check-interval = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-async-append = boolean,
    enable-bitmapscan = boolean,
    enable-gathermerge = boolean,
    enable-group-by-reordering = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-incremental-sort = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-memoize = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-parallel-append = boolean,
    enable-parallel-hash = boolean,
    enable-partition-pruning = boolean,
    enable-partitionwise-aggregate = boolean,
    enable-partitionwise-join = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    hash-mem-multiplier = float64,
    idle-in-transaction-session-timeout = integer,
    jit = boolean,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-sample = integer,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = integer,
    log-parameter-max-length-on-error = integer,
    log-recovery-conflict-waits = boolean,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = float64,
    log-temp-files = integer,
    log-transaction-sample-rate = float64,
    logical-decoding-work-mem = integer,
    maintenance-io-concurrency = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-logical-replication-workers = integer,
    max-parallel-maintenance-workers = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-replication-slots = integer,
    max-slot-wal-keep-size = integer,
    max-stack-depth = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-senders = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    parallel-leader-participation = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    pg-trgm-similarity-threshold = float64,
    pg-trgm-strict-word-similarity-threshold = float64,
    pg-trgm-word-similarity-threshold = float64,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    track-commit-timestamp = boolean,
    transform-null-equals = boolean,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    vacuum-failsafe-age = integer,
    vacuum-multixact-failsafe-age = integer,
    wal-keep-size = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-17-1c={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-insert-scale-factor = float64,
    autovacuum-vacuum-insert-threshold = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-connection-check-interval = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-async-append = boolean,
    enable-bitmapscan = boolean,
    enable-gathermerge = boolean,
    enable-group-by-reordering = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-incremental-sort = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-memoize = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-parallel-append = boolean,
    enable-parallel-hash = boolean,
    enable-partition-pruning = boolean,
    enable-partitionwise-aggregate = boolean,
    enable-partitionwise-join = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    hash-mem-multiplier = float64,
    idle-in-transaction-session-timeout = integer,
    jit = boolean,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-sample = integer,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = integer,
    log-parameter-max-length-on-error = integer,
    log-recovery-conflict-waits = boolean,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = float64,
    log-temp-files = integer,
    log-transaction-sample-rate = float64,
    logical-decoding-work-mem = integer,
    maintenance-io-concurrency = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-logical-replication-workers = integer,
    max-parallel-maintenance-workers = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-replication-slots = integer,
    max-slot-wal-keep-size = integer,
    max-stack-depth = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-senders = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    online-analyze-enable = boolean,
    parallel-leader-participation = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    pg-trgm-similarity-threshold = float64,
    pg-trgm-strict-word-similarity-threshold = float64,
    pg-trgm-word-similarity-threshold = float64,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    plantuner-fix-empty-table = boolean,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    track-commit-timestamp = boolean,
    transform-null-equals = boolean,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    vacuum-failsafe-age = integer,
    vacuum-multixact-failsafe-age = integer,
    wal-keep-size = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-18={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-insert-scale-factor = float64,
    autovacuum-vacuum-insert-threshold = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-connection-check-interval = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-async-append = boolean,
    enable-bitmapscan = boolean,
    enable-gathermerge = boolean,
    enable-group-by-reordering = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-incremental-sort = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-memoize = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-parallel-append = boolean,
    enable-parallel-hash = boolean,
    enable-partition-pruning = boolean,
    enable-partitionwise-aggregate = boolean,
    enable-partitionwise-join = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    hash-mem-multiplier = float64,
    idle-in-transaction-session-timeout = integer,
    jit = boolean,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-sample = integer,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = integer,
    log-parameter-max-length-on-error = integer,
    log-recovery-conflict-waits = boolean,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = float64,
    log-temp-files = integer,
    log-transaction-sample-rate = float64,
    logical-decoding-work-mem = integer,
    maintenance-io-concurrency = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-logical-replication-workers = integer,
    max-parallel-maintenance-workers = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-replication-slots = integer,
    max-slot-wal-keep-size = integer,
    max-stack-depth = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-senders = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    parallel-leader-participation = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    pg-trgm-similarity-threshold = float64,
    pg-trgm-strict-word-similarity-threshold = float64,
    pg-trgm-word-similarity-threshold = float64,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    track-commit-timestamp = boolean,
    transform-null-equals = boolean,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    vacuum-failsafe-age = integer,
    vacuum-multixact-failsafe-age = integer,
    wal-keep-size = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-18-1c={
    archive-timeout = integer,
    array-nulls = boolean,
    auto-explain-log-analyze = boolean,
    auto-explain-log-buffers = boolean,
    auto-explain-log-format = AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML,
    auto-explain-log-min-duration = integer,
    auto-explain-log-nested-statements = boolean,
    auto-explain-log-timing = boolean,
    auto-explain-log-triggers = boolean,
    auto-explain-log-verbose = boolean,
    auto-explain-sample-rate = float64,
    autovacuum-analyze-scale-factor = float64,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-vacuum-insert-scale-factor = float64,
    autovacuum-vacuum-insert-threshold = integer,
    autovacuum-vacuum-scale-factor = float64,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-connection-check-interval = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-transaction-read-only = boolean,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    enable-async-append = boolean,
    enable-bitmapscan = boolean,
    enable-gathermerge = boolean,
    enable-group-by-reordering = boolean,
    enable-hashagg = boolean,
    enable-hashjoin = boolean,
    enable-incremental-sort = boolean,
    enable-indexonlyscan = boolean,
    enable-indexscan = boolean,
    enable-material = boolean,
    enable-memoize = boolean,
    enable-mergejoin = boolean,
    enable-nestloop = boolean,
    enable-parallel-append = boolean,
    enable-parallel-hash = boolean,
    enable-partition-pruning = boolean,
    enable-partitionwise-aggregate = boolean,
    enable-partitionwise-join = boolean,
    enable-seqscan = boolean,
    enable-sort = boolean,
    enable-tidscan = boolean,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    from-collapse-limit = integer,
    geqo = boolean,
    geqo-effort = integer,
    geqo-generations = integer,
    geqo-pool-size = integer,
    geqo-seed = float64,
    geqo-selection-bias = float64,
    geqo-threshold = integer,
    gin-pending-list-limit = integer,
    hash-mem-multiplier = float64,
    idle-in-transaction-session-timeout = integer,
    jit = boolean,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-autovacuum-min-duration = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-sample = integer,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-parameter-max-length = integer,
    log-parameter-max-length-on-error = integer,
    log-recovery-conflict-waits = boolean,
    log-replication-commands = boolean,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-statement-sample-rate = float64,
    log-temp-files = integer,
    log-transaction-sample-rate = float64,
    logical-decoding-work-mem = integer,
    maintenance-io-concurrency = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-logical-replication-workers = integer,
    max-parallel-maintenance-workers = integer,
    max-parallel-workers = integer,
    max-parallel-workers-per-gather = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-replication-slots = integer,
    max-slot-wal-keep-size = integer,
    max-stack-depth = integer,
    max-standby-archive-delay = integer,
    max-standby-streaming-delay = integer,
    max-wal-senders = integer,
    max-wal-size = integer,
    max-worker-processes = integer,
    min-wal-size = integer,
    online-analyze-enable = boolean,
    parallel-leader-participation = boolean,
    password-encryption = PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256,
    pg-hint-plan-debug-print = PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE,
    pg-hint-plan-enable-hint = boolean,
    pg-hint-plan-enable-hint-table = boolean,
    pg-hint-plan-message-level = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    pg-qualstats-enabled = boolean,
    pg-qualstats-max = integer,
    pg-qualstats-resolve-oids = boolean,
    pg-qualstats-sample-rate = float64,
    pg-qualstats-track-constants = boolean,
    pg-trgm-similarity-threshold = float64,
    pg-trgm-strict-word-similarity-threshold = float64,
    pg-trgm-word-similarity-threshold = float64,
    plan-cache-mode = PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN,
    plantuner-fix-empty-table = boolean,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    session-duration-timeout = integer,
    shared-buffers = integer,
    shared-preload-libraries = [
      SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON, ...
    ],
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    timezone = string,
    track-activity-query-size = integer,
    track-commit-timestamp = boolean,
    transform-null-equals = boolean,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    vacuum-failsafe-age = integer,
    vacuum-multixact-failsafe-age = integer,
    wal-keep-size = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
  } | postgresql-config-9-6={
    archive-timeout = integer,
    array-nulls = boolean,
    autovacuum-max-workers = integer,
    autovacuum-naptime = integer,
    autovacuum-vacuum-cost-delay = integer,
    autovacuum-vacuum-cost-limit = integer,
    autovacuum-work-mem = integer,
    backend-flush-after = integer,
    backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
    bgwriter-delay = integer,
    bgwriter-flush-after = integer,
    bgwriter-lru-maxpages = integer,
    bgwriter-lru-multiplier = float64,
    bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
    checkpoint-completion-target = float64,
    checkpoint-flush-after = integer,
    checkpoint-timeout = integer,
    client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
    cursor-tuple-fraction = float64,
    deadlock-timeout = integer,
    default-statistics-target = integer,
    default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
    default-with-oids = boolean,
    effective-cache-size = integer,
    effective-io-concurrency = integer,
    escape-string-warning = boolean,
    exit-on-error = boolean,
    force-parallel-mode = FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS,
    from-collapse-limit = integer,
    gin-pending-list-limit = integer,
    idle-in-transaction-session-timeout = integer,
    join-collapse-limit = integer,
    lo-compat-privileges = boolean,
    lock-timeout = integer,
    log-checkpoints = boolean,
    log-connections = boolean,
    log-disconnections = boolean,
    log-duration = boolean,
    log-error-verbosity = LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE,
    log-lock-waits = boolean,
    log-min-duration-statement = integer,
    log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
    log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
    log-temp-files = integer,
    maintenance-work-mem = integer,
    max-connections = integer,
    max-locks-per-transaction = integer,
    max-pred-locks-per-transaction = integer,
    max-prepared-transactions = integer,
    max-standby-streaming-delay = integer,
    max-wal-size = integer,
    min-wal-size = integer,
    old-snapshot-threshold = integer,
    operator-precedence-warning = boolean,
    quote-all-identifiers = boolean,
    random-page-cost = float64,
    replacement-sort-tuples = integer,
    row-security = boolean,
    search-path = string,
    seq-page-cost = float64,
    shared-buffers = integer,
    sql-inheritance = boolean,
    standard-conforming-strings = boolean,
    statement-timeout = integer,
    synchronize-seqscans = boolean,
    synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
    temp-buffers = integer,
    temp-file-limit = integer,
    track-activity-query-size = integer,
    transform-null-equals = boolean,
    vacuum-cost-delay = integer,
    vacuum-cost-limit = integer,
    vacuum-cost-page-dirty = integer,
    vacuum-cost-page-hit = integer,
    vacuum-cost-page-miss = integer,
    wal-level = WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL,
    work-mem = integer,
    xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
    xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
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
    "serverless": "boolean",
    "web-sql": "boolean",
    "yandex-query": "boolean"
  },
  "autofailover": "boolean",
  "backup-retain-period-days": "integer",
  "backup-window-start": "timeofday",
  "disk-size-autoscaling": {
    "disk-size-limit": "integer",
    "emergency-usage-threshold": "integer",
    "planned-usage-threshold": "integer"
  },
  "performance-diagnostics": {
    "enabled": "boolean",
    "sessions-sampling-interval": "integer",
    "statements-sampling-interval": "integer"
  },
  "pooler-config": {
    "pool-discard": "boolean",
    "pooling-mode": "SESSION|TRANSACTION|STATEMENT"
  },
  "postgresql-config": {
    "postgresql-config-10": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-bitmapscan": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "idle-in-transaction-session-timeout": "integer",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-temp-files": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-stack-depth": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "old-snapshot-threshold": "integer",
      "operator-precedence-warning": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "replacement-sort-tuples": "integer",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "transform-null-equals": "boolean",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-10-1c": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-bitmapscan": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "idle-in-transaction-session-timeout": "integer",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-temp-files": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-stack-depth": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "old-snapshot-threshold": "integer",
      "online-analyze-enable": "boolean",
      "operator-precedence-warning": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "plantuner-fix-empty-table": "boolean",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "replacement-sort-tuples": "integer",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "transform-null-equals": "boolean",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-11": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-bitmapscan": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-parallel-append": "boolean",
      "enable-parallel-hash": "boolean",
      "enable-partition-pruning": "boolean",
      "enable-partitionwise-aggregate": "boolean",
      "enable-partitionwise-join": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "idle-in-transaction-session-timeout": "integer",
      "jit": "boolean",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-temp-files": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-parallel-maintenance-workers": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-stack-depth": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "old-snapshot-threshold": "integer",
      "operator-precedence-warning": "boolean",
      "parallel-leader-participation": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "pg-trgm-similarity-threshold": "float64",
      "pg-trgm-strict-word-similarity-threshold": "float64",
      "pg-trgm-word-similarity-threshold": "float64",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "transform-null-equals": "boolean",
      "vacuum-cleanup-index-scale-factor": "float64",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-11-1c": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-bitmapscan": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-parallel-append": "boolean",
      "enable-parallel-hash": "boolean",
      "enable-partition-pruning": "boolean",
      "enable-partitionwise-aggregate": "boolean",
      "enable-partitionwise-join": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "idle-in-transaction-session-timeout": "integer",
      "jit": "boolean",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-temp-files": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-parallel-maintenance-workers": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-stack-depth": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "old-snapshot-threshold": "integer",
      "online-analyze-enable": "boolean",
      "operator-precedence-warning": "boolean",
      "parallel-leader-participation": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "pg-trgm-similarity-threshold": "float64",
      "pg-trgm-strict-word-similarity-threshold": "float64",
      "pg-trgm-word-similarity-threshold": "float64",
      "plantuner-fix-empty-table": "boolean",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "transform-null-equals": "boolean",
      "vacuum-cleanup-index-scale-factor": "float64",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-12": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-bitmapscan": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-parallel-append": "boolean",
      "enable-parallel-hash": "boolean",
      "enable-partition-pruning": "boolean",
      "enable-partitionwise-aggregate": "boolean",
      "enable-partitionwise-join": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "idle-in-transaction-session-timeout": "integer",
      "jit": "boolean",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-temp-files": "integer",
      "log-transaction-sample-rate": "float64",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-parallel-maintenance-workers": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-stack-depth": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "old-snapshot-threshold": "integer",
      "operator-precedence-warning": "boolean",
      "parallel-leader-participation": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "pg-trgm-similarity-threshold": "float64",
      "pg-trgm-strict-word-similarity-threshold": "float64",
      "pg-trgm-word-similarity-threshold": "float64",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "transform-null-equals": "boolean",
      "vacuum-cleanup-index-scale-factor": "float64",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-12-1c": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-bitmapscan": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-parallel-append": "boolean",
      "enable-parallel-hash": "boolean",
      "enable-partition-pruning": "boolean",
      "enable-partitionwise-aggregate": "boolean",
      "enable-partitionwise-join": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "idle-in-transaction-session-timeout": "integer",
      "jit": "boolean",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-temp-files": "integer",
      "log-transaction-sample-rate": "float64",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-parallel-maintenance-workers": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-stack-depth": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "old-snapshot-threshold": "integer",
      "online-analyze-enable": "boolean",
      "operator-precedence-warning": "boolean",
      "parallel-leader-participation": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "pg-trgm-similarity-threshold": "float64",
      "pg-trgm-strict-word-similarity-threshold": "float64",
      "pg-trgm-word-similarity-threshold": "float64",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "plantuner-fix-empty-table": "boolean",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "transform-null-equals": "boolean",
      "vacuum-cleanup-index-scale-factor": "float64",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-13": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-insert-scale-factor": "float64",
      "autovacuum-vacuum-insert-threshold": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-bitmapscan": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-incremental-sort": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-parallel-append": "boolean",
      "enable-parallel-hash": "boolean",
      "enable-partition-pruning": "boolean",
      "enable-partitionwise-aggregate": "boolean",
      "enable-partitionwise-join": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "hash-mem-multiplier": "float64",
      "idle-in-transaction-session-timeout": "integer",
      "jit": "boolean",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-sample": "integer",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "integer",
      "log-parameter-max-length-on-error": "integer",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "float64",
      "log-temp-files": "integer",
      "log-transaction-sample-rate": "float64",
      "logical-decoding-work-mem": "integer",
      "maintenance-io-concurrency": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-parallel-maintenance-workers": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-slot-wal-keep-size": "integer",
      "max-stack-depth": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "old-snapshot-threshold": "integer",
      "operator-precedence-warning": "boolean",
      "parallel-leader-participation": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "pg-trgm-similarity-threshold": "float64",
      "pg-trgm-strict-word-similarity-threshold": "float64",
      "pg-trgm-word-similarity-threshold": "float64",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "transform-null-equals": "boolean",
      "vacuum-cleanup-index-scale-factor": "float64",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "wal-keep-size": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-13-1c": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-insert-scale-factor": "float64",
      "autovacuum-vacuum-insert-threshold": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-bitmapscan": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-incremental-sort": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-parallel-append": "boolean",
      "enable-parallel-hash": "boolean",
      "enable-partition-pruning": "boolean",
      "enable-partitionwise-aggregate": "boolean",
      "enable-partitionwise-join": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "hash-mem-multiplier": "float64",
      "idle-in-transaction-session-timeout": "integer",
      "jit": "boolean",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-sample": "integer",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "integer",
      "log-parameter-max-length-on-error": "integer",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "float64",
      "log-temp-files": "integer",
      "log-transaction-sample-rate": "float64",
      "logical-decoding-work-mem": "integer",
      "maintenance-io-concurrency": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-parallel-maintenance-workers": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-slot-wal-keep-size": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "old-snapshot-threshold": "integer",
      "online-analyze-enable": "boolean",
      "operator-precedence-warning": "boolean",
      "parallel-leader-participation": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "pg-trgm-similarity-threshold": "float64",
      "pg-trgm-strict-word-similarity-threshold": "float64",
      "pg-trgm-word-similarity-threshold": "float64",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "plantuner-fix-empty-table": "boolean",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "transform-null-equals": "boolean",
      "vacuum-cleanup-index-scale-factor": "float64",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "wal-keep-size": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-14": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-insert-scale-factor": "float64",
      "autovacuum-vacuum-insert-threshold": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-connection-check-interval": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-async-append": "boolean",
      "enable-bitmapscan": "boolean",
      "enable-gathermerge": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-incremental-sort": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-memoize": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-parallel-append": "boolean",
      "enable-parallel-hash": "boolean",
      "enable-partition-pruning": "boolean",
      "enable-partitionwise-aggregate": "boolean",
      "enable-partitionwise-join": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "hash-mem-multiplier": "float64",
      "idle-in-transaction-session-timeout": "integer",
      "jit": "boolean",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-sample": "integer",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "integer",
      "log-parameter-max-length-on-error": "integer",
      "log-recovery-conflict-waits": "boolean",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "float64",
      "log-temp-files": "integer",
      "log-transaction-sample-rate": "float64",
      "logical-decoding-work-mem": "integer",
      "maintenance-io-concurrency": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-parallel-maintenance-workers": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-slot-wal-keep-size": "integer",
      "max-stack-depth": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "old-snapshot-threshold": "integer",
      "parallel-leader-participation": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "pg-trgm-similarity-threshold": "float64",
      "pg-trgm-strict-word-similarity-threshold": "float64",
      "pg-trgm-word-similarity-threshold": "float64",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "transform-null-equals": "boolean",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "vacuum-failsafe-age": "integer",
      "vacuum-multixact-failsafe-age": "integer",
      "wal-keep-size": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-14-1c": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-insert-scale-factor": "float64",
      "autovacuum-vacuum-insert-threshold": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-connection-check-interval": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-async-append": "boolean",
      "enable-bitmapscan": "boolean",
      "enable-gathermerge": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-incremental-sort": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-memoize": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-parallel-append": "boolean",
      "enable-parallel-hash": "boolean",
      "enable-partition-pruning": "boolean",
      "enable-partitionwise-aggregate": "boolean",
      "enable-partitionwise-join": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "hash-mem-multiplier": "float64",
      "idle-in-transaction-session-timeout": "integer",
      "jit": "boolean",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-sample": "integer",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "integer",
      "log-parameter-max-length-on-error": "integer",
      "log-recovery-conflict-waits": "boolean",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "float64",
      "log-temp-files": "integer",
      "log-transaction-sample-rate": "float64",
      "logical-decoding-work-mem": "integer",
      "maintenance-io-concurrency": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-parallel-maintenance-workers": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-slot-wal-keep-size": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "old-snapshot-threshold": "integer",
      "online-analyze-enable": "boolean",
      "parallel-leader-participation": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "pg-trgm-similarity-threshold": "float64",
      "pg-trgm-strict-word-similarity-threshold": "float64",
      "pg-trgm-word-similarity-threshold": "float64",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "plantuner-fix-empty-table": "boolean",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "transform-null-equals": "boolean",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "vacuum-failsafe-age": "integer",
      "vacuum-multixact-failsafe-age": "integer",
      "wal-keep-size": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-15": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-insert-scale-factor": "float64",
      "autovacuum-vacuum-insert-threshold": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-connection-check-interval": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-async-append": "boolean",
      "enable-bitmapscan": "boolean",
      "enable-gathermerge": "boolean",
      "enable-group-by-reordering": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-incremental-sort": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-memoize": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-parallel-append": "boolean",
      "enable-parallel-hash": "boolean",
      "enable-partition-pruning": "boolean",
      "enable-partitionwise-aggregate": "boolean",
      "enable-partitionwise-join": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "hash-mem-multiplier": "float64",
      "idle-in-transaction-session-timeout": "integer",
      "jit": "boolean",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-sample": "integer",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "integer",
      "log-parameter-max-length-on-error": "integer",
      "log-recovery-conflict-waits": "boolean",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "float64",
      "log-temp-files": "integer",
      "log-transaction-sample-rate": "float64",
      "logical-decoding-work-mem": "integer",
      "maintenance-io-concurrency": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-parallel-maintenance-workers": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-slot-wal-keep-size": "integer",
      "max-stack-depth": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "old-snapshot-threshold": "integer",
      "parallel-leader-participation": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "pg-trgm-similarity-threshold": "float64",
      "pg-trgm-strict-word-similarity-threshold": "float64",
      "pg-trgm-word-similarity-threshold": "float64",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "transform-null-equals": "boolean",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "vacuum-failsafe-age": "integer",
      "vacuum-multixact-failsafe-age": "integer",
      "wal-keep-size": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-15-1c": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-insert-scale-factor": "float64",
      "autovacuum-vacuum-insert-threshold": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-connection-check-interval": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-async-append": "boolean",
      "enable-bitmapscan": "boolean",
      "enable-gathermerge": "boolean",
      "enable-group-by-reordering": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-incremental-sort": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-memoize": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-parallel-append": "boolean",
      "enable-parallel-hash": "boolean",
      "enable-partition-pruning": "boolean",
      "enable-partitionwise-aggregate": "boolean",
      "enable-partitionwise-join": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "hash-mem-multiplier": "float64",
      "idle-in-transaction-session-timeout": "integer",
      "jit": "boolean",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-sample": "integer",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "integer",
      "log-parameter-max-length-on-error": "integer",
      "log-recovery-conflict-waits": "boolean",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "float64",
      "log-temp-files": "integer",
      "log-transaction-sample-rate": "float64",
      "logical-decoding-work-mem": "integer",
      "maintenance-io-concurrency": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-parallel-maintenance-workers": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-slot-wal-keep-size": "integer",
      "max-stack-depth": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "old-snapshot-threshold": "integer",
      "online-analyze-enable": "boolean",
      "parallel-leader-participation": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "pg-trgm-similarity-threshold": "float64",
      "pg-trgm-strict-word-similarity-threshold": "float64",
      "pg-trgm-word-similarity-threshold": "float64",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "plantuner-fix-empty-table": "boolean",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "transform-null-equals": "boolean",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "vacuum-failsafe-age": "integer",
      "vacuum-multixact-failsafe-age": "integer",
      "wal-keep-size": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-16": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-insert-scale-factor": "float64",
      "autovacuum-vacuum-insert-threshold": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-connection-check-interval": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-async-append": "boolean",
      "enable-bitmapscan": "boolean",
      "enable-gathermerge": "boolean",
      "enable-group-by-reordering": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-incremental-sort": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-memoize": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-parallel-append": "boolean",
      "enable-parallel-hash": "boolean",
      "enable-partition-pruning": "boolean",
      "enable-partitionwise-aggregate": "boolean",
      "enable-partitionwise-join": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "hash-mem-multiplier": "float64",
      "idle-in-transaction-session-timeout": "integer",
      "jit": "boolean",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-sample": "integer",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "integer",
      "log-parameter-max-length-on-error": "integer",
      "log-recovery-conflict-waits": "boolean",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "float64",
      "log-temp-files": "integer",
      "log-transaction-sample-rate": "float64",
      "logical-decoding-work-mem": "integer",
      "maintenance-io-concurrency": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-parallel-maintenance-workers": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-slot-wal-keep-size": "integer",
      "max-stack-depth": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "old-snapshot-threshold": "integer",
      "parallel-leader-participation": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "pg-trgm-similarity-threshold": "float64",
      "pg-trgm-strict-word-similarity-threshold": "float64",
      "pg-trgm-word-similarity-threshold": "float64",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "transform-null-equals": "boolean",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "vacuum-failsafe-age": "integer",
      "vacuum-multixact-failsafe-age": "integer",
      "wal-keep-size": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-16-1c": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-insert-scale-factor": "float64",
      "autovacuum-vacuum-insert-threshold": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-connection-check-interval": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-async-append": "boolean",
      "enable-bitmapscan": "boolean",
      "enable-gathermerge": "boolean",
      "enable-group-by-reordering": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-incremental-sort": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-memoize": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-parallel-append": "boolean",
      "enable-parallel-hash": "boolean",
      "enable-partition-pruning": "boolean",
      "enable-partitionwise-aggregate": "boolean",
      "enable-partitionwise-join": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "hash-mem-multiplier": "float64",
      "idle-in-transaction-session-timeout": "integer",
      "jit": "boolean",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-sample": "integer",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "integer",
      "log-parameter-max-length-on-error": "integer",
      "log-recovery-conflict-waits": "boolean",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "float64",
      "log-temp-files": "integer",
      "log-transaction-sample-rate": "float64",
      "logical-decoding-work-mem": "integer",
      "maintenance-io-concurrency": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-parallel-maintenance-workers": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-slot-wal-keep-size": "integer",
      "max-stack-depth": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "old-snapshot-threshold": "integer",
      "online-analyze-enable": "boolean",
      "parallel-leader-participation": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "pg-trgm-similarity-threshold": "float64",
      "pg-trgm-strict-word-similarity-threshold": "float64",
      "pg-trgm-word-similarity-threshold": "float64",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "plantuner-fix-empty-table": "boolean",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "transform-null-equals": "boolean",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "vacuum-failsafe-age": "integer",
      "vacuum-multixact-failsafe-age": "integer",
      "wal-keep-size": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-17": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-insert-scale-factor": "float64",
      "autovacuum-vacuum-insert-threshold": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-connection-check-interval": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-async-append": "boolean",
      "enable-bitmapscan": "boolean",
      "enable-gathermerge": "boolean",
      "enable-group-by-reordering": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-incremental-sort": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-memoize": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-parallel-append": "boolean",
      "enable-parallel-hash": "boolean",
      "enable-partition-pruning": "boolean",
      "enable-partitionwise-aggregate": "boolean",
      "enable-partitionwise-join": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "hash-mem-multiplier": "float64",
      "idle-in-transaction-session-timeout": "integer",
      "jit": "boolean",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-sample": "integer",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "integer",
      "log-parameter-max-length-on-error": "integer",
      "log-recovery-conflict-waits": "boolean",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "float64",
      "log-temp-files": "integer",
      "log-transaction-sample-rate": "float64",
      "logical-decoding-work-mem": "integer",
      "maintenance-io-concurrency": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-logical-replication-workers": "integer",
      "max-parallel-maintenance-workers": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-replication-slots": "integer",
      "max-slot-wal-keep-size": "integer",
      "max-stack-depth": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-senders": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "parallel-leader-participation": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "pg-trgm-similarity-threshold": "float64",
      "pg-trgm-strict-word-similarity-threshold": "float64",
      "pg-trgm-word-similarity-threshold": "float64",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "track-commit-timestamp": "boolean",
      "transform-null-equals": "boolean",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "vacuum-failsafe-age": "integer",
      "vacuum-multixact-failsafe-age": "integer",
      "wal-keep-size": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-17-1c": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-insert-scale-factor": "float64",
      "autovacuum-vacuum-insert-threshold": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-connection-check-interval": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-async-append": "boolean",
      "enable-bitmapscan": "boolean",
      "enable-gathermerge": "boolean",
      "enable-group-by-reordering": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-incremental-sort": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-memoize": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-parallel-append": "boolean",
      "enable-parallel-hash": "boolean",
      "enable-partition-pruning": "boolean",
      "enable-partitionwise-aggregate": "boolean",
      "enable-partitionwise-join": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "hash-mem-multiplier": "float64",
      "idle-in-transaction-session-timeout": "integer",
      "jit": "boolean",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-sample": "integer",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "integer",
      "log-parameter-max-length-on-error": "integer",
      "log-recovery-conflict-waits": "boolean",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "float64",
      "log-temp-files": "integer",
      "log-transaction-sample-rate": "float64",
      "logical-decoding-work-mem": "integer",
      "maintenance-io-concurrency": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-logical-replication-workers": "integer",
      "max-parallel-maintenance-workers": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-replication-slots": "integer",
      "max-slot-wal-keep-size": "integer",
      "max-stack-depth": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-senders": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "online-analyze-enable": "boolean",
      "parallel-leader-participation": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "pg-trgm-similarity-threshold": "float64",
      "pg-trgm-strict-word-similarity-threshold": "float64",
      "pg-trgm-word-similarity-threshold": "float64",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "plantuner-fix-empty-table": "boolean",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "track-commit-timestamp": "boolean",
      "transform-null-equals": "boolean",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "vacuum-failsafe-age": "integer",
      "vacuum-multixact-failsafe-age": "integer",
      "wal-keep-size": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-18": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-insert-scale-factor": "float64",
      "autovacuum-vacuum-insert-threshold": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-connection-check-interval": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-async-append": "boolean",
      "enable-bitmapscan": "boolean",
      "enable-gathermerge": "boolean",
      "enable-group-by-reordering": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-incremental-sort": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-memoize": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-parallel-append": "boolean",
      "enable-parallel-hash": "boolean",
      "enable-partition-pruning": "boolean",
      "enable-partitionwise-aggregate": "boolean",
      "enable-partitionwise-join": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "hash-mem-multiplier": "float64",
      "idle-in-transaction-session-timeout": "integer",
      "jit": "boolean",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-sample": "integer",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "integer",
      "log-parameter-max-length-on-error": "integer",
      "log-recovery-conflict-waits": "boolean",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "float64",
      "log-temp-files": "integer",
      "log-transaction-sample-rate": "float64",
      "logical-decoding-work-mem": "integer",
      "maintenance-io-concurrency": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-logical-replication-workers": "integer",
      "max-parallel-maintenance-workers": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-replication-slots": "integer",
      "max-slot-wal-keep-size": "integer",
      "max-stack-depth": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-senders": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "parallel-leader-participation": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "pg-trgm-similarity-threshold": "float64",
      "pg-trgm-strict-word-similarity-threshold": "float64",
      "pg-trgm-word-similarity-threshold": "float64",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "track-commit-timestamp": "boolean",
      "transform-null-equals": "boolean",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "vacuum-failsafe-age": "integer",
      "vacuum-multixact-failsafe-age": "integer",
      "wal-keep-size": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-18-1c": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "auto-explain-log-analyze": "boolean",
      "auto-explain-log-buffers": "boolean",
      "auto-explain-log-format": "AUTO_EXPLAIN_LOG_FORMAT_TEXT|AUTO_EXPLAIN_LOG_FORMAT_XML|AUTO_EXPLAIN_LOG_FORMAT_JSON|AUTO_EXPLAIN_LOG_FORMAT_YAML",
      "auto-explain-log-min-duration": "integer",
      "auto-explain-log-nested-statements": "boolean",
      "auto-explain-log-timing": "boolean",
      "auto-explain-log-triggers": "boolean",
      "auto-explain-log-verbose": "boolean",
      "auto-explain-sample-rate": "float64",
      "autovacuum-analyze-scale-factor": "float64",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-vacuum-insert-scale-factor": "float64",
      "autovacuum-vacuum-insert-threshold": "integer",
      "autovacuum-vacuum-scale-factor": "float64",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-connection-check-interval": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-transaction-read-only": "boolean",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "enable-async-append": "boolean",
      "enable-bitmapscan": "boolean",
      "enable-gathermerge": "boolean",
      "enable-group-by-reordering": "boolean",
      "enable-hashagg": "boolean",
      "enable-hashjoin": "boolean",
      "enable-incremental-sort": "boolean",
      "enable-indexonlyscan": "boolean",
      "enable-indexscan": "boolean",
      "enable-material": "boolean",
      "enable-memoize": "boolean",
      "enable-mergejoin": "boolean",
      "enable-nestloop": "boolean",
      "enable-parallel-append": "boolean",
      "enable-parallel-hash": "boolean",
      "enable-partition-pruning": "boolean",
      "enable-partitionwise-aggregate": "boolean",
      "enable-partitionwise-join": "boolean",
      "enable-seqscan": "boolean",
      "enable-sort": "boolean",
      "enable-tidscan": "boolean",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "from-collapse-limit": "integer",
      "geqo": "boolean",
      "geqo-effort": "integer",
      "geqo-generations": "integer",
      "geqo-pool-size": "integer",
      "geqo-seed": "float64",
      "geqo-selection-bias": "float64",
      "geqo-threshold": "integer",
      "gin-pending-list-limit": "integer",
      "hash-mem-multiplier": "float64",
      "idle-in-transaction-session-timeout": "integer",
      "jit": "boolean",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-autovacuum-min-duration": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-sample": "integer",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-parameter-max-length": "integer",
      "log-parameter-max-length-on-error": "integer",
      "log-recovery-conflict-waits": "boolean",
      "log-replication-commands": "boolean",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-statement-sample-rate": "float64",
      "log-temp-files": "integer",
      "log-transaction-sample-rate": "float64",
      "logical-decoding-work-mem": "integer",
      "maintenance-io-concurrency": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-logical-replication-workers": "integer",
      "max-parallel-maintenance-workers": "integer",
      "max-parallel-workers": "integer",
      "max-parallel-workers-per-gather": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-replication-slots": "integer",
      "max-slot-wal-keep-size": "integer",
      "max-stack-depth": "integer",
      "max-standby-archive-delay": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-senders": "integer",
      "max-wal-size": "integer",
      "max-worker-processes": "integer",
      "min-wal-size": "integer",
      "online-analyze-enable": "boolean",
      "parallel-leader-participation": "boolean",
      "password-encryption": "PASSWORD_ENCRYPTION_MD5|PASSWORD_ENCRYPTION_SCRAM_SHA_256",
      "pg-hint-plan-debug-print": "PG_HINT_PLAN_DEBUG_PRINT_OFF|PG_HINT_PLAN_DEBUG_PRINT_ON|PG_HINT_PLAN_DEBUG_PRINT_DETAILED|PG_HINT_PLAN_DEBUG_PRINT_VERBOSE",
      "pg-hint-plan-enable-hint": "boolean",
      "pg-hint-plan-enable-hint-table": "boolean",
      "pg-hint-plan-message-level": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "pg-qualstats-enabled": "boolean",
      "pg-qualstats-max": "integer",
      "pg-qualstats-resolve-oids": "boolean",
      "pg-qualstats-sample-rate": "float64",
      "pg-qualstats-track-constants": "boolean",
      "pg-trgm-similarity-threshold": "float64",
      "pg-trgm-strict-word-similarity-threshold": "float64",
      "pg-trgm-word-similarity-threshold": "float64",
      "plan-cache-mode": "PLAN_CACHE_MODE_AUTO|PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN|PLAN_CACHE_MODE_FORCE_GENERIC_PLAN",
      "plantuner-fix-empty-table": "boolean",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "session-duration-timeout": "integer",
      "shared-buffers": "integer",
      "shared-preload-libraries": [
        "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN|SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN|SHARED_PRELOAD_LIBRARIES_TIMESCALEDB|SHARED_PRELOAD_LIBRARIES_PG_QUALSTATS|SHARED_PRELOAD_LIBRARIES_PG_CRON|SHARED_PRELOAD_LIBRARIES_PGLOGICAL|SHARED_PRELOAD_LIBRARIES_PG_PREWARM|SHARED_PRELOAD_LIBRARIES_PGAUDIT|SHARED_PRELOAD_LIBRARIES_ANON", ...
      ],
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "timezone": "string",
      "track-activity-query-size": "integer",
      "track-commit-timestamp": "boolean",
      "transform-null-equals": "boolean",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "vacuum-failsafe-age": "integer",
      "vacuum-multixact-failsafe-age": "integer",
      "wal-keep-size": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    },
    "postgresql-config-9-6": {
      "archive-timeout": "integer",
      "array-nulls": "boolean",
      "autovacuum-max-workers": "integer",
      "autovacuum-naptime": "integer",
      "autovacuum-vacuum-cost-delay": "integer",
      "autovacuum-vacuum-cost-limit": "integer",
      "autovacuum-work-mem": "integer",
      "backend-flush-after": "integer",
      "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
      "bgwriter-delay": "integer",
      "bgwriter-flush-after": "integer",
      "bgwriter-lru-maxpages": "integer",
      "bgwriter-lru-multiplier": "float64",
      "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
      "checkpoint-completion-target": "float64",
      "checkpoint-flush-after": "integer",
      "checkpoint-timeout": "integer",
      "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
      "cursor-tuple-fraction": "float64",
      "deadlock-timeout": "integer",
      "default-statistics-target": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "default-with-oids": "boolean",
      "effective-cache-size": "integer",
      "effective-io-concurrency": "integer",
      "escape-string-warning": "boolean",
      "exit-on-error": "boolean",
      "force-parallel-mode": "FORCE_PARALLEL_MODE_ON|FORCE_PARALLEL_MODE_OFF|FORCE_PARALLEL_MODE_REGRESS",
      "from-collapse-limit": "integer",
      "gin-pending-list-limit": "integer",
      "idle-in-transaction-session-timeout": "integer",
      "join-collapse-limit": "integer",
      "lo-compat-privileges": "boolean",
      "lock-timeout": "integer",
      "log-checkpoints": "boolean",
      "log-connections": "boolean",
      "log-disconnections": "boolean",
      "log-duration": "boolean",
      "log-error-verbosity": "LOG_ERROR_VERBOSITY_TERSE|LOG_ERROR_VERBOSITY_DEFAULT|LOG_ERROR_VERBOSITY_VERBOSE",
      "log-lock-waits": "boolean",
      "log-min-duration-statement": "integer",
      "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "log-temp-files": "integer",
      "maintenance-work-mem": "integer",
      "max-connections": "integer",
      "max-locks-per-transaction": "integer",
      "max-pred-locks-per-transaction": "integer",
      "max-prepared-transactions": "integer",
      "max-standby-streaming-delay": "integer",
      "max-wal-size": "integer",
      "min-wal-size": "integer",
      "old-snapshot-threshold": "integer",
      "operator-precedence-warning": "boolean",
      "quote-all-identifiers": "boolean",
      "random-page-cost": "float64",
      "replacement-sort-tuples": "integer",
      "row-security": "boolean",
      "search-path": "string",
      "seq-page-cost": "float64",
      "shared-buffers": "integer",
      "sql-inheritance": "boolean",
      "standard-conforming-strings": "boolean",
      "statement-timeout": "integer",
      "synchronize-seqscans": "boolean",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-buffers": "integer",
      "temp-file-limit": "integer",
      "track-activity-query-size": "integer",
      "transform-null-equals": "boolean",
      "vacuum-cost-delay": "integer",
      "vacuum-cost-limit": "integer",
      "vacuum-cost-page-dirty": "integer",
      "vacuum-cost-page-hit": "integer",
      "vacuum-cost-page-miss": "integer",
      "wal-level": "WAL_LEVEL_REPLICA|WAL_LEVEL_LOGICAL",
      "work-mem": "integer",
      "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
      "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
    }
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
  Access policy to DB
  data-lens -> (boolean)
    Allow access for DataLens
  data-transfer -> (boolean)
    Allow access for DataTransfer.
  serverless -> (boolean)
    Allow access for Serverless
  web-sql -> (boolean)
    Allow SQL queries to the cluster databases from the management console. See documentation for more details.
  yandex-query -> (boolean)
    Allow access for YandexQuery.
autofailover -> (boolean)
  Configuration setting which enables/disables autofailover in cluster.
backup-retain-period-days -> (integer)
  Retention policy of automated backups.
backup-window-start -> (timeofday)
  Time to start the daily backup, in the UTC timezone.
disk-size-autoscaling -> (struct)
  Disk size autoscaling
  disk-size-limit -> (integer)
    New storage size (in bytes) that is set when one of the thresholds is achieved.
  emergency-usage-threshold -> (integer)
    Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold.
  planned-usage-threshold -> (integer)
    Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold.
performance-diagnostics -> (struct)
  Configuration of the performance diagnostics service.
  enabled -> (boolean)
    Configuration setting which enables/disables performance diagnostics service in cluster.
  sessions-sampling-interval -> (integer)
    Interval (in seconds) for pg_stat_activity sampling
  statements-sampling-interval -> (integer)
    Interval (in seconds) for pg_stat_statements sampling
pooler-config -> (struct)
  Configuration of the connection pooler.
  pool-discard -> (boolean)
    Setting 'server_reset_query_always' parameter in PgBouncer.
  pooling-mode -> (struct)
    Mode that the connection pooler is working in. See descriptions of all modes in the documentation for PgBouncer.
resources -> (struct)
  Resources allocated to PostgreSQL hosts.
  disk-size -> (integer)
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
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (integer)
    gin-pending-list-limit -> (integer)
    idle-in-transaction-session-timeout -> (integer)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-statement -> (struct)
    log-temp-files -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-size -> (integer)
    min-wal-size -> (integer)
    old-snapshot-threshold -> (integer)
    operator-precedence-warning -> (boolean)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    replacement-sort-tuples -> (integer)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    shared-buffers -> (integer)
    sql-inheritance -> (boolean)
      This option has been removed in PostgreSQL 10.
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    track-activity-query-size -> (integer)
    transform-null-equals -> (boolean)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-10-1c -> (struct)
    Configuration for a PostgreSQL 10 1C cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-bitmapscan -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    idle-in-transaction-session-timeout -> (integer)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-temp-files -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-stack-depth -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    old-snapshot-threshold -> (integer)
    online-analyze-enable -> (boolean)
    operator-precedence-warning -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    plantuner-fix-empty-table -> (boolean)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    replacement-sort-tuples -> (integer)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    transform-null-equals -> (boolean)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-10 -> (struct)
    Configuration for a PostgreSQL 10 cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-bitmapscan -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    idle-in-transaction-session-timeout -> (integer)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-temp-files -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-stack-depth -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    old-snapshot-threshold -> (integer)
    operator-precedence-warning -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    replacement-sort-tuples -> (integer)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    transform-null-equals -> (boolean)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-11 -> (struct)
    Configuration for a PostgreSQL 11 cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-bitmapscan -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-parallel-append -> (boolean)
    enable-parallel-hash -> (boolean)
    enable-partition-pruning -> (boolean)
    enable-partitionwise-aggregate -> (boolean)
    enable-partitionwise-join -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    idle-in-transaction-session-timeout -> (integer)
    jit -> (boolean)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-temp-files -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-parallel-maintenance-workers -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-stack-depth -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    old-snapshot-threshold -> (integer)
    operator-precedence-warning -> (boolean)
    parallel-leader-participation -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    pg-trgm-similarity-threshold -> (float64)
    pg-trgm-strict-word-similarity-threshold -> (float64)
    pg-trgm-word-similarity-threshold -> (float64)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    transform-null-equals -> (boolean)
    vacuum-cleanup-index-scale-factor -> (float64)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-11-1c -> (struct)
    Configuration for a PostgreSQL 11 1C cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-bitmapscan -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-parallel-append -> (boolean)
    enable-parallel-hash -> (boolean)
    enable-partition-pruning -> (boolean)
    enable-partitionwise-aggregate -> (boolean)
    enable-partitionwise-join -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    idle-in-transaction-session-timeout -> (integer)
    jit -> (boolean)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-temp-files -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-parallel-maintenance-workers -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-stack-depth -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    old-snapshot-threshold -> (integer)
    online-analyze-enable -> (boolean)
    operator-precedence-warning -> (boolean)
    parallel-leader-participation -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    pg-trgm-similarity-threshold -> (float64)
    pg-trgm-strict-word-similarity-threshold -> (float64)
    pg-trgm-word-similarity-threshold -> (float64)
    plantuner-fix-empty-table -> (boolean)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    transform-null-equals -> (boolean)
    vacuum-cleanup-index-scale-factor -> (float64)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-12 -> (struct)
    Configuration for a PostgreSQL 12 cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-bitmapscan -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-parallel-append -> (boolean)
    enable-parallel-hash -> (boolean)
    enable-partition-pruning -> (boolean)
    enable-partitionwise-aggregate -> (boolean)
    enable-partitionwise-join -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    idle-in-transaction-session-timeout -> (integer)
    jit -> (boolean)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-temp-files -> (integer)
    log-transaction-sample-rate -> (float64)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-parallel-maintenance-workers -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-stack-depth -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    old-snapshot-threshold -> (integer)
    operator-precedence-warning -> (boolean)
    parallel-leader-participation -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    pg-trgm-similarity-threshold -> (float64)
    pg-trgm-strict-word-similarity-threshold -> (float64)
    pg-trgm-word-similarity-threshold -> (float64)
    plan-cache-mode -> (struct)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    transform-null-equals -> (boolean)
    vacuum-cleanup-index-scale-factor -> (float64)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-12-1c -> (struct)
    Configuration for a PostgreSQL 12 1C cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-bitmapscan -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-parallel-append -> (boolean)
    enable-parallel-hash -> (boolean)
    enable-partition-pruning -> (boolean)
    enable-partitionwise-aggregate -> (boolean)
    enable-partitionwise-join -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    idle-in-transaction-session-timeout -> (integer)
    jit -> (boolean)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-temp-files -> (integer)
    log-transaction-sample-rate -> (float64)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-parallel-maintenance-workers -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-stack-depth -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    old-snapshot-threshold -> (integer)
    online-analyze-enable -> (boolean)
    operator-precedence-warning -> (boolean)
    parallel-leader-participation -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    pg-trgm-similarity-threshold -> (float64)
    pg-trgm-strict-word-similarity-threshold -> (float64)
    pg-trgm-word-similarity-threshold -> (float64)
    plan-cache-mode -> (struct)
    plantuner-fix-empty-table -> (boolean)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    transform-null-equals -> (boolean)
    vacuum-cleanup-index-scale-factor -> (float64)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-13 -> (struct)
    Configuration for a PostgreSQL 13 cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-insert-scale-factor -> (float64)
    autovacuum-vacuum-insert-threshold -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-bitmapscan -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-incremental-sort -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-parallel-append -> (boolean)
    enable-parallel-hash -> (boolean)
    enable-partition-pruning -> (boolean)
    enable-partitionwise-aggregate -> (boolean)
    enable-partitionwise-join -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    hash-mem-multiplier -> (float64)
    idle-in-transaction-session-timeout -> (integer)
    jit -> (boolean)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-sample -> (integer)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (integer)
    log-parameter-max-length-on-error -> (integer)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-statement-sample-rate -> (float64)
    log-temp-files -> (integer)
    log-transaction-sample-rate -> (float64)
    logical-decoding-work-mem -> (integer)
    maintenance-io-concurrency -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-parallel-maintenance-workers -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-slot-wal-keep-size -> (integer)
    max-stack-depth -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    old-snapshot-threshold -> (integer)
    operator-precedence-warning -> (boolean)
    parallel-leader-participation -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    pg-trgm-similarity-threshold -> (float64)
    pg-trgm-strict-word-similarity-threshold -> (float64)
    pg-trgm-word-similarity-threshold -> (float64)
    plan-cache-mode -> (struct)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    transform-null-equals -> (boolean)
    vacuum-cleanup-index-scale-factor -> (float64)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    wal-keep-size -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-13-1c -> (struct)
    Configuration for a PostgreSQL 13 1C cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-insert-scale-factor -> (float64)
    autovacuum-vacuum-insert-threshold -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-bitmapscan -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-incremental-sort -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-parallel-append -> (boolean)
    enable-parallel-hash -> (boolean)
    enable-partition-pruning -> (boolean)
    enable-partitionwise-aggregate -> (boolean)
    enable-partitionwise-join -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    hash-mem-multiplier -> (float64)
    idle-in-transaction-session-timeout -> (integer)
    jit -> (boolean)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-sample -> (integer)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (integer)
    log-parameter-max-length-on-error -> (integer)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-statement-sample-rate -> (float64)
    log-temp-files -> (integer)
    log-transaction-sample-rate -> (float64)
    logical-decoding-work-mem -> (integer)
    maintenance-io-concurrency -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-parallel-maintenance-workers -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-slot-wal-keep-size -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    old-snapshot-threshold -> (integer)
    online-analyze-enable -> (boolean)
    operator-precedence-warning -> (boolean)
    parallel-leader-participation -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    pg-trgm-similarity-threshold -> (float64)
    pg-trgm-strict-word-similarity-threshold -> (float64)
    pg-trgm-word-similarity-threshold -> (float64)
    plan-cache-mode -> (struct)
    plantuner-fix-empty-table -> (boolean)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    transform-null-equals -> (boolean)
    vacuum-cleanup-index-scale-factor -> (float64)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    wal-keep-size -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-14 -> (struct)
    Configuration for a PostgreSQL 14 cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-insert-scale-factor -> (float64)
    autovacuum-vacuum-insert-threshold -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-connection-check-interval -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-async-append -> (boolean)
    enable-bitmapscan -> (boolean)
    enable-gathermerge -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-incremental-sort -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-memoize -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-parallel-append -> (boolean)
    enable-parallel-hash -> (boolean)
    enable-partition-pruning -> (boolean)
    enable-partitionwise-aggregate -> (boolean)
    enable-partitionwise-join -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    hash-mem-multiplier -> (float64)
    idle-in-transaction-session-timeout -> (integer)
    jit -> (boolean)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-sample -> (integer)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (integer)
    log-parameter-max-length-on-error -> (integer)
    log-recovery-conflict-waits -> (boolean)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-statement-sample-rate -> (float64)
    log-temp-files -> (integer)
    log-transaction-sample-rate -> (float64)
    logical-decoding-work-mem -> (integer)
    maintenance-io-concurrency -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-parallel-maintenance-workers -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-slot-wal-keep-size -> (integer)
    max-stack-depth -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    old-snapshot-threshold -> (integer)
    parallel-leader-participation -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    pg-trgm-similarity-threshold -> (float64)
    pg-trgm-strict-word-similarity-threshold -> (float64)
    pg-trgm-word-similarity-threshold -> (float64)
    plan-cache-mode -> (struct)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    transform-null-equals -> (boolean)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    vacuum-failsafe-age -> (integer)
    vacuum-multixact-failsafe-age -> (integer)
    wal-keep-size -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-14-1c -> (struct)
    Configuration for a PostgreSQL 14 1C cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-insert-scale-factor -> (float64)
    autovacuum-vacuum-insert-threshold -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-connection-check-interval -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-async-append -> (boolean)
    enable-bitmapscan -> (boolean)
    enable-gathermerge -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-incremental-sort -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-memoize -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-parallel-append -> (boolean)
    enable-parallel-hash -> (boolean)
    enable-partition-pruning -> (boolean)
    enable-partitionwise-aggregate -> (boolean)
    enable-partitionwise-join -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    hash-mem-multiplier -> (float64)
    idle-in-transaction-session-timeout -> (integer)
    jit -> (boolean)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-sample -> (integer)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (integer)
    log-parameter-max-length-on-error -> (integer)
    log-recovery-conflict-waits -> (boolean)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-statement-sample-rate -> (float64)
    log-temp-files -> (integer)
    log-transaction-sample-rate -> (float64)
    logical-decoding-work-mem -> (integer)
    maintenance-io-concurrency -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-parallel-maintenance-workers -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-slot-wal-keep-size -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    old-snapshot-threshold -> (integer)
    online-analyze-enable -> (boolean)
    parallel-leader-participation -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    pg-trgm-similarity-threshold -> (float64)
    pg-trgm-strict-word-similarity-threshold -> (float64)
    pg-trgm-word-similarity-threshold -> (float64)
    plan-cache-mode -> (struct)
    plantuner-fix-empty-table -> (boolean)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    transform-null-equals -> (boolean)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    vacuum-failsafe-age -> (integer)
    vacuum-multixact-failsafe-age -> (integer)
    wal-keep-size -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-15 -> (struct)
    Configuration for a PostgreSQL 15 cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-insert-scale-factor -> (float64)
    autovacuum-vacuum-insert-threshold -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-connection-check-interval -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-async-append -> (boolean)
    enable-bitmapscan -> (boolean)
    enable-gathermerge -> (boolean)
    enable-group-by-reordering -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-incremental-sort -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-memoize -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-parallel-append -> (boolean)
    enable-parallel-hash -> (boolean)
    enable-partition-pruning -> (boolean)
    enable-partitionwise-aggregate -> (boolean)
    enable-partitionwise-join -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    hash-mem-multiplier -> (float64)
    idle-in-transaction-session-timeout -> (integer)
    jit -> (boolean)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-sample -> (integer)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (integer)
    log-parameter-max-length-on-error -> (integer)
    log-recovery-conflict-waits -> (boolean)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-statement-sample-rate -> (float64)
    log-temp-files -> (integer)
    log-transaction-sample-rate -> (float64)
    logical-decoding-work-mem -> (integer)
    maintenance-io-concurrency -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-parallel-maintenance-workers -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-slot-wal-keep-size -> (integer)
    max-stack-depth -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    old-snapshot-threshold -> (integer)
    parallel-leader-participation -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    pg-trgm-similarity-threshold -> (float64)
    pg-trgm-strict-word-similarity-threshold -> (float64)
    pg-trgm-word-similarity-threshold -> (float64)
    plan-cache-mode -> (struct)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    transform-null-equals -> (boolean)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    vacuum-failsafe-age -> (integer)
    vacuum-multixact-failsafe-age -> (integer)
    wal-keep-size -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-15-1c -> (struct)
    Configuration for a PostgreSQL 15 1C cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-insert-scale-factor -> (float64)
    autovacuum-vacuum-insert-threshold -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-connection-check-interval -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-async-append -> (boolean)
    enable-bitmapscan -> (boolean)
    enable-gathermerge -> (boolean)
    enable-group-by-reordering -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-incremental-sort -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-memoize -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-parallel-append -> (boolean)
    enable-parallel-hash -> (boolean)
    enable-partition-pruning -> (boolean)
    enable-partitionwise-aggregate -> (boolean)
    enable-partitionwise-join -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    force-parallel-mode -> (struct)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    hash-mem-multiplier -> (float64)
    idle-in-transaction-session-timeout -> (integer)
    jit -> (boolean)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-sample -> (integer)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (integer)
    log-parameter-max-length-on-error -> (integer)
    log-recovery-conflict-waits -> (boolean)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-statement-sample-rate -> (float64)
    log-temp-files -> (integer)
    log-transaction-sample-rate -> (float64)
    logical-decoding-work-mem -> (integer)
    maintenance-io-concurrency -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-parallel-maintenance-workers -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-slot-wal-keep-size -> (integer)
    max-stack-depth -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    old-snapshot-threshold -> (integer)
    online-analyze-enable -> (boolean)
    parallel-leader-participation -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    pg-trgm-similarity-threshold -> (float64)
    pg-trgm-strict-word-similarity-threshold -> (float64)
    pg-trgm-word-similarity-threshold -> (float64)
    plan-cache-mode -> (struct)
    plantuner-fix-empty-table -> (boolean)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    transform-null-equals -> (boolean)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    vacuum-failsafe-age -> (integer)
    vacuum-multixact-failsafe-age -> (integer)
    wal-keep-size -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-16 -> (struct)
    Configuration for a PostgreSQL 16 cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-insert-scale-factor -> (float64)
    autovacuum-vacuum-insert-threshold -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-connection-check-interval -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    debug-parallel-query -> (struct)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-async-append -> (boolean)
    enable-bitmapscan -> (boolean)
    enable-gathermerge -> (boolean)
    enable-group-by-reordering -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-incremental-sort -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-memoize -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-parallel-append -> (boolean)
    enable-parallel-hash -> (boolean)
    enable-partition-pruning -> (boolean)
    enable-partitionwise-aggregate -> (boolean)
    enable-partitionwise-join -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    hash-mem-multiplier -> (float64)
    idle-in-transaction-session-timeout -> (integer)
    jit -> (boolean)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-sample -> (integer)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (integer)
    log-parameter-max-length-on-error -> (integer)
    log-recovery-conflict-waits -> (boolean)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-statement-sample-rate -> (float64)
    log-temp-files -> (integer)
    log-transaction-sample-rate -> (float64)
    logical-decoding-work-mem -> (integer)
    maintenance-io-concurrency -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-parallel-maintenance-workers -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-slot-wal-keep-size -> (integer)
    max-stack-depth -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    old-snapshot-threshold -> (integer)
    parallel-leader-participation -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    pg-trgm-similarity-threshold -> (float64)
    pg-trgm-strict-word-similarity-threshold -> (float64)
    pg-trgm-word-similarity-threshold -> (float64)
    plan-cache-mode -> (struct)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    transform-null-equals -> (boolean)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    vacuum-failsafe-age -> (integer)
    vacuum-multixact-failsafe-age -> (integer)
    wal-keep-size -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-16-1c -> (struct)
    Configuration for a PostgreSQL 16 1C cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-insert-scale-factor -> (float64)
    autovacuum-vacuum-insert-threshold -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-connection-check-interval -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    debug-parallel-query -> (struct)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-async-append -> (boolean)
    enable-bitmapscan -> (boolean)
    enable-gathermerge -> (boolean)
    enable-group-by-reordering -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-incremental-sort -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-memoize -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-parallel-append -> (boolean)
    enable-parallel-hash -> (boolean)
    enable-partition-pruning -> (boolean)
    enable-partitionwise-aggregate -> (boolean)
    enable-partitionwise-join -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    hash-mem-multiplier -> (float64)
    idle-in-transaction-session-timeout -> (integer)
    jit -> (boolean)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-sample -> (integer)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (integer)
    log-parameter-max-length-on-error -> (integer)
    log-recovery-conflict-waits -> (boolean)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-statement-sample-rate -> (float64)
    log-temp-files -> (integer)
    log-transaction-sample-rate -> (float64)
    logical-decoding-work-mem -> (integer)
    maintenance-io-concurrency -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-parallel-maintenance-workers -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-slot-wal-keep-size -> (integer)
    max-stack-depth -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    old-snapshot-threshold -> (integer)
    online-analyze-enable -> (boolean)
    parallel-leader-participation -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    pg-trgm-similarity-threshold -> (float64)
    pg-trgm-strict-word-similarity-threshold -> (float64)
    pg-trgm-word-similarity-threshold -> (float64)
    plan-cache-mode -> (struct)
    plantuner-fix-empty-table -> (boolean)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    transform-null-equals -> (boolean)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    vacuum-failsafe-age -> (integer)
    vacuum-multixact-failsafe-age -> (integer)
    wal-keep-size -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-17 -> (struct)
    Configuration for a PostgreSQL 17 cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-insert-scale-factor -> (float64)
    autovacuum-vacuum-insert-threshold -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-connection-check-interval -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    debug-parallel-query -> (struct)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-async-append -> (boolean)
    enable-bitmapscan -> (boolean)
    enable-gathermerge -> (boolean)
    enable-group-by-reordering -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-incremental-sort -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-memoize -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-parallel-append -> (boolean)
    enable-parallel-hash -> (boolean)
    enable-partition-pruning -> (boolean)
    enable-partitionwise-aggregate -> (boolean)
    enable-partitionwise-join -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    hash-mem-multiplier -> (float64)
    idle-in-transaction-session-timeout -> (integer)
    jit -> (boolean)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-sample -> (integer)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (integer)
    log-parameter-max-length-on-error -> (integer)
    log-recovery-conflict-waits -> (boolean)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-statement-sample-rate -> (float64)
    log-temp-files -> (integer)
    log-transaction-sample-rate -> (float64)
    logical-decoding-work-mem -> (integer)
    maintenance-io-concurrency -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-logical-replication-workers -> (integer)
    max-parallel-maintenance-workers -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-replication-slots -> (integer)
    max-slot-wal-keep-size -> (integer)
    max-stack-depth -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-senders -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    parallel-leader-participation -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    pg-trgm-similarity-threshold -> (float64)
    pg-trgm-strict-word-similarity-threshold -> (float64)
    pg-trgm-word-similarity-threshold -> (float64)
    plan-cache-mode -> (struct)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    track-commit-timestamp -> (boolean)
    transform-null-equals -> (boolean)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    vacuum-failsafe-age -> (integer)
    vacuum-multixact-failsafe-age -> (integer)
    wal-keep-size -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-17-1c -> (struct)
    Configuration for a PostgreSQL 17 1C cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-insert-scale-factor -> (float64)
    autovacuum-vacuum-insert-threshold -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-connection-check-interval -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    debug-parallel-query -> (struct)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-async-append -> (boolean)
    enable-bitmapscan -> (boolean)
    enable-gathermerge -> (boolean)
    enable-group-by-reordering -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-incremental-sort -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-memoize -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-parallel-append -> (boolean)
    enable-parallel-hash -> (boolean)
    enable-partition-pruning -> (boolean)
    enable-partitionwise-aggregate -> (boolean)
    enable-partitionwise-join -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    hash-mem-multiplier -> (float64)
    idle-in-transaction-session-timeout -> (integer)
    jit -> (boolean)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-sample -> (integer)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (integer)
    log-parameter-max-length-on-error -> (integer)
    log-recovery-conflict-waits -> (boolean)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-statement-sample-rate -> (float64)
    log-temp-files -> (integer)
    log-transaction-sample-rate -> (float64)
    logical-decoding-work-mem -> (integer)
    maintenance-io-concurrency -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-logical-replication-workers -> (integer)
    max-parallel-maintenance-workers -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-replication-slots -> (integer)
    max-slot-wal-keep-size -> (integer)
    max-stack-depth -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-senders -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    online-analyze-enable -> (boolean)
    parallel-leader-participation -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    pg-trgm-similarity-threshold -> (float64)
    pg-trgm-strict-word-similarity-threshold -> (float64)
    pg-trgm-word-similarity-threshold -> (float64)
    plan-cache-mode -> (struct)
    plantuner-fix-empty-table -> (boolean)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    track-commit-timestamp -> (boolean)
    transform-null-equals -> (boolean)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    vacuum-failsafe-age -> (integer)
    vacuum-multixact-failsafe-age -> (integer)
    wal-keep-size -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-18 -> (struct)
    Configuration for a PostgreSQL 18 cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-insert-scale-factor -> (float64)
    autovacuum-vacuum-insert-threshold -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-connection-check-interval -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    debug-parallel-query -> (struct)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-async-append -> (boolean)
    enable-bitmapscan -> (boolean)
    enable-gathermerge -> (boolean)
    enable-group-by-reordering -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-incremental-sort -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-memoize -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-parallel-append -> (boolean)
    enable-parallel-hash -> (boolean)
    enable-partition-pruning -> (boolean)
    enable-partitionwise-aggregate -> (boolean)
    enable-partitionwise-join -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    hash-mem-multiplier -> (float64)
    idle-in-transaction-session-timeout -> (integer)
    jit -> (boolean)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-sample -> (integer)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (integer)
    log-parameter-max-length-on-error -> (integer)
    log-recovery-conflict-waits -> (boolean)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-statement-sample-rate -> (float64)
    log-temp-files -> (integer)
    log-transaction-sample-rate -> (float64)
    logical-decoding-work-mem -> (integer)
    maintenance-io-concurrency -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-logical-replication-workers -> (integer)
    max-parallel-maintenance-workers -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-replication-slots -> (integer)
    max-slot-wal-keep-size -> (integer)
    max-stack-depth -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-senders -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    parallel-leader-participation -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    pg-trgm-similarity-threshold -> (float64)
    pg-trgm-strict-word-similarity-threshold -> (float64)
    pg-trgm-word-similarity-threshold -> (float64)
    plan-cache-mode -> (struct)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    track-commit-timestamp -> (boolean)
    transform-null-equals -> (boolean)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    vacuum-failsafe-age -> (integer)
    vacuum-multixact-failsafe-age -> (integer)
    wal-keep-size -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
  postgresql-config-18-1c -> (struct)
    Configuration for a PostgreSQL 18 1C cluster.
    archive-timeout -> (integer)
    array-nulls -> (boolean)
    auto-explain-log-analyze -> (boolean)
    auto-explain-log-buffers -> (boolean)
    auto-explain-log-format -> (struct)
    auto-explain-log-min-duration -> (integer)
    auto-explain-log-nested-statements -> (boolean)
    auto-explain-log-timing -> (boolean)
    auto-explain-log-triggers -> (boolean)
    auto-explain-log-verbose -> (boolean)
    auto-explain-sample-rate -> (float64)
    autovacuum-analyze-scale-factor -> (float64)
    autovacuum-max-workers -> (integer)
    autovacuum-naptime -> (integer)
    autovacuum-vacuum-cost-delay -> (integer)
    autovacuum-vacuum-cost-limit -> (integer)
    autovacuum-vacuum-insert-scale-factor -> (float64)
    autovacuum-vacuum-insert-threshold -> (integer)
    autovacuum-vacuum-scale-factor -> (float64)
    autovacuum-work-mem -> (integer)
    backend-flush-after -> (integer)
    backslash-quote -> (struct)
    bgwriter-delay -> (integer)
    bgwriter-flush-after -> (integer)
    bgwriter-lru-maxpages -> (integer)
    bgwriter-lru-multiplier -> (float64)
    bytea-output -> (struct)
    checkpoint-completion-target -> (float64)
    checkpoint-flush-after -> (integer)
    checkpoint-timeout -> (integer)
    client-connection-check-interval -> (integer)
    client-min-messages -> (struct)
    constraint-exclusion -> (struct)
    cursor-tuple-fraction -> (float64)
    deadlock-timeout -> (integer)
    debug-parallel-query -> (struct)
    default-statistics-target -> (integer)
    default-transaction-isolation -> (struct)
    default-transaction-read-only -> (boolean)
    default-with-oids -> (boolean)
    effective-cache-size -> (integer)
    effective-io-concurrency -> (integer)
    enable-async-append -> (boolean)
    enable-bitmapscan -> (boolean)
    enable-gathermerge -> (boolean)
    enable-group-by-reordering -> (boolean)
    enable-hashagg -> (boolean)
    enable-hashjoin -> (boolean)
    enable-incremental-sort -> (boolean)
    enable-indexonlyscan -> (boolean)
    enable-indexscan -> (boolean)
    enable-material -> (boolean)
    enable-memoize -> (boolean)
    enable-mergejoin -> (boolean)
    enable-nestloop -> (boolean)
    enable-parallel-append -> (boolean)
    enable-parallel-hash -> (boolean)
    enable-partition-pruning -> (boolean)
    enable-partitionwise-aggregate -> (boolean)
    enable-partitionwise-join -> (boolean)
    enable-seqscan -> (boolean)
    enable-sort -> (boolean)
    enable-tidscan -> (boolean)
    escape-string-warning -> (boolean)
    exit-on-error -> (boolean)
    from-collapse-limit -> (integer)
    geqo -> (boolean)
    geqo-effort -> (integer)
    geqo-generations -> (integer)
    geqo-pool-size -> (integer)
    geqo-seed -> (float64)
    geqo-selection-bias -> (float64)
    geqo-threshold -> (integer)
    gin-pending-list-limit -> (integer)
    hash-mem-multiplier -> (float64)
    idle-in-transaction-session-timeout -> (integer)
    jit -> (boolean)
    join-collapse-limit -> (integer)
    lo-compat-privileges -> (boolean)
    lock-timeout -> (integer)
    log-autovacuum-min-duration -> (integer)
    log-checkpoints -> (boolean)
    log-connections -> (boolean)
    log-disconnections -> (boolean)
    log-duration -> (boolean)
    log-error-verbosity -> (struct)
    log-lock-waits -> (boolean)
    log-min-duration-sample -> (integer)
    log-min-duration-statement -> (integer)
    log-min-error-statement -> (struct)
    log-min-messages -> (struct)
    log-parameter-max-length -> (integer)
    log-parameter-max-length-on-error -> (integer)
    log-recovery-conflict-waits -> (boolean)
    log-replication-commands -> (boolean)
    log-statement -> (struct)
    log-statement-sample-rate -> (float64)
    log-temp-files -> (integer)
    log-transaction-sample-rate -> (float64)
    logical-decoding-work-mem -> (integer)
    maintenance-io-concurrency -> (integer)
    maintenance-work-mem -> (integer)
    max-connections -> (integer)
    max-locks-per-transaction -> (integer)
    max-logical-replication-workers -> (integer)
    max-parallel-maintenance-workers -> (integer)
    max-parallel-workers -> (integer)
    max-parallel-workers-per-gather -> (integer)
    max-pred-locks-per-transaction -> (integer)
    max-prepared-transactions -> (integer)
    max-replication-slots -> (integer)
    max-slot-wal-keep-size -> (integer)
    max-stack-depth -> (integer)
    max-standby-archive-delay -> (integer)
    max-standby-streaming-delay -> (integer)
    max-wal-senders -> (integer)
    max-wal-size -> (integer)
    max-worker-processes -> (integer)
    min-wal-size -> (integer)
    online-analyze-enable -> (boolean)
    parallel-leader-participation -> (boolean)
    password-encryption -> (struct)
    pg-hint-plan-debug-print -> (struct)
    pg-hint-plan-enable-hint -> (boolean)
    pg-hint-plan-enable-hint-table -> (boolean)
    pg-hint-plan-message-level -> (struct)
    pg-qualstats-enabled -> (boolean)
    pg-qualstats-max -> (integer)
    pg-qualstats-resolve-oids -> (boolean)
    pg-qualstats-sample-rate -> (float64)
    pg-qualstats-track-constants -> (boolean)
    pg-trgm-similarity-threshold -> (float64)
    pg-trgm-strict-word-similarity-threshold -> (float64)
    pg-trgm-word-similarity-threshold -> (float64)
    plan-cache-mode -> (struct)
    plantuner-fix-empty-table -> (boolean)
    quote-all-identifiers -> (boolean)
    random-page-cost -> (float64)
    row-security -> (boolean)
    search-path -> (string)
    seq-page-cost -> (float64)
    session-duration-timeout -> (integer)
    shared-buffers -> (integer)
    shared-preload-libraries -> ([]struct)
    standard-conforming-strings -> (boolean)
    statement-timeout -> (integer)
    synchronize-seqscans -> (boolean)
    synchronous-commit -> (struct)
    temp-buffers -> (integer)
    temp-file-limit -> (integer)
    timezone -> (string)
    track-activity-query-size -> (integer)
    track-commit-timestamp -> (boolean)
    transform-null-equals -> (boolean)
    vacuum-cost-delay -> (integer)
    vacuum-cost-limit -> (integer)
    vacuum-cost-page-dirty -> (integer)
    vacuum-cost-page-hit -> (integer)
    vacuum-cost-page-miss -> (integer)
    vacuum-failsafe-age -> (integer)
    vacuum-multixact-failsafe-age -> (integer)
    wal-keep-size -> (integer)
    wal-level -> (struct)
    work-mem -> (integer)
    xmlbinary -> (struct)
    xmloption -> (struct)
``` ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster ||
|| `--description` | `string`

New description of the PostgreSQL cluster. ||
|| `--labels` | `map<string><string>`

Custom labels for the PostgreSQL cluster as '' key:value '' pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get] method, then send an [ClusterService.Update] request with the new label added to the set. ||
|| `--maintenance-window` | `shorthand/json`

New maintenance window settings for the cluster.

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

New name for the cluster. ||
|| `--network-id` | `string`

ID of the network to move the cluster to. ||
|| `--security-group-ids` | `[]string`

User security groups ||
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