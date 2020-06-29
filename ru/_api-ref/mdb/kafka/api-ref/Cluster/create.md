---
editable: false
---

# Метод create
Creates a new Apache Kafka cluster in the specified folder.
 

 
## HTTP-запрос {#https-request}
```
POST https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
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
  "topicSpecs": [
    {
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
  ],
  "userSpecs": [
    {
      "name": "string",
      "password": "string",
      "permissions": [
        {
          "topicName": "string",
          "role": "string"
        }
      ]
    }
  ],
  "networkId": "string"
}
```

 
Поле | Описание
--- | ---
folderId | **string**<br><p>Обязательное поле. ID of the folder to create the Apache Kafka cluster in.</p> <p>To get the folder ID, make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>Максимальная длина строки в символах — 50.</p> 
name | **string**<br><p>Обязательное поле. Name of the Apache Kafka cluster. The name must be unique within the folder.</p> <p>Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению <code>[a-z]([-a-z0-9]{0,61}[a-z0-9])?</code>.</p> 
description | **string**<br><p>Description of the Apache Kafka cluster.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Custom labels for the Apache Kafka cluster as <code>key:value</code> pairs. Maximum 64 per cluster.</p> <p>For example, &quot;project&quot;: &quot;mvp&quot; or &quot;source&quot;: &quot;dictionary&quot;.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению <code>[a-z][-_./\@0-9a-z]*</code>. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению <code>[-_./\@0-9a-z]*</code>.</p> 
environment | **string**<br><p>Deployment environment of the Apache Kafka cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with a more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
configSpec | **object**<br><p>Kafka and hosts configuration the Apache Kafka cluster.</p> <p>The cluster configuration.</p> 
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
topicSpecs[] | **object**<br><p>An Apache Kafka topic specifications.</p> 
topicSpecs[].<br>name | **string**<br><p>Name of the topic.</p> 
topicSpecs[].<br>partitions | **integer** (int64)<br><p>The number of the topic's partitions.</p> 
topicSpecs[].<br>replicationFactor | **integer** (int64)<br><p>Amount of copies of a topic data kept in the cluster.</p> 
topicSpecs[].<br>topicConfig_2_1 | **object**<br><p>A topic settings.</p> 
topicSpecs[].<br>topicConfig_2_1.<br>cleanupPolicy | **string**<br><p>Retention policy to use on old log messages.</p> <ul> <li>CLEANUP_POLICY_DELETE: This policy discards log segments when either their retention time or log size limit is reached.</li> </ul> <p>See also: [Cluster.config.kafka.kafka_config.log_retention_ms] and other similar parameters.</p> <ul> <li>CLEANUP_POLICY_COMPACT: This policy compacts messages in log.</li> <li>CLEANUP_POLICY_COMPACT_AND_DELETE: This policy use both compaction and deletion for messages and log segments.</li> </ul> 
topicSpecs[].<br>topicConfig_2_1.<br>compressionType | **string**<br><p>Specify the compression type for a given topic.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: No codec (uncompressed).</li> <li>COMPRESSION_TYPE_ZSTD: Zstandard codec.</li> <li>COMPRESSION_TYPE_LZ4: LZ4 codec.</li> <li>COMPRESSION_TYPE_SNAPPY: Snappy codec.</li> <li>COMPRESSION_TYPE_GZIP: GZip codec.</li> <li>COMPRESSION_TYPE_PRODUCER: The codec to use is set by a producer (can be any of ZSTD<code>, </code>LZ4<code>, </code>GZIP<code>or</code>SNAPPY` codecs).</li> </ul> 
topicSpecs[].<br>topicConfig_2_1.<br>deleteRetentionMs | **integer** (int64)<br><p>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.</p> 
topicSpecs[].<br>topicConfig_2_1.<br>fileDeleteDelayMs | **integer** (int64)<br><p>The time to wait before deleting a file from the filesystem.</p> 
topicSpecs[].<br>topicConfig_2_1.<br>flushMessages | **integer** (int64)<br><p>The number of messages accumulated on a log partition before messages are flushed to disk.</p> <p>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_messages] setting on the topic level.</p> 
topicSpecs[].<br>topicConfig_2_1.<br>flushMs | **integer** (int64)<br><p>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.</p> <p>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_ms] setting on the topic level.</p> 
topicSpecs[].<br>topicConfig_2_1.<br>minCompactionLagMs | **integer** (int64)<br><p>The minimum time in milliseconds a message will remain uncompacted in the log.</p> 
topicSpecs[].<br>topicConfig_2_1.<br>retentionBytes | **integer** (int64)<br><p>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the <code>delete</code> <code>cleanupPolicy</code> is in effect. It is helpful if you need to control the size of log due to limited disk space.</p> <p>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_bytes] setting on the topic level.</p> 
topicSpecs[].<br>topicConfig_2_1.<br>retentionMs | **integer** (int64)<br><p>The number of milliseconds to keep a log segment's file before deleting it.</p> <p>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_ms] setting on the topic level.</p> 
userSpecs[] | **object**<br><p>An Apache Kafka user specifications.</p> 
userSpecs[].<br>name | **string**<br><p>Обязательное поле. Name of the Apache Kafka user.</p> <p>Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9_]*</code>.</p> 
userSpecs[].<br>password | **string**<br><p>Обязательное поле. Password of the Apache Kafka user.</p> <p>Длина строки в символах должна быть от 8 до 128.</p> 
userSpecs[].<br>permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
userSpecs[].<br>permissions[].<br>topicName | **string**<br><p>Name of the topic that the permission grants access to.</p> <p>To get the topic name, make a [Topic.List] request.</p> 
userSpecs[].<br>permissions[].<br>role | **string**<br><p>Access role type to grant to the user.</p> <ul> <li>ACCESS_ROLE_PRODUCER: Producer role for the user.</li> <li>ACCESS_ROLE_CONSUMER: Consumer role for the user.</li> </ul> 
networkId | **string**<br><p>ID of the network to create the Apache Kafka cluster in.</p> <p>Максимальная длина строки в символах — 50.</p> 
 
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