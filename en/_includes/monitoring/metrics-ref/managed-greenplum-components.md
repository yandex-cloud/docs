Labels shared by all {{ mgp-name }} metrics:

| Label | Value |
| :--- | :--- |
| `service` | Service ID: `managed-greenplum` |
| `resource_type` | Resource type: `cluster` |
| `resource_id` | Cluster name |
| `cid` | Cluster ID |
| `host` | Host FQDN |
| `fqdn` | Host FQDN |

Some of the described metrics are cluster-specific, not host-specific. In such metrics, the `host` and `fqdn` labels contain the FQDN of the host they are collected on. Most commonly, it is the master host of the the coordinator (displayed as `MASTER` in the interface), and the label value may change when switching the role `MASTER` => `REPLICA`. Therefore, for cluster-specific metrics, it is best not to use these labels when building queries in {{ monitoring-name }}.

## Component resource metrics {#managed-greenplum-component-resources}

Metrics of consumption of resources by individual service components. To get the data, you must specify an additional `component` label containing the component name value.

Additional labels:
* `component`: Component name: `odyssey`, `yproxy`, `pxf`, and `unified_agent`.

| Name<br/>Type, units | Description |
| :--- | :--- |
| `managed_greenplum_component.memory_limit`<br/>`DGAUGE`, bytes | Memory limit allocated to the component (`cgroup memory limit`). |
| `managed_greenplum_component.cpu_time`<br/>`DGAUGE`, ms | Total CPU time used by the component (sum of `user` and `system`). |
| `managed_greenplum_component.cpu_time_system`<br/>`DGAUGE`, ms | Processor time used by the component in kernel mode (`system`). |
| `managed_greenplum_component.cpu_time_user`<br/>`DGAUGE`, ms | Processor time used by the component in `user` mode. |
| `managed_greenplum_component.memory_usage`<br/>`DGAUGE`, bytes | Current memory usage by the component. |
| `managed_greenplum_component.memory_cache`<br/>`DGAUGE`, bytes | Memory used by the component for data caching. |
| `managed_greenplum_component.memory_rss`<br/>`DGAUGE`, bytes | Amount of resident storage (RSS) occupied by the component in physical memory. |
| `managed_greenplum_component.cpu_quota_us`<br/>`DGAUGE`, microseconds | CPU time quota (`cgroup CPU quota`) in microseconds per period. |
| `managed_greenplum_component.cpu_period_us`<br/>`DGAUGE`, microseconds | Processor scheduling period (`cgroup CPU period`) in microseconds. |

## Composite signals {#managed-greenplum-composite-signals}

Composite metrics aggregating multiple indicators to quickly assess the status of a cluster or individual component. The signal values ​​are interpreted as follows:

| Numeric value | Stage | Description |
| :--- | :--- | :--- |
| `2` | **OK** (Green) | All important cluster or component indicators are within acceptable boundaries. The system is operating normally. |
| `1` | **Warn** (Yellow) | Deviations are detected according to one or more indicators. The cluster or component is functioning but may require attention. |
| `0` | **Crit** (Red) | Critical deviations detected. Significant performance degradation, instability, or complete unavailability of a cluster or component. |
| `-1` | **Unknown** (Gray) | Status not determined or there is no data. |

| Name<br/>Type, units | Description |
| :--- | :--- |
| `greenplum_cluster_status.signal`<br/>`DGAUGE` | Complex cluster status signal. Takes into account read and write accessibility, transaction counter utilization, and the number of segments in the `down` and `not preferred role` statuses. |
| `greenplum_pooler_status.signal`<br/>`DGAUGE` | Complex status signal of the connection pooler (Odyssey). Takes into account availability, CPU and memory utilization. |
| `greenplum_connections_status.signal`<br/>`DGAUGE` | Complex connection status signal. Takes into account total utilization of connections, utilization of connections in the `idle in transaction` state, and maximum utilization by segment. |
| `greenplum_resources_status.signal`<br/>`DGAUGE` | Complex signal of consumption by hosts. Takes into account Load Average, CPU, memory, network packets and traffic, disk space, and IO. |
| `greenplum_queries_status.signal`<br/>`DGAUGE` | Complex request completion signal based on latencies of test read and write requests. |

## Cluster availability and health metrics {#managed-greenplum-availability-metrics}

