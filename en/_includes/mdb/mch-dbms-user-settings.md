* **Add HTTP CORS header**{#setting-add-http-cors-header} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Adds a CORS header to HTTP responses.

   By default, no CORS header is included in HTTP responses.

* **Allow DDL**{#setting-allow-ddl} {{ tag-all }}

   Defines whether DDL queries will be executed (`CREATE`, `ALTER`, `RENAME`, and others).

   By default, DDL queries are allowed.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/permissions-for-queries/#settings_allow_ddl).

   See also the [Readonly](#setting-readonly) setting.

* **Allow introspection functions**{#setting-allow-introspection-functions} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   Enables [introspection functions]({{ ch.docs }}/sql-reference/functions/introspection/) for profiling queries.

   Possible values:

   * `0`: Introspection functions are disabled.
   * `1`: Introspection functions are enabled.

   The default value is `0`.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-allow_introspection_functions).

* **Allow suspicious low cardinality types**{#setting-allow-suspicious-low-cardinality-types} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   Allows using the [LowCardinality]({{ ch.docs }}/sql-reference/data-types/lowcardinality/) data type along with types of data with a fixed size of up to 8B.

   Possible values:

   * `0`: Limited use of `LowCardinality`.
   * `1`: Unlimited use of `LowCardinality`.

   The default value is `0`.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#allow_suspicious_low_cardinality_types).

* **Any join distinct right table keys**{#setting-any-join-distinct-right-table-keys} {{ tag-con }} {{ tag-sql }}

   Enables outdated behavior of the {{ CH }} server for `ANY INNER|LEFT JOIN` operations.

   By default, the outdated behavior for `JOINs` is disabled.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#any_join_distinct_right_table_keys).

* **Async insert**{#setting-async-insert} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   Enables/disables asynchronous inserts. Only works for inserts over HTTP. These inserts are made with no deduplication.

   If enabled, data is grouped into batches before inserting it in a table. This allows making small and frequent inserts in {{ CH }} (up to 15000 queries per second) without using intermediate tables.

   Possible values:

   * `0`: Synchronous inserts are made, one query after another.
   * `1`: Multiple asynchronous inserts are enabled.

   The default value is `0`.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#async-insert).

* **Async insert busy timeout ms**{#setting-async-insert-busy-timeout-ms} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   Maximum timeout (ms) before inserting data after the first `INSERT` query.

   The default value is `200`. If `0`, there is no timeout.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#async-insert-busy-timeout-ms).

* **Async insert max data size**{#setting-async-insert-max-data-size} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   Maximum size of raw data (in bytes) collected per query before inserting it.

   The default value is `1000000`. If `0`, asynchronous inserts are disabled.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#async-insert-max-data-size).

* **Async insert stale timeout ms**{#setting-async-insert-stale-timeout-ms} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   Maximum timeout (ms) before inserting data after the last `INSERT` query. If the value is different from zero, the [**Async insert busy timeout ms**](#setting-async-insert-busy-timeout-ms) is extended with each `INSERT` query until the [**Async insert max data size**](#setting-async-insert-max-data-size) value is exceeded.

   The default value is `0`. If `0`, there is no timeout.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#async-insert-stale-timeout-ms).

* **Async insert threads**{#setting-async-insert-threads} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   Maximum number of threads for data background processing and inserts.

   The default value is `16`. If `0`, asynchronous inserts are disabled.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#async-insert-threads).

* **Cancel http readonly queries on client close**{#setting-cancel-http-readonly-queries-on-client-close} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   If enabled, the service cancels HTTP readonly queries (like a SELECT) when the client aborts a connection before a response is returned.

   This setting is disabled by default.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#cancel-http-readonly-queries-on-client-close).

* **Compile**{#setting-compile} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Defines whether to compile queries when running them. With compilation enabled, structurally identical queries may run faster by using their compiled parts.

   Use this setting in combination with the [Min count to compile](#setting-min-count-to-compile) setting.

   Compilation is disabled by default.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#compile).

* **Compile expressions**{#setting-compile-expressions} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Defines whether to compile expressions when running queries. With compilation enabled, queries that use identical expressions may run faster by using compiled expressions.

   Use this setting in combination with [Min count to compile expression](#setting-min-count-to-compile-expression).

   Expression compilation is disabled by default.

* **Connect timeout**{#setting-connect-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Connection timeout in milliseconds.

   Minimum value is `1`. Default value is `10000` (10 seconds).

* **Connect timeout with failover ms**{#setting-connect-timeout-with-failover-ms} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   Remote server connect timeout (ms) for `Distributed` table engines if a cluster uses sharding and replication.

   If unable to connect to the server, attempts are made to connect to its replicas.

   The default value is `50`.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#connect-timeout-with-failover-ms).

* **Count distinct implementation**{#setting-count-distinct-implementation} {{ tag-all }}

   Determines the `uniq*` function to be used when performing a `COUNT(DISTINCT …)`:
   * [uniq]({{ ch.docs }}/sql-reference/aggregate-functions/reference/uniq/#agg_function-uniq)
   * [uniqCombined]({{ ch.docs }}/sql-reference/aggregate-functions/reference/uniqcombined/#agg_function-uniqcombined)
   * [uniqCombined64]({{ ch.docs }}/sql-reference/aggregate-functions/reference/uniqcombined64/#agg_function-uniqcombined64)
   * [uniqHLL12]({{ ch.docs }}/sql-reference/aggregate-functions/reference/uniqhll12/#agg_function-uniqhll12)
   * [uniqExact]({{ ch.docs }}/sql-reference/aggregate-functions/reference/uniqexact/#agg_function-uniqexact)

   By default, the `uniqExact` function is used.

* **Date time input format**{#setting-date-time-input-format} {{ tag-con }} {{ tag-sql }}

   Determines the parser to be used for a text representation of date and time when processing the input format:
   * `best_effort`: Extended parser.
   * `basic`: Basic parser.

   By default, the `basic` parser is used.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-date_time_input_format).

* **Date time output format**{#setting-date-time-output-format} {{ tag-con }} {{ tag-sql }}

   Determines the output format for a text representation of date and time:
   * `simple`: Simple format.
   * `iso`: ISO format.
   * `unix_timestamp`: Unix format.

   Defaults to `simple`.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-date_time_output_format).

* **Deduplicate blocks in dependent materialized views**{#setting-deduplicate-blocks-in-dependent-materialized-views} {{ tag-con }} {{ tag-sql }}

   Enables checks for deduplication of materialized views that get data from replicated tables.

   Disabled by default (`0`).

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-deduplicate-blocks-in-dependent-materialized-views).

* **Distinct overflow mode**{#setting-distinct-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Determines {{ CH }} behavior when the amount of data when running a `SELECT DISTINCT` query [exceeds the limits]({{ ch.docs }}/operations/settings/query-complexity/#restrictions-on-query-complexity):
   * `throw`: Abort query execution and return an error.
   * `break`: Return a partial result.

   By default, the value is not set (equivalent to `throw`).

* **Distributed aggregation memory efficient**{#setting-distributed-aggregation-memory-efficient} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Defines whether to enable memory saving mode for distributed aggregation.

   Under distributed query processing, remote servers perform [external aggregation](#setting-max-bytes-before-external-group-by). Enable this setting to reduce the memory footprint on the server initiating the query.

   By default, memory saving mode is disabled.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/statements/select/group-by/#select-group-by-in-external-memory).

* **Distributed ddl task timeout**{#setting-distributed-ddl-task-timeout} {{ tag-all }}

   Sets the waiting time for responses to DDL queries from all cluster hosts. If a DDL query isn't executed on all hosts, a response contains the timeout error and the query is run in asynchronous mode. Possible values:
   * A positive integer: The timeout is equal to this integer (in seconds).
   * `0`: Asynchronous mode.
   * A negative number: Infinite timeout.

   By default, `180`.

* **Distributed product mode**{#setting-distributed-product-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Changes the behavior of distributed subqueries when a query contains the product of distributed tables:
   * `deny`: Bans the use of such subqueries.
   * `local`: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal `IN/JOIN`.
   * `global`: Replaces the `IN/JOIN` query with the `GLOBAL IN/GLOBAL JOIN` one.
   * `allow`: Allows the use of such subqueries.

   By default, the value is not set (equivalent to `deny`).

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#distributed-product-mode).

* **Empty result for aggregation by empty set**{#setting-empty-result-for-aggregation-by-empty-set} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Defines the output format when aggregating data without keys (without `GROUP BY`) for an empty set (for example, `SELECT count(*) FROM table WHERE 0`):
   * Disabled (default): {{ CH }} returns a single-line result consisting of `NULL `values for aggregation functions, in accordance with SQL standard.
   * Enabled: {{ CH }} returns an empty result.

* **Enable http compression**{#setting-enable-http-compression} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Defines whether the data in a response to an HTTP request will be compressed.

   By default, {{ CH }} stores data in a compressed format. The request output is uncompressed. For {{ CH }} to compress request outputs when sending them over HTTP, enable this option and pass the selected compression method in the `Accept-Encoding` request  header.
   * `gzip`
   * `br`
   * `deflate`

   By default, data compression in HTTP responses is disabled.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/interfaces/http/).

* **Fallback to stale replicas for distributed queries**{#setting-fallback-to-stale-replicas-for-distributed-queries} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Forces a query to a stale replica if up-to-date data is unavailable.

   {{ CH }} selects the most up-to-date stale replica in the table. Use this setting when running `SELECT` queries from distributed tables pointing to replicated tables.

   By default, query forcing is enabled.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries).

   See also the [Max replica delay for distributed queries](#setting-max-replica-delay-for-distributed-queries) setting.

* **Flatten nested**{#setting-flatten-nested} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   Sets data format for [nested columns]({{ ch.docs }}/sql-reference/data-types/nested-data-structures/nested).

   Possible values:

   * `0`: A nested column is converted into an array of tuples.
   * `1`: A nested column is converted into individual arrays.

   The default value is `1`.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#flatten-nested).

* **Force index by date**{#setting-force-index-by-date} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Disables queries if you can't use an index by date. Works with the [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) family of tables.

   By default, the setting is disabled (query execution is enabled).

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-force_index_by_date).

* **Force primary key**{#setting-force-primary-key} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Disables queries if you can't use an index by primary key. Works with the [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) family of tables.

   By default, the setting is disabled (query execution is enabled).

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-force_primary_key).

* **Format regexp**{#setting-format-regexp} {{ tag-con }} {{ tag-sql }}

   Sets a regular expression in [re2 format](https://github.com/google/re2/wiki/Syntax) to be applied to each row of imported data. The number of subtemplates (parenthetical groups) in the expression must be equal to the number of columns in the table the data is imported to. Use the `\n` or `\r\n` line break characters as delimiters, line breaks can't be escaped. If a row doesn't match the regular expression, it's skipped.

   No value is set by default.

* **Format regexp escaping rule**{#setting-format-regexp_escaping_rule} {{ tag-con }} {{ tag-sql }}

   Sets the escaping rule for the regular expression specified in the [Format regexp](#setting-format-regexp) setting:
   * `CSV`
   * `JSON`
   * `Escaped`
   * `Quoted`
   * `Raw`

   Defaults to `Raw` (no escaping).

* **Format regexp skip unmatched**{#setting-format-regexp-skip-unmatched} {{ tag-con }} {{ tag-sql }}

   Outputs an error message if a row in imported data can't be split by the template specified in the [Format regexp](#setting-format-regexp) setting.

   By default, no message is output (`0`).

* **Group by overflow mode**{#setting-group-by-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Determines {{ CH }} behavior if, during aggregation, the number of unique keys [exceeds the limit]({{ ch.docs }}/operations/settings/query-complexity/#restrictions-on-query-complexity):
   * `throw`: Abort query execution and return an error.
   * `break`: Return a partial result.
   * `any`: Run `GROUP BY` in fuzzy mode. The quality of this computation depends on the data's statistical properties.

   By default, the value is not set (equivalent to `throw`).

* **Group by two level threshold**{#setting-group-by-two-level-threshold} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Defines the number of keys at which two-level aggregation begins.

   Minimum value is `0` (not set). Default is `100000`.

* **Group by two level threshold bytes**{#setting-group-by-two-level-threshold-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Defines the number of bytes in the aggregated output at which two-level aggregation begins.

   Minimum value is `0` (not set). Default is `50000000`.

* **Http connection timeout**{#setting-http-connection-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Sets the HTTP connection timeout in milliseconds.

   Minimum value is `1`. Default is `1000` (one second).

* **Http headers progress interval**{#setting-http-headers progress interval} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Sets the minimum interval between progress notifications with the `X-ClickHouse-Progress` HTTP header, in milliseconds.

   Minimum value is `1`. Default is `100`.

* **Http receive timeout**{#setting-http-receive-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Sets the HTTP receive timeout (in milliseconds).

   Minimum value is `1`. Default is `1800000` (30 minutes).

* **Http send timeout**{#setting-http-send-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Sets the HTTP send timeout (in milliseconds).

   Minimum value is `1`. Default is `1800000` (30 minutes).

* **Input format defaults for omitted fields**{#setting-input-format-defaults-for-omitted-fields} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Determines whether default values will be entered into omitted fields for a column data type when inserting data using `INSERT`.

   By default, replacement is enabled.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#session_settings-input_format_defaults_for_omitted_fields).

* **Input format null as default**{#setting-input-format-null-as-default} {{ tag-con }} {{ tag-sql }}

   Defines if `NULL` cells should be filled in with the default values if the cell data type doesn't allow storing `NULL`.

   Enabled by default (`NULL` cells are filled in with the defaults).

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-input-format-null-as-default).

* **Input format values interpret expressions**{#setting-input-format-values-interpret-expressions} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Enables the SQL parser if the stream parser is unable to parse the data. Use this setting when inserting values containing SQL expressions into the table.

   For instance, the stream parser does not recognize a value containing `now`() while the SQL parser, if enabled, will parse the value correctly causing the output of the `now`() SQL function (current date and time) to be inserted.

   This setting is only used for the [Values]({{ ch.docs }}/interfaces/formats/#data-format-values) format when inserting data.

   By default, the SQL parser is enabled.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-input_format_values_interpret_expressions).

* **Input format with names use header**{#setting-input-format-with-names-use-header} {{ tag-con }} {{ tag-sql }}

   Defines if the order of columns should be checked when inserting data.

   By default, the check is enabled.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-input-format-with-names-use-header).

* **Insert null as default**{#setting-insert-null-as-default} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   Enables inserts of [default values]({{ ch.docs }}/sql-reference/statements/create/table/#create-default-values) instead of [NULL]({{ ch.docs }}/sql-reference/statements/create/table/#null-modifiers) in columns that do not allow `NULL`.

   Possible values:

   * `0`: Inserting `NULL` in a column that doesn't allow `NULL` will throw an exception.
   * `1`: The default column value is inserted instead of `NULL`.

   The default value is `1`.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#insert_null_as_default).

* **Insert quorum**{#setting-insert-quorum} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Manages a {{ CH }} cluster's quorum write:
   * If the value is less than 2, quorum write is disabled.
   * If the value is greater than or equal to 2, quorum write is enabled.

   Quorum write ensures that {{ CH }} writes data error-free to the quorum from the replicas' Insert quorum during an interval that does not exceed [Insert quorum timeout](#setting-insert-quorum-timeout) and that data is not lost if one or more replicas fail. All replicas in the quorum are in the consistent state, meaning that they contain linearized data from the previous `INSERT` queries.

   You can use the [Select sequential consistency](#setting-select-sequential-consistency) setting to read data written with Insert quorum.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-insert_quorum).

* **Insert quorum parallel**{#setting-insert-quorum-parallel} {{ tag-con }} {{ tag-sql }}

   If this setting is enabled, multiple `INSERT` queries with quorum write can be run in parallel. If disabled, only one `INSERT` query with quorum write is made to the same table.

   This setting is enabled by default.

* **Insert quorum timeout**{#setting-insert-quorum-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Sets the [quorum write](#setting-insert-quorum) timeout in milliseconds. If the timeout is complete and a write has not occurred, {{ CH }} will stop the `INSERT` and return an error.

   The minimum value is `1000` (1 second). The default is `60000` (1 minute).

* **Join algorithm**{#setting-join-algorithm} {{ tag-con }} {{ tag-sql }}

   Defines the `JOIN` algorithm:
   * `hash`: Hash join.
   * `partial_merge`: Join by merging sorted lists (sort-merge join).
   * `prefer_partial_merge`: Use merge join whenever possible.
   * `auto`: Hash join is used but, if the server is running out of memory, {{ CH }} tries to use merge join.

   The default algorithm is `hash`.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-join_algorithm).

* **Join overflow mode**{#setting-join-overflow-mode} {{ tag-all }}

   Defines the action to be performed by {{ CH }} if any of the following `JOIN` limits is reached:
   * `max_bytes_in_join`
   * `max_rows_in_join`

   Possible values:
   * `THROW`: {{ CH }} throws an exception and breaks the operation.
   * `BREAK`: {{ CH }} breaks the operation without throwing an exception.

   Defaults to `THROW`.

* **Join use nulls**{#setting-join-use-nulls} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

   Controls the behavior of `JOIN` clauses. If the setting is enabled, empty cells resulting from a join are filled with `NULL` values. Otherwise, the cells are filled with the defaults for the specific field type.

   This setting is disabled by default.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#join_use_nulls).

* **Joined subquery requires alias**{#setting-joined-subquery-requires-alias} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

   Requires aliases for subqueries when executing the `JOIN` command.

   If the setting is enabled, this request is not executed:

   ```sql
   SELECT col1, col2 FROM table1 JOIN (SELECT col3 FROM table2)
   ```

   The request with the specified alias is successfully executed:

   ```sql
   SELECT col1, col2 FROM table1 JOIN (SELECT col3 FROM table2) AS MyQuery
   ```

   This setting is disabled by default.

* **Low cardinality allow in native format**{#setting-low-cardinality-allow-in-native-format} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Determines whether to use [LowCardinality]({{ ch.docs }}/sql-reference/data-types/lowcardinality/) in native format:
   * If this setting is enabled (by default), use native format.
   * If the setting is off, do not use native format:
      * For `SELECT` queries, convert LowCardinality type columns to regular ones.
      * For `INSERT` queries, convert regular columns to LowCardinality.

   Columns of this type enable you to store data more efficiently as hash tables. Wherever possible, {{ CH }} uses LowCardinality-type columns.

   Some third-party clients for {{ CH }} do not support LowCardinality columns and cannot correctly interpret the output of a query that contains columns of this type. Disabling the setting enables such clients to process query output correctly.

   The official {{ CH }} client supports working with LowCardinality columns.

   This setting is enabled by default.

* **Max ast depth**{#setting-max-ast-depth} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Maximum nesting depth of the syntax tree.

   For complex queries, the syntax tree may be too deep. This setting enables you to block the execution of unnecessarily complex or unoptimized queries for large tables.

   For example, a `SELECT *` query will mostly result in a deeper and more complex syntax tree than a `SELECT ... WHERE ...` query containing constraints and conditions.

   The default is `1000`. If too small a value is set, it may render ClickHouse unable to execute even simple queries.

* **Max ast elements**{#setting-max-ast-elements} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Maximum size of the query syntax tree (number of tree nodes).

   For complex queries, the syntax tree may contain too many elements. This setting enables you to block the execution of unnecessarily complex or unoptimized queries for large tables.

   The default value is `50000`. If too small a value is set, it may render ClickHouse unable to execute even simple queries.

* **Max block size**{#setting-max-block-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Data in {{ CH }} is processed by blocks (a block is a set of column parts). This parameter sets the recommended block size (number of rows) that will be loaded when processing tables. Processing each block entails overhead, so too small a setting can slow processing down.

   Minimum value is `1`. Default is `65536`.

* **Max bytes before external group by**{#setting-max-bytes-before-external-group-by} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Data accumulated during the `GROUP BY` aggregation are stored in RAM for a certain period of time. This parameter sets a threshold (in bytes) which, when exceeded, will cause data to be flushed to disk to save RAM.

   It is useful if queries fail because there isn't enough RAM to aggregate a large amount of data. If this is the case, set this parameter to a non-zero value to get {{ CH }} to flush data to disk and perform successful aggregation.

   Minimum value is `0` (`GROUP BY` in external memory disabled). Default is `0`.

   When using aggregation in the external memory, we recommend setting the value of this setting twice as low as the [Max memory usage](#setting-max-memory-usage) setting value (by default, the maximum memory usage is limited to 10 GB).

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/statements/select/group-by/#select-group-by-in-external-memory).

   See also the [Distributed aggregation memory efficient](#setting-distributed-aggregation-memory-efficient) setting.

* **Max bytes before external sort**{#setting-max-bytes-before-external-sort} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   This setting is similar to the [previous](#setting-max-bytes-before-external-group-by) setting, except that it is used for the sorting operation (`ORDER BY`).

* **Max bytes in distinct**{#setting-max-bytes-in-distinct} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The maximum amount of uncompressed data (in bytes) occupied by a hash table when using `DISTINCT`.

   The minimum and default value is `0` (no limitation is set).

* **Max bytes in join**{#setting-max-bytes-in-join} {{ tag-all }}

   The maximum amount of uncompressed data (in bytes) occupied by a hash table when using `JOIN`.

   The minimum and default value is `0` (no limitation is set).

* **Max bytes in set**{#setting-max-bytes-in-set} {{ tag-all }}

   The maximum amount of uncompressed data (in bytes) occupied by a set created from a subquery in the `IN` section.

   The minimum and default value is `0` (no limitation is set).

* **Max bytes to read**{#setting-max-bytes-to-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The maximum amount of uncompressed data (in bytes) that can be read from a table when executing a query.

   The minimum and default value is `0` (no limitation is set).

* **Max bytes to sort**{#setting-max-bytes-to-sort} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The maximum amount of uncompressed data (in bytes) that can be read from a table before sorting. This setting helps reduce RAM usage during a sort operation.

   The minimum and default value is `0` (no limitation is set).

* **Max bytes to transfer**{#setting-max-bytes-to-transfer} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The maximum amount of uncompressed data (in bytes) that can be passed to a remote server or saved to a temporary table when using `GLOBAL IN`.

   The minimum and default value is `0` (no limitation is set).

* **Max columns to read**{#setting-max-columns-to-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Maximum number of columns that can be read from a table in a single query. Queries that require reading more columns will fail.

   The minimum and default value is `0` (no limitation is set).

* **Max concurrent queries for user**{#setting-max-concurrent-queries-for-user} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   The maximum number of concurrently processed user queries to a [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table.

   The minimum value is `0` (no limit), defaults to `450`.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#max-concurrent-queries-for-user).

* **Max execution time**{#setting-max-execution-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Maximum query run time in milliseconds.

   If query execution is at one of the stages of sorting or joining and finalizing aggregations, the limit on the maximum query run time will not be checked and may be exceeded.

   The minimum and default value is `0` (no limitation is set).

* **Max expanded ast elements**{#setting-max-expanded-ast-elements} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Maximum query syntax tree size (number of tree nodes) after alias and asterisk value expansion.

   For complex queries, the syntax tree may contain too many elements. This setting enables you to block the execution of unnecessarily complex or unoptimized queries for large tables.

   The default value is `500000`. If too small a value is set, it may render ClickHouse unable to execute even simple queries.

* **Max http get redirects**{#setting-max-http-get-redirects} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   Sets the maximum number of redirects in tables with the [URL engine]({{ ch.docs }}/engines/table-engines/special/url/) for HTTP GET requests.

   If `0`, redirects are not allowed.

   The default value is `0`.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#setting-max_http_get_redirects).

* **Max insert block size**{#setting-max-insert-block-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Enables the creation of blocks of the specified size (in bytes) when inserting data into a table. This setting will work only if a server creates such blocks on its own.

   The default value is `1048576`.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-max_insert_block_size).

* **Max memory usage**{#setting-max-memory-usage} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The maximum amount of RAM (in bytes) to execute a query on a single server. This setting does not account for the amount of free memory or the total amount of a machine's memory. It applies to a single query on a single server.

   Minimum value is `0` (no limit). Default is `10737418240` (10 GB). The maximum value is limited to the Max server memory usage setting value, which can't be changed directly. For more information, see [{#T}](../../managed-clickhouse/concepts/memory-management.md).

   If you are using [Max bytes before external `GROUP BY`](#setting-max-bytes-before-external-group-by) or [Max bytes before external sort](#setting-max-bytes-before-external-sort), we recommend setting their values to half of Max memory usage.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/query-complexity#settings_max_memory_usage).

* **Max memory usage for user**{#setting-max-memory-usage-for-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The maximum amount of RAM (in bytes) to execute user queries on a single server. This setting does not account for the amount of free memory or the total amount of a machine's memory.

   The restriction applies to all user queries that run concurrently within the same server, unlike [Max memory usage](#setting-max-memory-usage).

   The minimum and default value is `0` (no limitation is set).

* **Max network bandwidth**{#setting-max-network-bandwidth} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The maximum network data transmission rate for running a single query (bytes per second).

   The minimum and default value is `0` (no limitation is set).

* **Max network bandwidth for user**{#setting-max-network-bandwidth-for-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The maximum network data transmission rate (bytes per second). This setting applies to all concurrent user queries, unlike [Max network bandwidth](#setting-max-network-bandwidth).

   The minimum and default value is `0` (no limitation is set).

* **Max partitions per insert block**{#setting-partitions-per-insert-block} {{ tag-con }} {{ tag-sql }}

   Limits the maximum number of partitions per insert block.

   The minimum value is `0` (no limit), defaults to `100`.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/query-complexity/#max-partitions-per-insert-block).

* **Max query size**{#setting-max-query-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Limits the size of the largest part of a query (in bytes) that can be transferred to RAM for parsing using the SQL parser.

   Minimum value is `1`. Default is `262144`.

* **Max replica delay for distributed queries**{#setting-max-replica-delay-for-distributed-queries} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Maximum replica delay (in milliseconds). If replica delay is greater than this setting, the replica is no longer used.

   Minimum value is `1000` (1 second). Default is `300000` (5 minutes).

   See also the [Fallback to stale replicas for distributed queries](#setting-fallback-to-stale-replicas-for-distributed-queries) setting.

* **Max result bytes**{#setting-max-result-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The maximum size of an uncompressed data query output (in bytes). This restriction also applies to subqueries and to parts of distributed queries that run on remote servers.

   The minimum and default value is `0` (no limitation is set).

* **Max result rows**{#setting-max-result-rows} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The maximum number of output rows. This restriction also applies to subqueries and to parts of distributed queries that run on remote servers.

   The minimum and default value is `0` (no limitation is set).

* **Max rows in distinct**{#setting-max-rows-in-distinct} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Limits the maximum number of distinct rows when using `DISTINCT`.

   The minimum and default value is `0` (no limitation is set).

* **Max rows in join**{#setting-max-rows-in-join} {{ tag-all }}

   The maximum number of rows in a hash table used when joining tables. Applies to a `SELECT… JOIN` and the `Join` table engine.

   The minimum and default value is `0` (no limitation is set).

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/query-complexity/#settings-max_rows_in_join).

* **Max rows in set**{#setting-max-rows-in-set} {{ tag-all }}

   The maximum number of rows for a set created from a subquery in the `IN` section.

   The minimum and default value is `0` (no limitation is set).

* **Max rows to group by**{#setting-max-rows-to-group-by} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Limits the maximum number of unique keys received from the aggregation function. Use this setting to limit RAM usage during aggregation.

   The minimum and default value is `0` (no limitation is set).

* **Max rows to read**{#setting-max-rows-to-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Maximum number of rows that can be read from a table when running a query.

   The minimum and default value is `0` (no limitation is set).

* **Max rows to sort**{#setting-max-rows-to-sort} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Maximum number of rows to sort. Use this setting to limit RAM usage during sorting.

   The minimum and default value is `0` (no limitation is set).

* **Max rows to transfer**{#setting-max-rows-to-transfer} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Maximum number of rows that can be passed to a remote server or saved in a temporary table when using `GLOBAL IN`.

   The minimum and default value is `0` (no limitation is set).

* **Max temporary columns**{#setting-max-temporary-columns} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The maximum number of temporary columns concurrently stored in RAM when executing a query (including permanent columns).

   The minimum and default value is `0` (no limitation is set).
* **Max temporary non const columns**{#setting-max-temporary-non-const-columns} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The maximum number of temporary columns concurrently stored in RAM when executing a query (excluding permanent columns).

   The minimum and default value is `0` (no limitation is set).

* **Max threads**{#setting-max-threads} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The maximum number of query processing threads, excluding threads for reading data from remote servers. This setting applies to threads that are used for the parallel execution of stages of the query pipeline.

   Minimum and default values are `0` (compute the value automatically as the number of processor cores without accounting for Hyper-Threading).

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-max_threads).

* **Memory profiler step**{#setting-memory-profiler-step} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   Memory profiler step in bytes. If, at the next query execution step, memory usage increases by the number of bytes specified in this setting, the profiler saves the allocated stack trace. A value less than several MB slows down query processing.

   Defaults to `4194304` (4 MB). If `0`, the memory profiler is disabled.

* **Memory profiler sample probability**{#setting-memory-profiler-sample-probability} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   The system will log information about specific memory allocation and deallocation to the `system.trace_log` file of the `MemorySample` tracing type with the specified probability. The logging probability doesn't depend on the size of memory allocated/released.

   Possible values are from `0` to `1`. By default: `0`.

* **Merge tree max bytes to use cache**{#setting-merge-tree-max-bytes-to-use-cache} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The maximum size of a query (in bytes) that uses the uncompressed data cache. Queries larger than the specified value do not use the cache.

   Use this setting in combination with the [Use uncompressed cache](#setting-use-uncompressed-cache) setting.

   The default selected is `192x10x1024x1024`.

* **Merge tree max rows to use cache**{#setting-merge-tree-max-rows-to-use-cache} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The maximum size of a query (in rows) that uses the uncompressed data cache. Queries larger than the specified value do not use the cache.

   Use this setting in combination with the [Use uncompressed cache](#setting-use-uncompressed-cache) setting.

   The default value is `128x8192`.

* **Merge tree min bytes for concurrent read**{#setting-merge-tree-min-bytes-for-concurrent-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   If the number of bytes read from a file exceeds this value, {{ CH }} will try to use multiple threads to read data from the file concurrently.

   Minimum value is `1`. Default is `24x10x1024x1024`.

* **Merge tree min rows for concurrent read**{#setting-merge-tree-min-rows-for-concurrent-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   If the number of rows read from a file exceeds this value, {{ CH }} will try to use multiple threads to read data from the file concurrently.

   Minimum value is `1`. Default is `20x8192`.

* **Min bytes to use direct io**{#setting-merge-tree-min-bytes-to-use-direct-io} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The amount of data (in bytes) required for direct reading (Direct I/O) from disk.

   By default, {{ CH }} doesn't read data directly from a disk, relying on the filesystem and its cache instead. This reading strategy is effective for small amounts of data. If a reading operation involves large amounts of data, it is more efficient to read the data directly from the disk and bypassing the filesystem cache.

   If the total amount of data stored for reading is greater than the value of this parameter, {{ CH }} will fetch the data directly from the disk.

   Minimum value and default value are `0` (direct reads disabled).

* **Min count to compile**{#setting-min-count-to-compile} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Sets the minimum count of structurally identical queries to start [compilation](#setting-compile) from.

   For a value of `0`, compilation is performed in synchronous mode: a query waits for compilation to finish then continues to run. It is recommended to set this value only for testing purposes.

   For all other values, compilation is performed asynchronously in a separate thread: the result is used as soon as it's available, including by currently running queries.

   Minimum value is `0`. Default is `3`.

* **Min count to compile expression**{#setting-min-count-to-compile-expression} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Sets the minimum count of identical expressions to start [expression compilation](#setting-compile-expressions) with.

   For a value of `0`, compilation is performed in synchronous mode: an expression waits for compilation to finish then query execution continues. It is recommended to set this value only for testing purposes.

   For all other values, compilation is performed asynchronously in a separate thread: the result is used as soon as it's available, including by currently running queries.

   Minimum value is `0`. Default is `3`.

* **Min execution speed**{#setting-min-execution-speed} {{ tag-all }}

   The minimum query execution speed (rows per second).

   When executing queries, {{ CH }} processes data in batches. If a batch is processed longer than the time set in [timeout_before_checking_execution_speed]({{ ch.docs }}/operations/settings/query-complexity/#timeout-before-checking-execution-speed), the query execution speed is checked. If the speed is lower than specified in the setting value, an exception is thrown.

   The minimum and default value is `0` (no limitation is set).

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/query-complexity/#min-execution-speed).

* **Min execution speed bytes**{#setting-min-execution-speed-bytes} {{ tag-all }}

   The minimum query execution speed (bytes per second).

   When executing queries, {{ CH }} processes data in batches. If a batch is processed longer than the time set in [timeout_before_checking_execution_speed]({{ ch.docs }}/operations/settings/query-complexity/#timeout-before-checking-execution-speed), the query execution speed is checked. If the speed is lower than specified in the setting value, an exception is thrown.

   The minimum and default value is `0` (no limitation is set).

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/query-complexity/#min-execution-speed-bytes).

* **Min insert block size bytes**{#setting-min-insert-block-size-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The minimum block size (in bytes) that can be inserted into a table by an `INSERT` query. Smaller blocks are [merged]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage).

   Minimum value is `0` (block squashing disabled). Default is ‭`268435456`‬‬ (256 MB).

* **Min insert block size rows**{#setting-min-insert-block-size-rows} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   The minimum block size (in rows) that can be inserted into a table by an `INSERT` query. Smaller blocks are [merged]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage).

   Minimum value is `0` (block squashing disabled). Default is `1048576`.

* **Output format json quote denormals**{#setting-output-format-json-quote-denormals} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Determines whether to output special values for floating-point numbers (`+nan`, `-nan`, `+inf`, and `-inf`) when using JSON format for the output.

   The default value is `false`, preventing special values from being output.

* **Output format json quote_64bit integers**{#setting-output-format-json-quote-64bit-integers} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Defines the format of numbers in the JSON output. If this setting is enabled, 64-bit integers (`UInt64` and `Int64`) are put in quotes when output in JSON to maintain compatibility with most JavaScript engines, otherwise quotes aren't used.

   By default, using quotes around 64-bit integers is disabled.

* **Priority**{#setting-priority} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Sets the priority of a query.
   * `0`: No priority is used.
   * `1`: The highest priority.
   * Other: The higher the number, the lower a query's priority.

   The parameter is set for each query individually.

   If {{ CH }} receives a query with a higher priority, execution of lower-priority queries is suspended until this incoming query is completed.

   The minimum value is `0` (default).

* **Quota mode**{#setting-quota-mode} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

   The mode used to track resources utilized when [quotas]({{ link-console-quotas }}) are enabled:
   * `default`: Keys not used.
   * `keyed`: `quota_key` is passed in a user query parameter, and quotas are calculated individually for each key value.
   * `keyed_by_ip`: Similar to the previous one, but a user's IP address acts as the key. We recommended that you use this mode only if a user does not have a way to acquire a new IP address quickly to bypass quota restrictions, for example. This applies to both IPv4 and IPv6 addresses.

   By default, no value is set (equivalent to `default`).

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/quotas/).

* **Read overflow mode**{#setting-read-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Determines {{ CH }} behavior if the amount of data read [exceeds one of the limits]({{ ch.docs }}/operations/settings/query-complexity/#restrictions-on-query-complexity):
   * `throw`: Abort query execution and return an error.
   * `break`: Return a partial result.

   By default, the value is not set (equivalent to `throw`).

* **Readonly**{#setting-readonly} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Permissions for configuration, read, and write queries:
   * `0` (default): Allows queries of all types.
   * `1`: Only read data queries are allowed.
   * `2`: Read data and edit settings queries are allowed.

   This setting doesn't affect running DDL queries. To enable or disable DDL queries, use the [Allow DDL](#setting-allow-ddl) setting.

   See the [example of creating a user with read-only access](../../managed-clickhouse/operations/cluster-users.md#example-create-readonly-user).

* **Receive timeout**{#setting-receive-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Receive timeout (in milliseconds).

   The default value is `300000` (5 minutes).

* **Replication alter partitions sync**{#setting-replication-alter-partitions-sync} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Sets wait mode for asynchronous actions in `ALTER ... ATTACH DETACH DROP` queries on replicated tables:
   * `0`: Do not wait.
   * `1`: Only wait for execution at its own (default).
   * `2`: Wait for every action to complete.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/statements/alter/#synchronicity-of-alter-queries).

* **Result overflow mode**{#setting-result-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Determines {{ CH }} behavior if the size of the result [exceeds one of the limits]({{ ch.docs }}/operations/settings/query-complexity/#restrictions-on-query-complexity):
   * `throw`: Abort query execution and return an error.
   * `break`: Return a partial result.

   By default, the value is not set (equivalent to `throw`).

* **Select sequential consistency**{#setting-select-sequential-consistency} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Determines whether to enable sequential consistency for `SELECT` queries.

   By default, sequential consistency is disabled.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-select_sequential_consistency).

* **Send progress in http headers**{#setting-send-progress-in-http-headers} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Enables the sending of notifications regarding query execution status using `X-ClickHouse-Progress` headers.

   By default, notifications are disabled.

* **Send timeout**{#setting-send-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Send timeout (in milliseconds).

   The default value is `300000` (5 minutes).

* **Set overflow mode**{#setting-set-overflow-mode} {{ tag-all }}

   Determines {{ CH }} behavior if the amount of data [exceeds one of the query complexity restrictions]({{ ch.docs }}/operations/settings/query-complexity/#restrictions-on-query-complexity):
   * `throw`: Abort query execution and return an error.
   * `break`: Return a partial result.

   By default, the value is not set (equivalent to `throw`).

* **Skip unavailable shards**{#setting-skip-unavailable-shards} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Enables silent skipping of inaccessible shards. A shard is considered unavailable if none of its replicas are available.

   By default, silent skip is disabled.

* **Sort overflow mode**{#setting-sort-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Determines {{ CH }} behavior if the number of rows received before sorting [exceeds one of the limits]({{ ch.docs }}/operations/settings/query-complexity/#restrictions-on-query-complexity):
   * `throw`: Abort query execution and return an error.
   * `break`: Return a partial result.

   By default, the value is not set (equivalent to `throw`).

* **Timeout before checking execution speed**{#setting-timeout-before-checking-execution-speed} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   Timeout (in seconds) before a query execution speed check. It is checked that the execution speed is not lower than that specified in the [**Min execution speed**](#setting-min-execution-speed) parameter.

   The default value is `10`.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/query-complexity/#timeout-before-checking-execution-speed).

* **Timeout overflow mode**{#setting-timeout-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Determines {{ CH }} behavior if a query takes longer than [max_execution_time](#setting-max-execution-time):
   * `throw`: Abort query execution and return an error.
   * `break`: Return a partial result.

   By default, the value is not set (equivalent to `throw`).

* **Transfer overflow mode**{#setting-transfer-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Determines {{ CH }} behavior if the amount of data to be transferred to another server [exceeds one of the limits]({{ ch.docs }}/operations/settings/query-complexity/#restrictions-on-query-complexity):
   * `throw`: Abort query execution and return an error.
   * `break`: Return a partial result.

   By default, the value is not set (equivalent to `throw`).

* **Transform null in**{#setting-transform-null-in} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

   When the compare option is enabled, `NULL = NULL` returns `true` in the `IN` operator.

   This setting is disabled by default.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#transform_null_in).

* **Use uncompressed cache**{#setting-use-uncompressed-cache} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Determines whether to use a cache of uncompressed blocks. Using this type of cache can help significantly reduce latency and improve throughput for a large number of short queries (only for the [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) family of tables). Enable this setting for users who initiate small queries frequently.

   By default, the cache is disabled.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#setting-use_uncompressed_cache).

   See [Merge tree max bytes to use cache](#setting-merge-tree-max-bytes-to-use-cache) and [Merge tree max rows to use cache](#setting-merge-tree-max-rows-to-use-cache).

* **Wait for async insert**{#setting-wait-for-async-insert} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   Enables waiting for [asynchronous insert](#setting-async-insert) handling.

   Possible values:

   * `0`: The server returns `OK` even if a data insert is not completed yet.
   * `1`: The server returns `OK` only after data is inserted.

   The default value is `1`.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#wait-for-async-insert).

* **Wait for async insert timeout**{#setting-wait-for-async-insert-timeout} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

   Asynchronous insert handling timeout (in seconds).

   The default value is `120`. If `0`, there is no timeout.

   For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#wait-for-async-insert-timeout).
