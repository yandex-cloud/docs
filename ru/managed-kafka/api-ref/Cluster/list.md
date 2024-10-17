---
editable: false
sourcePath: en/_api-ref/mdb/kafka/v1/api-ref/Cluster/list.md
---

# Managed Service for Apache Kafka® API, REST: Cluster.List {#List}

Retrieves the list of Apache Kafka® clusters that belong to the specified folder.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-kafka/v1/clusters
```

## Query parameters {#yandex.cloud.mdb.kafka.v1.ListClustersRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list Apache Kafka® clusters in.

To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the service returns a [ListClustersResponse.nextPageToken](#yandex.cloud.mdb.kafka.v1.ListClustersResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.

To get the next page of results, set `pageToken` to the [ListClustersResponse.nextPageToken](#yandex.cloud.mdb.kafka.v1.ListClustersResponse) returned by the previous list request. ||
|| filter | **string**

Filter support is not currently implemented. Any filters are ignored. ||
|#

## Response {#yandex.cloud.mdb.kafka.v1.ListClustersResponse}

**HTTP Code: 200 - OK**

```json
{
  "clusters": [
    {
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| clusters[] | **[Cluster](#yandex.cloud.mdb.kafka.v1.Cluster)**

List of Apache Kafka® clusters. ||
|| nextPageToken | **string**

Token that allows you to get the next page of results for list requests.

If the number of results is larger than [ListClustersRequest.pageSize](#yandex.cloud.mdb.kafka.v1.ListClustersRequest), use `nextPageToken` as the value for the [ListClustersRequest.pageToken](#yandex.cloud.mdb.kafka.v1.ListClustersRequest) parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
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
|| config | **[ConfigSpec](#yandex.cloud.mdb.kafka.v1.ConfigSpec)**

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
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.kafka.v1.MaintenanceWindow)**

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

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flushMessages](/docs/managed-kafka/api-ref/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logFlushIntervalMs | **string** (int64)

The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk.
If not set, the value of `logFlushSchedulerIntervalMs` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flushMs](/docs/managed-kafka/api-ref/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logFlushSchedulerIntervalMs | **string** (int64)

The frequency of checks (in milliseconds) for any logs that need to be flushed to disk.
This check is done by the log flusher. ||
|| logRetentionBytes | **string** (int64)

Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig2_8.cleanupPolicy](/docs/managed-kafka/api-ref/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) is in effect.
This setting is helpful if you need to control the size of a log due to limited disk space.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retentionBytes](/docs/managed-kafka/api-ref/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logRetentionHours | **string** (int64)

The number of hours to keep a log segment file before deleting it. ||
|| logRetentionMinutes | **string** (int64)

The number of minutes to keep a log segment file before deleting it.

If not set, the value of `logRetentionHours` is used. ||
|| logRetentionMs | **string** (int64)

The number of milliseconds to keep a log segment file before deleting it.

If not set, the value of `logRetentionMinutes` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retentionMs](/docs/managed-kafka/api-ref/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logSegmentBytes | **string** (int64)

The maximum size of a single log file.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segmentBytes](/docs/managed-kafka/api-ref/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| logPreallocate | **boolean**

Should pre allocate file when create new segment?

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate](/docs/managed-kafka/api-ref/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
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

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flushMessages](/docs/managed-kafka/api-ref/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logFlushIntervalMs | **string** (int64)

The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk.
If not set, the value of `logFlushSchedulerIntervalMs` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flushMs](/docs/managed-kafka/api-ref/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logFlushSchedulerIntervalMs | **string** (int64)

The frequency of checks (in milliseconds) for any logs that need to be flushed to disk.
This check is done by the log flusher. ||
|| logRetentionBytes | **string** (int64)

Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig3.cleanupPolicy](/docs/managed-kafka/api-ref/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig3) is in effect.
This setting is helpful if you need to control the size of a log due to limited disk space.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retentionBytes](/docs/managed-kafka/api-ref/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logRetentionHours | **string** (int64)

The number of hours to keep a log segment file before deleting it. ||
|| logRetentionMinutes | **string** (int64)

The number of minutes to keep a log segment file before deleting it.

If not set, the value of `logRetentionHours` is used. ||
|| logRetentionMs | **string** (int64)

The number of milliseconds to keep a log segment file before deleting it.

If not set, the value of `logRetentionMinutes` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retentionMs](/docs/managed-kafka/api-ref/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logSegmentBytes | **string** (int64)

The maximum size of a single log file.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segmentBytes](/docs/managed-kafka/api-ref/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| logPreallocate | **boolean**

Should pre allocate file when create new segment?

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate](/docs/managed-kafka/api-ref/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
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