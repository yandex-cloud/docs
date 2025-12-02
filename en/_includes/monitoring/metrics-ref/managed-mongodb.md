The `name` label contains the metric name.

Labels shared by all {{ mmg-name }} metrics: 

Label | Value
----|----
service | Service ID: `managed-mongodb`
resource_type | Resource type: `cluster`
resource_id | Cluster ID
host | Host FQDN
node | Host type: `primary`, `secondary`, or `unknown`
shard | Shard name
subcluster_name | Subcluster name
dc | [Availability zone](../../../overview/concepts/geo-scope.md)


## CPU metrics {#managed-mongodb-cpu-metrics}

These metrics show CPU core workload.

The consumption type goes into the `systag` label.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `cpu.fraction`<br/>`DGAUGE`, % | Guaranteed vCPU performance | 
| `cpu.guarantee`<br/>`DGAUGE`, count | Guaranteed number of cores | 
| `cpu.guest_nice`<br/>`DGAUGE`, % | CPU core usage, `guest_nice` usage type | 
| `cpu.limit`<br/>`DGAUGE`, count | Maximum number of cores in use | 
| `cpu.guest`<br/>`DGAUGE`, % | CPU core usage, `guest` usage type | 
| `cpu.idle`<br/>`DGAUGE`, % | CPU core usage, `idle` usage type | 
| `cpu.iowait`<br/>`DGAUGE`, % | CPU core usage, `iowait` usage type | 
| `cpu.irq`<br/>`DGAUGE`, % | CPU core usage, `irq` usage type | 
| `cpu.nice`<br/>`DGAUGE`, % | CPU core usage, `nice` usage type | 
| `cpu.softirq`<br/>`DGAUGE`, % | CPU core usage, `softirq` usage type | 
| `cpu.steal`<br/>`DGAUGE`, % | CPU core usage, `steal` usage type | 
| `cpu.system`<br/>`DGAUGE`, % | CPU core usage, `system` usage type | 
| `cpu.user`<br/>`DGAUGE`, % | CPU core usage, `user` usage type |
| `cpu_utilization_by_db_15`<br/>`DGAUGE`, % | Average processor core (vCPU) utilization by database in 15 seconds elapsed time (%). It ranges from 0% to the [vCPU performance level](../../../compute/concepts/performance-levels.md). | 
| `cpu_utilization_by_db_15_limit`<br/>`DGAUGE`, % | Limit processor core (vCPU) utilization by database in 15 seconds elapsed time (%) | 
| `cpu_utilization_by_db_60`<br/>`DGAUGE`, % | Average processor core (vCPU) utilization by database in 60 seconds elapsed time (%) | 
| `cpu_utilization_by_db_60_limit`<br/>`DGAUGE`, % | Limit processor core (vCPU) utilization by database in 60 seconds elapsed time (%) |


## Disk metrics {#managed-mongodb-disk-metrics}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, bytes | Free space | 
| `disk.free_inodes`<br/>`DGAUGE`, count | Free inodes | 
| `disk.total_bytes`<br/>`DGAUGE`, bytes | Available space | 
| `disk.total_inodes`<br/>`DGAUGE`, count | Available inodes | 
| `disk.used_bytes`<br/>`DGAUGE`, bytes | Used space | 
| `disk.used_inodes`<br/>`DGAUGE`, count | Used inodes |
| `load.avg_15min`<br/>`DGAUGE`, % | Average load over 15 minutes | 
| `load.avg_1min`<br/>`DGAUGE`, % | Average load over one minute | 
| `load.avg_5min`<br/>`DGAUGE`, % | Average load over five minutes |
| `vd*`<br/>`DGAUGE`, bytes | Virtual disk size |
| `vd**`<br/>`DGAUGE`, bytes | Virtual disk partition size |


