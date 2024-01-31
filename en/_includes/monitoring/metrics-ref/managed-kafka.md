## {{ mkf-full-name }} {#managed-kafka}

Common labels for all {{ mkf-name }} metrics:

| Label | Value |
| ----- | ----- |
| service | Service ID: `managed-kafka` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster ID |
| host | Host FQDN |
| node | Broker type: `leader`, `follower`, and `replica` |
| subcluster_name | Subcluster type: `zookeeper_subcluster`, `kafka_subcluster` |

### CPU metrics {#managed-kafka-cpu-metrics}
The load on processor cores.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `cpu.fraction`<br/>`DGAUGE`, % | Guaranteed vCPU share. |
| `cpu.guarantee`<br/>`DGAUGE`, number | Guaranteed number of cores. |
| `cpu.limit`<br/>`DGAUGE`, number | Limit on CPUs in use. |
| `cpu.guest`<br/>`DGAUGE`, % | CPU usage, `guest` usage type. |
| `cpu.idle`<br/>`DGAUGE`, % | CPU usage, `idle` usage type. |
| `cpu.iowait`<br/>`DGAUGE`, % | CPU usage, `iowait` usage type. |
| `cpu.irq`<br/>`DGAUGE`, % | CPU usage, `irq` usage type |
| `cpu.nice`<br/>`DGAUGE`, % | CPU usage, `nice` usage type |
| `cpu.softirq`<br/>`DGAUGE`, % | CPU usage, `softirq` usage type |
| `cpu.steal`<br/>`DGAUGE`, % | CPU usage, `steal` usage type. |
| `cpu.system`<br/>`DGAUGE`, % | CPU usage, `system` usage type. |
| `cpu.user`<br/>`DGAUGE`, % | CPU usage, `user` usage type. |
| `load.avg_15min`<br/>`DGAUGE`, % | Average load in 15 minutes. |
| `load.avg_1min`<br/>`DGAUGE`, % | Average load per 1 minute. |
| `load.avg_5min`<br/>`DGAUGE`, % | Average load in 5 minutes |

### Disk metrics {#managed-kafka-disk-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, bytes | Free space. |
| `disk.free_inodes`<br/>`DGAUGE`, number | Number of free inodes. |
| `disk.total_bytes`<br/>`DGAUGE`, bytes | Available space. |
| `disk.total_inodes`<br/>`DGAUGE`, number | Available inodes. |
| `disk.used_bytes`<br/>`DGAUGE`, bytes | Used space. |
| `disk.used_inodes`<br/>`DGAUGE`, number | Used inodes. |

### Disk operation metrics {#managed-kafka-diskio-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `io.avg_read_time`<br/>`DGAUGE`, ms | Average disk read time. |
| `io.avg_write_time`<br/>`DGAUGE`, ms | Average disk write time. |
| `io.disk*.avg_read_time`<br/>`DGAUGE`, ms | Average read time for a specific disk. |
| `io.disk*.avg_write_time`<br/>`DGAUGE`, ms | Average write time for a specific disk. |
| `io.disk*.read_bytes`<br/>`DGAUGE`, bytes per second | Read speed for a specific disk. |
| `io.disk*.read_count`<br/>`DGAUGE`, operations per second | Read operations per second for a specific disk. |
| `io.disk*.read_merged_count`<br/>`DGAUGE`, operations per second | Merged read operations per second for a specific disk. |
| `io.disk*.utilization`<br/>`DGAUGE`, % | Utilization of a specific disk; disabled for network drives. |
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

### RAM metrics {#managed-kafka-ram-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.guarantee_bytes`<br/>`DGAUGE`, bytes | Guaranteed memory. |
| `mem.limit_bytes`<br/>`DGAUGE`, bytes | Memory limit. |
| `mem.active_bytes`<br/>`DGAUGE`, bytes | Amount of RAM used most often and only freed up when absolutely necessary. |
| `mem.available_bytes`<br/>`DGAUGE`, bytes | RAM usage, `available` usage type. |
| `mem.buffers_bytes`<br/>`DGAUGE`, bytes | RAM usage, `buffers` usage type. |
| `mem.cached_bytes`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type. |
| `mem.free_bytes`<br/>`DGAUGE`, bytes | Amount of free RAM available, excluding `mem.buffers_bytes` and `mem.cached_bytes`. |
| `mem.shared_bytes`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type. |
| `mem.total_bytes`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type. |
| `mem.used_bytes`<br/>`DGAUGE`, bytes | Amount of RAM currently used by the running processes. |

### Network metrics {#managed-kafka-net-metrics}
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

