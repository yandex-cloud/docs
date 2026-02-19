---
editable: false
noIndex: true
---

# yc beta managed-kafka topic create

Creates a new Kafka topic in the specified cluster.

#### Command Usage

Syntax:

`yc beta managed-kafka topic create <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--cluster-id` | `string`

ID of the Apache Kafka® cluster to create a topic in. To get the cluster ID, make a [ClusterService.List] request. ||
|| `--topic-spec` | `shorthand/json`

Configuration of the topic to create.

Shorthand Syntax:

```hcl
{
  name = string,
  partitions = integer,
  replication-factor = integer,
  topic-config = topic-config-2-8={
    cleanup-policy = CLEANUP_POLICY_DELETE|CLEANUP_POLICY_COMPACT|CLEANUP_POLICY_COMPACT_AND_DELETE,
    compression-type = COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER,
    delete-retention-ms = integer,
    file-delete-delay-ms = integer,
    flush-messages = integer,
    flush-ms = integer,
    max-message-bytes = integer,
    message-timestamp-type = MESSAGE_TIMESTAMP_TYPE_CREATE_TIME|MESSAGE_TIMESTAMP_TYPE_LOG_APPEND_TIME,
    min-compaction-lag-ms = integer,
    min-insync-replicas = integer,
    preallocate = boolean,
    retention-bytes = integer,
    retention-ms = integer,
    segment-bytes = integer
  } | topic-config-3={
    cleanup-policy = CLEANUP_POLICY_DELETE|CLEANUP_POLICY_COMPACT|CLEANUP_POLICY_COMPACT_AND_DELETE,
    compression-type = COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER,
    delete-retention-ms = integer,
    file-delete-delay-ms = integer,
    flush-messages = integer,
    flush-ms = integer,
    max-message-bytes = integer,
    message-timestamp-type = MESSAGE_TIMESTAMP_TYPE_CREATE_TIME|MESSAGE_TIMESTAMP_TYPE_LOG_APPEND_TIME,
    min-compaction-lag-ms = integer,
    min-insync-replicas = integer,
    preallocate = boolean,
    retention-bytes = integer,
    retention-ms = integer,
    segment-bytes = integer
  } | topic-config-4={
    cleanup-policy = CLEANUP_POLICY_DELETE|CLEANUP_POLICY_COMPACT|CLEANUP_POLICY_COMPACT_AND_DELETE,
    compression-type = COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER,
    delete-retention-ms = integer,
    file-delete-delay-ms = integer,
    flush-messages = integer,
    flush-ms = integer,
    max-message-bytes = integer,
    message-timestamp-type = MESSAGE_TIMESTAMP_TYPE_CREATE_TIME|MESSAGE_TIMESTAMP_TYPE_LOG_APPEND_TIME,
    min-compaction-lag-ms = integer,
    min-insync-replicas = integer,
    preallocate = boolean,
    retention-bytes = integer,
    retention-ms = integer,
    segment-bytes = integer
  }
}
```

JSON Syntax:

