The `name` label stores the metric name.

Labels shared by all {{ mch-name }} metrics: 

Label | Value
----|----
service | Service ID: `managed-clickhouse`
resource_type | Resource type: `cluster`
resource_id | Cluster ID
host | Host FQDN
node | Host type: `replica`, `follower`, or `leader`
subcluster_name | Subcluster type: `clickhouse_subcluster` or `zookeeper_subcluster`
shard | Shard ID

## CPU metrics {#managed-clickhouse-cpu-metrics}
These metrics show processor core workload.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `cpu.fraction`<br/>`DGAUGE`, % | Guaranteed vCPU performance |
| `cpu.guarantee`<br/>`DGAUGE`, count | Guaranteed number of cores |
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
| `load.avg_15min`<br/>`DGAUGE`, % | Average load over 15 minutes |
| `load.avg_1min`<br/>`DGAUGE`, % | Average load over one minute |
| `load.avg_5min`<br/>`DGAUGE`, % | Average load over five minutes |

## Disk metrics {#managed-clickhouse-disk-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `ch_s3_disk_parts_size`<br/>`DGAUGE`, bytes | Space used by [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) table parts in {{ objstorage-full-name }} with a {{ mch-name }} [hybrid storage](../../../managed-clickhouse/concepts/storage.md#hybrid-storage-features) configured. |
| `disk.free_bytes`<br/>`DGAUGE`, bytes | Free space | 
| `disk.free_inodes`<br/>`DGAUGE`, count | Free inodes | 
| `disk.total_bytes`<br/>`DGAUGE`, bytes | Available space | 
| `disk.total_inodes`<br/>`DGAUGE`, count | Available inodes | 
| `disk.used_bytes`<br/>`DGAUGE`, bytes | Used space | 
| `disk.used_inodes`<br/>`DGAUGE`, count | Used inodes |

## Disk I/O metrics {#managed-clickhouse-diskio-metrics}
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

## RAM metrics {#managed-clickhouse-ram-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.guarantee_bytes`<br/>`DGAUGE`, bytes | Guaranteed memory allocation | 
| `mem.limit_bytes`<br/>`DGAUGE`, bytes | Memory limit | 
| `mem.active_bytes`<br/>`DGAUGE`, bytes | Active resident memory (frequently accessed and released when absolutely necessary) | 
| `mem.available_bytes`<br/>`DGAUGE`, bytes | RAM usage, `available` usage type | 
| `mem.buffers_bytes`<br/>`DGAUGE`, bytes | RAM usage, `buffers` usage type  | 
| `mem.cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type  | 
| `mem.free_bytes`<br/>`DGAUGE`, bytes | Amount of free RAM available, excluding `mem.buffers_bytes` and `mem.cached_bytes`  |
| `mem.shared_bytes`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type  | 
| `mem.total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type  | 
| `mem.used_bytes`<br/>`DGAUGE`, bytes | Amount of RAM currently used by running processes  | 

## Network metrics {#managed-clickhouse-net-metrics}
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

## Service metrics {#managed-clickhouse-metrics}
#### System event metrics {#managed-clickhouse-system-events-metrics}
These are {{ CH }} native metrics from the [system.events]({{ ch.docs }}/operations/system-tables/events) table.
For each metric, the increment (`inc`) and rate of change (`rate`) per unit of time are calculated.

