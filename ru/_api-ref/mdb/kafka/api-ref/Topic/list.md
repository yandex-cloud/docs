---
editable: false
---

# Метод list
Получает список топиков Kafka в указанном кластере.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/topics
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера Apache Kafka®, для которого нужно получить список топиков.  Чтобы получить идентификатор кластера, выполните запрос [list](/docs/managed-kafka/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на одной странице в ответе.  Если количество результатов больше чем [pageSize](/docs/managed-kafka/api-ref/Topic/list#query_params), сервис вернет значение [nextPageToken](/docs/managed-kafka/api-ref/Topic/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы.  Установите значение [pageToken](/docs/managed-kafka/api-ref/Topic/list#query_params) равным значению поля [nextPageToken](/docs/managed-kafka/api-ref/Topic/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
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
topics[] | **object**<br><p>Топик Kafka. Подробнее читайте в разделе <a href="/docs/managed-kafka/concepts/topics">Concepts → Topics and partitions</a> документации.</p> 
topics[].<br>name | **string**<br><p>Имя топика.</p> 
topics[].<br>clusterId | **string**<br><p>Идентификатор кластера Apache Kafka®, к которому принадлежит топик.</p> <p>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a>.</p> 
topics[].<br>partitions | **integer** (int64)<br><p>Количество разделов в топике.</p> 
topics[].<br>replicationFactor | **integer** (int64)<br><p>Количество копий данных (реплик) для топика в кластере.</p> 
topics[].<br>topicConfig_2_1 | **object**<br><p>Настройки топика.</p> 
topics[].<br>topicConfig_2_1.<br>cleanupPolicy | **string**<br><p>Политика хранения старых сообщений лога.</p> <ul> <li>CLEANUP_POLICY_DELETE: эта политика отбрасывает сегменты лога либо при истечении срока их хранения, либо при достижении предельного размера лога. См. также описание ``logRetentionMs`` и других подобных параметров.</li> <li>CLEANUP_POLICY_COMPACT: эта политика сжимает сообщения в логе.</li> <li>CLEANUP_POLICY_COMPACT_AND_DELETE: эта политика использует как сжатие сообщений, так и удаление сегментов лога.</li> </ul> 
topics[].<br>topicConfig_2_1.<br>compressionType | **string**<br><p>Тип сжатия для указанного топика.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: не использовать кодек (сообщения не сжимаются).</li> <li>COMPRESSION_TYPE_ZSTD: кодек Zstandard.</li> <li>COMPRESSION_TYPE_LZ4: Кодек LZ4.</li> <li>COMPRESSION_TYPE_SNAPPY: Кодек Snappy.</li> <li>COMPRESSION_TYPE_GZIP: кодек GZip.</li> <li>COMPRESSION_TYPE_PRODUCER: кодек задается на стороне производителя (допустимые кодеки: ``ZSTD``, ``LZ4``, ``GZIP`` или ``SNAPPY``).</li> </ul> 
topics[].<br>topicConfig_2_1.<br>deleteRetentionMs | **integer** (int64)<br><p>Время (в миллисекундах), в течение которого нужно хранить tombstone-маркеры удаления для топиков со сжатым логом.</p> 
topics[].<br>topicConfig_2_1.<br>fileDeleteDelayMs | **integer** (int64)<br><p>Время ожидания перед удалением файла из файловой системы.</p> 
topics[].<br>topicConfig_2_1.<br>flushMessages | **integer** (int64)<br><p>Количество сообщений, которые должны быть накоплены в разделе прежде, чем эти сообщения будут сброшены на диск.</p> <p>Эта настройка переопределяет на уровне топика настройку уровня кластера ``logFlushIntervalMessages``.</p> 
topics[].<br>topicConfig_2_1.<br>flushMs | **integer** (int64)<br><p>Максимальное время (в миллисекундах), в течение которого сообщение в любом топике хранится в памяти перед сбросом на диск.</p> <p>Эта настройка переопределяет на уровне топика настройку уровня кластера ``logFlushIntervalMs``.</p> 
topics[].<br>topicConfig_2_1.<br>minCompactionLagMs | **integer** (int64)<br><p>Минимальное время в миллисекундах, в течение которого сообщение в логе будет оставаться несжатым.</p> 
topics[].<br>topicConfig_2_1.<br>retentionBytes | **integer** (int64)<br><p>Максимальный размер, до которого может вырасти раздел, прежде чем Kafka начнет отбрасывать старые сегменты лога, если действует настройка ``delete`` ``cleanupPolicy``. Эта настройка полезна, если вам необходимо контролировать размер лога из-за ограниченного дискового пространства.</p> <p>Эта настройка переопределяет на уровне топика настройку уровня кластера ``logRetentionBytes``.</p> 
topics[].<br>topicConfig_2_1.<br>retentionMs | **integer** (int64)<br><p>Количество миллисекунд до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> <p>Эта настройка переопределяет на уровне топика настройку уровня кластера ``logRetentionMs``.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе.</p> <p>Если количество результатов больше чем <a href="/docs/managed-kafka/api-ref/Topic/list#query_params">pageSize</a>, используйте <a href="/docs/managed-kafka/api-ref/Topic/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-kafka/api-ref/Topic/list#query_params">pageToken</a> в следующем запросе. Все последующие запросы будут получать свои значения <a href="/docs/managed-kafka/api-ref/Topic/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 