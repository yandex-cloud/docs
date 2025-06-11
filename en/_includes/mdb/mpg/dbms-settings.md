- **Archive timeout**{#setting-archive-timeout} {{ tag-all }}

  Period (in milliseconds) for archiving the {{ PG }} transaction log.

  The minimum value is `10000`; the maximum value is `86400000`; the default value is `30000`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-ARCHIVE-TIMEOUT).

- **Array nulls**{#setting-array-nulls} {{ tag-all }}

  Manages the recognition of the `NULL` elements when inserting an array. If this setting is enabled, such elements are recognized as an empty `NULL` field. Otherwise, as a string with the `NULL` text.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-ARRAY-NULLS).

- **Auto explain log analyze**{#setting-auto-explain-log-analyze} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Determines whether to automatically output query plan statistics to the {{ PG }} log without having to run `EXPLAIN` manually. This allows you to track unoptimized queries. This setting uses the `auto_explain` module. To enable it, [connect the `auto_explain` library](#setting-shared-libraries).

  It is disabled by default (query plan statistics are not logged).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log buffers**{#setting-auto-explain-log-buffers} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Determines whether to output buffer usage statistics to the {{ PG }} log using the `auto_explain` module. It works similar to the `BUFFERS` parameter in the `EXPLAIN` statement. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  This setting is disabled by default (buffer usage statistics are not logged).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log min duration**{#setting-auto-explain-log-min-duration} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Minimum query execution time (in milliseconds) at which logging is enabled in the `auto_explain` module.

  The minimum value is `-1` (logging disabled); the maximum value is `2147483647`; the default value is `-1`. If set to `0`, plans are logged for all queries without regard to their execution time.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log nested statements**{#setting-auto-explain-log-nested-statements} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Determines whether the `auto_explain` module will log the execution of nested queries inside SQL functions. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  This setting is disabled by default (plans are logged for top-level queries only).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log timing**{#setting-auto-explain-log-timing} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Determines whether the `auto_explain` module will log execution time information for individual query plan steps. It works similar to the `TIMING` parameter in the `EXPLAIN` statement. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  This setting is disabled by default (timing information for individual steps is not logged).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log triggers**{#setting-auto-explain-log-triggers} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Determines whether to output trigger execution statistics in the `auto_explain` module. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  This setting is disabled by default (trigger execution statistics are not output).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log verbose**{#setting-auto-explain-log-verbose} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Determines whether to provide log details in the `auto_explain` module. It works similar to the `VERBOSE` parameter in the `EXPLAIN` statement. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  This setting is disabled by default (no logging details).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain sample rate**{#setting-auto-explain-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Rate of queries logged per session using the `auto_explain` module. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  The minimum value is `0.0` (no queries are logged); the maximum value is `1.0` (all queries are logged); the default value is `1.0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Autovacuum analyze scale factor**{#setting-autovacuum-analyze-scale-factor} {{ tag-all }}

  Rate of changed or deleted table records at which [autovacuum](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) will run the `ANALYZE` statement for statistics collection.

  The minimum value is `0.0`; the maximum value is `1.0`; the default value is `0.0001`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-ANALYZE-SCALE-FACTOR).

- **Autovacuum max workers**{#setting-autovacuum-max-workers} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-cli }}

  Maximum number of [autovacuum processes](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) running in parallel. Autovacuuming runs at intervals for each DB, looks up the table records marked for deletion, and deletes them.

  It can range from `1` to `32`. The default value [depends on the selected host class](#settings-instance-dependent) and is equal to the number of vCPUs on a single host, with a minimum of `3`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-MAX-WORKERS).

- **Autovacuum naptime**{#setting-autovacuum-naptime} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Sets the minimum interval (in milliseconds) between [autovacuums](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM). If your data changes frequently, you can increase this interval to avoid overloading your database.

  The minimum value is `1000`; the maximum value is `86400000`; the default value is `15000`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-NAPTIME).

- **Autovacuum vacuum cost delay**{#setting-autovacuum-vacuum-cost-delay} {{ tag-all }}

  Time (in milliseconds) the [autovacuum](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) process will remain idle if the [cost limit](#setting-autovacuum-vacuum-cost-limit) is exceeded.

  The minimum value is `-1` (disables the setting); the maximum value is `100`. The default value [depends on the selected host class](#settings-instance-dependent).

  - If the number of vCPUs for the selected host class is 10 or more, the value is set to `5`.
  - In other cases, the default value is calculated using the following formula:

    ```text
    55 - 5 × <number_of_vCPUs_per_host>
    ```

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-COST-DELAY).

- **Autovacuum vacuum cost limit**{#setting-autovacuum-vacuum-cost-limit} {{ tag-all }}

  Cost limit that, when exceeded, will freeze the [autovacuum process](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) for the time specified by the [Autovacuum vacuum cost delay](#setting-autovacuum-vacuum-cost-delay) parameter.

  The minimum value is `-1` (disables the setting); the maximum value is `10000`. The default value [depends on the selected host class](#settings-instance-dependent) and is determined by the formula:

  ```text
  150 × <number_of_vCPUs_per_host> + 400
  ```

  For example:

  Host class | vCPU | Default value
  ---|----|-----
  s2.small | 4 | `150 × 4 + 400 = 1000`
  m2.medium| 6 | `150 × 6 + 400 = 1300`

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-COST-LIMIT).

- **Autovacuum vacuum insert scale factor**{#setting-autovacuum-vacuum-insert-scale-factor} {{ tag-all }}

  Table size share added to the [Autovacuum vacuum insert threshold](#setting-autovacuum-vacuum-insert-threshold) setting value at which [autovacuum](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) will be activated.

  The minimum value is `0.0`; the maximum value is `1.0`; the default value is `0.2`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-INSERT-SCALE-FACTOR).

- **Autovacuum vacuum insert threshold**{#setting-autovacuum-vacuum-insert-threshold} {{ tag-all }}

  Sets the number of rows that, when inserted into a table, triggers the [autovacuum process](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM).

  The minimum value is `-1` (disables the setting); the maximum value is `2147483647`; the default value is `1000`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-INSERT-THRESHOLD).

- **Autovacuum vacuum scale factor**{#setting-autovacuum-vacuum-scale-factor} {{ tag-all }}

  Rate of changed or deleted table records at which [autovacuum](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) will start vacuuming using the `VACUUM` statement.

  The minimum value is `0.0` (disables the setting); the maximum value is `1.0`; the default value is `0.00001`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-SCALE-FACTOR).

- **Autovacuum work mem**{#setting-autovacuum-work-mem} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-cli }}

  Memory (in bytes) allocated to each [autovacuum process](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM).

  The minimum value is `-1` (disables the setting); the maximum value is `2147483647`; the default value is `-1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-AUTOVACUUM-WORK-MEM).

- **Backend flush after**{#setting-backend-flush-after} {{ tag-all }}

  Maximum amount of data (in kilobytes) a utility process can write to the OS kernel page cache. If it is exceeded, the DBMS commands the OS to flush data to the disk. The higher the parameter, the less likely the slowdown when flushing data to the disk using `fsync` (e.g., after completing a checkpoint).

  The minimum value is `0` (disables the setting); the maximum value is `2048`; the default value is `0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BACKEND-FLUSH-AFTER).

- **Backslash quote**{#setting-backslash-quote} {{ tag-all }}

  Controls the way quotation mark is represented in an SQL string.

  Acceptable values:

  - `backslash_quote` (`BACKSLASH_QUOTE` for {{ TF }}, API, and CLI): Quotation mark can be represented as `\'` (equivalent to `on`).
  - `on` (`BACKSLASH_QUOTE_ON` for {{ TF }}, API, and CLI): Quotation mark can be represented as `\'`.
  - `off` (`BACKSLASH_QUOTE_OFF` for {{ TF }}, API, and CLI): Quotation mark can only be represented as the SQL's standard `''`.
  - `safe_encoding` (`BACKSLASH_QUOTE_SAFE_ENCODING` for {{ TF }}, API, and CLI): Quotation mark can be represented as `\'` only for client encodings not using `\` in multi-byte characters.

  The default value is `safe_encoding`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-BACKSLASH-QUOTE).

- **Bgwriter delay**{#setting-bgwriter-delay} {{ tag-all }}

  Time (in milliseconds) between the background writer runs. This process writes new or changed items from the {{ PG }} buffer to the disk. The delay helps avoid rewriting the same page many times for every page modification and reduce IO load.

  The minimum value is `10`; the maximum value is `10000`; the default value is `200`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-DELAY).

- **Bgwriter flush after**{#setting-bgwriter-flush-after} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Limits the amount of data processed by the background writer (in kilobytes). When the limit is exceeded, the DBMS instructs the OS to flush this data to disk. This parameter limits the amount of <q>dirty</q> data in the kernel page cache, thus reducing the likelihood of slowdowns when an `fsync` statement is issued at the end of a checkpoint or when the OS flushes data to the disk in the background.

  The minimum value is `0`; the maximum value is `2048`; the default value is `512`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-FLUSH-AFTER).

- **Bgwriter lru maxpages**{#setting-bgwriter-lru-maxpages} {{ tag-all }}

  Maximum number of {{ PG }} buffers that can be written by the background writer per activity round. The value of zero disables background writing.

  The minimum value is `0`; the maximum value is `1073741823`; the default value is `100`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-LRU-MAXPAGES).

- **Bgwriter lru multiplier**{#setting-bgwriter-lru-multiplier} {{ tag-all }}

  Multiplies the average need in buffers over the previous rounds to calculate the background writer's buffer need for the next round.

  The minimum value is `0`; the maximum value is `10`; the default value is `2`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-LRU-MULTIPLIER).

- **Bytea output**{#setting-bytea-output} {{ tag-all }}

  Sets the output format for [binary string values](https://www.postgresql.org/docs/current/datatype-binary.html) (the `bytea` type):

  - `hex` (`BYTEA_OUTPUT_HEX` for {{ TF }}, API, and CLI) to encode binary data as two hexadecimal digits per byte, e.g., '`SELECT '\xDEADBEEF';`'.
  - `escape` (`BYTEA_OUTPUT_ESCAPE` for {{ TF }}, API, and CLI) to use the standard {{ PG }} format (ASCII characters only).

  The default value is `hex`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/datatype-binary.html).

- **Checkpoint completion target**{#setting-checkpoint-completion-target} {{ tag-all }}

  Portion of the interval between checkpoints representing the maximum duration of completing a checkpoint. For example, if the value is `0.5`, the checkpoint will be completed within about half the interval until the next checkpoint.

  The minimum value is `0.0`; the maximum value is `1.0`; the default value is `0.5`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/wal-configuration.html).

- **Checkpoint flush after**{#setting-checkpoint-flush-after} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Size of page cache (in kilobytes) that triggers data flush at a checkpoint. The pages beyond the value are flushed to the disk and deleted from the OS page cache.

  The minimum value is `0`; the maximum value is `2048`; the default value is `256`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-CHECKPOINT-FLUSH-AFTER).

- **Checkpoint timeout**{#setting-checkpoint-timeout} {{ tag-all }}

  Interval between checkpoints (in milliseconds).

  The minimum value is `30000`; the maximum value is `86400000`; the default value is `300000`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-CHECKPOINT-TIMEOUT).

- **Client connection check interval**{#setting-client-connection-check-interval} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Client connection check interval when executing queries (in milliseconds). The check polls the server socket for a connection and aborts long-running queries if it detects that the connection has been terminated. {{ PG }} supports this feature starting from version 14.

  The minimum value is `0` (disables checks); the maximum value is `2147483647`. By default, the minimum value is used.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-connection.html#GUC-CLIENT-CONNECTION-CHECK-INTERVAL).

- **Client min messages**{#setting-client-min-messages} {{ tag-all }}

  Level of logging messages sent to client applications. Possible values (in ascending order of severity): `debug5`, `debug4`, `debug3`, `debug2`, `debug1`, `info`, `notice`, `warning`, `error`, `log`, `fatal`, and `panic` (for {{ TF }}, API, and CLI, `LOG_LEVEL_DEBUG5`, `LOG_LEVEL_DEBUG4`, `LOG_LEVEL_DEBUG3`, `LOG_LEVEL_DEBUG2`, `LOG_LEVEL_DEBUG1`, `LOG_LEVEL_INFO`, `LOG_LEVEL_NOTICE`, `LOG_LEVEL_WARNING`, `LOG_LEVEL_ERROR`, `LOG_LEVEL_LOG`, `LOG_LEVEL_FATAL`, and `LOG_LEVEL_PANIC`).

  The default value is `NOTICE`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-CLIENT-MIN-MESSAGES).

- **Constraint exclusion**{#setting-constraint-exclusion} {{ tag-all }}

  Allows the query planner to use table constraints to optimize queries.

  Acceptable values:

  - `on` (`CONSTRAINT_EXCLUSION_ON` for {{ TF }}, API, and CLI): Use constraints for all tables.
  - `off` (`CONSTRAINT_EXCLUSION_OFF` for {{ TF }}, API, and CLI): Do not use constraints.
  - `partition` (`CONSTRAINT_EXCLUSION_PARTITION` for {{ TF }}, API, and CLI): Only use constraints for child tables and `UNION ALL` clauses.

  The default value is `partition`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-CONSTRAINT-EXCLUSION).

- **Cursor tuple fraction**{#setting-cursor-tuple-fraction} {{ tag-all }}

  Sets the planner's estimate of the fraction of rows to be retrieved via a cursor.

  The minimum value is `0.0`; the maximum value is `1.0`; the default value is `0.1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-CURSOR-TUPLE-FRACTION).

- **Deadlock timeout**{#setting-deadlock-timeout} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-cli }}

  Waiting time (in milliseconds) before checking for a deadlock condition.

  The minimum value is `1`; the maximum value is `2147483647`; the default value is `1000`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-locks.html#GUC-DEADLOCK-TIMEOUT).

- **Default statistics target**{#setting-default-statistics-target} {{ tag-all }}

  Maximum number of statistics records for each DB table column. The query planner uses statistics to estimate the number of rows returned by queries to select the most suitable query plan.

  To improve the quality of the planner's estimates, increase the target.

  The minimum value is `1`; the maximum value is `10000`; the default value is `1000`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-DEFAULT-STATISTICS-TARGET).

- **Default transaction isolation**{#setting-default-transaction-isolation} {{ tag-all }}

  This setting determines the default isolation level to be used for new SQL transactions.

  Acceptable values:

  - `read committed` (`TRANSACTION_ISOLATION_READ_COMMITTED` for {{ TF }}, API, and CLI): The query only sees the rows that were committed before it started.
  - `read uncommitted` (`TRANSACTION_ISOLATION_READ_UNCOMMITTED` for {{ TF }}, API, and CLI): This isolation level's behavior in {{ PG }} is identical to `read committed`.
  - `repeatable read` (`TRANSACTION_ISOLATION_REPEATABLE_READ` for {{ TF }}, API, and CLI): All queries in the current transaction only see the rows that were committed before the first query to select or update data in this transaction.
  - `serializable` (`TRANSACTION_ISOLATION_SERIALIZABLE` for {{ TF }}, API, and CLI): The strictest isolation level out of all those mentioned above. This isolation level's behavior in {{ PG }} is identical to `repeatable read`. However, if the overlap of read and write operations of parallel serializable transactions is incompatible with their serial execution, one of the transactions is rolled back with the <q>serialization failure</q> error.

  The default value is `read committed`.

  To learn more about isolation levels, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/transaction-iso.html).

  The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Default transaction read only**{#setting-default-transaction-read-only} {{ tag-all }}

  Sets the <q>read only</q> mode in each new transaction for any tables except temporary ones.

  This setting is disabled by default (both reads and writes are allowed).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-DEFAULT-TRANSACTION-READ-ONLY).

- **Default with oids**{#setting-default-with-oids} {{ tag-all }}

  Adds the `OID` column containing a unique row ID. The setting has effect if the table is created:

  - Either without specifying `WITH OIDS` and `WITHOUT OIDS`.
  - Or using the `SELECT INTO` statement.

  The practice of using `OID` in user tables is considered obsolete, so enable this setting for backward compatibility reasons only.

  This setting is disabled by default (no `OID` column is added).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/11/runtime-config-compatible.html#GUC-DEFAULT-WITH-OIDS).

- **Effective cache size**{#setting-effective-cache-size} {{ tag-all }}

  Sets the assumption about the effective size of the disk cache that is available to a single query. With a higher value, index scans are more likely to be used by the query planner. With a lower value, sequential scans are more likely.

  The minimum value is `0`; the maximum value is `549755813888` (512 GB); the default value is `107374182400` (100 GB).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-EFFECTIVE-CACHE-SIZE).

- **Effective io concurrency**{#setting-effective-io-concurrency} {{ tag-all }}

  Number of concurrent disk I/O operations for an individual DB session. The higher this number, the more operations {{ PG }} will attempt to execute in parallel within a session.

  The minimum value is `0`; the maximum value is `1000`; the default value is `1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-EFFECTIVE-IO-CONCURRENCY).

- **Enable async append**{#setting-enable-async-append} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Allows the query planner to consider asynchronous execution of the query plan on different hosts when adding data from external sources. {{ PG }} supports this feature starting from version 14.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-ASYNC-APPEND).

- **Enable bitmapscan**{#setting-enable-bitmapscan} {{ tag-all }}

  Allows the query planner to use the bitmap-scan plan types, even if this is not specified in the query explicitly. This access method is similar to regular access by index, but occurs in two steps:

  1. The index is scanned (Bitmap Index Scan) and a bitmap is built where the rows to be read by the query are flagged.
  1. The table is scanned (Bitmap Heap Scan). In this case, the following applies:

     - The pages are read sequentially (this increases the likelihood of using the OS cache).
     - Each page is viewed only once.

  The setting is effective when repeating queries to tables.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-BITMAPSCAN).

- **Enable gathermerge**{#setting-enable-gathermerge} {{ tag-con }} {{ tag-api}} {{ tag-cli }}

  Allows the query planner to use a Gather Merge node for merging query execution results while preserving their order in the parallel query plan. {{ PG }} supports this feature starting from version 14.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-GATHERMERGE).

- **Enable hashagg**{#setting-enable-hashagg} {{ tag-all }}

  Allows the planner to build a hash table from the result set, even if this is not specified in the query explicitly. This setting is effective for frequent unsorted queries to large database tables.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-HASHAGG).

- **Enable hashjoin**{#setting-enable-hashjoin} {{ tag-all }}

  Allows the scheduler to `JOIN` tables based on row hash values, even if this is not specified in the query explicitly. This setting is effective when handling large amounts of data or when the tables are not sorted by the join columns.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-HASHJOIN).

- **Enable incremental sort**{#setting-enable-incremental-sort} {{ tag-all }}

  Allows the query planner to use incremental sorting. This type of sorting can reduce query execution time and RAM requirements if rows need to be sorted by multiple columns, and one or more of them have already been sorted. This feature has been supported by {{ PG }} starting from version 13.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-INCREMENTAL-SORT).

- **Enable indexonlyscan**{#setting-enable-indexonlyscan} {{ tag-all }}

  Allows the query planner to use a table index without accessing the data, even if this is not specified in the query explicitly.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/indexes-index-only-scans.html).

- **Enable indexscan**{#setting-enable-indexscan} {{ tag-all }}

  Allows the query planner to use a table index, even if this is not explicitly specified in the query.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-INDEXSCAN).

- **Enable material**{#setting-enable-material} {{ tag-all }}

  Allows the query planner to use materialization.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-MATERIAL).

- **Enable mergejoin**{#setting-enable-mergejoin} {{ tag-all }}

  Allows the query planner to merge `JOIN` operations when joining tables.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-MERGEJOIN).

- **Enable nestloop**{#setting-enable-nestloop} {{ tag-all }}

  Allows the query planner to use `JOIN` with nested cycles. When the setting is disabled, the query planner will use other methods.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-NESTLOOP).

- **Enable parallel append**{#setting-enable-parallel-append} {{ tag-all }}

  Allows the query planner to use parallel-aware append.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-PARALLEL-APPEND).

- **Enable parallel hash**{#setting-enable-parallel-hash} {{ tag-all }}

  Allows the query planner to use hash-join with parallel hash. The setting only applies when [Enable hashjoin](#setting-enable-hashjoin) is enabled.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-PARALLEL-HASH).

- **Enable partition pruning**{#setting-enable-partition-pruning} {{ tag-all }}

  Allows the query planner to remove unneeded partitions from the query plans for partitioned tables.

  This setting is on by default.

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

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#RUNTIME-CONFIG-QUERY-ENABLE).

- **Enable sort**{#setting-enable-sort} {{ tag-all }}

  Allows the query planner to use explicit sort steps.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-SORT).

- **Enable tidscan**{#setting-enable-tidscan} {{ tag-all }}

  Allows the query planner to use TID (tuple identifier) scan plans to speed up queries.

  This setting is enabled by default (the planner uses TID scans).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/ddl-system-columns.html).

- **Escape string warning**{#setting-escape-string-warning} {{ tag-all }}

  Enables a warning when a backslash (`\`) appears in a regular string constant (with the `'...'` syntax). Only applies if [Standard conforming strings](#setting-standard-strings) is off.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-ESCAPE-STRING-WARNING).

- **Exit on error**{#setting-exit-on-error} {{ tag-all }}

  Enables session interruption in case of any error in the query.

  The setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-error-handling.html).

- **Force parallel mode**{#setting-force-parallel-mode} {{ tag-all }}

  Allows executing queries in parallel mode for testing purposes:

  - `off` (`FORCE_PARALLEL_MODE_OFF` for {{ TF }}, API, and CLI): Use parallel mode only when a performance increase is expected.
  - `on` (`FORCE_PARALLEL_MODE_ON` for {{ TF }}, API, and CLI): Force parallel mode for all queries where it is safe.
  - `regress` (`FORCE_PARALLEL_MODE_REGRESS` for {{ TF }}, API, and CLI): Equivalent to `on`, but the standard output is the same as when using `off`.

  The default value is `off`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-developer.html).

- **From collapse limit**{#setting-from-collapse-limit} {{ tag-all }}

  As long as the number of elements in the `FROM` list does not exceed the setting value, the query planner will combine nested queries with the external query. You can decrease planning time using smaller values, but your query plan might get less effective.

  The minimum value is `1`; the maximum value is `2147483647`; the default value is `8`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-FROM-COLLAPSE-LIMIT).

- **Geqo**{#setting-geqo} {{ tag-con }} {{ tag-api }}

  Enables genetic query optimization ([GEQO](https://www.postgresql.org/docs/current/geqo.html)).

  Default value: `false` (disables genetic optimization).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO).

- **Geqo effort**{#setting-geqo-effort} {{ tag-con }} {{ tag-api }}

  Sets the ratio between the query planning time and query plan quality in the [GEQO](https://www.postgresql.org/docs/current/geqo.html) algorithm.

  The higher the value, the longer it takes to plan the query. But it also increases the probability of selecting an efficient query plan. This setting does not affect the algorithm operation directly but is used to calculate default values for other settings.

  The minimum value is `1`; the maximum value is `10`; the default value is `5`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-EFFORT).

- **Geqo generations**{#setting-geqo-generations} {{ tag-con }} {{ tag-api }}

  Sets the number of iterations for the [GEQO](https://www.postgresql.org/docs/current/geqo.html) algorithm.

  Usable values are in the range from `100` to `1000`.

  If set to `0` (default), the number of algorithm iterations is selected based on the [**Geqo pool size**](#setting-geqo-pool-size) setting.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-GENERATIONS).

- **Geqo pool size**{#setting-geqo-pool-size} {{ tag-con }} {{ tag-api }}

  Sets the number of species in the [GEQO](https://www.postgresql.org/docs/current/geqo.html) algorithm's genetic population.

  Cannot be equal to `1`. Usable values are in the range from `100` to `1000`.

  If set to `0` (default), the number of species is selected depending on the [**Geqo effort**](#setting-geqo-effort) setting and the number of tables in the query.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-POOL-SIZE).

- **Geqo seed**{#setting-geqo-seed} {{ tag-con }} {{ tag-api }}

  Sets an initial value for the random number generator used by the [GEQO](https://www.postgresql.org/docs/current/geqo.html) algorithm to select paths in the join sequence search space.

  When you change the setting, you alter the set of join paths examined which might either improve or degrade the resulting path.

  The minimum value is `0`; the maximum value is `1`; the default value is `0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-SEED).

- **Geqo selection bias**{#setting-geqo-selection-bias} {{ tag-con }} {{ tag-api }}

  Sets the selective pressure within the [GEQO](https://www.postgresql.org/docs/current/geqo.html) population.

  The minimum value is `1.50`; the maximum value is `2.00`; the default value is `2.00`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-SELECTION-BIAS).

- **Geqo threshold**{#setting-geqo-threshold} {{ tag-con }} {{ tag-api }}

  The [GEQO](https://www.postgresql.org/docs/current/geqo.html) algorithm will only be used to plan queries where the number of tables in the [`FROM` clause](https://www.postgresql.org/docs/current/sql-select.html#SQL-FROM) is equal to or greater than this setting.

  For small queries, we recommend the standard planner that uses full scan. However, for the queries across many tables, a full scan might take more time than a suboptimal plan.

  The minimum value is `2`; the maximum value is `2147483647`; the default value is `12`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-THRESHOLD).

- **Gin pending list limit**{#setting-gin-list-limit} {{ tag-all }}

  Sets the maximum size of a [GIN index's](https://www.postgresql.org/docs/current/gin-intro.html) pending list in bytes. The list is used when `fastupdate` mode is enabled. If the pending list exceeds the specified limit, its entries are moved to the index's main GIN data structure in bulk and the list is cleared.

  The minimum value is `64`; the maximum value is `2147483647` (2 GB); the default value is `4194304`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-GIN-PENDING-LIST-LIMIT).

- **Hash mem multiplier**{#setting-hash-mem-multiplier} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Defines the maximum amount of memory that operations with hash tables can use The amount is calculated by multiplying the setting value by [Work mem](#setting-work-mem).

  The minimum value is `0.0`; the maximum value is `1000.0`; the default value is `1.0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-HASH-MEM-MULTIPLIER).

- **Idle in transaction session timeout**{#setting-idle-session-timeout} {{ tag-all }}

  Open transaction idle timeout (in milliseconds). When exceeded, the transaction's session will be terminated.

  The minimum value is `0`; the maximum value is `2147483647`; the default value is `0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-IDLE-IN-TRANSACTION-SESSION-TIMEOUT).

- **Jit**{#setting-jit} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Enables [Just-in-Time (JIT) compilation](https://www.postgresql.org/docs/current/jit.html) of queries for {{ PG }}. If this setting is enabled, SQL queries are compiled into machine code directly at runtime. This will speed up execution of complex CPU-intensive queries.

  The setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-JIT).

- **Join collapse limit**{#setting-join-collapse-limit} {{ tag-all }}

  As long as the number of elements in the `FROM` list does not exceed this value, the query planner will move explicit `JOIN` instructions (except `FULL JOIN`) to the list. You can decrease planning time using smaller values, but your query plan might get less effective.

  The minimum value is `1`; the maximum value is `2147483647`; the default value is `8`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-JOIN-COLLAPSE-LIMIT).

- **Lo compat privileges**{#setting-lo-compat-privileges} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Disables access permission check for large objects. Prior to version 9.0, large objects were not covered by access permissions, so any user could access them for reading and writing. Enable this setting if you need compatibility with {{ PG }} versions below 9.0.

  The setting is disabled by default (privilege checks are enabled).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-LO-COMPAT-PRIVILEGES).

- **Lock timeout**{#setting-lock-timeout} {{ tag-all }}

  Specifies how long to wait for the lock to be released (in milliseconds). Locks can be used for tables, indexes, rows, and other database objects. If the timeout for an operation has expired, the operation is aborted.

  The minimum value is `0` (disables the timeout; you can await a lock indefinitely); the maximum value is `2147483647`; the default value is `1000`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-LOCK-TIMEOUT).

  The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Log checkpoints**{#setting-log-checkpoints} {{ tag-all }}

  Enables logging of checkpoints and server restart points.

  The setting is disabled by default (no logging).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-CHECKPOINTS).

- **Log connections**{#setting-log-connections} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Enables logging of all attempts to connect to the {{ PG }} server, including those where clients were successfully authenticated.

  The setting is disabled by default (no logging).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-CONNECTIONS).

- **Log disconnections**{#setting-log-disconnections} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Enables logging of session terminations.

  The setting is disabled by default (no logging).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-DISCONNECTIONS).

- **Log duration**{#setting-log-duration} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Enables logging of the duration of each completed statement.

  The setting is disabled by default (no logging).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-DURATION).

- **Log error verbosity**{#setting-log-error-verbosity} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  This setting controls the amount of detail written to the {{ PG }} log for each message. Log detail levels in ascending order of verbosity:

  - `terse` (`LOG_ERROR_VERBOSITY_TERSE` for {{ TF }}, CLI, and API). The `DETAIL`, `HINT`, `QUERY`, and `CONTEXT` fields are excluded from the error message.
  - `default` (`LOG_ERROR_VERBOSITY_DEFAULT` for {{ TF }}, CLI, and API). Default.
  - `verbose` (`LOG_ERROR_VERBOSITY_VERBOSE` for {{ TF }}, CLI, and API). The error message includes the `SQLSTATE` error code, the source code file name, function name, and the number of the row that generated the error.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-ERROR-VERBOSITY).

- **Log lock waits**{#setting-log-lock-waits} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Controls logging of long lock waits. When enabled, a log entry is created when a {{ PG }} session waits longer than [Deadlock timeout](#setting-deadlock-timeout) to get a lock.

  The setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-LOCK-WAITS).

- **Log min duration sample**{#setting-log-min-duration-sample} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  This setting is similar to [Log min duration statement](#setting-log-min-duration-statement), but only applies to the statements listed in [Log statement sample rate](#setting-log-statement-sample-rate).

  If set to `0`, the duration is logged for all the specified statements.

  The minimum value is `-1` (disables statement runtime logging); the maximum value is `2147483647`; the default value is `-1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-DURATION-SAMPLE).

- **Log min duration statement**{#setting-log-min-duration-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  This setting specifies the minimum statement runtime required to log the statement (in milliseconds).

  If set to `0`, the runtime of all statements is logged.

  The minimum value is `-1` (disables runtime logging); the maximum value is `2147483647`; the default value is `-1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-DURATION-STATEMENT).

  The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Log min error statement**{#setting-log-min-error-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Defines the logging level for errors of SQL statement execution. A message about statement execution is logged if it at least has the specified severity level. Possible values: `DEBUG5`, `DEBUG4`, `DEBUG3`, `DEBUG2`, `DEBUG1`, `INFO`, `NOTICE`, `WARNING`, `ERROR`, `LOG`, `FATAL`, and `PANIC`.

  The default value is `ERROR`. This means that the {{ PG }} log will include statements that ended with a message with the `ERROR`, `LOG`, `FATAL`, or `PANIC` severity level.

  To disable logging the majority of statements with errors, select the `PANIC` value.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-ERROR-STATEMENT).

- **Log min messages**{#setting-log-min-messages} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  This setting defines the logging level in {{ PG }}. All messages of the selected severity level (or higher) are logged. Possible values (in ascending order of severity): `DEBUG5`, `DEBUG4`, `DEBUG3`, `DEBUG2`, `DEBUG1`, `INFO`, `NOTICE`, `WARNING`, `ERROR`, `LOG`, `FATAL`, and `PANIC`.

  The default value is `WARNING`. This means that the {{ PG }} log will include all messages with the `WARNING`, `ERROR`, `LOG`, `FATAL`, and `PANIC` severity level.

  To disable logging of most messages, select `PANIC`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-MESSAGES).

- **Log parameter max length**{#setting-log-parameter-max-length} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Reduces to a specified number of bytes the value of each referenced SQL parameter that is output together with SQL operators when logging all messages other than error messages.

  If set to `0`, logging is disabled.

  The minimum value is `-1` (parameter values are logged fully); the maximum value is `1073741823`. By default, the minimum value is used.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-PARAMETER-MAX-LENGTH).

- **Log parameter max length on error**{#setting-log-parameter-max-length} {{ tag-all }}

  Reduces to a specified number of bytes the value of each referenced SQL parameter that is output together with SQL operators when logging error messages.

  If set to `0`, logging is disabled.

  The minimum value is `-1` (parameter values are logged fully); the maximum value is `1073741823`. By default, the minimum value is used.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-PARAMETER-MAX-LENGTH-ON-ERROR).

- **Log recovery conflict waits**{#setting-log-recovery-conflict-waits} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Controls logging of long recovery conflict waits when reading WAL to continue replication. When enabled, a log entry is created when a {{ PG }} session waits longer than [Deadlock timeout](#setting-deadlock-timeout) to resolve a recovery conflict. {{ PG }} supports this feature starting from version 14.

  The setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-RECOVERY-CONFLICT-WAITS).

- **Log statement**{#setting-log-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Filter for SQL statements that will be written to the {{ PG }} log:

  - `none` (`LOG_STATEMENT_NONE` for {{ TF }}, CLI, and API): The filter is disabled, no SQL statements are logged.
  - `ddl` (`LOG_STATEMENT_DDL` for {{ TF }}, CLI, and API): Logs the SQL statements allowing to change data structure definitions (`CREATE`, `ALTER`, `DROP` etc.).
  - `mod` (`LOG_STATEMENT_MOD` for {{ TF }}, CLI, and API): Logs the `ddl`-filtered SQL statements and the statements allowing to modify data (`INSERT`, `UPDATE`, etc.).
  - `all` (`LOG_STATEMENT_ALL` for {{ TF }}, CLI, and API): Logs all SQL statements.

  The default value is `none`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html).

  The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Log statement sample rate**{#setting-log-statement-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Rate of SQL statements that will be logged in addition to statements logged for other reasons.

  The minimum value is `0.0`; the maximum value is `1.0`; the default value is `0.0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-STATEMENT-SAMPLE-RATE).

- **Log temp files**{#setting-log-temp-files} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Sets the minimum size of a temporary file to be logged in {{ PG }} when deleted.

  The minimum value is `-1` (information about deleted files is not logged); the maximum value is `2147483647` (2 GB). If set to `0`, the sizes and names of all temporary files are logged. Default: `-1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-TEMP-FILES).

- **Log transaction sample rate**{#setting-log-transaction-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Rate of transactions whose statements will be logged in addition to statements logged for other reasons.

  The minimum value is `0.0`; the maximum value is `1.0`; the default value is `0.0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-TRANSACTION-SAMPLE-RATE).

- **Logical decoding work mem**{#setting-logical-decoding-work-mem} {{ tag-all }}

  Maximum memory (in bytes) allocated for [logical decoding](https://www.postgresql.org/docs/current/logicaldecoding.html) before writing to a local storage. The setting limits the amount of memory used in the connection for logical replication.

  The minimum value is `65536` (64 KB); the maximum value is `1099511627776` (1 TB); the default value is `67108864` (64 MB).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-LOGICAL-DECODING-WORK-MEM).

- **Maintenance io concurrency**{#setting-maintenance-io-concurrency} {{ tag-all }}

  Maximum number of concurrent disk I/O operations during {{ PG }} maintenance using the `VACUUM`, `CREATE INDEX`, and `ALTER TABLE ADD FOREIGN KEY` statements for an individual DB session. The higher this number, the more maintenance statements {{ PG }} will attempt to execute in parallel within a session.

  The minimum value is `0`; the maximum value is `1000`; the default value is `10`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAINTENANCE-IO-CONCURRENCY).

- **Maintenance work mem**{#setting-maintenance-work-mem} {{ tag-all }}

  Maximum memory (in bytes) for {{ PG }} maintenance operations, such as `VACUUM`, `CREATE INDEX`, and `ALTER TABLE ADD FOREIGN KEY`. The value must be a multiple of 1,024.

  The minimum value is `1048576` (1 MB); the maximum value is `137438953472` (128 GB); the default value is `67108864` (64 MB).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAINTENANCE-WORK-MEM).

- **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Maximum number of simultaneous connections to a {{ PG }} host.

  The minimum value is `1`. The maximum and default values [depend on the selected host class](#settings-instance-dependent) and the formula:

  ```text
  200 × <number_of_vCPUs_per_host>
  ```

  Hosts with guaranteed vCPU share under 100% (`burstable`) use the fixed maximum value of `200`.

  By default, the maximum value is used.

  {% include [note-pg-user-connections.md](../../mdb/note-pg-user-connections.md) %}

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-connection.html#GUC-MAX-CONNECTIONS).

- **Max locks per transaction**{#setting-max-locks-transaction} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Maximum number of objects that can be locked by a single transaction. Individual transactions can lock more objects if the locks of all transactions fit in the lock table.

  The minimum value is `10`; the maximum value is `2147483647`; the default value is `64`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-locks.html#GUC-MAX-LOCKS-PER-TRANSACTION).

- **Max logical replication workers**{#setting-max-logical-replication-workers} {{ tag-con }}

  Maximum number of {{ PG }} logical replication processes.

  It can range from `4` to `100`. By default, the minimum value is used.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-LOGICAL-REPLICATION-WORKERS).

- **Max parallel maintenance workers**{#setting-max-parallel-maintenance-workers} {{ tag-all }}

  Maximum number of parallel {{ PG }} processes initiated by a single utility statement (e.g., `CREATE INDEX`).

  The minimum value is `0`; the maximum value is `1024`; the default value is `2`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PARALLEL-MAINTENANCE-WORKERS).

- **Max parallel workers**{#setting-max-parallel-workers} {{ tag-all }}

  Maximum number of parallel {{ PG }} processes.

  The minimum value is `0`; the maximum value is `1024`; the default value is `8`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PARALLEL-WORKERS).

- **Max parallel workers per gather**{#setting-max-parallel-workers-gather} {{ tag-all }}

  Maximum number of parallel processes that can be started by a single [Gather](https://www.postgresql.org/docs/current/how-parallel-query-works.html) node.

  The minimum value is `0`; the maximum value is `1024`; the default value is `2`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PARALLEL-WORKERS-PER-GATHER).

- **Max pred locks per transaction**{#setting-max-pred-locks-transaction} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Maximum number of objects that can be locked by [predicate locks](https://www.postgresql.org/docs/current/transaction-iso.html#XACT-SERIALIZABLE) per transaction. Individual transactions can lock more objects than specified in the setting if the locks of all transactions fit in the lock table.

  The minimum value is `10`; the maximum value is `2147483647` (2 GB); the default value is `64`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-locks.html#GUC-MAX-PRED-LOCKS-PER-TRANSACTION).

- **Max prepared transactions**{#setting-max-prepared-transactions} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Maximum number of transactions in [prepared state](https://www.postgresql.org/docs/current/sql-prepare-transaction.html) at the same time.

  The minimum value is `0`; the maximum value is `262143`; the default value is `0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PREPARED-TRANSACTIONS).

- **Max replication slots**{#setting-max-replication-slots} {{ tag-con }}

  Maximum number of [replication slots](https://www.postgresql.org/docs/current/warm-standby.html#STREAMING-REPLICATION-SLOTS). Replication slots automatically provide a mechanism for saving [WAL](https://www.postgresql.org/docs/current/wal-intro.html) (Write-Ahead Log) files until they are received by all replicas.

  It can range from `20` to `100`. By default, the minimum value is used.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-REPLICATION-SLOTS).

- **Max slot wal keep size**{#setting-max-slot-wal-keep-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Maximum size (in bytes) of the files of the [Write-Ahead Log (WAL)](https://www.postgresql.org/docs/current/wal-intro.html) stored on the master host during replication.

  The minimum value is `67108864` (64 MB). The maximum value is 50% of the [storage](../../../managed-postgresql/concepts/storage.md) size. The default value is `-1` (unlimited). The value must be a multiple of 1,024.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-SLOT-WAL-KEEP-SIZE).

- **Max standby streaming delay**{#setting-max-standby-streaming-delay} {{ tag-all }}

  Waiting time (in milliseconds) after which the hot standby host replica will start canceling the queries conflicting with pending [WAL](https://www.postgresql.org/docs/current/wal-intro.html) updates.

  The minimum value is `-1` (unlimited waiting time); the maximum value is `2147483647`; the default value is `30000` (30 seconds).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-STANDBY-STREAMING-DELAY).

- **Max wal senders**{#setting-max-wal-senders} {{ tag-con }}

  The maximum number of concurrent connections from streaming replication source hosts.

  It can range from `20` to `100`. By default, the minimum value is used.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-WAL-SENDERS).

- **Max wal size**{#setting-max-wal-size} {{ tag-all }}

  Maximum [WAL](https://www.postgresql.org/docs/current/wal-intro.html) file size (in bytes) that, when reached, will initiate completing automatic checkpoints.

  The minimum value is `2`. The maximum value [depends on storage size](#settings-instance-dependent) and equals 10% of that value, but not more than `8589934592` (8 GB). By default, the maximum value is used.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-MAX-WAL-SIZE).

- **Max worker processes**{#setting-max-worker-processes} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Maximum number of {{ PG }} background processes that can be run in the current system.

  The minimum value is `0`; the maximum value is `1024`; the default value is `8`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-WORKER-PROCESSES).

- **Min wal size**{#setting-min-wal-size} {{ tag-all }}

  Amount of disk space (in bytes) taken up by the [WAL](https://www.postgresql.org/docs/current/wal-intro.html) the exceeding of which will cause deletion of old WAL files at checkpoints.

  The minimum value is `2`. The maximum value [depends on storage size](#settings-instance-dependent) and equals 5% of that value, but not more than `1073741824` (1 GB). By default, the maximum value is used.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-MIN-WAL-SIZE).

- **Old snapshot threshold**{#setting-old-snapshot-threshold} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Minimum time (in milliseconds) during which a status snapshot can be used for query without the risk of an error.

  The minimum value is `-1` (unlimited); the maximum value is `86400000` (24 hours); the default value is `-1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-OLD-SNAPSHOT-THRESHOLD).

- **Online analyze enable**{#setting-online-analyze} {{ tag-con }} {{ tag-api }}

  Enables the `online_analyze` module that updates statistics after the `INSERT`, `UPDATE`, `DELETE`, or `SELECT INTO` operations in the target tables.

- **Operator precedence warning**{#setting-operator-precedence-warning} {{ tag-all }}

  Allows the query parser to emit a warning for any constructs that changed their behavior since version 9.4 as a result of changes in operator precedence. This feature is not supported by {{ PG }} starting from version 14.

  The setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/13/runtime-config-compatible.html#GUC-OPERATOR-PRECEDENCE-WARNING).

- **Parallel leader participation**{#setting-parallel-leader-participation} {{ tag-all }}

  Allows the leader process to execute the query plan downstream of Gather and Gather Merge nodes without waiting for workflows.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-PARALLEL-LEADER-PARTICIPATION).

- **Pg hint plan debug print**{#setting-pghint-plan-debug} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Debugging information output and detail setting for the `pg_hint_plan` module. Only applies when [Pg hint plan enable hint](#setting-pg-hint-plan-enable) is enabled. Possible values (in ascending order of verbosity):

  - `off` (`PG_HINT_PLAN_DEBUG_PRINT_OFF` for {{ TF }} and API): The output is disabled.
  - `on` (`PG_HINT_PLAN_DEBUG_PRINT_ON` for {{ TF }} and API): Default.
  - `detailed` (`PG_HINT_PLAN_DEBUG_PRINT_DETAILED` for {{ TF }} and API).
  - `verbose` (`PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` for {{ TF }} and API).

- **Pg hint plan enable hint**{#setting-pg-hint-plan-enable} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Enables the use of the `pg_hint_plan` module to correct automatic query plans with the help of so-called <q>hints</q>, which are simple descriptions contained in special SQL comments.

- **Pg hint plan enable hint table**{#setting-pg-hint-plan-enable-hint-table} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Enables the use of the `hint_plan.hints` table. It contains <q>hints</q> for the `pg_hint_plan` module and is used when you cannot edit queries. The table contains the following columns:

  - `id`: Unique ID of the row with the <q>hint</q>. This column is populated automatically.
  - `norm_query_string`: Template for selecting the queries the <q>hint</q> will refer to. Replace constants with the `?` character. Whitespace characters in the template are significant.
  - `application_name`: Application that initiated the sessions the <q>hint</q> will operate in.
  - `hint`: <q>Hints</q> without the comment markup.

- **Pg hint plan message level**{#setting-pg-hint-plan-message} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Level of debug messages for the `pg_hint_plan` module that will get into the {{ PG }} log. Only applies when [Pg hint plan enable hint](#setting-pg-hint-plan-enable) is enabled. The possible values are:

  - `error`
  - `warning`
  - `notice`
  - `info` (default)
  - `log`
  - `debug`

- **Pg qualstats enabled**{#setting-pg-qualstats-enabled} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Activates the `pg_qualstats` module to collect statistics on predicates in `WHERE` operators and `JOIN` blocks. It is used to analyze the most frequently calculated query predicates.

- **Pg qualstats max**{#setting-pg-qualstats-max} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Maximum number of tracked predicates for the `pg_qualstats` module. Only applies when the [Pg qualstats enabled](#setting-pg-qualstats-enabled) setting is on.

  The minimum value is `100`; the maximum value is `2147483647`; the default value is `1000`.

- **Pg qualstats resolve oids**{#setting-pg-qualstats-resolve-oids} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Enables table name recovery using `OID` when collecting query statistics for the `pg_qualstats` module. The setting makes it easier to analyze data, but requires more disk space for storing statistics. Only applies when the [Pg qualstats enabled](#setting-pg-qualstats-enabled) setting is on.

  The setting is disabled by default.

- **Pg qualstats sample rate**{#setting-pg-qualstats-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Rate of queries (as a number from 0 to 1) the `pg_qualstats` module collects statistics for. Only applies when the [Pg qualstats enabled](#setting-pg-qualstats-enabled) setting is on. Specific setting values:

  - `0`: Disables the setting.
  - `1`: All queries are analyzed.
  - `-1`: Automatic mode, the rate of queries is inverse to the [Max connections](#setting-max-connections) setting value and [depends on selected host class](#settings-instance-dependent).

  The default value is `-1`.

- **Pg qualstats track constants**{#setting-pg-qualstats-track-constants} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Enables tracking of already encountered predicates in subsequent queries when collecting statistics using  the `pg_qualstats` module. Only applies when the [Pg qualstats enabled](#setting-pg-qualstats-enabled) setting is on.

  This setting is on by default.

- **Plan cache mode**{#setting-plan-cache-mode} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Determines which type of query plan (generic or custom) will be used to execute [prepared statements](https://www.postgresql.org/docs/current/sql-prepare.html). The possible values are:

  - `auto` (`PLAN_CACHE_MODE_AUTO` for {{ TF }} and API): Automatic selection.
  - `force_custom_plan` (`PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN` for {{ TF }} and API): Force custom plans.
  - `force_generic_plan` (`PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` for {{ TF }} and API): Force generic plans.

  The default value is `auto`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-PLAN-CACHE_MODE).

- **Plantuner fix empty table**{#setting-plantuner-fix-empty-table} {{ tag-con }} {{ tag-api }}

  Allows the `plantuner` module to hide individual indexes from the planner to prevent their use in query plans.

  The setting is disabled by default.

- **Quote all identifiers**{#setting-quote-identifiers} {{ tag-all }}

  Forces enclosing all identifiers in quotation marks when generating SQL queries from a database, e.g., when running the `EXPLAIN` operation.

  The setting is disabled by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-QUOTE-ALL-IDENTIFIERS).

- **Random page cost**{#setting-random-page-cost} {{ tag-all }}

  Sets the planner's estimate of the cost of reading an arbitrary disk page. If the setting value is less than [Seq page cost](#setting-seq-page-cost), the planner will prefer index scans.

  The minimum value is `0`; the default value is `1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-RANDOM-PAGE-COST).

- **Row security**{#setting-row-security} {{ tag-all }}

  Controls processing of queries that apply at least one [row security policy](https://www.postgresql.org/docs/current/sql-createpolicy.html). If you disable the setting, such queries will return an error.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-ROW-SECURITY).

- **Search path**{#setting-search-path} {{ tag-all }}

  Comma-separated list of DB schemas. When accessing objects in these schemas, the schema name can be omitted.

  The default value is `$user, public` (the current user schema and the `public` schema).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-SEARCH-PATH).

- **Seq page cost**{#setting-seq-page-cost} {{ tag-all }}

  Sets the planner's estimate of the cost of a disk page read when doing a series of sequential reads.

  The minimum value is `0`; the default value is `1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#RUNTIME-CONFIG-QUERY-CONSTANTS).

- **Session duration timeout**{#setting-session-duration-timeout} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Maximum TTL of the longest active session or transaction (in milliseconds). Only applies to sessions with the `active` and `idle in transaction` status.
  
  To make sure the setting does not impact the cluster performance, the longest transaction/session is checked on a regular basis. The checking interval is selected randomly and ranges from 5 to 10 minutes. For example, if set to `1000`, the session will terminate within 1 second + 5 to 10 minutes.
  
  If the value you set is larger than the default one, this may increase the DB size and slow down the OS.

  The minimum value is `0` (the active session/transaction TTL is unlimited); the maximum value is `2147483647`; the default value is `43200000` (12 hours). The minimum granularity for the setting is `1000`.

  For more information about possible session statuses, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

- **Shared buffers**{#setting-shared-buffers} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Memory (in bytes) {{ PG }} can use for shared memory buffers.

  The minimum value is `131072` (128 KB). The maximum value [depends on the selected host class](#settings-instance-dependent) and is equal to 80% of the {{ mpg-name }} cluster host's total RAM. By default, the value is 25% of the total RAM size, with a maximum of 8 GB.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-SHARED-BUFFERS).

- **Shared preload libraries**{#setting-shared-libraries} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Comma-separated list of shared libraries to preload when the {{ PG }} server starts. Libraries are required for using some [{{ PG }} extensions](../../../managed-postgresql/operations/extensions/cluster-extensions.md).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-SHARED-PRELOAD-LIBRARIES).

- **Standard conforming strings**{#setting-standard-strings} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Treating backslashes (`\`) in regular string constants (`'...'`) as a regular character (as per the SQL standard), not as as a special character.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-STANDARD-CONFORMING-STRINGS).

- **Statement timeout**{#setting-statement-timeout} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Maximum statement runtime (in milliseconds) after which the statement is aborted.

  The minimum value is `0`; the maximum value is `2147483647`; the default value is `0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-STATEMENT-TIMEOUT).

- **Synchronize seqscans**{#setting-synchronize-seqscans} {{ tag-all }}

  Allows sequential scans of large tables to synchronize with each other, so that concurrent scans read the same block at about the same time. When disabled, ensures pre-8.3 behavior where a sequential scan always started from the beginning of the table.

  This setting is on by default.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-SYNCHRONIZE-SEQSCANS).

- **Synchronous commit**{#setting-synchronous-commit} {{ tag-all }}

  Determines at what stage of [WAL](https://www.postgresql.org/docs/current/wal-intro.html) data processing the server will commit a transaction.

  Acceptable values:

  {% list tabs group=instructions %}

  - Management console/CLI {#console}

    - `on`: Transaction is committed if the WAL is written to the master disk and quorum replica disk.
    - `off`: Transaction is committed even if its data is not yet in the WAL. Writes are not synchronous, and the transaction data might be lost as a result of a disk subsystem failure.
    - `local`: Transaction is committed if the WAL is written to the master disk.
    - `remote_write`: Transaction is committed if the WAL is written to the master disk, the quorum replica received the WAL and forwarded it to the OS to write it to the disk. If the master disk system is lost and the OS on the quorum replica fails, transaction data with this level of synchronization may be lost.
    - `remote_apply`: Transaction is committed if the WAL is written to the master disk, the quorum replica received the WAL and applied the updates from it.

    The default value is `on`.

  - {{ TF }} {#tf}

    - `1` or `"SYNCHRONOUS_COMMIT_ON"`: Transaction is committed if the WAL is written to the master disk and quorum replica disk.
    - `2` or `"SYNCHRONOUS_COMMIT_OFF"`: Transaction is committed even if its data is not yet in the WAL. Writes are not synchronous, and the transaction data might be lost as a result of a disk subsystem failure.
    - `3` or `"SYNCHRONOUS_COMMIT_LOCAL"`: Transaction is committed if the WAL is written to the master disk.
    - `4` or `"SYNCHRONOUS_COMMIT_REMOTE_WRITE"`: Transaction is committed if the WAL is written to the master disk, the quorum replica received the WAL and forwarded it to the OS to write it to the disk. If the master disk system is lost and the OS on the quorum replica fails, transaction data with this level of synchronization may be lost.
    - `5` or `"SYNCHRONOUS_COMMIT_REMOTE_APPLY"`: Transaction is committed if the WAL is written to the master disk, the quorum replica received the WAL and applied the changes from it.

    The default value is `"SYNCHRONOUS_COMMIT_ON"`.

  - API {#api}

    - `SYNCHRONOUS_COMMIT_ON`: Transaction is committed if the WAL is written to the master disk and quorum replica disk.
    - `SYNCHRONOUS_COMMIT_OFF`: Transaction is committed even if its data is not yet in the WAL. Writes are not synchronous, and the transaction data might be lost as a result of a disk subsystem failure.
    - `SYNCHRONOUS_COMMIT_LOCAL`: Transaction is committed if the WAL is written to the master disk.
    - `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Transaction is committed if the WAL is written to the master disk, the quorum replica received the WAL and forwarded it to the OS to write it to the disk. If the master disk system is lost and the OS on the quorum replica fails, transaction data with this level of synchronization may be lost.
    - `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Transaction is committed if the WAL is written to the master disk, the quorum replica received the WAL and applied the changes from it.

    The default value is `SYNCHRONOUS_COMMIT_ON`.

  {% endlist %}

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT).

  The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Temp buffers**{#setting-temp-buffers} {{ tag-all }}

  Maximum memory (in bytes) allocated for temporary buffers in each session.

  The minimum value is `100`; the maximum value is `1073741823` (1 GB); the default value is `8388608` (8 MB).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-TEMP-BUFFERS).

- **Temp file limit**{#setting-temp-file-limit} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Maximum amount of disk space (in bytes) a single process can use for temporary files. A transaction that tries to exceed this limit will be canceled.

  Large queries are executed in the disk space rather than in RAM. Queries that are too large overload the disk and prevent other queries from being executed. The setting prevents queries that degrade performance by limiting the size of temporary files.

  The minimum value is `-1` (no limits); the maximum value is `2147483647` (2 GB); the default value is `-1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-TEMP-FILE-LIMIT).

  The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Timezone**{#setting-timezone} {{ tag-all }}

  Timezone for time output and input.

  The default value is `Europe/Moscow`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-TIMEZONE).

- **Track activity query size**{#setting-track-activity-query-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Memory (in bytes) reserved in each active session for the text of the statement currently being executed.

  The minimum value is `100`; the maximum value is `102400`; the default value is `1024`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-statistics.html#GUC-TRACK-ACTIVITY-QUERY-SIZE).

- **Transform null equals**{#setting-transform-null-equals} {{ tag-all }}

  Enables treating the condition `expression = NULL` as `expression IS NULL`. The condition is true if the expression has the `NULL` value, otherwise it is false. According to the SQL standard, `expression = NULL` always returns `NULL` (unknown value).

  This setting is disabled by default (the SQL standard applies).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-TRANSFORM-NULL-EQUALS).

- **Vacuum cleanup index scale factor**{#setting-vacuum-index-scale-factor} {{ tag-all }}

  Rate of tuples in the index counted in the previous statistics collection. When running the `VACUUM` operation, index statistics are considered obsolete if the ratio of newly inserted tuples to the total number of tuples in the index exceeds this value. In this case, the index will be re-scanned. This feature is not supported by {{ PG }} starting from version 14.

  The minimum value is `0.0`; the maximum value is `10000000000.0`; the default value is `0.1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/12/runtime-config-client.html#GUC-VACUUM-CLEANUP-INDEX-SCALE-FACTOR).

- **Vacuum cost delay**{#setting-vacuum-cost-delay} {{ tag-all }}

  Time (in milliseconds) the `VACUUM` and `ANALYZE` operations will remain idle if the cost limit is exceeded (see [Vacuum cost limit](#setting-vacuum-cost-limit)).

  The minimum value is `0`; the maximum value is `100`; the default value is `0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#RUNTIME-CONFIG-RESOURCE-VACUUM-COST).

- **Vacuum cost limit**{#setting-vacuum-cost-limit} {{ tag-all }}

  Accumulated cost threshold at which the `VACUUM` process will go idle (sleep mode).

  The minimum value is `1`; the maximum value is `10000`; the default value is `200`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-LIMIT).

- **Vacuum cost page dirty**{#setting-vacuum-cost-page-dirty} {{ tag-all }}

  Notional cost of a `VACUUM` operation that modifies a block not modified before.

  The minimum value is `0`; the maximum value is `10000`; the default value is `20`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-PAGE-DIRTY).

- **Vacuum cost page hit**{#setting-vacuum-cost-page-hit} {{ tag-all }}

  Notional cost of vacuuming a buffer found in shared cache.

  The minimum value is `0`; the maximum value is `10000`; the default value is `1`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-PAGE-HIT).

- **Vacuum cost page miss**{#setting-vacuum-cost-page-miss} {{ tag-all }}

  Notional cost of vacuuming a buffer that has to be read from a disk.

  The minimum value is `0`; the maximum value is `10000`; the default value is `10`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-PAGE-MISS).

- **Vacuum failsafe age**{#setting-vacuum-failsafe-age} {{ tag-con }} {{ tag-api}} {{ tag-cli }}

  Maximum age of <q>frozen</q> (already completed) transaction measured as the number of transactions initiated after it. As soon as this value is reached, the `VACUUM` process runs vacuuming to avoid transaction counter overflow. {{ PG }} supports this feature starting from version 14.

  The minimum value is `0`; the maximum value is `2100000000`; the default value is `1600000000`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-VACUUM-FAILSAFE-AGE).

- **Vacuum multixact failsafe age**{#setting-vacuum-multixact-failsafe-age} {{ tag-con }} {{ tag-api}} {{ tag-cli }}

  Maximum age of frozen (already completed) [multi-transaction](https://www.postgresql.org/docs/14/routine-vacuuming.html#VACUUM-FOR-MULTIXACT-WRAPAROUND) measured as the number of multi-transactions initiated after it. As soon as this value is reached, the `VACUUM` process runs vacuuming to avoid multi-transaction counter overflow. {{ PG }} supports this feature starting from version 14.

  The minimum value is `0`; the maximum value is `2100000000`; the default value is `1600000000`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-VACUUM-MULTIXACT-FAILSAFE-AGE).

- **Wal keep size**{#setting-wal-keep-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Minimum size (in bytes) of obsolete log segments kept in the [WAL](https://www.postgresql.org/docs/current/wal-intro.html) directory for [replicas](../../../managed-postgresql/concepts/replication.md#replication) to download, if required.

  The minimum value is `0` (past segments are not saved for replication); the maximum value is `2251799812636672` (2 TB); the default value is `0`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-WAL-KEEP-SIZE).

- **Work mem**{#setting-work-mem} {{ tag-all }}

  Basic memory (in bytes) available for internal query processing operations (e.g., sorting or hash tables) before making use of temporary files on disk.

  The minimum value is `64`; the maximum value is `2147483647` (2 GB); the default value is `4194304` (4 MB).

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-WORK-MEM).

- **Xmlbinary**{#setting-xmlbinary} {{ tag-all }}

  Method used for encoding binary data in XML. The possible values are:

  - `base64` (`XML_BINARY_BASE64` for {{ TF }}, API, and CLI): BASE64 encoding.
  - `hex` (`XML_BINARY_HEX` for {{ TF }}, API, and CLI): Hexadecimal encoding.

  The default value is `base64`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-XMLBINARY).

- **Xmloption**{#setting-xmloption} {{ tag-all }}

  Default type of conversion between XML and character data. The possible values are:

  - `document` (`XML_OPTION_DOCUMENT` for {{ TF }}, API, and CLI): XML document.
  - `content` (`XML_OPTION_CONTENT` for {{ TF }}, API, and CLI): XML document fragment.

  The default value is `content`.

  For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-XMLOPTION).