| Name<br/>Type |
| ----- |
| `ch_system_events_ArenaAllocBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ArenaAllocBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_ArenaAllocChunks_inc`<br/>`DGAUGE` |
| `ch_system_events_ArenaAllocChunks_rate`<br/>`DGAUGE` |
| `ch_system_events_BackgroundLoadingMarksTasks_inc`<br/>`DGAUGE` |
| `ch_system_events_BackgroundLoadingMarksTasks_rate`<br/>`DGAUGE` |
| `ch_system_events_CreatedHTTPConnections_inc`<br/>`DGAUGE` |
| `ch_system_events_CreatedHTTPConnections_rate`<br/>`DGAUGE` |
| `ch_system_events_CompileExpressionsBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_CompileExpressionsBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_CompileExpressionsMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_CompileExpressionsMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_CompileFunction_inc`<br/>`DGAUGE` |
| `ch_system_events_CompileFunction_rate`<br/>`DGAUGE` |
| `ch_system_events_CompressedReadBufferBlocks_inc`<br/>`DGAUGE` |
| `ch_system_events_CompressedReadBufferBlocks_rate`<br/>`DGAUGE` |
| `ch_system_events_CompressedReadBufferBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_CompressedReadBufferBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_ContextLock_inc`<br/>`DGAUGE` |
| `ch_system_events_ContextLock_rate`<br/>`DGAUGE` |
| `ch_system_events_ContextLockWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_ContextLockWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_CreatedReadBufferOrdinary_inc`<br/>`DGAUGE` |
| `ch_system_events_CreatedReadBufferOrdinary_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskReadElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskReadElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskS3DeleteObjects_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskS3DeleteObjects_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskS3GetObject_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskS3GetObject_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskS3PutObject_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskS3PutObject_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskS3ReadMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskS3ReadMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskS3ReadRequestsCount_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskS3ReadRequestsCount_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskS3WriteMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskS3WriteMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskS3WriteRequestsCount_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskS3WriteRequestsCount_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskWriteElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskWriteElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_FailedInsertQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_FailedInsertQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_FailedQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_FailedQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_FailedSelectQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_FailedSelectQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_FileOpen_inc`<br/>`DGAUGE` |
| `ch_system_events_FileOpen_rate`<br/>`DGAUGE` |
| `ch_system_events_FileSync_inc`<br/>`DGAUGE` |
| `ch_system_events_FileSync_rate`<br/>`DGAUGE` |
| `ch_system_events_FileSyncElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_FileSyncElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_FunctionExecute_inc`<br/>`DGAUGE` |
| `ch_system_events_FunctionExecute_rate`<br/>`DGAUGE` |
| `ch_system_events_HardPageFaults_inc`<br/>`DGAUGE` |
| `ch_system_events_HardPageFaults_rate`<br/>`DGAUGE` |
| `ch_system_events_IOBufferAllocBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_IOBufferAllocBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_IOBufferAllocs_inc`<br/>`DGAUGE` |
| `ch_system_events_IOBufferAllocs_rate`<br/>`DGAUGE` |
| `ch_system_events_LoadedMarksCount_inc`<br/>`DGAUGE` |
| `ch_system_events_LoadedMarksCount_rate`<br/>`DGAUGE` |
| `ch_system_events_LoadedMarksMemoryBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_LoadedMarksMemoryBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_LogDebug_inc`<br/>`DGAUGE` |
| `ch_system_events_LogDebug_rate`<br/>`DGAUGE` |
| `ch_system_events_LogError_inc`<br/>`DGAUGE` |
| `ch_system_events_LogError_rate`<br/>`DGAUGE` |
| `ch_system_events_LogInfo_inc`<br/>`DGAUGE` |
| `ch_system_events_LogInfo_rate`<br/>`DGAUGE` |
| `ch_system_events_LogWarning_inc`<br/>`DGAUGE` |
| `ch_system_events_LogWarning_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertQueryTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertQueryTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertedCompactParts_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertedCompactParts_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertedRows_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertedRows_rate`<br/>`DGAUGE` |
| `ch_system_events_MainConfigLoads_inc`<br/>`DGAUGE` |
| `ch_system_events_MainConfigLoads_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterBlocksAlreadySorted_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterBlocksAlreadySorted_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterBlocks_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterBlocks_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterCompressedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterCompressedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterRows_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterRows_rate`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterUncompressedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_MergeTreeDataWriterUncompressedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_Merge_inc`<br/>`DGAUGE` |
| `ch_system_events_Merge_rate`<br/>`DGAUGE` |
| `ch_system_events_MergedIntoCompactParts_inc`<br/>`DGAUGE` |
| `ch_system_events_MergedIntoCompactParts_rate`<br/>`DGAUGE` |
| `ch_system_events_MergedRows_inc`<br/>`DGAUGE` |
| `ch_system_events_MergedRows_rate`<br/>`DGAUGE` |
| `ch_system_events_MergedUncompressedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_MergedUncompressedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_MergesTimeMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_MergesTimeMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_NetworkReceiveBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_NetworkReceiveBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_NetworkReceiveElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_NetworkReceiveElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_NetworkSendBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_NetworkSendBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_NetworkSendElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_NetworkSendElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_OSCPUVirtualTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_OSCPUVirtualTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_OSCPUWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_OSCPUWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_OSIOWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_OSIOWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_OSReadBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_OSReadBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_OSReadChars_inc`<br/>`DGAUGE` |
| `ch_system_events_OSReadChars_rate`<br/>`DGAUGE` |
| `ch_system_events_OSWriteBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_OSWriteBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_OSWriteChars_inc`<br/>`DGAUGE` |
| `ch_system_events_OSWriteChars_rate`<br/>`DGAUGE` |
| `ch_system_events_OtherQueryTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_OtherQueryTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_PartsLockHoldMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_PartsLockHoldMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_PartsLockWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_PartsLockWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_QueriesWithSubqueries_inc`<br/>`DGAUGE` |
| `ch_system_events_QueriesWithSubqueries_rate`<br/>`DGAUGE` |
| `ch_system_events_OpenedFileCacheHits_inc`<br/>`DGAUGE` |
| `ch_system_events_OpenedFileCacheHits_rate`<br/>`DGAUGE` |
| `ch_system_events_OpenedFileCacheMisses_inc`<br/>`DGAUGE` |
| `ch_system_events_OpenedFileCacheMisses_rate`<br/>`DGAUGE` |
| `ch_system_events_QueryProfilerRuns_inc`<br/>`DGAUGE` |
| `ch_system_events_QueryProfilerRuns_rate`<br/>`DGAUGE` |
| `ch_system_events_QueryTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_QueryTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_Query_inc`<br/>`DGAUGE` |
| `ch_system_events_Query_rate`<br/>`DGAUGE` |
| `ch_system_events_RWLockAcquiredReadLocks_inc`<br/>`DGAUGE` |
| `ch_system_events_RWLockAcquiredReadLocks_rate`<br/>`DGAUGE` |
| `ch_system_events_RWLockReadersWaitMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_RWLockReadersWaitMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_S3DeleteObjects_inc`<br/>`DGAUGE` |
| `ch_system_events_S3DeleteObjects_rate`<br/>`DGAUGE` |
| `ch_system_events_S3GetObject_inc`<br/>`DGAUGE` |
| `ch_system_events_S3GetObject_rate`<br/>`DGAUGE` |
| `ch_system_events_S3PutObject_inc`<br/>`DGAUGE` |
| `ch_system_events_S3PutObject_rate`<br/>`DGAUGE` |
| `ch_system_events_S3ReadMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_S3ReadMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_S3ReadRequestsCount_inc`<br/>`DGAUGE` |
| `ch_system_events_S3ReadRequestsCount_rate`<br/>`DGAUGE` |
| `ch_system_events_S3WriteMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_S3WriteMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_S3WriteRequestsCount_inc`<br/>`DGAUGE` |
| `ch_system_events_S3WriteRequestsCount_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromFileDescriptorReadBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromFileDescriptorReadBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromS3Bytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromS3Bytes_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromS3InitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromS3InitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromS3Microseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromS3Microseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromS3PreservedSessions_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromS3PreservedSessions_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromFileDescriptorRead_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromFileDescriptorRead_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadCompressedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadCompressedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_RealTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_RealTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_RegexpCreated_inc`<br/>`DGAUGE` |
| `ch_system_events_RegexpCreated_rate`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSBuffers_inc`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSBuffers_rate`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSSeeks_inc`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSSeeks_rate`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSSeeksWithReset_inc`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSSeeksWithReset_rate`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSUnprefetchedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSUnprefetchedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSUnprefetchedReads_inc`<br/>`DGAUGE` |
| `ch_system_events_RemoteFSUnprefetchedReads_rate`<br/>`DGAUGE` |
| `ch_system_events_Seek_inc`<br/>`DGAUGE` |
| `ch_system_events_Seek_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectQueryTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectQueryTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ServerStartupMilliseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_ServerStartupMilliseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedRows_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedRows_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectQueriesWithSubqueries_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectQueriesWithSubqueries_rate`<br/>`DGAUGE` |
| `ch_system_events_SoftPageFaults_inc`<br/>`DGAUGE` |
| `ch_system_events_SoftPageFaults_rate`<br/>`DGAUGE` |
| `ch_system_events_SynchronousRemoteReadWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_SynchronousRemoteReadWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_SystemTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_SystemTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_UserTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_UserTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_WaitMarksLoadMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_WaitMarksLoadMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromFileDescriptorWrite_inc`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromFileDescriptorWrite_rate`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromFileDescriptorWriteBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromFileDescriptorWriteBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromS3Bytes_inc`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromS3Bytes_rate`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromS3Microseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromS3Microseconds_rate`<br/>`DGAUGE` |

