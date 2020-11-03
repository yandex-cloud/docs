---
editable: false
---

# TopicService

Набор методов для управления топиками Kafka.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает информацию об указанном топике Kafka. |
| [List](#List) | Получает список топиков Kafka в указанном кластере. |
| [Create](#Create) | Создает топик Kafka в указанном кластере. |
| [Update](#Update) | Изменяет указанный топик Kafka. |
| [Delete](#Delete) | Удаляет указанный топик Kafka. |

## Вызовы TopicService {#calls}

## Get {#Get}

Возвращает информацию об указанном топике Kafka. <br>Чтобы получить список доступных топиков Kafka, выполните запрос [List](#List).

**rpc Get ([GetTopicRequest](#GetTopicRequest)) returns ([Topic](#Topic))**

### GetTopicRequest {#GetTopicRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, к которому принадлежит топик. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
topic_name | **string**<br>Обязательное поле. Имя запрашиваемого топика Kafka. <br>Чтобы получить имя топика, выполните запрос [TopicService.List](#List). Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Topic {#Topic}

Поле | Описание
--- | ---
name | **string**<br>Имя топика. 
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, к которому принадлежит топик. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](./cluster_service#List). 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество разделов в топике. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество копий данных (реплик) для топика в кластере. 
topic_config | **oneof:** `topic_config_2_1`<br>Пользовательские настройки топика.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_1)**<br>Пользовательские настройки топика. 


### TopicConfig2_1 {#TopicConfig2_1}

Поле | Описание
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Политика хранения старых сообщений лога. <ul><li>`CLEANUP_POLICY_DELETE`: эта политика отбрасывает сегменты лога либо при истечении срока их хранения, либо при достижении предельного размера лога. См. также описание [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) и других подобных параметров.</li><li>`CLEANUP_POLICY_COMPACT`: эта политика сжимает сообщения в логе.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: эта политика использует как сжатие сообщений, так и удаление сегментов лога.</li><ul/>
compression_type | enum **CompressionType**<br>Тип сжатия для указанного топика. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: не использовать кодек (сообщения не сжимаются).</li><li>`COMPRESSION_TYPE_ZSTD`: кодек Zstandard.</li><li>`COMPRESSION_TYPE_LZ4`: Кодек LZ4.</li><li>`COMPRESSION_TYPE_SNAPPY`: Кодек Snappy.</li><li>`COMPRESSION_TYPE_GZIP`: кодек GZip.</li><li>`COMPRESSION_TYPE_PRODUCER`: кодек задается на стороне производителя (допустимые кодеки: `ZSTD`, `LZ4`, `GZIP` или `SNAPPY`).</li><ul/>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время (в миллисекундах), в течение которого нужно хранить tombstone-маркеры удаления для топиков со сжатым логом. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время ожидания перед удалением файла из файловой системы. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество сообщений, которые должны быть накоплены в разделе прежде, чем эти сообщения будут сброшены на диск. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_flush_interval_messages](#KafkaConfig2_1). 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное время (в миллисекундах), в течение которого сообщение в любом топике хранится в памяти перед сбросом на диск. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_flush_interval_ms](#KafkaConfig2_1). 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Минимальное время в миллисекундах, в течение которого сообщение в логе будет оставаться несжатым. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальный размер, до которого может вырасти раздел, прежде чем Kafka начнет отбрасывать старые сегменты лога, если действует настройка `delete` `cleanup_policy`. Эта настройка полезна, если вам необходимо контролировать размер лога из-за ограниченного дискового пространства. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_retention_bytes](#KafkaConfig2_1). 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество миллисекунд до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1). 


## List {#List}

Получает список топиков Kafka в указанном кластере.

**rpc List ([ListTopicsRequest](#ListTopicsRequest)) returns ([ListTopicsResponse](#ListTopicsResponse))**

### ListTopicsRequest {#ListTopicsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, для которого нужно получить список топиков. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. <br>Если количество результатов больше чем `page_size`, сервис вернет значение [ListTopicsResponse.next_page_token](#ListTopicsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. <br>Установите значение `page_token` равным значению поля [ListTopicsResponse.next_page_token](#ListTopicsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListTopicsResponse {#ListTopicsResponse}

Поле | Описание
--- | ---
topics[] | **[Topic](#Topic1)**<br>Список топиков Kafka. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. <br>Если количество результатов больше чем [ListTopicsRequest.page_size](#ListTopicsRequest), используйте `next_page_token` в качестве значения параметра [ListTopicsRequest.page_token](#ListTopicsRequest) в следующем запросе. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Topic {#Topic1}

Поле | Описание
--- | ---
name | **string**<br>Имя топика. 
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, к которому принадлежит топик. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](./cluster_service#List). 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество разделов в топике. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество копий данных (реплик) для топика в кластере. 
topic_config | **oneof:** `topic_config_2_1`<br>Пользовательские настройки топика.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_11)**<br>Пользовательские настройки топика. 


### TopicConfig2_1 {#TopicConfig2_11}

Поле | Описание
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Политика хранения старых сообщений лога. <ul><li>`CLEANUP_POLICY_DELETE`: эта политика отбрасывает сегменты лога либо при истечении срока их хранения, либо при достижении предельного размера лога. См. также описание [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) и других подобных параметров.</li><li>`CLEANUP_POLICY_COMPACT`: эта политика сжимает сообщения в логе.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: эта политика использует как сжатие сообщений, так и удаление сегментов лога.</li><ul/>
compression_type | enum **CompressionType**<br>Тип сжатия для указанного топика. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: не использовать кодек (сообщения не сжимаются).</li><li>`COMPRESSION_TYPE_ZSTD`: кодек Zstandard.</li><li>`COMPRESSION_TYPE_LZ4`: Кодек LZ4.</li><li>`COMPRESSION_TYPE_SNAPPY`: Кодек Snappy.</li><li>`COMPRESSION_TYPE_GZIP`: кодек GZip.</li><li>`COMPRESSION_TYPE_PRODUCER`: кодек задается на стороне производителя (допустимые кодеки: `ZSTD`, `LZ4`, `GZIP` или `SNAPPY`).</li><ul/>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время (в миллисекундах), в течение которого нужно хранить tombstone-маркеры удаления для топиков со сжатым логом. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время ожидания перед удалением файла из файловой системы. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество сообщений, которые должны быть накоплены в разделе прежде, чем эти сообщения будут сброшены на диск. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_flush_interval_messages](#KafkaConfig2_1). 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное время (в миллисекундах), в течение которого сообщение в любом топике хранится в памяти перед сбросом на диск. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_flush_interval_ms](#KafkaConfig2_1). 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Минимальное время в миллисекундах, в течение которого сообщение в логе будет оставаться несжатым. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальный размер, до которого может вырасти раздел, прежде чем Kafka начнет отбрасывать старые сегменты лога, если действует настройка `delete` `cleanup_policy`. Эта настройка полезна, если вам необходимо контролировать размер лога из-за ограниченного дискового пространства. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_retention_bytes](#KafkaConfig2_1). 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество миллисекунд до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1). 


## Create {#Create}

Создает топик Kafka в указанном кластере.

**rpc Create ([CreateTopicRequest](#CreateTopicRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateTopicMetadata](#CreateTopicMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Topic](#Topic2)<br>

### CreateTopicRequest {#CreateTopicRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, в котором следует создать топик. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
topic_spec | **[TopicSpec](#TopicSpec)**<br>Обязательное поле. Конфигурация топика, который нужно создать. 


### TopicSpec {#TopicSpec}

Поле | Описание
--- | ---
name | **string**<br>Имя топика. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество разделов в топике. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество копий данных топика, хранящихся в кластере. 
topic_config | **oneof:** `topic_config_2_1`<br>Пользовательские настройки топика.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_12)**<br>Пользовательские настройки топика. 


### TopicConfig2_1 {#TopicConfig2_12}

Поле | Описание
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Политика хранения старых сообщений лога. <ul><li>`CLEANUP_POLICY_DELETE`: эта политика отбрасывает сегменты лога либо при истечении срока их хранения, либо при достижении предельного размера лога. См. также описание [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) и других подобных параметров.</li><li>`CLEANUP_POLICY_COMPACT`: эта политика сжимает сообщения в логе.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: эта политика использует как сжатие сообщений, так и удаление сегментов лога.</li><ul/>
compression_type | enum **CompressionType**<br>Тип сжатия для указанного топика. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: не использовать кодек (сообщения не сжимаются).</li><li>`COMPRESSION_TYPE_ZSTD`: кодек Zstandard.</li><li>`COMPRESSION_TYPE_LZ4`: Кодек LZ4.</li><li>`COMPRESSION_TYPE_SNAPPY`: Кодек Snappy.</li><li>`COMPRESSION_TYPE_GZIP`: кодек GZip.</li><li>`COMPRESSION_TYPE_PRODUCER`: кодек задается на стороне производителя (допустимые кодеки: `ZSTD`, `LZ4`, `GZIP` или `SNAPPY`).</li><ul/>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время (в миллисекундах), в течение которого нужно хранить tombstone-маркеры удаления для топиков со сжатым логом. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время ожидания перед удалением файла из файловой системы. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество сообщений, которые должны быть накоплены в разделе прежде, чем эти сообщения будут сброшены на диск. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_flush_interval_messages](#KafkaConfig2_1). 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное время (в миллисекундах), в течение которого сообщение в любом топике хранится в памяти перед сбросом на диск. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_flush_interval_ms](#KafkaConfig2_1). 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Минимальное время в миллисекундах, в течение которого сообщение в логе будет оставаться несжатым. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальный размер, до которого может вырасти раздел, прежде чем Kafka начнет отбрасывать старые сегменты лога, если действует настройка `delete` `cleanup_policy`. Эта настройка полезна, если вам необходимо контролировать размер лога из-за ограниченного дискового пространства. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_retention_bytes](#KafkaConfig2_1). 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество миллисекунд до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1). 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateTopicMetadata](#CreateTopicMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Topic](#Topic2)>**<br>в случае успешного выполнения операции. 


### CreateTopicMetadata {#CreateTopicMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, в котором создается топик. 
topic_name | **string**<br>Обязательное поле. Имя создаваемого топика Kafka. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Topic {#Topic2}

Поле | Описание
--- | ---
name | **string**<br>Имя топика. 
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, к которому принадлежит топик. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](./cluster_service#List). 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество разделов в топике. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество копий данных (реплик) для топика в кластере. 
topic_config | **oneof:** `topic_config_2_1`<br>Пользовательские настройки топика.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_13)**<br>Пользовательские настройки топика. 


### TopicConfig2_1 {#TopicConfig2_13}

Поле | Описание
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Политика хранения старых сообщений лога. <ul><li>`CLEANUP_POLICY_DELETE`: эта политика отбрасывает сегменты лога либо при истечении срока их хранения, либо при достижении предельного размера лога. См. также описание [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) и других подобных параметров.</li><li>`CLEANUP_POLICY_COMPACT`: эта политика сжимает сообщения в логе.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: эта политика использует как сжатие сообщений, так и удаление сегментов лога.</li><ul/>
compression_type | enum **CompressionType**<br>Тип сжатия для указанного топика. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: не использовать кодек (сообщения не сжимаются).</li><li>`COMPRESSION_TYPE_ZSTD`: кодек Zstandard.</li><li>`COMPRESSION_TYPE_LZ4`: Кодек LZ4.</li><li>`COMPRESSION_TYPE_SNAPPY`: Кодек Snappy.</li><li>`COMPRESSION_TYPE_GZIP`: кодек GZip.</li><li>`COMPRESSION_TYPE_PRODUCER`: кодек задается на стороне производителя (допустимые кодеки: `ZSTD`, `LZ4`, `GZIP` или `SNAPPY`).</li><ul/>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время (в миллисекундах), в течение которого нужно хранить tombstone-маркеры удаления для топиков со сжатым логом. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время ожидания перед удалением файла из файловой системы. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество сообщений, которые должны быть накоплены в разделе прежде, чем эти сообщения будут сброшены на диск. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_flush_interval_messages](#KafkaConfig2_1). 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное время (в миллисекундах), в течение которого сообщение в любом топике хранится в памяти перед сбросом на диск. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_flush_interval_ms](#KafkaConfig2_1). 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Минимальное время в миллисекундах, в течение которого сообщение в логе будет оставаться несжатым. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальный размер, до которого может вырасти раздел, прежде чем Kafka начнет отбрасывать старые сегменты лога, если действует настройка `delete` `cleanup_policy`. Эта настройка полезна, если вам необходимо контролировать размер лога из-за ограниченного дискового пространства. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_retention_bytes](#KafkaConfig2_1). 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество миллисекунд до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1). 


## Update {#Update}

Изменяет указанный топик Kafka.

**rpc Update ([UpdateTopicRequest](#UpdateTopicRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateTopicMetadata](#UpdateTopicMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Topic](#Topic3)<br>

### UpdateTopicRequest {#UpdateTopicRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, в котором следует изменить топик. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
topic_name | **string**<br>Обязательное поле. Имя топика, который нужно изменить. <br>Чтобы получить имя топика, выполните запрос [TopicService.List](#List). Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
topic_spec | **[TopicSpec](#TopicSpec1)**<br>Новые настройки топика. <br>Используйте параметр `update_mask` чтобы предотвратить сброс настроек топика, не перечисленных в `topic_spec`, на значения по умолчанию. 


### TopicSpec {#TopicSpec1}

Поле | Описание
--- | ---
name | **string**<br>Имя топика. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество разделов в топике. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество копий данных топика, хранящихся в кластере. 
topic_config | **oneof:** `topic_config_2_1`<br>Пользовательские настройки топика.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_14)**<br>Пользовательские настройки топика. 


### TopicConfig2_1 {#TopicConfig2_14}

Поле | Описание
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Политика хранения старых сообщений лога. <ul><li>`CLEANUP_POLICY_DELETE`: эта политика отбрасывает сегменты лога либо при истечении срока их хранения, либо при достижении предельного размера лога. См. также описание [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) и других подобных параметров.</li><li>`CLEANUP_POLICY_COMPACT`: эта политика сжимает сообщения в логе.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: эта политика использует как сжатие сообщений, так и удаление сегментов лога.</li><ul/>
compression_type | enum **CompressionType**<br>Тип сжатия для указанного топика. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: не использовать кодек (сообщения не сжимаются).</li><li>`COMPRESSION_TYPE_ZSTD`: кодек Zstandard.</li><li>`COMPRESSION_TYPE_LZ4`: Кодек LZ4.</li><li>`COMPRESSION_TYPE_SNAPPY`: Кодек Snappy.</li><li>`COMPRESSION_TYPE_GZIP`: кодек GZip.</li><li>`COMPRESSION_TYPE_PRODUCER`: кодек задается на стороне производителя (допустимые кодеки: `ZSTD`, `LZ4`, `GZIP` или `SNAPPY`).</li><ul/>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время (в миллисекундах), в течение которого нужно хранить tombstone-маркеры удаления для топиков со сжатым логом. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время ожидания перед удалением файла из файловой системы. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество сообщений, которые должны быть накоплены в разделе прежде, чем эти сообщения будут сброшены на диск. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_flush_interval_messages](#KafkaConfig2_1). 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное время (в миллисекундах), в течение которого сообщение в любом топике хранится в памяти перед сбросом на диск. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_flush_interval_ms](#KafkaConfig2_1). 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Минимальное время в миллисекундах, в течение которого сообщение в логе будет оставаться несжатым. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальный размер, до которого может вырасти раздел, прежде чем Kafka начнет отбрасывать старые сегменты лога, если действует настройка `delete` `cleanup_policy`. Эта настройка полезна, если вам необходимо контролировать размер лога из-за ограниченного дискового пространства. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_retention_bytes](#KafkaConfig2_1). 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество миллисекунд до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1). 


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateTopicMetadata](#UpdateTopicMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Topic](#Topic3)>**<br>в случае успешного выполнения операции. 


### UpdateTopicMetadata {#UpdateTopicMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, в котором изменяется топик. 
topic_name | **string**<br>Имя изменяемого топика Kafka. 


### Topic {#Topic3}

Поле | Описание
--- | ---
name | **string**<br>Имя топика. 
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, к которому принадлежит топик. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](./cluster_service#List). 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество разделов в топике. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество копий данных (реплик) для топика в кластере. 
topic_config | **oneof:** `topic_config_2_1`<br>Пользовательские настройки топика.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_15)**<br>Пользовательские настройки топика. 


### TopicConfig2_1 {#TopicConfig2_15}

Поле | Описание
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Политика хранения старых сообщений лога. <ul><li>`CLEANUP_POLICY_DELETE`: эта политика отбрасывает сегменты лога либо при истечении срока их хранения, либо при достижении предельного размера лога. См. также описание [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) и других подобных параметров.</li><li>`CLEANUP_POLICY_COMPACT`: эта политика сжимает сообщения в логе.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: эта политика использует как сжатие сообщений, так и удаление сегментов лога.</li><ul/>
compression_type | enum **CompressionType**<br>Тип сжатия для указанного топика. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: не использовать кодек (сообщения не сжимаются).</li><li>`COMPRESSION_TYPE_ZSTD`: кодек Zstandard.</li><li>`COMPRESSION_TYPE_LZ4`: Кодек LZ4.</li><li>`COMPRESSION_TYPE_SNAPPY`: Кодек Snappy.</li><li>`COMPRESSION_TYPE_GZIP`: кодек GZip.</li><li>`COMPRESSION_TYPE_PRODUCER`: кодек задается на стороне производителя (допустимые кодеки: `ZSTD`, `LZ4`, `GZIP` или `SNAPPY`).</li><ul/>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время (в миллисекундах), в течение которого нужно хранить tombstone-маркеры удаления для топиков со сжатым логом. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время ожидания перед удалением файла из файловой системы. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество сообщений, которые должны быть накоплены в разделе прежде, чем эти сообщения будут сброшены на диск. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_flush_interval_messages](#KafkaConfig2_1). 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное время (в миллисекундах), в течение которого сообщение в любом топике хранится в памяти перед сбросом на диск. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_flush_interval_ms](#KafkaConfig2_1). 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Минимальное время в миллисекундах, в течение которого сообщение в логе будет оставаться несжатым. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальный размер, до которого может вырасти раздел, прежде чем Kafka начнет отбрасывать старые сегменты лога, если действует настройка `delete` `cleanup_policy`. Эта настройка полезна, если вам необходимо контролировать размер лога из-за ограниченного дискового пространства. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_retention_bytes](#KafkaConfig2_1). 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество миллисекунд до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1). 


## Delete {#Delete}

Удаляет указанный топик Kafka.

**rpc Delete ([DeleteTopicRequest](#DeleteTopicRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteTopicMetadata](#DeleteTopicMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteTopicRequest {#DeleteTopicRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, в котором следует удалить топик. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
topic_name | **string**<br>Обязательное поле. Имя удаляемого топика. <br>Чтобы получить имя топика, выполните запрос [TopicService.List](#List). Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteTopicMetadata](#DeleteTopicMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteTopicMetadata {#DeleteTopicMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, в котором удаляется топик. 
topic_name | **string**<br>Имя удаляемого топика Kafka. 


