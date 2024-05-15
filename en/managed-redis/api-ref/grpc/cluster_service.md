---
editable: false
sourcePath: en/_api-ref-grpc/managed-redis/api-ref/grpc/cluster_service.md
---

# Managed Service for Redis API, gRPC: ClusterService

A set of methods for managing Redis clusters.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Redis cluster. |
| [List](#List) | Retrieves the list of Redis clusters that belong to the specified folder. |
| [Create](#Create) | Creates a Redis cluster in the specified folder. |
| [Update](#Update) | Updates the specified Redis cluster. |
| [Delete](#Delete) | Deletes the specified Redis cluster. |
| [Start](#Start) | Start the specified Redis cluster. |
| [Stop](#Stop) | Stop the specified Redis cluster. |
| [Move](#Move) | Moves a Redis cluster to the specified folder. |
| [Backup](#Backup) | Creates a backup for the specified Redis cluster. |
| [Restore](#Restore) | Creates a new Redis cluster using the specified backup. |
| [RescheduleMaintenance](#RescheduleMaintenance) | Reschedules planned maintenance operation. |
| [StartFailover](#StartFailover) | Start a manual failover on the specified Redis cluster. |
| [ListLogs](#ListLogs) | Retrieves logs for the specified Redis cluster. |
| [StreamLogs](#StreamLogs) | Same as ListLogs but using server-side streaming. |
| [ListOperations](#ListOperations) | Retrieves the list of operations for the specified cluster. |
| [ListBackups](#ListBackups) | Retrieves the list of available backups for the specified Redis cluster. |
| [ListHosts](#ListHosts) | Retrieves a list of hosts for the specified cluster. |
| [AddHosts](#AddHosts) | Creates new hosts for a cluster. |
| [DeleteHosts](#DeleteHosts) | Deletes the specified hosts for a cluster. |
| [UpdateHosts](#UpdateHosts) | Updates the specified hosts. |
| [GetShard](#GetShard) | Returns the specified shard. |
| [ListShards](#ListShards) | Retrieves a list of shards. |
| [AddShard](#AddShard) | Creates a new shard. |
| [DeleteShard](#DeleteShard) | Deletes the specified shard. |
| [Rebalance](#Rebalance) | Rebalances the cluster. |
| [EnableSharding](#EnableSharding) | Enable Sharding on non sharded cluster |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified Redis cluster. <br>To get the list of available Redis clusters, make a [List](#List) request.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to return. To get the cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the Redis cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Redis cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the Redis cluster. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the Redis cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Redis cluster as `key:value` pairs. Maximum 64 per cluster. 
environment | enum **Environment**<br>Deployment environment of the Redis cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring)**<br>Description of monitoring systems relevant to the Redis cluster. 
config | **[ClusterConfig](#ClusterConfig)**<br>Configuration of the Redis cluster. 
network_id | **string**<br> 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data)</li><li>`ALIVE`: Cluster is alive and well (all hosts are alive)</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions)</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions)</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster status is unknown</li><li>`CREATING`: Cluster is being created</li><li>`RUNNING`: Cluster is running</li><li>`ERROR`: Cluster failed</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Redis cluster mode on/off. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
tls_enabled | **bool**<br>TLS port and functionality on\off 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
persistence_mode | enum **PersistenceMode**<br>Persistence mode 
announce_hostnames | **bool**<br>Enable FQDN instead of ip 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Redis cluster. 


### ClusterConfig {#ClusterConfig}

Field | Description
--- | ---
version | **string**<br>Version of Redis server software. 
redis_config | **oneof:** `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2` or `redis_config_7_0`<br>Configuration for Redis servers in the cluster.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Configuration of a Redis 5.0 server. 
&nbsp;&nbsp;redis_config_6_0 | **[config.RedisConfigSet6_0](#RedisConfigSet6_0)**<br>Configuration of a Redis 6.0 server. 
&nbsp;&nbsp;redis_config_6_2 | **[config.RedisConfigSet6_2](#RedisConfigSet6_2)**<br>Configuration of a Redis 6.2 server. 
&nbsp;&nbsp;redis_config_7_0 | **[config.RedisConfigSet7_0](#RedisConfigSet7_0)**<br>Configuration of a Redis 7.0 server. 
resources | **[Resources](#Resources)**<br>Resources allocated to Redis hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access)**<br>Access policy to DB 
redis | **[config.RedisConfigSet](#RedisConfigSet)**<br>Unified configuration of a Redis cluster. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


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

Retrieves the list of Redis clusters that belong to the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list Redis clusters in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by the previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters clusters listed in the response. The expression must specify: <ol><li>The field name. Currently you can only use filtering with the [Cluster.name](#Cluster1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z]([-a-z0-9]{,61}[a-z0-9])?`.</li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of Redis clusters. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster1}

Field | Description
--- | ---
id | **string**<br>ID of the Redis cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Redis cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the Redis cluster. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the Redis cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Redis cluster as `key:value` pairs. Maximum 64 per cluster. 
environment | enum **Environment**<br>Deployment environment of the Redis cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Description of monitoring systems relevant to the Redis cluster. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Configuration of the Redis cluster. 
network_id | **string**<br> 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data)</li><li>`ALIVE`: Cluster is alive and well (all hosts are alive)</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions)</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions)</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster status is unknown</li><li>`CREATING`: Cluster is being created</li><li>`RUNNING`: Cluster is running</li><li>`ERROR`: Cluster failed</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Redis cluster mode on/off. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow1)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation1)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
tls_enabled | **bool**<br>TLS port and functionality on\off 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
persistence_mode | enum **PersistenceMode**<br>Persistence mode 
announce_hostnames | **bool**<br>Enable FQDN instead of ip 


### Monitoring {#Monitoring1}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Redis cluster. 


### ClusterConfig {#ClusterConfig1}

Field | Description
--- | ---
version | **string**<br>Version of Redis server software. 
redis_config | **oneof:** `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2` or `redis_config_7_0`<br>Configuration for Redis servers in the cluster.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Configuration of a Redis 5.0 server. 
&nbsp;&nbsp;redis_config_6_0 | **[config.RedisConfigSet6_0](#RedisConfigSet6_0)**<br>Configuration of a Redis 6.0 server. 
&nbsp;&nbsp;redis_config_6_2 | **[config.RedisConfigSet6_2](#RedisConfigSet6_2)**<br>Configuration of a Redis 6.2 server. 
&nbsp;&nbsp;redis_config_7_0 | **[config.RedisConfigSet7_0](#RedisConfigSet7_0)**<br>Configuration of a Redis 7.0 server. 
resources | **[Resources](#Resources1)**<br>Resources allocated to Redis hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access1)**<br>Access policy to DB 
redis | **[config.RedisConfigSet](#RedisConfigSet)**<br>Unified configuration of a Redis cluster. 


### Resources {#Resources1}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access1}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


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

Creates a Redis cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create the Redis cluster in. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the Redis cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the Redis cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Redis cluster as `key:value` pairs. Maximum 64 per cluster. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Required. Deployment environment of the Redis cluster. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Required. Configuration and resources for hosts that should be created for the Redis cluster. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Individual configurations for hosts that should be created for the Redis cluster. The number of elements must be greater than 0.
network_id | **string**<br>Required. ID of the network to create the cluster in. The maximum string length in characters is 50.
sharded | **bool**<br>Redis cluster mode on/off. 
security_group_ids[] | **string**<br>User security groups 
tls_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>TLS port and functionality on\off 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
persistence_mode | **[Cluster.PersistenceMode](#Cluster2)**<br>Persistence mode 
announce_hostnames | **bool**<br>Enable FQDN instead of ip 


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Version of Redis used in the cluster. 
redis_spec | **oneof:** `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2` or `redis_config_7_0`<br>Configuration of a Redis cluster.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfig5_0](#RedisConfig5_0)**<br>Configuration of a Redis cluster. 
&nbsp;&nbsp;redis_config_6_0 | **[config.RedisConfig6_0](#RedisConfig6_0)**<br>Configuration of a Redis cluster. 
&nbsp;&nbsp;redis_config_6_2 | **[config.RedisConfig6_2](#RedisConfig6_2)**<br>Configuration of a Redis cluster. 
&nbsp;&nbsp;redis_config_7_0 | **[config.RedisConfig7_0](#RedisConfig7_0)**<br>Configuration of a Redis cluster. 
resources | **[Resources](#Resources2)**<br>Resources allocated to Redis hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access2)**<br>Access policy to DB 
redis | **[config.RedisConfig](#RedisConfig)**<br>Unified configuration of a Redis cluster 


### Resources {#Resources2}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access2}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. 
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster2). 
shard_name | **string**<br>ID of the Redis shard the host belongs to. To get the shard ID use a [ClusterService.ListShards](#ListShards) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
replica_priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>A replica with a low priority number is considered better for promotion. A replica with priority of 0 will never be selected by Redis Sentinel for promotion. Works only for non-sharded clusters. Default value is 100. 
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 


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
cluster_id | **string**<br>ID of the Redis cluster that is being created. 


### Cluster {#Cluster2}

Field | Description
--- | ---
id | **string**<br>ID of the Redis cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Redis cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the Redis cluster. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the Redis cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Redis cluster as `key:value` pairs. Maximum 64 per cluster. 
environment | enum **Environment**<br>Deployment environment of the Redis cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the Redis cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the Redis cluster. 
network_id | **string**<br> 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data)</li><li>`ALIVE`: Cluster is alive and well (all hosts are alive)</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions)</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions)</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster status is unknown</li><li>`CREATING`: Cluster is being created</li><li>`RUNNING`: Cluster is running</li><li>`ERROR`: Cluster failed</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Redis cluster mode on/off. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow2)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation2)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
tls_enabled | **bool**<br>TLS port and functionality on\off 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
persistence_mode | enum **PersistenceMode**<br>Persistence mode 
announce_hostnames | **bool**<br>Enable FQDN instead of ip 


### Monitoring {#Monitoring2}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Redis cluster. 


### ClusterConfig {#ClusterConfig2}

Field | Description
--- | ---
version | **string**<br>Version of Redis server software. 
redis_config | **oneof:** `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2` or `redis_config_7_0`<br>Configuration for Redis servers in the cluster.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Configuration of a Redis 5.0 server. 
&nbsp;&nbsp;redis_config_6_0 | **[config.RedisConfigSet6_0](#RedisConfigSet6_0)**<br>Configuration of a Redis 6.0 server. 
&nbsp;&nbsp;redis_config_6_2 | **[config.RedisConfigSet6_2](#RedisConfigSet6_2)**<br>Configuration of a Redis 6.2 server. 
&nbsp;&nbsp;redis_config_7_0 | **[config.RedisConfigSet7_0](#RedisConfigSet7_0)**<br>Configuration of a Redis 7.0 server. 
resources | **[Resources](#Resources3)**<br>Resources allocated to Redis hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access3)**<br>Access policy to DB 
redis | **[config.RedisConfigSet](#RedisConfigSet)**<br>Unified configuration of a Redis cluster. 


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


### MaintenanceOperation {#MaintenanceOperation2}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## Update {#Update}

Updates the specified Redis cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to update. To get the Redis cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Redis cluster should be updated. 
description | **string**<br>New description of the Redis cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Redis cluster as `` key:value `` pairs. Maximum 64 per cluster. For example, "project": "mvp" or "source": "dictionary". <br>The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get](#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec)**<br>New configuration and resources for hosts in the cluster. 
name | **string**<br>New name for the cluster. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>New maintenance window settings for the cluster. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
persistence_mode | **[Cluster.PersistenceMode](#Cluster3)**<br>Persistence mode 
announce_hostnames | **bool**<br>Enable FQDN instead of ip 


### ConfigSpec {#ConfigSpec1}

Field | Description
--- | ---
version | **string**<br>Version of Redis used in the cluster. 
redis_spec | **oneof:** `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2` or `redis_config_7_0`<br>Configuration of a Redis cluster.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfig5_0](#RedisConfig5_0)**<br>Configuration of a Redis cluster. 
&nbsp;&nbsp;redis_config_6_0 | **[config.RedisConfig6_0](#RedisConfig6_0)**<br>Configuration of a Redis cluster. 
&nbsp;&nbsp;redis_config_6_2 | **[config.RedisConfig6_2](#RedisConfig6_2)**<br>Configuration of a Redis cluster. 
&nbsp;&nbsp;redis_config_7_0 | **[config.RedisConfig7_0](#RedisConfig7_0)**<br>Configuration of a Redis cluster. 
resources | **[Resources](#Resources3)**<br>Resources allocated to Redis hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access3)**<br>Access policy to DB 
redis | **[config.RedisConfig](#RedisConfig)**<br>Unified configuration of a Redis cluster 


### Resources {#Resources3}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access3}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


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
cluster_id | **string**<br>ID of the Redis cluster that is being updated. 


### Cluster {#Cluster3}

Field | Description
--- | ---
id | **string**<br>ID of the Redis cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Redis cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the Redis cluster. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the Redis cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Redis cluster as `key:value` pairs. Maximum 64 per cluster. 
environment | enum **Environment**<br>Deployment environment of the Redis cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Description of monitoring systems relevant to the Redis cluster. 
config | **[ClusterConfig](#ClusterConfig3)**<br>Configuration of the Redis cluster. 
network_id | **string**<br> 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data)</li><li>`ALIVE`: Cluster is alive and well (all hosts are alive)</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions)</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions)</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster status is unknown</li><li>`CREATING`: Cluster is being created</li><li>`RUNNING`: Cluster is running</li><li>`ERROR`: Cluster failed</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Redis cluster mode on/off. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation3)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
tls_enabled | **bool**<br>TLS port and functionality on\off 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
persistence_mode | enum **PersistenceMode**<br>Persistence mode 
announce_hostnames | **bool**<br>Enable FQDN instead of ip 


### Monitoring {#Monitoring3}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Redis cluster. 


### ClusterConfig {#ClusterConfig3}

Field | Description
--- | ---
version | **string**<br>Version of Redis server software. 
redis_config | **oneof:** `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2` or `redis_config_7_0`<br>Configuration for Redis servers in the cluster.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Configuration of a Redis 5.0 server. 
&nbsp;&nbsp;redis_config_6_0 | **[config.RedisConfigSet6_0](#RedisConfigSet6_0)**<br>Configuration of a Redis 6.0 server. 
&nbsp;&nbsp;redis_config_6_2 | **[config.RedisConfigSet6_2](#RedisConfigSet6_2)**<br>Configuration of a Redis 6.2 server. 
&nbsp;&nbsp;redis_config_7_0 | **[config.RedisConfigSet7_0](#RedisConfigSet7_0)**<br>Configuration of a Redis 7.0 server. 
resources | **[Resources](#Resources4)**<br>Resources allocated to Redis hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access4)**<br>Access policy to DB 
redis | **[config.RedisConfigSet](#RedisConfigSet)**<br>Unified configuration of a Redis cluster. 


### MaintenanceOperation {#MaintenanceOperation3}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## Delete {#Delete}

Deletes the specified Redis cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to delete. To get the Redis cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the Redis cluster that is being deleted. 


## Start {#Start}

Start the specified Redis cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to start. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the Redis cluster. 


### Cluster {#Cluster4}

Field | Description
--- | ---
id | **string**<br>ID of the Redis cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Redis cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the Redis cluster. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the Redis cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Redis cluster as `key:value` pairs. Maximum 64 per cluster. 
environment | enum **Environment**<br>Deployment environment of the Redis cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Description of monitoring systems relevant to the Redis cluster. 
config | **[ClusterConfig](#ClusterConfig4)**<br>Configuration of the Redis cluster. 
network_id | **string**<br> 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data)</li><li>`ALIVE`: Cluster is alive and well (all hosts are alive)</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions)</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions)</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster status is unknown</li><li>`CREATING`: Cluster is being created</li><li>`RUNNING`: Cluster is running</li><li>`ERROR`: Cluster failed</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Redis cluster mode on/off. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation4)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
tls_enabled | **bool**<br>TLS port and functionality on\off 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
persistence_mode | enum **PersistenceMode**<br>Persistence mode 
announce_hostnames | **bool**<br>Enable FQDN instead of ip 


### Monitoring {#Monitoring4}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Redis cluster. 


### ClusterConfig {#ClusterConfig4}

Field | Description
--- | ---
version | **string**<br>Version of Redis server software. 
redis_config | **oneof:** `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2` or `redis_config_7_0`<br>Configuration for Redis servers in the cluster.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Configuration of a Redis 5.0 server. 
&nbsp;&nbsp;redis_config_6_0 | **[config.RedisConfigSet6_0](#RedisConfigSet6_0)**<br>Configuration of a Redis 6.0 server. 
&nbsp;&nbsp;redis_config_6_2 | **[config.RedisConfigSet6_2](#RedisConfigSet6_2)**<br>Configuration of a Redis 6.2 server. 
&nbsp;&nbsp;redis_config_7_0 | **[config.RedisConfigSet7_0](#RedisConfigSet7_0)**<br>Configuration of a Redis 7.0 server. 
resources | **[Resources](#Resources4)**<br>Resources allocated to Redis hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access4)**<br>Access policy to DB 
redis | **[config.RedisConfigSet](#RedisConfigSet)**<br>Unified configuration of a Redis cluster. 


### Resources {#Resources4}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access4}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


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

Stop the specified Redis cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to stop. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the Redis cluster. 


### Cluster {#Cluster5}

Field | Description
--- | ---
id | **string**<br>ID of the Redis cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Redis cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the Redis cluster. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the Redis cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Redis cluster as `key:value` pairs. Maximum 64 per cluster. 
environment | enum **Environment**<br>Deployment environment of the Redis cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Description of monitoring systems relevant to the Redis cluster. 
config | **[ClusterConfig](#ClusterConfig5)**<br>Configuration of the Redis cluster. 
network_id | **string**<br> 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data)</li><li>`ALIVE`: Cluster is alive and well (all hosts are alive)</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions)</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions)</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster status is unknown</li><li>`CREATING`: Cluster is being created</li><li>`RUNNING`: Cluster is running</li><li>`ERROR`: Cluster failed</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Redis cluster mode on/off. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow5)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation5)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
tls_enabled | **bool**<br>TLS port and functionality on\off 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
persistence_mode | enum **PersistenceMode**<br>Persistence mode 
announce_hostnames | **bool**<br>Enable FQDN instead of ip 


### Monitoring {#Monitoring5}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Redis cluster. 


### ClusterConfig {#ClusterConfig5}

Field | Description
--- | ---
version | **string**<br>Version of Redis server software. 
redis_config | **oneof:** `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2` or `redis_config_7_0`<br>Configuration for Redis servers in the cluster.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Configuration of a Redis 5.0 server. 
&nbsp;&nbsp;redis_config_6_0 | **[config.RedisConfigSet6_0](#RedisConfigSet6_0)**<br>Configuration of a Redis 6.0 server. 
&nbsp;&nbsp;redis_config_6_2 | **[config.RedisConfigSet6_2](#RedisConfigSet6_2)**<br>Configuration of a Redis 6.2 server. 
&nbsp;&nbsp;redis_config_7_0 | **[config.RedisConfigSet7_0](#RedisConfigSet7_0)**<br>Configuration of a Redis 7.0 server. 
resources | **[Resources](#Resources5)**<br>Resources allocated to Redis hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access5)**<br>Access policy to DB 
redis | **[config.RedisConfigSet](#RedisConfigSet)**<br>Unified configuration of a Redis cluster. 


### Resources {#Resources5}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access5}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


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

Moves a Redis cluster to the specified folder.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### MoveClusterRequest {#MoveClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to move. The maximum string length in characters is 50.
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
cluster_id | **string**<br>ID of the Redis cluster being moved. 
source_folder_id | **string**<br>ID of the source folder. 
destination_folder_id | **string**<br>ID of the destination folder. 


### Cluster {#Cluster6}

Field | Description
--- | ---
id | **string**<br>ID of the Redis cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Redis cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the Redis cluster. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the Redis cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Redis cluster as `key:value` pairs. Maximum 64 per cluster. 
environment | enum **Environment**<br>Deployment environment of the Redis cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring6)**<br>Description of monitoring systems relevant to the Redis cluster. 
config | **[ClusterConfig](#ClusterConfig6)**<br>Configuration of the Redis cluster. 
network_id | **string**<br> 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data)</li><li>`ALIVE`: Cluster is alive and well (all hosts are alive)</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions)</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions)</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster status is unknown</li><li>`CREATING`: Cluster is being created</li><li>`RUNNING`: Cluster is running</li><li>`ERROR`: Cluster failed</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Redis cluster mode on/off. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow6)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation6)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
tls_enabled | **bool**<br>TLS port and functionality on\off 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
persistence_mode | enum **PersistenceMode**<br>Persistence mode 
announce_hostnames | **bool**<br>Enable FQDN instead of ip 


### Monitoring {#Monitoring6}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Redis cluster. 


### ClusterConfig {#ClusterConfig6}

Field | Description
--- | ---
version | **string**<br>Version of Redis server software. 
redis_config | **oneof:** `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2` or `redis_config_7_0`<br>Configuration for Redis servers in the cluster.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Configuration of a Redis 5.0 server. 
&nbsp;&nbsp;redis_config_6_0 | **[config.RedisConfigSet6_0](#RedisConfigSet6_0)**<br>Configuration of a Redis 6.0 server. 
&nbsp;&nbsp;redis_config_6_2 | **[config.RedisConfigSet6_2](#RedisConfigSet6_2)**<br>Configuration of a Redis 6.2 server. 
&nbsp;&nbsp;redis_config_7_0 | **[config.RedisConfigSet7_0](#RedisConfigSet7_0)**<br>Configuration of a Redis 7.0 server. 
resources | **[Resources](#Resources6)**<br>Resources allocated to Redis hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access6)**<br>Access policy to DB 
redis | **[config.RedisConfigSet](#RedisConfigSet)**<br>Unified configuration of a Redis cluster. 


### Resources {#Resources6}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access6}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


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


## Backup {#Backup}

Creates a backup for the specified Redis cluster.

**rpc Backup ([BackupClusterRequest](#BackupClusterRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupClusterMetadata](#BackupClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster7)<br>

### BackupClusterRequest {#BackupClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to back up. To get the Redis cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation6}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster7)>**<br>if operation finished successfully. 


### BackupClusterMetadata {#BackupClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Redis cluster that is being backed up. 


### Cluster {#Cluster7}

Field | Description
--- | ---
id | **string**<br>ID of the Redis cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Redis cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the Redis cluster. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the Redis cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Redis cluster as `key:value` pairs. Maximum 64 per cluster. 
environment | enum **Environment**<br>Deployment environment of the Redis cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring7)**<br>Description of monitoring systems relevant to the Redis cluster. 
config | **[ClusterConfig](#ClusterConfig7)**<br>Configuration of the Redis cluster. 
network_id | **string**<br> 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data)</li><li>`ALIVE`: Cluster is alive and well (all hosts are alive)</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions)</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions)</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster status is unknown</li><li>`CREATING`: Cluster is being created</li><li>`RUNNING`: Cluster is running</li><li>`ERROR`: Cluster failed</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Redis cluster mode on/off. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow7)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation7)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
tls_enabled | **bool**<br>TLS port and functionality on\off 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
persistence_mode | enum **PersistenceMode**<br>Persistence mode 
announce_hostnames | **bool**<br>Enable FQDN instead of ip 


### Monitoring {#Monitoring7}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Redis cluster. 


### ClusterConfig {#ClusterConfig7}

Field | Description
--- | ---
version | **string**<br>Version of Redis server software. 
redis_config | **oneof:** `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2` or `redis_config_7_0`<br>Configuration for Redis servers in the cluster.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Configuration of a Redis 5.0 server. 
&nbsp;&nbsp;redis_config_6_0 | **[config.RedisConfigSet6_0](#RedisConfigSet6_0)**<br>Configuration of a Redis 6.0 server. 
&nbsp;&nbsp;redis_config_6_2 | **[config.RedisConfigSet6_2](#RedisConfigSet6_2)**<br>Configuration of a Redis 6.2 server. 
&nbsp;&nbsp;redis_config_7_0 | **[config.RedisConfigSet7_0](#RedisConfigSet7_0)**<br>Configuration of a Redis 7.0 server. 
resources | **[Resources](#Resources7)**<br>Resources allocated to Redis hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access7)**<br>Access policy to DB 
redis | **[config.RedisConfigSet](#RedisConfigSet)**<br>Unified configuration of a Redis cluster. 


### Resources {#Resources7}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access7}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


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


## Restore {#Restore}

Creates a new Redis cluster using the specified backup.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster8)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. ID of the backup to create a cluster from. To get the backup ID, use a [ClusterService.ListBackups](#ListBackups) request. 
name | **string**<br>Required. Name of the new Redis cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the new Redis cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Redis cluster as `` key:value `` pairs. Maximum 64 per cluster. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster8)**<br>Required. Deployment environment of the new Redis cluster. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Required. Configuration for the Redis cluster to be created. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Configurations for Redis hosts that should be created for the cluster that is being created from the backup. The number of elements must be greater than 0.
network_id | **string**<br>Required. ID of the network to create the Redis cluster in. The maximum string length in characters is 50.
folder_id | **string**<br>ID of the folder to create the Redis cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>User security groups 
tls_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>TLS port and functionality on\off 
persistence_mode | **[Cluster.PersistenceMode](#Cluster8)**<br>Persistence mode 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
announce_hostnames | **bool**<br>Enable FQDN instead of ip 


### ConfigSpec {#ConfigSpec2}

Field | Description
--- | ---
version | **string**<br>Version of Redis used in the cluster. 
redis_spec | **oneof:** `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2` or `redis_config_7_0`<br>Configuration of a Redis cluster.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfig5_0](#RedisConfig5_0)**<br>Configuration of a Redis cluster. 
&nbsp;&nbsp;redis_config_6_0 | **[config.RedisConfig6_0](#RedisConfig6_0)**<br>Configuration of a Redis cluster. 
&nbsp;&nbsp;redis_config_6_2 | **[config.RedisConfig6_2](#RedisConfig6_2)**<br>Configuration of a Redis cluster. 
&nbsp;&nbsp;redis_config_7_0 | **[config.RedisConfig7_0](#RedisConfig7_0)**<br>Configuration of a Redis cluster. 
resources | **[Resources](#Resources8)**<br>Resources allocated to Redis hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access8)**<br>Access policy to DB 
redis | **[config.RedisConfig](#RedisConfig)**<br>Unified configuration of a Redis cluster 


### Resources {#Resources8}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access8}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


### HostSpec {#HostSpec1}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. 
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster8). 
shard_name | **string**<br>ID of the Redis shard the host belongs to. To get the shard ID use a [ClusterService.ListShards](#ListShards) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
replica_priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>A replica with a low priority number is considered better for promotion. A replica with priority of 0 will never be selected by Redis Sentinel for promotion. Works only for non-sharded clusters. Default value is 100. 
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 


### Operation {#Operation7}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster8)>**<br>if operation finished successfully. 


### RestoreClusterMetadata {#RestoreClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the new Redis cluster that is being created from a backup. 
backup_id | **string**<br>ID of the backup that is being used for creating a cluster. 


### Cluster {#Cluster8}

Field | Description
--- | ---
id | **string**<br>ID of the Redis cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Redis cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the Redis cluster. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the Redis cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Redis cluster as `key:value` pairs. Maximum 64 per cluster. 
environment | enum **Environment**<br>Deployment environment of the Redis cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring8)**<br>Description of monitoring systems relevant to the Redis cluster. 
config | **[ClusterConfig](#ClusterConfig8)**<br>Configuration of the Redis cluster. 
network_id | **string**<br> 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data)</li><li>`ALIVE`: Cluster is alive and well (all hosts are alive)</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions)</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions)</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster status is unknown</li><li>`CREATING`: Cluster is being created</li><li>`RUNNING`: Cluster is running</li><li>`ERROR`: Cluster failed</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Redis cluster mode on/off. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow8)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation8)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
tls_enabled | **bool**<br>TLS port and functionality on\off 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
persistence_mode | enum **PersistenceMode**<br>Persistence mode 
announce_hostnames | **bool**<br>Enable FQDN instead of ip 


### Monitoring {#Monitoring8}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Redis cluster. 


### ClusterConfig {#ClusterConfig8}

Field | Description
--- | ---
version | **string**<br>Version of Redis server software. 
redis_config | **oneof:** `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2` or `redis_config_7_0`<br>Configuration for Redis servers in the cluster.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Configuration of a Redis 5.0 server. 
&nbsp;&nbsp;redis_config_6_0 | **[config.RedisConfigSet6_0](#RedisConfigSet6_0)**<br>Configuration of a Redis 6.0 server. 
&nbsp;&nbsp;redis_config_6_2 | **[config.RedisConfigSet6_2](#RedisConfigSet6_2)**<br>Configuration of a Redis 6.2 server. 
&nbsp;&nbsp;redis_config_7_0 | **[config.RedisConfigSet7_0](#RedisConfigSet7_0)**<br>Configuration of a Redis 7.0 server. 
resources | **[Resources](#Resources9)**<br>Resources allocated to Redis hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access9)**<br>Access policy to DB 
redis | **[config.RedisConfigSet](#RedisConfigSet)**<br>Unified configuration of a Redis cluster. 


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


## RescheduleMaintenance {#RescheduleMaintenance}

Reschedules planned maintenance operation.

**rpc RescheduleMaintenance ([RescheduleMaintenanceRequest](#RescheduleMaintenanceRequest)) returns ([operation.Operation](#Operation8))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RescheduleMaintenanceMetadata](#RescheduleMaintenanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster9)<br>

### RescheduleMaintenanceRequest {#RescheduleMaintenanceRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to reschedule the maintenance operation for. The maximum string length in characters is 50.
reschedule_type | enum **RescheduleType**<br>Required. The type of reschedule request. <ul><li>`IMMEDIATE`: Start the maintenance operation immediately.</li><li>`NEXT_AVAILABLE_WINDOW`: Start the maintenance operation within the next available maintenance window.</li><li>`SPECIFIC_TIME`: Start the maintenance operation at the specific time.</li></ul>
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time until which this maintenance operation should be delayed. The value should be ahead of the first time when the maintenance operation has been scheduled for no more than two weeks. The value can also point to the past moment of time if `reschedule_type.IMMEDIATE` reschedule type is chosen. 


### Operation {#Operation8}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster9)>**<br>if operation finished successfully. 


### RescheduleMaintenanceMetadata {#RescheduleMaintenanceMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster. 
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. The time until which this maintenance operation is to be delayed. 


### Cluster {#Cluster9}

Field | Description
--- | ---
id | **string**<br>ID of the Redis cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Redis cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the Redis cluster. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the Redis cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Redis cluster as `key:value` pairs. Maximum 64 per cluster. 
environment | enum **Environment**<br>Deployment environment of the Redis cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring9)**<br>Description of monitoring systems relevant to the Redis cluster. 
config | **[ClusterConfig](#ClusterConfig9)**<br>Configuration of the Redis cluster. 
network_id | **string**<br> 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data)</li><li>`ALIVE`: Cluster is alive and well (all hosts are alive)</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions)</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions)</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster status is unknown</li><li>`CREATING`: Cluster is being created</li><li>`RUNNING`: Cluster is running</li><li>`ERROR`: Cluster failed</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Redis cluster mode on/off. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow9)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation9)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
tls_enabled | **bool**<br>TLS port and functionality on\off 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
persistence_mode | enum **PersistenceMode**<br>Persistence mode 
announce_hostnames | **bool**<br>Enable FQDN instead of ip 


### Monitoring {#Monitoring9}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Redis cluster. 


### ClusterConfig {#ClusterConfig9}

Field | Description
--- | ---
version | **string**<br>Version of Redis server software. 
redis_config | **oneof:** `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2` or `redis_config_7_0`<br>Configuration for Redis servers in the cluster.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Configuration of a Redis 5.0 server. 
&nbsp;&nbsp;redis_config_6_0 | **[config.RedisConfigSet6_0](#RedisConfigSet6_0)**<br>Configuration of a Redis 6.0 server. 
&nbsp;&nbsp;redis_config_6_2 | **[config.RedisConfigSet6_2](#RedisConfigSet6_2)**<br>Configuration of a Redis 6.2 server. 
&nbsp;&nbsp;redis_config_7_0 | **[config.RedisConfigSet7_0](#RedisConfigSet7_0)**<br>Configuration of a Redis 7.0 server. 
resources | **[Resources](#Resources9)**<br>Resources allocated to Redis hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access9)**<br>Access policy to DB 
redis | **[config.RedisConfigSet](#RedisConfigSet)**<br>Unified configuration of a Redis cluster. 


### Resources {#Resources9}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access9}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


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


## StartFailover {#StartFailover}

Start a manual failover on the specified Redis cluster.

**rpc StartFailover ([StartClusterFailoverRequest](#StartClusterFailoverRequest)) returns ([operation.Operation](#Operation9))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterFailoverMetadata](#StartClusterFailoverMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster10)<br>

### StartClusterFailoverRequest {#StartClusterFailoverRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to start failover on. The maximum string length in characters is 50.
host_names[] | **string**<br>List of hostnames which should not be masters. Can be empty for sentinel clusters or can contain multiple hosts for sharded clusters. The maximum string length in characters for each value is 253.


### Operation {#Operation9}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartClusterFailoverMetadata](#StartClusterFailoverMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster10)>**<br>if operation finished successfully. 


### StartClusterFailoverMetadata {#StartClusterFailoverMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Redis cluster on which failover will be initiated. 
host_names[] | **string**<br>List of hostnames which should not be masters. Can be empty for sentinel clusters or can contain multiple hosts for sharded clusters. 


### Cluster {#Cluster10}

Field | Description
--- | ---
id | **string**<br>ID of the Redis cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Redis cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the Redis cluster. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the Redis cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Redis cluster as `key:value` pairs. Maximum 64 per cluster. 
environment | enum **Environment**<br>Deployment environment of the Redis cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring10)**<br>Description of monitoring systems relevant to the Redis cluster. 
config | **[ClusterConfig](#ClusterConfig10)**<br>Configuration of the Redis cluster. 
network_id | **string**<br> 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data)</li><li>`ALIVE`: Cluster is alive and well (all hosts are alive)</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions)</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions)</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster status is unknown</li><li>`CREATING`: Cluster is being created</li><li>`RUNNING`: Cluster is running</li><li>`ERROR`: Cluster failed</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Redis cluster mode on/off. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow10)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation10)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
tls_enabled | **bool**<br>TLS port and functionality on\off 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
persistence_mode | enum **PersistenceMode**<br>Persistence mode 
announce_hostnames | **bool**<br>Enable FQDN instead of ip 


### Monitoring {#Monitoring10}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Redis cluster. 


### ClusterConfig {#ClusterConfig10}

Field | Description
--- | ---
version | **string**<br>Version of Redis server software. 
redis_config | **oneof:** `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2` or `redis_config_7_0`<br>Configuration for Redis servers in the cluster.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Configuration of a Redis 5.0 server. 
&nbsp;&nbsp;redis_config_6_0 | **[config.RedisConfigSet6_0](#RedisConfigSet6_0)**<br>Configuration of a Redis 6.0 server. 
&nbsp;&nbsp;redis_config_6_2 | **[config.RedisConfigSet6_2](#RedisConfigSet6_2)**<br>Configuration of a Redis 6.2 server. 
&nbsp;&nbsp;redis_config_7_0 | **[config.RedisConfigSet7_0](#RedisConfigSet7_0)**<br>Configuration of a Redis 7.0 server. 
resources | **[Resources](#Resources10)**<br>Resources allocated to Redis hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access10)**<br>Access policy to DB 
redis | **[config.RedisConfigSet](#RedisConfigSet)**<br>Unified configuration of a Redis cluster. 


### Resources {#Resources10}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access10}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


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

Retrieves logs for the specified Redis cluster.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to request logs for. To get the Redis cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from the logs table to request. If no columns are specified, entire log records are returned. 
service_type | enum **ServiceType**<br> <ul><li>`REDIS`: Logs of Redis activity.</li></ul>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterLogsResponse {#ListClusterLogsResponse}

Field | Description
--- | ---
logs[] | **[LogRecord](#LogRecord)**<br>Requested log records. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterLogsRequest.page_size](#ListClusterLogsRequest), use the `next_page_token` as the value for the [ListClusterLogsRequest.page_token](#ListClusterLogsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. This value is interchangeable with `next_record_token` from StreamLogs method. 


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
cluster_id | **string**<br>Required. Required. ID of the Redis cluster. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from logs table to get in the response. 
service_type | enum **ServiceType**<br> <ul><li>`REDIS`: Logs of Redis activity.</li></ul>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request. If this field is not set, all existing logs will be sent and then the new ones as they appear. In essence it has 'tail -f' semantics. 
record_token | **string**<br>Record token. Set `record_token` to the `next_record_token` returned by a previous StreamLogs request to start streaming from next log record. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently filtering can be applied to the [LogRecord.logs.hostname](#LogRecord) field </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Examples of a filter `message.hostname='node1.db.cloud.yandex.net'`. The maximum string length in characters is 1000.


### StreamLogRecord {#StreamLogRecord}

Field | Description
--- | ---
record | **[LogRecord](#LogRecord)**<br>One of the requested log records. 
next_record_token | **string**<br>This token allows you to continue streaming logs starting from the exact same record. To continue streaming, specify value of `next_record_token` as value for `record_token` parameter in the next StreamLogs request. This value is interchangeable with `next_page_token` from ListLogs method. 


### LogRecord {#LogRecord1}

Field | Description
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log record timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
message | **map<string,string>**<br>Contents of the log record. 


## ListOperations {#ListOperations}

Retrieves the list of operations for the specified cluster.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation10)**<br>List of operations for the specified Redis cluster. 
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

Retrieves the list of available backups for the specified Redis cluster.

**rpc ListBackups ([ListClusterBackupsRequest](#ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#ListClusterBackupsResponse))**

### ListClusterBackupsRequest {#ListClusterBackupsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster. To get the Redis cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterBackupsResponse {#ListClusterBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup)**<br>List of Redis backups. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterBackupsRequest.page_size](#ListClusterBackupsRequest), use the `next_page_token` as the value for the [ListClusterBackupsRequest.page_token](#ListClusterBackupsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format (i.e. when the backup operation was completed). 
source_cluster_id | **string**<br>ID of the Redis cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format (i.e. when the backup operation was started). 
source_shard_names[] | **string**<br>Shard names used as a source for backup. 


## ListHosts {#ListHosts}

Retrieves a list of hosts for the specified cluster.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster. To get the Redis cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](#Host)**<br>List of hosts for the cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
name | **string**<br>Name of the Redis host. The host name is assigned by MDB at creation time, and cannot be changed. 1-63 characters long. <br>The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. 
cluster_id | **string**<br>ID of the Redis cluster. The ID is assigned by MDB at creation time. 
zone_id | **string**<br>ID of the availability zone where the Redis host resides. 
subnet_id | **string**<br>ID of the subnet that the host belongs to. 
resources | **[Resources](#Resources11)**<br>Resources allocated to the Redis host. 
role | enum **Role**<br>Role of the host in the cluster. If the field has default value, it is not returned in the response. <ul><li>`ROLE_UNKNOWN`: Role of the host in the cluster is unknown. Default value.</li><li>`MASTER`: Host is the master Redis server in the cluster.</li><li>`REPLICA`: Host is a replica (standby) Redis server in the cluster.</li></ul>
health | enum **Health**<br>Aggregated health of the host. If the field has default value, it is not returned in the response. <ul><li>`HEALTH_UNKNOWN`: Health of the host is unknown. Default value.</li><li>`ALIVE`: The host is performing all its functions normally.</li><li>`DEAD`: The host is inoperable, and cannot perform any of its essential functions.</li><li>`DEGRADED`: The host is degraded, and can perform only some of its essential functions.</li></ul>
services[] | **[Service](#Service)**<br>Services provided by the host. 
shard_name | **string**<br> 
replica_priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>A replica with a low priority number is considered better for promotion. A replica with priority of 0 will never be selected by Redis Sentinel for promotion. Works only for non-sharded clusters. Default value is 100. 
assign_public_ip | **bool**<br>Flag showing public IP assignment status to this host. 


### Resources {#Resources11}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Service {#Service}

Field | Description
--- | ---
type | enum **Type**<br>Type of the service provided by the host. If the field has default value, it is not returned in the response. <ul><li>`TYPE_UNSPECIFIED`: Service type of the host is unspecified. Default value.</li><li>`REDIS`: The host is a Redis server.</li><li>`ARBITER`: The host provides a Sentinel-only service (a quorum node).</li><li>`REDIS_CLUSTER`: The host is a Redis Cluster node.</li></ul>
health | enum **Health**<br>Aggregated health of the service. If the field has default value, it is not returned in the response. <ul><li>`HEALTH_UNKNOWN`: Health of the server is unknown. Default value.</li><li>`ALIVE`: The server is working normally.</li><li>`DEAD`: The server is dead or unresponsive.</li></ul>


## AddHosts {#AddHosts}

Creates new hosts for a cluster.

**rpc AddHosts ([AddClusterHostsRequest](#AddClusterHostsRequest)) returns ([operation.Operation](#Operation11))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterHostsMetadata](#AddClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddClusterHostsRequest {#AddClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to add hosts to. To get the Redis cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
host_specs[] | **[HostSpec](#HostSpec)**<br>Configurations for Redis hosts that should be added to the cluster. The number of elements must be greater than 0.


### HostSpec {#HostSpec2}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. 
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster11). 
shard_name | **string**<br>ID of the Redis shard the host belongs to. To get the shard ID use a [ClusterService.ListShards](#ListShards) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
replica_priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>A replica with a low priority number is considered better for promotion. A replica with priority of 0 will never be selected by Redis Sentinel for promotion. Works only for non-sharded clusters. Default value is 100. 
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 


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
cluster_id | **string**<br>ID of the Redis cluster to which the hosts are being added. 
host_names[] | **string**<br>Names of hosts that are being added to the cluster. 


## DeleteHosts {#DeleteHosts}

Deletes the specified hosts for a cluster.

**rpc DeleteHosts ([DeleteClusterHostsRequest](#DeleteClusterHostsRequest)) returns ([operation.Operation](#Operation12))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterHostsMetadata](#DeleteClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterHostsRequest {#DeleteClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to remove hosts from. To get the Redis cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
host_names[] | **string**<br>Names of hosts to delete. The number of elements must be greater than 0. The maximum string length in characters for each value is 253.


### Operation {#Operation12}

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
cluster_id | **string**<br>ID of the Redis cluster to remove hosts from. 
host_names[] | **string**<br>Names of hosts that are being deleted. 


## UpdateHosts {#UpdateHosts}

Updates the specified hosts.

**rpc UpdateHosts ([UpdateClusterHostsRequest](#UpdateClusterHostsRequest)) returns ([operation.Operation](#Operation13))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterHostsMetadata](#UpdateClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateClusterHostsRequest {#UpdateClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to update hosts in. To get the Redis cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_host_specs[] | **[UpdateHostSpec](#UpdateHostSpec)**<br>New configurations to apply to hosts. The number of elements must be greater than 0.


### UpdateHostSpec {#UpdateHostSpec}

Field | Description
--- | ---
host_name | **string**<br>Required. Name of the host to update. To get the Redis host name, use a [ClusterService.ListHosts](#ListHosts) request. 
replica_priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>A replica with a low priority number is considered better for promotion. A replica with priority of 0 will never be selected by Redis Sentinel for promotion. Works only for non-sharded clusters. Default value is 100. 
assign_public_ip | **bool**<br>Whether the host should get a public IP address on update. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Redis host should be updated. 


### Operation {#Operation13}

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
cluster_id | **string**<br>ID of the Redis cluster to update hosts in. 
host_names[] | **string**<br>Names of hosts that are being updated. 


## GetShard {#GetShard}

Returns the specified shard.

**rpc GetShard ([GetClusterShardRequest](#GetClusterShardRequest)) returns ([Shard](#Shard))**

### GetClusterShardRequest {#GetClusterShardRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster the shard belongs to. To get the cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name of Redis shard to return. To get the shard name use a [ClusterService.ListShards](#ListShards) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Shard {#Shard}

Field | Description
--- | ---
name | **string**<br>Name of the Redis shard. The shard name is assigned by user at creation time, and cannot be changed. 1-63 characters long. 
cluster_id | **string**<br>ID of the Redis cluster the shard belongs to. The ID is assigned by MDB at creation time. 


## ListShards {#ListShards}

Retrieves a list of shards.

**rpc ListShards ([ListClusterShardsRequest](#ListClusterShardsRequest)) returns ([ListClusterShardsResponse](#ListClusterShardsResponse))**

### ListClusterShardsRequest {#ListClusterShardsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to list shards in. To get the cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterShardsResponse.next_page_token](#ListClusterShardsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterShardsResponse.next_page_token](#ListClusterShardsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterShardsResponse {#ListClusterShardsResponse}

Field | Description
--- | ---
shards[] | **[Shard](#Shard1)**<br>List of Redis shards. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterShardsRequest.page_size](#ListClusterShardsRequest), use the `next_page_token` as the value for the [ListClusterShardsRequest.page_token](#ListClusterShardsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Shard {#Shard1}

Field | Description
--- | ---
name | **string**<br>Name of the Redis shard. The shard name is assigned by user at creation time, and cannot be changed. 1-63 characters long. 
cluster_id | **string**<br>ID of the Redis cluster the shard belongs to. The ID is assigned by MDB at creation time. 


## AddShard {#AddShard}

Creates a new shard.

**rpc AddShard ([AddClusterShardRequest](#AddClusterShardRequest)) returns ([operation.Operation](#Operation14))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterShardMetadata](#AddClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Shard](#Shard2)<br>

### AddClusterShardRequest {#AddClusterShardRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to create a shard in. To get the cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name of the shard. The name must be unique within the cluster. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
host_specs[] | **[HostSpec](#HostSpec)**<br>Configurations for Redis hosts that should be created with the shard. Must contain at least one element. The number of elements must be greater than 0.


### HostSpec {#HostSpec3}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. 
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster11). 
shard_name | **string**<br>ID of the Redis shard the host belongs to. To get the shard ID use a [ClusterService.ListShards](#ListShards) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
replica_priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>A replica with a low priority number is considered better for promotion. A replica with priority of 0 will never be selected by Redis Sentinel for promotion. Works only for non-sharded clusters. Default value is 100. 
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 


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
cluster_id | **string**<br>ID of the Redis cluster that a shard is being added to. 
shard_name | **string**<br>Name of the Redis shard that is being created. 


### Shard {#Shard2}

Field | Description
--- | ---
name | **string**<br>Name of the Redis shard. The shard name is assigned by user at creation time, and cannot be changed. 1-63 characters long. 
cluster_id | **string**<br>ID of the Redis cluster the shard belongs to. The ID is assigned by MDB at creation time. 


## DeleteShard {#DeleteShard}

Deletes the specified shard.

**rpc DeleteShard ([DeleteClusterShardRequest](#DeleteClusterShardRequest)) returns ([operation.Operation](#Operation15))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterShardMetadata](#DeleteClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterShardRequest {#DeleteClusterShardRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster the shard belongs to. To get the cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name of the Redis shard to delete. To get the shard name use a [ClusterService.ListShards](#ListShards) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation15}

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
cluster_id | **string**<br>ID of the Redis cluster the shard belongs to. 
shard_name | **string**<br>Name of the Redis shard that is being deleted. 


## Rebalance {#Rebalance}

Rebalances the cluster. Evenly distributes all the hash slots between the shards.

**rpc Rebalance ([RebalanceClusterRequest](#RebalanceClusterRequest)) returns ([operation.Operation](#Operation16))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RebalanceClusterMetadata](#RebalanceClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster11)<br>

### RebalanceClusterRequest {#RebalanceClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Redis cluster to rebalance. To get the cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation16}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RebalanceClusterMetadata](#RebalanceClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster11)>**<br>if operation finished successfully. 


### RebalanceClusterMetadata {#RebalanceClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Redis cluster that is being rebalancing. 


### Cluster {#Cluster11}

Field | Description
--- | ---
id | **string**<br>ID of the Redis cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Redis cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the Redis cluster. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the Redis cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Redis cluster as `key:value` pairs. Maximum 64 per cluster. 
environment | enum **Environment**<br>Deployment environment of the Redis cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring11)**<br>Description of monitoring systems relevant to the Redis cluster. 
config | **[ClusterConfig](#ClusterConfig11)**<br>Configuration of the Redis cluster. 
network_id | **string**<br> 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data)</li><li>`ALIVE`: Cluster is alive and well (all hosts are alive)</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions)</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions)</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster status is unknown</li><li>`CREATING`: Cluster is being created</li><li>`RUNNING`: Cluster is running</li><li>`ERROR`: Cluster failed</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Redis cluster mode on/off. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow11)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation11)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
tls_enabled | **bool**<br>TLS port and functionality on\off 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
persistence_mode | enum **PersistenceMode**<br>Persistence mode 
announce_hostnames | **bool**<br>Enable FQDN instead of ip 


### Monitoring {#Monitoring11}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Redis cluster. 


### ClusterConfig {#ClusterConfig11}

Field | Description
--- | ---
version | **string**<br>Version of Redis server software. 
redis_config | **oneof:** `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2` or `redis_config_7_0`<br>Configuration for Redis servers in the cluster.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Configuration of a Redis 5.0 server. 
&nbsp;&nbsp;redis_config_6_0 | **[config.RedisConfigSet6_0](#RedisConfigSet6_0)**<br>Configuration of a Redis 6.0 server. 
&nbsp;&nbsp;redis_config_6_2 | **[config.RedisConfigSet6_2](#RedisConfigSet6_2)**<br>Configuration of a Redis 6.2 server. 
&nbsp;&nbsp;redis_config_7_0 | **[config.RedisConfigSet7_0](#RedisConfigSet7_0)**<br>Configuration of a Redis 7.0 server. 
resources | **[Resources](#Resources12)**<br>Resources allocated to Redis hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access11)**<br>Access policy to DB 
redis | **[config.RedisConfigSet](#RedisConfigSet)**<br>Unified configuration of a Redis cluster. 


### Resources {#Resources12}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access11}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


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


## EnableSharding {#EnableSharding}

Enable Sharding on non sharded cluster

**rpc EnableSharding ([EnableShardingClusterRequest](#EnableShardingClusterRequest)) returns ([operation.Operation](#Operation17))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[EnableShardingClusterMetadata](#EnableShardingClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster12)<br>

### EnableShardingClusterRequest {#EnableShardingClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the Redis cluster to return. The maximum string length in characters is 50.


### Operation {#Operation17}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[EnableShardingClusterMetadata](#EnableShardingClusterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster12)>**<br>if operation finished successfully. 


### EnableShardingClusterMetadata {#EnableShardingClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br> 


### Cluster {#Cluster12}

Field | Description
--- | ---
id | **string**<br>ID of the Redis cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Redis cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the Redis cluster. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the Redis cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Redis cluster as `key:value` pairs. Maximum 64 per cluster. 
environment | enum **Environment**<br>Deployment environment of the Redis cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring12)**<br>Description of monitoring systems relevant to the Redis cluster. 
config | **[ClusterConfig](#ClusterConfig12)**<br>Configuration of the Redis cluster. 
network_id | **string**<br> 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data)</li><li>`ALIVE`: Cluster is alive and well (all hosts are alive)</li><li>`DEAD`: Cluster is inoperable (it cannot perform any of its essential functions)</li><li>`DEGRADED`: Cluster is partially alive (it can perform some of its essential functions)</li></ul>
status | enum **Status**<br>Cluster status. <ul><li>`STATUS_UNKNOWN`: Cluster status is unknown</li><li>`CREATING`: Cluster is being created</li><li>`RUNNING`: Cluster is running</li><li>`ERROR`: Cluster failed</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Redis cluster mode on/off. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow12)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation12)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
tls_enabled | **bool**<br>TLS port and functionality on\off 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
persistence_mode | enum **PersistenceMode**<br>Persistence mode 
announce_hostnames | **bool**<br>Enable FQDN instead of ip 


### Monitoring {#Monitoring12}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Redis cluster. 


### ClusterConfig {#ClusterConfig12}

Field | Description
--- | ---
version | **string**<br>Version of Redis server software. 
redis_config | **oneof:** `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2` or `redis_config_7_0`<br>Configuration for Redis servers in the cluster.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Configuration of a Redis 5.0 server. 
&nbsp;&nbsp;redis_config_6_0 | **[config.RedisConfigSet6_0](#RedisConfigSet6_0)**<br>Configuration of a Redis 6.0 server. 
&nbsp;&nbsp;redis_config_6_2 | **[config.RedisConfigSet6_2](#RedisConfigSet6_2)**<br>Configuration of a Redis 6.2 server. 
&nbsp;&nbsp;redis_config_7_0 | **[config.RedisConfigSet7_0](#RedisConfigSet7_0)**<br>Configuration of a Redis 7.0 server. 
resources | **[Resources](#Resources13)**<br>Resources allocated to Redis hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access12)**<br>Access policy to DB 
redis | **[config.RedisConfigSet](#RedisConfigSet)**<br>Unified configuration of a Redis cluster. 


### Resources {#Resources13}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access12}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


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