#### Current event metrics {#managed-clickhouse-system-metrics}
These are {{ CH }} native metrics from the [system.metrics]({{ ch.docs }}/operations/system-tables/metrics/) table.

| Name<br/>Type |
| ----- |
| `ch_system_metrics_ActiveTimersInQueryProfiler`<br/>`DGAUGE` |
| `ch_system_metrics_AggregatorThreads`<br/>`DGAUGE` |
| `ch_system_metrics_AggregatorThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_AsynchronousInsertThreads`<br/>`DGAUGE` |
| `ch_system_metrics_AsynchronousInsertThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_AsynchronousReadWait`<br/>`DGAUGE` |
| `ch_system_metrics_AsyncInsertCacheSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundBufferFlushSchedulePoolSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundBufferFlushSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundCommonPoolSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundCommonPoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundDistributedSchedulePoolSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundDistributedSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundFetchesPoolSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundFetchesPoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMergesAndMutationsPoolSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMergesAndMutationsPoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMessageBrokerSchedulePoolSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMessageBrokerSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMovePoolSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMovePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundSchedulePoolSize`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackupsIOThreads`<br/>`DGAUGE` |
| `ch_system_metrics_BackupsIOThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_BackupsThreads`<br/>`DGAUGE` |
| `ch_system_metrics_BackupsThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_BrokenDistributedFilesToInsert`<br/>`DGAUGE` |
| `ch_system_metrics_BrokenDistributedFilesToInsert`<br/>`DGAUGE` |
| `ch_system_metrics_CacheDetachedFileSegments`<br/>`DGAUGE` |
| `ch_system_metrics_CacheDictionaryThreads`<br/>`DGAUGE` |
| `ch_system_metrics_CacheDictionaryThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_CacheDictionaryUpdateQueueBatches`<br/>`DGAUGE` |
| `ch_system_metrics_CacheDictionaryUpdateQueueKeys`<br/>`DGAUGE` |
| `ch_system_metrics_CacheFileSegments`<br/>`DGAUGE` |
| `ch_system_metrics_Connection`<br/>`DGAUGE` |
| `ch_system_metrics_ContextLockWait`<br/>`DGAUGE` |
| `ch_system_metrics_CreatedTimersInQueryProfiler`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseCatalogThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseCatalogThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseOnDiskThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseOnDiskThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseOrdinaryThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DatabaseOrdinaryThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DDLWorkerThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DDLWorkerThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DelayedInserts`<br/>`DGAUGE` |
| `ch_system_metrics_DestroyAggregatesThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DestroyAggregatesThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DictCacheRequests`<br/>`DGAUGE` |
| `ch_system_metrics_DiskObjectStorageAsyncThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DiskObjectStorageAsyncThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DiskSpaceReservedForMerge`<br/>`DGAUGE` |
| `ch_system_metrics_DistributedBytesToInsert`<br/>`DGAUGE` |
| `ch_system_metrics_DistributedFilesToInsert`<br/>`DGAUGE` |
| `ch_system_metrics_DistributedInsertThreads`<br/>`DGAUGE` |
| `ch_system_metrics_DistributedInsertThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_DistributedSend`<br/>`DGAUGE` |
| `ch_system_metrics_EphemeralNode`<br/>`DGAUGE` |
| `ch_system_metrics_FilesystemCacheDelayedCleanupElements`<br/>`DGAUGE` |
| `ch_system_metrics_FilesystemCacheDownloadQueueElements`<br/>`DGAUGE` |
| `ch_system_metrics_FilesystemCacheElements`<br/>`DGAUGE` |
| `ch_system_metrics_FilesystemCacheReadBuffers`<br/>`DGAUGE` |
| `ch_system_metrics_FilesystemCacheSize`<br/>`DGAUGE` |
| `ch_system_metrics_FilesystemCacheSizeLimit`<br/>`DGAUGE` |
| `ch_system_metrics_GlobalThread`<br/>`DGAUGE` |
| `ch_system_metrics_GlobalThreadActive`<br/>`DGAUGE` |
| `ch_system_metrics_HashedDictionaryThreads`<br/>`DGAUGE` |
| `ch_system_metrics_HashedDictionaryThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_HTTPConnection`<br/>`DGAUGE` |
| `ch_system_metrics_IDiskCopierThreads`<br/>`DGAUGE` |
| `ch_system_metrics_IDiskCopierThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_InterserverConnection`<br/>`DGAUGE` |
| `ch_system_metrics_IOPrefetchThreads`<br/>`DGAUGE` |
| `ch_system_metrics_IOPrefetchThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_IOThreads`<br/>`DGAUGE` |
| `ch_system_metrics_IOThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_IOUringInFlightEvents`<br/>`DGAUGE` |
| `ch_system_metrics_IOUringPendingEvents`<br/>`DGAUGE` |
| `ch_system_metrics_IOWriterThreads`<br/>`DGAUGE` |
| `ch_system_metrics_IOWriterThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_KafkaAssignedPartitions`<br/>`DGAUGE` |
| `ch_system_metrics_KafkaBackgroundReads`<br/>`DGAUGE` |
| `ch_system_metrics_KafkaConsumers`<br/>`DGAUGE` |
| `ch_system_metrics_KafkaConsumersInUse`<br/>`DGAUGE` |
| `ch_system_metrics_KafkaConsumersWithAssignment`<br/>`DGAUGE` |
| `ch_system_metrics_KafkaLibrdkafkaThreads`<br/>`DGAUGE` |
| `ch_system_metrics_KafkaProducers`<br/>`DGAUGE` |
| `ch_system_metrics_KafkaWrites`<br/>`DGAUGE` |
| `ch_system_metrics_KeeperAliveConnections`<br/>`DGAUGE` |
| `ch_system_metrics_KeeperOutstandingRequets`<br/>`DGAUGE` |
| `ch_system_metrics_LocalThread`<br/>`DGAUGE` |
| `ch_system_metrics_LocalThreadActive`<br/>`DGAUGE` |
| `ch_system_metrics_MarksLoaderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_MarksLoaderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_MaxDDLEntryID`<br/>`DGAUGE` |
| `ch_system_metrics_MaxPushedDDLEntryID`<br/>`DGAUGE` |
| `ch_system_metrics_MemoryTracking`<br/>`DGAUGE` |
| `ch_system_metrics_Merge`<br/>`DGAUGE` |
| `ch_system_metrics_MergesMutationsMemoryTracking`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeAllRangesAnnouncementsSent`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeBackgroundExecutorThreads`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeBackgroundExecutorThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeDataSelectExecutorThreads`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeDataSelectExecutorThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeOutdatedPartsLoaderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeOutdatedPartsLoaderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreePartsCleanerThreads`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreePartsCleanerThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreePartsLoaderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreePartsLoaderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_MergeTreeReadTaskRequestsSent`<br/>`DGAUGE` |
| `ch_system_metrics_MMappedAllocBytes`<br/>`DGAUGE` |
| `ch_system_metrics_MMappedAllocs`<br/>`DGAUGE` |
| `ch_system_metrics_MMappedFileBytes`<br/>`DGAUGE` |
| `ch_system_metrics_MMappedFiles`<br/>`DGAUGE` |
| `ch_system_metrics_Move`<br/>`DGAUGE` |
| `ch_system_metrics_MySQLConnection`<br/>`DGAUGE` |
| `ch_system_metrics_NetworkReceive`<br/>`DGAUGE` |
| `ch_system_metrics_NetworkSend`<br/>`DGAUGE` |
| `ch_system_metrics_ObjectStorageAzureThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ObjectStorageAzureThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ObjectStorageS3Threads`<br/>`DGAUGE` |
| `ch_system_metrics_ObjectStorageS3ThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_OpenFileForRead`<br/>`DGAUGE` |
| `ch_system_metrics_OpenFileForWrite`<br/>`DGAUGE` |
| `ch_system_metrics_OutdatedPartsLoadingThreads`<br/>`DGAUGE` |
| `ch_system_metrics_OutdatedPartsLoadingThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ParallelFormattingOutputFormatThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ParallelFormattingOutputFormatThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ParallelParsingInputFormatThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ParallelParsingInputFormatThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ParquetDecoderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ParquetDecoderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ParquetEncoderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ParquetEncoderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_PartMutation`<br/>`DGAUGE` |
| `ch_system_metrics_PartsActive`<br/>`DGAUGE` |
| `ch_system_metrics_PartsCommitted`<br/>`DGAUGE` |
| `ch_system_metrics_PartsCompact`<br/>`DGAUGE` |
| `ch_system_metrics_PartsDeleteOnDestroy`<br/>`DGAUGE` |
| `ch_system_metrics_PartsDeleting`<br/>`DGAUGE` |
| `ch_system_metrics_PartsInMemory`<br/>`DGAUGE` |
| `ch_system_metrics_PartsOutdated`<br/>`DGAUGE` |
| `ch_system_metrics_PartsPreActive`<br/>`DGAUGE` |
| `ch_system_metrics_PartsPreCommitted`<br/>`DGAUGE` |
| `ch_system_metrics_PartsTemporary`<br/>`DGAUGE` |
| `ch_system_metrics_PartsWide`<br/>`DGAUGE` |
| `ch_system_metrics_PendingAsyncInsert`<br/>`DGAUGE` |
| `ch_system_metrics_PostgreSQLConnection`<br/>`DGAUGE` |
| `ch_system_metrics_Query`<br/>`DGAUGE` |
| `ch_system_metrics_QueryPipelineExecutorThreads`<br/>`DGAUGE` |
| `ch_system_metrics_QueryPipelineExecutorThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_QueryPreempted`<br/>`DGAUGE` |
| `ch_system_metrics_QueryThread`<br/>`DGAUGE` |
| `ch_system_metrics_Read`<br/>`DGAUGE` |
| `ch_system_metrics_ReadonlyReplica`<br/>`DGAUGE` |
| `ch_system_metrics_ReadTaskRequestsSent`<br/>`DGAUGE` |
| `ch_system_metrics_RemoteRead`<br/>`DGAUGE` |
| `ch_system_metrics_ReplicatedChecks`<br/>`DGAUGE` |
| `ch_system_metrics_ReplicatedFetch`<br/>`DGAUGE` |
| `ch_system_metrics_ReplicatedSend`<br/>`DGAUGE` |
| `ch_system_metrics_RestartReplicaThreads`<br/>`DGAUGE` |
| `ch_system_metrics_RestartReplicaThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_RestoreThreads`<br/>`DGAUGE` |
| `ch_system_metrics_RestoreThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_Revision`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockActiveReaders`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockActiveTotal`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockActiveWriters`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockWaitingReaders`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockWaitingTotal`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockWaitingWriters`<br/>`DGAUGE` |
| `ch_system_metrics_S3Requests`<br/>`DGAUGE` |
| `ch_system_metrics_SendExternalTables`<br/>`DGAUGE` |
| `ch_system_metrics_SendScalars`<br/>`DGAUGE` |
| `ch_system_metrics_StartupSystemTablesThreads`<br/>`DGAUGE` |
| `ch_system_metrics_StartupSystemTablesThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_StorageBufferBytes`<br/>`DGAUGE` |
| `ch_system_metrics_StorageBufferRows`<br/>`DGAUGE` |
| `ch_system_metrics_StorageDistributedThreads`<br/>`DGAUGE` |
| `ch_system_metrics_StorageDistributedThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_StorageHiveThreads`<br/>`DGAUGE` |
| `ch_system_metrics_StorageHiveThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_StorageS3Threads`<br/>`DGAUGE` |
| `ch_system_metrics_StorageS3ThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_SystemReplicasThreads`<br/>`DGAUGE` |
| `ch_system_metrics_SystemReplicasThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_TablesLoaderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_TablesLoaderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_TablesToDropQueueSize`<br/>`DGAUGE` |
| `ch_system_metrics_TCPConnection`<br/>`DGAUGE` |
| `ch_system_metrics_TemporaryFilesForAggregation`<br/>`DGAUGE` |
| `ch_system_metrics_TemporaryFilesForJoin`<br/>`DGAUGE` |
| `ch_system_metrics_TemporaryFilesForSort`<br/>`DGAUGE` |
| `ch_system_metrics_TemporaryFilesUnknown`<br/>`DGAUGE` |
| `ch_system_metrics_ThreadPoolFSReaderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ThreadPoolFSReaderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ThreadPoolRemoteFSReaderThreads`<br/>`DGAUGE` |
| `ch_system_metrics_ThreadPoolRemoteFSReaderThreadsActive`<br/>`DGAUGE` |
| `ch_system_metrics_ThreadsInOvercommitTracker`<br/>`DGAUGE` |
| `ch_system_metrics_TotalTemporaryFiles`<br/>`DGAUGE` |
| `ch_system_metrics_VersionInteger`<br/>`DGAUGE` |
| `ch_system_metrics_Write`<br/>`DGAUGE` |
| `ch_system_metrics_ZooKeeperRequest`<br/>`DGAUGE` |
| `ch_system_metrics_ZooKeeperSession`<br/>`DGAUGE` |
| `ch_system_metrics_ZooKeeperWatch`<br/>`DGAUGE` |

#### Query queue metrics {#managed-clickhouse-query-log-metrics}
These are {{ CH }} native metrics from the [system.query_log]({{ ch.docs }}/operations/system-tables/query_log) table.
For each metric, the increment per unit of time (second) is calculated.

| Name<br/>Type |
| ----- |
| `ch_system_query_log_insert_requests_inc`<br/>`DGAUGE` | |
| `ch_system_query_log_read_bytes_inc`<br/>`DGAUGE` | |
| `ch_system_query_log_read_rows_inc`<br/>`DGAUGE` | |
| `ch_system_query_log_requests_inc`<br/>`DGAUGE` | |
| `ch_system_query_log_result_bytes_inc`<br/>`DGAUGE` | |
| `ch_system_query_log_result_rows_inc`<br/>`DGAUGE` | |
| `ch_system_query_log_select_requests_inc`<br/>`DGAUGE` | |
| `ch_system_query_log_written_bytes_inc`<br/>`DGAUGE` | |
| `ch_system_query_log_written_rows_inc`<br/>`DGAUGE` | |

#### Replication metrics {#managed-clickhouse-replication-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `ch_replication-future_parts`<br/>`DGAUGE`, count | Number of data parts after the `MERGE` and `INSERT` operations| 
| `ch_replication-inserts_in_queue`<br/>`DGAUGE`, count | Number of data parts enqueued for insert | 
| `ch_replication-is_alive`<br/>`DGAUGE`, 0/1 | Replication performance indicator.<br/>It can be either `1` if DB replication is alive or `0` if it is not. | 
| `ch_replication-max_absolute_delay`<br/>`DGAUGE`, seconds | Maximum replication delay | 
| `ch_replication-merges_in_queue`<br/>`DGAUGE`, count | Merges enqueued | 
| `ch_replication-parts_to_check`<br/>`DGAUGE`, count | Number of data parts to check | 
| `ch_replication-queue_size`<br/>`DGAUGE`, count | Merge and insert queue size | 
| `ch_replication-tables`<br/>`DGAUGE`, count | Number of replicated tables |

#### System metrics {#managed-clickhouse-config-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `ch_config_merge_tree_parts_to_throw_insert`<br/>`DGAUGE`, count | Threshold for active table data parts, which, when surpassed, causes {{ CH }} to throw a `Too many parts ...` exception. It is specified in the [settings](../../../managed-clickhouse/concepts/settings-list.md#setting-merge-tree). It makes sense to analyze it along with the `ch_system_async_metrics_MaxPartCountForPartition` metric. |
| `ch_local_disk_parts_size`<br/>`DGAUGE`, bytes | Local disk partition size |
| `ch_system_async_metrics_MaxPartCountForPartition`<br/>`DGAUGE`, count | Maximum number of data parts per partition | 
| `ch_system_async_metrics_NumberOfDatabases`<br/>`DGAUGE`, count | Total databases on the server |
| `ch_system_async_metrics_NumberOfTables`<br/>`DGAUGE`, count | Total tables across all databases on the server, excluding those DBs that cannot contain MergeTree tables. Excluded database engines are those that generate tables dynamically, such as Lazy, {{ MY }}, {{ PG }}, and SQLite. |
| `ch_system_async_metrics_NumberOfTablesSystem`<br/>`DGAUGE`, count | Total system database tables stored as MergeTree tables on the server |
| `ch_system_async_metrics_ReplicasMaxAbsoluteDelay`<br/>`DGAUGE`, seconds | Maximum replication delay | 
| `ch_system_async_metrics_ReplicasMaxInsertsInQueue`<br/>`DGAUGE`, count | Maximum number of queued `INSERT` operations (to replicate) in replicated tables | 
| `ch_system_async_metrics_ReplicasMaxMergesInQueue`<br/>`DGAUGE`, count | Maximum number of queued merge operations (to apply) for replicated tables | 
| `ch_system_async_metrics_ReplicasMaxQueueSize`<br/>`DGAUGE`, count | Maximum replication queue size |
| `ch_system_async_metrics_ReplicasMaxRelativeDelay`<br/>`DGAUGE`, seconds | Maximum lag difference between a replica and the most delayed replica of the same table across replicated tables | 
| `ch_system_async_metrics_ReplicasSumInsertsInQueue`<br/>`DGAUGE`, count | Total queued `INSERT` operations (to replicate) across replicated tables | 
| `ch_system_async_metrics_ReplicasSumMergesInQueue`<br/>`DGAUGE`, count | Total queued `MERGE` operations (to apply) across replicated tables | 
| `ch_system_async_metrics_ReplicasSumQueueSize`<br/>`DGAUGE`, bytes | Total queued operations, e.g., `FETCH` and `MERGE`, across replicated tables | 
| `ch_system_async_metrics_TotalBytesOfMergeTreeTables`<br/>`DGAUGE`, bytes | Total compressed bytes (including data and indexes) across all MergeTree tables | 
| `ch_system_async_metrics_TotalBytesOfMergeTreeTablesSystem`<br/>`DGAUGE`, bytes | Total compressed bytes (including data and indexes) in MergeTree tables within the system database | 
| `ch_system_async_metrics_TotalPartsOfMergeTreeTables`<br/>`DGAUGE`, count | Total data parts across all MergeTree tables. Counts above 10,000 will adversely affect server startup time and may indicate a bad choice of partition key. | 
| `ch_system_async_metrics_TotalPartsOfMergeTreeTablesSystem`<br/>`DGAUGE`, count | Total data parts in MergeTree tables within the system database | 
| `ch_system_async_metrics_TotalRowsOfMergeTreeTables`<br/>`DGAUGE`, count | Total rows (entries) across all MergeTree tables | 
| `ch_system_async_metrics_TotalRowsOfMergeTreeTablesSystem`<br/>`DGAUGE`, count | Total rows (records) in MergeTree tables within the system database | 
| `ch_system_async_metrics_Uptime`<br/>`DGAUGE`, seconds | Server uptime (in seconds), which includes the time used to initialize the server before it starts accepting connections. | 

## Other metrics {#managed-clickhouse-other-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Read access indicator.<br/>It can be either `1` if a cluster is available for reads or `0` if it is not. | 
| `can_write`<br/>`DGAUGE`, 0/1 | Write access indicator.<br/>It can be either `1` if a cluster is available for writes or `0` if it is not. | 
| `is_alive`<br/>`DGAUGE`, 0/1 | Host health indicator.<br/>It can be either `1` if a DB host is healthy or `0` if it is not. |