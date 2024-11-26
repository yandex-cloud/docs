---
editable: false
sourcePath: en/_api-ref-grpc/mdb/kafka/v1/api-ref/grpc/Cluster/create.md
---

# Managed Service for Apache Kafka® API, gRPC: ClusterService.Create

Creates a new Apache Kafka® cluster in the specified folder.

## gRPC request

**rpc Create ([CreateClusterRequest](#yandex.cloud.mdb.kafka.v1.CreateClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateClusterRequest {#yandex.cloud.mdb.kafka.v1.CreateClusterRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "environment": "Environment",
  "config_spec": {
    "version": "string",
    "kafka": {
      "resources": {
        "resource_preset_id": "string",
        "disk_size": "int64",
        "disk_type_id": "string"
      },
      // Includes only one of the fields `kafka_config_2_8`, `kafka_config_3`
      "kafka_config_2_8": {
        "compression_type": "CompressionType",
        "log_flush_interval_messages": "google.protobuf.Int64Value",
        "log_flush_interval_ms": "google.protobuf.Int64Value",
        "log_flush_scheduler_interval_ms": "google.protobuf.Int64Value",
        "log_retention_bytes": "google.protobuf.Int64Value",
        "log_retention_hours": "google.protobuf.Int64Value",
        "log_retention_minutes": "google.protobuf.Int64Value",
        "log_retention_ms": "google.protobuf.Int64Value",
        "log_segment_bytes": "google.protobuf.Int64Value",
        "log_preallocate": "google.protobuf.BoolValue",
        "socket_send_buffer_bytes": "google.protobuf.Int64Value",
        "socket_receive_buffer_bytes": "google.protobuf.Int64Value",
        "auto_create_topics_enable": "google.protobuf.BoolValue",
        "num_partitions": "google.protobuf.Int64Value",
        "default_replication_factor": "google.protobuf.Int64Value",
        "message_max_bytes": "google.protobuf.Int64Value",
        "replica_fetch_max_bytes": "google.protobuf.Int64Value",
        "ssl_cipher_suites": [
          "string"
        ],
        "offsets_retention_minutes": "google.protobuf.Int64Value",
        "sasl_enabled_mechanisms": [
          "SaslMechanism"
        ]
      },
      "kafka_config_3": {
        "compression_type": "CompressionType",
        "log_flush_interval_messages": "google.protobuf.Int64Value",
        "log_flush_interval_ms": "google.protobuf.Int64Value",
        "log_flush_scheduler_interval_ms": "google.protobuf.Int64Value",
        "log_retention_bytes": "google.protobuf.Int64Value",
        "log_retention_hours": "google.protobuf.Int64Value",
        "log_retention_minutes": "google.protobuf.Int64Value",
        "log_retention_ms": "google.protobuf.Int64Value",
        "log_segment_bytes": "google.protobuf.Int64Value",
        "log_preallocate": "google.protobuf.BoolValue",
        "socket_send_buffer_bytes": "google.protobuf.Int64Value",
        "socket_receive_buffer_bytes": "google.protobuf.Int64Value",
        "auto_create_topics_enable": "google.protobuf.BoolValue",
        "num_partitions": "google.protobuf.Int64Value",
        "default_replication_factor": "google.protobuf.Int64Value",
        "message_max_bytes": "google.protobuf.Int64Value",
        "replica_fetch_max_bytes": "google.protobuf.Int64Value",
        "ssl_cipher_suites": [
          "string"
        ],
        "offsets_retention_minutes": "google.protobuf.Int64Value",
        "sasl_enabled_mechanisms": [
          "SaslMechanism"
        ]
      }
      // end of the list of possible fields
    },
    "zookeeper": {
      "resources": {
        "resource_preset_id": "string",
        "disk_size": "int64",
        "disk_type_id": "string"
      }
    },
    "zone_id": [
      "string"
    ],
    "brokers_count": "google.protobuf.Int64Value",
    "assign_public_ip": "bool",
    "unmanaged_topics": "bool",
    "schema_registry": "bool",
    "access": {
      "data_transfer": "bool"
    },
    "rest_api_config": {
      "enabled": "bool"
    },
    "disk_size_autoscaling": {
      "planned_usage_threshold": "int64",
      "emergency_usage_threshold": "int64",
      "disk_size_limit": "int64"
    },
    "kraft": {
      "resources": {
        "resource_preset_id": "string",
        "disk_size": "int64",
        "disk_type_id": "string"
      }
    }
  },
  "topic_specs": [
    {
      "name": "string",
      "partitions": "google.protobuf.Int64Value",
      "replication_factor": "google.protobuf.Int64Value",
      // Includes only one of the fields `topic_config_2_8`, `topic_config_3`
      "topic_config_2_8": {
        "cleanup_policy": "CleanupPolicy",
        "compression_type": "CompressionType",
        "delete_retention_ms": "google.protobuf.Int64Value",
        "file_delete_delay_ms": "google.protobuf.Int64Value",
        "flush_messages": "google.protobuf.Int64Value",
        "flush_ms": "google.protobuf.Int64Value",
        "min_compaction_lag_ms": "google.protobuf.Int64Value",
        "retention_bytes": "google.protobuf.Int64Value",
        "retention_ms": "google.protobuf.Int64Value",
        "max_message_bytes": "google.protobuf.Int64Value",
        "min_insync_replicas": "google.protobuf.Int64Value",
        "segment_bytes": "google.protobuf.Int64Value",
        "preallocate": "google.protobuf.BoolValue"
      },
      "topic_config_3": {
        "cleanup_policy": "CleanupPolicy",
        "compression_type": "CompressionType",
        "delete_retention_ms": "google.protobuf.Int64Value",
        "file_delete_delay_ms": "google.protobuf.Int64Value",
        "flush_messages": "google.protobuf.Int64Value",
        "flush_ms": "google.protobuf.Int64Value",
        "min_compaction_lag_ms": "google.protobuf.Int64Value",
        "retention_bytes": "google.protobuf.Int64Value",
        "retention_ms": "google.protobuf.Int64Value",
        "max_message_bytes": "google.protobuf.Int64Value",
        "min_insync_replicas": "google.protobuf.Int64Value",
        "segment_bytes": "google.protobuf.Int64Value",
        "preallocate": "google.protobuf.BoolValue"
      }
      // end of the list of possible fields
    }
  ],
  "user_specs": [
    {
      "name": "string",
      "password": "string",
      "permissions": [
        {
          "topic_name": "string",
          "role": "AccessRole",
          "allow_hosts": [
            "string"
          ]
        }
      ]
    }
  ],
  "network_id": "string",
  "subnet_id": [
    "string"
  ],
  "security_group_ids": [
    "string"
  ],
  "host_group_ids": [
    "string"
  ],
  "deletion_protection": "bool",
  "maintenance_window": {
    // Includes only one of the fields `anytime`, `weekly_maintenance_window`
    "anytime": "AnytimeMaintenanceWindow",
    "weekly_maintenance_window": {
      "day": "WeekDay",
      "hour": "int64"
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create the Apache Kafka® cluster in.

To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Required field. Name of the Apache Kafka® cluster. The name must be unique within the folder. ||
|| description | **string**

Description of the Apache Kafka® cluster. ||
|| labels | **string**

Custom labels for the Apache Kafka® cluster as `key:value` pairs.

For example, "project": "mvp" or "source": "dictionary". ||
|| environment | enum **Environment**

Deployment environment of the Apache Kafka® cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility. ||
|| config_spec | **[ConfigSpec](#yandex.cloud.mdb.kafka.v1.ConfigSpec)**

Kafka and hosts configuration the Apache Kafka® cluster. ||
|| topic_specs[] | **[TopicSpec](#yandex.cloud.mdb.kafka.v1.TopicSpec)**

One or more configurations of topics to be created in the Apache Kafka® cluster. ||
|| user_specs[] | **[UserSpec](#yandex.cloud.mdb.kafka.v1.UserSpec)**

Configurations of accounts to be created in the Apache Kafka® cluster. ||
|| network_id | **string**

ID of the network to create the Apache Kafka® cluster in. ||
|| subnet_id[] | **string**

IDs of subnets to create brokers in. ||
|| security_group_ids[] | **string**

User security groups ||
|| host_group_ids[] | **string**

Host groups to place VMs of cluster on. ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.kafka.v1.MaintenanceWindow)**

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
|| zone_id[] | **string**

IDs of availability zones where Kafka brokers reside. ||
|| brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of Kafka brokers deployed in each availability zone. ||
|| assign_public_ip | **bool**

The flag that defines whether a public IP address is assigned to the cluster.
If the value is `true`, then Apache Kafka® cluster is available on the Internet via it's public IP address. ||
|| unmanaged_topics | **bool**

Allows to manage topics via AdminAPI
Deprecated. Feature enabled permanently. ||
|| schema_registry | **bool**

Enables managed schema registry on cluster ||
|| access | **[Access](#yandex.cloud.mdb.kafka.v1.Access)**

Access policy for external services. ||
|| rest_api_config | **[RestAPIConfig](#yandex.cloud.mdb.kafka.v1.ConfigSpec.RestAPIConfig)**

Configuration of REST API. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.kafka.v1.DiskSizeAutoscaling)**

DiskSizeAutoscaling settings ||
|| kraft | **[KRaft](#yandex.cloud.mdb.kafka.v1.ConfigSpec.KRaft)**

Configuration and resource allocation for KRaft-controller hosts. ||
|#

## Kafka {#yandex.cloud.mdb.kafka.v1.ConfigSpec.Kafka}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.kafka.v1.Resources)**

Resources allocated to Kafka brokers. ||
|| kafka_config_2_8 | **[KafkaConfig2_8](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8)**

Includes only one of the fields `kafka_config_2_8`, `kafka_config_3`.

Kafka broker configuration. ||
|| kafka_config_3 | **[KafkaConfig3](#yandex.cloud.mdb.kafka.v1.KafkaConfig3)**

Includes only one of the fields `kafka_config_2_8`, `kafka_config_3`.

Kafka broker configuration. ||
|#

## Resources {#yandex.cloud.mdb.kafka.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory, etc.).
All available presets are listed in the [documentation](/docs/managed-kafka/concepts/instance-types). ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted. ||
|| disk_type_id | **string**

Type of the storage environment for the host. ||
|#

## KafkaConfig2_8 {#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8}

Kafka version 2.8 broker configuration.

#|
||Field | Description ||
|| compression_type | enum **CompressionType**

Cluster topics compression type.

- `COMPRESSION_TYPE_UNSPECIFIED`
- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of messages accumulated on a log partition before messages are flushed to disk.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_messages](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk.
If not set, the value of `log_flush_scheduler_interval_ms` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_ms](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The frequency of checks (in milliseconds) for any logs that need to be flushed to disk.
This check is done by the log flusher. ||
|| log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig2_8.cleanup_policy](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) is in effect.
This setting is helpful if you need to control the size of a log due to limited disk space.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_bytes](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of hours to keep a log segment file before deleting it. ||
|| log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of minutes to keep a log segment file before deleting it.

If not set, the value of `log_retention_hours` is used. ||
|| log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of milliseconds to keep a log segment file before deleting it.

If not set, the value of `log_retention_minutes` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_ms](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of a single log file.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segment_bytes](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Should pre allocate file when create new segment?

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. ||
|| socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. ||
|| auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable auto creation of topic on the server ||
|| num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Default number of partitions per topic on the whole cluster ||
|| default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Default replication factor of the topic on the whole cluster ||
|| message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The largest record batch size allowed by Kafka. Default value: 1048588. ||
|| replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. ||
|| ssl_cipher_suites[] | **string**

A list of cipher suites. ||
|| offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Offset storage time after a consumer group loses all its consumers. Default: 10080. ||
|| sasl_enabled_mechanisms[] | enum **SaslMechanism**

The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512].

- `SASL_MECHANISM_UNSPECIFIED`
- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|#

## KafkaConfig3 {#yandex.cloud.mdb.kafka.v1.KafkaConfig3}

Kafka version 3.x broker configuration.

#|
||Field | Description ||
|| compression_type | enum **CompressionType**

Cluster topics compression type.

- `COMPRESSION_TYPE_UNSPECIFIED`
- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of messages accumulated on a log partition before messages are flushed to disk.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_messages](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk.
If not set, the value of `log_flush_scheduler_interval_ms` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_ms](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The frequency of checks (in milliseconds) for any logs that need to be flushed to disk.
This check is done by the log flusher. ||
|| log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig3.cleanup_policy](#yandex.cloud.mdb.kafka.v1.TopicConfig3) is in effect.
This setting is helpful if you need to control the size of a log due to limited disk space.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_bytes](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of hours to keep a log segment file before deleting it. ||
|| log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of minutes to keep a log segment file before deleting it.

If not set, the value of `log_retention_hours` is used. ||
|| log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of milliseconds to keep a log segment file before deleting it.

If not set, the value of `log_retention_minutes` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_ms](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of a single log file.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segment_bytes](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Should pre allocate file when create new segment?

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. ||
|| socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. ||
|| auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable auto creation of topic on the server ||
|| num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Default number of partitions per topic on the whole cluster ||
|| default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Default replication factor of the topic on the whole cluster ||
|| message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The largest record batch size allowed by Kafka. Default value: 1048588. ||
|| replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. ||
|| ssl_cipher_suites[] | **string**

A list of cipher suites. ||
|| offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Offset storage time after a consumer group loses all its consumers. Default: 10080. ||
|| sasl_enabled_mechanisms[] | enum **SaslMechanism**

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
|| data_transfer | **bool**

Allow access for DataTransfer. ||
|#

## RestAPIConfig {#yandex.cloud.mdb.kafka.v1.ConfigSpec.RestAPIConfig}

#|
||Field | Description ||
|| enabled | **bool**

Is REST API enabled for this cluster. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.kafka.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| planned_usage_threshold | **int64**

Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold. ||
|| emergency_usage_threshold | **int64**

Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold. ||
|| disk_size_limit | **int64**

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
|| partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of the topic's partitions. ||
|| replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of copies of a topic data kept in the cluster. ||
|| topic_config_2_8 | **[TopicConfig2_8](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8)**

Includes only one of the fields `topic_config_2_8`, `topic_config_3`.

User-defined settings for the topic. ||
|| topic_config_3 | **[TopicConfig3](#yandex.cloud.mdb.kafka.v1.TopicConfig3)**

Includes only one of the fields `topic_config_2_8`, `topic_config_3`.

User-defined settings for the topic. ||
|#

## TopicConfig2_8 {#yandex.cloud.mdb.kafka.v1.TopicConfig2_8}

A topic settings for 2.8

#|
||Field | Description ||
|| cleanup_policy | enum **CleanupPolicy**

Retention policy to use on old log messages.

- `CLEANUP_POLICY_UNSPECIFIED`
- `CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_8.log_retention_ms](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) and other similar parameters.
- `CLEANUP_POLICY_COMPACT`: This policy compacts messages in log.
- `CLEANUP_POLICY_COMPACT_AND_DELETE`: This policy use both compaction and deletion for messages and log segments. ||
|| compression_type | enum **CompressionType**

The compression type for a given topic.

- `COMPRESSION_TYPE_UNSPECIFIED`
- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. ||
|| file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The time to wait before deleting a file from the filesystem. ||
|| flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of messages accumulated on a log partition before messages are flushed to disk.

This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_messages](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.

This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_ms](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time in milliseconds a message will remain uncompacted in the log. ||
|| retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect.
It is helpful if you need to control the size of log due to limited disk space.

This setting overrides the cluster-level [KafkaConfig2_8.log_retention_bytes](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of milliseconds to keep a log segment's file before deleting it.

This setting overrides the cluster-level [KafkaConfig2_8.log_retention_ms](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The largest record batch size allowed in topic. ||
|| min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write
to be considered successful (when a producer sets acks to "all"). ||
|| segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This configuration controls the segment file size for the log. Retention and cleaning is always done a file
at a time so a larger segment size means fewer files but less granular control over retention.

This setting overrides the cluster-level [KafkaConfig2_8.log_segment_bytes](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

True if we should preallocate the file on disk when creating a new log segment.

This setting overrides the cluster-level [KafkaConfig2_8.log_preallocate](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|#

## TopicConfig3 {#yandex.cloud.mdb.kafka.v1.TopicConfig3}

A topic settings for 3.x

#|
||Field | Description ||
|| cleanup_policy | enum **CleanupPolicy**

Retention policy to use on old log messages.

- `CLEANUP_POLICY_UNSPECIFIED`
- `CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig3.log_retention_ms](#yandex.cloud.mdb.kafka.v1.KafkaConfig3) and other similar parameters.
- `CLEANUP_POLICY_COMPACT`: This policy compacts messages in log.
- `CLEANUP_POLICY_COMPACT_AND_DELETE`: This policy use both compaction and deletion for messages and log segments. ||
|| compression_type | enum **CompressionType**

The compression type for a given topic.

- `COMPRESSION_TYPE_UNSPECIFIED`
- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. ||
|| file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The time to wait before deleting a file from the filesystem. ||
|| flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of messages accumulated on a log partition before messages are flushed to disk.

This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_messages](#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.

This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_ms](#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time in milliseconds a message will remain uncompacted in the log. ||
|| retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect.
It is helpful if you need to control the size of log due to limited disk space.

This setting overrides the cluster-level [KafkaConfig3.log_retention_bytes](#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of milliseconds to keep a log segment's file before deleting it.

This setting overrides the cluster-level [KafkaConfig3.log_retention_ms](#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The largest record batch size allowed in topic. ||
|| min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write
to be considered successful (when a producer sets acks to "all"). ||
|| segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This configuration controls the segment file size for the log. Retention and cleaning is always done a file
at a time so a larger segment size means fewer files but less granular control over retention.

This setting overrides the cluster-level [KafkaConfig3.log_segment_bytes](#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

True if we should preallocate the file on disk when creating a new log segment.

This setting overrides the cluster-level [KafkaConfig3.log_preallocate](#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
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
|| topic_name | **string**

Name or prefix-pattern with wildcard for the topic that the permission grants access to.

To get the topic name, make a [TopicService.List](/docs/managed-kafka/api-ref/grpc/Topic/list#List) request. ||
|| role | enum **AccessRole**

Access role type to grant to the user.

- `ACCESS_ROLE_UNSPECIFIED`
- `ACCESS_ROLE_PRODUCER`: Producer role for the user.
- `ACCESS_ROLE_CONSUMER`: Consumer role for the user.
- `ACCESS_ROLE_ADMIN`: Admin role for the user. ||
|| allow_hosts[] | **string**

Lists hosts allowed for this permission.
Only ip-addresses allowed as value of single host.
When not defined, access from any host is allowed.

Bare in mind that the same host might appear in multiple permissions at the same time,
hence removing individual permission doesn't automatically restricts access from the `allow_hosts` of the permission.
If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.kafka.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.kafka.v1.AnytimeMaintenanceWindow)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.kafka.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.kafka.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.kafka.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | enum **WeekDay**

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "cluster_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "environment": "Environment",
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
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        // Includes only one of the fields `kafka_config_2_8`, `kafka_config_3`
        "kafka_config_2_8": {
          "compression_type": "CompressionType",
          "log_flush_interval_messages": "google.protobuf.Int64Value",
          "log_flush_interval_ms": "google.protobuf.Int64Value",
          "log_flush_scheduler_interval_ms": "google.protobuf.Int64Value",
          "log_retention_bytes": "google.protobuf.Int64Value",
          "log_retention_hours": "google.protobuf.Int64Value",
          "log_retention_minutes": "google.protobuf.Int64Value",
          "log_retention_ms": "google.protobuf.Int64Value",
          "log_segment_bytes": "google.protobuf.Int64Value",
          "log_preallocate": "google.protobuf.BoolValue",
          "socket_send_buffer_bytes": "google.protobuf.Int64Value",
          "socket_receive_buffer_bytes": "google.protobuf.Int64Value",
          "auto_create_topics_enable": "google.protobuf.BoolValue",
          "num_partitions": "google.protobuf.Int64Value",
          "default_replication_factor": "google.protobuf.Int64Value",
          "message_max_bytes": "google.protobuf.Int64Value",
          "replica_fetch_max_bytes": "google.protobuf.Int64Value",
          "ssl_cipher_suites": [
            "string"
          ],
          "offsets_retention_minutes": "google.protobuf.Int64Value",
          "sasl_enabled_mechanisms": [
            "SaslMechanism"
          ]
        },
        "kafka_config_3": {
          "compression_type": "CompressionType",
          "log_flush_interval_messages": "google.protobuf.Int64Value",
          "log_flush_interval_ms": "google.protobuf.Int64Value",
          "log_flush_scheduler_interval_ms": "google.protobuf.Int64Value",
          "log_retention_bytes": "google.protobuf.Int64Value",
          "log_retention_hours": "google.protobuf.Int64Value",
          "log_retention_minutes": "google.protobuf.Int64Value",
          "log_retention_ms": "google.protobuf.Int64Value",
          "log_segment_bytes": "google.protobuf.Int64Value",
          "log_preallocate": "google.protobuf.BoolValue",
          "socket_send_buffer_bytes": "google.protobuf.Int64Value",
          "socket_receive_buffer_bytes": "google.protobuf.Int64Value",
          "auto_create_topics_enable": "google.protobuf.BoolValue",
          "num_partitions": "google.protobuf.Int64Value",
          "default_replication_factor": "google.protobuf.Int64Value",
          "message_max_bytes": "google.protobuf.Int64Value",
          "replica_fetch_max_bytes": "google.protobuf.Int64Value",
          "ssl_cipher_suites": [
            "string"
          ],
          "offsets_retention_minutes": "google.protobuf.Int64Value",
          "sasl_enabled_mechanisms": [
            "SaslMechanism"
          ]
        }
        // end of the list of possible fields
      },
      "zookeeper": {
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        }
      },
      "zone_id": [
        "string"
      ],
      "brokers_count": "google.protobuf.Int64Value",
      "assign_public_ip": "bool",
      "unmanaged_topics": "bool",
      "schema_registry": "bool",
      "access": {
        "data_transfer": "bool"
      },
      "rest_api_config": {
        "enabled": "bool"
      },
      "disk_size_autoscaling": {
        "planned_usage_threshold": "int64",
        "emergency_usage_threshold": "int64",
        "disk_size_limit": "int64"
      },
      "kraft": {
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        }
      }
    },
    "network_id": "string",
    "health": "Health",
    "status": "Status",
    "security_group_ids": [
      "string"
    ],
    "host_group_ids": [
      "string"
    ],
    "deletion_protection": "bool",
    "maintenance_window": {
      // Includes only one of the fields `anytime`, `weekly_maintenance_window`
      "anytime": "AnytimeMaintenanceWindow",
      "weekly_maintenance_window": {
        "day": "WeekDay",
        "hour": "int64"
      }
      // end of the list of possible fields
    },
    "planned_operation": {
      "info": "string",
      "delayed_until": "google.protobuf.Timestamp"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateClusterMetadata](#yandex.cloud.mdb.kafka.v1.CreateClusterMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

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
|| cluster_id | **string**

ID of the Apache Kafka® cluster that is being created. ||
|#

## Cluster {#yandex.cloud.mdb.kafka.v1.Cluster}

An Apache Kafka® cluster resource.
For more information, see the [Concepts](/docs/managed-kafka/concepts) section of the documentation.

#|
||Field | Description ||
|| id | **string**

ID of the Apache Kafka® cluster.
This ID is assigned at creation time. ||
|| folder_id | **string**

ID of the folder that the Apache Kafka® cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the Apache Kafka® cluster.
The name must be unique within the folder. 1-63 characters long. Value must match the regular expression `[a-zA-Z0-9_-]*`. ||
|| description | **string**

Description of the Apache Kafka® cluster. 0-256 characters long. ||
|| labels | **string**

Custom labels for the Apache Kafka® cluster as `key:value` pairs.
A maximum of 64 labels per resource is allowed. ||
|| environment | enum **Environment**

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
|| network_id | **string**

ID of the network that the cluster belongs to. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](/docs/managed-kafka/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.kafka.v1.Host) of all hosts in the cluster is `UNKNOWN`).
- `ALIVE`: Cluster is alive and well ([Host.health](/docs/managed-kafka/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.kafka.v1.Host) of all hosts in the cluster is `ALIVE`).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-kafka/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.kafka.v1.Host) of all hosts in the cluster is `DEAD`).
- `DEGRADED`: Cluster is in degraded state ([Host.health](/docs/managed-kafka/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.kafka.v1.Host) of at least one of the hosts in the cluster is not `ALIVE`). ||
|| status | enum **Status**

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| security_group_ids[] | **string**

User security groups ||
|| host_group_ids[] | **string**

Host groups hosting VMs of the cluster. ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.kafka.v1.MaintenanceWindow2)**

Window of maintenance operations. ||
|| planned_operation | **[MaintenanceOperation](#yandex.cloud.mdb.kafka.v1.MaintenanceOperation)**

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
|| zone_id[] | **string**

IDs of availability zones where Kafka brokers reside. ||
|| brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of Kafka brokers deployed in each availability zone. ||
|| assign_public_ip | **bool**

The flag that defines whether a public IP address is assigned to the cluster.
If the value is `true`, then Apache Kafka® cluster is available on the Internet via it's public IP address. ||
|| unmanaged_topics | **bool**

Allows to manage topics via AdminAPI
Deprecated. Feature enabled permanently. ||
|| schema_registry | **bool**

Enables managed schema registry on cluster ||
|| access | **[Access](#yandex.cloud.mdb.kafka.v1.Access2)**

Access policy for external services. ||
|| rest_api_config | **[RestAPIConfig](#yandex.cloud.mdb.kafka.v1.ConfigSpec.RestAPIConfig2)**

Configuration of REST API. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.kafka.v1.DiskSizeAutoscaling2)**

DiskSizeAutoscaling settings ||
|| kraft | **[KRaft](#yandex.cloud.mdb.kafka.v1.ConfigSpec.KRaft2)**

Configuration and resource allocation for KRaft-controller hosts. ||
|#

## Kafka {#yandex.cloud.mdb.kafka.v1.ConfigSpec.Kafka2}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.kafka.v1.Resources2)**

Resources allocated to Kafka brokers. ||
|| kafka_config_2_8 | **[KafkaConfig2_8](#yandex.cloud.mdb.kafka.v1.KafkaConfig2_82)**

Includes only one of the fields `kafka_config_2_8`, `kafka_config_3`.

Kafka broker configuration. ||
|| kafka_config_3 | **[KafkaConfig3](#yandex.cloud.mdb.kafka.v1.KafkaConfig32)**

Includes only one of the fields `kafka_config_2_8`, `kafka_config_3`.

Kafka broker configuration. ||
|#

## Resources {#yandex.cloud.mdb.kafka.v1.Resources2}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory, etc.).
All available presets are listed in the [documentation](/docs/managed-kafka/concepts/instance-types). ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted. ||
|| disk_type_id | **string**

Type of the storage environment for the host. ||
|#

## KafkaConfig2_8 {#yandex.cloud.mdb.kafka.v1.KafkaConfig2_82}

Kafka version 2.8 broker configuration.

#|
||Field | Description ||
|| compression_type | enum **CompressionType**

Cluster topics compression type.

- `COMPRESSION_TYPE_UNSPECIFIED`
- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of messages accumulated on a log partition before messages are flushed to disk.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_messages](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk.
If not set, the value of `log_flush_scheduler_interval_ms` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_ms](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The frequency of checks (in milliseconds) for any logs that need to be flushed to disk.
This check is done by the log flusher. ||
|| log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig2_8.cleanup_policy](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) is in effect.
This setting is helpful if you need to control the size of a log due to limited disk space.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_bytes](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of hours to keep a log segment file before deleting it. ||
|| log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of minutes to keep a log segment file before deleting it.

If not set, the value of `log_retention_hours` is used. ||
|| log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of milliseconds to keep a log segment file before deleting it.

If not set, the value of `log_retention_minutes` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_ms](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of a single log file.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segment_bytes](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Should pre allocate file when create new segment?

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate](#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. ||
|| socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. ||
|| auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable auto creation of topic on the server ||
|| num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Default number of partitions per topic on the whole cluster ||
|| default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Default replication factor of the topic on the whole cluster ||
|| message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The largest record batch size allowed by Kafka. Default value: 1048588. ||
|| replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. ||
|| ssl_cipher_suites[] | **string**

A list of cipher suites. ||
|| offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Offset storage time after a consumer group loses all its consumers. Default: 10080. ||
|| sasl_enabled_mechanisms[] | enum **SaslMechanism**

The list of SASL mechanisms enabled in the Kafka server. Default: [SCRAM_SHA_512].

- `SASL_MECHANISM_UNSPECIFIED`
- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|#

## KafkaConfig3 {#yandex.cloud.mdb.kafka.v1.KafkaConfig32}

Kafka version 3.x broker configuration.

#|
||Field | Description ||
|| compression_type | enum **CompressionType**

Cluster topics compression type.

- `COMPRESSION_TYPE_UNSPECIFIED`
- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| log_flush_interval_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of messages accumulated on a log partition before messages are flushed to disk.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_messages](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk.
If not set, the value of `log_flush_scheduler_interval_ms` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_ms](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The frequency of checks (in milliseconds) for any logs that need to be flushed to disk.
This check is done by the log flusher. ||
|| log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig3.cleanup_policy](#yandex.cloud.mdb.kafka.v1.TopicConfig3) is in effect.
This setting is helpful if you need to control the size of a log due to limited disk space.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_bytes](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of hours to keep a log segment file before deleting it. ||
|| log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of minutes to keep a log segment file before deleting it.

If not set, the value of `log_retention_hours` is used. ||
|| log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of milliseconds to keep a log segment file before deleting it.

If not set, the value of `log_retention_minutes` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_ms](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of a single log file.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segment_bytes](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Should pre allocate file when create new segment?

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate](#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| socket_send_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The SO_SNDBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. ||
|| socket_receive_buffer_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The SO_RCVBUF buffer of the socket server sockets. If the value is -1, the OS default will be used. ||
|| auto_create_topics_enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enable auto creation of topic on the server ||
|| num_partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Default number of partitions per topic on the whole cluster ||
|| default_replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Default replication factor of the topic on the whole cluster ||
|| message_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The largest record batch size allowed by Kafka. Default value: 1048588. ||
|| replica_fetch_max_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of bytes of messages to attempt to fetch for each partition. Default value: 1048576. ||
|| ssl_cipher_suites[] | **string**

A list of cipher suites. ||
|| offsets_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Offset storage time after a consumer group loses all its consumers. Default: 10080. ||
|| sasl_enabled_mechanisms[] | enum **SaslMechanism**

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
|| data_transfer | **bool**

Allow access for DataTransfer. ||
|#

## RestAPIConfig {#yandex.cloud.mdb.kafka.v1.ConfigSpec.RestAPIConfig2}

#|
||Field | Description ||
|| enabled | **bool**

Is REST API enabled for this cluster. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.kafka.v1.DiskSizeAutoscaling2}

#|
||Field | Description ||
|| planned_usage_threshold | **int64**

Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold. ||
|| emergency_usage_threshold | **int64**

Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold. ||
|| disk_size_limit | **int64**

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
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.kafka.v1.AnytimeMaintenanceWindow2)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.kafka.v1.WeeklyMaintenanceWindow2)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.kafka.v1.AnytimeMaintenanceWindow2}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.kafka.v1.WeeklyMaintenanceWindow2}

#|
||Field | Description ||
|| day | enum **WeekDay**

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC. ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.kafka.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string** ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#