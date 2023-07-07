## Service: {{ mch-full-name }} {#managed-clickhouse}

Common labels for all {{ mch-full-name }} service metrics:

| Label | Value |
----|----
| service | Service ID: `managed-clickhouse` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster ID |
| host | Host FQDN |
| node | Host type: `replica`, `follower`, or `leader` |
| subcluster_name | Subcluster type: `clickhouse_subcluster`, `zookeeper_subcluster` |
| shard | Shard ID |

### CPU metrics {#managed-clickhouse-cpu-metrics}
The load on processor cores.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `cpu.fraction`<br/>`DGAUGE`, % | Guaranteed vCPU performance. |
| `cpu.guarantee`<br/>`DGAUGE`, pcs | Guaranteed number of cores. |
| `cpu.limit`<br/>`DGAUGE`, pcs | Limit on CPUs in use. |
| `cpu.guest`<br/>`DGAUGE`, % | CPU usage, `guest` usage type. |
| `cpu.idle`<br/>`DGAUGE`, % | CPU usage, `idle` usage type. |
| `cpu.iowait`<br/>`DGAUGE`, % | CPU usage, `iowait` usage type. |
| `cpu.irq`<br/>`DGAUGE`, % | CPU usage, `irq` usage type. |
| `cpu.nice`<br/>`DGAUGE`, % | CPU usage, `nice` usage type. |
| `cpu.softirq`<br/>`DGAUGE`, % | CPU usage, `softirq` usage type. |
| `cpu.steal`<br/>`DGAUGE`, % | CPU usage, `steal` usage type. |
| `cpu.system`<br/>`DGAUGE`, % | CPU usage, `system` usage type. |
| `cpu.user`<br/>`DGAUGE`, % | CPU usage, `user` usage type. |
| `load.avg_15min`<br/>`DGAUGE`, % | Average load in 15 minutes. |
| `load.avg_1min`<br/>`DGAUGE`, % | Average load per 1 minute. |
| `load.avg_5min`<br/>`DGAUGE`, % | Average load in 5 minutes. |

### Disk metrics {#managed-clickhouse-disk-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, bytes | Free space. |
| `disk.free_inodes`<br/>`DGAUGE`, pcs | Number of free inodes. |
| `disk.total_bytes`<br/>`DGAUGE`, bytes | Available space. |
| `disk.total_inodes`<br/>`DGAUGE`, pcs | Available inodes. |
| `disk.used_bytes`<br/>`DGAUGE`, bytes | Used space. |
| `disk.used_inodes`<br/>`DGAUGE`, pcs | Used inodes. |

### Disk operation metrics {#managed-clickhouse-diskio-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `io.avg_read_time`<br/>`DGAUGE`, ms | Average disk read time. |
| `io.avg_write_time`<br/>`DGAUGE`, ms | Average disk write time. |
| `io.disk*.avg_read_time`<br/>`DGAUGE`, ms | Average read time for a specific disk. |
| `io.disk*.avg_write_time`<br/>`DGAUGE`, ms | Average write time for a specific disk. |
| `io.disk*.read_bytes`<br/>`DGAUGE`, bytes per second | Read speed for a specific disk. |
| `io.disk*.read_count`<br/>`DGAUGE`, operations per second | Read operations per second for a specific disk. |
| `io.disk*.read_merged_count`<br/>`DGAUGE`, operations per second | Merged read operations per second for a specific disk. |
| `io.disk*.utilization`<br/>`DGAUGE`, % | Utilization of a specific disk. |
| `io.disk*.write_bytes`<br/>`DGAUGE`, bytes per second | Write speed for a specific disk. |
| `io.disk*.write_count`<br/>`DGAUGE`, operations per second | Number of write operations per second for a specific disk. |
| `io.disk*.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second for a specific disk. |
| `io.read_bytes`<br/>`DGAUGE`, bytes per second | Disk read speed. |
| `io.read_count`<br/>`DGAUGE`, operations per second | Number of read operations per second. |
| `io.read_merged_count`<br/>`DGAUGE`, operations per second | Number of merged read operations per second. |
| `io.utilization`<br/>`DGAUGE`, % | Disk utilization. |
| `io.write_bytes`<br/>`DGAUGE`, bytes per second | Disk write speed. |
| `io.write_count`<br/>`DGAUGE`, operations per second | Number of write operations per second. |
| `io.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second. |

