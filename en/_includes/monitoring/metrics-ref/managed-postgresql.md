## Service: {{ mpg-full-name }} {#managed-postgresql}

Common labels for all {{ mpg-full-name }} service metrics:

| Label | Value |
| ----- | ----- |
| service | Service ID: `managed-postgresql` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster ID |
| host | Host FQDN |
| node | Host type: `primary`, `replica` |
| subcluster_name | Subcluster name |

### CPU metrics {#managed-postgresql-cpu-metrics}
The load on processor cores.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `cpu.fraction`<br/>`DGAUGE`, % | Guaranteed vCPU performance. |
| `cpu.guarantee`<br/>`DGAUGE`, pcs | Guaranteed number of cores. |
| `cpu.limit`<br/>`DGAUGE`, pcs | Limit on CPUs in use. |
| `cpu.guest`<br/>`DGAUGE`, % | CPU usage, `guest` usage type. |
| `cpu.idle`<br/>`DGAUGE`, % | CPU usage, `idle` usage type. |
| `cpu.iowait`<br/>`DGAUGE`, % | CPU usage, `iowait` usage type. |
| `cpu.irq`<br/>`DGAUGE`, % | CPU usage, `irq` usage type. |
| `cpu.nice`<br/>`DGAUGE`, % | CPU usage, `nice` usage type. |
| `cpu.softirq`<br/>`DGAUGE`, % | CPU usage, `softirq` usage type. |
| `cpu.steal`<br/>`DGAUGE`, % | CPU usage, `steal` usage type. |
| `cpu.system`<br/>`DGAUGE`, % | CPU usage, `system` usage type. |
| `cpu.user`<br/>`DGAUGE`, % | CPU usage, `user` usage type. |
| `load.avg_15min`<br/>`DGAUGE`, % | Average load in 15 minutes. |
| `load.avg_1min`<br/>`DGAUGE`, % | Average load per 1 minute. |
| `load.avg_5min`<br/>`DGAUGE`, % | Average load in 5 minutes. |

### Disk metrics {#managed-postgresql-disk-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, bytes | Free space. |
| `disk.free_inodes`<br/>`DGAUGE`, pcs | Number of free inodes. |
| `disk.total_bytes`<br/>`DGAUGE`, bytes | Available space. |
| `disk.total_inodes`<br/>`DGAUGE`, pcs | Available inodes. |
| `disk.used_bytes`<br/>`DGAUGE`, bytes | Used space. |
| `disk.used_inodes`<br/>`DGAUGE`, pcs | Used inodes. |

### Disk operation metrics {#managed-postgresql-diskio-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `io.avg_read_time`<br/>`DGAUGE`, ms | Average disk read time. |
| `io.avg_write_time`<br/>`DGAUGE`, ms | Average disk write time. |
| `io.disk*.avg_read_time`<br/>`DGAUGE`, ms | Average read time for a specific disk. |
| `io.disk*.avg_write_time`<br/>`DGAUGE`, ms | Average write time for a specific disk. |
| `io.disk*.read_bytes`<br/>`DGAUGE`, bytes per second | Read speed for a specific disk. |
| `io.disk*.read_count`<br/>`DGAUGE`, operations per second | Read operations per second for a specific disk. |
| `io.disk*.read_merged_count`<br/>`DGAUGE`, operations per second | Merged read operations per second for a specific disk. |
| `io.disk*.utilization`<br/>`DGAUGE`, % | Utilization of a specific disk. |
| `io.disk*.write_bytes`<br/>`DGAUGE`, bytes per second | Write speed for a specific disk. |
| `io.disk*.write_count`<br/>`DGAUGE`, operations per second | Number of write operations per second for a specific disk. |
| `io.disk*.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second for a specific disk. |
| `io.read_bytes`<br/>`DGAUGE`, bytes per second | Disk read speed. |
| `io.read_count`<br/>`DGAUGE`, operations per second | Number of read operations per second. |
| `io.read_merged_count`<br/>`DGAUGE`, operations per second | Number of merged read operations per second. |
| `io.utilization`<br/>`DGAUGE`, % | Disk utilization. |
| `io.write_bytes`<br/>`DGAUGE`, bytes per second | Disk write speed. |
| `io.write_count`<br/>`DGAUGE`, operations per second | Number of write operations per second. |
| `io.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second. |

