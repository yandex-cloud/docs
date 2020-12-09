---
editable: false
---

# Method update
Updates the specified Kafka topic.
 

 
## HTTP request {#https-request}
```
PATCH https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/topics/{topicName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Apache Kafka® cluster to update a topic in.  To get the cluster ID, make a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
topicName | Required. Name of the topic to update.  To get the name of the topic, make a [list](/docs/managed-kafka/api-ref/Topic/list) request.  The string length in characters must be 1-63. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "topicSpec": {
    "name": "string",
    "partitions": "integer",
    "replicationFactor": "integer",

    // `topicSpec` includes only one of the fields `topicConfig_2_1`, `topicConfig_2_6`
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
    // end of the list of possible fields`topicSpec`

  }
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in `` updateMask `` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If `` updateMask `` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
topicSpec | **object**<br><p>New configuration of the topic.</p> <p>Use <a href="/docs/managed-kafka/api-ref/Topic/update#body_params">updateMask</a> to prevent reverting all topic settings that are not listed in <a href="/docs/managed-kafka/api-ref/Topic/update#body_params">topicSpec</a> to their default values.</p> 
topicSpec.<br>name | **string**<br><p>Name of the topic.</p> 
topicSpec.<br>partitions | **integer** (int64)<br><p>The number of the topic's partitions.</p> 
topicSpec.<br>replicationFactor | **integer** (int64)<br><p>Amount of copies of a topic data kept in the cluster.</p> 
topicSpec.<br>topicConfig_2_1 | **object** <br>`topicSpec` includes only one of the fields `topicConfig_2_1`, `topicConfig_2_6`<br><br><p>A topic settings for 2.1.</p> 
topicSpec.<br>topicConfig_2_1.<br>cleanupPolicy | **string**<br><p>Retention policy to use on old log messages.</p> <ul> <li>CLEANUP_POLICY_DELETE: this policy discards log segments when either their retention time or log size limit is reached. See also: `logRetentionMs` and other similar parameters.</li> <li>CLEANUP_POLICY_COMPACT: this policy compacts messages in log.</li> <li>CLEANUP_POLICY_COMPACT_AND_DELETE: this policy use both compaction and deletion for messages and log segments.</li> </ul> 
topicSpec.<br>topicConfig_2_1.<br>compressionType | **string**<br><p>The compression type for a given topic.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li> </ul> 
topicSpec.<br>topicConfig_2_1.<br>deleteRetentionMs | **integer** (int64)<br><p>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.</p> 
topicSpec.<br>topicConfig_2_1.<br>fileDeleteDelayMs | **integer** (int64)<br><p>The time to wait before deleting a file from the filesystem.</p> 
topicSpec.<br>topicConfig_2_1.<br>flushMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This setting overrides the cluster-level `logFlushIntervalMessages` setting on the topic level.</p> 
topicSpec.<br>topicConfig_2_1.<br>flushMs | **integer** (int64)<br><p>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.</p> <p>This setting overrides the cluster-level `logFlushIntervalMs` setting on the topic level.</p> 
topicSpec.<br>topicConfig_2_1.<br>minCompactionLagMs | **integer** (int64)<br><p>The minimum time in milliseconds a message will remain uncompacted in the log.</p> 
topicSpec.<br>topicConfig_2_1.<br>retentionBytes | **integer** (int64)<br><p>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanupPolicy` is in effect. It is helpful if you need to control the size of log due to limited disk space.</p> <p>This setting overrides the cluster-level `logRetentionBytes` setting on the topic level.</p> 
topicSpec.<br>topicConfig_2_1.<br>retentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment's file before deleting it.</p> <p>This setting overrides the cluster-level `logRetentionMs` setting on the topic level.</p> 
topicSpec.<br>topicConfig_2_1.<br>maxMessageBytes | **integer** (int64)<br><p>The largest record batch size allowed in topic.</p> 
topicSpec.<br>topicConfig_2_1.<br>minInsyncReplicas | **integer** (int64)<br><p>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to &quot;all&quot;).</p> 
topicSpec.<br>topicConfig_2_1.<br>segmentBytes | **integer** (int64)<br><p>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention.</p> <p>This setting overrides the cluster-level `logSegmentBytes` setting on the topic level.</p> 
topicSpec.<br>topicConfig_2_1.<br>preallocate | **boolean** (boolean)<br><p>True if we should preallocate the file on disk when creating a new log segment.</p> <p>This setting overrides the cluster-level `logPreallocate` setting on the topic level.</p> 
topicSpec.<br>topicConfig_2_6 | **object** <br>`topicSpec` includes only one of the fields `topicConfig_2_1`, `topicConfig_2_6`<br><br><p>A topic settings for 2.6</p> 
topicSpec.<br>topicConfig_2_6.<br>cleanupPolicy | **string**<br><p>Retention policy to use on old log messages.</p> <ul> <li>CLEANUP_POLICY_DELETE: this policy discards log segments when either their retention time or log size limit is reached. See also: `logRetentionMs` and other similar parameters.</li> <li>CLEANUP_POLICY_COMPACT: this policy compacts messages in log.</li> <li>CLEANUP_POLICY_COMPACT_AND_DELETE: this policy use both compaction and deletion for messages and log segments.</li> </ul> 
topicSpec.<br>topicConfig_2_6.<br>compressionType | **string**<br><p>The compression type for a given topic.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li> </ul> 
topicSpec.<br>topicConfig_2_6.<br>deleteRetentionMs | **integer** (int64)<br><p>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.</p> 
topicSpec.<br>topicConfig_2_6.<br>fileDeleteDelayMs | **integer** (int64)<br><p>The time to wait before deleting a file from the filesystem.</p> 
topicSpec.<br>topicConfig_2_6.<br>flushMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This setting overrides the cluster-level `logFlushIntervalMessages` setting on the topic level.</p> 
topicSpec.<br>topicConfig_2_6.<br>flushMs | **integer** (int64)<br><p>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.</p> <p>This setting overrides the cluster-level `logFlushIntervalMs` setting on the topic level.</p> 
topicSpec.<br>topicConfig_2_6.<br>minCompactionLagMs | **integer** (int64)<br><p>The minimum time in milliseconds a message will remain uncompacted in the log.</p> 
topicSpec.<br>topicConfig_2_6.<br>retentionBytes | **integer** (int64)<br><p>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanupPolicy` is in effect. It is helpful if you need to control the size of log due to limited disk space.</p> <p>This setting overrides the cluster-level `logRetentionBytes` setting on the topic level.</p> 
topicSpec.<br>topicConfig_2_6.<br>retentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment's file before deleting it.</p> <p>This setting overrides the cluster-level `logRetentionMs` setting on the topic level.</p> 
topicSpec.<br>topicConfig_2_6.<br>maxMessageBytes | **integer** (int64)<br><p>The largest record batch size allowed in topic.</p> 
topicSpec.<br>topicConfig_2_6.<br>minInsyncReplicas | **integer** (int64)<br><p>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to &quot;all&quot;).</p> 
topicSpec.<br>topicConfig_2_6.<br>segmentBytes | **integer** (int64)<br><p>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention.</p> <p>This setting overrides the cluster-level `logSegmentBytes` setting on the topic level.</p> 
topicSpec.<br>topicConfig_2_6.<br>preallocate | **boolean** (boolean)<br><p>True if we should preallocate the file on disk when creating a new log segment.</p> <p>This setting overrides the cluster-level `logPreallocate` setting on the topic level.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 