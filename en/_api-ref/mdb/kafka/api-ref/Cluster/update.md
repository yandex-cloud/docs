---
editable: false
---

# Method update
Updates the specified Apache Kafka® cluster.
 

 
## HTTP request {#https-request}
```
PATCH https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Apache Kafka® cluster to update.  To get the Apache Kafka® cluster ID, make a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "description": "string",
  "labels": "object",
  "configSpec": {
    "version": "string",
    "kafka": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },

      // `configSpec.kafka` includes only one of the fields `kafkaConfig_2_1`, `kafkaConfig_2_6`
      "kafkaConfig_2_1": {
        "compressionType": "string",
        "logFlushIntervalMessages": "integer",
        "logFlushIntervalMs": "integer",
        "logFlushSchedulerIntervalMs": "integer",
        "logRetentionBytes": "integer",
        "logRetentionHours": "integer",
        "logRetentionMinutes": "integer",
        "logRetentionMs": "integer",
        "logSegmentBytes": "integer",
        "logPreallocate": true
      },
      "kafkaConfig_2_6": {
        "compressionType": "string",
        "logFlushIntervalMessages": "integer",
        "logFlushIntervalMs": "integer",
        "logFlushSchedulerIntervalMs": "integer",
        "logRetentionBytes": "integer",
        "logRetentionHours": "integer",
        "logRetentionMinutes": "integer",
        "logRetentionMs": "integer",
        "logSegmentBytes": "integer",
        "logPreallocate": true
      },
      // end of the list of possible fields`configSpec.kafka`

    },
    "zookeeper": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      }
    },
    "zoneId": [
      "string"
    ],
    "brokersCount": "integer",
    "assignPublicIp": true
  },
  "name": "string",
  "securityGroupIds": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in `` updateMask `` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If `` updateMask `` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
description | **string**<br><p>New description of the Apache Kafka® cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the Apache Kafka® cluster as `key:value` pairs.</p> <p>For example, &quot;project&quot;: &quot;mvp&quot; or &quot;source&quot;: &quot;dictionary&quot;.</p> <p>The new set of labels will completely replace the old ones. To add a label, request the current set with the <a href="/docs/managed-kafka/api-ref/Cluster/get">get</a> method, then send an <a href="/docs/managed-kafka/api-ref/Cluster/update">update</a> request with the new label added to the set.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression `` [a-z][-_0-9a-z]* ``. The maximum string length in characters for each value is 63. Each value must match the regular expression `` [-_0-9a-z]* ``.</p> 
configSpec | **object**<br><p>New configuration and resources for hosts in the Apache Kafka® cluster.</p> <p>Use <a href="/docs/managed-kafka/api-ref/Cluster/update#body_params">updateMask</a> to prevent reverting all cluster settings that are not listed in <a href="/docs/managed-kafka/api-ref/Cluster/update#body_params">configSpec</a> to their default values.</p> 
configSpec.<br>version | **string**<br><p>Version of Apache Kafka® used in the cluster. Possible values: `2.1`, `2.6`.</p> 
configSpec.<br>kafka | **object**<br><p>Configuration and resource allocation for Kafka brokers.</p> 
configSpec.<br>kafka.<br>resources | **object**<br>Resources allocated to Kafka brokers.<br>
configSpec.<br>kafka.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>kafka.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>kafka.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1 | **object** <br>`configSpec.kafka` includes only one of the fields `kafkaConfig_2_1`, `kafkaConfig_2_6`<br><br><p>Kafka version 2.1 broker configuration.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>compressionType | **string**<br><p>Сluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li> </ul> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `flushMessages` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `logFlushSchedulerIntervalMs` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `flushMs` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if `delete` `cleanupPolicy` is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `retentionBytes` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of `logRetentionHours` is used.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of `logRetentionMinutes` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `retentionMs` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logSegmentBytes | **integer** (int64)<br><p>The maximum size of a single log file.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `segmentBytes` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logPreallocate | **boolean** (boolean)<br><p>Should pre allocate file when create new segment?</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `preallocate` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_6 | **object** <br>`configSpec.kafka` includes only one of the fields `kafkaConfig_2_1`, `kafkaConfig_2_6`<br><br><p>Kafka version 2.6 broker configuration.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_6.<br>compressionType | **string**<br><p>Сluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: no codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li> </ul> 
configSpec.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `flushMessages` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of `logFlushSchedulerIntervalMs` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `flushMs` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if `delete` `cleanupPolicy` is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `retentionBytes` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of `logRetentionHours` is used.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of `logRetentionMinutes` is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `retentionMs` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_6.<br>logSegmentBytes | **integer** (int64)<br><p>The maximum size of a single log file.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `segmentBytes` setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_6.<br>logPreallocate | **boolean** (boolean)<br><p>Should pre allocate file when create new segment?</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the `preallocate` setting.</p> 
configSpec.<br>zookeeper | **object**<br><p>Configuration and resource allocation for ZooKeeper hosts.</p> 
configSpec.<br>zookeeper.<br>resources | **object**<br><p>Resources allocated to ZooKeeper hosts.</p> 
configSpec.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
configSpec.<br>zoneId[] | **string**<br><p>IDs of availability zones where Kafka brokers reside.</p> 
configSpec.<br>brokersCount | **integer** (int64)<br><p>The number of Kafka brokers deployed in each availability zone.</p> 
configSpec.<br>assignPublicIp | **boolean** (boolean)<br><p>The flag that defines whether a public IP address is assigned to the cluster. If the value is `true`, then Apache Kafka® cluster is available on the Internet via it's public IP address.</p> 
name | **string**<br><p>New name for the Apache Kafka® cluster.</p> <p>The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.</p> 
securityGroupIds[] | **string**<br><p>User security groups</p> 
 
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