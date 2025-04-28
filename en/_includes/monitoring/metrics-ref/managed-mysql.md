The `name` label stores the metric name.

Labels shared by all {{ mmy-name }} metrics: 

Label | Value
----|----
service | Service ID: `managed-mysql`
resource_type | Resource type: `cluster`
resource_id | Cluster ID
host | Host FQDN
node | Host type: `primary` or `replica`

## CPU metrics {#managed-mysql-cpu-metrics}
These metrics show processor core workload.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `cpu.guest`<br/>`DGAUGE`, % | CPU core usage, `guest` usage type | 
| `cpu.guest_nice`<br/>`DGAUGE`, % | CPU core usage, `guest_nice` usage type |
| `cpu.idle`<br/>`DGAUGE`, % | CPU core usage, `idle` usage type | 
| `cpu.iowait`<br/>`DGAUGE`, % | CPU core usage, `iowait` usage type | 
| `cpu.irq`<br/>`DGAUGE`, % | CPU core usage, `irq` usage type | 
| `cpu.nice`<br/>`DGAUGE`, % | CPU core usage, `nice` usage type | 
| `cpu.softirq`<br/>`DGAUGE`, % | CPU core usage, `softirq` usage type | 
| `cpu.steal`<br/>`DGAUGE`, % | CPU core usage, `steal` usage type | 
| `cpu.system`<br/>`DGAUGE`, % | CPU core usage, `system` usage type | 
| `cpu.usage_idle`<br/>`DGAUGE`, % | CPU core usage, `idle` usage type |
| `cpu.user`<br/>`DGAUGE`, % | CPU core usage, `user` usage type |
| `load.avg_15min`<br/>`DGAUGE`, % | Average load over 15 minutes | 
| `load.avg_1min`<br/>`DGAUGE`, % | Average load over one minute | 
| `load.avg_5min`<br/>`DGAUGE`, % | Average load over five minutes |

## Disk metrics {#managed-mysql-disk-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.free`<br/>`DGAUGE`, bytes | Free space |
| `disk.free_bytes`<br/>`DGAUGE`, bytes | Free space | 
| `disk.free_inodes`<br/>`DGAUGE`, count | Free inodes | 
| `disk.inodes_free`<br/>`DGAUGE`, count | Free inodes |
| `disk.inodes_total`<br/>`DGAUGE`, count | Available inodes |
| `disk.inodes_used`<br/>`DGAUGE`, count | Used inodes |
| `disk.inodes_used_percent`<br/>`DGAUGE`, % | Percentage of used inodes |
| `disk.total`<br/>`DGAUGE`, bytes | Available space |
| `disk.total_bytes`<br/>`DGAUGE`, bytes | Available space | 
| `disk.total_inodes`<br/>`DGAUGE`, count | Available inodes | 
| `disk.used`<br/>`DGAUGE`, bytes | Used space |
| `disk.used_bytes`<br/>`DGAUGE`, bytes | Used space | 
| `disk.used_inodes`<br/>`DGAUGE`, count | Used inodes |
| `disk.used_percent`<br/>`DGAUGE`, % | Percentage of used space |
| `disk.used_percent_inodes`<br/>`DGAUGE`, % | Percentage of used inodes |