### RAM metrics {#managed-clickhouse-ram-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.guarantee_bytes`<br/>`DGAUGE`, bytes | Guaranteed memory. |
| `mem.limit_bytes`<br/>`DGAUGE`, bytes | Memory limit. |
| `mem.active_bytes`<br/>`DGAUGE`, bytes | RAM usage, `active` usage type. |
| `mem.available_bytes`<br/>`DGAUGE`, bytes | RAM usage, `available` usage type. |
| `mem.buffers_bytes`<br/>`DGAUGE`, bytes | RAM usage, `buffers` usage type. |
| `mem.cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type. |
| `mem.free_bytes`<br/>`DGAUGE`, bytes | RAM usage, `free` usage type. |
| `mem.shared_bytes`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type. |
| `mem.total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type. |
| `mem.used_bytes`<br/>`DGAUGE`, bytes | RAM usage, `used` usage type. |

### Network metrics {#managed-clickhouse-net-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, bytes per second | Rate of receiving data over the network. |
| `net.bytes_sent`<br/>`DGAUGE`, bytes per second | Rate of sending data over the network. |
| `net.dropin`<br/>`DGAUGE`, pcs | Packets dropped upon receipt. |
| `net.dropout`<br/>`DGAUGE`, pcs | Packets dropped when being sent. |
| `net.errin`<br/>`DGAUGE`, pcs | Number of errors upon receipt. |
| `net.errout`<br/>`DGAUGE`, pcs | Number of errors at sending. |
| `net.packets_recv`<br/>`DGAUGE`, packets per second | Rate of receiving packets over the network. |
| `net.packets_sent`<br/>`DGAUGE`, packets per second | Rate of sending packets over the network. |

### Service metrics {#managed-clickhouse-metrics}
##### System event metrics {#managed-clickhouse-system-events-metrics}
Clickhouse native metrics from the [system.events]({{ ch.docs }}/operations/system-tables/events) table.
For each metric, the increment (`inc`) and change `rate` per unit of time are calculated.

