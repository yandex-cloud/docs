* **Gp add column inherits table setting**{#setting-gp-add-column-inherits-table-setting} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    This setting controls whether to apply the data compression parameters (`compresstype`, `compresslevel`, and `blocksize`) specified for the [AOCO table](../../../managed-greenplum/concepts/tables.md) when adding a column.

    By default, the setting is disabled, i.e., the table’s data compression parameters are ignored.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting).

* **Gp workfile compression**{#setting-gp-workfile-compression} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    This setting determines whether temporary files created on the disk during a hash connection or hash aggregation will be compressed.

    By default, it is disabled, i.e., temporary files are not compressed.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression).

    {% include [requires-restart](../note-requires-restart.md) %}

* **Gp workfile limits per query**{#setting-gp-workfile-limits} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    The maximum amount of disk space (in bytes) the temporary files of an active query can occupy in every segment.

    The maximum value is `1099511627776` (1 TB), the minimum value is `0` (unlimited amount), and the default value is `0`.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query).

* **Gp workfile limit files per query**{#setting-gp-workfile-limit-files} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    The maximum number of temporary files the service creates in a segment to process a single query. If the limit is exceeded, the query will be canceled.

    The maximum value is `100000`, the minimum value is `0` (unlimited number of temporary files), and the default value is `10000`.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query).

