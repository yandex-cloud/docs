The metric name is written to the `name` label.

All {{ data-transfer-name }} metrics have common labels:

| Label | Value |
--- | ---
| service | Service ID: `data-transfer` |
| job_index | [Worker](../../../data-transfer/concepts/index.md#worker) index to distinguish workers used for [parallel data copying](../../../data-transfer/concepts/sharded.md). |
| src_id | [Source](../../../data-transfer/transfer-matrix.md) ID |
| target_type | [Target](../../../data-transfer/transfer-matrix.md) type, e.g., `mongo` |
| resource_id | {{ data-transfer-name }} [transfer](../../../data-transfer/concepts/index.md#transfer) ID |
| dst_id | Target ID |
| source_type | Source type, e.g., `mongo` |
| operation_type (except for the `replication.*` metrics) | Operation type, e.g., `Activate` |

## CPU metrics {#data-transfer-cpu-metrics}

Processor core workload

Common labels for all CPU metrics:

| Label | Value |
--- | ---
| component | System component, e.g., `psutil` |

| Name</br>Type, units | Description |
----- | -----
| `cpu.counts`</br>`COUNTER`, number | Number of CPUs allocated for data transfer in the worker |
| `proc.cpu`</br>`DGAUGE`, % | Processor core workload |
| `proc.descriptors`</br>`DGAUGE`, number | Number of open file descriptors |
| `proc.ram`</br>`DGAUGE`, bytes | RAM usage |

## RAM metrics {#data-transfer-ram-metrics}

Common labels for all RAM metrics:

| Label | Value |
--- | ---
| component | System component, e.g., `psutil` |

| Name</br>Type, units | Description |
----- | -----
| `mem.available`</br>`COUNTER`, bytes | RAM usage, `available` usage type |
| `mem.percentage`</br>`DGAUGE`, % | Percentage of RAM usage |
| `mem.used`</br>`COUNTER`, bytes | RAM usage, `used` usage type |

## Service metrics {#data-transfer-metrics}

| Name</br>Type, units | Description</br>Labels |
----- | -----
| `fallbacks.source.deepness`</br>`DGAUGE`, number | Current number of elements in the fallback queue on the source side |
| `fallbacks.source.errors`</br>`COUNTER`, number | Number of errors on the source side during the fallback process |
| `fallbacks.source.items`</br>`COUNTER`, number | Total number of elements added to the fallback queue on the source side |
| `fallbacks.target.deepness`</br>`DGAUGE`, number | Current number of elements in the fallback queue on the target side |
| `fallbacks.target.errors`</br>`COUNTER`, number | Number of errors on the target side during the fallback process |
| `fallbacks.target.items`</br>`COUNTER`, number | Total number of elements added to the fallback queue on the target side |
| `logger.bytes_written`</br>`COUNTER`, bytes | Total volume of recorded logs |
| `logger.field_truncated_size_hist`</br>`IGAUGE`, bytes | Histogram of truncated fields in logs</br>`bin` label: Histogram buckets |
| `logger.leaked_count`</br>`COUNTER`, bytes | Number of leaks in logs |
| `logger.leaked_size`</br>`COUNTER`, bytes | Volume of leaks in logs |
| `logger.leaked_size_hist`</br>`IGAUGE`, bytes | Histogram of leaks in logs</br>`bin` label: Histogram buckets |
| `logger.success_size_hist`</br>`IGAUGE`, bytes | Histogram of recorded logs</br>`bin` label: Histogram buckets |
| `middleware.error_tracker.failures`</br>`COUNTER`, bytes | Number of errors in the error tracker</br>`component` label: System component, e.g., `middleware_filter` |
| `middleware.error_tracker.success`</br>`COUNTER`, number | Number of successful operations in the error tracker</br>`component` label: System component, e.g., `middleware_filter` |
| `middleware.filter.dropped`</br>`COUNTER`, number | Number of discarded elements</br>`component` label: System component, e.g., `middleware_filter` |
| `publisher.consumer.active`</br>`DGAUGE`, number | Number of active consumers (data processing threads) |
| `publisher.consumer.compress_ratio`</br>`DGAUGE`, % | Data compression ratio during data transfer |
| `publisher.consumer.ddl_error`</br>`COUNTER`, number | Number of errors related to DDL (Data Definition Language) operations |
| `publisher.consumer.error`</br>`COUNTER`, number | Total number of errors encountered by consumers |
| `publisher.consumer.extracted_bytes`</br>`DGAUGE`, bytes | Amount of data extracted from the source |
| `publisher.consumer.fatal`</br>`COUNTER`, number | Number of fatal errors requiring agent involvement |
| `publisher.consumer.log_usage_bytes`</br>`DGAUGE`, bytes | Size of buffer or write ahead log (when supported) in the source |
| `publisher.consumer.read_bytes`</br>`DGAUGE`, bytes | Amount of read data |
| `publisher.data.bytes`</br>`COUNTER`, bytes | Amount of data read from the source |
| `publisher.data.changeitems`</br>`COUNTER`, number | Number of source events generated for a transfer (apart from the data to transfer, these events may include housekeeping operations) |
| `publisher.data.parsed_rows`</br>`COUNTER`, number | Number of rows successfully processed after they were parsed |
| `publisher.data.transactions`</br>`COUNTER`, number | Number of data transactions processed during transfer |
| `publisher.data.unparsed_rows`</br>`COUNTER`, number | Number of data rows that could not be successfully parsed |
| `publisher.time.delay_ms`</br>`DGAUGE`, milliseconds | Delay during data transfer |
| `publisher.time.parse_ms`</br>`DGAUGE`, milliseconds | Time spent on data parsing |
| `publisher.time.push_ms`</br>`DGAUGE`, milliseconds | Time spent sending data to target |
| `publisher.time.transform_ms`</br>`DGAUGE`, milliseconds | Time spent on data transformation |
| `replication.running`</br>`DGAUGE`, 0/1 | Current replication state</br>Takes on these values:<ul><li>`1`: Launched</li><li>`0`: Stopped</li></ul> |
| `replication.start.unix`</br>`DGAUGE`, number | Replication start time label in Unix epoch format |
| `runtime.alloc`</br>`COUNTER`, bytes | Total amount of memory allocated but not freed up yet</br>`component` label: System component, e.g., `psutil` |
| `runtime.heapIdle`</br>`COUNTER`, bytes | Amount of memory allocated for dynamic memory but not currently in use</br>`component` label: System component, e.g., `psutil` |
| `runtime.heapInuse`</br>`COUNTER`, bytes | Amount of memory actively used as dynamic memory</br>`component` label: System component, e.g., `psutil` |
| `runtime.numGC`</br>`COUNTER`, bytes | Number of garbage collection (GC) cycles performed since the start of measurement time</br>`component` label: System component, e.g., `psutil` |
| `runtime.sys`</br>`COUNTER`, bytes | Total amount of system memory in use</br>`component` label: System component, e.g., `psutil` |
| `runtime.totalAlloc`</br>`COUNTER`, bytes | Total amount of memory allocated for the entire run time</br>`component` label: System component, e.g., `psutil` |
| `sinker.pusher.data.changeitems`</br>`COUNTER`, number | Number of events written to the target (apart from the data to transfer, these events may include housekeeping operations) |
| `sinker.pusher.data.row_events_pushed`</br>`COUNTER`, number | Number of rows sent to target |
| `sinker.pusher.time.batch_push_distribution_sec`</br>`IGAUGE`, seconds | Full time it takes to write a batch to the target, including data preprocessing</br>`bin` label: Histogram buckets |
| `sinker.pusher.time.row_lag_sec`</br>`IGAUGE`, seconds | Time lag between records appearing at target and source</br>`bin` label: Histogram buckets |
| `sinker.pusher.time.row_max_lag_sec`</br>`DGAUGE`, seconds | Maximum data lag |
| `sinker.pusher.time.row_max_read_lag_sec`</br>`DGAUGE`, seconds | Maximum lag between data appearing at source till the read time |
| `sinker.table.deleted_rows`</br>`COUNTER`, number | Number of deleted table rows</br>`table` label: DB table or collection |
| `sinker.table.rows`</br>`COUNTER`, number | 50 tables with the maximum number of rows written to the target</br>`table` label: DB table or collection |
| `sinker.table.updated_rows`</br>`COUNTER`, number | Number of updated table rows</br>`table` label: DB table or collection |
| `sinker.table.upserted_rows`</br>`COUNTER`, number | Number of table rows inserted or updated (`upsert`)</br>`table` label: DB table or collection |
| `sinker.time.bulkPrepare`</br>`DGAUGE`, seconds | Time to prepare a data batch for writing |
| `sinker.time.bulkWrite`</br>`DGAUGE`, seconds | Time to write a data batch |
| `sinker.time.push`</br>`DGAUGE`, seconds | Total data write operation time |
| `sinker.transactions.inflight`</br>`COUNTER`, number | Number of active transactions |
| `sinker.transactions.total`</br>`COUNTER`, number | Total number of completed transactions |
| `storage.diff_perc`</br>`DGAUGE`, % | Percentage difference between the number of source and target records</br>`table` label: DB table or collection |
| `storage.source_rows`</br>`DGAUGE`, number | Number of data source rows</br>`table` label: DB table or collection |
| `storage.target_rows`</br>`DGAUGE`, number | Number of data target rows</br>`table` label: DB table or collection |
| `task.snapshot.remainder.table`</br>`DGAUGE`, number | Number of rows awaiting transfer</br>`table` label: DB table or collection |
| `task.snapshot.reminder.total`</br>`DGAUGE`, number | Total number of rows still to be transferred</br>`table` label: DB table or collection |
| `task.status`</br>`DGAUGE`, 0/1 | Status of operation in progress</br>Takes on these values:<ul><li>`1`: Task active</li><li>`0`: Task inactive</li></ul> |