| Name<br/>Type |
| ----- |
| `ch_system_events_ArenaAllocBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ArenaAllocBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_ArenaAllocChunks_inc`<br/>`DGAUGE` |
| `ch_system_events_ArenaAllocChunks_rate`<br/>`DGAUGE` |
| `ch_system_events_CannotWriteToWriteBufferDiscard_inc`<br/>`DGAUGE` |
| `ch_system_events_CannotWriteToWriteBufferDiscard_rate`<br/>`DGAUGE` |
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
| `ch_system_events_CreatedHTTPConnections_inc`<br/>`DGAUGE` |
| `ch_system_events_CreatedHTTPConnections_rate`<br/>`DGAUGE` |
| `ch_system_events_CreatedLogEntryForMerge_inc`<br/>`DGAUGE` |
| `ch_system_events_CreatedLogEntryForMerge_rate`<br/>`DGAUGE` |
| `ch_system_events_CreatedReadBufferOrdinary_inc`<br/>`DGAUGE` |
| `ch_system_events_CreatedReadBufferOrdinary_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskReadElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskReadElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_DiskWriteElapsedMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_DiskWriteElapsedMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_DuplicatedInsertedBlocks_inc`<br/>`DGAUGE` |
| `ch_system_events_DuplicatedInsertedBlocks_rate`<br/>`DGAUGE` |
| `ch_system_events_FailedQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_FailedQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_FailedSelectQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_FailedSelectQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_FileOpen_inc`<br/>`DGAUGE` |
| `ch_system_events_FileOpen_rate`<br/>`DGAUGE` |
| `ch_system_events_FunctionExecute_inc`<br/>`DGAUGE` |
| `ch_system_events_FunctionExecute_rate`<br/>`DGAUGE` |
| `ch_system_events_IOBufferAllocBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_IOBufferAllocBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_IOBufferAllocs_inc`<br/>`DGAUGE` |
| `ch_system_events_IOBufferAllocs_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertQueryTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertQueryTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_InsertedRows_inc`<br/>`DGAUGE` |
| `ch_system_events_InsertedRows_rate`<br/>`DGAUGE` |
| `ch_system_events_MainConfigLoads_inc`<br/>`DGAUGE` |
| `ch_system_events_MainConfigLoads_rate`<br/>`DGAUGE` |
| `ch_system_events_MarkCacheHits_inc`<br/>`DGAUGE` |
| `ch_system_events_MarkCacheHits_rate`<br/>`DGAUGE` |
| `ch_system_events_MarkCacheMisses_inc`<br/>`DGAUGE` |
| `ch_system_events_MarkCacheMisses_rate`<br/>`DGAUGE` |
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
| `ch_system_events_NotCreatedLogEntryForMerge_inc`<br/>`DGAUGE` |
| `ch_system_events_NotCreatedLogEntryForMerge_rate`<br/>`DGAUGE` |
| `ch_system_events_OSCPUVirtualTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_OSCPUVirtualTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_OSCPUWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_OSCPUWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_OSIOWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_OSIOWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ObsoleteReplicatedParts_inc`<br/>`DGAUGE` |
| `ch_system_events_ObsoleteReplicatedParts_rate`<br/>`DGAUGE` |
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
| `ch_system_events_ReadBufferFromFileDescriptorReadBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromFileDescriptorReadBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromFileDescriptorRead_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadBufferFromFileDescriptorRead_rate`<br/>`DGAUGE` |
| `ch_system_events_ReadCompressedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_ReadCompressedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_RealTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_RealTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_RegexpCreated_inc`<br/>`DGAUGE` |
| `ch_system_events_RegexpCreated_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartChecksFailed_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartChecksFailed_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartChecks_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartChecks_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFailedFetches_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFailedFetches_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFetchesOfMerged_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFetchesOfMerged_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFetches_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartFetches_rate`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartMerges_inc`<br/>`DGAUGE` |
| `ch_system_events_ReplicatedPartMerges_rate`<br/>`DGAUGE` |
| `ch_system_events_ScalarSubqueriesCacheMiss_inc`<br/>`DGAUGE` |
| `ch_system_events_ScalarSubqueriesCacheMiss_rate`<br/>`DGAUGE` |
| `ch_system_events_Seek_inc`<br/>`DGAUGE` |
| `ch_system_events_Seek_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectQueryTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectQueryTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectQuery_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectQuery_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedMarks_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedMarks_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedParts_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedParts_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedRanges_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedRanges_rate`<br/>`DGAUGE` |
| `ch_system_events_SelectedRows_inc`<br/>`DGAUGE` |
| `ch_system_events_SelectedRows_rate`<br/>`DGAUGE` |
| `ch_system_events_SoftPageFaults_inc`<br/>`DGAUGE` |
| `ch_system_events_SoftPageFaults_rate`<br/>`DGAUGE` |
| `ch_system_events_SystemTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_SystemTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_UserTimeMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_UserTimeMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromFileDescriptorWriteBytes_inc`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromFileDescriptorWriteBytes_rate`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromFileDescriptorWrite_inc`<br/>`DGAUGE` |
| `ch_system_events_WriteBufferFromFileDescriptorWrite_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperBytesReceived_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperBytesReceived_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperBytesSent_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperBytesSent_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperCreate_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperCreate_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperExists_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperExists_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperGet_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperGet_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperInit_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperInit_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperList_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperList_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperMulti_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperMulti_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperRemove_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperRemove_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperSet_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperSet_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperTransactions_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperTransactions_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperUserExceptions_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperUserExceptions_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperWaitMicroseconds_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperWaitMicroseconds_rate`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperWatchResponse_inc`<br/>`DGAUGE` |
| `ch_system_events_ZooKeeperWatchResponse_rate`<br/>`DGAUGE` |

##### Current event metrics {#managed-clickhouse-system-metrics}
Clickhouse native metrics from the [system.metrics]({{ ch.docs }}/operations/system-tables/metrics/) table.

