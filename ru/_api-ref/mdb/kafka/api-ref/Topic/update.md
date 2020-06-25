---
editable: false
---

# Метод update
Updates the specified Apache Kafka topic.
 

 
## HTTP-запрос {#https-request}
```
PATCH https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/topics/{topicName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. ID of the Apache Kafka cluster to update a topic in.  To get the cluster ID, make a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  Максимальная длина строки в символах — 50.
topicName | Обязательное поле. Name of the topic to update.  To get the name of the topic, make a [list](/docs/managed-kafka/api-ref/Topic/list) request.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_-]* ``.
 
## Параметры в теле запроса {#body_params}
 
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

 
Поле | Описание
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the Apache Kafka topic should be updated.</p> <p>By default, this API method will replace all the values for the settings that are not present in <code>update_mask</code> list with the default ones. Pass the list of the settings to change in this parameter to prevent the method from doing so (use comma as a delimiter if you want to modify a few settings at once).</p> <p>Имена всех обновляемых полей, разделенные запятыми. Только значения указанных полей будут изменены. Остальные останутся нетронутыми. Если поле указано в параметре <code>updateMask</code> и в запросе не было отправлено значение для этого поля, значение поля будет сброшено на значение по умолчанию. Значение по умолчанию для большинства полей — null или 0.</p> <p>Если в запросе не передается <code>updateMask</code>, значения всех полей будут обновлены. Для полей, указанных в запросе, будут использованы переданные значения. Значения остальных полей будут сброшены на значения по умолчанию.</p> 
topicSpec | **object**<br><p>New configuration of the topic.</p> <p>Use <a href="/docs/managed-kafka/api-ref/Topic/update#body_params">updateMask</a> to prevent reverting all topic settings that are not listed in <code>topic_spec</code> to their default values. Configuration of the topic to create.</p> <p>An Apache Kafka topic specifications.</p> 
topicSpec.<br>name | **string**<br><p>Name of the topic.</p> 
topicSpec.<br>partitions | **integer** (int64)<br><p>The number of the topic's partitions.</p> 
topicSpec.<br>replicationFactor | **integer** (int64)<br><p>Amount of copies of a topic data kept in the cluster.</p> 
topicSpec.<br>topicConfig_2_1 | **object**<br><p>A topic settings.</p> 
topicSpec.<br>topicConfig_2_1.<br>cleanupPolicy | **string**<br><p>Retention policy to use on old log messages.</p> <ul> <li>CLEANUP_POLICY_DELETE: This policy discards log segments when either their retention time or log size limit is reached.</li> </ul> <p>See also: [Cluster.config.kafka.kafka_config.log_retention_ms] and other similar parameters.</p> <ul> <li>CLEANUP_POLICY_COMPACT: This policy compacts messages in log.</li> <li>CLEANUP_POLICY_COMPACT_AND_DELETE: This policy use both compaction and deletion for messages and log segments.</li> </ul> 
topicSpec.<br>topicConfig_2_1.<br>compressionType | **string**<br><p>Specify the compression type for a given topic.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: No codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: The codec to use is set by a producer (can be any of ZSTD<code>, </code>LZ4<code>, </code>GZIP<code>or</code>SNAPPY` codecs).</li> </ul> 
topicSpec.<br>topicConfig_2_1.<br>deleteRetentionMs | **integer** (int64)<br><p>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.</p> 
topicSpec.<br>topicConfig_2_1.<br>fileDeleteDelayMs | **integer** (int64)<br><p>The time to wait before deleting a file from the filesystem.</p> 
topicSpec.<br>topicConfig_2_1.<br>flushMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_messages] setting on the topic level.</p> 
topicSpec.<br>topicConfig_2_1.<br>flushMs | **integer** (int64)<br><p>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.</p> <p>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_ms] setting on the topic level.</p> 
topicSpec.<br>topicConfig_2_1.<br>minCompactionLagMs | **integer** (int64)<br><p>The minimum time in milliseconds a message will remain uncompacted in the log.</p> 
topicSpec.<br>topicConfig_2_1.<br>retentionBytes | **integer** (int64)<br><p>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the <code>delete</code> <code>cleanupPolicy</code> is in effect. It is helpful if you need to control the size of log due to limited disk space.</p> <p>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_bytes] setting on the topic level.</p> 
topicSpec.<br>topicConfig_2_1.<br>retentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment's file before deleting it.</p> <p>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_ms] setting on the topic level.</p> 
 
## Ответ {#responses}
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

  //  включает только одно из полей `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // конец списка возможных полей

}
```
Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор операции.</p> 
description | **string**<br><p>Описание операции. Длина описания должна быть от 0 до 256 символов.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
createdBy | **string**<br><p>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.</p> 
modifiedAt | **string** (date-time)<br><p>Время, когда ресурс Operation последний раз обновлялся. Значение в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
done | **boolean** (boolean)<br><p>Если значение равно <code>false</code> — операция еще выполняется. Если <code>true</code> — операция завершена, и задано значение одного из полей <code>error</code> или <code>response</code>.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>metadata</code>.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>response</code>.</p> 