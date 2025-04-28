The `name` label stores the metric name.

All {{ data-transfer-name }} metrics share the following labels:

Label | Value
--- | ---
service | Service ID: `data-transfer`
job_index | [Worker](../../../data-transfer/concepts/index.md#worker) index to distinguish workers used in [parallel data copying](../../../data-transfer/concepts/sharded.md)
src_id | [Source](../../../data-transfer/transfer-matrix.md) ID
target_type | [Target](../../../data-transfer/transfer-matrix.md) type, e.g., `mongo`
resource_id | [Transfer](../../../data-transfer/concepts/index.md#transfer) ID in {{ data-transfer-name }}
dst_id | Target ID
source_type | Source type, e.g., `mongo`
operation_type (except for the `replication.*` metrics) | Operation type, e.g., `Activate`

## CPU metrics {#data-transfer-cpu-metrics}

These metrics show processor core workload.

Labels shared by all CPU metrics:

Label | Value
--- | ---
component | System component, e.g., `psutil`

Name</br>Type, units | Description
----- | -----
`cpu.counts`</br>`COUNTER`, count | Number of CPUs allocated for data transfer in a worker
`proc.cpu`</br>`DGAUGE`, % | These metrics show processor core workload.
`proc.descriptors`</br>`DGAUGE`, count | Number of open file descriptors
`proc.ram`</br>`DGAUGE`, bytes | RAM usage

## RAM metrics {#data-transfer-ram-metrics}

Labels shared by all RAM metrics:

Label | Value
--- | ---
component | System component, e.g., `psutil`

Name</br>Type, units | Description
----- | -----
`mem.available`</br>`COUNTER`, bytes | RAM usage, `available` usage type
`mem.percentage`</br>`DGAUGE`, % | Percentage of RAM usage
`mem.used`</br>`COUNTER`, bytes | RAM usage, `used` usage type

## Service metrics {#data-transfer-metrics}

Name</br>Type, units | Description</br>Labels
----- | -----
`fallbacks.source.deepness`</br>`DGAUGE`, count | Current number of items in the source-side fallback queue
`fallbacks.source.errors`</br>`COUNTER`, count | Number of source-side fallback errors
`fallbacks.source.items`</br>`COUNTER`, count | Total items added to the source-side fallback queue
`fallbacks.target.deepness`</br>`DGAUGE`, count | Current number of items in the target-side fallback queue
`fallbacks.target.errors`</br>`COUNTER`, count | Number of target-side fallback errors
`fallbacks.target.items`</br>`COUNTER`, count | Total items added to the target-side fallback queue
`logger.bytes_written`</br>`COUNTER`, bytes | Total size of written logs
`logger.field_truncated_size_hist`</br>`IGAUGE`, bytes | Histogram of truncated log fields.</br>This metric features the `bin` label containing histogram buckets.
`logger.leaked_count`</br>`COUNTER`, count | Number of log leaks
`logger.leaked_size`</br>`COUNTER`, bytes | Size of log leaks
`logger.leaked_size_hist`</br>`IGAUGE`, bytes | Histogram of log leaks.</br>This metric features the `bin` label containing histogram buckets.
`logger.success_size_hist`</br>`IGAUGE`, bytes | Histogram of written logs.</br>This metric features the `bin` label containing histogram buckets.
`middleware.error_tracker.failures`</br>`COUNTER`, count | Number of errors in the error tracker.</br>This metric features the `component` label containing a system component, e.g., `middleware_filter`.
`middleware.error_tracker.success`</br>`COUNTER`, count | Number of successful operations in the error tracker</br>This metric features the `component` label containing a system component, e.g., `middleware_filter`.
`middleware.filter.dropped`</br>`COUNTER`, count | Number of dropped items.</br>This metric features the `component` label containing a system component, e.g., `middleware_filter`.
`publisher.consumer.active`</br>`DGAUGE`, count | Number of active consumers (data processing threads)
`publisher.consumer.compress_ratio`</br>`DGAUGE`, % | Data compression ratio during data transfer
`publisher.consumer.ddl_error`</br>`COUNTER`, count | Number of DDL errors
`publisher.consumer.error`</br>`COUNTER`, count | Total errors in consumers
`publisher.consumer.extracted_bytes`</br>`DGAUGE`, bytes | Size of data extracted from the source
`publisher.consumer.fatal`</br>`COUNTER`, count | Number of fatal errors requiring system specialist involvement
`publisher.consumer.log_usage_bytes`</br>`DGAUGE`, bytes | Size of buffer or write ahead log (when supported) in the source
`publisher.consumer.read_bytes`</br>`DGAUGE`, bytes | Size of read data
`publisher.data.bytes`</br>`COUNTER`, bytes | Size of data read from the source
`publisher.data.changeitems`</br>`COUNTER`, count | Number of source events generated for a transfer. Apart from the data to transfer, these events may include housekeeping operations.
`publisher.data.parsed_rows`</br>`COUNTER`, count | Number of rows successfully parsed and processed
`publisher.data.transactions`</br>`COUNTER`, count | Number of data transactions processed during transfer
`publisher.data.unparsed_rows`</br>`COUNTER`, count | Number of data rows that could not be successfully parsed
`publisher.time.delay_ms`</br>`DGAUGE`, milliseconds | Delay during data transfer
`publisher.time.parse_ms`</br>`DGAUGE`, milliseconds | Time spent on data parsing
`publisher.time.push_ms`</br>`DGAUGE`, milliseconds | Time spent sending data to target
`publisher.time.transform_ms`</br>`DGAUGE`, milliseconds | Time spent on data transformation
`replication.running`</br>`DGAUGE`, 0/1 | Current replication state.</br>It can take either of these two values:<ul><li>`1`: Launched.</li><li>`0`: Stopped.</li></ul>
`replication.start.unix`</br>`DGAUGE`, count | Replication start timestamp in Unix epoch format
`runtime.alloc`</br>`COUNTER`, bytes | Memory allocated but not yet released.</br>This metric features the `component` label containing a system component, e.g., `psutil`.
`runtime.heapIdle`</br>`COUNTER`, bytes | Dynamic memory allocation, which is currently idle.</br>This metric features the `component` label containing a system component, e.g., `psutil`.
`runtime.heapInuse`</br>`COUNTER`, bytes | Dynamic memory allocation, which is actively used.</br>This metric features the `component` label containing a system component, e.g., `psutil`.
`runtime.numGC`</br>`COUNTER`, count | Number of garbage collection (GC) cycles since measurement initiation.</br>This metric features the `component` label containing a system component, e.g., `psutil`.
`runtime.sys`</br>`COUNTER`, bytes | Total system memory in use.</br>This metric features the `component` label containing a system component, e.g., `psutil`.
`runtime.totalAlloc`</br>`COUNTER`, bytes | Total memory allocated over the run time.</br>This metric features the `component` label containing a system component, e.g., `psutil`.
`sinker.pusher.data.changeitems`</br>`COUNTER`, count | Number of events written to the target. Apart from the data to transfer, these events may include housekeeping operations.
`sinker.pusher.data.row_events_pushed`</br>`COUNTER`, count | Number of rows sent to the target
`sinker.pusher.time.batch_push_distribution_sec`</br>`IGAUGE`, seconds | Full time it takes to write a batch to the target, including data preprocessing.</br>This metric features the `bin` label containing histogram buckets.
`sinker.pusher.time.row_lag_sec`</br>`IGAUGE`, seconds | Time lag between when the records appear in the target and when they appear in the source.</br>This metric features the `bin` label containing histogram buckets.
`sinker.pusher.time.row_max_lag_sec`</br>`DGAUGE`, seconds | Maximum data lag
`sinker.pusher.time.row_max_read_lag_sec`</br>`DGAUGE`, seconds | Maximum lag between when the data appears in the source and when it is read.
`sinker.table.deleted_rows`</br>`COUNTER`, count | Number of deleted table rows.</br>This metric features the `table` label containing a DB table or collection.
`sinker.table.error`</br>`COUNTER`, count | Number of errors that occurred while processing the table.</br>This metric features the `table` label containing a DB table or collection.
`sinker.table.rows`</br>`COUNTER`, count | 50 tables with the maximum number of rows written to the target.</br>This metric features the `table` label containing a DB table or collection.
`sinker.table.updated_rows`</br>`COUNTER`, count | Number of updated table rows.</br>This metric features the `table` label containing a DB table or collection.
`sinker.table.upserted_rows`</br>`COUNTER`, count | Number of inserted or updated (`upsert`) table rows.</br>This metric features the `table` label containing a DB table or collection.
`sinker.time.bulkPrepare`</br>`DGAUGE`, seconds | Time to prepare a data batch for writing
`sinker.time.bulkWrite`</br>`DGAUGE`, seconds | Time to write a data batch
`sinker.time.push`</br>`DGAUGE`, seconds | Total data write time
`sinker.transactions.inflight`</br>`COUNTER`, count | Number of active transactions
`sinker.transactions.total`</br>`COUNTER`, count | Total completed transactions
`storage.diff_perc`</br>`DGAUGE`, % | Percentage difference between the number of source and target records.</br>This metric features the `table` label containing a DB table or collection.
`storage.source_rows`</br>`DGAUGE`, count | Number of data source rows.</br>This metric features the `table` label containing a DB table or collection.
`storage.target_rows`</br>`DGAUGE`, count |  Number of data target rows.</br>This metric features the `table` label containing a DB table or collection.
`task.snapshot.remainder.table`</br>`DGAUGE`, count | Number of rows awaiting transfer.</br>This metric features the `table` label containing a DB table or collection.
`task.snapshot.reminder.total`</br>`DGAUGE`, count | Total remaining rows to transfer.</br>This metric features the `table` label containing a DB table or collection.
`task.status`</br>`DGAUGE`, 0/1 | Status of the operation in progress.</br>It can take either of these two values:<ul><li>`1`: Active issue.</li><li>`0`: Inactive issue.</li></ul>