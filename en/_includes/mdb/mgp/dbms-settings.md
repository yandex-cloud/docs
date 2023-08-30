* **Gp workfile compression**{#setting-gp-workfile-compression} {{ tag-con }} {{ tag-api }}

   Determines whether temporary files created on the disk during a hash connection or hash aggregation will be compressed.

   By default, the setting is disabled (temporary files aren't compressed).

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression).

* **Gp workfile limits per query**{#setting-gp-workfile-limits} {{ tag-con }} {{ tag-api }}

   The maximum amount of disk space (in bytes) that the temporary files of an active query can occupy in every segment.

   The maximum value is `1099511627776` (1 TB), the minimum is `0` (unlimited amount). Defaults to `0`.

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query).

* **Gp workfile limit files per query**{#setting-gp-workfile-limit-files} {{ tag-con }} {{ tag-api }}

   The maximum number of temporary files which the service creates in a segment to process one query. If the limit is exceeded, the query will be canceled.

   The maximum value is `100000`, the minimum is `0` (unlimited number of temporary files). Defaults to `10000`.

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query).

* **Gp workfile limit per segment**{#setting-gp-workfile-limit-per segment} {{ tag-con }} {{ tag-api }}

   The maximum amount of disk space (in bytes) that temporary files of all active queries can occupy in every segment.

   The maximum value is `1099511627776` (1 TB), the minimum is `0` (unlimited amount). Defaults to `0`.

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment).

* **Log statement**{#setting-log-statement} {{ tag-con }} {{ tag-api }}

   A filter for SQL statements to be written to the {{ GP }} log:

   * `NONE`: The filter is disabled and SQL statements aren't logged.
   * `DDL`: SQL statements that change data definitions are logged (such as `CREATE`, `ALTER`, and `DROP`).
   * `MOD`: SQL statements that fall under the `DDL` filter and statements that let you change data (`INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`) are logged.
   * `ALL`: All SQL statements are logged.

   Default value: `ALL`.

   The `PREPARE` and `EXPLAIN ANALYZE` expressions are also logged if they contain the relevant types of commands.

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement).

* **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-api }}

   The maximum number of simultaneous connections to a master host.

   The maximum value is `1000`, the minimum is `250`. Defaults to `350`. For segment hosts, this value is automatically multiplied by 5.

   If you increase this setting, we recommend increasing [Max prepared transactions](#setting-max-prepared-transactions) as well.

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_connections).

* **Max prepared transactions**{#setting-max-prepared-transactions} {{ tag-con }} {{ tag-api }}

   The maximum number of transactions that can be in the [prepared state](https://www.postgresql.org/docs/9.6/sql-prepare-transaction.html) at the same time.

   The maximum value is `10000`, the minimum is `350`. Defaults to `350`. The values for master hosts and segment hosts are the same.

   We recommend choosing a value higher than [Max connections](#setting-max-connections).

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_prepared_transactions).

* **Max slot wal keep size**{#setting-max-slot-wal-keep-size} {{ tag-con }} {{ tag-api }}

   The maximum [Write-Ahead Log (WAL)](https://www.postgresql.org/docs/current/wal-intro.html) file size in bytes allowed for replication.

   The minimum value is `0` (no log), the maximum is `214748364800` (200 GB). Defaults to `0`.

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_slot_wal_keep_size).

* **Max statement mem**{#setting-max-statement-mem} {{ tag-con }} {{ tag-api }}

   The maximum amount of memory (in bytes) allocated for query processing.

   The minimum value is `134217728` (128 MB), the maximum is `1099511627776` (1 TB). Defaults to `2097152000` (2000 MB).

   For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-config_params-guc-list.html#max_statement_mem).
