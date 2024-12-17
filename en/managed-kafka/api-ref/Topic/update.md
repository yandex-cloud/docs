---
editable: false
sourcePath: en/_api-ref/mdb/kafka/v1/api-ref/Topic/update.md
---

# Managed Service for Apache Kafka® API, REST: Topic.Update

Updates the specified Kafka topic.

## HTTP request

```
PATCH https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}/topics/{topicName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Apache Kafka® cluster to update a topic in.

To get the cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/Cluster/list#List) request. ||
|| topicName | **string**

Required field. Name of the topic to update.

To get the name of the topic, make a [TopicService.List](/docs/managed-kafka/api-ref/Topic/list#List) request. ||
|#

## Body parameters {#yandex.cloud.mdb.kafka.v1.UpdateTopicRequest}

```json
{
  "updateMask": "object",
  "topicSpec": {
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
}
```

#|
||Field | Description ||
|| updateMask | **object** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| topicSpec | **[TopicSpec](#yandex.cloud.mdb.kafka.v1.TopicSpec)**

New configuration of the topic.

Use `updateMask` to prevent reverting all topic settings that are not listed in `topicSpec` to their default values. ||
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
- `CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_8.logRetentionMs](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) and other similar parameters.
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

This setting overrides the cluster-level [KafkaConfig2_8.logFlushIntervalMessages](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| flushMs | **string** (int64)

The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.

This setting overrides the cluster-level [KafkaConfig2_8.logFlushIntervalMs](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| minCompactionLagMs | **string** (int64)

The minimum time in milliseconds a message will remain uncompacted in the log. ||
|| retentionBytes | **string** (int64)

The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanupPolicy` is in effect.
It is helpful if you need to control the size of log due to limited disk space.

This setting overrides the cluster-level [KafkaConfig2_8.logRetentionBytes](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| retentionMs | **string** (int64)

The number of milliseconds to keep a log segment's file before deleting it.

This setting overrides the cluster-level [KafkaConfig2_8.logRetentionMs](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| maxMessageBytes | **string** (int64)

The largest record batch size allowed in topic. ||
|| minInsyncReplicas | **string** (int64)

This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write
to be considered successful (when a producer sets acks to "all"). ||
|| segmentBytes | **string** (int64)

This configuration controls the segment file size for the log. Retention and cleaning is always done a file
at a time so a larger segment size means fewer files but less granular control over retention.

This setting overrides the cluster-level [KafkaConfig2_8.logSegmentBytes](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| preallocate | **boolean**

True if we should preallocate the file on disk when creating a new log segment.

This setting overrides the cluster-level [KafkaConfig2_8.logPreallocate](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|#

## TopicConfig3 {#yandex.cloud.mdb.kafka.v1.TopicConfig3}

A topic settings for 3.x

#|
||Field | Description ||
|| cleanupPolicy | **enum** (CleanupPolicy)

Retention policy to use on old log messages.

- `CLEANUP_POLICY_UNSPECIFIED`
- `CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig3.logRetentionMs](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) and other similar parameters.
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

This setting overrides the cluster-level [KafkaConfig3.logFlushIntervalMessages](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| flushMs | **string** (int64)

The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.

This setting overrides the cluster-level [KafkaConfig3.logFlushIntervalMs](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| minCompactionLagMs | **string** (int64)

The minimum time in milliseconds a message will remain uncompacted in the log. ||
|| retentionBytes | **string** (int64)

The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanupPolicy` is in effect.
It is helpful if you need to control the size of log due to limited disk space.

This setting overrides the cluster-level [KafkaConfig3.logRetentionBytes](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| retentionMs | **string** (int64)

The number of milliseconds to keep a log segment's file before deleting it.

This setting overrides the cluster-level [KafkaConfig3.logRetentionMs](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| maxMessageBytes | **string** (int64)

The largest record batch size allowed in topic. ||
|| minInsyncReplicas | **string** (int64)

This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write
to be considered successful (when a producer sets acks to "all"). ||
|| segmentBytes | **string** (int64)

This configuration controls the segment file size for the log. Retention and cleaning is always done a file
at a time so a larger segment size means fewer files but less granular control over retention.

This setting overrides the cluster-level [KafkaConfig3.logSegmentBytes](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| preallocate | **boolean**

True if we should preallocate the file on disk when creating a new log segment.

This setting overrides the cluster-level [KafkaConfig3.logPreallocate](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
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
    "clusterId": "string",
    "topicName": "string"
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
    "name": "string",
    "clusterId": "string",
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
|| metadata | **[UpdateTopicMetadata](#yandex.cloud.mdb.kafka.v1.UpdateTopicMetadata)**

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

## UpdateTopicMetadata {#yandex.cloud.mdb.kafka.v1.UpdateTopicMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Apache Kafka® cluster where a topic is being updated. ||
|| topicName | **string**

Name of the Kafka topic that is being updated. ||
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

## Topic {#yandex.cloud.mdb.kafka.v1.Topic}

An Kafka topic.
For more information, see the [Concepts -> Topics and partitions](/docs/managed-kafka/concepts/topics) section of the documentation.

#|
||Field | Description ||
|| name | **string**

Name of the topic. ||
|| clusterId | **string**

ID of an Apache Kafka® cluster that the topic belongs to.

To get the Apache Kafka® cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/Cluster/list#List) request. ||
|| partitions | **string** (int64)

The number of the topic's partitions. ||
|| replicationFactor | **string** (int64)

Amount of data copies (replicas) for the topic in the cluster. ||
|| topicConfig_2_8 | **[TopicConfig2_8](#yandex.cloud.mdb.kafka.v1.TopicConfig2_82)**

Includes only one of the fields `topicConfig_2_8`, `topicConfig_3`.

User-defined settings for the topic. ||
|| topicConfig_3 | **[TopicConfig3](#yandex.cloud.mdb.kafka.v1.TopicConfig32)**

Includes only one of the fields `topicConfig_2_8`, `topicConfig_3`.

User-defined settings for the topic. ||
|#

## TopicConfig2_8 {#yandex.cloud.mdb.kafka.v1.TopicConfig2_82}

A topic settings for 2.8

#|
||Field | Description ||
|| cleanupPolicy | **enum** (CleanupPolicy)

Retention policy to use on old log messages.

- `CLEANUP_POLICY_UNSPECIFIED`
- `CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_8.logRetentionMs](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) and other similar parameters.
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

This setting overrides the cluster-level [KafkaConfig2_8.logFlushIntervalMessages](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| flushMs | **string** (int64)

The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.

This setting overrides the cluster-level [KafkaConfig2_8.logFlushIntervalMs](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| minCompactionLagMs | **string** (int64)

The minimum time in milliseconds a message will remain uncompacted in the log. ||
|| retentionBytes | **string** (int64)

The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanupPolicy` is in effect.
It is helpful if you need to control the size of log due to limited disk space.

This setting overrides the cluster-level [KafkaConfig2_8.logRetentionBytes](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| retentionMs | **string** (int64)

The number of milliseconds to keep a log segment's file before deleting it.

This setting overrides the cluster-level [KafkaConfig2_8.logRetentionMs](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| maxMessageBytes | **string** (int64)

The largest record batch size allowed in topic. ||
|| minInsyncReplicas | **string** (int64)

This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write
to be considered successful (when a producer sets acks to "all"). ||
|| segmentBytes | **string** (int64)

This configuration controls the segment file size for the log. Retention and cleaning is always done a file
at a time so a larger segment size means fewer files but less granular control over retention.

This setting overrides the cluster-level [KafkaConfig2_8.logSegmentBytes](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|| preallocate | **boolean**

True if we should preallocate the file on disk when creating a new log segment.

This setting overrides the cluster-level [KafkaConfig2_8.logPreallocate](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig2_8) setting on the topic level. ||
|#

## TopicConfig3 {#yandex.cloud.mdb.kafka.v1.TopicConfig32}

A topic settings for 3.x

#|
||Field | Description ||
|| cleanupPolicy | **enum** (CleanupPolicy)

Retention policy to use on old log messages.

- `CLEANUP_POLICY_UNSPECIFIED`
- `CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig3.logRetentionMs](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) and other similar parameters.
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

This setting overrides the cluster-level [KafkaConfig3.logFlushIntervalMessages](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| flushMs | **string** (int64)

The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.

This setting overrides the cluster-level [KafkaConfig3.logFlushIntervalMs](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| minCompactionLagMs | **string** (int64)

The minimum time in milliseconds a message will remain uncompacted in the log. ||
|| retentionBytes | **string** (int64)

The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanupPolicy` is in effect.
It is helpful if you need to control the size of log due to limited disk space.

This setting overrides the cluster-level [KafkaConfig3.logRetentionBytes](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| retentionMs | **string** (int64)

The number of milliseconds to keep a log segment's file before deleting it.

This setting overrides the cluster-level [KafkaConfig3.logRetentionMs](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| maxMessageBytes | **string** (int64)

The largest record batch size allowed in topic. ||
|| minInsyncReplicas | **string** (int64)

This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write
to be considered successful (when a producer sets acks to "all"). ||
|| segmentBytes | **string** (int64)

This configuration controls the segment file size for the log. Retention and cleaning is always done a file
at a time so a larger segment size means fewer files but less granular control over retention.

This setting overrides the cluster-level [KafkaConfig3.logSegmentBytes](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|| preallocate | **boolean**

True if we should preallocate the file on disk when creating a new log segment.

This setting overrides the cluster-level [KafkaConfig3.logPreallocate](/docs/managed-kafka/api-ref/Cluster/get#yandex.cloud.mdb.kafka.v1.KafkaConfig3) setting on the topic level. ||
|#