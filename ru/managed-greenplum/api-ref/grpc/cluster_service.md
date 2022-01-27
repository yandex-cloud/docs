---
editable: false
sourcePath: en/_api-ref-grpc/managed-greenplum/api-ref/grpc/cluster_service.md
---


# ClusterService

A set of methods for managing Greenplum® clusters.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Greenplum® cluster. |
| [List](#List) | Retrieves a list of Greenplum® clusters that belong to the specified folder. |
| [Create](#Create) | Creates a Greenplum® cluster in the specified folder. |
| [Update](#Update) | Updates the specified Greenplum® cluster. |
| [Delete](#Delete) | Deletes the specified Greenplum® cluster. |
| [Start](#Start) | Starts the specified Greenplum® cluster. |
| [Stop](#Stop) | Stops the specified Greenplum® cluster. |
| [ListOperations](#ListOperations) | Retrieves the list of Operation resources for the specified cluster. |
| [ListMasterHosts](#ListMasterHosts) | Retrieves a list of master hosts for the specified cluster. |
| [ListSegmentHosts](#ListSegmentHosts) | Retrieves a list of segment hosts for the specified cluster. |
| [ListLogs](#ListLogs) | Retrieves logs for the specified Greenplum® cluster. |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified Greenplum® cluster. <br>To get the list of available Greenplum® clusters, make a [List](#List) request.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® Cluster resource to return. To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum® cluster. This ID is assigned by Yandex.Cloud at the time of cluster creation. 
folder_id | **string**<br>ID of the folder that the Greenplum® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Cluster creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Required. Name of the Greenplum® cluster. The name is unique within the folder and is 1-63 characters long. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig)**<br>Greenplum® cluster configuration. 
description | **string**<br>Description of the Greenplum® cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum® cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring)**<br>Description of monitoring systems relevant to the Greenplum® cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig)**<br>Configuration of the Greenplum® segment subcluster. 
master_host_count | **int64**<br>Number of hosts in the master subcluster. 
segment_host_count | **int64**<br>Number of hosts in the segment subcluster. 
segment_in_host | **int64**<br>Number of segments per host. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><li>`UNBALANCED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is UNBALANCED).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation)**<br>Maintenance operation planned at nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups. 
user_name | **string**<br>Owner user name. 
deletion_protection | **bool**<br>Whether or not cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### GreenplumConfig {#GreenplumConfig}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum® server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#Cluster1)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether or not the cluster has a public IP address. <br>After the cluster has been created, this setting cannot be changed. 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allows data export from the cluster to Yandex DataLens. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from the Yandex.Cloud management console. 


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
config | **[GreenplumMasterConfigSet](#GreenplumMasterConfigSet)**<br>Configuration settings of a Greenplum® master server. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### GreenplumMasterConfigSet {#GreenplumMasterConfigSet}

Field | Description
--- | ---
effective_config | **[GreenplumMasterConfig](#GreenplumMasterConfig)**<br>Required. Effective settings for a Greenplum® master subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumMasterConfig](#GreenplumMasterConfig)**<br>User-defined settings for a Greenplum® master subcluster. 
default_config | **[GreenplumMasterConfig](#GreenplumMasterConfig)**<br>Default configuration for a Greenplum® master subcluster. 


### GreenplumMasterConfig {#GreenplumMasterConfig}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Controls which message levels in the master subcluster are sent to the client. <ul><li>`LOG_LEVEL_UNSPECIFIED`: Level of detail is not specified.</li><li>`TRACE`: Include tracing information.</li><li>`DEBUG`: Include debugging information.</li><li>`INFORMATION`: Include informative messages.</li><li>`WARNING`: Include warning messages. Default value.</li><li>`ERROR`: Only include error messages.</li><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
timezone | **google.protobuf.StringValue**<br>The server time zone to be used in DateTime field conversions, specified as an IANA identifier. 
pool | **[ConnectionPoolerConfig](#ConnectionPoolerConfig)**<br>Route server configuration. 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of transactions that can be in the "prepared" state simultaneously. For details, see PostgreSQL [documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
runaway_detector_activation_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>For queries that are managed by resource queues or resource groups, this parameter determines when Greenplum® Database terminates running queries based on the amount of memory the queries are using. A value of 100 disables the automatic termination of queries based on the percentage of memory that is utilized. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#runaway_detector_activation_percent). 
tcp_keepalives_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many keepalives may be lost before the connection is considered dead. A value of 0 uses the system default. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_count). 
tcp_keepalives_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many seconds to wait for a response to a keepalive before retransmitting. A value of 0 uses the system default. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_interval). 
readable_external_table_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>When an SQL query reads from an external table, the parameter value specifies the amount of time in seconds that Greenplum® Database waits before cancelling the query when data stops being returned from the external table. The default value of 0, specifies no time out. Greenplum® Database does not cancel the query. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#readable_external_table_timeout). 
gp_interconnect_snd_queue_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ul><li> 4. Increasing the value might radically increase the amount </li></ul> 
gp_interconnect_queue_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the amount of data per-peer to be queued by the Greenplum® Database interconnect on receivers (when data is received but no space is available to receive it the data will be dropped, and the transmitter will need to resend it) for the default UDPIFC interconnect. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_interconnect_queue_depth). 
log_statement | enum **LogStatement**<br>Controls which SQL statements are logged. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement). <ul><li>`LOG_STATEMENT_UNSPECIFIED`: The statement log option is not specified.</li><li>`NONE`: Don't log SQL statements.</li><li>`DDL`: Log all data definition commands like `CREATE`, `ALTER`, and `DROP` commands. Default value.</li><li>`MOD`: Log `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM` commands. `PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command is of an appropriate type.</li><li>`ALL`: Log all SQL statements.</li><ul/>
log_duration | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Causes the duration of every completed statement which satisfies `log_statement` to be logged. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_duration). 
optimizer_analyze_root_partition | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>For a partitioned table, controls whether the `ROOTPARTITION` keyword is required to collect root partition statistics when the `ANALYZE` command is run on the table. GPORCA uses the root partition statistics when generating a query plan. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#optimizer_analyze_root_partition). 
gp_external_max_segs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of segments that will scan external table data during an external table operation, the purpose being not to overload the system with scanning data and take away resources from other concurrent operations. This only applies to external tables that use the `gpfdist` protocol to access external table data. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_external_max_segs). 
gp_fts_probe_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specifies the allowed timeout for the fault detection process (ftsprobe) to establish a connection to a segment before declaring it down. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_fts_probe_timeout). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 
gp_autostats_mode_in_functions | enum **AutostatsModeInFunctions**<br>Specifies the mode for triggering automatic statistics collection with `ANALYZE` for statements in procedural language functions. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_autostats_mode_in_functions). <ul><li>`AUTOSTATS_MODE_IN_FUNCTIONS_UNSPECIFIED`: The mode is not specified.</li><li>`MODE_NONE`: Disables statistics collection. Default value.</li><li>`ON_CHANGE`: Triggers statistics collection only when the number of rows affected exceeds the threshold defined by `gp_autostats_on_change_threshold` (default is 2147483647). Operations in functions that can trigger automatic statistics collection with on_change are: `CREATE TABLE AS SELECT`, `UPDATE`, `DELETE`, `INSERT` and `COPY`.</li><li>`ON_NO_STATS`: Triggers statistics collection for `CREATE TABLE AS SELECT`, `INSERT`, or `COPY` operations that are executed in functions on any table that has no existing statistics.</li><ul/>


### ConnectionPoolerConfig {#ConnectionPoolerConfig}

Field | Description
--- | ---
mode | enum **PoolMode**<br>Route server pool mode. <ul><li>`SESSION`: Assign server connection to a client until it disconnects. Default value.</li><li>`TRANSACTION`: Assign server connection to a client for a transaction processing.</li><ul/>
size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. Set to zero to disable the limit. 
client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Server pool idle timeout, in seconds. A server connection closes after it has been idle for the specified duration. Set to zero to disable the limit. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig}

Field | Description
--- | ---
resources | **[Resources](#Resources1)**<br>Computational resources allocated to Greenplum® segment subcluster hosts. 
config | **[GreenplumSegmentConfigSet](#GreenplumSegmentConfigSet)**<br>Configuration settings of a Greenplum® segment server. 


### Resources {#Resources1}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### GreenplumSegmentConfigSet {#GreenplumSegmentConfigSet}

Field | Description
--- | ---
effective_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig)**<br>Required. Effective settings for a Greenplum® segment subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig)**<br>User-defined settings for a Greenplum® segment subcluster. 
default_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig)**<br>Default configuration for a Greenplum® segment subcluster. 


### GreenplumSegmentConfig {#GreenplumSegmentConfig}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Controls which message levels in the segment subcluster are sent to the client. <ul><li>`LOG_LEVEL_UNSPECIFIED`: Level of detail is not specified.</li><li>`TRACE`: Include tracing information.</li><li>`DEBUG`: Include debugging information.</li><li>`INFORMATION`: Include informative messages.</li><li>`WARNING`: Include warning messages. Default value.</li><li>`ERROR`: Only include error messages.</li><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specifies the maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. For details, see PostgreSQL [documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is `0`, which means a limit is not enforced. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is `0`, which means a limit is not enforced. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. Default value is `10000`. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
gp_resource_manager | enum **GPResourceManager**<br>Identifies the resource management scheme currently enabled in the Greenplum® Database cluster. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_manager). <ul><li>`GP_RESOURCE_MANAGER_UNSPECIFIED`: The management scheme is not specified.</li><li>`QUEUE`: Resource queue-based management.</li><li>`GROUP`: Resource group-based management. Default value.</li><ul/>
gp_resource_group_cpu_limit | **google.protobuf.FloatValue**<br>Identifies the maximum percentage of system CPU resources to allocate to resource groups on each Greenplum® Database segment node. Note: This server configuration parameter is enforced only when resource group-based management is active. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_cpu_limit). 
gp_resource_group_memory_limit | **google.protobuf.FloatValue**<br>Identifies the maximum percentage of system memory resources to allocate to resource groups on each Greenplum® Database segment node. Note: This server configuration parameter is enforced only when resource group-based management is active. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_memory_limit). 


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
day | enum **WeekDay**<br>Day of the week. <ul><ul/>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation}

