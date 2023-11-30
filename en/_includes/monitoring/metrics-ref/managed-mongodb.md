## {{ mmg-full-name }} service {#managed-mongodb}

Common labels for all {{ mmg-full-name }} metrics:

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

### Disk metrics {#managed-mongodb-disk-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, bytes | Free space |
| `disk.free_inodes`<br/>`DGAUGE`, pcs | Number of free inodes |
| `disk.total_bytes`<br/>`DGAUGE`, bytes | Available space |
| `disk.total_inodes`<br/>`DGAUGE`, pcs | Available inodes |
| `disk.used_bytes`<br/>`DGAUGE`, bytes | Used space |
| `disk.used_inodes`<br/>`DGAUGE`, pcs | Used inodes |

### Disk operation metrics {#managed-mongodb-diskio-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `io.avg_read_time`<br/>`DGAUGE`, ms | Average disk read time |
| `io.avg_write_time`<br/>`DGAUGE`, ms | Average disk write time |
| `io.disk*.avg_read_time`<br/>`DGAUGE`, ms | Average read time for a specific disk |
| `io.disk*.avg_write_time`<br/>`DGAUGE`, ms | Average write time for a specific disk |
| `io.disk*.read_bytes`<br/>`DGAUGE`, bytes per second | Read speed for a specific disk |
| `io.disk*.read_count`<br/>`DGAUGE`, operations per second | Read operations per second for a specific disk |
| `io.disk*.read_merged_count`<br/>`DGAUGE`, operations per second | Merged read operations per second for a specific disk |
| `io.disk*.utilization`<br/>`DGAUGE`, % | Utilization of a specific disk; disabled for network drives |
| `io.disk*.write_bytes`<br/>`DGAUGE`, bytes per second | Write speed for a specific disk |
| `io.disk*.write_count`<br/>`DGAUGE`, operations per second | Number of write operations per second for a specific disk |
| `io.disk*.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second for a specific disk |
| `io.read_bytes`<br/>`DGAUGE`, bytes per second | Disk read speed |
| `io.read_count`<br/>`DGAUGE`, operations per second | Number of read operations per second |
| `io.read_merged_count`<br/>`DGAUGE`, operations per second | Number of merged read operations per second |
| `io.utilization`<br/>`DGAUGE`, % | Disk utilization |
| `io.write_bytes`<br/>`DGAUGE`, bytes per second | Disk write speed |
| `io.write_count`<br/>`DGAUGE`, operations per second | Number of write operations per second |
| `io.write_merged_count`<br/>`DGAUGE`, operations per second | Number of merged write operations per second |

### RAM metrics {#managed-mongodb-ram-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.guarantee_bytes`<br/>`DGAUGE`, bytes | Guaranteed memory |
| `mem.limit_bytes`<br/>`DGAUGE`, bytes | Memory limit |
| `mem.active_bytes`<br/>`DGAUGE`, bytes | Amount of RAM used most often and only freed up when absolutely necessary |
| `mem.available_bytes`<br/>`DGAUGE`, bytes | RAM usage, `available` usage type |
| `mem.buffers_bytes`<br/>`DGAUGE`, bytes | RAM usage, `buffers` usage type |
| `mem.cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type |
| `mem.free_bytes`<br/>`DGAUGE`, bytes | Amount of free RAM available, excluding `mem.buffers_bytes` and `mem.cached_bytes` |
| `mem.shared_bytes`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type |
| `mem.total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type |
| `mem.used_bytes`<br/>`DGAUGE`, bytes | Amount of RAM currently used by the running processes |

### Network metrics {#managed-mongodb-net-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, bytes per second | Rate of receiving data over the network |
| `net.bytes_sent`<br/>`DGAUGE`, bytes per second | Rate of sending data over the network |
| `net.dropin`<br/>`DGAUGE`, pcs | Packets dropped upon receipt |
| `net.dropout`<br/>`DGAUGE`, pcs | Packets dropped when being sent |
| `net.errin`<br/>`DGAUGE`, pcs | Number of errors upon receipt |
| `net.errout`<br/>`DGAUGE`, pcs | Number of errors at sending |
| `net.packets_recv`<br/>`DGAUGE`, packets per second | Rate of receiving packets over the network |
| `net.packets_sent`<br/>`DGAUGE`, packets per second | Rate of sending packets over the network |

