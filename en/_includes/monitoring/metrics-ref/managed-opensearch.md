The `name` label contains the metric name.

Labels shared by all {{ mos-name }} metrics: 

Label | Value
----|----
dc | [Availability zone](../../../overview/concepts/geo-scope.md)
host | Host FQDN
node | Type of host
resource_id | Cluster ID
resource_type | Resource type: `cluster`
sensor | Additional label, matches the metric name
service | Service ID: `managed-opensearch`
shard | Shard ID
shard_name | Shard name
subcluster_name | Subcluster name

## CPU metrics {#managed-opensearch-cpu-metrics}

CPU core workload.

The consumption type goes into the `systag` label.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `cpu.fraction`<br/>`DGAUGE`, % | Guaranteed vCPU share | 
| `cpu.guarantee`<br/>`DGAUGE`, count | Guaranteed number of cores | 
| `cpu.guest_nice`<br/>`DGAUGE`, % | CPU core usage, [guest_nice](*guest_nice) usage type |
| `cpu.guest`<br/>`DGAUGE`, % | CPU core usage, [guest](*guest) usage type |
| `cpu.idle`<br/>`DGAUGE`, % | CPU core usage, [idle](*idle) usage type |
| `cpu.iowait`<br/>`DGAUGE`, % | CPU core usage, [iowait](*iowait) usage type |
| `cpu.irq`<br/>`DGAUGE`, % | CPU core usage, [irq](*irq) usage type |
| `cpu.limit`<br/>`DGAUGE`, count | Maximum number of cores in use |
| `cpu.nice`<br/>`DGAUGE`, % | CPU core usage, [nice](*nice) usage type |
| `cpu.softirq`<br/>`DGAUGE`, % | CPU core usage, [softirq](*softirq) usage type |
| `cpu.steal`<br/>`DGAUGE`, % | CPU core usage, [steal](*steal) usage type |
| `cpu.system`<br/>`DGAUGE`, % | CPU core usage, [system](*system) usage type |
| `cpu.user`<br/>`DGAUGE`, % | CPU core usage, [user](*user) usage type |
| `cpu_time_iowait_counter`<br/>`DGAUGE`, seconds | Total I/O wait time |
| `cpu_time_iowait`<br/>`DGAUGE`, seconds | I/O wait time |
| `cpu_time_system_counter`<br/>`DGAUGE`, seconds | Total time in system mode |
| `cpu_time_system`<br/>`DGAUGE`, seconds | Time in system mode |
| `cpu_time_user_counter`<br/>`DGAUGE`, seconds | Total time in user mode |
| `cpu_time_user`<br/>`DGAUGE`, seconds | Time in user mode |
| `cpu_utilization_by_db_15_limit`<br/>`DGAUGE`, % | Maximum VM processor core (vCPU) utilization by a database over 15 seconds (%) | 
| `cpu_utilization_by_db_15`<br/>`DGAUGE`, % | Average VM processor core (vCPU) utilization by a database over 15 seconds (%). It ranges from 0% to the [vCPU performance level](../../../compute/concepts/performance-levels.md). | 
| `cpu_utilization_by_db_60_limit`<br/>`DGAUGE`, % | Maximum VM processor core (vCPU) utilization by a database over 60 seconds (%) |
| `cpu_utilization_by_db_60`<br/>`DGAUGE`, % | Average VM processor core (vCPU) utilization by a database over 60 seconds (%) | 
| `load.avg_15min`<br/>`DGAUGE`, % | Average load over 15 minutes |
| `load.avg_1min`<br/>`DGAUGE`, % | Average load over one minute |
| `load.avg_5min`<br/>`DGAUGE`, % | Average load over five minutes |

## Disk metrics {#managed-opensearch-disk-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, bytes | Free space | 
| `disk.free_inodes`<br/>`DGAUGE`, count | Free inodes | 
| `disk.total_bytes`<br/>`DGAUGE`, bytes | Available space | 
| `disk.total_inodes`<br/>`DGAUGE`, count | Available inodes | 
| `disk.used_bytes`<br/>`DGAUGE`, bytes | Used space | 
| `disk.used_inodes`<br/>`DGAUGE`, count | Used inodes |

## Disk I/O metrics {#managed-opensearch-diskio-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `io.avg.iops_in_progress`<br/>`DGAUGE`, count | Number of disk I/O operations currently in progress |
| `io.avg.read_bytes`<br/>`DGAUGE`, bytes per second | Disk read speed |
| `io.avg.read_count`<br/>`DGAUGE`, operations per second | Number of read operations per second |
| `io.avg.read_merged_count`<br/>`DGAUGE`, operations per second | Number of merged read operations per second |
| `io.avg.read_time`<br/>`DGAUGE`, ms | Average read time for all disks |
| `io.avg.weighted_io_time`<br/>`DGAUGE`, ms | Total (weighted) time spent on I/O operations |
| `io.avg.write_bytes`<br/>`DGAUGE`, bytes per second | Disk write speed |
| `io.avg.write_count`<br/>`DGAUGE`, operations per second | Number of writes per second |
| `io.avg.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second |
| `io.avg.write_time`<br/>`DGAUGE`, ms | Total time spent writing to disk |
| `io.disk*.iops_in_progress`<br/>`DGAUGE`, count | Number of disk I/O operations in progress | 
| `io.disk*.read_bytes`<br/>`DGAUGE`, bytes per second | Read speed for a given disk | 
| `io.disk*.read_count`<br/>`DGAUGE`, operations per second | Number of reads per second for a given disk | 
| `io.disk*.read_merged_count`<br/>`DGAUGE`, operations per second | Number of merged read operations per second for a given disk |
| `io.disk*.read_time`<br/>`DGAUGE`, ms | Average read time for a given disk | 
| `io.disk*.utilization`<br/>`DGAUGE`, % | Utilization of a given disk; disabled for network drives. | 
| `io.disk*.weighted_io_time`<br/>`DGAUGE`, ms | I/O wait time for a given disk | 
| `io.disk*.write_bytes`<br/>`DGAUGE`, bytes per second | Write speed for a given disk | 
| `io.disk*.write_count`<br/>`DGAUGE`, operations per second | Number of writes per second for a given disk | 
| `io.disk*.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second for a given disk |
| `io.disk*.write_time`<br/>`DGAUGE`, ms | Average write time for a given disk | 
| `io_quota_utilization_percentage`<br/>`DGAUGE`, % | Average percentage of disk quota usage |
| `io_quota_utilization_percentage_burst`<br/>`DGAUGE`, % | Maximum percentage of disk quota usage |
| `monitoring_disk.read_bytes`<br/>`DGAUGE`, bytes per second | Average number of bytes read from disk |
| `monitoring_disk.read_bytes_burst`<br/>`DGAUGE`, bytes per second | Maximum number of bytes read from disk |
| `monitoring_disk.write_bytes`<br/>`DGAUGE`, bytes per second | Average number of bytes written to disk |
| `monitoring_disk.write_bytes_burst`<br/>`DGAUGE`, bytes per second | Maximum number of bytes written to disk |
| `read_latency`<br/>`DGAUGE`, ms | Distribution histogram for disk read request latency |
| `read_ops`<br/>`DGAUGE`, operations per second | Average number of disk reads |
| `read_ops_burst`<br/>`DGAUGE`, operations per second | Maximum number of disk reads |
| `read_throttler_delay`<br/>`DGAUGE`, ms | Histogram of read latency due to exceeded disk quota |
| `write_latency`<br/>`DGAUGE`, ms | Distribution histogram for disk write request latency |
| `write_ops`<br/>`DGAUGE`, operations per second | Average number of disk write operations |
| `write_ops_burst`<br/>`DGAUGE`, operations per second | Maximum number of disk write operations |
| `write_throttler_delay`<br/>`DGAUGE`, ms | Histogram of write latency due to exceeded disk quota |

## RAM metrics {#managed-opensearch-ram-metrics}

