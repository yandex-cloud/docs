The name of the metric is written in the `name` label.

Common labels for all {{ mrd-name }} metrics:

| Label | Value |
----|----
| service | Service ID: `managed-redis` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster ID |
| host | Host FQDN |
| node | Host type: `master` |
| subcluster_name | Subcluster name |

## CPU metrics {#managed-redis-cpu-metrics}
Processor core workload.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `cpu.fraction`<br/>`DGAUGE`, % | Guaranteed vCPU share |
| `cpu.guarantee`<br/>`DGAUGE`, number | Guaranteed number of cores |
| `cpu.guest`<br/>`DGAUGE`, % | CPU core usage, `guest` usage type |
| `cpu.guest_nice`<br/>`DGAUGE`, % | CPU core usage, `guest_nice` usage type |
| `cpu.limit`<br/>`DGAUGE`, number | Limit on CPU cores in use |
| `cpu.idle`<br/>`DGAUGE`, % | CPU core usage, `idle` usage type |
| `cpu.iowait`<br/>`DGAUGE`, % | CPU core usage, `iowait` usage type |
| `cpu.irq`<br/>`DGAUGE`, % | CPU core usage, `irq` usage type |
| `cpu.nice`<br/>`DGAUGE`, % | CPU core usage, `nice` usage type |
| `cpu.softirq`<br/>`DGAUGE`, % | CPU core usage, `softirq` usage type |
| `cpu.steal`<br/>`DGAUGE`, % | CPU core usage, `steal` usage type |
| `cpu.system`<br/>`DGAUGE`, % | CPU core usage, `system` usage type |
| `cpu.user`<br/>`DGAUGE`, % | CPU core usage, `user` usage type |
| `cpu_utilization_by_db_15`<br/>`DGAUGE`, % | Average VM processor core (vCPUs) utilization by a database over 15 seconds (%). Ranges from 0% to the [vCPU performance level](../../../compute/concepts/performance-levels.md). |
| `cpu_utilization_by_db_15_limit`<br/>`DGAUGE`, % | Maximum VM processor core (vCPUs) utilization by a database over 15 seconds (%) |
| `cpu_utilization_by_db_60`<br/>`DGAUGE`, % | Average VM processor core (vCPUs) utilization by a database over 60 seconds (%) |
| `cpu_utilization_by_db_60_limit`<br/>`DGAUGE`, % | Maximum VM processor core (vCPUs) utilization by a database over 60 seconds (%) |
| `load.avg_15min`<br/>`DGAUGE`, % | Average load over 15 minutes |
| `load.avg_1min`<br/>`DGAUGE`, % | Average load over 1 minute |
| `load.avg_5min`<br/>`DGAUGE`, % | Average load over 5 minutes |

## Disk metrics {#managed-redis-disk-metrics}
| Name<br/>Type, unit | Description |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, bytes | Free space |
| `disk.free_inodes`<br/>`DGAUGE`, number | Number of free inodes |
| `disk.total_bytes`<br/>`DGAUGE`, bytes | Available space |
| `disk.total_inodes`<br/>`DGAUGE`, number | Available inodes |
| `disk.used_bytes`<br/>`DGAUGE`, bytes | Used space |
| `disk.used_inodes`<br/>`DGAUGE`, number | Used inodes |

## Disk operation metrics {#managed-redis-diskio-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `io.disk*.iops_in_progress`<br/>`DGAUGE`, number | Disk operations in progress |
| `io.disk*.merged_reads`<br/>`DGAUGE`, number | Merged read operations for a specific disk |
| `io.disk*.merged_writes`<br/>`DGAUGE`, number | Merged write operations for a specific disk |
| `io.disk*.read_bytes`<br/>`DGAUGE`, bytes/s | Read speed for a specific disk |
| `io.disk*.read_count`<br/>`DGAUGE`, operations per second | Read operations per second for a specific disk |
| `io.disk*.read_time`<br/>`DGAUGE`, ms | Average read time for a specific disk |
| `io.disk*.utilization`<br/>`DGAUGE`, % | Utilization of a specific disk |
| `io.disk*.weighted_io_time`<br/>`DGAUGE`, ms | Waiting time for I/O operations on a specific disk |
| `io.disk*.write_time`<br/>`DGAUGE`, ms | Average write time for a specific disk |
| `io.disk*.write_bytes`<br/>`DGAUGE`, bytes/s | Write speed for a specific disk |
| `io.disk*.write_count`<br/>`DGAUGE`, operations per second | Number of write operations per second for a specific disk |