### Service metrics {#managed-mongodb-metrics}
##### dbStats metrics {#managed-mongodb-dbstats-metrics}
Collected for each `<dbname>` database, including service ones (admin, config, and local).

| Name<br/>Type, units | Description |
| ----- | ----- |
| `db_stats_avgObjSize`<br/>`DGAUGE`, bytes | Average document size |
| `db_stats_collections`<br/>`DGAUGE`, pcs | Number of DB collections |
| `db_stats_dataSize`<br/>`DGAUGE`, bytes | Size of uncompressed data in the DB |
| `db_stats_fsTotalSize`<br/>`DGAUGE`, bytes | Total disk space of the file system where MongoDB stores data |
| `db_stats_fsUsedSize`<br/>`DGAUGE`, bytes | Used disk space of the file system where MongoDB stores data |
| `db_stats_indexSize`<br/>`DGAUGE`, bytes | Space used by DB indexes |
| `db_stats_indexes`<br/>`DGAUGE`, pcs | Number of indexes in all DB collections |
| `db_stats_numExtents`<br/>`DGAUGE`, pcs | Number of logical containers in all DB collections |
| `db_stats_objects`<br/>`DGAUGE`, pcs | Number of objects (documents) in all DB collections |
| `db_stats_ok`<br/>`DGAUGE`, 0/1 | dbStats command output.<br/>`1` if the command completed successfully, `0` if it failed. |
| `db_stats_scaleFactor`<br/>`DGAUGE`, pcs | `scale` parameter used by the command |
| `db_stats_storageSize`<br/>`DGAUGE`, bytes | Space allocated for document storage across DB collections, including free space |
| `db_stats_views`<br/>`DGAUGE`, pcs | Number of DB views |