Field | Description
--- | ---
info | **string**<br>The description of the operation, 1-256 characters long. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 


## List {#List}

Retrieves a list of Greenplum® clusters that belong to the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list Greenplum® clusters in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently you can only use filtering with the [Cluster.name](#Cluster1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`.</li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of Greenplum Cluster resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster1}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum® cluster. This ID is assigned by Yandex.Cloud at the time of cluster creation. 
folder_id | **string**<br>ID of the folder that the Greenplum® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Cluster creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Required. Name of the Greenplum® cluster. The name is unique within the folder and is 1-63 characters long. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig1)**<br>Greenplum® cluster configuration. 
description | **string**<br>Description of the Greenplum® cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum® cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Description of monitoring systems relevant to the Greenplum® cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig1)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig1)**<br>Configuration of the Greenplum® segment subcluster. 
master_host_count | **int64**<br>Number of hosts in the master subcluster. 
segment_host_count | **int64**<br>Number of hosts in the segment subcluster. 
segment_in_host | **int64**<br>Number of segments per host. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><li>`UNBALANCED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is UNBALANCED).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow1)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation1)**<br>Maintenance operation planned at nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups. 
user_name | **string**<br>Owner user name. 
deletion_protection | **bool**<br>Whether or not cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### GreenplumConfig {#GreenplumConfig1}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum® server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access1)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#Cluster2)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether or not the cluster has a public IP address. <br>After the cluster has been created, this setting cannot be changed. 


### Access {#Access1}

Field | Description
--- | ---
data_lens | **bool**<br>Allows data export from the cluster to Yandex DataLens. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from the Yandex.Cloud management console. 


### Monitoring {#Monitoring1}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum® cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig1}

Field | Description
--- | ---
resources | **[Resources](#Resources2)**<br>Computational resources allocated to Greenplum® master subcluster hosts. 
config | **[GreenplumMasterConfigSet](#GreenplumMasterConfigSet1)**<br>Configuration settings of a Greenplum® master server. 


### Resources {#Resources2}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### GreenplumMasterConfigSet {#GreenplumMasterConfigSet1}

Field | Description
--- | ---
effective_config | **[GreenplumMasterConfig](#GreenplumMasterConfig1)**<br>Required. Effective settings for a Greenplum® master subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumMasterConfig](#GreenplumMasterConfig1)**<br>User-defined settings for a Greenplum® master subcluster. 
default_config | **[GreenplumMasterConfig](#GreenplumMasterConfig1)**<br>Default configuration for a Greenplum® master subcluster. 


### GreenplumMasterConfig {#GreenplumMasterConfig1}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Controls which message levels in the master subcluster are sent to the client. <ul><li>`LOG_LEVEL_UNSPECIFIED`: Level of detail is not specified.</li><li>`TRACE`: Include tracing information.</li><li>`DEBUG`: Include debugging information.</li><li>`INFORMATION`: Include informative messages.</li><li>`WARNING`: Include warning messages. Default value.</li><li>`ERROR`: Only include error messages.</li><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
timezone | **google.protobuf.StringValue**<br>The server time zone to be used in DateTime field conversions, specified as an IANA identifier. 
pool | **[ConnectionPoolerConfig](#ConnectionPoolerConfig1)**<br>Route server configuration. 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of transactions that can be in the "prepared" state simultaneously. For details, see PostgreSQL [documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
runaway_detector_activation_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>For queries that are managed by resource queues or resource groups, this parameter determines when Greenplum® Database terminates running queries based on the amount of memory the queries are using. A value of 100 disables the automatic termination of queries based on the percentage of memory that is utilized. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#runaway_detector_activation_percent). 
tcp_keepalives_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many keepalives may be lost before the connection is considered dead. A value of 0 uses the system default. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_count). 
tcp_keepalives_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many seconds to wait for a response to a keepalive before retransmitting. A value of 0 uses the system default. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_interval). 
readable_external_table_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>When an SQL query reads from an external table, the parameter value specifies the amount of time in seconds that Greenplum® Database waits before cancelling the query when data stops being returned from the external table. The default value of 0, specifies no time out. Greenplum® Database does not cancel the query. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#readable_external_table_timeout). 
gp_interconnect_snd_queue_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ul><li> 4. Increasing the value might radically increase the amount </li></ul> 
gp_interconnect_queue_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the amount of data per-peer to be queued by the Greenplum® Database interconnect on receivers (when data is received but no space is available to receive it the data will be dropped, and the transmitter will need to resend it) for the default UDPIFC interconnect. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_interconnect_queue_depth). 
log_statement | enum **LogStatement**<br>Controls which SQL statements are logged. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement). <ul><li>`LOG_STATEMENT_UNSPECIFIED`: The statement log option is not specified.</li><li>`NONE`: Don't log SQL statements.</li><li>`DDL`: Log all data definition commands like `CREATE`, `ALTER`, and `DROP` commands. Default value.</li><li>`MOD`: Log `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM` commands. `PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command is of an appropriate type.</li><li>`ALL`: Log all SQL statements.</li><ul/>
log_duration | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Causes the duration of every completed statement which satisfies `log_statement` to be logged. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_duration). 
optimizer_analyze_root_partition | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>For a partitioned table, controls whether the `ROOTPARTITION` keyword is required to collect root partition statistics when the `ANALYZE` command is run on the table. GPORCA uses the root partition statistics when generating a query plan. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#optimizer_analyze_root_partition). 
gp_external_max_segs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of segments that will scan external table data during an external table operation, the purpose being not to overload the system with scanning data and take away resources from other concurrent operations. This only applies to external tables that use the `gpfdist` protocol to access external table data. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_external_max_segs). 
gp_fts_probe_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specifies the allowed timeout for the fault detection process (ftsprobe) to establish a connection to a segment before declaring it down. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_fts_probe_timeout). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 
gp_autostats_mode_in_functions | enum **AutostatsModeInFunctions**<br>Specifies the mode for triggering automatic statistics collection with `ANALYZE` for statements in procedural language functions. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_autostats_mode_in_functions). <ul><li>`AUTOSTATS_MODE_IN_FUNCTIONS_UNSPECIFIED`: The mode is not specified.</li><li>`MODE_NONE`: Disables statistics collection. Default value.</li><li>`ON_CHANGE`: Triggers statistics collection only when the number of rows affected exceeds the threshold defined by `gp_autostats_on_change_threshold` (default is 2147483647). Operations in functions that can trigger automatic statistics collection with on_change are: `CREATE TABLE AS SELECT`, `UPDATE`, `DELETE`, `INSERT` and `COPY`.</li><li>`ON_NO_STATS`: Triggers statistics collection for `CREATE TABLE AS SELECT`, `INSERT`, or `COPY` operations that are executed in functions on any table that has no existing statistics.</li><ul/>


### ConnectionPoolerConfig {#ConnectionPoolerConfig1}

Field | Description
--- | ---
mode | enum **PoolMode**<br>Route server pool mode. <ul><li>`SESSION`: Assign server connection to a client until it disconnects. Default value.</li><li>`TRANSACTION`: Assign server connection to a client for a transaction processing.</li><ul/>
size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. Set to zero to disable the limit. 
client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Server pool idle timeout, in seconds. A server connection closes after it has been idle for the specified duration. Set to zero to disable the limit. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig1}

Field | Description
--- | ---
resources | **[Resources](#Resources3)**<br>Computational resources allocated to Greenplum® segment subcluster hosts. 
config | **[GreenplumSegmentConfigSet](#GreenplumSegmentConfigSet1)**<br>Configuration settings of a Greenplum® segment server. 


### Resources {#Resources3}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### GreenplumSegmentConfigSet {#GreenplumSegmentConfigSet1}

Field | Description
--- | ---
effective_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig1)**<br>Required. Effective settings for a Greenplum® segment subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig1)**<br>User-defined settings for a Greenplum® segment subcluster. 
default_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig1)**<br>Default configuration for a Greenplum® segment subcluster. 


### GreenplumSegmentConfig {#GreenplumSegmentConfig1}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Controls which message levels in the segment subcluster are sent to the client. <ul><li>`LOG_LEVEL_UNSPECIFIED`: Level of detail is not specified.</li><li>`TRACE`: Include tracing information.</li><li>`DEBUG`: Include debugging information.</li><li>`INFORMATION`: Include informative messages.</li><li>`WARNING`: Include warning messages. Default value.</li><li>`ERROR`: Only include error messages.</li><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specifies the maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. For details, see PostgreSQL [documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is `0`, which means a limit is not enforced. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is `0`, which means a limit is not enforced. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. Default value is `10000`. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
gp_resource_manager | enum **GPResourceManager**<br>Identifies the resource management scheme currently enabled in the Greenplum® Database cluster. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_manager). <ul><li>`GP_RESOURCE_MANAGER_UNSPECIFIED`: The management scheme is not specified.</li><li>`QUEUE`: Resource queue-based management.</li><li>`GROUP`: Resource group-based management. Default value.</li><ul/>
gp_resource_group_cpu_limit | **google.protobuf.FloatValue**<br>Identifies the maximum percentage of system CPU resources to allocate to resource groups on each Greenplum® Database segment node. Note: This server configuration parameter is enforced only when resource group-based management is active. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_cpu_limit). 
gp_resource_group_memory_limit | **google.protobuf.FloatValue**<br>Identifies the maximum percentage of system memory resources to allocate to resource groups on each Greenplum® Database segment node. Note: This server configuration parameter is enforced only when resource group-based management is active. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_memory_limit). 


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
day | enum **WeekDay**<br>Day of the week. <ul><ul/>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation1}