| Name<br/>Type, units | Description |
| :--- | :--- |
| `greenplum_availability.can_read`<br/>`DGAUGE` | Cluster read availability indicator for the last 5 minutes. `1`: read operations successful, `0`: no successful operations. |
| `greenplum_availability.can_write`<br/>`DGAUGE` | Cluster write availability indicator for the last 5 minutes. `1`: write operations successful, `0`: no successful operations. |
| `gp.percent_xid_wraparound`<br/>`DGAUGE`, % | Transaction counter utilization percentage (XID). Indicates a risk of wraparound.<br/>Additional labels: `db_name` |
| `gp.percent_xid_wraparound_warn_limit`<br/>`DGAUGE`, % | XID utilization warning threshold. |
| `gp.percent_xid_wraparound_crit_limit`<br/>`DGAUGE`, % | Critical XID utilization threshold. |
| `gp.seg_down`<br/>`DGAUGE`, count | Number of unavailable segments. |
| `gp.seg_down_warn_limit`<br/>`DGAUGE`, count | Warning threshold for the number of unavailable segments. |
| `gp.seg_not_pref_role`<br/>`DGAUGE`, count | Number of segments operating not in preferred role. |
| `gp.seg_not_pref_role_warn_limit`<br/>`DGAUGE`, count | Warning threshold for segments that are not in preferred role. |
| `gp.seg_not_synch`<br/>`DGAUGE`, count | Number of segments in an unsynchronized state. |
| `gp.log_events_warning_total`<br/>`DGAUGE`, count | Total number of `WARNING` level events in DBMS logs. |
| `gp.log_events_error_total`<br/>`DGAUGE`, count | Total number of `ERROR` level events in DBMS logs. |
| `gp.log_events_fatal_total`<br/>`DGAUGE`, count | Total number of `FATAL` level events in DBMS logs. |

## Odyssey (Pooler) component metrics {#managed-greenplum-odyssey-metrics}

Odyssey connection pooler metrics.

| Name<br/>Type, units | Description |
| :--- | :--- |
| `pooler.is_available`<br/>`DGAUGE` | Pooler availability indicator for the last 5 minutes. `1`: available, `0`: unavailable. |
| `pooler.cpu_limit_warn`<br/>`DGAUGE`, % | Pooler CPU utilization warning threshold. |
| `pooler.memory_limit_warn`<br/>`DGAUGE`, bytes | Pooler memory consumption warning threshold. |
| `pooler.bytes_sent`<br/>`DGAUGE`, bytes per second | Data send speed from pooler to clients. |
| `pooler.bytes_received`<br/>`DGAUGE`, bytes per second | Data receive speed from clients by pooler. |
| `pooler.used_servers`<br/>`DGAUGE`, count | Number of active server connections (pooler → DMBS). |
| `pooler.free_servers`<br/>`DGAUGE`, count | Number of free server connections in the pool. |
| `pooler.used_clients`<br/>`DGAUGE`, count | Number of active client connections (client → pooler). |
| `pooler.query_0.5`<br/>`DGAUGE`, ms | 50th percentile of query execution time through the pooler. |
| `pooler.query_0.75`<br/>`DGAUGE`, ms | 75th percentile of query execution time through the pooler. |
| `pooler.query_0.9`<br/>`DGAUGE`, ms | 90th percentile of query execution time through the pooler. |
| `pooler.query_0.95`<br/>`DGAUGE`, ms | 95th percentile of query execution time through the pooler. |
| `pooler.query_0.99`<br/>`DGAUGE`, ms | 99th percentile of query execution time through the pooler. |
| `pooler.query_0.999`<br/>`DGAUGE`, ms | 99,9th percentile of query execution time through the pooler. |

## Connection metrics {#managed-greenplum-connections-detailed-metrics}

Detailed metrics on the status of connections to the master and segments.

| Name<br/>Type, units | Description |
| :--- | :--- |
| `gp.max_connections`<br/>`DGAUGE`, count | Maximum allowed number of connections to the cluster including the superuser reserve. |
| `gp.connect_utilization_warn_limit`<br/>`DGAUGE`, % | Warning threshold for utilization of connections. |
| `gp.connect_utilization_crit_limit`<br/>`DGAUGE`, % | Critical threshold for utilization of connections. |
| `gp.idle_in_transaction_utilization_warn_limit`<br/>`DGAUGE`, % | Warning threshold for utilization of connections in the `idle in transaction` state. |
| `gp.idle_in_transaction_utilization_crit_limit`<br/>`DGAUGE`, % | Critical threshold for utilization of connections in the `idle in transaction` state. |
| `gp.segment_max_connections`<br/>`DGAUGE`, count | Maximum allowed number of connections to segments. |

