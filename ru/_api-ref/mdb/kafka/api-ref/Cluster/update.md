---
editable: false
---

# Метод update
Updates the specified Apache Kafka cluster.
 

 
## HTTP-запрос {#https-request}
```
PATCH https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. ID of the Apache Kafka cluster to update.  To get the Apache Kafka cluster ID, make a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  Максимальная длина строки в символах — 50.
 
## Параметры в теле запроса {#body_params}
 
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
      "kafkaConfig_2_1": {
        "compressionType": "string",
        "logFlushIntervalMessages": "integer",
        "logFlushIntervalMs": "integer",
        "logFlushSchedulerIntervalMs": "integer",
        "logRetentionBytes": "integer",
        "logRetentionHours": "integer",
        "logRetentionMinutes": "integer",
        "logRetentionMs": "integer"
      }
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
  "name": "string"
}
```

 
Поле | Описание
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the Apache Kafka cluster should be updated.</p> <p>By default, this API method will replace all the values for the settings that are not present in <code>update_mask</code> list with the default ones. Pass the list of the settings to change in this parameter to prevent the method from doing so (use comma as a delimiter if you want to modify a few settings at once).</p> <p>Имена всех обновляемых полей, разделенные запятыми. Только значения указанных полей будут изменены. Остальные останутся нетронутыми. Если поле указано в параметре <code>updateMask</code> и в запросе не было отправлено значение для этого поля, значение поля будет сброшено на значение по умолчанию. Значение по умолчанию для большинства полей — null или 0.</p> <p>Если в запросе не передается <code>updateMask</code>, значения всех полей будут обновлены. Для полей, указанных в запросе, будут использованы переданные значения. Значения остальных полей будут сброшены на значения по умолчанию.</p> 
description | **string**<br><p>New description of the Apache Kafka cluster.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Custom labels for the Apache Kafka cluster as <code>key:value</code> pairs. Maximum 64 per resource.</p> <p>For example, &quot;project&quot;: &quot;mvp&quot; or &quot;source&quot;: &quot;dictionary&quot;.</p> <p>The new set of labels will completely replace the old ones. To add a label, request the current set with the <a href="/docs/managed-kafka/api-ref/Cluster/get">get</a> method, then send an <a href="/docs/managed-kafka/api-ref/Cluster/update">update</a> request with the new label added to the set.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению <code>[a-z][-_0-9a-z]*</code>. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению <code>[-_0-9a-z]*</code>.</p> 
configSpec | **object**<br><p>New configuration and resources for hosts in the Apache Kafka cluster.</p> <p>Use <a href="/docs/managed-kafka/api-ref/Cluster/update#body_params">updateMask</a> to prevent reverting all cluster settings that are not listed in <code>config_spec</code> to their default values.</p> <p>The cluster configuration.</p> 
configSpec.<br>version | **string**<br><p>Version of Apache Kafka used in the cluster.</p> 
configSpec.<br>kafka | **object**<br><p>Configuration and resource allocation for Apache Kafka brokers.</p> <p>Apache Kafka configuration.</p> 
configSpec.<br>kafka.<br>resources | **object**<br>Resources allocated to Apache Kafka brokers.<br><p>Cluster computational resources.</p> 
configSpec.<br>kafka.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>kafka.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>kafka.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1 | **object**<br><p>Apache Kafka broker configuration. Log flushing and log retention settings are configured here.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>compressionType | **string**<br><p>Сluster topics compression type.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: No codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: The codec to use is set by a producer (can be any of ZSTD<code>, </code>LZ4<code>, </code>GZIP<code>or</code>SNAPPY` codecs).</li> </ul> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the [Topic.topic_config.flush_messages] setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMs | **integer** (int64)<br><p>The maximum time (in milliseconds) that a message in any topic is kept in memory before flushed to disk. If not set, the value of <code>logFlushSchedulerIntervalMs</code> is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the [Topic.topic_config.flush_ms] setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>The frequency (in milliseconds) that the log flusher checks whether any log needs to be flushed to disk.</p> <p>The frequency of checks (in milliseconds) for any logs that need to be flushed to disk. This check is done by the log flusher.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionBytes | **integer** (int64)<br><p>Partition size limit; Kafka will discard old log segments to free up space if <code>delete</code> [Topic.topic_config.cleanup_policy] is in effect. This setting is helpful if you need to control the size of a log due to limited disk space.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the [Topic.topic_config.retention_bytes] setting.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionHours | **integer** (int64)<br><p>The number of hours to keep a log segment file before deleting it.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMinutes | **integer** (int64)<br><p>The number of minutes to keep a log segment file before deleting it.</p> <p>If not set, the value of <code>logRetentionHours</code> is used.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment file before deleting it.</p> <p>If not set, the value of <code>logRetentionMinutes</code> is used.</p> <p>This is the global cluster-level setting that can be overridden on a topic level by using the [Topic.topic_config.retention_ms] setting.</p> 
configSpec.<br>zookeeper | **object**<br><p>Configuration and resource allocation for ZooKeeper hosts.</p> <p>Zookeeper configuration.</p> 
configSpec.<br>zookeeper.<br>resources | **object**<br><p>Resources allocated to ZooKeeper hosts.</p> <p>Cluster computational resources.</p> 
configSpec.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
configSpec.<br>zoneId[] | **string**<br><p>IDs of availability zones where Apache Kafka brokers reside.</p> 
configSpec.<br>brokersCount | **integer** (int64)<br><p>The number of Apache Kafka brokers deployed in each availability zone.</p> 
configSpec.<br>assignPublicIp | **boolean** (boolean)<br><p>The flag that defines whether a public IP address is assigned to the cluster. If the value is <code>true</code>, then Apache Kafka cluster is available on the Internet via it's public IP address.</p> 
name | **string**<br><p>New name for the Apache Kafka cluster.</p> <p>Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9_-]*</code>.</p> 
 
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