### Service metrics {#managed-kafka-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `kafka_controller_ControllerStats_LeaderElectionRateAndTimeMs`<br/>`DGAUGE`, ms | Leader broker change per unit of time, normally shows 0. The value may increase under maintenance, which does not indicate a problem.<br/>Additional labels: `quantile`. |
| `kafka_controller_KafkaController_ActiveControllerCount`<br/>`DGAUGE`, number | Number of active controllers. |
| `kafka_controller_KafkaController_GlobalTopicCount`<br/>`DGAUGE`, number | Number of topics. |
| `kafka_controller_KafkaController_OfflinePartitionsCount`<br/>`DGAUGE`, number | Number of offline partitions. |
| `kafka_controller_KafkaController_PreferredReplicaImbalanceCount`<br/>`DGAUGE`, number | Imbalance indicator in the required allocation of replicas, normally shows `0`. |
| `kafka_group_topic_partition_lag`<br/>`DGAUGE`, number | Message lag: Difference between the offset and total number of messages in the partition. |
| `kafka_group_topic_partition_offset`<br/>`DGAUGE`, number | Partition offset. |
| `kafka_host_count`<br/>`DGAUGE`, number | Number of hosts in the cluster. |
| `kafka_is_alive`<br/>`DGAUGE`, 0/1 | Broker health indicator.<br/>`1` if broker alive, `0` if not. |
| `kafka_network_RequestChannel_RequestQueueSize`<br/>`DGAUGE`, number | Requests enqueued. |
| `kafka_network_RequestMetrics_Errors`<br/>`DGAUGE`, number | Number of errors.<br/>Additional labels: `request` |
| `kafka_network_RequestMetrics_LocalTimeMs`<br/>`DGAUGE`, ms | Time it takes the leader broker to process a request.<br/>Additional labels: `request`, `quantile` |
| `kafka_network_RequestMetrics_MessageConversionsTimeMs`<br/>`DGAUGE`, ms | Message format conversion time.<br/>Additional labels: `request`, `quantile` |
| `kafka_network_RequestMetrics_RemoteTimeMs`<br/>`DGAUGE`, ms | Follower broker waiting time.<br/>Additional labels: `request`, `quantile` |
| `kafka_network_RequestMetrics_RequestQueueTimeMs`<br/>`DGAUGE`, ms | Waiting time in the request queue.<br/>Additional labels: `request`, `quantile` |
| `kafka_network_RequestMetrics_Requests`<br/>`DGAUGE`, number | Number of requests.<br/>Additional labels: `request` |
| `kafka_network_RequestMetrics_ResponseQueueTimeMs`<br/>`DGAUGE`, ms | Waiting time in the response queue.<br/>Additional labels: `request`, `quantile` |
| `kafka_network_RequestMetrics_ResponseSendTimeMs`<br/>`DGAUGE`, ms | Response send time.<br/>Additional labels: `request`, `quantile` |
| `kafka_network_RequestMetrics_TotalTimeMs`<br/>`DGAUGE`, ms | Total request execution time.<br/>Additional labels: `request`, `quantile` |
| `kafka_network_SocketServer_NetworkProcessorAvgIdlePercent`<br/>`DGAUGE`, % | Network processor average idle value. Ranges from `0` (all resources are utilized) to `1` (all resources are free). |
| `kafka_server_BrokerTopicMetrics_BytesIn`<br/>`DGAUGE`, bytes | Input data size. |
| `kafka_server_BrokerTopicMetrics_BytesOut`<br/>`DGAUGE`, bytes | Output data size. |
| `kafka_server_BrokerTopicMetrics_FailedFetchRequests`<br/>`DGAUGE`, number | Number of failed incoming requests. |
| `kafka_server_BrokerTopicMetrics_FailedProduceRequests`<br/>`DGAUGE`, number | Number of requests that failed to be processed. |
| `kafka_server_BrokerTopicMetrics_MessagesIn`<br/>`DGAUGE`, number | Number of written messages. |
| `kafka_server_BrokerTopicMetrics_ReplicationBytesIn`<br/>`DGAUGE`, bytes | Replicated data size. |
| `kafka_server_KafkaRequestHandlerPool_RequestHandlerAvgIdlePercent_count`<br/>`DGAUGE`, % | Request handler average idle value. Ranges from `0` (all resources are utilized) to `1` (all resources are free). |
| `kafka_server_KafkaServer_BrokerState`<br/>`DGAUGE` | Broker state:<br/>0: `Not Running`<br/>1: `Starting`<br/>2: `Recovering from Unclean Shutdown`<br/>3: `Running as Broker`<br/>4: `Running as Controller`<br/>5: `Pending Controlled ShutdownStates`<br/>6: `Broker Shutting Down` |
| `kafka_server_ReplicaFetcherManager_MaxLag`<br/>`DGAUGE`, number | Maximum lag of message replication between the follower and leader brokers.<br/>Additional labels: `clientId` |
| `kafka_server_ReplicaManager_LeaderCount`<br/>`DGAUGE`, number | Number of partitions with a leader broker. |
| `kafka_server_ReplicaManager_OfflineReplicaCount`<br/>`DGAUGE`, number | Number of partitions without a leader. These partitions do not support message writes or reads. |
| `kafka_server_ReplicaManager_PartitionCount`<br/>`DGAUGE`, number | Number of partitions for a broker. |
| `kafka_server_ReplicaManager_ReassigningPartitions`<br/>`DGAUGE`, number | Number of partitions with the leader being reassigned. |
| `kafka_server_ReplicaManager_UnderMinIsrPartitionCount`<br/>`DGAUGE`, number | Number of partitions with a number of in-sync replicas below the minimum allowed value specified in the settings. |
| `kafka_server_ReplicaManager_UnderReplicatedPartitions`<br/>`DGAUGE`, number | Number of partitions whose replication factor is greater than the number of their in-sync replicas (ISRs). |
| `kafka_server_ZooKeeperClientMetrics_ZooKeeperRequestLatencyMs`<br/>`DGAUGE`, ms | Request latency in {{ ZK }}.<br/>Additional labels: `quantile` |
| `kafka_shard_count`<br/>`DGAUGE`, number | Number of active shards. |

Read more about the service in the [{{ mkf-name }}](../../../managed-kafka/) documentation.