* **Gp workfile limit per segment**{#setting-gp-workfile-limit-per-segment} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    The maximum amount of disk space (in bytes) the temporary files of all active queries can occupy in every segment.

    The maximum value is `1099511627776` (1 TB), the minimum value is `0` (unlimited amount). The default value [depends on the segment host storage size](#settings-instance-dependent) and is calculated by the formula:

    ```text
    0.1 × <segment_host_storage_size> / <number_of_segments_per_host>
    ```

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment).

* **Log connections**{#setting-log-connections} {{ tag-con }}

    This setting controls whether to log a string detailing each successful connection to the {{ GP }} server.

    The setting is disabled by default (no logging).

    For more information, see the [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#log_connections).

* **Log disconnections**{#setting-log-disconnections} {{ tag-con }}

    This setting controls whether to log session completion. If the setting is enabled, after each completed client session, a string with the session duration is output to the log.

    The setting is disabled by default (no logging).

    For more information, see the [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#log_disconnections).

* **Log error verbosity**{#setting-log-error-verbosity} {{ tag-con }}

    This setting controls the amount of detail written to the {{ GP }} log for each message. Log detail levels in ascending order of verbosity:

    * `terse`.
    * `default` (default value).
    * `verbose`.

    For more information, see the [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#log_error_verbosity).

* **Log hostname**{#setting-log-hostname} {{ tag-con }}

    This setting controls whether to output the host name of the {{ GP }} database master server to the connection log. If the setting is enabled, the IP address and host name are logged. If the setting is disabled, only the IP address is logged.

    The setting is disabled by default.

    For more information, see the [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#log_hostname).

* **Log min duration statement**{#setting-log-min-duration-statement} {{ tag-con }}

    This setting specifies the minimum command duration required to log the command (in milliseconds).

    If set to `0`, the runtime of all statements is logged.

    The minimum value is `-1` (disables runtime logging); the maximum value is `2147483647`; the default value is `-1`.

    For more information, see the [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#log_min_duration_statement).

* **Log min messages**{#setting-log-min-messages} {{ tag-con }}

    This setting defines the logging level in {{ GP }}. All messages of the selected severity level (or higher) are logged. Possible values (in ascending order of severity): `DEBUG5`, `DEBUG4`, `DEBUG3`, `DEBUG2`, `DEBUG1`, `INFO`, `NOTICE`, `WARNING`, `ERROR`, `LOG`, `FATAL`, and `PANIC`.

    The default value is `WARNING`. This means all the messages with the following severity levels will be logged: `WARNING`, `ERROR`, `LOG`, `FATAL`, and `PANIC`.

    To disable logging of most messages, select `PANIC`.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#log_min_messages).

* **Log statement**{#setting-log-statement} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    Filter for SQL commands that will be written to the {{ GP }} log:

    * `NONE`: Filter is disabled, no SQL commands are logged.
    * `DDL`: Logs SQL commands used to change data structure definitions (such as `CREATE`, `ALTER`, `DROP` etc.).
    * `MOD`: Logs the `DDL` commands and commands allowing you to modify data (`INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`).
    * `ALL`: Logs all SQL commands.

    The default value is `DDL`.

    The `PREPARE` and `EXPLAIN ANALYZE` expressions are also logged if they contain the relevant types of commands.

    For more information, see the [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#log_statement).

* **Log statement stats**{#setting-log-statement-stat} {{ tag-con }}

    This setting controls whether to log query statistics (parsing, scheduling, execution).

    The setting is disabled by default (no logging).

    For more information, see the [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#log_statement_stats).

* **Master shared buffers**{#setting-master-shared-buffers} {{ tag-con }}

    The amount of memory the {{ GP }} master host uses for shared memory buffers (in bytes).

    The minimum value is `1048576` (1 MB). The default value is `134217728` (128 MB).

    The maximum value is calculated using the following formula:

    ```text
    min(<master_host_storage_size> / 4, 8 * <size_of_DB_data>)
    ```

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#shared_buffers).

    {% include [requires-restart](../note-requires-restart.md) %}

* **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    The maximum number of concurrent connections to the master host.

    The maximum value is `1000`, the minimum value is `50`, and the default value is `350`. For segment hosts, this value is automatically multiplied by five.

    If you increase this value, we recommend increasing [Max prepared transactions](#setting-max-prepared-transactions) as well.

    If you update this setting, both the master and segment hosts will be checked to have at least 20 MB of available RAM per connection. If this condition is not met, [this error](../../../managed-greenplum/qa/cluster-hosts.md#memory-limit) occurs.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#max_connections).

* **Max prepared transactions**{#setting-max-prepared-transactions} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    The maximum number of transactions that can be in the [prepared state]({{ pg.docs.org }}/current/sql-prepare-transaction.html) at the same time.

    The maximum value is `10000`, the minimum value is `350`, and the default value is `350`. The values for master hosts and segment hosts are the same.

    We recommend choosing a value higher than [Max connections](#setting-max-connections).

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#max_prepared_transactions).

* **Max slot wal keep size**{#setting-max-slot-wal-keep-size} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    The maximum [write-ahead log (WAL)](https://www.postgresql.org/docs/current/wal-intro.html) file size in bytes allowed for replication.

    The minimum value is `0` (no logging), and the maximum value is `214748364800` (200 GB). The default value [depends on the segment host storage size](#settings-instance-dependent) and is calculated by the formula:

    ```text
    0.1 × <segment_host_storage_size> / <number_of_segments_per_host>
    ```

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#max_slot_wal_keep_size).

* **Max statement mem**{#setting-max-statement-mem} {{ tag-con }} {{ tag-tf }} {{ tag-api }}

    The maximum amount of memory (in bytes) allocated for query processing.

    The minimum value is `134217728` (128 MB), the maximum value is `1099511627776` (1 TB), and the default value is `2097152000` (2,000 MB).

    For more information, see the [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#max_statement_mem).

* **Segment shared buffers**{#setting-segment-shared-buffers} {{ tag-con }}

    The amount of memory the {{ GP }} segment hosts use for shared memory buffers (in bytes).

    The minimum value is `1048576` (1 MB). The default value is `134217728` (128 MB).

    The maximum value is calculated using the following formula:

    ```text
    min(<segment_host_storage_size> / (4 * <number_of_segments_per_host>), 8 * <size_of_DB_data>)
    ```

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#shared_buffers).

    {% include [requires-restart](../note-requires-restart.md) %}
