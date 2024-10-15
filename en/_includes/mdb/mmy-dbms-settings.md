- **Audit log**{#setting-audit-log} {{ tag-all }}

  Manages writing the {{ MY }} audit log.

  By default, this setting is disabled.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/audit-log-reference.html#audit-log-options-variables).

- **Auto increment**{#setting-auto-increment-increment} {{ tag-all }}

  Sets the interval between the values of `AUTO_INCREMENT` columns.

  The minimum value is `1`, and the maximum value is `65535`. The default value is `1`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/replication-options-source.html#sysvar_auto_increment_increment).

- **Auto increment offset**{#setting-auto-increment-offset} {{ tag-all }}

  Sets the initial value for `AUTO_INCREMENT` columns. This setting is ignored if its value is greater than [Auto increment](#setting-auto-increment-increment).

  The minimum value is `1`, and the maximum value is `65535`. The default value is `1`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/replication-options-source.html#sysvar_auto_increment_offset).

- **Binlog cache size**{#setting-binlog-cache-size} {{ tag-all }}

  The size of the cache (in bytes) for storing changes to the [binary log]({{ my.docs }}/refman/8.0/en/binary-log.html) while performing a transaction.

  The minimum value is `4096` (4 KB) and the maximum value is `67108864` (64 MB). The default value is `32768` (32 KB).

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_cache_size).

- **Binlog group commit sync delay**{#setting-binlog-sync-delay} {{ tag-all }}

  Delays binary log synchronization with the disk when performing a `COMMIT` operation for the binary log. To synchronize more transactions with the disk at a time, set the delay to a value greater than zero. This will reduce the total time per `COMMIT` for a group of transactions.

  The minimum value is `0` (no delay) and the maximum value is `1000000` (one second). The default value is `0`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay).

- **Binlog row image**{#setting-binlog-row-image} {{ tag-all }}

  Indicates how to write row images to the binary log for row-based replication:
  - `FULL` (default): Log all columns to both the _before_ and _after_ images.
  - `MINIMAL`: Log only those columns to the _before_ image that are required to identify the rows to change; log only those columns in the _after_ image where the value was set with an SQL statement or auto increment operation.
  - `NOBLOB`: Log all columns to the _before_ and _after_ images (same as `FULL`), except for `BLOB` and `TEXT` columns that either have not changed or are not required to identify rows.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image).

- **Binlog rows query log events**{#setting-binlog-log-events} {{ tag-all }}

  Controls logging information events (for example, query log events) in the binary log.

  By default, this setting is disabled.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events).

- **Binlog transaction dependency tracking**{#setting-binlog-transaction-dependency-tracking} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  The schema to calculate logical temporary labels that help replicas determine which transactions can be executed concurrently. It is used for generating dependency information, which is written to a binary log when multithreaded replication ([Slave parallel workers](#setting-slave-parallel-workers)) with the `LOGICAL_CLOCK` [Slave parallel type](#setting-slave-parallel-type) policy is enabled.

  Possible values:

  - `COMMIT_ORDER` (default): Two transactions are considered independent if the period of committing the first transaction overlaps with the period of committing the second one.
  - `WRITESET`: Schema is based on `COMMIT_ORDER`. Additionally, two transactions are considered conflicting if a value (hash) appears in the record sets of both transactions.
  - `WRITESET_SESSION`: Two transactions are considered dependent if at least one of these conditions is met:

    - The transactions are dependent according to the `WRITESET` schema.
    - The transactions were committed during one user session.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking).

- **Character set server**{#setting-character-set-server} {{ tag-all }}

  The [character set]({{ my.docs }}/refman/8.0/en/charset.html) used by the {{ MY }} cluster when working with data and exchanging information with {{ MY }} clients. This choice affects the performance of SQL functions for manipulating strings and other features.

  The default value is `utf8mb4`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_character_set_server).

- **Collation server**{#setting-collation-server} {{ tag-all }}

  The [algorithm for collating characters]({{ my.docs }}/refman/8.0/en/charset.html) used by the {{ MY }} cluster when working with data and exchanging information with {{ MY }} clients. This choice affects the performance of SQL functions for sorting data, manipulating strings, and other features.

  The default value is `utf8mb4_0900_ai_ci`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_collation_server).

- **Default authentication plugin**{#setting-authentication-plugin} {{ tag-all }}

  The authentication plugin used in {{ mmy-name }} clusters:
  - `mysql_native_password`: Authentication method used in {{ MY }} prior to authentication plugins.
  - `sha256_password`: Authentication using SHA-256 for passwords.
  - `caching_sha2_password` (default): Similar to `sha256_password`, uses server-side caching for better performance and provides some additional features.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin).

- **Default time zone**{#setting-time-zone} {{ tag-all }}

  The server time zone.

  The default value is `Europe/Moscow`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-options.html#option_mysqld_default-time-zone).

- **Explicit defaults for timestamp**{#setting-defaults-for-timestamp} {{ tag-all }}

  Controls non-standard default values and `NULL` value handling in `TIMESTAMP` columns.

  By default, the setting is enabled, which **disables** any nonstandard behaviors.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp).

- **General log**{#setting-general-log} {{ tag-all }}

  Controls writing the {{ MY }} general query log.

  By default, this setting is disabled.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_general_log).

- **Group concat max len**{#setting-group-concat-max} {{ tag-all }}

  The maximum result length (in bytes) for the [GROUP_CONCAT()]({{ my.docs }}/refman/8.0/en/aggregate-functions.html#function_group-concat) function.

  The minimum value is `4`, and the maximum value is `33554432` (32 MB). The default value is `1024` (1 KB).

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_group_concat_max_len).

- **Innodb adaptive hash index**{#setting-adaptive-hash-index} {{ tag-all }}

  Controls the InnoDB [adaptive hash index]({{ my.docs }}/refman/8.0/en/glossary.html#glos_adaptive_hash_index). It may be desirable to disable this index for some types of database workloads. The {{ MY }} documentation recommends performing load testing on real data to determine whether to enable the adaptive hash index.

  By default, the adaptive hash index is enabled.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index).

- **Innodb buffer pool size**{#setting-buffer-pool-size} {{ tag-all }}

  The size of the InnoDB buffer pool (in bytes) used for caching table and index data. A larger buffer pool requires fewer I/O operations to access the same table data more than once.

  The minimum value is `134217728` (128 MB). The maximum and default values [depend on the selected host class](#settings-instance-dependent) and are set according to the table:

  | Amount of GB RAM on the host | Default value | Maximum value |
  |----------------------------|:---------------------:|:---------------------:|
  | 2                          | `268435456` (0.25 GB) | `536870912` (0.5 GB)  |
  | 4                          | `1610612736` (1.5 GB) | `2684354560` (2.5 GB) |
  | ≥ 8                        | `0.5 × RAM`           | `0.8 × RAM`           |

  For more information, see the [configuration recommendations](../../managed-mysql/qa/configuring.md#innodb-buffer-pool-size) and [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size).

- **Innodb compression level**{#setting-innodb-compression-level} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  The `zlib` compression level used for InnoDB compressed tables and indexes.

  The minimum value is `0`, and the maximum value is `9`. The default value is `6`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_compression_level).

- **Innodb flush log at trx commit**{#setting-flush-log-commit} {{ tag-all }}

  Determines {{ MY }} behavior for transaction `COMMIT` operations:
  - `1` (default): Full [ACID]({{ my.docs }}/refman/8.0/en/glossary.html#glos_acid) compliance. Logs are written and flushed to disk at each transaction commit.
  - `2`: Logs are written after each transaction is committed but flushed to disk once per second. Transactions for which logs have not been flushed can be lost in a crash.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit).

- **Innodb ft max token size**{#setting-ft-max-token-size} {{ tag-all }}

  The maximum length of words stored in the InnoDB `FULLTEXT` index.

  The minimum value is `10`, and the maximum value is `84`. The default value is `84`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size).

- **Innodb ft min token size**{#setting-ft-min-token-size} {{ tag-all }}

  The minimum length of words stored in the InnoDB `FULLTEXT` index.

  The minimum value is `0`, and the maximum value is `16`. The default value is `3`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size).

- **Innodb io capacity**{#setting-innodb-io-capacity} {{ tag-all }}

  The number of I/O operations per second (IOPS) available to all InnoDB background tasks. This setting affects processes that require I/O, such as flushing data to disk, and can be used to limit the number of I/O operations.

  The minimum value is `100`, and the maximum value is `100000`. The default value is `200`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity).

- **Innodb io capacity max**{#setting-innodb-io-capacity-max} {{ tag-all }}

  The maximum number of I/O operations per second (IOPS) available to all InnoDB background tasks. If a host's flushing activity falls behind, InnoDB may start flushing data to disk at a higher rate of IOPS than defined by the [Innodb io capacity](#setting-innodb-io-capacity) setting but within the specified maximum number of IOPS.

  The minimum value is `100`, and the maximum value is `100000`. The default value is `2000`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity_max).

- **Innodb lock wait timeout**{#setting-innodb-lock-wait-timeout} {{ tag-all }}

  The maximum time (in seconds) an InnoDB transaction waits for a row lock. When a lock wait timeout occurs, an error is returned and the current SQL statement (**not** the entire transaction) is rolled back.

  You can decrease this value for OLTP applications and interactive user applications. You can increase this value if your application has lengthy operations, e.g., large `INSERT` or `UPDATE` queries awaiting completion when transforming large arrays of data from the data storage.

  The minimum value is `1`, and the maximum value is `28800` (480 minutes, or 8 hours). The default value is `50`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout).

- **Innodb log buffer size**{#setting-log-buffer-size} {{ tag-all }}

  The size of the buffer (in bytes) that InnoDB uses to write the log files on disk. A large log buffer enables large transactions to run without the need to write the log to disk before the transactions commit. This saves disk I/O.

  The minimum value is `1048576` (1 MB), and the maximum value is `268435456` (256 MB). The default value is `16777216` (16 MB).

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_buffer_size).

- **Innodb log file size**{#setting-log-file-size} {{ tag-all }}

  The size of a single InnoDB redo log file (in bytes). The larger the value, the less [checkpoint]({{ my.docs }}/refman/8.0/en/glossary.html#glos_checkpoint) activity is required in the buffer pool, saving disk I/O. At the same time, larger log files make crash recovery slower.

  The minimum value is `268435456` (256 MB), and the maximum value is `4294967296` (4 GB). The default value is `268435456` (256 MB).

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size).

- **Innodb lru scan depth**{#setting-innodb-lru-scan-depth} {{ tag-con }} {{ tag-api }}

  The number of free pages that InnoDB attempts to save in each buffer pool to accelerate page read and create operations.

  The minimum value is `100`, and the maximum value is `4294967295`. The default value is `1024`.

  The higher the value, the more the setting affects the cluster performance and memory:

  * Increase the value only if the cluster has spare resources for data I/O under typical workload.
  * Decrease the value if you lack resources at the current value.

  In most cases, the default value is suitable.

  For more information, see the Percona blog and {{ MY }} documentation:

  * [Calculating the setting value](https://www.percona.com/blog/tuning-mysql-innodb-flushing-for-a-write-intensive-workload/)
  * [Setting description]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lru_scan_depth)

- **Innodb numa interleave**{#setting-innodb-numa-interleave} {{ tag-all }}

  Controls the [NUMA Interleave](https://www.kernel.org/doc/html/latest/admin-guide/mm/numa_memory_policy.html#components-of-memory-policies) policy for allocation of the InnoDB buffer pool.

  This policy is disabled by default.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_numa_interleave).

- **Innodb online alter log max size**{#setting-online-alter-log-max-size} {{ tag-all }}

  The size of temporary InnoDB log files (in bytes) received during [online DDL queries]({{ my.docs }}/refman/8.0/en/glossary.html#glos_online_ddl). The greater value means more [DML operations]({{ my.docs }}/refman/8.0/en/glossary.html#glos_dml) during DDL queries but a longer period after a DDL query during which a table is locked because log data is applied.

  The minimum value is `65536` (64 KB), and the maximum value is `107374182400` (100 GB). The default value is `134217728` (128 MB).

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size).

- **Innodb page size**{#setting-innodb-page-size} {{ tag-all }}

  The page size for InnoDB tablespace (in bytes). You cannot edit this setting after you create a cluster.

  Acceptable values: `4096` (4 KB), `8192` (8 KB), `16384` (16 KB), `32768` (32 KB), and `65536` (64 KB). The default value is `16384` (16 KB).

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_page_size).

- **Innodb print all deadlocks**{#setting-print-all-deadlocks} {{ tag-all }}

  Controls writing information about all [deadlocks]({{ my.docs }}/refman/8.0/en/innodb-deadlocks.html) to the error log. If this setting is disabled, the `SHOW ENGINE INNODB STATUS` command will only output information about the last deadlock.

  By default, the option for showing information about all deadlocks is off.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks).

- **Innodb purge threads**{#setting-innodb-purge-threads} {{ tag-all }}

  The number of InnoDB I/O threads used for [purge operations]({{ my.docs }}/refman/8.0/en/glossary.html#glos_purge). Increasing the number of these threads can improve efficiency on systems where data manipulation operations (`INSERT`, `UPDATE`, or `DELETE`) are performed on multiple tables.

  The minimum value is `1`, and the maximum value is `16`. The default value is `4`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_purge_threads).

- **Innodb read io threads**{#setting-innodb-read-io-threads} {{ tag-all }}

  The number of InnoDB I/O threads used for read operations.

  The minimum value is `1`, and the maximum value is `16`. The default value is `4`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_read_io_threads).

- **Innodb status output**{#setting-innodb-status-output} {{ tag-con }}

  Manages output of the standard InnoDB [monitor]({{ my.docs }}/refman/8.0/en/innodb-enabling-monitors.html).

  By default, the standard monitor is disabled.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_status_output).

- **Innodb strict mode**{#setting-strict-mode} {{ tag-con }}

  Manages the [strict mode]({{ my.docs }}/refman/8.0/en/glossary.html#glos_strict_mode) in Innodb. When enabled, specific conditions that are normally treated as warnings are considered errors.

  By default, InnoDB strict mode is enabled.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_strict_mode).

- **Innodb temp data file max size**{#setting-temp-data-max-size} {{ tag-all }}

  The maximum size of InnoDB [temporary tablespace]({{ my.docs }}/refman/8.0/en/innodb-temporary-tablespace.html#innodb-global-temporary-tablespace) (in bytes).

  The minimum value is `0` (no temporary tablespace is used). The maximum value is `107374182400` (100 GB). The default value is `0`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path).

- **Innodb thread concurrency**{#setting-innodb-thread-concurrency} {{ tag-all }}

  The maximum number of concurrently executed InnoDB threads.

  The minimum value is `0` (no restrictions). The maximum value is `1000`. The default value is `0`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_thread_concurrency).

- **Innodb write io threads**{#setting-innodb-write-io-threads} {{ tag-all }}

  The number of InnoDB I/O threads used for write operations.

  The minimum value is `1`, and the maximum value is `16`. The default value is `4`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_write_io_threads).

- **Interactive timeout**{#setting-interactive-timeout} {{ tag-all }}

  The period of time (in seconds) for which the server waits for activity during an interactive connection before terminating it.

  The minimum value is `600` (10 minutes), and the maximum value is `86400` (24 hours). The default value is `28800` (8 hours).

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_interactive_timeout).

- **Join buffer size**{#setting-join-buffer-size} {{ tag-all }}

  The minimum size of the buffer (in bytes) that is used for:
  - Plain index scans.
  - Range index scans.
  - Full table scans (for `JOIN` operations where no indexes are used).

  One join buffer of the specified size is allocated for each full join between two tables. Increase the value of this setting to get a faster full join when adding indexes is not possible.

  The minimum value is `1024` (1 KB), and the maximum value is `16777216` (16 MB). The default value is `262144` (256 KB).

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_join_buffer_size).

- **Lock wait timeout**{#setting-lock-wait-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  The maximum wait time (in seconds) when attempting to get a [metadata lock]({{ my.docs }}/refman/8.0/en/metadata-locking.html).

  The minimum value is `1`, the maximum value is `31536000` (1 year). The default value is `31536000`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_lock_wait_timeout).

- **Log error verbosity**{#setting-log-error-verbosity} {{ tag-con }}

  Defines the type of events written to the error log:

  - `2`: Errors and warnings.
  - `3` (default): Errors, warnings, and information messages.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_log_error_verbosity).

- **Log slow filter**{#setting-log-slow-filter} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Filter for a slow query log by query type. It is a string with any combination of the following comma-separated values:

  * `full_scan`: Log queries that perform a full table scan.
  * `full_join`: Log queries that perform a FULL JOIN without indexes.
  * `tmp_table`: Log queries that create an implicit internal temporary table.
  * `tmp_table_on_disk`: Log queries that save a temporary table on the disk.
  * `filesort`: Log queries that perform file sorting.
  * `filesort_on_disk`: Log queries that perform sorting of disk files.

  If the filter value is set, only query types included in the filter will appear in the slow query log.

  The default value is `""` (empty string, query filtering is disabled).

  For more information, see the [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter).

- **Log slow rate limit**{#setting-log-slow-rate-limit} {{ tag-all }}

  The setting shows which part of queries will be included in the slow query log. Depending on the [Log slow rate type](#setting-log-slow-rate-type) setting value, the setting is applied to either individual queries (`QUERY`) or sessions (`SESSION`).

  If its value is set to `1`, each query or session considered slow will be logged. With other values, every Nth query or cluster will be logged, which will reduce cluster load.

  If query processing time exceeds the value of [Slow query log always write time](#setting-slow-query-log-always-write-time), the query is written to the [slow query log](#setting-slow-query-log) regardless of the value of [Log slow rate limit](#setting-log-slow-rate-limit).

  The minimum value is `1`, and the maximum value is `1000`. The default value is `1`.

  For more information, see the [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit).

- **Log slow rate type**{#setting-log-slow-rate-type} {{ tag-all }}

  Sets the entry type for the slow query log to configure [Log slow rate limit](#setting-log-slow-rate-limit):

  * `query`: At the query level
  * `session`: At the session level

  The default value is `query`.

  For more information, see the [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type).

- **Log slow sp statements**{#setting-log-slow-sp-statements} {{ tag-all }}

  Controls writing of expressions run by stored procedures to the slow query log.

  By default, the writing of expressions is enabled.

  For more information, see the [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements).

- **Long query time**{#setting-long-query-time} {{ tag-all }}

  If a query takes longer than this number of seconds, it is considered slow. The lower the value, the more queries will be considered slow.

  The minimum value is `0`, and the maximum value is `3600` (1 hour). The default value is `10`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_long_query_time).

- **Lower case table names**{#setting-lower-case-table-names} {{ tag-all }}

  Determines the type of storage and comparison of table names:

  - `0` (default): Table names are saved with no changes. Comparisons are case-sensitive.
  - `1`: Table names are saved in lowercase. Comparisons are case-insensitive.

  You cannot edit this setting after you create a cluster.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_lower_case_table_names).

- **Max allowed packet**{#setting-max-allowed-packet} {{ tag-all }}

  The maximum size (in bytes) of a package, string, or parameters sent by the [mysql_stmt_send_long_data()]({{ my.docs }}/c-api/8.0/en/mysql-stmt-send-long-data.html) function.

  The default value is small in order to discard incorrect packages, which are usually larger. Increase this value if you are using large BLOB columns or long strings.

  The minimum value is `1024` (1 KB), and the maximum value is `134217728` (128 MB). The default value is `16777216` (16 MB).

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet).

- **Max connections**{#setting-max-connections} {{ tag-all }}

  The maximum number of simultaneous connections permitted for {{ MY }} cluster hosts.

  The minimum value is `10`. The maximum and default values [depend on the selected host class](#settings-instance-dependent) and are set using these formulas:

  - Maximum value: `<number_of_MB_RAM_per_host> / 8`.
  - Default value: `<number_of_MB_RAM_per_host> / 32`, but not less than `100`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_max_connections).

- **Max digest length**{#setting-max-digest-length} {{ tag-con }}

  The amount of memory (in bytes) allocated for the calculation of [normalized statement digests]({{ my.docs }}/refman/8.0/en/performance-schema-statement-digests.html).

  The minimum value is `1024` (1 KB), and the maximum value is `8192` (8 KB). The default value is `1024` (1 KB).

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_max_digest_length).

- **Max execution time**{#setting-max-execution-time} {{ tag-all }}

  The timeout for running `SELECT` SQL queries in milliseconds.

  The minimum value is `0`. In this case, there is no limit on query runtime. The maximum value is `4294967295`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_max_execution_time).

- **Max heap table size**{#setting-max-heap-table-size} {{ tag-all }}

  The maximum size of user-created [MEMORY tables]({{ my.docs }}/refman/8.0/en/memory-storage-engine.html) (in bytes). Changing this setting has no effect on any existing MEMORY table. It is also used in conjunction with the [Tmp table size](#setting-tmp-table-size) setting to limit the size of internal in-memory tables.

  The minimum value is `16384` (16 KB), and the maximum value is `134217728` (128 MB). The default value is `16777216` (16 MB).

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_max_heap_table_size).

- **Max prepared stmt count**{#setting-max-prepared-stmt-count} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Maximum number of prepared requests on the server.

  This option can be used for protecting from DoS attacks that overflow the server memory by a large number of prepared requests.

  The minimum value is `0`, and the maximum value is `4194304`. The default value is `16382`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_max_prepared_stmt_count).

- **Max sp recursion depth**{#setting-max-sp-recursion-depth} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  The maximum number of recursive invocations of a stored procedure.

  The minimum value is `0` (recursion is disabled). The maximum value is `255`. The default value is `0`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_max_sp_recursion_depth).

- **Mdb offline mode disable lag**{#setting-mdb-offline-mode-disable-lag} {{ tag-all }}

  The replication lag (in seconds) before switching {{ MY }} to `offline_mode = OFF`. The value must be less than the [Mdb offline mode enable lag](#setting-mdb-offline-mode-enable-lag) value.

  The minimum value is `60` (1 minute), and the maximum value is `86400` (24 hours). The default value is `300` (5 minutes).

- **Mdb offline mode enable lag**{#setting-mdb-offline-mode-enable-lag} {{ tag-all }}

  The replication lag (in seconds) before switching {{ MY }} to `offline_mode = ON` so that users get up-to-date data.

  The minimum value is `600` (10 minutes), and the maximum value is `432000` (5 days). The default value is `86400` (24 hours).

- **Mdb preserve binlog bytes**{#setting-mdb-preserve-binlog-bytes} {{ tag-all }}

  The size of the binary logs (in bytes) to store on cluster hosts.

  The minimum value is `1073741824` (1 GB), and the maximum value is `107374182400` (100 GB). The default value is `1073741824` (1 GB).

- **Mdb priority choice max lag**{#setting-mdb-priority-choice-max-lag} {{ tag-all }}

  The replication lag (in seconds) before switching the cluster host role from replica to master. The value must be less than the [Mdb offline mode enable lag](#setting-mdb-offline-mode-enable-lag) value.

  The minimum value is `0`, and the maximum value is `86400` (24 hours). The default value is `60` (1 minute).

- **Net read timeout**{#setting-net-read-timeout} {{ tag-all }}

  The maximum number of seconds to wait for more data from a network connection before aborting the read.

  The minimum value is `1`, and the maximum value is `1200` (20 minutes). The default value is `30`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_net_read_timeout).

- **Net write timeout**{#setting-net-write-timeout} {{ tag-all }}

  The maximum number of seconds to wait for data to be written to a network connection before aborting the write.

  The minimum value is `1`, and the maximum value is `1200` (20 minutes). The default value is `60`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_net_write_timeout).

- **Optimizer search depth**{#setting-optimizer-search-depth} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Maximum depth of search performed by the query optimizer.

  If the setting value is higher than the number of relationships in the query, a better query execution plan will be created; it will, however, require more time to create such a plan. If the value is lower, the query execution plan will be generated faster, although it may not be perfect.

  The minimum value is `0` (the system will select the search depth automatically), and the maximum value is `62`. The default value is `62`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/5.7/en/server-system-variables.html#sysvar_optimizer_search_depth).

- **Optimizer switch**{#setting-optimizer-switch} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  String with a [set of flags]({{ my.docs }}/refman/5.7/en/switchable-optimizations.html). Each flag enables or disables certain optimizer behavior.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/5.7/en/server-system-variables.html#sysvar_optimizer_switch).

- **Range optimizer max mem size**{#setting-range-optimizer-max-mem-size} {{ tag-all }}

  The maximum memory consumption (in bytes) by the range optimizer.

  The minimum value is `1048576` (1 MB), and the maximum value is `268435456` (256 MB). The default value is `8388608` (8 MB).

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size).

- **Regexp time limit**{#setting-regexp-time-limit} {{ tag-all }}

  The limit on the number of steps for matching operations performed by [REGEXP_LIKE()]({{ my.docs }}/refman/8.0/en/regexp.html#function_regexp-like) and similar functions when [using regular expressions]({{ my.docs }}/refman/8.0/en/regexp.html). This setting indirectly affects execution time.

  The minimum value is `0` (no limit), and the maximum value is `1048576`. The default value is `0`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_regexp_time_limit).

- **Replication optimize for static plugin config**{#setting-replication-optimize-for-static-plugin-config} {{ tag-con }} {{ tag-api }}

  Allows replicas to use shared locks with [semi-sync replication]({{ my.docs }}/refman/8.0/en/replication-semisync.html). If the setting is disabled, replicas use more locks. This results in increased contention between replicas attempting to get a lock and decreased cluster performance.

  The setting improves performance of replicas and replication source hosts, since they use the same lock mechanism.

  Enable this setting together with **Replication sender observe commit only**. This will improve cluster performance even with a large number of replicas.

  This setting is disabled by default.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/replication-options-replica.html#sysvar_replication_optimize_for_static_plugin_config).

- **Replication sender observe commit only**{#setting-replication-sender-observe-commit-only} {{ tag-con }} {{ tag-api }}

  Imposes a limit on callbacks for [semi-sync replication]({{ my.docs }}/refman/8.0/en/replication-semisync.html). If you do not limit them, the number of locks and contending replicas will increase. This results in decreased cluster performance.

  The setting improves performance of replicas and replication source hosts, since they use the same lock mechanism.

  Enable this setting together with **Replication optimize for static plugin config**. This will improve cluster performance even with a large number of replicas.

  This setting is disabled by default.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/replication-options-replica.html#sysvar_replication_sender_observe_commit_only).

- **Rpl semi sync master wait for slave count**{#setting-rpl-wait-slave-count} {{ tag-all }}

  The number of replicas the master must get a response from during semi-synchronous replication before performing a `COMMIT` on a transaction.

  The minimum value is `1`, and the maximum value is `2`. The default value is `1`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/replication-options-source.html#sysvar_rpl_semi_sync_master_wait_for_slave_count).

- **Slave parallel type**{#setting-slave-parallel-type} {{ tag-all }}

  Specifies the policy used to decide which transactions are allowed to run in parallel on the replica when multithreaded replication is enabled (set by [Slave parallel workers](#setting-slave-parallel-workers)):
  - `LOGICAL_CLOCK`: Transactions that are part of a group commit for the same source binary log run in parallel on the replica.
  - `DATABASE` (default): Transactions that update different databases run in parallel.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_type).

- **Slave parallel workers**{#setting-slave-parallel-workers} {{ tag-all }}

  Sets the number of threads for executing replication transactions in parallel on the replica.

  The minimum value is `0` (multithreading on the replica is disabled), and the maximum value is `64`. The default value is `8`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_workers).

- **Slow query log**{#setting-slow-query-log} {{ tag-all }}

  Permits logging slow queries. A query is considered slow if its execution time exceeds the [Long query time](#setting-long-query-time) setting value.

  Acceptable values:

  * `0` or `OFF`
  * `1` or `ON`

  The default value is `OFF`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log).

- **Slow query log always write time**{#setting-slow-query-log-always-write-time} {{ tag-all }}

  Query execution time (in seconds) after which a query is unconditionally written to the [slow query log](#setting-slow-query-log) ignoring the [Log slow rate limit](#setting-log-slow-rate-limit) setting.

  The minimum value is `0`, and the maximum value is `3600` (1 hour). The default value is `10`.

  For more information, see the [Percona documentation](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time).

- **Sort buffer size**{#setting-sort-buffer-size} {{ tag-all }}

  The size of the buffer (in bytes) used for performing in-memory sorts.

  The minimum value is `32768` (32 KB), and the maximum value is `16777216` (16 MB). The default value is `262144` (256 KB).

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_sort_buffer_size).

- **Sql mode**{#setting-sql-mode} {{ tag-all }}

  {{ MY }} cluster SQL modes:
  - [ALLOW_INVALID_DATES]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_allow_invalid_dates): Do not perform full checking of dates. In this mode, the server checks that the month is in the range from 1 to 12 and the day is in the range from 1 to 31. Invalid dates, such as `2004-04-31`, are converted to `0000-00-00` and a warning is returned.
  - [ANSI_QUOTES]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_ansi_quotes): Treat `"` quotes as identifier quotes and not string quotes. With this mode enabled, use single quotes (`'`) rather than double quotes (`"`) for strings.
  - [ERROR_FOR_DIVISION_BY_ZERO]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_error_for_division_by_zero): Division by zero returns `NULL` and a warning. This SQL mode is deprecated.
  - [HIGH_NOT_PRECEDENCE]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_high_not_precedence): Gives higher precedence to the `NOT` operator when parsing Boolean expressions. In this mode, the `NOT a BETWEEN b AND c` expression will be interpreted as `(NOT a) BETWEEN b AND c` instead of `NOT (a BETWEEN b AND c)`.
  - [IGNORE_SPACE]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_ignore_space): Allows spaces between a function name and the opening bracket (`(`). As a result, built-in function names are treated as keywords. Identifiers that are the same as function names must be quoted.
  - [NO_AUTO_VALUE_ON_ZERO]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_no_auto_value_on_zero): Only `NULL` inserted into the `AUTO_INCREMENT` column generates the next sequence number for the column. Normally, new sequence numbers are generated when inserting either `0` or `NULL` into it. So this mode can be useful if you need to explicitly store `0` in this column.
  - [NO_BACKSLASH_ESCAPES]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_no_backslash_escapes): Disables the use of the backslash character (`\`) as an escape character. With this mode enabled, backslash is treated as an ordinary character.
  - [NO_DIR_IN_CREATE]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_no_dir_in_create): When creating a table, ignore the `INDEX DIRECTORY` and `DATA DIRECTORY` directives.
  - [NO_ENGINE_SUBSTITUTION]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_no_engine_substitution): Do not use the default storage engine automatically and return an error if the `CREATE TABLE` or `ALTER TABLE` statement specifies an engine that is unavailable.
  - [NO_UNSIGNED_SUBTRACTION]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_no_unsigned_subtraction): A negative result is allowed when using subtraction between integer values, one of which is unsigned.
  - [NO_ZERO_DATE]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_no_zero_date): Affects the use of the `0000-00-00` date: {#setting-no-zero-date}
    - If [strict SQL mode](#setting-strict-mode) is disabled, the `0000-00-00` date is allowed, and inserting it produces a warning.
    - If strict SQL mode is enabled, the `0000-00-00` date is not allowed. If you try to insert it, you will get an error.

    This SQL mode is deprecated.

  - [NO_ZERO_IN_DATE]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_no_zero_in_date): Affects the use of dates in which the month or day is zero:
    - If [strict SQL mode](#setting-strict-mode) is disabled, dates with a zero month or day are inserted as `0000-00-00` with a warning returned.
    - If strict SQL mode is enabled, dates with zero parts are not permitted. If you try to insert them, an error occurs.

    This SQL mode is deprecated.

    See also: [NO_ZERO_DATE](#setting-no-zero-date).

  - [ONLY_FULL_GROUP_ BY]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_only_full_group_by): Prohibits queries in which `SELECT`, `HAVING`, or `ORDER BY` refer to non-aggregated columns that are not included in `GROUP BY` ([SQL-92]({{ my.docs }}/refman/8.0/en/group-by-handling.html) behavior).
  - [PAD_CHAR_TO_FULL_LENGTH]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_pad_char_to_full_length): `CHAR` column values are padded with spaces to their full length. This does not apply to `VARCHAR` columns.
  - [PIPES_AS_CONCAT]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_pipes_as_concat): Treat `||` as a concatenation operator (same as [CONCAT()]({{ my.docs }}/refman/8.0/en/string-functions.html#function_concat)) rather than a synonym for [OR]({{ my.docs }}/refman/8.0/en/logical-operators.html#operator_or).
  - [REAL_AS_FLOAT]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_real_as_float): Treat `REAL` as a synonym for `FLOAT` (by default, {{ MY }} treats `REAL` as a synonym for `DOUBLE`).
  - [STRICT_ALL_TABLES]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_strict_all_tables): Enable [strict SQL mode]({{ my.docs }}/refman/8.0/en/sql-mode.html#sql-mode-strict) for all engines.
  - [STRICT_TRANS_TABLES]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_strict_trans_tables): Enable [strict SQL mode]({{ my.docs }}/refman/8.0/en/sql-mode.html#sql-mode-strict) for all transactional engines and, when possible, for non-transactional engines. {#setting-strict-mode}
  - [TIME_TRUNCATE_FRACTIONAL]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_time_truncate_fractional): Enables truncation of a fractional part when inserting a `TIME`, `DATE`, or `TIMESTAMP` value into a column that has fewer fractional digits (by default, {{ MY }} uses rounding instead of truncation).
  - [ANSI]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_ansi): A combination of the following modes:
    - `REAL_AS_FLOAT`
    - `PIPES_AS_CONCAT`
    - `ANSI_QUOTES`
    - `IGNORE_SPACE`
    - `ONLY_FULL_GROUP_BY`.
  - [TRADITIONAL]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_traditional): A combination of the following modes:
    - `STRICT_ALL_TABLES`
    - `STRICT_TRANS_TABLES`
    - `NO_ZERO_DATE`
    - `NO_ZERO_IN_DATE`
    - `ERROR_FOR_DIVISION_BY_ZERO`
    - `NO_ENGINE_SUBSTITUTION`

  You can select multiple modes from the list or completely disable all SQL Mode settings.

  By default, the following set of SQL modes is used:
  - `ERROR_FOR_DIVISION_BY_ZERO`
  - `NO_ENGINE_SUBSTITUTION`
  - `NO_ZERO_DATE`
  - `NO_ZERO_IN_DATE`
  - `ONLY_FULL_GROUP_BY`
  - `STRICT_TRANS_TABLES`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/sql-mode.html#sql-mode-setting).

- **Sync binlog**{#setting-sync-binlog} {{ tag-all }}

  Determines how often the binary log is synchronized to disk:
  - `0`: Synchronization is disabled. {{ MY }} relies on the operating system to flush the binary log to the disk from time to time, as it does for any other file. This method provides the best performance. However, data might be lost in case of power failure or operating system crash, as transactions might be committed before they are synced to the binary log.
  - `1`: The binary log is synchronized to disk before transactions are committed. This is the safest method, but it may have a negative impact on performance due to the increased number of disk writes. In the event of a power failure or operating system crash, transactions that are missing from the binary log are in a prepared state. This lets you perform automatic recovery and roll back the transactions, which guarantees that no transaction is lost from the binary log.
  - `N`: The binary log is synchronized to disk after collecting `N` commit groups for the binary log. In case power fails or the operating system crashes, transactions might be committed before they are synced to the binary log. This method may have a negative impact on performance due to the increased number of disk writes. The higher the `N` value, the better the performance and the higher the risk of data loss.

  The minimum value is `0`, and the maximum value is `4096`. The default value is `1`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/replication-options-binary-log.html#sysvar_sync_binlog).

- **Table definition cache**{#setting-table-definition-cache} {{ tag-all }}

  The number of table definitions that can be stored in the definition cache. If your database has a large number of tables, increase this value to speed up opening of tables.

  The minimum value is `400`, and the maximum value is `524288`. The default value is `2000`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_table_definition_cache).

- **Table open cache**{#setting-table-open-cache} {{ tag-all }}

  The size of the open tables cache for all threads. If the value of [Opened tables]({{ my.docs }}/refman/8.0/en/server-status-variables.html#statvar_Opened_tables) is large and you do not use [FLUSH_TABLES]({{ my.docs }}/refman/8.0/en/flush.html#flush-tables) often, increase the value of this setting.

  Increasing it requires increasing the number of file descriptors for the {{ MY }} cluster hosts.

  The minimum value is `400`, and the maximum value is `524288`. The default value is `4000`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache).

- **Table open cache instances**{#setting-table-open-cache-instances} {{ tag-all }}

  To improve scalability, the [open tables cache](#setting-table-open-cache) can be partitioned into smaller segments. This value sets the number of such cache instances.

  The minimum value is `1`, and the maximum value is `32`. The default value is `16`.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache_instances).

- **Thread cache size**{#setting-thread-cache-size} {{ tag-all }}

  The number of threads that are cached to handle new connections. When establishing a new connection, threads from the cache are reused first and only then new threads are created. Increase this value to improve performance if you have a lot of new connections.

  The minimum value is `10`, and the maximum value is `10000`. The default value [depends on the selected host class](#settings-instance-dependent) and is determined by the formula:

  ```text
  max_connections / 10
  ```

  Where `max_connections` is the default value of the [Max connections](#setting-max-connections) setting for the selected host class.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_thread_cache_size).

- **Thread stack**{#setting-thread-stack} {{ tag-all }}

  The stack size (in bytes) for each thread. The default value is large enough for normal operation of the {{ MY }} server. If the thread stack size is too small, it limits the complexity of SQL statements, the recursion depth of stored procedures, and other memory-consuming actions.

  The minimum value is `131072` (128 KB), and the maximum value is `16777216` (16 MB). The default value is `196608` (192 KB).

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_thread_stack).

- **Tmp table size**{#setting-tmp-table-size} {{ tag-all }}

  The maximum size of in-memory temporary tables (in bytes). If a table exceeds this limit, it is converted to an on-disk temporary table. This setting does not affect user-created MEMORY tables. Increase its value if you run many complex `GROUP BY` queries and your hosts have enough RAM.

  The minimum value is `1024` (1 KB), and the maximum value is `134217728` (128 MB). The default value is `16777216` (16 MB).

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_tmp_table_size).

- **Transaction isolation**{#setting-transaction-isolation} {{ tag-all }}

  The default transaction isolation level:
  - `READ-COMMITTED`: Query only sees the strings committed before it is run.
  - `REPEATABLE-READ`: All queries in the current transaction only see the strings committed before running the first select or update data query within this transaction.
  - `SERIALIZABLE`: Similar to `REPEATABLE-READ`, except that InnoDB implicitly converts `SELECT` statements to `SELECT ... FOR SHARE` if [autocommit]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_autocommit) is disabled. If autocommit is enabled, `SELECT` remains in its own transaction in `read only` mode and can be serialized.

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_transaction_isolation).

- **Wait timeout**{#setting-wait-timeout} {{ tag-all }}

  The period of time (in seconds) for which the server waits for activity during a non-interactive connection before terminating it.

  The minimum value is `600` (10 minutes), and the maximum value is `86400` (24 hours). The default value is `28800` (8 hours).

  For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_wait_timeout).
