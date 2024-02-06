## {{ mpg-full-name }} {#managed-postgresql}

Common labels for all {{ mpg-name }} metrics:

| Label | Value |
| ----- | ----- |
| service | Service ID: `managed-postgresql` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster ID |
| host | Host FQDN |
| node | Host type: `primary`, `replica` |
| subcluster_name | Subcluster name |

### CPU metrics {#managed-postgresql-cpu-metrics}
Processor core workload.

| Name<br/>Type, unit | Description |
| ----- | ----- |
| `cpu.guest`<br/>`DGAUGE`, % | CPU core usage, `guest` usage type |
| `cpu.idle`<br/>`DGAUGE`, % | CPU core usage, `idle` usage type |
| `cpu.iowait`<br/>`DGAUGE`, % | CPU core usage, `iowait` usage type |
| `cpu.irq`<br/>`DGAUGE`, % | CPU core usage, `irq` usage type |
| `cpu.nice`<br/>`DGAUGE`, % | CPU core usage, `nice` usage type |
| `cpu.softirq`<br/>`DGAUGE`, % | CPU core usage, `softirq` usage type |
| `cpu.steal`<br/>`DGAUGE`, % | CPU core usage, `steal` usage type |
| `cpu.system`<br/>`DGAUGE`, % | CPU core usage, `system` usage type |
| `cpu.user`<br/>`DGAUGE`, % | CPU core usage, `user` usage type |
| `load.avg_15min`<br/>`DGAUGE`, % | Average load over 15 minutes |
| `load.avg_1min`<br/>`DGAUGE`, % | Average load over 1 minute |
| `load.avg_5min`<br/>`DGAUGE`, % | Average load over 5 minutes |
| `pg_backend_cpu`<br/>`DGAUGE`, % | CPU usage by the {{ PG }} process |

### Disk metrics {#managed-postgresql-disk-metrics}
| Name<br/>Type, unit | Description |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, bytes | Free space |
| `disk.free_inodes`<br/>`DGAUGE`, number | Number of free inodes |
| `disk.temp_files_size`<br/>`DGAUGE`, bytes | Size of temporary files |
| `disk.total_bytes`<br/>`DGAUGE`, bytes | Available space |
| `disk.total_inodes`<br/>`DGAUGE`, number | Available inodes |
| `disk.used_bytes`<br/>`DGAUGE`, bytes | Used space |
| `disk.used_inodes`<br/>`DGAUGE`, number | Used inodes |
| `disk.wal_size`<br/>`DGAUGE`, bytes | Write-ahead log (WAL) size |
| `pg_backend_read_bytes`<br>`DGAUGE`, bytes/s | Rate of data reads by the {{ PG }} process |
| `pg_backend_write_bytes`<br>`DGAUGE`, bytes/s | Rate of data writes by the {{ PG }} process |

### Disk operation metrics {#managed-postgresql-diskio-metrics}
| Name<br/>Type, unit | Description |
| ----- | ----- |
| `io.avg_read_time`<br/>`DGAUGE`, ms | Average disk read time |
| `io.avg_write_time`<br/>`DGAUGE`, ms | Average disk write time |
| `io.disk*.avg_read_time`<br/>`DGAUGE`, ms | Average read time for a specific disk |
| `io.disk*.avg_write_time`<br/>`DGAUGE`, ms | Average write time for a specific disk |
| `io.disk*.read_bytes`<br/>`DGAUGE`, bytes/s | Read speed for a specific disk |
| `io.disk*.read_count`<br/>`DGAUGE`, operations per second | Read operations per second for a specific disk |
| `io.disk*.read_merged_count`<br/>`DGAUGE`, operations per second | Merged read operations per second for a specific disk |
| `io.disk*.utilization`<br/>`DGAUGE`, % | Utilization of a specific disk; disabled for network drives |
| `io.disk*.write_bytes`<br/>`DGAUGE`, bytes/s | Write speed for a specific disk |
| `io.disk*.write_count`<br/>`DGAUGE`, operations per second | Number of write operations per second for a specific disk |
| `io.disk*.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second for a specific disk |
| `io.read_bytes`<br/>`DGAUGE`, bytes/s | Disk read speed |
| `io.read_count`<br/>`DGAUGE`, operations per second | Number of read operations per second |
| `io.read_merged_count`<br/>`DGAUGE`, operations per second | Number of merged read operations per second |
| `io.utilization`<br/>`DGAUGE`, % | Disk utilization |
| `io.write_bytes`<br/>`DGAUGE`, bytes/s | Disk write speed |
| `io.write_count`<br/>`DGAUGE`, operations per second | Number of write operations per second |
| `io.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second |