## Network queue and Interconnect metrics {#managed-greenplum-network-queues-metrics}

| Name<br/>Type, units | Description |
| :--- | :--- |
| `net_queue.rx_queue_0_packets`<br/>`DGAUGE`, packets per second | Number of packets in the incoming queue (ring buffer) of the interface. |
| `net_queue.rx_queue_1_packets`<br/>`DGAUGE`, packets per second | Number of packets in the incoming queue (ring buffer) of the interface (channel 1). |
| `net_queue.tx_queue_0_packets`<br/>`DGAUGE`, packets per second | Number of packets in the outgoing queue (ring buffer) of the interface. |
| `net_queue.tx_queue_1_packets`<br/>`DGAUGE`, packets per second | Number of packets in the outgoing queue (ring buffer) of the interface (channel 1). |
| `gp.retransmits`<br/>`DGAUGE`, count | Number of resent Interconnect packets. |
| `gp.snd_pkt_num`<br/>`DGAUGE`, count | Total number of Interconnect packets sent. |

## Query execution metrics {#managed-greenplum-queries-execution-metrics}

| Name<br/>Type, units | Description |
| :--- | :--- |
| `test_queries_duration.canreadduration`<br/>`DGAUGE`, ms | Duration of test read request (`SELECT 1`). |
| `test_queries_duration.canwriteduration`<br/>`DGAUGE`, ms | Duration of test write request. |
| `test_queries_duration.select42duration`<br/>`DGAUGE`, ms | Duration of test read request from each segment.<br/>Additional labels: `segment_id` |
| `yagpcc.new_queries`<br/>`DGAUGE`, count/sec | Number of new requests received by the cluster. |
| `yagpcc.failed_queries`<br/>`DGAUGE`, count/sec | Number of requests that failed or were canceled. |
| `yagpcc.query_bucket`<br/>`DGAUGE`, count | Distribution histogram of completed requests based on duration.<br/>Additional labels: `le` (upper limit of the interval in seconds: `0.05`, `0.1`, `1`, `10`, `60`, `300`, `600`, `3600`, `+Inf`) |
| `yagpcc.executing_query_10ms`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 0 and 10 milliseconds. |
| `yagpcc.executing_query_50ms`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 10 and 50 milliseconds. |
| `yagpcc.executing_query_100ms`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 50 and 100 milliseconds. |
| `yagpcc.executing_query_1s`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 100 milliseconds and 1 second. |
| `yagpcc.executing_query_2s`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 1 and 2 seconds. |
| `yagpcc.executing_query_5s`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 2 and 5 seconds. |
| `yagpcc.executing_query_10s`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 5 and 10 seconds. |
| `yagpcc.executing_query_30s`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 10 and 30 seconds. |
| `yagpcc.executing_query_1m0s`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 30 seconds and 1 minute. |
| `yagpcc.executing_query_2m0s`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 1 and 2 minutes. |
| `yagpcc.executing_query_5m0s`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 2 and 5 minutes. |
| `yagpcc.executing_query_10m0s`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 5 and 10 minutes. |
| `yagpcc.executing_query_30m0s`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 10 and 30 minutes. |
| `yagpcc.executing_query_1h0m0s`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 30 minutes and 1 hour. |
| `yagpcc.executing_query_2h0m0s`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 1 and 2 hours. |
| `yagpcc.executing_query_3h0m0s`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 2 and 3 hours. |
| `yagpcc.executing_query_5h0m0s`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 3 and 5 hours. |
| `yagpcc.executing_query_12h0m0s`<br/>`DGAUGE`, count | Number of ongoing requests with a duration between 5 and 12 hours. |
| `yagpcc.executing_query_inf`<br/>`DGAUGE`, count | Number of ongoing requests with a duration of more than 12 hours. |

## Maintenance metrics (Vacuum and Analyze) {#managed-greenplum-vacuum-analyze-metrics}

System folder health metrics, `pg_attribute` tables, and custom table maintenance age.

