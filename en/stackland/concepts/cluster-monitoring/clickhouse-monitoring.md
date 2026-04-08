# {{ CH }} dashboard metrics

{{ grafana-name }}'s {{ CH }} dashboard enables comprehensive monitoring of a {{ CH }} DBMS cluster. The dashboard displays performance metrics, replication status, use of resources, and other critical cluster parameters.

To open a cluster dashboard:

1. If you have not opened a project yet, select one.
1. In the left-hand menu, select **{{ CH }} Clusters**.
1. Select a cluster.
1. Click **Cluster monitoring**.

This will open the cluster dashboard.

## General info

**Dashboard title**: {{ CH }}.
**UID**: `clickhouse-operator`.
**Refresh interval**: 10 seconds.
**Data source**: {{ prometheus-name }}.

## Dashboard variables

The dashboard uses the following variables for data filtering:

* **Cluster** (`chi`): Selecting a {{ CH }} cluster.
* **Server** (`hostname`): Selecting a specific server.
* **Namespace** (`namespace`): Stackland project where {{ CH }} Operator is deployed.

## Panels and metrics

### 1. Uptime (logarithmic)

**Description**: {{ CH }} server uptime since last restart. The chart uses a logarithmic scale to make large values easier to read.

**Metric**: `chi_clickhouse_metric_Uptime`.

**Unit of measurement**: Seconds.

### 2. Failed Pods

**Description**: Number of pods where `metrics-exporter` fails to retrieve metrics from `clickhouse-server`. Any non-zero value indicates issues with server availability.

**Metric**: `chi_clickhouse_metric_fetch_errors`.

**Unit of measurement**: Count.

**Recommendations**: If errors occur, check the pod status by running `kubectl get pods --all-namespaces | grep clickhouse`.

