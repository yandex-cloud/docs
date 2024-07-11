- **Archive timeout**{#setting-archive-timeout} {{ tag-all }}

   Period (in milliseconds) for archiving the {{ PG }} transaction log.

   The minimum value is `10000`, the maximum one is `86400000`. The default value is `30000`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-ARCHIVE-TIMEOUT).

- **Array nulls**{#setting-array-nulls} {{ tag-all }}

   Used to manage recognition of `NULL` elements when inserting an array. If this setting is enabled, these elements are recognized as a `NULL` field. Otherwise, they are recognized as a string containing the word `NULL`.

   This setting is enabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-ARRAY-NULLS).

- **Auto explain log analyze**{#setting-auto-explain-log-analyze} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Determines whether to automatically output query plan statistics to the {{ PG }} log without having to run `EXPLAIN` manually. This allows you to track unoptimized queries. This setting uses the `auto_explain` module. To enable it, [connect the `auto_explain` library](#setting-shared-libraries).

   It is disabled by default (query plan statistics are not logged).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log buffers**{#setting-auto-explain-log-buffers} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Determines whether to output buffer usage statistics to the {{ PG }} log using the `auto_explain` module. Similar to the `BUFFERS` parameter in the `EXPLAIN` command. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

   This setting is disabled by default (buffer usage statistics are not logged).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log min duration**{#setting-auto-explain-log-min-duration} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   The minimum query execution time (in milliseconds) when logging is enabled in the `auto_explain` module.

   The minimum value is `-1` (logging disabled), while the maximum one is `2147483647`. The default value is `-1`. When the value is `0`, execution plans for all queries are logged regardless of their execution time.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log nested statements**{#setting-auto-explain-log-nested-statements} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Determines whether the `auto_explain` module will log the execution of nested queries inside SQL functions. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

   This setting is disabled by default (execution plans are logged for top-level statements).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log timing**{#setting-auto-explain-log-timing} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Determines whether the `auto_explain` module will log timing information for individual query execution plan steps. Similar to the `TIMING` parameter in the `EXPLAIN` command. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

   This setting is disabled by default (timing information for individual steps is not logged).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log triggers**{#setting-auto-explain-log-triggers} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Determines whether to output trigger execution statistics in the `auto_explain` module. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

   This setting is disabled by default (trigger execution statistics are not output).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log verbose**{#setting-auto-explain-log-verbose} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Determines whether to provide log details in the `auto_explain` module. Similar to the `VERBOSE` parameter in the `EXPLAIN` command. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

   This setting is disabled by default (no logging details).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain sample rate**{#setting-auto-explain-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Percentage of queries logged per session using the `auto_explain` module. Applies only when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

   The minimum value is `0.0` (no queries are logged), while the maximum one is `1.0` (all queries are logged). The default value is `1.0`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/auto-explain.html).

- **Autovacuum analyze scale factor**{#setting-autovacuum-analyze-scale-factor} {{ tag-all }}

   Percentage of changed or deleted records in the table that, when reached, triggers [autovacuum](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) to start the `ANALYZE` statistics collection command.

   The minimum value is `0.0`, while the maximum one is `1.0`. The default value is `0.0001`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-ANALYZE-SCALE-FACTOR).

- **Autovacuum max workers**{#setting-autovacuum-max-workers} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-cli }}

   The maximum number of [autovacuum worker processes](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) running in parallel. Autovacuuming runs on for each DB a regular basis, determines the table records marked for deletion, and deletes them.

   The minimum value is `1`, while the maximum one is `32`. The default value [depends on the selected host class](#settings-instance-dependent) and is equal to the number of vCPUs on a single host, with a minimum of `3`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-MAX-WORKERS).

- **Autovacuum naptime**{#setting-autovacuum-naptime} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Sets the minimum interval (in milliseconds) between [autovacuums](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM). If your data changes frequently, you can increase this interval to avoid overloading your database.

   The minimum value is `1000`, while the maximum one is `86400000`. The default value is `15000`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-NAPTIME).

- **Autovacuum vacuum cost delay**{#setting-autovacuum-vacuum-cost-delay} {{ tag-all }}

   The amount of time (in milliseconds) for the [autovacuum](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) process to sleep when the [cost limit](#setting-autovacuum-vacuum-cost-limit) has been exceeded.

   The minimum value is `-1` (the setting is not applied), while the maximum one is `100`. The default value [depends on the selected host class](#settings-instance-dependent).

  - If the number of vCPUs for the selected host class is 10 or more, the value is set to `5`.
  - In other cases, the default value is calculated using the following formula:

      ```text
      55 - 5 × <number_of_vCPUs_per_host>
      ```

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-COST-DELAY).

- **Autovacuum vacuum cost limit**{#setting-autovacuum-vacuum-cost-limit} {{ tag-all }}

   The cost limit that, when exceeded, will freeze the [autovacuum process](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) for the time specified by the [Autovacuum vacuum cost delay](#setting-autovacuum-vacuum-cost-delay) parameter.

   The minimum value is `-1` (the setting is not applied), while the maximum one is `10000`. The default value [depends on the selected host class](#settings-instance-dependent) and is determined by the formula:

   ```text
   150 × <number_of_vCPUs_per_host> + 400
   ```

   For example:

   | Host class | vCPU | Default value |
   ---|----|-----
   | s2.small | 4 | `150 × 4 + 400 = 1000` |
   | m2.medium | 6 | `150 × 6 + 400 = 1300` |

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-COST-LIMIT).

- **Autovacuum vacuum insert scale factor**{#setting-autovacuum-vacuum-insert-scale-factor} {{ tag-all }}

   Percentage of the table size added to the [Autovacuum vacuum insert threshold](#setting-autovacuum-vacuum-insert-threshold) value that, when reached, triggers the [autovacuum process](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM).

   The minimum value is `0.0`, while the maximum one is `1.0`. The default value is `0.2`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-INSERT-SCALE-FACTOR).

- **Autovacuum vacuum insert threshold**{#setting-autovacuum-vacuum-insert-threshold} {{ tag-all }}

   Sets the number of rows that, when inserted into a table, triggers the [autovacuum process](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM).

   The minimum value is `-1` (the setting is not applied), while the maximum one is `2147483647`. The default value is `1000`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-INSERT-THRESHOLD).

- **Autovacuum vacuum scale factor**{#setting-autovacuum-vacuum-scale-factor} {{ tag-all }}

   Percentage of changed or deleted records in the table that, when reached, triggers [autovacuum](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) to start the `VACUUM` cleaning command.

   The minimum value is `0.0` (the setting is not applied), while the maximum one is `1.0`. The default value is `0.00001`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-SCALE-FACTOR).

- **Autovacuum work mem**{#setting-autovacuum-work-mem} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-cli }}

   The amount of memory (in bytes) allocated to each [autovacuum process](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM).

   The minimum value is `-1` (the setting is not applied), while the maximum one is `2147483647`. The default value is `-1`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-AUTOVACUUM-WORK-MEM).

- **Backend flush after**{#setting-backend-flush-after} {{ tag-all }}

   The maximum amount of data (in kilobytes) that a utility process can write to the OS kernel's page cache. If it is exceeded, the DBMS commands the OS to flush data to the disk. The higher the parameter, the less likely a slowdown is when flushing data to the disk using `fsync` (for example, on completing a checkpoint).

   The minimum value is `0` (the setting is not applied), while the maximum one is `2048`. The default value is `0`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BACKEND-FLUSH-AFTER).

- **Backslash quote**{#setting-backslash-quote} {{ tag-all }}

   Controls representation of quotation mark in an SQL string.

   Acceptable values include:

  - `backslash_quote` (`BACKSLASH_QUOTE` for {{ TF }}, API, and CLI): Quotation marks can be represented as `\'` (equivalent to `on`).
  - `on` (`BACKSLASH_QUOTE_ON` for {{ TF }}, API, and CLI): Quotation marks can be represented as `\'`.
  - `off` (`BACKSLASH_QUOTE_OFF` for {{ TF }}, API, and CLI): Quotation marks may only be used in the usual SQL way (`''`).
  - `safe_encoding` (`BACKSLASH_QUOTE_SAFE_ENCODING` for {{ TF }}, API, and CLI): Quotation marks may be represented as `\'` only for the client encodings that do not use `\` in multi-byte characters.

   The default value is `safe_encoding`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-BACKSLASH-QUOTE).

- **Bgwriter delay**{#setting-bgwriter-delay} {{ tag-all }}

   Time to sleep (in milliseconds) after running the background writer. This process writes new or changed items from the {{ PG }} buffer to the disk. The delay helps avoid rewriting the same page many times for every page modification and reduce IO load.

   The minimum value is `10`, while the maximum one is `10000`. The default value is `200`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-DELAY).

- **Bgwriter flush after**{#setting-bgwriter-flush-after} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Limits the amount of data processed by the background writer (in kilobytes). When the limit is exceeded, the DBMS instructs the OS to flush this data to disk. This parameter limits the amount of <q>dirty</q> data in the kernel's page cache, reducing the likelihood of stalls when an `fsync` command is issued when the checkpoint is complete, or when the OS writes the data to the disk in the background.

   The minimum value is `0`, while the maximum one is `2048`. The default value is `512`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-FLUSH-AFTER).

- **Bgwriter lru maxpages**{#setting-bgwriter-lru-maxpages} {{ tag-all }}

   Maximum number of {{ PG }} buffers that can be written by the background writer per activity round. The value of zero disables background writing.

   The minimum value is `0`, while the maximum one is `1073741823`. The default value is `100`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-LRU-MAXPAGES).

- **Bgwriter lru multiplier**{#setting-bgwriter-lru-multiplier} {{ tag-all }}

   Multiplies the average need in buffers over the previous rounds to calculate the background writer's buffer need for the next round.

   The minimum value is `0`, while the maximum one is `10`. The default value is `2`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-LRU-MULTIPLIER).

- **Bytea output**{#setting-bytea-output} {{ tag-all }}

   Sets the output format for [binary string values](https://www.postgresql.org/docs/current/datatype-binary.html) (the `bytea` type):

  - `hex` (`BYTEA_OUTPUT_HEX` for {{ TF }}, API, and CLI) encodes binary data as two hexadecimal digits per byte, for example, '`SELECT '\xDEADBEEF';`'.
  - `escape` (`BYTEA_OUTPUT_ESCAPE` for {{ TF }}, API, and CLI) means the standard {{ PG }} format (ASCII characters only).

   The default value is `hex`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/datatype-binary.html).

- **Checkpoint completion target**{#setting-checkpoint-completion-target} {{ tag-all }}

   A fraction of the checkpoint interval that defines the maximum length of issuing a checkpoint. For example, if the value is `0.5`, the system will try to complete the checkpoint in about half the interval before the next checkpoint is issued.

   The minimum value is `0.0`, while the maximum one is `1.0`. The default value is `0.5`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/wal-configuration.html).

- **Checkpoint flush after**{#setting-checkpoint-flush-after} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Size of page cache (in kilobytes) that triggers data flush at a checkpoint. The pages beyond the value are flushed to the disk and deleted from the OS page cache.

   The minimum value is `0`, while the maximum one is `2048`. The default value is `256`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-CHECKPOINT-FLUSH-AFTER).

- **Checkpoint timeout**{#setting-checkpoint-timeout} {{ tag-all }}

   The interval between checkpoints (in milliseconds).

   The minimum value is `30 000`, while the maximum one is `86400000`. The default value is `300 000`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-CHECKPOINT-TIMEOUT).

- **Client connection check interval**{#setting-client-connection-check-interval} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

   Client connection check interval when executing queries (in milliseconds). The check polls the server socket for a connection and aborts long-running queries if it detects that the connection has been terminated. {{ PG }} supports this feature starting from version 14.

   The minimum value is `0` (no check is run), while the maximum one is `2147483647`. By default, the minimum value is used.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-connection.html#GUC-CLIENT-CONNECTION-CHECK-INTERVAL).

- **Client min messages**{#setting-client-min-messages} {{ tag-all }}

   The level of logging messages sent to client applications. Acceptable values (in ascending order of severity): `debug5`, `debug4`, `debug3`, `debug2`, `debug1`, `info`, `notice`, `warning`, `error`, `log`, `fatal`, and `panic` (for {{ TF }}, API, CLI `LOG_LEVEL_DEBUG5`, `LOG_LEVEL_DEBUG4`, `LOG_LEVEL_DEBUG3`, `LOG_LEVEL_DEBUG2`, `LOG_LEVEL_DEBUG1`, `LOG_LEVEL_INFO`, `LOG_LEVEL_NOTICE`, `LOG_LEVEL_WARNING`, `LOG_LEVEL_ERROR`, `LOG_LEVEL_LOG`, `LOG_LEVEL_FATAL`, and `LOG_LEVEL_PANIC`).

   The default value is `NOTICE`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-CLIENT-MIN-MESSAGES).

- **Constraint exclusion**{#setting-constraint-exclusion} {{ tag-all }}

   Allows the query planner to use table constraints to optimize queries.

   Acceptable values include:

  - `on` (`CONSTRAINT_EXCLUSION_ON` for {{ TF }}, API, and CLI): Use constraints for all tables.
  - `off` (`CONSTRAINT_EXCLUSION_OFF` for {{ TF }}, API, and CLI): Do not use constraints.
  - `partition` (`CONSTRAINT_EXCLUSION_PARTITION` for {{ TF }}, API, and CLI): Only use constraints for child tables and `UNION ALL` clauses.

   The default value is `partition`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-CONSTRAINT-EXCLUSION).

- **Cursor tuple fraction**{#setting-cursor-tuple-fraction} {{ tag-all }}

   Sets the planner's estimate of the fraction of rows to be retrieved via a cursor.

   The minimum value is `0.0`, while the maximum one is `1.0`. The default value is `0.1`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-CURSOR-TUPLE-FRACTION).

- **Deadlock timeout**{#setting-deadlock-timeout} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-cli }}

   Waiting time (in milliseconds) before checking for a deadlock condition.

   The minimum value is `1`, while the maximum one is `2147483647`. The default value is `1000`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-locks.html#GUC-DEADLOCK-TIMEOUT).

- **Default statistics target**{#setting-default-statistics-target} {{ tag-all }}

   The maximum number of statistics records for each DB table column. The query planner uses statistics to estimate the number of rows returned by queries to select the most suitable query plan.

   To improve the quality of the planner's estimates, increase the target.

   The minimum value is `1`, while the maximum one is `10000`. The default value is `1000`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-DEFAULT-STATISTICS-TARGET).

- **Default transaction isolation**{#setting-default-transaction-isolation} {{ tag-all }}

   This setting determines the default isolation level to be used for new SQL transactions.

   Acceptable values include:

  - `read committed` (`TRANSACTION_ISOLATION_READ_COMMITTED` for {{ TF }}, API, and CLI): The query only sees the rows that were committed before it started.
  - `read uncommitted` (`TRANSACTION_ISOLATION_READ_UNCOMMITTED` for {{ TF }}, API, and CLI): The behavior of this isolation level in {{ PG }} is identical to `read committed`.
  - `repeatable read` (`TRANSACTION_ISOLATION_REPEATABLE_READ` for {{ TF }}, API, and CLI): All queries in the current transaction only see the rows that were committed before the first query to select or update data in this transaction.
  - `serializable` (`TRANSACTION_ISOLATION_SERIALIZABLE` for {{ TF }}, API, and CLI): The strictest isolation level of all those mentioned. The behavior of this isolation level in {{ PG }} is identical to `repeatable read`. However, if the overlap of read and write operations of parallel serializable transactions is incompatible with their serial execution, one of the transactions is rolled back with the <q>serialization failure</q> error.

   The default value is `read committed`.

   To learn more about isolation levels, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/transaction-iso.html).

   The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Default transaction read only**{#setting-default-transaction-read-only} {{ tag-all }}

   Sets the <q>read only</q> mode in each new transaction for any tables except temporary ones.

   This setting is disabled by default (both reads and writes are allowed).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-DEFAULT-TRANSACTION-READ-ONLY).

- **Default with oids**{#setting-default-with-oids} {{ tag-all }}

   Adds an `OID` column containing a unique row ID. The setting has effect if the table is created:

  - Without specifying `WITH OIDS` or `WITHOUT OIDS`.
  - Using the `SELECT INTO` command.

   Using `OID` is considered deprecated in user tables, so enable this setting for backward compatibility reasons only.

   Disabled by default (no `OID` column is added).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/11/runtime-config-compatible.html#GUC-DEFAULT-WITH-OIDS).

- **Effective cache size**{#setting-effective-cache-size} {{ tag-all }}

   Sets the assumption about the effective size of the disk cache that is available to a single query. With a higher value, index scans are more likely to be used by the query planner. With a lower value, sequential scans are more likely.

   The minimum value is `0`, while the maximum one is `549755813888` (512 GB). The default value is `107374182400` (100 GB).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-EFFECTIVE-CACHE-SIZE).

- **Effective io concurrency**{#setting-effective-io-concurrency} {{ tag-all }}

   The number of concurrent disk I/O operations for an individual DB session. The higher this number, the more operations {{ PG }} will attempt to initiate in parallel within a session.

   The minimum value is `0`, while the maximum one is `1000`. The default value is `1`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-EFFECTIVE-IO-CONCURRENCY).

- **Enable async append**{#setting-enable-async-append} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

   Allows the query planner to consider asynchronous execution of the query plan on different hosts when adding data from external sources. {{ PG }} supports this feature starting from version 14.

   This setting is enabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-ASYNC-APPEND).

- **Enable bitmapscan**{#setting-enable-bitmapscan} {{ tag-all }}

   Allows the query planner to use the bitmap-scan plan types, even if this is not specified in the query explicitly. This access method is similar to regular access by index, but occurs in two steps:

   1. The index is scanned (Bitmap Index Scan) and a bitmap is built where the rows to be read by the query are flagged.
   1. The table is scanned (Bitmap Heap Scan). Note that:

      - The pages are read sequentially (this increases the likelihood of using the OS cache).
      - Each page is viewed only once.

   The setting is effective when repeating queries to tables.

   This setting is enabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-BITMAPSCAN).

- **Enable gathermerge**{#setting-enable-gathermerge} {{ tag-con }} {{ tag-api}} {{ tag-cli }}

   Allows the query planner to use a Gather Merge node for merging query execution results while preserving their order in the parallel query plan. {{ PG }} supports this feature starting from version 14.

   This setting is enabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-GATHERMERGE).

- **Enable hashagg**{#setting-enable-hashagg} {{ tag-all }}

   Allows the planner to build a hash table from the result set, even if this is not specified in the query explicitly. This setting is effective for frequent unsorted queries to large database tables.

   This setting is enabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-HASHAGG).

- **Enable hashjoin**{#setting-enable-hashjoin} {{ tag-all }}

   Allows the scheduler to `JOIN` tables using the row hash values, even if this is not specified in the query explicitly. This setting is effective when handling large amounts of data or when the tables are not sorted by the join columns.

   This setting is enabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-HASHJOIN).

- **Enable incremental sort**{#setting-enable-incremental-sort} {{ tag-all }}

   Allows the query planner to use incremental sorting. This type of sorting can reduce query execution time and RAM requirements if rows need to be sorted by multiple columns, and one or more of them have already been sorted. {{ PG }} supports this feature starting from version 13.

   This setting is enabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-INCREMENTAL-SORT).

- **Enable indexonlyscan**{#setting-enable-indexonlyscan} {{ tag-all }}

   Allows the query planner to use a table index without accessing the data, even if this is not specified in the query explicitly.

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

   Allows the query planner to use hash-join with parallel hash. The setting only applies when [Enable hashjoin](#setting-enable-hashjoin) is enabled.

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

   Allows the query planner to use TID (tuple identifier) scan plans to speed up queries.

   This setting is enabled by default (the planner uses TID scans).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/ddl-system-columns.html).

- **Escape string warning**{#setting-escape-string-warning} {{ tag-all }}

   A warning is issued if a backslash (`\`) appears in a regular string constant (`'...'` syntax). Only applies if [Standard conforming strings](#setting-standard-strings) is off.

   This setting is enabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-ESCAPE-STRING-WARNING).

- **Exit on error**{#setting-exit-on-error} {{ tag-all }}

   Enables session interruption in case of any error in the query.

   This setting is disabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-error-handling.html).

- **Force parallel mode**{#setting-force-parallel-mode} {{ tag-all }}

   Allows executing queries in parallel mode for testing purposes:

  - `off` (`FORCE_PARALLEL_MODE_OFF` for {{ TF }}, API, and CLI): Use parallel mode only when performance increase is expected.
  - `on` (`FORCE_PARALLEL_MODE_ON` for {{ TF }}, API, and CLI): Force parallelize all the queries where it is safe.
  - `regress` (`FORCE_PARALLEL_MODE_REGRESS` for {{ TF }}, API, and CLI): Equivalent to `on`, but the standard output is the same as when using `off`.

   The default value is `off`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-developer.html).

- **From collapse limit**{#setting-from-collapse-limit} {{ tag-all }}

   Maximum number of items in the `FROM` list. As long as this number is not exceeded, the query planner will merge nested queries with upper queries. You can decrease planning time using smaller values, but your query plan might get less effective.

   The minimum value is `1`, while the maximum one is `2147483647`. The default value is `8`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-FROM-COLLAPSE-LIMIT).

- **Geqo**{#setting-geqo} {{ tag-con }} {{ tag-api }}

   Enables genetic query optimization ([GEQO](https://www.postgresql.org/docs/current/geqo.html)).

   Default value: `false` (genetic optimization is disabled).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO).

- **Geqo effort**{#setting-geqo-effort} {{ tag-con }} {{ tag-api }}

   Used in the [GEQO](https://www.postgresql.org/docs/current/geqo.html) algorithm to set the ratio between the time allotted for query planning and quality of the query execution plan.

   The higher is the value, the longer it takes to plan the query. However, the probability of selecting an efficient query execution plan increases. This setting does not affect the algorithm operation directly but is used to calculate default values for other settings.

   The minimum value is `1`, while the maximum one is `10`. The default value is `5`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-EFFORT).

- **Geqo generations**{#setting-geqo-generations} {{ tag-con }} {{ tag-api }}

   Sets the number of iterations for the [GEQO](https://www.postgresql.org/docs/current/geqo.html) algorithm.

   Useful values are in the range between `100` and `1000`.

   If the value of the setting is `0` (default), the number of algorithm iterations is selected based on the [**Geqo pool size**](#setting-geqo-pool-size) setting.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-GENERATIONS).

- **Geqo pool size**{#setting-geqo-pool-size} {{ tag-con }} {{ tag-api }}

   Sets the number of species in the [GEQO](https://www.postgresql.org/docs/current/geqo.html) algorithm's genetic population.

   Cannot be equal to `1`. Useful values are in the range between `100` and `1000`.

   If the setting is `0` (default), the number of species is selected depending on the [**Geqo effort**](#setting-geqo-effort) setting and the number of tables in the query.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-POOL-SIZE).

- **Geqo seed**{#setting-geqo-seed} {{ tag-con }} {{ tag-api }}

   Sets an initial value for the random number generator used by the [GEQO](https://www.postgresql.org/docs/current/geqo.html) algorithm to select paths in the join sequence search space.

   When you change the setting, you alter the set of join paths examined which might either improve or degrade the resulting path.

   The minimum value is `0`, while the maximum one is `1`. The default value is `0`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-SEED).

- **Geqo selection bias**{#setting-geqo-selection-bias} {{ tag-con }} {{ tag-api }}

   Sets the selective pressure within the [GEQO](https://www.postgresql.org/docs/current/geqo.html) population.

   The minimum value is `1.50`, while the maximum one is `2.00`. The default value is `2.00`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-SELECTION-BIAS).

- **Geqo threshold**{#setting-geqo-threshold} {{ tag-con }} {{ tag-api }}

   The [GEQO](https://www.postgresql.org/docs/current/geqo.html) algorithm will only be used to plan such queries where the number of tables in the [`FROM` clause](https://www.postgresql.org/docs/current/sql-select.html#SQL-FROM) is equal to or greater than this setting.

   For small queries, we recommend the standard planner that uses full scan. However, for the queries across many tables, a full scan might take more time than a suboptimal plan.

   The minimum value is `2`, while the maximum one is `2147483647`. The default value is `12`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-THRESHOLD).

- **Gin pending list limit**{#setting-gin-list-limit} {{ tag-all }}

   Sets the maximum size of a [GIN index's](https://www.postgresql.org/docs/current/gin-intro.html) pending list in bytes. The pending list is used when `fastupdate` mode is enabled. If the pending list exceeds the specified limit, its entries are moved to the index's main GIN data structure in bulk and the list is cleared.

   The minimum value is `64`, while the maximum one is `2147483647` (2 GB). The default value is `4194304`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-GIN-PENDING-LIST-LIMIT).

- **Hash mem multiplier**{#setting-hash-mem-multiplier} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Defines the maximum amount of memory that operations with hash tables can use The amount is calculated by multiplying the setting value by [Work mem](#setting-work-mem).

   The minimum value is `0.0`, while the maximum one is `1000.0`. The default value is `1.0`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-HASH-MEM-MULTIPLIER).

- **Idle in transaction session timeout**{#setting-idle-session-timeout} {{ tag-all }}

   The maximum idle time of an open transaction (in milliseconds). When exceeded, the session running this transaction terminates.

   The minimum value is `0`, while the maximum one is `2147483647`. The default value is `0`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-IDLE-IN-TRANSACTION-SESSION-TIMEOUT).

- **Jit**{#setting-jit} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Enables [Just-in-Time (JIT) compilation](https://www.postgresql.org/docs/current/jit.html) of queries for {{ PG }}. If this setting is enabled, SQL queries are compiled into machine code directly at runtime. This will speed up execution of complex CPU-intensive queries.

   This setting is disabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-JIT).

- **Join collapse limit**{#setting-join-collapse-limit} {{ tag-all }}

   Maximum number of items in the `FROM` list. As long as this value is not exceeded, the planner will move explicit `JOIN` constructs (except `FULL JOIN`s) to the list. You can decrease planning time using smaller values, but your query plan might get less effective.

   The minimum value is `1`, while the maximum one is `2147483647`. The default value is `8`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-JOIN-COLLAPSE-LIMIT).

- **Lo compat privileges**{#setting-lo-compat-privileges} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   Disables access permission check for large objects. Prior to version 9.0, large objects were not covered by access permissions, so any user could access them for reading and writing. Enable this setting if you need compatibility with {{ PG }} versions below 9.0.

   The setting is disabled by default (privilege checks are enabled).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-LO-COMPAT-PRIVILEGES).

- **Lock timeout**{#setting-lock-timeout} {{ tag-all }}

   Specifies how long to wait for the lock to be released (in milliseconds). Locks can be used for tables, indexes, rows, and other database objects. If the timeout for an operation has expired, the operation is aborted.

   The minimum value is `0` (timeout is off, lock waiting time can be indefinite), the maximum one is `2147483647`. The default value is `1000`.

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

   Sets the level of detail for the {{ PG }} log entry per message. Log detail levels in ascending order of verbosity:

  - `terse` (`LOG_ERROR_VERBOSITY_TERSE` for {{ TF }}, CLI, and API). The `DETAIL`, `HINT`, `QUERY`, and `CONTEXT` fields are excluded from the error message.
  - `default` (`LOG_ERROR_VERBOSITY_DEFAULT` for {{ TF }}, CLI, and API). Default.
  - `verbose` (`LOG_ERROR_VERBOSITY_VERBOSE` for {{ TF }}, CLI, and API). The error message includes the `SQLSTATE` error code, the source code file name, function name, and line number that generated the error.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-ERROR-VERBOSITY).

- **Log lock waits**{#setting-log-lock-waits} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   Controls logging of long lock waits. When enabled, a log entry is created when a {{ PG }} session waits longer than [Deadlock timeout](#setting-deadlock-timeout) to get a lock.

   This setting is disabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-LOCK-WAITS).

- **Log min duration sample**{#setting-log-min-duration-sample} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   The setting is similar to [Log min duration statement](#setting-log-min-duration-statement), but only applies to the statements listed in [Log statement sample rate](#setting-log-statement-sample-rate).

   When the value is `0`, the duration is logged for all the specified statements.

   The minimum value is `-1` (disables logging of the statement duration), while the maximum one is `2147483647`. The default value is `-1`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-DURATION-SAMPLE).

- **Log min duration statement**{#setting-log-min-duration-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   Sets the threshold for statement duration logging (in milliseconds).

   When the value is `0`, the duration is logged for all the specified statements.

   The minimum value is `-1` (disables duration logging), while the maximum one is `2147483647`. The default value is `-1`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-DURATION-STATEMENT).

   The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Log min error statement**{#setting-log-min-error-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   Defines the logging level for errors of SQL statement execution. A message about statement execution is logged if it at least has the specified severity level. Acceptable values: `DEBUG5`, `DEBUG4`, `DEBUG3`, `DEBUG2`, `DEBUG1`, `INFO`, `NOTICE`, `WARNING`, `ERROR`, `LOG`, `FATAL`, and `PANIC`.

   The default value is `ERROR`. This means that the {{ PG }} log will include all the statements that ended with a message having the `ERROR`, `LOG`, `FATAL`, and `PANIC` severity level.

   To disable logging of most failed statements, select the `PANIC` value.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-ERROR-STATEMENT).

- **Log min messages**{#setting-log-min-messages} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   Defines the logging level in {{ PG }}. All messages of the selected severity level (or higher) are logged. Acceptable values (in ascending severity): `DEBUG5`, `DEBUG4`, `DEBUG3`, `DEBUG2`, `DEBUG1`, `INFO`, `NOTICE`, `WARNING`, `ERROR`, `LOG`, `FATAL` , and `PANIC`.

   The default value is `WARNING`. This means that the {{ PG }} log will include all the messages with the `WARNING`, `ERROR`, `LOG`, `FATAL`, and `PANIC` severity level.

   To disable logging of most messages, select the `PANIC` value.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-MESSAGES).

- **Log parameter max length**{#setting-log-parameter-max-length} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   Reduces to a specified number of bytes the value of each referenced SQL parameter that is output along with SQL operators when logging all messages except error ones.

   Logging is disabled when the value is `0`.

   The minimum value is `-1` (parameter values are completely logged), while the maximum one is `1073741823`. By default, the minimum value is used.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-PARAMETER-MAX-LENGTH).

- **Log parameter max length on error**{#setting-log-parameter-max-length} {{ tag-all }}

   Reduces to a specified number of bytes the value of each referenced SQL parameter that is output along with SQL operators when logging error messages.

   Logging is disabled when the value is `0`.

   The minimum value is `-1` (parameter values are completely logged), while the maximum one is `1073741823`. By default, the minimum value is used.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-PARAMETER-MAX-LENGTH-ON-ERROR).

- **Log recovery conflict waits**{#setting-log-recovery-conflict-waits} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

   Controls logging of long recovery conflict waits when reading WAL to continue replication. When enabled, a log entry is created when a {{ PG }} session waits longer than [Deadlock timeout](#setting-deadlock-timeout) to resolve a recovery conflict. {{ PG }} supports this feature starting from version 14.

   This setting is disabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-RECOVERY-CONFLICT-WAITS).

- **Log statement**{#setting-log-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   A filter for SQL statements to be written to the {{ PG }} log:

  - `none` (`LOG_STATEMENT_NONE` for {{ TF }}, CLI, and API): Filter is disabled and SQL statements are not logged.
  - `ddl` (`LOG_STATEMENT_DDL` for {{ TF }}, CLI, and API): SQL statements that allow you to change data definitions, such as `CREATE`, `ALTER`, and `DROP`, are logged.
  - `mod` (`LOG_STATEMENT_MOD` for {{ TF }}, CLI, and API): All `ddl` statements and data-modifying statements, such as `INSERT` and `UPDATE`, are logged.
  - `all` (`LOG_STATEMENT_ALL` for {{ TF }}, CLI, and API): All SQL statements are logged.

   The default value is `none`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html).

   The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Log statement sample rate**{#setting-log-statement-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   The rate of SQL statements that will be logged in addition to statements logged for other reasons.

   The minimum value is `0.0`, while the maximum one is `1.0`. The default value is `0.0`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-STATEMENT-SAMPLE-RATE).

- **Log temp files**{#setting-log-temp-files} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   Sets the minimum size of a temporary file to be logged in {{ PG }} when deleted.

   The minimum value is `-1` (information about deleted files is not logged). The maximum value is `2147483647` (2 GB). If `0`, the sizes and names of all temporary files are logged. The default value is `-1`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-TEMP-FILES).

- **Log transaction sample rate**{#setting-log-transaction-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   The rate of transactions whose statements will be logged in addition to statements logged for other reasons.

   The minimum value is `0.0`, while the maximum one is `1.0`. The default value is `0.0`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-TRANSACTION-SAMPLE-RATE).

- **Logical decoding work mem**{#setting-logical-decoding-work-mem} {{ tag-all }}

   The maximum amount of memory (in bytes) allocated for [logical decoding](https://www.postgresql.org/docs/current/logicaldecoding.html) before writing to a local storage. The setting limits the amount of memory used in the connection for logical replication.

   The minimum value is `65536` (64 KB), while the maximum one is `1099511627776` (1 TB). The default value is `67108864` (64 MB).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-LOGICAL-DECODING-WORK-MEM).

- **Maintenance io concurrency**{#setting-maintenance-io-concurrency} {{ tag-all }}

   The maximum number of concurrent disk I/O operations when maintaining {{ PG }} with the commands `VACUUM`, `CREATE INDEX`, and `ALTER TABLE ADD FOREIGN KEY` for an individual DB session. The higher this number, the more maintenance commands {{ PG }} will attempt to initiate in parallel within a session.

   The minimum value is `0`, while the maximum one is `1000`. The default value is `10`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAINTENANCE-IO-CONCURRENCY).

- **Maintenance work mem**{#setting-maintenance-work-mem} {{ tag-all }}

   The maximum amount of memory (in bytes) to be used by {{ PG }} maintenance operations, such as `VACUUM`, `CREATE INDEX`, and `ALTER TABLE ADD FOREIGN KEY`. The value must be a multiple of 1024.

   The minimum value is `1048576` (1 MB), while the maximum one is `137438953472` (128 GB). The default value is `67108864` (64 MB).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAINTENANCE-WORK-MEM).

- **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   The maximum number of simultaneous connections to the {{ PG }} host.

   The minimum value is `1`. The maximum and default values [depend on the selected host class](#settings-instance-dependent) and are determined by the formula:

   ```text
   200 × <number_of_vCPUs_per_host>
   ```

   Hosts with guaranteed vCPU performance under 100% (`burstable`) use the fixed maximum value: `200`.

   By default, the maximum value is used.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-connection.html#GUC-MAX-CONNECTIONS).

- **Max locks per transaction**{#setting-max-locks-transaction} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   The maximum number of objects that can be locked by a single transaction. Individual transactions can lock more objects if the locks of all transactions fit in the lock table.

   The minimum value is `10`, while the maximum one is `2147483647`. The default value is `64`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-locks.html#GUC-MAX-LOCKS-PER-TRANSACTION).

- **Max logical replication workers**{#setting-max-logical-replication-workers} {{ tag-con }}

   The maximum number of {{ PG }} logical replication workers.

   The minimum value is `4`, while the maximum one is `100`. By default, the minimum value is used.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-LOGICAL-REPLICATION-WORKERS).

- **Max parallel maintenance workers**{#setting-max-parallel-maintenance-workers} {{ tag-all }}

   The maximum number of parallel {{ PG }} workers that can be started by a single utility command (for example, `CREATE INDEX`).

   The minimum value is `0`, while the maximum one is `1024`. The default value is `2`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PARALLEL-MAINTENANCE-WORKERS).

- **Max parallel workers**{#setting-max-parallel-workers} {{ tag-all }}

   The maximum number of parallel {{ PG }} workers.

   The minimum value is `0`, while the maximum one is `1024`. The default value is `8`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PARALLEL-WORKERS).

- **Max parallel workers per gather**{#setting-max-parallel-workers-gather} {{ tag-all }}

   The maximum number of parallel workers that can be started by a single [Gather](https://www.postgresql.org/docs/current/how-parallel-query-works.html) node.

   The minimum value is `0`, while the maximum one is `1024`. The default value is `2`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PARALLEL-WORKERS-PER-GATHER).

- **Max pred locks per transaction**{#setting-max-pred-locks-transaction} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   The maximum number of objects that can be locked by [predicate locks](https://www.postgresql.org/docs/current/transaction-iso.html#XACT-SERIALIZABLE) per transaction. Individual transactions can lock more objects than specified in the setting if the locks of all transactions fit in the lock table.

   The minimum value is `10`, while the maximum one is `2147483647` (2 GB). The default value is `64`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-locks.html#GUC-MAX-PRED-LOCKS-PER-TRANSACTION).

- **Max prepared transactions**{#setting-max-prepared-transactions} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   The maximum number of transactions that can be in the [prepared state](https://www.postgresql.org/docs/current/sql-prepare-transaction.html) at the same time.

   The minimum value is `0`, while the maximum one is `262143`. The default value is `0`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PREPARED-TRANSACTIONS).

- **Max replication slots**{#setting-max-replication-slots} {{ tag-con }}

   The maximum number of [replication slots](https://www.postgresql.org/docs/current/warm-standby.html#STREAMING-REPLICATION-SLOTS). Replication slots automatically provide a mechanism for saving [WAL](https://www.postgresql.org/docs/current/wal-intro.html) (Write-Ahead Log) files until they are received by all replicas.

   The minimum value is `20`, while the maximum one is `100`. By default, the minimum value is used.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-REPLICATION-SLOTS).

- **Max slot wal keep size**{#setting-max-slot-wal-keep-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   The maximum size (in bytes) of the files of the [Write-Ahead Log (WAL)](https://www.postgresql.org/docs/current/wal-intro.html) stored on the master host during replication.

   The minimum value is `67108864` (64 MB). The maximum value is 50% of the [storage](../../../managed-postgresql/concepts/storage.md) size. The default value is `-1` (unlimited). The value must be a multiple of 1024.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-SLOT-WAL-KEEP-SIZE).

- **Max standby streaming delay**{#setting-max-standby-streaming-delay} {{ tag-all }}

   Waiting time (in milliseconds) after which the hot standby host replica will start canceling the queries that conflict with the about-to-be-applied [WAL](https://www.postgresql.org/docs/current/wal-intro.html) entries.

   The minimum value is `-1` (unlimited waiting time), the maximum one is `2147483647`. The default value is `30000` (30 seconds).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-STANDBY-STREAMING-DELAY).

- **Max wal senders**{#setting-max-wal-senders} {{ tag-con }}

   The maximum number of concurrent connections from streaming replication source hosts.

   The minimum value is `20`, while the maximum one is `100`. By default, the minimum value is used.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-WAL-SENDERS).

- **Max wal size**{#setting-max-wal-size} {{ tag-all }}

   The maximum [WAL](https://www.postgresql.org/docs/current/wal-intro.html) file size (in bytes) that, when reached, triggers automatic checkpoints.

   The minimum value is `2`. The maximum value [depends on the storage size](#settings-instance-dependent) and is equal to 10% of this value, with a maximum of `8589934592` (8 GB). By default, the maximum value is used.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-MAX-WAL-SIZE).

- **Max worker processes**{#setting-max-worker-processes} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   The maximum number of {{ PG }} background processes that can be run on the current system.

   The minimum value is `0`, while the maximum one is `1024`. The default value is `8`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-WORKER-PROCESSES).

- **Min wal size**{#setting-min-wal-size} {{ tag-all }}

   The amount of disk space (in bytes) occupied by the [WAL](https://www.postgresql.org/docs/current/wal-intro.html) that, when exceeded, triggers deletion of old WAL files at checkpoints.

   The minimum value is `2`. The maximum value [depends on the storage size](#settings-instance-dependent) and is equal to 5% of this value, with a maximum of `1073741824` (1 GB). By default, the maximum value is used.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-MIN-WAL-SIZE).

- **Old snapshot threshold**{#setting-old-snapshot-threshold} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   The minimum time (in milliseconds) that a query snapshot can be used without risk of an error.

   The minimum value is `-1` (unlimited), while the maximum one is `86400000` (24 hours). The default value is `-1`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-OLD-SNAPSHOT-THRESHOLD).

- **Online analyze enable**{#setting-online-analyze} {{ tag-con }} {{ tag-api }}

   Enables the `online_analyze` module that updates statistics after the `INSERT`, `UPDATE`, `DELETE`, or `SELECT INTO` operations in the target tables.

- **Operator precedence warning**{#setting-operator-precedence-warning} {{ tag-all }}

   Allows the query parser to emit a warning for any constructs that changed their behavior since version 9.4 as a result of changes in operator precedence. This feature is not supported by {{ PG }} starting from version 14.

   This setting is disabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/13/runtime-config-compatible.html#GUC-OPERATOR-PRECEDENCE-WARNING).

- **Parallel leader participation**{#setting-parallel-leader-participation} {{ tag-all }}

   Allows the leader process to execute the query plan under Gather and Gather Merge nodes without waiting for worker processes.

   This setting is enabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-PARALLEL-LEADER-PARTICIPATION).

- **Pg hint plan debug print**{#setting-pghint-plan-debug} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Sets the level of output and detail of debugging information for the `pg_hint_plan` module. Only applies when [Pg hint plan enable hint](#setting-pg-hint-plan-enable) is enabled. Possible values (in ascending order of verbosity):

  - `off` (`PG_HINT_PLAN_DEBUG_PRINT_OFF` for {{ TF }} and API): The output is disabled.
  - `on` (`PG_HINT_PLAN_DEBUG_PRINT_ON` for {{ TF }} and API): Default.
  - `detailed` (`PG_HINT_PLAN_DEBUG_PRINT_DETAILED` for {{ TF }} and API).
  - `verbose` (`PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` for {{ TF }} and API).

- **Pg hint plan enable hint**{#setting-pg-hint-plan-enable} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Enables the `pg_hint_plan` module that lets you adjust automatic execution plans using so-called <q>hints</q> that are simple descriptions in the SQL comments of special format.

- **Pg hint plan enable hint table**{#setting-pg-hint-plan-enable-hint-table} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Enables the use of the `hint_plan.hints` table. It contains <q>hints</q> for the `pg_hint_plan` module and is used when it is not possible edit queries. The table contains the following columns:

  - `id`: A unique ID of the row with the <q>hint</q>. This column is populated automatically.
  - `norm_query_string`: A pattern to match the <q>hinted</q> queries. Replace constants with a `?`. Whitespace characters are significant in the pattern.
  - `application_name`: The application that initiated the sessions to apply the <q>hint</q> to.
  - `hint`: A series of <q>hints</q> excluding surrounding comment marks.

- **Pg hint plan message level**{#setting-pg-hint-plan-message} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   The level of debug messages for the `pg_hint_plan` module that will be included in the {{ PG }} log. Only applies when [Pg hint plan enable hint](#setting-pg-hint-plan-enable) is enabled. The possible values include:

  - `error`
  - `warning`
  - `notice`
  - `info` (default)
  - `log`
  - `debug`

- **Pg qualstats enabled**{#setting-pg-qualstats-enabled} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

   Enables the `pg_qualstats` module to collect statistics on predicates in `WHERE` operators and `JOIN` blocks. Used to analyze the most frequently calculated query predicates.

- **Pg qualstats max**{#setting-pg-qualstats-max} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

   The maximum number of tracked predicates for the `pg_qualstats` module. Only applies when [Pg qualstats enabled](#setting-pg-qualstats-enabled) is enabled.

   The minimum value is `100`, while the maximum one is `2147483647`. The default value is `1000`.

- **Pg qualstats resolve oids**{#setting-pg-qualstats-resolve-oids} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

   Enables table name recovery using `OID` when collecting statistics for the `pg_qualstats` module. The setting makes it easier to analyze data, but requires more disk space for storing statistics. Only applies when [Pg qualstats enabled](#setting-pg-qualstats-enabled) is enabled.

   This setting is disabled by default.

- **Pg qualstats sample rate**{#setting-pg-qualstats-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

   Percentage of queries (from 0 to 1) that the `pg_qualstats` module collects statistics for. Only applies when [Pg qualstats enabled](#setting-pg-qualstats-enabled) is enabled. Specific setting values:

  - `0`: Disables the setting.
  - `1`: All queries are analyzed.
  - `-1`: Automatic mode, percentage of queries is inverse to the value of the [Max connections](#setting-max-connections) setting and [depends on the selected host class](#settings-instance-dependent).

   By default, `-1`.

- **Pg qualstats track constants**{#setting-pg-qualstats-track-constants} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

   Enables tracking of already encountered predicates in further queries when statistics are collected by the `pg_qualstats` module. Only applies when [Pg qualstats enabled](#setting-pg-qualstats-enabled) is enabled.

   This setting is enabled by default.

- **Plan cache mode**{#setting-plan-cache-mode} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Determines the type of query plan (generic or custom) to be used to execute [prepared statements](https://www.postgresql.org/docs/current/sql-prepare.html). The possible values include:

  - `auto` (`PLAN_CACHE_MODE_AUTO` for {{ TF }} and API): Automatic selection.
  - `force_custom_plan` (`PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN` for {{ TF }} and API): Force custom plans.
  - `force_generic_plan` (`PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` for {{ TF }} and API): Force generic plans.

   The default value is `auto`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-PLAN-CACHE_MODE).

- **Plantuner fix empty table**{#setting-plantuner-fix-empty-table} {{ tag-con }} {{ tag-api }}

   Allows the `plantuner` module to hide certain indexes from the planner to prevent them from being used in query plans.

   This setting is disabled by default.

- **Quote all identifiers**{#setting-quote-identifiers} {{ tag-all }}

   Forces quoting of all identifiers when generating SQL queries from a database, for example, when running the `EXPLAIN` operation.

   This setting is disabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-QUOTE-ALL-IDENTIFIERS).

- **Random page cost**{#setting-random-page-cost} {{ tag-all }}

   Sets the planner's estimate of the cost of reading an arbitrary disk page. If the setting value is less than [Seq page cost](#setting-seq-page-cost), the planner will prefer index scans.

   The minimum value is `0`. The default value is `1`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-RANDOM-PAGE-COST).

- **Row security**{#setting-row-security} {{ tag-all }}

   Controls processing of queries that apply at least one [row security policy](https://www.postgresql.org/docs/current/sql-createpolicy.html). If you disable the setting, such queries will return an error.

   This setting is enabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-ROW-SECURITY).

- **Search path**{#setting-search-path} {{ tag-all }}

   A comma-separated list of DB schemas. When accessing objects in these schemas, the schema name can be omitted.

   The default value is `$user, public` (the current user schema and `public` schema).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-SEARCH-PATH).

- **Seq page cost**{#setting-seq-page-cost} {{ tag-all }}

   Sets the planner's estimate of the cost of a disk page read when doing a series of sequential reads.

   The minimum value is `0`. The default value is `1`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-query.html#RUNTIME-CONFIG-QUERY-CONSTANTS).

- **Session duration timeout**{#setting-session-duration-timeout} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

   The maximum TTL of the longest active session or transaction (in milliseconds). It applies only to sessions with the `active` and `idle in transaction` status.

   To make sure the setting does not impact the cluster performance, the longest transaction/session is checked on a regular basis. The checking interval is selected randomly and ranges from 5 to 10 minutes. For example, if you set the setting to `1000`, a session will terminate within 1 second + 5 to 10 minutes.

   If the value you set is larger than the default one, this may increase the DB size and slow down the OS.

   The minimum value is `0` (the active session/transaction TTL is unlimited). The maximum value is `2147483647`. The default value is `43200000` (12 hours). The minimum granularity for changing the setting value is `1000`.

   For more information about possible session statuses, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

- **Shared buffers**{#setting-shared-buffers} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   The amount of memory (in bytes) that {{ PG }} can use for shared memory buffers.

   The minimum value is `131072` (128 KB). The maximum value [depends on the selected host class](#settings-instance-dependent) and is equal to 80% of the total RAM size of the {{ mpg-name }} cluster host. By default, the value is 25% of the total RAM size, with a maximum of 8 GB.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-SHARED-BUFFERS).

- **Shared preload libraries**{#setting-shared-libraries} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   A comma-separated list of shared libraries to preload when the {{ PG }} server starts. Libraries are required for using some [{{ PG }} extensions](../../../managed-postgresql/operations/extensions/cluster-extensions.md).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-SHARED-PRELOAD-LIBRARIES).

- **Standard conforming strings**{#setting-standard-strings} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   Treating backslashes (`\`) in regular string constants (`'...'`) literally (as specified in the SQL standard) rather than as a special character.

   This setting is enabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-STANDARD-CONFORMING-STRINGS).

- **Statement timeout**{#setting-statement-timeout} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   The maximum statement duration (in milliseconds) after which the command is aborted.

   The minimum value is `0`, while the maximum one is `2147483647`. The default value is `0`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-STATEMENT-TIMEOUT).

- **Synchronize seqscans**{#setting-synchronize-seqscans} {{ tag-all }}

   Allows sequential scans of large tables to synchronize with each other, so that concurrent scans read the same block at about the same time. When disabled, ensures pre-8.3 behavior where a sequential scan always started from the beginning of the table.

   This setting is enabled by default.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-SYNCHRONIZE-SEQSCANS).

- **Synchronous commit**{#setting-synchronous-commit} {{ tag-all }}

   Determines at what stage of [WAL](https://www.postgresql.org/docs/current/wal-intro.html) data processing the server will commit a transaction.

   Acceptable values include:

   {% list tabs group=instructions %}

  - Management console/CLI {#console}

    - `on`: A transaction is committed if the WAL is written to the master disk and quorum replica disk.
    - `off`: A transaction is committed even if its data is not yet in the WAL. Writes are not synchronous, and the transaction data might be lost as a result of a disk subsystem failure.
    - `local`: A transaction is committed if the WAL is written to the master disk.
    - `remote_write`: A transaction is committed if the WAL is written to the master disk, and the quorum replica received the WAL and forwarded it to the OS to write it to the disk. If the master disk system is lost and the OS on the quorum replica fails, transaction data with this level of synchronization may be lost.
    - `remote_apply`: A transaction is committed if the WAL is written to the master disk, and the quorum replica accepted the WAL and applied the changes from it.

      The default value is `on`.

  - {{ TF }} {#tf}

    - `1` or `"SYNCHRONOUS_COMMIT_ON"`: A transaction is committed if the WAL is written to the master disk and quorum replica disk.
    - `2` or `"SYNCHRONOUS_COMMIT_OFF"` : A transaction is committed even if its data is not yet in the WAL. Writes are not synchronous, and the transaction data might be lost as a result of a disk subsystem failure.
    - `3` or `"SYNCHRONOUS_COMMIT_LOCAL"`: A transaction is committed if the WAL is written to the master disk.
    - `4` or `"SYNCHRONOUS_COMMIT_REMOTE_WRITE"`: A transaction is committed if the WAL is written to the master disk, and the quorum replica received the WAL and forwarded it to the OS to write it to the disk. If the master disk system is lost and the OS on the quorum replica fails, transaction data with this level of synchronization may be lost.
    - `5` or `"SYNCHRONOUS_COMMIT_REMOTE_APPLY"`: A transaction is committed if the WAL is written to the master disk, and the quorum replica accepted the WAL and applied the changes from it.

      The default value is `"SYNCHRONOUS_COMMIT_ON"`.

  - API {#api}

    - `SYNCHRONOUS_COMMIT_ON`: A transaction is committed if the WAL is written to the master disk and quorum replica disk.
    - `SYNCHRONOUS_COMMIT_OFF`: A transaction is committed even if its data is not yet in the WAL. Writes are not synchronous, and the transaction data might be lost as a result of a disk subsystem failure.
    - `SYNCHRONOUS_COMMIT_LOCAL`: A transaction is committed if the WAL is written to the master disk.
    - `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: A transaction is committed if the WAL is written to the master disk, and the quorum replica received the WAL and forwarded it to the OS to write it to the disk. If the master disk system is lost and the OS on the quorum replica fails, transaction data with this level of synchronization may be lost.
    - `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: A transaction is committed if the WAL is written to the master disk, and the quorum replica accepted the WAL and applied the changes from it.

      The default value is `SYNCHRONOUS_COMMIT_ON`.

   {% endlist %}

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT).

   The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Temp buffers**{#setting-temp-buffers} {{ tag-all }}

   The maximum amount of memory (in bytes) allocated for temporary buffers in each session.

   The minimum value is `100`, while the maximum one is `1073741823` (1 GB). The default value is `8388608` (8 MB).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-TEMP-BUFFERS).

- **Temp file limit**{#setting-temp-file-limit} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

   The maximum storage space size (in kilobytes) that a single process can use to create temporary files. A transaction that tries to exceed this limit will be canceled.

   Large queries are executed in the disk space rather than in RAM. Queries that are too large overload the disk and prevent other queries from being executed. The setting prevents queries that degrade performance by limiting the size of temporary files.

   The minimum value is `-1` (no limit), while the maximum one is `2147483647` (2 GB). The default value is `-1`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-TEMP-FILE-LIMIT).

   The setting applies at the {{ mpg-name }} cluster level, but it can be [overridden at the user level](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Timezone**{#setting-timezone} {{ tag-all }}

   Time zone for output and input of time values.

   Default value: `Europe/Moscow`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-TIMEZONE).

- **Track activity query size**{#setting-track-activity-query-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   The amount of memory (in bytes) reserved to store the text of the currently executing command for each active session.

   The minimum value is `100`, while the maximum one is `102400`. The default value is `1024`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-statistics.html#GUC-TRACK-ACTIVITY-QUERY-SIZE).

- **Transform null equals**{#setting-transform-null-equals} {{ tag-all }}

   Enables treating the condition `expression = NULL` as `expression IS NULL`. The condition is true if the expression has the value `NULL`, otherwise it is false. According to the SQL standard, `expression = NULL` always returns `NULL` (an unknown value).

   This setting is disabled by default (the SQL standard applies).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-TRANSFORM-NULL-EQUALS).

- **Vacuum cleanup index scale factor**{#setting-vacuum-index-scale-factor} {{ tag-all }}

   The fraction of heap tuples counted in the previous statistics collection. When running the `VACUUM` operation, index statistics are considered to be stale if the ratio of newly inserted tuples to the total number of heap tuples exceeds this fraction. In this case, the index will be re-scanned. This feature is not supported by {{ PG }} starting from version 14.

   The minimum value is `0.0`, while the maximum one is `10000000000.0`. The default value is `0.1`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/12/runtime-config-client.html#GUC-VACUUM-CLEANUP-INDEX-SCALE-FACTOR).

- **Vacuum cost delay**{#setting-vacuum-cost-delay} {{ tag-all }}

   The amount of time (in milliseconds) for the `VACUUM` and `ANALYZE` operations to sleep when the cost limit has been exceeded (see [Vacuum cost limit](#setting-vacuum-cost-limit)).

   The minimum value is `0`, while the maximum one is `100`. The default value is `0`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#RUNTIME-CONFIG-RESOURCE-VACUUM-COST).

- **Vacuum cost limit**{#setting-vacuum-cost-limit} {{ tag-all }}

   The accumulated cost that will cause the `VACUUM` process to sleep.

   The minimum value is `1`, while the maximum one is `10000`. The default value is `200`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-LIMIT).

- **Vacuum cost page dirty**{#setting-vacuum-cost-page-dirty} {{ tag-all }}

   The estimated cost that is charged when `VACUUM` modifies a block that was previously clean.

   The minimum value is `0`, while the maximum one is `10000`. The default value is `20`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-PAGE-DIRTY).

- **Vacuum cost page hit**{#setting-vacuum-cost-page-hit} {{ tag-all }}

   The estimated cost for vacuuming a buffer found in the shared buffer cache.

   The minimum value is `0`, while the maximum one is `10000`. The default value is `1`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-PAGE-HIT).

- **Vacuum cost page miss**{#setting-vacuum-cost-page-miss} {{ tag-all }}

   The estimated cost for vacuuming a buffer that has to be read from a disk.

   The minimum value is `0`, while the maximum one is `10000`. The default value is `10`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-PAGE-MISS).

- **Vacuum failsafe age**{#setting-vacuum-failsafe-age} {{ tag-con }} {{ tag-api}} {{ tag-cli }}

   The maximum age of a <q>frozen</q> (already ended) transaction measured as the number of transactions initiated after it. After this value is reached, the `VACUUM` process triggers vacuuming to avoid transaction counter overflow. {{ PG }} supports this feature starting from version 14.

   The minimum value is `0`, while the maximum one is `2100000000`. The default value is `1600000000`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-VACUUM-FAILSAFE-AGE).

- **Vacuum multixact failsafe age**{#setting-vacuum-multixact-failsafe-age} {{ tag-con }} {{ tag-api}} {{ tag-cli }}

   The maximum age of a frozen (already ended) [multi-transaction](https://www.postgresql.org/docs/14/routine-vacuuming.html#VACUUM-FOR-MULTIXACT-WRAPAROUND) measured as the number of multi-transactions initiated after it. After this value is reached, the `VACUUM` process triggers vacuuming to avoid multi-transaction counter overflow. {{ PG }} supports this feature starting from version 14.

   The minimum value is `0`, while the maximum one is `2100000000`. The default value is `1600000000`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-VACUUM-MULTIXACT-FAILSAFE-AGE).

- **Wal keep size**{#setting-wal-keep-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

   The minimum size (in bytes) of past log segments kept in the [WAL](https://www.postgresql.org/docs/current/wal-intro.html) directory so that [replicas](../../../managed-postgresql/concepts/replication.md#replication) could fetch them, if needed.

   The minimum value is `0` (past segments are not saved for replication), while the maximum one is `2251799812636672` (2 TB). The default value is `0`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-WAL-KEEP-SIZE).

- **Work mem**{#setting-work-mem} {{ tag-all }}

   The base maximum amount of memory to be used by an internal query operation (such as a sort or hash table) before writing to temporary disk files.

   The minimum value is `64`, while the maximum one is `2147483647` (2 GB). The default value is `4194304` (4 MB).

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-WORK-MEM).

- **Xmlbinary**{#setting-xmlbinary} {{ tag-all }}

   The method used for encoding binary data in XML. The possible values include:

  - `base64` (`XML_BINARY_BASE64` for {{ TF }}, API, and CLI): BASE64 encoding.
  - `hex` (`XML_BINARY_HEX` for {{ TF }}, API, and CLI): Hexadecimal encoding.

   The default value is `base64`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-XMLBINARY).

- **Xmloption**{#setting-xmloption} {{ tag-all }}

   The default type of conversion between the XML and character string data. The possible values include:

  - `document` (`XML_OPTION_DOCUMENT` for {{ TF }}, API, and CLI): An XML document.
  - `content` (`XML_OPTION_CONTENT` for {{ TF }}, API, and CLI): A fragment of an XML document.

   The default value is `content`.

   For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-XMLOPTION).