## Disk I/O metrics {#managed-mysql-diskio-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `io.avg_read_time`<br/>`DGAUGE`, milliseconds | Average disk read time | 
| `io.avg_write_time`<br/>`DGAUGE`, milliseconds | Average disk write time | 
| `io.disk*.avg_read_time`<br/>`DGAUGE`, milliseconds | Average read time for a given disk | 
| `io.disk*.avg_write_time`<br/>`DGAUGE`, milliseconds | Average write time for a given disk | 
| `io.disk*.read_bytes`<br/>`DGAUGE`, bytes per second | Read speed for a given disk | 
| `io.disk*.read_count`<br/>`DGAUGE`, operations per second | Number of reads per second for a given disk | 
| `io.disk*.read_merged_count`<br/>`DGAUGE`, operations per second | Number of merged read operations per second for a given disk | 
| `io.disk*.utilization`<br/>`DGAUGE`, % | Utilization of a given disk; disabled for network drives. | 
| `io.disk*.write_bytes`<br/>`DGAUGE`, bytes per second | Write speed for a given disk | 
| `io.disk*.write_count`<br/>`DGAUGE`, operations per second | Number of writes per second for a given disk | 
| `io.disk*.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second for a given disk |
| `io.read_bytes`<br/>`DGAUGE`, bytes per second | Disk read rate | 
| `io.read_count`<br/>`DGAUGE`, operations per second | Number of read operations per second | 
| `io.read_merged_count`<br/>`DGAUGE`, operations per second | Number of merged read operations per second | 
| `io.utilization`<br/>`DGAUGE`, % | Disk utilization | 
| `io.write_bytes`<br/>`DGAUGE`, bytes per second | Disk write speed | 
| `io.write_count`<br/>`DGAUGE`, operations per second | Number of writes per second | 
| `io.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second |

