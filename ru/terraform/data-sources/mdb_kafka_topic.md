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
- `partitions` (*Read-Only*) (Number). The number of the topic's partitions.
- `replication_factor` (*Read-Only*) (Number). Amount of data copies (replicas) for the topic in the cluster.
- `topic_config` (*Read-Only*) (List Of Object). User-defined settings for the topic. For more information, see [the official documentation](https://yandex.cloud/docs/managed-kafka/concepts/settings-list#topic-settings) and [the Kafka documentation](https://kafka.apache.org/documentation/#topicconfigs).
  - `cleanup_policy` . 
  - `compression_type` . 
  - `delete_retention_ms` . 
  - `file_delete_delay_ms` . 
  - `flush_messages` . 
  - `flush_ms` . 
  - `max_message_bytes` . 
  - `message_timestamp_type` . 
  - `min_compaction_lag_ms` . 
  - `min_insync_replicas` . 
  - `preallocate` . 
  - `retention_bytes` . 
  - `retention_ms` . 
  - `segment_bytes` .


