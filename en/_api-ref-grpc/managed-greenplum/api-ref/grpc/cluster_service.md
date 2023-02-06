---
editable: false
---

# Managed Service for Greenplum® API, gRPC: ClusterService

A set of methods for managing Greenplum® clusters.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Greenplum® cluster. |
| [List](#List) | Retrieves a list of Greenplum® clusters that belong to the specified folder. |
| [Create](#Create) | Creates a Greenplum® cluster in the specified folder. |
| [Update](#Update) | Updates the specified Greenplum® cluster. |
| [Expand](#Expand) | Expands the specified Greenplum® cluster. |
| [Delete](#Delete) | Deletes the specified Greenplum® cluster. |
| [Start](#Start) | Starts the specified Greenplum® cluster. |
| [Stop](#Stop) | Stops the specified Greenplum® cluster. |
| [ListOperations](#ListOperations) | Retrieves the list of Operation resources for the specified cluster. |
| [ListMasterHosts](#ListMasterHosts) | Retrieves a list of master hosts for the specified cluster. |
| [ListSegmentHosts](#ListSegmentHosts) | Retrieves a list of segment hosts for the specified cluster. |
| [ListLogs](#ListLogs) | Retrieves logs for the specified Greenplum® cluster. |
| [StreamLogs](#StreamLogs) | Same as [ListLogs](#ListLogs) but using server-side streaming. |
| [ListBackups](#ListBackups) | Retrieves a list of available backups for the specified Greenplum® cluster. |
| [Restore](#Restore) | Creates a new Greenplum® cluster using the specified backup. |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified Greenplum® cluster. <br>To get the list of all available Greenplum® clusters, make a [List](#List) request.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® cluster resource to return. <br>To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum® cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the Greenplum® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Required. Name of the Greenplum® cluster. The name is unique within the folder. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig)**<br>Greenplum® cluster configuration. 
description | **string**<br>Description of the Greenplum® cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum® cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring)**<br>Description of monitoring systems relevant to the Greenplum® cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig)**<br>Configuration of the Greenplum® segment subcluster. 
master_host_count | **int64**<br>Number of hosts in the master subcluster. 
segment_host_count | **int64**<br>Number of hosts in the segment subcluster. 
segment_in_host | **int64**<br>Number of segments per host. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><li>`UNBALANCED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is UNBALANCED).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow)**<br>A Greenplum® cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation)**<br>Maintenance operation planned at nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups. 
user_name | **string**<br>Owner user name. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
cluster_config | **[ClusterConfigSet](#ClusterConfigSet)**<br>Greenplum® and Odyssey® configuration. 


### GreenplumConfig {#GreenplumConfig}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum® server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#Cluster1)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Determines whether the cluster has a public IP address. <br>After the cluster has been created, this setting cannot be changed. 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allows data export from the cluster to DataLens. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from the management console. 
data_transfer | **bool**<br>Allows access for DataTransfer. 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum® cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig}

Field | Description
--- | ---
resources | **[Resources](#Resources)**<br>Computational resources allocated to Greenplum® master subcluster hosts. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. <br>Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig}

Field | Description
--- | ---
resources | **[Resources](#Resources1)**<br>Computational resources allocated to Greenplum® segment subcluster hosts. 


### MaintenanceWindow {#MaintenanceWindow}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow)**<br>An any-time maintenance window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow)**<br>A weekly maintenance window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week. <ul><li>`MON`: Monday</li><li>`TUE`: Tuesday</li><li>`WED`: Wednesday</li><li>`THU`: Thursday</li><li>`FRI`: Friday</li><li>`SAT`: Saturday</li><li>`SUN`: Sunday</li></ul>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation}

Field | Description
--- | ---
info | **string**<br>The description of the operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 


### ClusterConfigSet {#ClusterConfigSet}

Field | Description
--- | ---
greenplum_config | **oneof:** `greenplum_config_set_6_17` or `greenplum_config_set_6_19`<br>
&nbsp;&nbsp;greenplum_config_set_6_17 | **[GreenplumConfigSet6_17](#GreenplumConfigSet6_17)**<br> 
&nbsp;&nbsp;greenplum_config_set_6_19 | **[GreenplumConfigSet6_19](#GreenplumConfigSet6_19)**<br> 
pool | **[ConnectionPoolerConfigSet](#ConnectionPoolerConfigSet)**<br>Odyssey® pool settings. 


### GreenplumConfigSet6_17 {#GreenplumConfigSet6_17}

Field | Description
--- | ---
effective_config | **[GreenplumConfig6_17](#GreenplumConfig6_17)**<br>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in [GreenplumConfigSet6_17.user_config](#GreenplumConfigSet6_17) and [GreenplumConfigSet6_17.default_config](#GreenplumConfigSet6_17)). 
user_config | **[GreenplumConfig6_17](#GreenplumConfig6_17)**<br>User-defined settings for a Greenplum® cluster. 
default_config | **[GreenplumConfig6_17](#GreenplumConfig6_17)**<br>Default configuration for a Greenplum® cluster. 


### GreenplumConfig6_17 {#GreenplumConfig6_17}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary spill files allowed per query at each segment. <br>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated. <br>The current query is terminated if the limit is exceeded. <br>Set to zero to disable the limit. <br>Master session reloads if the parameter changes. <br>Default value is 10000. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of transactions that can be in the `prepared` state simultaneously. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the spill files are compressed or not. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 


### GreenplumConfigSet6_19 {#GreenplumConfigSet6_19}

Field | Description
--- | ---
effective_config | **[GreenplumConfig6_19](#GreenplumConfig6_19)**<br>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in [GreenplumConfigSet6_19.user_config](#GreenplumConfigSet6_19) and [GreenplumConfigSet6_19.default_config](#GreenplumConfigSet6_19)). 
user_config | **[GreenplumConfig6_19](#GreenplumConfig6_19)**<br>User-defined settings for a Greenplum® cluster. 
default_config | **[GreenplumConfig6_19](#GreenplumConfig6_19)**<br>Default configuration for a Greenplum® cluster. 


### GreenplumConfig6_19 {#GreenplumConfig6_19}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary spill files allowed per query at each segment. <br>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated. <br>The current query is terminated if the limit is exceeded. <br>Set to zero to disable the limit. <br>Master session reloads if the parameter changes. <br>Default value is 10000. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of transactions that can be in the `prepared` state simultaneously. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the spill files are compressed or not. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 
max_statement_mem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum memory limit for a query, in bytes. <br>Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting `statement_mem` too high. <br>Taking into account the configuration of a single segment host, calculate `max_statement_mem` as follows: `seghost_physical_memory` / `average_number_concurrent_queries`. <br>When changing both `max_statement_mem` and `statement_mem`, `max_statement_mem` must be changed first, or listed first in the `postgresql.conf` file. <br>Default value is 2097152000 (2000 MB). <br>More info in [Greenplum® documentation](https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem). 
log_statement | enum **LogStatement**<br>Logged SQL statements. <br>`PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command belongs to an appropriate type. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement). <ul><li>`NONE`: None statements are logged.</li><li>`DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.</li><li>`MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.</li><li>`ALL`: Logs all statements.</li></ul>


### ConnectionPoolerConfigSet {#ConnectionPoolerConfigSet}

Field | Description
--- | ---
effective_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig)**<br>Required. Effective settings for an Odyssey® pooler (a combination of settings defined in [ConnectionPoolerConfigSet.user_config](#ConnectionPoolerConfigSet) and [ConnectionPoolerConfigSet.default_config](#ConnectionPoolerConfigSet)). 
user_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig)**<br>User-defined settings for an Odyssey® pooler. 
default_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig)**<br>Default configuration for an Odyssey® pooler. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig}

Field | Description
--- | ---
mode | enum **PoolMode**<br>Route server pool mode. <ul><li>`SESSION`: Assign server connection to a client until it disconnects. Default value.</li><li>`TRANSACTION`: Assign server connection to a client for a transaction processing.</li></ul>
size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. <br>Set to zero to disable the limit. 
client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Server pool idle timeout, in seconds. <br>A server connection closes after being idle for the specified time. <br>Set to zero to disable the limit. 


## List {#List}

Retrieves a list of Greenplum® clusters that belong to the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list Greenplum® clusters in. <br>To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by the previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <br><ol><li>The field name. Currently you can only use filtering with the [Cluster.name](#Cluster1) field. </li></ol><br><ol><li>An `=` operator. </li></ol><br><ol><li>The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`.</li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of Greenplum® cluster resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest) parameter in the next list request. <br>Each subsequent list request has its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster1}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum® cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the Greenplum® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Required. Name of the Greenplum® cluster. The name is unique within the folder. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig1)**<br>Greenplum® cluster configuration. 
description | **string**<br>Description of the Greenplum® cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum® cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Description of monitoring systems relevant to the Greenplum® cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig1)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig1)**<br>Configuration of the Greenplum® segment subcluster. 
master_host_count | **int64**<br>Number of hosts in the master subcluster. 
segment_host_count | **int64**<br>Number of hosts in the segment subcluster. 
segment_in_host | **int64**<br>Number of segments per host. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><li>`UNBALANCED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is UNBALANCED).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow1)**<br>A Greenplum® cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation1)**<br>Maintenance operation planned at nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups. 
user_name | **string**<br>Owner user name. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
cluster_config | **[ClusterConfigSet](#ClusterConfigSet1)**<br>Greenplum® and Odyssey® configuration. 


### GreenplumConfig {#GreenplumConfig1}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum® server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access1)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#Cluster2)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Determines whether the cluster has a public IP address. <br>After the cluster has been created, this setting cannot be changed. 


### Access {#Access1}

Field | Description
--- | ---
data_lens | **bool**<br>Allows data export from the cluster to DataLens. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from the management console. 
data_transfer | **bool**<br>Allows access for DataTransfer. 


### Monitoring {#Monitoring1}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum® cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig1}

Field | Description
--- | ---
resources | **[Resources](#Resources1)**<br>Computational resources allocated to Greenplum® master subcluster hosts. 


### Resources {#Resources1}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. <br>Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig1}

Field | Description
--- | ---
resources | **[Resources](#Resources2)**<br>Computational resources allocated to Greenplum® segment subcluster hosts. 


### MaintenanceWindow {#MaintenanceWindow1}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow1)**<br>An any-time maintenance window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow1)**<br>A weekly maintenance window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow1}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow1}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week. <ul><li>`MON`: Monday</li><li>`TUE`: Tuesday</li><li>`WED`: Wednesday</li><li>`THU`: Thursday</li><li>`FRI`: Friday</li><li>`SAT`: Saturday</li><li>`SUN`: Sunday</li></ul>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation1}

Field | Description
--- | ---
info | **string**<br>The description of the operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 


### ClusterConfigSet {#ClusterConfigSet1}

Field | Description
--- | ---
greenplum_config | **oneof:** `greenplum_config_set_6_17` or `greenplum_config_set_6_19`<br>
&nbsp;&nbsp;greenplum_config_set_6_17 | **[GreenplumConfigSet6_17](#GreenplumConfigSet6_171)**<br> 
&nbsp;&nbsp;greenplum_config_set_6_19 | **[GreenplumConfigSet6_19](#GreenplumConfigSet6_191)**<br> 
pool | **[ConnectionPoolerConfigSet](#ConnectionPoolerConfigSet1)**<br>Odyssey® pool settings. 


### GreenplumConfigSet6_17 {#GreenplumConfigSet6_171}

Field | Description
--- | ---
effective_config | **[GreenplumConfig6_17](#GreenplumConfig6_171)**<br>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in [GreenplumConfigSet6_17.user_config](#GreenplumConfigSet6_171) and [GreenplumConfigSet6_17.default_config](#GreenplumConfigSet6_171)). 
user_config | **[GreenplumConfig6_17](#GreenplumConfig6_171)**<br>User-defined settings for a Greenplum® cluster. 
default_config | **[GreenplumConfig6_17](#GreenplumConfig6_171)**<br>Default configuration for a Greenplum® cluster. 


### GreenplumConfig6_17 {#GreenplumConfig6_171}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary spill files allowed per query at each segment. <br>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated. <br>The current query is terminated if the limit is exceeded. <br>Set to zero to disable the limit. <br>Master session reloads if the parameter changes. <br>Default value is 10000. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of transactions that can be in the `prepared` state simultaneously. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the spill files are compressed or not. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 


### GreenplumConfigSet6_19 {#GreenplumConfigSet6_191}

Field | Description
--- | ---
effective_config | **[GreenplumConfig6_19](#GreenplumConfig6_191)**<br>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in [GreenplumConfigSet6_19.user_config](#GreenplumConfigSet6_191) and [GreenplumConfigSet6_19.default_config](#GreenplumConfigSet6_191)). 
user_config | **[GreenplumConfig6_19](#GreenplumConfig6_191)**<br>User-defined settings for a Greenplum® cluster. 
default_config | **[GreenplumConfig6_19](#GreenplumConfig6_191)**<br>Default configuration for a Greenplum® cluster. 


### GreenplumConfig6_19 {#GreenplumConfig6_191}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary spill files allowed per query at each segment. <br>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated. <br>The current query is terminated if the limit is exceeded. <br>Set to zero to disable the limit. <br>Master session reloads if the parameter changes. <br>Default value is 10000. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of transactions that can be in the `prepared` state simultaneously. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the spill files are compressed or not. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 
max_statement_mem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum memory limit for a query, in bytes. <br>Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting `statement_mem` too high. <br>Taking into account the configuration of a single segment host, calculate `max_statement_mem` as follows: `seghost_physical_memory` / `average_number_concurrent_queries`. <br>When changing both `max_statement_mem` and `statement_mem`, `max_statement_mem` must be changed first, or listed first in the `postgresql.conf` file. <br>Default value is 2097152000 (2000 MB). <br>More info in [Greenplum® documentation](https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem). 
log_statement | enum **LogStatement**<br>Logged SQL statements. <br>`PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command belongs to an appropriate type. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement). <ul><li>`NONE`: None statements are logged.</li><li>`DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.</li><li>`MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.</li><li>`ALL`: Logs all statements.</li></ul>


### ConnectionPoolerConfigSet {#ConnectionPoolerConfigSet1}

Field | Description
--- | ---
effective_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig1)**<br>Required. Effective settings for an Odyssey® pooler (a combination of settings defined in [ConnectionPoolerConfigSet.user_config](#ConnectionPoolerConfigSet1) and [ConnectionPoolerConfigSet.default_config](#ConnectionPoolerConfigSet1)). 
user_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig1)**<br>User-defined settings for an Odyssey® pooler. 
default_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig1)**<br>Default configuration for an Odyssey® pooler. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig1}

Field | Description
--- | ---
mode | enum **PoolMode**<br>Route server pool mode. <ul><li>`SESSION`: Assign server connection to a client until it disconnects. Default value.</li><li>`TRANSACTION`: Assign server connection to a client for a transaction processing.</li></ul>
size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. <br>Set to zero to disable the limit. 
client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Server pool idle timeout, in seconds. <br>A server connection closes after being idle for the specified time. <br>Set to zero to disable the limit. 


## Create {#Create}

Creates a Greenplum® cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create the Greenplum® cluster in. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the Greenplum® cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the Greenplum® cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. For example, `"project":"mvp"` or `"source":"dictionary"`. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Required. Deployment environment of the Greenplum® cluster. 
config | **[GreenplumConfig](#GreenplumConfig2)**<br>Greenplum® cluster configuration. 
master_config | **[MasterSubclusterConfigSpec](#MasterSubclusterConfigSpec)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfigSpec](#SegmentSubclusterConfigSpec)**<br>Configuration of the Greenplum® segment subcluster. 
master_host_count | **int64**<br>Number of hosts in the master subcluster. 
segment_in_host | **int64**<br>Number of segments per host. 
segment_host_count | **int64**<br>Number of hosts in the segment subcluster. 
user_name | **string**<br>Required. Owner user name. 
user_password | **string**<br>Required. Owner user password. The string length in characters must be 8-128.
network_id | **string**<br>Required. ID of the network to create the cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups to place VMs of the cluster in. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow2)**<br>A Greenplum® cluster maintenance window. Should be defined by either one of the two options. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Configuration of Greenplum® and Odyssey®. 


### GreenplumConfig {#GreenplumConfig2}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum® server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access2)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#Cluster2)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Determines whether the cluster has a public IP address. <br>After the cluster has been created, this setting cannot be changed. 


### Access {#Access2}

Field | Description
--- | ---
data_lens | **bool**<br>Allows data export from the cluster to DataLens. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from the management console. 
data_transfer | **bool**<br>Allows access for DataTransfer. 


### MasterSubclusterConfigSpec {#MasterSubclusterConfigSpec}

Field | Description
--- | ---
resources | **[Resources](#Resources2)**<br>Resources allocated to Greenplum® master subcluster hosts. 


### Resources {#Resources2}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. <br>Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### SegmentSubclusterConfigSpec {#SegmentSubclusterConfigSpec}

Field | Description
--- | ---
resources | **[Resources](#Resources3)**<br>Resources allocated to Greenplum® segment subcluster hosts. 


### MaintenanceWindow {#MaintenanceWindow2}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow2)**<br>An any-time maintenance window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow2)**<br>A weekly maintenance window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow2}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow2}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week. <ul><li>`MON`: Monday</li><li>`TUE`: Tuesday</li><li>`WED`: Wednesday</li><li>`THU`: Thursday</li><li>`FRI`: Friday</li><li>`SAT`: Saturday</li><li>`SUN`: Sunday</li></ul>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
greenplum_config | **oneof:** `greenplum_config_6_17`, `greenplum_config_6_19`, `greenplum_config_6_21` or `greenplum_config_6_22`<br>
&nbsp;&nbsp;greenplum_config_6_17 | **[GreenplumConfig6_17](#GreenplumConfig6_172)**<br> 
&nbsp;&nbsp;greenplum_config_6_19 | **[GreenplumConfig6_19](#GreenplumConfig6_192)**<br> 
&nbsp;&nbsp;greenplum_config_6_21 | **[GreenplumConfig6_21](#GreenplumConfig6_21)**<br> 
&nbsp;&nbsp;greenplum_config_6_22 | **[GreenplumConfig6_22](#GreenplumConfig6_22)**<br> 
pool | **[ConnectionPoolerConfig](#ConnectionPoolerConfig2)**<br>Odyssey® pool settings. 


### GreenplumConfig6_17 {#GreenplumConfig6_172}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary spill files allowed per query at each segment. <br>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated. <br>The current query is terminated if the limit is exceeded. <br>Set to zero to disable the limit. <br>Master session reloads if the parameter changes. <br>Default value is 10000. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of transactions that can be in the `prepared` state simultaneously. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the spill files are compressed or not. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 


### GreenplumConfig6_19 {#GreenplumConfig6_192}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary spill files allowed per query at each segment. <br>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated. <br>The current query is terminated if the limit is exceeded. <br>Set to zero to disable the limit. <br>Master session reloads if the parameter changes. <br>Default value is 10000. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of transactions that can be in the `prepared` state simultaneously. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the spill files are compressed or not. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 
max_statement_mem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum memory limit for a query, in bytes. <br>Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting `statement_mem` too high. <br>Taking into account the configuration of a single segment host, calculate `max_statement_mem` as follows: `seghost_physical_memory` / `average_number_concurrent_queries`. <br>When changing both `max_statement_mem` and `statement_mem`, `max_statement_mem` must be changed first, or listed first in the `postgresql.conf` file. <br>Default value is 2097152000 (2000 MB). <br>More info in [Greenplum® documentation](https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem). 
log_statement | enum **LogStatement**<br>Logged SQL statements. <br>`PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command belongs to an appropriate type. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement). <ul><li>`NONE`: None statements are logged.</li><li>`DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.</li><li>`MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.</li><li>`ALL`: Logs all statements.</li></ul>


### GreenplumConfig6_21 {#GreenplumConfig6_21}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression 
max_statement_mem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB) 
log_statement | enum **LogStatement**<br>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement Default value is ddl <ul><li>`NONE`: None statements are logged.</li><li>`DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.</li><li>`MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.</li><li>`ALL`: Logs all statements.</li></ul>
gp_add_column_inherits_table_setting | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting 


### GreenplumConfig6_22 {#GreenplumConfig6_22}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression 
max_statement_mem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB) 
log_statement | enum **LogStatement**<br>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement Default value is ddl <ul><li>`NONE`: None statements are logged.</li><li>`DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.</li><li>`MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.</li><li>`ALL`: Logs all statements.</li></ul>
gp_add_column_inherits_table_setting | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting 


### ConnectionPoolerConfig {#ConnectionPoolerConfig2}

Field | Description
--- | ---
mode | enum **PoolMode**<br>Route server pool mode. <ul><li>`SESSION`: Assign server connection to a client until it disconnects. Default value.</li><li>`TRANSACTION`: Assign server connection to a client for a transaction processing.</li></ul>
size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. <br>Set to zero to disable the limit. 
client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Server pool idle timeout, in seconds. <br>A server connection closes after being idle for the specified time. <br>Set to zero to disable the limit. 


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
cluster_id | **string**<br>ID of the Greenplum® cluster that is being created. 


### Cluster {#Cluster2}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum® cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the Greenplum® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Required. Name of the Greenplum® cluster. The name is unique within the folder. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig3)**<br>Greenplum® cluster configuration. 
description | **string**<br>Description of the Greenplum® cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum® cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the Greenplum® cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig2)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig2)**<br>Configuration of the Greenplum® segment subcluster. 
master_host_count | **int64**<br>Number of hosts in the master subcluster. 
segment_host_count | **int64**<br>Number of hosts in the segment subcluster. 
segment_in_host | **int64**<br>Number of segments per host. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><li>`UNBALANCED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is UNBALANCED).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>A Greenplum® cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation2)**<br>Maintenance operation planned at nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups. 
user_name | **string**<br>Owner user name. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
cluster_config | **[ClusterConfigSet](#ClusterConfigSet2)**<br>Greenplum® and Odyssey® configuration. 


### Monitoring {#Monitoring2}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum® cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig2}

Field | Description
--- | ---
resources | **[Resources](#Resources3)**<br>Computational resources allocated to Greenplum® master subcluster hosts. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig2}

Field | Description
--- | ---
resources | **[Resources](#Resources3)**<br>Computational resources allocated to Greenplum® segment subcluster hosts. 


### MaintenanceOperation {#MaintenanceOperation2}

Field | Description
--- | ---
info | **string**<br>The description of the operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 


### ClusterConfigSet {#ClusterConfigSet2}

Field | Description
--- | ---
greenplum_config | **oneof:** `greenplum_config_set_6_17` or `greenplum_config_set_6_19`<br>
&nbsp;&nbsp;greenplum_config_set_6_17 | **[GreenplumConfigSet6_17](#GreenplumConfigSet6_172)**<br> 
&nbsp;&nbsp;greenplum_config_set_6_19 | **[GreenplumConfigSet6_19](#GreenplumConfigSet6_192)**<br> 
pool | **[ConnectionPoolerConfigSet](#ConnectionPoolerConfigSet2)**<br>Odyssey® pool settings. 


### GreenplumConfigSet6_17 {#GreenplumConfigSet6_172}

Field | Description
--- | ---
effective_config | **[GreenplumConfig6_17](#GreenplumConfig6_173)**<br>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in [GreenplumConfigSet6_17.user_config](#GreenplumConfigSet6_172) and [GreenplumConfigSet6_17.default_config](#GreenplumConfigSet6_172)). 
user_config | **[GreenplumConfig6_17](#GreenplumConfig6_173)**<br>User-defined settings for a Greenplum® cluster. 
default_config | **[GreenplumConfig6_17](#GreenplumConfig6_173)**<br>Default configuration for a Greenplum® cluster. 


### GreenplumConfigSet6_19 {#GreenplumConfigSet6_192}

Field | Description
--- | ---
effective_config | **[GreenplumConfig6_19](#GreenplumConfig6_193)**<br>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in [GreenplumConfigSet6_19.user_config](#GreenplumConfigSet6_192) and [GreenplumConfigSet6_19.default_config](#GreenplumConfigSet6_192)). 
user_config | **[GreenplumConfig6_19](#GreenplumConfig6_193)**<br>User-defined settings for a Greenplum® cluster. 
default_config | **[GreenplumConfig6_19](#GreenplumConfig6_193)**<br>Default configuration for a Greenplum® cluster. 


### ConnectionPoolerConfigSet {#ConnectionPoolerConfigSet2}

Field | Description
--- | ---
effective_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig3)**<br>Required. Effective settings for an Odyssey® pooler (a combination of settings defined in [ConnectionPoolerConfigSet.user_config](#ConnectionPoolerConfigSet2) and [ConnectionPoolerConfigSet.default_config](#ConnectionPoolerConfigSet2)). 
user_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig3)**<br>User-defined settings for an Odyssey® pooler. 
default_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig3)**<br>Default configuration for an Odyssey® pooler. 


## Update {#Update}

Updates the specified Greenplum® cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® cluster resource to update. To get the Greenplum® cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Greenplum® cluster resource should be updated. 
description | **string**<br>New description of the Greenplum® cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. For example, `"project":"mvp"` or `"source":"dictionary"`. <br>The new set of labels completely replaces the old one. To add a label, request the current set with the [ClusterService.Get](#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
name | **string**<br>New name for the cluster. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
config | **[GreenplumConfig](#GreenplumConfig3)**<br>The Greenplum® cluster configuration. 
master_config | **[MasterSubclusterConfigSpec](#MasterSubclusterConfigSpec)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfigSpec](#SegmentSubclusterConfigSpec)**<br>Configuration of the Greenplum® segment subcluster. 
user_password | **string**<br>Required. Owner user password. The string length in characters must be 8-128.
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>The Greenplum® cluster maintenance window. Should be defined by either one of the two options. 
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Settings of the Greenplum® cluster. 


### GreenplumConfig {#GreenplumConfig3}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum® server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access3)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#Cluster3)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Determines whether the cluster has a public IP address. <br>After the cluster has been created, this setting cannot be changed. 


### Access {#Access3}

Field | Description
--- | ---
data_lens | **bool**<br>Allows data export from the cluster to DataLens. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from the management console. 
data_transfer | **bool**<br>Allows access for DataTransfer. 


### MasterSubclusterConfigSpec {#MasterSubclusterConfigSpec1}

Field | Description
--- | ---
resources | **[Resources](#Resources3)**<br>Resources allocated to Greenplum® master subcluster hosts. 


### Resources {#Resources3}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. <br>Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### SegmentSubclusterConfigSpec {#SegmentSubclusterConfigSpec1}

Field | Description
--- | ---
resources | **[Resources](#Resources4)**<br>Resources allocated to Greenplum® segment subcluster hosts. 


### MaintenanceWindow {#MaintenanceWindow3}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow3)**<br>An any-time maintenance window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow3)**<br>A weekly maintenance window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow3}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow3}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week. <ul><li>`MON`: Monday</li><li>`TUE`: Tuesday</li><li>`WED`: Wednesday</li><li>`THU`: Thursday</li><li>`FRI`: Friday</li><li>`SAT`: Saturday</li><li>`SUN`: Sunday</li></ul>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


### ConfigSpec {#ConfigSpec1}

Field | Description
--- | ---
greenplum_config | **oneof:** `greenplum_config_6_17`, `greenplum_config_6_19`, `greenplum_config_6_21` or `greenplum_config_6_22`<br>
&nbsp;&nbsp;greenplum_config_6_17 | **[GreenplumConfig6_17](#GreenplumConfig6_173)**<br> 
&nbsp;&nbsp;greenplum_config_6_19 | **[GreenplumConfig6_19](#GreenplumConfig6_193)**<br> 
&nbsp;&nbsp;greenplum_config_6_21 | **[GreenplumConfig6_21](#GreenplumConfig6_211)**<br> 
&nbsp;&nbsp;greenplum_config_6_22 | **[GreenplumConfig6_22](#GreenplumConfig6_221)**<br> 
pool | **[ConnectionPoolerConfig](#ConnectionPoolerConfig3)**<br>Odyssey® pool settings. 


### GreenplumConfig6_17 {#GreenplumConfig6_173}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary spill files allowed per query at each segment. <br>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated. <br>The current query is terminated if the limit is exceeded. <br>Set to zero to disable the limit. <br>Master session reloads if the parameter changes. <br>Default value is 10000. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of transactions that can be in the `prepared` state simultaneously. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the spill files are compressed or not. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 


### GreenplumConfig6_19 {#GreenplumConfig6_193}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary spill files allowed per query at each segment. <br>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated. <br>The current query is terminated if the limit is exceeded. <br>Set to zero to disable the limit. <br>Master session reloads if the parameter changes. <br>Default value is 10000. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of transactions that can be in the `prepared` state simultaneously. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the spill files are compressed or not. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 
max_statement_mem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum memory limit for a query, in bytes. <br>Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting `statement_mem` too high. <br>Taking into account the configuration of a single segment host, calculate `max_statement_mem` as follows: `seghost_physical_memory` / `average_number_concurrent_queries`. <br>When changing both `max_statement_mem` and `statement_mem`, `max_statement_mem` must be changed first, or listed first in the `postgresql.conf` file. <br>Default value is 2097152000 (2000 MB). <br>More info in [Greenplum® documentation](https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem). 
log_statement | enum **LogStatement**<br>Logged SQL statements. <br>`PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command belongs to an appropriate type. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement). <ul><li>`NONE`: None statements are logged.</li><li>`DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.</li><li>`MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.</li><li>`ALL`: Logs all statements.</li></ul>


### GreenplumConfig6_21 {#GreenplumConfig6_211}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression 
max_statement_mem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB) 
log_statement | enum **LogStatement**<br>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement Default value is ddl <ul><li>`NONE`: None statements are logged.</li><li>`DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.</li><li>`MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.</li><li>`ALL`: Logs all statements.</li></ul>
gp_add_column_inherits_table_setting | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting 


### GreenplumConfig6_22 {#GreenplumConfig6_221}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression 
max_statement_mem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB) 
log_statement | enum **LogStatement**<br>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement Default value is ddl <ul><li>`NONE`: None statements are logged.</li><li>`DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.</li><li>`MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.</li><li>`ALL`: Logs all statements.</li></ul>
gp_add_column_inherits_table_setting | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting 


### ConnectionPoolerConfig {#ConnectionPoolerConfig3}

Field | Description
--- | ---
mode | enum **PoolMode**<br>Route server pool mode. <ul><li>`SESSION`: Assign server connection to a client until it disconnects. Default value.</li><li>`TRANSACTION`: Assign server connection to a client for a transaction processing.</li></ul>
size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. <br>Set to zero to disable the limit. 
client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Server pool idle timeout, in seconds. <br>A server connection closes after being idle for the specified time. <br>Set to zero to disable the limit. 


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
cluster_id | **string**<br>ID of the Greenplum® cluster resource that is being updated. 


### Cluster {#Cluster3}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum® cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the Greenplum® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Required. Name of the Greenplum® cluster. The name is unique within the folder. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig4)**<br>Greenplum® cluster configuration. 
description | **string**<br>Description of the Greenplum® cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum® cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Description of monitoring systems relevant to the Greenplum® cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig3)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig3)**<br>Configuration of the Greenplum® segment subcluster. 
master_host_count | **int64**<br>Number of hosts in the master subcluster. 
segment_host_count | **int64**<br>Number of hosts in the segment subcluster. 
segment_in_host | **int64**<br>Number of segments per host. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><li>`UNBALANCED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is UNBALANCED).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>A Greenplum® cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation3)**<br>Maintenance operation planned at nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups. 
user_name | **string**<br>Owner user name. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
cluster_config | **[ClusterConfigSet](#ClusterConfigSet3)**<br>Greenplum® and Odyssey® configuration. 


### Monitoring {#Monitoring3}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum® cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig3}

Field | Description
--- | ---
resources | **[Resources](#Resources4)**<br>Computational resources allocated to Greenplum® master subcluster hosts. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig3}

Field | Description
--- | ---
resources | **[Resources](#Resources4)**<br>Computational resources allocated to Greenplum® segment subcluster hosts. 


### MaintenanceOperation {#MaintenanceOperation3}

Field | Description
--- | ---
info | **string**<br>The description of the operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 


### ClusterConfigSet {#ClusterConfigSet3}

Field | Description
--- | ---
greenplum_config | **oneof:** `greenplum_config_set_6_17` or `greenplum_config_set_6_19`<br>
&nbsp;&nbsp;greenplum_config_set_6_17 | **[GreenplumConfigSet6_17](#GreenplumConfigSet6_173)**<br> 
&nbsp;&nbsp;greenplum_config_set_6_19 | **[GreenplumConfigSet6_19](#GreenplumConfigSet6_193)**<br> 
pool | **[ConnectionPoolerConfigSet](#ConnectionPoolerConfigSet3)**<br>Odyssey® pool settings. 


### GreenplumConfigSet6_17 {#GreenplumConfigSet6_173}

Field | Description
--- | ---
effective_config | **[GreenplumConfig6_17](#GreenplumConfig6_174)**<br>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in [GreenplumConfigSet6_17.user_config](#GreenplumConfigSet6_173) and [GreenplumConfigSet6_17.default_config](#GreenplumConfigSet6_173)). 
user_config | **[GreenplumConfig6_17](#GreenplumConfig6_174)**<br>User-defined settings for a Greenplum® cluster. 
default_config | **[GreenplumConfig6_17](#GreenplumConfig6_174)**<br>Default configuration for a Greenplum® cluster. 


### GreenplumConfigSet6_19 {#GreenplumConfigSet6_193}

Field | Description
--- | ---
effective_config | **[GreenplumConfig6_19](#GreenplumConfig6_194)**<br>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in [GreenplumConfigSet6_19.user_config](#GreenplumConfigSet6_193) and [GreenplumConfigSet6_19.default_config](#GreenplumConfigSet6_193)). 
user_config | **[GreenplumConfig6_19](#GreenplumConfig6_194)**<br>User-defined settings for a Greenplum® cluster. 
default_config | **[GreenplumConfig6_19](#GreenplumConfig6_194)**<br>Default configuration for a Greenplum® cluster. 


### ConnectionPoolerConfigSet {#ConnectionPoolerConfigSet3}

Field | Description
--- | ---
effective_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig4)**<br>Required. Effective settings for an Odyssey® pooler (a combination of settings defined in [ConnectionPoolerConfigSet.user_config](#ConnectionPoolerConfigSet3) and [ConnectionPoolerConfigSet.default_config](#ConnectionPoolerConfigSet3)). 
user_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig4)**<br>User-defined settings for an Odyssey® pooler. 
default_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig4)**<br>Default configuration for an Odyssey® pooler. 


## Expand {#Expand}

Expands the specified Greenplum® cluster.

**rpc Expand ([ExpandRequest](#ExpandRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterHostsMetadata](#AddClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### ExpandRequest {#ExpandRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum Cluster resource to update. To get the Greenplum cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
segment_host_count | **int64**<br>Number of hosts for add to the segment subcluster 
add_segments_per_host_count | **int64**<br>Number of segments per host to add 
duration | **int64**<br>Redistribute duration, in seconds 


### Operation {#Operation2}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster4)>**<br>if operation finished successfully. 


### AddClusterHostsMetadata {#AddClusterHostsMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Greenplum Cluster resource that is being updated. 


### Cluster {#Cluster4}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum® cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the Greenplum® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Required. Name of the Greenplum® cluster. The name is unique within the folder. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig4)**<br>Greenplum® cluster configuration. 
description | **string**<br>Description of the Greenplum® cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum® cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Description of monitoring systems relevant to the Greenplum® cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig4)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig4)**<br>Configuration of the Greenplum® segment subcluster. 
master_host_count | **int64**<br>Number of hosts in the master subcluster. 
segment_host_count | **int64**<br>Number of hosts in the segment subcluster. 
segment_in_host | **int64**<br>Number of segments per host. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><li>`UNBALANCED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is UNBALANCED).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>A Greenplum® cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation4)**<br>Maintenance operation planned at nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups. 
user_name | **string**<br>Owner user name. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
cluster_config | **[ClusterConfigSet](#ClusterConfigSet4)**<br>Greenplum® and Odyssey® configuration. 


### GreenplumConfig {#GreenplumConfig4}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum® server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access4)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#Cluster5)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Determines whether the cluster has a public IP address. <br>After the cluster has been created, this setting cannot be changed. 


### Access {#Access4}

Field | Description
--- | ---
data_lens | **bool**<br>Allows data export from the cluster to DataLens. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from the management console. 
data_transfer | **bool**<br>Allows access for DataTransfer. 


### Monitoring {#Monitoring4}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum® cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig4}

Field | Description
--- | ---
resources | **[Resources](#Resources4)**<br>Computational resources allocated to Greenplum® master subcluster hosts. 


### Resources {#Resources4}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. <br>Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig4}

Field | Description
--- | ---
resources | **[Resources](#Resources5)**<br>Computational resources allocated to Greenplum® segment subcluster hosts. 


### MaintenanceWindow {#MaintenanceWindow4}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow4)**<br>An any-time maintenance window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow4)**<br>A weekly maintenance window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow4}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow4}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week. <ul><li>`MON`: Monday</li><li>`TUE`: Tuesday</li><li>`WED`: Wednesday</li><li>`THU`: Thursday</li><li>`FRI`: Friday</li><li>`SAT`: Saturday</li><li>`SUN`: Sunday</li></ul>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation4}

Field | Description
--- | ---
info | **string**<br>The description of the operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 


### ClusterConfigSet {#ClusterConfigSet4}

Field | Description
--- | ---
greenplum_config | **oneof:** `greenplum_config_set_6_17` or `greenplum_config_set_6_19`<br>
&nbsp;&nbsp;greenplum_config_set_6_17 | **[GreenplumConfigSet6_17](#GreenplumConfigSet6_174)**<br> 
&nbsp;&nbsp;greenplum_config_set_6_19 | **[GreenplumConfigSet6_19](#GreenplumConfigSet6_194)**<br> 
pool | **[ConnectionPoolerConfigSet](#ConnectionPoolerConfigSet4)**<br>Odyssey® pool settings. 


### GreenplumConfigSet6_17 {#GreenplumConfigSet6_174}

Field | Description
--- | ---
effective_config | **[GreenplumConfig6_17](#GreenplumConfig6_174)**<br>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in [GreenplumConfigSet6_17.user_config](#GreenplumConfigSet6_174) and [GreenplumConfigSet6_17.default_config](#GreenplumConfigSet6_174)). 
user_config | **[GreenplumConfig6_17](#GreenplumConfig6_174)**<br>User-defined settings for a Greenplum® cluster. 
default_config | **[GreenplumConfig6_17](#GreenplumConfig6_174)**<br>Default configuration for a Greenplum® cluster. 


### GreenplumConfig6_17 {#GreenplumConfig6_174}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary spill files allowed per query at each segment. <br>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated. <br>The current query is terminated if the limit is exceeded. <br>Set to zero to disable the limit. <br>Master session reloads if the parameter changes. <br>Default value is 10000. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of transactions that can be in the `prepared` state simultaneously. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the spill files are compressed or not. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 


### GreenplumConfigSet6_19 {#GreenplumConfigSet6_194}

Field | Description
--- | ---
effective_config | **[GreenplumConfig6_19](#GreenplumConfig6_194)**<br>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in [GreenplumConfigSet6_19.user_config](#GreenplumConfigSet6_194) and [GreenplumConfigSet6_19.default_config](#GreenplumConfigSet6_194)). 
user_config | **[GreenplumConfig6_19](#GreenplumConfig6_194)**<br>User-defined settings for a Greenplum® cluster. 
default_config | **[GreenplumConfig6_19](#GreenplumConfig6_194)**<br>Default configuration for a Greenplum® cluster. 


### GreenplumConfig6_19 {#GreenplumConfig6_194}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary spill files allowed per query at each segment. <br>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated. <br>The current query is terminated if the limit is exceeded. <br>Set to zero to disable the limit. <br>Master session reloads if the parameter changes. <br>Default value is 10000. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of transactions that can be in the `prepared` state simultaneously. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the spill files are compressed or not. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 
max_statement_mem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum memory limit for a query, in bytes. <br>Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting `statement_mem` too high. <br>Taking into account the configuration of a single segment host, calculate `max_statement_mem` as follows: `seghost_physical_memory` / `average_number_concurrent_queries`. <br>When changing both `max_statement_mem` and `statement_mem`, `max_statement_mem` must be changed first, or listed first in the `postgresql.conf` file. <br>Default value is 2097152000 (2000 MB). <br>More info in [Greenplum® documentation](https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem). 
log_statement | enum **LogStatement**<br>Logged SQL statements. <br>`PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command belongs to an appropriate type. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement). <ul><li>`NONE`: None statements are logged.</li><li>`DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.</li><li>`MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.</li><li>`ALL`: Logs all statements.</li></ul>


### ConnectionPoolerConfigSet {#ConnectionPoolerConfigSet4}

Field | Description
--- | ---
effective_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig4)**<br>Required. Effective settings for an Odyssey® pooler (a combination of settings defined in [ConnectionPoolerConfigSet.user_config](#ConnectionPoolerConfigSet4) and [ConnectionPoolerConfigSet.default_config](#ConnectionPoolerConfigSet4)). 
user_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig4)**<br>User-defined settings for an Odyssey® pooler. 
default_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig4)**<br>Default configuration for an Odyssey® pooler. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig4}

Field | Description
--- | ---
mode | enum **PoolMode**<br>Route server pool mode. <ul><li>`SESSION`: Assign server connection to a client until it disconnects. Default value.</li><li>`TRANSACTION`: Assign server connection to a client for a transaction processing.</li></ul>
size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. <br>Set to zero to disable the limit. 
client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Server pool idle timeout, in seconds. <br>A server connection closes after being idle for the specified time. <br>Set to zero to disable the limit. 


## Delete {#Delete}

Deletes the specified Greenplum® cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® cluster to delete. To get the Greenplum® cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation3}

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
cluster_id | **string**<br>ID of the Greenplum® cluster that is being deleted. 


## Start {#Start}

Starts the specified Greenplum® cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® cluster to start. To get the Greenplum® cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation4}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster5)>**<br>if operation finished successfully. 


### StartClusterMetadata {#StartClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Greenplum® cluster being started. 


### Cluster {#Cluster5}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum® cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the Greenplum® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Required. Name of the Greenplum® cluster. The name is unique within the folder. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig5)**<br>Greenplum® cluster configuration. 
description | **string**<br>Description of the Greenplum® cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum® cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Description of monitoring systems relevant to the Greenplum® cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig5)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig5)**<br>Configuration of the Greenplum® segment subcluster. 
master_host_count | **int64**<br>Number of hosts in the master subcluster. 
segment_host_count | **int64**<br>Number of hosts in the segment subcluster. 
segment_in_host | **int64**<br>Number of segments per host. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><li>`UNBALANCED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is UNBALANCED).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow5)**<br>A Greenplum® cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation5)**<br>Maintenance operation planned at nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups. 
user_name | **string**<br>Owner user name. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
cluster_config | **[ClusterConfigSet](#ClusterConfigSet5)**<br>Greenplum® and Odyssey® configuration. 


### GreenplumConfig {#GreenplumConfig5}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum® server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access5)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#Cluster6)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Determines whether the cluster has a public IP address. <br>After the cluster has been created, this setting cannot be changed. 


### Access {#Access5}

Field | Description
--- | ---
data_lens | **bool**<br>Allows data export from the cluster to DataLens. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from the management console. 
data_transfer | **bool**<br>Allows access for DataTransfer. 


### Monitoring {#Monitoring5}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum® cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig5}

Field | Description
--- | ---
resources | **[Resources](#Resources5)**<br>Computational resources allocated to Greenplum® master subcluster hosts. 


### Resources {#Resources5}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. <br>Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig5}

Field | Description
--- | ---
resources | **[Resources](#Resources6)**<br>Computational resources allocated to Greenplum® segment subcluster hosts. 


### MaintenanceWindow {#MaintenanceWindow5}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow5)**<br>An any-time maintenance window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow5)**<br>A weekly maintenance window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow5}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow5}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week. <ul><li>`MON`: Monday</li><li>`TUE`: Tuesday</li><li>`WED`: Wednesday</li><li>`THU`: Thursday</li><li>`FRI`: Friday</li><li>`SAT`: Saturday</li><li>`SUN`: Sunday</li></ul>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation5}

Field | Description
--- | ---
info | **string**<br>The description of the operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 


### ClusterConfigSet {#ClusterConfigSet5}

Field | Description
--- | ---
greenplum_config | **oneof:** `greenplum_config_set_6_17` or `greenplum_config_set_6_19`<br>
&nbsp;&nbsp;greenplum_config_set_6_17 | **[GreenplumConfigSet6_17](#GreenplumConfigSet6_175)**<br> 
&nbsp;&nbsp;greenplum_config_set_6_19 | **[GreenplumConfigSet6_19](#GreenplumConfigSet6_195)**<br> 
pool | **[ConnectionPoolerConfigSet](#ConnectionPoolerConfigSet5)**<br>Odyssey® pool settings. 


### GreenplumConfigSet6_17 {#GreenplumConfigSet6_175}

Field | Description
--- | ---
effective_config | **[GreenplumConfig6_17](#GreenplumConfig6_175)**<br>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in [GreenplumConfigSet6_17.user_config](#GreenplumConfigSet6_175) and [GreenplumConfigSet6_17.default_config](#GreenplumConfigSet6_175)). 
user_config | **[GreenplumConfig6_17](#GreenplumConfig6_175)**<br>User-defined settings for a Greenplum® cluster. 
default_config | **[GreenplumConfig6_17](#GreenplumConfig6_175)**<br>Default configuration for a Greenplum® cluster. 


### GreenplumConfig6_17 {#GreenplumConfig6_175}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary spill files allowed per query at each segment. <br>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated. <br>The current query is terminated if the limit is exceeded. <br>Set to zero to disable the limit. <br>Master session reloads if the parameter changes. <br>Default value is 10000. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of transactions that can be in the `prepared` state simultaneously. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the spill files are compressed or not. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 


### GreenplumConfigSet6_19 {#GreenplumConfigSet6_195}

Field | Description
--- | ---
effective_config | **[GreenplumConfig6_19](#GreenplumConfig6_195)**<br>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in [GreenplumConfigSet6_19.user_config](#GreenplumConfigSet6_195) and [GreenplumConfigSet6_19.default_config](#GreenplumConfigSet6_195)). 
user_config | **[GreenplumConfig6_19](#GreenplumConfig6_195)**<br>User-defined settings for a Greenplum® cluster. 
default_config | **[GreenplumConfig6_19](#GreenplumConfig6_195)**<br>Default configuration for a Greenplum® cluster. 


### GreenplumConfig6_19 {#GreenplumConfig6_195}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary spill files allowed per query at each segment. <br>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated. <br>The current query is terminated if the limit is exceeded. <br>Set to zero to disable the limit. <br>Master session reloads if the parameter changes. <br>Default value is 10000. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of transactions that can be in the `prepared` state simultaneously. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the spill files are compressed or not. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 
max_statement_mem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum memory limit for a query, in bytes. <br>Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting `statement_mem` too high. <br>Taking into account the configuration of a single segment host, calculate `max_statement_mem` as follows: `seghost_physical_memory` / `average_number_concurrent_queries`. <br>When changing both `max_statement_mem` and `statement_mem`, `max_statement_mem` must be changed first, or listed first in the `postgresql.conf` file. <br>Default value is 2097152000 (2000 MB). <br>More info in [Greenplum® documentation](https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem). 
log_statement | enum **LogStatement**<br>Logged SQL statements. <br>`PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command belongs to an appropriate type. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement). <ul><li>`NONE`: None statements are logged.</li><li>`DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.</li><li>`MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.</li><li>`ALL`: Logs all statements.</li></ul>


### ConnectionPoolerConfigSet {#ConnectionPoolerConfigSet5}

Field | Description
--- | ---
effective_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig5)**<br>Required. Effective settings for an Odyssey® pooler (a combination of settings defined in [ConnectionPoolerConfigSet.user_config](#ConnectionPoolerConfigSet5) and [ConnectionPoolerConfigSet.default_config](#ConnectionPoolerConfigSet5)). 
user_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig5)**<br>User-defined settings for an Odyssey® pooler. 
default_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig5)**<br>Default configuration for an Odyssey® pooler. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig5}

Field | Description
--- | ---
mode | enum **PoolMode**<br>Route server pool mode. <ul><li>`SESSION`: Assign server connection to a client until it disconnects. Default value.</li><li>`TRANSACTION`: Assign server connection to a client for a transaction processing.</li></ul>
size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. <br>Set to zero to disable the limit. 
client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Server pool idle timeout, in seconds. <br>A server connection closes after being idle for the specified time. <br>Set to zero to disable the limit. 


## Stop {#Stop}

Stops the specified Greenplum® cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® cluster to stop. To get the Greenplum® cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation5}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster6)>**<br>if operation finished successfully. 


### StopClusterMetadata {#StopClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Greenplum® cluster being stopped. 


### Cluster {#Cluster6}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum® cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the Greenplum® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Required. Name of the Greenplum® cluster. The name is unique within the folder. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig6)**<br>Greenplum® cluster configuration. 
description | **string**<br>Description of the Greenplum® cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum® cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring6)**<br>Description of monitoring systems relevant to the Greenplum® cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig6)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig6)**<br>Configuration of the Greenplum® segment subcluster. 
master_host_count | **int64**<br>Number of hosts in the master subcluster. 
segment_host_count | **int64**<br>Number of hosts in the segment subcluster. 
segment_in_host | **int64**<br>Number of segments per host. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><li>`UNBALANCED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is UNBALANCED).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow6)**<br>A Greenplum® cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation6)**<br>Maintenance operation planned at nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups. 
user_name | **string**<br>Owner user name. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
cluster_config | **[ClusterConfigSet](#ClusterConfigSet6)**<br>Greenplum® and Odyssey® configuration. 


### GreenplumConfig {#GreenplumConfig6}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum® server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access6)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#Cluster7)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Determines whether the cluster has a public IP address. <br>After the cluster has been created, this setting cannot be changed. 


### Access {#Access6}

Field | Description
--- | ---
data_lens | **bool**<br>Allows data export from the cluster to DataLens. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from the management console. 
data_transfer | **bool**<br>Allows access for DataTransfer. 


### Monitoring {#Monitoring6}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum® cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig6}

Field | Description
--- | ---
resources | **[Resources](#Resources6)**<br>Computational resources allocated to Greenplum® master subcluster hosts. 


### Resources {#Resources6}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. <br>Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig6}

Field | Description
--- | ---
resources | **[Resources](#Resources7)**<br>Computational resources allocated to Greenplum® segment subcluster hosts. 


### MaintenanceWindow {#MaintenanceWindow6}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow6)**<br>An any-time maintenance window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow6)**<br>A weekly maintenance window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow6}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow6}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week. <ul><li>`MON`: Monday</li><li>`TUE`: Tuesday</li><li>`WED`: Wednesday</li><li>`THU`: Thursday</li><li>`FRI`: Friday</li><li>`SAT`: Saturday</li><li>`SUN`: Sunday</li></ul>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation6}

Field | Description
--- | ---
info | **string**<br>The description of the operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 


### ClusterConfigSet {#ClusterConfigSet6}

Field | Description
--- | ---
greenplum_config | **oneof:** `greenplum_config_set_6_17` or `greenplum_config_set_6_19`<br>
&nbsp;&nbsp;greenplum_config_set_6_17 | **[GreenplumConfigSet6_17](#GreenplumConfigSet6_176)**<br> 
&nbsp;&nbsp;greenplum_config_set_6_19 | **[GreenplumConfigSet6_19](#GreenplumConfigSet6_196)**<br> 
pool | **[ConnectionPoolerConfigSet](#ConnectionPoolerConfigSet6)**<br>Odyssey® pool settings. 


### GreenplumConfigSet6_17 {#GreenplumConfigSet6_176}

Field | Description
--- | ---
effective_config | **[GreenplumConfig6_17](#GreenplumConfig6_176)**<br>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in [GreenplumConfigSet6_17.user_config](#GreenplumConfigSet6_176) and [GreenplumConfigSet6_17.default_config](#GreenplumConfigSet6_176)). 
user_config | **[GreenplumConfig6_17](#GreenplumConfig6_176)**<br>User-defined settings for a Greenplum® cluster. 
default_config | **[GreenplumConfig6_17](#GreenplumConfig6_176)**<br>Default configuration for a Greenplum® cluster. 


### GreenplumConfig6_17 {#GreenplumConfig6_176}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary spill files allowed per query at each segment. <br>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated. <br>The current query is terminated if the limit is exceeded. <br>Set to zero to disable the limit. <br>Master session reloads if the parameter changes. <br>Default value is 10000. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of transactions that can be in the `prepared` state simultaneously. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the spill files are compressed or not. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 


### GreenplumConfigSet6_19 {#GreenplumConfigSet6_196}

Field | Description
--- | ---
effective_config | **[GreenplumConfig6_19](#GreenplumConfig6_196)**<br>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in [GreenplumConfigSet6_19.user_config](#GreenplumConfigSet6_196) and [GreenplumConfigSet6_19.default_config](#GreenplumConfigSet6_196)). 
user_config | **[GreenplumConfig6_19](#GreenplumConfig6_196)**<br>User-defined settings for a Greenplum® cluster. 
default_config | **[GreenplumConfig6_19](#GreenplumConfig6_196)**<br>Default configuration for a Greenplum® cluster. 


### GreenplumConfig6_19 {#GreenplumConfig6_196}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary spill files allowed per query at each segment. <br>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated. <br>The current query is terminated if the limit is exceeded. <br>Set to zero to disable the limit. <br>Master session reloads if the parameter changes. <br>Default value is 10000. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of transactions that can be in the `prepared` state simultaneously. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the spill files are compressed or not. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 
max_statement_mem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum memory limit for a query, in bytes. <br>Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting `statement_mem` too high. <br>Taking into account the configuration of a single segment host, calculate `max_statement_mem` as follows: `seghost_physical_memory` / `average_number_concurrent_queries`. <br>When changing both `max_statement_mem` and `statement_mem`, `max_statement_mem` must be changed first, or listed first in the `postgresql.conf` file. <br>Default value is 2097152000 (2000 MB). <br>More info in [Greenplum® documentation](https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem). 
log_statement | enum **LogStatement**<br>Logged SQL statements. <br>`PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command belongs to an appropriate type. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement). <ul><li>`NONE`: None statements are logged.</li><li>`DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.</li><li>`MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.</li><li>`ALL`: Logs all statements.</li></ul>


### ConnectionPoolerConfigSet {#ConnectionPoolerConfigSet6}

Field | Description
--- | ---
effective_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig6)**<br>Required. Effective settings for an Odyssey® pooler (a combination of settings defined in [ConnectionPoolerConfigSet.user_config](#ConnectionPoolerConfigSet6) and [ConnectionPoolerConfigSet.default_config](#ConnectionPoolerConfigSet6)). 
user_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig6)**<br>User-defined settings for an Odyssey® pooler. 
default_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig6)**<br>Default configuration for an Odyssey® pooler. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig6}

Field | Description
--- | ---
mode | enum **PoolMode**<br>Route server pool mode. <ul><li>`SESSION`: Assign server connection to a client until it disconnects. Default value.</li><li>`TRANSACTION`: Assign server connection to a client for a transaction processing.</li></ul>
size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. <br>Set to zero to disable the limit. 
client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Server pool idle timeout, in seconds. <br>A server connection closes after being idle for the specified time. <br>Set to zero to disable the limit. 


## ListOperations {#ListOperations}

Retrieves the list of Operation resources for the specified cluster.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® cluster resource to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation6)**<br>List of Operation resources for the specified Greenplum® cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest), use the `next_page_token` as the value for the [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest) query parameter in the next list request. <br>Each subsequent list request has its own `next_page_token` to continue paging through the results. 


### Operation {#Operation6}

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


## ListMasterHosts {#ListMasterHosts}

Retrieves a list of master hosts for the specified cluster.

**rpc ListMasterHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® cluster. <br>To get the Greenplum® cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](#Host)**<br>Requested list of hosts for the cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) query parameter in the next list request. <br>Each subsequent list request has its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
name | **string**<br>Required. Name of the Greenplum® host. <br>The host name is assigned by the platform at creation time and cannot be changed. <br>The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. The maximum string length in characters is 63.
cluster_id | **string**<br>ID of the Greenplum® cluster. The ID is assigned by the platform at creation time. 
zone_id | **string**<br>ID of the availability zone the Greenplum® host belongs to. 
type | enum **Type**<br>Type of the host. <ul><li>`TYPE_UNSPECIFIED`: The type is not specified.</li><li>`MASTER`: A Greenplum® master host.</li><li>`REPLICA`: A Greenplum® master replica host.</li><li>`SEGMENT`: A Greenplum® segment host.</li></ul>
resources | **[Resources](#Resources7)**<br>Resources allocated to the Greenplum® host. 
health | enum **Health**<br>Status code of the aggregated health of the host. <ul><li>`UNKNOWN`: Health of the host is unknown.</li><li>`ALIVE`: The host is performing all its functions normally.</li><li>`DEAD`: The host is inoperable and cannot perform any of its essential functions.</li><li>`DEGRADED`: The host is working below capacity or not fully functional.</li><li>`UNBALANCED`: One or more segments are not in the preferred role.</li></ul>
subnet_id | **string**<br>ID of the subnet that the host belongs to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the host. 


### Resources {#Resources7}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. <br>Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


## ListSegmentHosts {#ListSegmentHosts}

Retrieves a list of segment hosts for the specified cluster.

**rpc ListSegmentHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest1}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® cluster. <br>To get the Greenplum® cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse1}

Field | Description
--- | ---
hosts[] | **[Host](#Host1)**<br>Requested list of hosts for the cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) query parameter in the next list request. <br>Each subsequent list request has its own `next_page_token` to continue paging through the results. 


### Host {#Host1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the Greenplum® host. <br>The host name is assigned by the platform at creation time and cannot be changed. <br>The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. The maximum string length in characters is 63.
cluster_id | **string**<br>ID of the Greenplum® cluster. The ID is assigned by the platform at creation time. 
zone_id | **string**<br>ID of the availability zone the Greenplum® host belongs to. 
type | enum **Type**<br>Type of the host. <ul><li>`TYPE_UNSPECIFIED`: The type is not specified.</li><li>`MASTER`: A Greenplum® master host.</li><li>`REPLICA`: A Greenplum® master replica host.</li><li>`SEGMENT`: A Greenplum® segment host.</li></ul>
resources | **[Resources](#Resources8)**<br>Resources allocated to the Greenplum® host. 
health | enum **Health**<br>Status code of the aggregated health of the host. <ul><li>`UNKNOWN`: Health of the host is unknown.</li><li>`ALIVE`: The host is performing all its functions normally.</li><li>`DEAD`: The host is inoperable and cannot perform any of its essential functions.</li><li>`DEGRADED`: The host is working below capacity or not fully functional.</li><li>`UNBALANCED`: One or more segments are not in the preferred role.</li></ul>
subnet_id | **string**<br>ID of the subnet that the host belongs to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the host. 


### Resources {#Resources8}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. <br>Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


## ListLogs {#ListLogs}

Retrieves logs for the specified Greenplum® cluster.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® cluster to request logs for. <br>To get the Greenplum® cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from log table to request. If no columns are specified, entire log records are returned. 
service_type | enum **ServiceType**<br>Type of the service to request logs about. <ul><li>`SERVICE_TYPE_UNSPECIFIED`: Type is not specified.</li><li>`GREENPLUM`: Greenplum® activity logs.</li><li>`GREENPLUM_POOLER`: Greenplum® pooler logs.</li></ul>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request. 
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) returned by the previous list request. The maximum string length in characters is 100.
always_next_page_token | **bool**<br>The service always returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse), even if the current page is empty. 
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <br><ol><li>A field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname](#LogRecord), [LogRecord.logs.message.error_severity](#LogRecord)(for `GREENPLUM` service) and [LogRecord.logs.message.level](#LogRecord)(for `GREENPLUM_POOLER` service) fields. </li></ol><br><ol><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li></ol><br><ol><li>A value. Must be 1-63 characters long and match the regular expression `^[a-z0-9.-]{1,61}$`. </li></ol><br>Examples of a filter: <ul><li>`message.hostname='node1.db.cloud.yandex.net'`; </li><li>`message.error_severity IN ("ERROR", "FATAL", "PANIC") AND message.hostname = "node1.db.cloud.yandex.net"`.</li></ul> The maximum string length in characters is 1000.


### ListClusterLogsResponse {#ListClusterLogsResponse}

Field | Description
--- | ---
logs[] | **[LogRecord](#LogRecord)**<br>Requested log records. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterLogsRequest.page_size](#ListClusterLogsRequest), use the `next_page_token` as the value for the [ListClusterLogsRequest.page_token](#ListClusterLogsRequest) query parameter in the next list request. <br>Each subsequent list request has its own `next_page_token` to continue paging through the results. <br>This value is interchangeable with the [StreamLogRecord.next_record_token](#StreamLogRecord) from [StreamLogs](#StreamLogs) method. 


### LogRecord {#LogRecord}

Field | Description
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the log was recorded. 
message | **map<string,string>**<br>Contents of the log record. 


## StreamLogs {#StreamLogs}

Same as [ListLogs](#ListLogs) but using server-side streaming. Also allows for `tail -f` semantics.

**rpc StreamLogs ([StreamClusterLogsRequest](#StreamClusterLogsRequest)) returns (stream [StreamLogRecord](#StreamLogRecord))**

### StreamClusterLogsRequest {#StreamClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® cluster. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from log table to get in the response. If no columns are specified, entire log records are returned. 
service_type | enum **ServiceType**<br>Type of the service to request logs about. <ul><li>`SERVICE_TYPE_UNSPECIFIED`: Type is not specified.</li><li>`GREENPLUM`: Greenplum® activity logs.</li><li>`GREENPLUM_POOLER`: Greenplum® pooler logs.</li></ul>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request. <br>If this field is not set, all existing logs are sent as well as the new ones as they appear. <br>In essence it has `tail -f` semantics. 
record_token | **string**<br>Record token. Set `record_token` to the [StreamLogs.next_record_token](#StreamLogs) returned by the previous [StreamLogs](#StreamLogs) request to start streaming from the next log record. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <br><ol><li>A field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname](#LogRecord), [LogRecord.logs.message.error_severity](#LogRecord)(for GREENPLUM service), [LogRecord.logs.message.level](#LogRecord)(for POOLER service) fields. </li></ol><br><ol><li>An `=` operator. </li></ol><br><ol><li>A value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-z0-9.-]{1,61}`. </li></ol><br>Examples of a filter: <br><ul><li>`message.hostname='node1.db.cloud.yandex.net'`; </li><li>`message.error_severity IN ("ERROR", "FATAL", "PANIC") AND message.hostname = "node1.db.cloud.yandex.net"`.</li></ul> The maximum string length in characters is 1000.


### StreamLogRecord {#StreamLogRecord}

Field | Description
--- | ---
record | **[LogRecord](#LogRecord)**<br>One of the requested log records. 
next_record_token | **string**<br>This token allows you to continue streaming logs starting from the exact same record. <br>To do that, specify value of `next_record_token` as the value for [StreamLogs.record_token](#StreamLogs) parameter in the next [StreamLogs](#StreamLogs) request. <br>This value is interchangeable with [ListLogs.next_page_token](#ListLogs) from [ListLogs](#ListLogs) method. 


### LogRecord {#LogRecord1}

Field | Description
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the log was recorded. 
message | **map<string,string>**<br>Contents of the log record. 


## ListBackups {#ListBackups}

Retrieves a list of available backups for the specified Greenplum® cluster.

**rpc ListBackups ([ListClusterBackupsRequest](#ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#ListClusterBackupsResponse))**

### ListClusterBackupsRequest {#ListClusterBackupsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® cluster. <br>To get the Greenplum® cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterBackupsResponse {#ListClusterBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup)**<br>List of Greenplum® backups. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterBackupsRequest.page_size](#ListClusterBackupsRequest), use the `next_page_token` as the value for the [ListClusterBackupsRequest.page_token](#ListClusterBackupsRequest) query parameter in the next list request. <br>Each subsequent list request has its own `next_page_token` to continue paging through the results. 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>Required. ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was completed. 
source_cluster_id | **string**<br>ID of the Greenplum® cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was started. 
size | **int64**<br>Size of the backup in bytes. 


## Restore {#Restore}

Creates a new Greenplum® cluster using the specified backup.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster7)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. ID of the backup to create a cluster from. <br>To get the backup ID, use a [ClusterService.ListBackups](#ListBackups) request. 
folder_id | **string**<br>Required. ID of the folder to create the Greenplum® cluster in. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the Greenplum® cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the Greenplum® cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. For example, "project":"mvp" or "source":"dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster7)**<br>Required. Deployment environment of the Greenplum® cluster. 
config | **[GreenplumRestoreConfig](#GreenplumRestoreConfig)**<br>Greenplum® cluster config. 
master_resources | **[Resources](#Resources9)**<br>Resources of the Greenplum® master subcluster. 
segment_resources | **[Resources](#Resources9)**<br>Resources of the Greenplum® segment subcluster. 
network_id | **string**<br>Required. ID of the network to create the cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups to place VMs of cluster on. 
placement_group_id | **string**<br>ID of the placement group. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow7)**<br>A Greenplum® cluster maintenance window. Should be defined by either one of the two options. 


### GreenplumRestoreConfig {#GreenplumRestoreConfig}

Field | Description
--- | ---
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access7)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone where the host resides. <br>To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster7). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Determines whether the host should get a public IP address on creation. <br>After a host has been created, this setting cannot be changed. <br>To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed. <br>Possible values: <ul><li>`false` - do not assign a public IP to the master host. </li><li>`true` - assign a public IP to the master host.</li></ul> 


### Access {#Access7}

Field | Description
--- | ---
data_lens | **bool**<br>Allows data export from the cluster to DataLens. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from the management console. 
data_transfer | **bool**<br>Allows access for DataTransfer. 


### Resources {#Resources9}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. <br>Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### MaintenanceWindow {#MaintenanceWindow7}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow7)**<br>An any-time maintenance window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow7)**<br>A weekly maintenance window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow7}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow7}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week. <ul><li>`MON`: Monday</li><li>`TUE`: Tuesday</li><li>`WED`: Wednesday</li><li>`THU`: Thursday</li><li>`FRI`: Friday</li><li>`SAT`: Saturday</li><li>`SUN`: Sunday</li></ul>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster7)>**<br>if operation finished successfully. 


### RestoreClusterMetadata {#RestoreClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the new Greenplum® cluster that is being created from a backup. 
backup_id | **string**<br>ID of the backup that is being used for creating a cluster. 


### Cluster {#Cluster7}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum® cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the Greenplum® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Required. Name of the Greenplum® cluster. The name is unique within the folder. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig7)**<br>Greenplum® cluster configuration. 
description | **string**<br>Description of the Greenplum® cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum® cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring7)**<br>Description of monitoring systems relevant to the Greenplum® cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig7)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig7)**<br>Configuration of the Greenplum® segment subcluster. 
master_host_count | **int64**<br>Number of hosts in the master subcluster. 
segment_host_count | **int64**<br>Number of hosts in the segment subcluster. 
segment_in_host | **int64**<br>Number of segments per host. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host2) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host2) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host2) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host2) for at least one host in the cluster is not ALIVE).</li><li>`UNBALANCED`: Cluster is working below capacity ([Host.health](#Host2) for at least one host in the cluster is UNBALANCED).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow8)**<br>A Greenplum® cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation7)**<br>Maintenance operation planned at nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups. 
user_name | **string**<br>Owner user name. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
cluster_config | **[ClusterConfigSet](#ClusterConfigSet7)**<br>Greenplum® and Odyssey® configuration. 


### GreenplumConfig {#GreenplumConfig7}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum® server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access8)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#Cluster8)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Determines whether the cluster has a public IP address. <br>After the cluster has been created, this setting cannot be changed. 


### Monitoring {#Monitoring7}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum® cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig7}

Field | Description
--- | ---
resources | **[Resources](#Resources10)**<br>Computational resources allocated to Greenplum® master subcluster hosts. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig7}

Field | Description
--- | ---
resources | **[Resources](#Resources10)**<br>Computational resources allocated to Greenplum® segment subcluster hosts. 


### MaintenanceOperation {#MaintenanceOperation7}

Field | Description
--- | ---
info | **string**<br>The description of the operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 


### ClusterConfigSet {#ClusterConfigSet7}

Field | Description
--- | ---
greenplum_config | **oneof:** `greenplum_config_set_6_17` or `greenplum_config_set_6_19`<br>
&nbsp;&nbsp;greenplum_config_set_6_17 | **[GreenplumConfigSet6_17](#GreenplumConfigSet6_177)**<br> 
&nbsp;&nbsp;greenplum_config_set_6_19 | **[GreenplumConfigSet6_19](#GreenplumConfigSet6_197)**<br> 
pool | **[ConnectionPoolerConfigSet](#ConnectionPoolerConfigSet7)**<br>Odyssey® pool settings. 


### GreenplumConfigSet6_17 {#GreenplumConfigSet6_177}

Field | Description
--- | ---
effective_config | **[GreenplumConfig6_17](#GreenplumConfig6_177)**<br>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in [GreenplumConfigSet6_17.user_config](#GreenplumConfigSet6_177) and [GreenplumConfigSet6_17.default_config](#GreenplumConfigSet6_177)). 
user_config | **[GreenplumConfig6_17](#GreenplumConfig6_177)**<br>User-defined settings for a Greenplum® cluster. 
default_config | **[GreenplumConfig6_17](#GreenplumConfig6_177)**<br>Default configuration for a Greenplum® cluster. 


### GreenplumConfig6_17 {#GreenplumConfig6_177}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary spill files allowed per query at each segment. <br>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated. <br>The current query is terminated if the limit is exceeded. <br>Set to zero to disable the limit. <br>Master session reloads if the parameter changes. <br>Default value is 10000. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of transactions that can be in the `prepared` state simultaneously. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the spill files are compressed or not. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 


### GreenplumConfigSet6_19 {#GreenplumConfigSet6_197}

Field | Description
--- | ---
effective_config | **[GreenplumConfig6_19](#GreenplumConfig6_197)**<br>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in [GreenplumConfigSet6_19.user_config](#GreenplumConfigSet6_197) and [GreenplumConfigSet6_19.default_config](#GreenplumConfigSet6_197)). 
user_config | **[GreenplumConfig6_19](#GreenplumConfig6_197)**<br>User-defined settings for a Greenplum® cluster. 
default_config | **[GreenplumConfig6_19](#GreenplumConfig6_197)**<br>Default configuration for a Greenplum® cluster. 


### GreenplumConfig6_19 {#GreenplumConfig6_197}

Field | Description
--- | ---
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections on master segment. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment. <br>The default value is 0 (no limit). <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of temporary spill files allowed per query at each segment. <br>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated. <br>The current query is terminated if the limit is exceeded. <br>Set to zero to disable the limit. <br>Master session reloads if the parameter changes. <br>Default value is 10000. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of transactions that can be in the `prepared` state simultaneously. <br>More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Whether the spill files are compressed or not. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 
max_statement_mem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum memory limit for a query, in bytes. <br>Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting `statement_mem` too high. <br>Taking into account the configuration of a single segment host, calculate `max_statement_mem` as follows: `seghost_physical_memory` / `average_number_concurrent_queries`. <br>When changing both `max_statement_mem` and `statement_mem`, `max_statement_mem` must be changed first, or listed first in the `postgresql.conf` file. <br>Default value is 2097152000 (2000 MB). <br>More info in [Greenplum® documentation](https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem). 
log_statement | enum **LogStatement**<br>Logged SQL statements. <br>`PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command belongs to an appropriate type. <br>More info in [Greenplum® documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement). <ul><li>`NONE`: None statements are logged.</li><li>`DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.</li><li>`MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.</li><li>`ALL`: Logs all statements.</li></ul>


### ConnectionPoolerConfigSet {#ConnectionPoolerConfigSet7}

Field | Description
--- | ---
effective_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig7)**<br>Required. Effective settings for an Odyssey® pooler (a combination of settings defined in [ConnectionPoolerConfigSet.user_config](#ConnectionPoolerConfigSet7) and [ConnectionPoolerConfigSet.default_config](#ConnectionPoolerConfigSet7)). 
user_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig7)**<br>User-defined settings for an Odyssey® pooler. 
default_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig7)**<br>Default configuration for an Odyssey® pooler. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig7}

Field | Description
--- | ---
mode | enum **PoolMode**<br>Route server pool mode. <ul><li>`SESSION`: Assign server connection to a client until it disconnects. Default value.</li><li>`TRANSACTION`: Assign server connection to a client for a transaction processing.</li></ul>
size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. <br>Set to zero to disable the limit. 
client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Server pool idle timeout, in seconds. <br>A server connection closes after being idle for the specified time. <br>Set to zero to disable the limit. 


