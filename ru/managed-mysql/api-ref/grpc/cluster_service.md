---
editable: false
sourcePath: en/_api-ref-grpc/managed-mysql/api-ref/grpc/cluster_service.md
---

# Managed Service for MySQL API, gRPC: ClusterService

A set of methods for managing MySQL clusters.

| Call | Description |
| --- | --- |
| [Get](#Get) | Retrieves information about a cluster. |
| [List](#List) | Retrieves the list of clusters in a folder. |
| [Create](#Create) | Creates a cluster in a folder. |
| [Update](#Update) | Updates a cluster. |
| [Delete](#Delete) | Deletes a cluster. |
| [Start](#Start) | Starts a cluster. |
| [Stop](#Stop) | Stops a cluster. |
| [Move](#Move) | Moves a cluster to a folder. |
| [Backup](#Backup) | Creates a backup for a cluster. |
| [Restore](#Restore) | Restores a backup to a new cluster. |
| [RescheduleMaintenance](#RescheduleMaintenance) | Reschedules planned maintenance operation. |
| [StartFailover](#StartFailover) | Starts a manual failover for a cluster. |
| [ListLogs](#ListLogs) | Retrieves logs for a cluster. |
| [StreamLogs](#StreamLogs) | Retrieves a log stream for a cluster. |
| [ListOperations](#ListOperations) | Retrieves a list of operations for a cluster. |
| [ListBackups](#ListBackups) | Retrieves a list of backups for a cluster. |
| [ListHosts](#ListHosts) | Retrieves a list of hosts for a cluster. |
| [AddHosts](#AddHosts) | Adds new hosts in a cluster. |
| [UpdateHosts](#UpdateHosts) | Updates the specified hosts. |
| [DeleteHosts](#DeleteHosts) | Deletes the specified hosts for a cluster. |

## Calls ClusterService {#calls}

## Get {#Get}

Retrieves information about a cluster.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to return information about. <br>To get this ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. <br>This ID is assigned by the platform at the time of creation. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp of the cluster. 
name | **string**<br>Name of the cluster. 
description | **string**<br>Description of the cluster. 
labels | **map<string,string>**<br>Custom labels for the cluster as `key:value` pairs. 
environment | enum **Environment**<br>Deployment environment of the cluster. <ul><li>`PRODUCTION`: Environment for stable versions of your apps. A conservative update policy is in effect: only bug fixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment for testing, including the Managed Service for MySQL itself. This environment gets new features, improvements, and bug fixes in the first place, compared to the production environment. However, not every update ensures backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring)**<br>Monitoring systems data that is relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig)**<br>Configuration of the cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated health of the cluster. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is degraded ([Host.health](#Host) for at least one host in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow)**<br>Maintenance window settings for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>Effective list of security group IDs applied to the cluster. 
deletion_protection | **bool**<br>This option prevents unintended deletion of the cluster. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the cluster. 


### ClusterConfig {#ClusterConfig}

Field | Description
--- | ---
version | **string**<br>Version of MySQL used in the cluster. 
mysql_config | **oneof:** `mysql_config_5_7` or `mysql_config_8_0`<br>Cluster-wide MySQL configuration.
&nbsp;&nbsp;mysql_config_5_7 | **[config.MysqlConfigSet5_7](#MysqlConfigSet5_7)**<br>Configuration of a MySQL 5.7 server. 
&nbsp;&nbsp;mysql_config_8_0 | **[config.MysqlConfigSet8_0](#MysqlConfigSet8_0)**<br>Configuration of a MySQL 8.0 server. 
resources | **[Resources](#Resources)**<br>Resource preset for the cluster hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access)**<br>Access policy for external services. 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics)**<br>Configuration of the performance diagnostics service. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. <br>All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage (for each cluster host, in bytes). 
disk_type_id | **string**<br>Type of the storage. <br>Possible values: <ul><li>`network-hdd` - standard network storage </li><li>`network-ssd` - fast network storage </li><li>`network-ssd-nonreplicated` - fast network nonreplicated storage </li><li>`local-ssd` - fast local storage. </li></ul><br>See [the documentation](/docs/managed-mysql/concepts/storage) for details. 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access from DataLens. <br>See [the documentation](/docs/managed-mysql/operations/datalens-connect) for details. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from management console. <br>See [the documentation](/docs/managed-mysql/operations/web-sql-query) for details. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics}

Field | Description
--- | ---
enabled | **bool**<br>Flag that shows if performance statistics gathering is enabled for the cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for `my_session` sampling. Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for `my_statements` sampling. Acceptable values are 1 to 86400, inclusive.


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

Retrieves the list of clusters in a folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list clusters in. <br>To get this ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the API returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in the subsequent [ClusterService.List](#List) requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token that can be used to iterate through multiple pages of results. <br>To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by the previous [ClusterService.List](#List) request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that selects clusters listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can only use filtering with the [Cluster.name](#Cluster1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`.</li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of clusters. 
next_page_token | **string**<br>The token that can be used to get the next page of results. <br>If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest) in the subsequent [ClusterService.List](#List) request to iterate through multiple pages of results. <br>Each of the subsequent [ClusterService.List](#List) requests should use the `next_page_token` value returned by the previous request to continue paging through the results. 


### Cluster {#Cluster1}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. <br>This ID is assigned by the platform at the time of creation. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp of the cluster. 
name | **string**<br>Name of the cluster. 
description | **string**<br>Description of the cluster. 
labels | **map<string,string>**<br>Custom labels for the cluster as `key:value` pairs. 
environment | enum **Environment**<br>Deployment environment of the cluster. <ul><li>`PRODUCTION`: Environment for stable versions of your apps. A conservative update policy is in effect: only bug fixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment for testing, including the Managed Service for MySQL itself. This environment gets new features, improvements, and bug fixes in the first place, compared to the production environment. However, not every update ensures backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Monitoring systems data that is relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Configuration of the cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated health of the cluster. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is degraded ([Host.health](#Host) for at least one host in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow1)**<br>Maintenance window settings for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation1)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>Effective list of security group IDs applied to the cluster. 
deletion_protection | **bool**<br>This option prevents unintended deletion of the cluster. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring1}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the cluster. 


### ClusterConfig {#ClusterConfig1}

Field | Description
--- | ---
version | **string**<br>Version of MySQL used in the cluster. 
mysql_config | **oneof:** `mysql_config_5_7` or `mysql_config_8_0`<br>Cluster-wide MySQL configuration.
&nbsp;&nbsp;mysql_config_5_7 | **[config.MysqlConfigSet5_7](#MysqlConfigSet5_7)**<br>Configuration of a MySQL 5.7 server. 
&nbsp;&nbsp;mysql_config_8_0 | **[config.MysqlConfigSet8_0](#MysqlConfigSet8_0)**<br>Configuration of a MySQL 8.0 server. 
resources | **[Resources](#Resources1)**<br>Resource preset for the cluster hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access1)**<br>Access policy for external services. 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics1)**<br>Configuration of the performance diagnostics service. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.


### Resources {#Resources1}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. <br>All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage (for each cluster host, in bytes). 
disk_type_id | **string**<br>Type of the storage. <br>Possible values: <ul><li>`network-hdd` - standard network storage </li><li>`network-ssd` - fast network storage </li><li>`network-ssd-nonreplicated` - fast network nonreplicated storage </li><li>`local-ssd` - fast local storage. </li></ul><br>See [the documentation](/docs/managed-mysql/concepts/storage) for details. 


### Access {#Access1}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access from DataLens. <br>See [the documentation](/docs/managed-mysql/operations/datalens-connect) for details. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from management console. <br>See [the documentation](/docs/managed-mysql/operations/web-sql-query) for details. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics1}

Field | Description
--- | ---
enabled | **bool**<br>Flag that shows if performance statistics gathering is enabled for the cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for `my_session` sampling. Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for `my_statements` sampling. Acceptable values are 1 to 86400, inclusive.


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

Creates a cluster in a folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create the cluster in. <br>To get this ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the cluster as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Deployment environment of the cluster. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Configuration of the cluster. 
database_specs[] | **[DatabaseSpec](#DatabaseSpec)**<br>Configuration of databases in the cluster. 
user_specs[] | **[UserSpec](#UserSpec)**<br>Configuration of database users in the cluster. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Configuration of hosts in the cluster. 
network_id | **string**<br>ID of the network to create the cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>List of security group IDs to apply to the cluster. 
deletion_protection | **bool**<br>This option prevents unintended deletion of the cluster. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Version of MySQL used in the cluster. <br>Possible values: `5.7`, `8.0`. 
mysql_config | **oneof:** `mysql_config_5_7` or `mysql_config_8_0`<br>Cluster-wide MySQL configuration.
&nbsp;&nbsp;mysql_config_5_7 | **[config.MysqlConfig5_7](#MysqlConfig5_7)**<br>Configuration for a MySQL 5.7 cluster. 
&nbsp;&nbsp;mysql_config_8_0 | **[config.MysqlConfig8_0](#MysqlConfig8_0)**<br>Configuration for a MySQL 8.0 cluster. 
resources | **[Resources](#Resources2)**<br>Resource preset for the cluster hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access2)**<br>Access policy for external services. <br>If the specific services need to access the cluster, then set the necessary values in this policy. 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics2)**<br>Configuration of the performance diagnostics service. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.


### Resources {#Resources2}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. <br>All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage (for each cluster host, in bytes). 
disk_type_id | **string**<br>Type of the storage. <br>Possible values: <ul><li>`network-hdd` - standard network storage </li><li>`network-ssd` - fast network storage </li><li>`network-ssd-nonreplicated` - fast network nonreplicated storage </li><li>`local-ssd` - fast local storage. </li></ul><br>See [the documentation](/docs/managed-mysql/concepts/storage) for details. 


### Access {#Access2}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access from DataLens. <br>See [the documentation](/docs/managed-mysql/operations/datalens-connect) for details. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from management console. <br>See [the documentation](/docs/managed-mysql/operations/web-sql-query) for details. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics2}

Field | Description
--- | ---
enabled | **bool**<br>Flag that shows if performance statistics gathering is enabled for the cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for `my_session` sampling. Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for `my_statements` sampling. Acceptable values are 1 to 86400, inclusive.


### DatabaseSpec {#DatabaseSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the database. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the user. The maximum string length in characters is 32. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
password | **string**<br>Required. Password of the user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission)**<br>Set of permissions granted to the user to access specific databases. One permission per database. <br>When a permission for a database is set, the user will have access to the database. 
global_permissions[] | enum **GlobalPermission**<br>Set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the `SHOW MASTER STATUS`, `SHOW SLAVE STATUS`, and `SHOW BINARY LOGS` statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the `SHOW SLAVE HOSTS`, `SHOW RELAYLOG EVENTS` and `SHOW BINLOG EVENTS` statements.</li><li>`PROCESS`: Enables display of information about the the statements currently being performed by sessions (the set of threads executing within the server). <br>The privilege enables use of `SHOW PROCESSLIST` or `mysqladmin` processlist to see threads belonging to other users. You can always see your own threads. The `PROCESS` privilege also enables use of `SHOW ENGINE`.</li><li>`FLUSH_OPTIMIZER_COSTS`: Enables use of the `FLUSH OPTIMIZER_COSTS` statement.</li><li>`SHOW_ROUTINE`: Enables a user to access definitions and properties of all stored routines (stored procedures and functions), even those for which the user is not named as the routine DEFINER. This access includes: The contents of the Information Schema `ROUTINES` table. The `SHOW CREATE FUNCTION` and `SHOW CREATE PROCEDURE` statements. The `SHOW FUNCTION CODE` and `SHOW PROCEDURE CODE` statements. The SHOW `FUNCTION STATUS` and `SHOW PROCEDURE STATUS` statements.</li></ul>
connection_limits | **[ConnectionLimits](#ConnectionLimits)**<br>Set of user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>User authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li></ul>


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. <br>See [the documentation](/docs/managed-mysql/operations/grant) for details. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines and functions.</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using `LOCK TABLES` statement for tables available with `SELECT` privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some `SELECT` statements can be allowed without the `SELECT` privilege. All statements that read column values require the `SELECT` privilege. <br>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_select) for details.</li><li>`SHOW_VIEW`: Using the `SHOW CREATE VIEW` statement. Also needed for views used with `EXPLAIN`.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li></ul>


### ConnectionLimits {#ConnectionLimits}

Field | Description
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user questions per hour. The minimum value is 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user updates per hour. The minimum value is 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of simultaneous client connections per hour. The minimum value is 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of simultaneous connections permitted to any given MySQL user account. The minimum value is 0.


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. <br>To get a list of available zones, make the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet to assign to the host. <br>This subnet should be a part of the cluster network (the network ID is specified in the [ClusterService.CreateClusterRequest.network_id](./cluster_service#CreateClusterRequest)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Option that enables public IP address for the host so that the host can be accessed from the internet. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP address, or to assign a public IP address to a host without one, recreate the host with the appropriate `assign_public_ip` value set. <br>Possible values: <ul><li>`false` - don't assign a public IP address to the host. </li><li>`true` - assign a public IP address to the host.</li></ul> 
replication_source | **string**<br>[Host.name](#Host) of the host to be used as the replication source (for cascading replication). 
backup_priority | **int64**<br>Host backup priority Acceptable values are 0 to 100, inclusive.
priority | **int64**<br>Host master promotion priority Acceptable values are 0 to 100, inclusive.


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
cluster_id | **string**<br>ID of the cluster that is being created. 


### Cluster {#Cluster2}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. <br>This ID is assigned by the platform at the time of creation. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp of the cluster. 
name | **string**<br>Name of the cluster. 
description | **string**<br>Description of the cluster. 
labels | **map<string,string>**<br>Custom labels for the cluster as `key:value` pairs. 
environment | enum **Environment**<br>Deployment environment of the cluster. <ul><li>`PRODUCTION`: Environment for stable versions of your apps. A conservative update policy is in effect: only bug fixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment for testing, including the Managed Service for MySQL itself. This environment gets new features, improvements, and bug fixes in the first place, compared to the production environment. However, not every update ensures backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Monitoring systems data that is relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated health of the cluster. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is degraded ([Host.health](#Host) for at least one host in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow2)**<br>Maintenance window settings for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation2)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>Effective list of security group IDs applied to the cluster. 
deletion_protection | **bool**<br>This option prevents unintended deletion of the cluster. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring2}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the cluster. 


### ClusterConfig {#ClusterConfig2}

Field | Description
--- | ---
version | **string**<br>Version of MySQL used in the cluster. 
mysql_config | **oneof:** `mysql_config_5_7` or `mysql_config_8_0`<br>Cluster-wide MySQL configuration.
&nbsp;&nbsp;mysql_config_5_7 | **[config.MysqlConfigSet5_7](#MysqlConfigSet5_7)**<br>Configuration of a MySQL 5.7 server. 
&nbsp;&nbsp;mysql_config_8_0 | **[config.MysqlConfigSet8_0](#MysqlConfigSet8_0)**<br>Configuration of a MySQL 8.0 server. 
resources | **[Resources](#Resources3)**<br>Resource preset for the cluster hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access3)**<br>Access policy for external services. 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics3)**<br>Configuration of the performance diagnostics service. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.


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

Updates a cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to update. <br>To get this ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which settings of the cluster should be updated. 
description | **string**<br>New description of the cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>New set of custom labels for the cluster as `key:value` pairs. <br>This set will completely replace the current one. To add a label, request the current label set with the [ClusterService.Get](#Get) request, then send an [ClusterService.Update](#Update) request with the new label added to the current set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec)**<br>New configuration of the cluster. 
name | **string**<br>New name of the cluster. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>Configuration of a maintenance window in an MySQL cluster. 
security_group_ids[] | **string**<br>New list of security group IDs to apply to the cluster. 
deletion_protection | **bool**<br>This option prevents unintended deletion of the cluster. 


### ConfigSpec {#ConfigSpec1}

Field | Description
--- | ---
version | **string**<br>Version of MySQL used in the cluster. <br>Possible values: `5.7`, `8.0`. 
mysql_config | **oneof:** `mysql_config_5_7` or `mysql_config_8_0`<br>Cluster-wide MySQL configuration.
&nbsp;&nbsp;mysql_config_5_7 | **[config.MysqlConfig5_7](#MysqlConfig5_7)**<br>Configuration for a MySQL 5.7 cluster. 
&nbsp;&nbsp;mysql_config_8_0 | **[config.MysqlConfig8_0](#MysqlConfig8_0)**<br>Configuration for a MySQL 8.0 cluster. 
resources | **[Resources](#Resources3)**<br>Resource preset for the cluster hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access3)**<br>Access policy for external services. <br>If the specific services need to access the cluster, then set the necessary values in this policy. 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics3)**<br>Configuration of the performance diagnostics service. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.


### Resources {#Resources3}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. <br>All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage (for each cluster host, in bytes). 
disk_type_id | **string**<br>Type of the storage. <br>Possible values: <ul><li>`network-hdd` - standard network storage </li><li>`network-ssd` - fast network storage </li><li>`network-ssd-nonreplicated` - fast network nonreplicated storage </li><li>`local-ssd` - fast local storage. </li></ul><br>See [the documentation](/docs/managed-mysql/concepts/storage) for details. 


### Access {#Access3}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access from DataLens. <br>See [the documentation](/docs/managed-mysql/operations/datalens-connect) for details. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from management console. <br>See [the documentation](/docs/managed-mysql/operations/web-sql-query) for details. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics3}

Field | Description
--- | ---
enabled | **bool**<br>Flag that shows if performance statistics gathering is enabled for the cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for `my_session` sampling. Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for `my_statements` sampling. Acceptable values are 1 to 86400, inclusive.


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
cluster_id | **string**<br>ID of the cluster that is being updated. 


### Cluster {#Cluster3}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. <br>This ID is assigned by the platform at the time of creation. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp of the cluster. 
name | **string**<br>Name of the cluster. 
description | **string**<br>Description of the cluster. 
labels | **map<string,string>**<br>Custom labels for the cluster as `key:value` pairs. 
environment | enum **Environment**<br>Deployment environment of the cluster. <ul><li>`PRODUCTION`: Environment for stable versions of your apps. A conservative update policy is in effect: only bug fixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment for testing, including the Managed Service for MySQL itself. This environment gets new features, improvements, and bug fixes in the first place, compared to the production environment. However, not every update ensures backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Monitoring systems data that is relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig3)**<br>Configuration of the cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated health of the cluster. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is degraded ([Host.health](#Host) for at least one host in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Maintenance window settings for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation3)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>Effective list of security group IDs applied to the cluster. 
deletion_protection | **bool**<br>This option prevents unintended deletion of the cluster. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring3}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the cluster. 


### ClusterConfig {#ClusterConfig3}

Field | Description
--- | ---
version | **string**<br>Version of MySQL used in the cluster. 
mysql_config | **oneof:** `mysql_config_5_7` or `mysql_config_8_0`<br>Cluster-wide MySQL configuration.
&nbsp;&nbsp;mysql_config_5_7 | **[config.MysqlConfigSet5_7](#MysqlConfigSet5_7)**<br>Configuration of a MySQL 5.7 server. 
&nbsp;&nbsp;mysql_config_8_0 | **[config.MysqlConfigSet8_0](#MysqlConfigSet8_0)**<br>Configuration of a MySQL 8.0 server. 
resources | **[Resources](#Resources4)**<br>Resource preset for the cluster hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access4)**<br>Access policy for external services. 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics4)**<br>Configuration of the performance diagnostics service. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.


### MaintenanceOperation {#MaintenanceOperation3}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## Delete {#Delete}

Deletes a cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to delete. <br>To get this ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the cluster that is being deleted. 


## Start {#Start}

Starts a cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to start. <br>To get this ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the cluster that is being started. 


### Cluster {#Cluster4}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. <br>This ID is assigned by the platform at the time of creation. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp of the cluster. 
name | **string**<br>Name of the cluster. 
description | **string**<br>Description of the cluster. 
labels | **map<string,string>**<br>Custom labels for the cluster as `key:value` pairs. 
environment | enum **Environment**<br>Deployment environment of the cluster. <ul><li>`PRODUCTION`: Environment for stable versions of your apps. A conservative update policy is in effect: only bug fixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment for testing, including the Managed Service for MySQL itself. This environment gets new features, improvements, and bug fixes in the first place, compared to the production environment. However, not every update ensures backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Monitoring systems data that is relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig4)**<br>Configuration of the cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated health of the cluster. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is degraded ([Host.health](#Host) for at least one host in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Maintenance window settings for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation4)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>Effective list of security group IDs applied to the cluster. 
deletion_protection | **bool**<br>This option prevents unintended deletion of the cluster. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring4}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the cluster. 


### ClusterConfig {#ClusterConfig4}

Field | Description
--- | ---
version | **string**<br>Version of MySQL used in the cluster. 
mysql_config | **oneof:** `mysql_config_5_7` or `mysql_config_8_0`<br>Cluster-wide MySQL configuration.
&nbsp;&nbsp;mysql_config_5_7 | **[config.MysqlConfigSet5_7](#MysqlConfigSet5_7)**<br>Configuration of a MySQL 5.7 server. 
&nbsp;&nbsp;mysql_config_8_0 | **[config.MysqlConfigSet8_0](#MysqlConfigSet8_0)**<br>Configuration of a MySQL 8.0 server. 
resources | **[Resources](#Resources4)**<br>Resource preset for the cluster hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access4)**<br>Access policy for external services. 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics4)**<br>Configuration of the performance diagnostics service. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.


### Resources {#Resources4}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. <br>All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage (for each cluster host, in bytes). 
disk_type_id | **string**<br>Type of the storage. <br>Possible values: <ul><li>`network-hdd` - standard network storage </li><li>`network-ssd` - fast network storage </li><li>`network-ssd-nonreplicated` - fast network nonreplicated storage </li><li>`local-ssd` - fast local storage. </li></ul><br>See [the documentation](/docs/managed-mysql/concepts/storage) for details. 


### Access {#Access4}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access from DataLens. <br>See [the documentation](/docs/managed-mysql/operations/datalens-connect) for details. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from management console. <br>See [the documentation](/docs/managed-mysql/operations/web-sql-query) for details. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics4}

Field | Description
--- | ---
enabled | **bool**<br>Flag that shows if performance statistics gathering is enabled for the cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for `my_session` sampling. Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for `my_statements` sampling. Acceptable values are 1 to 86400, inclusive.


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

Stops a cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to stop. <br>To get this ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the cluster that is being stopped. 


### Cluster {#Cluster5}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. <br>This ID is assigned by the platform at the time of creation. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp of the cluster. 
name | **string**<br>Name of the cluster. 
description | **string**<br>Description of the cluster. 
labels | **map<string,string>**<br>Custom labels for the cluster as `key:value` pairs. 
environment | enum **Environment**<br>Deployment environment of the cluster. <ul><li>`PRODUCTION`: Environment for stable versions of your apps. A conservative update policy is in effect: only bug fixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment for testing, including the Managed Service for MySQL itself. This environment gets new features, improvements, and bug fixes in the first place, compared to the production environment. However, not every update ensures backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Monitoring systems data that is relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig5)**<br>Configuration of the cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated health of the cluster. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is degraded ([Host.health](#Host) for at least one host in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow5)**<br>Maintenance window settings for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation5)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>Effective list of security group IDs applied to the cluster. 
deletion_protection | **bool**<br>This option prevents unintended deletion of the cluster. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring5}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the cluster. 


### ClusterConfig {#ClusterConfig5}

Field | Description
--- | ---
version | **string**<br>Version of MySQL used in the cluster. 
mysql_config | **oneof:** `mysql_config_5_7` or `mysql_config_8_0`<br>Cluster-wide MySQL configuration.
&nbsp;&nbsp;mysql_config_5_7 | **[config.MysqlConfigSet5_7](#MysqlConfigSet5_7)**<br>Configuration of a MySQL 5.7 server. 
&nbsp;&nbsp;mysql_config_8_0 | **[config.MysqlConfigSet8_0](#MysqlConfigSet8_0)**<br>Configuration of a MySQL 8.0 server. 
resources | **[Resources](#Resources5)**<br>Resource preset for the cluster hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access5)**<br>Access policy for external services. 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics5)**<br>Configuration of the performance diagnostics service. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.


### Resources {#Resources5}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. <br>All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage (for each cluster host, in bytes). 
disk_type_id | **string**<br>Type of the storage. <br>Possible values: <ul><li>`network-hdd` - standard network storage </li><li>`network-ssd` - fast network storage </li><li>`network-ssd-nonreplicated` - fast network nonreplicated storage </li><li>`local-ssd` - fast local storage. </li></ul><br>See [the documentation](/docs/managed-mysql/concepts/storage) for details. 


### Access {#Access5}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access from DataLens. <br>See [the documentation](/docs/managed-mysql/operations/datalens-connect) for details. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from management console. <br>See [the documentation](/docs/managed-mysql/operations/web-sql-query) for details. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics5}

Field | Description
--- | ---
enabled | **bool**<br>Flag that shows if performance statistics gathering is enabled for the cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for `my_session` sampling. Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for `my_statements` sampling. Acceptable values are 1 to 86400, inclusive.


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

Moves a cluster to a folder.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### MoveClusterRequest {#MoveClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to move. <br>To get this ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
destination_folder_id | **string**<br>Required. ID of the destination folder. <br>To get this ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the cluster that is being moved. 
source_folder_id | **string**<br>ID of the source folder. 
destination_folder_id | **string**<br>ID of the destination folder. 


### Cluster {#Cluster6}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. <br>This ID is assigned by the platform at the time of creation. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp of the cluster. 
name | **string**<br>Name of the cluster. 
description | **string**<br>Description of the cluster. 
labels | **map<string,string>**<br>Custom labels for the cluster as `key:value` pairs. 
environment | enum **Environment**<br>Deployment environment of the cluster. <ul><li>`PRODUCTION`: Environment for stable versions of your apps. A conservative update policy is in effect: only bug fixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment for testing, including the Managed Service for MySQL itself. This environment gets new features, improvements, and bug fixes in the first place, compared to the production environment. However, not every update ensures backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring6)**<br>Monitoring systems data that is relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig6)**<br>Configuration of the cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated health of the cluster. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is degraded ([Host.health](#Host) for at least one host in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow6)**<br>Maintenance window settings for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation6)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>Effective list of security group IDs applied to the cluster. 
deletion_protection | **bool**<br>This option prevents unintended deletion of the cluster. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring6}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the cluster. 


### ClusterConfig {#ClusterConfig6}

Field | Description
--- | ---
version | **string**<br>Version of MySQL used in the cluster. 
mysql_config | **oneof:** `mysql_config_5_7` or `mysql_config_8_0`<br>Cluster-wide MySQL configuration.
&nbsp;&nbsp;mysql_config_5_7 | **[config.MysqlConfigSet5_7](#MysqlConfigSet5_7)**<br>Configuration of a MySQL 5.7 server. 
&nbsp;&nbsp;mysql_config_8_0 | **[config.MysqlConfigSet8_0](#MysqlConfigSet8_0)**<br>Configuration of a MySQL 8.0 server. 
resources | **[Resources](#Resources6)**<br>Resource preset for the cluster hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access6)**<br>Access policy for external services. 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics6)**<br>Configuration of the performance diagnostics service. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.


### Resources {#Resources6}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. <br>All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage (for each cluster host, in bytes). 
disk_type_id | **string**<br>Type of the storage. <br>Possible values: <ul><li>`network-hdd` - standard network storage </li><li>`network-ssd` - fast network storage </li><li>`network-ssd-nonreplicated` - fast network nonreplicated storage </li><li>`local-ssd` - fast local storage. </li></ul><br>See [the documentation](/docs/managed-mysql/concepts/storage) for details. 


### Access {#Access6}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access from DataLens. <br>See [the documentation](/docs/managed-mysql/operations/datalens-connect) for details. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from management console. <br>See [the documentation](/docs/managed-mysql/operations/web-sql-query) for details. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics6}

Field | Description
--- | ---
enabled | **bool**<br>Flag that shows if performance statistics gathering is enabled for the cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for `my_session` sampling. Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for `my_statements` sampling. Acceptable values are 1 to 86400, inclusive.


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

Creates a backup for a cluster. <br>To get information about a backup, make a [BackupService.Get](./backup_service#Get) request.

**rpc Backup ([BackupClusterRequest](#BackupClusterRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupClusterMetadata](#BackupClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster7)<br>

### BackupClusterRequest {#BackupClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to back up. <br>To get this ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the cluster that is being backed up. 
backup_id | **string**<br>ID of the MySQL backup that is created. 


### Cluster {#Cluster7}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. <br>This ID is assigned by the platform at the time of creation. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp of the cluster. 
name | **string**<br>Name of the cluster. 
description | **string**<br>Description of the cluster. 
labels | **map<string,string>**<br>Custom labels for the cluster as `key:value` pairs. 
environment | enum **Environment**<br>Deployment environment of the cluster. <ul><li>`PRODUCTION`: Environment for stable versions of your apps. A conservative update policy is in effect: only bug fixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment for testing, including the Managed Service for MySQL itself. This environment gets new features, improvements, and bug fixes in the first place, compared to the production environment. However, not every update ensures backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring7)**<br>Monitoring systems data that is relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig7)**<br>Configuration of the cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated health of the cluster. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is degraded ([Host.health](#Host) for at least one host in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow7)**<br>Maintenance window settings for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation7)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>Effective list of security group IDs applied to the cluster. 
deletion_protection | **bool**<br>This option prevents unintended deletion of the cluster. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring7}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the cluster. 


### ClusterConfig {#ClusterConfig7}

Field | Description
--- | ---
version | **string**<br>Version of MySQL used in the cluster. 
mysql_config | **oneof:** `mysql_config_5_7` or `mysql_config_8_0`<br>Cluster-wide MySQL configuration.
&nbsp;&nbsp;mysql_config_5_7 | **[config.MysqlConfigSet5_7](#MysqlConfigSet5_7)**<br>Configuration of a MySQL 5.7 server. 
&nbsp;&nbsp;mysql_config_8_0 | **[config.MysqlConfigSet8_0](#MysqlConfigSet8_0)**<br>Configuration of a MySQL 8.0 server. 
resources | **[Resources](#Resources7)**<br>Resource preset for the cluster hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access7)**<br>Access policy for external services. 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics7)**<br>Configuration of the performance diagnostics service. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.


### Resources {#Resources7}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. <br>All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage (for each cluster host, in bytes). 
disk_type_id | **string**<br>Type of the storage. <br>Possible values: <ul><li>`network-hdd` - standard network storage </li><li>`network-ssd` - fast network storage </li><li>`network-ssd-nonreplicated` - fast network nonreplicated storage </li><li>`local-ssd` - fast local storage. </li></ul><br>See [the documentation](/docs/managed-mysql/concepts/storage) for details. 


### Access {#Access7}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access from DataLens. <br>See [the documentation](/docs/managed-mysql/operations/datalens-connect) for details. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from management console. <br>See [the documentation](/docs/managed-mysql/operations/web-sql-query) for details. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics7}

Field | Description
--- | ---
enabled | **bool**<br>Flag that shows if performance statistics gathering is enabled for the cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for `my_session` sampling. Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for `my_statements` sampling. Acceptable values are 1 to 86400, inclusive.


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

Restores a backup to a new cluster. <br>See [the documentation](/docs/managed-mysql/concepts/backup) for details.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster8)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. ID of the backup to restore from. <br>To get this ID, make a [BackupService.List](./backup_service#List) request (lists all backups in a folder) or a [ClusterService.ListBackups](#ListBackups) request (lists all backups for an existing cluster). 
time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the moment to which the MySQL cluster should be restored. 
name | **string**<br>Required. Name of the new MySQL cluster the backup will be restored to. The name must be unique within the folder. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the new cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the new cluster as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster8)**<br>Deployment environment for the new cluster. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Configuration of the new cluster. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Configuration of hosts in the new cluster. 
network_id | **string**<br>ID of the network to create the new cluster in. The maximum string length in characters is 50.
folder_id | **string**<br>ID of the folder to create the new cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>List of security group IDs to apply to the new cluster. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### ConfigSpec {#ConfigSpec2}

Field | Description
--- | ---
version | **string**<br>Version of MySQL used in the cluster. <br>Possible values: `5.7`, `8.0`. 
mysql_config | **oneof:** `mysql_config_5_7` or `mysql_config_8_0`<br>Cluster-wide MySQL configuration.
&nbsp;&nbsp;mysql_config_5_7 | **[config.MysqlConfig5_7](#MysqlConfig5_7)**<br>Configuration for a MySQL 5.7 cluster. 
&nbsp;&nbsp;mysql_config_8_0 | **[config.MysqlConfig8_0](#MysqlConfig8_0)**<br>Configuration for a MySQL 8.0 cluster. 
resources | **[Resources](#Resources8)**<br>Resource preset for the cluster hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access8)**<br>Access policy for external services. <br>If the specific services need to access the cluster, then set the necessary values in this policy. 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics8)**<br>Configuration of the performance diagnostics service. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.


### Resources {#Resources8}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. <br>All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage (for each cluster host, in bytes). 
disk_type_id | **string**<br>Type of the storage. <br>Possible values: <ul><li>`network-hdd` - standard network storage </li><li>`network-ssd` - fast network storage </li><li>`network-ssd-nonreplicated` - fast network nonreplicated storage </li><li>`local-ssd` - fast local storage. </li></ul><br>See [the documentation](/docs/managed-mysql/concepts/storage) for details. 


### Access {#Access8}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access from DataLens. <br>See [the documentation](/docs/managed-mysql/operations/datalens-connect) for details. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from management console. <br>See [the documentation](/docs/managed-mysql/operations/web-sql-query) for details. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics8}

Field | Description
--- | ---
enabled | **bool**<br>Flag that shows if performance statistics gathering is enabled for the cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for `my_session` sampling. Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for `my_statements` sampling. Acceptable values are 1 to 86400, inclusive.


### HostSpec {#HostSpec1}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. <br>To get a list of available zones, make the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet to assign to the host. <br>This subnet should be a part of the cluster network (the network ID is specified in the [ClusterService.CreateClusterRequest.network_id](./cluster_service#CreateClusterRequest)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Option that enables public IP address for the host so that the host can be accessed from the internet. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP address, or to assign a public IP address to a host without one, recreate the host with the appropriate `assign_public_ip` value set. <br>Possible values: <ul><li>`false` - don't assign a public IP address to the host. </li><li>`true` - assign a public IP address to the host.</li></ul> 
replication_source | **string**<br>[Host.name](#Host) of the host to be used as the replication source (for cascading replication). 
backup_priority | **int64**<br>Host backup priority Acceptable values are 0 to 100, inclusive.
priority | **int64**<br>Host master promotion priority Acceptable values are 0 to 100, inclusive.


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
cluster_id | **string**<br>ID of the new cluster that is being created from a backup. 
backup_id | **string**<br>ID of the backup that is being used for creating a cluster. 


### Cluster {#Cluster8}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. <br>This ID is assigned by the platform at the time of creation. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp of the cluster. 
name | **string**<br>Name of the cluster. 
description | **string**<br>Description of the cluster. 
labels | **map<string,string>**<br>Custom labels for the cluster as `key:value` pairs. 
environment | enum **Environment**<br>Deployment environment of the cluster. <ul><li>`PRODUCTION`: Environment for stable versions of your apps. A conservative update policy is in effect: only bug fixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment for testing, including the Managed Service for MySQL itself. This environment gets new features, improvements, and bug fixes in the first place, compared to the production environment. However, not every update ensures backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring8)**<br>Monitoring systems data that is relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig8)**<br>Configuration of the cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated health of the cluster. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is degraded ([Host.health](#Host) for at least one host in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow8)**<br>Maintenance window settings for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation8)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>Effective list of security group IDs applied to the cluster. 
deletion_protection | **bool**<br>This option prevents unintended deletion of the cluster. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring8}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the cluster. 


### ClusterConfig {#ClusterConfig8}

Field | Description
--- | ---
version | **string**<br>Version of MySQL used in the cluster. 
mysql_config | **oneof:** `mysql_config_5_7` or `mysql_config_8_0`<br>Cluster-wide MySQL configuration.
&nbsp;&nbsp;mysql_config_5_7 | **[config.MysqlConfigSet5_7](#MysqlConfigSet5_7)**<br>Configuration of a MySQL 5.7 server. 
&nbsp;&nbsp;mysql_config_8_0 | **[config.MysqlConfigSet8_0](#MysqlConfigSet8_0)**<br>Configuration of a MySQL 8.0 server. 
resources | **[Resources](#Resources9)**<br>Resource preset for the cluster hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access9)**<br>Access policy for external services. 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics9)**<br>Configuration of the performance diagnostics service. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.


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
cluster_id | **string**<br>Required. ID of the cluster to reschedule the maintenance operation for. <br>To get this ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
reschedule_type | enum **RescheduleType**<br>Required. The type of reschedule request. <ul><li>`IMMEDIATE`: Start the maintenance operation immediately.</li><li>`NEXT_AVAILABLE_WINDOW`: Start the maintenance operation within the next available maintenance window.</li><li>`SPECIFIC_TIME`: Start the maintenance operation at the specific time.</li></ul>
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time until which this maintenance operation should be delayed. The value should be ahead of the first time when the maintenance operation has been scheduled for no more than two weeks. The value can also point to the past moment of time if `IMMEDIATE` reschedule type is chosen. 


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
cluster_id | **string**<br>ID of the cluster the maintenance operation is being rescheduled for. 
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time until which this maintenance operation is to be delayed. 


### Cluster {#Cluster9}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. <br>This ID is assigned by the platform at the time of creation. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp of the cluster. 
name | **string**<br>Name of the cluster. 
description | **string**<br>Description of the cluster. 
labels | **map<string,string>**<br>Custom labels for the cluster as `key:value` pairs. 
environment | enum **Environment**<br>Deployment environment of the cluster. <ul><li>`PRODUCTION`: Environment for stable versions of your apps. A conservative update policy is in effect: only bug fixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment for testing, including the Managed Service for MySQL itself. This environment gets new features, improvements, and bug fixes in the first place, compared to the production environment. However, not every update ensures backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring9)**<br>Monitoring systems data that is relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig9)**<br>Configuration of the cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated health of the cluster. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is degraded ([Host.health](#Host) for at least one host in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow9)**<br>Maintenance window settings for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation9)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>Effective list of security group IDs applied to the cluster. 
deletion_protection | **bool**<br>This option prevents unintended deletion of the cluster. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring9}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the cluster. 


### ClusterConfig {#ClusterConfig9}

Field | Description
--- | ---
version | **string**<br>Version of MySQL used in the cluster. 
mysql_config | **oneof:** `mysql_config_5_7` or `mysql_config_8_0`<br>Cluster-wide MySQL configuration.
&nbsp;&nbsp;mysql_config_5_7 | **[config.MysqlConfigSet5_7](#MysqlConfigSet5_7)**<br>Configuration of a MySQL 5.7 server. 
&nbsp;&nbsp;mysql_config_8_0 | **[config.MysqlConfigSet8_0](#MysqlConfigSet8_0)**<br>Configuration of a MySQL 8.0 server. 
resources | **[Resources](#Resources9)**<br>Resource preset for the cluster hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access9)**<br>Access policy for external services. 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics9)**<br>Configuration of the performance diagnostics service. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.


### Resources {#Resources9}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. <br>All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage (for each cluster host, in bytes). 
disk_type_id | **string**<br>Type of the storage. <br>Possible values: <ul><li>`network-hdd` - standard network storage </li><li>`network-ssd` - fast network storage </li><li>`network-ssd-nonreplicated` - fast network nonreplicated storage </li><li>`local-ssd` - fast local storage. </li></ul><br>See [the documentation](/docs/managed-mysql/concepts/storage) for details. 


### Access {#Access9}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access from DataLens. <br>See [the documentation](/docs/managed-mysql/operations/datalens-connect) for details. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from management console. <br>See [the documentation](/docs/managed-mysql/operations/web-sql-query) for details. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics9}

Field | Description
--- | ---
enabled | **bool**<br>Flag that shows if performance statistics gathering is enabled for the cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for `my_session` sampling. Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for `my_statements` sampling. Acceptable values are 1 to 86400, inclusive.


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

Starts a manual failover for a cluster.

**rpc StartFailover ([StartClusterFailoverRequest](#StartClusterFailoverRequest)) returns ([operation.Operation](#Operation9))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterFailoverMetadata](#StartClusterFailoverMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster10)<br>

### StartClusterFailoverRequest {#StartClusterFailoverRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to start failover for. <br>To get this ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
host_name | **string**<br>Host name to switch master role to. If not provided, then the master role is switched to the most up-to-date replica host. <br>To get this name, make a [ClusterService.ListHosts](#ListHosts) request. The maximum string length in characters is 253.


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
cluster_id | **string**<br>ID of the cluster that is being failovered. 


### Cluster {#Cluster10}

Field | Description
--- | ---
id | **string**<br>ID of the cluster. <br>This ID is assigned by the platform at the time of creation. 
folder_id | **string**<br>ID of the folder that the cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp of the cluster. 
name | **string**<br>Name of the cluster. 
description | **string**<br>Description of the cluster. 
labels | **map<string,string>**<br>Custom labels for the cluster as `key:value` pairs. 
environment | enum **Environment**<br>Deployment environment of the cluster. <ul><li>`PRODUCTION`: Environment for stable versions of your apps. A conservative update policy is in effect: only bug fixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment for testing, including the Managed Service for MySQL itself. This environment gets new features, improvements, and bug fixes in the first place, compared to the production environment. However, not every update ensures backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring10)**<br>Monitoring systems data that is relevant to the cluster. 
config | **[ClusterConfig](#ClusterConfig10)**<br>Configuration of the cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated health of the cluster. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is degraded ([Host.health](#Host) for at least one host in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster is stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow10)**<br>Maintenance window settings for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation10)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>Effective list of security group IDs applied to the cluster. 
deletion_protection | **bool**<br>This option prevents unintended deletion of the cluster. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 


### Monitoring {#Monitoring10}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the cluster. 


### ClusterConfig {#ClusterConfig10}

Field | Description
--- | ---
version | **string**<br>Version of MySQL used in the cluster. 
mysql_config | **oneof:** `mysql_config_5_7` or `mysql_config_8_0`<br>Cluster-wide MySQL configuration.
&nbsp;&nbsp;mysql_config_5_7 | **[config.MysqlConfigSet5_7](#MysqlConfigSet5_7)**<br>Configuration of a MySQL 5.7 server. 
&nbsp;&nbsp;mysql_config_8_0 | **[config.MysqlConfigSet8_0](#MysqlConfigSet8_0)**<br>Configuration of a MySQL 8.0 server. 
resources | **[Resources](#Resources10)**<br>Resource preset for the cluster hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access10)**<br>Access policy for external services. 
performance_diagnostics | **[PerformanceDiagnostics](#PerformanceDiagnostics10)**<br>Configuration of the performance diagnostics service. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retention policy of automated backups. Acceptable values are 7 to 60, inclusive.


### Resources {#Resources10}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. <br>All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage (for each cluster host, in bytes). 
disk_type_id | **string**<br>Type of the storage. <br>Possible values: <ul><li>`network-hdd` - standard network storage </li><li>`network-ssd` - fast network storage </li><li>`network-ssd-nonreplicated` - fast network nonreplicated storage </li><li>`local-ssd` - fast local storage. </li></ul><br>See [the documentation](/docs/managed-mysql/concepts/storage) for details. 


### Access {#Access10}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access from DataLens. <br>See [the documentation](/docs/managed-mysql/operations/datalens-connect) for details. 
web_sql | **bool**<br>Allows SQL queries to the cluster databases from management console. <br>See [the documentation](/docs/managed-mysql/operations/web-sql-query) for details. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### PerformanceDiagnostics {#PerformanceDiagnostics10}

Field | Description
--- | ---
enabled | **bool**<br>Flag that shows if performance statistics gathering is enabled for the cluster. 
sessions_sampling_interval | **int64**<br>Interval (in seconds) for `my_session` sampling. Acceptable values are 1 to 86400, inclusive.
statements_sampling_interval | **int64**<br>Interval (in seconds) for `my_statements` sampling. Acceptable values are 1 to 86400, inclusive.


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

Retrieves logs for a cluster. <br>Alternatively, logs can be streamed using [StreamLogs](#StreamLogs).

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to request logs for. <br>To get this ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from the logs table to request. If no columns are specified, complete log records are returned. 
service_type | enum **ServiceType**<br>The log type. <ul><li>`MYSQL_ERROR`: MySQL error log.</li><li>`MYSQL_GENERAL`: MySQL general query log.</li><li>`MYSQL_SLOW_QUERY`: MySQL slow query log.</li><li>`MYSQL_AUDIT`: MySQL audit log.</li></ul>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request. The logs in the response will be within `from_time` to `to_time` range. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request. The logs in the response will be within `from_time` to `to_time` range. 
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the API returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) that can be used to get the next page of results in the subsequent [ClusterService.ListLogs](#ListLogs) requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token that can be used to iterate through multiple pages of results. <br>To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) returned by the previous [ClusterService.ListLogs](#ListLogs) request. The maximum string length in characters is 100.
always_next_page_token | **bool**<br>Option that controls the behavior of result pagination. If it is set to `true`, then [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) will always be returned, even if the current page is empty. 


### ListClusterLogsResponse {#ListClusterLogsResponse}

Field | Description
--- | ---
logs[] | **[LogRecord](#LogRecord)**<br>Requested log records. 
next_page_token | **string**<br>The token that can be used to get the next page of results. <br>If the number of results is larger than [ListClusterLogsRequest.page_size](#ListClusterLogsRequest), use the `next_page_token` as the value for the [ListClusterLogsRequest.page_token](#ListClusterLogsRequest) in the subsequent [ClusterService.ListLogs](#ListLogs) request to iterate through multiple pages of results. <br>Each of the subsequent [ClusterService.ListLogs](#ListLogs) requests should use the `next_page_token` value returned by the previous request to continue paging through the results. <br>This value is interchangeable with [StreamLogRecord.next_record_token](#StreamLogRecord) from [ClusterService.StreamLogs](#StreamLogs) method. 


### LogRecord {#LogRecord}

Field | Description
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the log record. 
message | **map<string,string>**<br>Contents of the log record. 


## StreamLogs {#StreamLogs}

Retrieves a log stream for a cluster. <br>This method is similar to [ListLogs](#ListLogs), but uses server-side streaming, which allows for the `tail -f` command semantics.

**rpc StreamLogs ([StreamClusterLogsRequest](#StreamClusterLogsRequest)) returns (stream [StreamLogRecord](#StreamLogRecord))**

### StreamClusterLogsRequest {#StreamClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to stream logs for. <br>To get this ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from the logs table to request. If no columns are specified, complete log records are returned. 
service_type | enum **ServiceType**<br>The log type. <ul><li>`MYSQL_ERROR`: MySQL error log.</li><li>`MYSQL_GENERAL`: MySQL general query log.</li><li>`MYSQL_SLOW_QUERY`: MySQL slow query log.</li><li>`MYSQL_AUDIT`: MySQL audit log.</li></ul>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request. If this field is not set, all existing log records beginning from `from_time` will be returned first, and then the new records will be returned as they appear. <br>In essence it has `tail -f` command semantics. 
record_token | **string**<br>Record token that can be used to control logs streaming. <br>Set `record_token` to the [StreamLogRecord.next_record_token](#StreamLogRecord), returned by the previous [ClusterService.StreamLogs](#StreamLogs) request to start streaming from the next log record. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that selects clusters logs listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can be applied to the [LogRecord.logs.hostname](#LogRecord) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Examples of a filter: `message.hostname='node1.db.cloud.yandex.net'` The maximum string length in characters is 1000.


### StreamLogRecord {#StreamLogRecord}

Field | Description
--- | ---
record | **[LogRecord](#LogRecord)**<br>One of the requested log records. 
next_record_token | **string**<br>The token that can be used to continue streaming logs starting from the exact same record. To continue streaming, specify value of `next_record_token` as the [StreamClusterLogsRequest.record_token](#StreamClusterLogsRequest) value in the next [ClusterService.StreamLogs](#StreamLogs) request. <br>This value is interchangeable with [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) from [ClusterService.ListLogs](#ListLogs) method. 


### LogRecord {#LogRecord1}

Field | Description
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the log record. 
message | **map<string,string>**<br>Contents of the log record. 


## ListOperations {#ListOperations}

Retrieves a list of operations for a cluster.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to list operations for. <br>To get this ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the API returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in the subsequent [ClusterService.ListOperations](#ListOperations) requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token that can be used to iterate through multiple pages of results. <br>To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by the previous [ClusterService.ListOperations](#ListOperations) request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation10)**<br>List of operations in the cluster. 
next_page_token | **string**<br>The token that can be used to get the next page of results. <br>If the number of results is larger than [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest), use the `next_page_token` as the value for the [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest) in the subsequent [ClusterService.ListOperations](#ListOperations) request to iterate through multiple pages of results. <br>Each of the subsequent [ClusterService.ListOperations](#ListOperations) requests should use the `next_page_token` value returned by the previous request to continue paging through the results. 


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

Retrieves a list of backups for a cluster. <br>To list all backups in a folder, make a [BackupService.List](./backup_service#List) request.

**rpc ListBackups ([ListClusterBackupsRequest](#ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#ListClusterBackupsResponse))**

### ListClusterBackupsRequest {#ListClusterBackupsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to list backups for. <br>To get this ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the API returns a [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) that can be used to get the next page of results in the subsequent [ClusterService.ListBackups](#ListBackups) requests. The maximum value is 1000.
page_token | **string**<br>Page token that can be used to iterate through multiple pages of results. <br>To get the next page of results, set `page_token` to the [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) returned by the previous [ClusterService.ListBackups](#ListBackups) request. The maximum string length in characters is 100.


### ListClusterBackupsResponse {#ListClusterBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup)**<br>List of the cluster backups. 
next_page_token | **string**<br>The token that can be used to get the next page of results. <br>If the number of results is larger than [ListClusterBackupsRequest.page_size](#ListClusterBackupsRequest), use the `next_page_token` as the value for the [ListClusterBackupsRequest.page_token](#ListClusterBackupsRequest) in the subsequent [ClusterService.ListBackups](#ListBackups) request to iterate through multiple pages of results. <br>Each of the subsequent [ClusterService.ListBackups](#ListBackups) requests should use the `next_page_token` value returned by the previous request to continue paging through the results. 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>Required. ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp (the time when the backup operation was completed). 
source_cluster_id | **string**<br>ID of the cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp (the time when the backup operation was started). 
size | **int64**<br>Size of backup, in bytes 
type | enum **BackupCreationType**<br>How this backup was created (manual/automatic/etc...) <ul><li>`AUTOMATED`: Backup created by automated daily schedule</li><li>`MANUAL`: Backup created by user request</li></ul>


## ListHosts {#ListHosts}

Retrieves a list of hosts for a cluster.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to list hosts for. <br>To get this ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the API returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in the subsequent [ClusterService.ListHosts](#ListHosts) requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token that can be used to iterate through multiple pages of results. <br>To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by the previous [ClusterService.ListHosts](#ListHosts) request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](#Host)**<br>List of hosts in the cluster. 
next_page_token | **string**<br>The token that can be used to get the next page of results. <br>If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) in the subsequent [ClusterService.ListHosts](#ListHosts) request to iterate through multiple pages of results. <br>Each of the subsequent [ClusterService.ListHosts](#ListHosts) requests should use the `next_page_token` value returned by the previous request to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
name | **string**<br>Name of the host. <br>This name is assigned by the platform at the time of creation. The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. 
cluster_id | **string**<br>ID of the cluster the host belongs to. 
zone_id | **string**<br>ID of the availability zone where the host resides. 
resources | **[Resources](#Resources11)**<br>Resources allocated to the host. 
role | enum **Role**<br>Role of the host in the cluster. <ul><li>`ROLE_UNKNOWN`: Role of the host is unknown.</li><li>`MASTER`: Host is the master.</li><li>`REPLICA`: Host is a replica.</li></ul>
health | enum **Health**<br>Aggregated health of the host. <ul><li>`HEALTH_UNKNOWN`: Health of the host is unknown.</li><li>`ALIVE`: Host is performing all its functions normally.</li><li>`DEAD`: Host is inoperable, and cannot perform any of its essential functions.</li><li>`DEGRADED`: Host is degraded, and can perform only some of its essential functions.</li><li>`READONLY`: Host is alive, but in read-only mode.</li></ul>
services[] | **[Service](#Service)**<br>List of services provided by the host. 
subnet_id | **string**<br>ID of the subnet that the host belongs to. 
assign_public_ip | **bool**<br>Flag that shows if public IP address is assigned to the host so that the host can be accessed from the internet. 
replication_source | **string**<br>Name of the host to be used as the replication source for cascading replication. 
backup_priority | **int64**<br>Host backup priority. Acceptable values are 0 to 100, inclusive.
priority | **int64**<br>Host master promotion priority. Acceptable values are 0 to 100, inclusive.


### Resources {#Resources11}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. <br>All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage (for each cluster host, in bytes). 
disk_type_id | **string**<br>Type of the storage. <br>Possible values: <ul><li>`network-hdd` - standard network storage </li><li>`network-ssd` - fast network storage </li><li>`network-ssd-nonreplicated` - fast network nonreplicated storage </li><li>`local-ssd` - fast local storage. </li></ul><br>See [the documentation](/docs/managed-mysql/concepts/storage) for details. 


### Service {#Service}

Field | Description
--- | ---
type | enum **Type**<br>Type of the service provided by the host. <ul><li>`MYSQL`: The host is a MySQL server.</li></ul>
health | enum **Health**<br>Aggregated health of the service. <ul><li>`HEALTH_UNKNOWN`: Health of the service is unknown.</li><li>`ALIVE`: The service is working normally.</li><li>`DEAD`: The service is dead or unresponsive.</li><li>`READONLY`: The service is in read-only mode.</li></ul>


## AddHosts {#AddHosts}

Adds new hosts in a cluster.

**rpc AddHosts ([AddClusterHostsRequest](#AddClusterHostsRequest)) returns ([operation.Operation](#Operation11))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterHostsMetadata](#AddClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddClusterHostsRequest {#AddClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to add hosts to. <br>To get this ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
host_specs[] | **[HostSpec](#HostSpec)**<br>Configuration of the newly added hosts. The number of elements must be greater than 0.


### HostSpec {#HostSpec2}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. <br>To get a list of available zones, make the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet to assign to the host. <br>This subnet should be a part of the cluster network (the network ID is specified in the [ClusterService.CreateClusterRequest.network_id](./cluster_service#CreateClusterRequest)). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Option that enables public IP address for the host so that the host can be accessed from the internet. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP address, or to assign a public IP address to a host without one, recreate the host with the appropriate `assign_public_ip` value set. <br>Possible values: <ul><li>`false` - don't assign a public IP address to the host. </li><li>`true` - assign a public IP address to the host.</li></ul> 
replication_source | **string**<br>[Host.name](#Host1) of the host to be used as the replication source (for cascading replication). 
backup_priority | **int64**<br>Host backup priority Acceptable values are 0 to 100, inclusive.
priority | **int64**<br>Host master promotion priority Acceptable values are 0 to 100, inclusive.


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
cluster_id | **string**<br>ID of the cluster to which the hosts are being added. 
host_names[] | **string**<br>Names of hosts that are being added. 


## UpdateHosts {#UpdateHosts}

Updates the specified hosts.

**rpc UpdateHosts ([UpdateClusterHostsRequest](#UpdateClusterHostsRequest)) returns ([operation.Operation](#Operation12))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterHostsMetadata](#UpdateClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateClusterHostsRequest {#UpdateClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MySQL cluster to update hosts in. To get the MySQL cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_host_specs[] | **[UpdateHostSpec](#UpdateHostSpec)**<br>New configurations to apply to hosts. The number of elements must be greater than 0.


### UpdateHostSpec {#UpdateHostSpec}

Field | Description
--- | ---
host_name | **string**<br>Required. Name of the host to update. To get a MySQL host name, use a [ClusterService.ListHosts](#ListHosts) request. 
replication_source | **string**<br>[Host.name](#Host1) of the host to be used as the replication source (for cascading replication). To get a MySQL host name, use a [ClusterService.ListHosts](#ListHosts) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which settings of the MySQL host should be updated. 
backup_priority | **int64**<br>Host backup priority. Acceptable values are 0 to 100, inclusive.
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. 
priority | **int64**<br>Host master promotion priority. Acceptable values are 0 to 100, inclusive.


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
cluster_id | **string**<br>ID of the cluster in which the hosts are being updated. 
host_names[] | **string**<br>Names of hosts that are being updated. 


## DeleteHosts {#DeleteHosts}

Deletes the specified hosts for a cluster.

**rpc DeleteHosts ([DeleteClusterHostsRequest](#DeleteClusterHostsRequest)) returns ([operation.Operation](#Operation13))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterHostsMetadata](#DeleteClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterHostsRequest {#DeleteClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to delete hosts from. <br>To get this ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
host_names[] | **string**<br>Names of hosts to delete. <br>To get these names, make a [ClusterService.ListHosts](#ListHosts) request. The number of elements must be greater than 0. The maximum string length in characters for each value is 253.


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
cluster_id | **string**<br>ID of the cluster from which the hosts are being deleted. 
host_names[] | **string**<br>Names of hosts that are being deleted. 


