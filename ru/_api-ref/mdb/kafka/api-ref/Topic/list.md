---
editable: false
---

# Метод list
Retrieves the list of Apache Kafka topics in the specified cluster.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/topics
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. ID of the Apache Kafka cluster to list topics in.  To get the cluster ID, make a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | The maximum number of results per page to return.  If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/managed-kafka/api-ref/Topic/list#responses) that can be used to get the next page of results in subsequent list requests.  Максимальное значение — 1000.
pageToken | Page token.  To get the next page of results, set `page_token` to the [nextPageToken](/docs/managed-kafka/api-ref/Topic/list#responses) returned by a previous list request.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
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

 
Поле | Описание
--- | ---
topics[] | **object**<br><p>An Apache Kafka topic. For more information, see the <a href="/docs/managed-kafka/concepts/topics">Concepts → Topics and partitions</a> section of the documentation.</p> 
topics[].<br>name | **string**<br><p>Name of the topic.</p> 
topics[].<br>clusterId | **string**<br><p>ID of an Apache Kafka cluster that the topic belongs to.</p> <p>To get the Apache Kafka cluster ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> 
topics[].<br>partitions | **integer** (int64)<br><p>The number of the topic's partitions.</p> 
topics[].<br>replicationFactor | **integer** (int64)<br><p>Amount of data copies (replicas) for the topic in the cluster.</p> 
topics[].<br>topicConfig_2_1 | **object**<br><p>A topic settings.</p> 
topics[].<br>topicConfig_2_1.<br>cleanupPolicy | **string**<br><p>Retention policy to use on old log messages.</p> <ul> <li>CLEANUP_POLICY_DELETE: This policy discards log segments when either their retention time or log size limit is reached.</li> </ul> <p>See also: [Cluster.config.kafka.kafka_config.log_retention_ms] and other similar parameters.</p> <ul> <li>CLEANUP_POLICY_COMPACT: This policy compacts messages in log.</li> <li>CLEANUP_POLICY_COMPACT_AND_DELETE: This policy use both compaction and deletion for messages and log segments.</li> </ul> 
topics[].<br>topicConfig_2_1.<br>compressionType | **string**<br><p>Specify the compression type for a given topic.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: No codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: The codec to use is set by a producer (can be any of ZSTD<code>, </code>LZ4<code>, </code>GZIP<code>or</code>SNAPPY` codecs).</li> </ul> 
topics[].<br>topicConfig_2_1.<br>deleteRetentionMs | **integer** (int64)<br><p>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.</p> 
topics[].<br>topicConfig_2_1.<br>fileDeleteDelayMs | **integer** (int64)<br><p>The time to wait before deleting a file from the filesystem.</p> 
topics[].<br>topicConfig_2_1.<br>flushMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_messages] setting on the topic level.</p> 
topics[].<br>topicConfig_2_1.<br>flushMs | **integer** (int64)<br><p>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.</p> <p>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_ms] setting on the topic level.</p> 
topics[].<br>topicConfig_2_1.<br>minCompactionLagMs | **integer** (int64)<br><p>The minimum time in milliseconds a message will remain uncompacted in the log.</p> 
topics[].<br>topicConfig_2_1.<br>retentionBytes | **integer** (int64)<br><p>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the <code>delete</code> <code>cleanupPolicy</code> is in effect. It is helpful if you need to control the size of log due to limited disk space.</p> <p>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_bytes] setting on the topic level.</p> 
topics[].<br>topicConfig_2_1.<br>retentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment's file before deleting it.</p> <p>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_ms] setting on the topic level.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-kafka/api-ref/Topic/list#query_params">pageSize</a>, use the <code>next_page_token</code> as the value for the <a href="/docs/managed-kafka/api-ref/Topic/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <code>next_page_token</code> to continue paging through the results.</p> 