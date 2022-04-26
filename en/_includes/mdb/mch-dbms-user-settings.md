* **Add HTTP CORS header**{#setting-add-http-cors-header} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Adds CORS header in HTTP responses.

    By default, no CORS header is included in HTTP responses.

* **Allow DDL**{#setting-allow-ddl} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Defines whether DDL queries will be executed (`CREATE`, `ALTER`, `RENAME`, and others).

    By default, DDL queries are allowed.

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/operations/settings/permissions-for-queries/#settings_allow_ddl).

    See also: the [Readonly](#setting-readonly) setting.

* **Compile**{#setting-compile} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Defines whether to compile queries when running them. With compilation enabled, structurally identical queries may run faster by using their compiled parts.

    Use this setting in combination with the [Min count to compile](#setting-min-count-to-compile) setting.

    Compilation is disabled by default.

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/operations/settings/settings/#compile).

* **Compile expressions**{#setting-compile-expressions} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Defines whether to compile expressions when running queries. With compilation enabled, queries that use identical expressions may run faster by using compiled expressions.

    Use this setting in combination with the [Min count to compile expression](#setting-min-count-to-compile-expression) setting.

    Expression compilation is disabled by default.

* **Connect timeout**{#setting-connect-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Connection timeout in milliseconds.

    Minimum value is `1`. Default value is `10000` (10 seconds).

* **DISTINCT overflow mode**{#setting-distinct-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Determines the {{ CH }} behavior when running the `SELECT DISTINCT` [exceeds the limit](https://{{ ch-domain }}/docs/en/operations/settings/query-complexity/#ogranicheniia-na-slozhnost-zaprosa): `throw` (stop execution, return error) or `break` (return incomplete result).

    By default, the value is not set (equivalent to `throw`).

* **Distributed aggregation memory efficient**{#setting-distributed-aggregation-memory-efficient} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Defines whether to enable memory saving mode for distributed aggregation.

    Under distributed query processing, remote servers perform [external aggregation](#setting-max-bytes-before-external-group-by). Enable this setting to reduce the memory footprint on the server initiating the query.

    By default, memory saving mode is disabled.

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory).

* **Distributed product mode**{#setting-distributed-product-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Changes the behavior of distributed subqueries when a query contains the product of distributed tables:
    * `deny`: Bans the use of such subqueries.
    * `local`: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal `IN/JOIN`.
    * `global`: Replaces the `IN/JOIN` query with the `GLOBAL IN/GLOBAL JOIN` one.
    * `allow`: Allows the use of such subqueries.

    By default, the value is not set (equivalent to `deny`).

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/operations/settings/settings/#distributed-product-mode).

* **Empty result for aggregation by empty set**{#setting-empty-result-for-aggregation-by-empty-set} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Defines the output format when aggregating data without keys (without `GROUP BY`) for an empty set (for example, `SELECT count(*) FROM table WHERE 0`):
    * Disabled (default): {{ CH }} returns a single-line result consisting of `NULL` values for aggregation functions, in accordance with SQL standard.
    * Enabled: {{ CH }} returns an empty result.

* **Enable HTTP compression**{#setting-enable-http-compression} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Defines whether the data in a response to an HTTP request will be compressed.

    By default, {{ CH }} stores data in a compressed format. The request output is uncompressed. For {{ CH }} to compress request outputs when sending them over HTTP, enable this option and pass the selected compression method in the `Accept-Encoding` request  header.

    ClickHouse supports the following compression methods: `gzip`, `br`, and `deflate`.

    By default, data compression in HTTP responses is disabled.

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/interfaces/http/).

* **Fallback to stale replicas for distributed queries**{#setting-fallback-to-stale-replicas-for-distributed-queries} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Forces a query to a stale replica if up-to-date data is unavailable.

    {{ CH }} selects the most up-to-date stale replica in the table. Use this setting when running `SELECT` queries from distributed tables pointing to replicated tables.

    By default, query forcing is enabled.

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries).

    See also the [Max replica delay for distributed queries](#setting-max-replica-delay-for-distributed-queries) setting.

* **Force index by date**{#setting-force-index-by-date} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Disables queries if you can't use an index by date. Works with the [MergeTree](https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/mergetree/) family of tables.

    By default, the setting is disabled (query execution is enabled).

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/operations/settings/settings/#settings-force_index_by_date).

* **Force primary key**{#setting-force-primary-key} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Disables queries if you can't use an index by primary key. Works with the [MergeTree](https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/mergetree/) family of tables.

    By default, the setting is disabled (query execution is enabled).

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/operations/settings/settings/#settings-force_primary_key).

* **GROUP BY overflow mode**{#setting-group-by-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Defines {{ CH }} behavior when the number of unique keys during aggregation [exceeds the limit](https://{{ ch-domain }}/docs/en/operations/settings/query-complexity/#ogranicheniia-na-slozhnost-zaprosa):
    * `throw`: Abort query execution and return an error.
    * `break`: Return a partial result.
    * `any`: Run `GROUP BY` in fuzzy mode. The quality of this computation depends on the data's statistical properties.

    By default, the value is not set (equivalent to `throw`).

* **GROUP BY two level threshold**{#setting-group-by-two-level-threshold} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Defines the number of keys at which two-level aggregation begins.

    Minimum value is `0` (not set). Default is `100000`.

* **GROUP BY two level threshold bytes**{#setting-group-by-two-level-threshold-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Defines the number of bytes in the aggregated output at which two-level aggregation begins.

    Minimum value is `0` (not set). Default is `50000000`.

* **HTTP connection timeout**{#setting-http-connection-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Sets the HTTP connection timeout in milliseconds.

    Minimum value is `1`. Default is `1000` (one second).

* **HTTP headers progress interval**{#setting-http-headers progress interval} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Sets the minimum interval between progress notifications with the `X-ClickHouse-Progress` HTTP header, in milliseconds.

    Minimum value is `1`. Default is `100`.

* **HTTP receive timeout**{#setting-http-receive-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Sets the HTTP receive timeout (in milliseconds).

    Minimum value is `1`. Default is `1800000` (30 minutes).

* **HTTP send timeout**{#setting-http-send-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Sets the HTTP send timeout (in milliseconds).

    Minimum value is `1`. Default is `1800000` (30 minutes).

* **Input format defaults for omitted fields**{#setting-input-format-defaults-for-omitted-fields} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Determines whether default values will be entered into omitted fields for a column data type when inserting data using `INSERT`.

    By default, replacement is enabled.

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/operations/settings/settings/#session_settings-input_format_defaults_for_omitted_fields).

* **Input format values interpret expressions**{#setting-input-format-values-interpret-expressions} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Enables the SQL parser if the stream parser is unable to parse the data. Use this setting when inserting values containing SQL expressions into the table.

    For instance, the stream parser does not recognize a value containing `now()` while the SQL parser, if enabled, will parse the value correctly causing the output of the `now()` SQL function (current date and time) to be inserted.

    This option is used only for the [Values](https://{{ ch-domain }}/docs/en/interfaces/formats/#data-format-values) format when inserting data.

    By default, the SQL parser is enabled.

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions).

* **Insert quorum**{#setting-insert-quorum} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Manages a {{ CH }} cluster's quorum write:
    * If the value is less than 2, quorum write is disabled.
    * If the value is greater than or equal to 2, quorum write is enabled.

    Quorum write ensures that {{ CH }} writes data error-free to the quorum from the replicas' Insert quorum during an interval that does not exceed [Insert quorum timeout](#setting-insert-quorum-timeout) and that data is not lost if one or more replicas fail. All replicas in the quorum are in the consistent state, meaning that they contain linearized data from the previous `INSERT` queries.

    You can use the [Select sequential consistency](#setting-select-sequential-consistency) setting to read data written with Insert quorum.

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/operations/settings/settings/#settings-insert_quorum).

* **Insert quorum timeout**{#setting-insert-quorum-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Sets the [insert quorum](#setting-insert-quorum) timeout in milliseconds. If the timeout is complete, and a write has not occurred, ClickHouse will stop the `INSERT` and return an error.

    The minimum value is `1000` (1 second). The default is `60000` (1 minute).

* **Join use nulls**{#setting-join-use-nulls} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

    Controls the behavior of `JOIN` clauses. If the setting is enabled, empty cells resulting from a join are filled with `NULL` values. Otherwise, the cells are filled with the defaults for the specific field type.

    This setting is disabled by default.

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/operations/settings/settings/#join_use_nulls).

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

    Determines whether to use [LowCardinality](https://{{ ch-domain }}/docs/en/sql-reference/data-types/lowcardinality/) in native format:
    * If this setting is enabled (by default), use native format.
    * If the setting is off, do not use native format:
      * For `SELECT` queries, convert LowCardinality type columns to regular ones.
      * For `INSERT` queries, convert regular columns to LowCardinality.

    Columns of this type enable you to store data more efficiently as hash tables. Wherever possible, {{ CH }} uses LowCardinality-type columns.

    Some third-party clients for {{ CH }} do not support LowCardinality columns and cannot correctly interpret the output of a query that contains columns of this type. Disabling the setting enables such clients to process query output correctly.

    The official {{ CH }} client supports working with LowCardinality columns.

    This setting is enabled by default.

* **Max AST depth**{#setting-max-ast-depth} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Maximum nesting depth of the syntax tree.

    For complex queries, the syntax tree may be too deep. This setting enables you to block the execution of unnecessarily complex or unoptimized queries for large tables.

    For example, a `SELECT *` query will mostly result in a deeper and more complex syntax tree than a `SELECT ... WHERE ...` query containing constraints and conditions.

    The default is `1000`. If too small a value is set, it may render ClickHouse unable to execute even simple queries.

* **Max AST elements**{#setting-max-ast-elements} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Maximum size of the query syntax tree (number of tree nodes).

    For complex queries, the syntax tree may contain too many elements. This setting enables you to block the execution of unnecessarily complex or unoptimized queries for large tables.

    The default value is `50000`. If too small a value is set, it may render ClickHouse unable to execute even simple queries.

* **Max block size**{#setting-max-block-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Data in {{ CH }} is processed by blocks (a block is a set of column parts). This parameter sets the recommended block size (number of rows) that will be loaded when processing tables. Processing each block entails overhead, so too small a setting can slow processing down.

    Minimum value is `1`. Default is `65536`.

* **Max bytes before external `GROUP BY`**{#setting-max-bytes-before-external-group-by} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Data accumulated during the `GROUP BY` aggregation are stored in RAM for a certain period of time. This parameter sets a threshold (in bytes) which, when exceeded, will cause data to be flushed to disk to save RAM.

    It is useful if queries fail because there isn't enough RAM to aggregate a large amount of data. If this is the case, set this parameter to a non-zero value to get {{ CH }} to flush data to disk and perform successful aggregation.

    Minimum value is `0` (`GROUP BY` in external memory disabled). Default is `0`.

    When using aggregation in the external memory, we recommend setting the value of this setting twice as low as the [Max memory usage](#setting-max-memory-usage) setting value (by default, the maximum memory usage is limited to 10 GB).

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory).

    See also the [Distributed aggregation memory efficient](#setting-distributed-aggregation-memory-efficient) setting.

* **Max bytes before external sort**{#setting-max-bytes-before-external-sort} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    This setting is similar to the [previous](#setting-max-bytes-before-external-group-by) one, except that it applies to sorting (`ORDER BY`).

* **Max bytes in DISTINCT**{#setting-max-bytes-in-distinct} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    The maximum amount of uncompressed data (in bytes) occupied by a hash table when using `DISTINCT`.

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

* **Max execution time**{#setting-max-execution-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Maximum query run time in milliseconds.

    If query execution is at one of the stages of sorting or joining and finalizing aggregations, the limit on the maximum query run time will not be checked and may be exceeded.

    The minimum and default value is `0` (no limitation is set).

* **Max expanded AST elements**{#setting-max-expanded-ast-elements} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Maximum query syntax tree size (number of tree nodes) after alias and asterisk value expansion.

    For complex queries, the syntax tree may contain too many elements. This setting enables you to block the execution of unnecessarily complex or unoptimized queries for large tables.

    The default value is `500000`. If too small a value is set, it may render ClickHouse unable to execute even simple queries.

* **Max INSERT block size**{#setting-max-insert-block-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Enables the creation of blocks of the specified size (in bytes) when inserting data into a table. This setting will work only if a server creates such blocks on its own.

    The default value is `1048576`.

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/operations/settings/settings/#settings-max_insert_block_size).

* **Max memory usage**{#setting-max-memory-usage} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    The maximum amount of RAM (in bytes) to execute a query on a single server. This setting does not account for the amount of free memory or the total amount of a machine's memory. It applies to a single query on a single server.

    Minimum value is `0` (no limit). Default is `10737418240` (10 GB).

    If you are using [Max bytes before external `GROUP BY`](#setting-max-bytes-before-external-group-by) or [Max bytes before external sort](#setting-max-bytes-before-external-sort), we recommend setting their values to half of Max memory usage.

* **Max memory usage for user**{#setting-max-memory-usage-for-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    The maximum amount of RAM (in bytes) to execute user queries on a single server. This setting does not account for the amount of free memory or the total amount of a machine's memory.

    The restriction applies to all user queries that run concurrently within the same server, unlike [Max memory usage](#setting-max-memory-usage).

    The minimum and default value is `0` (no limitation is set).

* **Max network bandwidth**{#setting-max-network-bandwidth} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    The maximum network data transmission rate for running a single query (bytes per second).

    The minimum and default value is `0` (no limitation is set).

* **Max network bandwidth for user**{#setting-max-network-bandwidth-for-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    The maximum network data transmission rate (bytes per second). This setting applies to all concurrent user queries, unlike [Max network bandwidth](#setting-max-network-bandwidth).

    The minimum and default value is `0` (no limitation is set).

* **Max query size**{#setting-max-query-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Limits the size of the largest part of a query (in bytes) that can be transferred to RAM for parsing using the SQL parser.

    Minimum value is `1`. Default is `262144`.

* **Max replica delay for distributed queries**{#setting-max-replica-delay-for-distributed-queries} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Maximum replica delay (in milliseconds). If replica delay is greater than this setting, the replica is no longer used.

    Minimum value is `1000` (1 second). Default is `300000` (5 minutes).

    See also the [Fallback to stale replicas for distributed queries](#setting-fallback-to-stale-replicas-for-distributed-queries) setting description.

* **Max result bytes**{#setting-max-result-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    The maximum size of an uncompressed data query output (in bytes). This restriction also applies to subqueries and to parts of distributed queries that run on remote servers.

    The minimum and default value is `0` (no limitation is set).

* **Max result rows**{#setting-max-result-rows} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    The maximum number of output rows. This restriction also applies to subqueries and to parts of distributed queries that run on remote servers.

    The minimum and default value is `0` (no limitation is set).

* **Max rows in DISTINCT**{#setting-max-rows-in-distinct} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Limits the maximum number of distinct rows when using `DISTINCT`.

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

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/operations/settings/settings/#settings-max_threads).

* **Merge tree max bytes to use cache**{#setting-merge-tree-max-bytes-to-use-cache} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    The maximum size of a query (in bytes) that uses the uncompressed data cache. Queries larger than the specified value do not use the cache.

    Use this setting in combination with [Use uncompressed cache](#setting-use-uncompressed-cache).

    The default selected is `192x10x1024x1024`.

* **Merge tree max rows to use cache**{#setting-merge-tree-max-rows-to-use-cache} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    The maximum size of a query (in rows) that uses the uncompressed data cache. Queries larger than the specified value do not use the cache.

    Use this setting in combination with [Use uncompressed cache](#setting-use-uncompressed-cache).

    The default value is `128x8192`.

* **Merge tree min bytes for concurrent read**{#setting-merge-tree-min-bytes-for-concurrent-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    If the number of bytes read from a file exceeds this value, {{ CH }} will try to use multiple threads to read data from the file concurrently.

    Minimum value is `1`. Default is `24x10x1024x1024`.

* **Merge tree min rows for concurrent read**{#setting-merge-tree-min-rows-for-concurrent-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    If the number of rows read from a file exceeds this value, {{ CH }} will try to use multiple threads to read data from the file concurrently.

    Minimum value is `1`. Default is `20x8192`.

* **Min bytes to use Direct I/O**{#setting-merge-tree-min-bytes-to-use-direct-io} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    The amount of data (in bytes) required for direct reading (Direct I/O) from disk.

    By default, {{ CH }} doesn't read data directly from a disk, relying on the filesystem and its cache instead. This reading strategy is effective for small amounts of data. If a reading operation involves large amounts of data, it is more efficient to read the data directly from the disk and bypassing the filesystem cache.

    If the total amount of data stored for reading is greater than the value of this parameter, {{ CH }} will fetch the data directly from the disk.

    Minimum value and default value are `0` (direct reads disabled).

* **Min count to compile**{#setting-min-count-to-compile} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Sets the minimum count of structurally identical queries to start [compilation](#setting-compile) from.

    For a value of `0`, compilation is performed in synchronous mode: a query waits for compilation to finish then continues to run. We recommend setting this value only for testing purposes.

    For all other values, compilation is performed asynchronously in a separate thread: the result is used as soon as it's available, including by currently running queries.

    Minimum value is `0`. Default is `3`.

* **Min count to compile expression**{#setting-min-count-to-compile-expression} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Sets the minimum count of identical expressions to start [expression compilation](#setting-compile-expressions) with.

    For a value of `0`, compilation is performed in synchronous mode: an expression waits for compilation to finish then query execution continues. We recommend setting this value only for testing purposes.

    For all other values, compilation is performed asynchronously in a separate thread: the result is used as soon as it's available, including by currently running queries.

    Minimum value is `0`. Default is `3`.

* **Min INSERT block size bytes**{#setting-min-insert-block-size-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    The minimum block size (in bytes) that can be inserted into a table by an `INSERT` query. Smaller blocks [are squashed together](https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage).

    Minimum value is `0` (block squashing disabled). Default is `‭268435456‬‬` (256 MB).

* **Min INSERT block size rows**{#setting-min-insert-block-size-rows} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    The minimum block size (in rows) that can be inserted into a table by an `INSERT` query. Smaller blocks [are squashed together](https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage).

    Minimum value is `0` (block squashing disabled). Default is `1048576`.

* **Output format JSON quote denormals**{#setting-output-format-json-quote-denormals} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Determines whether to output special values for floating-point numbers (`+nan`, `-nan`, `+inf`, and `-inf`) when using JSON format for the output.

    The default value is `false`, preventing special values from being output.

* **Output format JSON quote_64bit integers**{#setting-output-format-json-quote-64bit-integers} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Defines the format of numbers in the JSON output. If this option is enabled, 64-bit integers (`UInt64` and `Int64`) are put in quotes when output in JSON to maintain compatibility with most JavaScript engines, otherwise quotes aren't used.

  By default, using quotes around 64-bit integers is disabled.

* **Priority**{#setting-priority} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Sets the priority of a query.
    * `0`: No priority is used.
    * `1`: The highest priority.
    * Other: The higher the number, the lower a query's priority.

    The parameter is set for each query individually.

    If {{ CH }} receives a query with a higher priority, execution of lower-priority queries is suspended until this incoming query is completed.

    The minimum and default value is `0`.

* **Quota mode**{#setting-quota-mode} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

    The mode used to track resources utilized when quotas are enabled:
    * `default`: Keys not used.
    * `keyed`: `quota_key` is passed in a user query parameter, and quotas are calculated individually for each key value.
    * `keyed_by_ip`: Similar to the previous one, but a user's IP address acts as the key. We recommended that you use this mode only if a user does not have a way to acquire a new IP address quickly to bypass quota restrictions, for example. This applies to both IPv4 and IPv6 addresses.

    By default, no value is set (equivalent to `default`).

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/operations/quotas/).

* **Read overflow mode**{#setting-read-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Defines {{ CH }} behavior when the amount of data read [exceeds a limit](https://{{ ch-domain }}/docs/en/operations/settings/query-complexity/#ogranicheniia-na-slozhnost-zaprosa):
    * `throw` (abort execution, return error).
    * `break` (return partial output).

    By default, the value is not set (equivalent to `throw`).

* **Readonly**{#setting-readonly} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Permissions for configuration, read, and write queries:
    * `0` (default): Allows queries of all types.
    * `1`: Allows data reads only.
    * `2`: Read data and edit settings queries are allowed.

    This setting doesn't affect running DDL queries. To enable or disable DDL queries, use the [Allow DDL](#setting-allow-ddl) setting.

    See also: [Example of creating a read-only user](../../managed-clickhouse/operations/cluster-users.md#example-create-readonly-user).

* **Receive timeout**{#setting-receive-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Receive timeout (in milliseconds).

    The default value is `300000` (5 minutes).

* **Replication ALTER partitions sync**{#setting-replication-alter-partitions-sync} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets wait mode for asynchronous actions in `ALTER ... ATTACH DETACH DROP` queries on replicated tables:
  * `0`: Do not wait.
  * `1`: Only wait for execution at its own (default).
  * `2`: Wait for every action to complete.

  For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/sql-reference/statements/alter/#sinkhronnost-zaprosov-alter).

* **Result overflow mode**{#setting-result-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Defines {{ CH }} behavior when the amount of output [exceeds a limit](https://{{ ch-domain }}/docs/en/operations/settings/query-complexity/#ogranicheniia-na-slozhnost-zaprosa):
    * `throw` (abort execution, return error).
    * `break` (return partial output).

    By default, the value is not set (equivalent to `throw`).

* **SELECT sequential consistency**{#setting-select-sequential-consistency} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Determines whether to enable sequential consistency for `SELECT` queries.

    By default, sequential consistency is disabled.

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/operations/settings/settings/#settings-select_sequential_consistency).

* **Send progress in HTTP headers**{#setting-send-progress-in-http-headers} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Enables the sending of notifications regarding query execution status using `X-ClickHouse-Progress` headers.

    By default, notifications are disabled.

* **Send timeout**{#setting-send-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Send timeout (in milliseconds).

    The default value is `300000` (5 minutes).

* **Skip unavailable shards**{#setting-skip-unavailable-shards} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Enables silent skipping of inaccessible shards. A shard is considered unavailable if none of its replicas are available.

    By default, silent skip is disabled.

* **Sort overflow mode**{#setting-sort-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Defines {{ CH }} behavior when the number of pre-sort rows received [exceeds a limit](https://{{ ch-domain }}/docs/en/operations/settings/query-complexity/#ogranicheniia-na-slozhnost-zaprosa):
    * `throw` (abort execution, return error).
    * `break` (return partial output).

    By default, the value is not set (equivalent to `throw`).

* **Timeout overflow mode**{#setting-timeout-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Defines {{ CH }} behavior when a query takes longer to run than [max_execution_time](#setting-max-execution-time):
    * `throw` (abort execution, return error).
    * `break` (return partial output).

    By default, the value is not set (equivalent to `throw`).

* **Transfer overflow mode**{#setting-transfer-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Defines {{ CH }} when the amount of data to pass to another server [exceeds a limit](https://{{ ch-domain }}/docs/en/operations/settings/query-complexity/#ogranicheniia-na-slozhnost-zaprosa):
    * `throw` (abort execution, return error).
    * `break` (return partial output).

    By default, the value is not set (equivalent to `throw`).

* **Transform null in**{#setting-transform-null-in} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

    When the compare option is enabled, `NULL = NULL` returns `true` in the `IN` operator.

    This setting is disabled by default.

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/operations/settings/settings/#transform_null_in).

* **Use uncompressed cache**{#setting-use-uncompressed-cache} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

    Determines whether to use a cache of uncompressed blocks. Using this type of cache can help significantly reduce latency and improve throughput for a large number of short queries (only for the [MergeTree](https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/mergetree/)) family. Enable this setting for users who initiate small queries frequently.

    By default, the cache is disabled.

    For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/operations/settings/settings/#setting-use_uncompressed_cache).

    See also the [Merge tree max bytes to use cache](#setting-merge-tree-max-bytes-to-use-cache) and [Merge tree max rows to use cache](#setting-merge-tree-max-rows-to-use-cache) settings.
