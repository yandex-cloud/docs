---
editable: false
---

# Topic
A set of methods for managing Apache Kafka topics.
## JSON-представление {#representation}
```json 
{
  "name": "string",
  "clusterId": "string",
  "partitions": "integer",
  "replicationFactor": "integer",
  "topicConfig_2_1": {
    "cleanupPolicy": "string",
    "compressionType": "string",
    "deleteRetentionMs": "integer",
    "fileDeleteDelayMs": "integer",
    "flushMessages": "integer",
    "flushMs": "integer",
    "minCompactionLagMs": "integer",
    "retentionBytes": "integer",
    "retentionMs": "integer"
  }
}
```
 
Поле | Описание
--- | ---
name | **string**<br><p>Name of the topic.</p> 
clusterId | **string**<br><p>ID of an Apache Kafka cluster that the topic belongs to.</p> <p>To get the Apache Kafka cluster ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> 
partitions | **integer** (int64)<br><p>The number of the topic's partitions.</p> 
replicationFactor | **integer** (int64)<br><p>Amount of data copies (replicas) for the topic in the cluster.</p> 
topicConfig_2_1 | **object**<br><p>A topic settings.</p> 
topicConfig_2_1.<br>cleanupPolicy | **string**<br><p>Retention policy to use on old log messages.</p> <ul> <li>CLEANUP_POLICY_DELETE: This policy discards log segments when either their retention time or log size limit is reached.</li> </ul> <p>See also: [Cluster.config.kafka.kafka_config.log_retention_ms] and other similar parameters.</p> <ul> <li>CLEANUP_POLICY_COMPACT: This policy compacts messages in log.</li> <li>CLEANUP_POLICY_COMPACT_AND_DELETE: This policy use both compaction and deletion for messages and log segments.</li> </ul> 
topicConfig_2_1.<br>compressionType | **string**<br><p>Specify the compression type for a given topic.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: No codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: The codec to use is set by a producer (can be any of ZSTD<code>, </code>LZ4<code>, </code>GZIP<code>or</code>SNAPPY` codecs).</li> </ul> 
topicConfig_2_1.<br>deleteRetentionMs | **integer** (int64)<br><p>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.</p> 
topicConfig_2_1.<br>fileDeleteDelayMs | **integer** (int64)<br><p>The time to wait before deleting a file from the filesystem.</p> 
topicConfig_2_1.<br>flushMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_messages] setting on the topic level.</p> 
topicConfig_2_1.<br>flushMs | **integer** (int64)<br><p>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.</p> <p>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_ms] setting on the topic level.</p> 
topicConfig_2_1.<br>minCompactionLagMs | **integer** (int64)<br><p>The minimum time in milliseconds a message will remain uncompacted in the log.</p> 
topicConfig_2_1.<br>retentionBytes | **integer** (int64)<br><p>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the <code>delete</code> <code>cleanupPolicy</code> is in effect. It is helpful if you need to control the size of log due to limited disk space.</p> <p>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_bytes] setting on the topic level.</p> 
topicConfig_2_1.<br>retentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment's file before deleting it.</p> <p>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_ms] setting on the topic level.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Creates a new Apache Kafka topic in the specified cluster.
[delete](delete.md) | Deletes the specified Apache Kafka topic.
[get](get.md) | Returns the specified Apache Kafka topic.
[list](list.md) | Retrieves the list of Apache Kafka topics in the specified cluster.
[update](update.md) | Updates the specified Apache Kafka topic.