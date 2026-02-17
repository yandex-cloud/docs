---
editable: false
noIndex: true
---

# yc beta managed-postgresql cluster add-hosts

Creates new hosts for a cluster.

#### Command Usage

Syntax:

`yc beta managed-postgresql cluster add-hosts <CLUSTER-ID>`

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
|| `--cluster-id` | `string`

ID of the PostgreSQL cluster to add hosts to. To get the PostgreSQL cluster ID, use a [ClusterService.List] request. ||
|| `--host-specs` | `shorthand/json`

Configurations for PostgreSQL hosts that should be added to the cluster.

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