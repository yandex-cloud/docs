---
editable: false
sourcePath: en/_api-ref/mdb/kafka/v1/api-ref/Cluster/index.md
---

# Managed Service for Apache Kafka® API, REST: Cluster methods
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

      // `config.kafka` includes only one of the fields `kafkaConfig_2_1`, `kafkaConfig_2_6`, `kafkaConfig_2_8`, `kafkaConfig_3`
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
        "offsetsRetentionMinutes": "integer"
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
        "offsetsRetentionMinutes": "integer"
      },
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
  "networkId": "string",
  "health": "string",
  "status": "string",
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

  },
  "plannedOperation": {
    "info": "string",
    "delayedUntil": "string"
  }
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the Apache Kafka® cluster. This ID is assigned at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the Apache Kafka® cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the Apache Kafka® cluster. The name must be unique within the folder. 1-63 characters long. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
description | **string**<br><p>Description of the Apache Kafka® cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Custom labels for the Apache Kafka® cluster as ``key:value`` pairs. A maximum of 64 labels per resource is allowed.</p> 
environment | **string**<br><p>Deployment environment of the Apache Kafka® cluster.</p> <ul> <li>PRODUCTION: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li> </ul> 
monitoring[] | **object**<br><p>Description of monitoring systems relevant to the Apache Kafka® cluster.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the Apache Kafka® cluster.</p> 
config | **object**<br><p>Configuration of the Apache Kafka® cluster.</p> 
config.<br>version | **string**<br><p>Version of Apache Kafka® used in the cluster. Possible values: ``2.1``, ``2.6``.</p> 
config.<br>kafka | **object**<br><p>Configuration and resource allocation for Kafka brokers.</p> 
config.<br>kafka.<br>resources | **object**
config.<br>kafka.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
config.<br>kafka.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted.</p> 
config.<br>kafka.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
config.<br>kafka.<br>kafkaConfig_2_1 | **object** <br>`config.kafka` includes only one of the fields `kafkaConfig_2_1`, `kafkaConfig_2_6`, `kafkaConfig_2_8`, `kafkaConfig_3`<br><br><p>Deprecated. Version ``2.1`` of Kafka not supported in Yandex Cloud.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>compressionType | **string**<br><p>Cluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of ``ZSTD``, ``LZ4``, ``GZIP`` or ``SNAPPY`` codecs).</li> </ul> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMessages`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of ``logFlushSchedulerIntervalMs`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMs`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if ``delete`` ``cleanupPolicy`` is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionBytes`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionHours`` is used.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionMinutes`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionMs`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logSegmentBytes | **integer** (int64)<br><p>The maximum size of a single log file.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``segmentBytes`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logPreallocate | **boolean** (boolean)<br><p>Should pre allocate file when create new segment?</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``preallocate`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>socketSendBufferBytes | **integer** (int64)<br><p>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>socketReceiveBufferBytes | **integer** (int64)<br><p>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>autoCreateTopicsEnable | **boolean** (boolean)<br><p>Enable auto creation of topic on the server</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>numPartitions | **integer** (int64)<br><p>Default number of partitions per topic on the whole cluster</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>defaultReplicationFactor | **integer** (int64)<br><p>Default replication factor of the topic on the whole cluster</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>messageMaxBytes | **integer** (int64)<br><p>The largest record batch size allowed by Kafka. Default value: 1048588.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>replicaFetchMaxBytes | **integer** (int64)<br><p>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>sslCipherSuites[] | **string**<br><p>A list of cipher suites.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>offsetsRetentionMinutes | **integer** (int64)<br><p>Offset storage time after a consumer group loses all its consumers. Default: 10080.</p> 
config.<br>kafka.<br>kafkaConfig_2_6 | **object** <br>`config.kafka` includes only one of the fields `kafkaConfig_2_1`, `kafkaConfig_2_6`, `kafkaConfig_2_8`, `kafkaConfig_3`<br><br><p>Deprecated. Version ``2.6`` of Kafka not supported in Yandex Cloud.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>compressionType | **string**<br><p>Cluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of ``ZSTD``, ``LZ4``, ``GZIP`` or ``SNAPPY`` codecs).</li> </ul> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMessages`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of ``logFlushSchedulerIntervalMs`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMs`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if ``delete`` ``cleanupPolicy`` is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionBytes`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionHours`` is used.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionMinutes`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionMs`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logSegmentBytes | **integer** (int64)<br><p>The maximum size of a single log file.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``segmentBytes`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logPreallocate | **boolean** (boolean)<br><p>Should pre allocate file when create new segment?</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``preallocate`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>socketSendBufferBytes | **integer** (int64)<br><p>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>socketReceiveBufferBytes | **integer** (int64)<br><p>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>autoCreateTopicsEnable | **boolean** (boolean)<br><p>Enable auto creation of topic on the server</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>numPartitions | **integer** (int64)<br><p>Default number of partitions per topic on the whole cluster</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>defaultReplicationFactor | **integer** (int64)<br><p>Default replication factor of the topic on the whole cluster</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>messageMaxBytes | **integer** (int64)<br><p>The largest record batch size allowed by Kafka. Default value: 1048588.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>replicaFetchMaxBytes | **integer** (int64)<br><p>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>sslCipherSuites[] | **string**<br><p>A list of cipher suites.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>offsetsRetentionMinutes | **integer** (int64)<br><p>Offset storage time after a consumer group loses all its consumers. Default: 10080.</p> 
config.<br>kafka.<br>kafkaConfig_2_8 | **object** <br>`config.kafka` includes only one of the fields `kafkaConfig_2_1`, `kafkaConfig_2_6`, `kafkaConfig_2_8`, `kafkaConfig_3`<br><br><p>Kafka version 2.8 broker configuration.</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>compressionType | **string**<br><p>Cluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of ``ZSTD``, ``LZ4``, ``GZIP`` or ``SNAPPY`` codecs).</li> </ul> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMessages`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of ``logFlushSchedulerIntervalMs`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMs`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if ``delete`` ``cleanupPolicy`` is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionBytes`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionHours`` is used.</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionMinutes`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionMs`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>logSegmentBytes | **integer** (int64)<br><p>The maximum size of a single log file.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``segmentBytes`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>logPreallocate | **boolean** (boolean)<br><p>Should pre allocate file when create new segment?</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``preallocate`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>socketSendBufferBytes | **integer** (int64)<br><p>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>socketReceiveBufferBytes | **integer** (int64)<br><p>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>autoCreateTopicsEnable | **boolean** (boolean)<br><p>Enable auto creation of topic on the server</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>numPartitions | **integer** (int64)<br><p>Default number of partitions per topic on the whole cluster</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>defaultReplicationFactor | **integer** (int64)<br><p>Default replication factor of the topic on the whole cluster</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>messageMaxBytes | **integer** (int64)<br><p>The largest record batch size allowed by Kafka. Default value: 1048588.</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>replicaFetchMaxBytes | **integer** (int64)<br><p>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576.</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>sslCipherSuites[] | **string**<br><p>A list of cipher suites.</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>offsetsRetentionMinutes | **integer** (int64)<br><p>Offset storage time after a consumer group loses all its consumers. Default: 10080.</p> 
config.<br>kafka.<br>kafkaConfig_2_8.<br>saslEnabledMechanisms[] | **string**<br><p>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512].</p> 
config.<br>kafka.<br>kafkaConfig_3 | **object** <br>`config.kafka` includes only one of the fields `kafkaConfig_2_1`, `kafkaConfig_2_6`, `kafkaConfig_2_8`, `kafkaConfig_3`<br><br><p>Kafka version 3.x broker configuration.</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>compressionType | **string**<br><p>Cluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of ``ZSTD``, ``LZ4``, ``GZIP`` or ``SNAPPY`` codecs).</li> </ul> 
config.<br>kafka.<br>kafkaConfig_3.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMessages`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of ``logFlushSchedulerIntervalMs`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``flushMs`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if ``delete`` ``cleanupPolicy`` is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionBytes`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionHours`` is used.</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of ``logRetentionMinutes`` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``retentionMs`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>logSegmentBytes | **integer** (int64)<br><p>The maximum size of a single log file.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``segmentBytes`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>logPreallocate | **boolean** (boolean)<br><p>Should pre allocate file when create new segment?</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the ``preallocate`` setting.</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>socketSendBufferBytes | **integer** (int64)<br><p>The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>socketReceiveBufferBytes | **integer** (int64)<br><p>The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used.</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>autoCreateTopicsEnable | **boolean** (boolean)<br><p>Enable auto creation of topic on the server</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>numPartitions | **integer** (int64)<br><p>Default number of partitions per topic on the whole cluster</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>defaultReplicationFactor | **integer** (int64)<br><p>Default replication factor of the topic on the whole cluster</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>messageMaxBytes | **integer** (int64)<br><p>The largest record batch size allowed by Kafka. Default value: 1048588.</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>replicaFetchMaxBytes | **integer** (int64)<br><p>The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576.</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>sslCipherSuites[] | **string**<br><p>A list of cipher suites.</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>offsetsRetentionMinutes | **integer** (int64)<br><p>Offset storage time after a consumer group loses all its consumers. Default: 10080.</p> 
config.<br>kafka.<br>kafkaConfig_3.<br>saslEnabledMechanisms[] | **string**<br><p>The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512].</p> 
config.<br>zookeeper | **object**<br><p>Configuration and resource allocation for ZooKeeper hosts.</p> 
config.<br>zookeeper.<br>resources | **object**<br><p>Resources allocated to ZooKeeper hosts.</p> 
config.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
config.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted.</p> 
config.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
config.<br>zoneId[] | **string**<br><p>IDs of availability zones where Kafka brokers reside.</p> 
config.<br>brokersCount | **integer** (int64)<br><p>The number of Kafka brokers deployed in each availability zone.</p> 
config.<br>assignPublicIp | **boolean** (boolean)<br><p>The flag that defines whether a public IP address is assigned to the cluster. If the value is ``true``, then Apache Kafka® cluster is available on the Internet via it's public IP address.</p> 
config.<br>unmanagedTopics | **boolean** (boolean)<br><p>Allows to manage topics via AdminAPI</p> 
config.<br>schemaRegistry | **boolean** (boolean)<br><p>Enables managed schema registry on cluster</p> 
config.<br>access | **object**<br><p>Access policy for external services.</p> 
config.<br>access.<br>dataTransfer | **boolean** (boolean)<br><p>Allow access for DataTransfer.</p> 
config.<br>restApiConfig | **object**<br><p>Configuration of REST API.</p> 
config.<br>restApiConfig.<br>enabled | **boolean** (boolean)<br><p>Is REST API enabled for this cluster.</p> 
networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: state of the cluster is unknown (``health`` of all hosts in the cluster is ``UNKNOWN``).</li> <li>ALIVE: cluster is alive and well (``health`` of all hosts in the cluster is ``ALIVE``).</li> <li>DEAD: cluster is inoperable (``health`` of all hosts in the cluster is ``DEAD``).</li> <li>DEGRADED: cluster is in degraded state (``health`` of at least one of the hosts in the cluster is not ``ALIVE``).</li> </ul> 
status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: cluster state is unknown.</li> <li>CREATING: cluster is being created.</li> <li>RUNNING: cluster is running normally.</li> <li>ERROR: cluster encountered a problem and cannot operate.</li> <li>UPDATING: cluster is being updated.</li> <li>STOPPING: cluster is stopping.</li> <li>STOPPED: cluster stopped.</li> <li>STARTING: cluster is starting.</li> </ul> 
securityGroupIds[] | **string**<br><p>User security groups</p> 
hostGroupIds[] | **string**<br><p>Host groups hosting VMs of the cluster.</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
maintenanceWindow | **object**<br><p>Window of maintenance operations.</p> 
maintenanceWindow.<br>anytime | **object** <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow | **object** <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC.</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
plannedOperation | **object**<br><p>Scheduled maintenance operation.</p> 
plannedOperation.<br>info | **string**<br><p>The maximum string length in characters is 256.</p> 
plannedOperation.<br>delayedUntil | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 

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
[rescheduleMaintenance](rescheduleMaintenance.md) | Reschedule planned maintenance operation.
[start](start.md) | Starts the specified Apache Kafka® cluster.
[stop](stop.md) | Stops the specified Apache Kafka® cluster.
[streamLogs](streamLogs.md) | Same as [listLogs](/docs/managed-kafka/api-ref/Cluster/listLogs) but using server-side streaming. Also allows for `tail -f` semantics.
[update](update.md) | Updates the specified Apache Kafka® cluster.