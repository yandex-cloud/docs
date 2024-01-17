## {{ mmg-full-name }} service {#managed-mongodb}

Common labels for all {{ mmg-name }} metrics:

| Label | Value |
----|----
| service | Service ID: `managed-mongodb` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster ID |
| host | Host FQDN |
| node | Host type: `primary`, `secondary` |
| shard | Shard ID |

### CPU metrics {#managed-mongodb-cpu-metrics}
The load on processor cores.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `cpu.fraction`<br/>`DGAUGE`, % | Guaranteed vCPU share. |
| `cpu.guarantee`<br/>`DGAUGE`, number | Guaranteed number of cores. |
| `cpu.guest_nice`<br/>`DGAUGE`, % | CPU usage, `guest_nice` usage type. |
| `cpu.limit`<br/>`DGAUGE`, number | Limit on CPUs in use. |
| `cpu.guest`<br/>`DGAUGE`, % | CPU usage, `guest` usage type. |
| `cpu.idle`<br/>`DGAUGE`, % | CPU usage, `idle` usage type. |
| `cpu.iowait`<br/>`DGAUGE`, % | CPU usage, `iowait` usage type. |
| `cpu.irq`<br/>`DGAUGE`, % | CPU usage, `irq` usage type. |
| `cpu.nice`<br/>`DGAUGE`, % | CPU usage, `nice` usage type. |
| `cpu.softirq`<br/>`DGAUGE`, % | CPU usage, `softirq` usage type. |
| `cpu.steal`<br/>`DGAUGE`, % | CPU usage, `steal` usage type. |
| `cpu.system`<br/>`DGAUGE`, % | CPU usage, `system` usage type. |
| `cpu.user`<br/>`DGAUGE`, % | CPU usage, `user` usage type. |
| `cpu_utilization_by_db_60`<br/>`DGAUGE`, % | Average utilization of VM processor cores (vCPUs) by a database over 60 seconds (%). |
| `cpu_utilization_by_db_60_limit`<br/>`DGAUGE`, % | Maximum utilization of VM processor cores (vCPUs) by a database over 60 seconds (%). |

### Disk metrics {#managed-mongodb-disk-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, bytes | Free space. |
| `disk.free_inodes`<br/>`DGAUGE`, number | Number of free inodes. |
| `disk.total_bytes`<br/>`DGAUGE`, bytes | Available space. |
| `disk.total_inodes`<br/>`DGAUGE`, number | Available inodes. |
| `disk.used_bytes`<br/>`DGAUGE`, bytes | Used space. |
| `disk.used_inodes`<br/>`DGAUGE`, number | Used inodes. |
| `load.avg_15min`<br/>`DGAUGE`, % | Average load over 15 minutes. |
| `load.avg_1min`<br/>`DGAUGE`, % | Average load over 1 minute. |
| `load.avg_5min`<br/>`DGAUGE`, % | Average load over 5 minutes. |

### Disk operation metrics {#managed-mongodb-diskio-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `io.disk*.iops_in_progress`<br/>`DGAUGE`, number | Disk operations in progress. |
| `io.disk*.merged_reads`<br/>`DGAUGE`, number | Merged read operations for a specific disk. |
| `io.disk*.merged_writes`<br/>`DGAUGE`, number | Merged write operations for a specific disk. |
| `io.disk*.read_bytes`<br/>`DGAUGE`, bytes per second | Read speed for a specific disk. |
| `io.disk*.read_count`<br/>`DGAUGE`, operations per second | Read operations per second for a specific disk. |
| `io.disk*.read_time`<br/>`DGAUGE`, ms | Average read time for a specific disk. |
| `io.disk*.utilization`<br/>`DGAUGE`, % | Utilization of a specific disk; disabled for network drives. |
| `io.disk*.weighted_io_time`<br/>`DGAUGE`, ms | Waiting time for I/O operations on a specific disk. |
| `io.disk*.write_bytes`<br/>`DGAUGE`, bytes per second | Write speed for a specific disk. |
| `io.disk*.write_count`<br/>`DGAUGE`, operations per second | Number of write operations per second for a specific disk. |
| `io.disk*.write_time`<br/>`DGAUGE`, ms | Average write time for a specific disk. |