| Name<br/>Type |
| ----- |
| `ch_system_metrics_ActiveAsyncDrainedConnections`<br/>`DGAUGE` |
| `ch_system_metrics_ActiveSyncDrainedConnections`<br/>`DGAUGE` |
| `ch_system_metrics_AsyncDrainedConnections`<br/>`DGAUGE` |
| `ch_system_metrics_AsynchronousReadWait`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundBufferFlushSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundCommonPoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundDistributedSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundFetchesPoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMergesAndMutationsPoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMessageBrokerSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundMovePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BackgroundSchedulePoolTask`<br/>`DGAUGE` |
| `ch_system_metrics_BrokenDistributedFilesToInsert`<br/>`DGAUGE` |
| `ch_system_metrics_CacheDictionaryUpdateQueueBatches`<br/>`DGAUGE` |
| `ch_system_metrics_CacheDictionaryUpdateQueueKeys`<br/>`DGAUGE` |
| `ch_system_metrics_Connection`<br/>`DGAUGE` |
| `ch_system_metrics_ContextLockWait`<br/>`DGAUGE` |
| `ch_system_metrics_DelayedInserts`<br/>`DGAUGE` |
| `ch_system_metrics_DictCacheRequests`<br/>`DGAUGE` |
| `ch_system_metrics_DiskSpaceReservedForMerge`<br/>`DGAUGE` |
| `ch_system_metrics_DistributedFilesToInsert`<br/>`DGAUGE` |
| `ch_system_metrics_DistributedSend`<br/>`DGAUGE` |
| `ch_system_metrics_EphemeralNode`<br/>`DGAUGE` |
| `ch_system_metrics_GlobalThread`<br/>`DGAUGE` |
| `ch_system_metrics_GlobalThreadActive`<br/>`DGAUGE` |
| `ch_system_metrics_HTTPConnection`<br/>`DGAUGE` |
| `ch_system_metrics_InterserverConnection`<br/>`DGAUGE` |
| `ch_system_metrics_LocalThread`<br/>`DGAUGE` |
| `ch_system_metrics_LocalThreadActive`<br/>`DGAUGE` |
| `ch_system_metrics_MMappedFileBytes`<br/>`DGAUGE` |
| `ch_system_metrics_MMappedFiles`<br/>`DGAUGE` |
| `ch_system_metrics_MaxDDLEntryID`<br/>`DGAUGE` |
| `ch_system_metrics_MaxPushedDDLEntryID`<br/>`DGAUGE` |
| `ch_system_metrics_MemoryTracking`<br/>`DGAUGE` |
| `ch_system_metrics_Merge`<br/>`DGAUGE` |
| `ch_system_metrics_MySQLConnection`<br/>`DGAUGE` |
| `ch_system_metrics_NetworkReceive`<br/>`DGAUGE` |
| `ch_system_metrics_NetworkSend`<br/>`DGAUGE` |
| `ch_system_metrics_OpenFileForRead`<br/>`DGAUGE` |
| `ch_system_metrics_OpenFileForWrite`<br/>`DGAUGE` |
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
| `ch_system_metrics_QueryPreempted`<br/>`DGAUGE` |
| `ch_system_metrics_QueryThread`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockActiveReaders`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockActiveTotal`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockActiveWriters`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockWaitingReaders`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockWaitingTotal`<br/>`DGAUGE` |
| `ch_system_metrics_RWLockWaitingWriters`<br/>`DGAUGE` |
| `ch_system_metrics_Read`<br/>`DGAUGE` |
| `ch_system_metrics_ReadonlyReplica`<br/>`DGAUGE` |
| `ch_system_metrics_ReplicatedChecks`<br/>`DGAUGE` |
| `ch_system_metrics_ReplicatedFetch`<br/>`DGAUGE` |
| `ch_system_metrics_ReplicatedSend`<br/>`DGAUGE` |
| `ch_system_metrics_Revision`<br/>`DGAUGE` |
| `ch_system_metrics_SendExternalTables`<br/>`DGAUGE` |
| `ch_system_metrics_SendScalars`<br/>`DGAUGE` |
| `ch_system_metrics_StorageBufferBytes`<br/>`DGAUGE` |
| `ch_system_metrics_StorageBufferRows`<br/>`DGAUGE` |
| `ch_system_metrics_SyncDrainedConnections`<br/>`DGAUGE` |
| `ch_system_metrics_TCPConnection`<br/>`DGAUGE` |
| `ch_system_metrics_TablesToDropQueueSize`<br/>`DGAUGE` |
| `ch_system_metrics_VersionInteger`<br/>`DGAUGE` |
| `ch_system_metrics_Write`<br/>`DGAUGE` |
| `ch_system_metrics_ZooKeeperRequest`<br/>`DGAUGE` |
| `ch_system_metrics_ZooKeeperSession`<br/>`DGAUGE` |
| `ch_system_metrics_ZooKeeperWatch`<br/>`DGAUGE` |

