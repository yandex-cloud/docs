---
editable: false
---

# Method list
Retrieves the list of Apache Kafka Topic resources in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/topics
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Apache Kafka cluster to list topics in. To get the cluster ID use a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum value is 1000.
pageToken | Page token. To get the next page of results, Set [pageToken](/docs/managed-kafka/api-ref/Topic/list#query_params) to the [nextPageToken](/docs/managed-kafka/api-ref/Topic/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "topics": [
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
topics[] | **object**<br><p>A Apache Kafka Topic resource. For more information, see the <a href="/docs/mdb/kafka/concepts">Developer's Guide</a>.</p> 
topics[].<br>name | **string**<br><p>Name of the topic.</p> 
topics[].<br>clusterId | **string**<br><p>ID of the Apache Kafka cluster that the topic belongs to.</p> 
topics[].<br>partitions | **integer** (int64)<br><p>Number of topic partitions.</p> 
topics[].<br>replicationFactor | **integer** (int64)<br><p>Amount of copies of a topic data kept in a cluster.</p> 
topics[].<br>topicConfig_2_1 | **object**<br>
topics[].<br>topicConfig_2_1.<br>cleanupPolicy | **string**<br><p>Retention policy to use on old log segments.</p> 
topics[].<br>topicConfig_2_1.<br>compressionType | **string**<br><p>Specify the final compression type for a given topic.</p> 
topics[].<br>topicConfig_2_1.<br>deleteRetentionMs | **integer** (int64)<br><p>The amount of time to retain delete tombstone markers for log compacted topics.</p> 
topics[].<br>topicConfig_2_1.<br>fileDeleteDelayMs | **integer** (int64)<br><p>The time to wait before deleting a file from the filesystem</p> 
topics[].<br>topicConfig_2_1.<br>flushMessages | **integer** (int64)<br><p>This setting allows specifying an interval at which we will force an fsync of data written to the log</p> 
topics[].<br>topicConfig_2_1.<br>flushMs | **integer** (int64)<br><p>This setting allows specifying a time interval at which we will force an fsync of data written to the log</p> 
topics[].<br>topicConfig_2_1.<br>minCompactionLagMs | **integer** (int64)<br><p>The minimum time a message will remain uncompacted in the log.</p> 
topics[].<br>topicConfig_2_1.<br>retentionBytes | **integer** (int64)<br><p>This configuration controls the maximum size a partition (which consists of log segments) can grow to before we will discard old log segments to free up space if we are using the &quot;delete&quot; retention policy</p> 
topics[].<br>topicConfig_2_1.<br>retentionMs | **integer** (int64)<br><p>This configuration controls the maximum time we will retain a log before we will discard old log segments to free up space if we are using the &quot;delete&quot; retention policy.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-kafka/api-ref/Topic/list#query_params">pageSize</a>, use the <a href="/docs/managed-kafka/api-ref/Topic/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-kafka/api-ref/Topic/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-kafka/api-ref/Topic/list#responses">nextPageToken</a> to continue paging through the results.</p> 