Field | Description
--- | ---
info | **string**<br>The description of the operation, 1-256 characters long. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 


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
name | **string**<br>Required. Name of the Greenplum® cluster. The name must be unique within the folder. Maximum 63 characters. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the Greenplum® cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 per resource. For example, "project":"mvp" or "source":"dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Required. Deployment environment of the Greenplum® cluster. 
config | **[GreenplumConfig](#GreenplumConfig2)**<br>Greenplum® cluster configuration. 
master_config | **[MasterSubclusterConfigSpec](#MasterSubclusterConfigSpec)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfigSpec](#SegmentSubclusterConfigSpec)**<br>Configuration of the Greenplum® segment subcluster. 
master_host_count | **int64**<br>Number of hosts in the master subcluster. 
segment_in_host | **int64**<br>Number of segments per host. 
segment_host_count | **int64**<br>Number of hosts in the segment subcluster. 
user_name | **string**<br>Owner user name. 
user_password | **string**<br>Required. Owner user password. Must be 8-128 characters long The string length in characters must be 8-128.
network_id | **string**<br>Required. ID of the network to create the cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Whether or not cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups to place VMs of the cluster in. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow2)**<br>Window of maintenance operations. 


### GreenplumConfig {#GreenplumConfig2}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum® server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access2)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#Cluster2)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether or not the cluster has a public IP address. <br>After the cluster has been created, this setting cannot be changed. 


### Access {#Access2}

Field | Description
--- | ---
data_lens | **bool**<br>Allows data export from the cluster to Yandex DataLens. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from the Yandex.Cloud management console. 


### MasterSubclusterConfigSpec {#MasterSubclusterConfigSpec}

Field | Description
--- | ---
resources | **[Resources](#Resources4)**<br>Resources allocated to Greenplum® master subcluster hosts. 
config | **[GreenplumMasterConfig](#GreenplumMasterConfig2)**<br>Configuration settings of a Greenplum® master server. 


### Resources {#Resources4}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### GreenplumMasterConfig {#GreenplumMasterConfig2}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Controls which message levels in the master subcluster are sent to the client. <ul><li>`LOG_LEVEL_UNSPECIFIED`: Level of detail is not specified.</li><li>`TRACE`: Include tracing information.</li><li>`DEBUG`: Include debugging information.</li><li>`INFORMATION`: Include informative messages.</li><li>`WARNING`: Include warning messages. Default value.</li><li>`ERROR`: Only include error messages.</li><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
timezone | **google.protobuf.StringValue**<br>The server time zone to be used in DateTime field conversions, specified as an IANA identifier. 
pool | **[ConnectionPoolerConfig](#ConnectionPoolerConfig2)**<br>Route server configuration. 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of transactions that can be in the "prepared" state simultaneously. For details, see PostgreSQL [documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
runaway_detector_activation_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>For queries that are managed by resource queues or resource groups, this parameter determines when Greenplum® Database terminates running queries based on the amount of memory the queries are using. A value of 100 disables the automatic termination of queries based on the percentage of memory that is utilized. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#runaway_detector_activation_percent). 
tcp_keepalives_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many keepalives may be lost before the connection is considered dead. A value of 0 uses the system default. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_count). 
tcp_keepalives_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many seconds to wait for a response to a keepalive before retransmitting. A value of 0 uses the system default. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_interval). 
readable_external_table_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>When an SQL query reads from an external table, the parameter value specifies the amount of time in seconds that Greenplum® Database waits before cancelling the query when data stops being returned from the external table. The default value of 0, specifies no time out. Greenplum® Database does not cancel the query. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#readable_external_table_timeout). 
gp_interconnect_snd_queue_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ul><li> 4. Increasing the value might radically increase the amount </li></ul> 
gp_interconnect_queue_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the amount of data per-peer to be queued by the Greenplum® Database interconnect on receivers (when data is received but no space is available to receive it the data will be dropped, and the transmitter will need to resend it) for the default UDPIFC interconnect. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_interconnect_queue_depth). 
log_statement | enum **LogStatement**<br>Controls which SQL statements are logged. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement). <ul><li>`LOG_STATEMENT_UNSPECIFIED`: The statement log option is not specified.</li><li>`NONE`: Don't log SQL statements.</li><li>`DDL`: Log all data definition commands like `CREATE`, `ALTER`, and `DROP` commands. Default value.</li><li>`MOD`: Log `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM` commands. `PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command is of an appropriate type.</li><li>`ALL`: Log all SQL statements.</li><ul/>
log_duration | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Causes the duration of every completed statement which satisfies `log_statement` to be logged. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_duration). 
optimizer_analyze_root_partition | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>For a partitioned table, controls whether the `ROOTPARTITION` keyword is required to collect root partition statistics when the `ANALYZE` command is run on the table. GPORCA uses the root partition statistics when generating a query plan. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#optimizer_analyze_root_partition). 
gp_external_max_segs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of segments that will scan external table data during an external table operation, the purpose being not to overload the system with scanning data and take away resources from other concurrent operations. This only applies to external tables that use the `gpfdist` protocol to access external table data. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_external_max_segs). 
gp_fts_probe_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specifies the allowed timeout for the fault detection process (ftsprobe) to establish a connection to a segment before declaring it down. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_fts_probe_timeout). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 
gp_autostats_mode_in_functions | enum **AutostatsModeInFunctions**<br>Specifies the mode for triggering automatic statistics collection with `ANALYZE` for statements in procedural language functions. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_autostats_mode_in_functions). <ul><li>`AUTOSTATS_MODE_IN_FUNCTIONS_UNSPECIFIED`: The mode is not specified.</li><li>`MODE_NONE`: Disables statistics collection. Default value.</li><li>`ON_CHANGE`: Triggers statistics collection only when the number of rows affected exceeds the threshold defined by `gp_autostats_on_change_threshold` (default is 2147483647). Operations in functions that can trigger automatic statistics collection with on_change are: `CREATE TABLE AS SELECT`, `UPDATE`, `DELETE`, `INSERT` and `COPY`.</li><li>`ON_NO_STATS`: Triggers statistics collection for `CREATE TABLE AS SELECT`, `INSERT`, or `COPY` operations that are executed in functions on any table that has no existing statistics.</li><ul/>


### ConnectionPoolerConfig {#ConnectionPoolerConfig2}

Field | Description
--- | ---
mode | enum **PoolMode**<br>Route server pool mode. <ul><li>`SESSION`: Assign server connection to a client until it disconnects. Default value.</li><li>`TRANSACTION`: Assign server connection to a client for a transaction processing.</li><ul/>
size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. Set to zero to disable the limit. 
client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Server pool idle timeout, in seconds. A server connection closes after it has been idle for the specified duration. Set to zero to disable the limit. 


### SegmentSubclusterConfigSpec {#SegmentSubclusterConfigSpec}

Field | Description
--- | ---
resources | **[Resources](#Resources5)**<br>Resources allocated to Greenplum® segment subcluster hosts. 
config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig2)**<br>Configuration settings of a Greenplum® segment server. 