##### serverStatus metrics {#managed-mongodb-serverstatus-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `server_status_admin_asserts.msg`<br/>`DGAUGE`, pcs | Number of message asserts triggered |
| `server_status_admin_asserts.msg_rate`<br/>`DGAUGE`, pcs | Message assert increment per second |
| `server_status_admin_asserts.regular`<br/>`DGAUGE`, pcs | Number of regular asserts triggered |
| `server_status_admin_asserts.regular_rate`<br/>`DGAUGE`, pcs | Regular message assert increment per second |
| `server_status_admin_asserts.rollovers`<br/>`DGAUGE`, pcs | Number of counter rollovers |
| `server_status_admin_asserts.rollovers_rate`<br/>`DGAUGE`, pcs | Counter rollover increment per second |
| `server_status_admin_asserts.user`<br/>`DGAUGE`, pcs | Number of user asserts triggered |
| `server_status_admin_asserts.user_rate`<br/>`DGAUGE`, pcs | User assert increment per second |
| `server_status_admin_asserts.warning`<br/>`DGAUGE`, pcs | Number of warnings |
| `server_status_admin_asserts.warning_rate`<br/>`DGAUGE`, pcs | Warning increment per second |
| `server_status_admin_connections.active`<br/>`DGAUGE`, pcs | Number of active connections |
| `server_status_admin_connections.active_rate`<br/>`DGAUGE`, pcs | Active connection increment per second |
| `server_status_admin_connections.adminConnections.readyThreads`<br/>`DGAUGE`, pcs | Ready threads |
| `server_status_admin_connections.adminConnections.readyThreads_rate`<br/>`DGAUGE`, pcs | Ready thread increment per second |
| `server_status_admin_connections.adminConnections.startingThreads`<br/>`DGAUGE`, pcs | Started threads |
| `server_status_admin_connections.adminConnections.startingThreads_rate`<br/>`DGAUGE`, pcs | Started thread increment per second |
| `server_status_admin_connections.adminConnections.threadsRunning`<br/>`DGAUGE`, pcs | Running threads |
| `server_status_admin_connections.adminConnections.threadsRunning_rate`<br/>`DGAUGE`, pcs | Running thread increment per second |
| `server_status_admin_connections.available`<br/>`DGAUGE`, pcs | Number of available connections |
| `server_status_admin_connections.available_rate`<br/>`DGAUGE`, pcs | Available connection increment per second |
| `server_status_admin_connections.current`<br/>`DGAUGE`, pcs | Number of incoming DB connections |
| `server_status_admin_connections.current_rate`<br/>`DGAUGE`, pcs | Incoming DB connection increment per second |
| `server_status_admin_connections.totalCreated`<br/>`DGAUGE`, pcs | Total number of incoming server connections, including terminated ones |
| `server_status_admin_connections.totalCreated_rate`<br/>`DGAUGE`, number | Increment of total incoming server connections, including terminated ones |
| `server_status_admin_extra_info.page_faults_rate`<br/>`DGAUGE`, pcs | Number of [page faults](https://ru.wikipedia.org/wiki/Отказ_страницы) |
| `server_status_admin_globalLock.currentQueue.readers`<br/>`DGAUGE`, pcs | Number of operations in the current queue waiting for read lock release |
| `server_status_admin_globalLock.currentQueue.readers_rate`<br/>`DGAUGE`, pcs | Increment of the number of operations in the current queue waiting for read lock release, per second |
| `server_status_admin_globalLock.currentQueue.total`<br/>`DGAUGE`, pcs | Total number of operations in the current queue waiting for lock release |
| `server_status_admin_globalLock.currentQueue.total_rate`<br/>`DGAUGE`, pcs | Increment of the number of operations in the current queue waiting for lock release, per second |
| `server_status_admin_globalLock.currentQueue.writers`<br/>`DGAUGE`, pcs | Number of operations in the current queue waiting for write lock release |
| `server_status_admin_globalLock.currentQueue.writers_rate`<br/>`DGAUGE`, pcs | Increment of the number of operations in the current queue waiting for write lock release, per second |
| `server_status_admin_metrics.cursor.open.noTimeout`<br/>`DGAUGE`, pcs | Number of open cursors with the `DBQuery.Option.noTimeout` setting to prevent a timeout in the event of inactivity |
| `server_status_admin_metrics.cursor.open.noTimeout_rate`<br/>`DGAUGE`, pcs | Increment of the number of open cursors with the `DBQuery.Option.noTimeout` setting to prevent a timeout in the event of inactivity, per second |
| `server_status_admin_metrics.cursor.open.pinned`<br/>`DGAUGE`, pcs | Number of pinned open cursors |
| `server_status_admin_metrics.cursor.open.pinned_rate`<br/>`DGAUGE`, pcs | Increment of the number of pinned open cursors, per second |
| `server_status_admin_metrics.cursor.open.total`<br/>`DGAUGE`, pcs | Number of open cursors |
| `server_status_admin_metrics.cursor.open.total_rate`<br/>`DGAUGE`, pcs | Increment of the number of open cursors, per second |
| `server_status_admin_metrics.cursor.timedOut`<br/>`DGAUGE`, pcs | Number of open cursors that timed out |
| `server_status_admin_metrics.cursor.timedOut_rate`<br/>`DGAUGE`, pcs | Increment of the number of cursors that timed out, per second |
| `server_status_admin_metrics.document.deleted`<br/>`DGAUGE`, pcs | Number of documents deleted |
| `server_status_admin_metrics.document.deleted_rate`<br/>`DGAUGE`, pcs | Increment of the number of documents deleted per second |
| `server_status_admin_metrics.document.inserted`<br/>`DGAUGE`, pcs | Number of documents inserted |
| `server_status_admin_metrics.document.inserted_rate`<br/>`DGAUGE`, pcs | Increment of the number of documents inserted per second |
| `server_status_admin_metrics.document.returned`<br/>`DGAUGE`, pcs | Number of documents returned |
| `server_status_admin_metrics.document.returned_rate`<br/>`DGAUGE`, pcs | Increment of the number of documents returned per second |
| `server_status_admin_metrics.document.updated`<br/>`DGAUGE`, pcs | Number of documents updated |
| `server_status_admin_metrics.document.updated_rate`<br/>`DGAUGE`, pcs | Increment of the number of documents updated per second |
| `server_status_admin_metrics.getLastError.wtime.totalMillis`<br/>`DGAUGE`, ms | Number of milliseconds spent by the DB waiting for write confirmation |
| `server_status_admin_metrics.getLastError.wtime.totalMillis_rate`<br/>`DGAUGE`, ms | Increment of the number of milliseconds spent by the DB waiting for write confirmation, per second |
| `server_status_admin_metrics.operation.scanAndOrder`<br/>`DGAUGE`, pcs | Number of data sort operations with no index used |
| `server_status_admin_metrics.operation.scanAndOrder_rate`<br/>`DGAUGE`, pcs | Increment of the number of data sort operations with no index used, per second |
| `server_status_admin_metrics.operation.writeConflicts`<br/>`DGAUGE`, pcs | Number of write conflicts |
| `server_status_admin_metrics.operation.writeConflicts_rate`<br/>`DGAUGE`, pcs | Increment of the number of write conflicts, per second |
| `server_status_admin_metrics.queryExecutor.scanned`<br/>`DGAUGE`, pcs | Number of scanned index keys |
| `server_status_admin_metrics.queryExecutor.scanned_rate`<br/>`DGAUGE`, pcs | Increment of the number of index keys scanned per second |
| `server_status_admin_metrics.queryExecutor.scannedObjects`<br/>`DGAUGE`, pcs | Number of scanned documents |
| `server_status_admin_metrics.queryExecutor.scannedObjects_rate`<br/>`DGAUGE`, pcs | Increment of the number of documents scanned per second |
| `server_status_admin_metrics.ttl.deletedDocuments`<br/>`DGAUGE`, pcs | Number of documents deleted using the [TTL index](https://www.mongodb.com/docs/manual/core/index-ttl/) |
| `server_status_admin_metrics.ttl.deletedDocuments_rate`<br/>`DGAUGE`, pcs | Increment of the number of documents deleted using the [TTL index](https://www.mongodb.com/docs/manual/core/index-ttl/) per second |
| `server_status_admin_metrics.ttl.passes`<br/>`DGAUGE`, pcs | Number of background operations for deleting documents from collections with the TTL index used |
| `server_status_admin_metrics.ttl.passes_rate`<br/>`DGAUGE`, pcs | Increment of the number of background operations for deleting documents from collections with the TTL index used, per second |
| `server_status_admin_opLatencies.commands.latency`<br/>`DGAUGE`, microseconds | Total delay in DB command execution, microseconds |
| `server_status_admin_opLatencies.commands.latency_rate`<br/>`DGAUGE`, microseconds | Change in the DB command execution delay per second |
| `server_status_admin_opLatencies.commands.ops`<br/>`DGAUGE`, pcs | Number of operations on DB collections |
| `server_status_admin_opLatencies.commands.ops_rate`<br/>`DGAUGE`, pcs | Increment of the number of operations on DB collections per second |
| `server_status_admin_opLatencies.reads.latency`<br/>`DGAUGE`, microseconds | Delay in read command execution, in microseconds |
| `server_status_admin_opLatencies.reads.latency_rate`<br/>`DGAUGE`, microseconds | Change in the read command execution delay per second |
| `server_status_admin_opLatencies.reads.ops`<br/>`DGAUGE`, pcs | Number of DB collection reads |
| `server_status_admin_opLatencies.reads.ops_rate`<br/>`DGAUGE`, pcs | Increment of the number of DB collection reads per second |
| `server_status_admin_opLatencies.transactions.latency`<br/>`DGAUGE`, microseconds | Transaction latency, in microseconds |
| `server_status_admin_opLatencies.transactions.latency_rate`<br/>`DGAUGE`, microseconds | Change in transaction latency per second |
| `server_status_admin_opLatencies.transactions.ops`<br/>`DGAUGE`, pcs | Number of DB transactions |
| `server_status_admin_opLatencies.transactions.ops_rate`<br/>`DGAUGE`, pcs | Increment of the number of DB transactions per second |
| `server_status_admin_opLatencies.writes.latency`<br/>`DGAUGE`, microseconds | Delay in write command execution, in microseconds |
| `server_status_admin_opLatencies.writes.latency_rate`<br/>`DGAUGE`, microseconds | Change in the write command execution delay per second |
| `server_status_admin_opLatencies.writes.ops`<br/>`DGAUGE`, pcs | Number of DB collection writes |
| `server_status_admin_opLatencies.writes.ops_rate`<br/>`DGAUGE`, pcs | Increment of the number of DB collection writes per second |
| `server_status_admin_opcounters.command`<br/>`DGAUGE`, pcs | Number of commands to the DB since its last start, except `insert`, `update`, and `delete` |
| `server_status_admin_opcounters.command_rate`<br/>`DGAUGE`, pcs | Increment of the number of commands to the DB per second, except `insert`, `update`, and `delete` |
| `server_status_admin_opcounters.delete`<br/>`DGAUGE`, pcs | Number of `delete` operations since the last start of the DB |
| `server_status_admin_opcounters.delete_rate`<br/>`DGAUGE`, pcs | Increment of the number of `delete` operations in the DB per second |
| `server_status_admin_opcounters.getmore`<br/>`DGAUGE`, pcs | Number of `getmore` operations since the last start of the DB |
| `server_status_admin_opcounters.getmore_rate`<br/>`DGAUGE`, pcs | Increment of the number of `getmore` operations in the DB per second |
| `server_status_admin_opcounters.insert`<br/>`DGAUGE`, pcs | Number of `insert` operations since the last start of the DB |
| `server_status_admin_opcounters.insert_rate`<br/>`DGAUGE`, pcs | Increment of the number of `insert` operations in the DB per second |
| `server_status_admin_opcounters.query`<br/>`DGAUGE`, pcs | Number of `query` operations since the last start of the DB |
| `server_status_admin_opcounters.query_rate`<br/>`DGAUGE`, pcs | Increment of the number of `query` operations in the DB per second |
| `server_status_admin_opcounters.update`<br/>`DGAUGE`, pcs | Number of `update` operations since the last start of the DB |
| `server_status_admin_opcounters.update_rate`<br/>`DGAUGE`, pcs | Increment of the number of `update` operations in the DB per second |
| `server_status_admin_opcountersRepl.command`<br/>`DGAUGE`, pcs | Number of replicated commands to the DB since its last start |
| `server_status_admin_opcountersRepl.command_rate`<br/>`DGAUGE`, pcs | Increment of the number of replicated commands to the DB per second |
| `server_status_admin_opcountersRepl.delete`<br/>`DGAUGE`, pcs | Number of replicated `delete` operations since the last start of the DB |
| `server_status_admin_opcountersRepl.delete_rate`<br/>`DGAUGE`, pcs | Increment of the number of replicated `delete` operations in the DB per second |
| `server_status_admin_opcountersRepl.getmore`<br/>`DGAUGE`, pcs | Number of replicated `getmore` operations since the last start of the DB |
| `server_status_admin_opcountersRepl.getmore_rate`<br/>`DGAUGE`, pcs | Increment of the number of replicated `getmore` operations in the DB per second |
| `server_status_admin_opcountersRepl.insert`<br/>`DGAUGE`, pcs | Number of replicated `insert` operations since the last start of the DB |
| `server_status_admin_opcountersRepl.insert_rate`<br/>`DGAUGE`, pcs | Increment of the number of replicated `insert` operations in the DB per second |
| `server_status_admin_opcountersRepl.query`<br/>`DGAUGE`, pcs | Number of replicated `query` operations since the last start of the DB |
| `server_status_admin_opcountersRepl.query_rate`<br/>`DGAUGE`, pcs | Increment of the number of replicated `query` operations in the DB per second |
| `server_status_admin_opcountersRepl.update`<br/>`DGAUGE`, pcs | Number of replicated `update` operations since the last start of the DB |
| `server_status_admin_opcountersRepl.update_rate`<br/>`DGAUGE`, pcs | Increment of the number of replicated `update` operations in the DB per second |
| `server_status_admin_wiredTiger.cache.bytes_currently_in_the_cache`<br/>`DGAUGE`, bytes | Size of the WiredTiger cache used |
| `server_status_admin_wiredTiger.cache.bytes_currently_in_the_cache_rate`<br/>`DGAUGE`, bytes | Increment of the size of the WiredTiger cache used, per second |
| `server_status_admin_wiredTiger.cache.checkpoint_blocked_page_eviction`<br/>`DGAUGE`, pcs | Number of pages evicted at a checkpoint |
| `server_status_admin_wiredTiger.cache.checkpoint_blocked_page_eviction_rate`<br/>`DGAUGE`, pcs | Increment of the number of pages evicted at a checkpoint per second |
| `server_status_admin_wiredTiger.cache.maximum_bytes_configured`<br/>`DGAUGE`, bytes | Maximum cache size set |
| `server_status_admin_wiredTiger.cache.modified_pages_evicted`<br/>`DGAUGE`, pcs | Number of modified RAM pages evicted |
| `server_status_admin_wiredTiger.cache.modified_pages_evicted_rate`<br/>`DGAUGE`, pcs | Increment of the number of modified RAM pages evicted per second |
| `server_status_admin_wiredTiger.cache.tracked_dirty_bytes_in_the_cache`<br/>`DGAUGE`, bytes | Size of the dirty cache |
| `server_status_admin_wiredTiger.cache.tracked_dirty_bytes_in_the_cache_rate`<br/>`DGAUGE`, bytes | Increment of the size of the dirty cache per second |
| `server_status_admin_wiredTiger.cache.unmodified_pages_evicted`<br/>`DGAUGE`, pcs | Number of unmodified RAM pages evicted |
| `server_status_admin_wiredTiger.cache.unmodified_pages_evicted_rate`<br/>`DGAUGE`, pcs | Increment of the number of unmodified RAM pages evicted per second |
| `server_status_admin_wiredTiger.concurrentTransactions.read.out`<br/>`DGAUGE`, pcs | Number of used tickets of concurrent read transactions |
| `server_status_admin_wiredTiger.concurrentTransactions.read.out_rate`<br/>`DGAUGE`, pcs | Increment of the number of used tickets of concurrent read transactions, per second |
| `server_status_admin_wiredTiger.concurrentTransactions.read.totalTickets`<br/>`DGAUGE`, pcs | Number of available tickets of concurrent read transactions |
| `server_status_admin_wiredTiger.concurrentTransactions.read.totalTickets_rate`<br/>`DGAUGE`, pcs | Increment of the number of tickets of concurrent read transactions, per second |
| `server_status_admin_wiredTiger.concurrentTransactions.write.out`<br/>`DGAUGE`, pcs | Number of used tickets of concurrent write transactions |
| `server_status_admin_wiredTiger.concurrentTransactions.write.out_rate`<br/>`DGAUGE`, pcs | Increment of the number of used tickets of concurrent write transactions, per second |
| `server_status_admin_wiredTiger.concurrentTransactions.write.totalTickets`<br/>`DGAUGE`, pcs | Number of available tickets of concurrent write transactions |
| `server_status_admin_wiredTiger.concurrentTransactions.write.totalTickets_rate`<br/>`DGAUGE`, pcs | Increment of the number of available tickets of concurrent write transactions, per second |
| `server_status_admin_wiredTiger.transaction.transaction_begins`<br/>`DGAUGE`, pcs | Running transactions |
| `server_status_admin_wiredTiger.transaction.transaction_begins_rate`<br/>`DGAUGE`, pcs | Running transaction increment per second |
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_max_time_msecs`<br/>`DGAUGE`, ms | Maximum checkpoint creation time |
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_min_time_msecs`<br/>`DGAUGE`, ms | Minimum checkpoint creation time |
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_most_recent_time_msecs`<br/>`DGAUGE`, ms | Most recent checkpoint creation time, in ms |
| `server_status_admin_wiredTiger.transaction.transaction_checkpoints`<br/>`DGAUGE`, pcs | Number of transaction checkpoints |
| `server_status_admin_wiredTiger.transaction.transaction_checkpoints_rate`<br/>`DGAUGE`, pcs | Transaction checkpoint increment per second |
| `server_status_admin_wiredTiger.transaction.transactions_committed`<br/>`DGAUGE`, pcs | Committed transactions |
| `server_status_admin_wiredTiger.transaction.transactions_committed_rate`<br/>`DGAUGE`, pcs | Committed transaction increment per second |
| `server_status_admin_wiredTiger.transaction.transactions_rolled_back`<br/>`DGAUGE`, pcs | Transactions rolled back |
| `server_status_admin_wiredTiger.transaction.transactions_rolled_back_rate`<br/>`DGAUGE`, pcs | Rolled back transaction increment per second |

##### Other metrics {#managed-mongodb-other-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Read access indicator.<br/>`1` if a cluster is available for reads, `0` if it is not. |
| `can_write`<br/>`DGAUGE`, 0/1 | Write access indicator.<br/>`1` if a cluster is available for writes, `0` if it is not. |
| `oplog-diff`<br/>`DGAUGE`, ms | Operation log size, in ms |
| `oplog-firstTs`<br/>`DGAUGE`, ms | Timestamp of the first operation in the operation log |
| `oplog-lastTs`<br/>`DGAUGE`, ms | Timestamp of the last operation in the operation log |
| `oplog-maxSize`<br/>`DGAUGE`, bytes | Maximum size of the operation log |
| `replset_status-replicationLag`<br/>`DGAUGE`, seconds | Replication lag |

Read more about the service in the [{{ mmg-full-name }}](../../../managed-mongodb/) documentation.