The consumption type goes into the `systag` label.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.active_bytes`<br/>`DGAUGE`, bytes | Active resident memory (frequently accessed and released when absolutely necessary) | 
| `mem.available_bytes`<br/>`DGAUGE`, bytes | RAM usage, [available](*available) usage type |
| `mem.available_percent_bytes`<br/>`DGAUGE`, % | Percentage of RAM usage, [available](*available) usage type |
| `mem.buffers_bytes`<br/>`DGAUGE`, bytes | RAM usage, [buffers](*buffers) usage type |
| `mem.cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, [cached](*cached) usage type |
| `mem.commit_limit_bytes`<br/>`DGAUGE`, bytes | RAM usage, [commit_limit](*commit_limit) usage type |
| `mem.committed_as_bytes`<br/>`DGAUGE`, bytes | RAM usage, [committed_as](*committed_as) usage type |
| `mem.dirty_bytes`<br/>`DGAUGE`, bytes | RAM usage, [dirty](*dirty) usage type |
| `mem.free_bytes`<br/>`DGAUGE`, bytes | Amount of free RAM available, excluding `mem.buffers_bytes` and `mem.cached_bytes`. |
| `mem.guarantee_bytes`<br/>`DGAUGE`, bytes | Guaranteed memory allocation |
| `mem.high_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, [high_free](*high_free) usage type |
| `mem.high_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, [high_total](*high_total) usage type |
| `mem.huge_page_size_bytes`<br/>`DGAUGE`, bytes | RAM usage, [huge_page_size](*huge_page_size) usage type |
| `mem.huge_pages_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, [huge_pages_free](*huge_pages_free) usage type |
| `mem.huge_pages_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, [huge_pages_total](*huge_pages_total) usage type |
| `mem.inactive_bytes`<br/>`DGAUGE`, bytes | RAM usage, [inactive](*inactive) usage type |
| `mem.limit_bytes`<br/>`DGAUGE`, bytes | Memory limit |
| `mem.low_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, [low_free](*low_free) usage type |
| `mem.low_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, [low_total](*low_total) usage type |
| `mem.mapped_bytes`<br/>`DGAUGE`, bytes | RAM usage, [mapped](*mapped) usage type |
| `mem.page_tables_bytes`<br/>`DGAUGE`, bytes | RAM usage, [page_tables](*page_tables) usage type |
| `mem.shared_bytes`<br/>`DGAUGE`, bytes | RAM usage, [shared](*shared) usage type |
| `mem.slab_bytes`<br/>`DGAUGE`, bytes | RAM usage, [slab](*slab) usage type |
| `mem.sreclaimable_bytes`<br/>`DGAUGE`, bytes | RAM usage, [sreclaimable](*sreclaimable) usage type |
| `mem.sunreclaim_bytes`<br/>`DGAUGE`, bytes | RAM usage, [sunreclaim](*sunreclaim) usage type |
| `mem.swap_cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, [swap_cached](*swap_cached) usage type |
| `mem.swap_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, [swap_free](*swap_free) usage type |
| `mem.swap_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, [swap_total](*swap_total) usage type |
| `mem.total_bytes`<br/>`DGAUGE`, bytes | RAM usage, [total](*total) usage type |
| `mem.used_bytes`<br/>`DGAUGE`, bytes | Amount of RAM currently used by running processes |
| `mem.used_percent_bytes`<br/>`DGAUGE`, % | Percentage of used RAM |
| `mem.vmalloc_chunk_bytes`<br/>`DGAUGE`, bytes | RAM usage, [vmalloc_chunk](*vmalloc_chunk) usage type |
| `mem.vmalloc_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, [vmalloc_total](*vmalloc_total) usage type |
| `mem.vmalloc_used_bytes`<br/>`DGAUGE`, bytes | RAM usage, [vmalloc_used](*vmalloc_used) usage type |
| `mem.write_back_bytes`<br/>`DGAUGE`, bytes | RAM usage, [write_back](*write_back) usage type |
| `mem.write_back_tmp_bytes`<br/>`DGAUGE`, bytes | RAM usage, [write_back_tmp](*write_back_tmp) usage type |

## Network metrics {#managed-opensearch-net-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, bytes per second | Network data receive rate | 
| `net.bytes_sent`<br/>`DGAUGE`, bytes per second | Network data transmit rate | 
| `net.dropin`<br/>`DGAUGE`, count | Dropped receive packets | 
| `net.dropout`<br/>`DGAUGE`, count | Dropped transmit packets | 
| `net.errin`<br/>`DGAUGE`, count | Receive error count | 
| `net.errout`<br/>`DGAUGE`, count | Transmit error count | 
| `net.packets_recv`<br/>`DGAUGE`, packets per second | Network packet receive rate | 
| `net.packets_sent`<br/>`DGAUGE`, packets per second | Network packet transmit rate | 
| `net.speed`<br/>`DGAUGE`, bits per second | Maximum network data transfer rate for this interface |