**Links**:
* [metric_fetch_errors on GitHub](https://github.com/Altinity/clickhouse-operator/search?q=metric_fetch_errors)

### 3. Version

**Description**: {{ CH }} version deployed on the servers. The system shows the version in numeric format; e.g., 11.22.33 appears as 11022033.

**Metric**: `chi_clickhouse_metric_VersionInteger`.

**Unit of measurement**: Numeric version format.

### 4. Tables / Databases

**Description**: Total number of tables and databases in the cluster.

**Metrics**:
* `chi_clickhouse_metric_NumberOfTables`: Number of tables.
* `chi_clickhouse_metric_NumberOfDatabases`: Number of databases.

**Unit of measurement**: Count



### 5. ReadOnly replicas

**Description**: Number of replicas in read-only mode. Any non-zero value indicates replication issues.

**Metric**: `chi_clickhouse_metric_ReadonlyReplica`.

**Unit of measurement**: Count.



**Recommendations**: Check the {{ ZK }} connection, available disk space, and network connectivity between replicas.

**Links**:
* [Recovery after failures](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/replication/#recovery-after-failures)
* [Recovery after complete data loss](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/replication/#recovery-after-complete-data-loss)

### 6. DNS and Distributed Connection Errors

**Description**: DNS errors and connectivity failures between servers in distributed tables.

**Metrics**:
* `chi_clickhouse_event_NetworkErrors`: Network errors.
* `chi_clickhouse_event_DistributedConnectionFailAtAll`: Complete failures of distributed connections.
* `chi_clickhouse_event_DistributedConnectionFailTry`: Failed connection attempts.
* `chi_clickhouse_event_DNSError`: DNS errors.

**Unit of measurement**: Events per minute

**Links**:
* [Distributed table management](https://clickhouse.com/docs/en/sql-reference/statements/system#managing-distributed-tables)
* [DNSError on GitHub](https://github.com/clickhouse/clickhouse/search?q=DNSError)

### 7. Replication and {{ ZK }} Exceptions

**Description**: Replication metrics and exceptions when working with {{ ZK }}.

**Metrics**:
* `chi_clickhouse_metric_ReadonlyReplica`: Read-only replicas.
* `chi_clickhouse_event_ReplicaPartialShutdown`: Partial replica shutdown.
* `chi_clickhouse_event_{{ ZK }}UserExceptions`: custom {{ ZK }} exceptions.
* `chi_clickhouse_event_{{ ZK }}Init`: {{ ZK }} initialization.
* `chi_clickhouse_metric_{{ ZK }}Session`: {{ ZK }} sessions.
* `chi_clickhouse_event_{{ ZK }}HardwareExceptions`: hardware {{ ZK }} exceptions.

**Unit of measurement**: Events per minute.

**Links**:
* [Recommended {{ ZK }} settings](https://clickhouse.com/docs/en/operations/tips#zookeeper)
* [system.zookeeper](https://clickhouse.com/docs/en/operations/system-tables/zookeeper)

### 8. Delayed/Rejected/Pending Inserts

**Description**: Metrics of delayed, rejected, and pending data inserts.

**Metrics**:
* `chi_clickhouse_metric_DelayedInserts`: Current number of delayed `INSERT` queries.
* `chi_clickhouse_event_DelayedInserts`: Total counter of delayed blocks.
* `chi_clickhouse_event_RejectedInserts`: Number of rejected blocks.
* `chi_clickhouse_metric_DistributedFilesToInsert`: Files pending insertion into distributed tables.
* `chi_clickhouse_metric_BrokenDistributedFilesToInsert`: Corrupted files in distributed tables.

**Unit of measurement**: Count.

**Metric description**:
* **delayed query**: Number of `INSERT` queries delayed due to a large number of active data parts.
* **delayed blocks**: Number of blocks with delayed insertion.
* **rejected blocks**: Number of blocks whose insertion was rejected with a `Too many parts` error.

**Recommendations**: Check the `parts_to_delay_insert` and `parts_to_throw_insert` settings in the `system.merge_tree_settings` table.

**Links**:
* [system.parts_log](https://clickhouse.com/docs/en/operations/system-tables/part_log)
* [system.merge_tree_settings](https://clickhouse.com/docs/en/operations/system-tables/merge_tree_settings)

### 9. Queries (running)

**Description**: Number of running queries per server and cluster-wide.

**Metric**: `chi_clickhouse_metric_Query`.

**Unit of measurement**: Count.

**Links**:
* [max_concurrent_queries](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#max_concurrent_queries)
* [max_execution_time](https://clickhouse.com/docs/en/operations/settings/query-complexity#max-execution-time)

### 10. Select Queries (started per sec)

**Description**: Number of SELECT queries per second.

**Metric**: `chi_clickhouse_event_SelectQuery`.

**Unit of measurement**: Queries per second.

### 11. Memory for Queries

**Description**: Total memory allocated for running queries. Certain memory allocations may not be considered.

**Metric**: `chi_clickhouse_metric_MemoryTracking`.

**Unit of measurement**: Bytes.

**Links**:
* [max_memory_usage](https://clickhouse.com/docs/en/operations/settings/query-complexity#settings_max_memory_usage)

### 12. Insert Queries (running)

**Description**: Number of running `INSERT` queries. It does not include queries that failed parsing or were rejected due to limits, but does include internal {{ CH }}-initiated queries.

**Metric**: `chi_clickhouse_event_InsertQuery`.

**Unit of measurement**: Queries per minute.

### 13. Insert Queries (started per sec)

**Description**: Number of `INSERT` queries per second.

**Metric**: `chi_clickhouse_event_InsertQuery`.

**Unit of measurement**: Queries per second.

### 14. Rows Inserted

**Description**: Number of rows inserted into tables.

**Metric**: `chi_clickhouse_event_InsertedRows`.

**Unit of measurement**: Rows per minute.

### 15. Replication Queue Jobs

**Description**: Rate of data part exchange between replicas.

**Metrics**:
* `chi_clickhouse_event_ReplicatedDataLoss`: Data loss during replication.
* `chi_clickhouse_event_ReplicatedPartChecks`: Counter of data part checks.
* `chi_clickhouse_event_ReplicatedPartChecksFailed`: Counter of failed data part checks.
* `chi_clickhouse_event_ReplicatedPartFetches`: Network replication activity.
* `chi_clickhouse_event_ReplicatedPartFailedFetches`: Counter of failed attempts to fetch data parts.
* `chi_clickhouse_event_ReplicatedPartFetchesOfMerged`: Fetching merged data parts.
* `chi_clickhouse_event_ReplicatedPartMerges`: Merging replicated data parts.
* `chi_clickhouse_metric_ReplicasSumInsertsInQueue`: Replication lag. It shows the number of pending queries in the queue.
* `chi_clickhouse_metric_ReplicasSumMergesInQueue`: Data merge lag. It shows the number of merges not yet completed by replicas.

**Unit of measurement**: Events per minute.



**Links**:
* [How replication works](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/replication)

### 16. Max Replica Delay

**Description**: Replica lag relative to the current time for direct inserts into `*ReplicatedMergeTree` tables.

**Metrics**:
* `chi_clickhouse_metric_ReplicasMaxAbsoluteDelay`: Absolute lag, in seconds.
* `chi_clickhouse_metric_ReplicasMaxRelativeDelay`: Relative lag, in seconds.

**Unit of measurement**: Seconds.



**Links**:
* [Replication architecture](https://clickhouse.com/docs/en/development/architecture#replication)
* [ReplicatedMergeTree](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/replication)
* [max_replica_delay_for_distributed_queries](https://clickhouse.com/docs/en/operations/settings/settings#settings-max_replica_delay_for_distributed_queries)

### 17. Zookeeper Transactions

**Description**: Number of {{ ZK }} transactions per second.

**Metric**: `chi_clickhouse_event_{{ ZK }}Transactions`.

**Unit of measurement**: Transactions per second.



**Links**:
* [Replication architecture](https://clickhouse.com/docs/en/development/architecture#replication)

### 18. Merges

**Description**: Rate of background merges for data parts.

**Metric**: `chi_clickhouse_event_Merge`.

**Unit of measurement**: Merges per minute.



**Links**:
* [START/STOP Merges](https://clickhouse.com/docs/en/sql-reference/statements/system#stop-merges)
* [MergeTree Engine](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree)

### 19. Merged Rows

**Description**: Number of rows processed in merging.

**Metric**: `chi_clickhouse_event_MergedRows`.

**Unit of measurement**: Rows per minute.



### 20. Merged Uncompressed Bytes

**Description**: Size of uncompressed data processed in merging.

**Metric**: `chi_clickhouse_event_MergedUncompressedBytes`.

**Unit of measurement**: Bytes per minute.



### 21. Active Parts

**Description**: Number of active data parts in tables.

**Metric**: `chi_clickhouse_table_parts` (filtered by `active="1"`).

**Unit of measurement**: Count.

**Links**:
* [system.parts](https://clickhouse.com/docs/en/operations/system-tables/parts)
* [parts_to_delay_insert](https://github.com/clickhouse/clickhouse/search?q=parts_to_delay_insert)

### 22. Detached parts

**Description**: Number of detached data parts, along with the reason for detachment.

**Metrics**:
* `chi_clickhouse_metric_DetachedParts`: Number of detached data parts.
* `chi_clickhouse_table_parts` (filtered by `active="0"`): Inactive parts.

**Unit of measurement**: Count.

**Reasons for detachment**:
* `detached_by_user`: Detached by the user.
* `broken`: Corrupted parts.
* `clone`: Cloned parts.
* `ignored`: Ignored parts.

**Links**:
* [system.detached_parts](https://clickhouse.com/docs/en/operations/system-tables/detached_parts/)

### 23. Max Part count for Partition

**Description**: Maximum number of physical data parts per logical partition.

**Metric**: `chi_clickhouse_metric_MaxPartCountForPartition`.

**Unit of measurement**: Count.



**Links**:
* [Custom Partitioning Key](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/custom-partitioning-key/)
* [system.parts](https://clickhouse.com/docs/en/operations/system-tables/parts)
* [system.part_log](https://clickhouse.com/docs/en/operations/system-tables/part-log)

### 24. clickhouse-server Process Memory

**Description**: Memory usage by `clickhouse-server` (available since {{ CH }} 20.4+).

**Metrics**:
* `chi_clickhouse_metric_MemoryCode`: Executable code (CODE).
* `chi_clickhouse_metric_MemoryResident`: Resident set size (RSS).
* `chi_clickhouse_metric_MemoryShared`: Shared memory (SHR).
* `chi_clickhouse_metric_MemoryDataAndStack`: Data and stack (DATA).
* `chi_clickhouse_metric_MemoryVirtual`: Virtual memory (VIRT).

**Unit of measurement**: Bytes.

**Memory type description**:
* **VIRT**: Total virtual memory (VIRT = SWAP + RSS).
* **SWAP**: Amount of memory swapped out.
* **RSS**: Physical memory not swapped out (RSS = CODE + DATA).
* **CODE**: Memory for executable code (text resident set).
* **DATA**: Memory for non-executable data (data resident set).
* **SHR**: Shared memory available to other processes.

**Links**:
* [Description of Linux memory types](https://elinux.org/Runtime_Memory_Measurement)

### 25. Primary Keys Memory

**Description**: Memory allocated for primary key storage.

**Metric**: `chi_clickhouse_metric_MemoryPrimaryKeyBytesAllocated`.

**Unit of measurement**: Bytes.



**Links**:
* [Selecting a primary key](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree#selecting-the-primary-key)

### 26. Dictionary Memory

**Description**: Memory allocated for dictionaries.

**Metric**: `chi_clickhouse_metric_MemoryDictionaryBytesAllocated`.

**Unit of measurement**: Bytes.



**Links**:
* [system.dictionaries](https://clickhouse.com/docs/en/operations/system-tables/dictionaries)
* [CREATE DICTIONARY](https://clickhouse.com/docs/en/sql-reference/statements/create/dictionary)

### 27. Disk Space Free

**Description**: Free disk space ratio. Make sure to consider configurations with multiple volumes, {{ k8s }} volume claims, and {{ objstorage-name }} as the storage backend.

**Metric**: `chi_clickhouse_metric_DiskFreeBytes / chi_clickhouse_metric_DiskTotalBytes`.

**Unit of measurement**: Fraction (0–1).



**Links**:
* [system.disks](https://clickhouse.com/docs/en/operations/system-tables/disks/)
* [Multiple Disk Volumes](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-multiple-volumes)

### 28. Table Stats

**Description**: Table statistics, such as data size, row count, number of parts, and average row size.

**Metrics**:
* `chi_clickhouse_table_parts_bytes`: Data size, in bytes.
* `chi_clickhouse_table_parts_rows`: Number of rows.
* `chi_clickhouse_table_parts`: Number of parts.

**Unit of measurement**:
* Bytes
* Rows
* Parts
* BytePerRow (calculated field)



### 29. Clickhouse Data size on Disk

**Description**: Total disk space used by `*MergeTree` tables.

**Metric**: `chi_clickhouse_metric_DiskDataBytes`.

**Unit of measurement**: Bytes.



**Links**:
* [system.parts](https://clickhouse.com/docs/en/operations/system-tables/parts)

### 30. Background Tasks

**Description**: Number of active background tasks.

**Metrics**:
* `chi_clickhouse_metric_BackgroundPoolTask`: Merge, mutation, data fetch, and replication queue management tasks.
* `chi_clickhouse_metric_BackgroundSchedulePoolTask`: Periodic ReplicatedMergeTree tasks, such as cleanup of old parts, part mutations, and replica reinitialization.
* `chi_clickhouse_metric_BackgroundMovePoolTask`: Data movement tasks.

**Unit of measurement**: Count.



**Links**:
* [FETCH PARTITION](https://clickhouse.com/docs/en/sql-reference/statements/alter/partition#fetch-partitionpart)
* [Mutations](https://clickhouse.com/docs/en/sql-reference/statements/alter#mutations)
* [Data TTL](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-ttl)
* [MOVE PARTITION](https://clickhouse.com/docs/en/sql-reference/statements/alter/partition#move-partitionpart)

### 31. Mutations

**Description**: Number of active mutations (`ALTER DELETE`/`ALTER UPDATE`) and data parts pending mutation.

**Metrics**:
* `chi_clickhouse_table_mutations`: Number of mutations.
* `chi_clickhouse_table_mutations_parts_to_do`: Number of parts pending mutation.

**Unit of measurement**: Count.



**Links**:
* [Mutations](https://clickhouse.com/docs/en/sql-reference/statements/alter#mutations)
* [system.mutations](https://clickhouse.com/docs/en/operations/system-tables/mutations)
* [KILL MUTATION](https://clickhouse.com/docs/en/sql-reference/statements/kill#kill-mutation)

### 32. Marks Cache Hit Rate

**Description**: Cache hit rate for mark files (`.mrk`) read from memory rather than disk.

**Metric**: `chi_clickhouse_event_MarkCacheHits / (chi_clickhouse_event_MarkCacheHits + chi_clickhouse_event_MarkCacheMisses)`.

**Unit of measurement**: Fraction (0–1).



**Links**:
* [mark_cache_size](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#server-mark-cache-size)
* [MergeTree architecture](https://clickhouse.com/docs/en/development/architecture/#merge-tree)

### 33. CPU Time per second

**Description**: CPU time spent on different types of activity.

**Metrics**:
* `chi_clickhouse_event_RealTimeMicroseconds`: Real execution time.
* `chi_clickhouse_event_UserTimeMicroseconds`: User CPU time.
* `chi_clickhouse_event_SystemTimeMicroseconds`: System CPU time.
* `chi_clickhouse_event_OSIOWaitMicroseconds`: I/O wait time.
* `chi_clickhouse_event_OSCPUWaitMicroseconds`: CPU wait time.
* `chi_clickhouse_event_OSCPUVirtualTimeMicroseconds`: Virtual CPU time.

**Unit of measurement**: Microseconds per second



### 34. Network / Disk CPU Time per second

**Description**: CPU time spent on network and disk operations.

**Metrics**:
* `chi_clickhouse_event_DiskReadElapsedMicroseconds`: Disk read time.
* `chi_clickhouse_event_DiskWriteElapsedMicroseconds`: Disk write time.
* `chi_clickhouse_event_NetworkReceiveElapsedMicroseconds`: Network receive time.
* `chi_clickhouse_event_NetworkSendElapsedMicroseconds`: Network send time.

**Unit of measurement**: Microseconds per second



### 35. Load Average 1m

**Description**: Average system load over one minute (Unix load average). Load is considered high if it approaches the number of available CPUs or the CPU limits allocated to the {{ CH }} pod.

**Metric**: `chi_clickhouse_metric_LoadAverage1`.

**Unit of measurement**: Dimensionless quantity.



### 36. CPU Time total

**Description**: Total CPU time spent on various activities over the selected period.

**Metrics**:
* `chi_clickhouse_event_DiskReadElapsedMicroseconds`: Disk read time.
* `chi_clickhouse_event_DiskWriteElapsedMicroseconds`: Disk write time.
* `chi_clickhouse_event_NetworkReceiveElapsedMicroseconds`: Network receive time.
* `chi_clickhouse_event_NetworkSendElapsedMicroseconds`: Network send time.
* `chi_clickhouse_event_RealTimeMicroseconds`: Real query execution time.
* `chi_clickhouse_event_UserTimeMicroseconds`: User CPU time.
* `chi_clickhouse_event_SystemTimeMicroseconds`: System CPU time.
* `chi_clickhouse_event_OSIOWaitMicroseconds`: I/O wait time.
* `chi_clickhouse_event_OSCPUWaitMicroseconds`: CPU wait time.
* `chi_clickhouse_event_OSCPUVirtualTimeMicroseconds`: CPU time spent on virtual OS processes.
* `chi_clickhouse_event_ThrottlerSleepMicroseconds`: Throttler wait time.
* `chi_clickhouse_event_DelayedInsertsMilliseconds`: Time spent on delayed inserts.
* `chi_clickhouse_event_{{ ZK }}WaitMicroseconds`: {{ ZK }} wait time.
* `chi_clickhouse_event_CompileExpressionsMicroseconds`: Expression compilation time.
* `chi_clickhouse_event_MergesTimeMilliseconds`: Merge time.
* `chi_clickhouse_event_RWLockReadersWaitMilliseconds`: Read lock wait time.
* `chi_clickhouse_event_RWLockWritersWaitMilliseconds`: Write lock wait time.
* `chi_clickhouse_event_SelectQueryTimeMicroseconds`: Time spent running `SELECT` queries.
* `chi_clickhouse_event_InsertQueryTimeMicroseconds`: Time spent running `INSERT` queries.
* `chi_clickhouse_event_{{ objstorage-name }}ReadMicroseconds`: {{ objstorage-name }} read time.
* `chi_clickhouse_event_{{ objstorage-name }}WriteMicroseconds`: {{ objstorage-name }} write time.

**Unit of measurement**: Microseconds.



**Interval**: 1 minute.

### 37. Connections

**Description**: Different connection types per server.

**Metrics**:
* `chi_clickhouse_metric_TCPConnection`: TCP connections (native protocol).
* `chi_clickhouse_metric_HTTPConnection`: HTTP connections.
* `chi_clickhouse_metric_InterserverConnection`: Inter-server connections.
* `chi_clickhouse_metric_MySQLConnection`: MySQL connections.

**Unit of measurement**: Count.



**Links**:
* [max_connections](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#max-connections)
* [max_distributed_connections](https://clickhouse.com/docs/en/operations/settings/settings#max-distributed-connections)
* [MySQL Protocol](https://clickhouse.com/docs/en/interfaces/mysql/)
* [HTTP Protocol](https://clickhouse.com/docs/en/interfaces/http/)
* [Native Protocol](https://clickhouse.com/docs/en/interfaces/tcp/)

## Monitoring best practices

### Critical metrics

The following metrics require immediate attention when they deviate from normal values:

1. **Failed Pods**: It must be `0`. Any non-zero value indicates server unavailability.
1. **ReadOnly replicas**: It must be `0`. Any non-zero value indicates replication issues.
1. **DNS and Distributed Connection Errors**: It must be as low as possible. High values indicate network issues.
1. **Delayed/Rejected Inserts**: High values of this metric indicate write performance issues.
1. **Disk Space Free**: Monitor free space; critical threshold is below 10%.

### Performance metrics

To evaluate your cluster performance, pay attention to:

1. **Queries (running)**: Number of concurrent queries.
1. **Memory for Queries**: Query memory usage.
1. **CPU Time per second**: CPU load.
1. **Marks Cache Hit Rate**: Cache efficiency, which must be more than 90%.

### Replication metrics

For replication status monitoring:

1. **Replication Queue Jobs**: Replication queue size.
1. **Max Replica Delay**: Replica lag.
1. **Zookeeper Transactions**: {{ ZK }} transaction rate.

### Storage metrics

For disk space usage monitoring:

1. **Active Parts**: Number of active data parts.
1. **Detached parts** : Detached parts, which must be minimal.
1. **Max Part count for Partition**: Number of parts per partition.
1. **Clickhouse Data size on Disk**: Total data size.

## Extra resources

* [Official {{ CH }} documentation](https://clickhouse.com/docs/)
* [{{ CH }} Operator on GitHub](https://github.com/Altinity/clickhouse-operator)
* [System Tables Reference](https://clickhouse.com/docs/en/operations/system-tables/)
* [Server Configuration Parameters](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings)
