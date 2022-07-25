# yc managed-clickhouse cluster update-config

Update the configuration of a ClickHouse cluster.

#### Command Usage

Syntax: 

`yc managed-clickhouse cluster update-config <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> ID of the ClickHouse cluster.|
|`--name`|<b>`string`</b><br/> Name of the ClickHouse cluster.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--set`|<b>`key1=value1[,key2=value2][,"key3=val3a,val3b"]`</b><br/> Set a parameter for a ClickHouse cluster. Can be specified multiple times. Acceptable keys: log_level Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.  merge_tree.replicated_deduplication_window Number of blocks of hashes to keep in ZooKeeper.  merge_tree.replicated_deduplication_window_seconds Period of time to keep blocks of hashes for.  merge_tree.parts_to_delay_insert If table contains at least that many active parts in single partition, artificially slow down insert into table.  merge_tree.parts_to_throw_insert If more than this number active parts in single partition, throw 'Too many parts ...' exception.  merge_tree.max_replicated_merges_in_queue How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue.  merge_tree.number_of_free_entries_in_pool_to_lower_max_size_of_merge If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process.  merge_tree.max_bytes_to_merge_at_min_space_in_pool Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue).  merge_tree.max_bytes_to_merge_at_max_space_in_pool  kafka.security_protocol  kafka.sasl_mechanism  kafka.sasl_username  kafka.sasl_password  kafka_topics.name  kafka_topics.settings.security_protocol  kafka_topics.settings.sasl_mechanism  kafka_topics.settings.sasl_username  kafka_topics.settings.sasl_password  rabbitmq.username  rabbitmq.password  max_connections Maximum number of inbound connections.  max_concurrent_queries Maximum number of simultaneously processed requests.  keep_alive_timeout Number of milliseconds that ClickHouse waits for incoming requests before closing the connection.  uncompressed_cache_size Cache size (in bytes) for uncompressed data used by MergeTree tables.  mark_cache_size Approximate size (in bytes) of the cache of "marks" used by MergeTree tables.  max_table_size_to_drop Maximum size of the table that can be deleted using a DROP query.  max_partition_size_to_drop Maximum size of the partition that can be deleted using a DROP query.  builtin_dictionaries_reload_interval The setting is deprecated and has no effect.  timezone The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.  geobase_uri Address of the archive with the user geobase in Object Storage.  query_log_retention_size The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled.  query_log_retention_time The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled.  query_thread_log_enabled Whether query_thread_log system table is enabled.  query_thread_log_retention_size The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled.  query_thread_log_retention_time The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled.  part_log_retention_size The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled.  part_log_retention_time The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled.  metric_log_enabled Whether metric_log system table is enabled.  metric_log_retention_size The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled.  metric_log_retention_time The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled.  trace_log_enabled Whether trace_log system table is enabled.  trace_log_retention_size The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled.  trace_log_retention_time The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled.  text_log_enabled Whether text_log system table is enabled.  text_log_retention_size The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled.  text_log_retention_time The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled.  text_log_level Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.  background_pool_size  background_schedule_pool_size|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