```json
{
  "name": "string",
  "partitions": "integer",
  "replication-factor": "integer",
  "topic-config": {
    "topic-config-2-8": {
      "cleanup-policy": "CLEANUP_POLICY_DELETE|CLEANUP_POLICY_COMPACT|CLEANUP_POLICY_COMPACT_AND_DELETE",
      "compression-type": "COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER",
      "delete-retention-ms": "integer",
      "file-delete-delay-ms": "integer",
      "flush-messages": "integer",
      "flush-ms": "integer",
      "max-message-bytes": "integer",
      "message-timestamp-type": "MESSAGE_TIMESTAMP_TYPE_CREATE_TIME|MESSAGE_TIMESTAMP_TYPE_LOG_APPEND_TIME",
      "min-compaction-lag-ms": "integer",
      "min-insync-replicas": "integer",
      "preallocate": "boolean",
      "retention-bytes": "integer",
      "retention-ms": "integer",
      "segment-bytes": "integer"
    },
    "topic-config-3": {
      "cleanup-policy": "CLEANUP_POLICY_DELETE|CLEANUP_POLICY_COMPACT|CLEANUP_POLICY_COMPACT_AND_DELETE",
      "compression-type": "COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER",
      "delete-retention-ms": "integer",
      "file-delete-delay-ms": "integer",
      "flush-messages": "integer",
      "flush-ms": "integer",
      "max-message-bytes": "integer",
      "message-timestamp-type": "MESSAGE_TIMESTAMP_TYPE_CREATE_TIME|MESSAGE_TIMESTAMP_TYPE_LOG_APPEND_TIME",
      "min-compaction-lag-ms": "integer",
      "min-insync-replicas": "integer",
      "preallocate": "boolean",
      "retention-bytes": "integer",
      "retention-ms": "integer",
      "segment-bytes": "integer"
    },
    "topic-config-4": {
      "cleanup-policy": "CLEANUP_POLICY_DELETE|CLEANUP_POLICY_COMPACT|CLEANUP_POLICY_COMPACT_AND_DELETE",
      "compression-type": "COMPRESSION_TYPE_UNCOMPRESSED|COMPRESSION_TYPE_ZSTD|COMPRESSION_TYPE_LZ4|COMPRESSION_TYPE_SNAPPY|COMPRESSION_TYPE_GZIP|COMPRESSION_TYPE_PRODUCER",
      "delete-retention-ms": "integer",
      "file-delete-delay-ms": "integer",
      "flush-messages": "integer",
      "flush-ms": "integer",
      "max-message-bytes": "integer",
      "message-timestamp-type": "MESSAGE_TIMESTAMP_TYPE_CREATE_TIME|MESSAGE_TIMESTAMP_TYPE_LOG_APPEND_TIME",
      "min-compaction-lag-ms": "integer",
      "min-insync-replicas": "integer",
      "preallocate": "boolean",
      "retention-bytes": "integer",
      "retention-ms": "integer",
      "segment-bytes": "integer"
    }
  }
}
```

Fields:

