---
editable: false
---

# Метод create
Создает новый кластер Apache Kafka в указанном каталоге.
 

 
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
folderId | **string**<br><p>Обязательное поле. Идентификатор каталога, в котором будет создан кластер Apache Kafka.</p> <p>Чтобы получить идентификатор каталога, выполните запрос <a href="/docs/resource-manager/api-ref/Folder/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
name | **string**<br><p>Обязательное поле. Имя кластера Apache Kafka. Имя должно быть уникальным в рамках каталога.</p> <p>Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению <code>[a-z]([-a-z0-9]{0,61}[a-z0-9])?</code>.</p> 
description | **string**<br><p>Описание кластера Apache Kafka.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Пользовательские метки для кластера Apache Kafka в виде пар <code>key:value</code>. Максимум 64 на кластер.</p> <p>Например, &quot;project&quot;: &quot;mvp&quot; или &quot;source&quot;: &quot;dictionary&quot;.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению <code>[a-z][-_./\@0-9a-z]*</code>. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению <code>[-_./\@0-9a-z]*</code>.</p> 
environment | **string**<br><p>Среда развертывания кластера Apache Kafka.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
configSpec | **object**<br><p>Конфигурация Kafka и хостов в кластере.</p> <p>Конфигурация кластера.</p> 
configSpec.<br>version | **string**<br><p>Версия Apache Kafka, которая используется в кластере.</p> 
configSpec.<br>kafka | **object**<br><p>Конфигурация и распределение ресурсов для брокеров Apache Kafka.</p> <p>Конфигурация Apache Kafka.</p> 
configSpec.<br>kafka.<br>resources | **object**<br>Ресурсы, выделенные брокерам Apache Kafka.<br><p>Вычислительные ресурсы кластера.</p> 
configSpec.<br>kafka.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-kafka/concepts/instance-types">документации</a>.</p> 
configSpec.<br>kafka.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
configSpec.<br>kafka.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1 | **object**<br><p>Конфигурация брокера Apache Kafka. Здесь настраиваются параметры, связанные с хранением лога и сбросом лога на диск.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>compressionType | **string**<br><p>Тип сжатия для топиков кластера.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: Не использовать кодек (сообщения не сжимаются).</li> <li>COMPRESSION_TYPE_ZSTD: Кодек Zstandard.</li> <li>COMPRESSION_TYPE_LZ4: Кодек LZ4.</li> <li>COMPRESSION_TYPE_SNAPPY: Кодек Snappy.</li> <li>COMPRESSION_TYPE_GZIP: Кодек GZip.</li> <li>COMPRESSION_TYPE_PRODUCER: Кодек задается на стороне производителя (допустимые кодеки: ZSTD<code>, </code>Формате LZ4<code>, </code>УТИЛИТА GZIP<code>or</code>SNAPPY`).</li> </ul> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMessages | **integer** (int64)<br><p>Количество сообщений, которые должны быть накоплены в разделе прежде, чем эти сообщения будут сброшены на диск.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Её можно переопределить на уровне топика с помощью настройки [Topic.topic_config.flush_messages].</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMs | **integer** (int64)<br><p>Максимальное время (в миллисекундах), в течение которого сообщение в любом топике хранится в памяти перед сбросом на диск. Если значение не задано, то используется значение настройки <code>logFlushSchedulerIntervalMs</code>.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Её можно переопределить на уровне топика с помощью настройки [Topic.topic_config.flush_ms].</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>Частота (в миллисекундах), с которой процесс, ответственный за сброс логов, проверяет, нужно ли сбрасывать какие-либо логи на диск.</p> <p>Частота проверки (в миллисекундах) наличия логов, которые нужно сбросить на диск. Эта проверка выполняется процессом, ответственным за сброс логов.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionBytes | **integer** (int64)<br><p>Ограничение размера раздела; Kafka отбросит старые сегменты лога, если , чтобы освободить место, если действует политика <code>delete</code> [Topic.topic_config.cleanup_policy]. Этот настройка полезна, если вам необходимо контролировать размер лога из-за ограниченного дискового пространства.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Её можно переопределить на уровне топика с помощью настройки [Topic.topic_config.retention_bytes].</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionHours | **integer** (int64)<br><p>Количество часов до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMinutes | **integer** (int64)<br><p>Количество минут до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> <p>Если значение не задано, то используется значение настройки <code>logRetentionHours</code>.</p> 
configSpec.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMs | **integer** (int64)<br><p>Количество миллисекунд до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> <p>Если значение не задано, то используется значение настройки <code>logRetentionMinutes</code>.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Её можно переопределить на уровне топика с помощью настройки [Topic.topic_config.retention_ms].</p> 
configSpec.<br>zookeeper | **object**<br><p>Конфигурация и распределение ресурсов для хостов ZooKeeper.</p> <p>Конфигурация ZooKeeper.</p> 
configSpec.<br>zookeeper.<br>resources | **object**<br><p>Ресурсы, выделенные хостам ZooKeeper.</p> <p>Вычислительные ресурсы кластера.</p> 
configSpec.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-kafka/concepts/instance-types">документации</a>.</p> 
configSpec.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
configSpec.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста.</p> 
configSpec.<br>zoneId[] | **string**<br><p>Идентификаторы зон доступности, в которых находятся брокеры Apache Kafka.</p> 
configSpec.<br>brokersCount | **integer** (int64)<br><p>Количество брокеров Apache Kafka, развернутых в каждой зоне доступности.</p> 
configSpec.<br>assignPublicIp | **boolean** (boolean)<br><p>Флаг, определяющий, назначен ли кластеру публичный IP-адрес. Если значение равно <code>true</code>, то кластер Apache Kafka доступен в Интернете через его публичный IP-адрес.</p> 
topicSpecs[] | **object**<br><p>Настройки топика Apache Kafka.</p> 
topicSpecs[].<br>name | **string**<br><p>Имя топика.</p> 
topicSpecs[].<br>partitions | **integer** (int64)<br><p>Количество разделов в топике.</p> 
topicSpecs[].<br>replicationFactor | **integer** (int64)<br><p>Количество копий данных топика, хранящихся в кластере.</p> 
topicSpecs[].<br>topicConfig_2_1 | **object**<br><p>Настройки топика.</p> 
topicSpecs[].<br>topicConfig_2_1.<br>cleanupPolicy | **string**<br><p>Политика хранения старых сообщений лога.</p> <ul> <li>CLEANUP_POLICY_DELETE: Эта политика отбрасывает сегменты лога либо при истечении срока их хранения, либо при достижении предельного размера лога.</li> </ul> <p>См. также описание [Cluster.config.kafka.kafka_config.log_retention_ms] и других подобных параметров.</p> <ul> <li>CLEANUP_POLICY_COMPACT: Эта политика сжимает сообщения в логе.</li> <li>CLEANUP_POLICY_COMPACT_AND_DELETE: Эта политика использует как сжатие сообщений, так и удаление сегментов лога.</li> </ul> 
topicSpecs[].<br>topicConfig_2_1.<br>compressionType | **string**<br><p>Тип сжатия для указанного топика.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: Не использовать кодек (сообщения не сжимаются).</li> <li>COMPRESSION_TYPE_ZSTD: Кодек Zstandard.</li> <li>COMPRESSION_TYPE_LZ4: Кодек LZ4.</li> <li>COMPRESSION_TYPE_SNAPPY: Кодек Snappy.</li> <li>COMPRESSION_TYPE_GZIP: Кодек GZip.</li> <li>COMPRESSION_TYPE_PRODUCER: Кодек задается на стороне производителя (допустимые кодеки: ZSTD<code>, </code>Формате LZ4<code>, </code>УТИЛИТА GZIP<code>or</code>SNAPPY`).</li> </ul> 
topicSpecs[].<br>topicConfig_2_1.<br>deleteRetentionMs | **integer** (int64)<br><p>Время (в миллисекундах), в течение которого нужно хранить tombstone-маркеры удаления для топиков со сжатым логом.</p> 
topicSpecs[].<br>topicConfig_2_1.<br>fileDeleteDelayMs | **integer** (int64)<br><p>Время ожидания перед удалением файла из файловой системы.</p> 
topicSpecs[].<br>topicConfig_2_1.<br>flushMessages | **integer** (int64)<br><p>Количество сообщений, которые должны быть накоплены в разделе прежде, чем эти сообщения будут сброшены на диск.</p> <p>Эта настройка переопределяет на уровне топика настройку уровня кластера [Cluster.config.kafka.kafka_config.log_flush_interval_messages].</p> 
topicSpecs[].<br>topicConfig_2_1.<br>flushMs | **integer** (int64)<br><p>Максимальное время (в миллисекундах), в течение которого сообщение в любом топике хранится в памяти перед сбросом на диск.</p> <p>Эта настройка переопределяет на уровне топика настройку уровня кластера [Cluster.config.kafka.kafka_config.log_flush_interval_ms].</p> 
topicSpecs[].<br>topicConfig_2_1.<br>minCompactionLagMs | **integer** (int64)<br><p>Минимальное время в миллисекундах, в течение которого сообщение в логе будет оставаться несжатым.</p> 
topicSpecs[].<br>topicConfig_2_1.<br>retentionBytes | **integer** (int64)<br><p>Максимальный размер, до которого может вырасти раздел, прежде чем Kafka начнет отбрасывать старые сегменты лога, если действует настройка <code>delete</code> <code>cleanupPolicy</code>. Эта настройка полезна, если вам необходимо контролировать размер лога из-за ограниченного дискового пространства.</p> <p>Эта настройка переопределяет на уровне топика настройку уровня кластера [Cluster.config.kafka.kafka_config.log_retention_bytes].</p> 
topicSpecs[].<br>topicConfig_2_1.<br>retentionMs | **integer** (int64)<br><p>Количество миллисекунд до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> <p>Эта настройка переопределяет на уровне топика настройку уровня кластера [Cluster.config.kafka.kafka_config.log_retention_ms].</p> 
userSpecs[] | **object**<br><p>Настройки пользователя Apache Kafka.</p> 
userSpecs[].<br>name | **string**<br><p>Обязательное поле. Имя пользователя Apache Kafka.</p> <p>Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9_]*</code>.</p> 
userSpecs[].<br>password | **string**<br><p>Обязательное поле. Пароль пользователя Apache Kafka.</p> <p>Длина строки в символах должна быть от 8 до 128.</p> 
userSpecs[].<br>permissions[] | **object**<br><p>Набор разрешений, предоставленных пользователю.</p> 
userSpecs[].<br>permissions[].<br>topicName | **string**<br><p>Имя топика, к которому предоставляется доступ.</p> <p>Чтобы получить имя топика, выполните запрос [Topic.List].</p> 
userSpecs[].<br>permissions[].<br>role | **string**<br><p>Роль доступа, которую нужно предоставить пользователю.</p> <ul> <li>ACCESS_ROLE_PRODUCER: Роль пользователя — производитель.</li> <li>ACCESS_ROLE_CONSUMER: Роль пользователя — потребитель.</li> </ul> 
networkId | **string**<br><p>Идентификатор каталога, в котором будет создан кластер Apache Kafka.</p> <p>Максимальная длина строки в символах — 50.</p> 
 
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