##### Query queue metrics {#managed-clickhouse-query-log-metrics}
Clickhouse native metrics from the [system.query_log]({{ ch.docs }}/operations/system-tables/query_log) table.
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

##### Zookeeper metrics {#managed-clickhouse-zookeeper-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `zk_avg_latency`<br/>`DGAUGE`, ms | {{ ZK }} host average response delay. |
| `zk_ephemerals_count`<br/>`DGAUGE`, pcs | Number of Ephemeral nodes. |
| `zk_num_alive_connections`<br/>`DGAUGE`, pcs | Number of connections. |
| `zk_outstanding_requests`<br/>`DGAUGE`, pcs | Requests being handled. |
| `zk_watch_count`<br/>`DGAUGE`, pcs | Number of Watches. |
| `zk_znode_count`<br/>`DGAUGE`, pcs | Number of Znodes. |

##### Replication metrics {#managed-clickhouse-replication-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `ch_replication-future_parts`<br/>`DGAUGE`, pcs | Number of data parts after MERGE and INSERT operations are completed. |
| `ch_replication-inserts_in_queue`<br/>`DGAUGE`, pcs | Number of enqueued data parts to be inserted. |
| `ch_replication-is_alive`<br/>`DGAUGE`, 0/1 | Replication performance indicator.<br/>`1` if DB replication is alive, `0` if not. |
| `ch_replication-max_absolute_delay`<br/>`DGAUGE`, seconds | Maximum replication delay. |
| `ch_replication-merges_in_queue`<br/>`DGAUGE`, pcs | Merges enqueued. |
| `ch_replication-parts_to_check`<br/>`DGAUGE`, pcs | Number of data parts to be checked. |
| `ch_replication-queue_size`<br/>`DGAUGE`, pcs | Merge and insert queue size. |
| `ch_replication-tables`<br/>`DGAUGE`, pcs | Number of replicated tables. |

##### System metrics {#managed-clickhouse-config-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `ch_config_merge_tree_parts_to_throw_insert`<br/>`DGAUGE`, pcs | Threshold value of active data parts in a table. When exceeded, ClickHouse throws the `Too many parts ...` exception. Set in the [settings](../../../managed-clickhouse/concepts/settings-list.md#setting-merge-tree). It makes sense to analyze it along with the `ch_system_async_metrics_MaxPartCountForPartition` metric. |
| `ch_local_disk_parts_size`<br/>`DGAUGE`, bytes | Local disk partition size. |
| `ch_system_async_metrics_MaxPartCountForPartition`<br/>`DGAUGE`, pcs | Maximum number of data chunks in a partition. |
| `ch_system_async_metrics_ReplicasMaxAbsoluteDelay`<br/>`DGAUGE`, seconds | Maximum replication delay. |
| `ch_system_async_metrics_ReplicasMaxQueueSize`<br/>`DGAUGE`, pcs | Maximum size of the replication queue. |

### Other metrics {#managed-clickhouse-other-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `is_alive`<br/>`DGAUGE`, 0/1 | Host health indicator.<br/>`1` if a DB host is alive, `0` if not. |


Read more about the service in the [{{ mch-full-name }}](../../../managed-clickhouse/) documentation.
