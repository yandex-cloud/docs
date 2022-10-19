---
editable: false
---

# Method list
Retrieves the list of Kafka topics in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}/topics
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Apache Kafka® cluster to list topics in.</p> <p>To get the cluster ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-kafka/api-ref/Topic/list#query_params">pageSize</a>, the service returns a <a href="/docs/managed-kafka/api-ref/Topic/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token.</p> <p>To get the next page of results, set <a href="/docs/managed-kafka/api-ref/Topic/list#query_params">pageToken</a> to the <a href="/docs/managed-kafka/api-ref/Topic/list#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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

      // `topics[]` includes only one of the fields `topicConfig_2_1`, `topicConfig_2_6`, `topicConfig_2_8`, `topicConfig_3`
      "topicConfig_2_1": {
        "cleanupPolicy": "string",
        "compressionType": "string",
        "deleteRetentionMs": "integer",
        "fileDeleteDelayMs": "integer",
        "flushMessages": "integer",
        "flushMs": "integer",
        "minCompactionLagMs": "integer",
        "retentionBytes": "integer",
        "retentionMs": "integer",
        "maxMessageBytes": "integer",
        "minInsyncReplicas": "integer",
        "segmentBytes": "integer",
        "preallocate": true
      },
      "topicConfig_2_6": {
        "cleanupPolicy": "string",
        "compressionType": "string",
        "deleteRetentionMs": "integer",
        "fileDeleteDelayMs": "integer",
        "flushMessages": "integer",
        "flushMs": "integer",
        "minCompactionLagMs": "integer",
        "retentionBytes": "integer",
        "retentionMs": "integer",
        "maxMessageBytes": "integer",
        "minInsyncReplicas": "integer",
        "segmentBytes": "integer",
        "preallocate": true
      },
      "topicConfig_2_8": {
        "cleanupPolicy": "string",
        "compressionType": "string",
        "deleteRetentionMs": "integer",
        "fileDeleteDelayMs": "integer",
        "flushMessages": "integer",
        "flushMs": "integer",
        "minCompactionLagMs": "integer",
        "retentionBytes": "integer",
        "retentionMs": "integer",
        "maxMessageBytes": "integer",
        "minInsyncReplicas": "integer",
        "segmentBytes": "integer",
        "preallocate": true
      },
      "topicConfig_3": {
        "cleanupPolicy": "string",
        "compressionType": "string",
        "deleteRetentionMs": "integer",
        "fileDeleteDelayMs": "integer",
        "flushMessages": "integer",
        "flushMs": "integer",
        "minCompactionLagMs": "integer",
        "retentionBytes": "integer",
        "retentionMs": "integer",
        "maxMessageBytes": "integer",
        "minInsyncReplicas": "integer",
        "segmentBytes": "integer",
        "preallocate": true
      },
      // end of the list of possible fields`topics[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
