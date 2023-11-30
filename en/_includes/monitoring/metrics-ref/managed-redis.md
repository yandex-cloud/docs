## {{ mrd-full-name }} service {#managed-redis}

Common labels for all {{ mrd-full-name }} metrics:

| Label | Value |
----|----
| service | Service ID: `managed-redis` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster ID |
| host | Host FQDN |
| node | Host type: `master` |
| subcluster_name | Subcluster name |

### CPU metrics {#managed-redis-cpu-metrics}
The load on processor cores.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `cpu.fraction`<br/>`DGAUGE`, % | Guaranteed vCPU performance |
| `cpu.guarantee`<br/>`DGAUGE`, pcs | Guaranteed number of cores |
| `cpu.limit`<br/>`DGAUGE`, pcs | Limit on CPUs in use |
| `cpu.guest`<br/>`DGAUGE`, % | CPU usage, `guest` usage type |
| `cpu.idle`<br/>`DGAUGE`, % | CPU usage, `idle` usage type |
| `cpu.iowait`<br/>`DGAUGE`, % | CPU usage, `iowait` usage type |
| `cpu.irq`<br/>`DGAUGE`, % | CPU usage, `irq` usage type |
| `cpu.nice`<br/>`DGAUGE`, % | CPU usage, `nice` usage type |
| `cpu.softirq`<br/>`DGAUGE`, % | CPU usage, `softirq` usage type |
| `cpu.steal`<br/>`DGAUGE`, % | CPU usage, `steal` usage type |
| `cpu.system`<br/>`DGAUGE`, % | CPU usage, `system` usage type |
| `cpu.user`<br/>`DGAUGE`, % | CPU usage, `user` usage type |

### Disk metrics {#managed-redis-disk-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, bytes | Free space |
| `disk.free_inodes`<br/>`DGAUGE`, pcs | Number of free inodes |
| `disk.total_bytes`<br/>`DGAUGE`, bytes | Available space |
| `disk.total_inodes`<br/>`DGAUGE`, pcs | Available inodes |
| `disk.used_bytes`<br/>`DGAUGE`, bytes | Used space |
| `disk.used_inodes`<br/>`DGAUGE`, pcs | Used inodes |

### Disk operation metrics {#managed-redis-diskio-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `io.avg_read_time`<br/>`DGAUGE`, ms | Average disk read time |
| `io.avg_write_time`<br/>`DGAUGE`, ms | Average disk write time |
| `io.disk*.avg_read_time`<br/>`DGAUGE`, ms | Average read time for a specific disk |
| `io.disk*.avg_write_time`<br/>`DGAUGE`, ms | Average write time for a specific disk |
| `io.disk*.read_bytes`<br/>`DGAUGE`, bytes per second | Read speed for a specific disk |
| `io.disk*.read_count`<br/>`DGAUGE`, operations per second | Read operations per second for a specific disk |
| `io.disk*.read_merged_count`<br/>`DGAUGE`, operations per second | Merged read operations per second for a specific disk |
| `io.disk*.utilization`<br/>`DGAUGE`, % | Utilization of a specific disk; disabled for network drives |
| `io.disk*.write_bytes`<br/>`DGAUGE`, bytes per second | Write speed for a specific disk |
| `io.disk*.write_count`<br/>`DGAUGE`, operations per second | Number of write operations per second for a specific disk |
| `io.disk*.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second for a specific disk |
| `io.read_bytes`<br/>`DGAUGE`, bytes per second | Disk read speed |
| `io.read_count`<br/>`DGAUGE`, operations per second | Number of read operations per second |
| `io.read_merged_count`<br/>`DGAUGE`, operations per second | Number of merged read operations per second |
| `io.utilization`<br/>`DGAUGE`, % | Disk utilization |
| `io.write_bytes`<br/>`DGAUGE`, bytes per second | Disk write speed |
| `io.write_count`<br/>`DGAUGE`, operations per second | Number of write operations per second |
| `io.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second |

### RAM metrics {#managed-redis-ram-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.guarantee_bytes`<br/>`DGAUGE`, bytes | Guaranteed memory |
| `mem.limit_bytes`<br/>`DGAUGE`, bytes | Memory limit |
| `mem.active_bytes`<br/>`DGAUGE`, bytes | Amount of RAM used most often and only freed up when absolutely necessary |
| `mem.available_bytes`<br/>`DGAUGE`, bytes | RAM usage, `available` usage type |
| `mem.buffers_bytes`<br/>`DGAUGE`, bytes | RAM usage, `buffers` usage type |
| `mem.cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type |
| `mem.free_bytes`<br/>`DGAUGE`, bytes | Amount of free RAM available, excluding `mem.buffers_bytes` and `mem.cached_bytes` |
| `mem.shared_bytes`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type |
| `mem.total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type |
| `mem.used_bytes`<br/>`DGAUGE`, bytes | Amount of RAM currently used by the running processes |

### Network metrics {#managed-redis-net-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, bytes per second | Rate of receiving data over the network |
| `net.bytes_sent`<br/>`DGAUGE`, bytes per second | Rate of sending data over the network |
| `net.dropin`<br/>`DGAUGE`, pcs | Packets dropped upon receipt |
| `net.dropout`<br/>`DGAUGE`, pcs | Packets dropped when being sent |
| `net.errin`<br/>`DGAUGE`, pcs | Number of errors upon receipt |
| `net.errout`<br/>`DGAUGE`, pcs | Number of errors at sending |
| `net.packets_recv`<br/>`DGAUGE`, packets per second | Rate of receiving packets over the network |
| `net.packets_sent`<br/>`DGAUGE`, packets per second | Rate of sending packets over the network |

