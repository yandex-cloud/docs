# Managed Service for Apache Kafka® API, REST: Cluster.Update

Updates the specified Apache Kafka® cluster.

## HTTP request

```
PATCH https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Apache Kafka® cluster to update.
To get the Apache Kafka® cluster ID, make a [ClusterService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.mdb.kafka.v1.UpdateClusterRequest}

```json
{
  "updateMask": "string",
  "description": "string",
  "labels": "object",
  "configSpec": {
    "version": "string",
    "kafka": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },
      // Includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`, `kafkaConfig_4`
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
        ],
        "transactionalIdExpirationMs": "string"
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
        ],
        "transactionalIdExpirationMs": "string"
      },
      "kafkaConfig_4": {
        "compressionType": "string",
        "logFlushIntervalMessages": "string",
        "logFlushIntervalMs": "string",
        "logFlushSchedulerIntervalMs": "string",
        "logRetentionBytes": "string",
        "logRetentionHours": "string",
        "logRetentionMinutes": "string",
        "logRetentionMs": "string",
        "logSegmentBytes": "string",
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
        ],
        "transactionalIdExpirationMs": "string"
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
    "kraft": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      }
    },
    "diskSizeAutoscaling": {
      "plannedUsageThreshold": "string",
      "emergencyUsageThreshold": "string",
      "diskSizeLimit": "string"
    },
    "kafkaUiConfig": {
      "enabled": "boolean"
    },
    "patchVersion": "string"
  },
  "name": "string",
  "securityGroupIds": [
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
  "networkId": "string",
  "subnetIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| description | **string**

New description of the Apache Kafka® cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Apache Kafka® cluster as `key:value` pairs.
For example, "project": "mvp" or "source": "dictionary".
The new set of labels will completely replace the old ones.
To add a label, request the current set with the [ClusterService.Get](get.md#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `. Each value must match the regular expression ` [-_./\@0-9a-z]* `. No more than 64 per resource. ||
|| configSpec | **[ConfigSpec](#yandex.cloud.mdb.kafka.v1.ConfigSpec)**

New configuration and resources for hosts in the Apache Kafka® cluster.
Use `updateMask` to prevent reverting all cluster settings that are not listed in `configSpec` to their default values. ||
|| name | **string**

New name for the Apache Kafka® cluster.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| securityGroupIds[] | **string**

User security groups ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.kafka.v1.MaintenanceWindow)**

New maintenance window settings for the cluster. ||
|| networkId | **string**

ID of the network to move the cluster to.

The maximum string length in characters is 50. ||
|| subnetIds[] | **string**

IDs of subnets where the hosts are located or a new host is being created ||
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
|| kraft | **[KRaft](#yandex.cloud.mdb.kafka.v1.ConfigSpec.KRaft)**

Configuration and resource allocation for KRaft-controller hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.kafka.v1.DiskSizeAutoscaling)**

DiskSizeAutoscaling settings ||
|| kafkaUiConfig | **[KafkaUIConfig](#yandex.cloud.mdb.kafka.v1.ConfigSpec.KafkaUIConfig)**

Configuration of Kafka UI. ||
|| patchVersion | **string**

Patch or release version ex. 3.9.1, 4.0.1 etc ||
|#

## Kafka {#yandex.cloud.mdb.kafka.v1.ConfigSpec.Kafka}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.kafka.v1.Resources)**

Resources allocated to Kafka brokers. ||
|| kafkaConfig_2_8 | **[KafkaConfig2_8](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8)**

Configuration of an Apache Kafka® 2.8 broker.

Includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`, `kafkaConfig_4`.

Kafka broker configuration. ||
|| kafkaConfig_3 | **[KafkaConfig3](#yandex.cloud.mdb.kafka.v1.KafkaConfig3)**

Configuration of an Apache Kafka® 3.x broker.

Includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`, `kafkaConfig_4`.

Kafka broker configuration. ||
|| kafkaConfig_4 | **[KafkaConfig4](#yandex.cloud.mdb.kafka.v1.KafkaConfig4)**

Configuration of an Apache Kafka® 4.x broker.

Includes only one of the fields `kafkaConfig_2_8`, `kafkaConfig_3`, `kafkaConfig_4`.

Kafka broker configuration. ||
|#

## Resources {#yandex.cloud.mdb.kafka.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory, etc.).
All available presets are listed in the [documentation](../../concepts/instance-types.md). ||
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

- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| logFlushIntervalMessages | **string** (int64)

The number of messages accumulated on a log partition before messages are flushed to disk.
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flushMessages](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logFlushIntervalMs | **string** (int64)

The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk.
If not set, the value of `logFlushSchedulerIntervalMs` is used.
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flushMs](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logFlushSchedulerIntervalMs | **string** (int64)

The frequency of checks (in milliseconds) for any logs that need to be flushed to disk.
This check is done by the log flusher. ||
|| logRetentionBytes | **string** (int64)

Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig2_8.cleanupPolicy](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) is in effect.
This setting is helpful if you need to control the size of a log due to limited disk space.
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retentionBytes](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logRetentionHours | **string** (int64)

The number of hours to keep a log segment file before deleting it. ||
|| logRetentionMinutes | **string** (int64)

The number of minutes to keep a log segment file before deleting it.
If not set, the value of `logRetentionHours` is used. ||
|| logRetentionMs | **string** (int64)

The number of milliseconds to keep a log segment file before deleting it.
If not set, the value of `logRetentionMinutes` is used.
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retentionMs](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logSegmentBytes | **string** (int64)

The maximum size of a single log file.
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segmentBytes](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logPreallocate | **boolean**

Should pre allocate file when create new segment?
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting.
Deprecated. Feature useless for Yandex Cloud. ||
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

- `SASL_MECHANISM_SCRAM_SHA_256`: SHA_256.
- `SASL_MECHANISM_SCRAM_SHA_512`: SHA_512. ||
|| transactionalIdExpirationMs | **string** (int64)

Timeout for transactional ids to expire in ms. Default: 604800000 (7 days). ||
|#

## KafkaConfig3 {#yandex.cloud.mdb.kafka.v1.KafkaConfig3}

Kafka version 3.x broker configuration.

#|
||Field | Description ||
|| compressionType | **enum** (CompressionType)

Cluster topics compression type.

- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| logFlushIntervalMessages | **string** (int64)

The number of messages accumulated on a log partition before messages are flushed to disk.
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flushMessages](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logFlushIntervalMs | **string** (int64)

The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk.
If not set, the value of `logFlushSchedulerIntervalMs` is used.
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flushMs](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logFlushSchedulerIntervalMs | **string** (int64)

The frequency of checks (in milliseconds) for any logs that need to be flushed to disk.
This check is done by the log flusher. ||
|| logRetentionBytes | **string** (int64)

Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig3.cleanupPolicy](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig3) is in effect.
This setting is helpful if you need to control the size of a log due to limited disk space.
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retentionBytes](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logRetentionHours | **string** (int64)

The number of hours to keep a log segment file before deleting it. ||
|| logRetentionMinutes | **string** (int64)

The number of minutes to keep a log segment file before deleting it.
If not set, the value of `logRetentionHours` is used. ||
|| logRetentionMs | **string** (int64)

The number of milliseconds to keep a log segment file before deleting it.
If not set, the value of `logRetentionMinutes` is used.
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retentionMs](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logSegmentBytes | **string** (int64)

The maximum size of a single log file.
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segmentBytes](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logPreallocate | **boolean**

Should pre allocate file when create new segment?
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting.
Deprecated. Feature useless for Yandex Cloud. ||
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

- `SASL_MECHANISM_SCRAM_SHA_256`: SHA_256.
- `SASL_MECHANISM_SCRAM_SHA_512`: SHA_512. ||
|| transactionalIdExpirationMs | **string** (int64)

Timeout for transactional ids to expire in ms. Default: 604800000 (7 days). ||
|#

## KafkaConfig4 {#yandex.cloud.mdb.kafka.v1.KafkaConfig4}

Kafka version 4.x broker configuration.

#|
||Field | Description ||
|| compressionType | **enum** (CompressionType)

Cluster topics compression type.

- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| logFlushIntervalMessages | **string** (int64)

The number of messages accumulated on a log partition before messages are flushed to disk.
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flushMessages](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logFlushIntervalMs | **string** (int64)

The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk.
If not set, the value of `logFlushSchedulerIntervalMs` is used.
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig4.flushMs](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig4) setting. ||
|| logFlushSchedulerIntervalMs | **string** (int64)

The frequency of checks (in milliseconds) for any logs that need to be flushed to disk.
This check is done by the log flusher. ||
|| logRetentionBytes | **string** (int64)

Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig4.cleanupPolicy](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig4) is in effect.
This setting is helpful if you need to control the size of a log due to limited disk space.
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retentionBytes](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logRetentionHours | **string** (int64)

The number of hours to keep a log segment file before deleting it. ||
|| logRetentionMinutes | **string** (int64)

The number of minutes to keep a log segment file before deleting it.
If not set, the value of `logRetentionHours` is used. ||
|| logRetentionMs | **string** (int64)

The number of milliseconds to keep a log segment file before deleting it.
If not set, the value of `logRetentionMinutes` is used.
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig4.retentionMs](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig4) setting. ||
|| logSegmentBytes | **string** (int64)