```
name -> (string)
  Name of the topic.
partitions -> (integer)
  The number of the topic's partitions.
replication-factor -> (integer)
  Amount of copies of a topic data kept in the cluster.
topic-config -> (oneof<topic-config-2-8|topic-config-3|topic-config-4>)
  Oneof topic-config field
  topic-config-2-8 -> (struct)
    Configuration of the Apache Kafka® 2.8 topic.
    cleanup-policy -> (struct)
      Retention policy to use on old log messages.
    compression-type -> (struct)
      The compression type for a given topic.
    delete-retention-ms -> (integer)
      The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.
    file-delete-delay-ms -> (integer)
      The time to wait before deleting a file from the filesystem.
    flush-messages -> (integer)
      The number of messages accumulated on a log partition before messages are flushed to disk. This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_messages] setting on the topic level.
    flush-ms -> (integer)
      The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_ms] setting on the topic level.
    max-message-bytes -> (integer)
      The largest record batch size allowed in topic.
    message-timestamp-type -> (struct)
      Define whether the timestamp in the message is message create time or log append time.
    min-compaction-lag-ms -> (integer)
      The minimum time in milliseconds a message will remain uncompacted in the log.
    min-insync-replicas -> (integer)
      This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all").
    preallocate -> (boolean)
      True if we should preallocate the file on disk when creating a new log segment. This setting overrides the cluster-level [KafkaConfig2_8.log_preallocate] setting on the topic level.
    retention-bytes -> (integer)
      The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the 'delete' [cleanup_policy] is in effect. It is helpful if you need to control the size of log due to limited disk space. This setting overrides the cluster-level [KafkaConfig2_8.log_retention_bytes] setting on the topic level.
    retention-ms -> (integer)
      The number of milliseconds to keep a log segment's file before deleting it. This setting overrides the cluster-level [KafkaConfig2_8.log_retention_ms] setting on the topic level.
    segment-bytes -> (integer)
      This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. This setting overrides the cluster-level [KafkaConfig2_8.log_segment_bytes] setting on the topic level.
  topic-config-3 -> (struct)
    Configuration of the Apache Kafka® 3.x topic.
    cleanup-policy -> (struct)
      Retention policy to use on old log messages.
    compression-type -> (struct)
      The compression type for a given topic.
    delete-retention-ms -> (integer)
      The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.
    file-delete-delay-ms -> (integer)
      The time to wait before deleting a file from the filesystem.
    flush-messages -> (integer)
      The number of messages accumulated on a log partition before messages are flushed to disk. This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_messages] setting on the topic level.
    flush-ms -> (integer)
      The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_ms] setting on the topic level.
    max-message-bytes -> (integer)
      The largest record batch size allowed in topic.
    message-timestamp-type -> (struct)
      Define whether the timestamp in the message is message create time or log append time.
    min-compaction-lag-ms -> (integer)
      The minimum time in milliseconds a message will remain uncompacted in the log.
    min-insync-replicas -> (integer)
      This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all").
    preallocate -> (boolean)
      True if we should preallocate the file on disk when creating a new log segment. This setting overrides the cluster-level [KafkaConfig3.log_preallocate] setting on the topic level.
    retention-bytes -> (integer)
      The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the 'delete' [cleanup_policy] is in effect. It is helpful if you need to control the size of log due to limited disk space. This setting overrides the cluster-level [KafkaConfig3.log_retention_bytes] setting on the topic level.
    retention-ms -> (integer)
      The number of milliseconds to keep a log segment's file before deleting it. This setting overrides the cluster-level [KafkaConfig3.log_retention_ms] setting on the topic level.
    segment-bytes -> (integer)
      This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. This setting overrides the cluster-level [KafkaConfig3.log_segment_bytes] setting on the topic level.
  topic-config-4 -> (struct)
    Configuration of the Apache Kafka® 4.x topic.
    cleanup-policy -> (struct)
      Retention policy to use on old log messages.
    compression-type -> (struct)
      The compression type for a given topic.
    delete-retention-ms -> (integer)
      The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.
    file-delete-delay-ms -> (integer)
      The time to wait before deleting a file from the filesystem.
    flush-messages -> (integer)
      The number of messages accumulated on a log partition before messages are flushed to disk. This setting overrides the cluster-level [KafkaConfig4.log_flush_interval_messages] setting on the topic level.
    flush-ms -> (integer)
      The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. This setting overrides the cluster-level [KafkaConfig4.log_flush_interval_ms] setting on the topic level.
    max-message-bytes -> (integer)
      The largest record batch size allowed in topic.
    message-timestamp-type -> (struct)
      Define whether the timestamp in the message is message create time or log append time.
    min-compaction-lag-ms -> (integer)
      The minimum time in milliseconds a message will remain uncompacted in the log.
    min-insync-replicas -> (integer)
      This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all").
    preallocate -> (boolean)
      True if we should preallocate the file on disk when creating a new log segment. This setting overrides the cluster-level [KafkaConfig4.log_preallocate] setting on the topic level.
    retention-bytes -> (integer)
      The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the 'delete' [cleanup_policy] is in effect. It is helpful if you need to control the size of log due to limited disk space. This setting overrides the cluster-level [KafkaConfig4.log_retention_bytes] setting on the topic level.
    retention-ms -> (integer)
      The number of milliseconds to keep a log segment's file before deleting it. This setting overrides the cluster-level [KafkaConfig4.log_retention_ms] setting on the topic level.
    segment-bytes -> (integer)
      This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. This setting overrides the cluster-level [KafkaConfig4.log_segment_bytes] setting on the topic level.
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#