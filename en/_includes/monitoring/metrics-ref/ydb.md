The metric name is written in the `name` label.

## DB metrics {#managed-ydb-db-metrics}
| Metric name<br>Type, unit | Description<br>Labels |
--- | ---
| `database_size`<br/>`DGAUGE`, bytes | Database size |

## Resource usage metrics {#resources}

| Metric name<br>Type, unit | Label<br>description |
--- | ---
| `resources.storage.limit_bytes`<br>`IGAUGE`, bytes | Limit on the size of user and service data that a database can store in distributed network storage. |
| `resources.storage.topic.used_bytes`<br>`DGAUGE`, bytes | Topic storage size in use |
| `resources.storage.used_bytes`<br>`IGAUGE`, bytes | Size of user and service data stored in the distributed network storage. Service data includes the data from the primary and [secondary indexes](https://ydb.tech/en/docs/concepts/secondary_indexes). |
| `resources.stream.limit_shards`<br>`DGAUGE`, number | Limit on the number of shards per stream |
| `resources.stream.storage.limit_bytes`<br>`DGAUGE`, bytes | Stream storage size limit |
| `resources.stream.storage.reserved_bytes`<br>`DGAUGE`, bytes | Reserved stream storage size |
| `resources.stream.throughput.limit_bytes_per_second`<br>`DGAUGE`, bytes/s | Stream throughput limit |
| `resources.stream.used_shards`<br>`DGAUGE`, number | Number of shards used by the stream |

## API metrics {#api}

| Metric name<br>Type, unit | Label<br>description |
--- | ---
| `api.grpc.request.bytes`<br>`RATE`, bytes | Size of queries received by the database over a certain period of time.<br>Labels:<ul><li>`api_service`: gRPC API service name, e.g., `table`.</li><li>`method`: Name of the gRPC API service method, e.g., `ExecuteDataQuery`.</li></ul> |
| `api.grpc.request.count`<br>`RATE`, number | Total number of DB queries.<br>Labels:<ul><li>`api_service`: gRPC API service name, e.g., `table`.</li><li>`method`: Name of the gRPC API service method, e.g., `ExecuteDataQuery`.</li></ul> |
| `api.grpc.request.dropped_count`<br>`RATE`, number | Number of queries dropped at the transport (gRPC) layer due to an error.<br>Labels:<ul><li>`api_service`: gRPC API service name, e.g., `table`.</li><li>`method`: Name of the gRPC API service method, e.g., `ExecuteDataQuery`.</li></ul> |
| `api.grpc.request.inflight_bytes`<br>`IGAUGE`, bytes | Size of queries concurrently handled by the database over a certain period of time.<br>Labels:<ul><li>`api_service`: gRPC API service name, e.g., `table`.</li><li>`method`: Name of the gRPC API service method, e.g., `ExecuteDataQuery`.</li></ul> |
| `api.grpc.request.inflight_count`<br>`IGAUGE`, number | Number of queries concurrently handled by the database over a certain period of time.<br>Labels:<ul><li>`api_service`: gRPC API service name, e.g., `table`.</li><li>`method`: Name of the gRPC API service method, e.g., `ExecuteDataQuery`.</li></ul> |
| `api.grpc.response.bytes`<br>`RATE`, bytes | Size of responses sent by the database over a certain period of time.<br>Labels:<ul><li>`api_service`: gRPC API service name, e.g., `table`.</li><li>`method`: Name of the gRPC API service method, e.g., `ExecuteDataQuery`.</li></ul> |
| `api.grpc.response.count`<br>`RATE`, number | Number of responses sent by the database over a certain period of time.<br>Labels:<ul><li>`api_service`: gRPC API service name, e.g., `table`.</li><li>`method`: Name of the gRPC API service method, e.g., `ExecuteDataQuery`.</li><li>`status`: Query execution status; for more information about statuses, see [Handling errors](https://ydb.tech/en/docs/reference/ydb-sdk/error_handling).</li></ul> |
| `api.grpc.response.dropped_count`<br>`RATE`, number | Number of responses dropped at the transport (gRPC) layer due to an error.<br>Labels:<ul><li>`api_service`: gRPC API service name, e.g., `table`.</li><li>`method`: Name of the gRPC API service method, e.g., `ExecuteDataQuery`.</li></ul> |
| `api.grpc.response.issues`<br>`RATE`, number | Number of errors of a certain type, which occurred when executing queries during a certain period of time.<br>Labels:<ul><li>`issue_type`: Error type; the only value is `optimistic_locks_invalidation`. For more information about lock invalidation, see [{{ ydb-short-name }} transactions and queries](https://ydb.tech/en/docs/concepts/transactions).</li></ul> |
| `api.request.completed_per_second`<br>`DGAUGE`, requests/s | API request completion rate |
| `api.request.latency_milliseconds`<br>`IGAUGE`, milliseconds | API latency |
| `api.request.latency_milliseconds_count`<br>`COUNTER`, number of requests | Total number of API requests for which latency was measured |
| `api.request.latency_milliseconds_sum`<br>`COUNTER`, milliseconds | Overall API latency |
| `api.request.size_bytes_per_second`<br>`DGAUGE`, bytes/s | API request processing rate |
| `api.response.size_bytes_per_second`<br>`DGAUGE`, bytes/s | API response processing rate |
| `api.units.consumed_by_method_per_second`<br>`DGAUGE`, number/s | Rate of resource consumption by a specific API method |
| `api.units.consumed_per_second`<br>`DGAUGE`, number/s | Overall rate of resource consumption by API methods |

## Session metrics {#sessions}

| Metric name<br>Type, unit | Label<br>description |
--- | ---
| `table.session.active_count`<br>`IGAUGE`, number | Number of sessions run by clients at the moment |
| `table.session.closed_by_idle_count`<br>`RATE`, number | Number of sessions closed by the DB server in a certain period of time due to exceeding the lifetime allowed for an idle session |

## Transaction processing metrics {#transactions}

You can analyze a transaction's execution time using a histogram counter. The intervals are set in milliseconds. The chart shows the number of transactions whose duration falls within a certain time interval.

| Metric name<br>Type, unit | Label<br>description |
--- | ---
| `table.transaction.client_duration_milliseconds`<br>`HIST_RATE`, number | Number of transactions of a certain duration on the client. The duration is the waiting time on the client between sending individual requests within a single transaction. It does not include the time of executing requests on the server.<br>Labels:<ul><li>`tx_kind`: Transaction type, which may take the `read_only`, `read_write`, `write_only`, or `pure` value.</li></ul> |
| `table.transaction.server_duration_milliseconds`<br>`HIST_RATE`, number | Number of transactions of a certain duration on the server. The duration is the time of executing requests within a transaction on the server. It does not include the waiting time on the client between sending separate requests within a single transaction.<br>Labels:<ul><li>`tx_kind`: Transaction type, which may take the `read_only`, `read_write`, `write_only`, or `pure` value.</li></ul> |
| `table.transaction.total_duration_milliseconds`<br>`HIST_RATE`, number | Number of transactions of a certain duration on the server and client. The duration of a transaction is counted from the point of its explicit or implicit start to committing changes or its rollback. It includes the transaction processing time on the server and the time on the client between sending different requests within the same transaction.<br>Labels:<ul><li>`tx_kind`: Transaction type, which may take the `read_only`, `read_write`, `write_only`, or `pure` value.</li></ul> |

## Query processing metrics {#queries}

| Metric name<br>Type, unit | Label<br>description |
--- | ---
| `table.query.compilation.latency_milliseconds`<br>`HIST_RATE`, number | Histogram counter. The intervals are set in milliseconds. Shows the number of successfully executed compilation queries whose duration falls within a certain time interval. |
| `table.query.compilation.active_count`<br>`IGAUGE`, number | Number of active compilations at the moment |
| `table.query.compilation.count`<br>`RATE`, number | Number of compilations completed successfully over a certain time period |
| `table.query.compilation.error_count`<br>`RATE`, number | Number of compilations failed over a certain period of time |
| `table.query.compilation.cache_hits`<br>`RATE`, number | Number of queries over a certain period of time, which did not require any compilation, because there was an existing plan in the cache of prepared queries |
| `table.query.compilation.cache_misses`<br>`RATE`, number | Number of queries over a certain period of time that required query compilation |
| `table.query.execution.latency_milliseconds`<br>`HIST_RATE`, number | Histogram counter. The intervals are set in milliseconds. Shows the number of queries whose execution time falls within a certain interval. |
| `table.query.request.bytes`<br>`RATE`, bytes | Size of YQL query text and parameter values to queries received by the database over a certain period of time |
| `table.query.request.parameters_bytes`<br>`RATE`, bytes | Parameter size to queries received by the database over a certain period of time |
| `table.query.response.bytes`<br>`RATE`, bytes | Size of responses sent by the database over a certain period of time |

## Table partition metrics (DataShards) {#datashards}

| Metric name<br/>Type, unit | Label<br>description |
--- | ---
| `table.datashard.bulk_upsert.bytes`<br>`RATE`, bytes | Size of data added through the `BulkUpsert` gRPC API call to all partitions of all DB tables over a certain period of time |
| `table.datashard.bulk_upsert.rows`<br>`RATE`, number | Number of rows added through the `BulkUpsert` gRPC API call to all partitions of all DB tables over a certain period of time |
| `table.datashard.erase.bytes`<br>`RATE`, bytes | Size of data deleted from the database over a certain period of time |
| `table.datashard.erase.rows`<br>`RATE`, number | Number of rows deleted from the database over a certain period of time |
| `table.datashard.read.bytes`<br>`RATE`, bytes | Size of data read by all partitions of all DB tables over a certain period of time |
| `table.datashard.read.rows`<br>`RATE`, number | Number of rows read by all partitions of all DB tables over a certain period of time |
| `table.datashard.row_count`<br>`GAUGE`, number | Number of rows in DB tables |
| `table.datashard.scan.bytes`<br>`RATE`, bytes | Size of data read through the `StreamExecuteScanQuery` or `StreamReadTable` gRPC API calls by all partitions of all DB tables over a certain period of time |
| `table.datashard.scan.rows`<br>`RATE`, number | Number of rows read through the `StreamExecuteScanQuery` or `StreamReadTable` gRPC API calls by all partitions of all DB tables over a certain period of time |
| `table.datashard.size_bytes`<br>`GAUGE`, bytes | Size of data in DB tables |
| `table.datashard.used_core_percents`<br>`HIST_GAUGE`, % | Histogram counter. The intervals are set as a percentage. Shows the number of table partitions using computing resources in the ratio that falls within a certain interval. |
| `table.datashard.write.rows`<br>`RATE`, number | Number of rows written by all partitions of all DB tables over a certain period of time |
| `table.datashard.write.bytes`<br>`RATE`, bytes | Size of data written by all partitions of all DB tables over a certain period of time |

## Table partition metrics (ColumnShards) {#columnshards}

| Metric name<br/>Type, unit | Description<br>Labels |
--- | ---
| `table.columnshard.bulk_upsert.bytes`<br>`RATE`, bytes/s | Size of data added through the `BulkUpsert` gRPC API call to all partitions of all DB tables over a certain period of time |
| `table.columnshard.bulk_upsert.rows`<br>`RATE`, rows/s | Number of rows added through the `BulkUpsert` gRPC API call to all partitions of all DB tables over a certain period of time |
| `table.columnshard.scan.bytes`<br>`RATE`, bytes/s | Size of data read through the `StreamExecuteScanQuery` or `StreamReadTable` gRPC API calls by all partitions of all DB tables over a certain period of time |
| `table.columnshard.scan.rows`<br>`RATE`, rows/s | Number of rows read through the `StreamExecuteScanQuery` or `StreamReadTable` gRPC API calls by all partitions of all DB tables over a certain period of time |

## Resource usage metrics (for Dedicated mode only) {#ydb_dedicated_resources}

| Metric name<br>Type<br>units of measurement | Label<br>description |
--- | ---
| `resources.cpu.limit_core_percents`<br>`IGAUGE`, % | Percentage of CPU available to a database. For example, for a database of three nodes with four cores in `pool=user` per node, the value of this sensor will be `1200`.<br>Labels:<ul><li>`pool`: Computing pool; the possible values are `user`, `system`, `batch`, `io`, and `ic`.</li></ul> |
| `resources.cpu.used_core_percents`<br>`RATE`, % | CPU usage. If the value is `100`, one of the cores is being used for 100%. The value may be greater than `100` for multi-core configurations.<br>Labels:<ul><li>`pool`: Computing pool; the possible values are `user`, `system`, `batch`, `io`, and `ic`.</li></ul> |
| `resources.memory.limit_bytes`<br>`IGAUGE`, bytes | RAM available to the database nodes |
| `resources.memory.used_bytes`<br>`IGAUGE`, bytes | Amount of RAM used by the database nodes |

## Query processing metrics (for Dedicated mode only) {#ydb_dedicated_queries}

| Metric name<br>Type<br>units of measurement | Description<br>Labels |
--- | ---
| `table.query.compilation.cache_evictions`<br>`RATE`, number | Number of queries evicted from the cache of [prepared queries](https://ydb.tech/en/docs/reference/ydb-sdk/example/#param-queries) within a certain period |
| `table.query.compilation.cache_size_bytes`<br>`IGAUGE`, bytes | Size of the cache of prepared queries |
| `table.query.compilation.cached_query_count`<br>`IGAUGE`, number | Size of the cache of prepared queries |