### Service metrics {#managed-redis-metrics}
| Name<br/>Type, units | Description |
| ----- |----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `can_read`<br/>`DGAUGE`, 0/1 | Read access indicator.<br/>`1` if a cluster is available for reads, `0` if it is not. |
| `can_write`<br/>`DGAUGE`, 0/1 | Write access indicator.<br/>`1` if a cluster is available for writes, `0` if it is not. |
| `redis_aof_last_cow_size`<br/>`DGAUGE`, bytes | Amount of data copied when creating an AOF file with the [COW (Copy-on-write)](https://en.wikipedia.org/wiki/Copy-on-write) mechanism used |
| `redis_blocked_clients`<br/>`DGAUGE`, pcs | Number of clients waiting for a connection per cluster host |
| `redis_client_output_normal_hard`<br/>`DGAUGE`, bytes | Hard memory usage limit |
| `redis_client_output_normal_soft`<br/>`DGAUGE`, bytes | Soft memory usage limit |
| `redis_client_recent_max_input_buffer`<br/>`DGAUGE`, bytes | Maximum memory usage for serving client connections that are writing data |
| `redis_client_recent_max_output_buffer`<br/>`DGAUGE`, bytes | Maximum memory usage for serving client connections that are reading data |
| `redis_connected_clients`<br/>`DGAUGE`, | Number of open connections per cluster host.<br/>If a cluster is sharded or uses replication, some connections will be used for exchanging data between cluster hosts.<br/>If cluster connection errors occur, perhaps, there are inactive apps that keep connections open for too long. If this is the case, [modify the settings](../../../managed-redis/operations/update.md#change-redis-config) to change the value of the [Timeout](../../../managed-redis/concepts/settings-list.md#settings-timeout) parameter. |
| `redis_db_hashtable_overhead`<br/>`DGAUGE`, bytes | RAM used for storing hash tables of all DBs |
| `redis_dbsize`<br/>`DGAUGE`, pcs | Number of keys stored in all the cluster databases |
| `redis_evicted_keys`<br/>`DGAUGE`, pcs | Number of keys deleted from memory when inserting new data |
| `redis_hit_rate`<br/>`DGAUGE`, % | Percentage of requests for which {{ mrd-full-name }} finds data in the cache |
| `redis_instantaneous_ops_per_sec`<br/>`DGAUGE`, operations per second | Number of requests per second |
| `redis_is_alive`<br/>`DGAUGE` | Host health indicator.<br/>`1` if a DB host is alive, `0` if it is not. |
| `redis_is_master`<br/>`DGAUGE` | Host type indicator.<br/>`1` if it is a DB server master host, `0` if it is not. |
| `redis_keys_db`<br/>`DGAUGE`, pcs | Number of keys stored in a specific cluster database.<br/>Additional labels: `db`. |
| `redis_keyspace_hits`<br/>`DGAUGE`, pcs | Number of successful requests by key |
| `redis_keyspace_misses`<br/>`DGAUGE`, pcs | Number of failed key requests |
| `redis_master_last_io_seconds_ago`<br/>`DGAUGE`, seconds | Number of seconds since the last interaction with the master host |
| `redis_maxmemory`<br/>`DGAUGE`, bytes | Maximum amount of memory allocated for user data |
| `redis_mem_aof_buffer`<br/>`DGAUGE`, bytes | RAM used for the AOF buffer |
| `redis_mem_clients_normal`<br/>`DGAUGE`, bytes | RAM used for serving external connections |
| `redis_mem_clients_slaves`<br/>`DGAUGE`, bytes | RAM used for serving replication connections |
| `redis_mem_fragmentation_ratio`<br/>`GAUGE` | Ratio of used memory to requested memory.<br/>The value is less than `1` if the amount of memory is insufficient. |
| `redis_mem_replication_backlog`<br/>`DGAUGE`, bytes | RAM used for the replication backlog buffer |
| `redis_memory_limit`<br/>`DGAUGE`, bytes | Memory allocated per host |
| `redis_module_fork_last_cow_size`<br/>`DGAUGE`, bytes | Amount of data copied during a fork() call using the COW mechanism |
| `redis_oom_count`<br/>`DGAUGE`, pcs | Number of Out of Memory errors, per hour |
| `redis_rdb_last_cow_size`<br/>`DGAUGE`, bytes | Amount of data copied when creating an RDB file |
| `redis_repl_backlog_histlen`<br/>`DGAUGE`, bytes | Portion of the replication buffer currently in use by data |
| `redis_repl_backlog_size`<br/>`DGAUGE`, | Maximum amount of memory available for the replication buffer |
| `redis_used_memory`<br/>`DGAUGE`, | Actual memory usage by a host. If the value of the `redis_used_memory` parameter reaches `redis_max_memory` when trying to insert new records, {{ mrd-full-name }} will apply the memory management mode defined by the [Maxmemory policy](../../../managed-redis/concepts/settings-list.md#settings-maxmemory-policy) setting. |
| `redis_used_memory_dataset`<br/>`DGAUGE`, bytes | RAM used for storing data |
| `redis_used_memory_rss`<br/>`DGAUGE`, bytes | Memory used by Redis processes |
| `redis_used_memory_scripts`<br/>`DGAUGE`, bytes | RAM used for storing and running scripts |
| `redis_used_memory_startup`<br/>`DGAUGE`, bytes | RAM used for Redis processes at startup (e.g., after restarting a cluster) |
| `slowlog_max_len`<br/>`DGAUGE`, pcs | Maximum number of slow requests logged |

Read more about the service in the [{{ mrd-full-name }}](../../../managed-redis/) documentation.
