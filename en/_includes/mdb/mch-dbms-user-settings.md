* **Add HTTP CORS header**{#setting-add-http-cors-header} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Adds a CORS header to HTTP responses.

  By default, no CORS header is included in HTTP responses.

* **Allow DDL**{#setting-allow-ddl} {{ tag-all }}

  Decides whether or not to execute DDL queries (`CREATE`, `ALTER`, `RENAME`, and others).

  By default, DDL queries are allowed.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/permissions-for-queries/#settings_allow_ddl).

  See also the [Readonly](#setting-readonly) setting.

* **Allow introspection functions**{#setting-allow-introspection-functions} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Enables [introspection functions]({{ ch.docs }}/sql-reference/functions/introspection/) for query profiling.

  The possible values are:

  * `0`: Introspection functions are disabled.
  * `1`: Introspection functions are enabled.

  The default value is `0`.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-allow_introspection_functions).

* **Allow suspicious low cardinality types**{#setting-allow-suspicious-low-cardinality-types} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Allows using the [LowCardinality]({{ ch.docs }}/sql-reference/data-types/lowcardinality/) data type with fixed-size data types of up to 8 bytes.

  The possible values are:

  * `0`: Restricted use of `LowCardinality`.
  * `1`: Unrestricted use of `LowCardinality`.

  The default value is `0`.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#allow_suspicious_low_cardinality_types).

* **Any join distinct right table keys**{#setting-any-join-distinct-right-table-keys} {{ tag-con }} {{ tag-sql }}

  Enables the deprecated behavior of the {{ CH }} server for `ANY INNER|LEFT JOIN`.

  By default, the deprecated `JOIN` behavior is disabled.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#any_join_distinct_right_table_keys).

* **Async insert**{#setting-async-insert} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Enables/disables asynchronous inserts. Only works for inserts over HTTP. These inserts are made with no deduplication.

  If enabled, data is grouped into batches before inserting it in a table. This allows making small and frequent inserts in {{ CH }} (up to 15000 queries per second) without using intermediate tables.

  The possible values are:

  * `0`: Inserts are synchronous, one query after another.
  * `1`: Multiple asynchronous inserts are enabled.

  The default value is `0`.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#async-insert).

* **Async insert busy timeout**{#setting-async-insert-busy-timeout} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Maximum data insert timeout (ms) after the first `INSERT` query.

  The default value is `200`. If `0`, there is no timeout.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#async-insert-busy-timeout-ms).

* **Async insert max data size**{#setting-async-insert-max-data-size} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Maximum size of raw data (in bytes) collected per query before inserting it.

  The default value is `1000000`. If `0`, asynchronous inserts are disabled.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#async-insert-max-data-size).

* **Async insert stale timeout**{#setting-async-insert-stale-timeout} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Maximum data insert timeout (ms) after the last `INSERT` query. For non-zero values, [**Async insert busy timeout**](#setting-async-insert-busy-timeout) will increase with each `INSERT` query until the [**Async insert max data size**](#setting-async-insert-max-data-size) value is exceeded.

  The default value is `0`. If `0`, there is no timeout.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#async-insert-stale-timeout-ms).

* **Async insert threads**{#setting-async-insert-threads} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Maximum number of threads for data background processing and inserts.

  The default value is `16`. If `0`, asynchronous inserts are disabled.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#async-insert-threads).

* **Async insert use adaptive busy timeout**{#setting-async-insert-use-adaptive-busy-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Decides whether or not to use an adaptive asynchronous insert, where {{ CH }} limits the number of inserts depending on the server load.

  This setting is on by default.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#async_insert_use_adaptive_busy_timeout).

* **Cancel HTTP readonly queries on client close**{#setting-cancel-http-readonly-queries-on-client-close} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  If enabled, the service cancels HTTP readonly queries (like a SELECT) when the client aborts a connection before a response is returned.

  The setting is disabled by default.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#cancel-http-readonly-queries-on-client-close).

* **Compile expressions**{#setting-compile-expressions} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Decides whether or not to compile expressions when running queries. With compilation enabled, queries that use identical expressions may run faster by using compiled expressions.

  Use this setting in combination with [Min count to compile expression](#setting-min-count-to-compile-expression).

  Expression compilation is disabled by default.

* **Connect timeout**{#setting-connect-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Connection timeout in milliseconds.

  The minimum value is `1`, the default value is `10000` (ten seconds).

* **Connect timeout with failover**{#setting-connect-timeout-with-failover} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Remote server connection timeout (ms) for the `Distributed` table engine if a cluster uses sharding and replication.

  If unable to connect to the server, the system will attempt to connect to its replicas.

  The default value is `50`.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#connect-timeout-with-failover-ms).

* **Count distinct implementation**{#setting-count-distinct-implementation} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Indicates the `uniq*` function to use when performing `COUNT(DISTINCT …)`:
  * [uniq]({{ ch.docs }}/sql-reference/aggregate-functions/reference/uniq#agg_function-uniq)
  * [uniqCombined]({{ ch.docs }}/sql-reference/aggregate-functions/reference/uniqcombined#agg_function-uniqcombined)
  * [uniqCombined64]({{ ch.docs }}/sql-reference/aggregate-functions/reference/uniqcombined64#agg_function-uniqcombined64)
  * [uniqHLL12]({{ ch.docs }}/sql-reference/aggregate-functions/reference/uniqhll12#agg_function-uniqhll12)
  * [uniqExact]({{ ch.docs }}/sql-reference/aggregate-functions/reference/uniqexact#agg_function-uniqexact)

  By default, the `uniqExact` function is used.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#count_distinct_implementation).

* **Data type default nullable**{#setting-data-type-default-nullable} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Decides whether or not to use the `Nullable` data type by default in column definition without explicit `NULL` or `NOT NULL` modifiers.

  The setting is disabled by default.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#data_type_default_nullable).

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

  The default format is `simple`.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-date_time_output_format).

* **Deduplicate blocks in dependent materialized views**{#setting-deduplicate-blocks-in-dependent-materialized-views} {{ tag-con }} {{ tag-sql }}

  Enables checks for deduplication of materialized views that get data from replicated tables.

  Disabled by default (`0`).

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-deduplicate-blocks-in-dependent-materialized-views).

* **Distinct overflow mode**{#setting-distinct-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Defines {{ CH }} behavior if the amount of data when running a `SELECT DISTINCT` query [exceeds the limits]({{ ch.docs }}/operations/settings/query-complexity/#restrictions-on-query-complexity):
  * `throw`: Terminate the query and return an error.
  * `break`: Return a partial output.

  By default, the value is not set (equivalent to `throw`).

* **Distributed aggregation memory efficient**{#setting-distributed-aggregation-memory-efficient} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Decides whether or not to enable memory saving mode for distributed aggregation.

  Under distributed query processing, remote servers perform [external aggregation](#setting-max-bytes-before-external-group-by). Enable this setting to reduce the memory footprint on the server initiating the query.

  By default, memory saving mode is disabled.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/statements/select/group-by/#select-group-by-in-external-memory).

* **Distributed ddl task timeout**{#setting-distributed-ddl-task-timeout} {{ tag-all }}

  Sets the waiting time for responses to DDL queries from all cluster hosts. If a DDL query is not run on all hosts, the response will contain the timeout error and the query will be run in asynchronous mode. The possible values are:
  * Positive integer: Timeout is equal to this integer (in seconds).
  * `0`: Asynchronous mode.
  * Negative number: Infinite timeout.

  The default value is `180`.

* **Distributed product mode**{#setting-distributed-product-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Changes the behavior of distributed subqueries when a query contains the product of distributed tables:
  * `deny`: Blocks the use of such subqueries.
  * `local`: Replaces the database and table in a subquery with the destination server (shard) local database and table leaving the regular `IN/JOIN`.
  * `global`: Replaces the `IN/JOIN` query with the `GLOBAL IN/GLOBAL JOIN` one.
  * `allow`: Allows the use of such subqueries.

  By default, no value is set (equivalent to `deny`).

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#distributed-product-mode).

* **Do not merge across partitions select final** {#setting-do-not-merge-across-partitions-select-final} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Decides whether or not to process table sections independently for `SELECT` queries with the `FINAL` operator.

  The setting is disabled by default.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/guides/replacing-merge-tree#exploiting-partitions-with-replacingmergetree).

* **Empty result for aggregation by empty set**{#setting-empty-result-for-aggregation-by-empty-set} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Defines the result format when aggregating data without keys (without `GROUP BY`) for an empty set (for example, `SELECT count(*) FROM table WHERE 0`):
  * Disabled (default): {{ CH }} returns a single-line result with `NULL` values for aggregation functions, in accordance with the SQL standard.
  * Enabled: {{ CH }} returns an empty result.

* **Enable HTTP compression**{#setting-enable-http-compression} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Decides whether or not to compress data in a response to an HTTP request.

  By default, {{ CH }} stores data in a compressed format. The request output is uncompressed. For {{ CH }} to compress a request output when sending it over HTTP, enable this option and include the selected compression method in the `Accept-Encoding` request header.
  * `gzip`
  * `br`
  * `deflate`

  By default, data compression in HTTP responses is disabled.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/interfaces/http/).

* **Enable reads from query cache**{#setting-enable-reads-from-query-cache} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Decides whether or not to extract the results of the `SELECT` queries from the query cache.

  This setting is on by default.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#enable_reads_from_query_cache).

  See also [Use query cache](#setting-use-query-cache).

* **Enable writes to query cache**{#setting-enable-writes-to-query-cache} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Decides whether or not to save the results of the `SELECT` queries to the query cache.

  This setting is on by default.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#enable_writes_to_query_cache).

  See also [Use query cache](#setting-use-query-cache).

* **Fallback to stale replicas for distributed queries**{#setting-fallback-to-stale-replicas-for-distributed-queries} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Forces a query to a stale replica if up-to-date data is unavailable.

  {{ CH }} selects the most up-to-date stale replica in the table. Use this setting when running `SELECT` queries from distributed tables pointing to replicated tables.

  By default, query forcing is enabled.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries).

  See also the [Max replica delay for distributed queries](#setting-max-replica-delay-for-distributed-queries) setting.

* **Flatten nested**{#setting-flatten-nested} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Sets data format for [nested columns]({{ ch.docs }}/sql-reference/data-types/nested-data-structures/nested).

  The possible values are:

  * `0`: Nested column is converted into an array of tuples.
  * `1`: Nested column is converted into individual arrays.

  The default value is `1`.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#flatten-nested).

* **Force index by date**{#setting-force-index-by-date} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Disables queries if you cannot use an index by date. Works with tables of the [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) family.

  By default, this setting is disabled, which means query execution is enabled.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-force_index_by_date).

* **Force primary key**{#setting-force-primary-key} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Disables queries if you cannot use an index by primary key. Works with tables of the [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) family.

  By default, this setting is disabled, which means query execution is enabled.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-force_primary_key).

* **Format avro schema registry url**{#setting-format-avro-schema-registry-url} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  URL of the Confluent schema registry for AvroConfluent format.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/formats#format_avro_schema_registry_url).

* **Format regexp**{#setting-format-regexp} {{ tag-con }} {{ tag-sql }}

  Sets a regular expression in [re2 format](https://github.com/google/re2/wiki/Syntax) to be applied to each row of imported data. The number of subtemplates (parenthetical groups) in the expression must be equal to the number of columns in the table the data is imported to. Use the `\n` or `\r\n` line break characters as delimiters; line breaks cannot be escaped. If a row does not match the regular expression, it is skipped.

  No value is set by default.

* **Format regexp escaping rule**{#setting-format-regexp_escaping_rule} {{ tag-con }} {{ tag-sql }}

  Sets the escaping rule for the regular expression specified in the [Format regexp](#setting-format-regexp) setting:
  * `CSV`
  * `Escaped`
  * `JSON`
  * `Quoted`
  * `Raw`
  * `XML`

  The default value is `Raw` (no escaping).

* **Format regexp skip unmatched**{#setting-format-regexp-skip-unmatched} {{ tag-con }} {{ tag-sql }}

  Outputs an error message if a row in imported data cannot be split by the template specified in the [Format regexp](#setting-format-regexp) setting.

  By default, no message is output (`0`).

* **Group by overflow mode**{#setting-group-by-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines {{ CH }} behavior if, during aggregation, the number of unique keys [exceeds the limit]({{ ch.docs }}/operations/settings/query-complexity/#restrictions-on-query-complexity):
  * `throw`: Terminate the query and return an error.
  * `break`: Return a partial output.
  * `any`: Run `GROUP BY` in fuzzy mode. The quality of this computation depends on the data's statistical properties.

  By default, the value is not set (equivalent to `throw`).

* **Group by two level threshold**{#setting-group-by-two-level-threshold} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Defines the number of keys at which two-level aggregation begins.

  The minimum value is `0` (not set). The default value is `100000`.

* **Group by two level threshold bytes**{#setting-group-by-two-level-threshold-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Defines the number of bytes in the aggregated output at which two-level aggregation begins.

  The minimum value is `0` (not set). The default value is `50000000`.

* **Hedged connection timeout ms**{#setting-hedged-connection-timeout-ms} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

  Timeout (ms) for connecting to the replica to work with hedged requests. Use this setting in combination with [Use hedged requests](#setting-use-hedged-requests).

  The default value is `50`.

  For more information, see the relevant [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/settings/settings#hedged_connection_timeout_ms).

* **HTTP connection timeout**{#setting-http-connection-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the HTTP connection timeout in milliseconds.

  The minimum value is `1`. The default value is `1000` (one second).

* **HTTP headers progress interval**{#setting-http-headers-progress-interval} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the minimum interval between progress notifications with the `X-ClickHouse-Progress` HTTP header, in milliseconds.

  The minimum value is `1`; the default value is `100`.

* **HTTP max field name size**{#setting-http-max-field-name-size} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Maximum field name length in an HTTP header.

  The default value is `131072`.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#http_max_field_name_size).

* **HTTP max field value size**{#setting-http-max-field-value-size} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Maximum field value length in an HTTP header.

  The default value is `131072`.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#http_max_field_value_size).

* **HTTP receive timeout**{#setting-http-receive-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the HTTP receive timeout (in milliseconds).

  Minimum value: `1`; default value: `1800000` (30 minutes).

* **HTTP send timeout**{#setting-http-send-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the HTTP send timeout (in milliseconds).

  Minimum value: `1`; default value: `1800000` (30 minutes).

* **Idle connection timeout**{#setting-idle-connection-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

  Time before closing idle TCP connections, in milliseconds.

  If set to `0`, all connections are closed immediately.

  The default value is `360000` (six minutes).

  For more information, see the relevant [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/settings/settings#idle_connection_timeout).

* **Ignore materialized views with dropped target table**{#setting-ignore-materialized-views-with-dropped-target-table} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Decides whether or not to ignore materialized views with a deleted target table when switching to views.

  The setting is disabled by default.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#ignore_materialized_views_with_dropped_target_table).

* **Input format defaults for omitted fields**{#setting-input-format-defaults-for-omitted-fields} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Indicates whether to write default values into omitted fields based on a column data type when inserting data with `INSERT`.

  By default, replacement is enabled.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#session_settings-input_format_defaults_for_omitted_fields).

* **Input format import nested json**{#setting-input-format-import-nested-json} {{ tag-con }}

  Determines whether to insert JSON data with nested objects.

  By default, such data inserts are disabled.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-input_format_import_nested_json).

* **Input format null as default**{#setting-input-format-null-as-default} {{ tag-con }} {{ tag-sql }}

  Indicates whether to write default values in `NULL` cells if the column data type does not allow storing the `NULL` value.

  This setting is enabled by default (`NULL` cells get default values).

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-input-format-null-as-default).

* **Input format parallel parsing**{#setting-input-format-parallel-parsing} {{ tag-con }}

  Determines whether to split incoming data into parts and parse each of them concurrently while preserving the original sequence. Only supported for [TSV](https://clickhouse.com/docs/en/interfaces/formats#tabseparated), [TKSV](https://clickhouse.com/docs/en/interfaces/formats#tskv), [CSV](https://clickhouse.com/docs/en/interfaces/formats#csv), and [JSONEachRow](https://clickhouse.com/docs/en/interfaces/formats#jsoneachrow) formats.

  By default, such splitting of incoming data is enabled.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#input-format-parallel-parsing).

* **Input format values interpret expressions**{#setting-input-format-values-interpret-expressions} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Enables the SQL parser if the stream parser is unable to parse the data. Use this setting when inserting values containing SQL expressions into the table.

  For instance, the stream parser does not recognize a value containing `now()` while the SQL parser, if enabled, will parse the value correctly insert the output of the `now()` SQL function (current date and time).

  This setting is only used for [Values]({{ ch.docs }}/interfaces/formats/#data-format-values) format when inserting data.

  By default, the SQL parser is enabled.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-input_format_values_interpret_expressions).

* **Input format with names use header**{#setting-input-format-with-names-use-header} {{ tag-con }} {{ tag-sql }}

  Defines if the order of columns should be checked when inserting data.

  By default, the check is enabled.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-input-format-with-names-use-header).

* **Insert keeper max retries**{#setting-insert-keeper-max-retries} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  The maximum number of retries for {{ CK }} (or {{ ZK }}) requests during inserts to replicated [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables.

  Minimum value: `0` (no retries); default value: `20`.

  For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/settings/settings#insert_keeper_max_retries).

* **Insert null as default**{#setting-insert-null-as-default} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Enables inserting [default values]({{ ch.docs }}/sql-reference/statements/create/table/#create-default-values) instead of [NULL]({{ ch.docs }}/sql-reference/statements/create/table/#null-modifiers) in columns that do not allow `NULL`.

  The possible values are:

  * `0`: Inserting `NULL` in a column that does not allow `NULL` will throw an exception.
  * `1`: Insert the default column value instead of `NULL`.

  The default value is `1`.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#insert_null_as_default).

* **Insert quorum**{#setting-insert-quorum} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Manages a {{ CH }} cluster's quorum write:
  * If the value is less than 2, quorum write is disabled.
  * If the value is greater than or equal to 2, quorum write is enabled.

  Quorum write ensures that {{ CH }} writes data error-free to the quorum from the replicas' Insert quorum during an interval that does not exceed [Insert quorum timeout](#setting-insert-quorum-timeout) and that data is not lost if one or more replicas fail. All replicas in the quorum are consistent, i.e., they contain data from all the previous `INSERT` queries.

  You can use the [Select sequential consistency](#setting-select-sequential-consistency) setting to read data written with Insert quorum.

  By default, quorum write is disabled (`0`).

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-insert_quorum).

* **Insert quorum parallel**{#setting-insert-quorum-parallel} {{ tag-con }} {{ tag-sql }}

  If this setting is enabled, you can run multiple `INSERT` queries with quorum writes at the same time. If disabled, a single `INSERT` query with a quorum write will be made to the same table.

  This setting is on by default.

* **Insert quorum timeout**{#setting-insert-quorum-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the [quorum write](#setting-insert-quorum) timeout in milliseconds. If the timeout ends without a write, {{ CH }} will terminate the `INSERT` query and return an error.

  Minimum value: `1000` (one second); default value: `60000` (1 minute).

* **Join algorithm**{#setting-join-algorithm} {{ tag-con }} {{ tag-sql }}

  Defines the `JOIN` algorithm:
  * `auto`: Use a hash join. However, if the server is running out of memory, {{ CH }} will attempt a merge join.
  * `direct`: Perform a join by searching the right-hand table rows, which serve as keys in the left-hand table. Joins are only possible if the following two conditions are met:
    * Storage in the right-hand table supports key-value queries, e.g., [Dictionary]({{ ch.docs }}/engines/table-engines/special/dictionary#dictionary) or [EmbeddedRocksDB]({{ ch.docs }}/engines/table-engines/integrations/embedded-rocksdb).
    * `LEFT` and `INNER JOIN` queries are running.
  * `hash`: Hash join.
  * `parallel_hash`: Type of a hash join where data is split into segments and multiple hash tables are created at the same time instead of a single one.
  * `partial_merge`: Type of sort-merge join where only the right-hand side of the table is completely sorted.
  * `prefer_partial_merge`: `partial_merge` algorithm. It is used whenever possible; otherwise, the `hash` algorithm is used.
  * `sorting_merge`: Sort-merge join.

  For {{ CH }} 24.11 or lower, the default value is `direct,auto`; for 24.12 or higher, `direct,parallel_hash,hash`. An available algorithm will be selected for the particular query depending on table type and engine.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-join_algorithm).

* **Join overflow mode**{#setting-join-overflow-mode} {{ tag-all }}

  Defines the action {{ CH }} will perform if any of the following `JOIN` limits is reached:
  * `max_bytes_in_join`
  * `max_rows_in_join`

  The possible values are:
  * `throw`: {{ CH }} throws an exception and terminates the operation.
  * `break`: {{ CH }} terminates the operation without throwing an exception.

  The default action is `throw`.

* **Join use nulls**{#setting-join-use-nulls} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Controls the behavior of `JOIN` queries. If the setting is enabled, empty cells resulting from a join will get `NULL` values. Otherwise, the cells will get the default values based on the specific field type.

  The setting is disabled by default.

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

  The setting is disabled by default.

* **Load balancing**{#setting-load-balancing} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

  Specifies the replica selection algorithm used to send and process distributed queries. {{ CH }} counts the number of errors per replica and selects the one with the lowest number of errors. If multiple replicas have the same number of errors, the **Load balancing** setting determines the order to sort the replicas in and which replica to select.

  The possible values are:

  * `random`: Sends the query to a random replica (default).

     Disadvantage: host proximity is ignored.

  * `nearest_hostname`: Sends the query to the replica whose host name is the closest possible match to the server host name in the {{ CH }} configuration file. Let's assume you have a server named `example-05-05-5` and two replicas, `example-05-05-7` and `example-05-06-7`. The `example-05-05-7` replica will be selected, as its name is only one character different from the server name.

     With this approach, distributed queries will be more likely sent to the same replicas located in proximity to each other. It eliminates the `random` value's drawback.

  * `hostname_levenshtein_distance`: To select a replica, the same principle applies as for `nearest_hostname`. However, the appropriate replica host name is determined by the [Levenshtein distance](https://en.wikipedia.org/wiki/Levenshtein_distance).

  * `in_order`: Sends the query to the replica in the order as per the {{ CH }} configuration file. In a {{ mch-name }} cluster, replicas are ranged so that the replica located in the same availability zone as the initiator host of distributed subqueries is the first one.

     Disadvantage: if the first replica fails, its workload will be moved to the next replica, which will double its workload.

  * `first_or_random`: Sends the query to the first replica similarly to `in_order`. However, there is an advantage over the `in_order` algorithm: if the first replica in the list fails, a random replica is selected.

  * `round_robin`: Applies the [Round-Robin](https://en.wikipedia.org/wiki/Round-robin_scheduling) policy to select a replica for the query. It is ony used with queries supporting this policy.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#settings-load_balancing).

* **Local filesystem read method**{#setting-local-filesystem-read-method} {{ tag-con }}

  Determines how to read data from the local file system.

  The possible values are:

  * `nmap`
  * `pread`
  * `pread_threadpool`
  * `read`

  The default value is `pread`.

* **Log processors profiles**{#setting-log-processors-profiles} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Decides whether or not to log information about profiling on processors level. The logs will be recorded to the `system.processors_profile_log` table.

  The setting is disabled by default. Changing this setting will restart {{ CH }} servers on cluster hosts.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#log_processors_profiles).

* **Log queries probability**{#setting-log-queries-probability} {{ tag-cli }} {{ tag-sql }}

  Decides whether or not only randomly selected queries with a specified probability must be written to the `system.query_log`, `system.query_thread_log`, and `system.query_views_log` system tables. Random selection reduces the load in case of large number of requests per second.

  This setting is a positive floating-point number within the [0..1] range. For example, if set to `0,5`, approximately half of the queries will be registered in the system tables. If set to `0`, no queries will be registered in the system tables. If set to `1` (default), all queries will be registered in the system tables.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#log_queries_probability).

* **Log query threads**{#setting-log-query-threads} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

  Enables logging of threads which run queries. The logs will be saved to the[system.query_thread_log]({{ ch.docs }}/operations/system-tables/query_thread_log) table.

  This setting works only when the [Query thread log enabled](../../managed-clickhouse/concepts/settings-list.md#setting-query-thread-log-enabled) settings is on. The setting is disabled by default.

  It is only suitable for some users or queries.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#settings-log-query-threads).

* **Log query views**{#setting-log-query-views} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Decides whether or not to log information about dependent views in queries. The logs will be saved to the `system.query_views_log` table.

  This setting is on by default.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#log_query_views).

* **Low cardinality allow in native format**{#setting-low-cardinality-allow-in-native-format} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines whether to use [LowCardinality type]({{ ch.docs }}/sql-reference/data-types/lowcardinality/) in native format.
  * If this setting is enabled (by default), use native format.
  * If the setting is off, do not use native format:
    * For `SELECT` queries, convert LowCardinality type columns to regular ones.
    * For `INSERT` queries, convert regular columns to LowCardinality.

  Columns of this type enable you to store data more efficiently as hash tables. Wherever possible, {{ CH }} uses LowCardinality-type columns.

  Some third-party clients for {{ CH }} do not support LowCardinality columns and cannot correctly interpret the output of a query that contains columns of this type. Disabling the setting enables such clients to process query output correctly.

  The official {{ CH }} client supports working with LowCardinality columns.

  This setting is on by default.

* **Max ast depth**{#setting-max-ast-depth} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Maximum nesting depth of the syntax tree.

  For complex queries, the syntax tree may be too deep. This setting enables you to block the execution of unnecessarily complex or unoptimized queries for large tables.

  For example, a `SELECT *` query will mostly result in a deeper and more complex syntax tree than a `SELECT ... WHERE ...` query with constraints and conditions.

  The default value is `1000`. If too small a value is set, it may render ClickHouse unable to execute even simple queries.

* **Max ast elements**{#setting-max-ast-elements} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Maximum size of the query syntax tree (number of tree nodes).

  For complex queries, the syntax tree may contain too many elements. This setting enables you to block the execution of unnecessarily complex or unoptimized queries for large tables.

  The default value is `50000`. If too small a value is set, it may render ClickHouse unable to execute even simple queries.

* **Max block size**{#setting-max-block-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Data in {{ CH }} is processed by blocks (a block is a set of column parts). This parameter sets the recommended block size (number of rows) that will be loaded when processing tables. Processing each block entails overhead, so too small a setting can slow processing down.

  Minimum value: `1`; default value: `65536`.

* **Max bytes before external group by**{#setting-max-bytes-before-external-group-by} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Data accumulated during the `GROUP BY` aggregation is stored in RAM for a certain period of time. This parameter sets a threshold (in bytes) which, when exceeded, will cause data to be flushed to disk to save RAM.

  The setting is useful if queries fail because there is not enough RAM to aggregate a large amount of data. If this is the case, set this parameter to a non-zero value to get {{ CH }} to flush data to disk and perform successful aggregation.

  The minimum value is `0` (`GROUP BY` is disabled in external memory). The default value is `0`.

  When using aggregation in the external memory, we recommend setting the value of this setting twice as low as the [Max memory usage](#setting-max-memory-usage) setting value (by default, the maximum memory usage is limited to 10 GB).

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/statements/select/group-by/#select-group-by-in-external-memory).

  See also the [Distributed aggregation memory efficient](#setting-distributed-aggregation-memory-efficient) setting.

* **Max bytes before external sort**{#setting-max-bytes-before-external-sort} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  This setting is similar to the [previous](#setting-max-bytes-before-external-group-by) setting, except that it is used for the sorting operation (`ORDER BY`).

* **Max bytes in distinct**{#setting-max-bytes-in-distinct} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum amount of uncompressed data (in bytes) occupied by a hash table when using `DISTINCT`.

  The minimum and default value is `0` (no limit).

* **Max bytes in join**{#setting-max-bytes-in-join} {{ tag-all }}

  The maximum amount of uncompressed data (in bytes) occupied by a hash table when using `JOIN`.

  The minimum and default value is `0` (no limit).

* **Max bytes in set**{#setting-max-bytes-in-set} {{ tag-all }}

  The maximum amount of uncompressed data (in bytes) occupied by a set created from a subquery in the `IN` section.

  The minimum and default value is `0` (no limit).

* **Max bytes to read**{#setting-max-bytes-to-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum amount of uncompressed data (in bytes) that can be read from a table when executing a query.

  The minimum and default value is `0` (no limit).

* **Max bytes to sort**{#setting-max-bytes-to-sort} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum amount of uncompressed data (in bytes) that can be read from a table before sorting. This setting helps reduce RAM usage during a sort operation.

  The minimum and default value is `0` (no limit).

* **Max bytes to transfer**{#setting-max-bytes-to-transfer} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum amount of uncompressed data (in bytes) that can be sent to a remote server or saved to a temporary table when using `GLOBAL IN`.

  The minimum and default value is `0` (no limit).

* **Max columns to read**{#setting-max-columns-to-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Maximum number of columns that can be read from a table in a single query. Queries that require reading more columns will fail.

  The minimum and default value is `0` (no limit).

* **Max concurrent queries for user**{#setting-max-concurrent-queries-for-user} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  The maximum number of concurrently processed user queries to a [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table.

  Minimum value: `0` (no limit). Default value: `450`.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings/#max-concurrent-queries-for-user).

* **Max execution time**{#setting-max-execution-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Maximum query run time in milliseconds.

  If query execution is at one of the stages of sorting or joining and finalizing aggregations, the limit on the maximum query run time will not be checked and may be exceeded.

  Minimum value: `0` (no limit). Default value: `600000`.

* **Max expanded ast elements**{#setting-max-expanded-ast-elements} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Maximum query syntax tree size (number of tree nodes) after alias and asterisk value expansion.

  For complex queries, the syntax tree may contain too many elements. This setting enables you to block the execution of unnecessarily complex or unoptimized queries for large tables.

  The default value is `500000`. If too small a value is set, it may render ClickHouse unable to execute even simple queries.

* **Max final threads**{#setting-max-final-threads} {{ tag-con }}

  Maximum number of parallel threads for a `SELECT` query with the [FINAL]({{ ch.docs }}/sql-reference/statements/select/from/#select-from-final) modifier.

  The default value is equal to the [Max threads](#setting-max-threads) setting value.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#max-final-threads).

* **Max HTTP get redirects**{#setting-max-http-get-redirects} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Sets the maximum number of redirect hops in [URL engine]({{ ch.docs }}/engines/table-engines/special/url/) tables for HTTP GET requests.

  If `0`, redirect hops are not allowed.

  The default value is `0`.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#setting-max_http_get_redirects).

* **Max insert block size**{#setting-max-insert-block-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Enables the creation of blocks of the specified size (in bytes) when inserting data into a table. This setting will work only if a server creates such blocks on its own.

  The default value is `1048576`.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-max_insert_block_size).

* **Max insert threads**{#setting-max-insert-threads} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

  The maximum number of threads for the `INSERT SELECT` query.

  If the value is greater than `1`, the threads will run in parallel. The default value is `0`.

  You can run `INSERT SELECT` queries in parallel only if using the [Max threads](#setting-max-threads) setting to enable running `SELECT` queries in parallel.

  The greater the **Max insert threads** value is, the higher is cluster RAM usage.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#settings-max-insert-threads).

* **Max memory usage**{#setting-max-memory-usage} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum amount of RAM (in bytes) to execute a query on a single server. This setting does not account for the amount of free memory or the total amount of a machine's memory. It applies to a single query on a single server.

  The minimum and default value is `0` (no limit). The maximum value is limited to the `Max server memory usage` setting value, which cannot be changed directly. To learn more, see [{#T}](../../managed-clickhouse/concepts/memory-management.md). If the set value is greater than the **Max server memory usage** value, the latter is used.

  If you are using [Max bytes before external `GROUP BY`](#setting-max-bytes-before-external-group-by) or [Max bytes before external sort](#setting-max-bytes-before-external-sort), we recommend setting their values to half of **Max memory usage**.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/query-complexity#settings_max_memory_usage).

* **Max memory usage for user**{#setting-max-memory-usage-for-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum amount of RAM (in bytes) to execute user queries on a single server. This setting does not account for the amount of free memory or the total amount of a machine's memory.

  The restriction applies to all user queries that run concurrently within the same server, unlike [Max memory usage](#setting-max-memory-usage).

  The minimum and default value is `0` (no limit).

* **Max network bandwidth**{#setting-max-network-bandwidth} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum network data transmission rate for running a single query (bytes per second).

  The minimum and default value is `0` (no limit).

* **Max network bandwidth for user**{#setting-max-network-bandwidth-for-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum network data transmission rate (bytes per second). This setting applies to all concurrent user queries, unlike [Max network bandwidth](#setting-max-network-bandwidth).

  The minimum and default value is `0` (no limit).

* **Max parser depth**{#setting-max-parser-depth} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  The maximum recursion depth in the recursive descent parser. It allows you to control the stack size.

  The minimum value is `0` (unlimited recursion depth). The default value is `1000`.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#max_parser_depth).

* **Max partitions per insert block**{#setting-partitions-per-insert-block} {{ tag-con }} {{ tag-sql }}

  Limits the maximum number of partitions per insert block.

  The minimum value is `0` (unlimited number of partitions). The default value is `100`.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/query-complexity/#max-partitions-per-insert-block).

* **Max query size**{#setting-max-query-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the size of the largest part of a query (in bytes) that can be transferred to RAM for parsing using the SQL parser.

  Minimum value: `1`; default value: `262144`.

* **Max read buffer size**{#setting-max-read-buffer-size} {{ tag-con }}

  Maximum buffer size (in bytes) to read data from the file system.

  The default value is `1048576` (1 MB).

* **Max replica delay for distributed queries**{#setting-max-replica-delay-for-distributed-queries} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Maximum replica delay (in milliseconds). If replica delay is greater than this setting, the replica is no longer used.

  The minimum value is `1000` (1 second). The default value is `300000` (5 minutes).

  See also the [Fallback to stale replicas for distributed queries](#setting-fallback-to-stale-replicas-for-distributed-queries) setting description.

* **Max result bytes**{#setting-max-result-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum size of an uncompressed data query output (in bytes). This restriction also applies to subqueries and to parts of distributed queries that run on remote servers.

  The minimum and default value is `0` (no limit).

* **Max result rows**{#setting-max-result-rows} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum number of output rows. This restriction also applies to subqueries and to parts of distributed queries that run on remote servers.

  The minimum and default value is `0` (no limit).

* **Max rows in distinct**{#setting-max-rows-in-distinct} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum number of distinct rows when using `DISTINCT`.

  The minimum and default value is `0` (no limit).

* **Max rows in join**{#setting-max-rows-in-join} {{ tag-all }}

  The maximum number of rows in a hash table used when joining tables. Applies to `SELECT… JOIN` and the `Join` table engine.

  The minimum and default value is `0` (no limit).

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/query-complexity/#settings-max_rows_in_join).

* **Max rows in set**{#setting-max-rows-in-set} {{ tag-all }}

  The maximum number of rows for a set created from a subquery in the `IN` section.

  The minimum and default value is `0` (no limit).

* **Max rows to group by**{#setting-max-rows-to-group-by} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum number of unique keys received from the aggregation function. Use this setting to limit RAM usage during aggregation.

  The minimum and default value is `0` (no limit).

* **Max rows to read**{#setting-max-rows-to-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Maximum number of rows that can be read from a table when running a query.

  The minimum and default value is `0` (no limit).

* **Max rows to sort**{#setting-max-rows-to-sort} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Maximum number of rows to sort. Use this setting to limit RAM usage during sorting.

  The minimum and default value is `0` (no limit).

* **Max rows to transfer**{#setting-max-rows-to-transfer} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Maximum number of rows that can be sent to a remote server or saved in a temporary table when using `GLOBAL IN`.

  The minimum and default value is `0` (no limit).

* **Max temporary columns**{#setting-max-temporary-columns} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum number of temporary columns concurrently stored in RAM when executing a query (including permanent columns).

  The minimum and default value is `0` (no limit).

* **Max temporary data on disk size for query**{#setting-max-temporary-data-on-disk-size-for-query} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  The maximum amount of data (in bytes) consumed by temporary files on the disk for all concurrently running queries.

  The minimum value is `0` (no limit).

  For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_query).

* **Max temporary data on disk size for user**{#setting-max-temporary-data-on-disk-size-for-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  The maximum amount of data (in bytes) consumed by temporary files on the disk for all concurrently running user queries.

  The minimum value is `0` (no limit).

  For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_user).

* **Max temporary non const columns**{#setting-max-temporary-non-const-columns} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum number of temporary columns concurrently stored in RAM when executing a query (excluding permanent columns).

  The minimum and default value is `0` (no limit).

* **Max threads**{#setting-max-threads} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum number of query processing threads, excluding threads for reading data from remote servers. This setting applies to threads that are used for the parallel execution of stages of the query pipeline.

  The minimum and default value is `0` (the value is calculated automatically based on the number of physical CPU cores excluding hyper-threading cores).

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-max_threads).

* **Memory overcommit ratio denominator**{#setting-memory-overcommit-ratio-denominator} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  [Memory overcommit](https://clickhouse.com/docs/en/operations/settings/memory-overcommit) limit (in GB) when the hard memory usage limit is reached at the user level.

  The minimum value is `0` (unlimited). The default value is `1`.

  For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_overcommit_ratio_denominator).

* **Memory overcommit ratio denominator for user**{#setting-memory-overcommit-ratio-denominator-for-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  [Memory overcommit](https://clickhouse.com/docs/en/operations/settings/memory-overcommit) limit (in GB) when the hard memory usage limit is reached globally.

  The minimum value is `0` (unlimited). The default value is `1`.

  For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_overcommit_ratio_denominator_for_user).

* **Memory profiler sample probability**{#setting-memory-profiler-sample-probability} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  The system will log information about specific memory allocation and deallocation to the `system.trace_log` file of the `MemorySample` tracing type with the specified probability. The logging probability does not depend on the size of the allocated or released memory.

  You can specify values between `0` and `1`. The default value is `0`.

* **Memory profiler step**{#setting-memory-profiler-step} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Memory profiler step in bytes. If, at the next query execution step, memory usage increases by the number of bytes specified in this setting, the profiler saves the allocated stack trace. A value less than several MB slows down query processing.

  The default value is `4194304` (4 MB). If `0`, the memory profiler is disabled.

* **Memory usage overcommit max wait microseconds**{#setting-memory-usage-overcommit-max-wait-microseconds} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Timeout (in microseconds) before releasing memory in the event of user-level [memory overcommit](https://clickhouse.com/docs/en/operations/settings/memory-overcommit).

  The default value is `5000000` (five seconds).

  For more information, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_usage_overcommit_max_wait_microseconds).

* **Merge tree max bytes to use cache**{#setting-merge-tree-max-bytes-to-use-cache} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum size of a query (in bytes) that uses the uncompressed data cache. Queries larger than the specified value do not use the cache.

  Use this setting in combination with the [Use uncompressed cache](#setting-use-uncompressed-cache) setting.

  The default value is `192x10x1024x1024`.

* **Merge tree max rows to use cache**{#setting-merge-tree-max-rows-to-use-cache} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum size of a query (in rows) that uses the uncompressed data cache. Queries larger than the specified value do not use the cache.

  Use this setting in combination with the [Use uncompressed cache](#setting-use-uncompressed-cache) setting.

  The default value is `128x8192`.

* **Merge tree min bytes for concurrent read**{#setting-merge-tree-min-bytes-for-concurrent-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  If the number of bytes read from a file exceeds this value, {{ CH }} will try to use multiple threads to read data from the file concurrently.

  Minimum value: `1`; default value: `24x10x1024x1024`.

* **Merge tree min rows for concurrent read**{#setting-merge-tree-min-rows-for-concurrent-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  If the number of rows read from a file exceeds this value, {{ CH }} will try to use multiple threads to read data from the file concurrently.

  Minimum value: `1`; default value: `20x8192`.

* **Min bytes to use direct io**{#setting-merge-tree-min-bytes-to-use-direct-io} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The amount of data (in bytes) required for direct reading (Direct I/O) from disk.

  By default, {{ CH }} does not read data directly from a disk, relying on the file system and its cache instead. This reading strategy is effective for small amounts of data. If a reading operation involves large amounts of data, it is more efficient to read the data directly from the disk and bypassing the filesystem cache.

  If the total amount of data stored for reading is greater than the value of this parameter, {{ CH }} will fetch the data directly from the disk.

  The minimum and default value is `0` (direct reads  are disabled).

* **Min count to compile**{#setting-min-count-to-compile} {{ tag-cli }} {{ tag-api }} {{ tag-sql }} 

  This setting is deprecated.

  Sets the minimum count of structurally identical queries to start [compilation](#setting-compile) from.

  For a value of `0`, compilation is performed in synchronous mode: a query waits for the compilation to finish and then resumes. We recommended setting this value only for testing purposes.

  For all other values, compilation is performed asynchronously in a separate thread: the result is used as soon as it is available, including by currently running queries.

  Minimum value: `0`; default value: `3`.

* **Min count to compile expression**{#setting-min-count-to-compile-expression} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the minimum count of identical expressions to start [expression compilation](#setting-compile-expressions) with.

  For a value of `0`, compilation is performed in synchronous mode: an expression waits for the compilation to finish, then the query resumes. We recommended setting this value only for testing purposes.

  For all other values, compilation is performed asynchronously in a separate thread: the result is used as soon as it is available, including by currently running queries.

  The minimum value is `0`; the default value is `3`.

* **Min execution speed**{#setting-min-execution-speed} {{ tag-all }}

  The minimum query execution speed (rows per second).

  When executing queries, {{ CH }} processes data in batches. If a batch is processed longer than the time set in [timeout_before_checking_execution_speed]({{ ch.docs }}/operations/settings/query-complexity/#timeout-before-checking-execution-speed), the query execution speed is checked. If the speed is lower than specified in the setting value, an exception is thrown.

  The minimum and default value is `0` (no limit).

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/query-complexity/#min-execution-speed).

* **Min execution speed bytes**{#setting-min-execution-speed-bytes} {{ tag-all }}

  The minimum query execution speed (bytes per second).

  When executing queries, {{ CH }} processes data in batches. If a batch is processed longer than the time set in [timeout_before_checking_execution_speed]({{ ch.docs }}/operations/settings/query-complexity/#timeout-before-checking-execution-speed), the query execution speed is checked. If the speed is lower than specified in the setting value, an exception is thrown.

  The minimum and default value is `0` (no limit).

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/query-complexity/#min-execution-speed-bytes).

* **Min insert block size bytes**{#setting-min-insert-block-size-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The minimum block size (in bytes) that can be inserted into a table by an `INSERT` query. Smaller blocks are [squashed]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage).

  The minimum value is `0` (block merges are disabled). The default value is `268435456` (256 MB).

* **Min insert block size rows**{#setting-min-insert-block-size-rows} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The minimum block size (in rows) that can be inserted into a table by an `INSERT` query. Smaller blocks are [squashed]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage).

  The minimum value is `0` (block squashing is disabled). The default value is `1048576`.

* **Output format json quote denormals**{#setting-output-format-json-quote-denormals} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines whether to output special values for floating-point numbers (`+nan`, `-nan`, `+inf`, and `-inf`) when using JSON format for the output.

  The default value is `false`, i.e., special values are not output.

* **Output format json quote_64bit integers**{#setting-output-format-json-quote-64bit-integers} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Defines the format of numbers in the JSON output. If this setting is enabled, 64-bit integers (`UInt64` and `Int64`) are enclosed in quotes in a JSON output to maintain compatibility with most JavaScript engines; otherwise, no quotes are used. 

  By default, using quotes around 64-bit integers is disabled.

* **Prefer localhost replica**{#setting-prefer-localhost-replica} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

  Enables sending distributed queries to the `localhost` replica.

  If the setting is enabled, {{ mch-name }} distributes queries based on the [Load balancing](#setting-load-balancing) value.

  This setting is on by default.

  {% note warning %}

  If a cluster has a single shard and multiple replicas, disabling this setting may damage the health of the cluster.

  {% endnote %}

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#settings-prefer-localhost-replica).

* **Priority**{#setting-priority} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the priority of a query.
  * `0`: No priority is used.
  * `1`: The highest priority.
  * Other: The higher the number, the lower a query's priority.

  The parameter is set for each query individually.

  If {{ CH }} receives a query with a higher priority, execution of lower-priority queries is suspended until this incoming query is completed.

  The minimum and default value is `0`.

* **Query cache max entries**{#setting-query-cache-max-entries} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Maximum number of query results the current user can save in the query cache.

  The minimum and default value is `0` (no limit).

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#query_cache_max_entries).

  See also [Use query cache](#setting-use-query-cache).

* **Query cache max size in bytes**{#setting-query-cache-max-size-in-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Maximum cache size (in bytes) for the user.

  The minimum and default value is `0` (no limit).

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#query_cache_max_size_in_bytes).

  See also [Use query cache](#setting-use-query-cache).

* **Query cache min query duration**{#setting-query-cache-min-query-duration} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Minimum `SELECT` query duration (in milliseconds) required for the results to be saved to the query cache.

  The minimum and default value is `0` (no limit).

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#query_cache_min_query_duration).

  See also [Use query cache](#setting-use-query-cache).

* **Query cache min query runs**{#setting-query-cache-min-query-runs} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Minimum number of completed `SELECT` queries required for the results to be saved to the query cache.

  The minimum and default value is `0` (no limit).

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#query_cache_min_query_runs).

  See also [Use query cache](#setting-use-query-cache).

* **Query cache nondeterministic function handling**{#setting-query-cache-nondeterministic-function-handling} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Determines how the query cache will process the `SELECT` queries with non-determined functions, such as `rand()` or `now()`.

  The possible values are:

  * `throw`: To generate an exception without caching the query result.
  * `save`: To cache the query result.
  * `ignore`: Not to generate an exception and not to cache the query result.

  By default, the value is not set (equivalent to `throw`).

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#query_cache_nondeterministic_function_handling).

  See also [Use query cache](#setting-use-query-cache).

* **Query cache share between users**{#setting-query-cache-share-between-users} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Decides whether or not the results of the `SELECT` queries saved in the query cache can be read by other users. We do not recommend disabling this parameter for security reasons.

  The setting is disabled by default.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#query_cache_share_between_users).

  See also [Use query cache](#setting-use-query-cache).

* **Query cache tag**{#setting-query-cache-tag} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  String that serves as a label for query cache records. This setting allows you to cache multiple results of the same query. Queries with different tags are considered to be different.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#query_cache_tag).

  See also [Use query cache](#setting-use-query-cache).

* **Query cache ttl**{#setting-query-cache-ttl} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Time (in seconds) after which records in the query cache become obsolete.

  The default value is `60`.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#query_cache_ttl).

  See also [Use query cache](#setting-use-query-cache).

* **Quota mode**{#setting-quota-mode} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  The mode used to track resources utilized when [quotas]({{ link-console-quotas }}) are enabled:
  * `default`: Keys not used.
  * `keyed`: `quota_key` is provided in a user query parameter, and quotas are calculated individually for each key value.
  * `keyed_by_ip`: Similar to the previous one, but a user's IP address acts as the key. We recommended that you use this mode only if a user does not have a way to acquire a new IP address quickly to bypass quota restrictions, for example. This applies to both IPv4 and IPv6 addresses.

  By default, no value is set (equivalent to `default`).

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/quotas/).

* **Read overflow mode**{#setting-read-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines {{ CH }} behavior if the amount of read data [exceeds one of the limits]({{ ch.docs }}/operations/settings/query-complexity/#restrictions-on-query-complexity):
  * `throw`: Terminate the query and return an error.
  * `break`: Return a partial output.

  By default, the value is not set (equivalent to `throw`).

* **Readonly**{#setting-readonly} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Permissions for configuration, read, and write queries:
  * `0` (default): Allows queries of all types.
  * `1`: Only read data queries are allowed.
  * `2`: Read data and edit settings queries are allowed.

  This setting does not affect running DDL queries. To enable or disable DDL queries, use the [Allow DDL](#setting-allow-ddl) setting. 

  See the [example of creating a user with read-only access](../../managed-clickhouse/operations/cluster-users.md#example-create-readonly-user).

* **Receive timeout**{#setting-receive-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Receive timeout (in milliseconds).

  The default value is `300000` (five minutes).

* **Remote filesystem read method**{#setting-remote-filesystem-read-method} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Determines how to read data from a remote file system.

  The possible values are:

  * `read`
  * `threadpool`

  The default value is `threadpool`.

* **Replication alter partitions sync**{#setting-replication-alter-partitions-sync} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets wait mode for asynchronous actions on replicas for `ALTER ... ATTACH DETACH DROP` queries:
  * `0`: Do not wait.
  * `1`: Only wait for execution at its own (default).
  * `2`: Wait for every action to complete.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/statements/alter/#synchronicity-of-alter-queries).

* **Result overflow mode**{#setting-result-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines {{ CH }} behavior if the size of the result [exceeds one of the limits]({{ ch.docs }}/operations/settings/query-complexity/#restrictions-on-query-complexity):
  * `throw`: Terminate the query and return an error.
  * `break`: Return a partial output.

  By default, the value is not set (equivalent to `throw`).

* **Select sequential consistency**{#setting-select-sequential-consistency} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines whether to enable sequential consistency for `SELECT` queries.

  By default, sequential consistency is disabled.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#settings-select_sequential_consistency).

* **Send progress in HTTP headers**{#setting-send-progress-in-http-headers} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Enables the sending of notifications regarding query execution status using `X-ClickHouse-Progress` headers.

  By default, notifications are disabled.

* **Send timeout**{#setting-send-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Send timeout (in milliseconds).

  The default value is `300000` (five minutes).

* **Set overflow mode**{#setting-set-overflow-mode} {{ tag-all }}

  Determines {{ CH }} behavior if the amount of data [exceeds one of the query complexity restrictions]({{ ch.docs }}/operations/settings/query-complexity/#restrictions-on-query-complexity):
  * `throw`: Terminate the query and return an error.
  * `break`: Return a partial output.

  By default, the value is not set (equivalent to `throw`).

* **Skip unavailable shards**{#setting-skip-unavailable-shards} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Enables silent skipping of inaccessible shards. A shard is considered unavailable if none of its replicas are available.

  By default, silent skip is disabled.

* **Sort overflow mode**{#setting-sort-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines {{ CH }} behavior if the number of rows received before sorting [exceeds one of the limits]({{ ch.docs }}/operations/settings/query-complexity/#restrictions-on-query-complexity):
  * `throw`: Terminate the query and return an error.
  * `break`: Return a partial output.

  By default, the value is not set (equivalent to `throw`).

* **Timeout before checking execution speed**{#setting-timeout-before-checking-execution-speed} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Timeout (in milliseconds) before a query execution speed check. It is checked that the execution speed is not lower than that specified in the [**Min execution speed**](#setting-min-execution-speed) parameter.

  The default value is `60000` (one minute).

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/query-complexity/#timeout-before-checking-execution-speed).

* **Timeout overflow mode**{#setting-timeout-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines {{ CH }} behavior if a query takes longer than [max_execution_time](#setting-max-execution-time):
  * `throw`: Terminate the query and return an error.
  * `break`: Return a partial output.

  By default, the value is not set (equivalent to `throw`).

* **Transfer overflow mode**{#setting-transfer-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines {{ CH }} behavior if the amount of data to be transferred to another server [exceeds one of the limits]({{ ch.docs }}/operations/settings/query-complexity/#restrictions-on-query-complexity):
  * `throw`: Terminate the query and return an error.
  * `break`: Return a partial output.

  By default, the value is not set (equivalent to `throw`).

* **Transform null in**{#setting-transform-null-in} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  When the compare option is enabled, `NULL = NULL` returns `true` in the `IN` operator.

  The setting is disabled by default.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#transform_null_in).

* **Use hedged requests**{#setting-use-hedged-requests} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

  Enables hedged requests.

  Allows you to establish multiple connections to various replicas for queries. A new connection is established if the current connections to replicas were not successful within the [Hedged connection timeout ms](#setting-hedged-connection-timeout-ms) period.

  The first connection that sent a non-empty query progress packet is used for this query. The other connections are canceled.

  This setting is on by default.

  For more information, see the relevant [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/settings/settings#use_hedged_requests).

* **Use query cache**{#setting-use-query-cache} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Decides whether or not the `SELECT` queries can use the query cache.

  The setting is disabled by default.

  For more information, see the relevant [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings#use_query_cache).

  See also the [Enable reads from query cache](#setting-enable-reads-from-query-cache) and [Enable writes to query cache](#setting-enable-writes-to-query-cache) settings.

* **Use uncompressed cache**{#setting-use-uncompressed-cache} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines whether to use a cache of uncompressed blocks. Using this type of cache can help significantly reduce latency and improve throughput for a large number of short queries (only for the [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) family of tables). Enable this setting for users who initiate small queries frequently.

  By default, the cache is disabled.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#setting-use_uncompressed_cache).

  See also [Merge tree max bytes to use cache](#setting-merge-tree-max-bytes-to-use-cache) and [Merge tree max rows to use cache](#setting-merge-tree-max-rows-to-use-cache).

* **Wait for async insert**{#setting-wait-for-async-insert} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Enables waiting for [asynchronous insert](#setting-async-insert) handling.

  The possible values are:

  * `0`: The server returns `OK` even if a data insert is not completed yet.
  * `1`: The server returns `OK` only after data is inserted.

  The default value is `1`.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#wait-for-async-insert).

* **Wait for async insert timeout**{#setting-wait-for-async-insert-timeout} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Asynchronous insert handling timeout (in seconds).

  The default value is `120`. If `0`, there is no timeout.

  For more information, see the [{{ CH }} documentation]({{ ch.docs }}/operations/settings/settings/#wait-for-async-insert-timeout).
