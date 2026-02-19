---
editable: false
noIndex: true
---

# yc beta managed-postgresql cluster create

Creates a PostgreSQL cluster in the specified folder.

#### Command Usage

Syntax:

`yc beta managed-postgresql cluster create <FOLDER-ID>`

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

Configuration and resources for hosts that should be created for the PostgreSQL cluster.

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
|| `--database-specs` | `shorthand/json`

Descriptions of databases to be created in the PostgreSQL cluster.

Shorthand Syntax:

```hcl
[
  {
    deletion-protection = boolean,
    extensions = [
      {
        name = string,
        version = string
      }, ...
    ],
    lc-collate = string,
    lc-ctype = string,
    name = string,
    owner = string,
    template-db = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "deletion-protection": "boolean",
    "extensions": [
      {
        "name": "string",
        "version": "string"
      }, ...
    ],
    "lc-collate": "string",
    "lc-ctype": "string",
    "name": "string",
    "owner": "string",
    "template-db": "string"
  }, ...
]
```

Fields:

```
deletion-protection -> (boolean)
  Deletion Protection inhibits deletion of the database Default value: 'unspecified' (inherits cluster's deletion_protection)
extensions -> ([]struct)
  PostgreSQL extensions to be enabled for the database.
  name -> (string)
    Name of the extension, e.g. 'pg_trgm' or 'pg_btree'. Extensions supported by Managed Service for PostgreSQL are documentation.
  version -> (string)
    Version of the extension. The setting is deprecated and has no effect.
lc-collate -> (string)
  POSIX locale for string sorting order. Can only be set at creation time.
lc-ctype -> (string)
  POSIX locale for character classification. Can only be set at creation time.
name -> (string)
  Name of the PostgreSQL database. 1-63 characters long.
owner -> (string)
  Name of the user to be assigned as the owner of the database. To get the list of available PostgreSQL users, make a [UserService.List] request.
template-db -> (string)
  Name of the PostgreSQL database template.
``` ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster ||
|| `--description` | `string`

Description of the PostgreSQL cluster. ||
|| `--disk-encryption-key-id` | `string`

ID of the key to encrypt cluster disks. ||
|| `--environment` | `enum`

Deployment environment of the PostgreSQL cluster. Possible Values: 'production', 'prestable' ||
|| `--folder-id` | `string`

ID of the folder to create the PostgreSQL cluster in. ||
|| `--host-group-ids` | `[]string`

Host groups hosting VMs of the cluster. ||
|| `--host-specs` | `shorthand/json`

Individual configurations for hosts that should be created for the PostgreSQL cluster.

Shorthand Syntax:

