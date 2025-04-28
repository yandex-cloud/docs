The `name` label stores the metric name.

## Database metrics {#managed-ydb-db-metrics}
Metric name<br>Type, units | Description<br>Labels
--- | ---
`database_size`<br/>`DGAUGE`, bytes | Database size

## Resource usage metrics {#resources}

Metric name<br>Type, units | Description<br>Labels
--- | ---
`resources.storage.limit_bytes`<br>`IGAUGE`, bytes | Limit on the size of user and system data a database can store in a distributed network storage.
`resources.storage.topic.used_bytes`<br>`DGAUGE`, bytes | Topic storage size in use
`resources.storage.used_bytes`<br>`IGAUGE`, bytes | Size of user and system data stored in the distributed network storage. System data includes primary and [secondary index]({{ ydb.docs }}/concepts/secondary_indexes) data.
`resources.stream.limit_shards`<br>`DGAUGE`, count | Limit on the number of shards per stream
`resources.stream.storage.limit_bytes`<br>`DGAUGE`, bytes | Stream storage size limit
`resources.stream.storage.reserved_bytes`<br>`DGAUGE`, bytes | Reserved stream storage size
`resources.stream.throughput.limit_bytes_per_second`<br>`DGAUGE`, bytes per second | Stream throughput limit
`resources.stream.used_shards`<br>`DGAUGE`, count | Number of shards used by the stream

## API metrics {#api}

Metric name<br>Type, units | Description<br>Labels
--- | ---
`api.grpc.request.bytes`<br>`RATE`, bytes | Size of requests received by the database over a certain period of time.<br>Labels:<ul><li>`api_service`: gRPC API service name, e.g., `table`.</li><li>`method`: gRPC API service method name, e.g., `ExecuteDataQuery`.</li></ul>
`api.grpc.request.count`<br>`RATE`, count | Total DB requests.<br>Labels:<ul><li>`api_service`: gRPC API service name, e.g., `table`.</li><li>`method`: gRPC API service method name, e.g., `ExecuteDataQuery`.</li></ul>
`api.grpc.request.dropped_count`<br>`RATE`, count | Number of requests dropped at the transport (gRPC) layer due to an error.<br>Labels:<ul><li>`api_service`: gRPC API service name, e.g., `table`.</li><li>`method`: gRPC API service method name, e.g., `ExecuteDataQuery`.</li></ul>
`api.grpc.request.inflight_bytes`<br>`IGAUGE`, bytes | Size of requests concurrently handled by the database over a certain period of time.<br>Labels:<ul><li>`api_service`: gRPC API service name, e.g., `table`.</li><li>`method`: gRPC API service method name, e.g., `ExecuteDataQuery`.</li></ul>
`api.grpc.request.inflight_count`<br>`IGAUGE`, count | Number of requests concurrently handled by the database over a certain period of time.<br>Labels:<ul><li>`api_service`: gRPC API service name, e.g., `table`.</li><li>`method`: gRPC API service method name, e.g., `ExecuteDataQuery`.</li></ul>
`api.grpc.response.bytes`<br>`RATE`, bytes | Size of responses sent by the database over a certain period of time.<br>Labels:<ul><li>`api_service`: gRPC API service name, e.g., `table`.</li><li>`method`: gRPC API service method name, e.g., `ExecuteDataQuery`.</li></ul>
`api.grpc.response.count`<br>`RATE`, count | Number of responses sent by the database over a certain period of time.<br>Labels:<ul><li>`api_service`: gRPC API service name, e.g., `table`.</li><li>`method`: gRPC API service method name, e.g., `ExecuteDataQuery`.</li><li>`status`: Query execution status. For a detailed description of statuses, see [Error Handling]({{ ydb.docs }}/docs/reference/ydb-sdk/error_handling).</li></ul>
`api.grpc.response.dropped_count`<br>`RATE`, count | Number of responses dropped at the transport (gRPC) layer due to an error.<br>Labels:<ul><li>`api_service`: gRPC API service name, e.g., `table`.</li><li>`method`: gRPC API service method name, e.g., `ExecuteDataQuery`.</li></ul>
`api.grpc.response.issues`<br>`RATE`, count | Number of specific error types encountered in gRPC API responses over a specified period of time.<br>Labels:<ul><li>`issue_type`: Error type. The only value is `optimistic_locks_invalidation`. For more information about lock invalidation, see [{{ ydb-short-name }} transactions and queries]({{ ydb.docs }}/docs/concepts/secondary_indexes).</li></ul>
`api.request.completed_per_second`<br>`DGAUGE`, requests per second | API request completion rate
`api.request.latency_milliseconds`<br>`IGAUGE`, milliseconds | API latency
`api.request.latency_milliseconds_count`<br>`COUNTER`, request count | Total API requests with measured latency
`api.request.latency_milliseconds_sum`<br>`COUNTER`, milliseconds | Overall API latency
`api.request.size_bytes_per_second`<br>`DGAUGE`, bytes per second | API request processing rate
`api.response.size_bytes_per_second`<br>`DGAUGE`, bytes per second | API response processing rate
`api.units.consumed_by_method_per_second`<br>`DGAUGE`, units per second | Rate of resource consumption by a specific API method
`api.units.consumed_per_second`<br>`DGAUGE`, units per second | Overall rate of resource consumption by API methods

