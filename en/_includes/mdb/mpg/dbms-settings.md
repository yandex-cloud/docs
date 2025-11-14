- **Archive timeout**{#setting-archive-timeout} {{ tag-all }}

  {{ PG }} transaction log archiving interval (ms).

  The minimum value is `10000`, the maximum is `86400000`, and the default is `30000`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-ARCHIVE-TIMEOUT).

- **Array nulls**{#setting-array-nulls} {{ tag-all }}

  Manages the recognition of the `NULL` elements during array insertion. If enabled, they are interpreted as SQL `NULL` values. If disabled, they are interpreted as the literal string `NULL`.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-ARRAY-NULLS).

- **Auto explain log analyze**{#setting-auto-explain-log-analyze} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Determines whether query plan statistics are automatically written to the {{ PG }} log, without using the `EXPLAIN` command. This allows you to track unoptimized queries. This setting uses the `auto_explain` module. To enable it, [load the `auto_explain` library](#setting-shared-libraries).

  By default, this setting is disabled, meaning query plan statistics are not logged.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log buffers**{#setting-auto-explain-log-buffers} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Determines whether buffer usage statistics are written to the {{ PG }} log by the `auto_explain` module. It works the same as the `BUFFERS` option in the `EXPLAIN` command. This setting only applies when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  By default, this setting is disabled, meaning buffer usage statistics are not logged.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log min duration**{#setting-auto-explain-log-min-duration} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Minimum query execution time (in milliseconds) required to activate logging in the `auto_explain` module.

  The minimum and default value is `-1` (logging disabled) and the maximum is `2147483647`. If set to `0`, all query plans are logged, regardless of their execution time.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log nested statements**{#setting-auto-explain-log-nested-statements} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Determines whether the `auto_explain` module will log the execution of nested queries inside SQL functions. This setting only applies when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  By default, this setting is disabled, meaning only top-level query plans are logged.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log timing**{#setting-auto-explain-log-timing} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Determines whether the `auto_explain` module will log the execution time for each step of the query plan. It works the same as the `TIMING` option in the `EXPLAIN` command. This setting only applies when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  By default, this setting is disabled, meaning that execution time for individual query steps is not logged.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log triggers**{#setting-auto-explain-log-triggers} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Determines whether the `auto_explain` module will output trigger execution statistics. This setting only applies when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  By default, this setting is disabled, meaning trigger execution statistics are not reported.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain log verbose**{#setting-auto-explain-log-verbose} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Determines whether the `auto_explain` module will generate detailed logs. It works the same as the `VERBOSE` option in the `EXPLAIN` command. This setting only applies when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  By default, this setting is disabled, meaning no logging details are provided.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/auto-explain.html).

- **Auto explain sample rate**{#setting-auto-explain-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Fraction of queries logged by the `auto_explain` module in each session. This setting only applies when [Auto explain log analyze](#setting-auto-explain-log-analyze) is enabled.

  The minimum value is `0.0`, and the maximum value is `1.0` (all queries are logged). The default value is `1.0`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/auto-explain.html).

- **Autovacuum analyze scale factor**{#setting-autovacuum-analyze-scale-factor} {{ tag-all }}

  Fraction of changed or deleted rows in a table that will trigger the [autovacuum](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) process to run the `ANALYZE` command for statistics collection.

  The minimum value is `0.0`, the maximum is `1.0`, and the default is `0.0001`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-ANALYZE-SCALE-FACTOR).

- **Autovacuum max workers**{#setting-autovacuum-max-workers} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-cli }}

  Maximum number of [autovacuum worker processes](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) running in parallel. Autovacuuming runs periodically for each database. It identifies which rows in tables are marked for deletion and removes them.

  This setting can range from `1` to `32`. The default value [depends on the selected host class](#settings-instance-dependent) and is equal to the number of vCPUs on a single host, with a minimum of `3`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-MAX-WORKERS).

- **Autovacuum naptime**{#setting-autovacuum-naptime} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Determines the minimum interval (in milliseconds) between [autovacuum](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) jobs. To avoid overloading the database during periods of frequent data changes, increase this setting.

  The minimum value is `1000`, the maximum is `86400000`, and the default is `15000`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-NAPTIME).

- **Autovacuum vacuum cost delay**{#setting-autovacuum-vacuum-cost-delay} {{ tag-all }}

  Time (in milliseconds) the [autovacuum](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) process will idle after exceeding the [cost limit](#setting-autovacuum-vacuum-cost-limit).

  The minimum value is `-1` (disables the setting) and the maximum is `100`. The default value [depends on the selected host class](#settings-instance-dependent).

  - If the number of vCPUs for the selected host class is 10 or more, the default value is set to `5`.
  - In other cases, the default value is computed as follows:

    ```text
    55 - 5 × <number_of_vCPUs_per_host>
    ```

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-COST-DELAY).

- **Autovacuum vacuum cost limit**{#setting-autovacuum-vacuum-cost-limit} {{ tag-all }}

  Cost limit which, when exceeded, will pause the [autovacuum process](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) for the duration specified in the [Autovacuum vacuum cost delay](#setting-autovacuum-vacuum-cost-delay) setting.

  The minimum value is `-1` (disables the setting) and the maximum is `10000`. The default value [depends on the selected host class](#settings-instance-dependent) and is computed as follows:

  ```text
  150 × <number_of_vCPUs_per_host> + 400
  ```

  Here is an example:

  Host class | vCPU | Default value
  ---|----|-----
  s2.small | 4 | `150 × 4 + 400 = 1000`
  m2.medium| 6 | `150 × 6 + 400 = 1300`

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-COST-LIMIT).

- **Autovacuum vacuum insert scale factor**{#setting-autovacuum-vacuum-insert-scale-factor} {{ tag-all }}

  Fraction of a table’s size that is added to [Autovacuum vacuum insert threshold](#setting-autovacuum-vacuum-insert-threshold) to determine the condition for triggering an [autovacuum](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM).

  The minimum value is `0.0`, the maximum is `1.0`, and the default is `0.2`.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-13.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-INSERT-SCALE-FACTOR).

- **Autovacuum vacuum insert threshold**{#setting-autovacuum-vacuum-insert-threshold} {{ tag-all }}

  Determines the number of rows inserted into a table that will trigger an [autovacuum](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM).

  The minimum value is `-1` (disables the setting), the maximum is `2147483647`, and the default is `1000`.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-13.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-INSERT-THRESHOLD).

- **Autovacuum vacuum scale factor**{#setting-autovacuum-vacuum-scale-factor} {{ tag-all }}

  Fraction of changed or deleted rows in a table that will trigger the [autovacuum](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM) process to run the `VACUUM` command for reclaiming storage occupied by dead tuples.

  The minimum value is `0.0` (disables the setting), the maximum is `1.0`, and the default is `0.00001`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-autovacuum.html#GUC-AUTOVACUUM-VACUUM-SCALE-FACTOR).

- **Autovacuum work mem**{#setting-autovacuum-work-mem} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-cli }}

  Memory (in bytes) allocated to each [autovacuum process](https://www.postgresql.org/docs/current/routine-vacuuming.html#AUTOVACUUM).

  The minimum value is `-1` (disables the setting), the maximum is `2147483647`, and the default value is `-1`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-AUTOVACUUM-WORK-MEM).

- **Backend flush after**{#setting-backend-flush-after} {{ tag-all }}

  Maximum amount of data (in kilobytes) a utility process can write to the OS kernel’s page cache. When this amount is exceeded, the DBMS instructs the OS to flush the data to disk. The higher value for this setting reduces the likelihood of write slowdowns when data is flushed to disk by the `fsync`,e.g., after a checkpoint is completed.

  The minimum value is `0` (disables the setting), the maximum is `2048`, and the default is `0`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BACKEND-FLUSH-AFTER).

- **Backslash quote**{#setting-backslash-quote} {{ tag-all }}

  Controls how a quotation mark is represented within an SQL string.

  The allowed values are:

  - `backslash_quote` (`BACKSLASH_QUOTE` for {{ TF }}, API, and CLI): Quotation mark can be represented as `\'` (same as `on`).
  - `on` (`BACKSLASH_QUOTE_ON` for {{ TF }}, API, and CLI): Quotation mark can be represented as `\'`.
  - `off` (`BACKSLASH_QUOTE_OFF` for {{ TF }}, API, and CLI): Quotation mark can only be represented using the standard SQL syntax `''`.
  - `safe_encoding` (`BACKSLASH_QUOTE_SAFE_ENCODING` for {{ TF }}, API, and CLI): Representing a quotation mark as `\'` is only permitted for client encodings where `\` is not used for multibyte characters.

  The default value is `safe_encoding`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-BACKSLASH-QUOTE).

- **Bgwriter delay**{#setting-bgwriter-delay} {{ tag-all }}

  Time (in milliseconds) between background writer runs. This process writes new or changed pages from the {{ PG }} buffer cache to the disk. The delay prevents rewriting the same page on every update, thus reducing disk load.

  The minimum value is `10`, the maximum is `10000`, and the default is `200`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-DELAY).

- **Bgwriter flush after**{#setting-bgwriter-flush-after} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Maximum amount of data (in kilobytes) processed by the background writer. When this limit is exceeded, the DBMS instructs the OS to flush the data to disk. This setting limits the amount of <q>dirty</q> data in the kernel page cache, reducing the risk of slowdowns when executing `fsync` at the end of a checkpoint or during the OS’s background writeback process.

  The minimum value is `0`, the maximum is `2048`, and the default is `512`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-FLUSH-AFTER).

- **Bgwriter lru maxpages**{#setting-bgwriter-lru-maxpages} {{ tag-all }}

  Maximum number of {{ PG }} buffer cache pages the background writer can save per activity round. A value of zero disables background writing.

  The minimum value is `0`, the maximum is `1073741823`, and the default is `100`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-LRU-MAXPAGES).

- **Bgwriter lru multiplier**{#setting-bgwriter-lru-multiplier} {{ tag-all }}

  Multiplier determining the factor by which the average number of buffers held by the background writeback process will be increased during the next round.

  The minimum value is `0`, the maximum is `10`, and the default is `2`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-BGWRITER-LRU-MULTIPLIER).

- **Bytea output**{#setting-bytea-output} {{ tag-all }}

  Defines the `bytea` output format for [binary string values](https://www.postgresql.org/docs/current/datatype-binary.html):

  - `hex` (`BYTEA_OUTPUT_HEX` for {{ TF }}, API, and CLI): Each byte is represented by two hexadecimal characters, e.g., '`SELECT '\xDEADBEEF';`'.
  - `escape` (`BYTEA_OUTPUT_ESCAPE` for {{ TF }}, API, and CLI): Standard {{ PG }} format with ASCII characters only.

  The default value is `hex`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/datatype-binary.html).

- **Checkpoint completion target**{#setting-checkpoint-completion-target} {{ tag-all }}

  Fraction of the checkpoint interval determining the maximum allowed time for a checkpoint to complete. For example, if this value is set to `0.5`, the checkpoint will finish with about half the time left until the next checkpoint.

  The minimum value is `0.0`, the maximum is `1.0`, and the default is `0.5`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/wal-configuration.html).

- **Checkpoint flush after**{#setting-checkpoint-flush-after} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  The amount of dirty data in memory (in kilobytes) that triggers a flush during a checkpoint. Pages beyond this limit will be flushed to disk and deleted from the OS page cache.

  The minimum value is `0`, the maximum is `2048`, and the default is `256`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-CHECKPOINT-FLUSH-AFTER).

- **Checkpoint timeout**{#setting-checkpoint-timeout} {{ tag-all }}

  Interval between checkpoints (in milliseconds).

  The minimum value is `30000`, the maximum is `86400000`, and the default is `300000`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-CHECKPOINT-TIMEOUT).

- **Client connection check interval**{#setting-client-connection-check-interval} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Client connection check interval during query execution (in milliseconds). The check polls the server’s connection socket and aborts long queries upon detecting that the connection has been terminated.

  The minimum value is `0` (disables checks) and the maximum is `2147483647`. By default, the system uses the minimum value.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-14.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-connection.html#GUC-CLIENT-CONNECTION-CHECK-INTERVAL).

- **Client min messages**{#setting-client-min-messages} {{ tag-all }}

  Level of logging messages sent to client applications. Possible values (in ascending order of severity): `debug5`, `debug4`, `debug3`, `debug2`, `debug1`, `info`, `notice`, `warning`, `error`, `log`, `fatal`, and `panic` (for {{ TF }}, API, and CLI, `LOG_LEVEL_DEBUG5`, `LOG_LEVEL_DEBUG4`, `LOG_LEVEL_DEBUG3`, `LOG_LEVEL_DEBUG2`, `LOG_LEVEL_DEBUG1`, `LOG_LEVEL_INFO`, `LOG_LEVEL_NOTICE`, `LOG_LEVEL_WARNING`, `LOG_LEVEL_ERROR`, `LOG_LEVEL_LOG`, `LOG_LEVEL_FATAL`, and `LOG_LEVEL_PANIC`).

  The default value is `NOTICE`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-CLIENT-MIN-MESSAGES).

- **Constraint exclusion**{#setting-constraint-exclusion} {{ tag-all }}

  Allows the planner to use table constraints for query optimization.

  Values for this setting can range:

  - `on` (`CONSTRAINT_EXCLUSION_ON` for {{ TF }}, API, and CLI): Use constraints for all tables.
  - `off` (`CONSTRAINT_EXCLUSION_OFF` for {{ TF }}, API, and CLI): Do not use constraints.
  - `partition` (`CONSTRAINT_EXCLUSION_PARTITION` for {{ TF }}, API, and CLI): Only use constraints for child tables and `UNION ALL` clauses.

  The default value is `partition`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-CONSTRAINT-EXCLUSION).

- **Cursor tuple fraction**{#setting-cursor-tuple-fraction} {{ tag-all }}

  Defines the planner's estimate for the fraction of rows that will be retrieved via a cursor.

  The minimum value is `0.0`, the maximum is `1.0`, and the default is `0.1`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-CURSOR-TUPLE-FRACTION).

- **Deadlock timeout**{#setting-deadlock-timeout} {{ tag-con }} {{ tag-api }} {{ tag-tf }} {{ tag-cli }}

  Timeout period (in milliseconds) before the system will check for a deadlock condition.

  The minimum value is `1`, the maximum is `2147483647`, and the default is `1000`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-locks.html#GUC-DEADLOCK-TIMEOUT).

- **Default statistics target**{#setting-default-statistics-target} {{ tag-all }}

  Maximum number of statistical records per column in database tables. Using this statistics, the planner estimates the number of rows returned by queries in order to choose the most optimal query plan.

  For more accurate planner estimates, increase this setting.

  The minimum value is `1`, the maximum is `10000`, and the default is `1000`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-DEFAULT-STATISTICS-TARGET).

- **Default transaction isolation**{#setting-default-transaction-isolation} {{ tag-all }}

  This setting determines the default isolation level for new SQL transactions.

  Values for this setting can range:

  - `read committed` (`TRANSACTION_ISOLATION_READ_COMMITTED` for {{ TF }}, API, and CLI): A query can only see rows that were committed before it started.
  - `read uncommitted` (`TRANSACTION_ISOLATION_READ_UNCOMMITTED` for {{ TF }}, API, and CLI): In {{ PG }}, this isolation level is identical to `read committed`.
  - `repeatable read` (`TRANSACTION_ISOLATION_REPEATABLE_READ` for {{ TF }}, API, and CLI): All queries in the current transaction see only those rows that were committed before the first SELECT or UPDATE query in this transaction.
  - `serializable` (`TRANSACTION_ISOLATION_SERIALIZABLE` for {{ TF }}, API, and CLI): The strictest isolation level. In {{ PG }}, this isolation level is identical to `repeatable read`. However, if the interleaving of read and write operations in concurrent serializable transactions is incompatible with their serial execution, one of the transactions will be rolled back with the <q>serialization failure</q> error.

  The default value is `read committed`.

  To learn more about isolation levels, see [this {{ PG }} article](https://www.postgresql.org/docs/current/transaction-iso.html).

  The setting applies at the {{ mpg-name }} cluster level, but can be [overridden for individual users](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Default transaction read only**{#setting-default-transaction-read-only} {{ tag-all }}

  Sets the default transaction access mode to <q>read only</q> for all tables except temporary ones.

  By default, this setting is disabled, meaning that both reads and writes are permitted.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-DEFAULT-TRANSACTION-READ-ONLY).

- **Default with oids**{#setting-default-with-oids} {{ tag-all }}

  Adds an `OID` column containing a unique row ID. This setting only applies when a table is created:

  - Without an explicit `WITH OIDS` or `WITHOUT OIDS` clause, OR.
  - Using the `SELECT INTO` statement.

  By default, this setting is disabled, meaning no `OID` column is added.

  Support for this feature was removed in {{ PG }} version 12. Use this setting only for compatibility with legacy applications.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/11/runtime-config-compatible.html#GUC-DEFAULT-WITH-OIDS).

- **Effective cache size**{#setting-effective-cache-size} {{ tag-all }}

  An estimate of the effective disk cache size (in bytes) available for a single query. Higher values of this setting increase the possibility of the query planner to use an index scan. Conversely, lower values make the planner more likely to choose a sequential scan.

  The minimum value is `0`, the maximum is `549755813888` (512 GB), and the default is `107374182400` (100 GB).

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-EFFECTIVE-CACHE-SIZE).

- **Effective io concurrency**{#setting-effective-io-concurrency} {{ tag-all }}

  Maximum of concurrent disk I/O operations per database session. A higher value increases the number of operations that a {{ PG }} session will try to run concurrently.

  The minimum value is `0`, the maximum is `1000`, and the default is `1`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-EFFECTIVE-IO-CONCURRENCY).

- **Enable async append**{#setting-enable-async-append} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Allows the planner to account for asynchronous query plan execution on multiple hosts during data ingestion from external sources.

  This setting is enabled by default.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-14.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-ASYNC-APPEND).

- **Enable bitmapscan**{#setting-enable-bitmapscan} {{ tag-all }}

  Allows the planner to perform a Bitmap Index Scan, even if it is not explicitly specified in the query. This access method is similar to a regular index scan, but occurs in two stages:

  1. A Bitmap Index Scan builds a bitmap, marking all relevant row locations.
  1. Then the system performs a Bitmap Heap Scan on the table. In this case, the following applies:

     - Sequential page reads increase the chance of hitting the OS cache.
     - The system reads each page only once.

  This setting is most effective for repeated queries to the same tables.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-BITMAPSCAN).

- **Enable gathermerge**{#setting-enable-gathermerge} {{ tag-con }} {{ tag-api}} {{ tag-cli }}

  Allows the planner to use the Gather Merge node to merge rows produced by parallel processes while preserving the original output order.

  This setting is enabled by default.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-14.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-GATHERMERGE).

- **Enable hashagg**{#setting-enable-hashagg} {{ tag-all }}

  Allows the planner to build a hash table from the source data, even if it is not explicitly specified in the query. This setting is most effective for frequent, unsorted queries on large tables.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-HASHAGG).

- **Enable hashjoin**{#setting-enable-hashjoin} {{ tag-all }}

  Allows the planner to perform hash joins (`JOIN`) on tables, even if it is not explicitly specified in the query. This setting is most effective when working with large data volumes or when the tables are not pre-sorted by their join keys.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-HASHJOIN).

- **Enable incremental sort**{#setting-enable-incremental-sort} {{ tag-all }}

  Allows the planner to use incremental sort. This sorting method reduces query execution time and the amount of RAM required when you need to sort by multiple columns, and one or more of them are already sorted.

  This setting is enabled by default.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-13.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-INCREMENTAL-SORT).

- **Enable indexonlyscan**{#setting-enable-indexonlyscan} {{ tag-all }}

  Allows the planner to perform an index-only scan, even if it is not explicitly specified in the query.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/indexes-index-only-scans.html).

- **Enable indexscan**{#setting-enable-indexscan} {{ tag-all }}

  Allows the planner to use an index scan, even if it is not explicitly specified in the query.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-INDEXSCAN).

- **Enable material**{#setting-enable-material} {{ tag-all }}

  Allows the planner to use materialize nodes.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-MATERIAL).

- **Enable mergejoin**{#setting-enable-mergejoin} {{ tag-all }}

  Allows the query planner to use the merge `JOIN` method.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-MERGEJOIN).

- **Enable nestloop**{#setting-enable-nestloop} {{ tag-all }}

  Allows the planner to use the nested loop `JOIN` method. When this setting is disabled, the planner will use alternative methods.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-NESTLOOP).

- **Enable parallel append**{#setting-enable-parallel-append} {{ tag-all }}

  Allows the planner to use parallel-aware append.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-PARALLEL-APPEND).

- **Enable parallel hash**{#setting-enable-parallel-hash} {{ tag-all }}

  Allows the planner to use parallel hash joins. This setting only applies when [Enable hashjoin](#setting-enable-hashjoin) is turned on.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-PARALLEL-HASH).

- **Enable partition pruning**{#setting-enable-partition-pruning} {{ tag-all }}

  Allows the planner to prune unnecessary partitions when building query plans for partitioned tables.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/ddl-partitioning.html#DDL-PARTITION-PRUNING).

- **Enable partitionwise aggregate**{#setting-enable-partitionwise-aggregate} {{ tag-all }}

  Allows the planner to perform grouping and aggregate operations partition-by-partition.

  By default, this setting is disabled, meaning that the planner ignores partitions.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-PARTITIONWISE-AGGREGATE).

- **Enable partitionwise join**{#setting-enable-partition-join} {{ tag-all }}

  Allows the planner to use partition-wise joins. This setting enables the execution of joins on partitioned tables by joining their matching partitions.

  By default, this setting is disabled, meaning that the planner ignores partitions.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-PARTITIONWISE-JOIN).

- **Enable seqscan**{#setting-enable-seqscan} {{ tag-all }}

  Allows the planner to use sequential table scans.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#RUNTIME-CONFIG-QUERY-ENABLE).

- **Enable sort**{#setting-enable-sort} {{ tag-all }}

  Allows the planner to use explicit sort operations.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-ENABLE-SORT).

- **Enable tidscan**{#setting-enable-tidscan} {{ tag-all }}

  Allows the planner to use TID (tuple ID) scans for faster query performance.

  This setting is enabled by default (the planner uses TID scans).

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/ddl-system-columns.html).

- **Escape string warning**{#setting-escape-string-warning} {{ tag-all }}

  Enables a warning for situations when a backslash (`\`) appears in a regular string constant (with the `'...'` syntax). This setting only applies if [Standard conforming strings](#setting-standard-strings) is disabled.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-ESCAPE-STRING-WARNING).

- **Exit on error**{#setting-exit-on-error} {{ tag-all }}

  Enables session termination upon any query error.

  This setting is disabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-error-handling.html).

- **Force parallel mode**{#setting-force-parallel-mode} {{ tag-all }}

  Allows query parallelization for testing purposes:

  - `off` (`FORCE_PARALLEL_MODE_OFF` for {{ TF }}, API, and CLI): Enable parallel mode only if it is expected to increase performance.
  - `on` (`FORCE_PARALLEL_MODE_ON` for {{ TF }}, API, and CLI): Force parallel mode for all queries that can be executed safely in parallel.
  - `regress` (`FORCE_PARALLEL_MODE_REGRESS` for {{ TF }}, API, and CLI): Equivalent to `on`, but generates output identical to the `off` state.

  The default value is `off`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-developer.html).

- **From collapse limit**{#setting-from-collapse-limit} {{ tag-all }}

  As long as the number of elements in the `FROM` clause does not exceed this setting, the query planner will merge subqueries with the outer query. Decreasing this value reduces planning time, but can result in a less efficient query plan.

  The minimum value is `1`, the maximum is `2147483647`, and the default is `8`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-FROM-COLLAPSE-LIMIT).

- **Geqo**{#setting-geqo} {{ tag-con }} {{ tag-api }}

  Enables genetic query optimization ([GEQO](https://www.postgresql.org/docs/current/geqo.html)).

  Default value: `false` (disables genetic optimization).

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO).

- **Geqo effort**{#setting-geqo-effort} {{ tag-con }} {{ tag-api }}

  Sets the trade-off between query planning time and plan quality in the [GEQO](https://www.postgresql.org/docs/current/geqo.html) algorithm.

  A higher value increases query planning time but also raises the probability of selecting an efficient query plan. This setting does not directly control the algorithm; instead, it is used to calculate default values for other settings.

  The minimum value is `1`, the maximum is `10`, and the default is `5`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-EFFORT).

- **Geqo generations**{#setting-geqo-generations} {{ tag-con }} {{ tag-api }}

  Defines the number of generations in the [GEQO](https://www.postgresql.org/docs/current/geqo.html) algorithm.

  The practical range for this setting is between `100` and `1000`.

  If this setting’s value is left to default, i.e.,`0`, the number of generations is selected based on [**Geqo pool size**](#setting-geqo-pool-size).

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-GENERATIONS).

- **Geqo pool size**{#setting-geqo-pool-size} {{ tag-con }} {{ tag-api }}

  Specifies the number of individuals in the genetic population for the [GEQO](https://www.postgresql.org/docs/current/geqo.html) algorithm.

  This value cannot be `1`. The practical range for this setting is between `100` and `1000`.

  If this setting’s value is left to default, i.e., `0`, the number of individuals is selected based on [**Geqo effort**](#setting-geqo-effort) and the number of tables in the query.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-POOL-SIZE).

- **Geqo seed**{#setting-geqo-seed} {{ tag-con }} {{ tag-api }}

  Defines the seed value for the [GEQO](https://www.postgresql.org/docs/current/geqo.html)‘s random number generator used when exploring the join order search space.

  Changing this setting alters the set of join paths explored, which may either improve or degrade the effectiveness of the resulting path.

  The minimum value is `0`, the maximum is `1`, and the default is `0`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-SEED).

- **Geqo selection bias**{#setting-geqo-selection-bias} {{ tag-con }} {{ tag-api }}

  Defines the selection pressure within the [GEQO](https://www.postgresql.org/docs/current/geqo.html) population.

  The minimum value is `1.50`, the maximum is `2.00`, and the default is `2.00`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-SELECTION-BIAS).

- **Geqo threshold**{#setting-geqo-threshold} {{ tag-con }} {{ tag-api }}

  The [GEQO](https://www.postgresql.org/docs/current/geqo.html) algorithm will only be used to plan queries where the number of tables in the [`FROM` clause](https://www.postgresql.org/docs/current/sql-select.html#SQL-FROM) is equal to or greater than this setting.

  For small queries, it is generally better to use the standard planner performing an exhaustive search. However, for queries involving a large number of tables, an exhaustive search method may take longer than just using a suboptimal plan.

  The minimum value is `2`, the maximum is `2147483647`, and the default is `12`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-GEQO-THRESHOLD).

- **Gin pending list limit**{#setting-gin-list-limit} {{ tag-all }}

  Defines the maximum size (in bytes) of the [GIN index's](https://www.postgresql.org/docs/current/gin-intro.html) pending list. This list is used when `fastupdate` mode is enabled. If the pending list exceeds the specified limit, all its entries are moved to the main GIN index structure and the list is cleared.

  The minimum value is `64`, the maximum is `2147483647` (2 GB), and the default is `4194304`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-GIN-PENDING-LIST-LIMIT).

- **Hash mem multiplier**{#setting-hash-mem-multiplier} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Defines the maximum amount of memory available for hash table operations. The total amount is calculated as this setting’s value multiplied by [Work mem](#setting-work-mem).

  The minimum value is `0.0`, the maximum is `1000.0`, and the default is `1.0`.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-13.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-HASH-MEM-MULTIPLIER).

- **Idle in transaction session timeout**{#setting-idle-session-timeout} {{ tag-all }}

  Open transaction idle timeout (in milliseconds). If exceeded, the transaction's session will be terminated.

  The minimum value is `0`, the maximum is `2147483647`, and the default is `0`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-IDLE-IN-TRANSACTION-SESSION-TIMEOUT).

- **Jit**{#setting-jit} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Enables [Just-in-Time (JIT) compilation](https://www.postgresql.org/docs/current/jit.html) of {{ PG }} queries. If this setting is enabled, SQL queries are compiled into machine code at runtime, which accelerates the execution of complex CPU-intensive queries.

  This setting is disabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-JIT).

- **Join collapse limit**{#setting-join-collapse-limit} {{ tag-all }}

  Defines a threshold for the number of elements in the `FROM` list. Until it is exceeded, the planner will transfer explicit `JOIN` constructs (with the exception of `FULL JOIN`) into the list. Decreasing this value reduces planning time, but can result in a less efficient query plan.

  The minimum value is `1`; the maximum value is `2147483647`; the default value is `8`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-JOIN-COLLAPSE-LIMIT).

- **Lo compat privileges**{#setting-lo-compat-privileges} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Disables access permission checks for large objects. Prior to version 9.0, access permissions did not apply to large objects, allowing any user to read and write them. Enable this setting if you need compatibility with pre-9.0 releases of {{ PG }}.

  This setting is disabled by default, meaning that access permission checks are enabled.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-LO-COMPAT-PRIVILEGES).

- **Lock timeout**{#setting-lock-timeout} {{ tag-all }}

  Specifies the waiting time (in milliseconds) for the lock to be released. Locks can be used for tables, indexes, rows, and other database objects. If the timeout for an operation has expired, the operation is aborted.

  The minimum value is `0` (disables the timeout; allowing the system to wait for a lock indefinitely), the maximum is `2147483647`, and the default is `1000`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-LOCK-TIMEOUT).

  The setting applies at the {{ mpg-name }} cluster level, but can be [overridden for individual users](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Log checkpoints**{#setting-log-checkpoints} {{ tag-all }}

  Enables logging of checkpoints and server restarts.

  The setting is disabled by default (no logging).

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-CHECKPOINTS).

- **Log connections**{#setting-log-connections} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Enables logging of all {{ PG }} server connection attempts, including those where client authentication was successful.

  The setting is disabled by default (no logging).

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-CONNECTIONS).

- **Log disconnections**{#setting-log-disconnections} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Enables logging of session terminations.

  The setting is disabled by default (no logging).

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-DISCONNECTIONS).

- **Log duration**{#setting-log-duration} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Enables logging of the execution time for each completed command.

  The setting is disabled by default (no logging).

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-DURATION).

- **Log error verbosity**{#setting-log-error-verbosity} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Defines the verbosity level for {{ PG }} log entries. Log detail levels, from least to most verbose:

  - `terse` (`LOG_ERROR_VERBOSITY_TERSE` for {{ TF }}, CLI, and API): `DETAIL`, `HINT`, `QUERY`, and `CONTEXT` fields are excluded from the error message.
  - `default` (`LOG_ERROR_VERBOSITY_DEFAULT` for {{ TF }}, CLI, and API): Default.
  - `verbose` (`LOG_ERROR_VERBOSITY_VERBOSE` for {{ TF }}, CLI, and API): Error message includes the `SQLSTATE` error code, source filename, function name, and the line number where the error occurred.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-ERROR-VERBOSITY).

- **Log lock waits**{#setting-log-lock-waits} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Controls the logging of long lock waits. When this setting is enabled, the system writes a log entry whenever a {{ PG }} session’s lock acquisition time exceeds the [Deadlock timeout](#setting-deadlock-timeout) value.

  This setting is disabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-LOCK-WAITS).

- **Log min duration sample**{#setting-log-min-duration-sample} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  This setting works the same as [Log min duration statement](#setting-log-min-duration-statement), but only applies to the statements listed in [Log statement sample rate](#setting-log-statement-sample-rate).

  A value of `0` enables execution time logging for all listed statements.

  The minimum value is `-1` (disables execution time logging), the maximum is `2147483647`, and the default is `-1`.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-13.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-DURATION-SAMPLE).

- **Log min duration statement**{#setting-log-min-duration-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Defines the minimum statement runtime (in milliseconds) required for it to be logged.

  A value of `0` enables execution time logging for all statements.

  The minimum value is `-1` (disables execution time logging), the maximum is `2147483647`, and the default is `-1`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-DURATION-STATEMENT).

  The setting applies at the {{ mpg-name }} cluster level, but can be [overridden for individual users](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Log min error statement**{#setting-log-min-error-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Defines the logging level for SQL runtime errors. The system logs statement execution information if the statement completes with an error of the specified severity level or higher. Possible values: `DEBUG5`, `DEBUG4`, `DEBUG3`, `DEBUG2`, `DEBUG1`, `INFO`, `NOTICE`, `WARNING`, `ERROR`, `LOG`, `FATAL`, and `PANIC`.

  The default value is `ERROR`. This means {{ PG }} will log all statements that ended with an error of the `ERROR`, `LOG`, `FATAL`, or `PANIC` severity level.

  To disable logging for most failed statements, select the `PANIC` value.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-ERROR-STATEMENT).

- **Log min messages**{#setting-log-min-messages} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Defines the {{ PG }} logging level. The system logs all messages with the selected severity level or higher. Possible values (in ascending order of severity): `DEBUG5`, `DEBUG4`, `DEBUG3`, `DEBUG2`, `DEBUG1`, `INFO`, `NOTICE`, `WARNING`, `ERROR`, `LOG`, `FATAL`, and `PANIC`.

  The default value is `WARNING`. This means {{ PG }} will log all messages with the `WARNING`, `ERROR`, `LOG`, `FATAL`, and `PANIC` severity level.

  To disable logging for most messages, select `PANIC`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-MIN-MESSAGES).

- **Log parameter max length**{#setting-log-parameter-max-length} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Shortens the value of each bound SQL parameter to the specified number of bytes for output with SQL statements in non-error log messages.

  A value of `0` disables logging.

  The minimum value is `-1` (parameter values are logged in full) and the maximum is `1073741823`. By default, the system uses the minimum value.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-13.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-PARAMETER-MAX-LENGTH).

- **Log parameter max length on error**{#setting-log-parameter-max-length} {{ tag-all }}

  Shortens the value of each bound SQL parameter to the specified number of bytes for output with SQL statements in error log messages.

  A value of `0` disables logging.

  The minimum value is `-1` (parameter values are logged in full) and the maximum is `1073741823`. By default, the system uses the minimum value.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-13.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-PARAMETER-MAX-LENGTH-ON-ERROR).

- **Log recovery conflict waits**{#setting-log-recovery-conflict-waits} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Enables logging of replication delays caused by recovery conflicts during WAL reading. The system adds log entries if conflict resolution timeout exceeds the [Deadlock timeout](#setting-deadlock-timeout) value.

  This setting is disabled by default.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-14.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-RECOVERY-CONFLICT-WAITS).

- **Log statement**{#setting-log-statement} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Filter for SQL statements to be logged by {{ PG }}:

  - `none` (`LOG_STATEMENT_NONE` for {{ TF }}, CLI, and API): The filter is disabled, no SQL statements are logged.
  - `ddl` (`LOG_STATEMENT_DDL` for {{ TF }}, CLI, and API): System logs data definition language statements, e.g., `CREATE`, `ALTER`, `DROP` etc.
  - `mod` (`LOG_STATEMENT_MOD` for {{ TF }}, CLI, and API): System logs `ddl`-statements along with data modification commands, e.g., `INSERT`, `UPDATE`, etc.
  - `all` (`LOG_STATEMENT_ALL` for {{ TF }}, CLI, and API): System logs all SQL statements.

  The default value is `none`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html).

  The setting applies at the {{ mpg-name }} cluster level, but can be [overridden for individual users](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Log statement sample rate**{#setting-log-statement-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Fraction of SQL statements that will be logged as a supplement to statements logged for other reasons.

  The minimum value is `0.0`, the maximum is `1.0`, and the default is `0.0`.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-13.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-STATEMENT-SAMPLE-RATE).

- **Log temp files**{#setting-log-temp-files} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Sets the minimum size of a temporary file, triggering {{ PG }} to log its details upon deletion.

  The minimum value is `-1` (information about deleted files is not logged) and the maximum is `2147483647` (2 GB). A value of `0` enables logging of all temporary file names and sizes. The default value is `-1`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-TEMP-FILES).

- **Log transaction sample rate**{#setting-log-transaction-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Fraction of transactions whose statements will be logged as a supplement to statements logged for other reasons.

  The minimum value is `0.0`; the maximum value is `1.0`; the default value is `0.0`.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-12.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-logging.html#GUC-LOG-TRANSACTION-SAMPLE-RATE).

- **Logical decoding work mem**{#setting-logical-decoding-work-mem} {{ tag-all }}

  Maximum memory (in bytes) allocated for [logical decoding](https://www.postgresql.org/docs/current/logicaldecoding.html) before writing to a local storage. This setting limits the amount of memory used by the logical replicatoin connection.

  The minimum value is `65536` (64 KB), the maximum is `1099511627776` (1 TB), and the default is `67108864` (64 MB).

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-13.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-LOGICAL-DECODING-WORK-MEM).

- **Maintenance io concurrency**{#setting-maintenance-io-concurrency} {{ tag-all }}

  Maximum concurrent disk I/O operations per session during {{ PG }} maintenance involving `VACUUM`, `CREATE INDEX`, and `ALTER TABLE ADD FOREIGN KEY` statements. Increasing this value will allow more {{ PG }} maintenance statements to run in parallel.

  The minimum value is `0`, the maximum is `1000`, and the default is `10`.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-13.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAINTENANCE-IO-CONCURRENCY).

- **Maintenance work mem**{#setting-maintenance-work-mem} {{ tag-all }}

  Maximum memory (in bytes) available for {{ PG }} maintenance operations, such as `VACUUM`, `CREATE INDEX`, and `ALTER TABLE ADD FOREIGN KEY`. The value must be a multiple of 1,024.

  The minimum value is `1048576` (1 MB), the maximum is `137438953472` (128 GB), and the default is `67108864` (64 MB).

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAINTENANCE-WORK-MEM).

- **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Maximum simultaneous {{ PG }} host connections.

  The minimum value is `1`. The maximum and default values [depend on the selected host class](#settings-instance-dependent) and are calculated as follows:

  ```text
  200 × <number_of_vCPUs_per_host>
  ```

  Hosts with a guaranteed vCPU share below 100% (`burstable`) use the fixed maximum value of `200`.

  By default, the system uses the maximum value.

  {% include [note-pg-user-connections.md](../../mdb/note-pg-user-connections.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-connection.html#GUC-MAX-CONNECTIONS).

- **Max locks per transaction**{#setting-max-locks-transaction} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Average number of objects that can be locked by a single transaction. Individual transactions can lock more objects as long as the total number of objects locked by all transactions fits in the lock table.

  The minimum value is `10`, the maximum is `2147483647`, and the default is `64`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-locks.html#GUC-MAX-LOCKS-PER-TRANSACTION).

- **Max logical replication workers**{#setting-max-logical-replication-workers} {{ tag-con }}

  Maximum number of {{ PG }} logical replication processes.

  This setting can range from `4` to `100`. By default, the system uses the minimum value.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-LOGICAL-REPLICATION-WORKERS).

- **Max parallel maintenance workers**{#setting-max-parallel-maintenance-workers} {{ tag-all }}

  Maximum number of parallel {{ PG }} processes that can be initiated by a single maintenance statement, e.g., `CREATE INDEX`.

  The minimum value is `0`, the maximum is `1024`, and the default is `2`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PARALLEL-MAINTENANCE-WORKERS).

- **Max parallel workers**{#setting-max-parallel-workers} {{ tag-all }}

  Maximum number of parallel {{ PG }} processes.

  The minimum value is `0`, the maximum is `1024`, and the default is `8`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PARALLEL-WORKERS).

- **Max parallel workers per gather**{#setting-max-parallel-workers-gather} {{ tag-all }}

  Maximum number of parallel processes that can be launched by a single [Gather](https://www.postgresql.org/docs/current/how-parallel-query-works.html) node.

  The minimum value is `0`; the maximum value is `1024`; the default value is `2`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PARALLEL-WORKERS-PER-GATHER).

- **Max pred locks per transaction**{#setting-max-pred-locks-transaction} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Average number of objects lockable by [predicate locks](https://www.postgresql.org/docs/current/transaction-iso.html#XACT-SERIALIZABLE) per transaction. Individual transactions can lock more objects than specified as long as the total number of objects locked by all transactions fits in the lock table.

  The minimum value is `10`, the maximum is `2147483647` (2 GB), and the default is `64`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-locks.html#GUC-MAX-PRED-LOCKS-PER-TRANSACTION).

- **Max prepared transactions**{#setting-max-prepared-transactions} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Maximum number of transactions that can be in a [prepared state](https://www.postgresql.org/docs/current/sql-prepare-transaction.html) simultaneously.

  The minimum value is `0`, the maximum is `262143`, and the default is `0`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-PREPARED-TRANSACTIONS).

- **Max replication slots**{#setting-max-replication-slots} {{ tag-con }}

  Maximum number of [replication slots](https://www.postgresql.org/docs/current/warm-standby.html#STREAMING-REPLICATION-SLOTS). Replication slots automatically ensure that [WAL](https://www.postgresql.org/docs/current/wal-intro.html) (Write-Ahead Log) files are preserved until they have been received by all replicas.

  This setting can range from `20` to `100`. By default, the system uses the minimum value.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-REPLICATION-SLOTS).

- **Max slot wal keep size**{#setting-max-slot-wal-keep-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Maximum size (in bytes) of the [Write-Ahead Log (WAL)](https://www.postgresql.org/docs/current/wal-intro.html) files stored on the master host during replication.

  The minimum value is `67108864` (64 MB), the maximum is 50% of the [storage](../../../managed-postgresql/concepts/storage.md) size, and the default is `-1` (unlimited). This value must be a multiple of 1,024.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-13.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-SLOT-WAL-KEEP-SIZE).

- **Max standby streaming delay**{#setting-max-standby-streaming-delay} {{ tag-all }}

  The timeout period (in milliseconds) before a hot standby replica begins terminating the queries conflicting with pending [WAL](https://www.postgresql.org/docs/current/wal-intro.html) updates.

  The minimum value is `-1` (unlimited waiting time), the maximum is `2147483647`, and the default is `30000` (30 seconds).

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-STANDBY-STREAMING-DELAY).

- **Max wal senders**{#setting-max-wal-senders} {{ tag-con }}

  Maximum number of parallel connections allowed from replication source hosts.

  This setting can range from `20` to `100`. By default, the system uses the minimum value.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-WAL-SENDERS).

- **Max wal size**{#setting-max-wal-size} {{ tag-all }}

  Maximum [WAL](https://www.postgresql.org/docs/current/wal-intro.html) file size (in bytes) that triggers automatic checkpoints.

  The minimum value is `2`. The maximum value equals 10% of the [storage size](#settings-instance-dependent), capped at `8589934592` (8 GB). By default, the system uses the maximum value.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-MAX-WAL-SIZE).

- **Max worker processes**{#setting-max-worker-processes} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Maximum number of {{ PG }} background processes that can be run on the current system.

  The minimum value is `0`; the maximum value is `1024`; the default value is `8`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-MAX-WORKER-PROCESSES).

- **Min wal size**{#setting-min-wal-size} {{ tag-all }}

   [WAL](https://www.postgresql.org/docs/current/wal-intro.html) disk usage threshold (in bytes) triggering the deletion of old WAL files during checkpoints.

  The minimum value is `2`. The maximum value equals 5% of the [storage size](#settings-instance-dependent), capped at `1073741824` (1 GB). By default, the system uses the maximum value.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-MIN-WAL-SIZE).

- **Old snapshot threshold**{#setting-old-snapshot-threshold} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Minimum time (in milliseconds) a snapshot can be safely used for query execution without risk of an error.

  The minimum and default values are `-1` (unlimited), and the maximum is `86400000` (24 hours).

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-OLD-SNAPSHOT-THRESHOLD).

- **Online analyze enable**{#setting-online-analyze} {{ tag-con }} {{ tag-api }}

  Enables the `online_analyze` module, which updates statistics after the `INSERT`, `UPDATE`, `DELETE`, and `SELECT INTO` operations on the target tables.

- **Operator precedence warning**{#setting-operator-precedence-warning} {{ tag-all }}

  Enables the query parser to issue warnings for all constructs whose behavior changed due to the precedence rule updates in version 9.5.

  This setting is disabled by default.

  Support for this feature was removed in {{ PG }} version 14.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/13/runtime-config-compatible.html#GUC-OPERATOR-PRECEDENCE-WARNING).

- **Parallel leader participation**{#setting-parallel-leader-participation} {{ tag-all }}

  Allows the leader process to execute sections of the query plan below Gather and Gather Merge nodes without waiting for worker processes.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-PARALLEL-LEADER-PARTICIPATION).

- **Pg hint plan debug print**{#setting-pghint-plan-debug} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Debug output configuration and verbosity for the `pg_hint_plan` module. This setting only applies when [Pg hint plan enable hint](#setting-pg-hint-plan-enable) is enabled. The possible values, in ascending order of verbosity, are:

  - `off` (`PG_HINT_PLAN_DEBUG_PRINT_OFF` for {{ TF }} and API): The output is disabled.
  - `on` (`PG_HINT_PLAN_DEBUG_PRINT_ON` for {{ TF }} and API): Default.
  - `detailed` (`PG_HINT_PLAN_DEBUG_PRINT_DETAILED` for {{ TF }} and API).
  - `verbose` (`PG_HINT_PLAN_DEBUG_PRINT_VERBOSE` for {{ TF }} and API).

- **Pg hint plan enable hint**{#setting-pg-hint-plan-enable} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Enables the `pg_hint_plan` module, which adjusts automatic query plans by applying <q>hints</q> written as simple directives within special SQL comments.

- **Pg hint plan enable hint table**{#setting-pg-hint-plan-enable-hint-table} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Enables the use of the `hint_plan.hints` table containing <q>hints</q> for the `pg_hint_plan` module that you can use when you cannot modify queries. This table has the following columns:

  - `id`: Unique row ID of a <q>hint</q>. This column is populated automatically.
  - `norm_query_string`: Pattern for selecting queries targeted by the <q>hint</q>. Replace constants with the `?` character. Whitespace characters are treated as part of the pattern and affect matching .
  - `application_name`: Initiating application for the sessions where the <q>hint</q> applies.
  - `hint`: <q>Hints</q> not wrapped in comment markers.

- **Pg hint plan message level**{#setting-pg-hint-plan-message} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Verbosity level for the `pg_hint_plan` debug messages written to the {{ PG }} log. This setting only applies when [Pg hint plan enable hint](#setting-pg-hint-plan-enable) is enabled. The possible values are:

  - `error`
  - `warning`
  - `notice`
  - `info` (default)
  - `log`
  - `debug`

- **Pg qualstats enabled**{#setting-pg-qualstats-enabled} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Enables the `pg_qualstats` module to collect statistics on predicates in `WHERE` operators and `JOIN` blocks. This setting is used to analyze the most frequently evaluated query predicates.

- **Pg qualstats max**{#setting-pg-qualstats-max} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Maximum number of predicates tracked by the `pg_qualstats` module. This setting only applies when [Pg qualstats enabled](#setting-pg-qualstats-enabled) is on.

  The minimum value is `100`, the maximum is `2147483647`, and the default is `1000`.

- **Pg qualstats resolve oids**{#setting-pg-qualstats-resolve-oids} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Enables table `OID`-to-name recovery during query statistics collection for the `pg_qualstats` module. This setting simplifies data analysis, but requires more disk space to store statistics. This setting only applies when [Pg qualstats enabled](#setting-pg-qualstats-enabled) is on.

  This setting is disabled by default.

- **Pg qualstats sample rate**{#setting-pg-qualstats-sample-rate} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Fraction of queries (0-1) for which statistics are collected by the `pg_qualstats` module. This setting only applies when [Pg qualstats enabled](#setting-pg-qualstats-enabled) is on. Special setting values:

  - `0`: Disables the setting.
  - `1`: All queries are analyzed.
  - `-1`: Automatic mode. The sampling rate is the reciprocal of the [Max connections](#setting-max-connections) setting and [depends on the selected host class](#settings-instance-dependent).

  The default value is `-1`.

- **Pg qualstats track constants**{#setting-pg-qualstats-track-constants} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Enables tracking of previously encountered predicates in subsequent queries during statistics collection by the `pg_qualstats` module. This setting only applies when [Pg qualstats enabled](#setting-pg-qualstats-enabled) is on.

  This setting is enabled by default.

- **Plan cache mode**{#setting-plan-cache-mode} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Determines the query plan type, i.e., generic or custom, that will be used to execute [prepared statements](https://www.postgresql.org/docs/current/sql-prepare.html). The possible values are:

  - `auto` (`PLAN_CACHE_MODE_AUTO` for {{ TF }} and API): Automatic selection.
  - `force_custom_plan` (`PLAN_CACHE_MODE_FORCE_CUSTOM_PLAN` for {{ TF }} and API): Forces the use of custom plans.
  - `force_generic_plan` (`PLAN_CACHE_MODE_FORCE_GENERIC_PLAN` for {{ TF }} and API): Forces the use of generic plans.

  The default value is `auto`.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-12.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-PLAN-CACHE_MODE).

- **Plantuner fix empty table**{#setting-plantuner-fix-empty-table} {{ tag-con }} {{ tag-api }}

  Allows the `plantuner` module to hide individual indexes from the planner to prevent their use in query plans.

  This setting is disabled by default.

- **Quote all identifiers**{#setting-quote-identifiers} {{ tag-all }}

  Forces quoting all identifiers in SQL queries generated from a database, e.g., during an `EXPLAIN` operation.

  This setting is disabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-QUOTE-ALL-IDENTIFIERS).

- **Random page cost**{#setting-random-page-cost} {{ tag-all }}

  Defines the planner's estimated cost of reading one arbitrary disk page. If this setting’s value is less than [Seq page cost](#setting-seq-page-cost), the planner will favor index scans.

  The minimum value is `0` and the default is `1`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#GUC-RANDOM-PAGE-COST).

- **Row security**{#setting-row-security} {{ tag-all }}

  Manages processing of queries subject to at least one [row-level security policy](https://www.postgresql.org/docs/current/sql-createpolicy.html). If you disable this setting, such queries will return an error.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-ROW-SECURITY).

- **Search path**{#setting-search-path} {{ tag-all }}

  Comma-separated list of database schema names. When accessing objects in these schemas, the schema name can be omitted.

  The default value is `$user, public`, i.e., the current user’s schema and the `public` schema.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-SEARCH-PATH).

- **Seq page cost**{#setting-seq-page-cost} {{ tag-all }}

  Defines the planner's estimated cost of reding one page from disk during a series of sequential reads.

  The minimum value is `0` and the default is `1`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-query.html#RUNTIME-CONFIG-QUERY-CONSTANTS).

- **Session duration timeout**{#setting-session-duration-timeout} {{ tag-con }} {{ tag-api }} {{ tag-cli }}

  Maximum TTL (in ms) of the longest active session or transaction. This setting only applies to sessions with the `active` or `idle in transaction` status.
  
  To prevent this setting from impacting cluster performance, the system checks the longest transaction/session at certain intervals. The interval between checks is chosen randomly within a range of 5 to 10 minutes. For example, if you set this parameter to `1000`, a session will terminate within 1 second + 5 to 10 minutes.
  
  A value higher than default may increase the database size and slow down the operating system.

  The minimum value is `0` (no limit on active session/transaction TTL), the maximum value is `2147483647`, and the default is `43200000` (12 hours). The minimum adjustment granularity for this setting is `1000`.

  Learn more about session statuses in [this {{ PG }} guide](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

- **Shared buffers**{#setting-shared-buffers} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Memory (in bytes) that {{ PG }} can use for shared memory buffers.

  The minimum value is `131072` (128 KB). The maximum value [depends on the selected host class](#settings-instance-dependent) and is equal to 80% of the {{ mpg-name }} cluster host's total RAM. The default value is set to 25% of the total RAM, capped at 8 GB.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-SHARED-BUFFERS).

- **Shared preload libraries**{#setting-shared-libraries} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Comma-separated list of shared libraries to load upon {{ PG }} server startup. These libraries are required for some [{{ PG }} extensions](../../../managed-postgresql/operations/extensions/cluster-extensions.md).

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-SHARED-PRELOAD-LIBRARIES).

- **Standard conforming strings**{#setting-standard-strings} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Enables interpreting backslashes (`\`) in regular string constants (`'...'`) as a literal rather than a special character, as per SQL standard.

  This setting is on by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-STANDARD-CONFORMING-STRINGS).

- **Statement timeout**{#setting-statement-timeout} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Maximum statement runtime (in ms) before it is aborted.

  The minimum value is `0`; the maximum value is `2147483647`; the default value is `0`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-STATEMENT-TIMEOUT).

- **Synchronize seqscans**{#setting-synchronize-seqscans} {{ tag-all }}

  Enables synchronized scanning for large table sequential scans, causing concurrent operations to read the same block at roughly the same time. When this setting is disabled, a sequential scan will always start from the beginning of the table, reverting to pre-8.3 behavior.

  This setting is enabled by default.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-SYNCHRONIZE-SEQSCANS).

- **Synchronous commit**{#setting-synchronous-commit} {{ tag-all }}

  Determines the [WAL](https://www.postgresql.org/docs/current/wal-intro.html) processing stage at which a transaction is considered committed.

  Values for this setting can range:

  {% list tabs group=instructions %}

  - Management console/CLI {#console}

    - `on`: Transaction is committed once its WAL record is written both to the master’s disk and to the disks of every quorum replica.
    - `off`: Transaction is committed even if its data has not yet been flushed to WAL. Due to the asynchronous nature of writes, transaction data in this case can be lost in the event of a disk subsystem failure.
    - `local`: Transaction is committed once its WAL record is written to the master’s disk.
    - `remote_write`: Transaction is committed once its WAL record is written to the master’s disk and all quorum replicas have received the WAL and provided it to the OS for writing to disk. If the master’s disk fails and the operating systems on quorum replicas crash, transaction data with this synchronization level can be lost.
    - `remote_apply`: Transaction is committed once its WAL record is written to the master’s disk and all quorum replicas have received the WAL and applied the changes it contains.

    The default value is `on`.

  - {{ TF }} {#tf}

    - `1` or `"SYNCHRONOUS_COMMIT_ON"`: Transaction is committed once its WAL record is written both to the master’s disk and to the disks of every quorum replica.
    - `2` or `"SYNCHRONOUS_COMMIT_OFF"`: Transaction is committed even if its data is not yet in the WAL. Due to the asynchronous nature of writes, transaction data in this case can be lost in the event of a disk subsystem failure.
    - `3` or `"SYNCHRONOUS_COMMIT_LOCAL"`: Transaction is committed if the WAL is written to the master disk.
    - `4` or `"SYNCHRONOUS_COMMIT_REMOTE_WRITE"`: Transaction is committed once its WAL record is written to the master’s disk and all quorum replicas have received the WAL and provided it to the OS for writing to disk. If the master’s disk fails and the operating systems on quorum replicas crash, transaction data with this synchronization level can be lost.
    - `5` or `"SYNCHRONOUS_COMMIT_REMOTE_APPLY"`: Transaction is committed once its WAL record is written to the master’s disk and all quorum replica have received the WAL and applied the changes it contains.

    The default value is `"SYNCHRONOUS_COMMIT_ON"`.

  - API {#api}

    - `SYNCHRONOUS_COMMIT_ON`: Transaction is committed once its WAL record is written both to the master’s disk and to the disks of every quorum replica.
    - `SYNCHRONOUS_COMMIT_OFF`: Transaction is committed even if its data has not yet been flushed to WAL. Due to the asynchronous nature of writes, transaction data in this case can be lost in the event of a disk subsystem failure.
    - `SYNCHRONOUS_COMMIT_LOCAL`: Transaction is committed once its WAL record is written to the master’s disk.
    - `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Transaction is committed once its WAL record is written to the master’s disk and all quorum replicas have received the WAL and provided it to the OS for writing to disk. If the master’s disk fails and the operating systems on quorum replicas crash, transaction data with this synchronization level can be lost.
    - `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Transaction is committed once its WAL record is written to the master’s disk and all quorum replicas have received the WAL and applied the changes it contains.

    The default value is `SYNCHRONOUS_COMMIT_ON`.

  {% endlist %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT).

  The setting applies at the {{ mpg-name }} cluster level, but can be [overridden for individual users](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Temp buffers**{#setting-temp-buffers} {{ tag-all }}

  Maximum memory (in bytes) allocated for temporary buffers in each session.

  The minimum value is `100`, the maximum is `1073741823` (1 GB), and the default is `8388608` (8 MB).

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-TEMP-BUFFERS).

- **Temp file limit**{#setting-temp-file-limit} {{ tag-con }} {{ tag-api }} {{ tag-cli }} {{ tag-tf }}

  Maximum amount of disk space (in bytes) a single process can use for temporary files. A transaction that tries to exceed this limit will be canceled.

  Large queries are executed in the disk space rather than in RAM. Queries that are too large overload the disk and prevent other queries from being executed. The setting prevents queries that degrade performance by limiting the size of temporary files.

  The minimum value is `-1` (no limits); the maximum value is `2147483647` (2 GB); the default value is `-1`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-TEMP-FILE-LIMIT).

  The setting applies at the {{ mpg-name }} cluster level, but can be [overridden for individual users](../../../managed-postgresql/concepts/settings-list.md#dbms-user-settings).

- **Timezone**{#setting-timezone} {{ tag-all }}

  Timezone for time output and input.

  The default value is `Europe/Moscow`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-TIMEZONE).

- **Track activity query size**{#setting-track-activity-query-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Memory (in bytes) reserved in each active session for the text of the statement currently being executed.

  The minimum value is `100`, the maximum is `102400`, and the default is `1024`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-statistics.html#GUC-TRACK-ACTIVITY-QUERY-SIZE).

- **Transform null equals**{#setting-transform-null-equals} {{ tag-all }}

  Enables treating the condition `expression = NULL` as `expression IS NULL`. The condition is true if the expression has the `NULL` value, otherwise it is false. According to the SQL standard, `expression = NULL` always returns `NULL` (unknown value).

  This setting is disabled by default (the SQL standard applies).

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-compatible.html#GUC-TRANSFORM-NULL-EQUALS).

- **Vacuum cleanup index scale factor**{#setting-vacuum-index-scale-factor} {{ tag-all }}

  Share of index rows used in the previous statistics. During the `VACUUM` operation, the index statistics are considered obsolete if the ratio of newly inserted rows to the total number of rows in the index exceeds the specified value. In this case, the index will be re-scanned.

  The minimum value is `0.0`, the maximum is `10000000000.0`, and the default is `0.1`.

  Support for this feature was removed in {{ PG }} version 14.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/12/runtime-config-client.html#GUC-VACUUM-CLEANUP-INDEX-SCALE-FACTOR).

- **Vacuum cost delay**{#setting-vacuum-cost-delay} {{ tag-all }}

  Time (in milliseconds) the `VACUUM` and `ANALYZE` operations will remain idle if the cost limit is exceeded (see [Vacuum cost limit](#setting-vacuum-cost-limit)).

  The minimum value is `0`, the maximum is `100`, and the default is `0`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#RUNTIME-CONFIG-RESOURCE-VACUUM-COST).

- **Vacuum cost limit**{#setting-vacuum-cost-limit} {{ tag-all }}

  Accumulated cost threshold at which the `VACUUM` process will go idle (sleep mode).

  The minimum value is `1`, the maximum is `10000`, and the default is `200`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-LIMIT).

- **Vacuum cost page dirty**{#setting-vacuum-cost-page-dirty} {{ tag-all }}

  Notional cost of a `VACUUM` operation that modifies a block not modified before.

  The minimum value is `0`, the maximum is `10000`, and the default is `20`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-PAGE-DIRTY).

- **Vacuum cost page hit**{#setting-vacuum-cost-page-hit} {{ tag-all }}

  Notional cost of vacuuming a buffer found in shared cache.

  The minimum value is `0`, the maximum is `10000`, and the default is `1`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-PAGE-HIT).

- **Vacuum cost page miss**{#setting-vacuum-cost-page-miss} {{ tag-all }}

  Notional cost of vacuuming a buffer that has to be read from a disk.

  The minimum value is `0`, the maximum is `10000`, and the default is `10`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-VACUUM-COST-PAGE-MISS).

- **Vacuum failsafe age**{#setting-vacuum-failsafe-age} {{ tag-con }} {{ tag-api}} {{ tag-cli }}

  Maximum age of <q>frozen</q> (already completed) transaction measured as the number of transactions initiated after it. As soon as this value is reached, the `VACUUM` process runs vacuuming to avoid transaction counter overflow.

  The minimum value is `0`, the maximum is `2100000000`, and the default is `1600000000`.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-14.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-VACUUM-FAILSAFE-AGE).

- **Vacuum multixact failsafe age**{#setting-vacuum-multixact-failsafe-age} {{ tag-con }} {{ tag-api}} {{ tag-cli }}

  Maximum age of <q>frozen</q> (already completed) [multi-transaction](https://www.postgresql.org/docs/14/routine-vacuuming.html#VACUUM-FOR-MULTIXACT-WRAPAROUND) measured as the number of multi-transactions initiated after it. As soon as this value is reached, the `VACUUM` process runs vacuuming to avoid multi-transaction counter overflow.

  The minimum value is `0`, the maximum is `2100000000`, and the default is `1600000000`.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-14.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-VACUUM-MULTIXACT-FAILSAFE-AGE).

- **Wal keep size**{#setting-wal-keep-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Minimum size (in bytes) of obsolete log segments kept in the [WAL](https://www.postgresql.org/docs/current/wal-intro.html) directory for [replicas](../../../managed-postgresql/concepts/replication.md#replication) to download, if required.

  The minimum value is `0` (past segments are not saved for replication); the maximum value is `2251799812636672` (2 TB); the default value is `0`.

  {% include [settings-version](../../../_includes/mdb/mpg/mpg-settings-v-13.md) %}

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-WAL-KEEP-SIZE).

- **Work mem**{#setting-work-mem} {{ tag-all }}

  Basic memory (in bytes) available for internal query processing operations (e.g., sorting or hash tables) before making use of temporary files on disk.

  The minimum value is `64`, the maximum is `2147483647` (2 GB), and the default is `4194304` (4 MB).

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-resource.html#GUC-WORK-MEM).

- **Xmlbinary**{#setting-xmlbinary} {{ tag-all }}

  Method used for encoding binary data in XML. The possible values are:

  - `base64` (`XML_BINARY_BASE64` for {{ TF }}, CLI, and API): BASE64 encoding.
  - `hex` (`XML_BINARY_HEX` for {{ TF }}, API, and CLI): Hexadecimal encoding.

  The default value is `base64`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-XMLBINARY).

- **Xmloption**{#setting-xmloption} {{ tag-all }}

  Default type of conversion between XML and character data. The possible values are:

  - `document` (`XML_OPTION_DOCUMENT` for {{ TF }}, CLI, and API): XML document.
  - `content` (`XML_OPTION_CONTENT` for {{ TF }}, CLI, and API): XML document fragment.

  The default value is `content`.

  For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-XMLOPTION).
