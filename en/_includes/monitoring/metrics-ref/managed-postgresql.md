The `name` label contains the metric name.

Labels shared by all {{ mpg-name }} metrics:

Label | Value
----|----
dc | [Availability zone](../../../overview/concepts/geo-scope.md)
host | Host FQDN
node | Host type: `primary`, `replica`, or `Unknown`
resource_id | Cluster ID
resource_type | Resource type: `cluster`
service | Service ID: `managed-postgresql`
shard | Shard ID
subcluster_name | Subcluster name

## CPU metrics {#managed-postgresql-cpu-metrics}

These metrics show CPU core workload.

The consumption type goes into the `systag` label.

| Name<br/>Type, units | Description |
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
| `load.avg_1min`<br/>`DGAUGE`, % | Average load over one minute |
| `load.avg_5min`<br/>`DGAUGE`, % | Average load over five minutes |
| `n_cpus`<br/>`DGAUGE`, count | Maximum number of cores in use |
| `pg_backend_cpu`<br/>`DGAUGE`, % | {{ PG }} process CPU utilization.<br/>Special labels:<ul><li>`backend_type`: Backend type</li><li>`database`: Database name</li><li>`user`: Username</li></ul> |


## Disk metrics {#managed-postgresql-disk-metrics}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, bytes | Free space |
| `disk.free_inodes`<br/>`DGAUGE`, count | Free inodes |
| `disk.temp_files_size`<br/>`DGAUGE`, bytes | Size of temporary files |
| `disk.total_bytes`<br/>`DGAUGE`, bytes | Available space |
| `disk.total_inodes`<br/>`DGAUGE`, count | Available inodes |
| `disk.used_bytes`<br/>`DGAUGE`, bytes | Used space |
| `disk.used_inodes`<br/>`DGAUGE`, count | Used inodes |
| `disk.wal_size`<br/>`DGAUGE`, bytes | Write-ahead log (WAL) size |
| `pg_backend_read_bytes`<br>`DGAUGE`, bytes per second | {{ PG }} process data read rate.<br/>Special labels:<ul><li>`backend_type`: Backend type</li><li>`database`: Database name</li><li>`user`: Username</li></ul> |
| `pg_backend_write_bytes`<br>`DGAUGE`, bytes per second | {{ PG }} process data write rate.<br/>Special labels:<ul><li>`backend_type`: Backend type</li><li>`database`: Database name</li><li>`user`: Username</li></ul> |


## Disk operation metrics {#managed-postgresql-diskio-metrics}

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
| `io.utilization`<br/>`DGAUGE`, % | Disk utilization disabled for network drives |
| `io.write_bytes`<br/>`DGAUGE`, bytes per second | Disk write speed |
| `io.write_count`<br/>`DGAUGE`, operations per second | Number of writes per second |
| `io.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second |
| `monitoring_disk.io_quota_utilization_percentage_burst`<br/>`DGAUGE`, % | Maximum percentage of disk I/O quota usage (burst) |
| `monitoring_disk.io_quota_utilization_percentage`<br/>`DGAUGE`, % | Average percentage of disk I/O quota usage |
| `monitoring_disk.read_bytes_burst`<br/>`DGAUGE`, bytes per second | Maximum number of bytes read from disk per second |
| `monitoring_disk.read_bytes`<br/>`DGAUGE`, bytes per second | Average number of bytes read from disk per second |
| `monitoring_disk.read_latency`<br/>`DGAUGE`, milliseconds | Distribution histogram for disk read request latency |
| `monitoring_disk.read_ops_burst`<br/>`DGAUGE`, operations per second | Maximum number of disk reads |
| `monitoring_disk.read_ops`<br/>`DGAUGE`, operations per second | Average number of disk reads |
| `monitoring_disk.read_throttler_delay`<br/>`DGAUGE`, milliseconds | Histogram of read latency due to exceeded disk quota |
| `monitoring_disk.write_bytes_burst`<br/>`DGAUGE`, bytes per second | Maximum number of bytes written to disk per second |
| `monitoring_disk.write_bytes`<br/>`DGAUGE`, bytes per second | Average number of bytes written to disk per second |
| `monitoring_disk.write_latency`<br/>`DGAUGE`, milliseconds | Distribution histogram for disk write request latency |
| `monitoring_disk.write_ops_burst`<br/>`DGAUGE`, operations per second | Maximum number of disk write operations |
| `monitoring_disk.write_ops`<br/>`DGAUGE`, operations per second | Average number of disk write operations |
| `monitoring_disk.write_throttler_delay`<br/>`DGAUGE`, milliseconds | Histogram of write latency due to exceeded disk quota |


## RAM metrics {#managed-postgresql-ram-metrics}

The consumption type goes into the `systag` label.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.active_bytes`<br/>`DGAUGE`, bytes | Active resident memory (frequently accessed and released when absolutely necessary) |
| `mem.available_bytes`<br/>`DGAUGE`, bytes | RAM usage, `available` usage type |
| `mem.buffers_bytes`<br/>`DGAUGE`, bytes | RAM usage, `buffers` usage type |
| `mem.cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type |
| `mem.free_bytes`<br/>`DGAUGE`, bytes | Amount of free RAM available, excluding `mem.buffers_bytes` and `mem.cached_bytes` |
| `mem.shared_bytes`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type |
| `mem.total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type |
| `mem.used_bytes`<br/>`DGAUGE`, bytes | Amount of RAM currently used by running processes |
| `oom_count`<br/>`DGAUGE`, count | Number of out-of-memory events |


