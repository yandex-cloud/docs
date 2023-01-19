## {{ mmy-full-name }} {#managed-mysql}

Common labels for all {{ mmy-full-name }} service metrics:

| Label | Value |
| ----- | ----- |
| service | Service ID: `managed-mysql` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster ID |
| host | Host FQDN |
| node | Host type: `primary`, `replica` |

### CPU metrics {#managed-mysql-cpu-metrics}
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

### Disk metrics {#managed-mysql-disk-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, bytes | Free space. |
| `disk.free_inodes`<br/>`DGAUGE`, pcs | Number of free inodes. |
| `disk.total_bytes`<br/>`DGAUGE`, bytes | Available space. |
| `disk.total_inodes`<br/>`DGAUGE`, pcs | Available inodes. |
| `disk.used_bytes`<br/>`DGAUGE`, bytes | Used space. |
| `disk.used_inodes`<br/>`DGAUGE`, pcs | Used inodes. |

### Disk operation metrics {#managed-mysql-diskio-metrics}
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

### RAM metrics {#managed-mysql-ram-metrics}
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

### Network metrics {#managed-mysql-net-metrics}
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

### Service metrics {#managed-mysql-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.mysql.binlogs_bytes`<br/>`DGAUGE`, bytes | Space used by MySQL service logs. |
| `disk.mysql.data_bytes`<br/>`DGAUGE`, bytes | Space used by data. |
| `disk.mysql.default_tablespace_bytes`<br/>`DGAUGE`, bytes | Space used by data in the default tablespace. |
| `disk.mysql.innodb_logs_bytes`<br/>`DGAUGE`, bytes | Space used by InnoDB logs. |
| `disk.mysql.relaylogs_bytes`<br/>`DGAUGE`, bytes | Space used by MySQL service logs. |
| `disk.mysql.temp_tablespace_bytes`<br/>`DGAUGE`, bytes | Space used by data in the temporary tablespace. |
| `disk.mysql.undo_tablespace_bytes`<br/>`DGAUGE`, bytes | Space used by data in the[InnoDB undo tablespace](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html). |
| `mysql.fileio.read_bytes`<br/>`DGAUGE`, bytes per second | Data read speed.<br/>Additional labels: `filetype` |
| `mysql.fileio.reads`<br/>`DGAUGE`, operations per second | Average speed of file reads per second.<br/>Additional labels: `filetype` |
| `mysql.fileio.write_bytes`<br/>`DGAUGE`, bytes per second | Data write speed.<br/>Additional labels: `filetype` |
| `mysql.fileio.writes`<br/>`DGAUGE`, operations per second | Average speed of file writes per second.<br/>Additional labels: `filetype` |
| `mysql.handler`<br/>`DGAUGE`, pcs | Number of handlers of various operations. For more information, see the [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/server-status-variables.html). <br/>Additional labels: `handler` |
| `mysql.session`<br/>`DGAUGE`, pcs | Number of sessions at a certain stage. <br/>Additional labels: `stage` |
| `mysql_Aborted_connects_rate`<br/>`DGAUGE`, connections per second | Number of failed attempts to connect to the DB. |
| `mysql_Binlog_cache_disk_use_rate`<br/>`DGAUGE`, transactions per second | Number of transactions that used the Binlog cache but exceeded its size and had to write data to a temporary disk file. |
| `mysql_Binlog_cache_use_rate`<br/>`DGAUGE`, transactions per second | Number of transactions that used the Binlog cache. |
| `mysql_Connections_rate`<br/>`DGAUGE`, connections per second | Attempts to connect to the DB (successful and failed). |
| `mysql_Created_tmp_disk_tables_rate`<br/>`DGAUGE`, tables per second | Number of temporary tables created on disk when handling DB queries. |
| `mysql_Created_tmp_files_rate`<br/>`DGAUGE`, files per second | Number of temporary DB files. |
| `mysql_Created_tmp_tables_rate`<br/>`DGAUGE`, tables per second | Number of temporary tables created when handling DB queries. |
| `mysql_Innodb_buffer_pool_pages_data`<br/>`DGAUGE`, pcs | Number of pages with data in the InnoDB buffer. Includes `dirty` and `clean`. |
| `mysql_Innodb_buffer_pool_pages_dirty`<br/>`DGAUGE`, pcs | Number of `dirty` pages in the InnoDB buffer. |
| `mysql_Innodb_buffer_pool_pages_free`<br/>`DGAUGE`, pcs | Number of free pages in the InnoDB buffer. |
| `mysql_Innodb_buffer_pool_pages_misc`<br/>`DGAUGE`, pcs | Number of service pages in the InnoDB buffer. |
| `mysql_Innodb_buffer_pool_pages_total`<br/>`DGAUGE`, pcs | Number of pages in the InnoDB buffer. |
| `mysql_Innodb_buffer_pool_read_requests_rate`<br/>`DGAUGE`, operations per second | Number of InnoDB reads. |
| `mysql_Innodb_buffer_pool_reads_rate`<br/>`DGAUGE`, operations per second | Number of InnoDB reads to handle which InnoDB has to access the disk. |
| `mysql_Innodb_checkpoint_age`<br/>`DGAUGE`, bytes | Size of data in InnoDB memory before being flushed to the disk. |
| `mysql_Innodb_checkpoint_max_age`<br/>`DGAUGE`, bytes | Maximum size of data in InnoDB memory before being flushed to the disk. |
| `mysql_Innodb_data_fsyncs_rate`<br/>`DGAUGE`, operations per second | Number of _fsync()_ operations when flushing data to the disk in InnoDB. |
| `mysql_Innodb_data_reads_rate`<br/>`DGAUGE`, operations per second | Number of disk reads in InnoDB. |
| `mysql_Innodb_data_writes_rate`<br/>`DGAUGE`, operations per second | Write rate in InnoDB. |
| `mysql_Innodb_page_size`<br/>`DGAUGE`, bytes | Page size in InnoDB (defaults to 16 KB). |
| `mysql_Innodb_row_lock_current_waits`<br/>`DGAUGE`, pcs | Number of row locks in InnoDB. |
| `mysql_Innodb_row_lock_time_rate`<br/>`DGAUGE`, ms | Total waiting time for row locks in InnoDB. |
| `mysql_Innodb_row_lock_waits_rate`<br/>`DGAUGE`, operations per second | Number of InnoDB operations that had to wait for row locks. |
| `mysql_Innodb_rows_deleted_rate`<br/>`DGAUGE`, rows per second | Rows deleted in InnoDB. |
| `mysql_Innodb_rows_inserted_rate`<br/>`DGAUGE`, rows per second | Rows inserted in InnoDB. |
| `mysql_Innodb_rows_read_rate`<br/>`DGAUGE`, rows per second | Rows read from InnoDB tables. |
| `mysql_Innodb_rows_updated_rate`<br/>`DGAUGE`, rows per second | Rows updated in InnoDB. |
| `mysql_Open_table_definitions`<br/>`DGAUGE`, pcs | Number of cached table definitions. |
| `mysql_Open_tables`<br/>`DGAUGE`, pcs | Number of open tables. |
| `mysql_Opened_table_definitions_rate`<br/>`DGAUGE`, tables per second | Number of table definitions cached per unit of time. |
| `mysql_Opened_tables_rate`<br/>`DGAUGE`, tables per second | Number of table definitions opened per unit of time. |
| `mysql_Prepared_stmt_count`<br/>`DGAUGE`, pcs | Prepared statements. |
| `mysql_Queries_rate`<br/>`DGAUGE`, queries per second | Number of active queries, including user queries and stored procedures, per unit of time. |
| `mysql_Questions_rate`<br/>`DGAUGE`, queries per second | Number of active user queries per unit of time. |
| `mysql_Rpl_semi_sync_master_clients`<br/>`DGAUGE`, pcs | Number of semi-sync replicas. |
| `mysql_Rpl_semi_sync_master_tx_avg_wait_time`<br/>`DGAUGE`, microseconds | Average waiting time for a transaction by the replication source. |
| `mysql_Rpl_semi_sync_master_tx_wait_time_rate`<br/>`DGAUGE`, microseconds | Total waiting time for a transaction by the replication source, per unit of time. |
| `mysql_Rpl_semi_sync_master_wait_sessions`<br/>`DGAUGE`, pcs | Number of sessions waiting for a response from replicas. |
| `mysql_Select_full_join_rate`<br/>`DGAUGE`, queries per second | Number of Joins that use table scans instead of indexes. |
| `mysql_Select_full_range_join_rate`<br/>`DGAUGE`, queries per second | Number of Joins that search by range in a reference table. |
| `mysql_Slow_queries_rate`<br/>`DGAUGE`, queries per second | Number of slow queries that take more seconds than set in `long_query_time` to execute, per unit of time. |
| `mysql_Sort_range_rate`<br/>`DGAUGE`, queries per second | Number of sorts by range per unit of time. |
| `mysql_Sort_rows_rate`<br/>`DGAUGE`, queries per second | Number of rows sorted per unit of time. |
| `mysql_Sort_scan_rate`<br/>`DGAUGE`, queries per second | Number of sorts using table scans per unit of time. |
| `mysql_Table_locks_immediate`<br/>`DGAUGE`, pcs | Number of immediate table locks. |
| `mysql_Table_locks_waited`<br/>`DGAUGE`, pcs | Number of table locks that had to wait. |
| `mysql_Table_open_cache_hits_rate`<br/>`DGAUGE`, operations per second | Number of hits for a search in the cache of open tables per unit of time. |
| `mysql_Table_open_cache_misses_rate`<br/>`DGAUGE`, operations per second | Number of failed attempts to search in the cache of open tables per unit of time. |
| `mysql_Threads_cached`<br/>`DGAUGE`, pcs | Number of threads cached. |
| `mysql_Threads_connected`<br/>`DGAUGE`, pcs | Number of threads handling open DB connections. |
| `mysql_Threads_created_rate`<br/>`DGAUGE`, threads per second | Number of threads created per unit of time. |
| `mysql_Threads_running`<br/>`DGAUGE`, pcs | Number of threads running at the moment. |
| `mysql_config_innodb_buffer_pool_size`<br/>`DGAUGE`, bytes | Size of the InnoDB buffer pool. |
| `mysql_config_innodb_log_file_size`<br/>`DGAUGE`, bytes | Log file size in the log group. |
| `mysql_config_max_connections`<br/>`DGAUGE`, pcs | Maximum number of concurrent connections. |
| `mysql_config_table_open_cache`<br/>`DGAUGE`, pcs | Number of open tables cache for all threads. |
| `mysql_config_thread_cache_size`<br/>`DGAUGE`, number | Number of threads that need to be cached to be reused. |
| `mysql_is_alive`<br/>`DGAUGE`, 0/1 | Host performance indicator.<br/>`1` if a DB host is alive, `0` if not. |
| `mysql_is_primary`<br/>`DGAUGE`, 0/1 | Master host indicator.<br/>`1` if a DB host is a master, `0` if not. |
| `mysql_is_replica`<br/>`DGAUGE`, 0/1 | Replica host indicator.<br/>`1` if a DB host is a replica, `0` if not. |
| `mysql_latency_query_0.5`<br/>`DGAUGE`, seconds | Query execution time, median value. |
| `mysql_latency_query_0.75`<br/>`DGAUGE`, seconds | Query execution time, 0.75 percentile. |
| `mysql_latency_query_0.90`<br/>`DGAUGE`, seconds | Query execution time, 0.90 percentile. |
| `mysql_latency_query_0.95`<br/>`DGAUGE`, seconds | Query execution time, 0.95 percentile. |
| `mysql_latency_query_0.99`<br/>`DGAUGE`, seconds | Query execution time, 0.99 percentile. |
| `mysql_latency_query_avg`<br/>`DGAUGE`, seconds | Average query execution time. |
| `mysql_replication_lag`<br/>`DGAUGE`, seconds | Time that a replica lags behind the master. |

### Other metrics {#managed-mysql-other-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Read access indicator.<br/>`1` if a cluster is available for reads, `0` if not. |
| `can_write`<br/>`DGAUGE`, 0/1 | Write access indicator.<br/>`1` if a cluster is available for writes, `0` if not. |

Read more about the service in the [{{ mmy-full-name }}](../../../managed-mysql/) documentation.
