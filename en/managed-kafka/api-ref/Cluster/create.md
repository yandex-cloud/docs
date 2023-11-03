---
editable: false
sourcePath: en/_api-ref/mdb/kafka/v1/api-ref/Cluster/create.md
---

# Managed Service for Apache Kafka® API, REST: Cluster.create
Creates a new Apache Kafka® cluster in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-mdb }}/managed-kafka/v1/clusters
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "configSpec": {
    "version": "string",
    "kafka": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },

      // `configSpec.kafka` includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`
      "kafkaConfig_2_8": {
        "compressionType": "string",
        "logFlushIntervalMessages": "integer",
        "logFlushIntervalMs": "integer",
        "logFlushSchedulerIntervalMs": "integer",
        "logRetentionBytes": "integer",
        "logRetentionHours": "integer",
        "logRetentionMinutes": "integer",
        "logRetentionMs": "integer",
        "logSegmentBytes": "integer",
        "logPreallocate": true,
        "socketSendBufferBytes": "integer",
        "socketReceiveBufferBytes": "integer",
        "autoCreateTopicsEnable": true,
        "numPartitions": "integer",
        "defaultReplicationFactor": "integer",
        "messageMaxBytes": "integer",
        "replicaFetchMaxBytes": "integer",
        "sslCipherSuites": [
          "string"
        ],
        "offsetsRetentionMinutes": "integer",
        "saslEnabledMechanisms": [
          "string"
        ]
      },
      "kafkaConfig_3": {
        "compressionType": "string",
        "logFlushIntervalMessages": "integer",
        "logFlushIntervalMs": "integer",
        "logFlushSchedulerIntervalMs": "integer",
        "logRetentionBytes": "integer",
        "logRetentionHours": "integer",
        "logRetentionMinutes": "integer",
        "logRetentionMs": "integer",
        "logSegmentBytes": "integer",
        "logPreallocate": true,
        "socketSendBufferBytes": "integer",
        "socketReceiveBufferBytes": "integer",
        "autoCreateTopicsEnable": true,
        "numPartitions": "integer",
        "defaultReplicationFactor": "integer",
        "messageMaxBytes": "integer",
        "replicaFetchMaxBytes": "integer",
        "sslCipherSuites": [
          "string"
        ],
        "offsetsRetentionMinutes": "integer",
        "saslEnabledMechanisms": [
          "string"
        ]
      },
      // end of the list of possible fields`configSpec.kafka`

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
    "assignPublicIp": true,
    "unmanagedTopics": true,
    "schemaRegistry": true,
    "access": {
      "dataTransfer": true
    },
    "restApiConfig": {
      "enabled": true
    }
  },
  "topicSpecs": [
    {
      "name": "string",
      "partitions": "integer",
      "replicationFactor": "integer",

      // `topicSpecs[]` includes only one of the fields `topicConfig_2_8`, `topicConfig_3`
      "topicConfig_2_8": {
        "cleanupPolicy": "string",
        "compressionType": "string",
        "deleteRetentionMs": "integer",
        "fileDeleteDelayMs": "integer",
        "flushMessages": "integer",
        "flushMs": "integer",
        "minCompactionLagMs": "integer",
        "retentionBytes": "integer",
        "retentionMs": "integer",
        "maxMessageBytes": "integer",
        "minInsyncReplicas": "integer",
        "segmentBytes": "integer",
        "preallocate": true
      },
      "topicConfig_3": {
        "cleanupPolicy": "string",
        "compressionType": "string",
        "deleteRetentionMs": "integer",
        "fileDeleteDelayMs": "integer",
        "flushMessages": "integer",
        "flushMs": "integer",
        "minCompactionLagMs": "integer",
        "retentionBytes": "integer",
        "retentionMs": "integer",
        "maxMessageBytes": "integer",
        "minInsyncReplicas": "integer",
        "segmentBytes": "integer",
        "preallocate": true
      },
      // end of the list of possible fields`topicSpecs[]`

    }
  ],
  "userSpecs": [
    {
      "name": "string",
      "password": "string",
      "permissions": [
        {
          "topicName": "string",
          "role": "string",
          "allowHosts": [
            "string"
          ]
        }
      ]
    }
  ],
  "networkId": "string",
  "subnetId": [
    "string"
  ],
  "securityGroupIds": [
    "string"
  ],
  "hostGroupIds": [
    "string"
  ],
  "deletionProtection": true,
  "maintenanceWindow": {

    // `maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": {},
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    },
    // end of the list of possible fields`maintenanceWindow`

  }
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create the Apache Kafka® cluster in.</p> <p>To get the folder ID, make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Required. Name of the Apache Kafka® cluster. The name must be unique within the folder.</p> <p>The string length in characters must be 1-63. Value must match the regular expression ``[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
description | **string**<br><p>Description of the Apache Kafka® cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the Apache Kafka® cluster as ``key:value`` pairs.</p> <p>For example, "project": "mvp" or "source": "dictionary".</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
environment | **string**<br><p>Deployment environment of the Apache Kafka® cluster.</p> <ul> <li>PRODUCTION: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li> </ul> 
configSpec | **object**<br><p>Kafka and hosts configuration the Apache Kafka® cluster.</p> 
configSpec.<br>version | **string**<br><p>Version of Apache Kafka® used in the cluster. Possible values: ``2.1``, ``2.6``.</p> 
configSpec.<br>kafka | **object**<br><p>Configuration and resource allocation for Kafka brokers.</p> 
configSpec.<br>kafka.<br>resources | **object**<br>Resources allocated to Kafka brokers.
configSpec.<br>kafka.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>kafka.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted.</p> 
configSpec.<br>kafka.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8 | **object** <br>`configSpec.kafka` includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`<br><br><p>Kafka version 2.8 broker configuration.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>compressionType | **string**<br><p>Cluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of ``ZSTD``, ``LZ4``, ``GZIP`` or ``SNAPPY`` codecs).</li> </ul> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMessages`` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of ``logFlushSchedulerIntervalMs`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMs`` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if ``delete`` ``cleanupPolicy`` is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionBytes`` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionHours`` is used.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionMinutes`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionMs`` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>logSegmentBytes | **integer** (int64)<br><p>The maximum size of a single log file.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``segmentBytes`` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>logPreallocate | **boolean** (boolean)<br><p>Should pre allocate file when create new segment?</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``preallocate`` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>socketSendBufferBytes | **integer** (int64)<br><p>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>socketReceiveBufferBytes | **integer** (int64)<br><p>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>autoCreateTopicsEnable | **boolean** (boolean)<br><p>Enable auto creation of topic on the server</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>numPartitions | **integer** (int64)<br><p>Default number of partitions per topic on the whole cluster</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>defaultReplicationFactor | **integer** (int64)<br><p>Default replication factor of the topic on the whole cluster</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>messageMaxBytes | **integer** (int64)<br><p>The largest record batch size allowed by Kafka. Default value: 1048588.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>replicaFetchMaxBytes | **integer** (int64)<br><p>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>sslCipherSuites[] | **string**<br><p>A list of cipher suites.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>offsetsRetentionMinutes | **integer** (int64)<br><p>Offset storage time after a consumer group loses all its consumers. Default: 10080.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_8.<br>saslEnabledMechanisms[] | **string**<br><p>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512].</p> 
configSpec.<br>kafka.<br>kafkaConfig_3 | **object** <br>`configSpec.kafka` includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`<br><br><p>Kafka version 3.x broker configuration.</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>compressionType | **string**<br><p>Cluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of ``ZSTD``, ``LZ4``, ``GZIP`` or ``SNAPPY`` codecs).</li> </ul> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMessages`` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of ``logFlushSchedulerIntervalMs`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMs`` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if ``delete`` ``cleanupPolicy`` is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionBytes`` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionHours`` is used.</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionMinutes`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionMs`` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>logSegmentBytes | **integer** (int64)<br><p>The maximum size of a single log file.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``segmentBytes`` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>logPreallocate | **boolean** (boolean)<br><p>Should pre allocate file when create new segment?</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``preallocate`` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>socketSendBufferBytes | **integer** (int64)<br><p>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>socketReceiveBufferBytes | **integer** (int64)<br><p>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>autoCreateTopicsEnable | **boolean** (boolean)<br><p>Enable auto creation of topic on the server</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>numPartitions | **integer** (int64)<br><p>Default number of partitions per topic on the whole cluster</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>defaultReplicationFactor | **integer** (int64)<br><p>Default replication factor of the topic on the whole cluster</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>messageMaxBytes | **integer** (int64)<br><p>The largest record batch size allowed by Kafka. Default value: 1048588.</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>replicaFetchMaxBytes | **integer** (int64)<br><p>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576.</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>sslCipherSuites[] | **string**<br><p>A list of cipher suites.</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>offsetsRetentionMinutes | **integer** (int64)<br><p>Offset storage time after a consumer group loses all its consumers. Default: 10080.</p> 
configSpec.<br>kafka.<br>kafkaConfig_3.<br>saslEnabledMechanisms[] | **string**<br><p>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512].</p> 
configSpec.<br>zookeeper | **object**<br><p>Configuration and resource allocation for ZooKeeper hosts.</p> 
configSpec.<br>zookeeper.<br>resources | **object**<br><p>Resources allocated to ZooKeeper hosts.</p> 
configSpec.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted.</p> 
configSpec.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
configSpec.<br>zoneId[] | **string**<br><p>IDs of availability zones where Kafka brokers reside.</p> 
configSpec.<br>brokersCount | **integer** (int64)<br><p>The number of Kafka brokers deployed in each availability zone.</p> 
configSpec.<br>assignPublicIp | **boolean** (boolean)<br><p>The flag that defines whether a public IP address is assigned to the cluster. If the value is ``true``, then Apache Kafka® cluster is available on the Internet via it's public IP address.</p> 
configSpec.<br>unmanagedTopics | **boolean** (boolean)<br><p>Allows to manage topics via AdminAPI Deprecated. Feature enabled permanently.</p> 
configSpec.<br>schemaRegistry | **boolean** (boolean)<br><p>Enables managed schema registry on cluster</p> 
configSpec.<br>access | **object**<br><p>Access policy for external services.</p> 
configSpec.<br>access.<br>dataTransfer | **boolean** (boolean)<br><p>Allow access for DataTransfer.</p> 
configSpec.<br>restApiConfig | **object**<br><p>Configuration of REST API.</p> 
configSpec.<br>restApiConfig.<br>enabled | **boolean** (boolean)<br><p>Is REST API enabled for this cluster.</p> 
topicSpecs[] | **object**<br><p>One or more configurations of topics to be created in the Apache Kafka® cluster.</p> 
topicSpecs[].<br>name | **string**<br><p>Name of the topic.</p> 
topicSpecs[].<br>partitions | **integer** (int64)<br><p>The number of the topic's partitions.</p> 
topicSpecs[].<br>replicationFactor | **integer** (int64)<br><p>Amount of copies of a topic data kept in the cluster.</p> 
topicSpecs[].<br>topicConfig_2_8 | **object** <br>`topicSpecs[]` includes only one of the fields `topicConfig_2_8`, `topicConfig_3`<br><br><p>A topic settings for 2.8</p> 
topicSpecs[].<br>topicConfig_2_8.<br>cleanupPolicy | **string**<br><p>Retention policy to use on old log messages.</p> <ul> <li>CLEANUP_POLICY_DELETE: this policy discards log segments when either their retention time or log size limit is reached. See also: ``logRetentionMs`` and other similar parameters.</li> <li>CLEANUP_POLICY_COMPACT: this policy compacts messages in log.</li> <li>CLEANUP_POLICY_COMPACT_AND_DELETE: this policy use both compaction and deletion for messages and log segments.</li> </ul> 
topicSpecs[].<br>topicConfig_2_8.<br>compressionType | **string**<br><p>The compression type for a given topic.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of ``ZSTD``, ``LZ4``, ``GZIP`` or ``SNAPPY`` codecs).</li> </ul> 
topicSpecs[].<br>topicConfig_2_8.<br>deleteRetentionMs | **integer** (int64)<br><p>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.</p> 
topicSpecs[].<br>topicConfig_2_8.<br>fileDeleteDelayMs | **integer** (int64)<br><p>The time to wait before deleting a file from the filesystem.</p> 
topicSpecs[].<br>topicConfig_2_8.<br>flushMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This setting overrides the cluster-level ``logFlushIntervalMessages`` setting on the topic level.</p> 
topicSpecs[].<br>topicConfig_2_8.<br>flushMs | **integer** (int64)<br><p>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.</p> <p>This setting overrides the cluster-level ``logFlushIntervalMs`` setting on the topic level.</p> 
topicSpecs[].<br>topicConfig_2_8.<br>minCompactionLagMs | **integer** (int64)<br><p>The minimum time in milliseconds a message will remain uncompacted in the log.</p> 
topicSpecs[].<br>topicConfig_2_8.<br>retentionBytes | **integer** (int64)<br><p>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the ``delete`` ``cleanupPolicy`` is in effect. It is helpful if you need to control the size of log due to limited disk space.</p> <p>This setting overrides the cluster-level ``logRetentionBytes`` setting on the topic level.</p> 
topicSpecs[].<br>topicConfig_2_8.<br>retentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment's file before deleting it.</p> <p>This setting overrides the cluster-level ``logRetentionMs`` setting on the topic level.</p> 
topicSpecs[].<br>topicConfig_2_8.<br>maxMessageBytes | **integer** (int64)<br><p>The largest record batch size allowed in topic.</p> 
topicSpecs[].<br>topicConfig_2_8.<br>minInsyncReplicas | **integer** (int64)<br><p>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all").</p> 
topicSpecs[].<br>topicConfig_2_8.<br>segmentBytes | **integer** (int64)<br><p>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention.</p> <p>This setting overrides the cluster-level ``logSegmentBytes`` setting on the topic level.</p> 
topicSpecs[].<br>topicConfig_2_8.<br>preallocate | **boolean** (boolean)<br><p>True if we should preallocate the file on disk when creating a new log segment.</p> <p>This setting overrides the cluster-level ``logPreallocate`` setting on the topic level.</p> 
topicSpecs[].<br>topicConfig_3 | **object** <br>`topicSpecs[]` includes only one of the fields `topicConfig_2_8`, `topicConfig_3`<br><br><p>A topic settings for 3.x</p> 
topicSpecs[].<br>topicConfig_3.<br>cleanupPolicy | **string**<br><p>Retention policy to use on old log messages.</p> <ul> <li>CLEANUP_POLICY_DELETE: this policy discards log segments when either their retention time or log size limit is reached. See also: ``logRetentionMs`` and other similar parameters.</li> <li>CLEANUP_POLICY_COMPACT: this policy compacts messages in log.</li> <li>CLEANUP_POLICY_COMPACT_AND_DELETE: this policy use both compaction and deletion for messages and log segments.</li> </ul> 
topicSpecs[].<br>topicConfig_3.<br>compressionType | **string**<br><p>The compression type for a given topic.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of ``ZSTD``, ``LZ4``, ``GZIP`` or ``SNAPPY`` codecs).</li> </ul> 
topicSpecs[].<br>topicConfig_3.<br>deleteRetentionMs | **integer** (int64)<br><p>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.</p> 
topicSpecs[].<br>topicConfig_3.<br>fileDeleteDelayMs | **integer** (int64)<br><p>The time to wait before deleting a file from the filesystem.</p> 
topicSpecs[].<br>topicConfig_3.<br>flushMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This setting overrides the cluster-level ``logFlushIntervalMessages`` setting on the topic level.</p> 
topicSpecs[].<br>topicConfig_3.<br>flushMs | **integer** (int64)<br><p>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.</p> <p>This setting overrides the cluster-level ``logFlushIntervalMs`` setting on the topic level.</p> 
topicSpecs[].<br>topicConfig_3.<br>minCompactionLagMs | **integer** (int64)<br><p>The minimum time in milliseconds a message will remain uncompacted in the log.</p> 
topicSpecs[].<br>topicConfig_3.<br>retentionBytes | **integer** (int64)<br><p>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the ``delete`` ``cleanupPolicy`` is in effect. It is helpful if you need to control the size of log due to limited disk space.</p> <p>This setting overrides the cluster-level ``logRetentionBytes`` setting on the topic level.</p> 
topicSpecs[].<br>topicConfig_3.<br>retentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment's file before deleting it.</p> <p>This setting overrides the cluster-level ``logRetentionMs`` setting on the topic level.</p> 
topicSpecs[].<br>topicConfig_3.<br>maxMessageBytes | **integer** (int64)<br><p>The largest record batch size allowed in topic.</p> 
topicSpecs[].<br>topicConfig_3.<br>minInsyncReplicas | **integer** (int64)<br><p>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all").</p> 
topicSpecs[].<br>topicConfig_3.<br>segmentBytes | **integer** (int64)<br><p>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention.</p> <p>This setting overrides the cluster-level ``logSegmentBytes`` setting on the topic level.</p> 
topicSpecs[].<br>topicConfig_3.<br>preallocate | **boolean** (boolean)<br><p>True if we should preallocate the file on disk when creating a new log segment.</p> <p>This setting overrides the cluster-level ``logPreallocate`` setting on the topic level.</p> 
userSpecs[] | **object**<br><p>Configurations of accounts to be created in the Apache Kafka® cluster.</p> 
userSpecs[].<br>name | **string**<br><p>Required. Name of the Kafka user.</p> <p>The string length in characters must be 1-256. Value must match the regular expression ``[a-zA-Z0-9_]*``.</p> 
userSpecs[].<br>password | **string**<br><p>Required. Password of the Kafka user.</p> <p>The string length in characters must be 8-128.</p> 
userSpecs[].<br>permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
userSpecs[].<br>permissions[].<br>topicName | **string**<br><p>Name or prefix-pattern with wildcard for the topic that the permission grants access to.</p> <p>To get the topic name, make a <a href="/docs/managed-kafka/api-ref/Topic/list">list</a> request.</p> 
userSpecs[].<br>permissions[].<br>role | **string**<br><p>Access role type to grant to the user.</p> <ul> <li>ACCESS_ROLE_PRODUCER: producer role for the user.</li> <li>ACCESS_ROLE_CONSUMER: consumer role for the user.</li> <li>ACCESS_ROLE_ADMIN: admin role for the user.</li> </ul> 
userSpecs[].<br>permissions[].<br>allowHosts[] | **string**<br><p>Lists hosts allowed for this permission. When not defined, access from any host is allowed.</p> <p>Bare in mind that the same host might appear in multiple permissions at the same time, hence removing individual permission doesn't automatically restricts access from the ``allowHosts`` of the permission. If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed.</p> 
networkId | **string**<br><p>ID of the network to create the Apache Kafka® cluster in.</p> <p>The maximum string length in characters is 50.</p> 
subnetId[] | **string**<br><p>IDs of subnets to create brokers in.</p> 
securityGroupIds[] | **string**<br><p>User security groups</p> 
hostGroupIds[] | **string**<br><p>Host groups to place VMs of cluster on.</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
maintenanceWindow | **object**<br><p>Window of maintenance operations.</p> 
maintenanceWindow.<br>anytime | **object** <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow | **object** <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC.</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 