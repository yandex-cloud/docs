---
editable: false
---

# TopicService

A set of methods for managing Kafka topics.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Kafka topic. |
| [List](#List) | Retrieves the list of Kafka topics in the specified cluster. |
| [Create](#Create) | Creates a new Kafka topic in the specified cluster. |
| [Update](#Update) | Updates the specified Kafka topic. |
| [Delete](#Delete) | Deletes the specified Kafka topic. |

## Calls TopicService {#calls}

## Get {#Get}

Returns the specified Kafka topic. <br>To get the list of available Kafka topics, make a [List](#List) request.

**rpc Get ([GetTopicRequest](#GetTopicRequest)) returns ([Topic](#Topic))**

### GetTopicRequest {#GetTopicRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster that the topic belongs to. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
topic_name | **string**<br>Required. Name of the Kafka topic resource to return. <br>To get the name of the topic, make a [TopicService.List](#List) request. The string length in characters must be 1-256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Topic {#Topic}

Field | Description
--- | ---
name | **string**<br>Name of the topic. 
cluster_id | **string**<br>ID of an Apache Kafka® cluster that the topic belongs to. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of the topic's partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of data copies (replicas) for the topic in the cluster. 
topic_config | **oneof:** `topic_config_2_1`, `topic_config_2_6`, `topic_config_2_8` or `topic_config_3`<br>User-defined settings for the topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_1)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_2_6 | **[TopicConfig2_6](#TopicConfig2_6)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_2_8 | **[TopicConfig2_8](#TopicConfig2_8)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_3 | **[TopicConfig3](#TopicConfig3)**<br>User-defined settings for the topic. 


### TopicConfig2_1 {#TopicConfig2_1}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_flush_interval_messages](#KafkaConfig2_1) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_flush_interval_ms](#KafkaConfig2_1) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_retention_bytes](#KafkaConfig2_1) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_segment_bytes](#KafkaConfig2_1) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_preallocate](#KafkaConfig2_1) setting on the topic level. 


### TopicConfig2_6 {#TopicConfig2_6}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_flush_interval_messages](#KafkaConfig2_6) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_flush_interval_ms](#KafkaConfig2_6) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_retention_bytes](#KafkaConfig2_6) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_retention_ms](#KafkaConfig2_6) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_segment_bytes](#KafkaConfig2_6) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_preallocate](#KafkaConfig2_6) setting on the topic level. 


### TopicConfig2_8 {#TopicConfig2_8}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_messages](#KafkaConfig2_8) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_ms](#KafkaConfig2_8) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_retention_bytes](#KafkaConfig2_8) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_retention_ms](#KafkaConfig2_8) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_segment_bytes](#KafkaConfig2_8) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_preallocate](#KafkaConfig2_8) setting on the topic level. 


### TopicConfig3 {#TopicConfig3}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig3.log_retention_ms](#KafkaConfig3) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_messages](#KafkaConfig3) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_ms](#KafkaConfig3) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig3.log_retention_bytes](#KafkaConfig3) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig3.log_retention_ms](#KafkaConfig3) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig3.log_segment_bytes](#KafkaConfig3) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig3.log_preallocate](#KafkaConfig3) setting on the topic level. 


## List {#List}

Retrieves the list of Kafka topics in the specified cluster.

**rpc List ([ListTopicsRequest](#ListTopicsRequest)) returns ([ListTopicsResponse](#ListTopicsResponse))**

### ListTopicsRequest {#ListTopicsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to list topics in. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListTopicsResponse.next_page_token](#ListTopicsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListTopicsResponse.next_page_token](#ListTopicsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListTopicsResponse {#ListTopicsResponse}

Field | Description
--- | ---
topics[] | **[Topic](#Topic1)**<br>List of Kafka topics. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListTopicsRequest.page_size](#ListTopicsRequest), use the `next_page_token` as the value for the [ListTopicsRequest.page_token](#ListTopicsRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Topic {#Topic1}

Field | Description
--- | ---
name | **string**<br>Name of the topic. 
cluster_id | **string**<br>ID of an Apache Kafka® cluster that the topic belongs to. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of the topic's partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of data copies (replicas) for the topic in the cluster. 
topic_config | **oneof:** `topic_config_2_1`, `topic_config_2_6`, `topic_config_2_8` or `topic_config_3`<br>User-defined settings for the topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_11)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_2_6 | **[TopicConfig2_6](#TopicConfig2_61)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_2_8 | **[TopicConfig2_8](#TopicConfig2_81)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_3 | **[TopicConfig3](#TopicConfig31)**<br>User-defined settings for the topic. 


### TopicConfig2_1 {#TopicConfig2_11}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_flush_interval_messages](#KafkaConfig2_1) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_flush_interval_ms](#KafkaConfig2_1) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_retention_bytes](#KafkaConfig2_1) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_segment_bytes](#KafkaConfig2_1) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_preallocate](#KafkaConfig2_1) setting on the topic level. 


### TopicConfig2_6 {#TopicConfig2_61}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_flush_interval_messages](#KafkaConfig2_6) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_flush_interval_ms](#KafkaConfig2_6) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_retention_bytes](#KafkaConfig2_6) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_retention_ms](#KafkaConfig2_6) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_segment_bytes](#KafkaConfig2_6) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_preallocate](#KafkaConfig2_6) setting on the topic level. 


### TopicConfig2_8 {#TopicConfig2_81}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_messages](#KafkaConfig2_8) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_ms](#KafkaConfig2_8) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_retention_bytes](#KafkaConfig2_8) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_retention_ms](#KafkaConfig2_8) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_segment_bytes](#KafkaConfig2_8) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_preallocate](#KafkaConfig2_8) setting on the topic level. 


### TopicConfig3 {#TopicConfig31}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig3.log_retention_ms](#KafkaConfig3) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_messages](#KafkaConfig3) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_ms](#KafkaConfig3) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig3.log_retention_bytes](#KafkaConfig3) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig3.log_retention_ms](#KafkaConfig3) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig3.log_segment_bytes](#KafkaConfig3) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig3.log_preallocate](#KafkaConfig3) setting on the topic level. 


## Create {#Create}

Creates a new Kafka topic in the specified cluster.

**rpc Create ([CreateTopicRequest](#CreateTopicRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateTopicMetadata](#CreateTopicMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Topic](#Topic2)<br>

### CreateTopicRequest {#CreateTopicRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to create a topic in. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
topic_spec | **[TopicSpec](#TopicSpec)**<br>Required. Configuration of the topic to create. 


### TopicSpec {#TopicSpec}

Field | Description
--- | ---
name | **string**<br>Name of the topic. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of the topic's partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of copies of a topic data kept in the cluster. 
topic_config | **oneof:** `topic_config_2_1`, `topic_config_2_6`, `topic_config_2_8` or `topic_config_3`<br>User-defined settings for the topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_12)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_2_6 | **[TopicConfig2_6](#TopicConfig2_62)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_2_8 | **[TopicConfig2_8](#TopicConfig2_82)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_3 | **[TopicConfig3](#TopicConfig32)**<br>User-defined settings for the topic. 


### TopicConfig2_1 {#TopicConfig2_12}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_flush_interval_messages](#KafkaConfig2_1) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_flush_interval_ms](#KafkaConfig2_1) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_retention_bytes](#KafkaConfig2_1) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_segment_bytes](#KafkaConfig2_1) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_preallocate](#KafkaConfig2_1) setting on the topic level. 


### TopicConfig2_6 {#TopicConfig2_62}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_flush_interval_messages](#KafkaConfig2_6) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_flush_interval_ms](#KafkaConfig2_6) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_retention_bytes](#KafkaConfig2_6) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_retention_ms](#KafkaConfig2_6) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_segment_bytes](#KafkaConfig2_6) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_preallocate](#KafkaConfig2_6) setting on the topic level. 


### TopicConfig2_8 {#TopicConfig2_82}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_messages](#KafkaConfig2_8) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_ms](#KafkaConfig2_8) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_retention_bytes](#KafkaConfig2_8) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_retention_ms](#KafkaConfig2_8) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_segment_bytes](#KafkaConfig2_8) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_preallocate](#KafkaConfig2_8) setting on the topic level. 


### TopicConfig3 {#TopicConfig32}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig3.log_retention_ms](#KafkaConfig3) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_messages](#KafkaConfig3) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_ms](#KafkaConfig3) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig3.log_retention_bytes](#KafkaConfig3) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig3.log_retention_ms](#KafkaConfig3) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig3.log_segment_bytes](#KafkaConfig3) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig3.log_preallocate](#KafkaConfig3) setting on the topic level. 


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
cluster_id | **string**<br>ID of the Apache Kafka® cluster where a topic is being created. 
topic_name | **string**<br>Required. Name of the Kafka topic that is being created. The maximum string length in characters is 256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Topic {#Topic2}

Field | Description
--- | ---
name | **string**<br>Name of the topic. 
cluster_id | **string**<br>ID of an Apache Kafka® cluster that the topic belongs to. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of the topic's partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of data copies (replicas) for the topic in the cluster. 
topic_config | **oneof:** `topic_config_2_1`, `topic_config_2_6`, `topic_config_2_8` or `topic_config_3`<br>User-defined settings for the topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_13)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_2_6 | **[TopicConfig2_6](#TopicConfig2_63)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_2_8 | **[TopicConfig2_8](#TopicConfig2_83)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_3 | **[TopicConfig3](#TopicConfig33)**<br>User-defined settings for the topic. 


### TopicConfig2_1 {#TopicConfig2_13}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_flush_interval_messages](#KafkaConfig2_1) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_flush_interval_ms](#KafkaConfig2_1) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_retention_bytes](#KafkaConfig2_1) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_segment_bytes](#KafkaConfig2_1) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_preallocate](#KafkaConfig2_1) setting on the topic level. 


### TopicConfig2_6 {#TopicConfig2_63}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_flush_interval_messages](#KafkaConfig2_6) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_flush_interval_ms](#KafkaConfig2_6) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_retention_bytes](#KafkaConfig2_6) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_retention_ms](#KafkaConfig2_6) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_segment_bytes](#KafkaConfig2_6) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_preallocate](#KafkaConfig2_6) setting on the topic level. 


### TopicConfig2_8 {#TopicConfig2_83}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_messages](#KafkaConfig2_8) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_ms](#KafkaConfig2_8) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_retention_bytes](#KafkaConfig2_8) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_retention_ms](#KafkaConfig2_8) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_segment_bytes](#KafkaConfig2_8) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_preallocate](#KafkaConfig2_8) setting on the topic level. 


### TopicConfig3 {#TopicConfig33}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig3.log_retention_ms](#KafkaConfig3) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_messages](#KafkaConfig3) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_ms](#KafkaConfig3) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig3.log_retention_bytes](#KafkaConfig3) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig3.log_retention_ms](#KafkaConfig3) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig3.log_segment_bytes](#KafkaConfig3) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig3.log_preallocate](#KafkaConfig3) setting on the topic level. 


## Update {#Update}

Updates the specified Kafka topic.

**rpc Update ([UpdateTopicRequest](#UpdateTopicRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateTopicMetadata](#UpdateTopicMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Topic](#Topic3)<br>

### UpdateTopicRequest {#UpdateTopicRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to update a topic in. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
topic_name | **string**<br>Required. Name of the topic to update. <br>To get the name of the topic, make a [TopicService.List](#List) request. The string length in characters must be 1-256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
topic_spec | **[TopicSpec](#TopicSpec1)**<br>New configuration of the topic. <br>Use `update_mask` to prevent reverting all topic settings that are not listed in `topic_spec` to their default values. 


### TopicSpec {#TopicSpec1}

Field | Description
--- | ---
name | **string**<br>Name of the topic. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of the topic's partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of copies of a topic data kept in the cluster. 
topic_config | **oneof:** `topic_config_2_1`, `topic_config_2_6`, `topic_config_2_8` or `topic_config_3`<br>User-defined settings for the topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_14)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_2_6 | **[TopicConfig2_6](#TopicConfig2_64)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_2_8 | **[TopicConfig2_8](#TopicConfig2_84)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_3 | **[TopicConfig3](#TopicConfig34)**<br>User-defined settings for the topic. 


### TopicConfig2_1 {#TopicConfig2_14}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_flush_interval_messages](#KafkaConfig2_1) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_flush_interval_ms](#KafkaConfig2_1) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_retention_bytes](#KafkaConfig2_1) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_segment_bytes](#KafkaConfig2_1) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_preallocate](#KafkaConfig2_1) setting on the topic level. 


### TopicConfig2_6 {#TopicConfig2_64}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_flush_interval_messages](#KafkaConfig2_6) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_flush_interval_ms](#KafkaConfig2_6) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_retention_bytes](#KafkaConfig2_6) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_retention_ms](#KafkaConfig2_6) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_segment_bytes](#KafkaConfig2_6) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_preallocate](#KafkaConfig2_6) setting on the topic level. 


### TopicConfig2_8 {#TopicConfig2_84}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_messages](#KafkaConfig2_8) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_ms](#KafkaConfig2_8) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_retention_bytes](#KafkaConfig2_8) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_retention_ms](#KafkaConfig2_8) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_segment_bytes](#KafkaConfig2_8) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_preallocate](#KafkaConfig2_8) setting on the topic level. 


### TopicConfig3 {#TopicConfig34}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig3.log_retention_ms](#KafkaConfig3) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_messages](#KafkaConfig3) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_ms](#KafkaConfig3) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig3.log_retention_bytes](#KafkaConfig3) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig3.log_retention_ms](#KafkaConfig3) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig3.log_segment_bytes](#KafkaConfig3) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig3.log_preallocate](#KafkaConfig3) setting on the topic level. 


### Operation {#Operation1}

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
cluster_id | **string**<br>ID of the Apache Kafka® cluster where a topic is being updated. 
topic_name | **string**<br>Name of the Kafka topic that is being updated. 


### Topic {#Topic3}

Field | Description
--- | ---
name | **string**<br>Name of the topic. 
cluster_id | **string**<br>ID of an Apache Kafka® cluster that the topic belongs to. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of the topic's partitions. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Amount of data copies (replicas) for the topic in the cluster. 
topic_config | **oneof:** `topic_config_2_1`, `topic_config_2_6`, `topic_config_2_8` or `topic_config_3`<br>User-defined settings for the topic.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_15)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_2_6 | **[TopicConfig2_6](#TopicConfig2_65)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_2_8 | **[TopicConfig2_8](#TopicConfig2_85)**<br>User-defined settings for the topic. 
&nbsp;&nbsp;topic_config_3 | **[TopicConfig3](#TopicConfig35)**<br>User-defined settings for the topic. 


### TopicConfig2_1 {#TopicConfig2_15}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_flush_interval_messages](#KafkaConfig2_1) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_flush_interval_ms](#KafkaConfig2_1) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_retention_bytes](#KafkaConfig2_1) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_segment_bytes](#KafkaConfig2_1) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_1.log_preallocate](#KafkaConfig2_1) setting on the topic level. 


### TopicConfig2_6 {#TopicConfig2_65}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_flush_interval_messages](#KafkaConfig2_6) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_flush_interval_ms](#KafkaConfig2_6) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_retention_bytes](#KafkaConfig2_6) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_retention_ms](#KafkaConfig2_6) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_segment_bytes](#KafkaConfig2_6) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_6.log_preallocate](#KafkaConfig2_6) setting on the topic level. 


### TopicConfig2_8 {#TopicConfig2_85}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_messages](#KafkaConfig2_8) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_flush_interval_ms](#KafkaConfig2_8) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_retention_bytes](#KafkaConfig2_8) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_retention_ms](#KafkaConfig2_8) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_segment_bytes](#KafkaConfig2_8) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig2_8.log_preallocate](#KafkaConfig2_8) setting on the topic level. 


### TopicConfig3 {#TopicConfig35}

Field | Description
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Retention policy to use on old log messages. <ul><li>`CLEANUP_POLICY_DELETE`: this policy discards log segments when either their retention time or log size limit is reached. See also: [KafkaConfig3.log_retention_ms](#KafkaConfig3) and other similar parameters.</li><li>`CLEANUP_POLICY_COMPACT`: this policy compacts messages in log.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: this policy use both compaction and deletion for messages and log segments.</li></ul>
compression_type | enum **CompressionType**<br>The compression type for a given topic. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: no codec (uncompressed).</li><li>`COMPRESSION_TYPE_ZSTD`: Zstandard codec.</li><li>`COMPRESSION_TYPE_LZ4`: LZ4 codec.</li><li>`COMPRESSION_TYPE_SNAPPY`: Snappy codec.</li><li>`COMPRESSION_TYPE_GZIP`: GZip codec.</li><li>`COMPRESSION_TYPE_PRODUCER`: the codec to use is set by a producer (can be any of `ZSTD`, `LZ4`, `GZIP` or `SNAPPY` codecs).</li></ul>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The time to wait before deleting a file from the filesystem. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of messages accumulated on a log partition before messages are flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_messages](#KafkaConfig3) setting on the topic level. 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk. <br>This setting overrides the cluster-level [KafkaConfig3.log_flush_interval_ms](#KafkaConfig3) setting on the topic level. 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum time in milliseconds a message will remain uncompacted in the log. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the `delete` `cleanup_policy` is in effect. It is helpful if you need to control the size of log due to limited disk space. <br>This setting overrides the cluster-level [KafkaConfig3.log_retention_bytes](#KafkaConfig3) setting on the topic level. 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of milliseconds to keep a log segment's file before deleting it. <br>This setting overrides the cluster-level [KafkaConfig3.log_retention_ms](#KafkaConfig3) setting on the topic level. 
max_message_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The largest record batch size allowed in topic. 
min_insync_replicas | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all"). 
segment_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention. <br>This setting overrides the cluster-level [KafkaConfig3.log_segment_bytes](#KafkaConfig3) setting on the topic level. 
preallocate | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>True if we should preallocate the file on disk when creating a new log segment. <br>This setting overrides the cluster-level [KafkaConfig3.log_preallocate](#KafkaConfig3) setting on the topic level. 


## Delete {#Delete}

Deletes the specified Kafka topic.

**rpc Delete ([DeleteTopicRequest](#DeleteTopicRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteTopicMetadata](#DeleteTopicMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteTopicRequest {#DeleteTopicRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to delete a topic in. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
topic_name | **string**<br>Required. Name of the topic to delete. <br>To get the name of the topic, make a [TopicService.List](#List) request. The string length in characters must be 1-256. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation2}

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
cluster_id | **string**<br>ID of the Apache Kafka® cluster where a topic is being deleted. 
topic_name | **string**<br>Name of the Kafka topic that is being deleted. 


