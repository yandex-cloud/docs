### Parameter contexts

Parameter context is what determines the level and interface the parameter can be specified in.

For {{ GP }}, the following parameter contexts are used:

| Context | Allows the parameter to be set via `SET` | Requires restart | Description | Interface |
| --- | --- | --- | --- | --- |
| `user` | Yes | No | You can set these parameters for the cluster or a session using the `SET` command. Any user can edit this parameter for their session. Cluster-level changes will affect the existing sessions only if no local value was set for the session using the `SET` command. | {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} |
| `backend` | Yes ^*^ | No | These parameters can be set for the cluster or a particular session via the connection request packet, e.g., using the `PGOPTIONS` environment variable in `libpq`. | {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} |
| `sighup` | No | No | These parameters can be set only for the cluster. | {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} |
| `superuser` | No | No | These parameters can be set only for the cluster. | {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} |
| `postmaster` | No | Yes | These parameters can be set only for the cluster. | {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} |

^*^ Any user can change these settings for their session; however, after the session starts, they can no longer be changed. New values, set at cluster level will only be valid for sessions started after they were applied.

### Parameters the user can manage globally

The parameters listed bellow can be managed by the user globally at cluster level via the management console, YC CLI, {{ TF }}, and API. Some of these parameters can also be managed locally at the session, user, or database level depending on parameter context.

#### gp_add_column_inherits_table_setting {#setting-gp-add-column-inherits-table-setting}

| Available in version | Type     | Acceptable values            | Default value | Context |
|-------------------|---------|--------------------------------|-----------------------|----------|
| 6.25 and higher | Boolean | `true` (`on`), `false` (`off`) | `false` (`off`) | `user` |

When adding a column to an append-optimized column-oriented table (`append-optimized`) using the `ALTER TABLE` command, this parameter decides whether the table data compression settings for the column (`compresstype`, `compresslevel`, and `blocksize`) will be inherited from the table values.

By default, this parameter is off (`false`/`off`): the table data compression settings are not considered when adding a column. If the parameter is on (`true`/`on`), the table compression settings will be considered.

When creating an append-optimized column-oriented table (`append-optimized`), you can set the table data compression parameters (`compresstype`, `compresslevel`, and `blocksize`) in the `WITH` clause.
When adding a column, the DBMS sets each data compression parameter based on one of the following values (in order of priority):

1. The data compression setting specified in the `ENCODING` clause of the `ALTER TABLE` command.
1. If this server configuration parameter is enabled (`true`/`on`), the data compression setting specified in the `WITH` clause when creating the table. Otherwise, the table data compression setting is ignored.
1. The data compression setting specified in the server configuration parameter [gp_default_storage_options](#setting-gp-default-storage-options).
1. The default data compression setting.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting).

#### gp_autostats_mode {#setting-gp-autostats-mode}

| Available in version | Acceptable values | Default value | Context |
|-------------------|-------------------------------------|-----------------------|----------|
| 6.25 and higher | `none`, `on_change`, `on_no_stats` | `on_no_stats` | `user` |

Specifies the mode of starting automatic statistics collection using `ANALYZE`.

The `on_no_stats` option starts statistics collection for `CREATE TABLE AS SELECT`, `INSERT`, or `COPY` operations in any tables that do not have any statistics yet.

The `on_change` option starts statistics collection only if the number of affected rows exceeds the threshold value set by the [gp_autostats_on_change_threshold](#setting-gp-autostats-on-change-threshold) parameter.
Operations that can start automatic statistics collection with `on_change`:

- `CREATE TABLE AS SELECT`
- `UPDATE`
- `DELETE`
- `INSERT`
- `COPY`

{% note info %}

For partitioned tables, automatic statistics collection does not start if data is inserted from the top-level parent table. Automatic statistics collection starts if the data is inserted directly into the table storing the partitioned table data (the statistics is collected for this table only).

{% endnote %}

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_autostats_mode).

#### gp_autostats_on_change_threshold {#setting-gp-autostats-on-change-threshold}