### Resources {#Resources5}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### GreenplumSegmentConfig {#GreenplumSegmentConfig2}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Controls which message levels in the segment subcluster are sent to the client. <ul><li>`LOG_LEVEL_UNSPECIFIED`: Level of detail is not specified.</li><li>`TRACE`: Include tracing information.</li><li>`DEBUG`: Include debugging information.</li><li>`INFORMATION`: Include informative messages.</li><li>`WARNING`: Include warning messages. Default value.</li><li>`ERROR`: Only include error messages.</li><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specifies the maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. For details, see PostgreSQL [documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is `0`, which means a limit is not enforced. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is `0`, which means a limit is not enforced. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. Default value is `10000`. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
gp_resource_manager | enum **GPResourceManager**<br>Identifies the resource management scheme currently enabled in the Greenplum® Database cluster. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_manager). <ul><li>`GP_RESOURCE_MANAGER_UNSPECIFIED`: The management scheme is not specified.</li><li>`QUEUE`: Resource queue-based management.</li><li>`GROUP`: Resource group-based management. Default value.</li><ul/>
gp_resource_group_cpu_limit | **google.protobuf.FloatValue**<br>Identifies the maximum percentage of system CPU resources to allocate to resource groups on each Greenplum® Database segment node. Note: This server configuration parameter is enforced only when resource group-based management is active. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_cpu_limit). 
gp_resource_group_memory_limit | **google.protobuf.FloatValue**<br>Identifies the maximum percentage of system memory resources to allocate to resource groups on each Greenplum® Database segment node. Note: This server configuration parameter is enforced only when resource group-based management is active. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_memory_limit). 


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
day | enum **WeekDay**<br>Day of the week. <ul><ul/>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


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
id | **string**<br>ID of the Greenplum® cluster. This ID is assigned by Yandex.Cloud at the time of cluster creation. 
folder_id | **string**<br>ID of the folder that the Greenplum® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Cluster creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Required. Name of the Greenplum® cluster. The name is unique within the folder and is 1-63 characters long. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig3)**<br>Greenplum® cluster configuration. 
description | **string**<br>Description of the Greenplum® cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum® cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the Greenplum® cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig2)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig2)**<br>Configuration of the Greenplum® segment subcluster. 
master_host_count | **int64**<br>Number of hosts in the master subcluster. 
segment_host_count | **int64**<br>Number of hosts in the segment subcluster. 
segment_in_host | **int64**<br>Number of segments per host. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><li>`UNBALANCED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is UNBALANCED).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation2)**<br>Maintenance operation planned at nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups. 
user_name | **string**<br>Owner user name. 
deletion_protection | **bool**<br>Whether or not cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### GreenplumConfig {#GreenplumConfig3}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum® server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access3)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#Cluster3)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether or not the cluster has a public IP address. <br>After the cluster has been created, this setting cannot be changed. 


### Access {#Access3}

Field | Description
--- | ---
data_lens | **bool**<br>Allows data export from the cluster to Yandex DataLens. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from the Yandex.Cloud management console. 


### Monitoring {#Monitoring2}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum® cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig2}

Field | Description
--- | ---
resources | **[Resources](#Resources6)**<br>Computational resources allocated to Greenplum® master subcluster hosts. 
config | **[GreenplumMasterConfigSet](#GreenplumMasterConfigSet2)**<br>Configuration settings of a Greenplum® master server. 


### Resources {#Resources6}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### GreenplumMasterConfigSet {#GreenplumMasterConfigSet2}

Field | Description
--- | ---
effective_config | **[GreenplumMasterConfig](#GreenplumMasterConfig3)**<br>Required. Effective settings for a Greenplum® master subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumMasterConfig](#GreenplumMasterConfig3)**<br>User-defined settings for a Greenplum® master subcluster. 
default_config | **[GreenplumMasterConfig](#GreenplumMasterConfig3)**<br>Default configuration for a Greenplum® master subcluster. 


### GreenplumMasterConfig {#GreenplumMasterConfig3}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Controls which message levels in the master subcluster are sent to the client. <ul><li>`LOG_LEVEL_UNSPECIFIED`: Level of detail is not specified.</li><li>`TRACE`: Include tracing information.</li><li>`DEBUG`: Include debugging information.</li><li>`INFORMATION`: Include informative messages.</li><li>`WARNING`: Include warning messages. Default value.</li><li>`ERROR`: Only include error messages.</li><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
timezone | **google.protobuf.StringValue**<br>The server time zone to be used in DateTime field conversions, specified as an IANA identifier. 
pool | **[ConnectionPoolerConfig](#ConnectionPoolerConfig3)**<br>Route server configuration. 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of transactions that can be in the "prepared" state simultaneously. For details, see PostgreSQL [documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
runaway_detector_activation_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>For queries that are managed by resource queues or resource groups, this parameter determines when Greenplum® Database terminates running queries based on the amount of memory the queries are using. A value of 100 disables the automatic termination of queries based on the percentage of memory that is utilized. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#runaway_detector_activation_percent). 
tcp_keepalives_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many keepalives may be lost before the connection is considered dead. A value of 0 uses the system default. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_count). 
tcp_keepalives_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many seconds to wait for a response to a keepalive before retransmitting. A value of 0 uses the system default. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_interval). 
readable_external_table_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>When an SQL query reads from an external table, the parameter value specifies the amount of time in seconds that Greenplum® Database waits before cancelling the query when data stops being returned from the external table. The default value of 0, specifies no time out. Greenplum® Database does not cancel the query. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#readable_external_table_timeout). 
gp_interconnect_snd_queue_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ul><li> 4. Increasing the value might radically increase the amount </li></ul> 
gp_interconnect_queue_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the amount of data per-peer to be queued by the Greenplum® Database interconnect on receivers (when data is received but no space is available to receive it the data will be dropped, and the transmitter will need to resend it) for the default UDPIFC interconnect. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_interconnect_queue_depth). 
log_statement | enum **LogStatement**<br>Controls which SQL statements are logged. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement). <ul><li>`LOG_STATEMENT_UNSPECIFIED`: The statement log option is not specified.</li><li>`NONE`: Don't log SQL statements.</li><li>`DDL`: Log all data definition commands like `CREATE`, `ALTER`, and `DROP` commands. Default value.</li><li>`MOD`: Log `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM` commands. `PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command is of an appropriate type.</li><li>`ALL`: Log all SQL statements.</li><ul/>
log_duration | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Causes the duration of every completed statement which satisfies `log_statement` to be logged. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_duration). 
optimizer_analyze_root_partition | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>For a partitioned table, controls whether the `ROOTPARTITION` keyword is required to collect root partition statistics when the `ANALYZE` command is run on the table. GPORCA uses the root partition statistics when generating a query plan. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#optimizer_analyze_root_partition). 
gp_external_max_segs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of segments that will scan external table data during an external table operation, the purpose being not to overload the system with scanning data and take away resources from other concurrent operations. This only applies to external tables that use the `gpfdist` protocol to access external table data. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_external_max_segs). 
gp_fts_probe_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specifies the allowed timeout for the fault detection process (ftsprobe) to establish a connection to a segment before declaring it down. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_fts_probe_timeout). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 
gp_autostats_mode_in_functions | enum **AutostatsModeInFunctions**<br>Specifies the mode for triggering automatic statistics collection with `ANALYZE` for statements in procedural language functions. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_autostats_mode_in_functions). <ul><li>`AUTOSTATS_MODE_IN_FUNCTIONS_UNSPECIFIED`: The mode is not specified.</li><li>`MODE_NONE`: Disables statistics collection. Default value.</li><li>`ON_CHANGE`: Triggers statistics collection only when the number of rows affected exceeds the threshold defined by `gp_autostats_on_change_threshold` (default is 2147483647). Operations in functions that can trigger automatic statistics collection with on_change are: `CREATE TABLE AS SELECT`, `UPDATE`, `DELETE`, `INSERT` and `COPY`.</li><li>`ON_NO_STATS`: Triggers statistics collection for `CREATE TABLE AS SELECT`, `INSERT`, or `COPY` operations that are executed in functions on any table that has no existing statistics.</li><ul/>


### ConnectionPoolerConfig {#ConnectionPoolerConfig3}

Field | Description
--- | ---
mode | enum **PoolMode**<br>Route server pool mode. <ul><li>`SESSION`: Assign server connection to a client until it disconnects. Default value.</li><li>`TRANSACTION`: Assign server connection to a client for a transaction processing.</li><ul/>
size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. Set to zero to disable the limit. 
client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Server pool idle timeout, in seconds. A server connection closes after it has been idle for the specified duration. Set to zero to disable the limit. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig2}

Field | Description
--- | ---
resources | **[Resources](#Resources7)**<br>Computational resources allocated to Greenplum® segment subcluster hosts. 
config | **[GreenplumSegmentConfigSet](#GreenplumSegmentConfigSet2)**<br>Configuration settings of a Greenplum® segment server. 


### Resources {#Resources7}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### GreenplumSegmentConfigSet {#GreenplumSegmentConfigSet2}

Field | Description
--- | ---
effective_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig3)**<br>Required. Effective settings for a Greenplum® segment subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig3)**<br>User-defined settings for a Greenplum® segment subcluster. 
default_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig3)**<br>Default configuration for a Greenplum® segment subcluster. 


### GreenplumSegmentConfig {#GreenplumSegmentConfig3}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Controls which message levels in the segment subcluster are sent to the client. <ul><li>`LOG_LEVEL_UNSPECIFIED`: Level of detail is not specified.</li><li>`TRACE`: Include tracing information.</li><li>`DEBUG`: Include debugging information.</li><li>`INFORMATION`: Include informative messages.</li><li>`WARNING`: Include warning messages. Default value.</li><li>`ERROR`: Only include error messages.</li><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specifies the maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. For details, see PostgreSQL [documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is `0`, which means a limit is not enforced. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is `0`, which means a limit is not enforced. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. Default value is `10000`. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
gp_resource_manager | enum **GPResourceManager**<br>Identifies the resource management scheme currently enabled in the Greenplum® Database cluster. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_manager). <ul><li>`GP_RESOURCE_MANAGER_UNSPECIFIED`: The management scheme is not specified.</li><li>`QUEUE`: Resource queue-based management.</li><li>`GROUP`: Resource group-based management. Default value.</li><ul/>
gp_resource_group_cpu_limit | **google.protobuf.FloatValue**<br>Identifies the maximum percentage of system CPU resources to allocate to resource groups on each Greenplum® Database segment node. Note: This server configuration parameter is enforced only when resource group-based management is active. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_cpu_limit). 
gp_resource_group_memory_limit | **google.protobuf.FloatValue**<br>Identifies the maximum percentage of system memory resources to allocate to resource groups on each Greenplum® Database segment node. Note: This server configuration parameter is enforced only when resource group-based management is active. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_memory_limit). 


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
day | enum **WeekDay**<br>Day of the week. <ul><ul/>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation2}

Field | Description
--- | ---
info | **string**<br>The description of the operation, 1-256 characters long. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 


## Update {#Update}