## RAM metrics {#managed-mysql-ram-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.active_bytes`<br/>`DGAUGE`, bytes | Active resident memory | 
| `mem.available_bytes`<br/>`DGAUGE`, bytes | RAM usage, `available` usage type | 
| `mem.available_percent_bytes`<br/>`DGAUGE`, % | Percentage of RAM usage, `available` usage type |
| `mem.buffers_bytes`<br/>`DGAUGE`, bytes | RAM usage, `buffers` usage type | 
| `mem.cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type | 
| `mem.commit_limit_bytes`<br/>`DGAUGE`, bytes | RAM usage, `commit_limit` usage type |
| `mem.committed_as_bytes`<br/>`DGAUGE`, bytes | RAM usage, `committed_as` usage type |
| `mem.dirty_bytes`<br/>`DGAUGE`, bytes | RAM usage, `dirty` usage type |
| `mem.free_bytes`<br/>`DGAUGE`, bytes | Amount of free RAM available, excluding `mem.buffers_bytes` and `mem.cached_bytes` |
| `mem.high_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, `high_free` usage type |
| `mem.high_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `high_total` usage type |
| `mem.huge_pages_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_free` usage type |
| `mem.huge_page_size_bytes`<br/>`DGAUGE`, bytes | RAM usage, `huge_page_size` usage type |
| `mem.huge_pages_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_total` usage type |
| `mem.inactive_bytes`<br/>`DGAUGE`, bytes | RAM usage, `inactive` usage type |
| `mem.low_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, `low_free` usage type |
| `mem.low_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `low_total` usage type |
| `mem.mapped_bytes`<br/>`DGAUGE`, bytes | RAM usage, `mapped` usage type |
| `mem.page_tables_bytes`<br/>`DGAUGE`, bytes | RAM usage, `page_tables` usage type |
| `mem.shared_bytes`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type | 
| `mem.slab_bytes`<br/>`DGAUGE`, bytes | RAM usage, `slab` usage type |
| `mem.sreclaimable_bytes`<br/>`DGAUGE`, bytes | RAM usage, `sreclaimable` usage type |
| `mem.sunreclaim_bytes`<br/>`DGAUGE`, bytes | RAM usage, `sunreclaim` usage type |
| `mem.swap_cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, `swap_cached` usage type |
| `mem.swap_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, `swap_free` usage type |
| `mem.swap_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `swap_total` usage type |
| `mem.total`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type |
| `mem.total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type | 
| `mem.used`<br/>`DGAUGE`, bytes | RAM usage, `used` usage type |
| `mem.used_bytes`<br/>`DGAUGE`, bytes | Amount of RAM currently used by running processes | 
| `mem.used_percent`<br/>`DGAUGE`, % | Percentage of used RAM |
| `mem.vmalloc_chunk_bytes`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_chunk` usage type |
| `mem.vmalloc_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_total` usage type |
| `mem.vmalloc_used_bytes`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_used` usage type |
| `mem.write_back_bytes`<br/>`DGAUGE`, bytes | RAM usage, `write_back` usage type |
| `mem.write_back_tmp_bytes`<br/>`DGAUGE`, bytes | RAM usage, `write_back_tmp` usage type |

## Network metrics {#managed-mysql-net-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, bytes per second | Network data receive rate | 
| `net.bytes_sent`<br/>`DGAUGE`, bytes per second | Network data transmit rate | 
| `net.dropin`<br/>`DGAUGE`, count | Dropped receive packets | 
| `net.dropout`<br/>`DGAUGE`, count | Dropped transmit packets | 
| `net.errin`<br/>`DGAUGE`, count | Receive error count | 
| `net.errout`<br/>`DGAUGE`, count | Transmit error count | 
| `net.icmpmsg_intype8`<br/>`DGAUGE`, messages | Number of ICMP type 8 (echo request) messages received |
| `net.icmpmsg_outtype0`<br/>`DGAUGE`, messages | Number of ICMP type 0 (echo reply) messages sent |
| `net.icmp_outratelimitglobal`<br/>`DGAUGE`, messages | Number of ICMP messages throttled by global rate limits |
| `net.icmp_outratelimithost`<br/>`DGAUGE`, messages | Number of ICMP messages throttled by host-specific rate limits |
| `net.ip_outtransmits`<br/>`DGAUGE`, packages | Number of successfully sent IP packets |
| `net.packets_recv`<br/>`DGAUGE`, packets per second | Network packet receive rate | 
| `net.packets_sent`<br/>`DGAUGE`, packets per second | Network packet transmit rate | 
| `net.speed`<br/>`DGAUGE`, bits per second | Maximum network data transfer rate for this interface |
| `net.udplite_memerrors`<br/>`DGAUGE`, errors | Number of UDP-Lite out-of-memory errors |
| `net.udp_memerrors`<br/>`DGAUGE`, errors | Number of UDP out-of-memory errors |

## Service metrics {#managed-mysql-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `dbaas_conf.cpu_fraction`<br/>`DGAUGE`, fractions | Fraction of available CPU resources allocated by the service |
| `dbaas_conf.cpu_guarantee`<br/>`DGAUGE`, fractions | Guaranteed fraction of CPU resources allocated by the service |
| `dbaas_conf.cpu_limit`<br/>`DGAUGE`, fractions | Maximum allowed fraction of CPU resource usage |
| `dbaas_conf.hosts_ha`<br/>`DGAUGE`, hosts | Number of hosts set up for high availability |
| `dbaas_conf.hosts.total`<br/>`DGAUGE`, hosts | Total hosts used by the service |
| `disk.mysql.binlogs_bytes`<br/>`DGAUGE`, bytes | Space used by MySQL service logs | 
| `disk.mysql.data_bytes`<br/>`DGAUGE`, bytes | Space used by data | 
| `disk.mysql.default_tablespace_bytes`<br/>`DGAUGE`, bytes | Space used by data in the default tablespace | 
| `disk.mysql.innodb_logs_bytes`<br/>`DGAUGE`, bytes | Space used by InnoDB logs | 
| `disk.mysql.relaylogs_bytes`<br/>`DGAUGE`, bytes | Space used by MySQL service logs | 
| `disk.mysql.temp_tablespace_bytes`<br/>`DGAUGE`, bytes | Space used by data in the temporary tablespace | 
| `disk.mysql.undo_tablespace_bytes`<br/>`DGAUGE`, bytes | Space used by data in the [InnoDB undo tablespace](https://dev.mysql.com/doc/refman/8.0/en/innodb-undo-tablespaces.html) | 
| `mysql.fileio.read_bytes`<br/>`DGAUGE`, bytes per second | Data read speed.<br/>Additional labels: `filetype`. | 
| `mysql.fileio.reads`<br/>`DGAUGE`, operations per second | Average speed of file reads per second.<br/>Additional labels: `filetype`. | 
| `mysql.fileio.write_bytes`<br/>`DGAUGE`, bytes per second | Data write speed.<br/>Additional labels: `filetype`. | 
| `mysql.fileio.writes`<br/>`DGAUGE`, operations per second | Average speed of file writes per second.<br/>Additional labels: `filetype`. | 
| `mysql.handler`<br/>`DGAUGE`, count | Number of handlers of various operations. For more information, see [this MySQL article](https://dev.mysql.com/doc/refman/8.0/en/server-status-variables.html). <br/>Additional labels: `handler`. | 
| `mysql.session`<br/>`DGAUGE`, count | Number of sessions at a certain stage. <br/>Additional labels: `stage`. | 
| `mysql_Aborted_connects_rate`<br/>`DGAUGE`, connections per second | Rate of failed database connection attempts | 
| `mysql_Binlog_cache_disk_use_rate`<br/>`DGAUGE`, transactions per second | Rate of transactions requiring temporary disk file writes due to binlog cache overflowing | 
| `mysql_Binlog_cache_use_rate`<br/>`DGAUGE`, transactions per second | Rate of transactions using the binlog cache | 
| `mysql_Connections_rate`<br/>`DGAUGE`, connections per second | Rate of database connection attempts (both successful and failed) | 
| `mysql_Created_tmp_disk_tables_rate`<br/>`DGAUGE`, tables per second | Rate of temporary tables created on the disk during DB query processing | 
| `mysql_Created_tmp_files_rate`<br/>`DGAUGE`, files per second | Rate of temporary DB file creation | 
| `mysql_Created_tmp_tables_rate`<br/>`DGAUGE`, tables per second | Rate of temporary tables created during DB query processing | 
| `mysql_Innodb_buffer_pool_pages_data`<br/>`DGAUGE`, count | Number of pages with data in the InnoDB buffer. It includes `dirty` and `clean`. | 
| `mysql_Innodb_buffer_pool_pages_dirty`<br/>`DGAUGE`, count | Number of `dirty` pages in the InnoDB buffer | 
| `mysql_Innodb_buffer_pool_pages_free`<br/>`DGAUGE`, count | Number of free pages in the InnoDB buffer | 
| `mysql_Innodb_buffer_pool_pages_misc`<br/>`DGAUGE`, count | Number of service pages in the InnoDB buffer | 
| `mysql_Innodb_buffer_pool_pages_total`<br/>`DGAUGE`, count | Total pages in the InnoDB buffer | 
| `mysql_Innodb_buffer_pool_read_requests_rate`<br/>`DGAUGE`, operations per second | Rate of InnoDB reads | 
| `mysql_Innodb_buffer_pool_reads_rate`<br/>`DGAUGE`, operations per second | Rate of InnoDB reads requiring InnoDB to access the disk | 
| `mysql_Innodb_checkpoint_age`<br/>`DGAUGE`, bytes | Size of InnoDB in-memory data before disk flush | 
| `mysql_Innodb_checkpoint_max_age`<br/>`DGAUGE`, bytes | Maximum size of InnoDB in-memory data before disk flush | 
| `mysql_Innodb_data_fsyncs_rate`<br/>`DGAUGE`, operations per second | Rate of _fsync()_ operations when flushing data to the disk in InnoDB | 
| `mysql_Innodb_data_reads_rate`<br/>`DGAUGE`, operations per second | Disk read rate in InnoDB | 
| `mysql_Innodb_data_writes_rate`<br/>`DGAUGE`, operations per second | Write rate in InnoDB | 
| `mysql_Innodb_page_size`<br/>`DGAUGE`, bytes | Page size in InnoDB (defaults to 16 KB) | 
| `mysql_Innodb_row_lock_current_waits`<br/>`DGAUGE`, count | Number of row locks in InnoDB | 
| `mysql_Innodb_row_lock_time_rate`<br/>`DGAUGE`, milliseconds | Total InnoDB row lock wait time | 
| `mysql_Innodb_row_lock_waits_rate`<br/>`DGAUGE`, operations per second | Rate of InnoDB operations waiting for row locks | 
| `mysql_Innodb_rows_deleted_rate`<br/>`DGAUGE`, rows per second | Rate of rows deleted from InnoDB | 
| `mysql_Innodb_rows_inserted_rate`<br/>`DGAUGE`, rows per second | Rate of rows inserted in InnoDB | 
| `mysql_Innodb_rows_read_rate`<br/>`DGAUGE`, rows per second | Rate of rows read from InnoDB tables | 
| `mysql_Innodb_rows_updated_rate`<br/>`DGAUGE`, rows per second | Rate of rows updated in InnoDB | 
| `mysql_Open_table_definitions`<br/>`DGAUGE`, count | Number of cached table definitions | 
| `mysql_Open_tables`<br/>`DGAUGE`, count | Number of open tables  | 
| `mysql_Opened_table_definitions_rate`<br/>`DGAUGE`, tables per second | Number of table definitions cached per unit of time | 
| `mysql_Opened_tables_rate`<br/>`DGAUGE`, tables per second | Number of tables opened per unit of time | 
| `mysql_Prepared_stmt_count`<br/>`DGAUGE`, count | Number of prepared statements | 
| `mysql_Queries_rate`<br/>`DGAUGE`, queries per second | Number of running queries, including user queries and stored procedures, per unit of time | 
| `mysql_Questions_rate`<br/>`DGAUGE`, queries per second | Number of running user queries per unit of time | 
| `mysql_Rpl_semi_sync_master_clients`<br/>`DGAUGE`, count | Number of semi-sync replicas | 
| `mysql_Rpl_semi_sync_master_tx_avg_wait_time`<br/>`DGAUGE`, microseconds | Average wait time for a transaction on the replication source | 
| `mysql_Rpl_semi_sync_master_tx_wait_time_rate`<br/>`DGAUGE`, microseconds | Total wait time for a transaction on the replication source, per unit of time | 
| `mysql_Rpl_semi_sync_master_wait_sessions`<br/>`DGAUGE`, count | Number of sessions waiting for a response from replicas | 
| `mysql_Select_full_join_rate`<br/>`DGAUGE`, queries per second | Number of joins using table scans rather than indexes | 
| `mysql_Select_full_range_join_rate`<br/>`DGAUGE`, queries per second | Number of joins searching by range in the reference table | 
| `mysql_Slow_queries_rate`<br/>`DGAUGE`, queries per second | Number of slow queries that take more seconds than set in `long_query_time` to run, per unit of time. | 
| `mysql_Sort_range_rate`<br/>`DGAUGE`, queries per second | Number of sorts by range per unit of time | 
| `mysql_Sort_rows_rate`<br/>`DGAUGE`, queries per second | Number of rows sorted per unit of time | 
| `mysql_Sort_scan_rate`<br/>`DGAUGE`, queries per second | Number of sorts using table scans per unit of time | 
| `mysql_Table_locks_immediate`<br/>`DGAUGE`, count | Number of immediate table locks | 
| `mysql_Table_locks_waited`<br/>`DGAUGE`, count | Number of table locks that had to wait  | 
| `mysql_Table_open_cache_hits_rate`<br/>`DGAUGE`, operations per second | Number of hits for open table cache lookups per unit of time | 
| `mysql_Table_open_cache_misses_rate`<br/>`DGAUGE`, operations per second | Number of misses for open table cache lookups per unit of time | 
| `mysql_Threads_cached`<br/>`DGAUGE`, count | Number of cached threads | 
| `mysql_Threads_connected`<br/>`DGAUGE`, count | Number of threads handling open DB connections | 
| `mysql_Threads_created_rate`<br/>`DGAUGE`, threads per second | Number of threads created per unit of time | 
| `mysql_Threads_running`<br/>`DGAUGE`, count | Number of currently running threads | 
| `mysql_Uptime`<br/>`DGAUGE`, seconds | Server uptime | 
| `mysql_config_innodb_buffer_pool_size`<br/>`DGAUGE`, bytes | InnoDB buffer pool size | 
| `mysql_config_innodb_log_file_size`<br/>`DGAUGE`, bytes | Log file size in the log group  | 
| `mysql_config_max_connections`<br/>`DGAUGE`, count | Maximum number of concurrent connections  | 
| `mysql_config_table_open_cache`<br/>`DGAUGE`, count | Number of open tables across all threads | 
| `mysql_config_thread_cache_size`<br/>`DGAUGE`, count | Number of threads to cache for reuse | 
| `mysql_is_alive`<br/>`DGAUGE`, 0/1 | Host health indicator.<br/>It can be either `1` if a DB host is healthy or `0` if it is not. | 
| `mysql_is_primary`<br/>`DGAUGE`, 0/1 | Master host indicator.<br/>It can be either `1` if a DB host is a master or `0` if it is not. | 
| `mysql_is_replica`<br/>`DGAUGE`, 0/1 | Replica host indicator.<br/>It can be either `1` if a DB host is a replica or `0` if it is not.  | 
| `mysql_latency_query_0.5`<br/>`DGAUGE`, milliseconds | Query execution time, median value | 
| `mysql_latency_query_0.75`<br/>`DGAUGE`, milliseconds | Query execution time, 75th percentile | 
| `mysql_latency_query_0.90`<br/>`DGAUGE`, milliseconds | Query execution time, 90th percentile | 
| `mysql_latency_query_0.95`<br/>`DGAUGE`, milliseconds | Query execution time, 95th percentile | 
| `mysql_latency_query_0.99`<br/>`DGAUGE`, milliseconds | Query execution time, 99th percentile | 
| `mysql_latency_query_avg`<br/>`DGAUGE`, milliseconds | Average query execution time | 
| `mysql_latency_query_oldest`<br/>`DGAUGE`, milliseconds | Execution time of the oldest query | 
| `mysql_latency_trx_0.5`<br/>`DGAUGE`, milliseconds | Transaction execution time, median value | 
| `mysql_latency_trx_0.75`<br/>`DGAUGE`, milliseconds | Transaction execution time, 75th percentile | 
| `mysql_latency_trx_0.90`<br/>`DGAUGE`, milliseconds | Transaction execution time, 90th percentile | 
| `mysql_latency_trx_0.95`<br/>`DGAUGE`, milliseconds | Transaction execution time, 95th percentile | 
| `mysql_latency_trx_0.99`<br/>`DGAUGE`, milliseconds | Transaction execution time, 99th percentile | 
| `mysql_latency_trx_avg`<br/>`DGAUGE`, milliseconds | Average transaction execution time | 
| `mysql_latency_trx_oldest`<br/>`DGAUGE`, milliseconds | Execution time of the oldest transaction | 
| `mysql_replication_lag`<br/>`DGAUGE`, seconds | Replica's lag behind the master | 
| `mysql_replication_io_thread_running`<br/>`DGAUGE`, 0/1 | State of {{ MY }} replication I/O thread.</br>It can be either `1` if the thread is running or `0` if it is stopped.</li></ul> |
| `mysql_replication_sql_thread_running`<br/>`DGAUGE`, 0/1 | State of {{ MY }} replication SQL thread.</br>It can be either `1` if the thread is running or `0` if it is stopped.</li></ul> |
| `mysql_role`<br/>`DGAUGE`, 1/2 | Current MySQL server role in the replication.<br/>It can be either `2` if the server is a replica (secondary server) or `1` if it is a master (primary server). | 
| `mysql_writable`<br/>`DGAUGE`, 0/1 | Server write access.<br/>It can be either `1` if a server is available for writes or `0` if it is not. | 

## Other metrics {#managed-mysql-other-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Read access indicator.<br/>It can be either `1` if a cluster is available for reads or `0` if it is not. | 
| `can_write`<br/>`DGAUGE`, 0/1 | Write access indicator.<br/>It can be either `1` if a cluster is available for writes or `0` if it is not. | 
| `core_dump_count`<br/>`DGAUGE`, number | Number of core dumps |
| `n_unique_users`<br/>`DGAUGE`, users | Number of unique users or accounts engaging with the system |