## Disk operation metrics {#managed-mongodb-diskio-metrics}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `io.avg.iops_in_progress`<br/>`DGAUGE`, count | Number of disk I/O operations currently in progress |
| `io.avg.read_bytes`<br/>`DGAUGE`, bytes per second | Disk read speed |
| `io.avg.read_count`<br/>`DGAUGE`, operations per second | Number of read operations per second |
| `io.avg.read_merged_count`<br/>`DGAUGE`, operations per second | Number of merged read operations per second |
| `io.avg.read_time`<br/>`DGAUGE`, milliseconds | Total time spent reading from disk |
| `io.avg.weighted_io_time`<br/>`DGAUGE`, milliseconds | Total (weighted) time spent on I/O operations |
| `io.avg.write_bytes`<br/>`DGAUGE`, bytes per second | Disk write speed |
| `io.avg.write_count`<br/>`DGAUGE`, operations per second | Number of writes per second |
| `io.avg.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second |
| `io.avg.write_time`<br/>`DGAUGE`, milliseconds | Total time spent writing to disk |
| `io.disk*.iops_in_progress`<br/>`DGAUGE`, count | Number of disk I/O operations in progress | 
| `io.disk*.read_bytes`<br/>`DGAUGE`, bytes per second | Read speed for a given disk | 
| `io.disk*.read_count`<br/>`DGAUGE`, operations per second | Number of reads per second for a given disk | 
| `io.disk*.read_merged_count`<br/>`DGAUGE`, operations per second | Number of merged read operations per second for a given disk |
| `io.disk*.read_time`<br/>`DGAUGE`, milliseconds | Average read time for a given disk |
| `io.disk*.utilization`<br/>`DGAUGE`, % | Utilization of a given disk; disabled for network drives. | 
| `io.disk*.weighted_io_time`<br/>`DGAUGE`, milliseconds | I/O wait time for a given disk | 
| `io.disk*.write_bytes`<br/>`DGAUGE`, bytes per second | Write speed for a given disk | 
| `io.disk*.write_count`<br/>`DGAUGE`, operations per second | Number of writes per second for a given disk | 
| `io.disk*.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second for a given disk |
| `io.disk*.write_time`<br/>`DGAUGE`, milliseconds | Average write time for a given disk | 
| `io_quota_utilization_percentage`<br/>`DGAUGE`, % | Average percentage of disk I/O quota usage |
| `io_quota_utilization_percentage_burst`<br/>`DGAUGE`, % | Maximum percentage of disk I/O quota usage (burst) |
| `monitoring_disk.read_bytes`<br/>`DGAUGE`, bytes per second | Average number of bytes read from disk per second |
| `monitoring_disk.read_bytes_burst`<br/>`DGAUGE`, bytes per second | Maximum number of bytes read from disk per second |
| `monitoring_disk.write_bytes`<br/>`DGAUGE`, bytes per second | Average number of bytes written to disk per second |
| `monitoring_disk.write_bytes_burst`<br/>`DGAUGE`, bytes per second | Maximum number of bytes written to disk per second |


## RAM metrics {#managed-mongodb-ram-metrics}