## RAM metrics {#managed-redis-ram-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.active_bytes`<br/>`DGAUGE`, bytes | Amount of RAM used most often and only freed up when absolutely necessary |
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
| `mem.huge_page_size_bytes`<br/>`DGAUGE`, bytes | RAM usage, `huge_page_size` usage type |
| `mem.huge_pages_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_free` usage type |
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
| `mem.total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type |
| `mem.used_bytes`<br/>`DGAUGE`, bytes | Amount of RAM currently used by the running processes |
| `mem.used_percent_bytes`<br/>`DGAUGE`, % | Used RAM, % |
| `mem.vmalloc_chunk_bytes`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_chunk` usage type |
| `mem.vmalloc_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_total` usage type |
| `mem.vmalloc_used_bytes`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_used` usage type |
| `mem.write_back_bytes`<br/>`DGAUGE`, bytes | RAM usage, `write_back` usage type |
| `mem.write_back_tmp_bytes`<br/>`DGAUGE`, bytes | RAM usage, `write_back_tmp` usage type |

## Network metrics {#managed-redis-net-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, bytes/s | Rate of receiving data over the network |
| `net.bytes_sent`<br/>`DGAUGE`, bytes/s | Rate of sending data over the network |
| `net.drop_in`<br/>`DGAUGE`, number | Packets dropped upon receipt |
| `net.drop_out`<br/>`DGAUGE`, number | Packets dropped when being sent |
| `net.err_in`<br/>`DGAUGE`, number | Number of errors upon receipt |
| `net.err_out`<br/>`DGAUGE`, number | Number of errors at sending |
| `net.packets_recv`<br/>`DGAUGE`, packets per second | Rate of receiving packets over the network |
| `net.packets_sent`<br/>`DGAUGE`, packets per second | Rate of sending packets over the network |

## Service metrics {#managed-redis-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `active`<br/>`DGAUGE`, number | Amount of RAM used most often and only freed up when absolutely necessary |
| `available`<br/>`DGAUGE`, number | RAM usage, `available` usage type |
| `available_percent`<br/>`DGAUGE`, % | Percentage of RAM usage, `available` usage type |
| `buffered`<br/>`DGAUGE`, bytes | RAM usage, `buffered` usage type |
| `bytes_recv`<br/>`DGAUGE`, bytes | Bytes received |
| `bytes_sent`<br/>`DGAUGE`, bytes | Bytes sent |
| `cached`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type |
| `can_read`<br/>`DGAUGE`, 0/1 | Read access indicator.<br/>`1` if a cluster is available for reads, `0` if it is not. |
| `can_write`<br/>`DGAUGE`, 0/1 | Write access indicator.<br/>`1` if a cluster is available for writes, `0` if it is not. |
| `commit_limit`<br/>`DGAUGE`, bytes | RAM usage, `commit_limit` usage type |
| `committed_as`<br/>`DGAUGE`, bytes | RAM usage, `committed_as` usage type |
| `dirty`<br/>`DGAUGE`, bytes | RAM usage, `dirty` usage type |
| `drop_in`<br/>`DGAUGE`, number | Packets dropped upon receipt |
| `drop_out`<br/>`DGAUGE`, number | Packets dropped when being sent |
| `err_in`<br/>`DGAUGE`, number | Number of errors upon receipt |
| `err_out`<br/>`DGAUGE`, number | Number of errors at sending |
| `free`<br/>`DGAUGE`, bytes | RAM usage, `free` usage type |
| `high_free`<br/>`DGAUGE`, bytes | RAM usage, `high_free` usage type |
| `high_total`<br/>`DGAUGE`, bytes | RAM usage, `high_total` usage type |
| `huge_page_size`<br/>`DGAUGE`, bytes | RAM usage, `huge_page_size` usage type |
| `huge_pages_free`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_free` usage type |
| `huge_pages_total`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_total` usage type |
| `icmp_inaddrmaskreps`<br/>`DGAUGE`, number | Number of ICMP Address Mask Reply messages received from the interrogated node |
| `icmp_inaddrmasks`<br/>`DGAUGE`, number | Number of ICMP Address Mask Request messages received |
| `icmp_incsumerrors`<br/>`DGAUGE`, number | Total number of IP packets with checksum errors |
| `icmp_indestunreachs`<br/>`DGAUGE`, number | Number of ICMP Destination Unreachable messages received |
| `icmp_inechoreps`<br/>`DGAUGE`, number | Number of ICMP Echo Reply messages received |
| `icmp_inechos`<br/>`DGAUGE`, number | Number of ICMP Echo (request) messages received |
| `icmp_inerrors`<br/>`DGAUGE`, number | Number of bad ICMP packets received, excluding those with checksum errors |
| `icmp_inmsgs`<br/>`DGAUGE`, number | Total number of ICMP messages received |
| `icmp_inparmprobs`<br/>`DGAUGE`, number | Number of ICMP Parameter Problem messages received |
| `icmp_inredirects`<br/>`DGAUGE`, number | Number of ICMP redirect messages received |
| `icmp_insrcquenchs`<br/>`DGAUGE`, number | Number of ICMP Source Quench messages received |
| `icmp_intimeexcds`<br/>`DGAUGE`, number | Number of ICMP Time Exceeded messages received is greater than that of messages received. |
| `icmp_intimestampreps`<br/>`DGAUGE`, number | Number of ICMP timestamp reply messages received |
| `icmp_intimestamps`<br/>`DGAUGE`, number | Number of ICMP timestamp messages (requests) received |
| `icmp_outaddrmaskreps`<br/>`DGAUGE`, number | Number of ICMP Address Mask Reply messages sent |
| `icmp_outaddrmasks`<br/>`DGAUGE`, number | Number of ICMP Address Mask Request messages sent |
| `icmp_outdestunreachs`<br/>`DGAUGE`, number | Number of ICMP Destination Unreachable messages sent |
| `icmp_outechoreps`<br/>`DGAUGE`, number | Number of ICMP Echo Reply messages sent |
| `icmp_outechos`<br/>`DGAUGE`, number | Number of ICMP Echo messages (requests) sent |
| `icmp_outerrors`<br/>`DGAUGE`, number | Number of ICMP messages this object did not send due to problems discovered within ICMP, such as a lack of buffers |
| `icmp_outmsgs`<br/>`DGAUGE`, number | Total number of ICMP messages which this object attempted to send. This includes all messages counted by `icmp_outerrors`. |
| `icmp_outparmprobs`<br/>`DGAUGE`, number | Number of ICMP Parameter Problem messages sent |
| `icmp_outredirects`<br/>`DGAUGE`, number | Number of Redirect Route messages sent |
| `icmp_outsrcquenchs`<br/>`DGAUGE`, number | Number of ICMP Source Quench messages sent |
| `icmp_outtimeexcds`<br/>`DGAUGE`, number | Number of ICMP Time Exceeded messages sent is greater than that of messages sent. |
| `icmp_outtimestampreps`<br/>`DGAUGE`, number | Number of ICMP timestamp reply messages sent |
| `icmp_outtimestamps`<br/>`DGAUGE`, number | Number of ICMP timestamp messages sent |
| `inactive`<br/>`DGAUGE`, bytes | RAM usage, `inactive` usage type |
| `inodes_free`<br/>`DGAUGE`, number | Number of free inodes |
| `inodes_total`<br/>`DGAUGE`, number | Available inodes |
| `inodes_used`<br/>`DGAUGE`, number | Used inodes |
| `instance_userfault_broken`<br/>`DGAUGE`, number | Number of memory operation errors |
| `iops_in_progress`<br/>`DGAUGE`, number | Disk operations in progress |
| `ip_defaultttl`<br/>`DGAUGE`, string | Default value inserted into the Time-To-Live field of the IP header of packets created in this object, whenever a TTL value is not supplied by the transport layer protocol. |
| `ip_forwarding`<br/>`DGAUGE` | IP forwarding status (SNMP): `0` for disabled, `1` for enabled |
| `ip_forwdatagrams`<br/>`DGAUGE`, number | Number of input packets for which this object was not their final IP destination resulting in an attempt to find a route to forward them to that final destination. In objects which do not act as IP Gateways, this counter will include only those packets that were source-routed through this object, and for which the source route parameter was processed successfully. |
| `ip_fragcreates`<br/>`DGAUGE`, number | Number of IP packet fragments generated as a result of fragmentation in this object |
| `ip_fragfails`<br/>`DGAUGE`, number | Number of IP packets dropped because they were subject to fragmenting in this object but could not be fragmented, e.g., due to the Do Not Fragment flag. |
| `ip_fragoks`<br/>`DGAUGE`, number | Number of successfully fragmented IP packets |
| `ip_inaddrerrors`<br/>`DGAUGE`, number | Number of input packets dropped because the IP address in their IP header's destination field was not a valid address to be received in this object. This count includes invalid addresses, such as `0.0.0.0`, and addresses of unsupported classes, e.g., Class E. For objects that are not IP Gateways and, as such, do not forward packets, this counter includes packets dropped because the destination address was not a local one. |
| `ip_indelivers`<br/>`DGAUGE`, number | Total number of IP packets delivered |
| `ip_indiscards`<br/>`DGAUGE`, number | Number of input IP packets encountering no problems preventing their further processing but still dropped, e.g., for lack of buffer space. This counter does not include the packets dropped while awaiting reassembly. |
| `ip_inhdrerrors`<br/>`DGAUGE`, number | Number of input packets with header errors |
| `ip_inreceives`<br/>`DGAUGE`, number | Total number of input packets received from interfaces, including those received through error |
| `ip_inunknownprotos`<br/>`DGAUGE`, number | Number of unknown protocol packets received |
| `ip_outdiscards`<br/>`DGAUGE`, number | Number of output IP packets encountering no problems preventing transmission to their destination but still dropped, e.g., for lack of buffer space. Note that the counter would include datagrams counted in `ip_forwdatagrams` if they met this (discretionary) discard criterion. |
| `ip_outnoroutes`<br/>`DGAUGE`, number | Number of IP packets dropped because no route could be found to transmit them to their destination. This counter includes all the packets counted in `ip_forwdatagrams` that meet this No Route criterion. This includes any packets a host cannot redirect because all its default gateways are down. |
| `ip_outrequests`<br/>`DGAUGE`, number | Total number of IP packets which local IP user protocols (including ICMP) supplied to IP in requests for transmission. This counter does not include any datagrams counted in `ip_forwdatagrams`. |
| `ip_reasmfails`<br/>`DGAUGE`, number | Number of failures detected by the IP reassembly algorithm (for whatever reason: timed out, errors, etc.). This is not necessarily a count of dropped IP fragments since some algorithms (such as the algorithm in RFC 815) can lose track of the number of fragments, combining them as they are received. |
| `ip_reasmoks`<br/>`DGAUGE`, number | Number of IP packets successfully reassembled |
| `ip_reasmreqds`<br/>`DGAUGE`, number | Number of IP fragments received which needed to be reassembled in this object |
| `ip_reasmtimeout`<br/>`DGAUGE`, seconds | Maximum time, in seconds, the received fragments are held while awaiting reassembly in this object |
| `low_free`<br/>`DGAUGE`, bytes | RAM usage, `low_free` usage type |
| `low_total`<br/>`DGAUGE`, bytes | RAM usage, `low_total` usage type |
| `mapped`<br/>`DGAUGE`, bytes | RAM usage, `mapped` usage type |
| `memory_utilization_by_db_percent`<br/>`DGAUGE`, % | Memory utilization by the database |
| `memory_utilization_by_db_percent_limit`<br/>`DGAUGE`, % | Limit on memory utilization by the database |
| `memory_utilization_by_db_rss`<br/>`DGAUGE`, bytes | Total amount of memory used by database processes |
| `merged_reads`<br/>`DGAUGE`, number | Number of merged disk reads |
| `merged_writes`<br/>`DGAUGE`, number | Number of merged disk writes |
| `n_cpus`<br/>`DGAUGE`, number | Limit on CPU cores in use |
| `n_users`<br/>`DGAUGE`, number | Limit on the number of users |
| `packets_recv`<br/>`DGAUGE`, packets per second | Rate of receiving packets over the network |
| `packets_sent`<br/>`DGAUGE`, packets per second | Rate of sending packets over the network |
| `page_tables`<br/>`DGAUGE`, bytes | RAM usage, `page_tables` usage type |
| `read_bytes`<br/>`DGAUGE`, bytes/s | Read speed for a specific disk |
| `read_count`<br/>`DGAUGE`, operations per second | Read operations per second for a specific disk |
| `read_time`<br/>`DGAUGE`, ms | Average disk read time |
| `redis_aof_last_cow_size`<br/>`DGAUGE`, bytes | Amount of data copied when creating an AOF file using [COW (Copy-on-write)](https://en.wikipedia.org/wiki/Copy-on-write) |
| `redis_blocked_clients`<br/>`DGAUGE`, number | Number of clients waiting for a connection per cluster host |
| `redis_client_output_normal_hard`<br/>`DGAUGE`, bytes | Hard memory usage limit |
| `redis_client_output_normal_soft`<br/>`DGAUGE`, bytes | Soft memory usage limit |
| `redis_client_recent_max_input_buffer`<br/>`DGAUGE`, bytes | Maximum memory usage for serving client connections that write data |
| `redis_client_recent_max_output_buffer`<br/>`DGAUGE`, bytes | Maximum memory usage for serving client connections that read data |
| `redis_connected_clients`<br/>`DGAUGE`, number | Number of open connections per cluster host.<br/>If a cluster is sharded or uses replication, some connections will be used for exchanging data between cluster hosts.<br/>If cluster connection errors occur, perhaps, there are inactive apps that keep connections open for too long. If this is the case, [modify the settings](../../../managed-redis/operations/update.md#change-redis-config) to change the value of the [Timeout](../../../managed-redis/concepts/settings-list.md#settings-timeout) parameter. |
| `redis_connected_slaves`<br/>`DGAUGE`, number | Number of secondary nodes connected to the master node |
| `redis_db_hashtable_overhead`<br/>`DGAUGE`, bytes | RAM used to store hash tables of all DBs |
| `redis_dbsize`<br/>`DGAUGE`, number | Number of keys stored in all the cluster databases |
| `redis_evicted_keys`<br/>`DGAUGE`, number | Number of keys deleted from memory when inserting new data |
| `redis_hit_rate`<br/>`DGAUGE`, % | Percentage of requests for which {{ mrd-full-name }} finds data in the cache |
| `redis_instantaneous_ops_per_sec`<br/>`DGAUGE`, operations per second | Number of requests per second |
| `redis_io_threaded_reads_processed`<br/>`DGAUGE`, number | Number of processed I/O read operations |
| `redis_io_threaded_writes_processed`<br/>`DGAUGE`, number | Number of processed stream I/O write operations |
| `redis_io_threads_active`<br/>`DGAUGE`, number | Number of active streams |
| `redis_is_alive`<br/>`DGAUGE` | Host health indicator.<br/>`1` if a DB host is alive, `0` if it is not. |
| `redis_is_master`<br/>`DGAUGE` | Host type indicator.<br/>`1` if it is a DB server master host, `0` if it is not. |
| `redis_keyspace_hits`<br/>`DGAUGE`, number | Number of successful requests by key |
| `redis_keyspace_misses`<br/>`DGAUGE`, number | Number of failed key requests |
| `redis_master_last_io_seconds_ago`<br/>`DGAUGE`, seconds | Number of seconds since the last interaction with the master host |
| `redis_maxmemory`<br/>`DGAUGE`, bytes | Maximum amount of memory allocated for user data |
| `redis_mem_aof_buffer`<br/>`DGAUGE`, bytes | RAM used for the AOF buffer |
| `redis_mem_clients_normal`<br/>`DGAUGE`, bytes | RAM used to serve external connections |
| `redis_mem_clients_slaves`<br/>`DGAUGE`, bytes | RAM used to serve replication connections |
| `redis_mem_cluster_links`<br/>`DGAUGE`, bytes | Total amount of memory allocated for network connections in cluster mode |
| `redis_mem_replication_backlog`<br/>`DGAUGE`, bytes | RAM used for the replication backlog buffer |
| `redis_memory_limit`<br/>`DGAUGE`, bytes | Memory allocated per host |
| `redis_module_fork_last_cow_size`<br/>`DGAUGE`, bytes | Amount of data copied during a `fork()` call using COW |
| `redis_oom_count`<br/>`DGAUGE`, number | Number of Out of Memory errors, per hour |
| `redis_rdb_last_cow_size`<br/>`DGAUGE`, bytes | Amount of data copied when creating an RDB file |
| `redis_repl_backlog_histlen`<br/>`DGAUGE`, bytes | Portion of the replication buffer currently in use by data |
| `redis_repl_backlog_size`<br/>`DGAUGE`, bytes | Maximum amount of memory available for the replication buffer |
| `redis_total_reads_processed`<br/>`DGAUGE`, number | Total number of processed read operations |
| `redis_total_writes_processed`<br/>`DGAUGE`, number | Total number of processed write operations |
| `redis_used_memory`<br/>`DGAUGE`, bytes | Actual memory usage by a host. If the value of the `redis_used_memory` parameter reaches `redis_max_memory` when trying to insert new records, {{ mrd-full-name }} will apply the memory management mode defined by the [Maxmemory policy](../../../managed-redis/concepts/settings-list.md#settings-maxmemory-policy) setting. |
| `redis_used_memory_dataset`<br/>`DGAUGE`, bytes | RAM used for storing data |
| `redis_used_memory_overhead`<br/>`DGAUGE`, bytes | Amount of RAM used for internal data and management structures |
| `redis_used_memory_rss`<br/>`DGAUGE`, bytes | Memory used by Redis processes |
| `redis_used_memory_scripts`<br/>`DGAUGE`, bytes | RAM used for storing and running scripts |
| `redis_used_memory_startup`<br/>`DGAUGE`, bytes | RAM used for Redis processes at startup (e.g., after restarting a cluster) |
| `shared`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type |
| `slab`<br/>`DGAUGE`, bytes | RAM usage, `slab` usage type |
| `slowlog_max_len`<br/>`DGAUGE`, number | Maximum number of slow requests logged |
| `sreclaimable`<br/>`DGAUGE`, bytes | RAM usage, `sreclaimable` usage type |
| `sunreclaim`<br/>`DGAUGE`, bytes | RAM usage, `sunreclaim` usage type |
| `swap_cached`<br/>`DGAUGE`, bytes | RAM usage, `swap_cached` usage type |
| `swap_free`<br/>`DGAUGE`, bytes | RAM usage, `swap_free` usage type |
| `swap_total`<br/>`DGAUGE`, bytes | RAM usage, `swap_total` usage type |
| `tcp_activeopens`<br/>`DGAUGE`, number | Number of times TCP connections have made a direct transition from the `CLOSED` state to the `SYN-SENT` state |
| `tcp_attemptfails`<br/>`DGAUGE`, number | Number of times TCP connections have made a direct transition to the `CLOSED` state either from the `SYN-SENT` state or from the `SYN-RCVD` state, plus the number of times TCP connections have made a direct transition |
| `tcp_currestab`<br/>`DGAUGE`, number | Current number of TCP connections for the `ESTABLISHED` or `CLOSE WAIT` state |
| `tcp_estabresets`<br/>`DGAUGE`, number | Number of times TCP connections have made a direct transition to the `CLOSED` state either from the `ESTABLISHED` state or from the `CLOSE-WAIT` state |
| `tcp_incsumerrors`<br/>`DGAUGE`, number | The value increases if a received TCP packet has an invalid checksum. |
| `tcp_inerrs`<br/>`DGAUGE`, number | Total number of segments received with an error, e.g., bad TCP checksums |
| `tcp_insegs`<br/>`DGAUGE`, number | Total number of segments received, including those received through error |
| `tcp_maxconn`<br/>`DGAUGE`, number | Maximum allowed number of TCP connections |
| `tcp_outrsts`<br/>`DGAUGE`, number | Number of TCP segments sent containing the `RST` flag |
| `tcp_outsegs`<br/>`DGAUGE`, number | Total number of TCP segments sent |
| `tcp_passiveopens`<br/>`DGAUGE`, number | Number of times TCP connections made a direct transition to the `SYN-RCVD` state from the `LISTEN` state |
| `tcp_retranssegs`<br/>`DGAUGE`, number | Total number of segments retransmitted, i.e., the number of TCP segments transmitted containing one or more previously transmitted octets |
| `tcp_rtoalgorithm`<br/>`DGAUGE` | Algorithm used to determine the timeout value used for retransmitting unacknowledged octets |
| `tcp_rtomax`<br/>`DGAUGE`, ms | Maximum value permitted by a TCP implementation for the retransmission timeout, in milliseconds |
| `tcp_rtomin`<br/>`DGAUGE`, ms | Minimum value permitted by a TCP implementation for the retransmission timeout, in milliseconds |
| `total`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type |
| `udp_ignoredmulti`<br/>`DGAUGE`, number | Used for UDP multicast. |
| `udp_incsumerrors`<br/>`DGAUGE`, number | The value increases when a received UDP packet contains an invalid kernel code checksum. |
| `udp_indatagrams`<br/>`DGAUGE`, number | Total number of UDP packets received |
| `udp_inerrors`<br/>`DGAUGE`, number | Number of bad UDP packets received, excluding those with checksum errors |
| `udp_noports`<br/>`DGAUGE`, number | Total number of UDP packets received that had no application on the destination port |
| `udp_outdatagrams`<br/>`DGAUGE`, number | Total number of outgoing UDP packets sent from this object |
| `udp_rcvbuferrors`<br/>`DGAUGE`, number | Number of UDP receive buffer errors |
| `udp_sndbuferrors`<br/>`DGAUGE`, number | Number of UDP send buffer errors |
| `udplite_ignoredmulti`<br/>`DGAUGE`, number | Used for UDP Lite multicast. |
| `udplite_incsumerrors`<br/>`DGAUGE`, number | The value increases when a UDP Lite packet received contains an invalid checksum of the kernel code. |
| `udplite_indatagrams`<br/>`DGAUGE`, number | Total number of UDP Lite packets received |
| `udplite_inerrors`<br/>`DGAUGE`, number | Total number of errors when receiving UDP Lite packets |
| `udplite_noports`<br/>`DGAUGE`, number | Total number of UDP Lite packets received that had no listener on the destination port. Irregularities in the value of this counter may occur when reinitializing the control system and at other times, which is indicated by the `udplite_statsdiscontinuitytime` value. |
| `udplite_outdatagrams`<br/>`DGAUGE`, number | Total number of UDP Lite packets sent |
| `udplite_rcvbuferrors`<br/>`DGAUGE`, number | The value increases when no memory can be allocated to handle an incoming UDP Lite packet. |
| `udplite_sndbuferrors`<br/>`DGAUGE`, number | The value increases when no memory can be allocated to send a UDP Lite packet. |
| `uptime`<br/>`DGAUGE`, % | Uptime percentage |
| `usage_guest`<br/>`DGAUGE`, % | CPU core usage, `guest` usage type |
| `usage_guest_nice`<br/>`DGAUGE`, % | CPU core usage, `guest_nice` usage type |
| `usage_idle`<br/>`DGAUGE`, % | CPU core usage, `idle` usage type |
| `usage_iowait`<br/>`DGAUGE`, % | CPU core usage, `iowait` usage type |
| `usage_irq`<br/>`DGAUGE`, % | CPU core usage, `irq` usage type |
| `usage_nice`<br/>`DGAUGE`, % | CPU core usage, `nice` usage type |
| `usage_softirq`<br/>`DGAUGE`, % | CPU core usage, `softirq` usage type |
| `usage_steal`<br/>`DGAUGE`, % | CPU core usage, `steal` usage type |
| `usage_system`<br/>`DGAUGE`, % | CPU core usage, `system` usage type |
| `usage_user`<br/>`DGAUGE`, % | CPU core usage, `user` usage type |
| `used`<br/>`DGAUGE`, bytes | RAM usage, `used` usage type |
| `used_percent`<br/>`DGAUGE`, % | Percentage of RAM usage, `used` usage type |
| `utilization`<br/>`DGAUGE`, % | Average VM processor core (vCPUs) utilization by a database |
| `vmalloc_chunk`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_chunk` usage type |
| `vmalloc_total`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_total` usage type |
| `vmalloc_used`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_used` usage type |
| `weighted_io_time`<br/>`DGAUGE`, ms | Waiting time for I/O operations |
| `write_back`<br/>`DGAUGE`, bytes | RAM usage, `write_back` usage type |
| `write_back_tmp`<br/>`DGAUGE`, bytes | RAM usage, `write_back_tmp` usage type |
| `write_bytes`<br/>`DGAUGE`, bytes/s | Disk write speed |
| `write_count`<br/>`DGAUGE`, operations per second | Number of write operations per second |
| `write_time`<br/>`DGAUGE`, ms | Average disk write time |
