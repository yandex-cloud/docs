---
editable: false
sourcePath: en/_api-ref-grpc/managed-postgresql/api-ref/grpc/cluster_service.md
---

# Managed Service for PostgreSQL API, gRPC: ClusterService

A set of methods for managing PostgreSQL Cluster resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified PostgreSQL Cluster resource. |
| [List](#List) | Retrieves the list of PostgreSQL Cluster resources that belong to the specified folder. |
| [Create](#Create) | Creates a PostgreSQL cluster in the specified folder. |
| [Update](#Update) | Updates the specified PostgreSQL cluster. |
| [Delete](#Delete) | Deletes the specified PostgreSQL cluster. |
| [Start](#Start) | Start the specified PostgreSQL cluster. |
| [Stop](#Stop) | Stop the specified PostgreSQL cluster. |
| [Move](#Move) | Moves the specified PostgreSQL cluster to the specified folder. |
| [Backup](#Backup) | Creates a backup for the specified PostgreSQL cluster. |
| [Restore](#Restore) | Creates a new PostgreSQL cluster using the specified backup. |
| [RescheduleMaintenance](#RescheduleMaintenance) | Reschedules planned maintenance operation. |
| [StartFailover](#StartFailover) | Start a manual failover on the specified PostgreSQL cluster. |
| [ListLogs](#ListLogs) | Retrieves logs for the specified PostgreSQL cluster. |
| [StreamLogs](#StreamLogs) | Same as ListLogs but using server-side streaming. |
| [ListOperations](#ListOperations) | Retrieves the list of Operation resources for the specified cluster. |
| [ListBackups](#ListBackups) | Retrieves the list of available backups for the specified PostgreSQL cluster. |
| [ListHosts](#ListHosts) | Retrieves a list of hosts for the specified cluster. |
| [AddHosts](#AddHosts) | Creates new hosts for a cluster. |
| [DeleteHosts](#DeleteHosts) | Deletes the specified hosts for a cluster. |
| [UpdateHosts](#UpdateHosts) | Updates the specified hosts. |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified PostgreSQL Cluster resource. <br>To get the list of available PostgreSQL Cluster resources, make a [List](#List) request.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL Cluster resource to return. To get the cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the PostgreSQL cluster. 


### ClusterConfig {#ClusterConfig}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL server software. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>Configuration for PostgreSQL servers in the cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration of a PostgreSQL 9.6 server. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration of a PostgreSQL 10 1C server. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration of a PostgreSQL 10 server. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration of a PostgreSQL 11 server. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlConfigSet11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**<br>Configuration of a PostgreSQL 11 1C server. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration of a PostgreSQL 12 server. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlConfigSet12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**<br>Configuration of a PostgreSQL 12 1C server. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlConfigSet13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**<br>Configuration of a PostgreSQL 13 server. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlConfigSet13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**<br>Configuration of a PostgreSQL 13 1C server. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlConfigSet14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**<br>Configuration of a PostgreSQL 14 server. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlConfigSet14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**<br>Configuration of a PostgreSQL 14 1C server. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlConfigSet15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**<br>Configuration of a PostgreSQL 15 server. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlConfigSet15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**<br>Configuration of a PostgreSQL 15 1C server. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.
access | **[Access](#Access)**<br>Access policy to DB 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics)**<br>Configuration of the performance diagnostics service. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig}

Field | Description
--- | ---
pooling_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Session pooling mode.</li><li>`TRANSACTION`: Transaction pooling mode.</li><li>`STATEMENT`: Statement pooling mode.</li></ul>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Setting `server_reset_query_always` parameter in PgBouncer. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-postgresql/operations/web-sql-query) for more details. 
serverless | **bool**<br>Allow access for Serverless 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics}

Field | Description
--- | ---
enabled | **bool**<br>Configuration setting which enables/disables performance diagnostics service in cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_activity sampling Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_statements sampling Acceptable values are 1 to 86400, inclusive.


### MaintenanceWindow {#MaintenanceWindow}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}



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

Retrieves the list of PostgreSQL Cluster resources that belong to the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list PostgreSQL clusters in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by the previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can only use filtering with the [Cluster.name](#Cluster1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`.</li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of PostgreSQL Cluster resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster1}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow1)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation1)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring1}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the PostgreSQL cluster. 


### ClusterConfig {#ClusterConfig1}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL server software. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>Configuration for PostgreSQL servers in the cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration of a PostgreSQL 9.6 server. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration of a PostgreSQL 10 1C server. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration of a PostgreSQL 10 server. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration of a PostgreSQL 11 server. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlConfigSet11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**<br>Configuration of a PostgreSQL 11 1C server. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration of a PostgreSQL 12 server. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlConfigSet12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**<br>Configuration of a PostgreSQL 12 1C server. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlConfigSet13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**<br>Configuration of a PostgreSQL 13 server. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlConfigSet13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**<br>Configuration of a PostgreSQL 13 1C server. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlConfigSet14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**<br>Configuration of a PostgreSQL 14 server. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlConfigSet14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**<br>Configuration of a PostgreSQL 14 1C server. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlConfigSet15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**<br>Configuration of a PostgreSQL 15 server. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlConfigSet15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**<br>Configuration of a PostgreSQL 15 1C server. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig1)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources1)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.
access | **[Access](#Access1)**<br>Access policy to DB 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics1)**<br>Configuration of the performance diagnostics service. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig1}

Field | Description
--- | ---
pooling_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Session pooling mode.</li><li>`TRANSACTION`: Transaction pooling mode.</li><li>`STATEMENT`: Statement pooling mode.</li></ul>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Setting `server_reset_query_always` parameter in PgBouncer. 


### Resources {#Resources1}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access1}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-postgresql/operations/web-sql-query) for more details. 
serverless | **bool**<br>Allow access for Serverless 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics1}

Field | Description
--- | ---
enabled | **bool**<br>Configuration setting which enables/disables performance diagnostics service in cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_activity sampling Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_statements sampling Acceptable values are 1 to 86400, inclusive.


### MaintenanceWindow {#MaintenanceWindow1}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow1)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow1)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow1}



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

Creates a PostgreSQL cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create the PostgreSQL cluster in. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the PostgreSQL cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the PostgreSQL cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Required. Deployment environment of the PostgreSQL cluster. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Required. Configuration and resources for hosts that should be created for the PostgreSQL cluster. 
database_specs[] | **[DatabaseSpec](#DatabaseSpec)**<br>Required. Descriptions of databases to be created in the PostgreSQL cluster. 
user_specs[] | **[UserSpec](#UserSpec)**<br>Required. Descriptions of database users to be created in the PostgreSQL cluster. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Required. Individual configurations for hosts that should be created for the PostgreSQL cluster. 
network_id | **string**<br>Required. ID of the network to create the cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL used in the cluster. Possible values: `9.6`, `10`, `10_1c`, `11`, `12`, `13`, `14`, `15` 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>Configuration of a PostgreSQL cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration for a PostgreSQL 9.6 cluster. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration for a PostgreSQL 10 1C cluster. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration for a PostgreSQL 10 cluster. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration for a PostgreSQL 11 cluster. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlConfig11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**<br>Configuration for a PostgreSQL 11 1C cluster. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration for a PostgreSQL 12 cluster. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlConfig12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**<br>Configuration for a PostgreSQL 12 1C cluster. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlConfig13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**<br>Configuration for a PostgreSQL 13 cluster. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlConfig13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**<br>Configuration for a PostgreSQL 13 1C cluster. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlConfig14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**<br>Configuration for a PostgreSQL 14 cluster. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlConfig14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**<br>Configuration for a PostgreSQL 14 1C cluster. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlConfig15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**<br>Configuration for a PostgreSQL 15 cluster. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlConfig15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**<br>Configuration for a PostgreSQL 15 1C cluster. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig2)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources2)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.
access | **[Access](#Access2)**<br>Access policy to DB 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics2)**<br>Configuration of the performance diagnostics service. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig2}

Field | Description
--- | ---
pooling_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Session pooling mode.</li><li>`TRANSACTION`: Transaction pooling mode.</li><li>`STATEMENT`: Statement pooling mode.</li></ul>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Setting `server_reset_query_always` parameter in PgBouncer. 


### Resources {#Resources2}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access2}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-postgresql/operations/web-sql-query) for more details. 
serverless | **bool**<br>Allow access for Serverless 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics2}

Field | Description
--- | ---
enabled | **bool**<br>Configuration setting which enables/disables performance diagnostics service in cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_activity sampling Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_statements sampling Acceptable values are 1 to 86400, inclusive.


### DatabaseSpec {#DatabaseSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the PostgreSQL database. 1-63 characters long. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
owner | **string**<br>Required. Name of the user to be assigned as the owner of the database. To get the list of available PostgreSQL users, make a [UserService.List](./user_service#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
lc_collate | **string**<br>POSIX locale for string sorting order. Can only be set at creation time. Value must match the regular expression ` \|[a-zA-Z_]+.UTF-8\|C `.
lc_ctype | **string**<br>POSIX locale for character classification. Can only be set at creation time. Value must match the regular expression ` \|[a-zA-Z_]+.UTF-8\|C `.
extensions[] | **[Extension](#Extension)**<br>PostgreSQL extensions to be enabled for the database. 
template_db | **string**<br>Name of the PostgreSQL database template. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Deletion Protection inhibits deletion of the database <br>Default value: `unspecified` (inherits cluster's deletion_protection) 


### Extension {#Extension}

Field | Description
--- | ---
name | **string**<br>Name of the extension, e.g. `pg_trgm` or `pg_btree`. Extensions supported by Managed Service for PostgreSQL are [listed in the Developer's Guide](/docs/managed-postgresql/operations/extensions/cluster-extensions). 
version | **string**<br>Version of the extension. 


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the PostgreSQL user. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Required. Password of the PostgreSQL user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission)**<br>Set of permissions to grant to the user to access specific databases. 
conn_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of database connections that should be available to the user. <br>When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the [Cluster.config.postgresql_config_12.effective_config.max_connections](#Cluster2) setting. <br>When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only `N` concurrent connections will be opened, where `N` is the value of the setting. <br>Minimum value: `10` (default: `50`), when used in session pooling. The minimum value is 10.
settings | **[UserSettings](#UserSettings)**<br>PostgreSQL settings for the user. 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>This flag defines whether the user can login to a PostgreSQL database. <br>Default value: `true` (login is allowed). 
grants[] | **string**<br>A set of roles and privileges that are granted to the user. <br>For more information, see [the documentation](/docs/managed-postgresql/operations/grant). The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-zA-Z0-9_]* `.
deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Deletion Protection inhibits deletion of the user <br>Default value: `unspecified` (inherits cluster's deletion_protection) 


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 


### UserSettings {#UserSettings}

Field | Description
--- | ---
default_transaction_isolation | enum **TransactionIsolation**<br>SQL sets an isolation level for each transaction. This setting defines the default isolation level to be set for all new SQL transactions. <br>See in-depth description in [PostgreSQL documentation](https://www.postgresql.org/docs/current/transaction-iso.html). <ul><li>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`: this level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.</li><li>`TRANSACTION_ISOLATION_READ_COMMITTED`: (default) on this level query sees only data committed before the query began.</li><li>`TRANSACTION_ISOLATION_REPEATABLE_READ`: on this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).</li><li>`TRANSACTION_ISOLATION_SERIALIZABLE`: this level provides the strictest transaction isolation. All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction. If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.</li></ul>
lock_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object. If the wait time is longer than the specified amount, then this statement is aborted. <br>Default value: `0` (no control is enforced, a statement waiting time is unlimited). 
log_min_duration_statement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>This setting controls logging of the duration of statements. <br>The duration of each completed statement will be logged if the statement ran for at least the specified amount of time (in milliseconds). E.g., if this setting's value is set to `500`, a statement that took 300 milliseconds to complete will not be logged; on the other hand, the one that took 2000 milliseconds to complete, will be logged. <br>Value of `0` forces PostgreSQL to log the duration of all statements. <br>Value of `-1` (default) disables logging of the duration of statements. <br>See in-depth description in [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). 
synchronous_commit | enum **SynchronousCommit**<br>This setting defines whether DBMS will commit transaction in a synchronous way. <br>When synchronization is enabled, cluster waits for the synchronous operations to be completed prior to reporting `success` to the client. These operations guarantee different levels of the data safety and visibility in the cluster. <br>See in-depth description in [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT). <ul><li>`SYNCHRONOUS_COMMIT_ON`: (default value) success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server.</li><li>`SYNCHRONOUS_COMMIT_OFF`: success is reported to the client even if the data is not in WAL. There is no synchronous write operation, data may be loss in case of storage subsystem failure.</li><li>`SYNCHRONOUS_COMMIT_LOCAL`: success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server. The transaction may be lost due to storage subsystem failure on the master server.</li><li>`SYNCHRONOUS_COMMIT_REMOTE_WRITE`: success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system. The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.</li><li>`SYNCHRONOUS_COMMIT_REMOTE_APPLY`: success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it. The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby.</li></ul>
temp_file_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum storage space size (in kilobytes) that a single process can use to create temporary files. If a transaction exceeds this limit during execution, it will be aborted. <br>A huge query may not fit into a server's RAM, therefore PostgreSQL will use some storage to store and execute such a query. Too big queries can make excessive use of the storage system, effectively making other quieries to run slow. This setting prevents execution of a big queries that can influence other queries by limiting size of temporary files. 
log_statement | enum **LogStatement**<br>This setting specifies which SQL statements should be logged (on the user level). <br>See in-depth description in [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). <ul><li>`LOG_STATEMENT_NONE`: (default) logs none of SQL statements.</li><li>`LOG_STATEMENT_DDL`: logs all data definition statements (such as `CREATE`, `ALTER`, `DROP` and others).</li><li>`LOG_STATEMENT_MOD`: logs all statements that fall in the `LOG_STATEMENT_DDL` category plus data-modifying statements (such as `INSERT`, `UPDATE` and others).</li><li>`LOG_STATEMENT_ALL`: logs all SQL statements.</li></ul>
pool_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in with specified user. <br>See in-depth description in [Odyssey documentation](https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool-string) <ul><li>`SESSION`: (default) server connection will be assigned to it for the whole duration the client stays connected</li><li>`TRANSACTION`: server connection is assigned to a client only during a transaction</li><li>`STATEMENT`: server connection will be put back into the pool immediately after a query completes</li></ul>
prepared_statements_pooling | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>User can use prepared statements with transaction pooling. <br>See in-depth description in [PostgreSQL documentation](https://www.postgresql.org/docs/current/sql-prepare.html) 
catchup_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The connection pooler setting. It determines the maximum allowed replication lag (in seconds). Pooler will reject connections to the replica with a lag above this threshold. It can be useful to prevent application from reading stale data. <br>Default value: 0 <br>Value of `0` disables this mechanism 
wal_sender_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) to wait for WAL replication (can be set only for PostgreSQL 12+) Terminate replication connections that are inactive for longer than this amount of time. <br>Default value: `60000` (60 seconds). <br>Value of `0` disables the timeout mechanism. <br>See in-depth description in [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html) 
idle_in_transaction_session_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum allowed idle time (in milliseconds) between queries, when in a transaction. <br>Values of `0` (default) disables the timeout. <br>See in-depth description in [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html) 
statement_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum time (in milliseconds) to wait for statement The timeout is measured from the time a command arrives at the server until it is completed by the server. <br>If `log_min_error_statement` is set to ERROR or lower, the statement that timed out will also be logged. <br>Value of `0` (default) disables the timeout <br>See in-depth description in [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html) 


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster2). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 
replication_source | **string**<br>[Host.name](#Host) of the host to be used as the replication source (for cascading replication). 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Priority of the host as a replica. A higher value corresponds to higher priority. <br>The host with the highest priority is the synchronous replica. All others are asynchronous. The synchronous replica replaces the master when needed. <br>When a replica becomes the master, its priority is ignored. 
config_spec | **[ConfigHostSpec](#ConfigHostSpec)**<br>Configuration of a PostgreSQL server for the host. 


### ConfigHostSpec {#ConfigHostSpec}

Field | Description
--- | ---
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**<br>Configuration for a host with PostgreSQL 9.6 server deployed. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**<br>Configuration for a host with PostgreSQL 10 1C server deployed. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**<br>Configuration for a host with PostgreSQL 10 server deployed. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**<br>Configuration for a host with PostgreSQL 11 server deployed. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlHostConfig11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11_1c.proto)**<br>Configuration for a host with PostgreSQL 11 1C server deployed. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**<br>Configuration for a host with PostgreSQL 12 server deployed. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlHostConfig12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12_1c.proto)**<br>Configuration for a host with PostgreSQL 12 1C server deployed. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlHostConfig13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13.proto)**<br>Configuration for a host with PostgreSQL 13 server deployed. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlHostConfig13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13_1c.proto)**<br>Configuration for a host with PostgreSQL 13 1C server deployed. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlHostConfig14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14.proto)**<br>Configuration for a host with PostgreSQL 14 server deployed. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlHostConfig14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14_1c.proto)**<br>Configuration for a host with PostgreSQL 14 1C server deployed. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlHostConfig15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15.proto)**<br>Configuration for a host with PostgreSQL 15 server deployed. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlHostConfig15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15_1c.proto)**<br>Configuration for a host with PostgreSQL 15 1C server deployed. 


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
cluster_id | **string**<br>ID of the PostgreSQL cluster that is being created. 


### Cluster {#Cluster2}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow2)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation2)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring2}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the PostgreSQL cluster. 


### ClusterConfig {#ClusterConfig2}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL server software. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>Configuration for PostgreSQL servers in the cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration of a PostgreSQL 9.6 server. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration of a PostgreSQL 10 1C server. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration of a PostgreSQL 10 server. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration of a PostgreSQL 11 server. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlConfigSet11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**<br>Configuration of a PostgreSQL 11 1C server. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration of a PostgreSQL 12 server. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlConfigSet12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**<br>Configuration of a PostgreSQL 12 1C server. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlConfigSet13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**<br>Configuration of a PostgreSQL 13 server. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlConfigSet13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**<br>Configuration of a PostgreSQL 13 1C server. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlConfigSet14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**<br>Configuration of a PostgreSQL 14 server. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlConfigSet14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**<br>Configuration of a PostgreSQL 14 1C server. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlConfigSet15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**<br>Configuration of a PostgreSQL 15 server. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlConfigSet15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**<br>Configuration of a PostgreSQL 15 1C server. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig3)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources3)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.
access | **[Access](#Access3)**<br>Access policy to DB 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics3)**<br>Configuration of the performance diagnostics service. 


### MaintenanceWindow {#MaintenanceWindow2}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow2)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow2)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow2}



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

Updates the specified PostgreSQL cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL Cluster resource to update. To get the PostgreSQL cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the PostgreSQL Cluster resource should be updated. 
description | **string**<br>New description of the PostgreSQL cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". <br>The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get](#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec)**<br>New configuration and resources for hosts in the cluster. 
name | **string**<br>New name for the cluster. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>New maintenance window settings for the cluster. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### ConfigSpec {#ConfigSpec1}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL used in the cluster. Possible values: `9.6`, `10`, `10_1c`, `11`, `12`, `13`, `14`, `15` 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>Configuration of a PostgreSQL cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration for a PostgreSQL 9.6 cluster. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration for a PostgreSQL 10 1C cluster. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration for a PostgreSQL 10 cluster. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration for a PostgreSQL 11 cluster. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlConfig11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**<br>Configuration for a PostgreSQL 11 1C cluster. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration for a PostgreSQL 12 cluster. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlConfig12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**<br>Configuration for a PostgreSQL 12 1C cluster. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlConfig13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**<br>Configuration for a PostgreSQL 13 cluster. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlConfig13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**<br>Configuration for a PostgreSQL 13 1C cluster. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlConfig14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**<br>Configuration for a PostgreSQL 14 cluster. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlConfig14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**<br>Configuration for a PostgreSQL 14 1C cluster. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlConfig15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**<br>Configuration for a PostgreSQL 15 cluster. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlConfig15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**<br>Configuration for a PostgreSQL 15 1C cluster. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig3)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources3)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.
access | **[Access](#Access3)**<br>Access policy to DB 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics3)**<br>Configuration of the performance diagnostics service. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig3}

Field | Description
--- | ---
pooling_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Session pooling mode.</li><li>`TRANSACTION`: Transaction pooling mode.</li><li>`STATEMENT`: Statement pooling mode.</li></ul>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Setting `server_reset_query_always` parameter in PgBouncer. 


### Resources {#Resources3}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access3}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-postgresql/operations/web-sql-query) for more details. 
serverless | **bool**<br>Allow access for Serverless 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics3}

Field | Description
--- | ---
enabled | **bool**<br>Configuration setting which enables/disables performance diagnostics service in cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_activity sampling Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_statements sampling Acceptable values are 1 to 86400, inclusive.


### MaintenanceWindow {#MaintenanceWindow3}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow3)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow3)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow3}



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
cluster_id | **string**<br>ID of the PostgreSQL Cluster resource that is being updated. 


### Cluster {#Cluster3}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig3)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation3)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring3}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the PostgreSQL cluster. 


### ClusterConfig {#ClusterConfig3}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL server software. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>Configuration for PostgreSQL servers in the cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration of a PostgreSQL 9.6 server. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration of a PostgreSQL 10 1C server. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration of a PostgreSQL 10 server. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration of a PostgreSQL 11 server. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlConfigSet11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**<br>Configuration of a PostgreSQL 11 1C server. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration of a PostgreSQL 12 server. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlConfigSet12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**<br>Configuration of a PostgreSQL 12 1C server. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlConfigSet13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**<br>Configuration of a PostgreSQL 13 server. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlConfigSet13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**<br>Configuration of a PostgreSQL 13 1C server. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlConfigSet14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**<br>Configuration of a PostgreSQL 14 server. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlConfigSet14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**<br>Configuration of a PostgreSQL 14 1C server. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlConfigSet15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**<br>Configuration of a PostgreSQL 15 server. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlConfigSet15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**<br>Configuration of a PostgreSQL 15 1C server. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig4)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources4)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.
access | **[Access](#Access4)**<br>Access policy to DB 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics4)**<br>Configuration of the performance diagnostics service. 


### MaintenanceOperation {#MaintenanceOperation3}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## Delete {#Delete}

Deletes the specified PostgreSQL cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to delete. To get the PostgreSQL cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the PostgreSQL cluster that is being deleted. 


## Start {#Start}

Start the specified PostgreSQL cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to start. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the PostgreSQL cluster. 


### Cluster {#Cluster4}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig4)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation4)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring4}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the PostgreSQL cluster. 


### ClusterConfig {#ClusterConfig4}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL server software. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>Configuration for PostgreSQL servers in the cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration of a PostgreSQL 9.6 server. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration of a PostgreSQL 10 1C server. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration of a PostgreSQL 10 server. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration of a PostgreSQL 11 server. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlConfigSet11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**<br>Configuration of a PostgreSQL 11 1C server. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration of a PostgreSQL 12 server. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlConfigSet12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**<br>Configuration of a PostgreSQL 12 1C server. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlConfigSet13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**<br>Configuration of a PostgreSQL 13 server. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlConfigSet13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**<br>Configuration of a PostgreSQL 13 1C server. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlConfigSet14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**<br>Configuration of a PostgreSQL 14 server. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlConfigSet14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**<br>Configuration of a PostgreSQL 14 1C server. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlConfigSet15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**<br>Configuration of a PostgreSQL 15 server. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlConfigSet15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**<br>Configuration of a PostgreSQL 15 1C server. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig4)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources4)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.
access | **[Access](#Access4)**<br>Access policy to DB 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics4)**<br>Configuration of the performance diagnostics service. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig4}

Field | Description
--- | ---
pooling_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Session pooling mode.</li><li>`TRANSACTION`: Transaction pooling mode.</li><li>`STATEMENT`: Statement pooling mode.</li></ul>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Setting `server_reset_query_always` parameter in PgBouncer. 


### Resources {#Resources4}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access4}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-postgresql/operations/web-sql-query) for more details. 
serverless | **bool**<br>Allow access for Serverless 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics4}

Field | Description
--- | ---
enabled | **bool**<br>Configuration setting which enables/disables performance diagnostics service in cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_activity sampling Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_statements sampling Acceptable values are 1 to 86400, inclusive.


### MaintenanceWindow {#MaintenanceWindow4}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow4)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow4)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow4}



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

Stop the specified PostgreSQL cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to stop. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the PostgreSQL cluster. 


### Cluster {#Cluster5}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig5)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow5)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation5)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring5}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the PostgreSQL cluster. 


### ClusterConfig {#ClusterConfig5}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL server software. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>Configuration for PostgreSQL servers in the cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration of a PostgreSQL 9.6 server. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration of a PostgreSQL 10 1C server. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration of a PostgreSQL 10 server. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration of a PostgreSQL 11 server. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlConfigSet11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**<br>Configuration of a PostgreSQL 11 1C server. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration of a PostgreSQL 12 server. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlConfigSet12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**<br>Configuration of a PostgreSQL 12 1C server. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlConfigSet13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**<br>Configuration of a PostgreSQL 13 server. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlConfigSet13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**<br>Configuration of a PostgreSQL 13 1C server. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlConfigSet14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**<br>Configuration of a PostgreSQL 14 server. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlConfigSet14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**<br>Configuration of a PostgreSQL 14 1C server. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlConfigSet15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**<br>Configuration of a PostgreSQL 15 server. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlConfigSet15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**<br>Configuration of a PostgreSQL 15 1C server. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig5)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources5)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.
access | **[Access](#Access5)**<br>Access policy to DB 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics5)**<br>Configuration of the performance diagnostics service. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig5}

Field | Description
--- | ---
pooling_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Session pooling mode.</li><li>`TRANSACTION`: Transaction pooling mode.</li><li>`STATEMENT`: Statement pooling mode.</li></ul>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Setting `server_reset_query_always` parameter in PgBouncer. 


### Resources {#Resources5}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access5}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-postgresql/operations/web-sql-query) for more details. 
serverless | **bool**<br>Allow access for Serverless 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics5}

Field | Description
--- | ---
enabled | **bool**<br>Configuration setting which enables/disables performance diagnostics service in cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_activity sampling Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_statements sampling Acceptable values are 1 to 86400, inclusive.


### MaintenanceWindow {#MaintenanceWindow5}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow5)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow5)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow5}



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

Moves the specified PostgreSQL cluster to the specified folder.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### MoveClusterRequest {#MoveClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to move. The maximum string length in characters is 50.
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
cluster_id | **string**<br>ID of the PostgreSQL cluster being moved. 
source_folder_id | **string**<br>ID of the source folder. 
destination_folder_id | **string**<br>ID of the destnation folder. 


### Cluster {#Cluster6}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring6)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig6)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow6)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation6)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring6}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the PostgreSQL cluster. 


### ClusterConfig {#ClusterConfig6}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL server software. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>Configuration for PostgreSQL servers in the cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration of a PostgreSQL 9.6 server. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration of a PostgreSQL 10 1C server. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration of a PostgreSQL 10 server. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration of a PostgreSQL 11 server. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlConfigSet11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**<br>Configuration of a PostgreSQL 11 1C server. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration of a PostgreSQL 12 server. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlConfigSet12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**<br>Configuration of a PostgreSQL 12 1C server. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlConfigSet13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**<br>Configuration of a PostgreSQL 13 server. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlConfigSet13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**<br>Configuration of a PostgreSQL 13 1C server. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlConfigSet14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**<br>Configuration of a PostgreSQL 14 server. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlConfigSet14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**<br>Configuration of a PostgreSQL 14 1C server. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlConfigSet15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**<br>Configuration of a PostgreSQL 15 server. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlConfigSet15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**<br>Configuration of a PostgreSQL 15 1C server. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig6)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources6)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.
access | **[Access](#Access6)**<br>Access policy to DB 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics6)**<br>Configuration of the performance diagnostics service. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig6}

Field | Description
--- | ---
pooling_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Session pooling mode.</li><li>`TRANSACTION`: Transaction pooling mode.</li><li>`STATEMENT`: Statement pooling mode.</li></ul>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Setting `server_reset_query_always` parameter in PgBouncer. 


### Resources {#Resources6}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access6}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-postgresql/operations/web-sql-query) for more details. 
serverless | **bool**<br>Allow access for Serverless 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics6}

Field | Description
--- | ---
enabled | **bool**<br>Configuration setting which enables/disables performance diagnostics service in cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_activity sampling Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_statements sampling Acceptable values are 1 to 86400, inclusive.


### MaintenanceWindow {#MaintenanceWindow6}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow6)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow6)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow6}



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

Creates a backup for the specified PostgreSQL cluster.

**rpc Backup ([BackupClusterRequest](#BackupClusterRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupClusterMetadata](#BackupClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster7)<br>

### BackupClusterRequest {#BackupClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to back up. To get the PostgreSQL cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the PostgreSQL cluster that is being backed up. 
backup_id | **string**<br>ID of the PostgreSQL backup that is being created. 


### Cluster {#Cluster7}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring7)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig7)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow7)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation7)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring7}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the PostgreSQL cluster. 


### ClusterConfig {#ClusterConfig7}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL server software. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>Configuration for PostgreSQL servers in the cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration of a PostgreSQL 9.6 server. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration of a PostgreSQL 10 1C server. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration of a PostgreSQL 10 server. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration of a PostgreSQL 11 server. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlConfigSet11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**<br>Configuration of a PostgreSQL 11 1C server. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration of a PostgreSQL 12 server. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlConfigSet12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**<br>Configuration of a PostgreSQL 12 1C server. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlConfigSet13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**<br>Configuration of a PostgreSQL 13 server. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlConfigSet13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**<br>Configuration of a PostgreSQL 13 1C server. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlConfigSet14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**<br>Configuration of a PostgreSQL 14 server. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlConfigSet14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**<br>Configuration of a PostgreSQL 14 1C server. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlConfigSet15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**<br>Configuration of a PostgreSQL 15 server. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlConfigSet15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**<br>Configuration of a PostgreSQL 15 1C server. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig7)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources7)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.
access | **[Access](#Access7)**<br>Access policy to DB 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics7)**<br>Configuration of the performance diagnostics service. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig7}

Field | Description
--- | ---
pooling_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Session pooling mode.</li><li>`TRANSACTION`: Transaction pooling mode.</li><li>`STATEMENT`: Statement pooling mode.</li></ul>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Setting `server_reset_query_always` parameter in PgBouncer. 


### Resources {#Resources7}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access7}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-postgresql/operations/web-sql-query) for more details. 
serverless | **bool**<br>Allow access for Serverless 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics7}

Field | Description
--- | ---
enabled | **bool**<br>Configuration setting which enables/disables performance diagnostics service in cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_activity sampling Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_statements sampling Acceptable values are 1 to 86400, inclusive.


### MaintenanceWindow {#MaintenanceWindow7}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow7)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow7)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow7}



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

Creates a new PostgreSQL cluster using the specified backup.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster8)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. ID of the backup to create a cluster from. To get the backup ID, use a [ClusterService.ListBackups](#ListBackups) request. 
time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the moment to which the PostgreSQL cluster should be restored. 
time_inclusive | **bool**<br>Flag that indicates whether a database should be restored to the first backup point available just after the timestamp specified in the `time` field instead of just before. <br>Possible values: <ul><li>false (default) - the restore point refers to the first backup moment before `time`. </li><li>true - the restore point refers to the first backup point after `time`.</li></ul> 
name | **string**<br>Required. Name of the new PostgreSQL cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the new PostgreSQL cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster8)**<br>Deployment environment of the new PostgreSQL cluster. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Configuration for the PostgreSQL cluster to be created. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Configurations for PostgreSQL hosts that should be created for the cluster that is being created from the backup. The number of elements must be greater than 0.
network_id | **string**<br>Required. ID of the network to create the PostgreSQL cluster in. The maximum string length in characters is 50.
folder_id | **string**<br>ID of the folder to create the PostgreSQL cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### ConfigSpec {#ConfigSpec2}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL used in the cluster. Possible values: `9.6`, `10`, `10_1c`, `11`, `12`, `13`, `14`, `15` 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>Configuration of a PostgreSQL cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration for a PostgreSQL 9.6 cluster. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration for a PostgreSQL 10 1C cluster. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration for a PostgreSQL 10 cluster. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration for a PostgreSQL 11 cluster. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlConfig11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**<br>Configuration for a PostgreSQL 11 1C cluster. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration for a PostgreSQL 12 cluster. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlConfig12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**<br>Configuration for a PostgreSQL 12 1C cluster. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlConfig13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**<br>Configuration for a PostgreSQL 13 cluster. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlConfig13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**<br>Configuration for a PostgreSQL 13 1C cluster. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlConfig14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**<br>Configuration for a PostgreSQL 14 cluster. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlConfig14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**<br>Configuration for a PostgreSQL 14 1C cluster. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlConfig15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**<br>Configuration for a PostgreSQL 15 cluster. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlConfig15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**<br>Configuration for a PostgreSQL 15 1C cluster. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig8)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources8)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.
access | **[Access](#Access8)**<br>Access policy to DB 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics8)**<br>Configuration of the performance diagnostics service. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig8}

Field | Description
--- | ---
pooling_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Session pooling mode.</li><li>`TRANSACTION`: Transaction pooling mode.</li><li>`STATEMENT`: Statement pooling mode.</li></ul>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Setting `server_reset_query_always` parameter in PgBouncer. 


### Resources {#Resources8}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access8}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-postgresql/operations/web-sql-query) for more details. 
serverless | **bool**<br>Allow access for Serverless 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics8}

Field | Description
--- | ---
enabled | **bool**<br>Configuration setting which enables/disables performance diagnostics service in cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_activity sampling Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_statements sampling Acceptable values are 1 to 86400, inclusive.


### HostSpec {#HostSpec1}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster8). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 
replication_source | **string**<br>[Host.name](#Host) of the host to be used as the replication source (for cascading replication). 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Priority of the host as a replica. A higher value corresponds to higher priority. <br>The host with the highest priority is the synchronous replica. All others are asynchronous. The synchronous replica replaces the master when needed. <br>When a replica becomes the master, its priority is ignored. 
config_spec | **[ConfigHostSpec](#ConfigHostSpec)**<br>Configuration of a PostgreSQL server for the host. 


### ConfigHostSpec {#ConfigHostSpec1}

Field | Description
--- | ---
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**<br>Configuration for a host with PostgreSQL 9.6 server deployed. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**<br>Configuration for a host with PostgreSQL 10 1C server deployed. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**<br>Configuration for a host with PostgreSQL 10 server deployed. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**<br>Configuration for a host with PostgreSQL 11 server deployed. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlHostConfig11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11_1c.proto)**<br>Configuration for a host with PostgreSQL 11 1C server deployed. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**<br>Configuration for a host with PostgreSQL 12 server deployed. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlHostConfig12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12_1c.proto)**<br>Configuration for a host with PostgreSQL 12 1C server deployed. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlHostConfig13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13.proto)**<br>Configuration for a host with PostgreSQL 13 server deployed. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlHostConfig13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13_1c.proto)**<br>Configuration for a host with PostgreSQL 13 1C server deployed. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlHostConfig14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14.proto)**<br>Configuration for a host with PostgreSQL 14 server deployed. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlHostConfig14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14_1c.proto)**<br>Configuration for a host with PostgreSQL 14 1C server deployed. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlHostConfig15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15.proto)**<br>Configuration for a host with PostgreSQL 15 server deployed. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlHostConfig15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15_1c.proto)**<br>Configuration for a host with PostgreSQL 15 1C server deployed. 


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
cluster_id | **string**<br>ID of the new PostgreSQL cluster that is being created from a backup. 
backup_id | **string**<br>ID of the backup that is being used for creating a cluster. 


### Cluster {#Cluster8}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring8)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig8)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow8)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation8)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring8}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the PostgreSQL cluster. 


### ClusterConfig {#ClusterConfig8}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL server software. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>Configuration for PostgreSQL servers in the cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration of a PostgreSQL 9.6 server. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration of a PostgreSQL 10 1C server. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration of a PostgreSQL 10 server. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration of a PostgreSQL 11 server. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlConfigSet11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**<br>Configuration of a PostgreSQL 11 1C server. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration of a PostgreSQL 12 server. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlConfigSet12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**<br>Configuration of a PostgreSQL 12 1C server. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlConfigSet13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**<br>Configuration of a PostgreSQL 13 server. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlConfigSet13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**<br>Configuration of a PostgreSQL 13 1C server. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlConfigSet14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**<br>Configuration of a PostgreSQL 14 server. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlConfigSet14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**<br>Configuration of a PostgreSQL 14 1C server. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlConfigSet15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**<br>Configuration of a PostgreSQL 15 server. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlConfigSet15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**<br>Configuration of a PostgreSQL 15 1C server. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig9)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources9)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.
access | **[Access](#Access9)**<br>Access policy to DB 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics9)**<br>Configuration of the performance diagnostics service. 


### MaintenanceWindow {#MaintenanceWindow8}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow8)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow8)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow8}



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
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to reschedule the maintenance operation for. The maximum string length in characters is 50.
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
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster. 
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. The time until which this maintenance operation is to be delayed. 


### Cluster {#Cluster9}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring9)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig9)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow9)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation9)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring9}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the PostgreSQL cluster. 


### ClusterConfig {#ClusterConfig9}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL server software. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>Configuration for PostgreSQL servers in the cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration of a PostgreSQL 9.6 server. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration of a PostgreSQL 10 1C server. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration of a PostgreSQL 10 server. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration of a PostgreSQL 11 server. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlConfigSet11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**<br>Configuration of a PostgreSQL 11 1C server. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration of a PostgreSQL 12 server. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlConfigSet12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**<br>Configuration of a PostgreSQL 12 1C server. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlConfigSet13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**<br>Configuration of a PostgreSQL 13 server. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlConfigSet13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**<br>Configuration of a PostgreSQL 13 1C server. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlConfigSet14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**<br>Configuration of a PostgreSQL 14 server. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlConfigSet14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**<br>Configuration of a PostgreSQL 14 1C server. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlConfigSet15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**<br>Configuration of a PostgreSQL 15 server. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlConfigSet15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**<br>Configuration of a PostgreSQL 15 1C server. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig9)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources9)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.
access | **[Access](#Access9)**<br>Access policy to DB 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics9)**<br>Configuration of the performance diagnostics service. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig9}

Field | Description
--- | ---
pooling_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Session pooling mode.</li><li>`TRANSACTION`: Transaction pooling mode.</li><li>`STATEMENT`: Statement pooling mode.</li></ul>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Setting `server_reset_query_always` parameter in PgBouncer. 


### Resources {#Resources9}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access9}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-postgresql/operations/web-sql-query) for more details. 
serverless | **bool**<br>Allow access for Serverless 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics9}

Field | Description
--- | ---
enabled | **bool**<br>Configuration setting which enables/disables performance diagnostics service in cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_activity sampling Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_statements sampling Acceptable values are 1 to 86400, inclusive.


### MaintenanceWindow {#MaintenanceWindow9}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow9)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow9)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow9}



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

Start a manual failover on the specified PostgreSQL cluster.

**rpc StartFailover ([StartClusterFailoverRequest](#StartClusterFailoverRequest)) returns ([operation.Operation](#Operation9))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterFailoverMetadata](#StartClusterFailoverMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster10)<br>

### StartClusterFailoverRequest {#StartClusterFailoverRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of PostgreSQL cluster. The maximum string length in characters is 50.
host_name | **string**<br>New master host. Switch to the most up-to-date replica if not provided. The maximum string length in characters is 253.


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
cluster_id | **string**<br>ID of the PostgreSQL cluster being failovered. 


### Cluster {#Cluster10}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring10)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig10)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow10)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation10)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring10}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the PostgreSQL cluster. 


### ClusterConfig {#ClusterConfig10}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL server software. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>Configuration for PostgreSQL servers in the cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration of a PostgreSQL 9.6 server. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration of a PostgreSQL 10 1C server. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration of a PostgreSQL 10 server. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration of a PostgreSQL 11 server. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlConfigSet11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**<br>Configuration of a PostgreSQL 11 1C server. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration of a PostgreSQL 12 server. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlConfigSet12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**<br>Configuration of a PostgreSQL 12 1C server. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlConfigSet13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**<br>Configuration of a PostgreSQL 13 server. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlConfigSet13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**<br>Configuration of a PostgreSQL 13 1C server. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlConfigSet14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**<br>Configuration of a PostgreSQL 14 server. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlConfigSet14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**<br>Configuration of a PostgreSQL 14 1C server. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlConfigSet15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**<br>Configuration of a PostgreSQL 15 server. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlConfigSet15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**<br>Configuration of a PostgreSQL 15 1C server. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig10)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources10)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.
access | **[Access](#Access10)**<br>Access policy to DB 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics10)**<br>Configuration of the performance diagnostics service. 


### ConnectionPoolerConfig {#ConnectionPoolerConfig10}

Field | Description
--- | ---
pooling_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Session pooling mode.</li><li>`TRANSACTION`: Transaction pooling mode.</li><li>`STATEMENT`: Statement pooling mode.</li></ul>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Setting `server_reset_query_always` parameter in PgBouncer. 


### Resources {#Resources10}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Access {#Access10}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the management console. <br>See [SQL queries in the management console](/docs/managed-postgresql/operations/web-sql-query) for more details. 
serverless | **bool**<br>Allow access for Serverless 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics10}

Field | Description
--- | ---
enabled | **bool**<br>Configuration setting which enables/disables performance diagnostics service in cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_activity sampling Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for pg_stat_statements sampling Acceptable values are 1 to 86400, inclusive.


### MaintenanceWindow {#MaintenanceWindow10}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>The maintenance policy in effect.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow10)**<br>Maintenance operation can be scheduled anytime. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow10)**<br>Maintenance operation can be scheduled on a weekly basis. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow10}



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

Retrieves logs for the specified PostgreSQL cluster.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to request logs for. To get the PostgreSQL cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from the logs table to request. If no columns are specified, entire log records are returned. 
service_type | enum **ServiceType**<br>Type of the service to request logs about. <ul><li>`POSTGRESQL`: Logs of PostgreSQL activity.</li><li>`POOLER`: Logs of connection pooler activity.</li></ul>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) returned by the previous list request. The maximum string length in characters is 100.
always_next_page_token | **bool**<br>Always return `next_page_token`, even if current page is empty. 


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
cluster_id | **string**<br>Required. Required. ID of the PostgreSQL cluster. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from logs table to get in the response. 
service_type | enum **ServiceType**<br> <ul><li>`POSTGRESQL`: Logs of PostgreSQL activity.</li><li>`POOLER`: Logs of connection pooler activity.</li></ul>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request. If this field is not set, all existing logs will be sent and then the new ones as they appear. In essence it has 'tail -f' semantics. 
record_token | **string**<br>Record token. Set `record_token` to the `next_record_token` returned by a previous StreamLogs request to start streaming from next log record. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname](#LogRecord), </li></ol>[LogRecord.logs.message.error_severity](#LogRecord)(for POSTGRESQL service), [LogRecord.logs.message.level](#LogRecord)(for POOLER service) fields. <ol><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-z0-9.-]{1,61}`. </li></ol>Examples of a filter: `message.hostname='node1.db.cloud.yandex.net'` `message.error_severity IN ("ERROR", "FATAL", "PANIC") AND message.hostname = "node1.db.cloud.yandex.net"` The maximum string length in characters is 1000.


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

Retrieves the list of Operation resources for the specified cluster.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL Cluster resource to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation10)**<br>List of Operation resources for the specified PostgreSQL cluster. 
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

Retrieves the list of available backups for the specified PostgreSQL cluster.

**rpc ListBackups ([ListClusterBackupsRequest](#ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#ListClusterBackupsResponse))**

### ListClusterBackupsRequest {#ListClusterBackupsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster. To get the PostgreSQL cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterBackupsResponse {#ListClusterBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup)**<br>List of PostgreSQL Backup resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterBackupsRequest.page_size](#ListClusterBackupsRequest), use the `next_page_token` as the value for the [ListClusterBackupsRequest.page_token](#ListClusterBackupsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>Required. ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format (i.e. when the backup operation was completed). 
source_cluster_id | **string**<br>ID of the PostgreSQL cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was started. 
size | **int64**<br>Size of backup, in bytes 
type | enum **BackupCreationType**<br>How this backup was created (manual/automatic/etc...) <ul><li>`AUTOMATED`: Backup created by automated daily schedule</li><li>`MANUAL`: Backup created by user request</li></ul>
method | enum **BackupMethod**<br>Method of backup creation <ul><li>`BASE`: Base backup</li><li>`INCREMENTAL`: Delta (incremental) PostgreSQL backup</li></ul>
journal_size | **int64**<br>Size of the journal associated with backup, in bytes 


## ListHosts {#ListHosts}

Retrieves a list of hosts for the specified cluster.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster. To get the PostgreSQL cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](#Host)**<br>List of Host resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
name | **string**<br>Name of the PostgreSQL host. The host name is assigned by MDB at creation time, and cannot be changed. 1-63 characters long. <br>The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. 
cluster_id | **string**<br>ID of the PostgreSQL host. The ID is assigned by MDB at creation time. 
zone_id | **string**<br>ID of the availability zone where the PostgreSQL host resides. 
resources | **[Resources](#Resources11)**<br>Resources allocated to the PostgreSQL host. 
role | enum **Role**<br>Role of the host in the cluster. <ul><li>`ROLE_UNKNOWN`: Role of the host in the cluster is unknown.</li><li>`MASTER`: Host is the master PostgreSQL server in the cluster.</li><li>`REPLICA`: Host is a replica (standby) PostgreSQL server in the cluster.</li></ul>
health | enum **Health**<br>Status code of the aggregated health of the host. <ul><li>`HEALTH_UNKNOWN`: Health of the host is unknown.</li><li>`ALIVE`: The host is performing all its functions normally.</li><li>`DEAD`: The host is inoperable, and cannot perform any of its essential functions.</li><li>`DEGRADED`: The host is degraded, and can perform only some of its essential functions.</li><li>`READONLY`: The host is alive, but in read-only mode.</li></ul>
services[] | **[Service](#Service)**<br>Services provided by the host. 
subnet_id | **string**<br>ID of the subnet that the host belongs to. 
replication_source | **string**<br>Name of the host to be used as the replication source for cascading replication. 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Priority of the host as a replica. Higher value means higher priority. <br>The host with the highest priority is the synchronous replica. All others are asynchronous. The synchronous replica replaces the master when needed. <br>When a replica becomes the master, its priority is ignored. 
config | **[HostConfig](#HostConfig)**<br>Configuration of a PostgreSQL server for the host. 
assign_public_ip | **bool**<br>Flag showing public IP assignment status to this host. 
replica_type | enum **ReplicaType**<br> 


### Resources {#Resources11}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Service {#Service}

Field | Description
--- | ---
type | enum **Type**<br>Type of the service provided by the host. <ul><li>`POSTGRESQL`: The host is a PostgreSQL server.</li><li>`POOLER`: The host is a PgBouncer server.</li></ul>
health | enum **Health**<br>Status code of server availability. <ul><li>`HEALTH_UNKNOWN`: Health of the server is unknown.</li><li>`ALIVE`: The server is working normally.</li><li>`DEAD`: The server is dead or unresponsive.</li><li>`READONLY`: The server is in read-only mode.</li></ul>


### HostConfig {#HostConfig}

Field | Description
--- | ---
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>Configuration of a PostgreSQL server for the host.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**<br>Configuration for a host with PostgreSQL 9.6 server deployed. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**<br>Configuration for a host with PostgreSQL 10 1C server deployed. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**<br>Configuration for a host with PostgreSQL 10 server deployed. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**<br>Configuration for a host with PostgreSQL 11 server deployed. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlHostConfig11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11_1c.proto)**<br>Configuration for a host with PostgreSQL 11 1C server deployed. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**<br>Configuration for a host with PostgreSQL 12 server deployed. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlHostConfig12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12_1c.proto)**<br>Configuration for a host with PostgreSQL 12 1C server deployed. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlHostConfig13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13.proto)**<br>Configuration for a host with PostgreSQL 13 server deployed. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlHostConfig13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13_1c.proto)**<br>Configuration for a host with PostgreSQL 13 1C server deployed. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlHostConfig14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14.proto)**<br>Configuration for a host with PostgreSQL 14 server deployed. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlHostConfig14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14_1c.proto)**<br>Configuration for a host with PostgreSQL 14 1C server deployed. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlHostConfig15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15.proto)**<br>Configuration for a host with PostgreSQL 15 server deployed. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlHostConfig15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15_1c.proto)**<br>Configuration for a host with PostgreSQL 15 1C server deployed. 


## AddHosts {#AddHosts}

Creates new hosts for a cluster.

**rpc AddHosts ([AddClusterHostsRequest](#AddClusterHostsRequest)) returns ([operation.Operation](#Operation11))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterHostsMetadata](#AddClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddClusterHostsRequest {#AddClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to add hosts to. To get the PostgreSQL cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
host_specs[] | **[HostSpec](#HostSpec)**<br>Configurations for PostgreSQL hosts that should be added to the cluster. The number of elements must be greater than 0.


### HostSpec {#HostSpec2}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster11). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 
replication_source | **string**<br>[Host.name](#Host1) of the host to be used as the replication source (for cascading replication). 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Priority of the host as a replica. A higher value corresponds to higher priority. <br>The host with the highest priority is the synchronous replica. All others are asynchronous. The synchronous replica replaces the master when needed. <br>When a replica becomes the master, its priority is ignored. 
config_spec | **[ConfigHostSpec](#ConfigHostSpec)**<br>Configuration of a PostgreSQL server for the host. 


### ConfigHostSpec {#ConfigHostSpec2}

Field | Description
--- | ---
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**<br>Configuration for a host with PostgreSQL 9.6 server deployed. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**<br>Configuration for a host with PostgreSQL 10 1C server deployed. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**<br>Configuration for a host with PostgreSQL 10 server deployed. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**<br>Configuration for a host with PostgreSQL 11 server deployed. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlHostConfig11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11_1c.proto)**<br>Configuration for a host with PostgreSQL 11 1C server deployed. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**<br>Configuration for a host with PostgreSQL 12 server deployed. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlHostConfig12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12_1c.proto)**<br>Configuration for a host with PostgreSQL 12 1C server deployed. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlHostConfig13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13.proto)**<br>Configuration for a host with PostgreSQL 13 server deployed. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlHostConfig13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13_1c.proto)**<br>Configuration for a host with PostgreSQL 13 1C server deployed. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlHostConfig14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14.proto)**<br>Configuration for a host with PostgreSQL 14 server deployed. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlHostConfig14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14_1c.proto)**<br>Configuration for a host with PostgreSQL 14 1C server deployed. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlHostConfig15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15.proto)**<br>Configuration for a host with PostgreSQL 15 server deployed. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlHostConfig15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15_1c.proto)**<br>Configuration for a host with PostgreSQL 15 1C server deployed. 


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
cluster_id | **string**<br>ID of the PostgreSQL cluster to which the hosts are being added. 
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
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to remove hosts from. To get the PostgreSQL cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
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
cluster_id | **string**<br>ID of the PostgreSQL cluster to remove hosts from. 
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
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to update hosts in. To get the PostgreSQL cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_host_specs[] | **[UpdateHostSpec](#UpdateHostSpec)**<br>New configurations to apply to hosts. The number of elements must be greater than 0.


### UpdateHostSpec {#UpdateHostSpec}

Field | Description
--- | ---
host_name | **string**<br>Required. Name of the host to update. To get the PostgreSQL host name, use a [ClusterService.ListHosts](#ListHosts) request. 
replication_source | **string**<br>[Host.name](#Host1) of the host to be used as the replication source (for cascading replication). To get the PostgreSQL host name, use a [ClusterService.ListHosts](#ListHosts) request. 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The host with the highest priority is the synchronous replica. All others are asynchronous. The synchronous replica replaces the master when needed. <br>When a replica becomes the master, its priority is ignored. 
config_spec | **[ConfigHostSpec](#ConfigHostSpec)**<br>Configuration of a PostgreSQL server for the host. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the PostgreSQL host should be updated. 
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. 


### ConfigHostSpec {#ConfigHostSpec3}

Field | Description
--- | ---
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15` or `postgresql_config_15_1c`<br>
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**<br>Configuration for a host with PostgreSQL 9.6 server deployed. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**<br>Configuration for a host with PostgreSQL 10 1C server deployed. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**<br>Configuration for a host with PostgreSQL 10 server deployed. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**<br>Configuration for a host with PostgreSQL 11 server deployed. 
&nbsp;&nbsp;postgresql_config_11_1c | **[PostgresqlHostConfig11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11_1c.proto)**<br>Configuration for a host with PostgreSQL 11 1C server deployed. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**<br>Configuration for a host with PostgreSQL 12 server deployed. 
&nbsp;&nbsp;postgresql_config_12_1c | **[PostgresqlHostConfig12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12_1c.proto)**<br>Configuration for a host with PostgreSQL 12 1C server deployed. 
&nbsp;&nbsp;postgresql_config_13 | **[PostgresqlHostConfig13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13.proto)**<br>Configuration for a host with PostgreSQL 13 server deployed. 
&nbsp;&nbsp;postgresql_config_13_1c | **[PostgresqlHostConfig13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13_1c.proto)**<br>Configuration for a host with PostgreSQL 13 1C server deployed. 
&nbsp;&nbsp;postgresql_config_14 | **[PostgresqlHostConfig14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14.proto)**<br>Configuration for a host with PostgreSQL 14 server deployed. 
&nbsp;&nbsp;postgresql_config_14_1c | **[PostgresqlHostConfig14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14_1c.proto)**<br>Configuration for a host with PostgreSQL 14 1C server deployed. 
&nbsp;&nbsp;postgresql_config_15 | **[PostgresqlHostConfig15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15.proto)**<br>Configuration for a host with PostgreSQL 15 server deployed. 
&nbsp;&nbsp;postgresql_config_15_1c | **[PostgresqlHostConfig15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15_1c.proto)**<br>Configuration for a host with PostgreSQL 15 1C server deployed. 


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
cluster_id | **string**<br>ID of the PostgreSQL cluster to update hosts in. 
host_names[] | **string**<br>Names of hosts that are being updated. 


