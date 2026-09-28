The `name` label contains the metric name.

Labels shared by all {{ metastore-name }} metrics:

Label | Value
----|----
service | Service ID: `managed-metastore`
component | Metric provider: `metastore-server`
cluster_id | Cluster ID
instance | Instance ID in the cluster


## Service metrics {#managed-metastore-metrics}

#|
|| **Name**

**Type, units** | **Description** ||
|| `jvm_gc_collection_seconds.count`
`COUNT`, count | Number of JVM garbage collections.
Additional label: `gc` for the garbage collection process. ||
|| `jvm_gc_collection_seconds.sum`
`SUM`, seconds | Total duration of JVM garbage collections. ||
|| `jvm_memory_max_bytes.gauge`
`DGAUGE`, bytes | Maximum amount of available JVM memory.
Additional label: `area` for memory area. ||
|| `jvm_memory_pool_used_bytes.gauge`
`DGAUGE`, bytes | JVM pool memory used.
Additional label: `pool` for pool name. ||
|| `jvm_memory_used_bytes.gauge`
`DGAUGE`, bytes | JVM memory used.
Additional label: `area` for memory area. ||
|| `metastore_api_active_calls.gauge`
`DGAUGE`, count | Number of ongoing requests to the API.
Additional label: `method` for the {{ metastore-name }} API method name. It may take the following values:
* `total`: All methods.
* `init`: Data not exported. ||
|| `metastore_api_calls_duration_seconds.gauge`
`DGAUGE`, seconds | API request execution time.
Additional labels:
* `method` for the {{ metastore-name }} API method name. It may take the following values:
  * `total`: All methods.
  * `init`: Data not exported.
* `quantile`: Percentile. It may take the following values:
  * `0.50`
  * `0.75`
  * `0.95`
  * `0.98`
  * `0.99`
  * `0.999` ||
|| `metastore_api_calls_total.counter`
`COUNTER`, count | Number of executed requests to the API.
Additional label: `method` for the {{ metastore-name }} API method name. It may take the following values:
* `total`: All methods.
* `init`: Data not exported. ||
|| `metastore_compaction_cycle_duration_seconds.gauge`
`DGAUGE`, seconds | Duration of the last compression cycle for the `Initiator` or `Cleaner` process.
Additional label: `cycle` for compression cycle. ||
|| `metastore_directsql_errors_total.counter`
`COUNTER`, count | Number of errors during DirectSQL queries after which {{ metastore-name }} proceeded to execute queries via JDO. ||
|| `metastore_jvm_max_fds.gauge`
`DGAUGE`, count | Maximum number of file descriptors for JVM processes. ||
|| `metastore_jvm_open_fds.gauge`
`DGAUGE`, count | Number of file descriptors used by JVM processes. ||
|| `metastore_jvm_pause_events_total.counter`
`COUNTER`, count | Number of stops of all JVM threads whose duration exceeded the thresholds.
The additional `kind` (stop type) label may take the following values:
* `info-threshold`: Stops whose duration exceeded the notification threshold.
* `warn-threshold`: Stops whose duration exceeded the warning threshold. ||
|| `metastore_jvm_pause_extra_sleep_seconds.counter`
`COUNTER`, seconds | Total duration of JVM thread stops. ||
|| `metastore_object_operations_total.counter`
`COUNTER`, count | Number of create and delete operations for {{ metastore-name }} objects.
Additional labels:
* `operation`: Operation type. It may take the following values:
  * `create`
  * `delete`
* `object`: Object type. It may take the following values:
  * `dbs`
  * `tables`
  * `partitions` ||
|| `metastore_open_connections.gauge`
`DGAUGE`, count | Number of active connections to the {{ metastore-name }} cluster over the Thrift protocol. ||
|| `metastore_open_transactions.gauge`
`DGAUGE`, count | Number of active [ACID](https://en.wikipedia.org/wiki/ACID) transactions. ||
|| `metastore_total_object_count.gauge`
`DGAUGE`, count | Number of databases, tables, and partitions in the {{ metastore-name }} cluster storage.
Additional label: `object` for object type. It may take the following values:
* `dbs`
* `tables`
* `partitions` ||
|#

## JDBC connection pool metrics {#managed-metastore-jdbc-conn-pool}

JDBC connection pool metrics are available in {{ metastore-name }} starting from version `4.2`.

Labels shared by all JDBC connection pool metrics:

#|
|| Label | Value ||
|| pool | Pool name, e.g., `objectstore`, `objectstore-secondary`, `compactor`, etc. ||
|#

#|
|| **Name**

**Type, units** | **Description** ||
|| `metastore_pool_active_connections.gauge`
`DGAUGE`, count | Number of active JDBC connections. ||
|| `metastore_pool_connection_creation_seconds.gauge`
`DGAUGE`, seconds | JDBC connection setup time percentile.
Additional label: `quantile` for percentile. It may take the following values:
* `0.50`
* `0.75`
* `0.95`
* `0.98`
* `0.99`
* `0.999` ||
|| `metastore_pool_connection_creation_total.counter`
`COUNTER`, count | Total number of new JDBC connections. ||
|| `metastore_pool_connection_timeouts_total.counter`
`COUNTER`, count | Number of queries that timed out due to absence of available connections. ||
|| `metastore_pool_idle_connections.gauge`
`DGAUGE`, count | Number of idle JDBC connections. ||
|| `metastore_pool_max_connections.gauge`
`DGAUGE`, count | Maximum size of a configured JDBC connection pool. ||
|| `metastore_pool_min_connections.gauge`
`DGAUGE`, count | Minimum size of a configured JDBC connection pool. ||
|| `metastore_pool_pending_connections.gauge`
`DGAUGE`, count | Number of requests without an allocated JDBC connection as yet. ||
|| `metastore_pool_total_connections.gauge`
`DGAUGE`, count | Total number of JDBC connections in the pool. ||
|| `metastore_pool_usage_seconds.gauge`
`DGAUGE`, seconds | Connection hold-time percentile of applications.
Additional label: `quantile` for percentile. It may take the following values:
* `0.50`
* `0.75`
* `0.95`
* `0.98`
* `0.99`
* `0.999` ||
|| `metastore_pool_wait_seconds.gauge`
`DGAUGE`, seconds | Connection wait time percentile.
Additional label: `quantile` for percentile. It may take the following values:
* `0.50`
* `0.75`
* `0.95`
* `0.98`
* `0.99`
* `0.999` ||
|| `metastore_pool_wait_total.counter`
`COUNTER`, count | Total number of connection waits. ||
|#


## CPU metrics {#managed-metastore-cpu-metrics}

CPU core workload.

#|
|| **Name**

**Type, units** | **Description** ||
|| `cpu_usage.gauge`
`DGAUGE`, number | Average number of vCPUs used by the instance. ||
|| `cpu_limit.gauge`
`DGAUGE`, number | Maximum number of vCPUs available for the instance. ||
|#


## RAM metrics {#managed-metastore-ram-metrics}

#|
|| **Name**

**Type, units** | **Description** ||
|| `memory_usage.gauge`
`DGAUGE`, bytes | RAM usage by the instance. ||
|| `memory_limit.gauge`
`DGAUGE`, bytes | Maximum RAM available for the instance. ||
|#