```hcl
[
  {
    assign-public-ip = boolean,
    config-spec = {
      postgresql-config = postgresql-config-10={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        old-snapshot-threshold = integer,
        operator-precedence-warning = boolean,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        replacement-sort-tuples = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-10-1c={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        old-snapshot-threshold = integer,
        operator-precedence-warning = boolean,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        replacement-sort-tuples = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-11={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        old-snapshot-threshold = integer,
        operator-precedence-warning = boolean,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-11-1c={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        old-snapshot-threshold = integer,
        operator-precedence-warning = boolean,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-12={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        old-snapshot-threshold = integer,
        operator-precedence-warning = boolean,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-12-1c={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        old-snapshot-threshold = integer,
        operator-precedence-warning = boolean,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-13={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        old-snapshot-threshold = integer,
        operator-precedence-warning = boolean,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-13-1c={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        old-snapshot-threshold = integer,
        operator-precedence-warning = boolean,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-14={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        old-snapshot-threshold = integer,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-14-1c={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        old-snapshot-threshold = integer,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-15={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        old-snapshot-threshold = integer,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-15-1c={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        old-snapshot-threshold = integer,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-16={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = integer,
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        old-snapshot-threshold = integer,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-16-1c={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = integer,
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        old-snapshot-threshold = integer,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-17={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = integer,
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-17-1c={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = integer,
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-18={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = integer,
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-18-1c={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
        debug-parallel-query = DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS,
        default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
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
        log-min-error-statement = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
        log-temp-files = integer,
        max-locks-per-transaction = integer,
        max-parallel-workers = integer,
        max-parallel-workers-per-gather = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        timezone = string,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      } | postgresql-config-9-6={
        array-nulls = boolean,
        backend-flush-after = integer,
        backslash-quote = BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING,
        bytea-output = BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED,
        client-min-messages = LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC,
        constraint-exclusion = CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION,
        cursor-tuple-fraction = float64,
        deadlock-timeout = integer,
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
        max-locks-per-transaction = integer,
        max-pred-locks-per-transaction = integer,
        max-standby-streaming-delay = integer,
        old-snapshot-threshold = integer,
        operator-precedence-warning = boolean,
        quote-all-identifiers = boolean,
        random-page-cost = float64,
        recovery-min-apply-delay = integer,
        replacement-sort-tuples = integer,
        row-security = boolean,
        search-path = string,
        seq-page-cost = float64,
        shared-buffers = integer,
        sql-inheritance = boolean,
        standard-conforming-strings = boolean,
        statement-timeout = integer,
        synchronize-seqscans = boolean,
        temp-buffers = integer,
        temp-file-limit = integer,
        transform-null-equals = boolean,
        work-mem = integer,
        xmlbinary = XML_BINARY_BASE64|XML_BINARY_HEX,
        xmloption = XML_OPTION_DOCUMENT|XML_OPTION_CONTENT
      }
    },
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
    "config-spec": {
      "postgresql-config": {
        "postgresql-config-10": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "old-snapshot-threshold": "integer",
          "operator-precedence-warning": "boolean",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "replacement-sort-tuples": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-10-1c": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "old-snapshot-threshold": "integer",
          "operator-precedence-warning": "boolean",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "replacement-sort-tuples": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-11": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "old-snapshot-threshold": "integer",
          "operator-precedence-warning": "boolean",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-11-1c": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "old-snapshot-threshold": "integer",
          "operator-precedence-warning": "boolean",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-12": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "old-snapshot-threshold": "integer",
          "operator-precedence-warning": "boolean",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-12-1c": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "old-snapshot-threshold": "integer",
          "operator-precedence-warning": "boolean",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-13": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "old-snapshot-threshold": "integer",
          "operator-precedence-warning": "boolean",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-13-1c": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "old-snapshot-threshold": "integer",
          "operator-precedence-warning": "boolean",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-14": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "old-snapshot-threshold": "integer",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-14-1c": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "old-snapshot-threshold": "integer",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-15": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "old-snapshot-threshold": "integer",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-15-1c": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "old-snapshot-threshold": "integer",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-16": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "integer",
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "old-snapshot-threshold": "integer",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-16-1c": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "integer",
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "old-snapshot-threshold": "integer",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-17": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "integer",
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-17-1c": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "integer",
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-18": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "integer",
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-18-1c": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
          "debug-parallel-query": "DEBUG_PARALLEL_QUERY_ON|DEBUG_PARALLEL_QUERY_OFF|DEBUG_PARALLEL_QUERY_REGRESS",
          "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
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
          "log-min-error-statement": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_INFO|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
          "log-temp-files": "integer",
          "max-locks-per-transaction": "integer",
          "max-parallel-workers": "integer",
          "max-parallel-workers-per-gather": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "timezone": "string",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        },
        "postgresql-config-9-6": {
          "array-nulls": "boolean",
          "backend-flush-after": "integer",
          "backslash-quote": "BACKSLASH_QUOTE|BACKSLASH_QUOTE_ON|BACKSLASH_QUOTE_OFF|BACKSLASH_QUOTE_SAFE_ENCODING",
          "bytea-output": "BYTEA_OUTPUT_HEX|BYTEA_OUTPUT_ESCAPED",
          "client-min-messages": "LOG_LEVEL_DEBUG5|LOG_LEVEL_DEBUG4|LOG_LEVEL_DEBUG3|LOG_LEVEL_DEBUG2|LOG_LEVEL_DEBUG1|LOG_LEVEL_LOG|LOG_LEVEL_NOTICE|LOG_LEVEL_WARNING|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL|LOG_LEVEL_PANIC",
          "constraint-exclusion": "CONSTRAINT_EXCLUSION_ON|CONSTRAINT_EXCLUSION_OFF|CONSTRAINT_EXCLUSION_PARTITION",
          "cursor-tuple-fraction": "float64",
          "deadlock-timeout": "integer",
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
          "max-locks-per-transaction": "integer",
          "max-pred-locks-per-transaction": "integer",
          "max-standby-streaming-delay": "integer",
          "old-snapshot-threshold": "integer",
          "operator-precedence-warning": "boolean",
          "quote-all-identifiers": "boolean",
          "random-page-cost": "float64",
          "recovery-min-apply-delay": "integer",
          "replacement-sort-tuples": "integer",
          "row-security": "boolean",
          "search-path": "string",
          "seq-page-cost": "float64",
          "shared-buffers": "integer",
          "sql-inheritance": "boolean",
          "standard-conforming-strings": "boolean",
          "statement-timeout": "integer",
          "synchronize-seqscans": "boolean",
          "temp-buffers": "integer",
          "temp-file-limit": "integer",
          "transform-null-equals": "boolean",
          "work-mem": "integer",
          "xmlbinary": "XML_BINARY_BASE64|XML_BINARY_HEX",
          "xmloption": "XML_OPTION_DOCUMENT|XML_OPTION_CONTENT"
        }
      }
    },
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
  Whether the host should get a public IP address on creation. After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with [assign_public_ip] set as needed. Possible values: * false - don't assign a public IP to the host. * true - the host should have a public IP address.
config-spec -> (struct)
  Configuration of a PostgreSQL server for the host.
  postgresql-config -> (oneof<postgresql-config-10|postgresql-config-10-1c|postgresql-config-11|postgresql-config-11-1c|postgresql-config-12|postgresql-config-12-1c|postgresql-config-13|postgresql-config-13-1c|postgresql-config-14|postgresql-config-14-1c|postgresql-config-15|postgresql-config-15-1c|postgresql-config-16|postgresql-config-16-1c|postgresql-config-17|postgresql-config-17-1c|postgresql-config-18|postgresql-config-18-1c|postgresql-config-9-6>)
    Oneof postgresql-config field
    postgresql-config-9-6 -> (struct)
      Configuration for a host with PostgreSQL 9.6 server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
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
      max-locks-per-transaction -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      old-snapshot-threshold -> (integer)
      operator-precedence-warning -> (boolean)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
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
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-10-1c -> (struct)
      Configuration for a host with PostgreSQL 10 1C server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      old-snapshot-threshold -> (integer)
      operator-precedence-warning -> (boolean)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      replacement-sort-tuples -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-10 -> (struct)
      Configuration for a host with PostgreSQL 10 server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      old-snapshot-threshold -> (integer)
      operator-precedence-warning -> (boolean)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      replacement-sort-tuples -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-11 -> (struct)
      Configuration for a host with PostgreSQL 11 server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      old-snapshot-threshold -> (integer)
      operator-precedence-warning -> (boolean)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-11-1c -> (struct)
      Configuration for a host with PostgreSQL 11 1C server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      old-snapshot-threshold -> (integer)
      operator-precedence-warning -> (boolean)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-12 -> (struct)
      Configuration for a host with PostgreSQL 12 server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      old-snapshot-threshold -> (integer)
      operator-precedence-warning -> (boolean)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-12-1c -> (struct)
      Configuration for a host with PostgreSQL 12 1C server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      old-snapshot-threshold -> (integer)
      operator-precedence-warning -> (boolean)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-13 -> (struct)
      Configuration for a host with PostgreSQL 13 server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      old-snapshot-threshold -> (integer)
      operator-precedence-warning -> (boolean)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-13-1c -> (struct)
      Configuration for a host with PostgreSQL 13 1C server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      old-snapshot-threshold -> (integer)
      operator-precedence-warning -> (boolean)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-14 -> (struct)
      Configuration for a host with PostgreSQL 14 server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      old-snapshot-threshold -> (integer)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-14-1c -> (struct)
      Configuration for a host with PostgreSQL 14 1C server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      old-snapshot-threshold -> (integer)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-15 -> (struct)
      Configuration for a host with PostgreSQL 15 server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      old-snapshot-threshold -> (integer)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-15-1c -> (struct)
      Configuration for a host with PostgreSQL 15 1C server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      old-snapshot-threshold -> (integer)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-16 -> (struct)
      Configuration for a host with PostgreSQL 16 server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      debug-parallel-query -> (struct)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      old-snapshot-threshold -> (integer)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-16-1c -> (struct)
      Configuration for a host with PostgreSQL 16 1C server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      debug-parallel-query -> (struct)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      old-snapshot-threshold -> (integer)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-17 -> (struct)
      Configuration for a host with PostgreSQL 17 1C server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      debug-parallel-query -> (struct)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-17-1c -> (struct)
      Configuration for a host with PostgreSQL 17 1C server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      debug-parallel-query -> (struct)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-18 -> (struct)
      Configuration for a host with PostgreSQL 18 1C server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      debug-parallel-query -> (struct)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
    postgresql-config-18-1c -> (struct)
      Configuration for a host with PostgreSQL 18 1C server deployed.
      array-nulls -> (boolean)
      backend-flush-after -> (integer)
      backslash-quote -> (struct)
      bytea-output -> (struct)
      client-min-messages -> (struct)
      constraint-exclusion -> (struct)
      cursor-tuple-fraction -> (float64)
      deadlock-timeout -> (integer)
      debug-parallel-query -> (struct)
      default-transaction-isolation -> (struct)
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
      max-locks-per-transaction -> (integer)
      max-parallel-workers -> (integer)
      max-parallel-workers-per-gather -> (integer)
      max-pred-locks-per-transaction -> (integer)
      max-standby-streaming-delay -> (integer)
      quote-all-identifiers -> (boolean)
      random-page-cost -> (float64)
      recovery-min-apply-delay -> (integer)
      row-security -> (boolean)
      search-path -> (string)
      seq-page-cost -> (float64)
      shared-buffers -> (integer)
      standard-conforming-strings -> (boolean)
      statement-timeout -> (integer)
      synchronize-seqscans -> (boolean)
      temp-buffers -> (integer)
      temp-file-limit -> (integer)
      timezone -> (string)
      transform-null-equals -> (boolean)
      work-mem -> (integer)
      xmlbinary -> (struct)
      xmloption -> (struct)
priority -> (integer)
  Priority of the host as a replica. A higher value corresponds to higher priority. The host with the highest priority is the synchronous replica. All others are asynchronous. The synchronous replica replaces the master when needed. When a replica becomes the master, its priority is ignored.
replication-source -> (string)
  [Host.name] of the host to be used as the replication source (for cascading replication).
subnet-id -> (string)
  ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id].
zone-id -> (string)
  ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request.
``` ||
|| `--labels` | `map<string><string>`

