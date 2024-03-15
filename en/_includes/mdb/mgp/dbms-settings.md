* **Gp workfile compression**{#setting-gp-workfile-compression} {{ tag-con }} {{ tag-api }}

   This setting determines whether temporary files created on the disk during a hash connection or hash aggregation will be compressed.

   By default, it is disabled, i.e., temporary files are not compressed.

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression).

* **Gp workfile limits per query**{#setting-gp-workfile-limits} {{ tag-con }} {{ tag-api }}

   The maximum amount of disk space (in bytes) the temporary files of an active query can occupy in every segment.

   The maximum value is `1099511627776` (1 TB), the minimum one is `0` (unlimited amount), and the default one is also `0`.

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query).

* **Gp workfile limit files per query**{#setting-gp-workfile-limit-files} {{ tag-con }} {{ tag-api }}

   The maximum number of temporary files the service creates in a segment to process a single query. If the limit is exceeded, the query will be canceled.

   The maximum value is `100000`, the minimum one is `0` (unlimited number of temporary files), and the default one is `10000`.

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query).

* **Gp workfile limit per segment**{#setting-gp-workfile-limit-per-segment} {{ tag-con }} {{ tag-api }}

   The maximum amount of disk space (in bytes) the temporary files of all active queries can occupy in every segment.

   The maximum value is `1099511627776` (1 TB), the minimum one is `0` (unlimited amount). The default value [depends on the segment host storage size](#settings-instance-dependent) and is calculated by the formula:

   ```text
   0.1 × <segment_host_storage_size> / <number_of_segments_per_host>
   ```

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment).

* **Log statement**{#setting-log-statement} {{ tag-con }} {{ tag-api }}

   Filter for SQL statements that will be written to the {{ GP }} log:

   * `NONE`: The filter is disabled and SQL statements are not logged.
   * `DDL`: SQL statements that change data definitions are logged (such as `CREATE`, `ALTER`, and `DROP`).
   * `MOD`: SQL statements that fall under the `DDL` filter and statements that allow you to change data (`INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`) are logged.
   * `ALL`: All SQL statements are logged.

   The default value is `ALL`.

   The `PREPARE` and `EXPLAIN ANALYZE` expressions are also logged if they contain the relevant types of commands.

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement).

* **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-api }}

   The maximum number of simultaneous connections to a master host.

   The maximum value is `1000`, the minimum one is `250`, and the default one is `350`. For segment hosts, this value is automatically multiplied by five.

   If you increase this value, we recommend increasing [Max prepared transactions](#setting-max-prepared-transactions) as well.

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_connections).

* **Max prepared transactions**{#setting-max-prepared-transactions} {{ tag-con }} {{ tag-api }}

   Maximum number of concurrent [prepared]({{ pg.docs.org }}/current/sql-prepare-transaction.html) transactions.

   The maximum value is `10000`, the minimum one is `350`, and the default one is `350`. The values for master hosts and segment hosts are the same.

   We recommend choosing a value higher than [Max connections](#setting-max-connections).

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_prepared_transactions).

* **Max slot wal keep size**{#setting-max-slot-wal-keep-size} {{ tag-con }} {{ tag-api }}

   The maximum [Write-Ahead Log (WAL)](https://www.postgresql.org/docs/current/wal-intro.html) file size in bytes allowed for replication.

   The minimum value is `0` (no logging), the maximum one is `214748364800` (200 GB). The default value [depends on the segment host storage size](#settings-instance-dependent) and is calculated by the formula:

   ```text
   0.1 × <segment_host_storage_size> / <number_of_segments_per_host>
   ```

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_slot_wal_keep_size).

* **Max statement mem**{#setting-max-statement-mem} {{ tag-con }} {{ tag-api }}

   The maximum amount of memory (in bytes) allocated for query processing.

   The minimum value is `134217728` (128 MB), the maximum one is `1099511627776` (1 TB), and the default one is `2097152000` (2000 MB).

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_statement_mem).
