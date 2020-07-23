---
editable: false
---

# Method update
Updates the specified Apache Kafka topic.
 

 
## HTTP request {#https-request}
```
PATCH https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/topics/{topicName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. Required. ID of the Apache Kafka cluster to update a topic in. To get the cluster ID use a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
topicName | Required. Required. Name of the topic to update. To get the name of the topic use a [list](/docs/managed-kafka/api-ref/Topic/list) request.  The string length in characters must be 1-63. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "topicSpec": {
    "name": "string",
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
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the Topic resource should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in <code>updateMask</code> and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If <code>updateMask</code> is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
topicSpec | **object**<br><p>Required. Configuration of the topic to create.</p> 
topicSpec.<br>name | **string**<br><p>Name of the topic.</p> 
topicSpec.<br>partitions | **integer** (int64)<br><p>Number of topic partitions</p> 
topicSpec.<br>replicationFactor | **integer** (int64)<br><p>Amount of copies of a topic data kept in a cluster.</p> 
topicSpec.<br>topicConfig_2_1 | **object**<br>
topicSpec.<br>topicConfig_2_1.<br>cleanupPolicy | **string**<br><p>Retention policy to use on old log segments.</p> 
topicSpec.<br>topicConfig_2_1.<br>compressionType | **string**<br><p>Specify the final compression type for a given topic.</p> 
topicSpec.<br>topicConfig_2_1.<br>deleteRetentionMs | **integer** (int64)<br><p>The amount of time to retain delete tombstone markers for log compacted topics.</p> 
topicSpec.<br>topicConfig_2_1.<br>fileDeleteDelayMs | **integer** (int64)<br><p>The time to wait before deleting a file from the filesystem</p> 
topicSpec.<br>topicConfig_2_1.<br>flushMessages | **integer** (int64)<br><p>This setting allows specifying an interval at which we will force an fsync of data written to the log</p> 
topicSpec.<br>topicConfig_2_1.<br>flushMs | **integer** (int64)<br><p>This setting allows specifying a time interval at which we will force an fsync of data written to the log</p> 
topicSpec.<br>topicConfig_2_1.<br>minCompactionLagMs | **integer** (int64)<br><p>The minimum time a message will remain uncompacted in the log.</p> 
topicSpec.<br>topicConfig_2_1.<br>retentionBytes | **integer** (int64)<br><p>This configuration controls the maximum size a partition (which consists of log segments) can grow to before we will discard old log segments to free up space if we are using the &quot;delete&quot; retention policy</p> 
topicSpec.<br>topicConfig_2_1.<br>retentionMs | **integer** (int64)<br><p>This configuration controls the maximum time we will retain a log before we will discard old log segments to free up space if we are using the &quot;delete&quot; retention policy.</p> 
 
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
done | **boolean** (boolean)<br><p>If the value is <code>false</code>, it means the operation is still in progress. If <code>true</code>, the operation is completed, and either <code>error</code> or <code>response</code> is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 