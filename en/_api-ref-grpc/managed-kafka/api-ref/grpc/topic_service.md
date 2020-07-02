---
editable: false
---

# TopicService

A set of methods for managing Apache Kafka Topic resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Apache Kafka Topic resource. |
| [List](#List) | Retrieves the list of Apache Kafka Topic resources in the specified cluster. |
| [Create](#Create) | Creates a new Apache Kafka topic in the specified cluster. |
| [Update](#Update) | Updates the specified Apache Kafka topic. |
| [Delete](#Delete) | Deletes the specified Apache Kafka topic. |

## Calls TopicService {#calls}

## Get {#Get}

Returns the specified Apache Kafka Topic resource. <br>To get the list of available Apache Kafka Topic resources, make a [List](#List) request.

**rpc Get ([GetTopicRequest](#GetTopicRequest)) returns ([Topic](#Topic))**

### GetTopicRequest {#GetTopicRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka cluster that the topic belongs to. To get the cluster ID use a [ClusterService.List](./cluster_service#List) request. false The maximum string length in characters is 50.
topic_name | **string**<br>Required. Name of the Apache Kafka Topic resource to return. To get the name of the topic use a [TopicService.List](#List) request. false The string length in characters must be 1-63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Topic {#Topic}

Field | Description
--- | ---
name | **string**<br>Name of the topic. 
cluster_id | **string**<br>ID of the Apache Kafka cluster that the topic belongs to. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of topic partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of copies of a topic data kept in a cluster. 
topic_config | **oneof:** `topic_config_2_1`<br>User-defined settings for a topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_1)**<br>User-defined settings for a topic. 


### TopicConfig2_1 {#TopicConfig2_1}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log segments. <ul><ul/>
compression_type | enum **CompressionType**<br>Specify the final compression type for a given topic. <ul><ul/>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This setting allows specifying an interval at which we will force an fsync of data written to the log 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This setting allows specifying a time interval at which we will force an fsync of data written to the log 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the maximum size a partition (which consists of log segments) can grow to before we will discard old log segments to free up space if we are using the "delete" retention policy 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the maximum time we will retain a log before we will discard old log segments to free up space if we are using the "delete" retention policy. 


## List {#List}

Retrieves the list of Apache Kafka Topic resources in the specified cluster.

**rpc List ([ListTopicsRequest](#ListTopicsRequest)) returns ([ListTopicsResponse](#ListTopicsResponse))**

### ListTopicsRequest {#ListTopicsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka cluster to list topics in. To get the cluster ID use a [ClusterService.List](./cluster_service#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListTopicsResponse.next_page_token](#ListTopicsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, Set `page_token` to the [ListTopicsResponse.next_page_token](#ListTopicsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListTopicsResponse {#ListTopicsResponse}

Field | Description
--- | ---
topics[] | **[Topic](#Topic1)**<br>List of Apache Kafka Topic resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListTopicsRequest.page_size](#ListTopicsRequest1), use the `next_page_token` as the value for the [ListTopicsRequest.page_token](#ListTopicsRequest1) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Topic {#Topic}

Field | Description
--- | ---
name | **string**<br>Name of the topic. 
cluster_id | **string**<br>ID of the Apache Kafka cluster that the topic belongs to. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of topic partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of copies of a topic data kept in a cluster. 
topic_config | **oneof:** `topic_config_2_1`<br>User-defined settings for a topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_11)**<br>User-defined settings for a topic. 


### TopicConfig2_1 {#TopicConfig2_1}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log segments. <ul><ul/>
compression_type | enum **CompressionType**<br>Specify the final compression type for a given topic. <ul><ul/>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This setting allows specifying an interval at which we will force an fsync of data written to the log 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This setting allows specifying a time interval at which we will force an fsync of data written to the log 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the maximum size a partition (which consists of log segments) can grow to before we will discard old log segments to free up space if we are using the "delete" retention policy 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the maximum time we will retain a log before we will discard old log segments to free up space if we are using the "delete" retention policy. 


## Create {#Create}

Creates a new Apache Kafka topic in the specified cluster.

**rpc Create ([CreateTopicRequest](#CreateTopicRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateTopicMetadata](#CreateTopicMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Topic](#Topic2)<br>

### CreateTopicRequest {#CreateTopicRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the Apache Kafka cluster to create a topic in. To get the cluster ID use a [ClusterService.List](./cluster_service#List) request. false The maximum string length in characters is 50.
topic_spec | **[TopicSpec](#TopicSpec)**<br>Required. Required. Configuration of the topic to create. false


### TopicSpec {#TopicSpec}

Field | Description
--- | ---
name | **string**<br>Name of the topic. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of topic partitions 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of copies of a topic data kept in a cluster. 
topic_config | **oneof:** `topic_config_2_1`<br>User-defined settings for a topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_12)**<br>User-defined settings for a topic. 


### TopicConfig2_1 {#TopicConfig2_1}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log segments. <ul><ul/>
compression_type | enum **CompressionType**<br>Specify the final compression type for a given topic. <ul><ul/>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This setting allows specifying an interval at which we will force an fsync of data written to the log 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This setting allows specifying a time interval at which we will force an fsync of data written to the log 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the maximum size a partition (which consists of log segments) can grow to before we will discard old log segments to free up space if we are using the "delete" retention policy 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the maximum time we will retain a log before we will discard old log segments to free up space if we are using the "delete" retention policy. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateTopicMetadata](#CreateTopicMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Topic](#Topic2)>**<br>if operation finished successfully. 


### CreateTopicMetadata {#CreateTopicMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Apache Kafka cluster where a topic is being created. 
topic_name | **string**<br>Required. Name of the Apache Kafka topic that is being created. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Topic {#Topic}

Field | Description
--- | ---
name | **string**<br>Name of the topic. 
cluster_id | **string**<br>ID of the Apache Kafka cluster that the topic belongs to. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of topic partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of copies of a topic data kept in a cluster. 
topic_config | **oneof:** `topic_config_2_1`<br>User-defined settings for a topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_13)**<br>User-defined settings for a topic. 


## Update {#Update}

Updates the specified Apache Kafka topic.

**rpc Update ([UpdateTopicRequest](#UpdateTopicRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateTopicMetadata](#UpdateTopicMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Topic](#Topic3)<br>

### UpdateTopicRequest {#UpdateTopicRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the Apache Kafka cluster to update a topic in. To get the cluster ID use a [ClusterService.List](./cluster_service#List) request. false The maximum string length in characters is 50.
topic_name | **string**<br>Required. Required. Name of the topic to update. To get the name of the topic use a [TopicService.List](#List) request. false The string length in characters must be 1-63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Topic resource should be updated. 
topic_spec | **[TopicSpec](#TopicSpec1)**<br>Required. Configuration of the topic to create. 


### TopicSpec {#TopicSpec}

Field | Description
--- | ---
name | **string**<br>Name of the topic. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of topic partitions 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of copies of a topic data kept in a cluster. 
topic_config | **oneof:** `topic_config_2_1`<br>User-defined settings for a topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_13)**<br>User-defined settings for a topic. 


### TopicConfig2_1 {#TopicConfig2_1}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log segments. <ul><ul/>
compression_type | enum **CompressionType**<br>Specify the final compression type for a given topic. <ul><ul/>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This setting allows specifying an interval at which we will force an fsync of data written to the log 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This setting allows specifying a time interval at which we will force an fsync of data written to the log 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the maximum size a partition (which consists of log segments) can grow to before we will discard old log segments to free up space if we are using the "delete" retention policy 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the maximum time we will retain a log before we will discard old log segments to free up space if we are using the "delete" retention policy. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateTopicMetadata](#UpdateTopicMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Topic](#Topic3)>**<br>if operation finished successfully. 


### UpdateTopicMetadata {#UpdateTopicMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Apache Kafka cluster where a topic is being updated. 
topic_name | **string**<br>Name of the Apache Kafka topic that is being updated. 


### Topic {#Topic}

Field | Description
--- | ---
name | **string**<br>Name of the topic. 
cluster_id | **string**<br>ID of the Apache Kafka cluster that the topic belongs to. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of topic partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of copies of a topic data kept in a cluster. 
topic_config | **oneof:** `topic_config_2_1`<br>User-defined settings for a topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_14)**<br>User-defined settings for a topic. 


## Delete {#Delete}

Deletes the specified Apache Kafka topic.

**rpc Delete ([DeleteTopicRequest](#DeleteTopicRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteTopicMetadata](#DeleteTopicMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteTopicRequest {#DeleteTopicRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the Apache Kafka cluster to delete a topic in. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. false The maximum string length in characters is 50.
topic_name | **string**<br>Required. Required. Name of the topic to delete. To get the name of the topic, use a [TopicService.List](#List) request. false The string length in characters must be 1-63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteTopicMetadata](#DeleteTopicMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteTopicMetadata {#DeleteTopicMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Apache Kafka cluster where a topic is being deleted. 
topic_name | **string**<br>Name of the Apache Kafka topic that is being deleted. 


