---
editable: false
---

# TopicService

A set of methods for managing Apache Kafka topics.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Returns the specified Apache Kafka topic. |
| [List](#List) | Retrieves the list of Apache Kafka topics in the specified cluster. |
| [Create](#Create) | Creates a new Apache Kafka topic in the specified cluster. |
| [Update](#Update) | Updates the specified Apache Kafka topic. |
| [Delete](#Delete) | Deletes the specified Apache Kafka topic. |

## Вызовы TopicService {#calls}

## Get {#Get}

Returns the specified Apache Kafka topic. <br>To get the list of available Apache Kafka topics, make a [List](#List) request.

**rpc Get ([GetTopicRequest](#GetTopicRequest)) returns ([Topic](#Topic))**

### GetTopicRequest {#GetTopicRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster that the topic belongs to. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. false Максимальная длина строки в символах — 50.
topic_name | **string**<br>Обязательное поле. Name of the Apache Kafka Topic resource to return. <br>To get the name of the topic, make a [TopicService.List](#List) request. false Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Topic {#Topic}

Поле | Описание
--- | ---
name | **string**<br>Name of the topic. 
cluster_id | **string**<br>ID of an Apache Kafka cluster that the topic belongs to. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of the topic's partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of data copies (replicas) for the topic in the cluster. 
topic_config | **oneof:** `topic_config_2_1`<br>User-defined settings for the topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_1)**<br>User-defined settings for the topic. 


### TopicConfig2_1 {#TopicConfig2_1}

Поле | Описание
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. <br>See also: [Cluster.config.kafka.kafka_config.log_retention_ms](#Cluster) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: This policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: This policy use both compaction and deletion for messages and log segments.</li><ul/>
compression_type | enum **CompressionType**<br>Specify the compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: No codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: The codec to use is set by a producer (can be any of ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li><ul/>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_messages](#Cluster) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_ms](#Cluster) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_bytes](#Cluster) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_ms](#Cluster) setting on the topic level. 


## List {#List}

Retrieves the list of Apache Kafka topics in the specified cluster.

**rpc List ([ListTopicsRequest](#ListTopicsRequest)) returns ([ListTopicsResponse](#ListTopicsResponse))**

### ListTopicsRequest {#ListTopicsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster to list topics in. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. false Максимальная длина строки в символах — 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListTopicsResponse.next_page_token](#ListTopicsResponse) that can be used to get the next page of results in subsequent list requests. Максимальное значение — 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListTopicsResponse.next_page_token](#ListTopicsResponse) returned by a previous list request. Максимальная длина строки в символах — 100.


### ListTopicsResponse {#ListTopicsResponse}

Поле | Описание
--- | ---
topics[] | **[Topic](#Topic1)**<br>List of Apache Kafka Topic resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListTopicsRequest.page_size](#ListTopicsRequest1), use the `next_page_token` as the value for the [ListTopicsRequest.page_token](#ListTopicsRequest1) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Topic {#Topic}

Поле | Описание
--- | ---
name | **string**<br>Name of the topic. 
cluster_id | **string**<br>ID of an Apache Kafka cluster that the topic belongs to. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of the topic's partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of data copies (replicas) for the topic in the cluster. 
topic_config | **oneof:** `topic_config_2_1`<br>User-defined settings for the topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_11)**<br>User-defined settings for the topic. 


### TopicConfig2_1 {#TopicConfig2_1}

Поле | Описание
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. <br>See also: [Cluster.config.kafka.kafka_config.log_retention_ms](#Cluster) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: This policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: This policy use both compaction and deletion for messages and log segments.</li><ul/>
compression_type | enum **CompressionType**<br>Specify the compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: No codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: The codec to use is set by a producer (can be any of ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li><ul/>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_messages](#Cluster) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_ms](#Cluster) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_bytes](#Cluster) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_ms](#Cluster) setting on the topic level. 


## Create {#Create}

Creates a new Apache Kafka topic in the specified cluster.

**rpc Create ([CreateTopicRequest](#CreateTopicRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateTopicMetadata](#CreateTopicMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Topic](#Topic2)<br>

### CreateTopicRequest {#CreateTopicRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster to create a topic in. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. false Максимальная длина строки в символах — 50.
topic_spec | **[TopicSpec](#TopicSpec)**<br>Обязательное поле. Configuration of the topic to create. false


### TopicSpec {#TopicSpec}

Поле | Описание
--- | ---
name | **string**<br>Name of the topic. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of the topic's partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of copies of a topic data kept in the cluster. 
topic_config | **oneof:** `topic_config_2_1`<br>User-defined settings for the topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_12)**<br>User-defined settings for the topic. 


### TopicConfig2_1 {#TopicConfig2_1}

Поле | Описание
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. <br>See also: [Cluster.config.kafka.kafka_config.log_retention_ms](#Cluster) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: This policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: This policy use both compaction and deletion for messages and log segments.</li><ul/>
compression_type | enum **CompressionType**<br>Specify the compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: No codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: The codec to use is set by a producer (can be any of ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li><ul/>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_messages](#Cluster) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_ms](#Cluster) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_bytes](#Cluster) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_ms](#Cluster) setting on the topic level. 


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
cluster_id | **string**<br>ID of the Apache Kafka cluster where a topic is being created. 
topic_name | **string**<br>Обязательное поле. Name of the Apache Kafka topic that is being created. false Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Topic {#Topic}

Поле | Описание
--- | ---
name | **string**<br>Name of the topic. 
cluster_id | **string**<br>ID of an Apache Kafka cluster that the topic belongs to. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of the topic's partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of data copies (replicas) for the topic in the cluster. 
topic_config | **oneof:** `topic_config_2_1`<br>User-defined settings for the topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_13)**<br>User-defined settings for the topic. 


## Update {#Update}

Updates the specified Apache Kafka topic.

**rpc Update ([UpdateTopicRequest](#UpdateTopicRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateTopicMetadata](#UpdateTopicMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Topic](#Topic3)<br>

### UpdateTopicRequest {#UpdateTopicRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster to update a topic in. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. false Максимальная длина строки в символах — 50.
topic_name | **string**<br>Обязательное поле. Name of the topic to update. <br>To get the name of the topic, make a [TopicService.List](#List) request. false Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Apache Kafka topic should be updated. <br>By default, this API method will replace all the values for the settings that are not present in `update_mask` list with the default ones. Pass the list of the settings to change in this parameter to prevent the method from doing so (use comma as a delimiter if you want to modify a few settings at once). 
topic_spec | **[TopicSpec](#TopicSpec1)**<br>New configuration of the topic. <br>Use `update_mask` to prevent reverting all topic settings that are not listed in `topic_spec` to their default values. Configuration of the topic to create. 


### TopicSpec {#TopicSpec}

Поле | Описание
--- | ---
name | **string**<br>Name of the topic. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of the topic's partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of copies of a topic data kept in the cluster. 
topic_config | **oneof:** `topic_config_2_1`<br>User-defined settings for the topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_13)**<br>User-defined settings for the topic. 


### TopicConfig2_1 {#TopicConfig2_1}

Поле | Описание
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. <br>See also: [Cluster.config.kafka.kafka_config.log_retention_ms](#Cluster) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: This policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: This policy use both compaction and deletion for messages and log segments.</li><ul/>
compression_type | enum **CompressionType**<br>Specify the compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: No codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: The codec to use is set by a producer (can be any of ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li><ul/>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_messages](#Cluster) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_ms](#Cluster) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_bytes](#Cluster) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_ms](#Cluster) setting on the topic level. 


### Operation {#Operation}

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
cluster_id | **string**<br>ID of the Apache Kafka cluster where a topic is being updated. 
topic_name | **string**<br>Name of the Apache Kafka topic that is being updated. 


### Topic {#Topic}

Поле | Описание
--- | ---
name | **string**<br>Name of the topic. 
cluster_id | **string**<br>ID of an Apache Kafka cluster that the topic belongs to. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of the topic's partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of data copies (replicas) for the topic in the cluster. 
topic_config | **oneof:** `topic_config_2_1`<br>User-defined settings for the topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_14)**<br>User-defined settings for the topic. 


## Delete {#Delete}

Deletes the specified Apache Kafka topic.

**rpc Delete ([DeleteTopicRequest](#DeleteTopicRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteTopicMetadata](#DeleteTopicMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteTopicRequest {#DeleteTopicRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster to delete a topic in. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. false Максимальная длина строки в символах — 50.
topic_name | **string**<br>Обязательное поле. Name of the topic to delete. <br>To get the name of the topic, make a [TopicService.List](#List) request. false Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Operation {#Operation}

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
cluster_id | **string**<br>ID of the Apache Kafka cluster where a topic is being deleted. 
topic_name | **string**<br>Name of the Apache Kafka topic that is being deleted. 


