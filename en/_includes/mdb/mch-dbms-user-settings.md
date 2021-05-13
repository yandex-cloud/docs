- **Add HTTP CORS header**{#setting-add-http-cors-header} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Adds CORS header in HTTP responses.

  By default, no CORS header is included in HTTP responses.

- **Allow DDL**{#setting-allow-ddl} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Allows or bans DDL queries (for example, `CREATE`, `ALTER`, `RENAME`, and so on).

  By default, DDL queries are allowed.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/permissions-for-queries/#settings_allow_ddl).

  See also: the [Readonly](#setting-readonly) setting.

- **Compile**{#setting-compile} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Enables or disables query compilation. If you run a large number of structurally identical queries with compilation enabled, such queries can be executed faster by using compiled query parts.

  Use this setting in combination with the [Min count to compile](#setting-min-count-to-compile) setting.

  Compilation is disabled by default.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#compile).

- **Compile expressions**{#setting-compile-expressions} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Enables or disables expression compilation. If you run a large number of queries that use identical expressions with compilation enabled, such queries can be executed faster by using compiled expressions.

  Use this setting in combination with the [Min count to compile expression](#setting-min-count-to-compile-expression) setting.

  Expression compilation is disabled by default.

- **Connect timeout**{#setting-connect-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the connection timeout in milliseconds.

  The value must be greater than zero (default: `10000`, 10 seconds).

- **DISTINCT overflow mode**{#setting-distinct-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines the {{ CH }} behavior when running the `SELECT DISTINCT` [query exceeds the limits](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#ogranicheniia-na-slozhnost-zaprosa): `throw` (abort the query execution and return an error) or `break` (return a partial result).

  By default, not selected (equivalent to `throw`).

- **Distributed aggregation memory efficient**{#setting-distributed-aggregation-memory-efficient} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Enables or disables memory saving mode when doing distributed aggregation.

  Under distributed query processing, [external aggregation](#setting-max-bytes-before-external-group-by) is done on remote servers. Enable this setting to achieve a smaller memory footprint on the server that sourced such a distributed query.

  By default, memory saving mode is disabled.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory).

- **Distributed product mode**{#setting-distributed-product-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Changes the behavior of distributed subqueries when a query contains the product of distributed tables:
  - `deny`: Bans the use of such subqueries.
  - `local`: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal `IN/JOIN`.
  - `global`: Replaces the `IN/JOIN` query with the `GLOBAL IN/GLOBAL JOIN` one.
  - `allow`: Allows the use of such subqueries.

  By default, not selected (equivalent to `deny`).

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#distributed-product-mode).

- **Empty result for aggregation by empty set**{#setting-empty-result-for-aggregation-by-empty-set} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines the returned result format when doing data aggregation with no keys (without `GROUP BY`) for an empty set (for example, `SELECT count(*) FROM table WHERE 0`):
  - Disabled (default): {{ CH }} returns a single-line result consisting of `NULL` values for aggregation functions, in accordance with SQL standard.
  - Enabled: {{ CH }} returns an empty result.

- **Enable HTTP compression**{#setting-enable-http-compression} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Enables or disables data compression in HTTP responses.

  By default, {{ CH }} stores data in a compressed format. When executing a query, its result is uncompressed. Use this setting to command {{ CH }} to compress the result when sending it via HTTP.

  Enable this setting and add the `Accept-Encoding: <compression method>` header in a request to force compression of a response from {{ CH }}.

  ClickHouse supports the following compression methods: `gzip`, `br`, and `deflate`.

  By default, data compression in HTTP responses is disabled.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/interfaces/http/).

- **Fallback to stale replicas for distributed queries**{#setting-fallback-to-stale-replicas-for-distributed-queries} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Enables or disables query forcing to a stale replica in case the actual data is unavailable. {{ CH }} will choose the most up-to-date replica and force the query to use the data in this replica. This setting can be used when executing a `SELECT` query from a distributed table that points to replicated tables.

  By default, query forcing is enabled.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries).

  See also the [Max replica delay for distributed queries](#setting-max-replica-delay-for-distributed-queries) setting.

- **Force index by date**{#setting-force-index-by-date} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Disables queries if you can't use an index by date. Works with tables of the MergeTree family.

  Disabled by default (queries are allowed).

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-force_index_by_date).

- **Force primary key**{#setting-force-primary-key} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Disables queries if you can't use an index by primary key. Works with tables of the MergeTree family.

  Disabled by default (queries are allowed).

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-force_primary_key).

- **GROUP BY overflow mode**{#setting-group-by-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines the {{ CH }} behavior when the number of unique keys during aggregation [exceeds the limit](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#ogranicheniia-na-slozhnost-zaprosa):
  - `throw`: Abort query execution and return an error.
  - `break`: Return a partial result.
  - `any`: Perform a `GROUP BY` approximately. The quality of this approximate calculation depends heavily on the statistical properties of the data.

  By default, not selected (equivalent to `throw`).

- **GROUP BY two level threshold**{#setting-group-by-two-level-threshold} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the threshold of the number of keys, after which two-level aggregation should be used.

  If `0`, no threshold is set (default: `10000`).

- **GROUP BY two level threshold bytes**{#setting-group-by-two-level-threshold-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the threshold of the number of bytes, after which two-level aggregation should be used.

  If `0`, no threshold is set (default: `100000000`).

- **HTTP connection timeout**{#setting-http-connection-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the HTTP connection timeout in milliseconds.

  The value must be greater than 0 (default: `1000`, 1 second).

- **HTTP headers progress interval**{#setting-http-headers progress interval} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the minimum interval between progress notifications with the `X-ClickHouse-Progress` HTTP header, in milliseconds.

  The value must be greater than zero (default: `100`).

- **HTTP receive timeout**{#setting-http-receive-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the HTTP receive timeout in milliseconds.

  The value must be greater than zero (default: `1800000`, 1800 seconds, 30 minutes).

- **HTTP send timeout**{#setting-http-send-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the HTTP send timeout in milliseconds.

  The value must be greater than zero (default: `1800000`, 1800 seconds, 30 minutes).

- **Input format defaults for omitted fields**{#setting-input-format-defaults-for-omitted-fields} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Enables or disables replacing omitted input values with default values of the respective columns when performing `INSERT` queries.

  By default, replacement is enabled.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#session_settings-input_format_defaults_for_omitted_fields).

- **Input format values interpret expressions**{#setting-input-format-values-interpret-expressions} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Enables or disables the SQL parser if the fast stream parser can't parse the data. Enable this setting if the data that you want to insert into a table contains SQL expressions.

  For example, when inserting a value that contains the `now()` expression into a table, the stream parser won't be able to interpret and parse this expression. With the SQL parser enabled, the expression will be interpreted and parsed correctly and the SQL function result will be inserted as the `now()` value (current date and time).

  This option is only used when inserting data of the [Values](https://clickhouse.tech/docs/en/interfaces/formats/#data-format-values) format.

  By default, the SQL parser is enabled.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions).

- **Insert quorum**{#setting-insert-quorum} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Enables or disables write quorum for a {{ CH }} cluster:
  - If the value is less than `2`, write quorum is disabled.
  - If the value is greater than or equal to `2`, write quorum is enabled.

  When used, write quorum guarantees that {{ CH }} wrote data to the quorum of Insert quorum replicas correctly within the [Insert quorum timeout](#setting-insert-quorum-timeout). All replicas in the quorum are in the consistent state, meaning that they contain linearized data from the previous `INSERT` queries. Employ write quorum to make sure that the written data won't be lost if one or more replicas fail.

  You can use the [Select sequential consistency](#setting-select-sequential-consistency) setting to read data written with Insert quorum.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-insert_quorum).

- **Insert quorum timeout**{#setting-insert-quorum-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the [insert quorum](#setting-insert-quorum) timeout in milliseconds. If the timeout expired and no write took place, {{ CH }} aborts the `INSERT` query execution, returns an error, and the client must repeat the query to insert the data block into the same or another replica.

  The minimum value is `1000` (1 second). The default is `60000` (1 minute).

- **Join use nulls**{#setting-join-use-nulls} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

   Sets the behavior type for `JOIN`. When tables are merged, blank cells may appear. If this option is enabled, the added field changes the type to `Nullable`, and the blank cell is filled with the `NULL` value. Otherwise, the blank cell is filled with the default value for this field type.

  By default, this option is disabled.

  To learn more, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#join_use_nulls).

- **Joined subquery requires alias**{#setting-joined-subquery-requires-alias} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Requires aliases for subqueries when executing the `JOIN` command.

  If the setting is enabled, this request is not executed:

  ```sql
  SELECT col1, col2 FROM table1 JOIN (SELECT col3 FROM table2)
  ```

  The request with the specified alias is successfully executed:

  ```sql
  SELECT col1, col2 FROM table1 JOIN (SELECT col3 FROM table2) AS MyQuery
  ```

  By default, this option is disabled.

- **Low cardinality allow in native format**{#setting-low-cardinality-allow-in-native-format} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines whether to use LowCardinality type in native format.
  - Enabled: Yes, use it.
  - Disabled: Convert LowCardinality columns to regular columns when doing a `SELECT` query, and convert regular columns to LowCardinality when doing an `INSERT` query.

  LowCardinality columns (aka sparse columns) store data in a more effective way, compared to regular columns, by using hash tables. If data for insertion suits this storage format, {{ CH }} will place them into the LowCardinality column.

  If you use a third-party {{ CH }} client that can't work with LowCardinality columns, this client won't be able to correctly interpret the result of the query that asks for data stored in the LowCardinality column. Disable this setting to convert LowCardinality columns to regular columns when creating the result, so that such clients can process the result.

  The official {{ CH }} client works with LowCardinality columns out of the box.

  This option is enabled by default.

- **Max AST depth**{#setting-max-ast-depth} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum depth of the query syntax tree.

  Executing a big and complex query may result in building a syntax tree of enormous depth. You can use this setting to ban over-sized or non-optimized queries for huge tables.

  For example, a `SELECT *` query will mostly result in a deeper and more complex syntax tree than a `SELECT ... WHERE ...` query containing constraints and conditions. A user can be forced to construct more optimized queries if this setting is used.

  The value must be greater than zero (default: `1000`). If a too small value is set, it may render ClickHouse unable to execute even simple queries.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#max-ast-depth).

- **Max AST elements**{#setting-max-ast-elements} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum size of the query syntax tree in number of nodes.

  Executing a big and complex query may result in building a syntax tree of enormous size. You can use this setting to ban over-sized or non-optimized queries for huge tables.

  The value must be greater than zero (default: `50000`). If a too small value is set, it may render ClickHouse unable to execute even simple queries.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#max-ast-elements).

- **Max block size**{#setting-max-block-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Data in {{ CH }} is processed by blocks (a block is a set of column parts). The internal processing cycles for a single block are efficient enough, but there are noticeable expenditures on each block. This setting is a recommendation for the size of a block (in the number of rows) that should be loaded from tables.

  The value must be greater than zero (default: `65536`).

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#setting-max_block_size).

- **Max bytes before external `GROUP BY`**{#setting-max-bytes-before-external-group-by} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the threshold of RAM consumption (in bytes). After that, the temporary data collected during the `GROUP BY` operation should be flushed to disk to limit the RAM consumption.

  By default, aggregation is done by employing a hash table that resides in RAM. If a query requires aggregation of large amounts of data that can lead to memory exhaustion and abortion of the query (see the [Max memory usage](#setting-max-memory-usage) setting), use this setting to force {{ CH }} to flush the data to disk and make sure the aggregation is successful.

  The minimum and default value is `0` (`GROUP BY` in the external memory is disabled).

  When using aggregation in the external memory, we recommend setting the value of this setting twice as low as the [Max memory usage](#setting-max-memory-usage) setting value (by default, the maximum memory usage is limited to 10 GB).

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory).

  See also the [Distributed aggregation memory efficient](#setting-distributed-aggregation-memory-efficient) setting.

- **Max bytes before external sort**{#setting-max-bytes-before-external-sort} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   This setting is similar to the [previous](#setting-max-bytes-before-external-group-by) setting, except that it is used for the sorting operation (`ORDER BY`).

- **Max bytes in DISTINCT**{#setting-max-bytes-in-distinct} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum size of a hash table in bytes (uncompressed data) when using `DISTINCT`.

  The minimum and default value is `0` (no limitation is set).

- **Max bytes to read**{#setting-max-bytes-to-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query.

  The minimum and default value is `0` (no limitation is set).

- **Max bytes to sort**{#setting-max-bytes-to-sort} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum number of bytes (uncompressed data) that can be read from a table for sorting. Helps reduce RAM consumption during sorting.

  The minimum and default value is `0` (no limitation is set).

- **Max bytes to transfer**{#setting-max-bytes-to-transfer} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary table when using `GLOBAL IN`.

  The minimum and default value is `0` (no limitation is set).

- **Max columns to read**{#setting-max-columns-to-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum number of columns that can be read from a table in a single query. If the query must read more columns to complete, it will be aborted.

  The minimum and default value is `0` (no limitation is set).

- **Max execution time**{#setting-max-execution-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum query execution time in milliseconds. Currently, this limitation is not checked when passing one of the sorting stages, as well as merging and finalizing aggregation functions.

  The minimum and default value is `0` (no limitation is set).

- **Max expanded AST elements**{#setting-max-expanded-ast-elements} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum size of the query syntax tree in number of nodes after expansion of aliases and the asterisk values.

  Executing a big and complex query may result in building a syntax tree of enormous size. You can use this setting to ban over-sized or non-optimized queries for huge tables.

  The value must be greater than zero (default: `500000`). If a too small value is set, it may render ClickHouse unable to execute even simple queries.

- **Max INSERT block size**{#setting-max-insert-block-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Allows creating blocks of the specified size (in bytes) when inserting data in a table. This setting is effective only if the server creates such blocks on its own.

  The value must be greater than zero (default: `1048576`).

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-max_insert_block_size).

- **Max memory usage**{#setting-max-memory-usage} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum memory usage (in bytes) for processing a single query on a single server. This setting doesn't take the server's free RAM or total RAM into account. This limitation is enforced for a single query on a single server.

  The minimum value is `0` (no limitation is set). The value set in the default config file is `10737418240` (10 GB).

  If you also use the [Max bytes before external `GROUP BY`](#setting-max-bytes-before-external-group-by) or [Max bytes before external sort](#setting-max-bytes-before-external-sort) setting, we recommend that their values are half the Max memory usage value.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#settings_max_memory_usage).

- **Max memory usage for user**{#setting-max-memory-usage-for-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum memory usage (in bytes) for processing a user's queries on a single server. This setting doesn't take the server's free RAM or total RAM into account. This limitation is enforced for all user queries that run simultaneously on a single server.

  The minimum and default value is `0` (no limitation is set).

- **Max network bandwidth**{#setting-max-network-bandwidth} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum speed of data exchange over the network in bytes per second for a query.

  The minimum and default value is `0` (no limitation is set).

- **Max network bandwidth for user**{#setting-max-network-bandwidth-for-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  The maximum speed of data exchange over the network in bytes per second. This setting, unlike the previous one, affects all concurrently running user queries.

  The minimum and default value is `0` (no limitation is set).

- **Max query size**{#setting-max-query-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the size of the part of a query that can be transferred to RAM for parsing with the SQL parser, in bytes.

  The value must be greater than zero (default: `262144`).

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-max_query_size).

- **Max replica delay for distributed queries**{#setting-max-replica-delay-for-distributed-queries} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used.

  The minimum value is `1000` (one second). The default value is `300000` (300 seconds, or 5 minutes).

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries).

  See also the [Fallback to stale replicas for distributed queries](#setting-fallback-to-stale-replicas-for-distributed-queries) setting description.

- **Max result bytes**{#setting-max-result-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the number of uncompressed bytes in the result. This limitation is also checked for subqueries and on remote servers when executing part of a distributed query.

  The minimum and default value is `0` (no limitation is set).

- **Max result rows**{#setting-max-result-rows} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the number of rows in the result. This limitation is also checked for subqueries and on remote servers when executing part of a distributed query.

  The minimum and default value is `0` (no limitation is set).

- **Max rows in DISTINCT**{#setting-max-rows-in-distinct} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum number of different rows when using `DISTINCT`.

  The minimum and default value is `0` (no limitation is set).

- **Max rows to group by**{#setting-max-rows-to-group-by} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum number of unique keys received from the aggregation function. This setting helps reduce RAM consumption during aggregation.

  The minimum and default value is `0` (no limitation is set).

- **Max rows to read**{#setting-max-rows-to-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum number of rows that can be read from a table when running a query.

  The minimum and default value is `0` (no limitation is set).

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#max-rows-to-read).

- **Max rows to sort**{#setting-max-rows-to-sort} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum number of rows to sort. Helps reduce RAM consumption during sorting.

  The minimum and default value is `0` (no limitation is set).

- **Max rows to transfer**{#setting-max-rows-to-transfer} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using `GLOBAL IN`.

  The minimum and default value is `0` (no limitation is set).

- **Max temporary columns**{#setting-max-temporary-columns} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns.

  The minimum and default value is `0` (no limitation is set).

- **Max temporary non const columns**{#setting-max-temporary-non-const-columns} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query (excluding constant columns).

  The minimum and default value is `0` (no limitation is set).

- **Max threads**{#setting-max-threads} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum number of query processing threads (excluding threads that read data from remote servers). This setting applies to threads that perform the same stages of the query processing pipeline in parallel.

  The minimum and default value is `0` (the number of threads is calculated automatically based on the number of physical CPU cores, excluding HyperThreading cores).

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-max_threads).

- **Merge tree max bytes to use cache**{#setting-merge-tree-max-bytes-to-use-cache} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum size in bytes of the request that can use the cache of uncompressed data. The cache isn't used for queries larger than the specified value.

  Use this setting in combination with the [Use uncompressed cache](#setting-use-uncompressed-cache) setting.

  The value must be greater than zero (default: 192x10x1024x1024).

- **Merge tree max rows to use cache**{#setting-merge-tree-max-rows-to-use-cache} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the maximum size in rows of the request that can use the cache of uncompressed data. The cache isn't used for queries larger than the specified value.

  Use this setting in combination with the [Use uncompressed cache](#setting-use-uncompressed-cache) setting.

  The value must be greater than zero (default: 128x8192).

- **Merge tree min bytes for concurrent read**{#setting-merge-tree-min-bytes-for-concurrent-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the number of bytes to be read from a file to enable concurrent read. If the number of bytes to read exceeds this value, {{ CH }} will try to use a few threads to read data from the file concurrently.

  The value must be greater than zero (default: 24x10x1024x1024).

- **Merge tree min rows for concurrent read**{#setting-merge-tree-min-rows-for-concurrent-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the minimum number of rows to be read from a file to enable concurrent read. If the number of rows to read exceeds this value, {{ CH }} will try to use a few threads to read data from the file concurrently.

  The value must be greater than zero (default: 20x8192).

- **Min bytes to use Direct I/O**{#setting-merge-tree-min-bytes-to-use-direct-io} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the minimum number of bytes to enable unbuffered direct reads from disk (Direct I/O). {{ CH }} uses this parameter when reading data from tables.

  By default, {{ CH }} doesn't read data directly from disk, but relies on the filesystem and its cache instead. This reading strategy is effective for small amounts of data. If the amount of the data to read is large, it is more effective to read it directly from the disk, bypassing the filesystem cache.

  If the total amount of data to read is greater than this setting value, {{ CH }} will fetch the data directly from the disk.

  The minimum and default value is `0`, direct I/O is disabled.

- **Min count to compile**{#setting-min-count-to-compile} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the minimum count of structurally identical queries to start [compilation](#setting-compile) from.

  The minimum value is `0`. The default is `3`.

  For the `0` value, compilation is synchronous: a query waits for the compilation process to complete before continuing execution. We recommend setting this value only for testing purposes.

  For all other values, compilation is performed asynchronously in a separate thread: the result is used as soon as it's available, including by currently running queries.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#min-count-to-compile).

- **Min count to compile expression**{#setting-min-count-to-compile-expression} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the minimum count of identical expressions to start [expression compilation](#setting-compile-expressions) with.

  The minimum value is `0`. The default is `3`.

  For the `0` value, compilation is synchronous: an expression waits for the compilation process to complete before continuing query execution. We recommend setting this value only for testing purposes.

  For all other values, compilation is performed asynchronously in a separate thread: the result is used as soon as it's available, including by currently running queries.

- **Min INSERT block size bytes**{#setting-min-insert-block-size-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the minimum number of bytes in a block to be inserted in a table by an `INSERT` query. Blocks that are smaller than the specified value are merged into larger blocks.

  The minimum value is `0` (block merging is disabled). The default is `‭268435456‬‬` (256 MB).

- **Min INSERT block size rows**{#setting-min-insert-block-size-rows} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Limits the minimum number of rows in a block to be inserted in a table by an `INSERT` query. Blocks that are smaller than the specified value are merged into larger blocks.

The minimum value is `0` (block merging is disabled). The default is `1048576`.

- **Output format JSON quote denormals**{#setting-output-format-json-quote-denormals} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Enables or disables special floating-point values (`+nan`, `-nan`, `+inf`, and `-inf`) in JSON output format.

  By default, special values are not output.

- **Output format JSON quote_64bit integers**{#setting-output-format-json-quote-64bit-integers} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Defines the format of numbers in the JSON output. If this option is enabled, 64-bit integers (`UInt64` and `Int64`) are put in quotes when output in JSON to maintain compatibility with most JavaScript engines, otherwise quotes aren't used.

  By default, using quotes around 64-bit integers is disabled.

- **Priority**{#setting-priority} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the priority of a query.
  - `0`: No priority is used.
  - `1`: The highest priority.
  - Other: The higher the number, the lower a query's priority.

  This setting should be set up for each query individually.

  If {{ CH }} is handling high-priority queries and a low-priority query enters, the low-priority query is paused until the higher-priority queries are completed.

  The minimum and default value is `0`.

- **Quota mode**{#setting-quota-mode} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Sets the mode to account for resources consumed when quotas are enabled:
  - `Default`: The default mode, no keys are used.
  - `Keyed`: The `quota_key` is passed in the user query parameter, and the quota is counted separately for each key value.
  - `Keyed_by_ip`: Similar to the previous one, except that the user's IP acts as the key (note that the user can easily change the IPv6 address).

  By default, not selected (equivalent to `default`).

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/quotas/).

- **Read overflow mode**{#setting-read-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines the {{ CH }} behavior when the amount of data read [exceeds one of the limits](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#ogranicheniia-na-slozhnost-zaprosa). Either `throw` (abort execution and return an error) or `break` (return a partial result).

  By default, not selected (equivalent to `throw`).

- **Readonly**{#setting-readonly} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Enables or disables queries to read data, write data, and edit parameters:
  - `0`: Any types of queries are allowed without limitations (default).
  - `1`: Only read data queries are allowed.
  - `2`: Read data and edit settings queries are allowed.

  This setting doesn't affect running DDL queries. To enable or disable DDL queries, use the [Allow DDL](#setting-allow-ddl) setting.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/permissions-for-queries/#settings_readonly).

  See also: [Example of creating a read-only user](../../managed-clickhouse/operations/cluster-users.md#example-create-readonly-user).

- **Receive timeout**{#setting-receive-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the receive timeout in milliseconds.

  The value must be greater than zero (default: `300000`, 300 seconds, or 5 minutes).

- **Replication ALTER partitions sync**{#setting-replication-alter-partitions-sync} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets wait mode for asynchronous actions in `ALTER ... ATTACH DETACH DROP` queries on replicated tables:
  - `0`: Do not wait.
  - `1`: Only wait for execution at its own (default).
  - `2`: Wait for every action to complete.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/sql-reference/statements/alter/#sinkhronnost-zaprosov-alter).

- **Result overflow mode**{#setting-result-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines the {{ CH }} behavior when the amount of results exceeds one of the limits. Either `throw` (abort execution and return an error) or `break` (return a partial result).

  By default, not selected (equivalent to `throw`).

- **SELECT sequential consistency**{#setting-select-sequential-consistency} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Enables or disables sequential consistency for `SELECT` queries.

  By default, sequential consistency is disabled.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-select_sequential_consistency).

- **Send progress in HTTP headers**{#setting-send-progress-in-http-headers} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Enables or disables progress notifications using `X-ClickHouse-Progress` headers.

  By default, notifications are disabled.

- **Send timeout**{#setting-send-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Sets the send timeout in milliseconds.

  The value must be greater than zero (default: `300000`, 300 seconds, or 5 minutes).

- **Skip unavailable shards**{#setting-skip-unavailable-shards} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Enables or disables silent skip of unavailable shards (a shard is considered unavailable if all of its replicas are unavailable).

  By default, silent skip is disabled.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#settings-skip_unavailable_shards).

- **Sort overflow mode**{#setting-sort-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines the {{ CH }} behavior when the amount of rows received before sorting [exceeds one of the limits](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#ogranicheniia-na-slozhnost-zaprosa). Either `throw` (abort execution and return an error) or `break` (return a partial result).

  By default, not selected (equivalent to `throw`).

- **Timeout overflow mode**{#setting-timeout-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

   Determines the {{ CH }} behavior when query execution exceeds the `max_execution_time`. Either `throw` (abort execution and return an error) or `break` (return a partial result).

  By default, not selected (equivalent to `throw`).

- **Transfer overflow mode**{#setting-transfer-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines the {{ CH }} behavior when the amount of data to transfer to another server [exceeds one of the limits](https://clickhouse.tech/docs/en/operations/settings/query-complexity/#ogranicheniia-na-slozhnost-zaprosa). Either `throw` (abort execution and return an error) or `break` (return a partial result).

  By default, not selected (equivalent to `throw`).

- **Transform null in**{#setting-transform-null-in} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  When the compare option is enabled, `NULL = NULL` returns `true` in the `IN` operator.

  By default, this option is disabled (the comparison returns `false` in the `IN` operator).

  To learn more, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#transform_null_in).

- **Use uncompressed cache**{#setting-use-uncompressed-cache} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Determines whether to use the cache of uncompressed blocks. Using this cache (only for MergeTree tables) may significantly reduce latency and increase throughput when a large amount of small queries is to be processed. Enable this setting for users who initiate small queries frequently.

  By default, the uncompressed cache is disabled.

  For more information, see the [documentation for {{ CH }}](https://clickhouse.tech/docs/en/operations/settings/settings/#setting-use_uncompressed_cache).

  See also the [Merge tree max bytes to use cache](#setting-merge-tree-max-bytes-to-use-cache) and [Merge tree max rows to use cache](#setting-merge-tree-max-rows-to-use-cache) settings.