Updates the specified Greenplum® cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® Cluster resource to update. To get the Greenplum® cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Greenplum® Cluster resource should be updated. 
description | **string**<br>New description of the Greenplum® cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 per resource. For example, "project":"mvp" or "source":"dictionary". <br>The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get](#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
name | **string**<br>New name for the cluster. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
config | **[GreenplumConfig](#GreenplumConfig4)**<br>Greenplum® cluster configuration. 
master_config | **[MasterSubclusterConfigSpec](#MasterSubclusterConfigSpec)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfigSpec](#SegmentSubclusterConfigSpec)**<br>Configuration of the Greenplum® segment subcluster. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Window of maintenance operations. 
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Whether or not cluster is protected from being deleted. 


### GreenplumConfig {#GreenplumConfig4}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum® server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access4)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#Cluster3)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether or not the cluster has a public IP address. <br>After the cluster has been created, this setting cannot be changed. 


### Access {#Access4}

Field | Description
--- | ---
data_lens | **bool**<br>Allows data export from the cluster to Yandex DataLens. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from the Yandex.Cloud management console. 


### MasterSubclusterConfigSpec {#MasterSubclusterConfigSpec1}

Field | Description
--- | ---
resources | **[Resources](#Resources8)**<br>Resources allocated to Greenplum® master subcluster hosts. 
config | **[GreenplumMasterConfig](#GreenplumMasterConfig4)**<br>Configuration settings of a Greenplum® master server. 


### Resources {#Resources8}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### GreenplumMasterConfig {#GreenplumMasterConfig4}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Controls which message levels in the master subcluster are sent to the client. <ul><li>`LOG_LEVEL_UNSPECIFIED`: Level of detail is not specified.</li><li>`TRACE`: Include tracing information.</li><li>`DEBUG`: Include debugging information.</li><li>`INFORMATION`: Include informative messages.</li><li>`WARNING`: Include warning messages. Default value.</li><li>`ERROR`: Only include error messages.</li><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
timezone | **google.protobuf.StringValue**<br>The server time zone to be used in DateTime field conversions, specified as an IANA identifier. 
pool | **[ConnectionPoolerConfig](#ConnectionPoolerConfig4)**<br>Route server configuration. 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of transactions that can be in the "prepared" state simultaneously. For details, see PostgreSQL [documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
runaway_detector_activation_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>For queries that are managed by resource queues or resource groups, this parameter determines when Greenplum® Database terminates running queries based on the amount of memory the queries are using. A value of 100 disables the automatic termination of queries based on the percentage of memory that is utilized. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#runaway_detector_activation_percent). 
tcp_keepalives_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many keepalives may be lost before the connection is considered dead. A value of 0 uses the system default. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_count). 
tcp_keepalives_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many seconds to wait for a response to a keepalive before retransmitting. A value of 0 uses the system default. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_interval). 
readable_external_table_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>When an SQL query reads from an external table, the parameter value specifies the amount of time in seconds that Greenplum® Database waits before cancelling the query when data stops being returned from the external table. The default value of 0, specifies no time out. Greenplum® Database does not cancel the query. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#readable_external_table_timeout). 
gp_interconnect_snd_queue_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ul><li> 4. Increasing the value might radically increase the amount </li></ul> 
gp_interconnect_queue_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the amount of data per-peer to be queued by the Greenplum® Database interconnect on receivers (when data is received but no space is available to receive it the data will be dropped, and the transmitter will need to resend it) for the default UDPIFC interconnect. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_interconnect_queue_depth). 
log_statement | enum **LogStatement**<br>Controls which SQL statements are logged. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement). <ul><li>`LOG_STATEMENT_UNSPECIFIED`: The statement log option is not specified.</li><li>`NONE`: Don't log SQL statements.</li><li>`DDL`: Log all data definition commands like `CREATE`, `ALTER`, and `DROP` commands. Default value.</li><li>`MOD`: Log `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM` commands. `PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command is of an appropriate type.</li><li>`ALL`: Log all SQL statements.</li><ul/>
log_duration | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Causes the duration of every completed statement which satisfies `log_statement` to be logged. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_duration). 
optimizer_analyze_root_partition | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>For a partitioned table, controls whether the `ROOTPARTITION` keyword is required to collect root partition statistics when the `ANALYZE` command is run on the table. GPORCA uses the root partition statistics when generating a query plan. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#optimizer_analyze_root_partition). 
gp_external_max_segs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of segments that will scan external table data during an external table operation, the purpose being not to overload the system with scanning data and take away resources from other concurrent operations. This only applies to external tables that use the `gpfdist` protocol to access external table data. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_external_max_segs). 
gp_fts_probe_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specifies the allowed timeout for the fault detection process (ftsprobe) to establish a connection to a segment before declaring it down. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_fts_probe_timeout). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 
gp_autostats_mode_in_functions | enum **AutostatsModeInFunctions**<br>Specifies the mode for triggering automatic statistics collection with `ANALYZE` for statements in procedural language functions. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_autostats_mode_in_functions). <ul><li>`AUTOSTATS_MODE_IN_FUNCTIONS_UNSPECIFIED`: The mode is not specified.</li><li>`MODE_NONE`: Disables statistics collection. Default value.</li><li>`ON_CHANGE`: Triggers statistics collection only when the number of rows affected exceeds the threshold defined by `gp_autostats_on_change_threshold` (default is 2147483647). Operations in functions that can trigger automatic statistics collection with on_change are: `CREATE TABLE AS SELECT`, `UPDATE`, `DELETE`, `INSERT` and `COPY`.</li><li>`ON_NO_STATS`: Triggers statistics collection for `CREATE TABLE AS SELECT`, `INSERT`, or `COPY` operations that are executed in functions on any table that has no existing statistics.</li><ul/>


### ConnectionPoolerConfig {#ConnectionPoolerConfig4}

Field | Description
--- | ---
mode | enum **PoolMode**<br>Route server pool mode. <ul><li>`SESSION`: Assign server connection to a client until it disconnects. Default value.</li><li>`TRANSACTION`: Assign server connection to a client for a transaction processing.</li><ul/>
size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. Set to zero to disable the limit. 
client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Server pool idle timeout, in seconds. A server connection closes after it has been idle for the specified duration. Set to zero to disable the limit. 


### SegmentSubclusterConfigSpec {#SegmentSubclusterConfigSpec1}

Field | Description
--- | ---
resources | **[Resources](#Resources9)**<br>Resources allocated to Greenplum® segment subcluster hosts. 
config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig4)**<br>Configuration settings of a Greenplum® segment server. 


### Resources {#Resources9}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### GreenplumSegmentConfig {#GreenplumSegmentConfig4}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Controls which message levels in the segment subcluster are sent to the client. <ul><li>`LOG_LEVEL_UNSPECIFIED`: Level of detail is not specified.</li><li>`TRACE`: Include tracing information.</li><li>`DEBUG`: Include debugging information.</li><li>`INFORMATION`: Include informative messages.</li><li>`WARNING`: Include warning messages. Default value.</li><li>`ERROR`: Only include error messages.</li><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specifies the maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. For details, see PostgreSQL [documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is `0`, which means a limit is not enforced. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is `0`, which means a limit is not enforced. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. Default value is `10000`. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
gp_resource_manager | enum **GPResourceManager**<br>Identifies the resource management scheme currently enabled in the Greenplum® Database cluster. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_manager). <ul><li>`GP_RESOURCE_MANAGER_UNSPECIFIED`: The management scheme is not specified.</li><li>`QUEUE`: Resource queue-based management.</li><li>`GROUP`: Resource group-based management. Default value.</li><ul/>
gp_resource_group_cpu_limit | **google.protobuf.FloatValue**<br>Identifies the maximum percentage of system CPU resources to allocate to resource groups on each Greenplum® Database segment node. Note: This server configuration parameter is enforced only when resource group-based management is active. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_cpu_limit). 
gp_resource_group_memory_limit | **google.protobuf.FloatValue**<br>Identifies the maximum percentage of system memory resources to allocate to resource groups on each Greenplum® Database segment node. Note: This server configuration parameter is enforced only when resource group-based management is active. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_memory_limit). 


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
day | enum **WeekDay**<br>Day of the week. <ul><ul/>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


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
cluster_id | **string**<br>ID of the Greenplum® Cluster resource that is being updated. 


### Cluster {#Cluster3}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum® cluster. This ID is assigned by Yandex.Cloud at the time of cluster creation. 
folder_id | **string**<br>ID of the folder that the Greenplum® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Cluster creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Required. Name of the Greenplum® cluster. The name is unique within the folder and is 1-63 characters long. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig5)**<br>Greenplum® cluster configuration. 
description | **string**<br>Description of the Greenplum® cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum® cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Description of monitoring systems relevant to the Greenplum® cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig3)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig3)**<br>Configuration of the Greenplum® segment subcluster. 
master_host_count | **int64**<br>Number of hosts in the master subcluster. 
segment_host_count | **int64**<br>Number of hosts in the segment subcluster. 
segment_in_host | **int64**<br>Number of segments per host. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><li>`UNBALANCED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is UNBALANCED).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow5)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation3)**<br>Maintenance operation planned at nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups. 
user_name | **string**<br>Owner user name. 
deletion_protection | **bool**<br>Whether or not cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### GreenplumConfig {#GreenplumConfig5}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum® server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access5)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#Cluster4)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether or not the cluster has a public IP address. <br>After the cluster has been created, this setting cannot be changed. 


### Access {#Access5}

Field | Description
--- | ---
data_lens | **bool**<br>Allows data export from the cluster to Yandex DataLens. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from the Yandex.Cloud management console. 


### Monitoring {#Monitoring3}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum® cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig3}

Field | Description
--- | ---
resources | **[Resources](#Resources10)**<br>Computational resources allocated to Greenplum® master subcluster hosts. 
config | **[GreenplumMasterConfigSet](#GreenplumMasterConfigSet3)**<br>Configuration settings of a Greenplum® master server. 


### Resources {#Resources10}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### GreenplumMasterConfigSet {#GreenplumMasterConfigSet3}

Field | Description
--- | ---
effective_config | **[GreenplumMasterConfig](#GreenplumMasterConfig5)**<br>Required. Effective settings for a Greenplum® master subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumMasterConfig](#GreenplumMasterConfig5)**<br>User-defined settings for a Greenplum® master subcluster. 
default_config | **[GreenplumMasterConfig](#GreenplumMasterConfig5)**<br>Default configuration for a Greenplum® master subcluster. 


### GreenplumMasterConfig {#GreenplumMasterConfig5}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Controls which message levels in the master subcluster are sent to the client. <ul><li>`LOG_LEVEL_UNSPECIFIED`: Level of detail is not specified.</li><li>`TRACE`: Include tracing information.</li><li>`DEBUG`: Include debugging information.</li><li>`INFORMATION`: Include informative messages.</li><li>`WARNING`: Include warning messages. Default value.</li><li>`ERROR`: Only include error messages.</li><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
timezone | **google.protobuf.StringValue**<br>The server time zone to be used in DateTime field conversions, specified as an IANA identifier. 
pool | **[ConnectionPoolerConfig](#ConnectionPoolerConfig5)**<br>Route server configuration. 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of transactions that can be in the "prepared" state simultaneously. For details, see PostgreSQL [documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
runaway_detector_activation_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>For queries that are managed by resource queues or resource groups, this parameter determines when Greenplum® Database terminates running queries based on the amount of memory the queries are using. A value of 100 disables the automatic termination of queries based on the percentage of memory that is utilized. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#runaway_detector_activation_percent). 
tcp_keepalives_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many keepalives may be lost before the connection is considered dead. A value of 0 uses the system default. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_count). 
tcp_keepalives_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many seconds to wait for a response to a keepalive before retransmitting. A value of 0 uses the system default. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_interval). 
readable_external_table_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>When an SQL query reads from an external table, the parameter value specifies the amount of time in seconds that Greenplum® Database waits before cancelling the query when data stops being returned from the external table. The default value of 0, specifies no time out. Greenplum® Database does not cancel the query. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#readable_external_table_timeout). 
gp_interconnect_snd_queue_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ul><li> 4. Increasing the value might radically increase the amount </li></ul> 
gp_interconnect_queue_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the amount of data per-peer to be queued by the Greenplum® Database interconnect on receivers (when data is received but no space is available to receive it the data will be dropped, and the transmitter will need to resend it) for the default UDPIFC interconnect. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_interconnect_queue_depth). 
log_statement | enum **LogStatement**<br>Controls which SQL statements are logged. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement). <ul><li>`LOG_STATEMENT_UNSPECIFIED`: The statement log option is not specified.</li><li>`NONE`: Don't log SQL statements.</li><li>`DDL`: Log all data definition commands like `CREATE`, `ALTER`, and `DROP` commands. Default value.</li><li>`MOD`: Log `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM` commands. `PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command is of an appropriate type.</li><li>`ALL`: Log all SQL statements.</li><ul/>
log_duration | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Causes the duration of every completed statement which satisfies `log_statement` to be logged. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_duration). 
optimizer_analyze_root_partition | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>For a partitioned table, controls whether the `ROOTPARTITION` keyword is required to collect root partition statistics when the `ANALYZE` command is run on the table. GPORCA uses the root partition statistics when generating a query plan. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#optimizer_analyze_root_partition). 
gp_external_max_segs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of segments that will scan external table data during an external table operation, the purpose being not to overload the system with scanning data and take away resources from other concurrent operations. This only applies to external tables that use the `gpfdist` protocol to access external table data. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_external_max_segs). 
gp_fts_probe_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specifies the allowed timeout for the fault detection process (ftsprobe) to establish a connection to a segment before declaring it down. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_fts_probe_timeout). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 
gp_autostats_mode_in_functions | enum **AutostatsModeInFunctions**<br>Specifies the mode for triggering automatic statistics collection with `ANALYZE` for statements in procedural language functions. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_autostats_mode_in_functions). <ul><li>`AUTOSTATS_MODE_IN_FUNCTIONS_UNSPECIFIED`: The mode is not specified.</li><li>`MODE_NONE`: Disables statistics collection. Default value.</li><li>`ON_CHANGE`: Triggers statistics collection only when the number of rows affected exceeds the threshold defined by `gp_autostats_on_change_threshold` (default is 2147483647). Operations in functions that can trigger automatic statistics collection with on_change are: `CREATE TABLE AS SELECT`, `UPDATE`, `DELETE`, `INSERT` and `COPY`.</li><li>`ON_NO_STATS`: Triggers statistics collection for `CREATE TABLE AS SELECT`, `INSERT`, or `COPY` operations that are executed in functions on any table that has no existing statistics.</li><ul/>


