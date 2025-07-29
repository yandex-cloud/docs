The metric name goes into the `name` label.

Labels shared by all {{ mos-name }} metrics: 

Label | Value
----|----
service | Service ID: `managed-opensearch`
resource_type | Resource type: `cluster`
resource_id | Cluster ID
host | Host FQDN

## CPU metrics {#managed-opensearch-cpu-metrics}
These metrics show processor core workload.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `cpu.fraction`<br/>`DGAUGE`, % | Guaranteed vCPU performance | 
| `cpu.guarantee`<br/>`DGAUGE`, count | Guaranteed number of cores | 
| `cpu.limit`<br/>`DGAUGE`, count | Maximum number of cores in use | 
| `cpu.guest`<br/>`DGAUGE`, % | CPU core usage, `guest` usage type | 
| `cpu.guest_nice`<br/>`DGAUGE`, % | CPU core usage, `guest_nice` usage type | 
| `cpu.idle`<br/>`DGAUGE`, % | CPU core usage, `idle` usage type | 
| `cpu.iowait`<br/>`DGAUGE`, % | CPU core usage, `iowait` usage type | 
| `cpu.irq`<br/>`DGAUGE`, % | CPU core usage, `irq` usage type | 
| `cpu.nice`<br/>`DGAUGE`, % | CPU core usage, `nice` usage type | 
| `cpu.softirq`<br/>`DGAUGE`, % | CPU core usage, `softirq` usage type | 
| `cpu.steal`<br/>`DGAUGE`, % | CPU core usage, `steal` usage type | 
| `cpu.system`<br/>`DGAUGE`, % | CPU core usage, `system` usage type | 
| `cpu.user`<br/>`DGAUGE`, % | CPU core usage, `user` usage type |
| `cpu_utilization_by_db_15`<br/>`DGAUGE`, % | Average VM processor core (vCPU) utilization by a database over 15 seconds (%). It ranges from 0% to the [vCPU performance level](../../../compute/concepts/performance-levels.md). | 
| `cpu_utilization_by_db_15_limit`<br/>`DGAUGE`, % | Maximum VM processor core (vCPU) utilization by a database over 15 seconds (%) | 
| `cpu_utilization_by_db_60`<br/>`DGAUGE`, % | Average VM processor core (vCPU) utilization by a database over 60 seconds (%) | 
| `cpu_utilization_by_db_60_limit`<br/>`DGAUGE`, % | Maximum VM processor core (vCPU) utilization by a database over 60 seconds (%) |
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
| `io.disk*.iops_in_progress`<br/>`DGAUGE`, count | Number of disk I/O operations in progress | 
| `io.disk*.merged_reads`<br/>`DGAUGE`, count | Number of merged read operations for a given disk | 
| `io.disk*.merged_writes`<br/>`DGAUGE`, count | Number of merged writes for a given disk | 
| `io.disk*.read_bytes`<br/>`DGAUGE`, bytes per second | Read speed for a given disk | 
| `io.disk*.read_count`<br/>`DGAUGE`, operations per second | Number of reads per second for a given disk | 
| `io.disk*.read_time`<br/>`DGAUGE`, milliseconds | Average read time for a given disk | 
| `io.disk*.utilization`<br/>`DGAUGE`, % | Utilization of a given disk; disabled for network drives. | 
| `io.disk*.weighted_io_time`<br/>`DGAUGE`, milliseconds | I/O wait time for a given disk | 
| `io.disk*.write_bytes`<br/>`DGAUGE`, bytes per second | Write speed for a given disk | 
| `io.disk*.write_count`<br/>`DGAUGE`, operations per second | Number of writes per second for a given disk | 
| `io.disk*.write_time`<br/>`DGAUGE`, milliseconds | Average write time for a given disk | 

## RAM metrics {#managed-opensearch-ram-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.active_bytes`<br/>`DGAUGE`, bytes | Active resident memory (frequently accessed and released when absolutely necessary) | 
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
| `mem.used_bytes`<br/>`DGAUGE`, bytes | Amount of RAM currently used by running processes | 
| `mem.used_percent_bytes`<br/>`DGAUGE`, % | Percentage of used RAM | 
| `mem.vmalloc_chunk_bytes`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_chunk` usage type | 
| `mem.vmalloc_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_total` usage type | 
| `mem.vmalloc_used_bytes`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_used` usage type | 
| `mem.write_back_bytes`<br/>`DGAUGE`, bytes | RAM usage, `write_back` usage type | 
| `mem.write_back_tmp_bytes`<br/>`DGAUGE`, bytes | RAM usage, `write_back_tmp` usage type |

