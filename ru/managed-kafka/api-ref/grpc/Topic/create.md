---
editable: false
sourcePath: en/_api-ref-grpc/mdb/kafka/v1/api-ref/grpc/Topic/create.md
---

# Managed Service for Apache Kafka® API, gRPC: TopicService.Create

Creates a new Kafka topic in the specified cluster.

## gRPC request

**rpc Create ([CreateTopicRequest](#yandex.cloud.mdb.kafka.v1.CreateTopicRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateTopicRequest {#yandex.cloud.mdb.kafka.v1.CreateTopicRequest}

```json
{
  "cluster_id": "string",
  "topic_spec": {
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
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Apache Kafka® cluster to create a topic in.

To get the cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/grpc/Cluster/list#List) request. ||
|| topic_spec | **[TopicSpec](#yandex.cloud.mdb.kafka.v1.TopicSpec)**

Required field. Configuration of the topic to create. ||
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
- `CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_8.log_retention_ms](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) and other similar parameters.
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

This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_messages](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.

This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_ms](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time in milliseconds a message will remain uncompacted in the log. ||
|| retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect.
It is helpful if you need to control the size of log due to limited disk space.

This setting overrides the cluster-level [KafkaConfig2_8.log_retention_bytes](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of milliseconds to keep a log segment's file before deleting it.

This setting overrides the cluster-level [KafkaConfig2_8.log_retention_ms](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The largest record batch size allowed in topic. ||
|| min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write
to be considered successful (when a producer sets acks to "all"). ||
|| segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This configuration controls the segment file size for the log. Retention and cleaning is always done a file
at a time so a larger segment size means fewer files but less granular control over retention.

This setting overrides the cluster-level [KafkaConfig2_8.log_segment_bytes](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

True if we should preallocate the file on disk when creating a new log segment.

This setting overrides the cluster-level [KafkaConfig2_8.log_preallocate](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|#

## TopicConfig3 {#yandex.cloud.mdb.kafka.v1.TopicConfig3}

A topic settings for 3.x

#|
||Field | Description ||
|| cleanup_policy | enum **CleanupPolicy**

Retention policy to use on old log messages.

- `CLEANUP_POLICY_UNSPECIFIED`
- `CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig3.log_retention_ms](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) and other similar parameters.
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

This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_messages](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.

This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_ms](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time in milliseconds a message will remain uncompacted in the log. ||
|| retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect.
It is helpful if you need to control the size of log due to limited disk space.

This setting overrides the cluster-level [KafkaConfig3.log_retention_bytes](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of milliseconds to keep a log segment's file before deleting it.

This setting overrides the cluster-level [KafkaConfig3.log_retention_ms](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The largest record batch size allowed in topic. ||
|| min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write
to be considered successful (when a producer sets acks to "all"). ||
|| segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This configuration controls the segment file size for the log. Retention and cleaning is always done a file
at a time so a larger segment size means fewer files but less granular control over retention.

This setting overrides the cluster-level [KafkaConfig3.log_segment_bytes](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

True if we should preallocate the file on disk when creating a new log segment.

This setting overrides the cluster-level [KafkaConfig3.log_preallocate](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
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
    "cluster_id": "string",
    "topic_name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    "cluster_id": "string",
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
|| metadata | **[CreateTopicMetadata](#yandex.cloud.mdb.kafka.v1.CreateTopicMetadata)**

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
|| response | **[Topic](#yandex.cloud.mdb.kafka.v1.Topic)**

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

## CreateTopicMetadata {#yandex.cloud.mdb.kafka.v1.CreateTopicMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the Apache Kafka® cluster where a topic is being created. ||
|| topic_name | **string**

Required field. Name of the Kafka topic that is being created. ||
|#

## Topic {#yandex.cloud.mdb.kafka.v1.Topic}

An Kafka topic.
For more information, see the [Concepts -> Topics and partitions](/docs/managed-kafka/concepts/topics) section of the documentation.

#|
||Field | Description ||
|| name | **string**

Name of the topic. ||
|| cluster_id | **string**

ID of an Apache Kafka® cluster that the topic belongs to.

To get the Apache Kafka® cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/grpc/Cluster/list#List) request. ||
|| partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of the topic's partitions. ||
|| replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of data copies (replicas) for the topic in the cluster. ||
|| topic_config_2_8 | **[TopicConfig2_8](#yandex.cloud.mdb.kafka.v1.TopicConfig2_82)**

Includes only one of the fields `topic_config_2_8`, `topic_config_3`.

User-defined settings for the topic. ||
|| topic_config_3 | **[TopicConfig3](#yandex.cloud.mdb.kafka.v1.TopicConfig32)**

Includes only one of the fields `topic_config_2_8`, `topic_config_3`.

User-defined settings for the topic. ||
|#

## TopicConfig2_8 {#yandex.cloud.mdb.kafka.v1.TopicConfig2_82}

A topic settings for 2.8

#|
||Field | Description ||
|| cleanup_policy | enum **CleanupPolicy**

Retention policy to use on old log messages.

- `CLEANUP_POLICY_UNSPECIFIED`
- `CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_8.log_retention_ms](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) and other similar parameters.
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

This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_messages](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.

This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_ms](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time in milliseconds a message will remain uncompacted in the log. ||
|| retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect.
It is helpful if you need to control the size of log due to limited disk space.

This setting overrides the cluster-level [KafkaConfig2_8.log_retention_bytes](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of milliseconds to keep a log segment's file before deleting it.

This setting overrides the cluster-level [KafkaConfig2_8.log_retention_ms](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The largest record batch size allowed in topic. ||
|| min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write
to be considered successful (when a producer sets acks to "all"). ||
|| segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This configuration controls the segment file size for the log. Retention and cleaning is always done a file
at a time so a larger segment size means fewer files but less granular control over retention.

This setting overrides the cluster-level [KafkaConfig2_8.log_segment_bytes](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

True if we should preallocate the file on disk when creating a new log segment.

This setting overrides the cluster-level [KafkaConfig2_8.log_preallocate](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|#

## TopicConfig3 {#yandex.cloud.mdb.kafka.v1.TopicConfig32}

A topic settings for 3.x

#|
||Field | Description ||
|| cleanup_policy | enum **CleanupPolicy**

Retention policy to use on old log messages.

- `CLEANUP_POLICY_UNSPECIFIED`
- `CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig3.log_retention_ms](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) and other similar parameters.
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

This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_messages](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.

This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_ms](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time in milliseconds a message will remain uncompacted in the log. ||
|| retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect.
It is helpful if you need to control the size of log due to limited disk space.

This setting overrides the cluster-level [KafkaConfig3.log_retention_bytes](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of milliseconds to keep a log segment's file before deleting it.

This setting overrides the cluster-level [KafkaConfig3.log_retention_ms](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The largest record batch size allowed in topic. ||
|| min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write
to be considered successful (when a producer sets acks to "all"). ||
|| segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This configuration controls the segment file size for the log. Retention and cleaning is always done a file
at a time so a larger segment size means fewer files but less granular control over retention.

This setting overrides the cluster-level [KafkaConfig3.log_segment_bytes](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

True if we should preallocate the file on disk when creating a new log segment.

This setting overrides the cluster-level [KafkaConfig3.log_preallocate](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|#