Custom labels for the PostgreSQL cluster as '' key:value '' pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". ||
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

Name of the PostgreSQL cluster. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the network to create the cluster in. ||
|| `--retention-policies` | `shorthand/json`

Backup long-term retention policies setting.

Shorthand Syntax:

```hcl
[
  {
    cron = {
      day-of-month = string,
      day-of-week = string,
      month = string
    },
    description = string,
    policy-name = string,
    retain-for-days = integer
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "cron": {
      "day-of-month": "string",
      "day-of-week": "string",
      "month": "string"
    },
    "description": "string",
    "policy-name": "string",
    "retain-for-days": "integer"
  }, ...
]
```

Fields:

```
cron -> (struct)
  CronTab schedule.
  day-of-month -> (string)
  day-of-week -> (string)
  month -> (string)
description -> (string)
  Human-readable description.
policy-name -> (string)
  Required. Policy name.
retain-for-days -> (integer)
  Retention duration.
``` ||
|| `--security-group-ids` | `[]string`

User security groups ||
|| `--user-specs` | `shorthand/json`

Descriptions of database users to be created in the PostgreSQL cluster.

Shorthand Syntax:

```hcl
[
  {
    auth-method = AUTH_METHOD_PASSWORD|AUTH_METHOD_IAM,
    conn-limit = integer,
    deletion-protection = boolean,
    generate-password = boolean,
    grants = string,...,
    login = boolean,
    name = string,
    password = string,
    permissions = [
      {
        database-name = string
      }, ...
    ],
    settings = {
      catchup-timeout = integer,
      default-transaction-isolation = TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE,
      idle-in-transaction-session-timeout = integer,
      lock-timeout = integer,
      log-min-duration-statement = integer,
      log-statement = LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL,
      pgaudit = {
        log = [
          PG_AUDIT_SETTINGS_LOG_READ|PG_AUDIT_SETTINGS_LOG_WRITE|PG_AUDIT_SETTINGS_LOG_FUNCTION|PG_AUDIT_SETTINGS_LOG_ROLE|PG_AUDIT_SETTINGS_LOG_DDL|PG_AUDIT_SETTINGS_LOG_MISC|PG_AUDIT_SETTINGS_LOG_MISC_SET, ...
        ]
      },
      pool-mode = SESSION|TRANSACTION|STATEMENT,
      prepared-statements-pooling = boolean,
      statement-timeout = integer,
      synchronous-commit = SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY,
      temp-file-limit = integer,
      wal-sender-timeout = integer
    },
    user-password-encryption = USER_PASSWORD_ENCRYPTION_MD5|USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "auth-method": "AUTH_METHOD_PASSWORD|AUTH_METHOD_IAM",
    "conn-limit": "integer",
    "deletion-protection": "boolean",
    "generate-password": "boolean",
    "grants": [
      "string", ...
    ],
    "login": "boolean",
    "name": "string",
    "password": "string",
    "permissions": [
      {
        "database-name": "string"
      }, ...
    ],
    "settings": {
      "catchup-timeout": "integer",
      "default-transaction-isolation": "TRANSACTION_ISOLATION_READ_UNCOMMITTED|TRANSACTION_ISOLATION_READ_COMMITTED|TRANSACTION_ISOLATION_REPEATABLE_READ|TRANSACTION_ISOLATION_SERIALIZABLE",
      "idle-in-transaction-session-timeout": "integer",
      "lock-timeout": "integer",
      "log-min-duration-statement": "integer",
      "log-statement": "LOG_STATEMENT_NONE|LOG_STATEMENT_DDL|LOG_STATEMENT_MOD|LOG_STATEMENT_ALL",
      "pgaudit": {
        "log": [
          "PG_AUDIT_SETTINGS_LOG_READ|PG_AUDIT_SETTINGS_LOG_WRITE|PG_AUDIT_SETTINGS_LOG_FUNCTION|PG_AUDIT_SETTINGS_LOG_ROLE|PG_AUDIT_SETTINGS_LOG_DDL|PG_AUDIT_SETTINGS_LOG_MISC|PG_AUDIT_SETTINGS_LOG_MISC_SET", ...
        ]
      },
      "pool-mode": "SESSION|TRANSACTION|STATEMENT",
      "prepared-statements-pooling": "boolean",
      "statement-timeout": "integer",
      "synchronous-commit": "SYNCHRONOUS_COMMIT_ON|SYNCHRONOUS_COMMIT_OFF|SYNCHRONOUS_COMMIT_LOCAL|SYNCHRONOUS_COMMIT_REMOTE_WRITE|SYNCHRONOUS_COMMIT_REMOTE_APPLY",
      "temp-file-limit": "integer",
      "wal-sender-timeout": "integer"
    },
    "user-password-encryption": "USER_PASSWORD_ENCRYPTION_MD5|USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256"
  }, ...
]
```

