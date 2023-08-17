---
editable: false
sourcePath: en/_api-ref-grpc/managed-clickhouse/api-ref/grpc/cluster_service.md
---

# Managed Service for ClickHouse API, gRPC: ClusterService

A set of methods for managing ClickHouse clusters.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified ClickHouse cluster. |
| [List](#List) | Retrieves a list of ClickHouse clusters that belong to the specified folder. |
| [Create](#Create) | Creates a ClickHouse cluster in the specified folder. |
| [Update](#Update) | Updates the specified ClickHouse cluster. |
| [Delete](#Delete) | Deletes the specified ClickHouse cluster. |
| [Start](#Start) | Starts the specified ClickHouse cluster. |
| [Stop](#Stop) | Stops the specified ClickHouse cluster. |
| [Move](#Move) | Moves a ClickHouse cluster to the specified folder. |
| [AddZookeeper](#AddZookeeper) | Adds a ZooKeeper subcluster to the specified ClickHouse cluster. |
| [Backup](#Backup) | Creates a backup for the specified ClickHouse cluster. |
| [Restore](#Restore) | Creates a new ClickHouse cluster using the specified backup. |
| [RescheduleMaintenance](#RescheduleMaintenance) | Reschedules planned maintenance operation. |
| [ListLogs](#ListLogs) | Retrieves logs for the specified ClickHouse cluster. |
| [StreamLogs](#StreamLogs) | Same as ListLogs but using server-side streaming. |
| [ListOperations](#ListOperations) | Retrieves the list of Operation resources for the specified cluster. |
| [ListBackups](#ListBackups) | Retrieves the list of available backups for the specified ClickHouse cluster. |
| [ListHosts](#ListHosts) | Retrieves a list of hosts for the specified cluster. |
| [AddHosts](#AddHosts) | Creates new hosts for a cluster. |
| [UpdateHosts](#UpdateHosts) | Updates the specified hosts. |
| [DeleteHosts](#DeleteHosts) | Deletes the specified hosts for a cluster. |
| [GetShard](#GetShard) | Returns the specified shard. |
| [ListShards](#ListShards) | Retrieves a list of shards that belong to the specified cluster. |
| [AddShard](#AddShard) | Creates a new shard in the specified cluster. |
| [UpdateShard](#UpdateShard) | Modifies the specified shard. |
| [DeleteShard](#DeleteShard) | Deletes the specified shard. |
| [GetShardGroup](#GetShardGroup) | Returns the specified shard group. |
| [ListShardGroups](#ListShardGroups) | Retrieves a list of shard groups that belong to specified cluster. |
| [CreateShardGroup](#CreateShardGroup) | Creates a new shard group in the specified cluster. |
| [UpdateShardGroup](#UpdateShardGroup) | Updates the specified shard group. |
| [DeleteShardGroup](#DeleteShardGroup) | Deletes the specified shard group. |
| [ListExternalDictionaries](#ListExternalDictionaries) | Retrieves a list of external dictionaries that belong to specified cluster. |
| [CreateExternalDictionary](#CreateExternalDictionary) | Creates an external dictionary for the specified ClickHouse cluster. |
| [UpdateExternalDictionary](#UpdateExternalDictionary) | Updates an external dictionary for the specified ClickHouse cluster. |
| [DeleteExternalDictionary](#DeleteExternalDictionary) | Deletes the specified external dictionary. |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified ClickHouse cluster. <br>To get the list of available ClickHouse clusters, make a [List](#List) request.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse Cluster resource to return. To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the ClickHouse cluster. 


### ClusterConfig {#ClusterConfig}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse)**<br>Configuration and resource allocation for ClickHouse hosts. 
zookeeper | **[Zookeeper](#Zookeeper)**<br>Configuration and resource allocation for ZooKeeper hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access)**<br>Access policy for external services. 
cloud_storage | **[CloudStorage](#CloudStorage)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper. 


### Clickhouse {#Clickhouse}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet)**<br>Configuration settings of a ClickHouse server. 
resources | **[Resources](#Resources)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper}

Field | Description
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to ZooKeeper hosts. 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. 
metrika | **bool**<br>Allow to import data from Yandex Metrica and AppMetrica to the cluster. <br>See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. 
serverless | **bool**<br>Allow access to cluster for Serverless. 
data_transfer | **bool**<br>Allow access for DataTransfer 
yandex_query | **bool**<br>Allow access for Query 


### CloudStorage {#CloudStorage}

Field | Description
--- | ---
enabled | **bool**<br>Whether to use Object Storage for storing ClickHouse data. 
move_factor | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> Acceptable values are 0 to 1, inclusive.
data_cache_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
data_cache_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### ClickhouseConfigSet {#ClickhouseConfigSet}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka)**<br>Required.  


### Rabbitmq {#Rabbitmq}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure}

Field | Description
--- | ---
id | **[Id](#Id)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### MaintenanceWindow {#MaintenanceWindow}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week (in `DDD` format). 
hour | **int64**<br>Hour of the day in UTC (in `HH` format). Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## List {#List}

Retrieves a list of ClickHouse clusters that belong to the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list ClickHouse clusters in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by the previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can only use filtering with the [Cluster.name](#Cluster1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`.</li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of ClickHouse Cluster resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster1}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow1)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation1)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring1}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the ClickHouse cluster. 


### ClusterConfig {#ClusterConfig1}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse1)**<br>Configuration and resource allocation for ClickHouse hosts. 
zookeeper | **[Zookeeper](#Zookeeper1)**<br>Configuration and resource allocation for ZooKeeper hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access1)**<br>Access policy for external services. 
cloud_storage | **[CloudStorage](#CloudStorage1)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper. 


### Clickhouse {#Clickhouse1}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet1)**<br>Configuration settings of a ClickHouse server. 
resources | **[Resources](#Resources1)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper1}

Field | Description
--- | ---
resources | **[Resources](#Resources1)**<br>Resources allocated to ZooKeeper hosts. 


### Access {#Access1}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. 
metrika | **bool**<br>Allow to import data from Yandex Metrica and AppMetrica to the cluster. <br>See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. 
serverless | **bool**<br>Allow access to cluster for Serverless. 
data_transfer | **bool**<br>Allow access for DataTransfer 
yandex_query | **bool**<br>Allow access for Query 


### CloudStorage {#CloudStorage1}

Field | Description
--- | ---
enabled | **bool**<br>Whether to use Object Storage for storing ClickHouse data. 
move_factor | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> Acceptable values are 0 to 1, inclusive.
data_cache_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
data_cache_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### ClickhouseConfigSet {#ClickhouseConfigSet1}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig1)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig1)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig1)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig1}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree1)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression1)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary1)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup1)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka1)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic1)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq1)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree1}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka1}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic1}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka1)**<br>Required.  


### Rabbitmq {#Rabbitmq1}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression1}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure1)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout1)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range1)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource1)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource1)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource1)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource1)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource1)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource1}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource1}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica1)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica1}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource1}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource1}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource1}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure1}

Field | Description
--- | ---
id | **[Id](#Id1)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key1)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute1)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute1)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute1)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key1}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute1)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout1}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range1}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup1}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern1)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern1}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention1)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention1}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources1}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### MaintenanceWindow {#MaintenanceWindow1}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow1)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow1)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow1}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow1}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week (in `DDD` format). 
hour | **int64**<br>Hour of the day in UTC (in `HH` format). Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation1}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## Create {#Create}

Creates a ClickHouse cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create the ClickHouse cluster in. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the ClickHouse cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the ClickHouse cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Required. Deployment environment of the ClickHouse cluster. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Required. Configuration and resources for hosts that should be created for the ClickHouse cluster. 
database_specs[] | **[DatabaseSpec](#DatabaseSpec)**<br>Descriptions of databases to be created in the ClickHouse cluster. The number of elements must be greater than 0.
user_specs[] | **[UserSpec](#UserSpec)**<br>Descriptions of database users to be created in the ClickHouse cluster. The number of elements must be greater than 0.
host_specs[] | **[HostSpec](#HostSpec)**<br>Individual configurations for hosts that should be created for the ClickHouse cluster. The number of elements must be greater than 0.
network_id | **string**<br>Required. ID of the network to create the cluster in. The maximum string length in characters is 50.
shard_name | **string**<br>Name of the first shard in cluster. If not set, defaults to the value 'shard1'. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow2)**<br>Window of maintenance operations. 


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse2)**<br>Configuration and resources for a ClickHouse server. 
zookeeper | **[Zookeeper](#Zookeeper2)**<br>Configuration and resources for a ZooKeeper server. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access2)**<br>Access policy for external services. <br>If you want a specific service to access the ClickHouse cluster, then set the necessary values in this policy. 
cloud_storage | **[CloudStorage](#CloudStorage2)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
admin_password | **string**<br>Password for user 'admin' that has SQL user management access. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper 


### Clickhouse {#Clickhouse2}

Field | Description
--- | ---
config | **[config.ClickhouseConfig](#ClickhouseConfig2)**<br>Configuration for a ClickHouse server. 
resources | **[Resources](#Resources2)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper2}

Field | Description
--- | ---
resources | **[Resources](#Resources2)**<br>Resources allocated to ZooKeeper hosts. If not set, minimal available resources will be used. All available resource presets can be retrieved with a [ResourcePresetService.List](./resource_preset_service#List) request. 


### Access {#Access2}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. 
metrika | **bool**<br>Allow to import data from Yandex Metrica and AppMetrica to the cluster. <br>See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. 
serverless | **bool**<br>Allow access to cluster for Serverless. 
data_transfer | **bool**<br>Allow access for DataTransfer 
yandex_query | **bool**<br>Allow access for Query 


### CloudStorage {#CloudStorage2}

Field | Description
--- | ---
enabled | **bool**<br>Whether to use Object Storage for storing ClickHouse data. 
move_factor | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> Acceptable values are 0 to 1, inclusive.
data_cache_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
data_cache_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### ClickhouseConfig {#ClickhouseConfig2}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree2)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression2)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary2)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup2)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka2)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic2)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq2)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree2}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka2}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic2}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka2)**<br>Required.  


### Rabbitmq {#Rabbitmq2}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression2}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary2}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure2)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout2)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range2)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource2)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource2)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource2)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource2)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource2)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource2}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource2}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica2)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica2}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource2}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource2}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource2}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure2}

Field | Description
--- | ---
id | **[Id](#Id2)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key2)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute2)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute2)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute2)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute2}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id2}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key2}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute2)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout2}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range2}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup2}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern2)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern2}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention2)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention2}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources2}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### DatabaseSpec {#DatabaseSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the ClickHouse database. 1-63 characters long. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the ClickHouse user. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Required. Password of the ClickHouse user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission)**<br>Set of permissions to grant to the user. If not set, it's granted permissions to access all databases. 
settings | **[UserSettings](#UserSettings)**<br> 
quotas[] | **[UserQuota](#UserQuota)**<br>Set of quotas assigned to the user. 


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 


### UserSettings {#UserSettings}

Field | Description
--- | ---
readonly | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Restricts permissions for non-DDL queries. To restrict permissions for DDL queries, use `allow_ddl` instead. <ul><li>**0** (default)-no restrictions. </li><li>**1**-only read data queries are allowed. </li><li>**2**-read data and change settings queries are allowed. </li></ul><br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_readonly). Acceptable values are 0 to 2, inclusive.
allow_ddl | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether DDL queries are allowed (e.g., **CREATE**, **ALTER**, **RENAME**, etc). <br>Default value: **true**. <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_allow_ddl). 
allow_introspection_functions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables [introspections functions](https://clickhouse.com/docs/en/sql-reference/functions/introspection) for query profiling. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-allow_introspection_functions). 
connect_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Connection timeout in milliseconds. <br>Value must be greater than **0** (default: **10000**, 10 seconds). Value must be greater than 0.
connect_timeout_with_failover | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The timeout in milliseconds for connecting to a remote server for a Distributed table engine. Applies only if the cluster uses sharding and replication. If unsuccessful, several attempts are made to connect to various replicas. <br>Default value: **50**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#connect-timeout-with-failover-ms). Value must be greater than 0.
receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Receive timeout in milliseconds. <br>Value must be greater than **0** (default: **300000**, 300 seconds or 5 minutes). Value must be greater than 0.
send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Send timeout in milliseconds. <br>Value must be greater than **0** (default: **300000**, 300 seconds or 5 minutes). Value must be greater than 0.
timeout_before_checking_execution_speed | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Timeout (in seconds) between checks of execution speed. It is checked that execution speed is not less that specified in `min_execution_speed` parameter. <br>Default value: **10**. 
insert_quorum | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Enables or disables write quorum for ClickHouse cluster. If the value is less than **2**, then write quorum is disabled, otherwise it is enabled. <br>When used, write quorum guarantees that ClickHouse has written data to the quorum of **insert_quorum** replicas with no errors until the `insert_quorum_timeout` expires. All replicas in the quorum are in the consistent state, meaning that they contain linearized data from the previous **INSERT** queries. Employ write quorum, if you need the guarantees that the written data would not be lost in case of one or more replicas failure. <br>You can use `select_sequential_consistency` setting to read the data written with write quorum. <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum). The minimum value is 0.
insert_quorum_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Quorum write timeout in milliseconds. <br>If the write quorum is enabled in the cluster, this timeout expires and some data is not written to the `insert_quorum` replicas, then ClickHouse will abort the execution of **INSERT** query and return an error. In this case, the client must send the query again to write the data block into the same or another replica. <br>Minimum value: **1000**, 1 second (default: **60000**, 1 minute). The minimum value is 1000.
insert_quorum_parallel | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum_parallel). 
insert_null_as_default | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables the insertion of default values instead of NULL into columns with not nullable data type. <br>Default value: **true**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#insert_null_as_default). 
select_sequential_consistency | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines the behavior of **SELECT** queries from the replicated table: if enabled, ClickHouse will terminate a query with error message in case the replica does not have a chunk written with the quorum and will not read the parts that have not yet been written with the quorum. <br>Default value: **false** (sequential consistency is disabled). 
deduplicate_blocks_in_dependent_materialized_views | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-deduplicate-blocks-in-dependent-materialized-views). 
replication_alter_partitions_sync | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Wait mode for asynchronous actions in **ALTER** queries on replicated tables: <br><ul><li>**0**-do not wait for replicas. </li><li>**1**-only wait for own execution (default). </li><li>**2**-wait for all replicas. </li></ul><br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/alter/#synchronicity-of-alter-queries). Acceptable values are 0 to 2, inclusive.
max_replica_delay_for_distributed_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used and becomes a stale one. <br>Minimum value: **1000**, 1 second (default: **300000**, 300 seconds or 5 minutes). <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries). The minimum value is 1000.
fallback_to_stale_replicas_for_distributed_queries | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables query forcing to a stale replica in case the actual data is unavailable. If enabled, ClickHouse will choose the most up-to-date replica and force the query to use the data in this replica. This setting can be used when doing **SELECT** query from a distributed table that points to replicated tables. <br>Default value: **true** (query forcing is enabled). <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries). 
distributed_product_mode | enum **DistributedProductMode**<br>Determine the behavior of distributed subqueries. <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#distributed-product-mode). <ul><li>`DISTRIBUTED_PRODUCT_MODE_DENY`: Default value. Prohibits using these types of subqueries (returns the "Double-distributed in/JOIN subqueries is denied" exception).</li><li>`DISTRIBUTED_PRODUCT_MODE_LOCAL`: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal IN/JOIN.</li><li>`DISTRIBUTED_PRODUCT_MODE_GLOBAL`: Replaces the IN/JOIN query with GLOBAL IN/GLOBAL JOIN.</li><li>`DISTRIBUTED_PRODUCT_MODE_ALLOW`: Allows the use of these types of subqueries.</li></ul>
distributed_aggregation_memory_efficient | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables of disables memory saving mode when doing distributed aggregation. <br>When ClickHouse works with a distributed query, external aggregation is done on remote servers. Enable this setting to achieve a smaller memory footprint on the server that sourced such a distributed query. <br>Default value: **false** (memory saving mode is disabled). <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory). 
distributed_ddl_task_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Timeout for DDL queries, in milliseconds. 
skip_unavailable_shards | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables silent skipping of unavailable shards. <br>A shard is considered unavailable if all its replicas are also unavailable. <br>Default value: **false** (silent skipping is disabled). <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-skip_unavailable_shards). 
compile_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables expression compilation. If you execute a lot of queries that contain identical expressions, then enable this setting. As a result, such queries may be executed faster due to use of compiled expressions. <br>Use this setting in combination with `min_count_to_compile_expression` setting. <br>Default value: **false** (expression compilation is disabled). 
min_count_to_compile_expression | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many identical expressions ClickHouse has to encounter before they are compiled. <br>Minimum value: **0** (default: **3**). <br>For the **0** value compilation is synchronous: a query waits for expression compilation process to complete prior to continuing execution. It is recommended to set this value only for testing purposes. <br>For all other values, compilation is asynchronous: the compilation process executes in a separate thread. When a compiled expression is ready, it will be used by ClickHouse for eligible queries, including the ones that are currently running. The minimum value is 0.
max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum block size for reading. <br>Data in ClickHouse is organized and processed by blocks (block is a set of columns' parts). The internal processing cycles for a single block are efficient enough, but there are noticeable expenditures on each block. <br>This setting is a recommendation for size of block (in a count of rows) that should be loaded from tables. <br>Value must be greater than **0** (default: **65536**). <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_block_size). Value must be greater than 0.
min_insert_block_size_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the minimum number of rows in a block to be inserted in a table by **INSERT** query. Blocks that are smaller than the specified value, will be squashed together into the bigger blocks. <br>Minimal value: **0**, block squashing is disabled (default: **1048576**). The minimum value is 0.
min_insert_block_size_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the minimum number of bytes in a block to be inserted in a table by **INSERT** query. Blocks that are smaller than the specified value, will be squashed together into the bigger blocks. <br>Minimal value: **0**, block squashing is disabled (default: **268435456**, 256 MB). The minimum value is 0.
max_insert_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Allows to form blocks of the specified size (in bytes) when inserting data in a table. This setting has effect only if server is creating such blocks by itself. <br>Value must be greater than **0** (default: **1048576**). <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_insert_block_size). Value must be greater than 0.
min_bytes_to_use_direct_io | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the minimum number of bytes to enable unbuffered direct reads from disk (Direct I/O). <br>By default, ClickHouse does not read data directly from disk, but relies on the filesystem and its cache instead. Such reading strategy is effective when the data volume is small. If the amount of the data to read is huge, it is more effective to read directly from the disk, bypassing the filesystem cache. <br>If the total amount of the data to read is greater than the value of this setting, then ClickHouse will fetch this data directly from the disk. <br>Minimal value and default value: **0**, Direct I/O is disabled. The minimum value is 0.
use_uncompressed_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether to use the cache of uncompressed blocks, or not. Using this cache can significantly reduce latency and increase the throughput when a huge amount of small queries is to be processed. Enable this setting for the users who instantiates small queries frequently. <br>This setting has effect only for tables of the MergeTree family. <br>Default value: **false** (uncompressed cache is disabled). <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-use_uncompressed_cache). 
merge_tree_max_rows_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum size in rows of the request that can use the cache of uncompressed data. The cache is not used for requests larger than the specified value. <br>Use this setting in combination with `use_uncompressed_cache` setting. <br>Value must be greater than **0** (default: **128x8192**). Value must be greater than 0.
merge_tree_max_bytes_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum size in bytes of the request that can use the cache of uncompressed data. The cache is not used for requests larger than the specified value. <br>Use this setting in combination with `use_uncompressed_cache` setting. <br>Value must be greater than **0** (default: **192x10x1024x1024**). Value must be greater than 0.
merge_tree_min_rows_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the minimum number of rows to be read from a file to enable concurrent read. If the number of rows to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently. <br>This setting has effect only for tables of the MergeTree family. <br>Value must be greater than **0** (default: **20x8192**). Value must be greater than 0.
merge_tree_min_bytes_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the number of bytes to be read from a file to enable concurrent read. If the number of bytes to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently. <br>This setting has effect only for tables of the MergeTree family. <br>Value must be greater than **0** (default: **24x10x1024x1024**). Value must be greater than 0.
max_bytes_before_external_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the **GROUP BY** operation, should be flushed to disk to limit the RAM comsumption. <br>By default, aggregation is done by employing hash table that resides in RAM. A query can result in aggregation of huge data volumes that can lead to memory exhaustion and abortion of the query (see the `max_memory_usage` setting). For such queries, you can use this setting to force ClickHouse to do flushing and complete aggregation successfully. <br>Minimal value and default value: **0**, **GROUP BY** in the external memory is disabled. <br>When using aggregation in external memory, it is recommended to set the value of this setting twice as low as the `max_memory_usage` setting value (by default, the maximum memory usage is limited to ten gigabytes). <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory). <br>See also: the `distributed_aggregation_memory_efficient` setting. 
max_bytes_before_external_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This setting is equivalent of the `max_bytes_before_external_group_by` setting, except for it is for sort operation (**ORDER BY**), not aggregation. 
group_by_two_level_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the threshold of the number of keys, after that the two-level aggregation should be used. <br>Minimal value: **0**, threshold is not set (default: **10000**). 
group_by_two_level_threshold_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the threshold of the number of bytes, after that the two-level aggregation should be used. <br>Minimal value: **0**, threshold is not set (default: **100000000**). 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the priority of a query. <br><ul><li>**0**-priority is not used. </li><li>**1**-the highest priority. </li><li>and so on. The higher the number, the lower a query's priority. </li></ul><br>This setting should be set up for each query individually. <br>If ClickHouse is working with the high-priority queries, and a low-priority query enters, then the low-priority query is paused until higher-priority queries are completed. <br>Minimal value and default value: **0**, priority is not used. The minimum value is 0.
max_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum number of threads to process the request (setting does not take threads that read data from remote servers into account). <br>This setting applies to threads that perform the same stages of the query processing pipeline in parallel. <br>Minimal value and default value: **0** (the thread number is calculated automatically based on the number of physical CPU cores, no HyperThreading cores are taken into account). <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_threads). Value must be greater than 0.
max_memory_usage | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum memory usage (in bytes) for processing of a single user's query on a single server. This setting does not take server's free RAM amount or total RAM amount into account. <br>This limitation is enforced for any user's single query on a single server. <br>Minimal value: **0**, no limitation is set. Value that is set in the ClickHouse default config file: **10737418240** (10 GB). <br>If you use `max_bytes_before_external_group_by` or `max_bytes_before_external_sort` setting, then it is recommended to set their values twice as low as `max_memory_usage` setting value. <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#settings_max_memory_usage). The minimum value is 0.
max_memory_usage_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum memory usage (in bytes) for processing of user's queries on a single server. This setting does not take server's free RAM amount or total RAM amount into account. <br>This limitation is enforced for all queries that belong to one user and run simultaneously on a single server. <br>Minimal value and default value: **0**, no limitation is set. The minimum value is 0.
max_network_bandwidth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum speed of data exchange over the network in bytes per second for a query. <br>Minimal value and default value: **0**, no limitation is set. 
max_network_bandwidth_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries. <br>Minimal value and default value: **0**, no limitation is set. 
max_partitions_per_insert_block | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/operations/settings/query-complexity/#max-partitions-per-insert-block). 
max_concurrent_queries_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of concurrent requests per user. Default value: 0 (no limit). 
force_index_by_date | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>If enabled, query is not executed if the ClickHouse can't use index by date. This setting has effect only for tables of the MergeTree family. <br>Default value: **false** (setting is disabled, query executes even if ClickHouse can't use index by date). <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-force_index_by_date). 
force_primary_key | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>If enabled, query is not executed if the ClickHouse can't use index by primary key. This setting has effect only for tables of the MergeTree family. <br>Default value: **false** (setting is disabled, query executes even if ClickHouse can't use index by primary key). <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#force-primary-key). 
max_rows_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum number of rows that can be read from a table when running a query. <br>Minimal value and default value: **0**, no limitation is set. <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-rows-to-read). The minimum value is 0.
max_bytes_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query. <br>Minimal value and default value: **0**, no limitation is set. The minimum value is 0.
read_overflow_mode | enum **OverflowMode**<br>Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while reading the data. <br><ul><li>**throw**-abort query execution, return an error. </li><li>**break**-stop query execution, return partial result.</li></ul> 
max_rows_to_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum number of unique keys received from aggregation function. This setting helps to reduce RAM consumption while doing aggregation. <br>Minimal value and default value: **0**, no limitation is set. The minimum value is 0.
group_by_overflow_mode | enum **GroupByOverflowMode**<br>Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing aggregation. <br><ul><li>**throw**-abort query execution, return an error. </li><li>**break**-stop query execution, return partial result. </li><li>**any**-perform approximate **GROUP BY** operation by continuing aggregation for the keys that got into the set, but don't add new keys to the set.</li></ul> 
max_rows_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum number of rows that can be read from a table for sorting. This setting helps to reduce RAM consumption. <br>Minimal value and default value: **0**, no limitation is set. The minimum value is 0.
max_bytes_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum number of bytes (uncompressed data) that can be read from a table for sorting. This setting helps to reduce RAM consumption. <br>Minimal value and default value: **0**, no limitation is set. The minimum value is 0.
sort_overflow_mode | enum **OverflowMode**<br>Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while sorting. <br><ul><li>**throw**-abort query execution, return an error. </li><li>**break**-stop query execution, return partial result.</li></ul> 
max_result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the number of rows in the result. This limitation is also checked for subqueries and parts of distributed queries that run on remote servers. <br>Minimal value and default value: **0**, no limitation is set. The minimum value is 0.
max_result_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the number of bytes in the result. This limitation is also checked for subqueries and parts of distributed queries that run on remote servers. <br>Minimal value and default value: **0**, no limitation is set. The minimum value is 0.
result_overflow_mode | enum **OverflowMode**<br>Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while forming result. <br><ul><li>**throw**-abort query execution, return an error. </li><li>**break**-stop query execution, return partial result.</li></ul> 
max_rows_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum number of different rows when using **DISTINCT**. <br>Minimal value and default value: **0**, no limitation is set. The minimum value is 0.
max_bytes_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum size of a hash table in bytes (uncompressed data) when using **DISTINCT**. The minimum value is 0.
distinct_overflow_mode | enum **OverflowMode**<br>Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing **DISCTINCT**. <br><ul><li>**throw**-abort query execution, return an error. </li><li>**break**-stop query execution, return partial result.</li></ul> 
max_rows_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using **GLOBAL IN**. <br>Minimal value and default value: **0**, no limitation is set. The minimum value is 0.
max_bytes_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary table when using **GLOBAL IN**. <br>Minimal value and default value: **0**, no limitation is set. The minimum value is 0.
transfer_overflow_mode | enum **OverflowMode**<br>Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing transfers. <br><ul><li>**throw**-abort query execution, return an error. </li><li>**break**-stop query execution, return partial result.</li></ul> 
max_execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum query execution time in milliseconds. At this moment, this limitation is not checked when passing one of the sorting stages, as well as merging and finalizing aggregation funictions. <br>Minimal value and default value: **0**, no limitation is set. The minimum value is 0.
timeout_overflow_mode | enum **OverflowMode**<br>Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) of execution time. <br><ul><li>**throw**-abort query execution, return an error. </li><li>**break**-stop query execution, return partial result.</li></ul> 
max_rows_in_set | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limit on the number of rows in the set resulting from the execution of the IN section. The minimum value is 0.
max_bytes_in_set | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limit on the number of bytes in the set resulting from the execution of the IN section. The minimum value is 0.
set_overflow_mode | enum **OverflowMode**<br>Determine the behavior on exceeding max_rows_in_set or max_bytes_in_set limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK. 
max_rows_in_join | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limit on maximum size of the hash table for JOIN, in rows. The minimum value is 0.
max_bytes_in_join | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limit on maximum size of the hash table for JOIN, in bytes. The minimum value is 0.
join_overflow_mode | enum **OverflowMode**<br>Determine the behavior on exceeding max_rows_in_join or max_bytes_in_join limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK. 
join_algorithm[] | enum **JoinAlgorithm**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-join_algorithm). 
any_join_distinct_right_table_keys | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#any_join_distinct_right_table_keys). 
max_columns_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum number of columns that can be read from a table in a single query. If the query requires to read more columns to complete, then it will be aborted. <br>Minimal value and default value: **0**, no limitation is set. The minimum value is 0.
max_temporary_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns. <br>Minimal value and default value: **0**, no limitation is set. The minimum value is 0.
max_temporary_non_const_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns. <br>Minimal value and default value: **0**, no limitation is set. The minimum value is 0.
max_query_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the size of the part of a query that can be transferred to RAM for parsing with the SQL parser, in bytes. <br>Value must be greater than **0** (default: **262144**). <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_query_size). Value must be greater than 0.
max_ast_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum depth of query syntax tree. <br>Executing a big and complex query may result in building a syntax tree of enormous depth. By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables. <br>For example, the **SELECT *** query may result in more complex and deeper syntax tree, compared to the **SELECT ... WHERE ...** query, containing constraints and conditions, in the most cases. A user can be forced to construct more optimized queries, if this setting is used. <br>Value must be greater than **0** (default: **1000**). If a too small value is set, it may render ClickHouse unable to execute even simple queries. <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-depth). Value must be greater than 0.
max_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum size of query syntax tree in number of nodes. <br>Executing a big and complex query may result in building a syntax tree of enormous size. By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables. <br>Value must be greater than **0** (default: **50000**). If a too small value is set, it may render ClickHouse unable to execute even simple queries. <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-elements). Value must be greater than 0.
max_expanded_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk values. <br>Executing a big and complex query may result in building a syntax tree of enormous size. By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables. <br>Value must be greater than **0** (default: **500000**). If a too small value is set, it may render ClickHouse unable to execute even simple queries. Value must be greater than 0.
min_execution_speed | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimal execution speed in rows per second. The minimum value is 0.
min_execution_speed_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimal execution speed in bytes per second. The minimum value is 0.
count_distinct_implementation | enum **CountDistinctImplementation**<br>Aggregate function to use for implementation of count(DISTINCT ...). 
input_format_values_interpret_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables SQL parser if the fast stream parser cannot parse the data. <br>Enable this setting, if the data that you want to insert into a table contains SQL expressions. <br>For example, the stream parser is unable to parse a value that contains **now()** expression; therefore an **INSERT** query for this value will fail and no data will be inserted into a table. With enabled SQL parser, this expression is parsed correctly: the **now()** expression will be parsed as SQL function, interpreted, and the current date and time will be inserted into the table as a result. <br>This setting has effect only if you use [Values](https://clickhouse.com/docs/en/interfaces/formats/#data-format-values) format when inserting data. <br>Default value: **true** (SQL parser is enabled). <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions). 
input_format_defaults_for_omitted_fields | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables replacing omitted input values with default values of the respective columns when performing **INSERT** queries. <br>Default value: **true** (replacing is enabled). 
input_format_null_as_default | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#input_format_null_as_default). 
date_time_input_format | enum **DateTimeInputFormat**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#date_time_input_format). 
input_format_with_names_use_header | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#input_format_with_names_use_header). 
output_format_json_quote_64bit_integers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables quoting of 64-bit integers in JSON output format. <br>If this setting is enabled, then 64-bit integers (**UInt64** and **Int64**) will be quoted when written to JSON output in order to maintain compatibility with the most of the JavaScript engines. Otherwise, such integers will not be quoted. <br>Default value: **false** (quoting 64-bit integers is disabled). 
output_format_json_quote_denormals | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables special floating-point values (**+nan**, **-nan**, **+inf** and **-inf**) in JSON output format. <br>Default value: **false** (special values do not present in output). 
date_time_output_format | enum **DateTimeOutputFormat**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#date_time_output_format). 
low_cardinality_allow_in_native_format | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determines whether to use LowCardinality type in Native format. <br><ul><li>**true** (default)-yes, use. </li><li>**false**-convert LowCardinality columns to regular columns when doing **SELECT**, and convert regular columns to LowCardinality when doing **INSERT**. </li></ul><br>LowCardinality columns (aka sparse columns) store data in more effective way, compared to regular columns, by using hash tables. If data to insert suits this storage format, ClickHouse will place them into LowCardinality column. <br>If you use a third-party ClickHouse client that can't work with LowCardinality columns, then this client will not be able to correctly interpret the result of the query that asks for data stored in LowCardinality column. Disable this setting to convert LowCardinality column to regular column when creating the result, so such clients will be able to process the result. <br>Official ClickHouse client works with LowCardinality columns out-of-the-box. <br>Default value: **true** (LowCardinality columns are used in Native format). 
allow_suspicious_low_cardinality_types | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Allows specifying **LowCardinality** modifier for types of small fixed size (8 or less) in CREATE TABLE statements. Enabling this may increase merge times and memory consumption. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#allow_suspicious_low_cardinality_types). 
empty_result_for_aggregation_by_empty_set | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables returning of empty result when aggregating without keys (with **GROUP BY** operation absent) on empty set (e.g., **SELECT count(*) FROM table WHERE 0**). <br><ul><li>**true**-ClickHouse will return an empty result for such queries. </li><li>**false** (default)-ClickHouse will return a single-line result consisting of **NULL** values for aggregation functions, in accordance with SQL standard.</li></ul> 
http_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP connection timeout, in milliseconds. <br>Value must be greater than **0** (default: **1000**, 1 second). 
http_receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP receive timeout, in milliseconds. <br>Value must be greater than **0** (default: **1800000**, 1800 seconds, 30 minutes). 
http_send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP send timeout, in milliseconds. <br>Value must be greater than **0** (default: **1800000**, 1800 seconds, 30 minutes). 
enable_http_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables data compression in HTTP responses. <br>By default, ClickHouse stores data compressed. When executing a query, its result is uncompressed. Use this setting to command ClickHouse to compress the result when sending it via HTTP. <br>Enable this setting and add the **Accept-Encoding: <compression method>** HTTP header in a HTTP request to force compression of HTTP response from ClickHouse. <br>ClickHouse support the following compression methods: **gzip**, **br** and **deflate**. <br>Default value: **false** (compression is disabled). <br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/interfaces/http/). 
send_progress_in_http_headers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables progress notifications using **X-ClickHouse-Progress** HTTP header. <br>Default value: **false** (notifications disabled). 
http_headers_progress_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum interval between progress notifications with **X-ClickHouse-Progress** HTTP header, in milliseconds. <br>Value must be greater than **0** (default: **100**). 
add_http_cors_header | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Adds CORS header in HTTP responses. <br>Default value: **false** (header is not added). 
cancel_http_readonly_queries_on_client_close | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Cancels HTTP read-only queries (e.g. SELECT) when a client closes the connection without waiting for the response. <br>Default value: **false**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#cancel-http-readonly-queries-on-client-close). 
max_http_get_redirects | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limits the maximum number of HTTP GET redirect hops for [URL-engine](https://clickhouse.com/docs/en/engines/table-engines/special/url) tables. <br>If the parameter is set to **0** (default), no hops is allowed. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_http_get_redirects). 
joined_subquery_requires_alias | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
join_use_nulls | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
transform_null_in | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
quota_mode | enum **QuotaMode**<br>Quota accounting mode. Possible values: QUOTA_MODE_DEFAULT, QUOTA_MODE_KEYED and QUOTA_MODE_KEYED_BY_IP. 
flatten_nested | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Sets the data format of a [nested](https://clickhouse.com/docs/en/sql-reference/data-types/nested-data-structures/nested) columns. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#flatten-nested). 
format_regexp | **string**<br>Regular expression (for Regexp format) 
format_regexp_escaping_rule | enum **FormatRegexpEscapingRule**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#format_regexp_escaping_rule). 
format_regexp_skip_unmatched | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#format_regexp_skip_unmatched). 
async_insert | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables asynchronous inserts. <br>Disabled by default. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert). 
async_insert_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of threads for background data parsing and insertion. <br>If the parameter is set to **0**, asynchronous insertions are disabled. Default value: **16**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-threads). 
wait_for_async_insert | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables waiting for processing of asynchronous insertion. If enabled, server returns OK only after the data is inserted. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#wait-for-async-insert). 
wait_for_async_insert_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The timeout (in seconds) for waiting for processing of asynchronous insertion. <br>Default value: **120**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#wait-for-async-insert-timeout). 
async_insert_max_data_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of the unparsed data in bytes collected per query before being inserted. <br>If the parameter is set to **0**, asynchronous insertions are disabled. Default value: **100000**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-max-data-size). 
async_insert_busy_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum timeout in milliseconds since the first INSERT query before inserting collected data. <br>If the parameter is set to **0**, the timeout is disabled. Default value: **200**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-busy-timeout-ms). 
async_insert_stale_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum timeout in milliseconds since the last INSERT query before dumping collected data. If enabled, the settings prolongs the `async_insert_busy_timeout` with every INSERT query as long as `async_insert_max_data_size` is not exceeded. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-stale-timeout-ms). 
memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Memory profiler step (in bytes). <br>If the next query step requires more memory than this parameter specifies, the memory profiler collects the allocating stack trace. Values lower than a few megabytes slow down query processing. <br>Default value: **4194304** (4 MB). Zero means disabled memory profiler. 
memory_profiler_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br>Collect random allocations and deallocations and write them into system.trace_log with 'MemorySample' trace_type. The probability is for every alloc/free regardless to the size of the allocation. <br>Possible values: from **0** to **1**. Default: **0**. 
max_final_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of parallel threads for the SELECT query data read phase with the FINAL modifier. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#max-final-threads). The minimum value is 0.
input_format_parallel_parsing | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables order-preserving parallel parsing of data formats. Supported only for [TSV](https://clickhouse.com/docs/en/interfaces/formats#tabseparated), [TKSV](https://clickhouse.com/docs/en/interfaces/formats#tskv), [CSV](https://clickhouse.com/docs/en/interfaces/formats#csv) and [JSONEachRow](https://clickhouse.com/docs/en/interfaces/formats#jsoneachrow) formats. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#input-format-parallel-parsing) 
input_format_import_nested_json | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables the insertion of JSON data with nested objects. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#input-format-parallel-parsing) 
local_filesystem_read_method | enum **LocalFilesystemReadMethod**<br>Method of reading data from local filesystem, one of: read, pread, mmap, io_uring, pread_threadpool. The 'io_uring' method is experimental and does not work for Log, TinyLog, StripeLog, File, Set and Join, and other tables with append-able files in presence of concurrent reads and writes. 
max_read_buffer_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of the buffer to read from the filesystem. See in-depth description in [ClickHouse documentation](https://clickhouse.com/codebrowser/ClickHouse/src/Core/Settings.h.html#DB::SettingsTraits::Data::max_read_buffer_size) Value must be greater than 0.
compile | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>The setting is deprecated and has no effect. 
min_count_to_compile | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 


### UserQuota {#UserQuota}

Field | Description
--- | ---
interval_duration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Duration of interval for quota in milliseconds. Minimal value is 1 second. The minimum value is 1000.
queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The total number of queries. 0 - unlimited. The minimum value is 0.
errors | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of queries that threw exception. 0 - unlimited. The minimum value is 0.
result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The total number of rows given as the result.. 0 - unlimited. The minimum value is 0.
read_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The total number of source rows read from tables for running the query, on all remote servers. 0 - unlimited. The minimum value is 0.
execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The total query execution time, in milliseconds (wall time). 0 - unlimited. The minimum value is 0.


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
type | **[Host.Type](#Host)**<br>Required. Type of the host to be deployed. 
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the [Cluster.network_id](#Cluster2) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 
shard_name | **string**<br>Name of the shard that the host is assigned to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### MaintenanceWindow {#MaintenanceWindow2}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow2)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow2)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow2}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow2}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week (in `DDD` format). 
hour | **int64**<br>Hour of the day in UTC (in `HH` format). Acceptable values are 1 to 24, inclusive.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateClusterMetadata](#CreateClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster2)>**<br>if operation finished successfully. 


### CreateClusterMetadata {#CreateClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ClickHouse cluster that is being created. 


### Cluster {#Cluster2}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation2)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring2}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the ClickHouse cluster. 


### ClusterConfig {#ClusterConfig2}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse3)**<br>Configuration and resource allocation for ClickHouse hosts. 
zookeeper | **[Zookeeper](#Zookeeper3)**<br>Configuration and resource allocation for ZooKeeper hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access3)**<br>Access policy for external services. 
cloud_storage | **[CloudStorage](#CloudStorage3)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper. 


### Clickhouse {#Clickhouse3}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet2)**<br>Configuration settings of a ClickHouse server. 
resources | **[Resources](#Resources3)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper3}

Field | Description
--- | ---
resources | **[Resources](#Resources3)**<br>Resources allocated to ZooKeeper hosts. 


### ClickhouseConfigSet {#ClickhouseConfigSet2}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig3)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig3)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig3)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig3}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree3)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression3)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary3)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup3)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka3)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic3)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq3)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree3}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka3}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic3}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka3)**<br>Required.  


### Rabbitmq {#Rabbitmq3}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression3}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary3}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure3)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout3)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range3)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource3)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource3)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource3)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource3)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource3)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource3}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource3}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica3)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica3}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource3}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource3}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource3}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure3}

Field | Description
--- | ---
id | **[Id](#Id3)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key3)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute3)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute3)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute3)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute3}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id3}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key3}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute3)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout3}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range3}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup3}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern3)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern3}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention3)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention3}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### MaintenanceOperation {#MaintenanceOperation2}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## Update {#Update}

Updates the specified ClickHouse cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse Cluster resource to update. To get the ClickHouse cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the ClickHouse Cluster resource should be updated. 
description | **string**<br>New description of the ClickHouse cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". <br>The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get](#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec)**<br>New configuration and resources for hosts in the cluster. 
name | **string**<br>New name for the cluster. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>New maintenance window settings for the cluster. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### ConfigSpec {#ConfigSpec1}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse4)**<br>Configuration and resources for a ClickHouse server. 
zookeeper | **[Zookeeper](#Zookeeper4)**<br>Configuration and resources for a ZooKeeper server. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access3)**<br>Access policy for external services. <br>If you want a specific service to access the ClickHouse cluster, then set the necessary values in this policy. 
cloud_storage | **[CloudStorage](#CloudStorage3)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
admin_password | **string**<br>Password for user 'admin' that has SQL user management access. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper 


### Clickhouse {#Clickhouse4}

Field | Description
--- | ---
config | **[config.ClickhouseConfig](#ClickhouseConfig4)**<br>Configuration for a ClickHouse server. 
resources | **[Resources](#Resources3)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper4}

Field | Description
--- | ---
resources | **[Resources](#Resources3)**<br>Resources allocated to ZooKeeper hosts. If not set, minimal available resources will be used. All available resource presets can be retrieved with a [ResourcePresetService.List](./resource_preset_service#List) request. 


### Access {#Access3}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. 
metrika | **bool**<br>Allow to import data from Yandex Metrica and AppMetrica to the cluster. <br>See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. 
serverless | **bool**<br>Allow access to cluster for Serverless. 
data_transfer | **bool**<br>Allow access for DataTransfer 
yandex_query | **bool**<br>Allow access for Query 


### CloudStorage {#CloudStorage3}

Field | Description
--- | ---
enabled | **bool**<br>Whether to use Object Storage for storing ClickHouse data. 
move_factor | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> Acceptable values are 0 to 1, inclusive.
data_cache_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
data_cache_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### ClickhouseConfig {#ClickhouseConfig4}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree4)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression4)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary4)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup4)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka4)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic4)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq4)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree4}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka4}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic4}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka4)**<br>Required.  


### Rabbitmq {#Rabbitmq4}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression4}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary4}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure4)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout4)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range4)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource4)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource4)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource4)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource4)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource4)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource4}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource4}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica4)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica4}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource4}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource4}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource4}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure4}

Field | Description
--- | ---
id | **[Id](#Id4)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key4)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute4)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute4)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute4)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute4}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id4}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key4}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute4)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout4}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range4}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup4}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern4)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern4}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention4)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention4}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources3}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### MaintenanceWindow {#MaintenanceWindow3}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow3)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow3)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow3}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow3}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week (in `DDD` format). 
hour | **int64**<br>Hour of the day in UTC (in `HH` format). Acceptable values are 1 to 24, inclusive.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateClusterMetadata](#UpdateClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster3)>**<br>if operation finished successfully. 


### UpdateClusterMetadata {#UpdateClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ClickHouse Cluster resource that is being updated. 


### Cluster {#Cluster3}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig3)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation3)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring3}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the ClickHouse cluster. 


### ClusterConfig {#ClusterConfig3}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse5)**<br>Configuration and resource allocation for ClickHouse hosts. 
zookeeper | **[Zookeeper](#Zookeeper5)**<br>Configuration and resource allocation for ZooKeeper hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access4)**<br>Access policy for external services. 
cloud_storage | **[CloudStorage](#CloudStorage4)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper. 


### Clickhouse {#Clickhouse5}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet3)**<br>Configuration settings of a ClickHouse server. 
resources | **[Resources](#Resources4)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper5}

Field | Description
--- | ---
resources | **[Resources](#Resources4)**<br>Resources allocated to ZooKeeper hosts. 


### ClickhouseConfigSet {#ClickhouseConfigSet3}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig5)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig5)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig5)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig5}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree5)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression5)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary5)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup5)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka5)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic5)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq5)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree5}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka5}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic5}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka5)**<br>Required.  


### Rabbitmq {#Rabbitmq5}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression5}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary5}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure5)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout5)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range5)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource5)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource5)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource5)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource5)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource5)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource5}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource5}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica5)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica5}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource5}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource5}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource5}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure5}

Field | Description
--- | ---
id | **[Id](#Id5)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key5)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute5)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute5)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute5)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute5}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id5}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key5}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute5)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout5}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range5}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup5}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern5)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern5}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention5)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention5}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### MaintenanceOperation {#MaintenanceOperation3}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## Delete {#Delete}

Deletes the specified ClickHouse cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to delete. To get the ClickHouse cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteClusterMetadata](#DeleteClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteClusterMetadata {#DeleteClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ClickHouse cluster that is being deleted. 


## Start {#Start}

Starts the specified ClickHouse cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to start. The maximum string length in characters is 50.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartClusterMetadata](#StartClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster4)>**<br>if operation finished successfully. 


### StartClusterMetadata {#StartClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ClickHouse cluster being started. 


### Cluster {#Cluster4}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig4)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation4)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring4}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the ClickHouse cluster. 


### ClusterConfig {#ClusterConfig4}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse6)**<br>Configuration and resource allocation for ClickHouse hosts. 
zookeeper | **[Zookeeper](#Zookeeper6)**<br>Configuration and resource allocation for ZooKeeper hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access4)**<br>Access policy for external services. 
cloud_storage | **[CloudStorage](#CloudStorage4)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper. 


### Clickhouse {#Clickhouse6}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet4)**<br>Configuration settings of a ClickHouse server. 
resources | **[Resources](#Resources4)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper6}

Field | Description
--- | ---
resources | **[Resources](#Resources4)**<br>Resources allocated to ZooKeeper hosts. 


### Access {#Access4}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. 
metrika | **bool**<br>Allow to import data from Yandex Metrica and AppMetrica to the cluster. <br>See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. 
serverless | **bool**<br>Allow access to cluster for Serverless. 
data_transfer | **bool**<br>Allow access for DataTransfer 
yandex_query | **bool**<br>Allow access for Query 


### CloudStorage {#CloudStorage4}

Field | Description
--- | ---
enabled | **bool**<br>Whether to use Object Storage for storing ClickHouse data. 
move_factor | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> Acceptable values are 0 to 1, inclusive.
data_cache_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
data_cache_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### ClickhouseConfigSet {#ClickhouseConfigSet4}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig6)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig6)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig6)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig6}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree6)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression6)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary6)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup6)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka6)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic6)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq6)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree6}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka6}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic6}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka6)**<br>Required.  


### Rabbitmq {#Rabbitmq6}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression6}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary6}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure6)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout6)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range6)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource6)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource6)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource6)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource6)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource6)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource6}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource6}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica6)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica6}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource6}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource6}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource6}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure6}

Field | Description
--- | ---
id | **[Id](#Id6)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key6)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute6)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute6)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute6)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute6}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id6}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key6}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute6)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout6}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range6}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup6}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern6)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern6}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention6)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention6}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources4}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### MaintenanceWindow {#MaintenanceWindow4}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow4)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow4)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow4}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow4}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week (in `DDD` format). 
hour | **int64**<br>Hour of the day in UTC (in `HH` format). Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation4}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## Stop {#Stop}

Stops the specified ClickHouse cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to stop. The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopClusterMetadata](#StopClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster5)>**<br>if operation finished successfully. 


### StopClusterMetadata {#StopClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ClickHouse cluster being stopped. 


### Cluster {#Cluster5}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig5)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow5)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation5)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring5}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the ClickHouse cluster. 


### ClusterConfig {#ClusterConfig5}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse7)**<br>Configuration and resource allocation for ClickHouse hosts. 
zookeeper | **[Zookeeper](#Zookeeper7)**<br>Configuration and resource allocation for ZooKeeper hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access5)**<br>Access policy for external services. 
cloud_storage | **[CloudStorage](#CloudStorage5)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper. 


### Clickhouse {#Clickhouse7}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet5)**<br>Configuration settings of a ClickHouse server. 
resources | **[Resources](#Resources5)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper7}

Field | Description
--- | ---
resources | **[Resources](#Resources5)**<br>Resources allocated to ZooKeeper hosts. 


### Access {#Access5}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. 
metrika | **bool**<br>Allow to import data from Yandex Metrica and AppMetrica to the cluster. <br>See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. 
serverless | **bool**<br>Allow access to cluster for Serverless. 
data_transfer | **bool**<br>Allow access for DataTransfer 
yandex_query | **bool**<br>Allow access for Query 


### CloudStorage {#CloudStorage5}

Field | Description
--- | ---
enabled | **bool**<br>Whether to use Object Storage for storing ClickHouse data. 
move_factor | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> Acceptable values are 0 to 1, inclusive.
data_cache_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
data_cache_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### ClickhouseConfigSet {#ClickhouseConfigSet5}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig7)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig7)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig7)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig7}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree7)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression7)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary7)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup7)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka7)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic7)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq7)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree7}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka7}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic7}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka7)**<br>Required.  


### Rabbitmq {#Rabbitmq7}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression7}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary7}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure7)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout7)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range7)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource7)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource7)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource7)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource7)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource7)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource7}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource7}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica7)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica7}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource7}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource7}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource7}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure7}

Field | Description
--- | ---
id | **[Id](#Id7)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key7)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute7)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute7)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute7)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute7}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id7}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key7}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute7)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout7}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range7}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup7}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern7)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern7}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention7)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention7}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources5}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### MaintenanceWindow {#MaintenanceWindow5}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow5)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow5)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow5}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow5}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week (in `DDD` format). 
hour | **int64**<br>Hour of the day in UTC (in `HH` format). Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation5}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## Move {#Move}

Moves a ClickHouse cluster to the specified folder.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### MoveClusterRequest {#MoveClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to move. The maximum string length in characters is 50.
destination_folder_id | **string**<br>Required. ID of the destination folder. The maximum string length in characters is 50.


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[MoveClusterMetadata](#MoveClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster6)>**<br>if operation finished successfully. 


### MoveClusterMetadata {#MoveClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ClickHouse cluster being moved. 
source_folder_id | **string**<br>ID of the source folder. 
destination_folder_id | **string**<br>ID of the destination folder. 


### Cluster {#Cluster6}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring6)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig6)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow6)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation6)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring6}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the ClickHouse cluster. 


### ClusterConfig {#ClusterConfig6}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse8)**<br>Configuration and resource allocation for ClickHouse hosts. 
zookeeper | **[Zookeeper](#Zookeeper8)**<br>Configuration and resource allocation for ZooKeeper hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access6)**<br>Access policy for external services. 
cloud_storage | **[CloudStorage](#CloudStorage6)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper. 


### Clickhouse {#Clickhouse8}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet6)**<br>Configuration settings of a ClickHouse server. 
resources | **[Resources](#Resources6)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper8}

Field | Description
--- | ---
resources | **[Resources](#Resources6)**<br>Resources allocated to ZooKeeper hosts. 


### Access {#Access6}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. 
metrika | **bool**<br>Allow to import data from Yandex Metrica and AppMetrica to the cluster. <br>See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. 
serverless | **bool**<br>Allow access to cluster for Serverless. 
data_transfer | **bool**<br>Allow access for DataTransfer 
yandex_query | **bool**<br>Allow access for Query 


### CloudStorage {#CloudStorage6}

Field | Description
--- | ---
enabled | **bool**<br>Whether to use Object Storage for storing ClickHouse data. 
move_factor | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> Acceptable values are 0 to 1, inclusive.
data_cache_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
data_cache_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### ClickhouseConfigSet {#ClickhouseConfigSet6}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig8)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig8)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig8)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig8}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree8)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression8)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary8)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup8)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka8)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic8)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq8)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree8}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka8}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic8}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka8)**<br>Required.  


### Rabbitmq {#Rabbitmq8}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression8}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary8}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure8)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout8)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range8)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource8)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource8)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource8)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource8)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource8)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource8}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource8}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica8)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica8}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource8}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource8}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource8}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure8}

Field | Description
--- | ---
id | **[Id](#Id8)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key8)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute8)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute8)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute8)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute8}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id8}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key8}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute8)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout8}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range8}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup8}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern8)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern8}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention8)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention8}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources6}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### MaintenanceWindow {#MaintenanceWindow6}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow6)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow6)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow6}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow6}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week (in `DDD` format). 
hour | **int64**<br>Hour of the day in UTC (in `HH` format). Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation6}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## AddZookeeper {#AddZookeeper}

Adds a ZooKeeper subcluster to the specified ClickHouse cluster.

**rpc AddZookeeper ([AddClusterZookeeperRequest](#AddClusterZookeeperRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterZookeeperMetadata](#AddClusterZookeeperMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster7)<br>

### AddClusterZookeeperRequest {#AddClusterZookeeperRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to modify. The maximum string length in characters is 50.
resources | **[Resources](#Resources7)**<br>Resources allocated to Zookeeper hosts. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Configuration of ZooKeeper hosts. 


### Resources {#Resources7}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### HostSpec {#HostSpec1}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
type | **[Host.Type](#Host)**<br>Required. Type of the host to be deployed. 
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the [Cluster.network_id](#Cluster7) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 
shard_name | **string**<br>Name of the shard that the host is assigned to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddClusterZookeeperMetadata](#AddClusterZookeeperMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster7)>**<br>if operation finished successfully. 


### AddClusterZookeeperMetadata {#AddClusterZookeeperMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ClickHouse cluster. 


### Cluster {#Cluster7}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring7)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig7)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow7)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation7)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring7}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the ClickHouse cluster. 


### ClusterConfig {#ClusterConfig7}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse9)**<br>Configuration and resource allocation for ClickHouse hosts. 
zookeeper | **[Zookeeper](#Zookeeper9)**<br>Configuration and resource allocation for ZooKeeper hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access7)**<br>Access policy for external services. 
cloud_storage | **[CloudStorage](#CloudStorage7)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper. 


### Clickhouse {#Clickhouse9}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet7)**<br>Configuration settings of a ClickHouse server. 
resources | **[Resources](#Resources8)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper9}

Field | Description
--- | ---
resources | **[Resources](#Resources8)**<br>Resources allocated to ZooKeeper hosts. 


### Access {#Access7}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. 
metrika | **bool**<br>Allow to import data from Yandex Metrica and AppMetrica to the cluster. <br>See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. 
serverless | **bool**<br>Allow access to cluster for Serverless. 
data_transfer | **bool**<br>Allow access for DataTransfer 
yandex_query | **bool**<br>Allow access for Query 


### CloudStorage {#CloudStorage7}

Field | Description
--- | ---
enabled | **bool**<br>Whether to use Object Storage for storing ClickHouse data. 
move_factor | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> Acceptable values are 0 to 1, inclusive.
data_cache_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
data_cache_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### ClickhouseConfigSet {#ClickhouseConfigSet7}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig9)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig9)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig9)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig9}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree9)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression9)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary9)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup9)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka9)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic9)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq9)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree9}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka9}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic9}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka9)**<br>Required.  


### Rabbitmq {#Rabbitmq9}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression9}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary9}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure9)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout9)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range9)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource9)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource9)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource9)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource9)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource9)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource9}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource9}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica9)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica9}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource9}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource9}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource9}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure9}

Field | Description
--- | ---
id | **[Id](#Id9)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key9)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute9)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute9)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute9)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute9}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id9}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key9}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute9)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout9}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range9}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup9}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern9)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern9}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention9)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention9}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### MaintenanceWindow {#MaintenanceWindow7}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow7)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow7)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow7}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow7}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week (in `DDD` format). 
hour | **int64**<br>Hour of the day in UTC (in `HH` format). Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation7}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## Backup {#Backup}

Creates a backup for the specified ClickHouse cluster.

**rpc Backup ([BackupClusterRequest](#BackupClusterRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupClusterMetadata](#BackupClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster8)<br>

### BackupClusterRequest {#BackupClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to back up. To get the ClickHouse cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation7}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BackupClusterMetadata](#BackupClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster8)>**<br>if operation finished successfully. 


### BackupClusterMetadata {#BackupClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ClickHouse cluster that is being backed up. 


### Cluster {#Cluster8}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring8)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig8)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow8)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation8)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring8}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the ClickHouse cluster. 


### ClusterConfig {#ClusterConfig8}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse10)**<br>Configuration and resource allocation for ClickHouse hosts. 
zookeeper | **[Zookeeper](#Zookeeper10)**<br>Configuration and resource allocation for ZooKeeper hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access8)**<br>Access policy for external services. 
cloud_storage | **[CloudStorage](#CloudStorage8)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper. 


### Clickhouse {#Clickhouse10}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet8)**<br>Configuration settings of a ClickHouse server. 
resources | **[Resources](#Resources8)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper10}

Field | Description
--- | ---
resources | **[Resources](#Resources8)**<br>Resources allocated to ZooKeeper hosts. 


### Access {#Access8}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. 
metrika | **bool**<br>Allow to import data from Yandex Metrica and AppMetrica to the cluster. <br>See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. 
serverless | **bool**<br>Allow access to cluster for Serverless. 
data_transfer | **bool**<br>Allow access for DataTransfer 
yandex_query | **bool**<br>Allow access for Query 


### CloudStorage {#CloudStorage8}

Field | Description
--- | ---
enabled | **bool**<br>Whether to use Object Storage for storing ClickHouse data. 
move_factor | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> Acceptable values are 0 to 1, inclusive.
data_cache_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
data_cache_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### ClickhouseConfigSet {#ClickhouseConfigSet8}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig10)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig10)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig10)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig10}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree10)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression10)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary10)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup10)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka10)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic10)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq10)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree10}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka10}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic10}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka10)**<br>Required.  


### Rabbitmq {#Rabbitmq10}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression10}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary10}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure10)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout10)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range10)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource10)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource10)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource10)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource10)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource10)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource10}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource10}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica10)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica10}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource10}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource10}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource10}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure10}

Field | Description
--- | ---
id | **[Id](#Id10)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key10)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute10)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute10)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute10)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute10}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id10}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key10}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute10)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout10}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range10}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup10}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern10)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern10}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention10)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention10}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources8}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### MaintenanceWindow {#MaintenanceWindow8}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow8)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow8)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow8}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow8}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week (in `DDD` format). 
hour | **int64**<br>Hour of the day in UTC (in `HH` format). Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation8}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## Restore {#Restore}

Creates a new ClickHouse cluster using the specified backup.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation8))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster9)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. ID of the backup to restore from. This backup will be used to create one cluster shard. To get the backup ID, use a [ClusterService.ListBackups](#ListBackups) request. 
additional_backup_ids[] | **string**<br>Additional IDs of the backups to restore from. Each additional backup is responsible for restoring separate shard. Restored cluster will have len(additional_backup_ids)+1 shards in total. To get the backup ID, use a [ClusterService.ListBackups](#ListBackups) request. 
name | **string**<br>Required. Name of the new ClickHouse cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the new ClickHouse cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster9)**<br>Required. Deployment environment of the new ClickHouse cluster. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Required. Configuration for the ClickHouse cluster to be created. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Configurations for ClickHouse hosts that should be created for the cluster that is being created from the backup. The number of elements must be greater than 0.
network_id | **string**<br>Required. ID of the network to create the ClickHouse cluster in. The maximum string length in characters is 50.
folder_id | **string**<br>ID of the folder to create the ClickHouse cluster in. The maximum string length in characters is 50.
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
security_group_ids[] | **string**<br>User security groups 


### ConfigSpec {#ConfigSpec2}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse11)**<br>Configuration and resources for a ClickHouse server. 
zookeeper | **[Zookeeper](#Zookeeper11)**<br>Configuration and resources for a ZooKeeper server. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access9)**<br>Access policy for external services. <br>If you want a specific service to access the ClickHouse cluster, then set the necessary values in this policy. 
cloud_storage | **[CloudStorage](#CloudStorage9)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
admin_password | **string**<br>Password for user 'admin' that has SQL user management access. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper 


### Clickhouse {#Clickhouse11}

Field | Description
--- | ---
config | **[config.ClickhouseConfig](#ClickhouseConfig11)**<br>Configuration for a ClickHouse server. 
resources | **[Resources](#Resources9)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper11}

Field | Description
--- | ---
resources | **[Resources](#Resources9)**<br>Resources allocated to ZooKeeper hosts. If not set, minimal available resources will be used. All available resource presets can be retrieved with a [ResourcePresetService.List](./resource_preset_service#List) request. 


### Access {#Access9}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. 
metrika | **bool**<br>Allow to import data from Yandex Metrica and AppMetrica to the cluster. <br>See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. 
serverless | **bool**<br>Allow access to cluster for Serverless. 
data_transfer | **bool**<br>Allow access for DataTransfer 
yandex_query | **bool**<br>Allow access for Query 


### CloudStorage {#CloudStorage9}

Field | Description
--- | ---
enabled | **bool**<br>Whether to use Object Storage for storing ClickHouse data. 
move_factor | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> Acceptable values are 0 to 1, inclusive.
data_cache_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
data_cache_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### ClickhouseConfig {#ClickhouseConfig11}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree11)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression11)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary11)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup11)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka11)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic11)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq11)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree11}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka11}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic11}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka11)**<br>Required.  


### Rabbitmq {#Rabbitmq11}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression11}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary11}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure11)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout11)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range11)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource11)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource11)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource11)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource11)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource11)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource11}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource11}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica11)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica11}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource11}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource11}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource11}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure11}

Field | Description
--- | ---
id | **[Id](#Id11)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key11)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute11)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute11)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute11)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute11}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id11}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key11}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute11)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout11}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range11}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup11}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern11)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern11}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention11)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention11}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources9}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### HostSpec {#HostSpec2}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
type | **[Host.Type](#Host)**<br>Required. Type of the host to be deployed. 
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the [Cluster.network_id](#Cluster9) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 
shard_name | **string**<br>Name of the shard that the host is assigned to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation8}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RestoreClusterMetadata](#RestoreClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster9)>**<br>if operation finished successfully. 


### RestoreClusterMetadata {#RestoreClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the new ClickHouse cluster that is being created from a backup. 
backup_id | **string**<br>ID of the backup that is being used for creating a cluster. 


### Cluster {#Cluster9}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring9)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig9)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow9)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation9)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring9}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the ClickHouse cluster. 


### ClusterConfig {#ClusterConfig9}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse12)**<br>Configuration and resource allocation for ClickHouse hosts. 
zookeeper | **[Zookeeper](#Zookeeper12)**<br>Configuration and resource allocation for ZooKeeper hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access10)**<br>Access policy for external services. 
cloud_storage | **[CloudStorage](#CloudStorage10)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper. 


### Clickhouse {#Clickhouse12}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet9)**<br>Configuration settings of a ClickHouse server. 
resources | **[Resources](#Resources10)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper12}

Field | Description
--- | ---
resources | **[Resources](#Resources10)**<br>Resources allocated to ZooKeeper hosts. 


### ClickhouseConfigSet {#ClickhouseConfigSet9}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig12)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig12)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig12)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig12}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree12)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression12)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary12)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup12)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka12)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic12)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq12)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree12}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka12}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic12}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka12)**<br>Required.  


### Rabbitmq {#Rabbitmq12}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression12}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary12}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure12)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout12)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range12)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource12)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource12)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource12)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource12)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource12)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource12}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource12}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica12)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica12}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource12}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource12}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource12}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure12}

Field | Description
--- | ---
id | **[Id](#Id12)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key12)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute12)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute12)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute12)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute12}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id12}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key12}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute12)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout12}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range12}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup12}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern12)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern12}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention12)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention12}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### MaintenanceWindow {#MaintenanceWindow9}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow9)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow9)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow9}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow9}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week (in `DDD` format). 
hour | **int64**<br>Hour of the day in UTC (in `HH` format). Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation9}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## RescheduleMaintenance {#RescheduleMaintenance}

Reschedules planned maintenance operation.

**rpc RescheduleMaintenance ([RescheduleMaintenanceRequest](#RescheduleMaintenanceRequest)) returns ([operation.Operation](#Operation9))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RescheduleMaintenanceMetadata](#RescheduleMaintenanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster10)<br>

### RescheduleMaintenanceRequest {#RescheduleMaintenanceRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to reschedule the maintenance operation for. The maximum string length in characters is 50.
reschedule_type | enum **RescheduleType**<br>Required. The type of reschedule request. <ul><li>`IMMEDIATE`: Start the maintenance operation immediately.</li><li>`NEXT_AVAILABLE_WINDOW`: Start the maintenance operation within the next available maintenance window.</li><li>`SPECIFIC_TIME`: Start the maintenance operation at the specific time.</li></ul>
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time until which this maintenance operation should be delayed. The value should be ahead of the first time when the maintenance operation has been scheduled for no more than two weeks. The value can also point to the past moment of time if `reschedule_type.IMMEDIATE` reschedule type is chosen. 


### Operation {#Operation9}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RescheduleMaintenanceMetadata](#RescheduleMaintenanceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster10)>**<br>if operation finished successfully. 


### RescheduleMaintenanceMetadata {#RescheduleMaintenanceMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster. 
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. The time until which this maintenance operation is to be delayed. 


### Cluster {#Cluster10}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring10)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig10)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow10)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation10)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring10}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the ClickHouse cluster. 


### ClusterConfig {#ClusterConfig10}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse13)**<br>Configuration and resource allocation for ClickHouse hosts. 
zookeeper | **[Zookeeper](#Zookeeper13)**<br>Configuration and resource allocation for ZooKeeper hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access10)**<br>Access policy for external services. 
cloud_storage | **[CloudStorage](#CloudStorage10)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper. 


### Clickhouse {#Clickhouse13}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet10)**<br>Configuration settings of a ClickHouse server. 
resources | **[Resources](#Resources10)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper13}

Field | Description
--- | ---
resources | **[Resources](#Resources10)**<br>Resources allocated to ZooKeeper hosts. 


### Access {#Access10}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. 
metrika | **bool**<br>Allow to import data from Yandex Metrica and AppMetrica to the cluster. <br>See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. 
serverless | **bool**<br>Allow access to cluster for Serverless. 
data_transfer | **bool**<br>Allow access for DataTransfer 
yandex_query | **bool**<br>Allow access for Query 


### CloudStorage {#CloudStorage10}

Field | Description
--- | ---
enabled | **bool**<br>Whether to use Object Storage for storing ClickHouse data. 
move_factor | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> Acceptable values are 0 to 1, inclusive.
data_cache_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
data_cache_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### ClickhouseConfigSet {#ClickhouseConfigSet10}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig13)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig13)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig13)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig13}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree13)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression13)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary13)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup13)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka13)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic13)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq13)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree13}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka13}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic13}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka13)**<br>Required.  


### Rabbitmq {#Rabbitmq13}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression13}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary13}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure13)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout13)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range13)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource13)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource13)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource13)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource13)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource13)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource13}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource13}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica13)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica13}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource13}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource13}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource13}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure13}

Field | Description
--- | ---
id | **[Id](#Id13)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key13)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute13)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute13)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute13)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute13}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id13}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key13}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute13)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout13}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range13}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup13}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern13)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern13}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention13)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention13}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources10}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### MaintenanceWindow {#MaintenanceWindow10}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow10)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow10)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow10}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow10}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week (in `DDD` format). 
hour | **int64**<br>Hour of the day in UTC (in `HH` format). Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation10}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## ListLogs {#ListLogs}

Retrieves logs for the specified ClickHouse cluster.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to request logs for. To get the ClickHouse cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from logs table to request. If no columns are specified, entire log records are returned. 
service_type | enum **ServiceType**<br>Required. Type of the service to request logs about. <ul><li>`CLICKHOUSE`: Logs of ClickHouse activity.</li></ul>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterLogsResponse {#ListClusterLogsResponse}

Field | Description
--- | ---
logs[] | **[LogRecord](#LogRecord)**<br>Requested log records. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterLogsRequest.page_size](#ListClusterLogsRequest), use the `next_page_token` as the value for the [ListClusterLogsRequest.page_token](#ListClusterLogsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. This value is interchangeable with the [StreamLogRecord.next_record_token](#StreamLogRecord) from StreamLogs method. 


### LogRecord {#LogRecord}

Field | Description
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log record timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
message | **map<string,string>**<br>Contents of the log record. 


## StreamLogs {#StreamLogs}

Same as ListLogs but using server-side streaming. Also allows for `tail -f` semantics.

**rpc StreamLogs ([StreamClusterLogsRequest](#StreamClusterLogsRequest)) returns (stream [StreamLogRecord](#StreamLogRecord))**

### StreamClusterLogsRequest {#StreamClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the ClickHouse cluster. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from logs table to get in the response. 
service_type | enum **ServiceType**<br>Required.  <ul><li>`CLICKHOUSE`: Logs of ClickHouse activity.</li></ul>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request. If this field is not set, all existing logs will be sent and then the new ones as they appear. In essence it has `tail -f` semantics. 
record_token | **string**<br>Record token. Set `record_token` to the [StreamLogRecord.next_record_token](#StreamLogRecord) returned by a previous StreamLogs request to start streaming from next log record. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname](#LogRecord), [LogRecord.logs.message.severity](#LogRecord) fields. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-z0-9.-]{1,61}`. </li></ol>Examples of a filter: <ul><li>`message.hostname='node1.db.cloud.yandex.net'` </li><li>`message.severity IN ('Error', 'Fatal') AND message.hostname != 'node2.db.cloud.yandex.net'`.</li></ul> The maximum string length in characters is 1000.


### StreamLogRecord {#StreamLogRecord}

Field | Description
--- | ---
record | **[LogRecord](#LogRecord)**<br>One of the requested log records. 
next_record_token | **string**<br>This token allows you to continue streaming logs starting from the exact same record. To continue streaming, specify value of [next_record_token [as value for the [StreamClusterLogsRequest.record_token](#StreamClusterLogsRequest) parameter in the next StreamLogs request. This value is interchangeable with the [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) from ListLogs method. 


### LogRecord {#LogRecord1}

Field | Description
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log record timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
message | **map<string,string>**<br>Contents of the log record. 


## ListOperations {#ListOperations}

Retrieves the list of Operation resources for the specified cluster.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse Cluster resource to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation10)**<br>List of Operation resources for the specified ClickHouse cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest), use the `next_page_token` as the value for the [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation10}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any. 


## ListBackups {#ListBackups}

Retrieves the list of available backups for the specified ClickHouse cluster.

**rpc ListBackups ([ListClusterBackupsRequest](#ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#ListClusterBackupsResponse))**

### ListClusterBackupsRequest {#ListClusterBackupsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster. To get the ClickHouse cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterBackupsResponse {#ListClusterBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup)**<br>List of ClickHouse Backup resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterBackupsRequest.page_size](#ListClusterBackupsRequest), use the `next_page_token` as the value for the [ListClusterBackupsRequest.page_token](#ListClusterBackupsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format (i.e. when the backup operation was completed). 
source_cluster_id | **string**<br>ID of the ClickHouse cluster that the backup was created for. 
source_shard_names[] | **string**<br>Names of the shards included in the backup. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was started. 


## ListHosts {#ListHosts}

Retrieves a list of hosts for the specified cluster.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster. To get the ClickHouse cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](#Host)**<br>Requested list of hosts for the cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
name | **string**<br>Name of the ClickHouse host. The host name is assigned by MDB at creation time, and cannot be changed. 1-63 characters long. <br>The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. 
cluster_id | **string**<br>ID of the ClickHouse host. The ID is assigned by MDB at creation time. 
zone_id | **string**<br>ID of the availability zone where the ClickHouse host resides. 
type | enum **Type**<br>Type of the host. <ul><li>`CLICKHOUSE`: ClickHouse host.</li><li>`ZOOKEEPER`: ZooKeeper host.</li></ul>
resources | **[Resources](#Resources11)**<br>Resources allocated to the ClickHouse host. 
health | enum **Health**<br>Status code of the aggregated health of the host. <ul><li>`UNKNOWN`: Health of the host is unknown.</li><li>`ALIVE`: The host is performing all its functions normally.</li><li>`DEAD`: The host is inoperable, and cannot perform any of its essential functions.</li><li>`DEGRADED`: The host is degraded, and can perform only some of its essential functions.</li></ul>
services[] | **[Service](#Service)**<br>Services provided by the host. 
subnet_id | **string**<br>ID of the subnet that the host belongs to. 
assign_public_ip | **bool**<br>Flag showing public IP assignment status to this host. 
shard_name | **string**<br> 


### Resources {#Resources11}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Service {#Service}

Field | Description
--- | ---
type | enum **Type**<br>Type of the service provided by the host. <ul><li>`CLICKHOUSE`: The host is a ClickHouse server.</li><li>`ZOOKEEPER`: The host is a ZooKeeper server.</li></ul>
health | enum **Health**<br>Status code of server availability. <ul><li>`UNKNOWN`: Health of the server is unknown.</li><li>`ALIVE`: The server is working normally.</li><li>`DEAD`: The server is dead or unresponsive.</li></ul>


## AddHosts {#AddHosts}

Creates new hosts for a cluster.

**rpc AddHosts ([AddClusterHostsRequest](#AddClusterHostsRequest)) returns ([operation.Operation](#Operation11))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterHostsMetadata](#AddClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddClusterHostsRequest {#AddClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to add hosts to. To get the ClickHouse cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
host_specs[] | **[HostSpec](#HostSpec)**<br>Configurations for ClickHouse hosts that should be added to the cluster. The number of elements must be greater than 0.
copy_schema | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether to copy schema to new ClickHouse hosts from replicas. 


### HostSpec {#HostSpec3}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
type | **[Host.Type](#Host1)**<br>Required. Type of the host to be deployed. 
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the [Cluster.network_id](#Cluster11) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 
shard_name | **string**<br>Name of the shard that the host is assigned to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation11}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddClusterHostsMetadata](#AddClusterHostsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### AddClusterHostsMetadata {#AddClusterHostsMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ClickHouse cluster to which the hosts are being added. 
host_names[] | **string**<br>Names of hosts that are being added to the cluster. 


## UpdateHosts {#UpdateHosts}

Updates the specified hosts.

**rpc UpdateHosts ([UpdateClusterHostsRequest](#UpdateClusterHostsRequest)) returns ([operation.Operation](#Operation12))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterHostsMetadata](#UpdateClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateClusterHostsRequest {#UpdateClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to update hosts in. To get the ClickHouse cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_host_specs[] | **[UpdateHostSpec](#UpdateHostSpec)**<br>New configurations to apply to hosts. The number of elements must be greater than 0.


### UpdateHostSpec {#UpdateHostSpec}

Field | Description
--- | ---
host_name | **string**<br>Required. Name of the host to update. To get the ClickHouse host name, use a [ClusterService.ListHosts](#ListHosts) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the ClickHouse host should be updated. 
assign_public_ip | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the host should get a public IP address on creation. 


### Operation {#Operation12}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateClusterHostsMetadata](#UpdateClusterHostsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### UpdateClusterHostsMetadata {#UpdateClusterHostsMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ClickHouse cluster to modify hosts in. 
host_names[] | **string**<br>Names of hosts that are being modified. 


## DeleteHosts {#DeleteHosts}

Deletes the specified hosts for a cluster.

**rpc DeleteHosts ([DeleteClusterHostsRequest](#DeleteClusterHostsRequest)) returns ([operation.Operation](#Operation13))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterHostsMetadata](#DeleteClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterHostsRequest {#DeleteClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to remove hosts from. To get the ClickHouse cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
host_names[] | **string**<br>Names of hosts to delete. The number of elements must be greater than 0. The maximum string length in characters for each value is 253.


### Operation {#Operation13}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteClusterHostsMetadata](#DeleteClusterHostsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteClusterHostsMetadata {#DeleteClusterHostsMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ClickHouse cluster to remove hosts from. 
host_names[] | **string**<br>Names of hosts that are being deleted. 


## GetShard {#GetShard}

Returns the specified shard.

**rpc GetShard ([GetClusterShardRequest](#GetClusterShardRequest)) returns ([Shard](#Shard))**

### GetClusterShardRequest {#GetClusterShardRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster that the shard belongs to. To get the cluster ID, use a [ClusterService.List](#List) request. To get the name of the database, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name of the shard to request information about. To get the name of a shard, use a [ClusterService.ListShards](#ListShards) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Shard {#Shard}

Field | Description
--- | ---
name | **string**<br>Name of the shard. 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 
config | **[ShardConfig](#ShardConfig)**<br>Configuration of the shard. 


### ShardConfig {#ShardConfig}

Field | Description
--- | ---
clickhouse | **[Clickhouse](#Clickhouse14)**<br>ClickHouse configuration for a shard. 


### Clickhouse {#Clickhouse14}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet11)**<br>ClickHouse settings for a shard. 
resources | **[Resources](#Resources12)**<br>Computational resources for a shard. 
weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Relative weight of a shard considered when writing data to the cluster. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/operations/table_engines/distributed/). 


### ClickhouseConfigSet {#ClickhouseConfigSet11}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig14)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig14)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig14)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig14}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree14)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression14)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary14)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup14)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka14)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic14)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq14)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree14}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka14}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic14}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka14)**<br>Required.  


### Rabbitmq {#Rabbitmq14}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression14}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary14}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure14)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout14)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range14)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource14)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource14)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource14)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource14)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource14)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource14}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource14}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica14)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica14}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource14}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource14}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource14}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure14}

Field | Description
--- | ---
id | **[Id](#Id14)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key14)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute14)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute14)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute14)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute14}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id14}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key14}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute14)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout14}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range14}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup14}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern14)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern14}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention14)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention14}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources12}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


## ListShards {#ListShards}

Retrieves a list of shards that belong to the specified cluster.

**rpc ListShards ([ListClusterShardsRequest](#ListClusterShardsRequest)) returns ([ListClusterShardsResponse](#ListClusterShardsResponse))**

### ListClusterShardsRequest {#ListClusterShardsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to list shards in. To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterShardsResponse.next_page_token](#ListClusterShardsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token.  to get the next page of results, set `page_token` to the [ListClusterShardsResponse.next_page_token](#ListClusterShardsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterShardsResponse {#ListClusterShardsResponse}

Field | Description
--- | ---
shards[] | **[Shard](#Shard1)**<br>List of ClickHouse shards. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterShardsRequest.page_size](#ListClusterShardsRequest), use the `next_page_token` as the value for the [ListClusterShardsRequest.page_token](#ListClusterShardsRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Shard {#Shard1}

Field | Description
--- | ---
name | **string**<br>Name of the shard. 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 
config | **[ShardConfig](#ShardConfig1)**<br>Configuration of the shard. 


### ShardConfig {#ShardConfig1}

Field | Description
--- | ---
clickhouse | **[Clickhouse](#Clickhouse15)**<br>ClickHouse configuration for a shard. 


### Clickhouse {#Clickhouse15}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet12)**<br>ClickHouse settings for a shard. 
resources | **[Resources](#Resources13)**<br>Computational resources for a shard. 
weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Relative weight of a shard considered when writing data to the cluster. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/operations/table_engines/distributed/). 


### ClickhouseConfigSet {#ClickhouseConfigSet12}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig15)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig15)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig15)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig15}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree15)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression15)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary15)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup15)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka15)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic15)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq15)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree15}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka15}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic15}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka15)**<br>Required.  


### Rabbitmq {#Rabbitmq15}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression15}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary15}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure15)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout15)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range15)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource15)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource15)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource15)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource15)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource15)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource15}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource15}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica15)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica15}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource15}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource15}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource15}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure15}

Field | Description
--- | ---
id | **[Id](#Id15)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key15)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute15)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute15)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute15)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute15}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id15}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key15}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute15)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout15}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range15}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup15}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern15)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern15}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention15)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention15}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources13}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


## AddShard {#AddShard}

Creates a new shard in the specified cluster.

**rpc AddShard ([AddClusterShardRequest](#AddClusterShardRequest)) returns ([operation.Operation](#Operation14))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterShardMetadata](#AddClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Shard](#Shard2)<br>

### AddClusterShardRequest {#AddClusterShardRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to add a shard to. To get the ClickHouse cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name for the new shard. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
config_spec | **[ShardConfigSpec](#ShardConfigSpec)**<br>Configuration of the new shard. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Configurations for ClickHouse hosts that should be created with the shard. The number of elements must be greater than 0.
copy_schema | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether to copy schema to hosts of the shard to be created. The schema is copied from hosts of an existing shard. 


### ShardConfigSpec {#ShardConfigSpec}

Field | Description
--- | ---
clickhouse | **[Clickhouse](#Clickhouse16)**<br>ClickHouse configuration for a shard. 


### Clickhouse {#Clickhouse16}

Field | Description
--- | ---
config | **[config.ClickhouseConfig](#ClickhouseConfig16)**<br>ClickHouse settings for the shard. 
resources | **[Resources](#Resources14)**<br>Computational resources for the shard. 
weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Relative weight of the shard considered when writing data to the cluster. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/operations/table_engines/distributed/). 


### ClickhouseConfig {#ClickhouseConfig16}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree16)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression16)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary16)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup16)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka16)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic16)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq16)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree16}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka16}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic16}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka16)**<br>Required.  


### Rabbitmq {#Rabbitmq16}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression16}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary16}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure16)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout16)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range16)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource16)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource16)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource16)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource16)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource16)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource16}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource16}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica16)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica16}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource16}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource16}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource16}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure16}

Field | Description
--- | ---
id | **[Id](#Id16)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key16)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute16)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute16)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute16)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute16}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id16}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key16}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute16)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout16}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range16}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup16}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern16)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern16}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention16)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention16}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources14}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### HostSpec {#HostSpec4}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
type | **[Host.Type](#Host1)**<br>Required. Type of the host to be deployed. 
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the [Cluster.network_id](#Cluster11) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 
shard_name | **string**<br>Name of the shard that the host is assigned to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation14}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddClusterShardMetadata](#AddClusterShardMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Shard](#Shard2)>**<br>if operation finished successfully. 


### AddClusterShardMetadata {#AddClusterShardMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the cluster that a shard is being added to. 
shard_name | **string**<br>Name of the shard being created. 


### Shard {#Shard2}

Field | Description
--- | ---
name | **string**<br>Name of the shard. 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 
config | **[ShardConfig](#ShardConfig2)**<br>Configuration of the shard. 


### ShardConfig {#ShardConfig2}

Field | Description
--- | ---
clickhouse | **[Clickhouse](#Clickhouse17)**<br>ClickHouse configuration for a shard. 


### Clickhouse {#Clickhouse17}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet13)**<br>ClickHouse settings for a shard. 
resources | **[Resources](#Resources15)**<br>Computational resources for a shard. 
weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Relative weight of a shard considered when writing data to the cluster. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/operations/table_engines/distributed/). 


### ClickhouseConfigSet {#ClickhouseConfigSet13}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig17)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig17)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig17)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig17}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree17)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression17)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary17)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup17)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka17)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic17)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq17)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree17}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka17}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic17}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka17)**<br>Required.  


### Rabbitmq {#Rabbitmq17}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression17}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary17}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure17)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout17)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range17)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource17)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource17)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource17)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource17)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource17)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource17}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource17}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica17)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica17}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource17}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource17}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource17}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure17}

Field | Description
--- | ---
id | **[Id](#Id17)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key17)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute17)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute17)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute17)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute17}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id17}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key17}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute17)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout17}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range17}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup17}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern17)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern17}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention17)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention17}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


## UpdateShard {#UpdateShard}

Modifies the specified shard.

**rpc UpdateShard ([UpdateClusterShardRequest](#UpdateClusterShardRequest)) returns ([operation.Operation](#Operation15))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterShardMetadata](#UpdateClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Shard](#Shard3)<br>

### UpdateClusterShardRequest {#UpdateClusterShardRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster the shard belongs to. To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name of the shard to be updated. To get the name of a shard, use a [ClusterService.ListShards](#ListShards) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the ClickHouse shard should be updated. 
config_spec | **[ShardConfigSpec](#ShardConfigSpec)**<br>New configuration for the specified shard. 


### ShardConfigSpec {#ShardConfigSpec1}

Field | Description
--- | ---
clickhouse | **[Clickhouse](#Clickhouse18)**<br>ClickHouse configuration for a shard. 


### Clickhouse {#Clickhouse18}

Field | Description
--- | ---
config | **[config.ClickhouseConfig](#ClickhouseConfig18)**<br>ClickHouse settings for the shard. 
resources | **[Resources](#Resources15)**<br>Computational resources for the shard. 
weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Relative weight of the shard considered when writing data to the cluster. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/operations/table_engines/distributed/). 


### ClickhouseConfig {#ClickhouseConfig18}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree18)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression18)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary18)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup18)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka18)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic18)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq18)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree18}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka18}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic18}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka18)**<br>Required.  


### Rabbitmq {#Rabbitmq18}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression18}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary18}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure18)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout18)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range18)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource18)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource18)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource18)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource18)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource18)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource18}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource18}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica18)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica18}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource18}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource18}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource18}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure18}

Field | Description
--- | ---
id | **[Id](#Id18)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key18)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute18)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute18)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute18)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute18}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id18}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key18}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute18)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout18}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range18}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup18}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern18)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern18}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention18)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention18}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources15}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Operation {#Operation15}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateClusterShardMetadata](#UpdateClusterShardMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Shard](#Shard3)>**<br>if operation finished successfully. 


### UpdateClusterShardMetadata {#UpdateClusterShardMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the cluster that contains the shard being updated. 
shard_name | **string**<br>Name of the shard being updated. 


### Shard {#Shard3}

Field | Description
--- | ---
name | **string**<br>Name of the shard. 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 
config | **[ShardConfig](#ShardConfig3)**<br>Configuration of the shard. 


### ShardConfig {#ShardConfig3}

Field | Description
--- | ---
clickhouse | **[Clickhouse](#Clickhouse19)**<br>ClickHouse configuration for a shard. 


### Clickhouse {#Clickhouse19}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet14)**<br>ClickHouse settings for a shard. 
resources | **[Resources](#Resources16)**<br>Computational resources for a shard. 
weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Relative weight of a shard considered when writing data to the cluster. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/operations/table_engines/distributed/). 


### ClickhouseConfigSet {#ClickhouseConfigSet14}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig19)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig19)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig19)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig19}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree19)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression19)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary19)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup19)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka19)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic19)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq19)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree19}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka19}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic19}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka19)**<br>Required.  


### Rabbitmq {#Rabbitmq19}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression19}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary19}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure19)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout19)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range19)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource19)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource19)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource19)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource19)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource19)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource19}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource19}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica19)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica19}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource19}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource19}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource19}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure19}

Field | Description
--- | ---
id | **[Id](#Id19)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key19)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute19)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute19)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute19)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute19}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id19}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key19}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute19)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout19}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range19}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup19}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern19)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern19}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention19)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention19}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


## DeleteShard {#DeleteShard}

Deletes the specified shard.

**rpc DeleteShard ([DeleteClusterShardRequest](#DeleteClusterShardRequest)) returns ([operation.Operation](#Operation16))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterShardMetadata](#DeleteClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterShardRequest {#DeleteClusterShardRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster the shard belongs to. To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name of the shard to be deleted. To get the name of a shard, use a [ClusterService.ListShards](#ListShards) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation16}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteClusterShardMetadata](#DeleteClusterShardMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteClusterShardMetadata {#DeleteClusterShardMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the cluster that contains the shard being deleted. 
shard_name | **string**<br>Name of the shard being deleted. 


## GetShardGroup {#GetShardGroup}

Returns the specified shard group.

**rpc GetShardGroup ([GetClusterShardGroupRequest](#GetClusterShardGroupRequest)) returns ([ShardGroup](#ShardGroup))**

### GetClusterShardGroupRequest {#GetClusterShardGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster that the shard group belongs to. <br>To get the cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
shard_group_name | **string**<br>Required. Name of the shard group to request information about. <br>To get the name of a shard group, make a [ClusterService.ListShardGroups](#ListShardGroups) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### ShardGroup {#ShardGroup}

Field | Description
--- | ---
name | **string**<br>Name of the shard group. 
cluster_id | **string**<br>ID of the ClickHouse cluster that the shard group belongs to. 
description | **string**<br>Description of the shard group. 0-256 characters long. 
shard_names[] | **string**<br>List of shard names contained in the shard group. 


## ListShardGroups {#ListShardGroups}

Retrieves a list of shard groups that belong to specified cluster.

**rpc ListShardGroups ([ListClusterShardGroupsRequest](#ListClusterShardGroupsRequest)) returns ([ListClusterShardGroupsResponse](#ListClusterShardGroupsResponse))**

### ListClusterShardGroupsRequest {#ListClusterShardGroupsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster that the shard group belongs to. <br>To get the cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterShardGroupsResponse.next_page_token](#ListClusterShardGroupsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListClusterShardGroupsResponse.next_page_token](#ListClusterShardGroupsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterShardGroupsResponse {#ListClusterShardGroupsResponse}

Field | Description
--- | ---
shard_groups[] | **[ShardGroup](#ShardGroup1)**<br>List of ClickHouse cluster's shard groups. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterShardGroupsRequest.page_size](#ListClusterShardGroupsRequest), use the `next_page_token` as the value for the [ListClusterShardGroupsRequest.page_token](#ListClusterShardGroupsRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### ShardGroup {#ShardGroup1}

Field | Description
--- | ---
name | **string**<br>Name of the shard group. 
cluster_id | **string**<br>ID of the ClickHouse cluster that the shard group belongs to. 
description | **string**<br>Description of the shard group. 0-256 characters long. 
shard_names[] | **string**<br>List of shard names contained in the shard group. 


## CreateShardGroup {#CreateShardGroup}

Creates a new shard group in the specified cluster.

**rpc CreateShardGroup ([CreateClusterShardGroupRequest](#CreateClusterShardGroupRequest)) returns ([operation.Operation](#Operation17))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterShardGroupMetadata](#CreateClusterShardGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ShardGroup](#ShardGroup2)<br>

### CreateClusterShardGroupRequest {#CreateClusterShardGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to add a shard group to. <br>To get the cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
shard_group_name | **string**<br>Required. Name for the new shard group. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the new shard group. 0-256 characters long. 
shard_names[] | **string**<br>List of shard names that should be put into the new group. <br>To get the list, make a [ClusterService.ListShardGroups](#ListShardGroups) request. 


### Operation {#Operation17}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateClusterShardGroupMetadata](#CreateClusterShardGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ShardGroup](#ShardGroup2)>**<br>if operation finished successfully. 


### CreateClusterShardGroupMetadata {#CreateClusterShardGroupMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the cluster to add a shard group to. 
shard_group_name | **string**<br>Name of the shard group that is being added. 


### ShardGroup {#ShardGroup2}

Field | Description
--- | ---
name | **string**<br>Name of the shard group. 
cluster_id | **string**<br>ID of the ClickHouse cluster that the shard group belongs to. 
description | **string**<br>Description of the shard group. 0-256 characters long. 
shard_names[] | **string**<br>List of shard names contained in the shard group. 


## UpdateShardGroup {#UpdateShardGroup}

Updates the specified shard group.

**rpc UpdateShardGroup ([UpdateClusterShardGroupRequest](#UpdateClusterShardGroupRequest)) returns ([operation.Operation](#Operation18))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterShardGroupMetadata](#UpdateClusterShardGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ShardGroup](#ShardGroup3)<br>

### UpdateClusterShardGroupRequest {#UpdateClusterShardGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster that contains the shard group to update. <br>To get the cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
shard_group_name | **string**<br>Required. Name of the shard group that should be updated. <br>To get the name, make a [ClusterService.ListShardGroups](#ListShardGroups) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
description | **string**<br>Updated description of the shard group. 0-256 characters long. 
shard_names[] | **string**<br>Updated list of shard names that belongs to the shard group. 


### Operation {#Operation18}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateClusterShardGroupMetadata](#UpdateClusterShardGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ShardGroup](#ShardGroup3)>**<br>if operation finished successfully. 


### UpdateClusterShardGroupMetadata {#UpdateClusterShardGroupMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the cluster that contains the shard group being updated. 
shard_group_name | **string**<br>Name of the shard group that is being updated. 


### ShardGroup {#ShardGroup3}

Field | Description
--- | ---
name | **string**<br>Name of the shard group. 
cluster_id | **string**<br>ID of the ClickHouse cluster that the shard group belongs to. 
description | **string**<br>Description of the shard group. 0-256 characters long. 
shard_names[] | **string**<br>List of shard names contained in the shard group. 


## DeleteShardGroup {#DeleteShardGroup}

Deletes the specified shard group.

**rpc DeleteShardGroup ([DeleteClusterShardGroupRequest](#DeleteClusterShardGroupRequest)) returns ([operation.Operation](#Operation19))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterShardGroupMetadata](#DeleteClusterShardGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterShardGroupRequest {#DeleteClusterShardGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster that contains the shard group to delete. <br>To get the cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
shard_group_name | **string**<br>Required. Name of the shard group that should be deleted. <br>To get the name, make a [ClusterService.ListShardGroups](#ListShardGroups) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation19}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteClusterShardGroupMetadata](#DeleteClusterShardGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteClusterShardGroupMetadata {#DeleteClusterShardGroupMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the cluster that contains the shard group being deleted. 
shard_group_name | **string**<br>Name of the shard group that is being deleted. 


## ListExternalDictionaries {#ListExternalDictionaries}

Retrieves a list of external dictionaries that belong to specified cluster.

**rpc ListExternalDictionaries ([ListClusterExternalDictionariesRequest](#ListClusterExternalDictionariesRequest)) returns ([ListClusterExternalDictionariesResponse](#ListClusterExternalDictionariesResponse))**

### ListClusterExternalDictionariesRequest {#ListClusterExternalDictionariesRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster that the external dictionaries belong to. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterExternalDictionaryResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterExternalDictionaryResponse.next_page_token] returned by a previous list request. The maximum string length in characters is 100.


### ListClusterExternalDictionariesResponse {#ListClusterExternalDictionariesResponse}

Field | Description
--- | ---
external_dictionaries[] | **[config.ClickhouseConfig.ExternalDictionary](#ClickhouseConfig20)**<br>List of ClickHouse Cluster external dictionaries. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterExternalDictionaryRequest.page_size], use the `next_page_token` as the value for the [ListClusterExternalDictionaryRequest.page_token] parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


## CreateExternalDictionary {#CreateExternalDictionary}

Creates an external dictionary for the specified ClickHouse cluster.

**rpc CreateExternalDictionary ([CreateClusterExternalDictionaryRequest](#CreateClusterExternalDictionaryRequest)) returns ([operation.Operation](#Operation20))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterExternalDictionaryMetadata](#CreateClusterExternalDictionaryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster11)<br>

### CreateClusterExternalDictionaryRequest {#CreateClusterExternalDictionaryRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to create the external dictionary for. To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
external_dictionary | **[config.ClickhouseConfig.ExternalDictionary](#ClickhouseConfig20)**<br>Configuration of the external dictionary. 


### Operation {#Operation20}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateClusterExternalDictionaryMetadata](#CreateClusterExternalDictionaryMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster11)>**<br>if operation finished successfully. 


### CreateClusterExternalDictionaryMetadata {#CreateClusterExternalDictionaryMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the cluster for which an external dictionary is being created. 


### Cluster {#Cluster11}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring11)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig11)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host1) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host1) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host1) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host1) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow11)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation11)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring11}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the ClickHouse cluster. 


### ClusterConfig {#ClusterConfig11}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse20)**<br>Configuration and resource allocation for ClickHouse hosts. 
zookeeper | **[Zookeeper](#Zookeeper14)**<br>Configuration and resource allocation for ZooKeeper hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access11)**<br>Access policy for external services. 
cloud_storage | **[CloudStorage](#CloudStorage11)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper. 


### Clickhouse {#Clickhouse20}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet15)**<br>Configuration settings of a ClickHouse server. 
resources | **[Resources](#Resources16)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper14}

Field | Description
--- | ---
resources | **[Resources](#Resources16)**<br>Resources allocated to ZooKeeper hosts. 


### Access {#Access11}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. 
metrika | **bool**<br>Allow to import data from Yandex Metrica and AppMetrica to the cluster. <br>See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. 
serverless | **bool**<br>Allow access to cluster for Serverless. 
data_transfer | **bool**<br>Allow access for DataTransfer 
yandex_query | **bool**<br>Allow access for Query 


### CloudStorage {#CloudStorage11}

Field | Description
--- | ---
enabled | **bool**<br>Whether to use Object Storage for storing ClickHouse data. 
move_factor | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> Acceptable values are 0 to 1, inclusive.
data_cache_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
data_cache_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### ClickhouseConfigSet {#ClickhouseConfigSet15}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig20)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig20)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig20)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig20}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree20)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression20)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary20)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup20)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka20)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic20)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq20)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree20}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka20}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic20}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka20)**<br>Required.  


### Rabbitmq {#Rabbitmq20}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression20}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary20}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure20)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout20)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range20)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource20)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource20)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource20)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource20)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource20)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource20}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource20}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica20)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica20}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource20}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource20}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource20}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure20}

Field | Description
--- | ---
id | **[Id](#Id20)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key20)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute20)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute20)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute20)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute20}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id20}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key20}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute20)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout20}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range20}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup20}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern20)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern20}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention20)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention20}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources16}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### MaintenanceWindow {#MaintenanceWindow11}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow11)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow11)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow11}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow11}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week (in `DDD` format). 
hour | **int64**<br>Hour of the day in UTC (in `HH` format). Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation11}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## UpdateExternalDictionary {#UpdateExternalDictionary}

Updates an external dictionary for the specified ClickHouse cluster.

**rpc UpdateExternalDictionary ([UpdateClusterExternalDictionaryRequest](#UpdateClusterExternalDictionaryRequest)) returns ([operation.Operation](#Operation21))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterExternalDictionaryMetadata](#UpdateClusterExternalDictionaryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster12)<br>

### UpdateClusterExternalDictionaryRequest {#UpdateClusterExternalDictionaryRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to update the external dictionary for. To get the cluster ID, use a [List](#List) request. The maximum string length in characters is 50.
external_dictionary | **[config.ClickhouseConfig.ExternalDictionary](#ClickhouseConfig21)**<br>Configuration of the external dictionary. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the External Dictionary should be updated. 


### Operation {#Operation21}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateClusterExternalDictionaryMetadata](#UpdateClusterExternalDictionaryMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster12)>**<br>if operation finished successfully. 


### UpdateClusterExternalDictionaryMetadata {#UpdateClusterExternalDictionaryMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the cluster for which an external dictionary is being updated. 
external_dictionary_name | **string**<br>Name of the external dictionary. 


### Cluster {#Cluster12}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring12)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig12)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host1) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host1) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host1) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host1) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow12)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation12)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring12}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the ClickHouse cluster. 


### ClusterConfig {#ClusterConfig12}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse21)**<br>Configuration and resource allocation for ClickHouse hosts. 
zookeeper | **[Zookeeper](#Zookeeper15)**<br>Configuration and resource allocation for ZooKeeper hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access12)**<br>Access policy for external services. 
cloud_storage | **[CloudStorage](#CloudStorage12)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper. 


### Clickhouse {#Clickhouse21}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet16)**<br>Configuration settings of a ClickHouse server. 
resources | **[Resources](#Resources17)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper15}

Field | Description
--- | ---
resources | **[Resources](#Resources17)**<br>Resources allocated to ZooKeeper hosts. 


### Access {#Access12}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. 
metrika | **bool**<br>Allow to import data from Yandex Metrica and AppMetrica to the cluster. <br>See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. 
serverless | **bool**<br>Allow access to cluster for Serverless. 
data_transfer | **bool**<br>Allow access for DataTransfer 
yandex_query | **bool**<br>Allow access for Query 


### CloudStorage {#CloudStorage12}

Field | Description
--- | ---
enabled | **bool**<br>Whether to use Object Storage for storing ClickHouse data. 
move_factor | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> Acceptable values are 0 to 1, inclusive.
data_cache_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
data_cache_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### ClickhouseConfigSet {#ClickhouseConfigSet16}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig21)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig21)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig21)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig21}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree21)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression21)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary21)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup21)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka21)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic21)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq21)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree21}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka21}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic21}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka21)**<br>Required.  


### Rabbitmq {#Rabbitmq21}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression21}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary21}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure21)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout21)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range21)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource21)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource21)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource21)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource21)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource21)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource21}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource21}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica21)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica21}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource21}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource21}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource21}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure21}

Field | Description
--- | ---
id | **[Id](#Id21)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key21)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute21)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute21)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute21)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute21}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id21}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key21}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute21)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout21}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range21}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup21}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern21)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern21}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention21)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention21}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources17}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### MaintenanceWindow {#MaintenanceWindow12}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow12)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow12)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow12}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow12}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week (in `DDD` format). 
hour | **int64**<br>Hour of the day in UTC (in `HH` format). Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation12}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## DeleteExternalDictionary {#DeleteExternalDictionary}

Deletes the specified external dictionary.

**rpc DeleteExternalDictionary ([DeleteClusterExternalDictionaryRequest](#DeleteClusterExternalDictionaryRequest)) returns ([operation.Operation](#Operation22))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterExternalDictionaryMetadata](#DeleteClusterExternalDictionaryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster13)<br>

### DeleteClusterExternalDictionaryRequest {#DeleteClusterExternalDictionaryRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to delete the external dictionary from. To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
external_dictionary_name | **string**<br>Name of the external dictionary to delete. 


### Operation {#Operation22}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteClusterExternalDictionaryMetadata](#DeleteClusterExternalDictionaryMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster13)>**<br>if operation finished successfully. 


### DeleteClusterExternalDictionaryMetadata {#DeleteClusterExternalDictionaryMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the cluster where an external dictionary is being deleted. 


### Cluster {#Cluster13}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring13)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig13)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host1) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host1) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host1) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host1) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow13)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation13)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring13}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the ClickHouse cluster. 


### ClusterConfig {#ClusterConfig13}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse22)**<br>Configuration and resource allocation for ClickHouse hosts. 
zookeeper | **[Zookeeper](#Zookeeper16)**<br>Configuration and resource allocation for ZooKeeper hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access13)**<br>Access policy for external services. 
cloud_storage | **[CloudStorage](#CloudStorage13)**<br> 
sql_database_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether database management through SQL commands is enabled. 
sql_user_management | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether user management through SQL commands is enabled. 
embedded_keeper | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether cluster should use embedded Keeper instead of Zookeeper. 


### Clickhouse {#Clickhouse22}

Field | Description
--- | ---
config | **[config.ClickhouseConfigSet](#ClickhouseConfigSet17)**<br>Configuration settings of a ClickHouse server. 
resources | **[Resources](#Resources18)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper16}

Field | Description
--- | ---
resources | **[Resources](#Resources18)**<br>Resources allocated to ZooKeeper hosts. 


### Access {#Access13}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. 
metrika | **bool**<br>Allow to import data from Yandex Metrica and AppMetrica to the cluster. <br>See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. 
serverless | **bool**<br>Allow access to cluster for Serverless. 
data_transfer | **bool**<br>Allow access for DataTransfer 
yandex_query | **bool**<br>Allow access for Query 


### CloudStorage {#CloudStorage13}

Field | Description
--- | ---
enabled | **bool**<br>Whether to use Object Storage for storing ClickHouse data. 
move_factor | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> Acceptable values are 0 to 1, inclusive.
data_cache_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
data_cache_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### ClickhouseConfigSet {#ClickhouseConfigSet17}

Field | Description
--- | ---
effective_config | **[ClickhouseConfig](#ClickhouseConfig22)**<br>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[ClickhouseConfig](#ClickhouseConfig22)**<br>User-defined settings for a ClickHouse cluster. 
default_config | **[ClickhouseConfig](#ClickhouseConfig22)**<br>Default configuration for a ClickHouse cluster. 


### ClickhouseConfig {#ClickhouseConfig22}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
merge_tree | **[MergeTree](#MergeTree22)**<br>Settings for the MergeTree engine. See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). 
compression[] | **[Compression](#Compression22)**<br>Compression settings for the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). 
dictionaries[] | **[ExternalDictionary](#ExternalDictionary22)**<br>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). 
graphite_rollup[] | **[GraphiteRollup](#GraphiteRollup22)**<br>Settings for thinning Graphite data. See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). 
kafka | **[Kafka](#Kafka22)**<br> 
kafka_topics[] | **[KafkaTopic](#KafkaTopic22)**<br> 
rabbitmq | **[Rabbitmq](#Rabbitmq22)**<br> 
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. The minimum value is 10.
max_concurrent_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of simultaneously processed requests. The minimum value is 10.
keep_alive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. 
uncompressed_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Cache size (in bytes) for uncompressed data used by MergeTree tables. 
mark_cache_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. Value must be greater than 0.
max_table_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the table that can be deleted using a DROP query. 
max_partition_size_to_drop | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the partition that can be deleted using a DROP query. 
builtin_dictionaries_reload_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The setting is deprecated and has no effect. 
timezone | **string**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 
geobase_uri | **string**<br>Address of the archive with the user geobase in Object Storage. 
query_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled. 
query_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled. 
query_thread_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query_thread_log system table is enabled. 
query_thread_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled. 
query_thread_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled. 
part_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled. 
part_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled. 
metric_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether metric_log system table is enabled. 
metric_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled. 
metric_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled. 
trace_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether trace_log system table is enabled. 
trace_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled. 
trace_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled. 
text_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether text_log system table is enabled. 
text_log_retention_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled. 
text_log_retention_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled. 
text_log_level | enum **LogLevel**<br>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. 
opentelemetry_span_log_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
background_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_fetches_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). Value must be greater than 0.
background_move_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_distributed_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_buffer_flush_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
background_message_broker_schedule_pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Value must be greater than 0.
default_database | **google.protobuf.StringValue**<br>The default database. <br>To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db). 
total_memory_profiler_step | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). 
total_memory_tracker_sample_probability | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br> 


### MergeTree {#MergeTree22}

Field | Description
--- | ---
replicated_deduplication_window | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of blocks of hashes to keep in ZooKeeper. 
replicated_deduplication_window_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Period of time to keep blocks of hashes for. 
parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If table contains at least that many active parts in single partition, artificially slow down insert into table. 
parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If more than this number active parts in single partition, throw 'Too many parts ...' exception. 
inactive_parts_to_delay_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
inactive_parts_to_throw_insert | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_replicated_merges_in_queue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. 
number_of_free_entries_in_pool_to_lower_max_size_of_merge | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process. 
max_bytes_to_merge_at_min_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue). 
max_bytes_to_merge_at_max_space_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
min_bytes_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of bytes in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
min_rows_for_wide_part | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum number of rows in a data part that can be stored in **Wide** format. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). 
ttl_only_drop_parts | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables. <br>More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). 
allow_remote_fs_zero_copy_replication | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
merge_with_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
merge_with_recompression_ttl_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_parts_in_total | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_number_of_merges_with_ttl_in_pool | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
cleanup_delay_period | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
number_of_free_entries_in_pool_to_execute_mutation | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### Kafka {#Kafka22}

Field | Description
--- | ---
security_protocol | enum **SecurityProtocol**<br> 
sasl_mechanism | enum **SaslMechanism**<br> 
sasl_username | **string**<br> 
sasl_password | **string**<br> 


### KafkaTopic {#KafkaTopic22}

Field | Description
--- | ---
name | **string**<br>Required.  
settings | **[Kafka](#Kafka22)**<br>Required.  


### Rabbitmq {#Rabbitmq22}

Field | Description
--- | ---
username | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username 
password | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password 
vhost | **string**<br>[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host 


### Compression {#Compression22}

Field | Description
--- | ---
method | enum **Method**<br>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`. <ul><li>`LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).</li><li>`ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/).</li></ul>
min_part_size | **int64**<br>Minimum size of a part of a table. The minimum value is 1.
min_part_size_ratio | **double**<br>Minimum ratio of a part relative to the size of all the data in the table. 


### ExternalDictionary {#ExternalDictionary22}

Field | Description
--- | ---
name | **string**<br>Required. Name of the external dictionary. 
structure | **[Structure](#Structure22)**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). 
layout | **[Layout](#Layout22)**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). 
lifetime | **oneof:** `fixed_lifetime` or `lifetime_range`<br>Setting for the period of time between dictionary updates. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
&nbsp;&nbsp;fixed_lifetime | **int64**<br>Fixed interval between dictionary updates. 
&nbsp;&nbsp;lifetime_range | **[Range](#Range22)**<br>Range of intervals between dictionary updates for ClickHouse to choose from. 
source | **oneof:** `http_source`, `mysql_source`, `clickhouse_source`, `mongodb_source` or `postgresql_source`<br>Description of the source for the external dictionary.
&nbsp;&nbsp;http_source | **[HttpSource](#HttpSource22)**<br>HTTP source for the dictionary. 
&nbsp;&nbsp;mysql_source | **[MysqlSource](#MysqlSource22)**<br>MySQL source for the dictionary. 
&nbsp;&nbsp;clickhouse_source | **[ClickhouseSource](#ClickhouseSource22)**<br>ClickHouse source for the dictionary. 
&nbsp;&nbsp;mongodb_source | **[MongodbSource](#MongodbSource22)**<br>MongoDB source for the dictionary. 
&nbsp;&nbsp;postgresql_source | **[PostgresqlSource](#PostgresqlSource22)**<br>PostgreSQL source for the dictionary. 


### HttpSource {#HttpSource22}

Field | Description
--- | ---
url | **string**<br>Required. URL of the source dictionary available over HTTP. 
format | **string**<br>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect. 


### MysqlSource {#MysqlSource22}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MySQL database to connect to. 
table | **string**<br>Required. Name of the database table to use as a ClickHouse dictionary. 
port | **int64**<br>Default port to use when connecting to a replica of the dictionary source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the default user for replicas of the dictionary source. 
password | **string**<br>Password of the default user for replicas of the dictionary source. 
replicas[] | **[Replica](#Replica22)**<br>List of MySQL replicas of the database used as dictionary source. The number of elements must be greater than 0.
where | **string**<br>Selection criteria for the data in the specified MySQL table. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 


### Replica {#Replica22}

Field | Description
--- | ---
host | **string**<br>Required. MySQL host of the replica. The maximum string length in characters is 253.
priority | **int64**<br>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number. Value must be greater than 0.
port | **int64**<br>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Name of the MySQL database user. 
password | **string**<br>Password of the MySQL database user. 


### ClickhouseSource {#ClickhouseSource22}

Field | Description
--- | ---
db | **string**<br>Required. Name of the ClickHouse database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
host | **string**<br>Required. ClickHouse host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the ClickHouse database user. 
password | **string**<br>Password of the ClickHouse database user. 
where | **string**<br>Selection criteria for the data in the specified ClickHouse table. 


### MongodbSource {#MongodbSource22}

Field | Description
--- | ---
db | **string**<br>Required. Name of the MongoDB database. 
collection | **string**<br>Required. Name of the collection in the specified database to be used as the dictionary source. 
host | **string**<br>Required. MongoDB host of the specified database. The maximum string length in characters is 253.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the MongoDB database user. 
password | **string**<br>Password of the MongoDB database user. 


### PostgresqlSource {#PostgresqlSource22}

Field | Description
--- | ---
db | **string**<br>Required. Name of the PostrgreSQL database. 
table | **string**<br>Required. Name of the table in the specified database to be used as the dictionary source. 
hosts[] | **string**<br>Name of the PostrgreSQL host The number of elements must be greater than 0.
port | **int64**<br>Port to use when connecting to the host. Acceptable values are 0 to 65535, inclusive.
user | **string**<br>Required. Name of the PostrgreSQL database user. 
password | **string**<br>Password of the PostrgreSQL database user. 
invalidate_query | **string**<br>Query for checking the dictionary status, to pull only updated data. For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). 
ssl_mode | enum **SslMode**<br>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html). <ul><li>`DISABLE`: Only try a non-SSL connection.</li><li>`ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.</li><li>`PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.</li><li>`VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li><li>`VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li></ul>


### Structure {#Structure22}

Field | Description
--- | ---
id | **[Id](#Id22)**<br>Single numeric key column for the dictionary. 
key | **[Key](#Key22)**<br>Composite key for the dictionary, containing of one or more key columns. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). 
range_min | **[Attribute](#Attribute22)**<br>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
range_max | **[Attribute](#Attribute22)**<br>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). 
attributes[] | **[Attribute](#Attribute22)**<br>Description of the fields available for database queries. For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). The number of elements must be greater than 0.


### Attribute {#Attribute22}

Field | Description
--- | ---
name | **string**<br>Required. Name of the column. 
type | **string**<br>Required. Type of the column. 
null_value | **string**<br>Default value for an element without data (for example, an empty string). 
expression | **string**<br>Expression, describing the attribute, if applicable. 
hierarchical | **bool**<br>Indication of hierarchy support. Default value: `false`. 
injective | **bool**<br>Indication of injective mapping "id -> attribute". Default value: `false`. 


### Id {#Id22}

Field | Description
--- | ---
name | **string**<br>Required. Name of the numeric key. 


### Key {#Key22}

Field | Description
--- | ---
attributes[] | **[Attribute](#Attribute22)**<br>Attributes of a complex key. The number of elements must be greater than 0.


### Layout {#Layout22}

Field | Description
--- | ---
type | enum **Type**<br>Required. Layout type for an external dictionary. <ul><li>`FLAT`: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li><li>`HASHED`: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li><li>`COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li><li>`RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li><li>`CACHE`: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li><li>`COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li></ul>
size_in_cells | **int64**<br>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. 


### Range {#Range22}

Field | Description
--- | ---
min | **int64**<br>Minimum dictionary lifetime. 
max | **int64**<br>Maximum dictionary lifetime. 


### GraphiteRollup {#GraphiteRollup22}

Field | Description
--- | ---
name | **string**<br>Required. Name for the specified combination of settings for Graphite rollup. 
patterns[] | **[Pattern](#Pattern22)**<br>Pattern to use for the rollup. The number of elements must be greater than 0.


### Pattern {#Pattern22}

Field | Description
--- | ---
regexp | **string**<br>Pattern for metric names. 
function | **string**<br>Required. Name of the aggregating function to apply to data of the age specified in `retention`. 
retention[] | **[Retention](#Retention22)**<br>Age of data to use for thinning. The number of elements must be greater than 0.


### Retention {#Retention22}

Field | Description
--- | ---
age | **int64**<br>Minimum age of the data in seconds. The minimum value is 0.
precision | **int64**<br>Precision of determining the age of the data, in seconds. Value must be greater than 0.


### Resources {#Resources18}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### MaintenanceWindow {#MaintenanceWindow13}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow13)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow13)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow13}

Empty.

### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow13}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week (in `DDD` format). 
hour | **int64**<br>Hour of the day in UTC (in `HH` format). Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation13}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


