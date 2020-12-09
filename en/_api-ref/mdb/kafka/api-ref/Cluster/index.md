---
editable: false
---

# Cluster
A set of methods for managing Apache Kafka® clusters.
## JSON Representation {#representation}
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

      // `config.kafka` includes only one of the fields `kafkaConfig_2_1`, `kafkaConfig_2_6`
      "kafkaConfig_2_1": {
        "compressionType": "string",
        "logFlushIntervalMessages": "integer",
        "logFlushIntervalMs": "integer",
        "logFlushSchedulerIntervalMs": "integer",
        "logRetentionBytes": "integer",
        "logRetentionHours": "integer",
        "logRetentionMinutes": "integer",
        "logRetentionMs": "integer",
        "logSegmentBytes": "integer",
        "logPreallocate": true
      },
      "kafkaConfig_2_6": {
        "compressionType": "string",
        "logFlushIntervalMessages": "integer",
        "logFlushIntervalMs": "integer",
        "logFlushSchedulerIntervalMs": "integer",
        "logRetentionBytes": "integer",
        "logRetentionHours": "integer",
        "logRetentionMinutes": "integer",
        "logRetentionMs": "integer",
        "logSegmentBytes": "integer",
        "logPreallocate": true
      },
      // end of the list of possible fields`config.kafka`

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
  "status": "string",
  "securityGroupIds": [
    "string"
  ]
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the Apache Kafka® cluster. This ID is assigned at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the Apache Kafka® cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the Apache Kafka® cluster. The name must be unique within the folder. 1-63 characters long. Value must match the regular expression `[a-zA-Z0-9_-]*`.</p> 
description | **string**<br><p>Description of the Apache Kafka® cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Custom labels for the Apache Kafka® cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed.</p> 
environment | **string**<br><p>Deployment environment of the Apache Kafka® cluster.</p> <ul> <li>PRODUCTION: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li> </ul> 
monitoring[] | **object**<br><p>Metadata of monitoring system.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the Apache Kafka® cluster.</p> 
config | **object**<br><p>Configuration of the Apache Kafka® cluster.</p> 
config.<br>version | **string**<br><p>Version of Apache Kafka® used in the cluster. Possible values: `2.1`, `2.6`.</p> 
config.<br>kafka | **object**<br><p>Configuration and resource allocation for Kafka brokers.</p> 
config.<br>kafka.<br>resources | **object**<br>
config.<br>kafka.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
config.<br>kafka.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>kafka.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
config.<br>kafka.<br>kafkaConfig_2_1 | **object** <br>`config.kafka` includes only one of the fields `kafkaConfig_2_1`, `kafkaConfig_2_6`<br><br><p>Kafka version 2.1 broker configuration.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>compressionType | **string**<br><p>Сluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li> </ul> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `flushMessages` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `logFlushSchedulerIntervalMs` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `flushMs` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if `delete` `cleanupPolicy` is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `retentionBytes` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of `logRetentionHours` is used.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of `logRetentionMinutes` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `retentionMs` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logSegmentBytes | **integer** (int64)<br><p>The maximum size of a single log file.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `segmentBytes` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logPreallocate | **boolean** (boolean)<br><p>Should pre allocate file when create new segment?</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `preallocate` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_6 | **object** <br>`config.kafka` includes only one of the fields `kafkaConfig_2_1`, `kafkaConfig_2_6`<br><br><p>Kafka version 2.6 broker configuration.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>compressionType | **string**<br><p>Сluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li> </ul> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `flushMessages` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `logFlushSchedulerIntervalMs` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `flushMs` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if `delete` `cleanupPolicy` is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `retentionBytes` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of `logRetentionHours` is used.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of `logRetentionMinutes` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `retentionMs` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logSegmentBytes | **integer** (int64)<br><p>The maximum size of a single log file.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `segmentBytes` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logPreallocate | **boolean** (boolean)<br><p>Should pre allocate file when create new segment?</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `preallocate` setting.</p> 
config.<br>zookeeper | **object**<br><p>Configuration and resource allocation for ZooKeeper hosts.</p> 
config.<br>zookeeper.<br>resources | **object**<br><p>Resources allocated to ZooKeeper hosts.</p> 
config.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
config.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
config.<br>zoneId[] | **string**<br><p>IDs of availability zones where Kafka brokers reside.</p> 
config.<br>brokersCount | **integer** (int64)<br><p>The number of Kafka brokers deployed in each availability zone.</p> 
config.<br>assignPublicIp | **boolean** (boolean)<br><p>The flag that defines whether a public IP address is assigned to the cluster. If the value is `true`, then Apache Kafka® cluster is available on the Internet via it's public IP address.</p> 
networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: state of the cluster is unknown (`health` of all hosts in the cluster is `UNKNOWN`).</li> <li>ALIVE: cluster is alive and well (`health` of all hosts in the cluster is `ALIVE`).</li> <li>DEAD: cluster is inoperable (`health` of all hosts in the cluster is `DEAD`).</li> <li>DEGRADED: cluster is in degraded state (`health` of at least one of the hosts in the cluster is not `ALIVE`).</li> </ul> 
status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: cluster state is unknown.</li> <li>CREATING: cluster is being created.</li> <li>RUNNING: cluster is running normally.</li> <li>ERROR: cluster encountered a problem and cannot operate.</li> <li>UPDATING: cluster is being updated.</li> <li>STOPPING: cluster is stopping.</li> <li>STOPPED: cluster stopped.</li> <li>STARTING: cluster is starting.</li> </ul> 
securityGroupIds[] | **string**<br><p>User security groups</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a new Apache Kafka® cluster in the specified folder.
[delete](delete.md) | Deletes the specified Apache Kafka® cluster.
[get](get.md) | Returns the specified Apache Kafka® cluster.
[list](list.md) | Retrieves the list of Apache Kafka® clusters that belong to the specified folder.
[listHosts](listHosts.md) | Retrieves a list of hosts for the specified Apache Kafka® cluster.
[listLogs](listLogs.md) | Retrieves logs for the specified Apache Kafka® cluster.
[listOperations](listOperations.md) | Retrieves the list of operations for the specified Apache Kafka® cluster.
[move](move.md) | Moves the specified Apache Kafka® cluster to the specified folder.
[start](start.md) | Starts the specified Apache Kafka® cluster.
[stop](stop.md) | Stops the specified Apache Kafka® cluster.
[streamLogs](streamLogs.md) | Same as [listLogs](/docs/managed-kafka/api-ref/Cluster/listLogs) but using server-side streaming. Also allows for `tail -f` semantics.
[update](update.md) | Updates the specified Apache Kafka® cluster.