## Session metrics {#sessions}

Metric name<br>Type, units | Description<br>Labels
--- | ---
`table.session.active_count`<br>`IGAUGE`, count | Number of active client sessions
`table.session.closed_by_idle_count`<br>`RATE`, count | Number of sessions closed by the DB server within a specific time period due to exceeding the idle session timeout

## Transaction processing metrics {#transactions}

You can analyze transaction duration using a histogram counter. The intervals are set in milliseconds. The chart shows the number of transactions binned by duration ranges.

Metric name<br>Type, units | Description<br>Labels
--- | ---
`table.transaction.client_duration_milliseconds`<br>`HIST_RATE`, count | Number of client-side transactions of a certain duration. The duration is the client-side wait time between sending individual requests within a single transaction. It does not include the time it takes for the server to process those requests.<br>Labels:<ul><li>`tx_kind`: Transaction type. Possible values are `read_only`, `read_write`, `write_only`, or `pure`.</li></ul>
`table.transaction.server_duration_milliseconds`<br>`HIST_RATE`, count | Number of server-side transaction of a certain duration. The duration is the time it takes for the server to process requests within a transaction. It does not include the client-side wait time between sending individual requests within a single transaction.<br>Labels:<ul><li>`tx_kind`: Transaction type. Possible values are `read_only`, `read_write`, `write_only`, or `pure`.</li></ul>
`table.transaction.total_duration_milliseconds`<br>`HIST_RATE`, count | Number of transactions of a certain duration on both the server and the client. The duration of a transaction is the time interval from the transaction start (explicit or implicit) to either commit or rollback. It includes the server-side transaction processing time and the client-side wait time between sending different requests within a single transaction.<br>Labels:<ul><li>`tx_kind`: Transaction type. Possible values are `read_only`, `read_write`, `write_only`, or `pure`.</li></ul>

## Query processing metrics {#queries}

Metric name<br>Type, units | Description<br>Labels
--- | ---
`table.query.compilation.latency_milliseconds`<br>`HIST_RATE`, count | Histogram counter. The intervals are set in milliseconds. It shows the number of successful table query compilations binned by latency ranges.
`table.query.compilation.active_count`<br>`IGAUGE`, count | Number of active compilations
`table.query.compilation.count`<br>`RATE`, count | Number of compilations completed successfully over a certain time period
`table.query.compilation.error_count`<br>`RATE`, count | Number of compilations failed over a certain time period
`table.query.compilation.cache_hits`<br>`RATE`, count | Number of queries over a certain period of time with no compilation needed due to a pre-existing plan in the prepared query cache
`table.query.compilation.cache_misses`<br>`RATE`, count | Number of queries requiring compilation over a certain period of time
`table.query.execution.latency_milliseconds`<br>`HIST_RATE`, count | Histogram counter. The intervals are set in milliseconds. It shows the number of queries binned by execution time ranges.
`table.query.request.bytes`<br>`RATE`, bytes | Size of YQL query strings and parameter values for queries that entered the database over a certain period of time.
`table.query.request.parameters_bytes`<br>`RATE`, bytes | Size of parameters for queries that entered the database database over a certain period of time.
`table.query.response.bytes`<br>`RATE`, bytes | Size of responses sent by the database over a certain period of time

## Table partition metrics (DataShards) {#datashards}