### RAM metrics {#managed-postgresql-ram-metrics}
| Name<br/>Type, unit | Description |
| ----- | ----- |
| `mem.active_bytes`<br/>`DGAUGE`, bytes | Amount of RAM used most often and only freed up when absolutely necessary |
| `mem.available_bytes`<br/>`DGAUGE`, bytes | RAM usage, `available` usage type |
| `mem.buffers_bytes`<br/>`DGAUGE`, bytes | RAM usage, `buffers` usage type |
| `mem.cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type |
| `mem.free_bytes`<br/>`DGAUGE`, bytes | Amount of free RAM available, excluding `mem.buffers_bytes` and `mem.cached_bytes` |
| `mem.shared_bytes`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type |
| `mem.total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type |
| `mem.used_bytes`<br/>`DGAUGE`, bytes | Amount of RAM currently used by the running processes |
| `oom_count`<br/>`DGAUGE`, pieces | Number of out-of-memory (OOM) events |

### Network metrics {#managed-postgresql-net-metrics}
| Name<br/>Type, unit | Description |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, bytes/s | Rate of receiving data over the network |
| `net.bytes_sent`<br/>`DGAUGE`, bytes/s | Rate of sending data over the network |
| `net.dropin`<br/>`DGAUGE`, number | Packets dropped upon receipt |
| `net.dropout`<br/>`DGAUGE`, number | Packets dropped when being sent |
| `net.errin`<br/>`DGAUGE`, number | Number of errors upon receipt |
| `net.errout`<br/>`DGAUGE`, number | Number of errors at sending |
| `net.packets_recv`<br/>`DGAUGE`, packets per second | Rate of receiving packets over the network |
| `net.packets_sent`<br/>`DGAUGE`, packets per second | Rate of sending packets over the network |

### Service metrics {#managed-postgresql-metrics}
##### Cluster metrics {#managed-postgresql-cluster-metrics}
| Name<br/>Type, unit | Description |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Read access indicator.<br/>`1` if a cluster is available for reads, `0` if it is not. |
| `can_write`<br/>`DGAUGE`, 0/1 | Write access indicator.<br/>`1` if a cluster is available for writes, `0` if it is not. |
| `postgres-is_alive`<br/>`DGAUGE`, 0/1 | Host health indicator.<br/>`1` if a DB host is alive, `0` if it is not. |
| `postgres-is_primary`<br/>`DGAUGE`, 0/1 | Master host indicator.<br/>`1` if a DB host is a master, `0` if it is not. |
| `postgres-is_replica`<br/>`DGAUGE`, 0/1 | Replica host indicator.<br/>`1` if a DB host is a replica, `0` if it is not. |
| `postgres-log_errors`<br/>`DGAUGE`, messages per second | Number of errors logged per second |
| `postgres-log_fatals`<br/>`DGAUGE`, messages per second | Number of fatal errors logged per second |
| `postgres-log_slow_queries`<br/>`DGAUGE`, queries per second | Number of slow queries logged per second |
| `postgres-log_warnings`<br/>`DGAUGE`, messages per second | Number of warnings logged per second |
| `postgres-replication_lag`<br/>`DGAUGE`, seconds | Replication lag |
| `postgres_max_connections`<br/>`DGAUGE`, number | Maximum number of connections |
| `postgres-oldest_inactive_replication_slot_duration`<br/>`DGAUGE`, seconds | Duration of the oldest inactive replication slot |
| `postgres_oldest_prepared_xact_duration`<br/>`DGAUGE`, seconds | Duration of the oldest prepared transaction |
| `postgres_oldest_query_duration`<br/>`DGAUGE`, seconds | Duration of the oldest query |
| `postgres_oldest_transaction_duration`<br/>`DGAUGE`, seconds | Duration of the oldest transaction |
| `postgres_role_conn_limit`<br/>`DGAUGE`, number | Maximum allowed number of concurrent user sessions |
| `postgres_role_total_conn_limit`<br/>`DGAUGE`, number | Maximum allowed number of concurrent sessions of all users |
| `postgres_total_connections`<br/>`DGAUGE`, number | Number of connections |
| `postgres_wal_rate_bytes`<br/>`DGAUGE`, bytes | Write-ahead logging rate |
| `postgres_xid_left`<br/>`DGAUGE`, number | Number of transaction counters left |
| `postgres_xid_left_percent`<br/>`DGAUGE`, % | Percentage of transaction counters left |
| `postgres_xid_used_percent`<br/>`DGAUGE`, % | Percentage of transaction counters used |

