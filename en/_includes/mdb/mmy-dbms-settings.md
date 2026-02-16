- **Audit log**{#setting-audit-log} {{ tag-all }}

  {% include [requires-restart](note-requires-restart.md) %}

  Manages {{ MY }} audit logging.

  By default, audit logging is disabled.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/audit-log-reference.html#audit-log-options-variables).

- **Audit log policy**{#setting-audit-log-policy} {{ tag-con }}

  {% include [requires-restart](note-requires-restart.md) %}

  Defines which events will be written to the audit log:

  * `ALL`: All events.
  * `LOGINS` (default): Only login events.
  * `QUERIES`: Only query events.
  * `NONE`: None.

  The **Audit log policy** setting is only relevant if **Audit log** is enabled.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/audit-log-reference.html#sysvar_audit_log_policy).

- **Auto increment**{#setting-auto-increment-increment} {{ tag-all }}

  Specifies the step between successive values in `AUTO_INCREMENT` columns.

  The valid values range from `1` to `65535`. The default value is `1`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/replication-options-source.html#sysvar_auto_increment_increment).

- **Auto increment offset**{#setting-auto-increment-offset} {{ tag-all }}

  Specifies the initial value for `AUTO_INCREMENT` columns. If greater than [Auto increment](#setting-auto-increment-increment), this setting is ignored.

  The valid values range from `1` to `65535`. The default value is `1`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/replication-options-source.html#sysvar_auto_increment_offset).

- **Binlog cache size**{#setting-binlog-cache-size} {{ tag-all }}

  Defines the cache size (in bytes) for [binary log]({{ my.docs }}/refman/8.0/en/binary-log.html) changes during a transaction.

  The valid values range from `4096` (4 KB) to `67108864` (64 MB). The default value is `32768` (32 KB).

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_cache_size).

- **Binlog group commit sync delay**{#setting-binlog-sync-delay} {{ tag-all }}

  Specifies the delay before syncing the binary log to disk during a `COMMIT`. To synchronize more transactions to disk at a time, set the delay to a value greater than zero. This will reduce the total time per `COMMIT` for a group of transactions.

  The valid values range from `0` (no delay) to `1000000` (one second). The default value is `0`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_group_commit_sync_delay).

- **Binlog row image**{#setting-binlog-row-image} {{ tag-all }}

  Specifies how to write row images to the binary log for row-based replication:
  - `FULL` (default): Log all columns in both the _before_ and _after_ images.
  - `MINIMAL`: Log only columns required for identifying the rows to change in the _before_ image and only columns updated by an SQL statement or affected by an auto increment in the _after_ image.
  - `NOBLOB`: Log all columns in the _before_ and _after_ images (same as `FULL`), except for `BLOB` and `TEXT` columns that either have not changed or are not required to identify rows.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image).

- **Binlog rows query log events**{#setting-binlog-log-events} {{ tag-all }}

  Specifies whether to write informational events, such as query log events, to the binary log.

  By default, this setting is disabled.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events).

- **Binlog transaction dependency tracking**{#setting-binlog-transaction-dependency-tracking} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Specifies how to compute logical timestamps, allowing replicas to identify transactions that can run concurrently. It is used to generate dependency information, which is written to the binary log when multi-threaded replication ([Slave parallel workers](#setting-slave-parallel-workers)) is enabled with the [Slave parallel type](#setting-slave-parallel-type) set to `LOGICAL_CLOCK`.

  Possible values:

  - `COMMIT_ORDER` (default): Two transactions are considered independent if their commit time windows overlap.
  - `WRITESET`: This approach is based on `COMMIT_ORDER`. In addition to the above condition, two transactions are considered conflicting if they share a hash value in their write sets.
  - `WRITESET_SESSION`: Two transactions are considered dependent if at least one of the following conditions is met:

    - The transactions are dependent according to `WRITESET`.
    - The transactions committed within the same user session.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_transaction_dependency_tracking).

- **Character set server**{#setting-character-set-server} {{ tag-all }}

  Specifies the [character set]({{ my.docs }}/refman/8.0/en/charset.html) the {{ MY }} cluster uses for processing data and communicating with {{ MY }} clients. It also determines how SQL string functions and other features work.

  The default value is `utf8mb4`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_character_set_server).

- **Collation server**{#setting-collation-server} {{ tag-all }}

  Specifies the [collation algorithm]({{ my.docs }}/refman/8.0/en/charset.html) the {{ MY }} cluster uses when processing data and communicating with {{ MY }} clients. It also determines how SQL sorting and string functions, and other features work.

  The default value is `utf8mb4_0900_ai_ci`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_collation_server).

- **Default authentication plugin**{#setting-authentication-plugin} {{ tag-all }}

  {% include [requires-restart](note-requires-restart.md) %}

  Specifies the authentication plugin used by the {{ mmy-name }} cluster:
  - `mysql_native_password`: Authentication method used in {{ MY }} prior to authentication plugins.
  - `sha256_password`: Authentication using SHA-256 for passwords.
  - `caching_sha2_password` (default): Similar to `sha256_password`, uses server-side caching for better performance and provides some additional features.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin).

- **Default time zone**{#setting-time-zone} {{ tag-all }}

  Specifies the server time zone.

  The default value is `Europe/Moscow`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-options.html#option_mysqld_default-time-zone).

- **Explicit defaults for timestamp**{#setting-defaults-for-timestamp} {{ tag-all }}

  Manages non-standard default values and `NULL` value processing in `TIMESTAMP` columns.

  By default, this setting is enabled, **disables** any non-standard behaviors.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_explicit_defaults_for_timestamp).

- **General log**{#setting-general-log} {{ tag-all }}

  Manages {{ MY }} general query logging.

  By default, it is disabled.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_general_log).

- **Group concat max len**{#setting-group-concat-max} {{ tag-all }}

  Sets the maximum result length (in bytes) for the [GROUP_CONCAT()]({{ my.docs }}/refman/8.0/en/aggregate-functions.html#function_group-concat) function.

  The valid values range from `4` to `33554432` (32 MB). The default value is `1024` (1 KB).

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_group_concat_max_len).

- **Innodb adaptive hash index**{#setting-adaptive-hash-index} {{ tag-all }}

  Manages the InnoDB [adaptive hash index]({{ my.docs }}/refman/8.0/en/glossary.html#glos_adaptive_hash_index). Depending on the database workload, disabling this index may improve performance. The {{ MY }} guides recommend running load testing on real data to determine whether to enable or disable it.

  By default, the adaptive hash index is enabled.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_adaptive_hash_index).

- **Innodb buffer pool size**{#setting-buffer-pool-size} {{ tag-all }}

  {% note warning %}

  If your cluster is running {{ MY }} 5.7, changing this setting will cause the cluster hosts to restart one at a time. {{ MY }} 8.0 cluster will restart only if you decrease the value of this setting.

  {% endnote %}

  Specifies the size of the InnoDB buffer pool (in bytes) used for caching table and index data. A larger buffer pool requires fewer I/O operations when the same table data is accessed repeatedly.

  The minimum value is `134217728` (128 MB). The maximum and default values [depend on the selected host class](#settings-instance-dependent) and are set according to the table below:

  | Amount of GB RAM on the host | Default value | Maximum value |
  |----------------------------|:---------------------:|:---------------------:|
  | 2                          | `268435456` (0.25 GB) | `536870912` (0.5 GB)  |
  | 4                          | `1610612736` (1.5 GB) | `2684354560` (2.5 GB) |
  | ≥ 8                        | `0.5 × RAM`           | `0.8 × RAM`           |

  For more information, see [these configuration recommendations](../../managed-mysql/qa/configuring.md#innodb-buffer-pool-size) and [this{{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size).

- **Innodb change buffering**{#setting-innodb-change-buffering} {{ tag-all }}

  Determines which secondary index changes will be temporarily stored in the Innodb change buffer before being written to disk.

  Possible values:

  * `none`: Do not store changes.
  * `inserts`: Store changes resulting from insert operations.
  * `deletes`: Store changes resulting from delete operations.
  * `changes`: Store changes resulting from insert and delete operations.
  * `purges`: Store changes resulting from background delete operations.
  * `all`: Store all changes. This is a default value.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_change_buffering).

- **Innodb compression level**{#setting-innodb-compression-level} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Sets the `zlib` compression level used for InnoDB compressed tables and indexes.

  The valid values range from `0` to `9`. The default value is `6`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_compression_level).

- **Innodb flush log at trx commit**{#setting-flush-log-commit} {{ tag-all }}

  Determines {{ MY }} log-flushing behavior for transaction `COMMIT` operations:
  - `1` (default): Full [ACID]({{ my.docs }}/refman/8.0/en/glossary.html#glos_acid) compliance. Logs are written and flushed to disk at each transaction commit.
  - `2`: Logs are written after each transaction is committed but flushed to disk once per second. If the system crashes, transactions whose logs were not flushed to disk may be lost.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_flush_log_at_trx_commit).

- **Innodb ft max token size**{#setting-ft-max-token-size} {{ tag-all }}

  {% include [requires-restart](note-requires-restart.md) %}

  Sets the maximum length of words stored in the InnoDB `FULLTEXT` index.

  The valid values range from `10` to `84`. The default value is `84`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_max_token_size).

- **Innodb ft min token size**{#setting-ft-min-token-size} {{ tag-all }}

  {% include [requires-restart](note-requires-restart.md) %}

  Specifies the minimum length of words stored in the InnoDB `FULLTEXT` index.

  The valid values range from `0` to `16`. The default value is `3`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_ft_min_token_size).

- **Innodb io capacity**{#setting-innodb-io-capacity} {{ tag-all }}

  Specifies the number of I/O operations per second (IOPS) for all InnoDB background operations. This setting affects processes that require I/O, such as flushing data to disk, and can be used to limit the number of I/O operations.

  The valid values range from `100` to `100000`. The default value is `200`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity).

- **Innodb io capacity max**{#setting-innodb-io-capacity-max} {{ tag-all }}

  Sets the upper IOPS limit for all InnoDB background operations. If the host falls behind on flushing, InnoDB may start flushing data to disk at a higher rate than defined by the [Innodb io capacity](#setting-innodb-io-capacity) but within this upper IOPS limit.

  The valid values range from `100` to `100000`. The default value is `2000`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_io_capacity_max).

- **Innodb lock wait timeout**{#setting-innodb-lock-wait-timeout} {{ tag-all }}

  Specifies the maximum time (in seconds) an InnoDB transaction waits for a row lock. Upon timeout, the system returns an error and the current SQL statement (**not** the entire transaction) is rolled back.

  You can decrease this value for OLTP applications and interactive user apps. You can increase this value if your application runs lengthy operations, such as large `INSERT` or `UPDATE` queries awaiting completion when transforming large datasets from the storage system.

  The minimum value is `1`, and the maximum, `28800` (480 minutes, or 8 hours). The default value is `50`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lock_wait_timeout).

- **Innodb log buffer size**{#setting-log-buffer-size} {{ tag-all }}

  Sets the size of the buffer (in bytes) that InnoDB uses when writing logs to disk. With a larger buffer, InnoDB can process larger transactions without disk flushes prior to commit, thus lowering I/O load.

  The valid values range from `1048576` (1 MB) to `268435456` (256 MB). The default value is `16777216` (16 MB).

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_buffer_size).

- **Innodb log file size**{#setting-log-file-size} {{ tag-all }}

  {% include [requires-restart](note-requires-restart.md) %}

  Sets the size of a single InnoDB redo log file (in bytes). A larger size decreases [checkpoint]({{ my.docs }}/refman/8.0/en/glossary.html#glos_checkpoint) flushes to disk, thus saving I/O resources, yet results in slower recovery after failures.

  The valid values range from `268435456` (256 MB) to `4294967296` (4 GB). The default value is `268435456` (256 MB).

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size).

- **Innodb lru scan depth**{#setting-innodb-lru-scan-depth} {{ tag-con }} {{ tag-api }}

  Sets the number of free pages that InnoDB attempts to keep in each buffer pool to speed up page read and create operations.

  The valid values range from `100` to `4294967295`. The default value is `1024`.

  The higher the value, the more the setting affects cluster performance and memory usage:

  * Increase the value only if the cluster has spare I/O capacity under typical workloads.
  * Decrease the value if the system lacks resources with the current setting.

  In most cases, the default value works well.

  Refer to the Percona blog and {{ MY }} article, to learn:

  * [How to calculate the setting value](https://www.percona.com/blog/tuning-mysql-innodb-flushing-for-a-write-intensive-workload/).
  * [More about this setting]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_lru_scan_depth).

- **Innodb numa interleave**{#setting-innodb-numa-interleave} {{ tag-all }}

  {% include [requires-restart](note-requires-restart.md) %}

  Manages the [NUMA interleave](https://www.kernel.org/doc/html/latest/admin-guide/mm/numa_memory_policy.html#components-of-memory-policies) policy for allocating memory to the InnoDB buffer pool.

  This policy is disabled by default.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_numa_interleave).

- **Innodb online alter log max size**{#setting-online-alter-log-max-size} {{ tag-all }}

  Sets the size of temporary InnoDB log files (in bytes) used during [online DDL operations]({{ my.docs }}/refman/8.0/en/glossary.html#glos_online_ddl). Increasing this value enables more concurrent [DML operations]({{ my.docs }}/refman/8.0/en/glossary.html#glos_dml) during online DDL, but prolongs the final table lock required to apply the log data.

  The valid values range from `65536` (64 KB) to `107374182400` (100 GB). The default value is `134217728` (128 MB).

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size).

- **Innodb page size**{#setting-innodb-page-size} {{ tag-all }}

  Specifies the page size (in bytes) for InnoDB tablespaces. You cannot edit this setting once the cluster is created.

  Allowed values: `4096` (4 KB), `8192` (8 KB), `16384` (16 KB), `32768` (32 KB), and `65536` (64 KB). The default value is `16384` (16 KB).

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_page_size).

- **Innodb print all deadlocks**{#setting-print-all-deadlocks} {{ tag-all }}

  Determines whether InnoDB writes complete information about all [deadlocks]({{ my.docs }}/refman/8.0/en/innodb-deadlocks.html) to the error log. If this setting is disabled, the `SHOW ENGINE INNODB STATUS` command will only show information about the last deadlock.

  By default, printing all deadlocks is disabled.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_print_all_deadlocks).

- **Innodb purge threads**{#setting-innodb-purge-threads} {{ tag-all }}

  {% include [requires-restart](note-requires-restart.md) %}

  Specifies the number of InnoDB I/O threads used for [purge operations]({{ my.docs }}/refman/8.0/en/glossary.html#glos_purge). Increasing this value can be useful for systems where DML operations (`INSERT`, `UPDATE`, or `DELETE`) affect multiple tables.

  The valid values range from `1` to `16`. The default value is `4`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_purge_threads).

- **Innodb read io threads**{#setting-innodb-read-io-threads} {{ tag-all }}

  {% include [requires-restart](note-requires-restart.md) %}

  Specifies the number of InnoDB I/O threads used for read operations.

  The valid values range from `1` to `16`. The default value is `4`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_read_io_threads).

- **Innodb status output**{#setting-innodb-status-output} {{ tag-con }}

  Manages the output of the standard [InnoDB]({{ my.docs }}/refman/8.0/en/innodb-enabling-monitors.html) monitor.

  By default, the standard monitor is disabled.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_status_output).

- **Innodb strict mode**{#setting-strict-mode} {{ tag-con }}

  Manages InnoDB [strict mode]({{ my.docs }}/refman/8.0/en/glossary.html#glos_strict_mode). When this setting is enabled, specific conditions that are normally treated as warnings are considered errors.

  By default, InnoDB strict mode is enabled.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_strict_mode).

- **Innodb temp data file max size**{#setting-temp-data-max-size} {{ tag-all }}

  {% include [requires-restart](note-requires-restart.md) %}

  Sets the maximum size of an InnoDB [temporary tablespace]({{ my.docs }}/refman/8.0/en/innodb-temporary-tablespace.html#innodb-global-temporary-tablespace) (in bytes).

  The valid values range from `0` (no temporary tablespace is used) to `107374182400` (100 GB). The default value is `0`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_temp_data_file_path).

- **Innodb thread concurrency**{#setting-innodb-thread-concurrency} {{ tag-all }}

  Sets the maximum number of concurrent threads in InnoDB.

  The valid values range from `0` (no restrictions) to `1000`. The default value is `0`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_thread_concurrency).

- **Innodb write io threads**{#setting-innodb-write-io-threads} {{ tag-all }}

  {% include [requires-restart](note-requires-restart.md) %}

  Specifies the number of InnoDB I/O threads used for write operations.

  The valid values range from `1` to `16`. The default value is `4`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/innodb-parameters.html#sysvar_innodb_write_io_threads).

- **Interactive timeout**{#setting-interactive-timeout} {{ tag-all }}

  Sets the activity wait interval (in seconds) for an interactive connection before the server terminates it.

  The valid values range from `600` (10 minutes) to `86400` (24 hours). The default value is `28800` (8 hours).

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_interactive_timeout).

- **Join buffer size**{#setting-join-buffer-size} {{ tag-all }}

  Sets the minimum buffer size (in bytes) used for:
  - Plain index scans.
  - Range index scans.
  - Full table scans (for `JOIN` operations hat do not use indexes).

  One join buffer of the specified size is allocated for each full join between two tables. Increase the value of this setting to get a faster full join when adding indexes is not possible.

  The valid values range from `1024` (1 KB) to `16777216` (16 MB). The default value is `262144` (256 KB).

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_join_buffer_size).

- **Lock wait timeout**{#setting-lock-wait-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Specifies the timeout (in seconds) for an attempt to acquire a [metadata lock]({{ my.docs }}/refman/8.0/en/metadata-locking.html).

  The valid values range from `1` to `31536000` (1 year). The default value is `31536000`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_lock_wait_timeout).

- **Log error verbosity**{#setting-log-error-verbosity} {{ tag-con }}

  Defines the type of events written to the error log:

  - `2`: Errors and warnings.
  - `3` (default): Errors, warnings, and information messages.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_log_error_verbosity).

- **Log slow filter**{#setting-log-slow-filter} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Specifies the filter for the slow query log by query type. It is a string with any combination of the following comma-separated values:

  * `full_scan`: Log queries that perform a full table scan.
  * `full_join`: Log queries that perform a full join without indexes.
  * `tmp_table`: Log queries that create an implicit internal temporary table.
  * `tmp_table_on_disk`: Log queries that save a temporary table to disk.
  * `filesort`: Log queries that perform file sorting.
  * `filesort_on_disk`: Log queries that perform sorting of disk files.

  If the filter value is set, only query types included in the filter appear in the slow query log.

  The default value is `""` (empty string, query filtering is disabled).

  For more information, see [this Percona article](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_filter).

- **Log slow rate limit**{#setting-log-slow-rate-limit} {{ tag-all }}

  Sets the proportion of queries that appear in the slow query log. Depending on the value of [Log slow rate type](#setting-log-slow-rate-type), this setting applies to either individual queries or sessions.

  If its value is set to `1`, each query or session considered slow is logged. With other values, every Nth query or session is logged, reducing the cluster load.

  Queries that run longer than [Slow query log always write time](#setting-slow-query-log-always-write-time) are always written to the [slow query log](#setting-slow-query-log) regardless of the [Log slow rate limit](#setting-log-slow-rate-limit) value.

  The valid values range from `1` to `1000`. The default value is `1`.

  For more information, see [this Percona article](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_limit).

- **Log slow rate type**{#setting-log-slow-rate-type} {{ tag-all }}

  Sets the type of logging for [Log slow rate limit](#setting-log-slow-rate-limit):

  * `query`: At the query level.
  * `session`: At the session level.

  The default value is `query`.

  For more information, see [this Percona article](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_rate_type).

- **Log slow sp statements**{#setting-log-slow-sp-statements} {{ tag-all }}

  Manages logging of statements executed within stored procedures in the slow query log.

  By default, statement logging is enabled.

  For more information, see [this Percona article](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#log_slow_sp_statements).

- **Long query time**{#setting-long-query-time} {{ tag-all }}

  Sets the maximum execution time (in seconds) before the query is considered slow. Smaller values of this setting result in more statements being considered slow.

  The valid values range from `0` to `3600` (1 hour). The default value is `10`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_long_query_time).

- **Lower case table names**{#setting-lower-case-table-names} {{ tag-all }}

  Specifies how table names are stored and compared:

  - `0` (default): Table names are saved with no changes. Comparisons are case-sensitive.
  - `1`: Table names are saved in lowercase. Comparisons are case-insensitive.

  You cannot edit this setting once the cluster is created.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_lower_case_table_names).

- **Max allowed packet**{#setting-max-allowed-packet} {{ tag-all }}

  Sets the maximum size (in bytes) of a single packet, row, or parameter sent by [mysql_stmt_send_long_data()]({{ my.docs }}/c-api/8.0/en/mysql-stmt-send-long-data.html).

  The default value is small to discard oversized packets. Increase the setting value when using large BLOB columns or long strings.

  The valid values range from `1024` (1 KB) to `1073741824` (1 GB). The default value is `16777216` (16 MB).

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet).

- **Max connections**{#setting-max-connections} {{ tag-all }}

  Sets the maximum number of simultaneous client connections supported by a {{ MY }} host.

  The minimum value is `10`. The maximum and default values [depend on the selected host class](#settings-instance-dependent) and are calculated as follows:

  - Maximum value: `<MB_of_RAM_per_host> / 8`.
  - Default value: `<MB_of_RAM_per_host> / 32`, but not less than `100`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_max_connections).

- **Max digest length**{#setting-max-digest-length} {{ tag-con }}

  {% include [requires-restart](note-requires-restart.md) %}

  Sets the memory allocation (in bytes) used for computing [normalized statement digests]({{ my.docs }}/refman/8.0/en/performance-schema-statement-digests.html).

  The valid values range from `1024` (1 KB) to `8192` (8 KB). The default value is `1024` (1 KB).

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_max_digest_length).

- **Max execution time**{#setting-max-execution-time} {{ tag-all }}

  Sets the execution timeout (in milliseconds) for `SELECT` statements.

  The minimum value is `0`. In this case, there is no limit on query runtime. The maximum value is `4294967295`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_max_execution_time).

- **Max heap table size**{#setting-max-heap-table-size} {{ tag-all }}

  Sets the maximum size of user-created [MEMORY tables]({{ my.docs }}/refman/8.0/en/memory-storage-engine.html) (in bytes). Changing this setting has no effect on any existing MEMORY table. It also works with [Tmp table size](#setting-tmp-table-size) for internal in-memory tables.

  The valid values range from `16384` (16 KB) to `134217728` (128 MB). The default value is `16777216` (16 MB).

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_max_heap_table_size).

- **Max prepared stmt count**{#setting-max-prepared-stmt-count} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Sets the maximum number of prepared statements on the server.

  This limit helps protect the server from DoS attacks that overflow server memory with prepared statements.

  The valid values range from `0` to `4194304`. The default value is `16382`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_max_prepared_stmt_count).

- **Max sp recursion depth**{#setting-max-sp-recursion-depth} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Sets the maximum number of recursive calls allowed for stored procedures.

  The valid values range from `0` (recursion is disabled) to `255`. The default value is `0`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_max_sp_recursion_depth).

- **Mdb force SSL**{#setting-mdb-force-ssl} {{ tag-all }}

  Enables the `require_secure_transport` setting for all cluster hosts, restricting access to SSL or TLS connections.

  This setting is disabled by default.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_require_secure_transport).  

- **Mdb offline mode disable lag**{#setting-mdb-offline-mode-disable-lag} {{ tag-all }}

  Specifies the replication lag (in seconds) before switching {{ MY }} to `offline_mode = OFF`. Make sure it is less than [Mdb offline mode enable lag](#setting-mdb-offline-mode-enable-lag).

  The valid values range from `60` (1 minute) to `86400` (24 hours). The default value is `300` (5 minutes).

- **Mdb offline mode enable lag**{#setting-mdb-offline-mode-enable-lag} {{ tag-all }}

  Specifies the replication lag (in seconds) before switching {{ MY }} to `offline_mode = ON` so that users get up-to-date data.

  The valid values range from `600` (10 minutes) to `432000` (5 days). The default value is `86400` (24 hours).

- **Mdb preserve binlog bytes**{#setting-mdb-preserve-binlog-bytes} {{ tag-all }}

  Sets the size (in bytes) of binary logs to store on cluster hosts.

  The valid values range from `1073741824` (1 GB) to `107374182400` (100 GB). The default value is `1073741824` (1 GB).

- **Mdb priority choice max lag**{#setting-mdb-priority-choice-max-lag} {{ tag-all }}

  Specifies the replication lag (in seconds) before a host is promoted from replica to master. Make sure it is less than [Mdb offline mode enable lag](#setting-mdb-offline-mode-enable-lag).

  The valid values range from `0` to `86400` (24 hours). The default value is `60` (1 minute).

- **Net read timeout**{#setting-net-read-timeout} {{ tag-all }}

  Sets the maximum number of seconds to wait for more data from a network connection before aborting the read.

  The valid values range from `1` to `1200` (20 minutes). The default value is `30`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_net_read_timeout).

- **Net write timeout**{#setting-net-write-timeout} {{ tag-all }}

  Sets the maximum number of seconds to wait for data to write to a network connection before aborting the write.

  The valid values range from `1` to `1200` (20 minutes). The default value is `60`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_net_write_timeout).

- **Optimizer search depth**{#setting-optimizer-search-depth} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Specifies the maximum depth of search performed by the query optimizer.

  A value larger than the number of relations in a query results in a better query plan, but takes longer to generate the plan. A value smaller than the number of relations in a query returns an execution plan quicker, but the plan may be far from being optimal.

  The valid values range from `0` (the system will select the search depth automatically) to `62`. The default value is `62`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/5.7/en/server-system-variables.html#sysvar_optimizer_search_depth).

- **Optimizer switch**{#setting-optimizer-switch} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Sets a [list of flags]({{ my.docs }}/refman/5.7/en/switchable-optimizations.html), each enabling or disabling a specific optimizer behavior.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/5.7/en/server-system-variables.html#sysvar_optimizer_switch).

- **Range optimizer max mem size**{#setting-range-optimizer-max-mem-size} {{ tag-all }}

  Sets the limit (in bytes) on memory consumption for the range optimizer.

  The valid values range from `1048576` (1 MB) to `268435456` (256 MB). The default value is `8388608` (8 MB).

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_range_optimizer_max_mem_size).

- **Regexp time limit**{#setting-regexp-time-limit} {{ tag-all }}

  Sets the limit on the number of steps for matching operations performed by [REGEXP_LIKE()]({{ my.docs }}/refman/8.0/en/regexp.html#function_regexp-like) and similar functions when [using regular expressions]({{ my.docs }}/refman/8.0/en/regexp.html). This setting indirectly affects execution time.

  The valid values range from `0` (no limit) to `1048576`. The default value is `0`.

  This feature is only supported by {{ MY }} 8.0.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_regexp_time_limit).

- **Replication optimize for static plugin config**{#setting-replication-optimize-for-static-plugin-config} {{ tag-con }} {{ tag-api }}

  Allows replicas to use shared locks with [semi-sync replication]({{ my.docs }}/refman/8.0/en/replication-semisync.html). If this setting is disabled, replicas use more locks, resulting in increased contention between replicas attempting to acquire a lock and decreased cluster performance.

  This setting improves performance of replicas and replication source hosts, since they use the same locking mechanism.

  Enable it along with **Replication sender observe commit only** to improve cluster performance even with a large number of replicas.

  This setting is disabled by default.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/replication-options-replica.html#sysvar_replication_optimize_for_static_plugin_config).

- **Replication sender observe commit only**{#setting-replication-sender-observe-commit-only} {{ tag-con }} {{ tag-api }}

  Enables a limit on callbacks for [semi-sync replication]({{ my.docs }}/refman/8.0/en/replication-semisync.html). If disabled, the number of locks and contending replicas increases. This results in decreased cluster performance.

  This setting improves performance of replicas and replication source hosts, since they use the same locking mechanism.

  Enable it along with **Replication optimize for static plugin config** to improve cluster performance even with a large number of replicas.

  This setting is disabled by default.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/replication-options-replica.html#sysvar_replication_sender_observe_commit_only).

- **Rpl semi sync master wait for slave count**{#setting-rpl-wait-slave-count} {{ tag-all }}

  Sets the number of replicas the master must get responses from before committing a transaction in semi-synchronous replication.

  The minimum value is `1`, and the maximum, `2`. The default value is `1`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/replication-options-source.html#sysvar_rpl_semi_sync_master_wait_for_slave_count).

- **Slave parallel type**{#setting-slave-parallel-type} {{ tag-all }}

  Specifies the policy used to decide which transactions are allowed to run in parallel on the replica when multi-threaded replication is enabled with [Slave parallel workers](#setting-slave-parallel-workers):
  - `LOGICAL_CLOCK`: Transactions that are part of a group commit for the same source binary log run in parallel on the replica.
  - `DATABASE` (default): Transactions that update different databases run in parallel.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_type).

- **Slave parallel workers**{#setting-slave-parallel-workers} {{ tag-all }}

  Sets the number of threads for executing replication transactions in parallel on the replica.

  The minimum value is `0` (multi-threading on the replica is disabled), and the maximum, `64`. The default value is `8`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/replication-options-replica.html#sysvar_slave_parallel_workers).

- **Slow query log**{#setting-slow-query-log} {{ tag-all }}

  Enables or disables slow query logging. A query is considered slow if its execution time exceeds the value set in [Long query time](#setting-long-query-time).

  Allowed values:

  * `0` or `OFF`
  * `1` or `ON`

  The default value is `OFF`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_slow_query_log).

- **Slow query log always write time**{#setting-slow-query-log-always-write-time} {{ tag-all }}

  Specifies the query execution time (in seconds) after which a query is always written to the [slow query log](#setting-slow-query-log) regardless of the [Log slow rate limit](#setting-log-slow-rate-limit).

  The valid values range from `0` to `3600` (1 hour). The default value is `10`.

  For more information, see [this Percona article](https://www.percona.com/doc/percona-server/8.0/diagnostics/slow_extended.html#slow_query_log_always_write_time).

- **Sort buffer size**{#setting-sort-buffer-size} {{ tag-all }}

  Sets the size of the buffer (in bytes) used for in-memory sorts.

  The valid values range from `32768` (32 KB) to `16777216` (16 MB). The default value is `262144` (256 KB).

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_sort_buffer_size).

- **Sql mode**{#setting-sql-mode} {{ tag-all }}

  {{ MY }} cluster SQL modes:
  - [ALLOW_INVALID_DATES]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_allow_invalid_dates): Bypasses full date validation. In this mode, the server only checks that the month is in the range from 1 to 12 and the day is in the range from 1 to 31. Invalid dates, such as `2004-04-31`, are converted to `0000-00-00` with a warning.
  - [ANSI_QUOTES]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_ansi_quotes): Treat `"` quotes as identifier quotes and not string quotes. With this mode enabled, use single quotes (`'`) rather than double quotes (`"`) for strings.
  - [ERROR_FOR_DIVISION_BY_ZERO]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_error_for_division_by_zero): Division by zero returns `NULL` and a warning. This SQL mode is deprecated.
  - [HIGH_NOT_PRECEDENCE]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_high_not_precedence): Gives higher precedence to the `NOT` operator when parsing Boolean expressions. In this mode, the `NOT a BETWEEN b AND c` expression is parsed as `(NOT a) BETWEEN b AND c` rather than `NOT (a BETWEEN b AND c)`.
  - [IGNORE_SPACE]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_ignore_space): Allows spaces between a function name and the `(` character. As a result, built-in function names are treated as keywords, and object IDs that match these names must be quoted.
  - [NO_AUTO_VALUE_ON_ZERO]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_no_auto_value_on_zero): Only `NULL` inserted into the `AUTO_INCREMENT` column generates the next sequence number for the column. Normally, new sequence numbers are generated when inserting either `0` or `NULL` into it. So this mode can be useful if you need to explicitly store `0` in this column.
  - [NO_BACKSLASH_ESCAPES]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_no_backslash_escapes): Disables the use of the backslash character (`\`) as an escape character. With this mode enabled, backslash is treated as an ordinary character.
  - [NO_DIR_IN_CREATE]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_no_dir_in_create): Ignores the `INDEX DIRECTORY` and `DATA DIRECTORY` directives during table creation.
  - [NO_ENGINE_SUBSTITUTION]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_no_engine_substitution): Disables automatically using the default storage engine if the engine specified in `CREATE TABLE` or `ALTER TABLE` is unavailable, returning an error instead.
  - [NO_UNSIGNED_SUBTRACTION]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_no_unsigned_subtraction): Allows negative results when subtracting integers, even if one of them is unsigned.
  - [NO_ZERO_DATE]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_no_zero_date): Affects the use of the `0000-00-00` date: {#setting-no-zero-date}
    - If [strict SQL mode](#setting-strict-mode) is disabled, the `0000-00-00` date is allowed, and inserting it produces a warning.
    - If strict SQL mode is enabled, the `0000-00-00` date is not allowed. If you try to insert it, you will get an error.

    This SQL mode is deprecated.

  - [NO_ZERO_IN_DATE]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_no_zero_in_date): Affects the use of dates in which the month or day is zero:
    - If [strict SQL mode](#setting-strict-mode) is disabled, dates with a zero month or day are inserted as `0000-00-00` with a warning returned.
    - If strict SQL mode is enabled, dates with a zero month or day are not allowed. If you try to insert them, you will get an error.

    This SQL mode is deprecated.

    See also: [NO_ZERO_DATE](#setting-no-zero-date).

  - [ONLY_FULL_GROUP_ BY]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_only_full_group_by): Prohibits queries in which `SELECT`, `HAVING`, or `ORDER BY` refer to non-aggregated columns that are not included in `GROUP BY` ([SQL-92]({{ my.docs }}/refman/8.0/en/group-by-handling.html) behavior).
  - [PAD_CHAR_TO_FULL_LENGTH]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_pad_char_to_full_length): Ensures that `CHAR` column values are padded with spaces to their full length. This does not apply to `VARCHAR` columns.
  - [PIPES_AS_CONCAT]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_pipes_as_concat): Treat `||` as a string concatenation operator (same as [CONCAT()]({{ my.docs }}/refman/8.0/en/string-functions.html#function_concat)) rather than a synonym for [OR]({{ my.docs }}/refman/8.0/en/logical-operators.html#operator_or).
  - [REAL_AS_FLOAT]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_real_as_float): Treat `REAL` as a synonym for `FLOAT`. By default, {{ MY }} treats `REAL` as a synonym for `DOUBLE`.
  - [STRICT_ALL_TABLES]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_strict_all_tables): Enables [strict SQL mode]({{ my.docs }}/refman/8.0/en/sql-mode.html#sql-mode-strict) for all storage engines.
  - [STRICT_TRANS_TABLES]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_strict_trans_tables): Enables [strict SQL mode]({{ my.docs }}/refman/8.0/en/sql-mode.html#sql-mode-strict) for all transactional storage engines and, when possible, for non-transactional ones. {#setting-strict-mode}
  - [TIME_TRUNCATE_FRACTIONAL]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_time_truncate_fractional): Enables truncation of a fractional part when inserting a `TIME`, `DATE`, or `TIMESTAMP` value into a column that has fewer fractional digits. By default, {{ MY }} uses rounding rather than truncation.
  - [ANSI]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_ansi): Combination of the following modes:
    - `REAL_AS_FLOAT`
    - `PIPES_AS_CONCAT`
    - `ANSI_QUOTES`
    - `IGNORE_SPACE`
    - `ONLY_FULL_GROUP_BY`
  - [TRADITIONAL]({{ my.docs }}/refman/8.0/en/sql-mode.html#sqlmode_traditional): Combination of the following modes:
    - `STRICT_ALL_TABLES`
    - `STRICT_TRANS_TABLES`
    - `NO_ZERO_DATE`
    - `NO_ZERO_IN_DATE`
    - `ERROR_FOR_DIVISION_BY_ZERO`
    - `NO_ENGINE_SUBSTITUTION`

  You can select multiple modes from the list or completely disable all SQL mode settings.

  By default, the following SQL modes are used:
  - `ERROR_FOR_DIVISION_BY_ZERO`
  - `NO_ENGINE_SUBSTITUTION`
  - `NO_ZERO_DATE`
  - `NO_ZERO_IN_DATE`
  - `ONLY_FULL_GROUP_BY`
  - `STRICT_TRANS_TABLES`

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/sql-mode.html#sql-mode-setting).

- **SQL require primary key**{#setting-sql-require-primary-key} {{ tag-all }}

  Prohibits creating or importing tables without a primary key as well as removing the key from the tables.

  This setting is disabled by default.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_sql_require_primary_key).

- **Sync binlog**{#setting-sync-binlog} {{ tag-all }}

  Determines how often the server synchronizes the binary log to disk:
  - `0`: Synchronization is disabled. {{ MY }} relies on the operating system to flush the binary log to disk from time to time, as it does for any other file. This approach provides the best performance. However, data may be lost in the event of a power failure or operating system crash: transactions may be committed but not yet synced with the binary log.
  - `1`: Binary log is synchronized to disk before transactions are committed. This is the safest option, but it may have a negative impact on performance due to the increased number of disk writes. In the event of a power failure or operating system crash, transactions that are missing from the binary log are only in prepared state. This allows you to perform automatic recovery and roll back the transactions, ensuring that no transaction is lost from the binary log.
  - `N`: Binary log is synchronized to disk after collecting `N` binary log commit groups. In the event of a power failure or operating system crash, transactions may be committed but not yet synced to the binary log. This approach may have a negative impact on performance due to the increased number of disk writes. The higher the `N` value, the better the performance and the higher the risk of data loss.

  The valid values range from `0` to `4096`. The default value is `1`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/replication-options-binary-log.html#sysvar_sync_binlog).

- **Table definition cache**{#setting-table-definition-cache} {{ tag-all }}

  Sets the number of table definitions that can be stored in the definition cache. If your database has a large number of tables, increase this setting to speed up opening of tables.

  The valid values range from `400` to `524288`. The default value is `2000`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_table_definition_cache).

- **Table open cache**{#setting-table-open-cache} {{ tag-all }}

  Specifies the size of the open table cache for all threads. If the [Opened tables]({{ my.docs }}/refman/8.0/en/server-status-variables.html#statvar_Opened_tables) value is large and you do not use [FLUSH_TABLES]({{ my.docs }}/refman/8.0/en/flush.html#flush-tables) often, increase this setting.

  Increasing this value requires increasing the number of file descriptors for {{ MY }} cluster hosts.

  The valid values range from `400` to `524288`. The default value is `4000`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache).

- **Table open cache instances**{#setting-table-open-cache-instances} {{ tag-all }}

  {% include [requires-restart](note-requires-restart.md) %}

  To improve scalability, the [open table cache](#setting-table-open-cache) can be partitioned into smaller cache instances. This value sets the number of such cache instances.

  The valid values range from `1` to `32`. The default value is `16`.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_table_open_cache_instances).

- **Thread cache size**{#setting-thread-cache-size} {{ tag-all }}

  Sets the number of threads that are cached to process new connections. When establishing a new connection, threads from the cache are reused first and only then new threads are created. Increase this value to improve performance if you have a lot of new connections.

  The valid values range from `10` to `10000`. The default value [depends on the selected host class](#settings-instance-dependent) and is calculated as follows:

  ```text
  max_connections / 10
  ```

  Where `max_connections` is the default value of the [Max connections](#setting-max-connections) setting for the selected host class.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_thread_cache_size).

- **Thread stack**{#setting-thread-stack} {{ tag-all }}

  {% include [requires-restart](note-requires-restart.md) %}

  Sets the stack size (in bytes) for each thread. The default value is large enough for normal {{ MY }} operation. Setting it too small can limit the complexity of SQL statements, stored procedure recursion depth, and other memory-consuming features.

  The valid values range from `131072` (128 KB) to `16777216` (16 MB). The default value is `196608` (192 KB).

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_thread_stack).

- **Tmp table size**{#setting-tmp-table-size} {{ tag-all }}

  Sets the maximum size of in-memory temporary tables (in bytes). If a table exceeds this limit, it is automatically converted to an on-disk temporary table. This setting does not apply to user-created `MEMORY` tables. Increase its value if you run many complex `GROUP BY` queries and your hosts have enough RAM.

  The valid values range from `1024` (1 KB) to `134217728` (128 MB). The default value is `16777216` (16 MB).

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_tmp_table_size).

- **Transaction isolation**{#setting-transaction-isolation} {{ tag-all }}

  Sets the default transaction isolation level:
  - `READ-COMMITTED`: Query only sees the strings committed before it is run.
  - `REPEATABLE-READ`: All queries in the current transaction only see the strings committed before running the first select or update data query within this transaction.
  - `SERIALIZABLE`: Similar to `REPEATABLE-READ`, except that InnoDB implicitly converts `SELECT` statements to `SELECT ... FOR SHARE` if [autocommit]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_autocommit) is disabled. If autocommit is enabled, `SELECT` remains in its own transaction in `read only` mode and can be serialized.

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_transaction_isolation).

- **Wait timeout**{#setting-wait-timeout} {{ tag-all }}

  Sets the activity wait interval (in seconds) for an non-interactive connection before the server terminates it.

  The valid values range from `600` (10 minutes) to `86400` (24 hours). The default value is `28800` (8 hours).

  For more information, see [this {{ MY }} article]({{ my.docs }}/refman/8.0/en/server-system-variables.html#sysvar_wait_timeout).