| It is available in versions from | Type | Acceptable values | Default value | Context |
|-------------------|---------|---------------------|-----------------------|----------|
| 6.25 and higher | Integer | from 0 to 2147483647 | 2147483647 | `user` |

Specifies the threshold value for automatic statistics collection when the [gp_autostats_mode](#setting-gp-autostats-mode) parameter is set to `on_change`. If a table operation affects the number of rows that exceeds this threshold value, `ANALYZE` is performed to collect the statistics for the table.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_autostats_on_change_threshold).

#### gp_cached_segworkers_threshold {#setting-gp-cached-segworkers-threshold}

| It is available in versions from | Type | Acceptable values | Default value | Context |
|-------------------|---------|---------------------|-----------------------|----------|
| 6.25 and higher | Integer | from 1 to 10 | 5 | `user` |

When a uses starts a database session and sends a query, the system creates groups of workflows (`gangs`) on each segment to complete the work. After the work is complete, the `worker` processes on the segments are terminated, except for a certain number that are preserved in cache. This number is set by this parameter.

A lower value allows saving system resources on the segment hosts, yet a higher value can improve performance in scenarios where many complex queries are sent consecutively.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_cached_segworkers_threshold).

#### gp_enable_global_deadlock_detector {#setting-gp-enable-global-deadlock-detector}

| Available in version | Type     | Acceptable values            | Default value | Context     |
|-------------------|---------|--------------------------------|-----------------------|--------------|
| 6.25 and higher       | Boolean | `true` (`on`), `false` (`off`) | `true` (`on`)         | `postmaster` |

Turns on or off the global deadlock detector (`Global Deadlock Detector`) used to manage concurrent `UPDATE` and `DELETE` operations in heap tables (`heap tables`) to improve performance.

If the global deadlock detector is off, the database performs concurrent update and delete operations in the heap table (`heap tables`) one by one. If the global deadlock detector is on, concurrent updates are allowed; the detector identifies deadlocks and resolves them by terminating one or more background processes associated with the "youngest" transactions.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_enable_global_deadlock_detector).

#### gp_enable_zstd_memory_accounting {#setting-gp-enable-zstd-memory-accounting}

{% note info %}

This is an [open-gpdb](https://github.com/open-gpdb/gpdb) build-specific parameter.

{% endnote %}

| Available in version | Type     | Acceptable values            | Default value | Context |
|-------------------|---------|--------------------------------|-----------------------|----------|
| 6.28 and higher       | Boolean | `true` (`on`), `false` (`off`) | `true` (`on`)         | `user`   |

Controls the `ZSTD` memory accounting feature. Enabling it (`true`/`on`) prevents `ZSTD` from exceeding the memory available to the resource manager (a group or a queue) by moving `ZSTD` to a separate `zstd_context` memory context. This reduces the probability of an uncontrolled cluster crash due to out-of-memory errors.

#### gp_global_deadlock_detector_period {#setting-gp-global-deadlock-detector-period}

| Available in version | Type | Acceptable values | Default value | Context |
|-------------------|---------|---------------------|-----------------------|----------|
| 6.25 and higher | Integer | from 5 to 2147483647 | 120 | `sighup` |

Specifies the execution interval (in seconds) of the global deadlock detector background workflow (`Global Deadlock Detector`, see the [gp_enable_global_deadlock_detector](#setting-gp-enable-global-deadlock-detector) parameter).

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_global_deadlock_detector_period).

#### gp_max_plan_size {#setting-gp-max-plan-size}

| Available in version | Type | Acceptable values | Default value | Context |
|-------------------|---------|---------------------|-----------------------|-------------|
| 6.25 and higher | Integer | from 0 to 2147483647 | 0 | `superuser` |

Sets the maximum allowed total uncompressed size of a query execution plan, multiplied by the number of `Motion` statements (`slices`) in the plan. If the query plan size exceeds the specified value, the query gets canceled and an error is returned. A value of 0 means the plan size is not tracked. Measured in bytes. This value must be a multiple of 1MB.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_max_plan_size).

#### gp_max_slices {#setting-gp-max-slices}

| Available in version | Type | Acceptable values | Default value | Context |
|-------------------|---------|---------------------|-----------------------|----------|
| 6.25 and higher       | Integer | from 10 to 100        | 100                   | `user`   |

Specifies the maximum number of slices (`slices`) a query can generate. If a query generates more slices than specified, the database returns an error and does not execute the query.

Executing a query that generates a massive number of slices may compromise database performance. For example, a query containing the `UNION` or `UNION ALL` statements for several complex views can generate a massive number of slices. To view slice statistics for a query, run the `EXPLAIN` command.

{% note warning %}

The service-level acceptable values are different from the DBMS-level acceptable values. This is done to reduce the probability of an uncontrolled cluster crash due to out-of-memory (OOM) errors caused by attempting to execute a "non-optimal" query. You can bypass this restriction by overriding the parameter at the session, user, or database level.

{% endnote %}

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_max_slices).