| Name<br/>Type, units | Description |
| :--- | :--- |
| `gp_vacuum.catalog_size_master`<br/>`DGAUGE`, bytes | Size of the system folder on the master host.<br/>Additional labels: `database` |
| `gp_vacuum.catalog_size_segment`<br/>`DGAUGE`, bytes | Size of the system folder on segments.<br/>Additional labels: `database` |
| `gp_vacuum.catalog_dead_tuples_master`<br/>`DGAUGE`, count | Number of _dead_ tuples in the system folder on the master.<br/>Additional labels: `database` |
| `gp_vacuum.catalog_dead_tuples_segment`<br/>`DGAUGE`, count | Number of _dead_ tuples in the system folder on segments.<br/>Additional labels: `database` |
| `gp_vacuum.catalog_live_tuples_master`<br/>`DGAUGE`, count | Number of _live_ tuples in the system folder on the master.<br/>Additional labels: `database` |
| `gp_vacuum.catalog_live_tuples_segment`<br/>`DGAUGE`, count | Number of _live_ tuples in the system folder on segments.<br/>Additional labels: `database` |
| `gp_vacuum.pg_attribute_size_master`<br/>`DGAUGE`, bytes | `pg_attribute` table size on master.<br/>Additional labels: `database` |
| `gp_vacuum.pg_attribute_size_segment`<br/>`DGAUGE`, bytes | `pg_attribute` table size on segments.<br/>Additional labels: `database` |
| `gp_vacuum.pg_attribute_dead_tuples_master`<br/>`DGAUGE`, count | Number of _dead_ tuples in the `pg_attribute` table on the master.<br/>Additional labels: `database` |
| `gp_vacuum.pg_attribute_dead_tuples_segment`<br/>`DGAUGE`, count | Number of _dead_ tuples in the `pg_attribute` table on segments.<br/>Additional labels: `database` |
| `gp_vacuum.pg_attribute_live_tuples_master`<br/>`DGAUGE`, count | Number of _live_ tuples in the `pg_attribute` table on the master.<br/>Additional labels: `database` |
| `gp_vacuum.pg_attribute_live_tuples_segment`<br/>`DGAUGE`, count | Number of _live_ tuples in the `pg_attribute` table on segments.<br/>Additional labels: `database` |
| `gp_vacuum.age_1`<br/>`DGAUGE`, count | Number of tables with last `VACUUM` 1 day ago. |
| `gp_vacuum.age_2`<br/>`DGAUGE`, count | Number of tables with last `VACUUM` 2 days ago. |
| `gp_vacuum.age_4`<br/>`DGAUGE`, count | Number of tables with last `VACUUM` 4 days ago. |
| `gp_vacuum.age_8`<br/>`DGAUGE`, count | Number of tables with last `VACUUM` 8 days ago. |
| `gp_vacuum.age_16`<br/>`DGAUGE`, count | Number of tables with last `VACUUM` 16 days ago. |
| `gp_vacuum.age_32`<br/>`DGAUGE`, count | Number of tables with last `VACUUM` 32 days ago. |
| `gp_vacuum.age_inf`<br/>`DGAUGE`, count | Number of tables with last `VACUUM` more than 32 days ago. |
| `gp_analyze.age_1`<br/>`DGAUGE`, count | Number of tables with last `ANALYZE` 1 day ago. |
| `gp_analyze.age_2`<br/>`DGAUGE`, count | Number of tables with last `ANALYZE` 2 days ago. |
| `gp_analyze.age_4`<br/>`DGAUGE`, count | Number of tables with last `ANALYZE` 4 days ago. |
| `gp_analyze.age_8`<br/>`DGAUGE`, count | Number of tables with last `ANALYZE` 8 days ago. |
| `gp_analyze.age_16`<br/>`DGAUGE`, count | Number of tables with last `ANALYZE` 16 days ago. |
| `gp_analyze.age_32`<br/>`DGAUGE`, count | Number of tables with last `ANALYZE` 32 days ago. |
| `gp_analyze.age_inf`<br/>`DGAUGE`, count | Number of tables with last `ANALYZE` more than 32 days ago. |

## Hybrid storage metrics (YProxy/Yezzey) {#managed-greenplum-hybrid-storage-metrics}

Metrics of the `yproxy` component and the `yezzey` extension.

| Name<br/>Type, units | Description |
| :--- | :--- |
| `yezzey.read_req_processed_total`<br/>`DGAUGE`, count/sec | Number of successfully processed requests to read from external storage. |
| `yezzey.write_req_processed_total`<br/>`DGAUGE`, count/sec | Number of successfully processed requests to write to external storage. |
| `yezzey.read_req_errors_total`<br/>`DGAUGE`, count/sec | Number of failed read requests. |
| `yezzey.write_req_errors_total`<br/>`DGAUGE`, count/sec | The number of failed write requests. |
| `yezzey.object_count`<br/>`DGAUGE`, count | Total number of objects in external storage managed by Yezzey. |
| `yezzey.object_size`<br/>`DGAUGE`, bytes | Total size of objects in external storage managed by Yezzey. |