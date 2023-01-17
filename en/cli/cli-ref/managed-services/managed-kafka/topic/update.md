---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-kafka/topic/update.md
---

# yc managed-kafka topic update

Modify attributes of a Kafka topic.

#### Command Usage

Syntax: 

`yc managed-kafka topic update <TOPIC-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>Kafka cluster id.|
|`--cluster-name`|<b>`string`</b><br/>Kafka cluster name.|
|`--partitions`|<b>`int`</b><br/>Number of partitions.|
|`--replication-factor`|<b>`int`</b><br/>Replication factor.|
|`--cleanup-policy`|<b>`string`</b><br/>Allows to set topic configuration property "cleanup.policy". Possible values are: compact, delete, compact_and_delete.|
|`--compression-type`|<b>`string`</b><br/>Allows to set topic configuration property "compression.type". Possible values are: gzip, snappy, lz4, zstd, producer, uncompressed.|
|`--delete-retention-ms`|<b>`int`</b><br/>Allows to set topic configuration property "delete.retention.ms". The amount of time in milliseconds to retain delete tombstone markers for log compacted topics.|
|`--file-delete-delay-ms`|<b>`int`</b><br/>Allows to set topic configuration property "file.delete.delay.ms". The time to wait before deleting a file from the filesystem.|
|`--flush-messages`|<b>`int`</b><br/>Allows to set topic configuration property "flush.messages". The number of messages accumulated on a log partition before messages are flushed to disk.|
|`--flush-ms`|<b>`int`</b><br/>Allows to set topic configuration property "flush.ms". The maximum time in milliseconds that a message in the topic is kept in memory before flushed to disk.|
|`--min-compaction-lag-ms`|<b>`int`</b><br/>Allows to set topic configuration property "min.compaction.lag.ms". The minimum time in milliseconds a message will remain uncompacted in the log.|
|`--retention-bytes`|<b>`delete`</b><br/>Allows to set topic configuration property "retention.bytes". The maximum size a partition can grow to before Kafka will discard old log segments to free up space if the delete [cleanup_policy] is in effect. It is helpful if you need to control the size of log due to limited disk space.|
|`--retention-ms`|<b>`int`</b><br/>Allows to set topic configuration property "retention.ms". The number of milliseconds to keep a log segment's file before deleting it.|
|`--max-message-bytes`|<b>`int`</b><br/>Allows to set topic configuration property "max.message.bytes". The largest record batch size allowed in topic.|
|`--min-insync-replicas`|<b>`int`</b><br/>Allows to set topic configuration property "min.insync.replicas". This configuration specifies the minimum number of replicas that must acknowledge a write to topic for the write to be considered successful (when a producer sets acks to "all").|
|`--segment-bytes`|<b>`int`</b><br/>Allows to set topic configuration property "segment.bytes". This configuration controls the segment file size for the log. Retention and cleaning is always done a file at a time so a larger segment size means fewer files but less granular control over retention.|
|`--preallocate`|Allows to set topic configuration property "preallocate". True if we should preallocate the file on disk when creating a new log segment.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