#### gp_resource_group_memory_limit {#setting-gp-resource-group-memory-limit}

| Available in version | Type | Acceptable values | Default value | Context |
|-------------------|------|---------------------|-----------------------|--------------|
| 6.25 and higher | Real | from 0.1 to 0.8 | 0.8 | `postmaster` |

{% note info %}

This configuration parameter applies only when group-based resource management is activated.

{% endnote %}

It sets the maximum percentage of system memory resources that can be allocated to resource groups per database segment node. Decreasing this parameter may be justified if you need to allocate more resources to auxiliary components residing on the database segment node (e.g., `PXF`).

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_resource_group_memory_limit).

#### gp_vmem_protect_segworker_cache_limit {#setting-gp-vmem-protect-segworker-cache-limit}

| Available in version | Type | Acceptable values | Default value | Context |
|-------------------|------|---------------------|-----------------------|--------------|
| 6.25 and higher       | Real | from 0 to 4096        | 500                   | `postmaster` |


If the query execution process consumes more than the specified amount of memory, the process will not be cached for use in subsequent queries after it is over. In systems with a large number of connections or idle processes, you can reduce this value to free up more memory on the segments. Measured in megabytes.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_vmem_protect_segworker_cache_limit).

#### gp_workfile_compression {#setting-gp-workfile-compression}

| Available in version | Type     | Acceptable values            | Default value | Context |
|-------------------|---------|--------------------------------|-----------------------|----------|
| 6.25 and higher | Boolean | `true` (`on`), `false` (`off`) | `false` (`off`) | `user` |


Specifies whether to compress the temporary files created when uploading to disk during hashing operations (aggregation or join). In some cases, compression can help avoid overloading the disk I/O subsystem.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression).

{% include [requires-restart](../note-requires-restart.md) %}

#### gp_workfile_limit_files_per_query {#setting-gp-workfile-limit-files-per-query}

| Available in version | Type | Acceptable values | Default value | Context |
|-------------------|---------|---------------------|-----------------------|----------|
| 6.25 and higher | Integer | from 0 to 100000 | 10000 | `user` |


Sets the maximum number of temporary workfiles (`workfiles`) allowed per query on each segment. Workfiles are created when a query requires more memory than allocated.
If the limit is exceeded, the current query gets terminated. A value of 0 indicates an unlimited number of upload files.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query).

#### gp_workfile_limit_per_query {#setting-gp-workfile-limit-per-query} 

| Available in version | Type | Acceptable values | Default value | Context |
|-------------------|---------|-----------------------|-----------------------|----------|
| 6.25 and higher       | Integer | form 0 to 1099511627776 | 0                     | `user`   |


Sets the maximum disk space an individual query can use to create temporary workfiles (`workfiles`) on each segment. A value of 0 means there is no limit. Specified in bytes. This value must be a multiple of 1 MB.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query).

#### gp_workfile_limit_per_segment {#setting-gp-workfile-limit-per-segment}

| Available in version | Type | Acceptable values | Default value | Context |
|-------------------|-----|----------------------|---------------|--------|
| 6.25 and higher | Integer | from 0 to the segment disk size / 2 | It is calculated dynamically based on the disk size on the segment | `postmaster` |


