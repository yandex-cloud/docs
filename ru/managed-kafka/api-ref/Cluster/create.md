---
editable: false
sourcePath: en/_api-ref/mdb/kafka/v1/api-ref/Cluster/create.md
---

# Managed Service for Apache Kafka® API, REST: Cluster.Create

Creates a new Apache Kafka® cluster in the specified folder.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-kafka/v1/clusters
```

## Body parameters {#yandex.cloud.mdb.kafka.v1.CreateClusterRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "environment": "string",
  "configSpec": {
    "version": "string",
    "kafka": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },
      // Includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`
      "kafkaConfig_2_8": {
        "compressionType": "string",
        "logFlushIntervalMessages": "string",
        "logFlushIntervalMs": "string",
        "logFlushSchedulerIntervalMs": "string",
        "logRetentionBytes": "string",
        "logRetentionHours": "string",
        "logRetentionMinutes": "string",
        "logRetentionMs": "string",
        "logSegmentBytes": "string",
        "logPreallocate": "boolean",
        "socketSendBufferBytes": "string",
        "socketReceiveBufferBytes": "string",
        "autoCreateTopicsEnable": "boolean",
        "numPartitions": "string",
        "defaultReplicationFactor": "string",
        "messageMaxBytes": "string",
        "replicaFetchMaxBytes": "string",
        "sslCipherSuites": [
          "string"
        ],
        "offsetsRetentionMinutes": "string",
        "saslEnabledMechanisms": [
          "string"
        ]
      },
      "kafkaConfig_3": {
        "compressionType": "string",
        "logFlushIntervalMessages": "string",
        "logFlushIntervalMs": "string",
        "logFlushSchedulerIntervalMs": "string",
        "logRetentionBytes": "string",
        "logRetentionHours": "string",
        "logRetentionMinutes": "string",
        "logRetentionMs": "string",
        "logSegmentBytes": "string",
        "logPreallocate": "boolean",
        "socketSendBufferBytes": "string",
        "socketReceiveBufferBytes": "string",
        "autoCreateTopicsEnable": "boolean",
        "numPartitions": "string",
        "defaultReplicationFactor": "string",
        "messageMaxBytes": "string",
        "replicaFetchMaxBytes": "string",
        "sslCipherSuites": [
          "string"
        ],
        "offsetsRetentionMinutes": "string",
        "saslEnabledMechanisms": [
          "string"
        ]
      }
      // end of the list of possible fields
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
    "brokersCount": "string",
    "assignPublicIp": "boolean",
    "unmanagedTopics": "boolean",
    "schemaRegistry": "boolean",
    "access": {
      "dataTransfer": "boolean"
    },
    "restApiConfig": {
      "enabled": "boolean"
    },
    "diskSizeAutoscaling": {
      "plannedUsageThreshold": "string",
      "emergencyUsageThreshold": "string",
      "diskSizeLimit": "string"
    },
    "kraft": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      }
    }
  },
  "topicSpecs": [
    {
      "name": "string",
      "partitions": "string",
      "replicationFactor": "string",
      // Includes only one of the fields `topicConfig_2_8`, `topicConfig_3`
      "topicConfig_2_8": {
        "cleanupPolicy": "string",
        "compressionType": "string",
        "deleteRetentionMs": "string",
        "fileDeleteDelayMs": "string",
        "flushMessages": "string",
        "flushMs": "string",
        "minCompactionLagMs": "string",
        "retentionBytes": "string",
        "retentionMs": "string",
        "maxMessageBytes": "string",
        "minInsyncReplicas": "string",
        "segmentBytes": "string",
        "preallocate": "boolean"
      },
      "topicConfig_3": {
        "cleanupPolicy": "string",
        "compressionType": "string",
        "deleteRetentionMs": "string",
        "fileDeleteDelayMs": "string",
        "flushMessages": "string",
        "flushMs": "string",
        "minCompactionLagMs": "string",
        "retentionBytes": "string",
        "retentionMs": "string",
        "maxMessageBytes": "string",
        "minInsyncReplicas": "string",
        "segmentBytes": "string",
        "preallocate": "boolean"
      }
      // end of the list of possible fields
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
  "deletionProtection": "boolean",
  "maintenanceWindow": {
    // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": "object",
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create the Apache Kafka® cluster in.

To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| name | **string**

Required field. Name of the Apache Kafka® cluster. The name must be unique within the folder. ||
|| description | **string**

Description of the Apache Kafka® cluster. ||
|| labels | **string**

Custom labels for the Apache Kafka® cluster as `key:value` pairs.

For example, "project": "mvp" or "source": "dictionary". ||
|| environment | **enum** (Environment)

Deployment environment of the Apache Kafka® cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility. ||
|| configSpec | **[ConfigSpec](#yandex.cloud.mdb.kafka.v1.ConfigSpec)**

Kafka and hosts configuration the Apache Kafka® cluster. ||
|| topicSpecs[] | **[TopicSpec](#yandex.cloud.mdb.kafka.v1.TopicSpec)**

One or more configurations of topics to be created in the Apache Kafka® cluster. ||
|| userSpecs[] | **[UserSpec](#yandex.cloud.mdb.kafka.v1.UserSpec)**

Configurations of accounts to be created in the Apache Kafka® cluster. ||
|| networkId | **string**

ID of the network to create the Apache Kafka® cluster in. ||
|| subnetId[] | **string**

IDs of subnets to create brokers in. ||
|| securityGroupIds[] | **string**

User security groups ||
|| hostGroupIds[] | **string**

Host groups to place VMs of cluster on. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.kafka.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|#

## ConfigSpec {#yandex.cloud.mdb.kafka.v1.ConfigSpec}

#|
||Field | Description ||
|| version | **string**

Version of Apache Kafka® used in the cluster. Possible values: `2.8`, `3.0`, `3.1`, `3.2`, `3.3`, `3.4`, `3.5`, `3.6`. ||
|| kafka | **[Kafka](#yandex.cloud.mdb.kafka.v1.ConfigSpec.Kafka)**

Configuration and resource allocation for Kafka brokers. ||
|| zookeeper | **[Zookeeper](#yandex.cloud.mdb.kafka.v1.ConfigSpec.Zookeeper)**

Configuration and resource allocation for ZooKeeper hosts. ||
|| zoneId[] | **string**

IDs of availability zones where Kafka brokers reside. ||
|| brokersCount | **string** (int64)

The number of Kafka brokers deployed in each availability zone. ||
|| assignPublicIp | **boolean**

The flag that defines whether a public IP address is assigned to the cluster.
If the value is `true`, then Apache Kafka® cluster is available on the Internet via it's public IP address. ||
|| unmanagedTopics | **boolean**

Allows to manage topics via AdminAPI
Deprecated. Feature enabled permanently. ||
|| schemaRegistry | **boolean**

Enables managed schema registry on cluster ||
|| access | **[Access](#yandex.cloud.mdb.kafka.v1.Access)**

Access policy for external services. ||
|| restApiConfig | **[RestAPIConfig](#yandex.cloud.mdb.kafka.v1.ConfigSpec.RestAPIConfig)**

Configuration of REST API. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.kafka.v1.DiskSizeAutoscaling)**

DiskSizeAutoscaling settings ||
|| kraft | **[KRaft](#yandex.cloud.mdb.kafka.v1.ConfigSpec.KRaft)**

Configuration and resource allocation for KRaft-controller hosts. ||
|#

## Kafka {#yandex.cloud.mdb.kafka.v1.ConfigSpec.Kafka}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.kafka.v1.Resources)**

Resources allocated to Kafka brokers. ||
|| kafkaConfig_2_8 | **[KafkaConfig2_8](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8)**

Includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`.

Kafka broker configuration. ||
|| kafkaConfig_3 | **[KafkaConfig3](#yandex.cloud.mdb.kafka.v1.KafkaConfig3)**

Includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`.

Kafka broker configuration. ||
|#

## Resources {#yandex.cloud.mdb.kafka.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory, etc.).
All available presets are listed in the [documentation](/docs/managed-kafka/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted. ||
|| diskTypeId | **string**

Type of the storage environment for the host. ||
|#

## KafkaConfig2_8 {#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8}

Kafka version 2.8 broker configuration.

#|
||Field | Description ||
|| compressionType | **enum** (CompressionType)

Cluster topics compression type.

- `COMPRESSION_TYPE_UNSPECIFIED`
- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| logFlushIntervalMessages | **string** (int64)

The number of messages accumulated on a log partition before messages are flushed to disk.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flushMessages](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logFlushIntervalMs | **string** (int64)

The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk.
If not set, the value of `logFlushSchedulerIntervalMs` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flushMs](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logFlushSchedulerIntervalMs | **string** (int64)

The frequency of checks (in milliseconds) for any logs that need to be flushed to disk.
This check is done by the log flusher. ||
|| logRetentionBytes | **string** (int64)

Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig2_8.cleanupPolicy](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) is in effect.
This setting is helpful if you need to control the size of a log due to limited disk space.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retentionBytes](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logRetentionHours | **string** (int64)

The number of hours to keep a log segment file before deleting it. ||
|| logRetentionMinutes | **string** (int64)

The number of minutes to keep a log segment file before deleting it.

If not set, the value of `logRetentionHours` is used. ||
|| logRetentionMs | **string** (int64)

The number of milliseconds to keep a log segment file before deleting it.

If not set, the value of `logRetentionMinutes` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retentionMs](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logSegmentBytes | **string** (int64)

The maximum size of a single log file.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segmentBytes](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logPreallocate | **boolean**

Should pre allocate file when create new segment?

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| socketSendBufferBytes | **string** (int64)

The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. ||
|| socketReceiveBufferBytes | **string** (int64)

The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. ||
|| autoCreateTopicsEnable | **boolean**

Enable auto creation of topic on the server ||
|| numPartitions | **string** (int64)

Default number of partitions per topic on the whole cluster ||
|| defaultReplicationFactor | **string** (int64)

Default replication factor of the topic on the whole cluster ||
|| messageMaxBytes | **string** (int64)

The largest record batch size allowed by Kafka. Default value: 1048588. ||
|| replicaFetchMaxBytes | **string** (int64)

The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. ||
|| sslCipherSuites[] | **string**

A list of cipher suites. ||
|| offsetsRetentionMinutes | **string** (int64)

Offset storage time after a consumer group loses all its consumers. Default: 10080. ||
|| saslEnabledMechanisms[] | **enum** (SaslMechanism)

The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512].

- `SASL_MECHANISM_UNSPECIFIED`
- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|#

## KafkaConfig3 {#yandex.cloud.mdb.kafka.v1.KafkaConfig3}

Kafka version 3.x broker configuration.

#|
||Field | Description ||
|| compressionType | **enum** (CompressionType)

Cluster topics compression type.

- `COMPRESSION_TYPE_UNSPECIFIED`
- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| logFlushIntervalMessages | **string** (int64)

The number of messages accumulated on a log partition before messages are flushed to disk.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flushMessages](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logFlushIntervalMs | **string** (int64)

The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk.
If not set, the value of `logFlushSchedulerIntervalMs` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flushMs](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logFlushSchedulerIntervalMs | **string** (int64)

The frequency of checks (in milliseconds) for any logs that need to be flushed to disk.
This check is done by the log flusher. ||
|| logRetentionBytes | **string** (int64)

Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig3.cleanupPolicy](#yandex.cloud.mdb.kafka.v1.TopicConfig3) is in effect.
This setting is helpful if you need to control the size of a log due to limited disk space.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retentionBytes](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logRetentionHours | **string** (int64)

The number of hours to keep a log segment file before deleting it. ||
|| logRetentionMinutes | **string** (int64)

The number of minutes to keep a log segment file before deleting it.

If not set, the value of `logRetentionHours` is used. ||
|| logRetentionMs | **string** (int64)

The number of milliseconds to keep a log segment file before deleting it.

If not set, the value of `logRetentionMinutes` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retentionMs](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logSegmentBytes | **string** (int64)

The maximum size of a single log file.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segmentBytes](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logPreallocate | **boolean**

Should pre allocate file when create new segment?

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| socketSendBufferBytes | **string** (int64)

The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. ||
|| socketReceiveBufferBytes | **string** (int64)

The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. ||
|| autoCreateTopicsEnable | **boolean**

Enable auto creation of topic on the server ||
|| numPartitions | **string** (int64)

Default number of partitions per topic on the whole cluster ||
|| defaultReplicationFactor | **string** (int64)

Default replication factor of the topic on the whole cluster ||
|| messageMaxBytes | **string** (int64)

The largest record batch size allowed by Kafka. Default value: 1048588. ||
|| replicaFetchMaxBytes | **string** (int64)

The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. ||
|| sslCipherSuites[] | **string**

A list of cipher suites. ||
|| offsetsRetentionMinutes | **string** (int64)

Offset storage time after a consumer group loses all its consumers. Default: 10080. ||
|| saslEnabledMechanisms[] | **enum** (SaslMechanism)

The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512].

- `SASL_MECHANISM_UNSPECIFIED`
- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|#

## Zookeeper {#yandex.cloud.mdb.kafka.v1.ConfigSpec.Zookeeper}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.kafka.v1.Resources)**

Resources allocated to ZooKeeper hosts. ||
|#

## Access {#yandex.cloud.mdb.kafka.v1.Access}

#|
||Field | Description ||
|| dataTransfer | **boolean**

Allow access for DataTransfer. ||
|#

## RestAPIConfig {#yandex.cloud.mdb.kafka.v1.ConfigSpec.RestAPIConfig}

#|
||Field | Description ||
|| enabled | **boolean**

Is REST API enabled for this cluster. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.kafka.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold. ||
|| emergencyUsageThreshold | **string** (int64)

Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold. ||
|| diskSizeLimit | **string** (int64)

New storage size (in bytes) that is set when one of the thresholds is achieved. ||
|#

## KRaft {#yandex.cloud.mdb.kafka.v1.ConfigSpec.KRaft}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.kafka.v1.Resources)**

Resources allocated to KRaft controller hosts. ||
|#

## TopicSpec {#yandex.cloud.mdb.kafka.v1.TopicSpec}

#|
||Field | Description ||
|| name | **string**

Name of the topic. ||
|| partitions | **string** (int64)

The number of the topic's partitions. ||
|| replicationFactor | **string** (int64)

Amount of copies of a topic data kept in the cluster. ||
|| topicConfig_2_8 | **[TopicConfig2_8](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8)**

Includes only one of the fields `topicConfig_2_8`, `topicConfig_3`.

User-defined settings for the topic. ||
|| topicConfig_3 | **[TopicConfig3](#yandex.cloud.mdb.kafka.v1.TopicConfig3)**

Includes only one of the fields `topicConfig_2_8`, `topicConfig_3`.

User-defined settings for the topic. ||
|#

## TopicConfig2_8 {#yandex.cloud.mdb.kafka.v1.TopicConfig2_8}

A topic settings for 2.8

#|
||Field | Description ||
|| cleanupPolicy | **enum** (CleanupPolicy)

Retention policy to use on old log messages.

- `CLEANUP_POLICY_UNSPECIFIED`
- `CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_8.logRetentionMs](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) and other similar parameters.
- `CLEANUP_POLICY_COMPACT`: This policy compacts messages in log.
- `CLEANUP_POLICY_COMPACT_AND_DELETE`: This policy use both compaction and deletion for messages and log segments. ||
|| compressionType | **enum** (CompressionType)

The compression type for a given topic.

- `COMPRESSION_TYPE_UNSPECIFIED`
- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| deleteRetentionMs | **string** (int64)

The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. ||
|| fileDeleteDelayMs | **string** (int64)

The time to wait before deleting a file from the filesystem. ||
|| flushMessages | **string** (int64)

The number of messages accumulated on a log partition before messages are flushed to disk.

This setting overrides the cluster-level [KafkaConfig2_8.logFlushIntervalMessages](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| flushMs | **string** (int64)

The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.

This setting overrides the cluster-level [KafkaConfig2_8.logFlushIntervalMs](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| minCompactionLagMs | **string** (int64)

The minimum time in milliseconds a message will remain uncompacted in the log. ||
|| retentionBytes | **string** (int64)

The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanupPolicy` is in effect.
It is helpful if you need to control the size of log due to limited disk space.

This setting overrides the cluster-level [KafkaConfig2_8.logRetentionBytes](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| retentionMs | **string** (int64)

The number of milliseconds to keep a log segment's file before deleting it.

This setting overrides the cluster-level [KafkaConfig2_8.logRetentionMs](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| maxMessageBytes | **string** (int64)

The largest record batch size allowed in topic. ||
|| minInsyncReplicas | **string** (int64)

This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write
to be considered successful (when a producer sets acks to "all"). ||
|| segmentBytes | **string** (int64)

This configuration controls the segment file size for the log. Retention and cleaning is always done a file
at a time so a larger segment size means fewer files but less granular control over retention.

This setting overrides the cluster-level [KafkaConfig2_8.logSegmentBytes](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| preallocate | **boolean**

True if we should preallocate the file on disk when creating a new log segment.

This setting overrides the cluster-level [KafkaConfig2_8.logPreallocate](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|#

## TopicConfig3 {#yandex.cloud.mdb.kafka.v1.TopicConfig3}

A topic settings for 3.x

#|
||Field | Description ||
|| cleanupPolicy | **enum** (CleanupPolicy)

Retention policy to use on old log messages.

- `CLEANUP_POLICY_UNSPECIFIED`
- `CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig3.logRetentionMs](#yandex.cloud.mdb.kafka.v1.KafkaConfig3) and other similar parameters.
- `CLEANUP_POLICY_COMPACT`: This policy compacts messages in log.
- `CLEANUP_POLICY_COMPACT_AND_DELETE`: This policy use both compaction and deletion for messages and log segments. ||
|| compressionType | **enum** (CompressionType)

The compression type for a given topic.

- `COMPRESSION_TYPE_UNSPECIFIED`
- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| deleteRetentionMs | **string** (int64)

The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. ||
|| fileDeleteDelayMs | **string** (int64)

The time to wait before deleting a file from the filesystem. ||
|| flushMessages | **string** (int64)

The number of messages accumulated on a log partition before messages are flushed to disk.

This setting overrides the cluster-level [KafkaConfig3.logFlushIntervalMessages](#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| flushMs | **string** (int64)

The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.

This setting overrides the cluster-level [KafkaConfig3.logFlushIntervalMs](#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| minCompactionLagMs | **string** (int64)

The minimum time in milliseconds a message will remain uncompacted in the log. ||
|| retentionBytes | **string** (int64)

The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanupPolicy` is in effect.
It is helpful if you need to control the size of log due to limited disk space.

This setting overrides the cluster-level [KafkaConfig3.logRetentionBytes](#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| retentionMs | **string** (int64)

The number of milliseconds to keep a log segment's file before deleting it.

This setting overrides the cluster-level [KafkaConfig3.logRetentionMs](#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| maxMessageBytes | **string** (int64)

The largest record batch size allowed in topic. ||
|| minInsyncReplicas | **string** (int64)

This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write
to be considered successful (when a producer sets acks to "all"). ||
|| segmentBytes | **string** (int64)

This configuration controls the segment file size for the log. Retention and cleaning is always done a file
at a time so a larger segment size means fewer files but less granular control over retention.

This setting overrides the cluster-level [KafkaConfig3.logSegmentBytes](#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| preallocate | **boolean**

True if we should preallocate the file on disk when creating a new log segment.

This setting overrides the cluster-level [KafkaConfig3.logPreallocate](#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|#

## UserSpec {#yandex.cloud.mdb.kafka.v1.UserSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the Kafka user. ||
|| password | **string**

Required field. Password of the Kafka user. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.kafka.v1.Permission)**

Set of permissions granted to the user. ||
|#

## Permission {#yandex.cloud.mdb.kafka.v1.Permission}

#|
||Field | Description ||
|| topicName | **string**

Name or prefix-pattern with wildcard for the topic that the permission grants access to.

To get the topic name, make a [TopicService.List](/docs/managed-kafka/api-ref/Topic/list#List) request. ||
|| role | **enum** (AccessRole)

Access role type to grant to the user.

- `ACCESS_ROLE_UNSPECIFIED`
- `ACCESS_ROLE_PRODUCER`: Producer role for the user.
- `ACCESS_ROLE_CONSUMER`: Consumer role for the user.
- `ACCESS_ROLE_ADMIN`: Admin role for the user. ||
|| allowHosts[] | **string**

Lists hosts allowed for this permission.
Only ip-addresses allowed as value of single host.
When not defined, access from any host is allowed.

Bare in mind that the same host might appear in multiple permissions at the same time,
hence removing individual permission doesn't automatically restricts access from the `allowHosts` of the permission.
If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.kafka.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.kafka.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.kafka.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | **enum** (WeekDay)

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Hour of the day in UTC. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "string",
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
        // Includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`
        "kafkaConfig_2_8": {
          "compressionType": "string",
          "logFlushIntervalMessages": "string",
          "logFlushIntervalMs": "string",
          "logFlushSchedulerIntervalMs": "string",
          "logRetentionBytes": "string",
          "logRetentionHours": "string",
          "logRetentionMinutes": "string",
          "logRetentionMs": "string",
          "logSegmentBytes": "string",
          "logPreallocate": "boolean",
          "socketSendBufferBytes": "string",
          "socketReceiveBufferBytes": "string",
          "autoCreateTopicsEnable": "boolean",
          "numPartitions": "string",
          "defaultReplicationFactor": "string",
          "messageMaxBytes": "string",
          "replicaFetchMaxBytes": "string",
          "sslCipherSuites": [
            "string"
          ],
          "offsetsRetentionMinutes": "string",
          "saslEnabledMechanisms": [
            "string"
          ]
        },
        "kafkaConfig_3": {
          "compressionType": "string",
          "logFlushIntervalMessages": "string",
          "logFlushIntervalMs": "string",
          "logFlushSchedulerIntervalMs": "string",
          "logRetentionBytes": "string",
          "logRetentionHours": "string",
          "logRetentionMinutes": "string",
          "logRetentionMs": "string",
          "logSegmentBytes": "string",
          "logPreallocate": "boolean",
          "socketSendBufferBytes": "string",
          "socketReceiveBufferBytes": "string",
          "autoCreateTopicsEnable": "boolean",
          "numPartitions": "string",
          "defaultReplicationFactor": "string",
          "messageMaxBytes": "string",
          "replicaFetchMaxBytes": "string",
          "sslCipherSuites": [
            "string"
          ],
          "offsetsRetentionMinutes": "string",
          "saslEnabledMechanisms": [
            "string"
          ]
        }
        // end of the list of possible fields
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
      "brokersCount": "string",
      "assignPublicIp": "boolean",
      "unmanagedTopics": "boolean",
      "schemaRegistry": "boolean",
      "access": {
        "dataTransfer": "boolean"
      },
      "restApiConfig": {
        "enabled": "boolean"
      },
      "diskSizeAutoscaling": {
        "plannedUsageThreshold": "string",
        "emergencyUsageThreshold": "string",
        "diskSizeLimit": "string"
      },
      "kraft": {
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
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
    "deletionProtection": "boolean",
    "maintenanceWindow": {
      // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
      "anytime": "object",
      "weeklyMaintenanceWindow": {
        "day": "string",
        "hour": "string"
      }
      // end of the list of possible fields
    },
    "plannedOperation": {
      "info": "string",
      "delayedUntil": "string"
    }
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateClusterMetadata](#yandex.cloud.mdb.kafka.v1.CreateClusterMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Cluster](#yandex.cloud.mdb.kafka.v1.Cluster)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateClusterMetadata {#yandex.cloud.mdb.kafka.v1.CreateClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Apache Kafka® cluster that is being created. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Cluster {#yandex.cloud.mdb.kafka.v1.Cluster}

An Apache Kafka® cluster resource.
For more information, see the [Concepts](/docs/managed-kafka/concepts) section of the documentation.

#|
||Field | Description ||
|| id | **string**

ID of the Apache Kafka® cluster.
This ID is assigned at creation time. ||
|| folderId | **string**

ID of the folder that the Apache Kafka® cluster belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the Apache Kafka® cluster.
The name must be unique within the folder. 1-63 characters long. Value must match the regular expression `[a-zA-Z0-9_-]*`. ||
|| description | **string**

Description of the Apache Kafka® cluster. 0-256 characters long. ||
|| labels | **string**

Custom labels for the Apache Kafka® cluster as `key:value` pairs.
A maximum of 64 labels per resource is allowed. ||
|| environment | **enum** (Environment)

Deployment environment of the Apache Kafka® cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.kafka.v1.Monitoring)**

Description of monitoring systems relevant to the Apache Kafka® cluster.
* The field is ignored for response of List method. ||
|| config | **[ConfigSpec](#yandex.cloud.mdb.kafka.v1.ConfigSpec2)**

Configuration of the Apache Kafka® cluster.
* The field is ignored for response of List method. ||
|| networkId | **string**

ID of the network that the cluster belongs to. ||
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](/docs/managed-kafka/api-ref/Cluster/listHosts#yandex.cloud.mdb.kafka.v1.Host) of all hosts in the cluster is `UNKNOWN`).
- `ALIVE`: Cluster is alive and well ([Host.health](/docs/managed-kafka/api-ref/Cluster/listHosts#yandex.cloud.mdb.kafka.v1.Host) of all hosts in the cluster is `ALIVE`).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-kafka/api-ref/Cluster/listHosts#yandex.cloud.mdb.kafka.v1.Host) of all hosts in the cluster is `DEAD`).
- `DEGRADED`: Cluster is in degraded state ([Host.health](/docs/managed-kafka/api-ref/Cluster/listHosts#yandex.cloud.mdb.kafka.v1.Host) of at least one of the hosts in the cluster is not `ALIVE`). ||
|| status | **enum** (Status)

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| securityGroupIds[] | **string**

User security groups ||
|| hostGroupIds[] | **string**

Host groups hosting VMs of the cluster. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.kafka.v1.MaintenanceWindow2)**

Window of maintenance operations. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.kafka.v1.MaintenanceOperation)**

Scheduled maintenance operation. ||
|#

## Monitoring {#yandex.cloud.mdb.kafka.v1.Monitoring}

Metadata of monitoring system.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the Apache Kafka® cluster. ||
|#

## ConfigSpec {#yandex.cloud.mdb.kafka.v1.ConfigSpec2}

#|
||Field | Description ||
|| version | **string**

Version of Apache Kafka® used in the cluster. Possible values: `2.8`, `3.0`, `3.1`, `3.2`, `3.3`, `3.4`, `3.5`, `3.6`. ||
|| kafka | **[Kafka](#yandex.cloud.mdb.kafka.v1.ConfigSpec.Kafka2)**

Configuration and resource allocation for Kafka brokers. ||
|| zookeeper | **[Zookeeper](#yandex.cloud.mdb.kafka.v1.ConfigSpec.Zookeeper2)**

Configuration and resource allocation for ZooKeeper hosts. ||
|| zoneId[] | **string**

IDs of availability zones where Kafka brokers reside. ||
|| brokersCount | **string** (int64)

The number of Kafka brokers deployed in each availability zone. ||
|| assignPublicIp | **boolean**

The flag that defines whether a public IP address is assigned to the cluster.
If the value is `true`, then Apache Kafka® cluster is available on the Internet via it's public IP address. ||
|| unmanagedTopics | **boolean**

Allows to manage topics via AdminAPI
Deprecated. Feature enabled permanently. ||
|| schemaRegistry | **boolean**

Enables managed schema registry on cluster ||
|| access | **[Access](#yandex.cloud.mdb.kafka.v1.Access2)**

Access policy for external services. ||
|| restApiConfig | **[RestAPIConfig](#yandex.cloud.mdb.kafka.v1.ConfigSpec.RestAPIConfig2)**

Configuration of REST API. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.kafka.v1.DiskSizeAutoscaling2)**

DiskSizeAutoscaling settings ||
|| kraft | **[KRaft](#yandex.cloud.mdb.kafka.v1.ConfigSpec.KRaft2)**

Configuration and resource allocation for KRaft-controller hosts. ||
|#

## Kafka {#yandex.cloud.mdb.kafka.v1.ConfigSpec.Kafka2}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.kafka.v1.Resources2)**

Resources allocated to Kafka brokers. ||
|| kafkaConfig_2_8 | **[KafkaConfig2_8](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_82)**

Includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`.

Kafka broker configuration. ||
|| kafkaConfig_3 | **[KafkaConfig3](#yandex.cloud.mdb.kafka.v1.KafkaConfig32)**

Includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`.

Kafka broker configuration. ||
|#

## Resources {#yandex.cloud.mdb.kafka.v1.Resources2}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory, etc.).
All available presets are listed in the [documentation](/docs/managed-kafka/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted. ||
|| diskTypeId | **string**

Type of the storage environment for the host. ||
|#

## KafkaConfig2_8 {#yandex.cloud.mdb.kafka.v1.KafkaConfig2_82}

Kafka version 2.8 broker configuration.

#|
||Field | Description ||
|| compressionType | **enum** (CompressionType)

Cluster topics compression type.

- `COMPRESSION_TYPE_UNSPECIFIED`
- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| logFlushIntervalMessages | **string** (int64)

The number of messages accumulated on a log partition before messages are flushed to disk.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flushMessages](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logFlushIntervalMs | **string** (int64)

The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk.
If not set, the value of `logFlushSchedulerIntervalMs` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flushMs](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logFlushSchedulerIntervalMs | **string** (int64)

The frequency of checks (in milliseconds) for any logs that need to be flushed to disk.
This check is done by the log flusher. ||
|| logRetentionBytes | **string** (int64)

Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig2_8.cleanupPolicy](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) is in effect.
This setting is helpful if you need to control the size of a log due to limited disk space.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retentionBytes](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logRetentionHours | **string** (int64)

The number of hours to keep a log segment file before deleting it. ||
|| logRetentionMinutes | **string** (int64)

The number of minutes to keep a log segment file before deleting it.

If not set, the value of `logRetentionHours` is used. ||
|| logRetentionMs | **string** (int64)

The number of milliseconds to keep a log segment file before deleting it.

If not set, the value of `logRetentionMinutes` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retentionMs](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logSegmentBytes | **string** (int64)

The maximum size of a single log file.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segmentBytes](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logPreallocate | **boolean**

Should pre allocate file when create new segment?

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| socketSendBufferBytes | **string** (int64)

The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. ||
|| socketReceiveBufferBytes | **string** (int64)

The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. ||
|| autoCreateTopicsEnable | **boolean**

Enable auto creation of topic on the server ||
|| numPartitions | **string** (int64)

Default number of partitions per topic on the whole cluster ||
|| defaultReplicationFactor | **string** (int64)

Default replication factor of the topic on the whole cluster ||
|| messageMaxBytes | **string** (int64)

The largest record batch size allowed by Kafka. Default value: 1048588. ||
|| replicaFetchMaxBytes | **string** (int64)

The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. ||
|| sslCipherSuites[] | **string**

A list of cipher suites. ||
|| offsetsRetentionMinutes | **string** (int64)

Offset storage time after a consumer group loses all its consumers. Default: 10080. ||
|| saslEnabledMechanisms[] | **enum** (SaslMechanism)

The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512].

- `SASL_MECHANISM_UNSPECIFIED`
- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|#

## KafkaConfig3 {#yandex.cloud.mdb.kafka.v1.KafkaConfig32}

Kafka version 3.x broker configuration.

#|
||Field | Description ||
|| compressionType | **enum** (CompressionType)

Cluster topics compression type.

- `COMPRESSION_TYPE_UNSPECIFIED`
- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| logFlushIntervalMessages | **string** (int64)

The number of messages accumulated on a log partition before messages are flushed to disk.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flushMessages](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logFlushIntervalMs | **string** (int64)

The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk.
If not set, the value of `logFlushSchedulerIntervalMs` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flushMs](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logFlushSchedulerIntervalMs | **string** (int64)

The frequency of checks (in milliseconds) for any logs that need to be flushed to disk.
This check is done by the log flusher. ||
|| logRetentionBytes | **string** (int64)

Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig3.cleanupPolicy](#yandex.cloud.mdb.kafka.v1.TopicConfig3) is in effect.
This setting is helpful if you need to control the size of a log due to limited disk space.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retentionBytes](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logRetentionHours | **string** (int64)

The number of hours to keep a log segment file before deleting it. ||
|| logRetentionMinutes | **string** (int64)

The number of minutes to keep a log segment file before deleting it.

If not set, the value of `logRetentionHours` is used. ||
|| logRetentionMs | **string** (int64)

The number of milliseconds to keep a log segment file before deleting it.

If not set, the value of `logRetentionMinutes` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retentionMs](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logSegmentBytes | **string** (int64)

The maximum size of a single log file.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segmentBytes](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logPreallocate | **boolean**

Should pre allocate file when create new segment?

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| socketSendBufferBytes | **string** (int64)

The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. ||
|| socketReceiveBufferBytes | **string** (int64)

The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. ||
|| autoCreateTopicsEnable | **boolean**

Enable auto creation of topic on the server ||
|| numPartitions | **string** (int64)

Default number of partitions per topic on the whole cluster ||
|| defaultReplicationFactor | **string** (int64)

Default replication factor of the topic on the whole cluster ||
|| messageMaxBytes | **string** (int64)

The largest record batch size allowed by Kafka. Default value: 1048588. ||
|| replicaFetchMaxBytes | **string** (int64)

The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. ||
|| sslCipherSuites[] | **string**

A list of cipher suites. ||
|| offsetsRetentionMinutes | **string** (int64)

Offset storage time after a consumer group loses all its consumers. Default: 10080. ||
|| saslEnabledMechanisms[] | **enum** (SaslMechanism)

The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512].

- `SASL_MECHANISM_UNSPECIFIED`
- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|#

## Zookeeper {#yandex.cloud.mdb.kafka.v1.ConfigSpec.Zookeeper2}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.kafka.v1.Resources2)**

Resources allocated to ZooKeeper hosts. ||
|#

## Access {#yandex.cloud.mdb.kafka.v1.Access2}

#|
||Field | Description ||
|| dataTransfer | **boolean**

Allow access for DataTransfer. ||
|#

## RestAPIConfig {#yandex.cloud.mdb.kafka.v1.ConfigSpec.RestAPIConfig2}

#|
||Field | Description ||
|| enabled | **boolean**

Is REST API enabled for this cluster. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.kafka.v1.DiskSizeAutoscaling2}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold. ||
|| emergencyUsageThreshold | **string** (int64)

Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold. ||
|| diskSizeLimit | **string** (int64)

New storage size (in bytes) that is set when one of the thresholds is achieved. ||
|#

## KRaft {#yandex.cloud.mdb.kafka.v1.ConfigSpec.KRaft2}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.kafka.v1.Resources2)**

Resources allocated to KRaft controller hosts. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.kafka.v1.MaintenanceWindow2}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.kafka.v1.WeeklyMaintenanceWindow2)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.kafka.v1.WeeklyMaintenanceWindow2}

#|
||Field | Description ||
|| day | **enum** (WeekDay)

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Hour of the day in UTC. ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.kafka.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string** ||
|| delayedUntil | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#