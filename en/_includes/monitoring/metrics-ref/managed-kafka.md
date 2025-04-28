The `name` label contains the metric name.

Labels shared by all {{ mkf-name }} metrics: 

Label | Value
----|----
service | Service ID: `managed-kafka`
resource_type | Resource type: `cluster`
resource_id | Cluster ID
host | Host FQDN
node | Broker type: `leader`, `follower`, or `replica`
subcluster_name | Subcluster type: `zookeeper_subcluster` or `kafka_subcluster`

## CPU metrics {#managed-kafka-cpu-metrics}
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

## Disk metrics {#managed-kafka-disk-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, bytes | Free space | 
| `disk.free_inodes`<br/>`DGAUGE`, count | Free inodes | 
| `disk.total_bytes`<br/>`DGAUGE`, bytes | Available space | 
| `disk.total_inodes`<br/>`DGAUGE`, count | Available inodes | 
| `disk.used_bytes`<br/>`DGAUGE`, bytes | Used space | 
| `disk.used_inodes`<br/>`DGAUGE`, count | Used inodes |

## Disk I/O metrics {#managed-kafka-diskio-metrics}
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

## RAM metrics {#managed-kafka-ram-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.guarantee_bytes`<br/>`DGAUGE`, bytes | Guaranteed memory allocation | 
| `mem.limit_bytes`<br/>`DGAUGE`, bytes | Memory limit | 
| `mem.active_bytes`<br/>`DGAUGE`, bytes | Active resident memory (frequently accessed and released when absolutely necessary) | 
| `mem.available_bytes`<br/>`DGAUGE`, bytes | RAM usage, `available` usage type | 
| `mem.buffers_bytes`<br/>`DGAUGE`, bytes | RAM usage, `buffers` usage type | 
| `mem.cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type | 
| `mem.free_bytes`<br/>`DGAUGE`, bytes | Amount of free RAM available, excluding `mem.buffers_bytes` and `mem.cached_bytes` |
| `mem.shared_bytes`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type | 
| `mem.total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type | 
| `mem.used_bytes`<br/>`DGAUGE`, bytes | Amount of RAM currently used by running processes | 

## Network metrics {#managed-kafka-net-metrics}
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