Sets the maximum total disk space that can be used by all ongoing queries to create temporary workfiles (`workfiles`) on each segment. A value of 0 means there is no limit.

The default value [depends on the segment host storage size](#settings-instance-dependent) and is calculated by the formula:

```text
0.1 × <segment_host_storage_size> / <number_of_segments_per_host>
```

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment).

#### idle_in_transaction_session_timeout {#setting-idle-in-transaction-session-timeout}

{% note info %}

This is an [open-gpdb](https://github.com/open-gpdb/gpdb) build-specific parameter.

{% endnote %}

| Available in version | Type | Acceptable values | Default value | Context |
|-------------------|---------|--------------------|-----------------------|----------|
| 6.25 and higher       | Integer | from 0 to 2147483647 | 0                     | `user`   |

Terminates any session which is idle (i.e., awaiting a client's request) as part of an open transaction for longer than the specified time interval. Measured in milliseconds. A value of 0 disables the timeout.

You can use this parameter to ensure that idle sessions will not be retaining locks for too long. Even if no significant lock are retained, an open transaction prevents deleting recently outdated tuples that are only visible within this transaction only and takes up space in the resource groups (the `concurrency` parameter of the resource group).

#### lock_timeout {#setting-lock-timeout}

| Available in version | Type | Acceptable values | Default value | Context |
|-------------------|---------|---------------------|-----------------------|----------|
| 6.25 and higher       | Integer | from 0 to 2147483647  | 0                     | `user`   |

Interrupts any query that waits longer than the specified number of milliseconds for a lock on a table, index, row, or other database object. The time limit applies separately to each lock acquisition attempt. This limit applies both to explicit lock requests (e.g., `LOCK TABLE` or `SELECT FOR UPDATE`) and implicitly acquired locks.
If [log_min_error_statement](#setting-log-min-error-statement) is set to `ERROR` or lower, the database logs the request that has exceeded the allocated time. A value of 0 disables the lock timeout monitoring.

Unlike [statement_timeout](#setting-statement-timeout), this timeout can only occur while awaiting locks. Please note: if [statement_timeout](#setting-statement-timeout) is a non-zero value, it makes no sense setting [lock_timeout](#setting-lock-timeout) the same or greater because the statement timeout will always trigger first.

The database uses the [deadlock_timeout](#setting-deadlock-timeout) and [gp_global_deadlock_detector_period](#setting-gp-global-deadlock-detector-period) parameters to initiate local and global deadlock detection. Please note: if [lock_timeout](#setting-lock-timeout) is on and its setting is smaller that the deadlock detection timeouts, the database will terminate the query before the deadlock check is initiated for this session.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#lock_timeout).

#### log_connections {#setting-log-connections}

| Available in version | Type     | Acceptable values            | Default value | Context  |
|-------------------|---------|--------------------------------|-----------------------|-----------|
| 6.25 and higher | Boolean | `true` (`on`), `false` (`off`) | `false` (`off`) | `backend` |

Adds to the server log a line with detailed info on each successful connection. Some client programs, e.g., `psql`, attempt to connect twice to figure out if a password is required; therefore, repeated "connection received" messages do not always indicate a problem.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_connections).

#### log_disconnections {#setting-log-disconnections}

| Available in version | Type     | Acceptable values            | Default value | Context  |
|-------------------|---------|--------------------------------|-----------------------|-----------|
| 6.25 and higher | Boolean | `true` (`on`), `false` (`off`) | `false` (`off`) | `backend` |

Adds to the server log a line that marks the end of the client session, including the duration of the session.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_disconnections).

#### log_error_verbosity {#setting-log-error-verbosity}

| Available in version | Acceptable values | Default value | Context |
|-------------------|-------------------------------|-----------------------|-------------|
| 6.25 and higher       | `terse`, `default`, `verbose` | `default`             | `superuser` |

Controls the level of detail of the server log entries logged for each message.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_error_verbosity).

#### log_hostname {#setting-log-hostname} 

| Available in version | Type     | Acceptable values            | Default value | Context |
|-------------------|---------|--------------------------------|-----------------------|----------|
| 6.25 and higher | Boolean | `true` (`on`), `false` (`off`) | `true` (`on`) | `sighup` |

By default, connection log entries only show the IP address of the connecting host. With this option on, both the IP address and name of the connecting host will be logged to the master log.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_hostname).

#### log_min_duration_statement {#setting-log-min-duration-statement}

| Available in version | Type | Acceptable values | Default value | Context |
|-------------------|---------|---------------------|-----------------------|-------------|
| 6.25 and higher | Integer | from -1 to 2147483647 | -1 | `superuser` |

Logs a query and its duration in a single line if the query duration is greater than or equal to the specified number of milliseconds. A value of 0 logs all queries and their durations.
A value of -1 disables this function. For example, if you set it to 250, it will log all SQL queries that take 250 ms or longer.

Enabling this option can help to identify non-optimized queries in your applications.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_min_duration_statement).

