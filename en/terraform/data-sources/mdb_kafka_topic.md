---
subcategory: Managed Service for Apache Kafka®
---

# yandex_mdb_kafka_topic (DataSource)

Get information about a topic of the Yandex Managed Kafka cluster. For more information, see [the official documentation](https://yandex.cloud/docs/managed-kafka/concepts).

## Example usage

```terraform
//
// Get information about existing MDB Kafka Topic.
//
data "yandex_mdb_kafka_topic" "foo" {
  cluster_id = "some_cluster_id"
  name       = "test"
}

output "replication_factor" {
  value = data.yandex_mdb_kafka_topic.foo.replication_factor
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). The ID of the Kafka cluster.
- `id` (String). 
- `name` (**Required**)(String). The resource name.
- `partitions` (**Required**)(Number). The number of the topic's partitions.
- `replication_factor` (**Required**)(Number). Amount of data copies (replicas) for the topic in the cluster.
- `topic_config` [Block]. User-defined settings for the topic. For more information, see [the official documentation](https://yandex.cloud/docs/managed-kafka/concepts/settings-list#topic-settings) and [the Kafka documentation](https://kafka.apache.org/documentation/#topicconfigs).
  - `cleanup_policy` (String). Retention policy to use on log segments.
  - `compression_type` (String). Compression type of kafka topic.
  - `delete_retention_ms` (String). The amount of time to retain delete tombstone markers for log compacted topics.
  - `file_delete_delay_ms` (String). The time to wait before deleting a file from the filesystem.
  - `flush_messages` (String). This setting allows specifying an interval at which we will force an fsync of data written to the log.
  - `flush_ms` (String). This setting allows specifying a time interval at which we will force an fsync of data written to the log.
  - `max_message_bytes` (String). The largest record batch size allowed by Kafka (after compression if compression is enabled).
  - `message_timestamp_type` (String). Define whether the timestamp in the message is message create time or log append time. Possible values: LOG_APPEND_TIME or CREATE_TIME.
  - `min_compaction_lag_ms` (String). The minimum time a message will remain uncompacted in the log. Only applicable for logs that are being compacted.
  - `min_insync_replicas` (String). When a producer sets acks to "all" (or "-1"), this configuration specifies the minimum number of replicas that must acknowledge a write for the write to be considered successful. 
  - `preallocate` (Bool). True if we should preallocate the file on disk when creating a new log segment.
  - `retention_bytes` (String). This configuration controls the maximum size a partition (which consists of log segments) can grow to before we will discard old log segments to free up space if we are using the "delete" retention policy.
  - `retention_ms` (String). This configuration controls the maximum time we will retain a log before we will discard old log segments to free up space if we are using the "delete" retention policy.
  - `segment_bytes` (String). This configuration controls the segment file size for the log.


