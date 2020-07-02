---
editable: false
---

# Topic
A set of methods for managing Apache Kafka Topic resources.
## JSON Representation {#representation}
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
 
Field | Description
--- | ---
name | **string**<br><p>Name of the topic.</p> 
clusterId | **string**<br><p>ID of the Apache Kafka cluster that the topic belongs to.</p> 
partitions | **integer** (int64)<br><p>Number of topic partitions.</p> 
replicationFactor | **integer** (int64)<br><p>Amount of copies of a topic data kept in a cluster.</p> 
topicConfig_2_1 | **object**<br>
topicConfig_2_1.<br>cleanupPolicy | **string**<br><p>Retention policy to use on old log segments.</p> 
topicConfig_2_1.<br>compressionType | **string**<br><p>Specify the final compression type for a given topic.</p> 
topicConfig_2_1.<br>deleteRetentionMs | **integer** (int64)<br><p>The amount of time to retain delete tombstone markers for log compacted topics.</p> 
topicConfig_2_1.<br>fileDeleteDelayMs | **integer** (int64)<br><p>The time to wait before deleting a file from the filesystem</p> 
topicConfig_2_1.<br>flushMessages | **integer** (int64)<br><p>This setting allows specifying an interval at which we will force an fsync of data written to the log</p> 
topicConfig_2_1.<br>flushMs | **integer** (int64)<br><p>This setting allows specifying a time interval at which we will force an fsync of data written to the log</p> 
topicConfig_2_1.<br>minCompactionLagMs | **integer** (int64)<br><p>The minimum time a message will remain uncompacted in the log.</p> 
topicConfig_2_1.<br>retentionBytes | **integer** (int64)<br><p>This configuration controls the maximum size a partition (which consists of log segments) can grow to before we will discard old log segments to free up space if we are using the &quot;delete&quot; retention policy</p> 
topicConfig_2_1.<br>retentionMs | **integer** (int64)<br><p>This configuration controls the maximum time we will retain a log before we will discard old log segments to free up space if we are using the &quot;delete&quot; retention policy.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a new Apache Kafka topic in the specified cluster.
[delete](delete.md) | Deletes the specified Apache Kafka topic.
[get](get.md) | Returns the specified Apache Kafka Topic resource.
[list](list.md) | Retrieves the list of Apache Kafka Topic resources in the specified cluster.
[update](update.md) | Updates the specified Apache Kafka topic.