#### log_min_messages {#setting-log-min-messages}

| Available in version | Acceptable values | Default value | Context |
| --- | --- | --- | --- |
| 6.25 and higher | `debug5`, `debug4`, `debug3`, `debug2`, `debug1`, `info`, `notice`, `warning`, `log`, `error`, `fatal`, `panic` | `warning` | `superuser` |

Controls which message levels to send to the server log. Each level includes all the following levels. The lower the level is down the list, the fewer messages will go to the log.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_min_messages).

#### log_statement {#setting-log-statement}

| Available in version | Acceptable values | Default value | Context |
| --- | --- | --- | --- |
| 6.25 and higher | `none`, `ddl`, `mod`, `all` | `ddl` | `superuser` |

Controls which SQL queries to log. The `ddl` level logs all data definition commands, such as `CREATE`, `ALTER`, and `DROP`. The `mod` level registers all `DDL` statements, as well as `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`. The `PREPARE` and `EXPLAIN ANALYZE` queries are also logged if they contain a statement of the relevant type.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement).

#### log_statement_stats {#setting-log-statement-stat}

| Available in version | Type     | Acceptable values            | Default value | Context    |
|-------------------|---------|--------------------------------|-----------------------|-------------|
| 6.25 and higher | Boolean | `true` (`on`), `false` (`off`) | `false` (`off`) | `superuser` |

Logs general performance statistics for the parser, planner, and query executor to the server log for each query. It is used as a basic profiling tool.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement_stats).

#### master_shared_buffers {#setting-master-shared-buffers}

{% note info %}