### RAM metrics {#managed-postgresql-ram-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.guarantee_bytes`<br/>`DGAUGE`, bytes | Guaranteed memory. |
| `mem.limit_bytes`<br/>`DGAUGE`, bytes | Memory limit. |
| `mem.active_bytes`<br/>`DGAUGE`, bytes | RAM usage, `active` usage type. |
| `mem.available_bytes`<br/>`DGAUGE`, bytes | RAM usage, `available` usage type. |
| `mem.buffers_bytes`<br/>`DGAUGE`, bytes | RAM usage, `buffers` usage type. |
| `mem.cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type. |
| `mem.free_bytes`<br/>`DGAUGE`, bytes | RAM usage, `free` usage type. |
| `mem.shared_bytes`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type. |
| `mem.total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type. |
| `mem.used_bytes`<br/>`DGAUGE`, bytes | RAM usage, `used` usage type. |

### Network metrics {#managed-postgresql-net-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, bytes per second | Rate of receiving data over the network. |
| `net.bytes_sent`<br/>`DGAUGE`, bytes per second | Rate of sending data over the network. |
| `net.dropin`<br/>`DGAUGE`, pcs | Packets dropped upon receipt. |
| `net.dropout`<br/>`DGAUGE`, pcs | Packets dropped when being sent. |
| `net.errin`<br/>`DGAUGE`, pcs | Number of errors upon receipt. |
| `net.errout`<br/>`DGAUGE`, pcs | Number of errors at sending. |
| `net.packets_recv`<br/>`DGAUGE`, packets per second | Rate of receiving packets over the network. |
| `net.packets_sent`<br/>`DGAUGE`, packets per second | Rate of sending packets over the network. |

### Service metrics {#managed-postgresql-metrics}
##### Cluster metrics {#managed-postgresql-cluster-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Read access indicator.<br/>`1` if a cluster is available for reads, `0` if not. |
| `can_write`<br/>`DGAUGE`, 0/1 | Write access indicator.<br/>`1` if a cluster is available for writes, `0` if not. |
| `postgres-is_alive`<br/>`DGAUGE`, 0/1 | Host health indicator.<br/>`1` if a DB host is alive, `0` if not. |
| `postgres-is_primary`<br/>`DGAUGE`, 0/1 | Master host indicator.<br/>`1` if a DB host is a master, `0` if not. |
| `postgres-is_replica`<br/>`DGAUGE`, 0/1 | Replica host indicator.<br/>`1` if a DB host is a replica, `0` if not. |
| `postgres-log_errors`<br/>`DGAUGE`, messages per second | Number of errors logged per second. |
| `postgres-log_fatals`<br/>`DGAUGE`, messages per second | Number of fatal errors logged per second. |
| `postgres-log_slow_queries`<br/>`DGAUGE`, queries per second | Number of slow queries logged per second. |
| `postgres-log_warnings`<br/>`DGAUGE`, messages per second | Number of warnings logged per second. |
| `postgres-replication_lag`<br/>`DGAUGE`, seconds | Replication lag. |
| `postgres_max_connections`<br/>`DGAUGE`, pcs | Maximum number of connections. |
| `postgres_total_connections`<br/>`DGAUGE`, pcs | Number of connections. |