### ConnectionPoolerConfig {#ConnectionPoolerConfig5}

Field | Description
--- | ---
mode | enum **PoolMode**<br>Route server pool mode. <ul><li>`SESSION`: Assign server connection to a client until it disconnects. Default value.</li><li>`TRANSACTION`: Assign server connection to a client for a transaction processing.</li><ul/>
size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. Set to zero to disable the limit. 
client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Server pool idle timeout, in seconds. A server connection closes after it has been idle for the specified duration. Set to zero to disable the limit. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig3}

Field | Description
--- | ---
resources | **[Resources](#Resources11)**<br>Computational resources allocated to Greenplum® segment subcluster hosts. 
config | **[GreenplumSegmentConfigSet](#GreenplumSegmentConfigSet3)**<br>Configuration settings of a Greenplum® segment server. 


### Resources {#Resources11}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### GreenplumSegmentConfigSet {#GreenplumSegmentConfigSet3}

Field | Description
--- | ---
effective_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig5)**<br>Required. Effective settings for a Greenplum® segment subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig5)**<br>User-defined settings for a Greenplum® segment subcluster. 
default_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig5)**<br>Default configuration for a Greenplum® segment subcluster. 


### GreenplumSegmentConfig {#GreenplumSegmentConfig5}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Controls which message levels in the segment subcluster are sent to the client. <ul><li>`LOG_LEVEL_UNSPECIFIED`: Level of detail is not specified.</li><li>`TRACE`: Include tracing information.</li><li>`DEBUG`: Include debugging information.</li><li>`INFORMATION`: Include informative messages.</li><li>`WARNING`: Include warning messages. Default value.</li><li>`ERROR`: Only include error messages.</li><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specifies the maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. For details, see PostgreSQL [documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is `0`, which means a limit is not enforced. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is `0`, which means a limit is not enforced. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. Default value is `10000`. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
gp_resource_manager | enum **GPResourceManager**<br>Identifies the resource management scheme currently enabled in the Greenplum® Database cluster. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_manager). <ul><li>`GP_RESOURCE_MANAGER_UNSPECIFIED`: The management scheme is not specified.</li><li>`QUEUE`: Resource queue-based management.</li><li>`GROUP`: Resource group-based management. Default value.</li><ul/>
gp_resource_group_cpu_limit | **google.protobuf.FloatValue**<br>Identifies the maximum percentage of system CPU resources to allocate to resource groups on each Greenplum® Database segment node. Note: This server configuration parameter is enforced only when resource group-based management is active. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_cpu_limit). 
gp_resource_group_memory_limit | **google.protobuf.FloatValue**<br>Identifies the maximum percentage of system memory resources to allocate to resource groups on each Greenplum® Database segment node. Note: This server configuration parameter is enforced only when resource group-based management is active. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_memory_limit). 


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
day | enum **WeekDay**<br>Day of the week. <ul><ul/>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation3}

Field | Description
--- | ---
info | **string**<br>The description of the operation, 1-256 characters long. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 


## Delete {#Delete}

Deletes the specified Greenplum® cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® cluster to delete. To get the Greenplum® cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the Greenplum® cluster that is being deleted. 


## Start {#Start}

Starts the specified Greenplum® cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® cluster to start. To get the Greenplum® cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the Greenplum® cluster being started. 


### Cluster {#Cluster4}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum® cluster. This ID is assigned by Yandex.Cloud at the time of cluster creation. 
folder_id | **string**<br>ID of the folder that the Greenplum® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Cluster creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Required. Name of the Greenplum® cluster. The name is unique within the folder and is 1-63 characters long. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig6)**<br>Greenplum® cluster configuration. 
description | **string**<br>Description of the Greenplum® cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum® cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Description of monitoring systems relevant to the Greenplum® cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig4)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig4)**<br>Configuration of the Greenplum® segment subcluster. 
master_host_count | **int64**<br>Number of hosts in the master subcluster. 
segment_host_count | **int64**<br>Number of hosts in the segment subcluster. 
segment_in_host | **int64**<br>Number of segments per host. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><li>`UNBALANCED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is UNBALANCED).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow6)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation4)**<br>Maintenance operation planned at nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups. 
user_name | **string**<br>Owner user name. 
deletion_protection | **bool**<br>Whether or not cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### GreenplumConfig {#GreenplumConfig6}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum® server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access6)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#Cluster5)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether or not the cluster has a public IP address. <br>After the cluster has been created, this setting cannot be changed. 


### Access {#Access6}

Field | Description
--- | ---
data_lens | **bool**<br>Allows data export from the cluster to Yandex DataLens. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from the Yandex.Cloud management console. 


### Monitoring {#Monitoring4}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum® cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig4}

Field | Description
--- | ---
resources | **[Resources](#Resources12)**<br>Computational resources allocated to Greenplum® master subcluster hosts. 
config | **[GreenplumMasterConfigSet](#GreenplumMasterConfigSet4)**<br>Configuration settings of a Greenplum® master server. 


### Resources {#Resources12}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### GreenplumMasterConfigSet {#GreenplumMasterConfigSet4}

Field | Description
--- | ---
effective_config | **[GreenplumMasterConfig](#GreenplumMasterConfig6)**<br>Required. Effective settings for a Greenplum® master subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumMasterConfig](#GreenplumMasterConfig6)**<br>User-defined settings for a Greenplum® master subcluster. 
default_config | **[GreenplumMasterConfig](#GreenplumMasterConfig6)**<br>Default configuration for a Greenplum® master subcluster. 


### GreenplumMasterConfig {#GreenplumMasterConfig6}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Controls which message levels in the master subcluster are sent to the client. <ul><li>`LOG_LEVEL_UNSPECIFIED`: Level of detail is not specified.</li><li>`TRACE`: Include tracing information.</li><li>`DEBUG`: Include debugging information.</li><li>`INFORMATION`: Include informative messages.</li><li>`WARNING`: Include warning messages. Default value.</li><li>`ERROR`: Only include error messages.</li><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
timezone | **google.protobuf.StringValue**<br>The server time zone to be used in DateTime field conversions, specified as an IANA identifier. 
pool | **[ConnectionPoolerConfig](#ConnectionPoolerConfig6)**<br>Route server configuration. 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of transactions that can be in the "prepared" state simultaneously. For details, see PostgreSQL [documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
runaway_detector_activation_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>For queries that are managed by resource queues or resource groups, this parameter determines when Greenplum® Database terminates running queries based on the amount of memory the queries are using. A value of 100 disables the automatic termination of queries based on the percentage of memory that is utilized. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#runaway_detector_activation_percent). 
tcp_keepalives_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many keepalives may be lost before the connection is considered dead. A value of 0 uses the system default. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_count). 
tcp_keepalives_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many seconds to wait for a response to a keepalive before retransmitting. A value of 0 uses the system default. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_interval). 
readable_external_table_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>When an SQL query reads from an external table, the parameter value specifies the amount of time in seconds that Greenplum® Database waits before cancelling the query when data stops being returned from the external table. The default value of 0, specifies no time out. Greenplum® Database does not cancel the query. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#readable_external_table_timeout). 
gp_interconnect_snd_queue_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ul><li> 4. Increasing the value might radically increase the amount </li></ul> 
gp_interconnect_queue_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the amount of data per-peer to be queued by the Greenplum® Database interconnect on receivers (when data is received but no space is available to receive it the data will be dropped, and the transmitter will need to resend it) for the default UDPIFC interconnect. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_interconnect_queue_depth). 
log_statement | enum **LogStatement**<br>Controls which SQL statements are logged. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement). <ul><li>`LOG_STATEMENT_UNSPECIFIED`: The statement log option is not specified.</li><li>`NONE`: Don't log SQL statements.</li><li>`DDL`: Log all data definition commands like `CREATE`, `ALTER`, and `DROP` commands. Default value.</li><li>`MOD`: Log `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM` commands. `PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command is of an appropriate type.</li><li>`ALL`: Log all SQL statements.</li><ul/>
log_duration | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Causes the duration of every completed statement which satisfies `log_statement` to be logged. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_duration). 
optimizer_analyze_root_partition | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>For a partitioned table, controls whether the `ROOTPARTITION` keyword is required to collect root partition statistics when the `ANALYZE` command is run on the table. GPORCA uses the root partition statistics when generating a query plan. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#optimizer_analyze_root_partition). 
gp_external_max_segs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of segments that will scan external table data during an external table operation, the purpose being not to overload the system with scanning data and take away resources from other concurrent operations. This only applies to external tables that use the `gpfdist` protocol to access external table data. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_external_max_segs). 
gp_fts_probe_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specifies the allowed timeout for the fault detection process (ftsprobe) to establish a connection to a segment before declaring it down. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_fts_probe_timeout). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 
gp_autostats_mode_in_functions | enum **AutostatsModeInFunctions**<br>Specifies the mode for triggering automatic statistics collection with `ANALYZE` for statements in procedural language functions. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_autostats_mode_in_functions). <ul><li>`AUTOSTATS_MODE_IN_FUNCTIONS_UNSPECIFIED`: The mode is not specified.</li><li>`MODE_NONE`: Disables statistics collection. Default value.</li><li>`ON_CHANGE`: Triggers statistics collection only when the number of rows affected exceeds the threshold defined by `gp_autostats_on_change_threshold` (default is 2147483647). Operations in functions that can trigger automatic statistics collection with on_change are: `CREATE TABLE AS SELECT`, `UPDATE`, `DELETE`, `INSERT` and `COPY`.</li><li>`ON_NO_STATS`: Triggers statistics collection for `CREATE TABLE AS SELECT`, `INSERT`, or `COPY` operations that are executed in functions on any table that has no existing statistics.</li><ul/>


