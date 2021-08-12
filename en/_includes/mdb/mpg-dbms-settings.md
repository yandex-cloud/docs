- **Archive timeout**{#setting-archive-timeout} {{ tag-all }}

  Period (in milliseconds) for archiving the {{ PG }} transaction log.

  The minimum value is `10000` and the maximum value is `86400000`. Defaults to `30000`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-ARCHIVE-TIMEOUT).

- **Array nulls**{#setting-array-nulls} {{ tag-all }}

  Controls recognition of `NULL` as a separate element when inserting an array into a cell with an array data type.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-ARRAY-NULLS).

- **Auto explain log analyze**{#setting-auto-explain-log-analyze} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Enables the `auto_explain` module that logs query execution plan statistics. The module allows you to log execution plans for slow queries automatically, without the `EXPLAIN` command. This is useful for tracking non-optimized queries.

  The `auto_explain` module is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log buffers**{#setting-auto-explain-log-buffers} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Enables output of the {{ PG }} buffer usage statistics using the `auto_explain` module. This parameter is similar to `BUFFERS` in the `EXPLAIN` command. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  This setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log min duration**{#setting-auto-explain-log-min-duration} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  The minimum query execution time (in milliseconds) when logging is enabled in the `auto_explain` module. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  The minimum value is `-1` (logging disabled) and the maximum value is `2147483647`. Defaults to `-1`. When the value is `0`, execution plans for all the queries are logged regardless of their execution time.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log nested statements**{#setting-auto-explain-log-nested-statements} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Enables logging of nested statements inside SQL functions in the `auto_explain` module. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  This setting is disabled by default (execution plans are logged for top-level statements).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log timing**{#setting-auto-explain-log-timing} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Enables logging of timing information for the query execution plan steps in the `auto_explain` module. It's similar to the `TIMING` parameter in the `EXPLAIN` command. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  This setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log triggers**{#setting-auto-explain-log-triggers} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Enables output of the trigger execution statistics in the `auto_explain` module. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  This setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log verbose**{#setting-auto-explain-log-verbose} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Enables verbose logging in the `auto_explain` module. It's similar to the `VERBOSE` parameter in the `EXPLAIN` command. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  This setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain sample rate**{#setting-auto-explain-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Fraction of queries per session that are logged using the `auto_explain` module. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  The minimum value is `0.0` (no queries are logged) and the maximum value is `1.0` (all queries are logged). Defaults to `1.0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Autovacuum analyze scale factor**{#setting-autovacuum-analyze-scale-factor} {{ tag-all }}

  Fraction of changed or deleted records in the table that, when reached, triggers [autovacuum](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) to start the `ANALYZE` statistics collection command.

  The minimum value is `0.0` and the maximum value is `1.0`. Defaults to `0.0001`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-ANALYZE-SCALE-FACTOR).

- **Autovacuum max workers**{#setting-autovacuum-max-workers} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-cli }}

  The maximum number of autovacuum worker processes running in parallel. A worker runs periodically for each DB, determines the table records marked for deletion, and deletes them.

  The minimum value is `1` and the maximum value is `32`. For this setting, the default value depends on the selected [host class](../../managed-postgresql/concepts/instance-types.md).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-MAX-WORKERS).

- **Autovacuum naptime**{#setting-autovacuum-naptime} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  The minimum interval to start the autovacuum process (in milliseconds). If your data changes frequently, you can increase this interval to avoid overloading your database.

  The minimum value is `1000` and the maximum value is `86400000`. Defaults to `15000`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-NAPTIME).

- **Autovacuum vacuum cost delay**{#setting-autovacuum-vacuum-cost-delay} {{ tag-all }}

  Time (in milliseconds) to freeze the autovacuum process.

  The minimum value is `-1` (the setting is not applied) and the maximum value is `100`. For this setting, the default value depends on the selected [host class](../../managed-postgresql/concepts/instance-types.md).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-COST-DELAY).

- **Autovacuum vacuum cost limit**{#setting-autovacuum-vacuum-cost-limit} {{ tag-all }}

  An integer to define the maximum penalty for the [autovacuum](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) process. It's used to calculate the true "freeze" time of the process: [Autovacuum vacuum cost delay](#setting-autovacuum-vacuum-cost-delay) is divided by this value.

  The minimum value is `-1` (the setting is not applied) and the maximum value is `10000`. For this setting, the default value depends on the selected [host class](../../managed-postgresql/concepts/instance-types.md).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-COST-LIMIT).

- **Autovacuum vacuum scale factor**{#setting-autovacuum-vacuum-scale-factor} {{ tag-all }}

  Fraction of changed or deleted records in the table that, when reached, triggers [autovacuum](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) to start the `VACUUM` cleaning command.

  The minimum value is `0.0` (the setting is not applied) and the maximum value is `1.0`. Defaults to `0.00001`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-SCALE-FACTOR).

- **Autovacuum work mem**{#setting-autovacuum-work-mem} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-cli }}

  The amount of memory (in bytes) allocated to each [autovacuum process](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM).

  The minimum value is `-1` (the setting is not applied) and the maximum value is `2147483647`. Defaults to `-1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-AUTOVACUUM-WORK-MEM).

- **Backend flush after**{#setting-backend-flush-after} {{ tag-all }}

  The maximum amount of data (in kilobytes) that a utility process can write to the OS kernel's page cache. If it is exceeded, the DBMS commands the OS to flush data to the disk. The higher the parameter, the less likely a slowdown on flushing data to the disk using `fsync` (also after a checkpoint is completed) is.

  The minimum value is `0` (the setting is not applied) and the maximum value is `2048`. Defaults to `0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BACKEND-FLUSH-AFTER).

- **Backslash quote**{#setting-backslash-quote} {{ tag-all }}

  Controls representation of quotation mark in an SQL string.

  Acceptable values:
   * `backslash_quote` (`BACKSLASH_QUOTE` for Terraform, API, and CLI): Quotation marks can be represented as `\'` (equivalent to `on`).
   * `on` (`BACKSLASH_QUOTE_ON` for Terraform, API, and CLI): Quotation marks can be represented as `\'`.
   * `off` (`BACKSLASH_QUOTE_OFF` for Terraform, API, and CLI): Quotation marks are represented in a usual SQL way (`''`).
   * `safe_encoding` (`BACKSLASH_QUOTE_SAFE_ENCODING` for Terraform, API, and CLI) (default): Quotation marks may be represented as `\'` only for the client encodings that don't use `\` in multi-byte characters.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-BACKSLASH-QUOTE).

- **Bgwriter delay**{#setting-bgwriter-delay} {{ tag-all }}

  Delay (in milliseconds) between activity rounds for the background writer. This process writes new or changed items from the {{ PG }} buffer to the disk. The background writer increases the overall disk I/O load, since it writes the page at each change rather than once per checkpoint.

  The minimum value is `10` and the maximum value is `10000`. Defaults to `200`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-DELAY).

- **Bgwriter flush after**{#setting-bgwriter-flush-after} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  Limits the amount of data processed by the background writer (in kilobytes). When the limit is exceeded, the DBMS commands the OS to flush this data to disk. This parameter limits the amount of dirty data in the kernel's page cache, reducing the likelihood of stalls when an `fsync` command is issued on completing a checkpoint or when the OS writes the data to the disk in the background.

  The minimum value is `0` and the maximum value is `2048`. Defaults to `512`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-FLUSH-AFTER).

- **Bgwriter lru maxpages**{#setting-bgwriter-lru-maxpages} {{ tag-all }}

  Maximum number of {{ PG }} buffers that can be written by the background writer per activity round. The value of zero disables background writing.

  The minimum value is `0` and the maximum value is `1073741823`. Defaults to `100`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-LRU-MAXPAGES).

- **Bgwriter lru multiplier**{#setting-bgwriter-lru-multiplier} {{ tag-all }}

  Multiplies the average need in buffers over the previous rounds to calculate the background writer's buffer need for the next round.

  The minimum value is `0` and the maximum value is `10`. Defaults to `2`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-LRU-MULTIPLIER).

- **Bytea output**{#setting-bytea-output} {{ tag-all }}

  Sets the output format for the [binary string values](https://www.postgresql.org/docs/current/datatype-binary.html) (the `bytea` type):
   * `hex` (`BYTEA_OUTPUT_HEX` for Terraform, API, and CLI) encodes binary data as two hexadecimal digits per byte, for example '`SELECT '\xDEADBEEF';`'.
   * `escape` (`BYTEA_OUTPUT_ESCAPE` for Terraform, API, and CLI) means the standard {{ PG }} format (ASCII characters only).

  Defaults to `hex`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/datatype-binary.html).

- **Checkpoint completion target**{#setting-checkpoint-completion-target} {{ tag-all }}

  Fraction of the interval between checkpoints that defines the maximum duration of writing RAM pages once the checkpoint is issued. For example, if the value is `0.5`, the system will try to complete the checkpoint in about half the interval before the next checkpoint is issued.

  The minimum value is `0.0` and the maximum value is `1.0`. Defaults to `0.5`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/wal-configuration.html)

- **Checkpoint flush after**{#setting-checkpoint-flush-after} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  Size of page cache (in kilobytes) that trigger data flush at checkpoint. The pages beyond the value are flushed to the disk and deleted from the OS page cache.

  The minimum value is `0` and the maximum value is `2048`. Defaults to `256`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-CHECKPOINT-FLUSH-AFTER)

- **Checkpoint timeout**{#setting-checkpoint-timeout} {{ tag-all }}

  The interval between checkpoints (in milliseconds).

  The minimum value is `30000` and the maximum value is `86400000`. Defaults to `300000`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-CHECKPOINT-TIMEOUT).

- **Client min messages**{#setting-client-min-messages} {{ tag-all }}

  The level of logging messages sent to client applications. Acceptable values (in ascending order of severity): `debug5`, `debug4`, `debug3`, `debug2`, `debug1`, `info`, `notice`, `warning`, `error`, `log`, `fatal`, and `panic` (for Terraform, API, CLI `LOG_LEVEL_DEBUG5`, `LOG_LEVEL_DEBUG4`, `LOG_LEVEL_DEBUG3`, `LOG_LEVEL_DEBUG2`, `LOG_LEVEL_DEBUG1`, `LOG_LEVEL_INFO`, `LOG_LEVEL_NOTICE`, `LOG_LEVEL_WARNING`, `LOG_LEVEL_ERROR`, `LOG_LEVEL_LOG`, `LOG_LEVEL_FATAL`, and `LOG_LEVEL_PANIC`).

  Defaults to `NOTICE`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-CLIENT-MIN-MESSAGES).

- **Constraint exclusion**{#setting-constraint-exclusion} {{ tag-all }}

  Allows the query planner to use table constraints to optimize queries.

  Acceptable values:
   * `on` (`CONSTRAINT_EXCLUSION_ON` for Terraform, API, and CLI): Use constraints for all tables.
   * `off` (`CONSTRAINT_EXCLUSION_OFF` for Terraform, API, and CLI): Don't use constraints.
   * `partition` (`CONSTRAINT_EXCLUSION_PARTITION` for Terraform, API, and CLI) (default): Use constraints only for child tables and `UNION ALL` clauses.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-CONSTRAINT-EXCLUSION).

- **Cursor tuple fraction**{#setting-cursor-tuple-fraction} {{ tag-all }}

  Sets the planner's estimate of the fraction of rows to be retrieved via a cursor.

  The minimum value is `0.0` and the maximum value is `1.0`. Defaults to `0.1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-CURSOR-TUPLE-FRACTION).

- **Deadlock timeout**{#setting-deadlock-timeout} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-cli }}

  Waiting time (in milliseconds) before checking for a deadlock condition.

  The minimum value is `1` and the maximum value is `2147483647`. Defaults to `1000`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-locks.html#GUC-DEADLOCK-TIMEOUT).

- **Default statistics target**{#setting-default-statistics-target} {{ tag-all }}

  The maximum number of statistics records for each DB table column. The query planner uses statistics to estimate the number of rows returned by queries to select the best-suiting query plan.

  By increasing the value, you can increase the accuracy of the planner's estimates.

  The minimum value is `1` and the maximum value is `10000`. Defaults to `1000`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-DEFAULT-STATISTICS-TARGET).

- **Default transaction isolation**{#setting-default-transaction-isolation} {{ tag-all }}

  This setting determines the default isolation level to be used for new SQL transactions.

  Acceptable values:
  * `read committed` (`TRANSACTION_ISOLATION_READ_COMMITTED` for Terraform, API, and CLI) (default): The query only sees the rows that were committed before it started.
  * `read uncommitted` (`TRANSACTION_ISOLATION_READ_UNCOMMITTED` for Terraform, API, and CLI): The behavior of this isolation level in {{ PG }} is identical to `read committed`.
  * `repeatable read` (`TRANSACTION_ISOLATION_REPEATABLE_READ` for Terraform, API, and CLI): All queries in the current transaction only see the rows that were committed before the first query to select or update data in this transaction.
  * `serializable` (`TRANSACTION_ISOLATION_SERIALIZABLE` for Terraform, API, and CLI): The strictest isolation level of all those mentioned. The behavior of this isolation level in {{ PG }} is identical to `repeatable read`. However, if the overlap of read and write operations of parallel serializable transactions is incompatible with their serial execution, one of the transactions is rolled back with the "serialization failure" error.

  For more information about isolation levels, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/transaction-iso.html).

  The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Default transaction read only**{#setting-default-transaction-read-only} {{ tag-all }}

  Sets the "read only" mode in each new transaction for regular (non-temporary) tables.

  This setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-DEFAULT-TRANSACTION-READ-ONLY).

- **Default with oids**{#setting-default-with-oids} {{ tag-all }}

  Adds an `OID` column containing a unique row ID. The setting has effect if the table is created:
    * either without specifying `WITH OIDS` and `WITHOUT OIDS`,
    * or using the `SELECT INTO` command.

  Using `OID` is considered deprecated in user tables, so you might need to enable this parameter only for backward compatibility reasons.

  This setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/11/runtime-config-compatible.html#GUC-DEFAULT-WITH-OIDS).

- **Effective cache size**{#setting-effective-cache-size} {{ tag-all }}

  Sets the assumption about the effective size of the disk cache that is available to a single query. It's used by the query planner: with a higher value, index scans are more likely to be used, with a lower value, sequential scans are more likely.

  The minimum value is `0` and the maximum value is `549755813888` (512 GB). Defaults to `107374182400` (100 GB).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-EFFECTIVE-CACHE-SIZE).

- **Effective io concurrency**{#setting-effective-io-concurrency} {{ tag-all }}

  The maximum number of concurrent disk I/O operations for an individual DB session. The higher this number, the more operations {{ PG }} will attempt to initiate in parallel within a session.

  The minimum value is `0` and the maximum value is `1000`. Defaults to `1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-EFFECTIVE-IO-CONCURRENCY).

- **Enable bitmapscan**{#setting-enable-bitmapscan} {{ tag-all }}

  Allows the query planner to use the bitmap-scan plan types, even if this is not explicitly specified in the query. This access method is similar to regular access by index, but occurs in two steps:
   1. The index is scanned (Bitmap Index Scan) and a bitmap is built where the rows to be read by the query are flagged.
   1. The table is scanned (Bitmap Heap Scan). In this case:
      - The pages are read sequentially (this increases the likelihood of using the OS cache).
      - Each page is viewed exactly once.

   This can speed up query execution.

   This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-BITMAPSCAN).

- **Enable hashagg**{#setting-enable-hashagg} {{ tag-all }}

  Allows the planner to build a hash table from the result set, even if this is not explicitly specified in the query. This setting is effective for frequent unsorted queries to large database tables.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-HASHAGG).

- **Enable hashjoin**{#setting-enable-hashjoin} {{ tag-all }}

  Allows the scheduler to `JOIN` tables using the row hash values, even if this is not specified in the query explicitly. This setting is effective when handling large amounts of data and when the tables are not sorted by the join columns.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-HASHJOIN).

- **Enable indexonlyscan**{#setting-enable-indexonlyscan} {{ tag-all }}

  Allows the query planner to use a table index without accessing the data, even if this is not explicitly specified in the query.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/indexes-index-only-scans.html).

- **Enable indexscan**{#setting-enable-indexscan} {{ tag-all }}

  Allows the query planner to use a table index, even if this is not explicitly specified in the query.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-INDEXSCAN).

- **Enable material**{#setting-enable-material} {{ tag-all }}

  Allows the query planner to use materialization.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-MATERIAL).

- **Enable mergejoin**{#setting-enable-mergejoin} {{ tag-all }}

  Allows the query planner to merge `JOIN` operations with tables.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-MERGEJOIN).

- **Enable nestloop**{#setting-enable-nestloop} {{ tag-all }}

  Allows the query planner to use `JOIN` with nested loops. When the setting is disabled, the query planner will use other methods.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-NESTLOOP).

- **Enable parallel append**{#setting-enable-parallel-append} {{ tag-all }}

  Allows the query planner to use parallel-aware append.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-PARALLEL-APPEND).

- **Enable parallel hash**{#setting-enable-parallel-hash} {{ tag-all }}

  Allows the query planner to use of hash-join with parallel hash. The setting only applies when [Enable hashjoin](#setting-enable-hashjoin) is enabled.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-PARALLEL-HASH).

- **Enable partition pruning**{#setting-enable-partition-pruning} {{ tag-all }}

  Allows the query planner to remove unneeded partitions from the query plans for partitioned tables.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/ddl-partitioning.html#DDL-PARTITION-PRUNING).

- **Enable partitionwise aggregate**{#setting-enable-partitionwise-aggregate} {{ tag-all }}

  Allows the query planner to perform grouping or aggregation on partitioned tables separately for each partition.

  This setting is disabled by default (query planner ignores partitions).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-PARTITIONWISE-AGGREGATE).

- **Enable partitionwise join**{#setting-enable-partition-join} {{ tag-all }}

  Allows the query planner to plan queries partitionwise. The setting lets you join partitioned tables by joining their matching partitions.

  This setting is disabled by default (query planner ignores partitions).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-PARTITIONWISE-JOIN).

- **Enable seqscan**{#setting-enable-seqscan} {{ tag-all }}

  Allows the query planner to use sequential table scan plans.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#RUNTIME-CONFIG-QUERY-ENABLE).

- **Enable sort**{#setting-enable-sort} {{ tag-all }}

  Allows the query planner to use explicit sort steps.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-SORT).

- **Enable tidscan**{#setting-enable-tidscan} {{ tag-all }}

  Allows the query planner to scan the system identifiers of entries (CTID, column tuple identifier). This can speed up query execution.

  This setting is enabled by default (the planner scans CTID).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/ddl-system-columns.html).

- **Escape string warning**{#setting-escape-string-warning} {{ tag-all }}

  Enables the DBMS server to issue a warning if it finds `\` in a regular string constant (with the `'...'` syntax) in the query.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-ESCAPE-STRING-WARNING).

- **Exit on error**{#setting-exit-on-error} {{ tag-all }}

  Enables session interruption in case of any error in the query.

  This setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-error-handling.html).

- **Force parallel mode**{#setting-force-parallel-mode} {{ tag-all }}

  Allows parallelizing a query for testing purposes:
   * `off` (`FORCE_PARALLEL_MODE_OFF` for Terraform, API, and CLI): Use parallel mode only when performance increase is expected.
   * `on` (`FORCE_PARALLEL_MODE_ON` for Terraform, API, and CLI): Force parallelize all the queries where it is safe.
   * `regress` (`FORCE_PARALLEL_MODE_REGRESS` for Terraform, API, and CLI): Equivalent to `on`, but the standard output is no different from non-parallel mode.

  Defaults to `off`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-FORCE-PARALLEL-MODE).

- **From collapse limit**{#setting-from-collapse-limit} {{ tag-all }}

  Maximum number of items in the `FROM` list. As long as this number is not exceeded, the query planner will combine nested queries with the upper query. You can decrease planning time with smaller values, but your query plan might be less effective.

  The minimum value is `1` and the maximum value is `2147483647`. Defaults to `8`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-FROM-COLLAPSE-LIMIT).

- **Gin pending list limit**{#setting-gin-list-limit} {{ tag-all }}

  Sets the maximum size of a [GIN index's](https://www.postgresql.org/docs/current/gin-intro.html) pending list. The pending list is used when `fastupdate` mode is enabled. If the pending list exceeds the specified limit, its entries are moved to the index's main GIN data structure in bulk and the list is cleared.

  The minimum value is `64` and the maximum value is `2147483647` (2 GB). Defaults to `4194304`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-GIN-PENDING-LIST-LIMIT).

- **Hash mem multiplier**{#setting-hash-mem-multiplier} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  Defines the maximum amount of memory that operations with hash tables can use The amount is calculated by multiplying the setting value by [Work mem](#setting-work-mem).

  The minimum value is `0.0` and the maximum value is `1000.0`. Defaults to `1.0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-HASH-MEM-MULTIPLIER).

- **Idle in transaction session timeout**{#setting-idle-session-timeout} {{ tag-all }}

  The maximum idle time of an open transaction (in milliseconds). When exceeded, the session running this transaction terminates.

  The minimum value is `0` and the maximum value is `2147483647`. Defaults to `0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-IDLE-IN-TRANSACTION-SESSION-TIMEOUT).

- **Jit**{#setting-jit} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  Enables [JIT compilation of queries](https://www.postgresql.org/docs/current/jit.html) (just-in-time compilation) for {{ PG }}. If this setting is enabled, SQL queries are compiled into machine code directly at runtime. This may speed up execution of complex CPU-intensive queries.

  This setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-JIT).

- **Join collapse limit**{#setting-join-collapse-limit} {{ tag-all }}

  Maximum number of items in the `FROM` list. As long as this value is not exceeded, the planner will move explicit `JOIN` instructions (except `FULL JOIN`) to the list. You can decrease planning time with smaller values, but your query plan might be less effective.

  The minimum value is `1` and the maximum value is `2147483647`. Defaults to `8`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-JOIN-COLLAPSE-LIMIT).

- **Lo compat privileges**{#setting-lo-compat-privileges} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Disables the check of access privileges for large objects. Prior to version 9.0, large objects didn't have access privileges, so any user could read or write them. Don't enable this setting if you need compatibility with {{ PG }} versions below 9.0.

  The setting is disabled by default (privilege checks are enabled).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-LO-COMPAT-PRIVILEGES).

- **Lock timeout**{#setting-lock-timeout} {{ tag-all }}

  Specifies how long to wait for the lock to be released (in milliseconds). Locks can be used for tables, indexes, rows, and other database objects. If the timeout for an operation has expired, the operation is aborted.

  The minimum value is `0` (timeout is not controlled, you may wait to acquire a lock as long as you need) and the maximum value is `2147483647`. Defaults to `0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-LOCK-TIMEOUT).

  The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Log checkpoints**{#setting-log-checkpoints} {{ tag-all }}

  Manages logging of execution of checkpoints and server restart points.

  The setting is disabled by default (no logging).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-CHECKPOINTS).

- **Log connections**{#setting-log-connections} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Manages logging of all attempts to connect to the {{ PG }} server, including those where clients were successfully authenticated.

  The setting is disabled by default (no logging).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-CONNECTIONS).

- **Log disconnections**{#setting-log-disconnections} {{ tag-con }} {{ tag-api }} {{tag-cli }} {{ tag-tf }}

  Manages logging of disconnections for {{ PG }} server sessions.

  The setting is disabled by default (no logging).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-DISCONNECTIONS).

- **Log duration**{#setting-log-duration} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Manages logging of duration of each completed command.

  The setting is disabled by default (no logging).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-DURATION).

- **Log error verbosity**{#setting-log-error-verbosity} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  The level of detail for the {{ PG }} log entry per message. Log detail levels in ascending order of verbosity:
  * `terse` (`LOG_ERROR_VERBOSITY_TERSE` for Terraform, CLI, and API). The `DETAIL`, `HINT`, `QUERY`, and `CONTEXT` fields are excluded from the error message.
  * `default` (`LOG_ERROR_VERBOSITY_DEFAULT` for Terraform, CLI, and API). Default.
  * `verbose` (`LOG_ERROR_VERBOSITY_VERBOSE` for Terraform, CLI, and API). The error message includes the `SQLSTATE` error code, the source code file name, function name, and line number that generated the error.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-ERROR-VERBOSITY).

- **Log lock waits**{#setting-log-lock-waits} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Controls logging of long lock waits. When enabled, a log entry is created when the log wait for a {{ PG }} session is longer than [Deadlock timeout](#setting-deadlock-timeout).

  This setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-LOCK-WAITS).

- **Log min duration sample**{#setting-log-min-duration-sample} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  The setting is similar to [Log min duration statement](#setting-log-min-duration-statement), but only applies to the statements listed in [Log statement sample rate](#setting-log-statement-sample-rate).

  When the value is `0`, the duration is logged for all the specified statements.

  Minimum value is `-1` (disables logging of the statement duration) and the maximum value is `2147483647`. Defaults to `-1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-DURATION-SAMPLE).

- **Log min duration statement**{#setting-log-min-duration-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  This setting sets the threshold for duration logging (in milliseconds). Only the statements that ran for at least the specified amount of time are logged.

  When the value is `0`, the duration is logged for all the specified statements.

  The minimum value is `-1` (disables duration logging) and the maximum value is `2147483647`. Defaults to `-1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-DURATION-STATEMENT).

  The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Log min error statement**{#setting-log-min-error-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Defines the logging level for errors of SQL statement execution. A message about the statement execution is logged if it has at least the specified severity level. Acceptable values: `DEBUG5`, `DEBUG4`, `DEBUG3`, `DEBUG2`, `DEBUG1`, `INFO`, `NOTICE`, `WARNING`, `ERROR`, `LOG`, `FATAL`, and `PANIC`.

  The default value is `ERROR`. This means that the {{ PG }} log will include all the statements that ended with a message having the `ERROR`, `LOG`, `FATAL`, or `PANIC` severity level.

  To disable logging of failed statements, select the `PANIC` value.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-ERROR-STATEMENT).

- **Log min messages**{#setting-log-min-messages} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Defines the logging level in {{ PG }}. All the messages that have at least the selected severity level are logged. Acceptable values (in ascending severity): `DEBUG5`, `DEBUG4`, `DEBUG3`, `DEBUG2`, `DEBUG1`, `INFO`, `NOTICE`, `WARNING`, `ERROR`, `LOG`, `FATAL`, and `PANIC`.

  The default value is `WARNING`. This means that the {{ PG }} log will include all the messages with the `WARNING`, `ERROR`, `LOG`, `FATAL`, or `PANIC` severity level.

  To disable logging of messages, select the `PANIC` value.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-MESSAGES).

- **Log statement**{#setting-log-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  A filter for SQL statements to be written to the {{ PG }} log:
  * `none` (`LOG_STATEMENT_NONE` for Terraform, CLI, and API) (default): The filter is disabled and SQL statements aren't logged.
  * `ddl` (`LOG_STATEMENT_DDL` for Terraform, CLI, and API): The SQL statements that let you change data definitions are logged (such as `CREATE`, `ALTER`, and `DROP`).
  * `mod` (`LOG_STATEMENT_MOD` for Terraform, CLI, and API): The SQL statements that match the `ddl` filter and statements used to change data (such as `INSERT` and `UPDATE`).
  * `all` (`LOG_STATEMENT_ALL` for Terraform, CLI, and API): All the SQL statements are logged.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html).

  The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Log statement sample rate**{#setting-log-statement-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  The rate of SQL statements that will be logged in addition to statements logged for other reasons.

  The minimum value is `0.0` and the maximum value is `1.0`. Defaults to `0.0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-STATEMENT-SAMPLE-RATE).

- **Log temp files**{#setting-log-temp-files} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  The size of temporary files (in bytes) that, if exceeded, triggers logging of the deletion in {{ PG }}.

  The minimum value is `-1` (not used) and the maximum value is `2147483647` (2 GB). Defaults to `-1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-TEMP-FILES).

- **Log transaction sample rate**{#setting-log-transaction-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  The rate of transactions whose statements will be logged in addition to statements logged for other reasons.

  The minimum value is `0.0` and the maximum value is `1.0`. Defaults to `0.0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-TRANSACTION-SAMPLE-RATE).

- **Maintenance work mem**{#setting-maintenance-work-mem} {{ tag-all }}

  The maximum memory (in bytes) allocated for {{ PG }} maintenance operations, including `VACUUM`, `CREATE INDEX`, and `ALTER TABLE ADD FOREIGN KEY`.

  The minimum value is `1024` and the maximum value is `2147483647` (2 GB). Defaults to `65536`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAINTENANCE-WORK-MEM).

- **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  The maximum number of simultaneous connections to the {{ PG }} host.

  The minimum value is `1` and the maximum value is `262143`. The default value depends on the selected [host class](../../managed-postgresql/concepts/instance-types.md) and is calculated as follows: `200 × <number of vCPUs per host>`. For example, for the cluster class [s1.micro](../../managed-postgresql/concepts/instance-types.md), the default setting is `400` and can't be increased.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-connection.html#GUC-MAX-CONNECTIONS).

- **Max locks per transaction**{#setting-max-locks-transaction} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  The maximum number of objects that can be locked per {{ PG }} host connection at the same time.

  The minimum value is `10` and the maximum value is `2147483647`. Defaults to `64`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-locks.html#GUC-MAX-LOCKS-PER-TRANSACTION).

- **Max parallel maintenance workers**{#setting-max-parallel-maintenance-workers} {{ tag-all }}

  The maximum number of parallel {{ PG }} workers that can be started by a single utility command (for example, `CREATE INDEX`).

  The minimum value is `0` and the maximum value is `1024`. Defaults to `2`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PARALLEL-WORKERS-MAINTENANCE).

- **Max parallel workers**{#setting-max-parallel-workers} {{ tag-all }}

  The maximum number of parallel {{ PG }} workers.

  The minimum value is `0` and the maximum value is `1024`. Defaults to `8`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PARALLEL-WORKERS).

- **Max parallel workers per gather**{#setting-max-parallel-workers-gather} {{ tag-all }}

  The maximum number of parallel workers that can be started by a single [Gather](https://www.postgresql.org/docs/current/how-parallel-query-works.html) node.

  The minimum value is `0` and the maximum value is `1024`. Defaults to `2`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PARALLEL-WORKERS-PER-GATHER).

- **Max locks per transaction**{#setting-max-pred-locks-transaction} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  The maximum number of objects that can be locked by [predicate locks](https://www.postgresql.org/docs/13/transaction-iso.html#XACT-SERIALIZABLE) per {{ PG }} host connection at the same time.

  The minimum value is `10` and the maximum value is `2147483647` (2 GB). Defaults to `64`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-locks.html#GUC-MAX-PRED-LOCKS-PER-TRANSACTION).

- **Max prepared transactions**{#setting-max-prepared-transactions} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  The maximum number of transactions that can be in the [prepared state](https://www.postgresql.org/docs/current/sql-prepare-transaction.html) at the same time.

  The minimum value is `0` and the maximum value is `262143`. Defaults to `0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PREPARED-TRANSACTIONS).

- **Max slot wal keep size**{#setting-max-slot-wal-keep-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  The maximum size of the [WAL](https://www.postgresql.org/docs/current/wal-intro.html) log files during replication (in bytes).

  The minimum value is `-1` (unlimited) and the maximum value is `2251799812636672` (2 TB). Defaults to `1073741824`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-SLOT-WAL-KEEP-SIZE).

- **Max standby streaming delay**{#setting-max-standby-streaming-delay} {{ tag-all }}

  Waiting time (in milliseconds) after which the hot-standby host replica will start canceling the queries that conflict with the about-to-be-applied [WAL](https://www.postgresql.org/docs/current/wal-intro.html) entries.

  The minimum value is `-1` and the maximum value is `2147483647` (2 GB). Defaults to `30000`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-STANDBY-STREAMING-DELAY).

- **Max wal size**{#setting-max-wal-size} {{ tag-all }}

  The maximum [WAL](https://www.postgresql.org/docs/current/wal-intro.html) file size (in bytes) that, when reached, triggers automatic checkpoints.

  The minimum value is `2` and the maximum value is `2251799812636672` (2 PB). Defaults to `5368709120` (5 GB).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-MAX-WAL-SIZE).

- **Max worker processes**{#setting-max-worker-processes} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  The maximum number of {{ PG }} background processes that might be run on the current system.

  The minimum value is `0` and the maximum value is `1024`. Defaults to `8`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-WORKER-PROCESSES).

- **Min wal size**{#setting-min-wal-size} {{ tag-all }}

  The amount of disk space (in bytes) occupied by the [WAL](https://www.postgresql.org/docs/current/wal-intro.html) that, when exceeded, triggers deletion of old WAL files at checkpoints.

  The minimum value is `2` and the maximum value is `2251799812636672` (2 PB). Defaults to `1073741824` (1 GB).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-MIN-WAL-SIZE).

- **Old snapshot threshold**{#setting-old-snapshot-threshold} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  The minimum time (in milliseconds) that a query snapshot can be used without risk of an error.

  The minimum value is `-1` (unlimited) and the maximum value is `86400000` (24 hours). Defaults to `-1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-OLD-SNAPSHOT-THRESHOLD).

- **Online analyze enable**{#setting-online-analyze} {{ tag-con }} {{ tag-api }}

  Enables the `online_analyze` module that updates statistics after the `INSERT`, `UPDATE`, `DELETE`, or `SELECT INTO` operations in the target tables.

- **Operator precedence warning**{#setting-operator-precedence-warning} {{ tag-all }}

  Allows the query parser to emit a warning for any constructs that changed their behavior since version 9.4 as a result of changes in operator precedence.

  This setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-OPERATOR-PRECEDENCE-WARNING).

- **Parallel leader participation**{#setting-parallel-leader-participation} {{ tag-all }}

  Allows the leader process to execute the query plan under Gather and Gather Merge nodes without waiting for worker processes.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-PARALLEL-LEADER-PARTICIPATION).

- **Pg hint plan debug print**{#setting-pghint-plan-debug} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  The level of output and detail of debugging information for the `pg_hint_plan` module. Applies when [Pg hint plan enable hint](#setting-pg-hint-plan-enable) is enabled. Possible values:
    * `off` (`PG_HINT_PLAN_DEBUG_PRINT_OFF` for Terraform and API): The output is disabled.
    * `on` (`PG_HINT_PLAN_DEBUG_PRINT_ON` for Terraform and API): Default.
    * `detailed` (`PG_HINT_PLAN_DEBUG_PRINT_DETAILED` for Terraform and API).
    * `verbose` (`PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` for Terraform and API).

- **Pg hint plan enable hint**{#setting-pg-hint-plan-enable} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Enables the `pg_hint_plan` module that lets you adjust the automatic execution plans using so-called “hints” that are simple descriptions in special SQL comments.

- **Pg hint plan enable hint table**{#setting-pg-hint-plan-enable-hint-table} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Enables the use of a table with "hints" for the `pg_hint_plan` module. When it is not possible to edit queries, you can put hints into a special `hint_plan.hints` table. The table contains the following columns:
  * `id`: A unique row ID with the hint. This column is populated automatically.
  * `norm_query_string`: A pattern to match the hinted queries. Constants in the target query must be replaced with a `?`. Whitespace characters are significant in the pattern.
  * `application_name`: The application that initiated the sessions to apply the hint to.
  * `hint`: The field must include the hints, excluding the surrounding comment marks.

- **Pg hint plan message level**{#setting-pghint-plan-message} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  The level of debug messages for the `pg_hint_plan` module that will be included in the {{ PG }} log. Applies when [Pg hint plan enable hint](#setting-pg-hint-plan-enable) is enabled. Possible values:
  * `error`
  * `warning`
  * `notice`
  * `info` (default)
  * `log`
  * `debug`

- **Plan cache mode**{#setting-plan-cache-mode} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  Determines the type of query plan (generic or custom) to be used to execute [prepared statements](https://www.postgresql.org/docs/current/sql-prepare.html). Possible values:
    * `auto` (`PLAN_CACHE_MODE_AUTO` for Terraform and API) (default): Automatic selection.
    * `force_custom_plan` (`PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN` for Terraform and API): Force custom plans.
    * `force_generic_plan` (`PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` for Terraform and API): Force generic plans.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-PLAN-CACHE_MODE).

- **Plantuner fix empty table**{#setting-plantuner-fix-empty-table} {{ tag-con }} {{ tag-api }}

  Allows the `plantuner` module to hide certain indexes from the planner to prevent them from being used in query plans.

  This setting is disabled by default.

- **Quote all identifiers**{#setting-quote-identifiers} {{ tag-all }}

  Forces quoting of all identifiers when generating SQL queries from a database, for example, when running the `EXPLAIN` operation.

  This setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-QUOTE-ALL-IDENTIFIERS).

- **Random page cost**{#setting-random-page-cost} {{ tag-all }}

  Estimates the cost of reading an arbitrary disk page.

  The minimum value is `0`. Defaults to `1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-RANDOM-PAGE-COST).

- **Row security**{#setting-row-security} {{ tag-all }}

  Controls processing of queries that apply at least one [row security policy](https://www.postgresql.org/docs/current/sql-createpolicy.html). If you disable the setting, such queries will return an error.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-ROW-SECURITY).

- **Search path**{#setting-search-path} {{ tag-all }}

  This is a comma-separated list of DB schemas whose objects you can access by simple names without specifying schemas.

  The default value is `$user, public` (the current user schema and `public` schema).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-SEARCH-PATH).

- **Seq page cost**{#setting-seq-page-cost} {{ tag-all }}

  The approximate conventional cost of reading a single page from the disk when doing a series of consecutive reads.

  The minimum value is `0`. Defaults to `1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#RUNTIME-CONFIG-QUERY-CONSTANTS).

- **Shared buffers**{#setting-shared-buffers} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  The amount of memory (in bytes) that {{ PG }} can use for shared memory buffers.

  The minimum value is `16` and the maximum value is `8796093014016` (8 TB). Defaults to 25% of the total RAM on the {{ mpg-name }} cluster host. The setting depends on the selected [host class](../../managed-postgresql/concepts/instance-types.md).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-SHARED-BUFFERS).

- **Shared preload libraries**{#setting-shared-libraries} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  A comma-separated list of shared libraries that will be loaded when the {{ PG }} server starts. Each name is interpreted as for the `LOAD` command. Whitespace characters between names are ignored. If you want to include whitespace characters or commas in the names, enclose them in double quotes.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-SHARED-PRELOAD-LIBRARIES).

- **Standard conforming strings**{#setting-standard-strings} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  Treating backslashes in the regular string constants (`'...'`) literally (as specified in the SQL standard) rather than a special character.

  This setting is enabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-STANDARD-CONFORMING-STRINGS).

- **Statement timeout**{#setting-statement-timeout} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  The maximum statement duration (in milliseconds) after which the command is aborted.

  The minimum value is `0` and the maximum value is `2147483647` (2 GB). Defaults to `0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-STATEMENT-TIMEOUT).

- **Synchronize seqscans**{#setting-synchronize-seqscans} {{ tag-all }}

  Allows sequential scans of large tables to synchronize with each other, so that concurrent scans read the same block at about the same time. When disabled, ensures the pre-8.3 behavior where a sequential scan always started from the beginning of the table.

  This setting is enabled by default (syncing enabled).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-SYNCHRONIZE-SEQSCANS).

- **Synchronous commit**{#setting-synchronous-commit} {{ tag-all }}

  Defines whether the DBMS will commit a transaction synchronously. Synchronous execution means that a cluster will wait for synchronous operations that guarantee different levels of data persistence and visibility in the cluster before committing the transaction to the client.

  Acceptable values:
  * `off` (`SYNCHRONOUS_COMMIT_OFF` for Terraform, CLI, and API): A transaction is committed even if the data hasn't yet been written to the [WAL](https://www.postgresql.org/dodcs/current/wal-intro.html) (Write Ahead Log). There is no synchronous write operation, and the transaction data might be lost as a result of a disk subsystem failure.
  * `on` (`SYNCHRONOUS_COMMIT_ON` for Terraform, CLI, and API) (default): A transaction is committed if the WAL has been written to the master disk and synchronous replica disk.
  * `local` (`SYNCHRONOUS_COMMIT_LOCAL` for Terraform, CLI, and API): A transaction is committed if the WAL has been written to the master disk.
  * `remote_apply` (`SYNCHRONOUS_COMMIT_REMOTE_APPLY` for Terraform, CLI, and API): A transaction is committed if the WAL has been written to the master disk, the synchronous replica has accepted the WAL and applied the changes from it.
  * `remote_write` (`SYNCHRONOUS_COMMIT_REMOTE_WRITE` for Terraform, CLI, and API): A transaction is committed if the WAL is written to the master disk, the synchronous replica has accepted the WAL and passed it to the OS for writing to the disk. If the master disk system is lost and the OS on the replica fails, transaction data with this level of synchronization may be lost.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT).

  The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Temp buffers**{#setting-temp-buffers} {{ tag-all }}

  The maximum amount of memory (in bytes) allocated for temporary buffers in each session.

  The minimum value is `100` and the maximum value is `1073741823` (1 GB). Defaults to `8388608` (8 MB).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-TEMP-BUFFERS).

- **Temp file limit**{#setting-temp-file-limit} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  The maximum storage space size (in kilobytes) that a single process can use to create temporary files. A transaction that tries to exceed this limit will be canceled.

  Large queries, due to their size, are executed in the disk space rather than in RAM. Queries that are too large can overload the disk and prevent other quieres from being executed. The setting prevents queries that can greatly affect performance by limiting the size of temporary files.

  The minimum value is `-1` (no limit) and the maximum value is `2147483647` (2 GB). Defaults to `-1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-TEMP-FILE-LIMIT).

  The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Timezone**{#setting-timezone} {{ tag-all }}

  Time zone for output and input of time values.

  Default value: `Europe/Moscow`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-TIMEZONE).

- **Track activity query size**{#setting-track-activity-query-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  The amount of memory (in bytes) reserved to store the text of the currently executing command for each active session.

  The minimum value is `100` and the maximum value is `102400`. Defaults to `1024`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-statistics.html#GUC-TRACK-ACTIVITY-QUERY-SIZE).

- **Transform null equals**{#setting-transform-null-equals} {{ tag-all }}

  Enables treating of the condition `expression = NULL` as `expression IS NULL`. The condition is true if the expression has the value `NULL`, otherwise it is false. According to the SQL standard, `expression = NULL` always returns `NULL` (an unknown value).

  This setting is disabled by default (the SQL standard applies).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-TRANSFORM-NULL-EQUALS).

- **Vacuum cleanup index scale factor**{#setting-vacuum-index-scale-factor} {{ tag-all }}

  The fraction of heap tuples counted in the previous statistics collection. When running the `VACUUM` operation, index statistics are considered to be stale if the ratio of newly inserted tuples to the total number of heap tuples exceeds this fraction. In this case, the index will be re-scanned.

  The minimum value is `0.0` and the maximum value is `10000000000.0`. Defaults to `0.1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-VACUUM-CLEANUP-INDEX-SCALE-FACTOR).

- **Vacuum cost delay**{#setting-vacuum-cost-delay} {{ tag-all }}

  The amount of time (in milliseconds) for the `VACUUM` and `ANALYZE` process to sleep when the cost limit has been exceeded (see the setting [Vacuum cost limit](#setting-vacuum-cost-limit)).

  The minimum value is `0` and the maximum value is `100`. Defaults to `0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#RUNTIME-CONFIG-RESOURCE-VACUUM-COST).

- **Vacuum cost limit**{#setting-vacuum-cost-limit} {{ tag-all }}

  The accumulated cost that will cause the `VACUUM` process to sleep.

  The minimum value is `1` and the maximum value is `10000`. Defaults to `200`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-LIMIT).

- **Vacuum cost page dirty**{#setting-vacuum-cost-page-dirty} {{ tag-all }}

  The estimated cost that is charged when `VACUUM` modifies a block that was previously clean.

  The minimum value is `10` and the maximum value is `10000`. Defaults to `20`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-PAGE-DIRTY).

- **Vacuum cost page hit**{#setting-vacuum-cost-page-hit} {{ tag-all }}

  The estimated cost for vacuuming a buffer found in the shared buffer cache.

  The minimum value is `0` and the maximum value is `10000`. Defaults to `1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-PAGE-HIT).

- **Vacuum cost page miss**{#setting-vacuum-cost-page-miss} {{ tag-all }}

  The estimated cost for vacuuming a buffer that has to be read from the disk.

  The minimum value is `0` and the maximum value is `10000`. Defaults to `10`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-PAGE-MISS).

- **Wal keep size**{#setting-wal-keep-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-sql }}

  The minimum size (in bytes) of past log segments kept in the [WAL](https://www.postgresql.org/docs/current/wal-intro.html) directory so that [replicas](../../managed-postgresql/concepts/replication.md#replication) could fetch them, if needed.

  The minimum value is `0` (past segments are not saved for replication) and the maximum value is `2251799812636672` (2 TB). Defaults to `0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-WAL-KEEP-SIZE).

- **Wal level**{#setting-wal-level} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  The logging level used for [WAL](https://www.postgresql.org/docs/current/wal-intro.html). Possible values:
    * `WAL_LEVEL_REPLICA`: Writes enough data to support WAL archiving and replication.
    * `WAL_LEVEL_LOGICAL` (default): On top of the `WAL_LEVEL_REPLICA` level, the information necessary for logical replication is added.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#RUNTIME-CONFIG-WAL-SETTINGS).

- **Work mem**{#setting-work-mem} {{ tag-all }}

  The base maximum amount of memory to be used by an internal query operation (such as a sort or hash table) before writing to temporary disk files.

  The minimum value is `64` and the maximum value is `2147483647` (2 GB). Defaults to `4194304` (4 MB).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-WORK-MEM).

- **Xmlbinary**{#setting-xmlbinary} {{ tag-all }}

  The method used for encoding binary data in XML. Possible values:
  * `base64` (`XML_BINARY_BASE64` for Terraform, API, and CLI) (default): BASE64 encoding.
  * `hex` (`XML_BINARY_HEX` for Terraform, API, and CLI): Hexadecimal encoding.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-XMLBINARY).

- **Xmloption**{#setting-xmloption} {{ tag-all }}

  The default type of conversion between the XML and character string data. Possible values:
  * `document` (`XML_OPTION_DOCUMENT` for Terraform, API, and CLI): An XML document.
  * `content` (`XML_OPTION_CONTENT` for Terraform, API, and CLI) (by default): A fragment of an XML document.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-XMLOPTION).

