---
editable: false
sourcePath: en/_api-ref-grpc/mdb/kafka/v1/api-ref/grpc/Cluster/list.md
---

# Managed Service for Apache Kafka® API, gRPC: ClusterService.List

Retrieves the list of Apache Kafka® clusters that belong to the specified folder.

## gRPC request

**rpc List ([ListClustersRequest](#yandex.cloud.mdb.kafka.v1.ListClustersRequest)) returns ([ListClustersResponse](#yandex.cloud.mdb.kafka.v1.ListClustersResponse))**

## ListClustersRequest {#yandex.cloud.mdb.kafka.v1.ListClustersRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list Apache Kafka® clusters in.

To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#yandex.cloud.mdb.kafka.v1.ListClustersResponse) that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token.

To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#yandex.cloud.mdb.kafka.v1.ListClustersResponse) returned by the previous list request. ||
|| filter | **string**

Filter support is not currently implemented. Any filters are ignored. ||
|#

## ListClustersResponse {#yandex.cloud.mdb.kafka.v1.ListClustersResponse}

```json
{
  "clusters": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| clusters[] | **[Cluster](#yandex.cloud.mdb.kafka.v1.Cluster)**

List of Apache Kafka® clusters. ||
|| next_page_token | **string**

Token that allows you to get the next page of results for list requests.

If the number of results is larger than [ListClustersRequest.page_size](#yandex.cloud.mdb.kafka.v1.ListClustersRequest), use `next_page_token` as the value for the [ListClustersRequest.page_token](#yandex.cloud.mdb.kafka.v1.ListClustersRequest) parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
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
|| labels | **object** (map<**string**, **string**>)

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
|| config | **[ConfigSpec](#yandex.cloud.mdb.kafka.v1.ConfigSpec)**

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
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.kafka.v1.MaintenanceWindow)**

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

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_messages](/docs/managed-kafka/api-ref/grpc/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk.
If not set, the value of `log_flush_scheduler_interval_ms` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.flush_ms](/docs/managed-kafka/api-ref/grpc/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The frequency of checks (in milliseconds) for any logs that need to be flushed to disk.
This check is done by the log flusher. ||
|| log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig2_8.cleanup_policy](/docs/managed-kafka/api-ref/grpc/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) is in effect.
This setting is helpful if you need to control the size of a log due to limited disk space.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_bytes](/docs/managed-kafka/api-ref/grpc/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of hours to keep a log segment file before deleting it. ||
|| log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of minutes to keep a log segment file before deleting it.

If not set, the value of `log_retention_hours` is used. ||
|| log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of milliseconds to keep a log segment file before deleting it.

If not set, the value of `log_retention_minutes` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.retention_ms](/docs/managed-kafka/api-ref/grpc/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of a single log file.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.segment_bytes](/docs/managed-kafka/api-ref/grpc/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
|| log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Should pre allocate file when create new segment?

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig2_8.preallocate](/docs/managed-kafka/api-ref/grpc/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig2_8) setting. ||
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

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_messages](/docs/managed-kafka/api-ref/grpc/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| log_flush_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk.
If not set, the value of `log_flush_scheduler_interval_ms` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.flush_ms](/docs/managed-kafka/api-ref/grpc/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| log_flush_scheduler_interval_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The frequency of checks (in milliseconds) for any logs that need to be flushed to disk.
This check is done by the log flusher. ||
|| log_retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Partition size limit; Kafka will discard old log segments to free up space if `delete` [TopicConfig3.cleanup_policy](/docs/managed-kafka/api-ref/grpc/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig3) is in effect.
This setting is helpful if you need to control the size of a log due to limited disk space.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_bytes](/docs/managed-kafka/api-ref/grpc/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| log_retention_hours | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of hours to keep a log segment file before deleting it. ||
|| log_retention_minutes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of minutes to keep a log segment file before deleting it.

If not set, the value of `log_retention_hours` is used. ||
|| log_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of milliseconds to keep a log segment file before deleting it.

If not set, the value of `log_retention_minutes` is used.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.retention_ms](/docs/managed-kafka/api-ref/grpc/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| log_segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of a single log file.

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.segment_bytes](/docs/managed-kafka/api-ref/grpc/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
|| log_preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Should pre allocate file when create new segment?

This is the global cluster-level setting that can be overridden on a topic level by using the [TopicConfig3.preallocate](/docs/managed-kafka/api-ref/grpc/Cluster/create#yandex.cloud.mdb.kafka.v1.TopicConfig3) setting. ||
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

## MaintenanceOperation {#yandex.cloud.mdb.kafka.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string** ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#