---
editable: false
---

# Method get
Returns the specified Apache Kafka Topic resource.
 
To get the list of available Apache Kafka Topic resources, make a [list](/docs/managed-kafka/api-ref/Topic/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/topics/{topicName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Apache Kafka cluster that the topic belongs to. To get the cluster ID use a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
topicName | Required. Name of the Apache Kafka Topic resource to return. To get the name of the topic use a [list](/docs/managed-kafka/api-ref/Topic/list) request.  The string length in characters must be 1-63. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.
 
## Response {#responses}
**HTTP Code: 200 - OK**

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
A Apache Kafka Topic resource. For more information, see
the [Developer's Guide](/docs/mdb/kafka/concepts).
 
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