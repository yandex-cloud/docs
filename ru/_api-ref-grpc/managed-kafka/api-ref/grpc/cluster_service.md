---
editable: false
---

# ClusterService

A set of methods for managing Apache Kafka clusters.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Returns the specified Apache Kafka cluster resource. |
| [List](#List) | Retrieves the list of Apache Kafka clusters that belong to the specified folder. |
| [Create](#Create) | Creates a new Apache Kafka cluster in the specified folder. |
| [Update](#Update) | Updates the specified Apache Kafka cluster. |
| [Delete](#Delete) | Deletes the specified Apache Kafka cluster. |
| [Move](#Move) | Moves the specified Apache Kafka cluster to the specified folder. |
| [Start](#Start) | Starts the specified Apache Kafka cluster. |
| [Stop](#Stop) | Stops the specified Apache Kafka cluster. |
| [ListLogs](#ListLogs) | Retrieves logs for the specified Apache Kafka cluster. |
| [StreamLogs](#StreamLogs) | Same as [ListLogs](#ListLogs) but using server-side streaming. |
| [ListOperations](#ListOperations) | Retrieves the list of operations for the specified Apache Kafka cluster. |
| [ListHosts](#ListHosts) | Retrieves a list of hosts for the specified Apache Kafka cluster. |

## Вызовы ClusterService {#calls}

## Get {#Get}

Returns the specified Apache Kafka cluster resource. <br>To get the list of available Apache Kafka clusters, make a [List](#List) request.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka Cluster resource to return. <br>To get the cluster ID, make a [ClusterService.List](#List) request. false Максимальная длина строки в символах — 50.


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>ID of the Apache Kafka cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Apache Kafka cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Apache Kafka cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Apache Kafka cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Apache Kafka cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Apache Kafka cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with a more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring)**<br>Description of monitoring systems relevant to the Apache Kafka cluster. 
config | **[ConfigSpec](#ConfigSpec)**<br>Configuration of the Apache Kafka cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


### Monitoring {#Monitoring}

Поле | Описание
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Apache Kafka cluster. 


### ConfigSpec {#ConfigSpec}

Поле | Описание
--- | ---
version | **string**<br>Version of Apache Kafka used in the cluster. 
kafka | **[Kafka](#Kafka)**<br>Configuration and resource allocation for Apache Kafka brokers. 
zookeeper | **[Zookeeper](#Zookeeper)**<br>Configuration and resource allocation for ZooKeeper hosts. 
zone_id[] | **string**<br>IDs of availability zones where Apache Kafka brokers reside. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of Apache Kafka brokers deployed in each availability zone. 
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the cluster. If the value is `true`, then Apache Kafka cluster is available on the Internet via it's public IP address. 


### Kafka {#Kafka}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to Apache Kafka brokers. 
kafka_config | **oneof:** `kafka_config_2_1`<br>Apache Kafka broker configuration.
&nbsp;&nbsp;kafka_config_2_1 | **[KafkaConfig2_1](#KafkaConfig2_1)**<br>Apache Kafka broker configuration. 


### Zookeeper {#Zookeeper}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to ZooKeeper hosts. 


## List {#List}

Retrieves the list of Apache Kafka clusters that belong to the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. ID of the folder to list Apache Kafka clusters in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. false Максимальная длина строки в символах — 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. Максимальное значение — 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by a previous list request. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>The field name to filter by. Currently you can only use filtering with the [Cluster.name](#Cluster1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Мust be 1-63 characters long and match the regular expression `^[a-zA-Z0-9_-]+$`. </li></ol> Максимальная длина строки в символах — 1000.


### ListClustersResponse {#ListClustersResponse}

Поле | Описание
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of Apache Kafka clusters. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest1), use `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest1) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>ID of the Apache Kafka cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Apache Kafka cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Apache Kafka cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Apache Kafka cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Apache Kafka cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Apache Kafka cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with a more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Description of monitoring systems relevant to the Apache Kafka cluster. 
config | **[ConfigSpec](#ConfigSpec1)**<br>Configuration of the Apache Kafka cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


### Monitoring {#Monitoring}

Поле | Описание
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Apache Kafka cluster. 


### ConfigSpec {#ConfigSpec}

Поле | Описание
--- | ---
version | **string**<br>Version of Apache Kafka used in the cluster. 
kafka | **[Kafka](#Kafka1)**<br>Configuration and resource allocation for Apache Kafka brokers. 
zookeeper | **[Zookeeper](#Zookeeper1)**<br>Configuration and resource allocation for ZooKeeper hosts. 
zone_id[] | **string**<br>IDs of availability zones where Apache Kafka brokers reside. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of Apache Kafka brokers deployed in each availability zone. 
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the cluster. If the value is `true`, then Apache Kafka cluster is available on the Internet via it's public IP address. 


### Kafka {#Kafka}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to Apache Kafka brokers. 
kafka_config | **oneof:** `kafka_config_2_1`<br>Apache Kafka broker configuration.
&nbsp;&nbsp;kafka_config_2_1 | **[KafkaConfig2_1](#KafkaConfig2_1)**<br>Apache Kafka broker configuration. 


### Zookeeper {#Zookeeper}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to ZooKeeper hosts. 


## Create {#Create}

Creates a new Apache Kafka cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. ID of the folder to create the Apache Kafka cluster in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. false Максимальная длина строки в символах — 50.
name | **string**<br>Обязательное поле. Name of the Apache Kafka cluster. The name must be unique within the folder. false Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the Apache Kafka cluster. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Custom labels for the Apache Kafka cluster as `key:value` pairs. Maximum 64 per cluster. <br>For example, "project": "mvp" or "source": "dictionary". Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_./\\@0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_./\\@0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Deployment environment of the Apache Kafka cluster. 
config_spec | **[ConfigSpec](#ConfigSpec2)**<br>Kafka and hosts configuration the Apache Kafka cluster. 
topic_specs[] | **[TopicSpec](#TopicSpec)**<br>One or more configurations of topics to be created in the Apache Kafka cluster. 
user_specs[] | **[UserSpec](#UserSpec)**<br>Configurations of accounts to be created in the Apache Kafka cluster. 
network_id | **string**<br>ID of the network to create the Apache Kafka cluster in. Максимальная длина строки в символах — 50.


### ConfigSpec {#ConfigSpec}

Поле | Описание
--- | ---
version | **string**<br>Version of Apache Kafka used in the cluster. 
kafka | **[Kafka](#Kafka2)**<br>Configuration and resource allocation for Apache Kafka brokers. 
zookeeper | **[Zookeeper](#Zookeeper2)**<br>Configuration and resource allocation for ZooKeeper hosts. 
zone_id[] | **string**<br>IDs of availability zones where Apache Kafka brokers reside. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of Apache Kafka brokers deployed in each availability zone. 
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the cluster. If the value is `true`, then Apache Kafka cluster is available on the Internet via it's public IP address. 


### Kafka {#Kafka}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to Apache Kafka brokers. 
kafka_config | **oneof:** `kafka_config_2_1`<br>Apache Kafka broker configuration.
&nbsp;&nbsp;kafka_config_2_1 | **[KafkaConfig2_1](#KafkaConfig2_1)**<br>Apache Kafka broker configuration. 


### Zookeeper {#Zookeeper}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to ZooKeeper hosts. 


### TopicSpec {#TopicSpec}

Поле | Описание
--- | ---
name | **string**<br>Name of the topic. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of the topic's partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of copies of a topic data kept in the cluster. 
topic_config | **oneof:** `topic_config_2_1`<br>User-defined settings for the topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_1)**<br>User-defined settings for the topic. 


### TopicConfig2_1 {#TopicConfig2_1}

Поле | Описание
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: This policy discards log segments when either their retention time or log size limit is reached. <br>See also: [Cluster.config.kafka.kafka_config.log_retention_ms](#Cluster2) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: This policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: This policy use both compaction and deletion for messages and log segments.</li><ul/>
compression_type | enum **CompressionType**<br>Specify the compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: No codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: The codec to use is set by a producer (can be any of ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li><ul/>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_messages](#Cluster2) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_flush_interval_ms](#Cluster2) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_bytes](#Cluster2) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [Cluster.config.kafka.kafka_config.log_retention_ms](#Cluster2) setting on the topic level. 


### UserSpec {#UserSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Name of the Apache Kafka user. false Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
password | **string**<br>Обязательное поле. Password of the Apache Kafka user. false Длина строки в символах должна быть от 8 до 128.
permissions[] | **[Permission](#Permission)**<br>Set of permissions granted to the user. 


### Permission {#Permission}

Поле | Описание
--- | ---
topic_name | **string**<br>Name of the topic that the permission grants access to. <br>To get the topic name, make a [Topic.List](#Topic) request. 
role | enum **AccessRole**<br>Access role type to grant to the user. <ul><li>`ACCESS_ROLE_PRODUCER`: Producer role for the user.</li><li>`ACCESS_ROLE_CONSUMER`: Consumer role for the user.</li><ul/>


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateClusterMetadata](#CreateClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster2)>**<br>в случае успешного выполнения операции. 


### CreateClusterMetadata {#CreateClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>ID of the Apache Kafka cluster that is being created. 


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>ID of the Apache Kafka cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Apache Kafka cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Apache Kafka cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Apache Kafka cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Apache Kafka cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Apache Kafka cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with a more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the Apache Kafka cluster. 
config | **[ConfigSpec](#ConfigSpec3)**<br>Configuration of the Apache Kafka cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


## Update {#Update}

Updates the specified Apache Kafka cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster to update. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](#List) request. false Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Apache Kafka cluster should be updated. <br>By default, this API method will replace all the values for the settings that are not present in `update_mask` list with the default ones. Pass the list of the settings to change in this parameter to prevent the method from doing so (use comma as a delimiter if you want to modify a few settings at once). 
description | **string**<br>New description of the Apache Kafka cluster. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Custom labels for the Apache Kafka cluster as `key:value` pairs. Maximum 64 per resource. <br>For example, "project": "mvp" or "source": "dictionary". <br>The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get](#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec3)**<br>New configuration and resources for hosts in the Apache Kafka cluster. <br>Use `update_mask` to prevent reverting all cluster settings that are not listed in `config_spec` to their default values. 
name | **string**<br>New name for the Apache Kafka cluster. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### ConfigSpec {#ConfigSpec}

Поле | Описание
--- | ---
version | **string**<br>Version of Apache Kafka used in the cluster. 
kafka | **[Kafka](#Kafka3)**<br>Configuration and resource allocation for Apache Kafka brokers. 
zookeeper | **[Zookeeper](#Zookeeper3)**<br>Configuration and resource allocation for ZooKeeper hosts. 
zone_id[] | **string**<br>IDs of availability zones where Apache Kafka brokers reside. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of Apache Kafka brokers deployed in each availability zone. 
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the cluster. If the value is `true`, then Apache Kafka cluster is available on the Internet via it's public IP address. 


### Kafka {#Kafka}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to Apache Kafka brokers. 
kafka_config | **oneof:** `kafka_config_2_1`<br>Apache Kafka broker configuration.
&nbsp;&nbsp;kafka_config_2_1 | **[KafkaConfig2_1](#KafkaConfig2_1)**<br>Apache Kafka broker configuration. 


### Zookeeper {#Zookeeper}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to ZooKeeper hosts. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateClusterMetadata](#UpdateClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster3)>**<br>в случае успешного выполнения операции. 


### UpdateClusterMetadata {#UpdateClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>ID of the Apache Kafka cluster that is being updated. 


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>ID of the Apache Kafka cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Apache Kafka cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Apache Kafka cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Apache Kafka cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Apache Kafka cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Apache Kafka cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with a more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the Apache Kafka cluster. 
config | **[ConfigSpec](#ConfigSpec4)**<br>Configuration of the Apache Kafka cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


## Delete {#Delete}

Deletes the specified Apache Kafka cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster to delete. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](#List) request. false Максимальная длина строки в символах — 50.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteClusterMetadata](#DeleteClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteClusterMetadata {#DeleteClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>ID of the Apache Kafka cluster that is being deleted. 


## Move {#Move}

Moves the specified Apache Kafka cluster to the specified folder.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### MoveClusterRequest {#MoveClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster to move. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](#List) request. false Максимальная длина строки в символах — 50.
destination_folder_id | **string**<br>Обязательное поле. ID of the destination folder. false Максимальная длина строки в символах — 50.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[MoveClusterMetadata](#MoveClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster4)>**<br>в случае успешного выполнения операции. 


### MoveClusterMetadata {#MoveClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>ID of the Apache Kafka cluster being moved. 
source_folder_id | **string**<br>ID of the source folder. 
destination_folder_id | **string**<br>ID of the destnation folder. 


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>ID of the Apache Kafka cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Apache Kafka cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Apache Kafka cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Apache Kafka cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Apache Kafka cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Apache Kafka cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with a more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the Apache Kafka cluster. 
config | **[ConfigSpec](#ConfigSpec4)**<br>Configuration of the Apache Kafka cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


## Start {#Start}

Starts the specified Apache Kafka cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StartClusterRequest {#StartClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster to start. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](#List) request. false Максимальная длина строки в символах — 50.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartClusterMetadata](#StartClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster5)>**<br>в случае успешного выполнения операции. 


### StartClusterMetadata {#StartClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>ID of the Apache Kafka cluster. 


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>ID of the Apache Kafka cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Apache Kafka cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Apache Kafka cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Apache Kafka cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Apache Kafka cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Apache Kafka cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with a more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the Apache Kafka cluster. 
config | **[ConfigSpec](#ConfigSpec4)**<br>Configuration of the Apache Kafka cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


## Stop {#Stop}

Stops the specified Apache Kafka cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### StopClusterRequest {#StopClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster to stop. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](#List) request. false Максимальная длина строки в символах — 50.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopClusterMetadata](#StopClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster6)>**<br>в случае успешного выполнения операции. 


### StopClusterMetadata {#StopClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>ID of the Apache Kafka cluster. 


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>ID of the Apache Kafka cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Apache Kafka cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Apache Kafka cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Apache Kafka cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Apache Kafka cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Apache Kafka cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with a more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the Apache Kafka cluster. 
config | **[ConfigSpec](#ConfigSpec4)**<br>Configuration of the Apache Kafka cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


## ListLogs {#ListLogs}

Retrieves logs for the specified Apache Kafka cluster. For more information about logs, see the [Logs](/docs/managed-kafka/operations/cluster-logs) section in the documentation.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster to request logs for. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](#List) request. false Максимальная длина строки в символах — 50.
column_filter[] | **string**<br>Columns from the logs table to request. <br>If no columns are specified, full log records are returned. 
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format. 
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. Максимальное значение — 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) returned by a previous list request. Максимальная длина строки в символах — 100.
always_next_page_token | **bool**<br>The flag that defines behavior of providing the next page token. <br>If this flag is set to `true`, this API method will always return `next_page_token`, even if current page is empty. 
filter | **string**<br><ol><li>The field name to filter by. Currently filtering can be applied to the [LogRecord.logs.message.hostname](#LogRecord) field. </li><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 1-63 characters long and match the regular expression `^[a-z0-9.-]{1,61}$`. </li></ol> Максимальная длина строки в символах — 1000.


### ListClusterLogsResponse {#ListClusterLogsResponse}

Поле | Описание
--- | ---
logs[] | **[LogRecord](#LogRecord)**<br>Requested log records. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterLogsRequest.page_size](#ListClusterLogsRequest1), use `next_page_token` as the value for the [ListClusterLogsRequest.page_token](#ListClusterLogsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. This value is interchangeable with `next_record_token` from StreamLogs method. 


### LogRecord {#LogRecord}

Поле | Описание
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log record timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format. 
message | **map<string,string>**<br>Contents of the log record. 


## StreamLogs {#StreamLogs}

Same as [ListLogs](#ListLogs) but using server-side streaming. Also allows for 'tail -f' semantics.

**rpc StreamLogs ([StreamClusterLogsRequest](#StreamClusterLogsRequest)) returns (stream [StreamLogRecord](#StreamLogRecord))**

### StreamClusterLogsRequest {#StreamClusterLogsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Kafka cluster. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](#List) request. false Максимальная длина строки в символах — 50.
column_filter[] | **string**<br>Columns from logs table to get in the response. <br>If no columns are specified, full log records are returned. 
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format. <br>If this field is not set, all existing logs will be sent and then the new ones as they appear. In essence it has 'tail -f' semantics. 
record_token | **string**<br>Record token. <br>Set `record_token` to the `next_record_token` returned by a previous [ClusterService.StreamLogs](#StreamLogs) request to start streaming from next log record. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>The field name to filter by. Currently filtering can be applied to the [LogRecord.logs.hostname](#LogRecord1) field. </li><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. </li></ol> Максимальная длина строки в символах — 1000.


### StreamLogRecord {#StreamLogRecord}

Поле | Описание
--- | ---
record | **[LogRecord](#LogRecord1)**<br>One of the requested log records. 
next_record_token | **string**<br>This token allows you to continue streaming logs starting from the exact same record. To continue streaming, specify value of `next_record_token` as value for `record_token` parameter in the next StreamLogs request. This value is interchangeable with `next_page_token` from ListLogs method. 


### LogRecord {#LogRecord}

Поле | Описание
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log record timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format. 
message | **map<string,string>**<br>Contents of the log record. 


## ListOperations {#ListOperations}

Retrieves the list of operations for the specified Apache Kafka cluster.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster to list operations for. false Максимальная длина строки в символах — 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. Максимальное значение — 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by a previous list request. Максимальная длина строки в символах — 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation6)**<br>List of operations for the specified Apache Kafka cluster. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest1), use `next_page_token` as the value for the [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`. 


## ListHosts {#ListHosts}

Retrieves a list of hosts for the specified Apache Kafka cluster.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](#List) request. false Максимальная длина строки в символах — 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. Максимальное значение — 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by a previous list request. Максимальная длина строки в символах — 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Поле | Описание
--- | ---
hosts[] | **[Host](#Host)**<br>List of hosts. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest1), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Поле | Описание
--- | ---
name | **string**<br>Name of the host. 
cluster_id | **string**<br>ID of the Apache Kafka cluster. 
zone_id | **string**<br>ID of the availability zone where the host resides. 
role | enum **Role**<br>Host role. <ul><li>`KAFKA`: The host is a Kafka broker.</li><li>`ZOOKEEPER`: The host is a ZooKeeper server.</li><ul/>
resources | **[Resources](#Resources)**<br>Resources allocated to the host. 
health | enum **Health**<br>Aggregated host health data. <ul><li>`UNKNOWN`: Health of the host is unknown.</li><li>`ALIVE`: The host is performing all its functions normally.</li><li>`DEAD`: The host is inoperable and cannot perform any of its essential functions.</li><li>`DEGRADED`: The host is degraded and can perform only some of its essential functions.</li><ul/>
subnet_id | **string**<br>ID of the subnet the host resides in. 
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the node. <br>If the value is `true`, then this node is available on the Internet via it's public IP address. 


### Resources {#Resources}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the [documentation](/docs/managed-kafka/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