### ConnectionPoolerConfig {#ConnectionPoolerConfig6}

Field | Description
--- | ---
mode | enum **PoolMode**<br>Route server pool mode. <ul><li>`SESSION`: Assign server connection to a client until it disconnects. Default value.</li><li>`TRANSACTION`: Assign server connection to a client for a transaction processing.</li><ul/>
size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. Set to zero to disable the limit. 
client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Server pool idle timeout, in seconds. A server connection closes after it has been idle for the specified duration. Set to zero to disable the limit. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig4}

Field | Description
--- | ---
resources | **[Resources](#Resources13)**<br>Computational resources allocated to Greenplum® segment subcluster hosts. 
config | **[GreenplumSegmentConfigSet](#GreenplumSegmentConfigSet4)**<br>Configuration settings of a Greenplum® segment server. 


### Resources {#Resources13}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### GreenplumSegmentConfigSet {#GreenplumSegmentConfigSet4}

Field | Description
--- | ---
effective_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig6)**<br>Required. Effective settings for a Greenplum® segment subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig6)**<br>User-defined settings for a Greenplum® segment subcluster. 
default_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig6)**<br>Default configuration for a Greenplum® segment subcluster. 


### GreenplumSegmentConfig {#GreenplumSegmentConfig6}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Controls which message levels in the segment subcluster are sent to the client. <ul><li>`LOG_LEVEL_UNSPECIFIED`: Level of detail is not specified.</li><li>`TRACE`: Include tracing information.</li><li>`DEBUG`: Include debugging information.</li><li>`INFORMATION`: Include informative messages.</li><li>`WARNING`: Include warning messages. Default value.</li><li>`ERROR`: Only include error messages.</li><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specifies the maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. For details, see PostgreSQL [documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is `0`, which means a limit is not enforced. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is `0`, which means a limit is not enforced. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. Default value is `10000`. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
gp_resource_manager | enum **GPResourceManager**<br>Identifies the resource management scheme currently enabled in the Greenplum® Database cluster. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_manager). <ul><li>`GP_RESOURCE_MANAGER_UNSPECIFIED`: The management scheme is not specified.</li><li>`QUEUE`: Resource queue-based management.</li><li>`GROUP`: Resource group-based management. Default value.</li><ul/>
gp_resource_group_cpu_limit | **google.protobuf.FloatValue**<br>Identifies the maximum percentage of system CPU resources to allocate to resource groups on each Greenplum® Database segment node. Note: This server configuration parameter is enforced only when resource group-based management is active. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_cpu_limit). 
gp_resource_group_memory_limit | **google.protobuf.FloatValue**<br>Identifies the maximum percentage of system memory resources to allocate to resource groups on each Greenplum® Database segment node. Note: This server configuration parameter is enforced only when resource group-based management is active. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_memory_limit). 


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
day | enum **WeekDay**<br>Day of the week. <ul><ul/>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation4}

Field | Description
--- | ---
info | **string**<br>The description of the operation, 1-256 characters long. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 


## Stop {#Stop}

Stops the specified Greenplum® cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® cluster to stop. To get the Greenplum® cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the Greenplum® cluster being stopped. 


### Cluster {#Cluster5}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum® cluster. This ID is assigned by Yandex.Cloud at the time of cluster creation. 
folder_id | **string**<br>ID of the folder that the Greenplum® cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Cluster creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Required. Name of the Greenplum® cluster. The name is unique within the folder and is 1-63 characters long. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig7)**<br>Greenplum® cluster configuration. 
description | **string**<br>Description of the Greenplum® cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum® cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Description of monitoring systems relevant to the Greenplum® cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig5)**<br>Configuration of the Greenplum® master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig5)**<br>Configuration of the Greenplum® segment subcluster. 
master_host_count | **int64**<br>Number of hosts in the master subcluster. 
segment_host_count | **int64**<br>Number of hosts in the segment subcluster. 
segment_in_host | **int64**<br>Number of segments per host. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><li>`UNBALANCED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is UNBALANCED).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow7)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation5)**<br>Maintenance operation planned at nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups. 
user_name | **string**<br>Owner user name. 
deletion_protection | **bool**<br>Whether or not cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### GreenplumConfig {#GreenplumConfig7}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum® server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access7)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone the cluster belongs to. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#Cluster6)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether or not the cluster has a public IP address. <br>After the cluster has been created, this setting cannot be changed. 


### Access {#Access7}

Field | Description
--- | ---
data_lens | **bool**<br>Allows data export from the cluster to Yandex DataLens. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from the Yandex.Cloud management console. 


### Monitoring {#Monitoring5}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum® cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig5}

Field | Description
--- | ---
resources | **[Resources](#Resources14)**<br>Computational resources allocated to Greenplum® master subcluster hosts. 
config | **[GreenplumMasterConfigSet](#GreenplumMasterConfigSet5)**<br>Configuration settings of a Greenplum® master server. 


### Resources {#Resources14}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### GreenplumMasterConfigSet {#GreenplumMasterConfigSet5}

Field | Description
--- | ---
effective_config | **[GreenplumMasterConfig](#GreenplumMasterConfig7)**<br>Required. Effective settings for a Greenplum® master subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumMasterConfig](#GreenplumMasterConfig7)**<br>User-defined settings for a Greenplum® master subcluster. 
default_config | **[GreenplumMasterConfig](#GreenplumMasterConfig7)**<br>Default configuration for a Greenplum® master subcluster. 


### GreenplumMasterConfig {#GreenplumMasterConfig7}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Controls which message levels in the master subcluster are sent to the client. <ul><li>`LOG_LEVEL_UNSPECIFIED`: Level of detail is not specified.</li><li>`TRACE`: Include tracing information.</li><li>`DEBUG`: Include debugging information.</li><li>`INFORMATION`: Include informative messages.</li><li>`WARNING`: Include warning messages. Default value.</li><li>`ERROR`: Only include error messages.</li><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
timezone | **google.protobuf.StringValue**<br>The server time zone to be used in DateTime field conversions, specified as an IANA identifier. 
pool | **[ConnectionPoolerConfig](#ConnectionPoolerConfig7)**<br>Route server configuration. 
max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of transactions that can be in the "prepared" state simultaneously. For details, see PostgreSQL [documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). 
runaway_detector_activation_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>For queries that are managed by resource queues or resource groups, this parameter determines when Greenplum® Database terminates running queries based on the amount of memory the queries are using. A value of 100 disables the automatic termination of queries based on the percentage of memory that is utilized. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#runaway_detector_activation_percent). 
tcp_keepalives_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many keepalives may be lost before the connection is considered dead. A value of 0 uses the system default. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_count). 
tcp_keepalives_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>How many seconds to wait for a response to a keepalive before retransmitting. A value of 0 uses the system default. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_interval). 
readable_external_table_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>When an SQL query reads from an external table, the parameter value specifies the amount of time in seconds that Greenplum® Database waits before cancelling the query when data stops being returned from the external table. The default value of 0, specifies no time out. Greenplum® Database does not cancel the query. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#readable_external_table_timeout). 
gp_interconnect_snd_queue_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ul><li> 4. Increasing the value might radically increase the amount </li></ul> 
gp_interconnect_queue_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the amount of data per-peer to be queued by the Greenplum® Database interconnect on receivers (when data is received but no space is available to receive it the data will be dropped, and the transmitter will need to resend it) for the default UDPIFC interconnect. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_interconnect_queue_depth). 
log_statement | enum **LogStatement**<br>Controls which SQL statements are logged. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement). <ul><li>`LOG_STATEMENT_UNSPECIFIED`: The statement log option is not specified.</li><li>`NONE`: Don't log SQL statements.</li><li>`DDL`: Log all data definition commands like `CREATE`, `ALTER`, and `DROP` commands. Default value.</li><li>`MOD`: Log `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM` commands. `PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command is of an appropriate type.</li><li>`ALL`: Log all SQL statements.</li><ul/>
log_duration | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Causes the duration of every completed statement which satisfies `log_statement` to be logged. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_duration). 
optimizer_analyze_root_partition | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>For a partitioned table, controls whether the `ROOTPARTITION` keyword is required to collect root partition statistics when the `ANALYZE` command is run on the table. GPORCA uses the root partition statistics when generating a query plan. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#optimizer_analyze_root_partition). 
gp_external_max_segs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the number of segments that will scan external table data during an external table operation, the purpose being not to overload the system with scanning data and take away resources from other concurrent operations. This only applies to external tables that use the `gpfdist` protocol to access external table data. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_external_max_segs). 
gp_fts_probe_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specifies the allowed timeout for the fault detection process (ftsprobe) to establish a connection to a segment before declaring it down. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_fts_probe_timeout). 
gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression). 
gp_autostats_mode_in_functions | enum **AutostatsModeInFunctions**<br>Specifies the mode for triggering automatic statistics collection with `ANALYZE` for statements in procedural language functions. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_autostats_mode_in_functions). <ul><li>`AUTOSTATS_MODE_IN_FUNCTIONS_UNSPECIFIED`: The mode is not specified.</li><li>`MODE_NONE`: Disables statistics collection. Default value.</li><li>`ON_CHANGE`: Triggers statistics collection only when the number of rows affected exceeds the threshold defined by `gp_autostats_on_change_threshold` (default is 2147483647). Operations in functions that can trigger automatic statistics collection with on_change are: `CREATE TABLE AS SELECT`, `UPDATE`, `DELETE`, `INSERT` and `COPY`.</li><li>`ON_NO_STATS`: Triggers statistics collection for `CREATE TABLE AS SELECT`, `INSERT`, or `COPY` operations that are executed in functions on any table that has no existing statistics.</li><ul/>