## Network metrics {#managed-postgresql-net-metrics}

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


## Service metrics {#managed-postgresql-metrics}

#### Cluster metrics {#managed-postgresql-cluster-metrics}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `backups_done.count`<br/>`DGAUGE`, count | Number of successful backups.<br/>The `type` special label is the backup type. The possible values are:<ul><li>`AUTOMATED`: Automatic</li><li>`MANUAL`: Manual</li></ul> |
| `can_read`<br/>`DGAUGE`, 0/1 | Host read access indicator.<br/>`1` if the host service is available for reads, `0` if not. |
| `can_write`<br/>`DGAUGE`, 0/1 | Host write access idicator.<br/>`1` if the host service is available for writes, `0` if not. |
| `core_dump.count`<br/>`DGAUGE`, count | Number of core dumps.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `dbaas_conf.cpu.fraction`<br/>`DGAUGE`, fractions | Fraction of available CPU resources allocated by the service.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `dbaas_conf.cpu.guarantee`<br/>`DGAUGE`, fractions | Guaranteed fraction of CPU resources allocated by the service.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `dbaas_conf.cpu.limit`<br/>`DGAUGE`, fractions | Maximum allowed fraction of CPU resource usage.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `dbaas_conf.hosts.ha`<br/>`DGAUGE`, hosts | Number of hosts set up for high availability.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `dbaas_conf.hosts.subcluster.<subcluster_name>.total`<br/>`DGAUGE`, count | Number of hosts in the subcluster.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `dbaas_conf.hosts.total`<br/>`DGAUGE`, count | Total hosts used by the service.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `last_automated_backup.timestamp_in_seconds`<br/>`DGAUGE`, seconds | Unix timestamp of the most recent automatic backup |
| `n_unique_users`<br/>`DGAUGE`, count | Number of unique users or accounts engaging with the system |
| `n_users`<br/>`DGAUGE`, count | Limit on the number of users |
| `od_cores.count`<br/>`DGAUGE`, count | Number of on-demand cores.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `pg_log_counter.error_duplicate_table`<br/>`DGAUGE`, count | Number of {{ PG }} errors caused by attempts to create an existing table |
| `pg_log_counter.error_query_canceled`<br/>`DGAUGE`, count | Number of canceled {{ PG }} queries |
| `pg_log_counter.fatal_connection_failure`<br/>`DGAUGE`, count | Number of fatal {{ PG }} connection errors |
| `pg_log_counter.fatal_invalid_password`<br/>`DGAUGE`, count | Number of fatal {{ PG }} connection errors due to an invalid password |
| `postgres.corruption_found`<br/>`DGAUGE`, 0/1 | Indicator of data corruption in the {{ PG }} cluster<br/> `1` if corruption is detected, `0` if not.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_Clog_blks_hit`<br/>`DGAUGE`, count | Number of Clog page SLRU cache hits (transaction commit log) |
| `postgres.slru_Clog_blks_read`<br/>`DGAUGE`, count | Number of Clog SLRU page reads from the disk |
| `postgres.slru_Clog_blks_written`<br/>`DGAUGE`, count | Number of Clog SLRU page writes to the disk |
| `postgres.slru_CommitTs_blks_hit`<br/>`DGAUGE`, count | Number of CommitTs page SLRU cache hits (transaction commit history).<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_CommitTs_blks_read`<br/>`DGAUGE`, count | Number of CommitTs SLRU page reads from the disk.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_CommitTs_blks_written`<br/>`DGAUGE`, count | Number of CommitTs SLRU page writes to the disk.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_MultiXactMember_blks_hit`<br/>`DGAUGE`, count | Number of MultiXactMember page SLRU cache hits.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_MultiXactMember_blks_read`<br/>`DGAUGE`, count | Number of MultiXactMember SLRU page reads from the disk.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_MultiXactMember_blks_written`<br/>`DGAUGE`, count | Number of MultiXactMember SLRU page writes to the disk.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_MultiXactOffset_blks_hit`<br/>`DGAUGE`, count | Number of MultiXactOffset page SLRU cache hits.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_MultiXactOffset_blks_read`<br/>`DGAUGE`, count | Number of MultiXactOffset SLRU page reads from the disk |
| `postgres.slru_MultiXactOffset_blks_written`<br/>`DGAUGE`, count | Number of MultiXactOffset SLRU page writes to the disk |
| `postgres.slru_Notify_blks_hit`<br/>`DGAUGE`, count | Number of notification queue page SLRU cache hits.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_Notify_blks_read`<br/>`DGAUGE`, count | Number of Notify SLRU page reads from the disk.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_Notify_blks_written`<br/>`DGAUGE`, count | Number of Notify SLRU page writes to the disk.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_other_blks_hit`<br/>`DGAUGE`, count | Number of SLRU cache hits for pages of other SLRU tables.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_other_blks_hit`<br/>`DGAUGE`, count | Number of SLRU cache hits for pages of other SLRU tables.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul>
`postgres.slru_other_blks_read`<br/>`DGAUGE`, count | Number of page reads from the disk for other SLRU tables |
| `postgres.slru_other_blks_written`<br/>`DGAUGE`, count | Number of page writes to the disk for other SLRU tables.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_Serial_blks_hit`<br/>`DGAUGE`, count | Number of sequence page SLRU cache hits.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_Serial_blks_read`<br/>`DGAUGE`, count | Number of Serial SLRU page reads from the disk.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_Serial_blks_written`<br/>`DGAUGE`, count | Number of Serial SLRU page writes to the disk.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_Subtrans_blks_hit`<br/>`DGAUGE`, count | Number of  SLRU cache hits for subtransaction log data pages.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_Subtrans_blks_read`<br/>`DGAUGE`, count | Number of Subtrans SLRU page reads from the disk.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_Subtrans_blks_written`<br/>`DGAUGE`, count | Number of Subtrans SLRU page writes to the disk.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_Xact_blks_hit`<br/>`DGAUGE`, count | Number of SLRU cache hits for transaction log pages.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_Xact_blks_read`<br/>`DGAUGE`, count | Number of Xact SLRU page reads from the disk.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres.slru_Xact_blks_written`<br/>`DGAUGE`, count | Number of Xact SLRU page writes to the disk.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres_archive_lag.logid_lag`<br/>`DGAUGE`, count | Lag in archiving WAL segments.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres_archive_lag.record_lag`<br/>`DGAUGE`, count | Lag in archiving WAL records.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres_archive_lag.timeline_lag`<br/>`DGAUGE`, count | Lag in archiving timelines.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres_archive_lag_bytes`<br/>`DGAUGE`, bytes | WAL archive lag in bytes |
| `postgres_archive_lag_seconds`<br/>`DGAUGE`, seconds | WAL archive lag in seconds |
| `postgres_conn_aborted`<br/>`DGAUGE`, count | Number of crashed connections |
| `postgres_conn_active`<br/>`DGAUGE`, count | Number of active connections |
| `postgres_conn_idle_in_transaction`<br/>`DGAUGE`, count | Number of `idle in transaction` connections (pending within an open transaction) |
| `postgres_conn_idle`<br/>`DGAUGE`, count | Number of `idle` connections (waiting for new requests) |
| `postgres_conn_waiting`<br/>`DGAUGE`, count | Number of connections waiting for resources |
| `postgres_max_connections`<br/>`DGAUGE`, count | Maximum number of connections  |
| `postgres_oldest_prepared_xact_duration`<br/>`DGAUGE`, seconds | Duration of the oldest prepared transaction |
| `postgres_oldest_query_duration`<br/>`DGAUGE`, seconds | Duration of the oldest query |
| `postgres_oldest_transaction_duration`<br/>`DGAUGE`, seconds | Duration of the oldest transaction |
| `postgres_pg_total_databases_size`<br/>`DGAUGE`, bytes | Total size of all databases |
| `postgres_role_conn_limit`<br/>`DGAUGE`, count | Maximum number of concurrent sessions per user.<br/>Special labels:<ul><li>`database`: Database name</li><li>`user`: Username</li></ul> |
| `postgres_role_sessions`<br/>`DGAUGE`, count | Number of active sessions per user.<br/>Special labels:<ul><li>`database`: Database name</li><li>`user`: Username</li></ul> |
| `postgres_role_total_conn_limit`<br/>`DGAUGE`, count | Maximum possible number of concurrent sessions for all users |
| `postgres_total_connections`<br/>`DGAUGE`, count | Number of connections |
| `postgres_wait_event_CPU_CPU`<br/>`DGAUGE`, count | Number of {{ PG }} processes waiting for CPU time.<br/>Special labels:<ul><li>`database`: Database name</li><li>`user`: Username</li></ul> |
| `postgres_wait_event_IO_DataFileWrite`<br/>`DGAUGE`, count | Number of processes waiting to write data to database files.<br/>Special labels:<ul><li>`database`: Database name</li><li>`user`: Username</li></ul> |
| `postgres_wait_event_IO_WALInitSync`<br/>`DGAUGE`, count | Number of processes waiting for WAL file initialization and synchronization.<br/>Special labels:<ul><li>`database`: Database name</li><li>`user`: Username</li></ul> |
| `postgres_wait_event_IO_WALSync`<br/>`DGAUGE`, count | Number of processes waiting for WAL file fsync/synchronization.<br/>Special labels:<ul><li>`database`: Database name</li><li>`user`: Username</li></ul> |
| `postgres_wait_event_LWLock_WALWrite`<br/>`DGAUGE`, count | Number of processes waiting for a WAL write LWLock.<br/>Special labels:<ul><li>`database`: Database name</li><li>`user`: Username</li></ul> |
| `postgres_wal_rate_bytes`<br/>`DGAUGE`, bytes per second | Write-ahead logging rate |
| `postgres_xid_left_percent`<br/>`DGAUGE`, % | Percentage of transaction counters left |
| `postgres_xid_left`<br/>`DGAUGE`, count | Number of transaction counters left |
| `postgres_xid_used_percent`<br/>`DGAUGE`, % | Percentage of transaction counters used |
| `postgres-is_alive`<br/>`DGAUGE`, 0/1 | Host health indicator.<br/>`1` if the database host is operational, `0` if not. |
| `postgres-is_primary`<br/>`DGAUGE`, 0/1 | Master host indicator.<br/>`1` if the database host is a master, `0` if not. |
| `postgres-is_replica`<br/>`DGAUGE`, 0/1 | Replica host indicator.<br/>`1` if the database host is a replica, `0` if not. |
| `postgres-log_errors`<br/>`DGAUGE`, messages per second| Number of errors logged per second |
| `postgres-log_fatals`<br/>`DGAUGE`, messages per second| Number of fatal errors logged per second |
| `postgres-log_slow_queries`<br/>`DGAUGE`, queries per second| Number of slow queries logged per second |
| `postgres-log_warnings`<br/>`DGAUGE`, messages per second| Number of warnings logged per second |
| `postgres-oldest_inactive_replication_slot_duration`<br/>`DGAUGE`, seconds | Duration of the oldest inactive replication slot |
| `postgres-replica_type`<br/>`DGAUGE`, count | Current {{ PG }} replica type |
| `postgres-replication_lag`<br/>`DGAUGE`, seconds | Replication lag.<br/>Calculated with one-second accuracy. A lag of less than one second cannot be tracked using this metric. |
| `postgres-role`<br/>`DGAUGE`, count | {{ PG }} instance role |
| `postgres-some_writable`<br/>`DGAUGE`, 0/1 | Indicates if the database is available for writing |
| `uptime`<br/>`DGAUGE`, % | Uptime percentage |


#### DB metrics {#managed-postgresql-db-metrics}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `_pg_database_size`<br/>`DGAUGE`, bytes | Database size.<br/>The `dbname` special label is the database name. |
| `<DB_name>_tup_deleted`<br/>`DGAUGE`, count | Number of rows deleted by queries in `<DB_name>` |
| `<DB_name>_tup_fetched`<br/>`DGAUGE`, count | Number of rows fetched by queries in `<DB_name>` |
| `<DB_name>_tup_inserted`<br/>`DGAUGE`, count | Number of rows inserted by queries in `<DB_name>` |
| `<DB_name>_tup_returned`<br/>`DGAUGE`, count | Number of rows returned by queries in `<DB_name>` |
| `<DB_name>_tup_updated`<br/>`DGAUGE`, count | Number of rows updated by queries in `<DB_name>` |


#### Connection pooler metrics {#managed-postgresql-pooler-metrics}

Special labels for Odyssey metrics:
* `fqdn`: Host FQDN
* `cid`: Cluster ID

| Name<br/>Type, units | Description |
| ----- | ----- |
| `odyssey.cpu_time_iowait`<br/>`DGAUGE`, seconds | Odyssey process I/O wait time |
| `odyssey.cpu_time_system`<br/>`DGAUGE`, seconds | Odyssey process time in kernel mode |
| `odyssey.cpu_time_user`<br/>`DGAUGE`, seconds | Odyssey process time in user mode |
| `odyssey.cpu_usage`<br/>`DGAUGE`, % | Odyssey process CPU usage |
| `odyssey.involuntary_context_switches`<br/>`DGAUGE`, count | Number of Odyssey process forced context switches |
| `odyssey.major_faults`<br/>`DGAUGE`, count | Number of Odyssey process major memory page faults |
| `odyssey.memory_rss`<br/>`DGAUGE`, bytes | Odyssey process RAM usage (RSS) |
| `odyssey.memory_usage`<br/>`DGAUGE`, % | Total memory used by the Odyssey process |
| `odyssey.memory_vms`<br/>`DGAUGE`, bytes | Odyssey process virtual memory |
| `odyssey.minor_faults`<br/>`DGAUGE`, count | Number of Odyssey process minor memory page faults |
| `odyssey.num_fds`<br/>`DGAUGE`, count | Number of Odyssey process open file descriptors |
| `odyssey.running`<br/>`DGAUGE`, 0/1 | Indicates a running Odyssey process.<br/>Special labels:<ul><li>`pgrep`</li><li>`result`</li></ul> |
| `odyssey.voluntary_context_switches`<br/>`DGAUGE`, count | Number of Odyssey process voluntary context switches|
| `pooler-avg_query_time`<br/>`DGAUGE`, milliseconds | Average query execution time per database host |
| `pooler-avg_xact_time`<br/>`DGAUGE`, milliseconds | Average transaction execution time per database host |
| `pooler-bytes_recieved`<br/>`DGAUGE`, bytes | Size of data received |
| `pooler-bytes_recieved-<DB_name>-<username>`<br/>`DGAUGE`, bytes | Size of data received by `<username>` through `<DB_name>` |
| `pooler-bytes_sent`<br/>`DGAUGE`, bytes | Total sent data size |
| `pooler-bytes_sent-<DB_name>-<username>`<br/>`DGAUGE`, bytes | Size of data sent by `<username>` through `<DB_name>` |
| `pooler-cl_active`<br/>`DGAUGE`, count | Number of active client connections |
| `pooler-cl_waiting`<br/>`DGAUGE`, count | Number of client connections waiting for a server connection release |
| `pooler-free_clients`<br/>`DGAUGE`, count | Remaining client connections in the connection pooler |
| `pooler-free_servers`<br/>`DGAUGE`, count | Remaining server connections in the connection pooler |
| `pooler-is_alive`<br/>`DGAUGE`, 0/1 | Connection pooler health for each host both as a master and as a replica |
| `pooler-login_clients`<br/>`DGAUGE`, count | Number of client connections established in the connection pooler |
| `pooler-maxwait`<br/>`DGAUGE`, milliseconds | Maximum client connection wait time |
| `pooler-pgbouncer_tcp_connections`<br/>`DGAUGE`, connections per second | Number of PostgreSQL TCP connections |
| `pooler-postgres_tcp_connections`<br/>`DGAUGE`, connections per second | Number of PgBouncer TCP connections |
| `pooler-query_0.5`<br/>`DGAUGE`, milliseconds | Median query execution time |
| `pooler-query_0.5-<DB_name>-<username>`<br/>`DGAUGE`, milliseconds | Execution time for queries run by `<username>` through `<DB_name>`, median value |
| `pooler-query_0.75`<br/>`DGAUGE`, milliseconds | 75th percentile query execution time |
| `pooler-query_0.75-<DB_name>-<username>`<br/>`DGAUGE`, milliseconds | Execution time for queries run by `<username>` through `<DB_name>`, 75th percentile |
| `pooler-query_0.9`<br/>`DGAUGE`, milliseconds | Query execution time, 90th percentile |
| `pooler-query_0.9-<DB_name>-<username>`<br/>`DGAUGE`, milliseconds | Execution time for queries run by `<username>` through `<DB_name>`, 90th percentile |
| `pooler-query_0.95`<br/>`DGAUGE`, milliseconds | 95th percentile query execution time |
| `pooler-query_0.95-<DB_name>-<username>`<br/>`DGAUGE`, milliseconds | Execution time for queries run by `<username>` through `<DB_name>`, 95th percentile |
| `pooler-query_0.99`<br/>`DGAUGE`, milliseconds | 99th percentile query execution time |
| `pooler-query_0.99-<DB_name>-<username>`<br/>`DGAUGE`, milliseconds | Execution time for queries run by `<username>` through `<DB_name>`, 99th percentile |
| `pooler-query_0.999`<br/>`DGAUGE`, milliseconds | Query execution time, 99.9th percentile |
| `pooler-query_0.999-<DB_name>-<username>`<br/>`DGAUGE`, milliseconds | Execution time for queries run by `<username>` through `<DB_name>`, 99.9th percentile |
| `pooler-query_0.9999`<br/>`DGAUGE`, milliseconds | 99.99th percentile query execution time |
| `pooler-query_0.9999-<DB_name>-<username>`<br/>`DGAUGE`, milliseconds | Execution time for queries run by `<username>` through `<DB_name>`, 99.99th percentile |
| `pooler-query_1`<br/>`DGAUGE`, milliseconds | 100th percentile query execution time |
| `pooler-query_1-<DB_name>-<username>`<br/>`DGAUGE`, milliseconds | Execution time for queries run by `<username>` through `<DB_name>`, 100th percentile |
| `pooler-query_count`<br/>`DGAUGE`, count | Number of running queries per DB host |
| `pooler-sv_active`<br/>`DGAUGE`, count | Number of active server connections |
| `pooler-sv_idle`<br/>`DGAUGE`, count | Number of idle server connections |
| `pooler-sv_login`<br/>`DGAUGE`, count | Number of server connections undergoing authentication |
| `pooler-sv_tested`<br/>`DGAUGE`, count | Number of verified server connections |
| `pooler-tcp_conn_count`<br/>`DGAUGE`, count | Number of TCP connections per DB host |
| `pooler-tcp_conn_count-<DB_name>-<username>`<br/>`DGAUGE`, count | Number of `<username>` TCP connections per DB host through `<DB_name>` |
| `pooler-total_query_count`<br/>`DGAUGE`, count | Number of executed queries |
| `pooler-total_tcp_connections`<br/>`DGAUGE`, connections per second | Number of PostgreSQL and PgBouncer TCP connections |
| `pooler-total_xact_count`<br/>`DGAUGE`, count | Number of executed transactions |
| `pooler-transaction_0.5`<br/>`DGAUGE`, milliseconds | Median transaction processing time |
| `pooler-transaction_0.5-<DB_name>-<username>`<br/>`DGAUGE`, milliseconds | Processing time for transactions executed by `<username>` through `<DB_name>`, median value |
| `pooler-transaction_0.75`<br/>`DGAUGE`, milliseconds | Transaction processing time, 75th percentile |
| `pooler-transaction_0.75-<DB_name>-<username>`<br/>`DGAUGE`, milliseconds | Processing time for transactions executed by `<username>` through `<DB_name>`, 75th percentile |
| `pooler-transaction_0.9`<br/>`DGAUGE`, milliseconds | Transaction processing time, 90th percentile |
| `pooler-transaction_0.9-<DB_name>-<username>`<br/>`DGAUGE`, milliseconds | Processing time for transactions executed by `<username>` through `<DB_name>`, 90th percentile |
| `pooler-transaction_0.95`<br/>`DGAUGE`, milliseconds | Transaction processing time, 95th percentile |
| `pooler-transaction_0.95-<DB_name>-<username>`<br/>`DGAUGE`, milliseconds | Processing time for transactions executed by `<username>` through `<DB_name>`, 95th percentile |
| `pooler-transaction_0.99`<br/>`DGAUGE`, milliseconds | Transaction processing time, 99th percentile |
| `pooler-transaction_0.99-<DB_name>-<username>`<br/>`DGAUGE`, milliseconds | Processing time for transactions executed by `<username>` through `<DB_name>`, 99th percentile |
| `pooler-transaction_0.999`<br/>`DGAUGE`, milliseconds | Transaction processing time, 99.9th percentile |
| `pooler-transaction_0.999-<DB_name>-<username>`<br/>`DGAUGE`, milliseconds | Processing time for transactions executed by `<username>` through `<DB_name>`, 99.9th percentile |
| `pooler-used_clients`<br/>`DGAUGE`, count | Number of client connections in the connection pooler |
| `pooler-used_servers`<br/>`DGAUGE`, count | Number of server connections in the connection pooler |
| `pooler-xact_count`<br/>`DGAUGE`, count | Number of running transactions per DB host |


#### Vacuum metrics {#managed-postgresql-vacuum}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `postgres_autovacuum.autovacuum_max_workers`<br/>`DGAUGE`, count | Maximum number of autovacuum workers, as defined by `autovacuum_max_workers`.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres_autovacuum.scanned_pct`<br/>`DGAUGE`, % | Percentage of table rows scanned by an autovacuum worker |
| `postgres_autovacuum.scanned_percent`<br/>`DGAUGE`, % | Percentage of table rows scanned by an autovacuum worker.<br/>Special labels:<ul><li>`dbname`: Database name</li><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li><li>`mode`: Execution mode</li><li>`rel`: Table name</li></ul> |
| `postgres_autovacuum.total_regular_vacuums`<br/>`DGAUGE`, count | Total number of executed regular autovacuum operations.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres_autovacuum.total_regular_workers`<br/>`DGAUGE`, count | Number of active autovacuum workers |
| `postgres_autovacuum.total_user_vacuums`<br/>`DGAUGE`, count | Total number of custom autovacuum operations.<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres_autovacuum.total_user_workers`<br/>`DGAUGE`, count | Number of active user-launched autovacuum workers |
| `postgres_autovacuum.total_wraparound_vacuums`<br/>`DGAUGE`, count | Total number of autovacuum operations to prevent wraparound (xid overflow).<br/>Special labels:<ul><li>`cid`: Cluster ID</li><li>`fqdn`: Host FQDN</li></ul> |
| `postgres_autovacuum.total_wraparound_workers`<br/>`DGAUGE`, count | Number of active autovacuum workers launched to prevent [wraparound](https://www.postgresql.org/docs/current/routine-vacuuming.html#VACUUM-FOR-WRAPAROUND) |
| `postgres_autovacuum.vacuumed_pct`<br/>`DGAUGE`, % | Percentage of table rows vacuumed by an autovacuum worker |