The maximum size of a single log file.
This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig4.segmentBytes](create.md#yandex.cloud.mdb.kafka.v1.TopicConfig4) setting. ||
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

- `SASL_MECHANISM_SCRAM_SHA_256`: SHA_256.
- `SASL_MECHANISM_SCRAM_SHA_512`: SHA_512. ||
|| transactionalIdExpirationMs | **string** (int64)

Timeout for transactional ids to expire in ms. Default: 604800000 (7 days). ||
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

## KRaft {#yandex.cloud.mdb.kafka.v1.ConfigSpec.KRaft}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.kafka.v1.Resources)**

Resources allocated to KRaft controller hosts. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.kafka.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold.

Acceptable values are 0 to 100, inclusive. ||
|| emergencyUsageThreshold | **string** (int64)

Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold.

Acceptable values are 0 to 100, inclusive. ||
|| diskSizeLimit | **string** (int64)

New storage size (in bytes) that is set when one of the thresholds is achieved. ||
|#

## KafkaUIConfig {#yandex.cloud.mdb.kafka.v1.ConfigSpec.KafkaUIConfig}

#|
||Field | Description ||
|| enabled | **boolean**

Is Kafka UI enabled for this cluster. ||
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

- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Hour of the day in UTC.

Acceptable values are 1 to 24, inclusive. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

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
|| metadata | **object**

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
|| response | **object**

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