##### DB metrics {#managed-postgresql-db-metrics}
| Name<br/>Type, unit | Description |
| ----- | ----- |
| `_pg_database_size`<br/>`DGAUGE`, bytes | DB size. <br/>Additional labels: `dbname` |
| `<database>_tup_deleted`<br/>`DGAUGE`, number | Number of rows deleted by queries in this `<database>` |
| `<database>_tup_fetched`<br/>`DGAUGE`, number | Number of rows fetched by queries in this `<database>` |
| `<database>_tup_inserted`<br/>`DGAUGE`, number | Number of rows inserted by queries in this `<database>` |
| `<database>_tup_returned`<br/>`DGAUGE`, number | Number of rows returned by queries in this `<database>` |
| `<database>_tup_updated`<br/>`DGAUGE`, number | Number of rows updated by queries in this `<database>` |

##### Connection pooler metrics {#managed-postgresql-pooler-metrics}
| Name<br/>Type, unit | Description |
| ----- | ----- |
| `pooler-avg_query_time`<br/>`DGAUGE`, ms | Average query execution time per DB host |
| `pooler-avg_xact_time`<br/>`DGAUGE`, ms | Average execution time per transaction per DB host |
| `pooler-bytes_recieved`<br/>`DGAUGE`, bytes | Bytes received |
| `pooler-bytes_recieved-<DB_name>-<username>`<br/>`DGAUGE`, bytes | Amount of data received by `<username>` through `<DB_name>` |
| `pooler-bytes_sent`<br/>`DGAUGE`, bytes | Bytes sent |
| `pooler-bytes_sent-<DB_name>-<username>`<br/>`DGAUGE`, bytes | Amount of data sent by `<username>` through `<DB_name>` |
| `pooler-free_clients`<br/>`DGAUGE`, number | Number of client connections left in the connection pooler |
| `pooler-free_servers`<br/>`DGAUGE`, number | Number of server connections left in the connection pooler |
| `pooler-is_alive`<br/>`DGAUGE`, 0/1 | Connection pooler health for each host either as a master or as a replica |
| `pooler-login_clients`<br/>`DGAUGE`, number | Number of client connections established in the connection pooler |
| `pooler-pgbouncer_tcp_connections`<br/>`DGAUGE`, connections per second | Number of PostgreSQL TCP connections |
| `pooler-postgres_tcp_connections`<br/>`DGAUGE`, connections per second | Number of PgBouncer TCP connections |
| `pooler-query_0.5`<br/>`DGAUGE`, seconds | Query execution time, median value |
| `pooler-query_0.5-<DB_name>-<username>`<br/>`DGAUGE`, seconds | Query execution time for queries made by `<username>` through `<DB_name>` |
| `pooler-query_0.75`<br/>`DGAUGE`, seconds | Query execution time, 0.75 percentile |
| `pooler-query_0.75-<DB_name>-<username>`<br/>`DGAUGE`, seconds | Query execution time for queries made by `<username>` through `<DB_name>`, 0.75 percentile |
| `pooler-query_0.9`<br/>`DGAUGE`, seconds | Query execution time, 0.9 percentile |
| `pooler-query_0.9-<DB_name>-<username>`<br/>`DGAUGE`, seconds | Query execution time for queries made by `<username>` through `<DB_name>`, 0.9 percentile |
| `pooler-query_0.95`<br/>`DGAUGE`, seconds | Query execution time, 0.95 percentile |
| `pooler-query_0.95-<DB_name>-<username>`<br/>`DGAUGE`, seconds | Query execution time for queries made by `<username>` through `<DB_name>`, 0.95 percentile |
| `pooler-query_0.99`<br/>`DGAUGE`, seconds | Query execution time, 0.99 percentile |
| `pooler-query_0.99-<DB_name>-<username>`<br/>`DGAUGE`, seconds | Query execution time for queries made by `<username>` through `<DB_name>`, 0.99 percentile |
| `pooler-query_0.999`<br/>`DGAUGE`, seconds | Query execution time, 0.999 percentile |
| `pooler-query_0.999-<DB_name>-<username>`<br/>`DGAUGE`, seconds | Query execution time for queries made by `<username>` through `<DB_name>`, 0.999 percentile |
| `pooler-query_count`<br/>`DGAUGE`, number | Number of queries executed on each DB host |
| `pooler-tcp_conn_count`<br/>`DGAUGE`, number | Number of TCP connections to each database host |
| `pooler-tcp_conn_count-<DB_name>-<username>`<br/>`DGAUGE`, number | Number of TCP connections to each DB host established by `<username>` through `<DB_name>` |
| `pooler-total_tcp_connections`<br/>`DGAUGE`, connections per second | Number of PostgreSQL and PgBouncer TCP connections |
| `pooler-transaction_0.5`<br/>`DGAUGE`, seconds | Transaction handling time, median value |
| `pooler-transaction_0.5-<DB_name>-<username>`<br/>`DGAUGE`, seconds | Transaction handling time for transactions executed by `<username>` through `<DB_name>`, median value |
| `pooler-transaction_0.75`<br/>`DGAUGE`, seconds | Transaction handling time, 0.75 percentile |
| `pooler-transaction_0.75-<DB_name>-<username>`<br/>`DGAUGE`, seconds | Transaction handling time for transactions executed by `<username>` through `<DB_name>`, 0.75 percentile |
| `pooler-transaction_0.9`<br/>`DGAUGE`, seconds | Transaction handling time, 0.9 percentile |
| `pooler-transaction_0.9-<DB_name>-<username>`<br/>`DGAUGE`, seconds | Transaction handling time for transactions executed by `<username>` through `<DB_name>`, 0.9 percentile |
| `pooler-transaction_0.95`<br/>`DGAUGE`, seconds | Transaction handling time, 0.95 percentile |
| `pooler-transaction_0.95-<DB_name>-<username>`<br/>`DGAUGE`, seconds | Transaction handling time for transactions executed by `<username>` through `<DB_name>`, 0.95 percentile |
| `pooler-transaction_0.99`<br/>`DGAUGE`, seconds | Transaction handling time, 0.99 percentile |
| `pooler-transaction_0.99-<DB_name>-<username>`<br/>`DGAUGE`, seconds | Transaction handling time for transactions executed by `<username>` through `<DB_name>`, 0.99 percentile |
| `pooler-transaction_0.999`<br/>`DGAUGE`, seconds | Transaction handling time, 0.999 percentile |
| `pooler-transaction_0.999-<DB_name>-<username>`<br/>`DGAUGE`, seconds | Transaction handling time for transactions executed by `<username>` through `<DB_name>`, 0.999 percentile |
| `pooler-used_clients`<br/>`DGAUGE`, number | Number of client connections in the connection pooler |
| `pooler-used_servers`<br/>`DGAUGE`, number | Number of server connections in the connection pooler |
| `pooler-xact_count`<br/>`DGAUGE`, number | Number of transactions executed on each DB host |

Read more about the service in the [{{ mpg-name }}](../../../managed-postgresql/) documentation.