## Network metrics {#managed-opensearch-net-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, bytes per second | Network data receive rate | 
| `net.bytes_sent`<br/>`DGAUGE`, bytes per second | Network data transmit rate | 
| `net.drop_in`<br/>`DGAUGE`, count | Dropped receive packets | 
| `net.drop_out`<br/>`DGAUGE`, count | Dropped transmit packets | 
| `net.dropin`<br/>`DGAUGE`, count | Dropped receive packets | 
| `net.dropout`<br/>`DGAUGE`, count | Dropped transmit packets | 
| `net.err_in`<br/>`DGAUGE`, count | Receive error count | 
| `net.err_out`<br/>`DGAUGE`, count | Transmit error count | 
| `net.errin`<br/>`DGAUGE`, count | Receive error count | 
| `net.errout`<br/>`DGAUGE`, count | Transmit error count | 
| `net.packets_recv`<br/>`DGAUGE`, packets per second | Network packet receive rate | 
| `net.packets_sent`<br/>`DGAUGE`, packets per second | Network packet transmit rate | 

## Service metrics {#managed-opensearch-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `active`<br/>`DGAUGE`, count | Active resident memory (frequently accessed and released when absolutely necessary) |
| `available`<br/>`DGAUGE`, count | RAM usage, `available` usage type |
| `available_percent`<br/>`DGAUGE`, % | Percentage of RAM usage, `available` usage type |
| `buffered`<br/>`DGAUGE`, bytes | RAM usage, `buffered` usage type |
| `bytes_recv`<br/>`DGAUGE`, bytes | Size of data received |
| `bytes_sent`<br/>`DGAUGE`, bytes | Size of data sent |
| `cached`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type |
| `commit_limit`<br/>`DGAUGE`, bytes | RAM usage, `commit_limit` usage type |
| `committed_as`<br/>`DGAUGE`, bytes | RAM usage, `committed_as` usage type |
| `dirty`<br/>`DGAUGE`, bytes | RAM usage, `dirty` usage type | 
| `drop_in`<br/>`DGAUGE`, count | Dropped receive packets | 
| `drop_out`<br/>`DGAUGE`, count | Dropped transmit packets | 
| `err_in`<br/>`DGAUGE`, count | Receive error count | 
| `err_out`<br/>`DGAUGE`, count | Transmit error count | 
| `free`<br/>`DGAUGE`, bytes | RAM usage, `free` usage type | 
| `high_free`<br/>`DGAUGE`, bytes | RAM usage, `high_free` usage type | 
| `high_total`<br/>`DGAUGE`, bytes | RAM usage, `high_total` usage type | 
| `huge_page_size`<br/>`DGAUGE`, bytes | RAM usage, `huge_page_size` usage type | 
| `huge_pages_free`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_free` usage type | 
| `huge_pages_total`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_total` usage type | 
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
| `inactive`<br/>`DGAUGE`, bytes | RAM usage, `inactive` usage type | 
| `index_docs_count`<br/>`DGAUGE`, count | Number of documents in the index. Displays 10 indexes with the largest number of documents. Only applies to indexes larger than 1 MB. |
| `index_primary_store_size`<br/>`DGAUGE`, bytes | Index size. Displays 10 largest indexes. Only applies to indexes larger than 1 MB. |
| `inodes_free`<br/>`DGAUGE`, count | Free inodes | 
| `inodes_total`<br/>`DGAUGE`, count | Available inodes | 
| `inodes_used`<br/>`DGAUGE`, count | Used inodes |
| `instance_userfault_broken`<br/>`DGAUGE`, 0/1 | Indicator of host failure due to user fault. |
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
| `ip_reasmfails`<br/>`DGAUGE`, count | Number of failures detected by the IP reassembly algorithm due to reasons, such as timeouts, errors, etc. This is not necessarily a count of dropped IP fragments, since certain algorithms, like the one in RFC 815, may lose count of fragments while reassembling them as they are received. | 
| `ip_reasmoks`<br/>`DGAUGE`, count | Number of IP packets successfully reassembled | 
| `ip_reasmreqds`<br/>`DGAUGE`, count | Number of received IP fragments requiring reassembly in the object in question | 
| `ip_reasmtimeout`<br/>`DGAUGE`, seconds | Maximum time, in seconds, received fragments are kept while awaiting reassembly in the object in question. | 
| `low_free`<br/>`DGAUGE`, bytes | RAM usage, `low_free` usage type | 
| `low_total`<br/>`DGAUGE`, bytes | RAM usage, `low_total` usage type | 
| `mapped`<br/>`DGAUGE`, bytes | RAM usage, `mapped` usage type | 
| `merged_reads`<br/>`DGAUGE`, count | Number of merged disk reads | 
| `merged_writes`<br/>`DGAUGE`, count | Number of merged disk writes | 
| `n_cpus`<br/>`DGAUGE`, count | Maximum number of cores in use | 
| `n_users`<br/>`DGAUGE`, count | Limit on the number of users | 
| `packets_recv`<br/>`DGAUGE`, packets per second | Network packet receive rate | 
| `packets_sent`<br/>`DGAUGE`, packets per second | Network packet transmit rate | 
| `page_tables`<br/>`DGAUGE`, bytes | RAM usage, `page_tables` usage type | 
| `read_bytes`<br/>`DGAUGE`, bytes per second | Read speed for a given disk | 
| `read_count`<br/>`DGAUGE`, operations per second | Number of reads per second for a given disk | 
| `read_time`<br/>`DGAUGE`, milliseconds | Average disk read time | 
| `shared`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type | 
| `slab`<br/>`DGAUGE`, bytes | RAM usage, `slab` usage type | 
| `sreclaimable`<br/>`DGAUGE`, bytes | RAM usage, `sreclaimable` usage type | 
| `sunreclaim`<br/>`DGAUGE`, bytes | RAM usage, `sunreclaim` usage type | 
| `swap_cached`<br/>`DGAUGE`, bytes | RAM usage, `swap_cached` usage type | 
| `swap_free`<br/>`DGAUGE`, bytes | RAM usage, `swap_free` usage type | 
| `swap_total`<br/>`DGAUGE`, bytes | RAM usage, `swap_total` usage type | 
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
| `tcp_rtomax`<br/>`DGAUGE`, milliseconds | Maximum TCP retransmission timeout, in milliseconds | 
| `tcp_rtomin`<br/>`DGAUGE`, milliseconds | Minimum TCP retransmission timeout, in milliseconds | 
| `total`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type | 
| `udp_ignoredmulti`<br/>`DGAUGE`, count | Number of UDP multicast packets ignored | 
| `udp_incsumerrors`<br/>`DGAUGE`, count | This value increases when a received UDP packet contains an invalid kernel code checksum. | 
| `udp_indatagrams`<br/>`DGAUGE`, count | Total UDP packets received  | 
| `udp_inerrors`<br/>`DGAUGE`, count | Number of bad UDP packets received, excluding those with checksum errors  | 
| `udp_noports`<br/>`DGAUGE`, count | Total UDP packets received with no application on the destination port | 
| `udp_outdatagrams`<br/>`DGAUGE`, count | Total UDP packets sent from the object in question | 
| `udp_rcvbuferrors`<br/>`DGAUGE`, count | Number of UDP receive buffer errors  | 
| `udp_sndbuferrors`<br/>`DGAUGE`, count | Number of UDP send buffer errors  | 
| `udplite_ignoredmulti`<br/>`DGAUGE`, count | Number of UDP-Lite multicast packets ignored  | 
| `udplite_incsumerrors`<br/>`DGAUGE`, count | This value increases when a received UDP-Lite packet contains an invalid kernel code checksum. | 
| `udplite_indatagrams`<br/>`DGAUGE`, count | Total UDP-Lite packets received  | 
| `udplite_inerrors`<br/>`DGAUGE`, count | Total UDP-Lite packet receive errors  | 
| `udplite_noports`<br/>`DGAUGE`, count | Total UDP-Lite packets received without a listener on the destination port. Irregularities in this counter may occur when reinitializing the management system and at other times, as indicated by the `udplite_statsdiscontinuitytime` value. | 
| `udplite_outdatagrams`<br/>`DGAUGE`, count | Total UDP-Lite packets sent  | 
| `udplite_rcvbuferrors`<br/>`DGAUGE`, count | This value increases when no memory can be allocated to process an inbound UDP-Lite packet. | 
| `udplite_sndbuferrors`<br/>`DGAUGE`, count | This value increases when no memory can be allocated to send an inbound UDP-Lite packet. | 
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
| `utilization`<br/>`DGAUGE`, % | Average VM processor core (vCPU) utilization by a database | 
| `vmalloc_chunk`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_chunk` usage type | 
| `vmalloc_total`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_total` usage type | 
| `vmalloc_used`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_used` usage type | 
| `weighted_io_time`<br/>`DGAUGE`, milliseconds | I/O wait time | 
| `write_back`<br/>`DGAUGE`, bytes | RAM usage, `write_back` usage type | 
| `write_back_tmp`<br/>`DGAUGE`, bytes | RAM usage, `write_back_tmp` usage type |
| `write_bytes`<br/>`DGAUGE`, bytes per second | Disk write speed | 
| `write_count`<br/>`DGAUGE`, operations per second | Number of writes per second | 
| `write_time`<br/>`DGAUGE`, milliseconds | Average disk write time | 

#### {{ OS }} native metrics {#managed-opensearch-system-metrics}

| Name<br/>Type, units | 
| ----- | 
| `opensearch_discovered_cluster_manager`<br/>`DGAUGE`, 0/1 | 
| `opensearch_discovered_master`<br/>`DGAUGE`, 0/1 | 
| `opensearch_fs_io_stats_total_operations`<br/>`DGAUGE`, count | 
| `opensearch_fs_io_stats_total_read_kilobytes`<br/>`DGAUGE`, kilobytes | 
| `opensearch_fs_io_stats_total_read_operations`<br/>`DGAUGE`, count | 
| `opensearch_fs_io_stats_total_write_kilobytes`<br/>`DGAUGE`, kilobytes | 
| `opensearch_fs_io_stats_total_write_operations`<br/>`DGAUGE`, count | 
| `opensearch_fs_total_available_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_fs_total_cache_reserved_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_fs_total_free_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_fs_total_total_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_fs_total_used_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_fs_total_used_percent`<br/>`DGAUGE`, count | 
| `opensearch_http_current_open`<br/>`DGAUGE`, count |
| `opensearch_http_total_opened`<br/>`DGAUGE`, count |
| `opensearch_indices_completion_size_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_docs_count`<br/>`DGAUGE`, count | 
| `opensearch_indices_docs_deleted`<br/>`DGAUGE`, count | 
| `opensearch_indices_fielddata_evictions`<br/>`DGAUGE`, count | 
| `opensearch_indices_fielddata_memory_size_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_flush_periodic`<br/>`DGAUGE`, count | 
| `opensearch_indices_flush_total`<br/>`DGAUGE`, count | 
| `opensearch_indices_flush_total_time_in_millis`<br/>`DGAUGE`, milliseconds | 
| `opensearch_indices_get_current`<br/>`DGAUGE`, count | 
| `opensearch_indices_get_exists_time_in_millis`<br/>`DGAUGE`, milliseconds | 
| `opensearch_indices_get_exists_total`<br/>`DGAUGE`, count | 
| `opensearch_indices_get_missing_time_in_millis`<br/>`DGAUGE`, milliseconds | 
| `opensearch_indices_get_missing_total`<br/>`DGAUGE`, count | 
| `opensearch_indices_get_time_in_millis`<br/>`DGAUGE`, milliseconds | 
| `opensearch_indices_get_total`<br/>`DGAUGE`, count |
| `opensearch_indices_indexing_delete_current`<br/>`DGAUGE`, count |
| `opensearch_indices_indexing_delete_time_in_millis`<br/>`DGAUGE`, milliseconds | 
| `opensearch_indices_indexing_delete_total`<br/>`DGAUGE`, count | 
| `opensearch_indices_indexing_index_current`<br/>`DGAUGE`, count | 
| `opensearch_indices_indexing_index_failed`<br/>`DGAUGE`, count | 
| `opensearch_indices_indexing_index_time_in_millis`<br/>`DGAUGE`, milliseconds  | 
| `opensearch_indices_indexing_index_total`<br/>`DGAUGE`, count | 
| `opensearch_indices_indexing_noop_update_total`<br/>`DGAUGE`, count | 
| `opensearch_indices_indexing_throttle_time_in_millis`<br/>`DGAUGE`, milliseconds | 
| `opensearch_indices_merges_current`<br/>`DGAUGE`, count | 
| `opensearch_indices_merges_current_docs`<br/>`DGAUGE`, count | 
| `opensearch_indices_merges_current_size_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_merges_total`<br/>`DGAUGE`, count | 
| `opensearch_indices_merges_total_auto_throttle_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_merges_total_docs`<br/>`DGAUGE`, count | 
| `opensearch_indices_merges_total_size_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_merges_total_stopped_time_in_millis`<br/>`DGAUGE`, milliseconds | 
| `opensearch_indices_merges_total_throttled_time_in_millis`<br/>`DGAUGE`, milliseconds | 
| `opensearch_indices_merges_total_time_in_millis`<br/>`DGAUGE`, milliseconds | 
| `opensearch_indices_query_cache_cache_count`<br/>`DGAUGE`, count | 
| `opensearch_indices_query_cache_cache_size`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_query_cache_evictions`<br/>`DGAUGE`, count | 
| `opensearch_indices_query_cache_hit_count`<br/>`DGAUGE`, count | 
| `opensearch_indices_query_cache_memory_size_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_query_cache_miss_count`<br/>`DGAUGE`, count | 
| `opensearch_indices_query_cache_total_count`<br/>`DGAUGE`, count | 
| `opensearch_indices_recovery_current_as_source`<br/>`DGAUGE`, count | 
| `opensearch_indices_recovery_current_as_target`<br/>`DGAUGE`, count | 
| `opensearch_indices_recovery_throttle_time_in_millis`<br/>`DGAUGE`, milliseconds | 
| `opensearch_indices_refresh_external_total`<br/>`DGAUGE`, count | 
| `opensearch_indices_refresh_external_total_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_refresh_listeners`<br/>`DGAUGE`, count | 
| `opensearch_indices_refresh_total`<br/>`DGAUGE`, count | 
| `opensearch_indices_refresh_total_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_request_cache_evictions`<br/>`DGAUGE`, count | 
| `opensearch_indices_request_cache_hit_count`<br/>`DGAUGE`, count | 
| `opensearch_indices_request_cache_memory_size_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_request_cache_miss_count`<br/>`DGAUGE`, count | 
| `opensearch_indices_search_fetch_current`<br/>`DGAUGE`, count | 
| `opensearch_indices_search_fetch_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_search_fetch_total`<br/>`DGAUGE`, count | 
| `opensearch_indices_search_open_contexts`<br/>`DGAUGE`, count | 
| `opensearch_indices_search_point_in_time_current`<br/>`DGAUGE`, count | 
| `opensearch_indices_search_point_in_time_time_in_millis`<br/>`DGAUGE`, milliseconds | 
| `opensearch_indices_search_point_in_time_total`<br/>`DGAUGE`, count | 
| `opensearch_indices_search_query_current`<br/>`DGAUGE`, count | 
| `opensearch_indices_search_query_time_in_millis`<br/>`DGAUGE`, milliseconds | 
| `opensearch_indices_search_query_total`<br/>`DGAUGE`, count | 
| `opensearch_indices_search_scroll_current`<br/>`DGAUGE`, count | 
| `opensearch_indices_search_scroll_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_search_scroll_total`<br/>`DGAUGE`, count | 
| `opensearch_indices_search_suggest_current`<br/>`DGAUGE`, count | 
| `opensearch_indices_search_suggest_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_indices_search_suggest_total`<br/>`DGAUGE`, count | 
| `opensearch_indices_segments_count`<br/>`DGAUGE`, count | 
| `opensearch_indices_segments_doc_values_memory_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_segments_fixed_bit_set_memory_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_segments_index_writer_memory_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_segments_max_unsafe_auto_id_timestamp`<br/>`DGAUGE`, timestamp | 
| `opensearch_indices_segments_memory_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_segments_norms_memory_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_segments_points_memory_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_segments_stored_fields_memory_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_segments_term_vectors_memory_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_segments_terms_memory_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_segments_version_map_memory_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_store_reserved_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_store_size_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_translog_earliest_last_modified_age`<br/>`DGAUGE`, count | 
| `opensearch_indices_translog_operations`<br/>`DGAUGE`, count |
| `opensearch_indices_translog_size_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_translog_uncommitted_operations`<br/>`DGAUGE`, count |  | 
| `opensearch_indices_translog_uncommitted_size_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_indices_warmer_current`<br/>`DGAUGE`, count | 
| `opensearch_indices_warmer_total`<br/>`DGAUGE`, count | 
| `opensearch_indices_warmer_total_time_in_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_jvm_gc_collectors_old_collection_count`<br/>`DGAUGE`, count | 
| `opensearch_jvm_gc_collectors_young_collection_count`<br/>`DGAUGE`, count | 
| `opensearch_jvm_mem_heap_committed_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_jvm_mem_heap_max_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_jvm_mem_heap_pressure`<br/>`DGAUGE` | 
| `opensearch_jvm_mem_heap_used_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_jvm_mem_heap_used_percent`<br/>`DGAUGE`, count | 
| `opensearch_jvm_mem_non_heap_committed_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_jvm_mem_non_heap_used_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_jvm_mem_pools_old_max_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_jvm_mem_pools_old_used_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_number_of_data_nodes`<br/>`DGAUGE`, count | 
| `opensearch_number_of_in_flight_fetch`<br/>`DGAUGE`, count | 
| `opensearch_number_of_nodes`<br/>`DGAUGE`, count | 
| `opensearch_number_of_pending_tasks`<br/>`DGAUGE`, count | 
| `opensearch_process_cpu_percent`<br/>`DGAUGE`, count | 
| `opensearch_process_cpu_total_in_millis`<br/>`DGAUGE`, milliseconds | 
| `opensearch_process_max_file_descriptors`<br/>`DGAUGE`, count | 
| `opensearch_process_mem_total_virtual_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_process_open_file_descriptors`<br/>`DGAUGE`, count | 
| `opensearch_process_timestamp`<br/>`DGAUGE`, timestamp | 
| `opensearch_task_max_waiting_in_queue_millis`<br/>`DGAUGE`, milliseconds |
| `opensearch_thread_pool_<thread_pool_name>_active`<br/>`DGAUGE`, count | 
| `opensearch_thread_pool_<thread_pool_name>_completed`<br/>`DGAUGE`, count | 
| `opensearch_thread_pool_<thread_pool_name>_largest`<br/>`DGAUGE`, count | 
| `opensearch_thread_pool_<thread_pool_name>_queue`<br/>`DGAUGE`, count | 
| `opensearch_thread_pool_<thread_pool_name>_rejected`<br/>`DGAUGE`, count | 
| `opensearch_thread_pool_<thread_pool_name>_threads`<br/>`DGAUGE`, count | 
| `opensearch_transport_rx_count`<br/>`DGAUGE`, count | 
| `opensearch_transport_rx_size_in_bytes`<br/>`DGAUGE`, bytes | 
| `opensearch_transport_server_open`<br/>`DGAUGE`, count | 
| `opensearch_transport_total_outbound_connections`<br/>`DGAUGE`, count | 
| `opensearch_transport_tx_count`<br/>`DGAUGE`, count | 
| `opensearch_transport_tx_size_in_bytes`<br/>`DGAUGE`, bytes |