##### DB metrics {#managed-postgresql-db-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `_pg_database_size`<br/>`DGAUGE`, bytes | DB size. <br/>Additional labels: `dbname` |
| `<database>_conn_aborted`<br/>`DGAUGE`, pcs | Number of `<database>` connections. Connection status: `aborted`. |
| `<database>_conn_active`<br/>`DGAUGE`, pcs | Number of `<database>` connections. Connection status: `active`. |
| `<database>_conn_idle`<br/>`DGAUGE`, pcs | Number of `<database>` connections. Connection status: `idle`. |
| `<database>_conn_idle_in_transaction`<br/>`DGAUGE`, pcs | Number of `<database>` connections. Connection status: `idle_in_transaction`. |
| `<database>_conn_waiting`<br/>`DGAUGE`, pcs | Number of `<database>` connections. Connection status: `waiting`. |
| `<database>_tup_deleted`<br/>`DGAUGE`, pcs | Number of rows deleted by queries in this `<database>`. |
| `<database>_tup_fetched`<br/>`DGAUGE`, pcs | Number of rows fetched by queries in this `<database>`. |
| `<database>_tup_inserted`<br/>`DGAUGE`, pcs | Number of rows inserted by queries in this `<database>`. |
| `<database>_tup_returned`<br/>`DGAUGE`, pcs | Number of rows returned by queries in this `<database>`. |
| `<database>_tup_updated`<br/>`DGAUGE`, pcs | Number of rows updated by queries in this `<database>`. |

##### Connection pooler metrics {#managed-postgresql-pooler-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `pooler-avg_query_time`<br/>`DGAUGE`, ms | Average query execution time per DB host. |
| `pooler-avg_xact_time`<br/>`DGAUGE`, ms | Average execution time per transaction per DB host. |
| `pooler-bytes_recieved`<br/>`DGAUGE`, bytes | Bytes received. |
| `pooler-bytes_sent`<br/>`DGAUGE`, bytes | Bytes sent. |
| `pooler-free_clients`<br/>`DGAUGE`, pcs | Number of client connections available in the connection pooler. |
| `pooler-free_servers`<br/>`DGAUGE`, pcs | Number of server connections available in the connection pooler. |
| `pooler-is_alive`<br/>`DGAUGE`, 0/1 | Pooler health for each host either as a master or as a replica. |
| `pooler-pgbouncer_tcp_connections`<br/>`DGAUGE`, connections per second | Number of PostgreSQL TCP connections. |
| `pooler-postgres_tcp_connections`<br/>`DGAUGE`, connections per second | Number of PgBouncer TCP connections. |
| `pooler-query_0.5`<br/>`DGAUGE`, seconds | Query execution time, median value. |
| `pooler-query_0.75`<br/>`DGAUGE`, seconds | Query execution time, 0.75 percentile. |
| `pooler-query_0.9`<br/>`DGAUGE`, seconds | Query execution time, 0.9 percentile. |
| `pooler-query_0.95`<br/>`DGAUGE`, seconds | Query execution time, 0.95 percentile. |
| `pooler-query_0.99`<br/>`DGAUGE`, seconds | Query execution time, 0.99 percentile. |
| `pooler-query_0.999`<br/>`DGAUGE`, seconds | Query execution time, 0.999 percentile. |
| `pooler-query_count`<br/>`DGAUGE`, pcs | Number of queries executed on each DB host. |
| `pooler-total_tcp_connections`<br/>`DGAUGE`, connections per second | Number of PostgreSQL and PgBouncer TCP connections. |
| `pooler-transaction_0.5`<br/>`DGAUGE`, seconds | Transaction handling time, median value |
| `pooler-transaction_0.75`<br/>`DGAUGE`, seconds | Transaction handling time, 0.75 percentile. |
| `pooler-transaction_0.9`<br/>`DGAUGE`, seconds | Transaction handling time, 0.9 percentile. |
| `pooler-transaction_0.95`<br/>`DGAUGE`, seconds | Transaction handling time, 0.95 percentile. |
| `pooler-transaction_0.99`<br/>`DGAUGE`, seconds | Transaction handling time, 0.99 percentile. |
| `pooler-transaction_0.999`<br/>`DGAUGE`, seconds | Transaction handling time, 0.999 percentile. |
| `pooler-used_clients`<br/>`DGAUGE`, pcs | Number of client connections used in the connection pooler. |
| `pooler-used_servers`<br/>`DGAUGE`, pcs | Number of server connections used in the connection pooler. |
| `pooler-xact_count`<br/>`DGAUGE`, pcs | Number of transactions executed on each DB host. |

Read more about the service in the [{{ mpg-full-name }}](../../../managed-postgresql/) documentation.