### ConnectionPoolerConfig {#ConnectionPoolerConfig7}

Field | Description
--- | ---
mode | enum **PoolMode**<br>Route server pool mode. <ul><li>`SESSION`: Assign server connection to a client until it disconnects. Default value.</li><li>`TRANSACTION`: Assign server connection to a client for a transaction processing.</li><ul/>
size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. Set to zero to disable the limit. 
client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Server pool idle timeout, in seconds. A server connection closes after it has been idle for the specified duration. Set to zero to disable the limit. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig5}

Field | Description
--- | ---
resources | **[Resources](#Resources15)**<br>Computational resources allocated to Greenplum® segment subcluster hosts. 
config | **[GreenplumSegmentConfigSet](#GreenplumSegmentConfigSet5)**<br>Configuration settings of a Greenplum® segment server. 


### Resources {#Resources15}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### GreenplumSegmentConfigSet {#GreenplumSegmentConfigSet5}

Field | Description
--- | ---
effective_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig7)**<br>Required. Effective settings for a Greenplum® segment subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig7)**<br>User-defined settings for a Greenplum® segment subcluster. 
default_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig7)**<br>Default configuration for a Greenplum® segment subcluster. 


### GreenplumSegmentConfig {#GreenplumSegmentConfig7}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Controls which message levels in the segment subcluster are sent to the client. <ul><li>`LOG_LEVEL_UNSPECIFIED`: Level of detail is not specified.</li><li>`TRACE`: Include tracing information.</li><li>`DEBUG`: Include debugging information.</li><li>`INFORMATION`: Include informative messages.</li><li>`WARNING`: Include warning messages. Default value.</li><li>`ERROR`: Only include error messages.</li><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Specifies the maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time. For details, see PostgreSQL [documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). 
gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is `0`, which means a limit is not enforced. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment). 
gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is `0`, which means a limit is not enforced. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query). 
gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. Default value is `10000`. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query). 
gp_resource_manager | enum **GPResourceManager**<br>Identifies the resource management scheme currently enabled in the Greenplum® Database cluster. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_manager). <ul><li>`GP_RESOURCE_MANAGER_UNSPECIFIED`: The management scheme is not specified.</li><li>`QUEUE`: Resource queue-based management.</li><li>`GROUP`: Resource group-based management. Default value.</li><ul/>
gp_resource_group_cpu_limit | **google.protobuf.FloatValue**<br>Identifies the maximum percentage of system CPU resources to allocate to resource groups on each Greenplum® Database segment node. Note: This server configuration parameter is enforced only when resource group-based management is active. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_cpu_limit). 
gp_resource_group_memory_limit | **google.protobuf.FloatValue**<br>Identifies the maximum percentage of system memory resources to allocate to resource groups on each Greenplum® Database segment node. Note: This server configuration parameter is enforced only when resource group-based management is active. For details, see Greenplum® [documentation](https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_memory_limit). 


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
day | enum **WeekDay**<br>Day of the week. <ul><ul/>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation5}

Field | Description
--- | ---
info | **string**<br>The description of the operation, 1-256 characters long. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 


## ListOperations {#ListOperations}

Retrieves the list of Operation resources for the specified cluster.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® Cluster resource to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>List of Operation resources for the specified Greenplum® cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest), use the `next_page_token` as the value for the [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation5}

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
cluster_id | **string**<br>Required. ID of the Greenplum® cluster. To get the Greenplum® cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](#Host)**<br>Requested list of hosts for the cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
name | **string**<br>Required. Name of the Greenplum® host. The host name is assigned by Yandex.Cloud at creation time and cannot be changed. 1-63 characters long. <br>The name is unique across all existing MDB hosts in Yandex.Cloud, as it defines the FQDN of the host. The maximum string length in characters is 63.
cluster_id | **string**<br>ID of the Greenplum® cluster. The ID is assigned by Yandex.Cloud at creation time. 
zone_id | **string**<br>ID of the availability zone the Greenplum® host belongs to. 
type | enum **Type**<br>Type of the host. <ul><li>`TYPE_UNSPECIFIED`: The type is not specified.</li><li>`MASTER`: A Greenplum® master host.</li><li>`REPLICA`: A Greenplum® master replica host.</li><li>`SEGMENT`: A Greenplum® segment host.</li><ul/>
resources | **[Resources](#Resources16)**<br>Resources allocated to the Greenplum® host. 
health | enum **Health**<br>Status code of the aggregated health of the host. <ul><li>`UNKNOWN`: Health of the host is unknown.</li><li>`ALIVE`: The host is performing all its functions normally.</li><li>`DEAD`: The host is inoperable and cannot perform any of its essential functions.</li><li>`DEGRADED`: The host is working below capacity or not fully functional.</li><li>`UNBALANCED`: One or more segments are not in preferred role.</li><ul/>
subnet_id | **string**<br>ID of the subnet that the host belongs to. 
assign_public_ip | **bool**<br>Whether or not a public IP is assigned to the host. 


### Resources {#Resources16}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


## ListSegmentHosts {#ListSegmentHosts}

Retrieves a list of segment hosts for the specified cluster.

**rpc ListSegmentHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest1}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® cluster. To get the Greenplum® cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse1}

Field | Description
--- | ---
hosts[] | **[Host](#Host1)**<br>Requested list of hosts for the cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Host {#Host1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the Greenplum® host. The host name is assigned by Yandex.Cloud at creation time and cannot be changed. 1-63 characters long. <br>The name is unique across all existing MDB hosts in Yandex.Cloud, as it defines the FQDN of the host. The maximum string length in characters is 63.
cluster_id | **string**<br>ID of the Greenplum® cluster. The ID is assigned by Yandex.Cloud at creation time. 
zone_id | **string**<br>ID of the availability zone the Greenplum® host belongs to. 
type | enum **Type**<br>Type of the host. <ul><li>`TYPE_UNSPECIFIED`: The type is not specified.</li><li>`MASTER`: A Greenplum® master host.</li><li>`REPLICA`: A Greenplum® master replica host.</li><li>`SEGMENT`: A Greenplum® segment host.</li><ul/>
resources | **[Resources](#Resources17)**<br>Resources allocated to the Greenplum® host. 
health | enum **Health**<br>Status code of the aggregated health of the host. <ul><li>`UNKNOWN`: Health of the host is unknown.</li><li>`ALIVE`: The host is performing all its functions normally.</li><li>`DEAD`: The host is inoperable and cannot perform any of its essential functions.</li><li>`DEGRADED`: The host is working below capacity or not fully functional.</li><li>`UNBALANCED`: One or more segments are not in preferred role.</li><ul/>
subnet_id | **string**<br>ID of the subnet that the host belongs to. 
assign_public_ip | **bool**<br>Whether or not a public IP is assigned to the host. 


### Resources {#Resources17}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


## ListLogs {#ListLogs}

Retrieves logs for the specified Greenplum® cluster.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum® cluster to request logs for. To get the Greenplum® cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from logs table to request. If no columns are specified, entire log records are returned. 
service_type | enum **ServiceType**<br>Type of the service to request logs about. <ul><li>`SERVICE_TYPE_UNSPECIFIED`: Type is not specified.</li><li>`GREENPLUM`: Greenplum® activity logs.</li><li>`GREENPLUM_POOLER`: Greenplum® pooler logs.</li><ul/>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) returned by a previous list request. The maximum string length in characters is 100.
always_next_page_token | **bool**<br>Always return `next_page_token`, even if the current page is empty. 
filter | **string**<br><ol><li>The field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname](#LogRecord), </li><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 1-63 characters long and match the regular expression `^[a-z0-9.-]{1,61}$`. </li><li>`message.hostname='node1.db.cloud.yandex.net'` </li><li>`message.error_severity IN ("ERROR", "FATAL", "PANIC") AND message.hostname = "node1.db.cloud.yandex.net"`</li></ol> The maximum string length in characters is 1000.


### ListClusterLogsResponse {#ListClusterLogsResponse}

Field | Description
--- | ---
logs[] | **[LogRecord](#LogRecord)**<br>Requested log records. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterLogsRequest.page_size](#ListClusterLogsRequest), use the `next_page_token` as the value for the [ListClusterLogsRequest.page_token](#ListClusterLogsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. This value is interchangeable with the [StreamLogRecord.next_record_token] from StreamLogs method. 


### LogRecord {#LogRecord}

Field | Description
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log record timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
message | **map<string,string>**<br>Contents of the log record. 


