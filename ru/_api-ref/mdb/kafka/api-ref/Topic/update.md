---
editable: false
---

# Метод update
Изменяет указанный топик Kafka.
 

 
## HTTP-запрос {#https-request}
```
PATCH https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/topics/{topicName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера Apache Kafka®, в котором следует изменить топик.  Чтобы получить идентификатор кластера, выполните запрос [list](/docs/managed-kafka/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
topicName | Обязательное поле. Имя топика, который нужно изменить.  Чтобы получить имя топика, выполните запрос [list](/docs/managed-kafka/api-ref/Topic/list).  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_-]* ``.
 
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
updateMask | **string**<br><p>Имена всех обновляемых полей, разделенные запятыми. Только значения указанных полей будут изменены. Остальные останутся нетронутыми. Если поле указано в параметре ``updateMask`` и в запросе не было отправлено значение для этого поля, значение поля будет сброшено на значение по умолчанию. Значение по умолчанию для большинства полей — null или 0.</p> <p>Если в запросе не передается ``updateMask``, значения всех полей будут обновлены. Для полей, указанных в запросе, будут использованы переданные значения. Значения остальных полей будут сброшены на значения по умолчанию.</p> 
topicSpec | **object**<br><p>Новые настройки топика.</p> <p>Используйте параметр <a href="/docs/managed-kafka/api-ref/Topic/update#body_params">updateMask</a> чтобы предотвратить сброс настроек топика, не перечисленных в <a href="/docs/managed-kafka/api-ref/Topic/update#body_params">topicSpec</a>, на значения по умолчанию.</p> 
topicSpec.<br>name | **string**<br><p>Имя топика.</p> 
topicSpec.<br>partitions | **integer** (int64)<br><p>Количество разделов в топике.</p> 
topicSpec.<br>replicationFactor | **integer** (int64)<br><p>Количество копий данных топика, хранящихся в кластере.</p> 
topicSpec.<br>topicConfig_2_1 | **object**<br><p>Настройки топика.</p> 
topicSpec.<br>topicConfig_2_1.<br>cleanupPolicy | **string**<br><p>Политика хранения старых сообщений лога.</p> <ul> <li>CLEANUP_POLICY_DELETE: эта политика отбрасывает сегменты лога либо при истечении срока их хранения, либо при достижении предельного размера лога. См. также описание ``logRetentionMs`` и других подобных параметров.</li> <li>CLEANUP_POLICY_COMPACT: эта политика сжимает сообщения в логе.</li> <li>CLEANUP_POLICY_COMPACT_AND_DELETE: эта политика использует как сжатие сообщений, так и удаление сегментов лога.</li> </ul> 
topicSpec.<br>topicConfig_2_1.<br>compressionType | **string**<br><p>Тип сжатия для указанного топика.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: не использовать кодек (сообщения не сжимаются).</li> <li>COMPRESSION_TYPE_ZSTD: кодек Zstandard.</li> <li>COMPRESSION_TYPE_LZ4: Кодек LZ4.</li> <li>COMPRESSION_TYPE_SNAPPY: Кодек Snappy.</li> <li>COMPRESSION_TYPE_GZIP: кодек GZip.</li> <li>COMPRESSION_TYPE_PRODUCER: кодек задается на стороне производителя (допустимые кодеки: ``ZSTD``, ``LZ4``, ``GZIP`` или ``SNAPPY``).</li> </ul> 
topicSpec.<br>topicConfig_2_1.<br>deleteRetentionMs | **integer** (int64)<br><p>Время (в миллисекундах), в течение которого нужно хранить tombstone-маркеры удаления для топиков со сжатым логом.</p> 
topicSpec.<br>topicConfig_2_1.<br>fileDeleteDelayMs | **integer** (int64)<br><p>Время ожидания перед удалением файла из файловой системы.</p> 
topicSpec.<br>topicConfig_2_1.<br>flushMessages | **integer** (int64)<br><p>Количество сообщений, которые должны быть накоплены в разделе прежде, чем эти сообщения будут сброшены на диск.</p> <p>Эта настройка переопределяет на уровне топика настройку уровня кластера ``logFlushIntervalMessages``.</p> 
topicSpec.<br>topicConfig_2_1.<br>flushMs | **integer** (int64)<br><p>Максимальное время (в миллисекундах), в течение которого сообщение в любом топике хранится в памяти перед сбросом на диск.</p> <p>Эта настройка переопределяет на уровне топика настройку уровня кластера ``logFlushIntervalMs``.</p> 
topicSpec.<br>topicConfig_2_1.<br>minCompactionLagMs | **integer** (int64)<br><p>Минимальное время в миллисекундах, в течение которого сообщение в логе будет оставаться несжатым.</p> 
topicSpec.<br>topicConfig_2_1.<br>retentionBytes | **integer** (int64)<br><p>Максимальный размер, до которого может вырасти раздел, прежде чем Kafka начнет отбрасывать старые сегменты лога, если действует настройка ``delete`` ``cleanupPolicy``. Эта настройка полезна, если вам необходимо контролировать размер лога из-за ограниченного дискового пространства.</p> <p>Эта настройка переопределяет на уровне топика настройку уровня кластера ``logRetentionBytes``.</p> 
topicSpec.<br>topicConfig_2_1.<br>retentionMs | **integer** (int64)<br><p>Количество миллисекунд до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> <p>Эта настройка переопределяет на уровне топика настройку уровня кластера ``logRetentionMs``.</p> 
 
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
done | **boolean** (boolean)<br><p>Если значение равно ``false`` — операция еще выполняется. Если ``true`` — операция завершена, и задано значение одного из полей ``error`` или ``response``.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля ``metadata``.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля ``response``.</p> 