#### Other metrics {#managed-opensearch-other-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `opensearch_active_primary_shards`<br/>`DGAUGE`, count | Number of active [primary shards](../../../managed-opensearch/concepts/scalability-and-resilience.md) and total active shards in the cluster | 
| `opensearch_active_shards`<br/>`DGAUGE`, count | Number of active shards | 
| `opensearch_active_shards_percent_as_number`<br/>`DGAUGE`, count | Percentage of active shards | 
| `opensearch_delayed_unassigned_shards`<br/>`DGAUGE`, count | Number of shards pending assignment |
| `opensearch_initializing_shards`<br/>`DGAUGE`, count | Number of shards being initialized | 
| `opensearch_is_alive`<br/>`DGAUGE`, 0/1 | Host health indicator.<br/>It can be either `1` if a DB host is healthy or `0` if it is not. | 
| `opensearch_relocating_shards`<br/>`DGAUGE`, count | Number of shards being relocated | 
| `opensearch_status`<br/>`DGAUGE`, 0/1/2 | Cluster health and technical condition:<br/>`0` (red): Cluster is unhealthy or partially functional. At least one of the primary shards is unavailable. If the cluster is responding to requests, search results in the responses may be incomplete.<br/>`1` (yellow): Cluster is healthy. One or more shard replicas are inaccessible. The search results in the cluster responses are complete, but if more shards become unavailable, the cluster performance will be disrupted.<br/>`2` (green): Cluster is completely healthy. All cluster shards are available. |
| `opensearch_unassigned_shards`<br/>`DGAUGE`, count | Number of inactive shards with no host assigned |
| `dashboards_is_alive`<br/>`DGAUGE`, 0/1 | Host health indicator.<br/>It can be either `1` if a DB host is healthy or `0` if it is not. | 
| `dashboards_metrics_requests_total`<br/>`DGAUGE`, count | Total cluster requests | 
