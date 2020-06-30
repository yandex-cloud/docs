---
editable: false
---

# ClusterService

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
| [ListLogs](#ListLogs) | Retrieves logs for the specified ClickHouse cluster. |
| [StreamLogs](#StreamLogs) | Same as ListLogs but using server-side streaming. |
| [ListOperations](#ListOperations) | Retrieves the list of Operation resources for the specified cluster. |
| [ListBackups](#ListBackups) | Retrieves the list of available backups for the specified ClickHouse cluster. |
| [ListHosts](#ListHosts) | Retrieves a list of hosts for the specified cluster. |
| [AddHosts](#AddHosts) | Creates new hosts for a cluster. |
| [DeleteHosts](#DeleteHosts) | Deletes the specified hosts for a cluster. |
| [GetShard](#GetShard) | Returns the specified shard. |
| [ListShards](#ListShards) | Retrieves a list of shards that belong to the specified cluster. |
| [AddShard](#AddShard) | Creates a new shard in the specified cluster. |
| [UpdateShard](#UpdateShard) | Modifies the specified shard. |
| [DeleteShard](#DeleteShard) | Deletes the specified shard. |
| [GetShardGroup](#GetShardGroup) | Returns the specified shard group. |
| [ListShardGroups](#ListShardGroups) | Retrieves a list of shard groups that belong to specified cluster. |
| [CreateShardGroup](#CreateShardGroup) | Creates a new shard group in the specified cluster. |
| [UpdateShardGroup](#UpdateShardGroup) | Modifies the specified shard group. |
| [DeleteShardGroup](#DeleteShardGroup) | Deletes the specified shard group. |
| [CreateExternalDictionary](#CreateExternalDictionary) | Creates an external dictionary for the specified ClickHouse cluster. |
| [DeleteExternalDictionary](#DeleteExternalDictionary) | Deletes the specified external dictionary. |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified ClickHouse cluster. <br>To get the list of available ClickHouse clusters, make a [List](#List) request.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse Cluster resource to return. To get the cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 


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
access | **[Access](#Access)**<br>Access policy to DB 


### Clickhouse {#Clickhouse}

Field | Description
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Configuration settings of a ClickHouse server. 
resources | **[Resources](#Resources)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper}

Field | Description
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to ZooKeeper hosts. 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 
web_sql | **bool**<br>Allow access for Web SQL 
metrika | **bool**<br>Allow access for Metrika 
serverless | **bool**<br>Allow access for Serverless 


## List {#List}

Retrieves a list of ClickHouse clusters that belong to the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list ClickHouse clusters in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently you can only use filtering with the [Cluster.name](#Cluster1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Мust be 1-63 characters long and match the regular expression `^[a-zA-Z0-9_-]+$`.</li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of ClickHouse Cluster resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest1), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest1) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 


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
clickhouse | **[Clickhouse](#Clickhouse1)**<br>Configuration and resource allocation for ClickHouse hosts. 
zookeeper | **[Zookeeper](#Zookeeper1)**<br>Configuration and resource allocation for ZooKeeper hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access1)**<br>Access policy to DB 


### Clickhouse {#Clickhouse}

Field | Description
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Configuration settings of a ClickHouse server. 
resources | **[Resources](#Resources)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper}

Field | Description
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to ZooKeeper hosts. 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 
web_sql | **bool**<br>Allow access for Web SQL 
metrika | **bool**<br>Allow access for Metrika 
serverless | **bool**<br>Allow access for Serverless 


## Create {#Create}

Creates a ClickHouse cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create the ClickHouse cluster in. false The maximum string length in characters is 50.
name | **string**<br>Required. Name of the ClickHouse cluster. The name must be unique within the folder. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the ClickHouse cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Required. Deployment environment of the ClickHouse cluster. false
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Required. Configuration and resources for hosts that should be created for the ClickHouse cluster. false
database_specs[] | **[DatabaseSpec](#DatabaseSpec)**<br>Descriptions of databases to be created in the ClickHouse cluster. The number of elements must be greater than 0.
user_specs[] | **[UserSpec](#UserSpec)**<br>Descriptions of database users to be created in the ClickHouse cluster. The number of elements must be greater than 0.
host_specs[] | **[HostSpec](#HostSpec)**<br>Individual configurations for hosts that should be created for the ClickHouse cluster. The number of elements must be greater than 0.
network_id | **string**<br>Required. ID of the network to create the cluster in. false The maximum string length in characters is 50.
shard_name | **string**<br>Name of the first shard in cluster. If not set, defaults to the value 'shard1'. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse2)**<br>Configuration and resources for a ClickHouse server. 
zookeeper | **[Zookeeper](#Zookeeper2)**<br>Configuration and resources for a ZooKeeper server. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access2)**<br>Access policy to DB 


### Clickhouse {#Clickhouse}

Field | Description
--- | ---
config | **`config.ClickhouseConfig`**<br>Configuration for a ClickHouse server. 
resources | **[Resources](#Resources)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper}

Field | Description
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to ZooKeeper hosts. If not set, minimal available resources will be used. All available resource presets can be retrieved with a [ResourcePresetService.List](./resource_preset_service#List) request. 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 
web_sql | **bool**<br>Allow access for Web SQL 
metrika | **bool**<br>Allow access for Metrika 
serverless | **bool**<br>Allow access for Serverless 


### DatabaseSpec {#DatabaseSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the ClickHouse database. 1-63 characters long. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the ClickHouse user. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Required. Password of the ClickHouse user. false The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission)**<br>Set of permissions to grant to the user. 
settings | **[UserSettings](#UserSettings)**<br> 
quotas[] | **[UserQuota](#UserQuota)**<br>Set of quotas assigned to the user. 


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 


### UserSettings {#UserSettings}

Field | Description
--- | ---
readonly | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Restricts permissions for non-DDL queries. Possible values: 0 (default) — no restrictions, 1 — only read data queries are allowed, 2 — read data and change settings queries are allowed. Acceptable values are 0 to 2, inclusive.
allow_ddl | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether DDL queries are allowed. Default value: false. 
insert_quorum | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>For INSERT queries in the replicated table, wait writing for the specified number of replicas and linearize the addition of the data. The minimum value is 0.
connect_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Connection timeout in milliseconds. Value must be greater than 0.
receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Receive timeout in milliseconds. Value must be greater than 0.
send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Send timeout in milliseconds. Value must be greater than 0.
insert_quorum_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Quorum write timeout in milliseconds. Default value: 60000. The minimum value is 1000.
select_sequential_consistency | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>For SELECT queries from the replicated table, throw an exception if the replica does not have a chunk written with the quorum; do not read the parts that have not yet been written with the quorum. 
max_replica_delay_for_distributed_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used. Default value: 300000. The minimum value is 1000.
fallback_to_stale_replicas_for_distributed_queries | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Determine the behavior when all replicas for the queried table are stale. If enabled, the query will be performed anyway. Otherwise, the error will be thrown. 
replication_alter_partitions_sync | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Wait mode for ALTER queries on replicated tables. Possible values: 0 - do not wait, 1 - wait for execution only of itself, 2 - wait for everyone. Acceptable values are 0 to 2, inclusive.
distributed_product_mode | enum **DistributedProductMode**<br>Determine the behavior of distributed subqueries. Possible values: DISTRIBUTED_PRODUCT_MODE_DENY, DISTRIBUTED_PRODUCT_MODE_LOCAL, DISTRIBUTED_PRODUCT_MODE_GLOBAL, DISTRIBUTED_PRODUCT_MODE_ALLOW. <ul><li>`DISTRIBUTED_PRODUCT_MODE_DENY`: Default value. Prohibits using these types of subqueries (returns the "Double-distributed in/JOIN subqueries is denied" exception).</li><li>`DISTRIBUTED_PRODUCT_MODE_LOCAL`: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal IN/JOIN.</li><li>`DISTRIBUTED_PRODUCT_MODE_GLOBAL`: Replaces the IN/JOIN query with GLOBAL IN/GLOBAL JOIN.</li><li>`DISTRIBUTED_PRODUCT_MODE_ALLOW`: Allows the use of these types of subqueries.</li><ul/>
distributed_aggregation_memory_efficient | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the memory-saving mode of distributed aggregation is enabled. 
distributed_ddl_task_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Timeout for DDL queries, in milliseconds. 
skip_unavailable_shards | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether unavailable shards can be skipped. 
compile | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether query compilation is enabled. 
min_count_to_compile | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of structurally identical queries before they are compiled. The minimum value is 0.
compile_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether expression compilation is enabled. 
min_count_to_compile_expression | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of identical expressions before they are compiled. The minimum value is 0.
max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum block size for reading. Value must be greater than 0.
min_insert_block_size_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Squash blocks passed to INSERT query to specified size in rows, if blocks are not big enough. If set to 0, blocks will never be squashed. The minimum value is 0.
min_insert_block_size_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Squash blocks passed to INSERT query to specified size in bytes, if blocks are not big enough. If set to 0, blocks will never be squashed. The minimum value is 0.
max_insert_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum block size for insertion. Value must be greater than 0.
min_bytes_to_use_direct_io | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum number of bytes for reading the data with O_DIRECT option during SELECT queries execution. The minimum value is 0.
use_uncompressed_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether to use the cache of uncompressed blocks. 
merge_tree_max_rows_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum request size in rows to use the cache of uncompressed data. The cache is not used for requests larger than the specified value. Value must be greater than 0.
merge_tree_max_bytes_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum request size in bytes to use the cache of uncompressed data. The cache is not used for requests larger than the specified value. Value must be greater than 0.
merge_tree_min_rows_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum number of rows to be read from a file to enable concurrent read. Value must be greater than 0.
merge_tree_min_bytes_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The minimum number of bytes to be read from a file to enable concurrent read. Value must be greater than 0.
max_bytes_before_external_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
max_bytes_before_external_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
group_by_two_level_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
group_by_two_level_threshold_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Priority of the query. The minimum value is 0.
max_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of threads to execute the request. Value must be greater than 0.
max_memory_usage | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum memory usage for processing of a single query. The minimum value is 0.
max_memory_usage_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum memory usage for processing all concurrently running queries for the user. The minimum value is 0.
max_network_bandwidth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum speed of data exchange over the network in bytes per second for a query. 
max_network_bandwidth_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries. 
force_index_by_date | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Disables query execution if the index can’t be used by date. 
force_primary_key | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Disables query execution if indexing by the primary key is not possible. 
max_rows_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of rows that can be read from a table when running a query. The minimum value is 0.
max_bytes_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of bytes (uncompressed data) that can be read from a table when running a query. The minimum value is 0.
read_overflow_mode | enum **OverflowMode**<br>Determine the behavior on exceeding max_rows_to_read or max_bytes_to_read limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK. <ul><ul/>
max_rows_to_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of unique keys received from aggregation. The minimum value is 0.
group_by_overflow_mode | enum **GroupByOverflowMode**<br>Determine the behavior on exceeding max_rows_to_group_by limit. Possible values: GROUP_BY_OVERFLOW_MODE_THROW, GROUP_BY_OVERFLOW_MODE_BREAK, GROUP_BY_OVERFLOW_MODE_ANY. <ul><ul/>
max_rows_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of rows before sorting. The minimum value is 0.
max_bytes_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of bytes before sorting. The minimum value is 0.
sort_overflow_mode | enum **OverflowMode**<br>Determine the behavior on exceeding max_rows_to_sort or max_bytes_to_sort limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK. <ul><ul/>
max_result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limit on the number of rows in the result. The minimum value is 0.
max_result_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Limit on the number of bytes in the result. The minimum value is 0.
result_overflow_mode | enum **OverflowMode**<br>Determine the behavior on exceeding max_result_rows or max_result_bytes limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK. <ul><ul/>
max_rows_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of different rows when using DISTINCT. The minimum value is 0.
max_bytes_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of bytes used by a hash table when using DISTINCT. The minimum value is 0.
distinct_overflow_mode | enum **OverflowMode**<br>Determine the behavior on exceeding max_rows_in_distinct or max_bytes_in_distinct limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK. <ul><ul/>
max_rows_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of rows that can be passed to a remote server or saved in a temporary table when using GLOBAL IN. The minimum value is 0.
max_bytes_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary table when using GLOBAL IN. The minimum value is 0.
transfer_overflow_mode | enum **OverflowMode**<br>Determine the behavior on exceeding max_rows_to_transfer or max_bytes_to_transfer limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK. <ul><ul/>
max_execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum query execution time in milliseconds. The minimum value is 0.
timeout_overflow_mode | enum **OverflowMode**<br>Determine the behavior on exceeding max_execution_time limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK. <ul><ul/>
max_columns_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of columns that can be read from a table in a single query. The minimum value is 0.
max_temporary_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns. The minimum value is 0.
max_temporary_non_const_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns. The minimum value is 0.
max_query_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum part of a query that can be taken to RAM for parsing with the SQL parser, in bytes. Default value: 262144. Value must be greater than 0.
max_ast_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum depth of query syntax tree. Default value: 1000. Value must be greater than 0.
max_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of query syntax tree in number of nodes. Default value: 50000. Value must be greater than 0.
max_expanded_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk. Default value: 500000. Value must be greater than 0.
input_format_values_interpret_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Enables or disables the full SQL parser if the fast stream parser cannot parse the data. 
input_format_defaults_for_omitted_fields | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>When performing INSERT queries, replace omitted input column values with default values of the respective columns. 
output_format_json_quote_64bit_integers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether quoting of 64-bit integers is enabled in JSON output format. 
output_format_json_quote_denormals | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether output of special floating-point values (+nan, -nan, +inf and -inf) is enabled in JSON output format. 
low_cardinality_allow_in_native_format | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether LowCardinality type is enabled in Native format. 
empty_result_for_aggregation_by_empty_set | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Return empty result when aggregating without keys on empty set. 
http_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP connection timeout, in milliseconds. 
http_receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP receive timeout, in milliseconds. 
http_send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>HTTP send timeout, in milliseconds. 
enable_http_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether data compression is enabled in HTTP responses. 
send_progress_in_http_headers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether progress notifications using X-ClickHouse-Progress headers are enabled. Default value: false. 
http_headers_progress_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Minimum interval between progress notifications, in milliseconds. Default value: 100. 
add_http_cors_header | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether CORS header in HTTP responses is enabled. Default value: false. 


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
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List) request. The maximum string length in characters is 50.
type | **[Host.Type](#Host)**<br>Required. Type of the host to be deployed. false
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the [Cluster.network_id](#Cluster2) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false — don't assign a public IP to the host. </li><li>true — the host should have a public IP address.</li></ul> 
shard_name | **string**<br>Name of the shard that the host is assigned to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


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


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 


## Update {#Update}

Updates the specified ClickHouse cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse Cluster resource to update. To get the ClickHouse cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the ClickHouse Cluster resource should be updated. 
description | **string**<br>New description of the ClickHouse cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". <br>The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get](#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec1)**<br>New configuration and resources for hosts in the cluster. 
name | **string**<br>New name for the cluster. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse3)**<br>Configuration and resources for a ClickHouse server. 
zookeeper | **[Zookeeper](#Zookeeper3)**<br>Configuration and resources for a ZooKeeper server. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access3)**<br>Access policy to DB 


### Clickhouse {#Clickhouse}

Field | Description
--- | ---
config | **`config.ClickhouseConfig`**<br>Configuration for a ClickHouse server. 
resources | **[Resources](#Resources)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper}

Field | Description
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to ZooKeeper hosts. If not set, minimal available resources will be used. All available resource presets can be retrieved with a [ResourcePresetService.List](./resource_preset_service#List) request. 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 
web_sql | **bool**<br>Allow access for Web SQL 
metrika | **bool**<br>Allow access for Metrika 
serverless | **bool**<br>Allow access for Serverless 


### Operation {#Operation}

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


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 


## Delete {#Delete}

Deletes the specified ClickHouse cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to delete. To get the ClickHouse cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.


### Operation {#Operation}

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
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to start. false The maximum string length in characters is 50.


### Operation {#Operation}

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


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 


## Stop {#Stop}

Stops the specified ClickHouse cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to stop. false The maximum string length in characters is 50.


### Operation {#Operation}

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


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 


## Move {#Move}

Moves a ClickHouse cluster to the specified folder.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### MoveClusterRequest {#MoveClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to move. false The maximum string length in characters is 50.
destination_folder_id | **string**<br>Required. ID of the destination folder. false The maximum string length in characters is 50.


### Operation {#Operation}

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


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 


## AddZookeeper {#AddZookeeper}

Adds a ZooKeeper subcluster to the specified ClickHouse cluster.

**rpc AddZookeeper ([AddClusterZookeeperRequest](#AddClusterZookeeperRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterZookeeperMetadata](#AddClusterZookeeperMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster7)<br>

### AddClusterZookeeperRequest {#AddClusterZookeeperRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to modify. false The maximum string length in characters is 50.
resources | **[Resources](#Resources)**<br>Resources allocated to Zookeeper hosts. 
host_specs[] | **[HostSpec](#HostSpec1)**<br>Configuration of ZooKeeper hosts. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br><ul><li>network-hdd — network HDD drive, </li><li>network-ssd — network SSD drive, </li><li>local-ssd — local SSD storage.</li></ul> 


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List) request. The maximum string length in characters is 50.
type | **[Host.Type](#Host)**<br>Required. Type of the host to be deployed. false
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the [Cluster.network_id](#Cluster7) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false — don't assign a public IP to the host. </li><li>true — the host should have a public IP address.</li></ul> 
shard_name | **string**<br>Name of the shard that the host is assigned to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation}

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


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 


## Backup {#Backup}

Creates a backup for the specified ClickHouse cluster.

**rpc Backup ([BackupClusterRequest](#BackupClusterRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupClusterMetadata](#BackupClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster8)<br>

### BackupClusterRequest {#BackupClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to back up. To get the ClickHouse cluster ID use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.


### Operation {#Operation}

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


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 


## Restore {#Restore}

Creates a new ClickHouse cluster using the specified backup.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation8))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster9)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. ID of the backup to create a cluster from. To get the backup ID, use a [ClusterService.ListBackups](#ListBackups) request. false
name | **string**<br>Required. Name of the new ClickHouse cluster. The name must be unique within the folder. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the new ClickHouse cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster9)**<br>Required. Deployment environment of the new ClickHouse cluster. false
config_spec | **[ConfigSpec](#ConfigSpec2)**<br>Required. Configuration for the ClickHouse cluster to be created. false
host_specs[] | **[HostSpec](#HostSpec2)**<br>Configurations for ClickHouse hosts that should be created for the cluster that is being created from the backup. The number of elements must be greater than 0.
network_id | **string**<br>Required. ID of the network to create the ClickHouse cluster in. false The maximum string length in characters is 50.
folder_id | **string**<br>ID of the folder to create the ClickHouse cluster in. The maximum string length in characters is 50.
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Version of the ClickHouse server software. 
clickhouse | **[Clickhouse](#Clickhouse4)**<br>Configuration and resources for a ClickHouse server. 
zookeeper | **[Zookeeper](#Zookeeper4)**<br>Configuration and resources for a ZooKeeper server. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access4)**<br>Access policy to DB 


### Clickhouse {#Clickhouse}

Field | Description
--- | ---
config | **`config.ClickhouseConfig`**<br>Configuration for a ClickHouse server. 
resources | **[Resources](#Resources1)**<br>Resources allocated to ClickHouse hosts. 


### Zookeeper {#Zookeeper}

Field | Description
--- | ---
resources | **[Resources](#Resources1)**<br>Resources allocated to ZooKeeper hosts. If not set, minimal available resources will be used. All available resource presets can be retrieved with a [ResourcePresetService.List](./resource_preset_service#List) request. 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 
web_sql | **bool**<br>Allow access for Web SQL 
metrika | **bool**<br>Allow access for Metrika 
serverless | **bool**<br>Allow access for Serverless 


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List) request. The maximum string length in characters is 50.
type | **[Host.Type](#Host)**<br>Required. Type of the host to be deployed. false
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the [Cluster.network_id](#Cluster9) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false — don't assign a public IP to the host. </li><li>true — the host should have a public IP address.</li></ul> 
shard_name | **string**<br>Name of the shard that the host is assigned to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation}

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


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 


## ListLogs {#ListLogs}

Retrieves logs for the specified ClickHouse cluster.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to request logs for. To get the ClickHouse cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from logs table to request. If no columns are specified, entire log records are returned. 
service_type | enum **ServiceType**<br>Type of the service to request logs about. <ul><li>`CLICKHOUSE`: Logs of ClickHouse activity.</li><ul/>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterLogsResponse {#ListClusterLogsResponse}

Field | Description
--- | ---
logs[] | **[LogRecord](#LogRecord)**<br>Requested log records. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterLogsRequest.page_size](#ListClusterLogsRequest1), use the `next_page_token` as the value for the [ListClusterLogsRequest.page_token](#ListClusterLogsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. This value is interchangeable with `next_record_token` from StreamLogs method. 


### LogRecord {#LogRecord}

Field | Description
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log record timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
message | **map<string,string>**<br>Contents of the log record. 


## StreamLogs {#StreamLogs}

Same as ListLogs but using server-side streaming. Also allows for 'tail -f' semantics.

**rpc StreamLogs ([StreamClusterLogsRequest](#StreamClusterLogsRequest)) returns (stream [StreamLogRecord](#StreamLogRecord))**

### StreamClusterLogsRequest {#StreamClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the ClickHouse cluster. false The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from logs table to get in the response. 
service_type | enum **ServiceType**<br> <ul><li>`CLICKHOUSE`: Logs of ClickHouse activity.</li><ul/>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request. If this field is not set, all existing logs will be sent and then the new ones as they appear. In essence it has 'tail -f' semantics. 
record_token | **string**<br>Record token. Set `record_token` to the `next_record_token` returned by a previous StreamLogs request to start streaming from next log record. The maximum string length in characters is 100.


### StreamLogRecord {#StreamLogRecord}

Field | Description
--- | ---
record | **[LogRecord](#LogRecord1)**<br>One of the requested log records. 
next_record_token | **string**<br>This token allows you to continue streaming logs starting from the exact same record. To continue streaming, specify value of `next_record_token` as value for `record_token` parameter in the next StreamLogs request. This value is interchangeable with `next_page_token` from ListLogs method. 


### LogRecord {#LogRecord}

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
cluster_id | **string**<br>Required. ID of the ClickHouse Cluster resource to list operations for. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation9)**<br>List of Operation resources for the specified ClickHouse cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest1), use the `next_page_token` as the value for the [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation}

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
cluster_id | **string**<br>Required. ID of the ClickHouse cluster. To get the ClickHouse cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterBackupsResponse {#ListClusterBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup)**<br>List of ClickHouse Backup resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterBackupsRequest.page_size](#ListClusterBackupsRequest1), use the `next_page_token` as the value for the [ListClusterBackupsRequest.page_token](#ListClusterBackupsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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
cluster_id | **string**<br>Required. ID of the ClickHouse cluster. To get the ClickHouse cluster ID use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](#Host)**<br>Requested list of hosts for the cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest1), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
name | **string**<br>Name of the ClickHouse host. The host name is assigned by MDB at creation time, and cannot be changed. 1-63 characters long. <br>The name is unique across all existing MDB hosts in Yandex.Cloud, as it defines the FQDN of the host. 
cluster_id | **string**<br>ID of the ClickHouse host. The ID is assigned by MDB at creation time. 
zone_id | **string**<br>ID of the availability zone where the ClickHouse host resides. 
type | enum **Type**<br>Type of the host. <ul><li>`CLICKHOUSE`: ClickHouse host.</li><li>`ZOOKEEPER`: ZooKeeper host.</li><ul/>
resources | **[Resources](#Resources1)**<br>Resources allocated to the ClickHouse host. 
health | enum **Health**<br>Status code of the aggregated health of the host. <ul><li>`UNKNOWN`: Health of the host is unknown.</li><li>`ALIVE`: The host is performing all its functions normally.</li><li>`DEAD`: The host is inoperable, and cannot perform any of its essential functions.</li><li>`DEGRADED`: The host is degraded, and can perform only some of its essential functions.</li><ul/>
services[] | **[Service](#Service)**<br>Services provided by the host. 
subnet_id | **string**<br>ID of the subnet that the host belongs to. 
assign_public_ip | **bool**<br>Flag showing public IP assignment status to this host. 
shard_name | **string**<br> 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br><ul><li>network-hdd — network HDD drive, </li><li>network-ssd — network SSD drive, </li><li>local-ssd — local SSD storage.</li></ul> 


### Service {#Service}

Field | Description
--- | ---
type | enum **Type**<br>Type of the service provided by the host. <ul><li>`CLICKHOUSE`: The host is a ClickHouse server.</li><li>`ZOOKEEPER`: The host is a ZooKeeper server.</li><ul/>
health | enum **Health**<br>Status code of server availability. <ul><li>`UNKNOWN`: Health of the server is unknown.</li><li>`ALIVE`: The server is working normally.</li><li>`DEAD`: The server is dead or unresponsive.</li><ul/>


## AddHosts {#AddHosts}

Creates new hosts for a cluster.

**rpc AddHosts ([AddClusterHostsRequest](#AddClusterHostsRequest)) returns ([operation.Operation](#Operation10))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterHostsMetadata](#AddClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddClusterHostsRequest {#AddClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to add hosts to. To get the ClickHouse cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
host_specs[] | **[HostSpec](#HostSpec3)**<br>Configurations for ClickHouse hosts that should be added to the cluster. The number of elements must be greater than 0.


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List) request. The maximum string length in characters is 50.
type | **[Host.Type](#Host1)**<br>Required. Type of the host to be deployed. false
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the [Cluster.network_id](#Cluster10) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false — don't assign a public IP to the host. </li><li>true — the host should have a public IP address.</li></ul> 
shard_name | **string**<br>Name of the shard that the host is assigned to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation}

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


## DeleteHosts {#DeleteHosts}

Deletes the specified hosts for a cluster.

**rpc DeleteHosts ([DeleteClusterHostsRequest](#DeleteClusterHostsRequest)) returns ([operation.Operation](#Operation11))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterHostsMetadata](#DeleteClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterHostsRequest {#DeleteClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to remove hosts from. To get the ClickHouse cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
host_names[] | **string**<br>Names of hosts to delete. The number of elements must be greater than 0. The maximum string length in characters for each value is 253.


### Operation {#Operation}

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
cluster_id | **string**<br>Required. ID of the cluster that the shard belongs to. To get the cluster ID, use a [ClusterService.List](#List)(#List) request. To get the name of the database, use a [ClusterService.List] request. false The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name of the shard to request information about. To get the name of a shard, use a [ClusterService.ListShards](#ListShards) request. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Shard {#Shard}

Field | Description
--- | ---
name | **string**<br>Name of the shard. 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 
config | **[ShardConfig](#ShardConfig)**<br>Configuration of the shard. 


### ShardConfig {#ShardConfig}

Field | Description
--- | ---
clickhouse | **[Clickhouse](#Clickhouse5)**<br>ClickHouse configuration for a shard. 


### Clickhouse {#Clickhouse}

Field | Description
--- | ---
config | **`config.ClickhouseConfigSet`**<br>ClickHouse settings for a shard. 
resources | **[Resources](#Resources2)**<br>Computational resources for a shard. 
weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Relative weight of a shard considered when writing data to the cluster. For details, see [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/table_engines/distributed/). 


## ListShards {#ListShards}

Retrieves a list of shards that belong to the specified cluster.

**rpc ListShards ([ListClusterShardsRequest](#ListClusterShardsRequest)) returns ([ListClusterShardsResponse](#ListClusterShardsResponse))**

### ListClusterShardsRequest {#ListClusterShardsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to list shards in. To get the cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterShardsResponse.next_page_token](#ListClusterShardsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token.  to get the next page of results, set `page_token` to the [ListClusterShardsResponse.next_page_token](#ListClusterShardsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterShardsResponse {#ListClusterShardsResponse}

Field | Description
--- | ---
shards[] | **[Shard](#Shard1)**<br>List of ClickHouse shards. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterShardsRequest.page_size](#ListClusterShardsRequest1), use the `next_page_token` as the value for the [ListClusterShardsRequest.page_token](#ListClusterShardsRequest1) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Shard {#Shard}

Field | Description
--- | ---
name | **string**<br>Name of the shard. 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 
config | **[ShardConfig](#ShardConfig1)**<br>Configuration of the shard. 


### ShardConfig {#ShardConfig}

Field | Description
--- | ---
clickhouse | **[Clickhouse](#Clickhouse6)**<br>ClickHouse configuration for a shard. 


### Clickhouse {#Clickhouse}

Field | Description
--- | ---
config | **`config.ClickhouseConfigSet`**<br>ClickHouse settings for a shard. 
resources | **[Resources](#Resources2)**<br>Computational resources for a shard. 
weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Relative weight of a shard considered when writing data to the cluster. For details, see [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/table_engines/distributed/). 


## AddShard {#AddShard}

Creates a new shard in the specified cluster.

**rpc AddShard ([AddClusterShardRequest](#AddClusterShardRequest)) returns ([operation.Operation](#Operation12))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterShardMetadata](#AddClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Shard](#Shard2)<br>

### AddClusterShardRequest {#AddClusterShardRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to add a shard to. To get the ClickHouse cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name for the new shard. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
config_spec | **[ShardConfigSpec](#ShardConfigSpec)**<br>Configuration of the new shard. 
host_specs[] | **[HostSpec](#HostSpec4)**<br>Configurations for ClickHouse hosts that should be created with the shard. The number of elements must be greater than 0.


### ShardConfigSpec {#ShardConfigSpec}

Field | Description
--- | ---
clickhouse | **[Clickhouse](#Clickhouse7)**<br>ClickHouse configuration for a shard. 


### Clickhouse {#Clickhouse}

Field | Description
--- | ---
config | **`config.ClickhouseConfig`**<br>ClickHouse settings for the shard. 
resources | **[Resources](#Resources2)**<br>Computational resources for the shard. 
weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Relative weight of the shard considered when writing data to the cluster. For details, see [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/table_engines/distributed/). 


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List) request. The maximum string length in characters is 50.
type | **[Host.Type](#Host1)**<br>Required. Type of the host to be deployed. false
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the [Cluster.network_id](#Cluster10) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false — don't assign a public IP to the host. </li><li>true — the host should have a public IP address.</li></ul> 
shard_name | **string**<br>Name of the shard that the host is assigned to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation}

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


### Shard {#Shard}

Field | Description
--- | ---
name | **string**<br>Name of the shard. 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 
config | **[ShardConfig](#ShardConfig2)**<br>Configuration of the shard. 


## UpdateShard {#UpdateShard}

Modifies the specified shard.

**rpc UpdateShard ([UpdateClusterShardRequest](#UpdateClusterShardRequest)) returns ([operation.Operation](#Operation13))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterShardMetadata](#UpdateClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Shard](#Shard3)<br>

### UpdateClusterShardRequest {#UpdateClusterShardRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster the shard belongs to. To get the cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name of the shard to be updated. To get the name of a shard, use a [ClusterService.ListShards](#ListShards) request. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the ClickHouse shard should be updated. 
config_spec | **[ShardConfigSpec](#ShardConfigSpec1)**<br>New configuration for the specified shard. 


### ShardConfigSpec {#ShardConfigSpec}

Field | Description
--- | ---
clickhouse | **[Clickhouse](#Clickhouse8)**<br>ClickHouse configuration for a shard. 


### Clickhouse {#Clickhouse}

Field | Description
--- | ---
config | **`config.ClickhouseConfig`**<br>ClickHouse settings for the shard. 
resources | **[Resources](#Resources2)**<br>Computational resources for the shard. 
weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Relative weight of the shard considered when writing data to the cluster. For details, see [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/table_engines/distributed/). 


### Operation {#Operation}

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


### Shard {#Shard}

Field | Description
--- | ---
name | **string**<br>Name of the shard. 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 
config | **[ShardConfig](#ShardConfig2)**<br>Configuration of the shard. 


## DeleteShard {#DeleteShard}

Deletes the specified shard.

**rpc DeleteShard ([DeleteClusterShardRequest](#DeleteClusterShardRequest)) returns ([operation.Operation](#Operation14))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterShardMetadata](#DeleteClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterShardRequest {#DeleteClusterShardRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster the shard belongs to. To get the cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name of the shard to be deleted. To get the name of a shard, use a [ClusterService.ListShards](#ListShards) request. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation}

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
cluster_id | **string**<br>Required. ID of the cluster that the shard group belongs to. false The maximum string length in characters is 50.
shard_group_name | **string**<br>Required. Name of the shard group to request information about. To get the name of a shard group, use a [ClusterService.ListShardGroups](#ListShardGroups) request. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### ShardGroup {#ShardGroup}

Field | Description
--- | ---
name | **string**<br>Name of the shard group 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 
description | **string**<br>Description of the ClickHouse cluster shard group. 0-256 characters long. 
shard_names[] | **string**<br>List of shard names contained in shard group 


## ListShardGroups {#ListShardGroups}

Retrieves a list of shard groups that belong to specified cluster.

**rpc ListShardGroups ([ListClusterShardGroupsRequest](#ListClusterShardGroupsRequest)) returns ([ListClusterShardGroupsResponse](#ListClusterShardGroupsResponse))**

### ListClusterShardGroupsRequest {#ListClusterShardGroupsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster that the shard group belongs to. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterShardGroupsResponse.next_page_token](#ListClusterShardGroupsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterShardGroupsResponse.next_page_token](#ListClusterShardGroupsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterShardGroupsResponse {#ListClusterShardGroupsResponse}

Field | Description
--- | ---
shard_groups[] | **[ShardGroup](#ShardGroup1)**<br>List of ClickHouse Cluster shard groups. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterShardGroupsRequest.page_size](#ListClusterShardGroupsRequest1), use the `next_page_token` as the value for the [ListClusterShardGroupsRequest.page_token](#ListClusterShardGroupsRequest1) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### ShardGroup {#ShardGroup}

Field | Description
--- | ---
name | **string**<br>Name of the shard group 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 
description | **string**<br>Description of the ClickHouse cluster shard group. 0-256 characters long. 
shard_names[] | **string**<br>List of shard names contained in shard group 


## CreateShardGroup {#CreateShardGroup}

Creates a new shard group in the specified cluster.

**rpc CreateShardGroup ([CreateClusterShardGroupRequest](#CreateClusterShardGroupRequest)) returns ([operation.Operation](#Operation15))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterShardGroupMetadata](#CreateClusterShardGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ShardGroup](#ShardGroup2)<br>

### CreateClusterShardGroupRequest {#CreateClusterShardGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to add a shard group to. To get the ClickHouse cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
shard_group_name | **string**<br>Required. Name for the new shard group. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the ClickHouse cluster shard group. 0-256 characters long. 
shard_names[] | **string**<br>List of shard names that belongs to the new group. 


### Operation {#Operation}

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
cluster_id | **string**<br>ID of the ClickHouse cluster to add a shard group to. 
shard_group_name | **string**<br>Name for the new shard group. 


### ShardGroup {#ShardGroup}

Field | Description
--- | ---
name | **string**<br>Name of the shard group 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 
description | **string**<br>Description of the ClickHouse cluster shard group. 0-256 characters long. 
shard_names[] | **string**<br>List of shard names contained in shard group 


## UpdateShardGroup {#UpdateShardGroup}

Modifies the specified shard group.

**rpc UpdateShardGroup ([UpdateClusterShardGroupRequest](#UpdateClusterShardGroupRequest)) returns ([operation.Operation](#Operation16))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterShardGroupMetadata](#UpdateClusterShardGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ShardGroup](#ShardGroup3)<br>

### UpdateClusterShardGroupRequest {#UpdateClusterShardGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster that contains the shard group being updated. false The maximum string length in characters is 50.
shard_group_name | **string**<br>Required. Name of the shard group that should be updated. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the ClickHouse shard group should be updated. 
description | **string**<br>Description of the ClickHouse cluster shard group. 0-256 characters long. 
shard_names[] | **string**<br>Updated list of shard names that belongs to the new group. 


### Operation {#Operation}

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
shard_group_name | **string**<br>Name of the shard group that should be updated. 


### ShardGroup {#ShardGroup}

Field | Description
--- | ---
name | **string**<br>Name of the shard group 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 
description | **string**<br>Description of the ClickHouse cluster shard group. 0-256 characters long. 
shard_names[] | **string**<br>List of shard names contained in shard group 


## DeleteShardGroup {#DeleteShardGroup}

Deletes the specified shard group.

**rpc DeleteShardGroup ([DeleteClusterShardGroupRequest](#DeleteClusterShardGroupRequest)) returns ([operation.Operation](#Operation17))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterShardGroupMetadata](#DeleteClusterShardGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterShardGroupRequest {#DeleteClusterShardGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster the shard group belongs to. false The maximum string length in characters is 50.
shard_group_name | **string**<br>Required. Name of the shard group that should be deleted. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation}

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
cluster_id | **string**<br>ID of the ClickHouse cluster the shard group belongs to. 
shard_group_name | **string**<br>Name of the shard group that should be deleted. 


## CreateExternalDictionary {#CreateExternalDictionary}

Creates an external dictionary for the specified ClickHouse cluster.

**rpc CreateExternalDictionary ([CreateClusterExternalDictionaryRequest](#CreateClusterExternalDictionaryRequest)) returns ([operation.Operation](#Operation18))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterExternalDictionaryMetadata](#CreateClusterExternalDictionaryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster10)<br>

### CreateClusterExternalDictionaryRequest {#CreateClusterExternalDictionaryRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to create the external dictionary for. To get the cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
external_dictionary | **[config.ClickhouseConfig.ExternalDictionary](#ClickhouseConfig)**<br>Configuration of the external dictionary. 


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster10)>**<br>if operation finished successfully. 


### CreateClusterExternalDictionaryMetadata {#CreateClusterExternalDictionaryMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the cluster for which an external dictionary is being created. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host1) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host1) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host1) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host1) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 


## DeleteExternalDictionary {#DeleteExternalDictionary}

Deletes the specified external dictionary.

**rpc DeleteExternalDictionary ([DeleteClusterExternalDictionaryRequest](#DeleteClusterExternalDictionaryRequest)) returns ([operation.Operation](#Operation19))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterExternalDictionaryMetadata](#DeleteClusterExternalDictionaryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster11)<br>

### DeleteClusterExternalDictionaryRequest {#DeleteClusterExternalDictionaryRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the ClickHouse cluster to delete the external dictionary from. To get the cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
external_dictionary_name | **string**<br>Name of the external dictionary to delete. 


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster11)>**<br>if operation finished successfully. 


### DeleteClusterExternalDictionaryMetadata {#DeleteClusterExternalDictionaryMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the cluster where an external dictionary is being deleted. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the ClickHouse cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the ClickHouse cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the ClickHouse cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the ClickHouse cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the ClickHouse cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host1) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host1) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host1) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host1) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 


