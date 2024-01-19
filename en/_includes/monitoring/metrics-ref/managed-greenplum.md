## {{ mgp-full-name }} {#managed-greenplum}

Common labels for all {{ mgp-name }} metrics:

| Label | Value |
----|----
| service | Service ID: `managed-greenplum` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster name |
| cid | Cluster ID |
| host | Host FQDN |
| FQDN | Host FQDN |

### CPU metrics {#managed-greenplum-cpu-metrics}
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

### Disk metrics {#managed-greenplum-disk-metrics}
Additional labels: `device`: Disk ID in the system.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.free`<br/>`DGAUGE`, bytes | Free space. |
| `disk.inodes_free`<br/>`DGAUGE`, pcs | Number of free inodes. |
| `disk.inodes_total`<br/>`DGAUGE`, pcs | Available inodes. |
| `disk.inodes_used`<br/>`DGAUGE`, pcs | Number of inodes used. |
| `disk.total`<br/>`DGAUGE`, bytes | Available space. |
| `disk.used`<br/>`DGAUGE`, bytes | Used space. |
| `disk.used_percent`<br/>`DGAUGE`, % | Percentage of used space. |

### Disk operation metrics {#managed-greenplum-diskio-metrics}
Additional labels: device: `dev`: Disk ID in the system.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `diskio.io_time`<br/>`DGAUGE`, ms | Disk operation duration. |
| `diskio.iops_in_progress`<br/>`DGAUGE`, pcs | Disk operations in progress. |
| `diskio.merged_reads`<br/>`DGAUGE`, pcs | Number of merged disk reads. |
| `diskio.merged_writes`<br/>`DGAUGE`, pcs | Number of merged disk writes. |
| `diskio.read_bytes`<br/>`DGAUGE`, bytes | Bytes read from disk. |
| `diskio.read_time`<br/>`DGAUGE`, ms | Disk read time. |
| `diskio.reads`<br/>`DGAUGE`, pcs | Number of disk reads. |
| `diskio.weighted_io_time`<br/>`DGAUGE`, ms | Waiting time for I/O operations. |
| `diskio.write_bytes`<br/>`DGAUGE`, bytes | Bytes written to disk. |
| `diskio.write_time`<br/>`DGAUGE`, ms | Disk write time. |
| `diskio.writes`<br/>`DGAUGE`, pcs | Number of disk writes. |

### RAM metrics {#managed-greenplum-ram-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.active`<br/>`DGAUGE`, bytes | RAM usage, `active` usage type. |
| `mem.available`<br/>`DGAUGE`, bytes | RAM usage, `available` usage type. |
| `mem.available_percent`<br/>`DGAUGE`, % | Available RAM, %. |
| `mem.buffered`<br/>`DGAUGE`, bytes | RAM usage, `buffered` usage type. |
| `mem.cached`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type. |
| `mem.commit_limit`<br/>`DGAUGE`, bytes | RAM usage, `commit_limit` usage type. |
| `mem.committed_as`<br/>`DGAUGE`, bytes | RAM usage, `committed_as` usage type. |
| `mem.dirty`<br/>`DGAUGE`, bytes | RAM usage, `dirty` usage type. |
| `mem.free`<br/>`DGAUGE`, bytes | RAM usage, `free` usage type. |
| `mem.high_free`<br/>`DGAUGE`, bytes | RAM usage, `high_free` usage type. |
| `mem.high_total`<br/>`DGAUGE`, bytes | RAM usage, `high_total` usage type. |
| `mem.huge_page_size`<br/>`DGAUGE`, bytes | RAM usage, `huge_page_size` usage type. |
| `mem.huge_pages_free`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_free` usage type. |
| `mem.huge_pages_total`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_total` usage type. |
| `mem.inactive`<br/>`DGAUGE`, bytes | RAM usage, `inactive` usage type. |
| `mem.low_free`<br/>`DGAUGE`, bytes | RAM usage, `low_free` usage type. |
| `mem.low_total`<br/>`DGAUGE`, bytes | RAM usage, `low_total` usage type. |
| `mem.mapped`<br/>`DGAUGE`, bytes | RAM usage, `mapped` usage type. |
| `mem.page_tables`<br/>`DGAUGE`, bytes | RAM usage, `page_tables` usage type. |
| `mem.shared`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type. |
| `mem.slab`<br/>`DGAUGE`, bytes | RAM usage, `slab` usage type. |
| `mem.sreclaimable`<br/>`DGAUGE`, bytes | RAM usage, `sreclaimable` usage type. |
| `mem.sunreclaim`<br/>`DGAUGE`, bytes | RAM usage, `sunreclaim` usage type. |
| `mem.swap_cached`<br/>`DGAUGE`, bytes | RAM usage, `swap_cached` usage type. |
| `mem.swap_free`<br/>`DGAUGE`, bytes | RAM usage, `swap_free` usage type. |
| `mem.swap_total`<br/>`DGAUGE`, bytes | RAM usage, `swap_total` usage type. |
| `mem.total`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type. |
| `mem.used`<br/>`DGAUGE`, bytes | RAM usage, `used` usage type. |
| `mem.used_percent`<br/>`DGAUGE`, % | Used RAM, %. |
| `mem.vmalloc_chunk`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_chunk` usage type. |
| `mem.vmalloc_total`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_total` usage type. |
| `mem.vmalloc_used`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_used` usage type. |
| `mem.write_back`<br/>`DGAUGE`, bytes | RAM usage, `write_back` usage type. |
| `mem.write_back_tmp`<br/>`DGAUGE`, bytes | RAM usage, `write_back_tmp` usage type. |

### Network metrics {#managed-greenplum-net-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, bytes per second | Rate of receiving data over the network. |
| `net.bytes_sent`<br/>`DGAUGE`, bytes per second | Rate of sending data over the network. |
| `net.drop_in`<br/>`DGAUGE`, pcs | Packets dropped upon receipt. |
| `net.drop_out`<br/>`DGAUGE`, pcs | Packets dropped when being sent. |
| `net.err_in`<br/>`DGAUGE`, pcs | Number of errors upon receipt. |
| `net.err_out`<br/>`DGAUGE`, pcs | Number of errors at sending. |
| `net.packets_recv`<br/>`DGAUGE`, packets per second | Rate of receiving packets over the network. |
| `net.packets_sent`<br/>`DGAUGE`, packets per second | Rate of sending packets over the network. |

### Service metrics {#managed-greenplum-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `gp.conn_aborted`<br/>`DGAUGE`, pcs | Number of aborted DB connections. |
| `gp.conn_active`<br/>`DGAUGE`, pcs | Number of active DB connections. |
| `gp.conn_count`<br/>`DGAUGE`, pcs | Number of DB connections. |
| `gp.conn_idle`<br/>`DGAUGE`, pcs | Number of idle DB connections. |
| `gp.conn_idle_in_transaction`<br/>`DGAUGE`, pcs | Number of idle DB connections for an incomplete transaction. |
| `gp.conn_waiting`<br/>`DGAUGE`, pcs | Number of pending DB connections. |
| `gp.connect_percent`<br/>`DGAUGE`, % | Percentage of connections. |
| `gp.is_alive`<br/>`DGAUGE` | Host health indicator.<br/>`1` if a DB host is alive, `0` if not. |
| `gp.is_alive_segment`<br/>`DGAUGE` | Segment host health indicator.<br/>`1` if a DB host is alive, `0` if not. |
| `gp.is_dead`<br/>`DGAUGE` | Host health indicator.<br/>`0` if a DB host is alive, `1` if not. |
| `gp.is_master`<br/>`DGAUGE` | Host type indicator.<br/>`1` if it's a DB master host, `0` if not. |
| `gp.master_replication_state`<br/>`DGAUGE` | Master replication status. |
| `gp.percent_xid_wraparound`<br/>`DGAUGE`, % | Transaction ID sequence usage.<br/>Additional labels: `db_name` |
| `gp.ping`<br/>`DGAUGE` | <br/>Additional labels: `can_read`, `is_master`, and `can_write` |
| `gp.pxf_is_alive`<br/>`DGAUGE` | Shows if the PXF extension is available. |
| `gp.rg_cpu_used`<br/>`DGAUGE` | CPU allocation across resource groups.<br/>Additional labels: `resgroup` |
| `gp.rg_mem_available`<br/>`DGAUGE` | Allocation of available RAM across resource groups.<br/>Additional labels: `resgroup` |
| `gp.rg_mem_used`<br/>`DGAUGE` | Allocation of RAM used across resource groups.<br/>Additional labels: `resgroup` |
| `gp.seg_count`<br/>`DGAUGE`, pcs | Number of segments in the cluster. |
| `gp.seg_down`<br/>`DGAUGE` | Segments that are down. |
| `gp.seg_not_synch`<br/>`DGAUGE` | Unsynced segments. |
| `gp.spill_files_num_per_seghost`<br/>`DGAUGE`, pcs | Number of temporary files per host. |
| `gp.spill_files_size_per_seghost`<br/>`DGAUGE`, bytes | Size of temporary files per host. |

Read more about the service in the [{{ mgp-name }}](../../../managed-greenplum/) documentation.