The consumption type goes into the `systag` label.

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
| `mem.guarantee_bytes`<br/>`DGAUGE`, bytes | Guaranteed memory allocation |
| `mem.high_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, `high_free` usage type | 
| `mem.high_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `high_total` usage type | 
| `mem.huge_page_size_bytes`<br/>`DGAUGE`, bytes | RAM usage, `huge_page_size` usage type | 
| `mem.huge_pages_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_free` usage type | 
| `mem.huge_pages_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_total` usage type | 
| `mem.inactive_bytes`<br/>`DGAUGE`, bytes | RAM usage, `inactive` usage type | 
| `mem.limit_bytes`<br/>`DGAUGE`, bytes | Memory limit | 
| `mem.low_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, `low_free` usage type | 
| `mem.low_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `low_total` usage type | 
| `mem.mapped_bytes`<br/>`DGAUGE`, bytes | RAM usage, `mapped` usage type | 
| `mem.page_tables_bytes`<br/>`DGAUGE`, bytes | RAM usage, `page_tables` usage type | 
| `mem.slab_bytes`<br/>`DGAUGE`, bytes | RAM usage, `slab` usage type | 
| `mem.sreclaimable_bytes`<br/>`DGAUGE`, bytes | RAM usage, `sreclaimable` usage type | 
| `mem.sunreclaim_bytes`<br/>`DGAUGE`, bytes | RAM usage, `sunreclaim` usage type | 
| `mem.swap_cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, `swap_cached` usage type | 
| `mem.swap_free_bytes`<br/>`DGAUGE`, bytes | RAM usage, `swap_free` usage type | 
| `mem.swap_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `swap_total` usage type | 
| `mem.shared_bytes`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type | 
| `mem.total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type | 
| `mem.used_bytes`<br/>`DGAUGE`, bytes | Amount of RAM currently used by running processes | 
| `mem.used_percent_bytes`<br/>`DGAUGE`, % | Percentage of used RAM | 
| `mem.vmalloc_chunk_bytes`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_chunk` usage type | 
| `mem.vmalloc_total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_total` usage type | 
| `mem.vmalloc_used_bytes`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_used` usage type | 
| `mem.write_back_bytes`<br/>`DGAUGE`, bytes | RAM usage, `write_back` usage type | 
| `mem.write_back_tmp_bytes`<br/>`DGAUGE`, bytes | RAM usage, `write_back_tmp` usage type |


## Network metrics {#managed-mongodb-net-metrics}

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


## `dbStats` metrics {#managed-mongodb-dbstats-metrics}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `db_stats_*_dataSize`<br/>`DGAUGE`, bytes | Size of uncompressed data in a given database. `admin`: Service database. | 
| `db_stats_*_indexSize`<br/>`DGAUGE`, bytes | Space used by indexes from a given database. `admin`: Service database. | 
| `db_stats_admin_dataSize`<br/>`DGAUGE`, bytes | Total size of data in the database excluding indexes |
| `db_stats_admin_indexSize`<br/>`DGAUGE`, bytes | Total index size in the database |
| `db_stats_config_dataSize`<br/>`DGAUGE`, bytes | Size of uncompressed data in a configuration DB |
| `db_stats_config_indexSize`<br/>`DGAUGE`, bytes | Space used by configuration DB indexes |
| `db_stats_local_dataSize`<br/>`DGAUGE`, bytes | Size of uncompressed data in a local DB |
| `db_stats_local_indexSize`<br/>`DGAUGE`, bytes | Space used by local DB indexes |
| `db_stats_mdb_internal_dataSize`<br/>`DGAUGE`, bytes | Size of uncompressed data of in an internal DB |
| `db_stats_mdb_internal_indexSize`<br/>`DGAUGE`, bytes | Space used by internal DB indexes |


## Service metrics {#managed-mongodb-metrics}

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
| `count`<br/>`DGAUGE`, objects | Number of objects per collection |
| `dirty`<br/>`DGAUGE`, bytes | RAM usage, `dirty` usage type | 
| `drop_in`<br/>`DGAUGE`, count | Dropped receive packets | 
| `drop_out`<br/>`DGAUGE`, count | Dropped transmit packets | 
| `err_in`<br/>`DGAUGE`, count | Receive error count | 
| `err_out`<br/>`DGAUGE`, count | Transmit error count | 
| `free`<br/>`DGAUGE`, bytes | RAM usage, `free` usage type | 
| `high_free`<br/>`DGAUGE`, bytes | RAM usage, `high_free` usage type | 
| `high_total`<br/>`DGAUGE`, bytes | RAM usage, `high_total` usage type | 
| `hosts.ha`<br/>`DGAUGE`, hosts | Number of hosts per high-availability cluster |
| `hosts.subcluster.mongocfg.total`<br/>`DGAUGE`, count | Number of _mongocfg_ instances per subcluster |
| `hosts.subcluster.mongod.total`<br/>`DGAUGE`, count | Number of _mongod_ instances per subcluster |
| `hosts.subcluster.mongoinfra.total`<br/>`DGAUGE`, count | Number of _mongoinfra_ instances per subcluster |
| `hosts.subcluster.mongos.total`<br/>`DGAUGE`, count | Number of _mongos_ instances per subcluster |
| `hosts.total`<br/>`DGAUGE`, hosts | Total hosts used by the service |
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
| `icmp_insrcquenchs`<br/>`DGAUGE`, count | Number of ICMP parameter problem messages received | 
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
| `icmp_outratelimitglobal`<br/>`DGAUGE`, count | Number of ICMP messages throttled by global rate limits |
| `icmp_outratelimithost`<br/>`DGAUGE`, count | Number of ICMP messages throttled by host-specific rate limits |
| `icmp_outredirects`<br/>`DGAUGE`, count | Number of ICMP redirect messages sent  | 
| `icmp_outsrcquenchs`<br/>`DGAUGE`, count | Number of ICMP source quench messages sent |
| `icmp_outtimeexcds`<br/>`DGAUGE`, count | Number of ICMP time exceeded messages sent | 
| `icmp_outtimestampreps`<br/>`DGAUGE`, count | Number of ICMP timestamp reply messages sent | 
| `icmp_outtimestamps`<br/>`DGAUGE`, count | Number of ICMP timestamp (request) messages sent  | 
| `icmpmsg_intype3`<br/>`DGAUGE`, count | Number of ICMP type 3 (destination unreachable) messages received |
| `icmpmsg_outtype3`<br/>`DGAUGE`, count | Number of ICMP type 3 (destination unreachable) messages sent |
| `inactive`<br/>`DGAUGE`, bytes | RAM usage, `inactive` usage type | 
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
| `latency_commands`<br/>`DGAUGE`, milliseconds | Average execution time of database commands |
| `latency_commands_count`<br/>`DGAUGE`, count | Number of executed database commands |
| `latency_reads`<br/>`DGAUGE`, milliseconds | Average time per read operation |
| `latency_reads_count`<br/>`DGAUGE`, count | Number of read operations |
| `latency_transactions`<br/>`DGAUGE`, milliseconds | Average transaction execution time |
| `latency_transactions_count`<br/>`DGAUGE`, count | Number of completed transactions |
| `latency_writes`<br/>`DGAUGE`, milliseconds | Average time per write operation |
| `latency_writes_count`<br/>`DGAUGE`, count | Number of write operations |
| `low_free`<br/>`DGAUGE`, bytes | RAM usage, `low_free` usage type | 
| `low_total`<br/>`DGAUGE`, bytes | RAM usage, `low_total` usage type | 
| `mapped`<br/>`DGAUGE`, bytes | RAM usage, `mapped` usage type | 
| `memory_utilization_by_db_percent`<br/>`DGAUGE`, % | Memory utilization by a database | 
| `memory_utilization_by_db_rss`<br/>`DGAUGE`, bytes | Total memory used by database processes | 
| `memory_utilization_memory_limit`<br/>`DGAUGE`, % | RAM (utilization) limit per database | 
| `mongocfg-is_alive`<br/>DGAUGE | Health indicator for configuration server host.<br/>`1` if the server is operational, `0` if not. |
| `mongod-is_alive`<br/>`DGAUGE` | Host health indicator.<br/>`1` if the DB host is operational, `0` if not. | 
| `mongos_active_migrations_count`<br/>`DGAUGE`, operations | Current number of active chunk migration operations via _mongos_ |
| `mongos_in_balancer_round`<br/>`DGAUGE` | Indicates whether _mongos_ is involved in current balancing round.<br/>`1` if it is, `0` if not. |
| `mongos_migrations_failed`<br/>`DGAUGE`, operations | Total number of unsuccessful (terminated with an error) chunk migrations through _mongos_ during the interval |
| `mongos_migrations_successful`<br/>`DGAUGE`, operations | Total number of successful chunk migrations through _mongos_ during the interval |
| `mongos-is_alive`<br/>`DGAUGE` | _mongos_ health indicator.<br/>`1` if _mongos_ is operational, `0` if not. |
| `n_cpus`<br/>`DGAUGE`, count | Maximum number of cores in use | 
| `n_unique_users`<br/>`DGAUGE`, count | Number of unique users or accounts engaging with the system |
| `n_users`<br/>`DGAUGE`, count | Limit on the number of users | 
| `oom_count`<br/>`DGAUGE`, count | Number of out-of-memory events |
| `packets_recv`<br/>`DGAUGE`, packets per second | Network packet receive rate | 
| `packets_sent`<br/>`DGAUGE`, packets per second | Network packet transmit rate | 
| `page_tables`<br/>`DGAUGE`, bytes | RAM usage, `page_tables` usage type | 
| `read_bytes`<br/>`DGAUGE`, bytes per second | Read speed for a given disk | 
| `read_bytes_burst`<br/>`DGAUGE`, bytes per second | Maximum number of bytes read from disk
| `read_count`<br/>`DGAUGE`, operations per second | Number of reads per second for a given disk | 
| `read_latency`<br/>`DGAUGE`, milliseconds | Average time per disk read operation.<br/>`bin` label: Histogram buckets. |
| `read_merged_count`<br/>`DGAUGE`, operations per second | Number of merged read operations per second |
| `read_ops`<br/>`DGAUGE`, operations per second | Number of disk read operations per second |
| `read_ops_burst`<br/>`DGAUGE`, operations per second | Maximum number of disk read operations per second |
| `read_throttler_delay`<br/>`DGAUGE`, milliseconds | Average read delay due to disk throughput limit.<br/>`bin` label: Histogram buckets. |
| `read_time`<br/>`DGAUGE`, milliseconds | Average disk read time | 
| `shared`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type | 
| `slab`<br/>`DGAUGE`, bytes | RAM usage, `slab` usage type | 
| `speed`<br/>`DGAUGE`, bits per second | Maximum network data transfer rate for this interface |
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
| `udp_memerrors`<br/>`DGAUGE`, errors | Number of UDP out-of-memory errors |
| `udp_noports`<br/>`DGAUGE`, count | Total UDP packets received with no application on the destination port  | 
| `udp_outdatagrams`<br/>`DGAUGE`, count | Total UDP packets sent from the object in question | 
| `udp_rcvbuferrors`<br/>`DGAUGE`, count | Number of UDP receive buffer errors  | 
| `udp_sndbuferrors`<br/>`DGAUGE`, count | Number of UDP send buffer errors  | 
| `udplite_ignoredmulti`<br/>`DGAUGE`, count | Number of UDP-Lite multicast packets ignored  | 
| `udplite_incsumerrors`<br/>`DGAUGE`, count | This value increases when a received UDP-Lite packet contains an invalid kernel code checksum.  | 
| `udplite_indatagrams`<br/>`DGAUGE`, count | Total UDP-Lite packets received  | 
| `udplite_inerrors`<br/>`DGAUGE`, count | Total UDP-Lite packet receive errors  | 
| `udplite_memerrors`<br/>`DGAUGE`, errors | Number of UDP-Lite out-of-memory errors |
| `udplite_noports`<br/>`DGAUGE`, count | Total UDP-Lite packets received without a listener on the destination port. Irregularities in this counter may occur when reinitializing the management system and at other times, as indicated by the `udplite_statsdiscontinuitytime` value. | 
| `udplite_outdatagrams`<br/>`DGAUGE`, count | Total UDP-Lite packets sent  | 
| `udplite_rcvbuferrors`<br/>`DGAUGE`, count | Number of UDP-Lite receive buffer errors  | 
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
| `vmalloc_chunk`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_chunk` usage type | 
| `vmalloc_total`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_total` usage type | 
| `vmalloc_used`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_used` usage type | 
| `weighted_io_time`<br/>`DGAUGE`, milliseconds | I/O wait time | 
| `write_back`<br/>`DGAUGE`, bytes | RAM usage, `write_back` usage type | 
| `write_back_tmp`<br/>`DGAUGE`, bytes | RAM usage, `write_back_tmp` usage type |
| `write_bytes`<br/>`DGAUGE`, bytes per second | Disk write speed | 
| `write_bytes_burst`<br/>`DGAUGE`, bytes per second | Maximum number of bytes written to disk | 
| `write_count`<br/>`DGAUGE`, operations per second | Number of writes per second | 
| `write_latency`<br/>`HIST_RATE`, milliseconds | Distribution histogram for disk write request latency.<br/>`bin` label: Histogram buckets. | 
| `write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second for a given disk | 
| `write_ops`<br/>`DGAUGE`, operations per second | Average number of disk write operations | 
| `write_ops_burst`<br/>`DGAUGE`, operations per second | Maximum number of disk write operations | 
| `write_throttler_delay`<br/>`HIST_RATE`, milliseconds | Histogram of write latency due to exceeded disk quota.<br/>`bin` label: Histogram buckets. | 
| `write_time`<br/>`DGAUGE`, milliseconds | Average disk write time | 


#### `serverStatus` metrics {#managed-mongodb-serverstatus-metrics}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `server_status_admin_asserts.msg_rate`<br/>`DGAUGE`, count | Message assert trigger increment, per second | 
| `server_status_admin_asserts.regular_rate`<br/>`DGAUGE`, count | Regular assert trigger increment, per second | 
| `server_status_admin_asserts.user_rate`<br/>`DGAUGE`, count | Custom assert trigger increment, per second | 
| `server_status_admin_connections.available`<br/>`DGAUGE`, count | Number of available connections | 
| `server_status_admin_connections.current`<br/>`DGAUGE`, count | Number of incoming DB connections | 
| `server_status_admin_extra_info.page_faults_rate`<br/>`DGAUGE`, count | Number of [page faults](https://en.wikipedia.org/wiki/Page_fault) | 
| `server_status_admin_globalLock.currentQueue.readers`<br/>`DGAUGE`, count | Number of operations in the current queue waiting for read lock release | 
| `server_status_admin_globalLock.currentQueue.writers`<br/>`DGAUGE`, count | Number of operations in the current queue waiting for write lock release | 
| `server_status_admin_metrics.cursor.open.noTimeout`<br/>`DGAUGE`, count | Number of open cursors with `DBQuery.Option.noTimeout` to prevent inactivity timeout | 
| `server_status_admin_metrics.cursor.open.pinned`<br/>`DGAUGE`, count | Number of pinned open cursors | 
| `server_status_admin_metrics.cursor.open.total`<br/>`DGAUGE`, count | Number of open cursors | 
| `server_status_admin_metrics.document.deleted_rate`<br/>`DGAUGE`, count | Increment of deleted documents, per second | 
| `server_status_admin_metrics.document.inserted_rate`<br/>`DGAUGE`, count | Increment of inserted documents, per second | 
| `server_status_admin_metrics.document.returned_rate`<br/>`DGAUGE`, count | Increment of returned documents, per second | 
| `server_status_admin_metrics.document.updated_rate`<br/>`DGAUGE`, count | Increment of updated documents, per second | 
| `server_status_admin_metrics.getLastError.wtime.totalMillis_rate`<br/>`DGAUGE`, milliseconds | Increment of milliseconds spent by a database waiting for write acknowledgement, per second | 
| `server_status_admin_metrics.operation.scanAndOrder_rate`<br/>`DGAUGE`, count | Increment of non-index data sorts, per second | 
| `server_status_admin_metrics.operation.writeConflicts_rate`<br/>`DGAUGE`, count | Increment of write conflicts, per second | 
| `server_status_admin_metrics.queryExecutor.scanned_rate`<br/>`DGAUGE`, count | Increment of scanned index keys, per second | 
| `server_status_admin_metrics.queryExecutor.scannedObjects_rate`<br/>`DGAUGE`, count | Increment of scanned documents, per second | 
| `server_status_admin_metrics.ttl.deletedDocuments_rate`<br/>`DGAUGE`, count | Increment of documents deleted using the TTL index, per second. |
| `server_status_admin_metrics.ttl.passes_rate`<br/>`DGAUGE`, count | Increment of background documents deleted from collections using the TTL index, per second | 
| `server_status_admin_opLatencies.commands.latency_rate`<br/>`DGAUGE`, microseconds | Rate of DB command execution latency change, per second | 
| `server_status_admin_opLatencies.commands.ops_rate`<br/>`DGAUGE`, count | Increment of DB collection operations, per second | 
| `server_status_admin_opLatencies.reads.latency_rate`<br/>`DGAUGE`, microseconds | Change in read command execution latency, per second | 
| `server_status_admin_opLatencies.reads.ops_rate`<br/>`DGAUGE`, count | Increment of DB collection reads, per second | 
| `server_status_admin_opLatencies.transactions.latency_rate`<br/>`DGAUGE`, microseconds |Change in transaction latency, per second  | 
| `server_status_admin_opLatencies.transactions.ops_rate`<br/>`DGAUGE`, count | Increment of database transactions, per second | 
| `server_status_admin_opLatencies.writes.latency_rate`<br/>`DGAUGE`, microseconds | Change in write command execution latency, per second | 
| `server_status_admin_opLatencies.writes.ops_rate`<br/>`DGAUGE`, count | Increment of DB collection writes, per second | 
| `server_status_admin_repl.secondary`<br/>`DGAUGE`, count | Number of secondary nodes in the replica set | 
| `server_status_admin_opcounters.command_rate`<br/>`DGAUGE`, count | Increment of DB commands, per second, other than `insert`, `update`, and `delete` | 
| `server_status_admin_opcounters.delete_rate`<br/>`DGAUGE`, count | Increment of `delete` operations in the DB, per second | 
| `server_status_admin_opcounters.getmore_rate`<br/>`DGAUGE`, count | Increment of `getmore` operations in the DB, per second | 
| `server_status_admin_opcounters.insert_rate`<br/>`DGAUGE`, count | Increment of `insert` operations in the DB, per second | 
| `server_status_admin_opcounters.query_rate`<br/>`DGAUGE`, count | Increment of `query` operations in the DB, per second | 
| `server_status_admin_opcounters.update_rate`<br/>`DGAUGE`, count | Increment of `update` operations in the DB, per second | 
| `server_status_admin_opcountersRepl.command_rate`<br/>`DGAUGE`, count | Increment of replicated DB commands, per second | 
| `server_status_admin_opcountersRepl.delete_rate`<br/>`DGAUGE`, count | Increment of replicated `delete` operations in the DB, per second | 
| `server_status_admin_opcountersRepl.getmore_rate`<br/>`DGAUGE`, count | Increment of replicated `getmore` operations in the DB, per second | 
| `server_status_admin_opcountersRepl.insert_rate`<br/>`DGAUGE`, count | Increment of replicated `insert` operations in the DB, per second | 
| `server_status_admin_opcountersRepl.query_rate`<br/>`DGAUGE`, count | Increment of replicated `query` operations in the DB, per second | 
| `server_status_admin_opcountersRepl.update_rate`<br/>`DGAUGE`, count | Increment of replicated `update` operations in the DB, per second | 
| `server_status_admin_wiredTiger.cache.bytes_currently_in_the_cache`<br/>`DGAUGE`, bytes | Size of the `WiredTiger` cache used | 
| `server_status_admin_wiredTiger.cache.maximum_bytes_configured`<br/>`DGAUGE`, bytes | Maximum configured cache size | 
| `server_status_admin_wiredTiger.cache.modified_pages_evicted_rate`<br/>`DGAUGE`, count | Increment of modified RAM pages evicted, per second | 
| `server_status_admin_wiredTiger.cache.tracked_dirty_bytes_in_the_cache`<br/>`DGAUGE`, bytes | Dirty cache size | 
| `server_status_admin_wiredTiger.cache.unmodified_pages_evicted_rate`<br/>`DGAUGE`, count | Increment of unmodified RAM pages evicted, per second | 
| `server_status_admin_wiredTiger.concurrentTransactions.read.out`<br/>`DGAUGE`, count | Number of tickets used for concurrent read transactions | 
| `server_status_admin_wiredTiger.concurrentTransactions.read.totalTickets`<br/>`DGAUGE`, count | Number of tickets available for concurrent read transactions | 
| `server_status_admin_wiredTiger.concurrentTransactions.write.out`<br/>`DGAUGE`, count | Number of tickets used for concurrent write transactions | 
| `server_status_admin_wiredTiger.concurrentTransactions.write.totalTickets`<br/>`DGAUGE`, count | Number of tickets available for concurrent write transactions | 
| `server_status_admin_wiredTiger.transaction.transaction_begins`<br/>`DGAUGE`, count | Number of running transactions | 
| `server_status_admin_wiredTiger.transaction.transaction_begins_rate`<br/>`DGAUGE`, units per second | Transaction start speed |
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_max_time_msecs`<br/>`DGAUGE`, milliseconds | Maximum checkpoint creation time | 
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_min_time_msecs`<br/>`DGAUGE`, milliseconds | Minimum checkpoint creation time |  
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_most_recent_time_msecs`<br/>`DGAUGE`, milliseconds | Most recent checkpoint creation time | 
| `server_status_admin_wiredTiger.transaction.transactions_committed_rate`<br/>`DGAUGE`, count | Committed transaction increment, per second | 
| `server_status_admin_wiredTiger.transaction.transactions_rolled_back_rate`<br/>`DGAUGE`, count | Rolled back transaction increment, per second | 
| `top_readLock_time_rate`<br/>`DGAUGE`, milliseconds/s | Total read lock retention time per second.<br/>`ns` label: Namespace. |
| `top_writeLock_time_rate`<br/>`DGAUGE`, milliseconds/s | Total write lock retention time per second.<br/>`ns` label: Namespace. |


## Other metrics {#managed-mongodb-other-metrics}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Host read access indicator.<br/>`1` if the host service is available for reads, `0` if not. |
| `can_write`<br/>`DGAUGE`, 0/1 | Host write access status.<br/>This metric is set to `1` if the host service is available for write operations, and to `0` otherwise. |
| `latest_backup_sec`<br/>`DGAUGE`, seconds | Time since the most recent successful backup |
| `oplog-diff`<br/>`DGAUGE`, milliseconds | Operation log size | 
| `oplog-maxSize`<br/>`DGAUGE`, bytes | Maximum size of the operation log | 
| `replset_status-replicationLag`<br/>`DGAUGE`, seconds | Replication lag |