Fields:

```
auth-method -> (struct)
  Auth method for user
conn-limit -> (integer)
  Maximum number of database connections that should be available to the user. When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the [Cluster.config.postgresql_config_12.effective_config.max_connections] setting. When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only 'N' concurrent connections will be opened, where 'N' is the value of the setting. Minimum value: '10' (default: '50'), when used in session pooling.
deletion-protection -> (boolean)
  Deletion Protection inhibits deletion of the user Default value: 'unspecified' (inherits cluster's deletion_protection)
generate-password -> (boolean)
  Generate password using Connection Manager.
grants -> ([]string)
  A set of roles and privileges that are granted to the user. For more information, see documentation.
login -> (boolean)
  This flag defines whether the user can login to a PostgreSQL database. Default value: 'true' (login is allowed).
name -> (string)
  Name of the PostgreSQL user.
password -> (string)
  Password of the PostgreSQL user.
permissions -> ([]struct)
  Set of permissions to grant to the user to access specific databases.
  database-name -> (string)
    Name of the database that the permission grants access to.
settings -> (struct)
  PostgreSQL settings for the user.
  catchup-timeout -> (integer)
    The connection pooler setting. It determines the maximum allowed replication lag (in seconds). Pooler will reject connections to the replica with a lag above this threshold. It can be useful to prevent application from reading stale data. Default value: 0 Value of '0' disables this mechanism
  default-transaction-isolation -> (struct)
    SQL sets an isolation level for each transaction. This setting defines the default isolation level to be set for all new SQL transactions. For more information, see the PostgreSQL documentation.
  idle-in-transaction-session-timeout -> (integer)
    Sets the maximum allowed idle time, in milliseconds, between queries while in a transaction. The default value is '0', which disables the timeout. For more information, see the PostgreSQL documentation.
  lock-timeout -> (integer)
    The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object. If the wait time is longer than the specified amount, then this statement is aborted. Default value: '0' (no control is enforced, a statement waiting time is unlimited).
  log-min-duration-statement -> (integer)
    This setting controls logging of the duration of statements. The duration of each completed statement will be logged if the statement ran for at least the specified amount of time (in milliseconds). E.g., if this setting's value is set to '500', a statement that took 300 milliseconds to complete will not be logged; on the other hand, the one that took 2000 milliseconds to complete, will be logged. Value of '0' forces PostgreSQL to log the duration of all statements. Value of '-1' (default) disables logging of the duration of statements. For more information, see the PostgreSQL documentation.
  log-statement -> (struct)
    This setting specifies which SQL statements should be logged (on the user level). For more information, see the PostgreSQL documentation.
  pgaudit -> (struct)
    Settings of the PostgreSQL Audit Extension (pgaudit).
    log -> ([]struct)
      Defines which user queries will be written to the audit log. Corresponds to the Pg audit log user setting. The possible values are the following: * PG_AUDIT_SETTINGS_LOG_READ: 'SELECT' and 'COPY' queries are logged if the data source is a relation or query. * PG_AUDIT_SETTINGS_LOG_WRITE: 'INSERT', 'UPDATE', 'DELETE', 'TRUNCATE', and 'COPY' queries are logged if the data target is a relation. * PG_AUDIT_SETTINGS_LOG_FUNCTION: Function invocations and 'DO' sections are logged. * PG_AUDIT_SETTINGS_LOG_ROLE: Statements related to role and privilege management, such as 'GRANT', 'REVOKE', or 'CREATE/ALTER/DROP ROLE', are logged. * PG_AUDIT_SETTINGS_LOG_DDL: Any 'DDL' statements that do not belong to the 'ROLE' class are logged. * PG_AUDIT_SETTINGS_LOG_MISC: Miscellaneous commands, such as 'DISCARD', 'FETCH', 'CHECKPOINT', 'VACUUM', and 'SET', are logged. * PG_AUDIT_SETTINGS_LOG_MISC_SET: Miscellaneous 'SET' commands, e.g., 'SET ROLE', are logged. The default value is PG_AUDIT_SETTINGS_LOG_UNSPECIFIED. In this case, the parameter is not configured.
  pool-mode -> (struct)
    Mode that the connection pooler is working in with specified user. For more information, see the Odyssey documentation.
  prepared-statements-pooling -> (boolean)
    User can use prepared statements with transaction pooling. This requires 'pool_mode' to be set to TRANSACTION. Odyssey documentation.
  statement-timeout -> (integer)
    The maximum time (in milliseconds) to wait for statement. The timeout is measured from the time a command arrives at the server until it is completed by the server. If 'log_min_error_statement' is set to ERROR or lower, the statement that timed out will also be logged. Value of '0' (default) disables the timeout For more information, see the PostgreSQL documentation.
  synchronous-commit -> (struct)
    This setting defines whether DBMS will commit transaction in a synchronous way. When synchronization is enabled, cluster waits for the synchronous operations to be completed prior to reporting 'success' to the client. These operations guarantee different levels of the data safety and visibility in the cluster. For more information, see the PostgreSQL documentation.
  temp-file-limit -> (integer)
    The maximum storage space size (in kilobytes) that a single process can use to create temporary files. If a transaction exceeds this limit during execution, it will be aborted. A huge query may not fit into a server's RAM, therefore PostgreSQL will use some storage to store and execute such a query. Too big queries can make excessive use of the storage system, effectively making other quieries to run slow. This setting prevents execution of a big queries that can influence other queries by limiting size of temporary files.
  wal-sender-timeout -> (integer)
    The maximum time (in milliseconds) to wait for WAL replication (can be set only for PostgreSQL 12+) Terminate replication connections that are inactive for longer than this amount of time. Default value: '60000' (60 seconds). Value of '0' disables the timeout mechanism. For more information, see the PostgreSQL documentation.
user-password-encryption -> (struct)
  Password-based authentication method for user. Possible values are '' USER_PASSWORD_ENCRYPTION_MD5 '' or '' USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256 ''. The default is '' password_encryption '' setting for cluster.
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