## Service metrics {#managed-opensearch-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `active`<br/>`DGAUGE`, count | Active resident memory (frequently accessed and released when absolutely necessary) |
| `available`<br/>`DGAUGE`, count | RAM usage, [available](*available) usage type |
| `available_percent`<br/>`DGAUGE`, % | Percentage of RAM usage, [available](*available) usage type |
| `buffered`<br/>`DGAUGE`, bytes | RAM usage, [buffered](*buffered) usage type |
| `cached`<br/>`DGAUGE`, bytes | RAM usage, [cached](*cached) usage type |
| `commit_limit`<br/>`DGAUGE`, bytes | RAM usage, [commit_limit](*commit_limit) usage type |
| `committed_as`<br/>`DGAUGE`, bytes | RAM usage, [committed_as](*committed_as) usage type |
| `count`<br/>`DGAUGE`, objects | Number of objects |
| `dirty`<br/>`DGAUGE`, bytes | RAM usage, [dirty](*dirty) usage type |
| `free`<br/>`DGAUGE`, bytes | RAM usage, [free](*free) usage type |
| `high_free`<br/>`DGAUGE`, bytes | RAM usage, [high_free](*high_free) usage type |
| `high_total`<br/>`DGAUGE`, bytes | RAM usage, [high_total](*high_total) usage type |
| `hosts.ha`<br/>`DGAUGE`, count | Number of nodes with enabled fault tolerance |
| `hosts.subcluster.dashboards.total`<br/>`DGAUGE`, count | Number of Dashboards subcluster nodes |
| `hosts.subcluster.opensearch.total`<br/>`DGAUGE`, count | Number of {{ OS }} subcluster nodes |
| `hosts.total`<br/>`DGAUGE`, count | Number of cluster nodes |
| `huge_page_size`<br/>`DGAUGE`, bytes | RAM usage, [huge_page_size](*huge_page_size) usage type |
| `huge_pages_free`<br/>`DGAUGE`, bytes | RAM usage, [huge_pages_free](*huge_pages_free) usage type |
| `huge_pages_total`<br/>`DGAUGE`, bytes | RAM usage, [huge_pages_total](*huge_pages_total) usage type |
| `icmp_inaddrmaskreps`<br/>`DGAUGE`, count | Number of ICMP address mask reply messages received from the polled node  | 
| `icmp_inaddrmasks`<br/>`DGAUGE`, count | Number of ICMP address mask request messages received | 
| `icmp_incsumerrors`<br/>`DGAUGE`, count | Total IP packets with checksum errors | 
| `icmp_indestunreachs`<br/>`DGAUGE`, count | Number of ICMP destination unreachable messages received | 
| `icmp_inechoreps`<br/>`DGAUGE`, count | Number of ICMP echo reply messages received | 
| `icmp_inechos`<br/>`DGAUGE`, count | Number of ICMP echo request messages received | 
| `icmp_inerrors`<br/>`DGAUGE`, count | Number of bad ICMP packets received, excluding those with checksum errors  | 
| `icmp_inmsgs`<br/>`DGAUGE`, count | Total ICMP messages received  | 
| `icmp_inparmprobs`<br/>`DGAUGE`, count | Number of ICMP parameter problem messages received | 
| `icmp_inredirects`<br/>`DGAUGE`, count | Number of ICMP redirect messages received | 
| `icmp_insrcquenchs`<br/>`DGAUGE`, count | Number of ICMP source quench messages received | 
| `icmp_intimeexcds`<br/>`DGAUGE`, count | Number of ICMP time exceeded messages received | 
| `icmp_intimestampreps`<br/>`DGAUGE`, count | Number of ICMP timestamp reply messages received | 
| `icmp_intimestamps`<br/>`DGAUGE`, count | Number of ICMP timestamp (request) messages received | 
| `icmp_outaddrmaskreps`<br/>`DGAUGE`, count | Number of ICMP address mask reply messages sent | 
| `icmp_outaddrmasks`<br/>`DGAUGE`, count | Number of ICMP address mask request messages sent | 
| `icmp_outdestunreachs`<br/>`DGAUGE`, count | Number of ICMP destination unreachable messages sent | 
| `icmp_outechoreps`<br/>`DGAUGE`, count | Number of ICMP echo reply messages sent | 
| `icmp_outechos`<br/>`DGAUGE`, count | Number of ICMP echo request messages sent | 
| `icmp_outerrors`<br/>`DGAUGE`, count | Number of ICMP messages not sent due to ICMP errors, such as buffer shortages | 
| `icmp_outmsgs`<br/>`DGAUGE`, count | Total ICMP messages the object in question attempted to send. This includes all messages counted by `icmp_outerrors`. |
| `icmp_outparmprobs`<br/>`DGAUGE`, count | Number of ICMP parameter problem messages sent | 
| `icmp_outratelimitglobal`<br/>`DGAUGE`, count | ICMP packets discarded due to rate limiting |
| `icmp_outratelimithost`<br/>`DGAUGE`, count | ICMP packets discarded due to exceeding the host rate limit |
| `icmp_outredirects`<br/>`DGAUGE`, count | Number of ICMP redirect messages sent  | 
| `icmp_outsrcquenchs`<br/>`DGAUGE`, count | Number of ICMP source quench messages sent |
| `icmp_outtimeexcds`<br/>`DGAUGE`, count | Number of ICMP time exceeded messages sent | 
| `icmp_outtimestampreps`<br/>`DGAUGE`, count | Number of ICMP timestamp reply messages sent | 
| `icmp_outtimestamps`<br/>`DGAUGE`, count | Number of ICMP timestamp (request) messages sent  | 
| `icmpmsg_intype0`<br/>`DGAUGE`, count | Number of ICMP type 0 (echo reply) messages received  | 
| `icmpmsg_intype8`<br/>`DGAUGE`, count | Number of ICMP type 8 (echo request) messages received  | 
| `icmpmsg_outtype0`<br/>`DGAUGE`, count | Number of ICMP type 0 (echo reply) messages sent  | 
| `icmpmsg_outtype3`<br/>`DGAUGE`, count | Number of ICMP type 3 (destination unreachable) messages sent  | 
| `icmpmsg_outtype8`<br/>`DGAUGE`, count | Total number of ICMP type 8 (echo request) messages sent  | 
| `icmpmsg_outtype11`<br/>`DGAUGE`, count | Total number of ICMP type 11 (time exceeded) messages sent |
| `inactive`<br/>`DGAUGE`, bytes | RAM usage, [inactive](*inactive) usage type |
| `index_docs_count`<br/>`DGAUGE`, count | Number of documents in the index. Displays 10 indexes with the largest number of documents. Only applies to indexes larger than 1 MB.<br/>The `index` special label is the index name. |
| `index_primary_store_size`<br/>`DGAUGE`, bytes | Index size. Displays 10 largest indexes. Only applies to indexes larger than 1 MB.<br/>The `index` special label is the index name. |
| `inodes_free`<br/>`DGAUGE`, count | Free inodes | 
| `inodes_total`<br/>`DGAUGE`, count | Available inodes | 
| `inodes_used`<br/>`DGAUGE`, count | Used inodes |
| `inodes_used_percent`<br/>`DGAUGE`, % | Percentage of used inodes |
| `instance_userfault_broken`<br/>`DGAUGE`, 0/1 | Indicator of host failure due to user fault |
| `iops_in_progress`<br/>`DGAUGE`, count | Number of disk I/O operations in progress | 
| `ip_defaultttl`<br/>`DGAUGE`, string | Default TTL value inserted into the IP header for IP packets generated in this object when the transport layer protocol does not provide a TTL. | 
| `ip_forwarding`<br/>`DGAUGE` | IP forwarding status (SNMP): `0` for disabled, `1` for enabled.  | 
| `ip_forwdatagrams`<br/>`DGAUGE`, count | Number of inbound packets not destined for this object, triggering an attempt to find a forwarding route to the final IP destination. For objects not acting as IP gateways, this count includes only those packets that were source-routed through them and where the source route option was successfully processed. | 
| `ip_fragcreates`<br/>`DGAUGE`, count | Number of IP packet fragments generated due to fragmentation in the object in question | 
| `ip_fragfails`<br/>`DGAUGE`, count | Number of IP packets dropped due to failed fragmentation which was required in this object, e.g., because of the `Do not fragment` flag being set. | 
| `ip_fragoks`<br/>`DGAUGE`, count | Number of successfully fragmented IP packets  | 
| `ip_inaddrerrors`<br/>`DGAUGE`, count | Number of inbound packets dropped due to an invalid destination IP address in the IP header for the object in question. This count includes invalid addresses, such as `0.0.0.0`, and addresses of unsupported classes, e.g., Class E. For objects that do not act as IP gateways and therefore do not forward packets, this counter includes packets dropped because the destination address was not a local one. | 
| `ip_indelivers`<br/>`DGAUGE`, count | Total IP packets delivered  | 
| `ip_indiscards`<br/>`DGAUGE`, count | Number of inbound IP packets encountering no issues preventing their further processing but still dropped, e.g., due to lack of buffer space. This counter does not include packets dropped while awaiting reassembly. | 
| `ip_inhdrerrors`<br/>`DGAUGE`, count | Number of inbound packets with header errors  | 
| `ip_inreceives`<br/>`DGAUGE`, count | Total inbound packets received from interfaces, including those received in error | 
| `ip_inunknownprotos`<br/>`DGAUGE`, count | Number of unknown protocol packets received  | 
| `ip_outdiscards`<br/>`DGAUGE`, count | Number of outgoing IP packets encountering no issues preventing their transmission to the destination but still dropped, e.g., due to lack of buffer space. Note that the counter would include packets counted in `ip_forwdatagrams` if they met this (discretionary) drop criterion. | 
| `ip_outnoroutes`<br/>`DGAUGE`, count | Number of IP packets dropped because no route to their destination was found. This metric tracks all packets counted in `ip_forwdatagrams` that meet this no-route criterion. This includes any packets a host cannot redirect because all its default gateways are down. | 
| `ip_outrequests`<br/>`DGAUGE`, count | Total IP packets provided by local IP user-level protocols (including ICMP) to IP in requests for transmission. This metric does not include the packets counted in `ip_forwdatagrams`. | 
| `ip_outtransmits`<br/>`DGAUGE`, count | Number of successfully sent IP packets |
| `ip_reasmfails`<br/>`DGAUGE`, count | Number of failures detected by the IP reassembly algorithm due to reasons, such as timeouts, errors, etc. This is not necessarily a count of dropped IP fragments, since certain algorithms, like the one in RFC 815, may lose count of fragments while reassembling them as they are received. | 
| `ip_reasmoks`<br/>`DGAUGE`, count | Number of IP packets successfully reassembled | 
| `ip_reasmreqds`<br/>`DGAUGE`, count | Number of received IP fragments requiring reassembly in the object in question | 
| `ip_reasmtimeout`<br/>`DGAUGE`, seconds | Maximum time, in seconds, received fragments are kept while awaiting reassembly in the object in question. | 
| `low_free`<br/>`DGAUGE`, bytes | RAM usage, [low_free](*low_free) usage type |
| `low_total`<br/>`DGAUGE`, bytes | RAM usage, [low_total](*low_total) usage type |
| `memory_pss`<br/>`DGAUGE`, byte | Proportional memory size used by the process (Proportional Set Size), including shared memory pages |
| `mapped`<br/>`DGAUGE`, bytes | RAM usage, [mapped](*mapped) usage type |
| `merged_reads`<br/>`DGAUGE`, count | Number of merged disk reads | 
| `merged_writes`<br/>`DGAUGE`, count | Number of merged disk writes | 
| `n_cpus`<br/>`DGAUGE`, count | Maximum number of cores in use | 
| `n_unique_users`<br/>`DGAUGE`, count | Number of unique users or accounts engaging with the system |
| `n_users`<br/>`DGAUGE`, count | Limit on the number of users | 
| `page_tables`<br/>`DGAUGE`, bytes | RAM usage, [page_tables](*page_tables) usage type |
| `read_bytes`<br/>`DGAUGE`, bytes per second | Read speed for a given disk | 
| `read_count`<br/>`DGAUGE`, operations per second | Number of reads per second for a given disk | 
| `read_merged_count`<br/>`DGAUGE`, operations per second | Number of merged read operations per second |
| `read_time`<br/>`DGAUGE`, ms | Average disk read time | 
| `running`<br/>`DGAUGE`, 0/1 | It can be either `1` if the service is running or `0` if it is not. |
| `shared`<br/>`DGAUGE`, bytes | RAM usage, [shared](*shared) usage type |
| `slab`<br/>`DGAUGE`, bytes | RAM usage, [slab](*slab) usage type |
| `sreclaimable`<br/>`DGAUGE`, bytes | RAM usage, [sreclaimable](*sreclaimable) usage type |
| `sunreclaim`<br/>`DGAUGE`, bytes | RAM usage, [sunreclaim](*sunreclaim) usage type |
| `swap_cached`<br/>`DGAUGE`, bytes | RAM usage, [swap_cached](*swap_cached) usage type |
| `swap_free`<br/>`DGAUGE`, bytes | RAM usage, [swap_free](*swap_free) usage type |
| `swap_total`<br/>`DGAUGE`, bytes | RAM usage, [swap_total](*swap_total) usage type |
| `tcp_activeopens`<br/>`DGAUGE`, count | Number of times TCP connections have made a direct transition from the `CLOSED` state to `SYN-SENT`. | 
| `tcp_attemptfails`<br/>`DGAUGE`, count | Number of times TCP connections have made a direct transition to the `CLOSED` state from either the `SYN-SENT` or `SYN-RCVD` state, plus the number of direct TCP connection transitions. | 
| `tcp_currestab`<br/>`DGAUGE`, count | Current number of TCP connections for the `ESTABLISHED` or `CLOSE WAIT` state | 
| `tcp_estabresets`<br/>`DGAUGE`, count | Number of times TCP connections have made a direct transition to the `CLOSED` state from either the `ESTABLISHED` or `CLOSE-WAIT` state. | 
| `tcp_incsumerrors`<br/>`DGAUGE`, count | This value increases when a received TCP packet has an invalid checksum. | 
| `tcp_inerrs`<br/>`DGAUGE`, count | Total segments received with an error, such as invalid TCP checksums |
| `tcp_insegs`<br/>`DGAUGE`, count | Total segments received, including those received in error | 
| `tcp_maxconn`<br/>`DGAUGE`, count | Maximum allowed number of TCP connections  | 
| `tcp_outrsts`<br/>`DGAUGE`, count | Number of TCP segments sent with the `RST` flag |
| `tcp_outsegs`<br/>`DGAUGE`, count | Total TCP segments sent  | 
| `tcp_passiveopens`<br/>`DGAUGE`, count | Number of times TCP connections have made a direct transition to the `SYN-RCVD` state from `LISTEN` | 
| `tcp_retranssegs`<br/>`DGAUGE`, count | Total segments retransmitted, i.e., number of TCP segments sent containing one or more previously transmitted octets. | 
| `tcp_rtoalgorithm`<br/>`DGAUGE` | Algorithm used to determine the timeout for retransmitting unacknowledged octets |
| `tcp_rtomax`<br/>`DGAUGE`, ms | Maximum TCP retransmission timeout, in milliseconds | 
| `tcp_rtomin`<br/>`DGAUGE`, ms | Minimum TCP retransmission timeout, in milliseconds | 
| `total`<br/>`DGAUGE`, bytes | RAM usage, [total](*total) usage type |
| `udp_ignoredmulti`<br/>`DGAUGE`, count | Number of UDP multicast packets ignored | 
| `udp_incsumerrors`<br/>`DGAUGE`, count | This value increases when a received UDP packet contains an invalid kernel code checksum. | 
| `udp_indatagrams`<br/>`DGAUGE`, count | Total UDP packets received  | 
| `udp_inerrors`<br/>`DGAUGE`, count | Number of bad UDP packets received, excluding those with checksum errors  | 
| `udp_memerrors`<br/>`DGAUGE`, errors | Number of UDP out-of-memory errors |
| `udp_noports`<br/>`DGAUGE`, count | Total UDP packets received with no application on the destination port | 
| `udp_outdatagrams`<br/>`DGAUGE`, count | Total UDP packets sent from the object in question | 
| `udp_rcvbuferrors`<br/>`DGAUGE`, count | Number of UDP receive buffer errors  | 
| `udp_sndbuferrors`<br/>`DGAUGE`, count | Number of UDP send buffer errors  | 
| `udplite_ignoredmulti`<br/>`DGAUGE`, count | Number of UDP-Lite multicast packets ignored  | 
| `udplite_incsumerrors`<br/>`DGAUGE`, count | This value increases when a received UDP-Lite packet contains an invalid kernel code checksum. | 
| `udplite_indatagrams`<br/>`DGAUGE`, count | Total UDP-Lite packets received  | 
| `udplite_inerrors`<br/>`DGAUGE`, count | Total UDP-Lite packet receive errors  | 
| `udplite_memerrors`<br/>`DGAUGE`, errors | Number of UDP-Lite out-of-memory errors |
| `udplite_noports`<br/>`DGAUGE`, count | Total UDP-Lite packets received without a listener on the destination port. Irregularities in this counter may occur when reinitializing the management system and at other times, as indicated by the `udplite_statsdiscontinuitytime` value. | 
| `udplite_outdatagrams`<br/>`DGAUGE`, count | Total UDP-Lite packets sent  | 
| `udplite_rcvbuferrors`<br/>`DGAUGE`, count | This value increases when no memory can be allocated to process an inbound UDP-Lite packet. | 
| `udplite_sndbuferrors`<br/>`DGAUGE`, count | This value increases when no memory can be allocated to send an inbound UDP-Lite packet. | 
| `uptime`<br/>`DGAUGE`, % | Uptime percentage | 
| `usage_guest`<br/>`DGAUGE`, % | CPU core usage, [guest](*guest) usage type |
| `usage_guest_nice`<br/>`DGAUGE`, % | CPU core usage, [guest_nice](*guest_nice) usage type |
| `usage_idle`<br/>`DGAUGE`, % | CPU core usage, [idle](*idle) usage type |
| `usage_iowait`<br/>`DGAUGE`, % | CPU core usage, [iowait](*iowait) usage type |
| `usage_irq`<br/>`DGAUGE`, % | CPU core usage, [irq](*irq) usage type |
| `usage_nice`<br/>`DGAUGE`, % | CPU core usage, [nice](*nice) usage type |
| `usage_softirq`<br/>`DGAUGE`, % | CPU core usage, [softirq](*softirq) usage type |
| `usage_steal`<br/>`DGAUGE`, % | CPU core usage, [steal](*steal) usage type |
| `usage_system`<br/>`DGAUGE`, % | CPU core usage, [system](*system) usage type |
| `usage_user`<br/>`DGAUGE`, % | CPU core usage, [user](*user) usage type |
| `used`<br/>`DGAUGE`, bytes | RAM usage, [used](*used) usage type |
| `used_percent`<br/>`DGAUGE`, % | Percentage of RAM usage, [used](*used) usage type |
| `vmalloc_chunk`<br/>`DGAUGE`, bytes | RAM usage, [vmalloc_chunk](*vmalloc_chunk) usage type |
| `vmalloc_total`<br/>`DGAUGE`, bytes | RAM usage, [vmalloc_total](*vmalloc_total) usage type |
| `vmalloc_used`<br/>`DGAUGE`, bytes | RAM usage, [vmalloc_used](*vmalloc_used) usage type |
| `weighted_io_time`<br/>`DGAUGE`, ms | I/O wait time | 
| `write_back`<br/>`DGAUGE`, bytes | RAM usage, [write_back](*write_back) usage type |
| `write_back_tmp`<br/>`DGAUGE`, bytes | RAM usage, [write_back_tmp](*write_back_tmp) usage type |
| `write_bytes`<br/>`DGAUGE`, bytes per second | Disk write speed |
| `write_count`<br/>`DGAUGE`, operations per second | Number of writes per second |
| `write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second for a given disk |
| `write_time`<br/>`DGAUGE`, ms | Average disk write time |

#### {{ OS }} native metrics {#managed-opensearch-system-metrics}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `opensearch_above_critical_watermark`<br/>`DGAUGE`, 0/1 | Critical disk usage threshold exceeded |
| `opensearch_above_flood_stage_watermark`<br/>`DGAUGE`, 0/1 | `flood_stage` threshold exceeded. Indexes enter read-only mode. |
| `opensearch_above_high_watermark`<br/>`DGAUGE`, 0/1 | High threshold exceeded. The cluster attempts to relocate shards from the node. |
| `opensearch_above_low_watermark`<br/>`DGAUGE`, 0/1 | Low threshold exceeded. No new shards are placed on the node. |
| `opensearch_breakers_fielddata_estimated_size_in_bytes`<br/>`DGAUGE`, bytes | Estimated memory currently used by `fielddata` (field values for sorting and aggregation by text fields). approaching this limit precedes `breaker` triggering. |
| `opensearch_breakers_fielddata_limit_size_in_bytes`<br/>`DGAUGE`, bytes | `fielddata circuit breaker` memory limit used to estimate remaining memory before triggering (`estimated` / `limit`). |
| `opensearch_breakers_fielddata_overhead`<br/>`DGAUGE` | Multiplier applied to calculated `fielddata` usage to estimate actual memory utilization. |
| `opensearch_breakers_fielddata_tripped`<br/>`DGAUGE`, count | Number of times `fielddata breaker` has triggered. If growing, indicates heavy sorting or aggregation operations exceeding the `fielddata` memory limit. |
| `opensearch_breakers_in_flight_requests_estimated_size_in_bytes`<br/>`DGAUGE`, bytes | Estimated memory currently used by buffers of incoming network requests (HTTP and transport). |
| `opensearch_breakers_in_flight_requests_limit_size_in_bytes`<br/>`DGAUGE`, bytes | `in-flight requests circuit breaker` memory limit |
| `opensearch_breakers_in_flight_requests_overhead`<br/>`DGAUGE` | Multiplier applied to calculated `in-flight requests` usage to estimate actual memory utilization. |
| `opensearch_breakers_in_flight_requests_tripped`<br/>`DGAUGE`, count | Number of times `in-flight requests breaker` has triggered. If growing, indicates that the memory limit for network buffers has been exceeded (too large or too frequent parallel requests). |
| `opensearch_breakers_parent_estimated_size_in_bytes`<br/>`DGAUGE`, bytes | Total estimated memory tracked across all child `breakers`. Comparing this value against the limit shows remaining memory before the parent breaker triggers. |
| `opensearch_breakers_parent_limit_size_in_bytes`<br/>`DGAUGE`, bytes | Global memory limit enforced across all `circuit breakers` to protect the node from `OutOfMemory`. |
| `opensearch_breakers_parent_overhead`<br/>`DGAUGE` | Multiplier applied to the total estimated memory of the parent `breaker` (usually 1.0). |
| `opensearch_breakers_parent_tripped`<br/>`DGAUGE`, count | Number of times the parent `breaker` has triggered: total memory usage has exceeded the global limit, causing the node to reject requests. This is the main indicator of node memory overload. |
| `opensearch_breakers_request_estimated_size_in_bytes`<br/>`DGAUGE`, bytes | Estimated memory currently allocated for processing active requests (aggregations, bucket tracking, etc.). |
| `opensearch_breakers_request_limit_size_in_bytes`<br/>`DGAUGE`, bytes | Memory limit for processing a single request (`request circuit breaker`). |
| `opensearch_breakers_request_overhead`<br/>`DGAUGE` | Multiplier applied to calculated `request breaker` usage to estimate actual memory utilization. |
| `opensearch_breakers_request_tripped`<br/>`DGAUGE`, count | Number of times `request breaker` has triggered. If growing, indicates that requests, these are usually heavy aggregations, require more memory than the `per-request` limit. |
| `opensearch_discovered_cluster_manager`<br/>`DGAUGE`, 0/1 | Indicates the node has discovered the master node (`cluster_manager`). |
| `opensearch_discovered_master`<br/>`DGAUGE`, 0/1 | Alias for `opensearch_discovered_cluster_manager`, preserved for backward compatibility. |
| `opensearch_fs_io_stats_total_io_time_in_millis`<br/>`DGAUGE`, ms | Total disk I/O time |
| `opensearch_fs_io_stats_total_operations`<br/>`DGAUGE`, count | Total number of disk I/O operations |
| `opensearch_fs_io_stats_total_queue_size`<br/>`DGAUGE`, count | Total length of the disk I/O queue |
| `opensearch_fs_io_stats_total_read_kilobytes`<br/>`DGAUGE`, kilobytes | Total amount of data read from disk |
| `opensearch_fs_io_stats_total_read_operations`<br/>`DGAUGE`, count | Total number of disk read operations |
| `opensearch_fs_io_stats_total_read_time`<br/>`DGAUGE`, ms | Total disk read time |
| `opensearch_fs_io_stats_total_write_kilobytes`<br/>`DGAUGE`, kilobytes | Total amount of data written to disk |
| `opensearch_fs_io_stats_total_write_operations`<br/>`DGAUGE`, count | Total number of disk write operations |
| `opensearch_fs_io_stats_total_write_time`<br/>`DGAUGE`, ms | Total disk write time |
| `opensearch_fs_total_available_in_bytes`<br/>`DGAUGE`, bytes | Disk space available to the OpenSearch process, excluding `root`-reserved space |
| `opensearch_fs_total_cache_reserved_in_bytes`<br/>`DGAUGE`, bytes | Disk space reserved for file cache |
| `opensearch_fs_total_free_in_bytes`<br/>`DGAUGE`, bytes | Free disk space |
| `opensearch_fs_total_total_in_bytes`<br/>`DGAUGE`, bytes | Total disk space available to OpenSearch |
| `opensearch_fs_total_used_in_bytes`<br/>`DGAUGE`, bytes | Used disk space |
| `opensearch_fs_total_used_percent`<br/>`DGAUGE`, % | Percentage of used disk space |
| `opensearch_http_current_open`<br/>`DGAUGE`, count | Number of currently open HTTP connections |
| `opensearch_http_total_opened`<br/>`DGAUGE`, count | Total HTTP connections opened since node startup |
| `opensearch_indices_completion_size_in_bytes`<br/>`DGAUGE`, bytes | Memory used by autocompletion structures (`completion suggester`) |
| `opensearch_indices_docs_count`<br/>`DGAUGE`, count | Total number of documents in node indexes |
| `opensearch_indices_docs_deleted`<br/>`DGAUGE`, count | Number of deleted documents not yet cleaned out by merges (`merge`) |
| `opensearch_indices_fielddata_evictions`<br/>`DGAUGE`, count | Number of evictions from the `fielddata` cache |
| `opensearch_indices_fielddata_memory_size_in_bytes`<br/>`DGAUGE`, bytes | Memory used by the `fielddata` cache |
| `opensearch_indices_flush_periodic`<br/>`DGAUGE`, count | Number of periodic `flush` operations initiated by translog size |
| `opensearch_indices_flush_total_time_in_millis`<br/>`DGAUGE`, ms | Total duration of `flush` operations |
| `opensearch_indices_flush_total`<br/>`DGAUGE`, count | Total number of `flush` operations |
| `opensearch_indices_get_current`<br/>`DGAUGE`, count | Number of `get` operations currently in progress |
| `opensearch_indices_get_exists_time_in_millis`<br/>`DGAUGE`, ms | Total duration of `get` operations where a document was retrieved. |
| `opensearch_indices_get_exists_total`<br/>`DGAUGE`, count | Total number of `get` operations where a document was retrieved. |
| `opensearch_indices_get_missing_time_in_millis`<br/>`DGAUGE`, ms | Total duration of `get` operations that failed to retrieve a document. |
| `opensearch_indices_get_missing_total`<br/>`DGAUGE`, count | Total number of `get` operations that failed to retrieve a document. |
| `opensearch_indices_get_time_in_millis`<br/>`DGAUGE`, ms | Total duration of all `get` operations |
| `opensearch_indices_get_total`<br/>`DGAUGE`, count | Total number of all `get` operations |
| `opensearch_indices_indexing_delete_current`<br/>`DGAUGE`, count | Number of ongoing document deletion operations |
| `opensearch_indices_indexing_delete_time_in_millis`<br/>`DGAUGE`, ms | Total duration of document deletion operations |
| `opensearch_indices_indexing_delete_total`<br/>`DGAUGE`, count | Total number of document deletion operations |
| `opensearch_indices_indexing_doc_status_2xx`<br/>`DGAUGE`, count | Number of documents indexed with 2xx HTTP status codes (success) |
| `opensearch_indices_indexing_doc_status_4xx`<br/>`DGAUGE`, count | Number of documents with 4xx HTTP status codes (client-side indexing error) |
| `opensearch_indices_indexing_doc_status_5xx`<br/>`DGAUGE`, count | Number of documents with 5xx HTTP status codes (server-side indexing error) |
| `opensearch_indices_indexing_index_current`<br/>`DGAUGE`, count | Number of ongoing indexing operations |
| `opensearch_indices_indexing_index_failed`<br/>`DGAUGE`, count | Number of failed indexing operations |
| `opensearch_indices_indexing_index_time_in_millis`<br/>`DGAUGE`, ms | Total duration of indexing operations |
| `opensearch_indices_indexing_index_total`<br/>`DGAUGE`, count | Total number of indexing operations |
| `opensearch_indices_indexing_noop_update_total`<br/>`DGAUGE`, count | Number of `noop` updates where the document remained unchanged. |
| `opensearch_indices_indexing_throttle_time_in_millis`<br/>`DGAUGE`, ms | Indexing throttle time |
| `opensearch_indices_merges_current_docs`<br/>`DGAUGE`, count | Number of documents involved in ongoing segment `merge` operations |
| `opensearch_indices_merges_current_size_in_bytes`<br/>`DGAUGE`, bytes | Size of segments in ongoing merges |
| `opensearch_indices_merges_current`<br/>`DGAUGE`, count | Number of ongoing segment merges |
| `opensearch_indices_merges_total_auto_throttle_in_bytes`<br/>`DGAUGE`, bytes | Total amount of data processed by merges with auto throttling |
| `opensearch_indices_merges_total_docs`<br/>`DGAUGE`, count | Total number of documents processed by merges |
| `opensearch_indices_merges_total_size_in_bytes`<br/>`DGAUGE`, bytes | Total size of segments processed by merges |
| `opensearch_indices_merges_total_stopped_time_in_millis`<br/>`DGAUGE`, ms | Total time during which merge operations were stopped. |
| `opensearch_indices_merges_total_throttled_time_in_millis`<br/>`DGAUGE`, ms | Total time during which merge operations were throttled. |
| `opensearch_indices_merges_total_time_in_millis`<br/>`DGAUGE`, ms | Total duration of merge operations |
| `opensearch_indices_merges_total`<br/>`DGAUGE`, count | Total number of completed segment merges |
| `opensearch_indices_merges_unreferenced_file_cleanups_performed`<br/>`DGAUGE`, count | Number of post-merge unused file cleanups |
| `opensearch_indices_query_cache_cache_count`<br/>`DGAUGE`, count | Number of records in the node-level `query cache` |
| `opensearch_indices_query_cache_cache_size`<br/>`DGAUGE`, bytes | Size of the node-level query cache |
| `opensearch_indices_query_cache_evictions`<br/>`DGAUGE`, count | Number of node-level query cache evictions |
| `opensearch_indices_query_cache_hit_count`<br/>`DGAUGE`, count | Number of node-level query cache hits |
| `opensearch_indices_query_cache_memory_size_in_bytes`<br/>`DGAUGE`, bytes | Memory used by the node-level query cache |
| `opensearch_indices_query_cache_miss_count`<br/>`DGAUGE`, count | Number of node-level query cache misses |
| `opensearch_indices_query_cache_total_count`<br/>`DGAUGE`, count | Total requests to the node-level query cache |
| `opensearch_indices_recovery_current_as_source`<br/>`DGAUGE`, count | Number of shard recoveries with this node as the source |
| `opensearch_indices_recovery_current_as_target`<br/>`DGAUGE`, count | Number of shard recoveries with this node as the target |
| `opensearch_indices_recovery_throttle_time_in_millis`<br/>`DGAUGE`, ms | Total recovery throttle duration |
| `opensearch_indices_refresh_external_total_time_in_millis`<br/>`DGAUGE`, ms | Total duration of external `refresh` operations after which updates become searchable. |
| `opensearch_indices_refresh_external_total`<br/>`DGAUGE`, count | Total number of external `refresh` operations |
| `opensearch_indices_refresh_listeners`<br/>`DGAUGE`, count | Number of listeners waiting for a next `refresh` |
| `opensearch_indices_refresh_total_time_in_millis`<br/>`DGAUGE`, ms | Total duration of all `refresh` operations |
| `opensearch_indices_refresh_total`<br/>`DGAUGE`, count | Total number of all `refresh` operations |
| `opensearch_indices_request_cache_evictions`<br/>`DGAUGE`, count | Number of shard-level `request cache` evictions |
| `opensearch_indices_request_cache_hit_count`<br/>`DGAUGE`, count | Number of shard-level request cache hits |
| `opensearch_indices_request_cache_memory_size_in_bytes`<br/>`DGAUGE`, bytes | Memory used by the shard-level request cache |
| `opensearch_indices_request_cache_miss_count`<br/>`DGAUGE`, count | Number of shard-level request cache misses |
| `opensearch_indices_search_concurrent_avg_slice_count`<br/>`DGAUGE`, count | Average number of `slices` concurrent search queries are broken into. |
| `opensearch_indices_search_concurrent_query_current`<br/>`DGAUGE`, count | Number of ongoing concurrent search queries |
| `opensearch_indices_search_concurrent_query_time_in_millis`<br/>`DGAUGE`, ms | Total duration of concurrent search queries |
| `opensearch_indices_search_concurrent_query_total`<br/>`DGAUGE`, count | Total number of concurrent search queries |
| `opensearch_indices_search_fetch_current`<br/>`DGAUGE`, count | Number of ongoing `fetch` phases (getting document body). |
| `opensearch_indices_search_fetch_time_in_millis`<br/>`DGAUGE`, ms | Total duration of `fetch` phases |
| `opensearch_indices_search_fetch_total`<br/>`DGAUGE`, count | Total number of `fetch` phases |
| `opensearch_indices_search_open_contexts`<br/>`DGAUGE`, count | Number of open search contexts (including `scroll` and `point-in-time`) |
| `opensearch_indices_search_point_in_time_current`<br/>`DGAUGE`, count | Number of currently active `point-in-time` searches |
| `opensearch_indices_search_point_in_time_time_in_millis`<br/>`DGAUGE`, ms | Total duration of `point-in-time` searches |
| `opensearch_indices_search_point_in_time_total`<br/>`DGAUGE`, count | Total number of `point-in-time` searches |
| `opensearch_indices_search_query_current`<br/>`DGAUGE`, count | Number of ongoing `query` phases |
| `opensearch_indices_search_query_time_in_millis`<br/>`DGAUGE`, ms | Total duration of `query` phases |
| `opensearch_indices_search_query_total`<br/>`DGAUGE`, count | Total number of `query` phases |
| `opensearch_indices_search_request_can_match_current`<br/>`DGAUGE`, count | Number of ongoing `can_match` phases (shard prefiltering before a query) |
| `opensearch_indices_search_request_can_match_time_in_millis`<br/>`DGAUGE`, ms | Total duration of `can_match` phases |
| `opensearch_indices_search_request_can_match_total`<br/>`DGAUGE`, count | Total number of `can_match` phases |
| `opensearch_indices_search_request_dfs_pre_query_current`<br/>`DGAUGE`, count | Number of ongoing `dfs_pre_query` phases (`Distributed Frequency Search`, global term statistics collection) |
| `opensearch_indices_search_request_dfs_pre_query_time_in_millis`<br/>`DGAUGE`, ms | Total duration of `dfs_pre_query` phases |
| `opensearch_indices_search_request_dfs_pre_query_total`<br/>`DGAUGE`, count | Total number of `dfs_pre_query` phases |
| `opensearch_indices_search_request_dfs_query_current`<br/>`DGAUGE`, count | Number of ongoing `dfs_query` phases |
| `opensearch_indices_search_request_dfs_query_time_in_millis`<br/>`DGAUGE`, ms | Total duration of `dfs_query` phases |
| `opensearch_indices_search_request_dfs_query_total`<br/>`DGAUGE`, count | Total number of `dfs_query` phases |
| `opensearch_indices_search_request_expand_current`<br/>`DGAUGE`, count | Number of ongoing `expand` phases (`collapse` grouping expansion) |
| `opensearch_indices_search_request_expand_time_in_millis`<br/>`DGAUGE`, ms | Total duration of `expand` phases |
| `opensearch_indices_search_request_expand_total`<br/>`DGAUGE`, count | Total number of `expand` phases |
| `opensearch_indices_search_request_fetch_current`<br/>`DGAUGE`, count | Number of ongoing query-level `fetch` phases |
| `opensearch_indices_search_request_fetch_time_in_millis`<br/>`DGAUGE`, ms | Total duration of query-level `fetch` phases |
| `opensearch_indices_search_request_fetch_total`<br/>`DGAUGE`, count | Total number of query-level `fetch` phases |
| `opensearch_indices_search_request_query_current`<br/>`DGAUGE`, count | Number of ongoing query-level `query` phases |
| `opensearch_indices_search_request_query_time_in_millis`<br/>`DGAUGE`, ms | Total duration of query-level `query` phases |
| `opensearch_indices_search_request_query_total`<br/>`DGAUGE`, count | Total number of query-level `query` phases |
| `opensearch_indices_search_scroll_current`<br/>`DGAUGE`, count | Number of active `scroll` contexts |
| `opensearch_indices_search_scroll_time_in_millis`<br/>`DGAUGE`, ms | Total duration of `scroll` operations |
| `opensearch_indices_search_scroll_total`<br/>`DGAUGE`, count | Total number of `scroll` operations |
| `opensearch_indices_search_suggest_current`<br/>`DGAUGE`, count | Number of running `suggest` queries |
| `opensearch_indices_search_suggest_time_in_millis`<br/>`DGAUGE`, ms | Total duration of `suggest` queries |
| `opensearch_indices_search_suggest_total`<br/>`DGAUGE`, count | Total number of `suggest` queries |
| `opensearch_indices_segments_count`<br/>`DGAUGE`, count | Number of Lucene segments per node |
| `opensearch_indices_segments_doc_values_memory_in_bytes`<br/>`DGAUGE`, bytes | Memory consumed by `doc_values` structures used for sorting and aggregation |
| `opensearch_indices_segments_fixed_bit_set_memory_in_bytes`<br/>`DGAUGE`, bytes | Memory used by `FixedBitSet`, e.g., for parent-child queries |
| `opensearch_indices_segments_index_writer_memory_in_bytes`<br/>`DGAUGE`, bytes | Memory used by `IndexWriter` buffers (document buffering prior to `flush`) |
| `opensearch_indices_segments_max_unsafe_auto_id_timestamp`<br/>`DGAUGE`, timestamp | Maximum `unsafe` timestamp for an auto-generated document ID |
| `opensearch_indices_segments_memory_in_bytes`<br/>`DGAUGE`, bytes | Total amount of memory used by segments |
| `opensearch_indices_segments_norms_memory_in_bytes`<br/>`DGAUGE`, bytes | Memory used by `norms` data (normalization of the scoring field length) |
| `opensearch_indices_segments_points_memory_in_bytes`<br/>`DGAUGE`, bytes | Memory used by `points` structures (numeric and geo fields) |
| `opensearch_indices_segments_remote_store_download_total_download_size_failed_bytes`<br/>`DGAUGE`, bytes | Total size of failed segment downloads from `remote store` |
| `opensearch_indices_segments_remote_store_download_total_download_size_started_bytes`<br/>`DGAUGE`, bytes | Total size of initiated segment downloads from `remote store` |
| `opensearch_indices_segments_remote_store_download_total_download_size_succeeded_bytes`<br/>`DGAUGE`, bytes | Total size of successful segment downloads from `remote store` |
| `opensearch_indices_segments_remote_store_download_total_time_spent_in_millis`<br/>`DGAUGE`, ms | Total duration of segment downloads from `remote store` |
| `opensearch_indices_segments_remote_store_upload_max_refresh_time_lag_in_millis`<br/>`DGAUGE`, ms | Maximum lag between a local `refresh` and segment upload to `remote store` |
| `opensearch_indices_segments_remote_store_upload_pressure_total_rejections`<br/>`DGAUGE`, count | Number of rejected `remote store` segment uploads due to backpressure |
| `opensearch_indices_segments_remote_store_upload_refresh_size_lag_max_bytes`<br/>`DGAUGE`, bytes | Maximum size lag between the local state and the `remote store` state |
| `opensearch_indices_segments_remote_store_upload_refresh_size_lag_total_bytes`<br/>`DGAUGE`, bytes | Total size lag between the local state and the `remote store` state |
| `opensearch_indices_segments_remote_store_upload_total_time_spent_in_millis`<br/>`DGAUGE`, ms | Total duration of segment uploads to `remote store` |
| `opensearch_indices_segments_remote_store_upload_total_upload_size_failed_bytes`<br/>`DGAUGE`, bytes | Total size of unsuccessful segment uploads to `remote store` |
| `opensearch_indices_segments_remote_store_upload_total_upload_size_started_bytes`<br/>`DGAUGE`, bytes | Total size of initiated segment uploads to `remote store` |
| `opensearch_indices_segments_remote_store_upload_total_upload_size_succeeded_bytes`<br/>`DGAUGE`, bytes | Total size of successful segment uploads to `remote store` |
| `opensearch_indices_segments_segment_replication_max_bytes_behind`<br/>`DGAUGE`, bytes | Maximum lag between a replica and the primary shard during `segment replication`, in bytes |
| `opensearch_indices_segments_segment_replication_max_replication_lag`<br/>`DGAUGE`, count | Maximum `segment replication` lag measured as the number of `refresh` operations |
| `opensearch_indices_segments_segment_replication_total_bytes_behind`<br/>`DGAUGE`, bytes | Total lag between replicas and primary shards, in bytes |
| `opensearch_indices_segments_stored_fields_memory_in_bytes`<br/>`DGAUGE`, bytes | Memory used by `stored fields`, e.g., `_source` |
| `opensearch_indices_segments_term_vectors_memory_in_bytes`<br/>`DGAUGE`, bytes | Memory used by `term vectors` |
| `opensearch_indices_segments_terms_memory_in_bytes`<br/>`DGAUGE`, bytes | Memory used by the term dictionary |
| `opensearch_indices_segments_version_map_memory_in_bytes`<br/>`DGAUGE`, bytes | Memory used by the document `version map` |
| `opensearch_indices_store_reserved_in_bytes`<br/>`DGAUGE`, bytes | Disk space reserved for ongoing operation, e.g., recovery |
| `opensearch_indices_store_size_in_bytes`<br/>`DGAUGE`, bytes | Total disk space used by node indexes |
| `opensearch_indices_translog_earliest_last_modified_age`<br/>`DGAUGE`, ms | Age of the earliest uncommited operation in the translog |
| `opensearch_indices_translog_operations`<br/>`DGAUGE`, count | Number of operations in the translog |
| `opensearch_indices_translog_remote_store_upload_total_upload_size_failed_bytes`<br/>`DGAUGE`, bytes | Total size of failed translog uploads to `remote store` |
| `opensearch_indices_translog_remote_store_upload_total_upload_size_started_bytes`<br/>`DGAUGE`, bytes | Total size of initiated translog uploads to `remote store` |
| `opensearch_indices_translog_remote_store_upload_total_upload_size_succeeded_bytes`<br/>`DGAUGE`, bytes | Total size of successful translog uploads to `remote store` |
| `opensearch_indices_translog_remote_store_upload_total_uploads_failed`<br/>`DGAUGE`, count | Number of unsuccessful translog uploads to `remote store` |
| `opensearch_indices_translog_remote_store_upload_total_uploads_started`<br/>`DGAUGE`, count | Number of initiated translog uploads to `remote store` |
| `opensearch_indices_translog_remote_store_upload_total_uploads_succeeded`<br/>`DGAUGE`, count | Number of successful translog uploads to `remote store` |
| `opensearch_indices_translog_size_in_bytes`<br/>`DGAUGE`, bytes | Translog size on disk |
| `opensearch_indices_translog_uncommitted_operations`<br/>`DGAUGE`, count | Number of uncommited operations in the translog |
| `opensearch_indices_translog_uncommitted_size_in_bytes`<br/>`DGAUGE`, bytes | Size of the uncommited translog part |
| `opensearch_indices_warmer_current`<br/>`DGAUGE`, count | Number of current `warmer` operations |
| `opensearch_indices_warmer_total_time_in_millis`<br/>`DGAUGE`, ms | Total duration of `warmer` operations |
| `opensearch_indices_warmer_total`<br/>`DGAUGE`, count | Total number of `warmer` operations |
| `opensearch_is_master`<br/>`DGAUGE`, 0/1 | Master node indicator (`cluster_manager`) |
| `opensearch_jvm_gc_collectors_old_collection_count`<br/>`DGAUGE`, count | Number of garbage collections in the old generation (Old GC) |
| `opensearch_jvm_gc_collectors_young_collection_count`<br/>`DGAUGE`, count | Number of garbage collections in the young generation (Young GC) |
| `opensearch_jvm_mem_heap_committed_in_bytes`<br/>`DGAUGE`, bytes | JVM `heap` amount allocated by the OS |
| `opensearch_jvm_mem_heap_max_in_bytes`<br/>`DGAUGE`, bytes | Maximum JVM `heap` size |
| `opensearch_jvm_mem_heap_pressure`<br/>`DGAUGE` | JVM `heap` pressure indicator calculated based on `heap` usage and GC activity |
| `opensearch_jvm_mem_heap_used_in_bytes`<br/>`DGAUGE`, bytes | Current amount of used JVM `heap` memory. |
| `opensearch_jvm_mem_heap_used_percent`<br/>`DGAUGE`, % | Percentage of used JVM `heap` |
| `opensearch_jvm_mem_non_heap_committed_in_bytes`<br/>`DGAUGE`, bytes | JVM `non-heap` memory allocated by the OS (Metaspace, Code Cache) |
| `opensearch_jvm_mem_non_heap_used_in_bytes`<br/>`DGAUGE`, bytes | JVM `non-heap` memory in use |
| `opensearch_jvm_mem_pools_old_max_in_bytes`<br/>`DGAUGE`, bytes | Maximum memory pool size for the JVM old generation |
| `opensearch_jvm_mem_pools_old_used_in_bytes`<br/>`DGAUGE`, bytes | Size of old generation JVM memory in use |
| `opensearch_number_of_data_nodes`<br/>`DGAUGE`, count | Number of data nodes in the cluster |
| `opensearch_number_of_in_flight_fetch`<br/>`DGAUGE`, count | Number of running shard state fetch queries |
| `opensearch_number_of_nodes`<br/>`DGAUGE`, count | Total number of cluster nodes |
| `opensearch_number_of_pending_tasks`<br/>`DGAUGE`, count | Number of pending cluster state update tasks |
| `opensearch_process_cpu_percent`<br/>`DGAUGE`, % | CPU usage percentage by the OpenSearch process |
| `opensearch_process_cpu_total_in_millis`<br/>`DGAUGE`, ms | Total CPU time consumed by the OpenSearch process |
| `opensearch_process_max_file_descriptors`<br/>`DGAUGE`, count | Maximum number of file descriptors allowed for the process |
| `opensearch_process_mem_total_virtual_in_bytes`<br/>`DGAUGE`, bytes | Virtual memory used by the OpenSearch process |
| `opensearch_process_open_file_descriptors`<br/>`DGAUGE`, count | Number of file descriptors currently opened by the process |
| `opensearch_process_timestamp`<br/>`DGAUGE`, timestamp | Process statistics collection timestamp |
| `opensearch_task_max_waiting_in_queue_millis`<br/>`DGAUGE`, ms | Maximum task queue waiting time |
| `opensearch_thread_pool_<thread_pool_name>_active`<br/>`DGAUGE`, count | Number of active threads in a pool.<br/>This metric features the `thread_pool_name` special label containing the thread pool name. |
| `opensearch_thread_pool_<thread_pool_name>_completed`<br/>`DGAUGE`, count | Number of completed pool tasks |
| `opensearch_thread_pool_<thread_pool_name>_largest`<br/>`DGAUGE`, count | Maximum size the thread pool has reached. |
| `opensearch_thread_pool_<thread_pool_name>_queue`<br/>`DGAUGE`, count | Number of tasks in the pool queue |
| `opensearch_thread_pool_<thread_pool_name>_rejected`<br/>`DGAUGE`, count | Number of rejected tasks (pool queue overflow) |
| `opensearch_thread_pool_<thread_pool_name>_threads`<br/>`DGAUGE`, count | Current number of threads in the pool |
| `opensearch_thread_pool_<thread_pool_name>_total_wait_time_in_nanos`<br/>`DGAUGE`, nanoseconds | Total task waiting time in the pool queue |
| `opensearch_transport_rx_count`<br/>`DGAUGE`, count | Number of received transport-level messages. |
| `opensearch_transport_rx_size_in_bytes`<br/>`DGAUGE`, bytes | Total amount of received transport-level data |
| `opensearch_transport_server_open`<br/>`DGAUGE`, count | Number of opened transport-level server connections |
| `opensearch_transport_total_outbound_connections`<br/>`DGAUGE`, count | Total number of opened outgoing transport connections |
| `opensearch_transport_tx_count`<br/>`DGAUGE`, count | Number of sent transport-level messages |
| `opensearch_transport_tx_size_in_bytes`<br/>`DGAUGE`, bytes | Total size of sent transport-level data |

#### Other metrics {#managed-opensearch-other-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `dashboards_is_alive`<br/>`DGAUGE`, 0/1 | Host health indicator.<br/>`1` if the database host is healthy, `0` if not. | 
| `dashboards_metrics_requests_total`<br/>`DGAUGE`, count | Total cluster requests | 
| `opensearch_active_primary_shards`<br/>`DGAUGE`, count | Number of active [primary shards](../../../managed-opensearch/concepts/scalability-and-resilience.md) and total active shards in the cluster |
| `opensearch_active_shards_percent_as_number`<br/>`DGAUGE`, count | Percentage of active shards | 
| `opensearch_active_shards`<br/>`DGAUGE`, count | Number of active shards | 
| `opensearch_backup_age`<br/>`DGAUGE`, seconds | Most recent backup age |
| `opensearch_backup_free_space_required`<br/>`DGAUGE`, bytes | Storage size required to restore a cluster from a backup. |
| `opensearch_backup_incremental_size`<br/>`DGAUGE`, bytes | Size of files created during the incremental backup |
| `opensearch_backup_total_size`<br/>`DGAUGE`, bytes | Size of files referenced by the backup |
| `opensearch_critical_watermark_bytes`<br/>`DGAUGE`, bytes | Critical disk space usage threshold |
| `opensearch_critical_watermark_percentage`<br/>`DGAUGE`, % | Critical disk fill threshold |
| `opensearch_delayed_unassigned_shards`<br/>`DGAUGE`, count | Number of delayed unassigned shards |
| `opensearch_flood_stage_watermark_bytes`<br/>`DGAUGE`, bytes | Flood stage threshold for used disk space |
| `opensearch_flood_stage_watermark_percentage`<br/>`DGAUGE`, % | Flood stage disk fill threshold |
| `opensearch_high_watermark_bytes`<br/>`DGAUGE`, bytes | Upper threshold for used disk space |
| `opensearch_high_watermark_percentage`<br/>`DGAUGE`, percentage | Disk fill upper threshold |
| `opensearch_initializing_shards`<br/>`DGAUGE`, count | Number of shards currently initializing | 
| `opensearch_is_alive`<br/>`DGAUGE`, 0/1 | Host health indicator.<br/>It can be either `1` if a DB host is healthy or `0` if not. | 
| `opensearch_low_watermark_bytes`<br/>`DGAUGE`, bytes | Lower threshold for used disk space |
| `opensearch_low_watermark_percentage`<br/>`DGAUGE`, percentage | Disk fill lower threshold |
| `opensearch_primary_shards_count`<br/>`DGAUGE`, count | Number of primary shards per cluster |
| `opensearch_relocating_shards`<br/>`DGAUGE`, count | Number of shards being relocated | 
| `opensearch_shards_count`<br/>`DGAUGE`, count | Total number of shards per cluster |
| `opensearch_status_green`<br/>`DGAUGE`, 0/1 | Green (healthy) cluster status indicator |
| `opensearch_status_red`<br/>`DGAUGE`, 0/1 | Red (unhealthy) cluster status indicator |
| `opensearch_status_yellow`<br/>`DGAUGE`, 0/1 | Yellow (partially healthy) cluster status indicator |
| `opensearch_status`<br/>`DGAUGE`, 0/1/2 | Cluster health and technical condition:<br/>`0` (red): Cluster is unhealthy or partially functional. At least one of the primary shards is not available. If the cluster is responding to queries, search results in the responses will be incomplete.<br/>`1` (yellow): Cluster is functional. One or more shard replicas are inaccessible. Search results in the cluster responses are complete, but if more shards become unavailable, the cluster performance will be disrupted.<br/>`2` (green): Cluster is healthy. All cluster shards are available. |
| `opensearch_unassigned_shards`<br/>`DGAUGE`, count | Number of inactive shards with no host assigned |
| `opensearch_unassigned_user_shards_count`<br/>`DGAUGE`, count | Number of unassigned custom shards |
| `opensearch_user_shards_without_primary_count`<br/>`DGAUGE`, count | Number of custom shards without primary backups |
| `opensearch_user_shards_without_replica_count`<br/>`DGAUGE`, count | Number of custom shards without replicas |


[*guest]: Time servicing a guest OS.

[*guest_nice]: Time servicing a low-priority guest OS.

[*idle]: CPU idle time.

[*iowait]: I/O completion wait time.

[*irq]: Hardware interrupt processing time.

[*nice]: Execution time of low-priority processes.

[*softirq]: Software interrupt processing time.

[*steal]: Time the hypervisor spends on servicing other vCPUs.

[*system]: System process execution time (kernel mode).

[*user]: User process execution time.

[*available]: Memory available for running new applications without a swap file.

[*buffered]: Memory used for kernel buffers (temporary storage for block device data).

[*buffers]: Memory used for kernel buffers (temporary storage for block device data).

[*cached]: Memory used for the file system cache (pages read from disk).

[*commit_limit]: Total memory the system can allocate, including the swap file.

[*committed_as]: Memory reserved for executing all operations (may exceed the physical memory).

[*dirty]: Memory waiting to be written to disk (modified cache data).

[*free]: Available unused memory.

[*high_free]: Available memory in the high memory area (for systems with memory allocation).

[*high_total]: Total memory in the high memory area.

[*huge_page_size]: Size of a huge memory page.

[*huge_pages_free]: Number of free huge memory pages.

[*huge_pages_total]: Total number of huge memory pages.

[*inactive]: Amount of memory that is rarely used and, if required, can be swapped out.

[*low_free]: Available memory in the low memory area (for systems with memory allocation).

[*low_total]: Total memory in the low memory area.

[*mapped]: Memory displayed in the process address spaces (files and shared libraries).

[*page_tables]: Memory used for page tables (virtual memory management structures).

[*shared]: Memory used for in-memory temporary file systems.

[*slab]: Memory used by the kernel to cache frequently used data structures.

[*sreclaimable]: Part of the kernel memory that can be reclaimed under memory pressure.

[*sunreclaim]: Part of the kernel memory that cannot be reclaimed.

[*swap_cached]: Memory that has been swapped out but is still in RAM.

[*swap_free]: Free space in the swap file.

[*swap_total]: Total swap file size.

[*total]: Total amount of RAM.

[*used]: Amount of used RAM.

[*vmalloc_chunk]: Size of the largest contiguous block in the kernel virtual memory area.

[*vmalloc_total]: Total size of the kernel virtual memory area.

[*vmalloc_used]: Amount of kernel virtual memory currently in use.

[*write_back]: Memory with data currently being written to disk.

[*write_back_tmp]: Amount of temporary memory for write operations.