Metric name<br/>Type, unit | Description<br>Labels
--- | ---
`table.datashard.bulk_upsert.bytes`<br>`RATE`, bytes | Size of data added through the `BulkUpsert` gRPC API call to all partitions of all DB tables over a certain period of time
`table.datashard.bulk_upsert.rows`<br>`RATE`, count | Number of rows added through the `BulkUpsert` gRPC API call to all partitions of all DB tables over a certain period of time
`table.datashard.erase.bytes`<br>`RATE`, bytes | Size of data deleted from the database over a certain period of time
`table.datashard.erase.rows`<br>`RATE`, count | Number of rows deleted from the database over a certain period of time
`table.datashard.read.bytes`<br>`RATE`, bytes | Size of data read by all partitions of all DB tables over a certain period of time
`table.datashard.read.rows`<br>`RATE`, count | Number of rows read by all partitions of all DB tables over a certain period of time
`table.datashard.row_count`<br>`GAUGE`, count | Number of rows in DB tables
`table.datashard.scan.bytes`<br>`RATE`, bytes | Size of data read through the `StreamExecuteScanQuery` or `StreamReadTable` gRPC API calls by all partitions of all DB tables over a certain period of time
`table.datashard.scan.rows`<br>`RATE`, count | Number of rows read through the `StreamExecuteScanQuery` or `StreamReadTable` gRPC API calls by all partitions of all DB tables over a certain period of time
`table.datashard.size_bytes`<br>`GAUGE`, bytes | Size of data in DB tables
`table.datashard.used_core_percents`<br>`HIST_GAUGE`, % | Histogram counter. The intervals are set as a percentage. It shows the number of table partitions binned by computing resource usage percentage.
`table.datashard.write.rows`<br>`RATE`, count | Number of rows written by all partitions of all DB tables over a certain period of time
`table.datashard.write.bytes`<br>`RATE`, bytes | Size of data written by all partitions of all DB tables over a certain period of time

## Table partition metrics (ColumnShards) {#columnshards}

Metric name<br/>Type, unit | Description<br>Labels
--- | ---
`table.columnshard.bulk_upsert.bytes`<br>`RATE`, bytes per second | Size of data added through the `BulkUpsert` gRPC API call to all partitions of all DB tables over a certain period of time
`table.columnshard.bulk_upsert.rows`<br>`RATE`, rows per second | Number of rows added through the `BulkUpsert` gRPC API call to all partitions of all DB tables over a certain period of time
`table.columnshard.scan.bytes`<br>`RATE`, bytes per second | Size of data read through the `StreamExecuteScanQuery` or `StreamReadTable` gRPC API calls by all partitions of all DB tables over a certain period of time
`table.columnshard.scan.rows`<br>`RATE`, rows per second | Number of rows read through the `StreamExecuteScanQuery` or `StreamReadTable` gRPC API calls by all partitions of all DB tables over a certain period of time

## Resource usage metrics (for Dedicated mode only) {#ydb_dedicated_resources}

Metric name<br>Type<br>units | Description<br>Labels
--- | ---
`resources.cpu.limit_core_percents`<br>`IGAUGE`, % | Percentage of CPU available to a database. For example, for a database that has three nodes with four cores in `pool=user` per node, the value of this metric will be `1200`.<br>Labels:<ul><li>`pool`: Computing pool. Possible values are `user`, `system`, `batch`, `io`, or `ic`.</li></ul>
`resources.cpu.used_core_percents`<br>`RATE`, % | CPU usage. If the value is `100`, one of the cores is being 100% used. The value may be greater than `100` for multi-core configurations.<br>Labels:<ul><li>`pool`: Computing pool. Possible values are `user`, `system`, `batch`, `io`, or `ic`.</li></ul>
`resources.memory.limit_bytes`<br>`IGAUGE`, bytes | RAM available to database nodes
`resources.memory.used_bytes`<br>`IGAUGE`, bytes | RAM used by database nodes

## Query processing metrics (for Dedicated mode only) {#ydb_dedicated_queries}

Metric name<br>Type<br>units | Description<br>Labels
--- | ---
`table.query.compilation.cache_evictions`<br>`RATE`, count | Number of queries evicted from the [prepared query]({{ ydb.docs }}/docs/reference/ydb-sdk/example/#param-queries) cache over a certain period of time
`table.query.compilation.cache_size_bytes`<br>`IGAUGE`, bytes | Prepared query cache size (memory used)
`table.query.compilation.cached_query_count`<br>`IGAUGE`, count | Prepared query cache size (compiled query plans)
