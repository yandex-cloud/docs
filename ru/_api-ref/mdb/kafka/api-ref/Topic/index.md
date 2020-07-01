---
editable: false
---

# Topic
Набор методов для управления топиками Apache Kafka.
## JSON-представление {#representation}
```json 
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
```
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя топика.</p> 
clusterId | **string**<br><p>Идентификатор кластера Apache Kafka, к которому принадлежит топик.</p> <p>Чтобы получить идентификатор кластера Apache Kafka, выполните запрос <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a>.</p> 
partitions | **integer** (int64)<br><p>Количество разделов в топике.</p> 
replicationFactor | **integer** (int64)<br><p>Количество копий данных (реплик) для топика в кластере.</p> 
topicConfig_2_1 | **object**<br><p>Настройки топика.</p> 
topicConfig_2_1.<br>cleanupPolicy | **string**<br><p>Политика хранения старых сообщений лога.</p> <ul> <li>CLEANUP_POLICY_DELETE: Эта политика отбрасывает сегменты лога либо при истечении срока их хранения, либо при достижении предельного размера лога.</li> </ul> <p>См. также описание [Cluster.config.kafka.kafka_config.log_retention_ms] и других подобных параметров.</p> <ul> <li>CLEANUP_POLICY_COMPACT: Эта политика сжимает сообщения в логе.</li> <li>CLEANUP_POLICY_COMPACT_AND_DELETE: Эта политика использует как сжатие сообщений, так и удаление сегментов лога.</li> </ul> 
topicConfig_2_1.<br>compressionType | **string**<br><p>Тип сжатия для указанного топика.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: Не использовать кодек (сообщения не сжимаются).</li> <li>COMPRESSION_TYPE_ZSTD: Кодек Zstandard.</li> <li>COMPRESSION_TYPE_LZ4: Кодек LZ4.</li> <li>COMPRESSION_TYPE_SNAPPY: Кодек Snappy.</li> <li>COMPRESSION_TYPE_GZIP: Кодек GZip.</li> <li>COMPRESSION_TYPE_PRODUCER: Кодек задается на стороне производителя (допустимые кодеки: ZSTD<code>, </code>Формате LZ4<code>, </code>УТИЛИТА GZIP<code>or</code>SNAPPY`).</li> </ul> 
topicConfig_2_1.<br>deleteRetentionMs | **integer** (int64)<br><p>Время (в миллисекундах), в течение которого нужно хранить tombstone-маркеры удаления для топиков со сжатым логом.</p> 
topicConfig_2_1.<br>fileDeleteDelayMs | **integer** (int64)<br><p>Время ожидания перед удалением файла из файловой системы.</p> 
topicConfig_2_1.<br>flushMessages | **integer** (int64)<br><p>Количество сообщений, которые должны быть накоплены в разделе прежде, чем эти сообщения будут сброшены на диск.</p> <p>Эта настройка переопределяет на уровне топика настройку уровня кластера [Cluster.config.kafka.kafka_config.log_flush_interval_messages].</p> 
topicConfig_2_1.<br>flushMs | **integer** (int64)<br><p>Максимальное время (в миллисекундах), в течение которого сообщение в любом топике хранится в памяти перед сбросом на диск.</p> <p>Эта настройка переопределяет на уровне топика настройку уровня кластера [Cluster.config.kafka.kafka_config.log_flush_interval_ms].</p> 
topicConfig_2_1.<br>minCompactionLagMs | **integer** (int64)<br><p>Минимальное время в миллисекундах, в течение которого сообщение в логе будет оставаться несжатым.</p> 
topicConfig_2_1.<br>retentionBytes | **integer** (int64)<br><p>Максимальный размер, до которого может вырасти раздел, прежде чем Kafka начнет отбрасывать старые сегменты лога, если действует настройка <code>delete</code> <code>cleanupPolicy</code>. Эта настройка полезна, если вам необходимо контролировать размер лога из-за ограниченного дискового пространства.</p> <p>Эта настройка переопределяет на уровне топика настройку уровня кластера [Cluster.config.kafka.kafka_config.log_retention_bytes].</p> 
topicConfig_2_1.<br>retentionMs | **integer** (int64)<br><p>Количество миллисекунд до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> <p>Эта настройка переопределяет на уровне топика настройку уровня кластера [Cluster.config.kafka.kafka_config.log_retention_ms].</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает топик Apache Kafka в указанном кластере.
[delete](delete.md) | Удаляет указанный топик Apache Kafka.
[get](get.md) | Возвращает информацию об указанном топике Apache Kafka.
[list](list.md) | Получает список топиков Apache Kafka в указанном кластере.
[update](update.md) | Изменяет указанный топик Apache Kafka.