The DBMS itself has only one parameter: `shared_buffers`. On the service side, there is a separation into `shared_buffers` for masters and segments. The setting for segments is called [segment_shared_buffers](#setting-segment-shared-buffers).

{% endnote %}

| Available in version | Type     | Acceptable values                 | Default value | Context     |
|-------------------|---------|-------------------------------------|-----------------------|--------------|
| 6.25 and higher | Integer | from 1048576 to the calculated value | 134217728 (128 MB) | `postmaster` |

Sets the amount of memory the master instance uses for shared memory buffers. This value must be at least 1 MB and must not exceed the value of the following expression (in particular, this depends on [max_connections](#setting-max-connections)):

```text
max(0.24 × available RAM on master, 16384 × max_connections)
```

Measured in bytes.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#shared_buffers).

{% include [requires-restart](../note-requires-restart.md) %}

#### max_connections {#setting-max-connections}

| Available in version | Type | Acceptable values | Default value | Context |
|-------------------|---------|---------------------|-----------------------|--------------|
| 6.25 and higher | Integer | from 50 to 1,000 | 200 | `postmaster` |


Maximum number of concurrent connections to the database cluster. You can connect up to `max_connections − 20` users, as `20` connections are reserved for superusers. The `superuser_reserved_connections` setting defines the number of connections for superusers, and you cannot change its value. For more information about `superuser_reserved_connections`, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#superuser_reserved_connections).

When increasing `max_connections`, you should also increase [max_prepared_transactions](#setting-max-prepared-transactions). Increasing `max_connections` may cause the database to request more shared memory (see [master_shared_buffers](#setting-master-shared-buffers) and [segment_shared_buffers](#setting-segment-shared-buffers)).

For segments, the `max_connections` value is calculated automatically using the following formula:
```
5 × max_connections (for master)
```

If you update this setting, both the master and segment hosts will be checked to have at least 20 MB of available RAM per connection. If this condition is not met, [this error](../../../managed-greenplum/qa/cluster-hosts.md#memory-limit) occurs.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_connections).

#### max_locks_per_transaction {#setting-max-locks-per-transaction}

| Available in version | Type | Acceptable values | Default value | Context |
|-------------------|---------|---------------------|-----------------------|--------------|
| 6.25 and higher       | Integer | from 128 to 2,048      | 128                   | `postmaster` |

The shared lock table is built to be able to describe locks for [max_locks_per_transaction](#setting-max-locks-per-transaction) × ([max_connections](#setting-max-connections) + [max_prepared_transactions](#setting-max-prepared-transactions)) objects. Therefore, not more than this number of different objects can be locked at the same time. This is not a hard limit on the number of locks set by a single transaction but rather the maximum average value. You may need to increase this value if you have clients that access multiple different tables within a single transaction.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_locks_per_transaction).

#### max_prepared_transactions {#setting-max-prepared-transactions}

| Available in version | Type     | Acceptable values | Default value | Context     |
|-------------------|---------|---------------------|-----------------------|--------------|
| 6.25 and higher       | Integer | from 50 to 10,000      | 200                   | `postmaster` |

Sets the maximum number of transactions that can be in prepared state simultaneously. The database uses prepared transactions internally to ensure data integrity across segments. This value must be at least as large as [max_connections](#setting-max-connections) on the master.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_prepared_transactions).

#### max_slot_wal_keep_size {#setting-max-slot-wal-keep-size}

| Available in version | Type     | Acceptable values  | Default value | Context |
|-------------------|---------|----------------------|-----------------------|----------|
| 6.25 and higher       | Integer | from 0 to 214748364800 | Calculated           | `sighup` |

Sets the maximum size in bytes of write-ahead log (`WAL`) files on disk for each segment instance that can be reserved when the database transfers data to a mirror segment or a standby master to maintain synchronization with its corresponding primary segment instance or master.

If the size of the files exceeds the set maximum, hey will be released and become available for deletion. As a result, the mirror or standby instance may loose the ability to continue replication due to the deletion of required WAL files.

If the active primary instances have a non-standard value set for [max_slot_wal_keep_size](#setting-max-slot-wal-keep-size), full and incremental recovery of their mirrors may become impossible. Depending on concurrent workload on the primary instance during full recovery, the recovery process may terminate with an error due to missing WAL files.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_slot_wal_keep_size).

#### max_statement_mem {#setting-max-statement-mem}

| Available in version | Type     | Acceptable values           | Default value | Context    |
|-------------------|---------|-------------------------------|-----------------------|-------------|
| 6.25 and higher       | Integer | from 134217728 to 1099511627776 | 2097152000 (2000 MB)  | `superuser` |

Sets the maximum memory limit per query. This helps prevent out-of-memory errors on the segment host during query processing due to excessively high [statement_mem](#setting-statement-mem).

When modifying the [max_statement_mem](#setting-max-statement-mem) and [statement_mem](#setting-statement-mem) parameters, change [max_statement_mem](#setting-max-statement-mem) first.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_statement_mem).

#### runaway_detector_activation_percent {#setting-runaway-detector-activation-percent}

| Available in version | Type     | Acceptable values | Default value | Context     |
|-------------------|---------|---------------------|-----------------------|--------------|
| 6.25 and higher       | Integer | from 0 to 100         | 90                    | `postmaster` |

For queries managed by resource queues or resource groups, decides when the database must terminate ongoing queries based on the amount of memory they are using. A value of 100 disables automatic termination of queries based on memory utilization percentage. Either the resource queue management method or the resource group management method can be active; both methods cannot be active at the same time.

The server configuration parameter [gp_resource_manager](#setting-gp-resource-manager) determines which method is active. When resource queues are on, this parameter sets the memory utilization percentage `vmem` to terminate the queries if it is exceeded. If the `vmem` memory utilization percentage for a segment exceeds the specified value, the database begins terminating queries managed by resource queues, starting with the query using the most memory. Queries get terminated until the `vmem` utilization percentage becomes lower than the specified value.

For example, if the `vmem` memory size is set to 10 GB and this parameter is 90 (90%), the database will start terminating queries as soon as `vmem` exceeds 9 GB. When resource groups are enabled, this parameter sets the utilization percentage for the shared global memory of resource groups. When this percentage is exceeded, the database will terminate the queries managed by resource groups with the `vmtracker` memory auditor configured, e.g., `admin_group` and `default_group`. Resource groups share a global memory pool if the sum of the `MEMORY_LIMIT` values configured for all resource groups is less than 100%. For example, if you have three resource groups with `memory_limit` limit values of 10%, 20%, and 30%, the shared global memory will be 40% = 100% − (10% + 20% + 30%).

If the utilization percentage of the shared global memory exceeds the specified value, the database will begin terminating queries based on their memory consumption, selecting them from among the queries managed by resource groups with the `vmtracker` memory auditor. The system will start with the query that consumes the most memory. Queries will be terminated until the shared global memory utilization percentage becomes lower than the specified value. For example, if there is 10 GB of shared global memory and this parameter is 90 (90%), the database will start terminating queries as soon as 9 GB of shared global memory has been used up.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#runaway_detector_activation_percent).

#### segment_shared_buffers

{% note info %}

The DBMS itself has only one parameter: `shared_buffers`. On the service side, there is a separation into `shared_buffers` for masters and segments. The setting for masters is called [master_shared_buffers](#setting-master-shared-buffers).

{% endnote %}

| Available in version | Type     | Acceptable values                 | Default value | Context     |
|-------------------|---------|-------------------------------------|-----------------------|--------------|
| 6.25 and higher       | Integer | from 1048576 to the calculated value | 134217728 (128 MB)    | `postmaster` |


This parameter sets the amount of memory that a segment instance uses for shared memory buffers. This parameter value must be at least 1 MB and must not exceed the value of the following expression (in particular, it depends on [max_connections](#setting-max-connections)):

```
max(0.2 × RAM available on the segment / number of segments per host), 16384 × 5 × max_connections)
```

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#shared_buffers).

{% include [requires-restart](../note-requires-restart.md) %}


### Parameters the user can manage locally {#setting-gp-loca}

This section contains parameters that the user can manage **only** at the session, user, or database level. These parameters **cannot** be managed at the management console, YC CLI, or API level.

#### gp_default_storage_options {#setting-gp-default-storage-options}

| Available in version | Acceptable values | Default value                                                                    | Context |
| --- | --- |------------------------------------------------------------------------------------------| --- |
| 6.25 and higher | `appendoptimized`: `true`, `false`; `blocksize`: [8192; 2097152]; `checksum`: `true`, `false`; `compresstype`: `zlib`, `zstd`, `quicklz`, `rle_type`, `none`; `compresslevel`: [0; 19]; `orientation`: `row`, `column`. | `appendonly=false, blocksize=32768`, `checksum=true, compresstype=none`, `orientation=row` | `user` |

Sets default values for the following table storage options when you create a table using `CREATE TABLE`:

* `appendoptimized`: Use the `appendoptimized=value` syntax to specify the append-optimized table storage type.
   The `appendoptimized` parameter is a shorthand for the deprecated storage parameter `appendonly`. The database stores the `appendonly` value in the folder and displays it when listing storage parameters for append-optimized tables.
* `blocksize`
* `checksum`
* `compresstype`
* `compresslevel`
* `orientation`

Multiple storage parameters are specified as a list separated by commas. You can set storage parameters using this parameter instead of specifying them in the `WITH` clause of the `CREATE TABLE` command. Storage parameters specified in the `CREATE TABLE` command override the values set by this parameter.

Not all combinations of storage parameter values are allowed. If the storage parameters you specify are not allowed, you get an error. You can find the information about the table storage parameters in the description of the `CREATE TABLE` command.

You can set default values for database and user. If the server configuration parameter is set at different levels, the table storage parameter values are prioritized as follows when the user logs in to the database and creates a table (from highest to lowest):

1. Values specified in the `CREATE TABLE` command with the `WITH` or `ENCODING` clause.
1. The [gp_default_storage_options](#setting-gp-default-storage-options) value set for the user using the `ALTER ROLE...SET` command.
1. The [gp_default_storage_options](#setting-gp-default-storage-options) value set for the database using the `ALTER DATABASE...SET` command.
1. The [gp_default_storage_options](#setting-gp-default-storage-options) value set for the entire cluster (default).

The parameter is not cumulative. For example, if the parameter sets `appendoptimized` and `compresstype` for the database, and the user uses it to set `orientation`, the `appendoptimized` and `compresstype` values set at the database level will be ignored.

In this example, the `ALTER DATABASE` command sets the default table storage parameters `orientation` and `compresstype` for the `mytest` database:

```sql
ALTER DATABASE mytest SET gp_default_storage_options = 'orientation=column, compresstype=rle_type'
```

To create an append-optimized columnar format table with `RLE` compression in the `mytest` database, it is enough to state `appendoptimized=TRUE` in the `WITH` clause.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_default_storage_options).

#### statement_mem {#setting-statement-mem}

| Available in version | Type     | Acceptable values   | Default value | Context |
|-------------------|---------|-----------------------|-----------------------|----------|
| 6.25 and higher       | Integer | from 1000 to 2147483647 | 128000 (125 MB)       | `user`   |

Allocates segment host memory for each query. The amount of memory allocated using this parameter cannot exceed [max_statement_mem](#setting-max-statement-mem) or the memory limit of the resource queue or resource groups used to send the query. If a query requires additional memory, temporary upload files are used on disk.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#statement_mem).

#### statement_timeout {#setting-statement-timeout}

| Available in version | Type     | Acceptable values | Default value | Context |
|-------------------|---------|---------------------|-----------------------|----------|
| 6.25 and higher       | Integer | from 0 to 2147483647  | 0                     | `user`   |

Terminates any query if its execution takes longer than the specified number of milliseconds. The 0 value disables the limit.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#statement_timeout).

### Parameters not available to the user {#setting-gp-unavailable}

This section presents parameters that cannot be managed by the user but are referenced by other parameters in this guide.

#### deadlock_timeout {#setting-deadlock-timeout}

| Available in version | Type     | Acceptable values | Default value | Context    |
|-------------------|---------|--------------------|-----------------------|-------------|
| 6.25 and higher       | Integer | from 1 to 214748364  | 1000                  | `superuser` |

Lock timeout before checking for a deadlock. You may need to increase this value on a heavily loaded server. Ideally, this setting should exceed the typical transaction time to increase the probability that the lock will be removed before the waiting process decides run a deadlock check.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#deadlock_timeout).

#### log_min_error_statement {#setting-log-min-error-statement}

| Available in version | Acceptable values | Default value | Context |
| --- | --- | --- | --- |
| 6.25 and higher | `debug5`, `debug4`, `debug3`, `debug2`, `debug1`, `info`, `notice`, `warning`, `error`, `fatal`, `panic` | `error` | `superuser` |


Controls whether to log the SQL query that causes an error. Logs all SQL queries causing an error of the specified level or higher. To effectively turn off logging of failed queries, set this parameter to `panic`.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_min_error_statement).

#### gp_resource_manager {#setting-gp-resource-manager}

| Available in version | Acceptable values | Default value | Context |
| --- | --- | --- | --- |
| 6.25 and higher | `group`, `queue` | `group` | `postmaster` |

Specifies the resource management method currently active in the cluster. The resource group method is used by default.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_resource_manager).
