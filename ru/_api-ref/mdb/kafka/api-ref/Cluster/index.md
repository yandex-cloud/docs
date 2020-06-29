---
editable: false
---

# Cluster
A set of methods for managing Apache Kafka clusters.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "monitoring": [
    {
      "name": "string",
      "description": "string",
      "link": "string"
    }
  ],
  "config": {
    "version": "string",
    "kafka": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },
      "kafkaConfig_2_1": {
        "compressionType": "string",
        "logFlushIntervalMessages": "integer",
        "logFlushIntervalMs": "integer",
        "logFlushSchedulerIntervalMs": "integer",
        "logRetentionBytes": "integer",
        "logRetentionHours": "integer",
        "logRetentionMinutes": "integer",
        "logRetentionMs": "integer"
      }
    },
    "zookeeper": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      }
    },
    "zoneId": [
      "string"
    ],
    "brokersCount": "integer",
    "assignPublicIp": true
  },
  "networkId": "string",
  "health": "string",
  "status": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>ID of the Apache Kafka cluster. This ID is assigned by MDB at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the Apache Kafka cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Name of the Apache Kafka cluster. The name must be unique within the folder. 1-63 characters long.</p> 
description | **string**<br><p>Description of the Apache Kafka cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Custom labels for the Apache Kafka cluster as <code>key:value</code> pairs. A maximum of 64 labels per resource is allowed.</p> 
environment | **string**<br><p>Deployment environment of the Apache Kafka cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with a more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
monitoring[] | **object**<br><p>Monitoring system.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the Apache Kafka cluster.</p> 
config | **object**<br><p>Configuration of the Apache Kafka cluster.</p> <p>The cluster configuration.</p> 
config.<br>version | **string**<br><p>Version of Apache Kafka used in the cluster.</p> 
config.<br>kafka | **object**<br><p>Configuration and resource allocation for Apache Kafka brokers.</p> <p>Apache Kafka configuration.</p> 
config.<br>kafka.<br>resources | **object**<br><p>Cluster computational resources.</p> 
config.<br>kafka.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
config.<br>kafka.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>kafka.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
config.<br>kafka.<br>kafkaConfig_2_1 | **object**<br><p>Apache Kafka broker configuration. Log flushing and log retention settings are configured here.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>compressionType | **string**<br><p>Сluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: No codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: The codec to use is set by a producer (can be any of ZSTD<code>, </code>LZ4<code>, </code>GZIP<code>or</code>SNAPPY` codecs).</li> </ul> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the [Topic.topic_config.flush_messages] setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of <code>logFlushSchedulerIntervalMs</code> is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the [Topic.topic_config.flush_ms] setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency (in milliseconds) that the log flusher checks whether any log needs to be flushed to disk.</p> <p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if <code>delete</code> [Topic.topic_config.cleanup_policy] is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the [Topic.topic_config.retention_bytes] setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of <code>logRetentionHours</code> is used.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of <code>logRetentionMinutes</code> is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the [Topic.topic_config.retention_ms] setting.</p> 
config.<br>zookeeper | **object**<br><p>Configuration and resource allocation for ZooKeeper hosts.</p> <p>Zookeeper configuration.</p> 
config.<br>zookeeper.<br>resources | **object**<br><p>Resources allocated to ZooKeeper hosts.</p> <p>Cluster computational resources.</p> 
config.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
config.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
config.<br>zoneId[] | **string**<br><p>IDs of availability zones where Apache Kafka brokers reside.</p> 
config.<br>brokersCount | **integer** (int64)<br><p>The number of Apache Kafka brokers deployed in each availability zone.</p> 
config.<br>assignPublicIp | **boolean** (boolean)<br><p>The flag that defines whether a public IP address is assigned to the cluster. If the value is <code>true</code>, then Apache Kafka cluster is available on the Internet via it's public IP address.</p> 
networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (<code>health</code> of all hosts in the cluster is <code>UNKNOWN</code>).</li> <li>ALIVE: Cluster is alive and well (<code>health</code> of all hosts in the cluster is <code>ALIVE</code>).</li> <li>DEAD: Cluster is inoperable (<code>health</code> of all hosts in the cluster is <code>DEAD</code>).</li> <li>DEGRADED: Cluster is in degraded state (<code>health</code> of at least one of the hosts in the cluster is not <code>ALIVE</code>).</li> </ul> 
status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Creates a new Apache Kafka cluster in the specified folder.
[delete](delete.md) | Deletes the specified Apache Kafka cluster.
[get](get.md) | Returns the specified Apache Kafka cluster resource.
[list](list.md) | Retrieves the list of Apache Kafka clusters that belong to the specified folder.
[listHosts](listHosts.md) | Retrieves a list of hosts for the specified Apache Kafka cluster.
[listLogs](listLogs.md) | Retrieves logs for the specified Apache Kafka cluster. For more information about logs, see the [Logs](/docs/managed-kafka/operations/cluster-logs) section in the documentation.
[listOperations](listOperations.md) | Retrieves the list of operations for the specified Apache Kafka cluster.
[move](move.md) | Moves the specified Apache Kafka cluster to the specified folder.
[start](start.md) | Starts the specified Apache Kafka cluster.
[stop](stop.md) | Stops the specified Apache Kafka cluster.
[streamLogs](streamLogs.md) | Same as [listLogs](/docs/managed-kafka/api-ref/Cluster/listLogs) but using server-side streaming. Also allows for 'tail -f' semantics.
[update](update.md) | Updates the specified Apache Kafka cluster.