### RAM metrics {#managed-mongodb-ram-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.active_bytes`<br/>`DGAUGE`, bytes | Amount of RAM used most often and only freed up when absolutely necessary. |
| `mem.available_bytes`<br/>`DGAUGE`, bytes | RAM usage, `available` usage type. |
| `mem.available_percent_bytes`<br/>`DGAUGE`, % | Percentage of RAM usage, `available` usage type. |
| `mem.buffers_bytes`<br/>`DGAUGE`, bytes | RAM usage, `buffers` usage type. |
| `mem.cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type. |
| `mem.commit_limit_bytes`<br/>`DGAUGE`, bytes | RAM usage, `commit_limit` usage type. |
| `mem.committed_as_bytes`<br/>`DGAUGE`, bytes | RAM usage, `committed_as` usage type. |
| `mem.dirty_bytes`<br/>`DGAUGE`, bytes | RAM usage, `dirty` usage type. |
| `mem.free_bytes`<br/>`DGAUGE`, bytes | Amount of free RAM available, excluding `mem.buffers_bytes` and `mem.cached_bytes`. |
| `mem.high_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, `high_free` usage type. |
| `mem.high_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `high_total` usage type. |
| `mem.huge_page_size_bytes`<br/>`DGAUGE`, bytes | RAM usage, `huge_page_size` usage type. |
| `mem.huge_pages_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_free` usage type. |
| `mem.huge_pages_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_total` usage type. |
| `mem.inactive_bytes`<br/>`DGAUGE`, bytes | RAM usage, `inactive` usage type. |
| `mem.low_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, `low_free` usage type. |
| `mem.low_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `low_total` usage type. |
| `mem.mapped_bytes`<br/>`DGAUGE`, bytes | RAM usage, `mapped` usage type. |
| `mem.page_tables_bytes`<br/>`DGAUGE`, bytes | RAM usage, `page_tables` usage type. |
| `mem.slab_bytes`<br/>`DGAUGE`, bytes | RAM usage, `slab` usage type. |
| `mem.sreclaimable_bytes`<br/>`DGAUGE`, bytes | RAM usage, `sreclaimable` usage type. |
| `mem.sunreclaim_bytes`<br/>`DGAUGE`, bytes | RAM usage, `sunreclaim` usage type. |
| `mem.swap_cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, `swap_cached` usage type. |
| `mem.swap_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, `swap_free` usage type. |
| `mem.swap_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `swap_total` usage type. |
| `mem.shared_bytes`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type. |
| `mem.total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type. |
| `mem.used_bytes`<br/>`DGAUGE`, bytes | Amount of RAM currently used by the running processes. |
| `mem.used_percent_bytes`<br/>`DGAUGE`, % | Used RAM, %. |
| `mem.vmalloc_chunk_bytes`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_chunk` usage type. |
| `mem.vmalloc_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_total` usage type. |
| `mem.vmalloc_used_bytes`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_used` usage type. |
| `mem.write_back_bytes`<br/>`DGAUGE`, bytes | RAM usage, `write_back` usage type. |
| `mem.write_back_tmp_bytes`<br/>`DGAUGE`, bytes | RAM usage, `write_back_tmp` usage type. |

### Network metrics {#managed-mongodb-net-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, bytes per second | Rate of receiving data over the network. |
| `net.bytes_sent`<br/>`DGAUGE`, bytes per second | Rate of sending data over the network. |
| `net.dropin`<br/>`DGAUGE`, number | Packets dropped upon receipt. |
| `net.dropout`<br/>`DGAUGE`, number | Packets dropped when being sent. |
| `net.errin`<br/>`DGAUGE`, number | Number of errors upon receipt. |
| `net.errout`<br/>`DGAUGE`, number | Number of errors at sending. |
| `net.packets_recv`<br/>`DGAUGE`, packets per second | Rate of receiving packets over the network. |
| `net.packets_sent`<br/>`DGAUGE`, packets per second | Rate of sending packets over the network. |

### Service metrics {#managed-mongodb-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `active`<br/>`DGAUGE`, number | Number of active clusters. |
| `available`<br/>`DGAUGE`, number | Number of available clusters. |
| `available_percent`<br/>`DGAUGE`, % | Percentage of available clusters. |
| `buffered`<br/>`DGAUGE`, bytes | RAM usage, `buffered` usage type. |
| `bytes_recv`<br/>`DGAUGE`, bytes | Bytes received. |
| `bytes_sent`<br/>`DGAUGE`, bytes | Bytes sent. |
| `cached`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type. |
| `commit_limit`<br/>`DGAUGE`, bytes | RAM usage, `commit_limit` usage type. |
| `committed_as`<br/>`DGAUGE`, bytes | RAM usage, `committed_as` usage type. |
| `dirty`<br/>`DGAUGE`, bytes | RAM usage, `dirty` usage type. |
| `drop_in`<br/>`DGAUGE`, number | Packets dropped upon receipt. |
| `drop_out`<br/>`DGAUGE`, number | Packets dropped when being sent. |
| `err_in`<br/>`DGAUGE`, number | Number of errors upon receipt. |
| `err_out`<br/>`DGAUGE`, number | Number of errors at sending. |
| `free`<br/>`DGAUGE`, bytes | RAM usage, `free` usage type. |
| `high_free`<br/>`DGAUGE`, bytes | RAM usage, `high_free` usage type. |
| `high_total`<br/>`DGAUGE`, bytes | RAM usage, `high_total` usage type. |
| `huge_page_size`<br/>`DGAUGE`, bytes | RAM usage, `huge_page_size` usage type. |
| `huge_pages_free`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_free` usage type. |
| `huge_pages_total`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_total` usage type. |
| `icmp_inaddrmasks`<br/>`DGAUGE`, number | Number of ICMP Address Mask Request messages received. |
| `icmp_insrcquenchs`<br/>`DGAUGE`, number | Number of ICMP Parameter Problem messages received. |
| `icmp_intimestampreps`<br/>`DGAUGE`, number | Number of ICMP timestamp reply messages received. |
| `icmp_intimestamps`<br/>`DGAUGE`, number | Number of ICMP timestamp messages (requests) received. |
| `icmp_outaddrmasks`<br/>`DGAUGE`, number | Number of ICMP Address Mask Request messages sent. |
| `icmp_outdestunreachs`<br/>`DGAUGE`, number | Number of ICMP Destination Unreachable messages sent. |
| `icmp_outechoreps`<br/>`DGAUGE`, number | Number of ICMP Echo Reply messages sent. |
| `icmp_outerrors`<br/>`DGAUGE`, number | Number of ICMP messages this entity did not send due to problems discovered within ICMP, such as a lack of buffers. |
| `icmp_outmsgs`<br/>`DGAUGE`, number | Total number of ICMP messages which this entity attempted to send. This includes all messages counted by `icmp_outerrors`. |
| `icmp_outparmprobs`<br/>`DGAUGE`, number | Number of ICMP Parameter Problem messages sent. |
| `icmp_outsrcquenchs`<br/>`DGAUGE`, number | Number of ICMP Source Quench messages sent. |
| `inactive`<br/>`DGAUGE`, bytes | RAM usage, `inactive` usage type. |
| `inodes_free`<br/>`DGAUGE`, number | Number of free inodes. |
| `inodes_total`<br/>`DGAUGE`, number | Available inodes. |
| `inodes_used`<br/>`DGAUGE`, number | Used inodes. |
| `iops_in_progress`<br/>`DGAUGE`, number | Disk operations in progress. |
| `ip_forwdatagrams`<br/>`DGAUGE`, number | Number of input datagrams for which this entity was not their final IP destination resulting in an attempt to find a route to forward them to that final destination. In entities which do not act as IP Gateways, this counter will include only those packets which were source-routed via this entity and for which the source route parameter was processed successfully. |
| `ip_inaddrerrors`<br/>`DGAUGE`, number | Number of input datagrams discarded because the IP address in their IP header's destination field was not a valid address to be received at this entity. This count includes invalid addresses, such as `0.0.0.0`, and addresses of unsupported classes, e.g., Class E. For entities which are not IP Gateways and therefore do not forward datagrams, this counter includes datagrams discarded because the destination address was not a local one. |
| `ip_indiscards`<br/>`DGAUGE`, number | Number of input IP datagrams for which no problems were encountered to prevent their further processing, but which were discarded, e.g., for lack of buffer space. This counter does not include any datagrams discarded while awaiting reassembly. |
| `ip_reasmreqds`<br/>`DGAUGE`, number | Number of IP fragments received which needed to be reassembled at this entity. |
| `ip_reasmtimeout`<br/>`DGAUGE`, seconds | Maximum time, in seconds, received fragments are held while awaiting reassembly at this entity. |
| `low_free`<br/>`DGAUGE`, bytes | RAM usage, `low_free` usage type. |
| `low_total`<br/>`DGAUGE`, bytes | RAM usage, `low_total` usage type. |
| `mapped`<br/>`DGAUGE`, bytes | RAM usage, `mapped` usage type. |
| `merged_reads`<br/>`DGAUGE`, number | Number of merged disk reads. |
| `merged_writes`<br/>`DGAUGE`, number | Number of merged disk writes. |
| `n_cpus`<br/>`DGAUGE`, number | Limit on CPUs in use. |
| `n_users`<br/>`DGAUGE`, number | Limit on the number of users. |
| `packets_recv`<br/>`DGAUGE`, packets per second | Rate of receiving packets over the network. |
| `packets_sent`<br/>`DGAUGE`, packets per second | Rate of sending packets over the network. |
| `page_tables`<br/>`DGAUGE`, bytes | RAM usage, `page_tables` usage type. |
| `read_bytes`<br/>`DGAUGE`, bytes per second | Read speed for a specific disk. |
| `read_count`<br/>`DGAUGE`, operations per second | Read operations per second for a specific disk. |
| `read_time`<br/>`DGAUGE`, ms | Average disk read time. |
| `shared`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type. |
| `slab`<br/>`DGAUGE`, bytes | RAM usage, `slab` usage type. |
| `sreclaimable`<br/>`DGAUGE`, bytes | RAM usage, `sreclaimable` usage type. |
| `sunreclaim`<br/>`DGAUGE`, bytes | RAM usage, `sunreclaim` usage type. |
| `swap_cached`<br/>`DGAUGE`, bytes | RAM usage, `swap_cached` usage type. |
| `swap_free`<br/>`DGAUGE`, bytes | RAM usage, `swap_free` usage type. |
| `swap_total`<br/>`DGAUGE`, bytes | RAM usage, `swap_total` usage type. |
| `tcp_inerrs`<br/>`DGAUGE`, number | Total number of segments received with an error, e.g., bad TCP checksums. |
| `tcp_outrsts`<br/>`DGAUGE`, number | Number of TCP segments sent containing the RST flag. |
| `tcp_passiveopens`<br/>`DGAUGE`, number | Number of times TCP connections have made a direct transition to the `SYN-RCVD` state from the `LISTEN` state. |
| `tcp_retranssegs`<br/>`DGAUGE`, number | Total number of segments retransmitted, i.e., the number of TCP segments transmitted containing one or more previously transmitted octets. |
| `tcp_rtoalgorithm`<br/>`DGAUGE`, number | Algorithm used to determine the timeout value used for retransmitting unacknowledged octets. |
| `tcp_rtomax`<br/>`DGAUGE`, number | Maximum value permitted by a TCP implementation for the retransmission timeout, measured in milliseconds. |
| `total`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type. |
| `udp_incsumerrors`<br/>`DGAUGE`, number | The value increases when a UDP packet received contains an invalid checksum of the kernel code. |
| `udp_outdatagrams`<br/>`DGAUGE`, number | Total number of outgoing UDP packets sent from this entity. |
| `udplite_noports`<br/>`DGAUGE`, number | Total number of UDP Lite packets received that had no listener on the destination port. Irregularities in the value of this counter may occur when reinitializing the control system and at other times, which is indicated by the `udplite_statsdiscontinuitytime` value. |
| `udplite_sndbuferrors`<br/>`DGAUGE`, number | The value increases when no memory can be allocated to send a UDP Lite packet. |
| `uptime`<br/>`DGAUGE`, % | Uptime percentage. |
| `usage_guest`<br/>`DGAUGE`, % | CPU usage, `guest` usage type. |
| `usage_guest_nice`<br/>`DGAUGE`, % | CPU usage, `guest_nice` usage type. |
| `usage_idle`<br/>`DGAUGE`, % | CPU usage, `idle` usage type. |
| `usage_iowait`<br/>`DGAUGE`, % | CPU usage, `iowait` usage type. |
| `usage_irq`<br/>`DGAUGE`, % | CPU usage, `irq` usage type. |
| `usage_nice`<br/>`DGAUGE`, % | CPU usage, `nice` usage type. |
| `usage_softirq`<br/>`DGAUGE`, % | CPU usage, `softirq` usage type. |
| `usage_steal`<br/>`DGAUGE`, % | CPU usage, `steal` usage type. |
| `usage_system`<br/>`DGAUGE`, % | CPU usage, `system` usage type. |
| `usage_user`<br/>`DGAUGE`, % | CPU usage, `user` usage type. |
| `used`<br/>`DGAUGE`, bytes | RAM usage, `used` usage type. |
| `used_percent`<br/>`DGAUGE`, % | Percentage of RAM usage, `used` usage type. |
| `utilization`<br/>`DGAUGE`, % | Average utilization of VM processor cores (vCPUs) by a database. |
| `vmalloc_chunk`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_chunk` usage type. |
| `vmalloc_total`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_total` usage type. |
| `vmalloc_used`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_used` usage type. |
| `weighted_io_time`<br/>`DGAUGE`, ms | Waiting time for I/O operations. |
| `write_back`<br/>`DGAUGE`, bytes | RAM usage, `write_back` usage type. |
| `write_back_tmp`<br/>`DGAUGE`, bytes | RAM usage, `write_back_tmp` usage type. |
| `write_bytes`<br/>`DGAUGE`, bytes per second | Disk write speed. |
| `write_count`<br/>`DGAUGE`, operations per second | Number of write operations per second. |
| `write_time`<br/>`DGAUGE`, ms | Average disk write time. |

Read more about the service in the [{{ mmg-name }}](../../../managed-mongodb/) documentation.
