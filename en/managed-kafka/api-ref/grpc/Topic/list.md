---
editable: false
sourcePath: en/_api-ref-grpc/mdb/kafka/v1/api-ref/grpc/Topic/list.md
---

# Managed Service for Apache Kafka® API, gRPC: TopicService.List {#List}

Retrieves the list of Kafka topics in the specified cluster.

## gRPC request

**rpc List ([ListTopicsRequest](#yandex.cloud.mdb.kafka.v1.ListTopicsRequest)) returns ([ListTopicsResponse](#yandex.cloud.mdb.kafka.v1.ListTopicsResponse))**

## ListTopicsRequest {#yandex.cloud.mdb.kafka.v1.ListTopicsRequest}

```json
{
  "clusterId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Apache Kafka® cluster to list topics in.

To get the cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/grpc/Cluster/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the service returns a [ListTopicsResponse.nextPageToken](#yandex.cloud.mdb.kafka.v1.ListTopicsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.

To get the next page of results, set `pageToken` to the [ListTopicsResponse.nextPageToken](#yandex.cloud.mdb.kafka.v1.ListTopicsResponse) returned by the previous list request. ||
|#

## ListTopicsResponse {#yandex.cloud.mdb.kafka.v1.ListTopicsResponse}

```json
{
  "topics": [
    {
      "name": "string",
      "clusterId": "string",
      "partitions": "google.protobuf.Int64Value",
      "replicationFactor": "google.protobuf.Int64Value",
      // Includes only one of the fields `topicConfig_2_8`, `topicConfig_3`
      "topicConfig_2_8": {
        "cleanupPolicy": "CleanupPolicy",
        "compressionType": "CompressionType",
        "deleteRetentionMs": "google.protobuf.Int64Value",
        "fileDeleteDelayMs": "google.protobuf.Int64Value",
        "flushMessages": "google.protobuf.Int64Value",
        "flushMs": "google.protobuf.Int64Value",
        "minCompactionLagMs": "google.protobuf.Int64Value",
        "retentionBytes": "google.protobuf.Int64Value",
        "retentionMs": "google.protobuf.Int64Value",
        "maxMessageBytes": "google.protobuf.Int64Value",
        "minInsyncReplicas": "google.protobuf.Int64Value",
        "segmentBytes": "google.protobuf.Int64Value",
        "preallocate": "google.protobuf.BoolValue"
      },
      "topicConfig_3": {
        "cleanupPolicy": "CleanupPolicy",
        "compressionType": "CompressionType",
        "deleteRetentionMs": "google.protobuf.Int64Value",
        "fileDeleteDelayMs": "google.protobuf.Int64Value",
        "flushMessages": "google.protobuf.Int64Value",
        "flushMs": "google.protobuf.Int64Value",
        "minCompactionLagMs": "google.protobuf.Int64Value",
        "retentionBytes": "google.protobuf.Int64Value",
        "retentionMs": "google.protobuf.Int64Value",
        "maxMessageBytes": "google.protobuf.Int64Value",
        "minInsyncReplicas": "google.protobuf.Int64Value",
        "segmentBytes": "google.protobuf.Int64Value",
        "preallocate": "google.protobuf.BoolValue"
      }
      // end of the list of possible fields
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| topics[] | **[Topic](#yandex.cloud.mdb.kafka.v1.Topic)**

List of Kafka topics. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListTopicsRequest.pageSize](#yandex.cloud.mdb.kafka.v1.ListTopicsRequest), use the `nextPageToken` as the value for the [ListTopicsRequest.pageToken](#yandex.cloud.mdb.kafka.v1.ListTopicsRequest) parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Topic {#yandex.cloud.mdb.kafka.v1.Topic}

An Kafka topic.
For more information, see the [Concepts -> Topics and partitions](/docs/managed-kafka/concepts/topics) section of the documentation.

#|
||Field | Description ||
|| name | **string**

Name of the topic. ||
|| clusterId | **string**

ID of an Apache Kafka® cluster that the topic belongs to.

To get the Apache Kafka® cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/grpc/Cluster/list#List) request. ||
|| partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of the topic's partitions. ||
|| replicationFactor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of data copies (replicas) for the topic in the cluster. ||
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
|| cleanupPolicy | enum **CleanupPolicy**

Retention policy to use on old log messages.

- `CLEANUP_POLICY_UNSPECIFIED`
- `CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_8.logRetentionMs](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) and other similar parameters.
- `CLEANUP_POLICY_COMPACT`: This policy compacts messages in log.
- `CLEANUP_POLICY_COMPACT_AND_DELETE`: This policy use both compaction and deletion for messages and log segments. ||
|| compressionType | enum **CompressionType**

The compression type for a given topic.

- `COMPRESSION_TYPE_UNSPECIFIED`
- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| deleteRetentionMs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. ||
|| fileDeleteDelayMs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The time to wait before deleting a file from the filesystem. ||
|| flushMessages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of messages accumulated on a log partition before messages are flushed to disk.

This setting overrides the cluster-level [KafkaConfig2_8.logFlushIntervalMessages](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| flushMs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.

This setting overrides the cluster-level [KafkaConfig2_8.logFlushIntervalMs](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| minCompactionLagMs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time in milliseconds a message will remain uncompacted in the log. ||
|| retentionBytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanupPolicy` is in effect.
It is helpful if you need to control the size of log due to limited disk space.

This setting overrides the cluster-level [KafkaConfig2_8.logRetentionBytes](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| retentionMs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of milliseconds to keep a log segment's file before deleting it.

This setting overrides the cluster-level [KafkaConfig2_8.logRetentionMs](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| maxMessageBytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The largest record batch size allowed in topic. ||
|| minInsyncReplicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write
to be considered successful (when a producer sets acks to "all"). ||
|| segmentBytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This configuration controls the segment file size for the log. Retention and cleaning is always done a file
at a time so a larger segment size means fewer files but less granular control over retention.

This setting overrides the cluster-level [KafkaConfig2_8.logSegmentBytes](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

True if we should preallocate the file on disk when creating a new log segment.

This setting overrides the cluster-level [KafkaConfig2_8.logPreallocate](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|#

## TopicConfig3 {#yandex.cloud.mdb.kafka.v1.TopicConfig3}

A topic settings for 3.x

#|
||Field | Description ||
|| cleanupPolicy | enum **CleanupPolicy**

Retention policy to use on old log messages.

- `CLEANUP_POLICY_UNSPECIFIED`
- `CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig3.logRetentionMs](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) and other similar parameters.
- `CLEANUP_POLICY_COMPACT`: This policy compacts messages in log.
- `CLEANUP_POLICY_COMPACT_AND_DELETE`: This policy use both compaction and deletion for messages and log segments. ||
|| compressionType | enum **CompressionType**

The compression type for a given topic.

- `COMPRESSION_TYPE_UNSPECIFIED`
- `COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).
- `COMPRESSION_TYPE_ZSTD`: Zstandard codec.
- `COMPRESSION_TYPE_LZ4`: LZ4 codec.
- `COMPRESSION_TYPE_SNAPPY`: Snappy codec.
- `COMPRESSION_TYPE_GZIP`: GZip codec.
- `COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs). ||
|| deleteRetentionMs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. ||
|| fileDeleteDelayMs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The time to wait before deleting a file from the filesystem. ||
|| flushMessages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of messages accumulated on a log partition before messages are flushed to disk.

This setting overrides the cluster-level [KafkaConfig3.logFlushIntervalMessages](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| flushMs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.

This setting overrides the cluster-level [KafkaConfig3.logFlushIntervalMs](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| minCompactionLagMs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time in milliseconds a message will remain uncompacted in the log. ||
|| retentionBytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanupPolicy` is in effect.
It is helpful if you need to control the size of log due to limited disk space.

This setting overrides the cluster-level [KafkaConfig3.logRetentionBytes](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| retentionMs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of milliseconds to keep a log segment's file before deleting it.

This setting overrides the cluster-level [KafkaConfig3.logRetentionMs](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| maxMessageBytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The largest record batch size allowed in topic. ||
|| minInsyncReplicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write
to be considered successful (when a producer sets acks to "all"). ||
|| segmentBytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This configuration controls the segment file size for the log. Retention and cleaning is always done a file
at a time so a larger segment size means fewer files but less granular control over retention.

This setting overrides the cluster-level [KafkaConfig3.logSegmentBytes](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

True if we should preallocate the file on disk when creating a new log segment.

This setting overrides the cluster-level [KafkaConfig3.logPreallocate](/docs/managed-kafka/api-ref/grpc/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|#