## Service metrics {#managed-kafka-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `kafka_controller_ControllerStats_LeaderElectionRateAndTimeMs`<br/>`DGAUGE`, milliseconds | Leader broker switch rate per unit of time. In a normal state, it is `0`. Its value may increase during maintenance, which does not indicate a problem.<br/>Additional labels: `quantile`. |
| `kafka_controller_KafkaController_ActiveControllerCount`<br/>`DGAUGE`, count | Number of active controllers |
| `kafka_controller_KafkaController_GlobalTopicCount`<br/>`DGAUGE`, count | Number of topics |
| `kafka_controller_KafkaController_OfflinePartitionsCount`<br/>`DGAUGE`, count | Number of offline partitions |
| `kafka_controller_KafkaController_PreferredReplicaImbalanceCount`<br/>`DGAUGE`, count | Imbalance count in the preferred replica. In a normal state, it is `0`. |
| `kafka_group_topic_partition_lag`<br/>`DGAUGE`, count | Message lag: Difference between the consumer offset and the partition's latest offset. |
| `kafka_group_topic_partition_offset`<br/>`DGAUGE`, count | Partition offset |
| `kafka_host_count`<br/>`DGAUGE`, count | Number of hosts in the cluster |
| `kafka_is_alive`<br/>`DGAUGE`, 0/1 | Broker health indicator.<br/>It can be either `1` if a broker is alive or `0` if it is not. |
| `kafka_network_RequestChannel_RequestQueueSize`<br/>`DGAUGE`, count | Number of enqueued requests |
| `kafka_network_RequestMetrics_Errors`<br/>`DGAUGE`, count | Number of errors.<br/>Additional labels: `request`. |
| `kafka_network_RequestMetrics_LocalTimeMs`<br/>`DGAUGE`, milliseconds | Time it takes the leader broker to process a request.<br/>Additional labels: `request` and `quantile`. |
| `kafka_network_RequestMetrics_MessageConversionsTimeMs`<br/>`DGAUGE`, milliseconds | Message format conversion time.<br/>Additional labels: `request` and `quantile`. |
| `kafka_network_RequestMetrics_RemoteTimeMs`<br/>`DGAUGE`, milliseconds | Follower broker wait time.<br/>Additional labels: `request` and `quantile`. |
| `kafka_network_RequestMetrics_RequestQueueTimeMs`<br/>`DGAUGE`, milliseconds | Request queue wait time.<br/>Additional labels: `request` and `quantile`. |
| `kafka_network_RequestMetrics_Requests`<br/>`DGAUGE`, count | Number of requests.<br/>Additional labels: `request`. |
| `kafka_network_RequestMetrics_ResponseQueueTimeMs`<br/>`DGAUGE`, milliseconds | Response queue wait time.<br/>Additional labels: `request` and `quantile`. |
| `kafka_network_RequestMetrics_ResponseSendTimeMs`<br/>`DGAUGE`, milliseconds | Response send time.<br/>Additional labels: `request` and `quantile`. |
| `kafka_network_RequestMetrics_TotalTimeMs`<br/>`DGAUGE`, milliseconds | Total request execution time.<br/>Additional labels: `request` and `quantile`. |
| `kafka_network_SocketServer_NetworkProcessorAvgIdlePercent`<br/>`DGAUGE`, % | Average network processor idle percentage. Its value ranges from `0` (fully utilized) to `1` (completely idle). |
| `kafka_server_BrokerTopicMetrics_BytesIn`<br/>`DGAUGE`, bytes | Incoming data size |
| `kafka_server_BrokerTopicMetrics_BytesOut`<br/>`DGAUGE`, bytes | Outgoing data size |
| `kafka_server_BrokerTopicMetrics_FailedFetchRequests`<br/>`DGAUGE`, count | Number of requests received with errors |
| `kafka_server_BrokerTopicMetrics_FailedProduceRequests`<br/>`DGAUGE`, count | Number of requests processed with errors |
| `kafka_server_BrokerTopicMetrics_MessagesIn`<br/>`DGAUGE`, count | Number of written messages |
| `kafka_server_BrokerTopicMetrics_ReplicationBytesIn`<br/>`DGAUGE`, bytes | Replicated data size |
| `kafka_server_KafkaRequestHandlerPool_RequestHandlerAvgIdlePercent_count`<br/>`DGAUGE`, % | Average request handler idle percentage. Its value ranges from `0` (fully utilized) to `1` (completely idle). |
| `kafka_server_KafkaServer_BrokerState`<br/>`DGAUGE` | Broker state:<br/>0: `Not Running`<br/>1: `Starting`<br/>2: `Recovering from Unclean Shutdown`<br/>3: `Running as Broker`<br/>4: `Running as Controller`<br/>5: `Pending Controlled ShutdownStates`<br/>6: `Broker Shutting Down` |
| `kafka_server_ReplicaFetcherManager_MaxLag`<br/>`DGAUGE`, count | Maximum lag of message replication between the follower and leader brokers.<br/>Additional labels: `clientId`.  |
| `kafka_server_ReplicaManager_LeaderCount`<br/>`DGAUGE`, count | Number of partitions led by the broker |
| `kafka_server_ReplicaManager_OfflineReplicaCount`<br/>`DGAUGE`, count | Number of partitions with no leader broker. These partitions do not support message writes or reads. |
| `kafka_server_ReplicaManager_PartitionCount`<br/>`DGAUGE`, count | Number of partitions per broker |
| `kafka_server_ReplicaManager_ReassigningPartitions`<br/>`DGAUGE`, count | Number of partitions with the leader being reassigned |
| `kafka_server_ReplicaManager_UnderMinIsrPartitionCount`<br/>`DGAUGE`, count | Number of partitions with in-sync replica (ISR) count below the set minimum |
| `kafka_server_ReplicaManager_UnderReplicatedPartitions`<br/>`DGAUGE`, count | Number of partitions with ISR count below the replication factor |
| `kafka_server_ZooKeeperClientMetrics_ZooKeeperRequestLatencyMs`<br/>`DGAUGE`, milliseconds | Request latency in {{ ZK }}.<br/>Additional labels: `quantile`. |
| `kafka_shard_count`<br/>`DGAUGE`, count | Number of active shards |