topics[] | **object**<br><p>List of Kafka topics.</p> 
topics[].<br>name | **string**<br><p>Name of the topic.</p> 
topics[].<br>clusterId | **string**<br><p>ID of an Apache Kafka® cluster that the topic belongs to.</p> <p>To get the Apache Kafka® cluster ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> 
topics[].<br>partitions | **integer** (int64)<br><p>The number of the topic's partitions.</p> 
topics[].<br>replicationFactor | **integer** (int64)<br><p>Amount of data copies (replicas) for the topic in the cluster.</p> 
topics[].<br>topicConfig_2_1 | **object** <br>`topics[]` includes only one of the fields `topicConfig_2_1`, `topicConfig_2_6`, `topicConfig_2_8`, `topicConfig_3`<br><br><p>Deprecated. Version ``2.1`` of Kafka not supported in Yandex Cloud.</p> 
topics[].<br>topicConfig_2_1.<br>cleanupPolicy | **string**<br><p>Retention policy to use on old log messages.</p> <ul> <li>CLEANUP_POLICY_DELETE: this policy discards log segments when either their retention time or log size limit is reached. See also: ``logRetentionMs`` and other similar parameters.</li> <li>CLEANUP_POLICY_COMPACT: this policy compacts messages in log.</li> <li>CLEANUP_POLICY_COMPACT_AND_DELETE: this policy use both compaction and deletion for messages and log segments.</li> </ul> 
topics[].<br>topicConfig_2_1.<br>compressionType | **string**<br><p>The compression type for a given topic.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of ``ZSTD``, ``LZ4``, ``GZIP`` or ``SNAPPY`` codecs).</li> </ul> 
topics[].<br>topicConfig_2_1.<br>deleteRetentionMs | **integer** (int64)<br><p>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.</p> 
topics[].<br>topicConfig_2_1.<br>fileDeleteDelayMs | **integer** (int64)<br><p>The time to wait before deleting a file from the filesystem.</p> 
topics[].<br>topicConfig_2_1.<br>flushMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This setting overrides the cluster-level ``logFlushIntervalMessages`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_1.<br>flushMs | **integer** (int64)<br><p>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.</p> <p>This setting overrides the cluster-level ``logFlushIntervalMs`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_1.<br>minCompactionLagMs | **integer** (int64)<br><p>The minimum time in milliseconds a message will remain uncompacted in the log.</p> 
topics[].<br>topicConfig_2_1.<br>retentionBytes | **integer** (int64)<br><p>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the ``delete`` ``cleanupPolicy`` is in effect. It is helpful if you need to control the size of log due to limited disk space.</p> <p>This setting overrides the cluster-level ``logRetentionBytes`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_1.<br>retentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment's file before deleting it.</p> <p>This setting overrides the cluster-level ``logRetentionMs`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_1.<br>maxMessageBytes | **integer** (int64)<br><p>The largest record batch size allowed in topic.</p> 
topics[].<br>topicConfig_2_1.<br>minInsyncReplicas | **integer** (int64)<br><p>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all").</p> 
topics[].<br>topicConfig_2_1.<br>segmentBytes | **integer** (int64)<br><p>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention.</p> <p>This setting overrides the cluster-level ``logSegmentBytes`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_1.<br>preallocate | **boolean** (boolean)<br><p>True if we should preallocate the file on disk when creating a new log segment.</p> <p>This setting overrides the cluster-level ``logPreallocate`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_6 | **object** <br>`topics[]` includes only one of the fields `topicConfig_2_1`, `topicConfig_2_6`, `topicConfig_2_8`, `topicConfig_3`<br><br><p>Deprecated. Version ``2.6`` of Kafka not supported in Yandex Cloud.</p> 
topics[].<br>topicConfig_2_6.<br>cleanupPolicy | **string**<br><p>Retention policy to use on old log messages.</p> <ul> <li>CLEANUP_POLICY_DELETE: this policy discards log segments when either their retention time or log size limit is reached. See also: ``logRetentionMs`` and other similar parameters.</li> <li>CLEANUP_POLICY_COMPACT: this policy compacts messages in log.</li> <li>CLEANUP_POLICY_COMPACT_AND_DELETE: this policy use both compaction and deletion for messages and log segments.</li> </ul> 
topics[].<br>topicConfig_2_6.<br>compressionType | **string**<br><p>The compression type for a given topic.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of ``ZSTD``, ``LZ4``, ``GZIP`` or ``SNAPPY`` codecs).</li> </ul> 
topics[].<br>topicConfig_2_6.<br>deleteRetentionMs | **integer** (int64)<br><p>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.</p> 
topics[].<br>topicConfig_2_6.<br>fileDeleteDelayMs | **integer** (int64)<br><p>The time to wait before deleting a file from the filesystem.</p> 
topics[].<br>topicConfig_2_6.<br>flushMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This setting overrides the cluster-level ``logFlushIntervalMessages`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_6.<br>flushMs | **integer** (int64)<br><p>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.</p> <p>This setting overrides the cluster-level ``logFlushIntervalMs`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_6.<br>minCompactionLagMs | **integer** (int64)<br><p>The minimum time in milliseconds a message will remain uncompacted in the log.</p> 
topics[].<br>topicConfig_2_6.<br>retentionBytes | **integer** (int64)<br><p>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the ``delete`` ``cleanupPolicy`` is in effect. It is helpful if you need to control the size of log due to limited disk space.</p> <p>This setting overrides the cluster-level ``logRetentionBytes`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_6.<br>retentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment's file before deleting it.</p> <p>This setting overrides the cluster-level ``logRetentionMs`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_6.<br>maxMessageBytes | **integer** (int64)<br><p>The largest record batch size allowed in topic.</p> 
topics[].<br>topicConfig_2_6.<br>minInsyncReplicas | **integer** (int64)<br><p>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all").</p> 
topics[].<br>topicConfig_2_6.<br>segmentBytes | **integer** (int64)<br><p>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention.</p> <p>This setting overrides the cluster-level ``logSegmentBytes`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_6.<br>preallocate | **boolean** (boolean)<br><p>True if we should preallocate the file on disk when creating a new log segment.</p> <p>This setting overrides the cluster-level ``logPreallocate`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_8 | **object** <br>`topics[]` includes only one of the fields `topicConfig_2_1`, `topicConfig_2_6`, `topicConfig_2_8`, `topicConfig_3`<br><br><p>A topic settings for 2.8</p> 
topics[].<br>topicConfig_2_8.<br>cleanupPolicy | **string**<br><p>Retention policy to use on old log messages.</p> <ul> <li>CLEANUP_POLICY_DELETE: this policy discards log segments when either their retention time or log size limit is reached. See also: ``logRetentionMs`` and other similar parameters.</li> <li>CLEANUP_POLICY_COMPACT: this policy compacts messages in log.</li> <li>CLEANUP_POLICY_COMPACT_AND_DELETE: this policy use both compaction and deletion for messages and log segments.</li> </ul> 
topics[].<br>topicConfig_2_8.<br>compressionType | **string**<br><p>The compression type for a given topic.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of ``ZSTD``, ``LZ4``, ``GZIP`` or ``SNAPPY`` codecs).</li> </ul> 
topics[].<br>topicConfig_2_8.<br>deleteRetentionMs | **integer** (int64)<br><p>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.</p> 
topics[].<br>topicConfig_2_8.<br>fileDeleteDelayMs | **integer** (int64)<br><p>The time to wait before deleting a file from the filesystem.</p> 
topics[].<br>topicConfig_2_8.<br>flushMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This setting overrides the cluster-level ``logFlushIntervalMessages`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_8.<br>flushMs | **integer** (int64)<br><p>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.</p> <p>This setting overrides the cluster-level ``logFlushIntervalMs`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_8.<br>minCompactionLagMs | **integer** (int64)<br><p>The minimum time in milliseconds a message will remain uncompacted in the log.</p> 
topics[].<br>topicConfig_2_8.<br>retentionBytes | **integer** (int64)<br><p>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the ``delete`` ``cleanupPolicy`` is in effect. It is helpful if you need to control the size of log due to limited disk space.</p> <p>This setting overrides the cluster-level ``logRetentionBytes`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_8.<br>retentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment's file before deleting it.</p> <p>This setting overrides the cluster-level ``logRetentionMs`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_8.<br>maxMessageBytes | **integer** (int64)<br><p>The largest record batch size allowed in topic.</p> 
topics[].<br>topicConfig_2_8.<br>minInsyncReplicas | **integer** (int64)<br><p>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all").</p> 
topics[].<br>topicConfig_2_8.<br>segmentBytes | **integer** (int64)<br><p>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention.</p> <p>This setting overrides the cluster-level ``logSegmentBytes`` setting on the topic level.</p> 
topics[].<br>topicConfig_2_8.<br>preallocate | **boolean** (boolean)<br><p>True if we should preallocate the file on disk when creating a new log segment.</p> <p>This setting overrides the cluster-level ``logPreallocate`` setting on the topic level.</p> 
topics[].<br>topicConfig_3 | **object** <br>`topics[]` includes only one of the fields `topicConfig_2_1`, `topicConfig_2_6`, `topicConfig_2_8`, `topicConfig_3`<br><br><p>A topic settings for 3.x</p> 
topics[].<br>topicConfig_3.<br>cleanupPolicy | **string**<br><p>Retention policy to use on old log messages.</p> <ul> <li>CLEANUP_POLICY_DELETE: this policy discards log segments when either their retention time or log size limit is reached. See also: ``logRetentionMs`` and other similar parameters.</li> <li>CLEANUP_POLICY_COMPACT: this policy compacts messages in log.</li> <li>CLEANUP_POLICY_COMPACT_AND_DELETE: this policy use both compaction and deletion for messages and log segments.</li> </ul> 
topics[].<br>topicConfig_3.<br>compressionType | **string**<br><p>The compression type for a given topic.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of ``ZSTD``, ``LZ4``, ``GZIP`` or ``SNAPPY`` codecs).</li> </ul> 
topics[].<br>topicConfig_3.<br>deleteRetentionMs | **integer** (int64)<br><p>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.</p> 
topics[].<br>topicConfig_3.<br>fileDeleteDelayMs | **integer** (int64)<br><p>The time to wait before deleting a file from the filesystem.</p> 
topics[].<br>topicConfig_3.<br>flushMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This setting overrides the cluster-level ``logFlushIntervalMessages`` setting on the topic level.</p> 
topics[].<br>topicConfig_3.<br>flushMs | **integer** (int64)<br><p>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.</p> <p>This setting overrides the cluster-level ``logFlushIntervalMs`` setting on the topic level.</p> 
topics[].<br>topicConfig_3.<br>minCompactionLagMs | **integer** (int64)<br><p>The minimum time in milliseconds a message will remain uncompacted in the log.</p> 
topics[].<br>topicConfig_3.<br>retentionBytes | **integer** (int64)<br><p>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the ``delete`` ``cleanupPolicy`` is in effect. It is helpful if you need to control the size of log due to limited disk space.</p> <p>This setting overrides the cluster-level ``logRetentionBytes`` setting on the topic level.</p> 
topics[].<br>topicConfig_3.<br>retentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment's file before deleting it.</p> <p>This setting overrides the cluster-level ``logRetentionMs`` setting on the topic level.</p> 
topics[].<br>topicConfig_3.<br>maxMessageBytes | **integer** (int64)<br><p>The largest record batch size allowed in topic.</p> 
topics[].<br>topicConfig_3.<br>minInsyncReplicas | **integer** (int64)<br><p>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all").</p> 
topics[].<br>topicConfig_3.<br>segmentBytes | **integer** (int64)<br><p>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention.</p> <p>This setting overrides the cluster-level ``logSegmentBytes`` setting on the topic level.</p> 
topics[].<br>topicConfig_3.<br>preallocate | **boolean** (boolean)<br><p>True if we should preallocate the file on disk when creating a new log segment.</p> <p>This setting overrides the cluster-level ``logPreallocate`` setting on the topic level.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-kafka/api-ref/Topic/list#query_params">pageSize</a>, use the <a href="/docs/managed-kafka/api-ref/Topic/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-kafka/api-ref/Topic/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-kafka/api-ref/Topic/list#responses">nextPageToken</a> to continue paging through the results.</p> 