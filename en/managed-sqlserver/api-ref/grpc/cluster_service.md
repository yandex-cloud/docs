---
editable: false
sourcePath: en/_api-ref-grpc/managed-sqlserver/api-ref/grpc/cluster_service.md
---

# Managed Service for SQL Server API, gRPC: ClusterService

A set of methods for managing SQL Server clusters.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified SQL Server cluster. |
| [List](#List) | Retrieves the list of SQL Server clusters that belong to the specified folder. |
| [Create](#Create) | Creates an SQL Server cluster in the specified folder. |
| [Update](#Update) | Modifies the specified SQL Server cluster. |
| [Delete](#Delete) | Deletes the specified SQL Server cluster. |
| [Start](#Start) | Starts the specified SQL Server cluster. |
| [Stop](#Stop) | Stops the specified SQL Server cluster. |
| [Move](#Move) | Moves the specified SQL Server cluster to the specified folder. |
| [Backup](#Backup) | Creates a backup for the specified SQL Server cluster. |
| [Restore](#Restore) | Creates a new SQL Server cluster using the specified backup. |
| [StartFailover](#StartFailover) | Starts a manual failover for a cluster. |
| [ListLogs](#ListLogs) | Retrieves logs for the specified SQL Server cluster. |
| [ListOperations](#ListOperations) | Retrieves the list of operations for the specified SQL Server cluster. |
| [ListBackups](#ListBackups) | Retrieves the list of available backups for the specified SQL Server cluster. |
| [ListHosts](#ListHosts) | Retrieves the list of hosts for the specified SQL Server cluster. |
| [UpdateHosts](#UpdateHosts) | Updates the specified hosts. |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified SQL Server cluster. <br>To get the list of available SQL Server clusters, make a [List](#List) request.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to return. <br>To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the SQL Server cluster. <br>This ID is assigned by Managed Service for SQL Server at the moment of creation. 
folder_id | **string**<br>ID of the folder the SQL Server cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when SQL Server cluster was created. 
name | **string**<br>Name of the SQL Server cluster. <br>The name must be unique within the folder, comply with [RFC 1035](https://www.ietf.org/rfc/rfc1035.txt) and be 1-63 characters long. 
description | **string**<br>Description of the SQL Server cluster. <br>Must be 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the SQL Server cluster as `key:value` pairs. <br>Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the SQL Server cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring)**<br>Description of monitoring systems relevant to the SQL Server cluster. 
config | **[ClusterConfig](#ClusterConfig)**<br>Configuration of the SQL Server cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and works well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
sqlcollation | **string**<br>SQL Server Collation. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
service_account_id | **string**<br>ID of the service account which is used for access to Object Storage. 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the SQL Server cluster. 


### ClusterConfig {#ClusterConfig}

Field | Description
--- | ---
version | **string**<br>Version of the SQL Server. 
sqlserver_config | **oneof:** `sqlserver_config_2016sp2std`, `sqlserver_config_2016sp2ent`, `sqlserver_config_2017std`, `sqlserver_config_2017ent`, `sqlserver_config_2019std` or `sqlserver_config_2019ent`<br>Configuration of the SQL Server instances in the cluster.
&nbsp;&nbsp;sqlserver_config_2016sp2std | **[config.SQLServerConfigSet2016sp2std](#SQLServerConfigSet2016sp2std)**<br>Configuration of the SQL Server 2016sp2 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2016sp2ent | **[config.SQLServerConfigSet2016sp2ent](#SQLServerConfigSet2016sp2ent)**<br>Configuration of the SQL Server 2016sp2 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2017std | **[config.SQLServerConfigSet2017std](#SQLServerConfigSet2017std)**<br>Configuration of the SQL Server 2017 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2017ent | **[config.SQLServerConfigSet2017ent](#SQLServerConfigSet2017ent)**<br>Configuration of the SQL Server 2017 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2019std | **[config.SQLServerConfigSet2019std](#SQLServerConfigSet2019std)**<br>Configuration of the SQL Server 2019 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2019ent | **[config.SQLServerConfigSet2019ent](#SQLServerConfigSet2019ent)**<br>Configuration of the SQL Server 2019 enterprise edition instance. 
resources | **[Resources](#Resources)**<br>Resources allocated to SQL Server hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Start time for the daily backup in UTC timezone. 
access | **[Access](#Access)**<br>Database access policy. 
secondary_connections | enum **SecondaryConnections**<br>Secondary replicas connection mode <ul><li>`SECONDARY_CONNECTIONS_OFF`: Connections to secondary replicas are prohibited</li><li>`SECONDARY_CONNECTIONS_READ_ONLY`: Secondary replicas are read-only</li></ul>


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). <br>All available presets are listed in the [documentation](/docs/managed-sqlserver/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br>Type of the storage environment for the host. <br>Possible values: <ul><li>`network-hdd` - network HDD drive; </li><li>`network-ssd` - network SSD drive; </li><li>`local-ssd` - local SSD storage.</li></ul> 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access for DataLens. 
web_sql | **bool**<br>Allows access for Web SQL. 


## List {#List}

Retrieves the list of SQL Server clusters that belong to the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list SQL Server clusters in. <br>To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by the previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <br><ol><li>A field name to filter by. Currently you can only use filtering with the [Cluster.name](#Cluster1) field. </li><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>A value. Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`. </li></ol><br>Example of a filter expression: `name NOT IN 'test,beta'`. The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of SQL Server clusters. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest) parameter in the next list request. Each subsequent list request has its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster1}

Field | Description
--- | ---
id | **string**<br>ID of the SQL Server cluster. <br>This ID is assigned by Managed Service for SQL Server at the moment of creation. 
folder_id | **string**<br>ID of the folder the SQL Server cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when SQL Server cluster was created. 
name | **string**<br>Name of the SQL Server cluster. <br>The name must be unique within the folder, comply with [RFC 1035](https://www.ietf.org/rfc/rfc1035.txt) and be 1-63 characters long. 
description | **string**<br>Description of the SQL Server cluster. <br>Must be 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the SQL Server cluster as `key:value` pairs. <br>Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the SQL Server cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Description of monitoring systems relevant to the SQL Server cluster. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Configuration of the SQL Server cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and works well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
sqlcollation | **string**<br>SQL Server Collation. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
service_account_id | **string**<br>ID of the service account which is used for access to Object Storage. 


### Monitoring {#Monitoring1}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the SQL Server cluster. 


### ClusterConfig {#ClusterConfig1}

Field | Description
--- | ---
version | **string**<br>Version of the SQL Server. 
sqlserver_config | **oneof:** `sqlserver_config_2016sp2std`, `sqlserver_config_2016sp2ent`, `sqlserver_config_2017std`, `sqlserver_config_2017ent`, `sqlserver_config_2019std` or `sqlserver_config_2019ent`<br>Configuration of the SQL Server instances in the cluster.
&nbsp;&nbsp;sqlserver_config_2016sp2std | **[config.SQLServerConfigSet2016sp2std](#SQLServerConfigSet2016sp2std)**<br>Configuration of the SQL Server 2016sp2 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2016sp2ent | **[config.SQLServerConfigSet2016sp2ent](#SQLServerConfigSet2016sp2ent)**<br>Configuration of the SQL Server 2016sp2 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2017std | **[config.SQLServerConfigSet2017std](#SQLServerConfigSet2017std)**<br>Configuration of the SQL Server 2017 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2017ent | **[config.SQLServerConfigSet2017ent](#SQLServerConfigSet2017ent)**<br>Configuration of the SQL Server 2017 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2019std | **[config.SQLServerConfigSet2019std](#SQLServerConfigSet2019std)**<br>Configuration of the SQL Server 2019 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2019ent | **[config.SQLServerConfigSet2019ent](#SQLServerConfigSet2019ent)**<br>Configuration of the SQL Server 2019 enterprise edition instance. 
resources | **[Resources](#Resources1)**<br>Resources allocated to SQL Server hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Start time for the daily backup in UTC timezone. 
access | **[Access](#Access1)**<br>Database access policy. 
secondary_connections | enum **SecondaryConnections**<br>Secondary replicas connection mode <ul><li>`SECONDARY_CONNECTIONS_OFF`: Connections to secondary replicas are prohibited</li><li>`SECONDARY_CONNECTIONS_READ_ONLY`: Secondary replicas are read-only</li></ul>


### Resources {#Resources1}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). <br>All available presets are listed in the [documentation](/docs/managed-sqlserver/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br>Type of the storage environment for the host. <br>Possible values: <ul><li>`network-hdd` - network HDD drive; </li><li>`network-ssd` - network SSD drive; </li><li>`local-ssd` - local SSD storage.</li></ul> 


### Access {#Access1}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access for DataLens. 
web_sql | **bool**<br>Allows access for Web SQL. 


## Create {#Create}

Creates an SQL Server cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create the SQL Server cluster in. <br>To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the SQL Server cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the SQL Server cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the SQL Server cluster as `key:value` pairs. For example, "project":"mvp" or "source":"dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Deployment environment of the SQL Server cluster. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Configurations of SQL Server and hosts of the cluster. 
database_specs[] | **[DatabaseSpec](#DatabaseSpec)**<br>One or more configurations of databases to be created in the SQL Server cluster. 
user_specs[] | **[UserSpec](#UserSpec)**<br>One or more configurations of database users to be created in the SQL Server cluster. 
host_specs[] | **[HostSpec](#HostSpec)**<br>One or more configurations of hosts to be created in the SQL Server cluster. 
network_id | **string**<br>ID of the network to create the SQL Server cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
sqlcollation | **string**<br>Name of SQL Collation that cluster will be created with. The maximum string length in characters is 100.
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Version of SQL Server used in the cluster. <br>Possible values: <ul><li>2016sp2std, </li><li>2016sp2ent, </li><li>2017std, </li><li>2017ent, </li><li>2019std, </li><li>2019ent.</li></ul> 
sqlserver_config | **oneof:** `sqlserver_config_2016sp2std`, `sqlserver_config_2016sp2ent`, `sqlserver_config_2017std`, `sqlserver_config_2017ent`, `sqlserver_config_2019std` or `sqlserver_config_2019ent`<br>Configuration of an SQL Server cluster.
&nbsp;&nbsp;sqlserver_config_2016sp2std | **[config.SQLServerConfig2016sp2std](#SQLServerConfig2016sp2std)**<br>Configuration for an SQL Server 2016 SP2 Standard edition cluster. 
&nbsp;&nbsp;sqlserver_config_2016sp2ent | **[config.SQLServerConfig2016sp2ent](#SQLServerConfig2016sp2ent)**<br>Configuration for an SQL Server 2016 SP2 Enterprise edition cluster. 
&nbsp;&nbsp;sqlserver_config_2017std | **[config.SQLServerConfig2017std](#SQLServerConfig2017std)**<br>Configuration for an SQL Server 2017 Standard edition cluster. 
&nbsp;&nbsp;sqlserver_config_2017ent | **[config.SQLServerConfig2017ent](#SQLServerConfig2017ent)**<br>Configuration for an SQL Server 2017 Enterprise edition cluster. 
&nbsp;&nbsp;sqlserver_config_2019std | **[config.SQLServerConfig2019std](#SQLServerConfig2019std)**<br>Configuration for an SQL Server 2019 Standard edition cluster. 
&nbsp;&nbsp;sqlserver_config_2019ent | **[config.SQLServerConfig2019ent](#SQLServerConfig2019ent)**<br>Configuration for an SQL Server 2019 Enterprise edition cluster. 
resources | **[Resources](#Resources2)**<br>Resources allocated to SQL Server hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Start time for the daily backup in UTC timezone. 
access | **[Access](#Access2)**<br>Database access policy. 
secondary_connections | **[ClusterConfig.SecondaryConnections](#ClusterConfig2)**<br>Secondary replicas connection mode 


### Resources {#Resources2}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). <br>All available presets are listed in the [documentation](/docs/managed-sqlserver/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br>Type of the storage environment for the host. <br>Possible values: <ul><li>`network-hdd` - network HDD drive; </li><li>`network-ssd` - network SSD drive; </li><li>`local-ssd` - local SSD storage.</li></ul> 


### Access {#Access2}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access for DataLens. 
web_sql | **bool**<br>Allows access for Web SQL. 


### DatabaseSpec {#DatabaseSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the database. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the SQL Server user. The maximum string length in characters is 32. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Required. Password of the SQL Server user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission)**<br>Set of permissions to grant to the user. 
server_roles[] | enum **ServerRole**<br>Set of server roles. <ul><li>`MDB_MONITOR`: Effectively grants VIEW SERVER STATE to the login. <br>That gives an ability to use various dynamic management views to monitor server state, including Activity Monitor tool that is built-in into SSMS. <br>No intrusive actions are allowed, so this is pretty safe to grant.</li></ul>


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database the permission grants access to. 
roles[] | enum **Role**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`DB_OWNER`: Members of this fixed database role can perform all configuration and maintenance activities on a database and can also drop a database in SQL Server.</li><li>`DB_SECURITYADMIN`: Members of this fixed database role can modify role membership for custom roles only and manage permissions. They can potentially elevate their privileges and their actions should be monitored.</li><li>`DB_ACCESSADMIN`: Members of this fixed database role can add or remove access to a database for Windows logins, Windows groups, and SQL Server logins.</li><li>`DB_BACKUPOPERATOR`: Members of this fixed database role can back up the database.</li><li>`DB_DDLADMIN`: Members of this fixed database role can run any Data Definition Language (DDL) command in a database.</li><li>`DB_DATAWRITER`: Members of this fixed database role can add, delete, or change data in all user tables.</li><li>`DB_DATAREADER`: Members of this fixed database role can read all data from all user tables.</li><li>`DB_DENYDATAWRITER`: Members of this fixed database role cannot add, modify, or delete any data in the user tables within a database. A denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li><li>`DB_DENYDATAREADER`: Members of this fixed database role cannot read any data in the user tables within a database. A denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li></ul>


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. <br>To get the list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. <br>The ID of the network is set in the field [Cluster.network_id](#Cluster2). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Determines whether the host gets a public IP address on creation. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed. <br>Possible values: <ul><li>`false` - do not assign a public IP to the host; </li><li>`true` - assign a public IP to the host.</li></ul> 


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
cluster_id | **string**<br>ID of the SQL Server cluster being created. 


### Cluster {#Cluster2}

Field | Description
--- | ---
id | **string**<br>ID of the SQL Server cluster. <br>This ID is assigned by Managed Service for SQL Server at the moment of creation. 
folder_id | **string**<br>ID of the folder the SQL Server cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when SQL Server cluster was created. 
name | **string**<br>Name of the SQL Server cluster. <br>The name must be unique within the folder, comply with [RFC 1035](https://www.ietf.org/rfc/rfc1035.txt) and be 1-63 characters long. 
description | **string**<br>Description of the SQL Server cluster. <br>Must be 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the SQL Server cluster as `key:value` pairs. <br>Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the SQL Server cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the SQL Server cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the SQL Server cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and works well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
sqlcollation | **string**<br>SQL Server Collation. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
service_account_id | **string**<br>ID of the service account which is used for access to Object Storage. 


### Monitoring {#Monitoring2}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the SQL Server cluster. 


### ClusterConfig {#ClusterConfig2}

Field | Description
--- | ---
version | **string**<br>Version of the SQL Server. 
sqlserver_config | **oneof:** `sqlserver_config_2016sp2std`, `sqlserver_config_2016sp2ent`, `sqlserver_config_2017std`, `sqlserver_config_2017ent`, `sqlserver_config_2019std` or `sqlserver_config_2019ent`<br>Configuration of the SQL Server instances in the cluster.
&nbsp;&nbsp;sqlserver_config_2016sp2std | **[config.SQLServerConfigSet2016sp2std](#SQLServerConfigSet2016sp2std)**<br>Configuration of the SQL Server 2016sp2 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2016sp2ent | **[config.SQLServerConfigSet2016sp2ent](#SQLServerConfigSet2016sp2ent)**<br>Configuration of the SQL Server 2016sp2 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2017std | **[config.SQLServerConfigSet2017std](#SQLServerConfigSet2017std)**<br>Configuration of the SQL Server 2017 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2017ent | **[config.SQLServerConfigSet2017ent](#SQLServerConfigSet2017ent)**<br>Configuration of the SQL Server 2017 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2019std | **[config.SQLServerConfigSet2019std](#SQLServerConfigSet2019std)**<br>Configuration of the SQL Server 2019 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2019ent | **[config.SQLServerConfigSet2019ent](#SQLServerConfigSet2019ent)**<br>Configuration of the SQL Server 2019 enterprise edition instance. 
resources | **[Resources](#Resources3)**<br>Resources allocated to SQL Server hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Start time for the daily backup in UTC timezone. 
access | **[Access](#Access3)**<br>Database access policy. 
secondary_connections | enum **SecondaryConnections**<br>Secondary replicas connection mode <ul><li>`SECONDARY_CONNECTIONS_OFF`: Connections to secondary replicas are prohibited</li><li>`SECONDARY_CONNECTIONS_READ_ONLY`: Secondary replicas are read-only</li></ul>


## Update {#Update}

Modifies the specified SQL Server cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to update. <br>To get the SQL Server cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the SQL Server cluster should be updated. 
description | **string**<br>New description of the SQL Server cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the SQL Server cluster as `key:value` pairs. <br>For example, `"project":"mvp"` or `"source":"dictionary"`. <br>The new set of labels completely replaces the old one. <br>To add a label, request the current set with the [ClusterService.Get](#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec)**<br>New configuration and resources for hosts in the SQL Server cluster. 
name | **string**<br>New name for the SQL Server cluster. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 


### ConfigSpec {#ConfigSpec1}

Field | Description
--- | ---
version | **string**<br>Version of SQL Server used in the cluster. <br>Possible values: <ul><li>2016sp2std, </li><li>2016sp2ent, </li><li>2017std, </li><li>2017ent, </li><li>2019std, </li><li>2019ent.</li></ul> 
sqlserver_config | **oneof:** `sqlserver_config_2016sp2std`, `sqlserver_config_2016sp2ent`, `sqlserver_config_2017std`, `sqlserver_config_2017ent`, `sqlserver_config_2019std` or `sqlserver_config_2019ent`<br>Configuration of an SQL Server cluster.
&nbsp;&nbsp;sqlserver_config_2016sp2std | **[config.SQLServerConfig2016sp2std](#SQLServerConfig2016sp2std)**<br>Configuration for an SQL Server 2016 SP2 Standard edition cluster. 
&nbsp;&nbsp;sqlserver_config_2016sp2ent | **[config.SQLServerConfig2016sp2ent](#SQLServerConfig2016sp2ent)**<br>Configuration for an SQL Server 2016 SP2 Enterprise edition cluster. 
&nbsp;&nbsp;sqlserver_config_2017std | **[config.SQLServerConfig2017std](#SQLServerConfig2017std)**<br>Configuration for an SQL Server 2017 Standard edition cluster. 
&nbsp;&nbsp;sqlserver_config_2017ent | **[config.SQLServerConfig2017ent](#SQLServerConfig2017ent)**<br>Configuration for an SQL Server 2017 Enterprise edition cluster. 
&nbsp;&nbsp;sqlserver_config_2019std | **[config.SQLServerConfig2019std](#SQLServerConfig2019std)**<br>Configuration for an SQL Server 2019 Standard edition cluster. 
&nbsp;&nbsp;sqlserver_config_2019ent | **[config.SQLServerConfig2019ent](#SQLServerConfig2019ent)**<br>Configuration for an SQL Server 2019 Enterprise edition cluster. 
resources | **[Resources](#Resources3)**<br>Resources allocated to SQL Server hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Start time for the daily backup in UTC timezone. 
access | **[Access](#Access3)**<br>Database access policy. 
secondary_connections | **[ClusterConfig.SecondaryConnections](#ClusterConfig3)**<br>Secondary replicas connection mode 


### Resources {#Resources3}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). <br>All available presets are listed in the [documentation](/docs/managed-sqlserver/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br>Type of the storage environment for the host. <br>Possible values: <ul><li>`network-hdd` - network HDD drive; </li><li>`network-ssd` - network SSD drive; </li><li>`local-ssd` - local SSD storage.</li></ul> 


### Access {#Access3}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access for DataLens. 
web_sql | **bool**<br>Allows access for Web SQL. 


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
cluster_id | **string**<br>ID of the SQL Server cluster being updated. 


### Cluster {#Cluster3}

Field | Description
--- | ---
id | **string**<br>ID of the SQL Server cluster. <br>This ID is assigned by Managed Service for SQL Server at the moment of creation. 
folder_id | **string**<br>ID of the folder the SQL Server cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when SQL Server cluster was created. 
name | **string**<br>Name of the SQL Server cluster. <br>The name must be unique within the folder, comply with [RFC 1035](https://www.ietf.org/rfc/rfc1035.txt) and be 1-63 characters long. 
description | **string**<br>Description of the SQL Server cluster. <br>Must be 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the SQL Server cluster as `key:value` pairs. <br>Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the SQL Server cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Description of monitoring systems relevant to the SQL Server cluster. 
config | **[ClusterConfig](#ClusterConfig3)**<br>Configuration of the SQL Server cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and works well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
sqlcollation | **string**<br>SQL Server Collation. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
service_account_id | **string**<br>ID of the service account which is used for access to Object Storage. 


### Monitoring {#Monitoring3}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the SQL Server cluster. 


### ClusterConfig {#ClusterConfig3}

Field | Description
--- | ---
version | **string**<br>Version of the SQL Server. 
sqlserver_config | **oneof:** `sqlserver_config_2016sp2std`, `sqlserver_config_2016sp2ent`, `sqlserver_config_2017std`, `sqlserver_config_2017ent`, `sqlserver_config_2019std` or `sqlserver_config_2019ent`<br>Configuration of the SQL Server instances in the cluster.
&nbsp;&nbsp;sqlserver_config_2016sp2std | **[config.SQLServerConfigSet2016sp2std](#SQLServerConfigSet2016sp2std)**<br>Configuration of the SQL Server 2016sp2 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2016sp2ent | **[config.SQLServerConfigSet2016sp2ent](#SQLServerConfigSet2016sp2ent)**<br>Configuration of the SQL Server 2016sp2 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2017std | **[config.SQLServerConfigSet2017std](#SQLServerConfigSet2017std)**<br>Configuration of the SQL Server 2017 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2017ent | **[config.SQLServerConfigSet2017ent](#SQLServerConfigSet2017ent)**<br>Configuration of the SQL Server 2017 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2019std | **[config.SQLServerConfigSet2019std](#SQLServerConfigSet2019std)**<br>Configuration of the SQL Server 2019 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2019ent | **[config.SQLServerConfigSet2019ent](#SQLServerConfigSet2019ent)**<br>Configuration of the SQL Server 2019 enterprise edition instance. 
resources | **[Resources](#Resources4)**<br>Resources allocated to SQL Server hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Start time for the daily backup in UTC timezone. 
access | **[Access](#Access4)**<br>Database access policy. 
secondary_connections | enum **SecondaryConnections**<br>Secondary replicas connection mode <ul><li>`SECONDARY_CONNECTIONS_OFF`: Connections to secondary replicas are prohibited</li><li>`SECONDARY_CONNECTIONS_READ_ONLY`: Secondary replicas are read-only</li></ul>


## Delete {#Delete}

Deletes the specified SQL Server cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to delete. <br>To get the SQL Server cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the SQL Server cluster being deleted. 


## Start {#Start}

Starts the specified SQL Server cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to start. <br>To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the SQL Server cluster being started. 


### Cluster {#Cluster4}

Field | Description
--- | ---
id | **string**<br>ID of the SQL Server cluster. <br>This ID is assigned by Managed Service for SQL Server at the moment of creation. 
folder_id | **string**<br>ID of the folder the SQL Server cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when SQL Server cluster was created. 
name | **string**<br>Name of the SQL Server cluster. <br>The name must be unique within the folder, comply with [RFC 1035](https://www.ietf.org/rfc/rfc1035.txt) and be 1-63 characters long. 
description | **string**<br>Description of the SQL Server cluster. <br>Must be 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the SQL Server cluster as `key:value` pairs. <br>Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the SQL Server cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Description of monitoring systems relevant to the SQL Server cluster. 
config | **[ClusterConfig](#ClusterConfig4)**<br>Configuration of the SQL Server cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and works well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
sqlcollation | **string**<br>SQL Server Collation. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
service_account_id | **string**<br>ID of the service account which is used for access to Object Storage. 


### Monitoring {#Monitoring4}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the SQL Server cluster. 


### ClusterConfig {#ClusterConfig4}

Field | Description
--- | ---
version | **string**<br>Version of the SQL Server. 
sqlserver_config | **oneof:** `sqlserver_config_2016sp2std`, `sqlserver_config_2016sp2ent`, `sqlserver_config_2017std`, `sqlserver_config_2017ent`, `sqlserver_config_2019std` or `sqlserver_config_2019ent`<br>Configuration of the SQL Server instances in the cluster.
&nbsp;&nbsp;sqlserver_config_2016sp2std | **[config.SQLServerConfigSet2016sp2std](#SQLServerConfigSet2016sp2std)**<br>Configuration of the SQL Server 2016sp2 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2016sp2ent | **[config.SQLServerConfigSet2016sp2ent](#SQLServerConfigSet2016sp2ent)**<br>Configuration of the SQL Server 2016sp2 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2017std | **[config.SQLServerConfigSet2017std](#SQLServerConfigSet2017std)**<br>Configuration of the SQL Server 2017 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2017ent | **[config.SQLServerConfigSet2017ent](#SQLServerConfigSet2017ent)**<br>Configuration of the SQL Server 2017 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2019std | **[config.SQLServerConfigSet2019std](#SQLServerConfigSet2019std)**<br>Configuration of the SQL Server 2019 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2019ent | **[config.SQLServerConfigSet2019ent](#SQLServerConfigSet2019ent)**<br>Configuration of the SQL Server 2019 enterprise edition instance. 
resources | **[Resources](#Resources4)**<br>Resources allocated to SQL Server hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Start time for the daily backup in UTC timezone. 
access | **[Access](#Access4)**<br>Database access policy. 
secondary_connections | enum **SecondaryConnections**<br>Secondary replicas connection mode <ul><li>`SECONDARY_CONNECTIONS_OFF`: Connections to secondary replicas are prohibited</li><li>`SECONDARY_CONNECTIONS_READ_ONLY`: Secondary replicas are read-only</li></ul>


### Resources {#Resources4}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). <br>All available presets are listed in the [documentation](/docs/managed-sqlserver/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br>Type of the storage environment for the host. <br>Possible values: <ul><li>`network-hdd` - network HDD drive; </li><li>`network-ssd` - network SSD drive; </li><li>`local-ssd` - local SSD storage.</li></ul> 


### Access {#Access4}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access for DataLens. 
web_sql | **bool**<br>Allows access for Web SQL. 


## Stop {#Stop}

Stops the specified SQL Server cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to stop. <br>To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the SQL Server cluster being stopped. 


### Cluster {#Cluster5}

Field | Description
--- | ---
id | **string**<br>ID of the SQL Server cluster. <br>This ID is assigned by Managed Service for SQL Server at the moment of creation. 
folder_id | **string**<br>ID of the folder the SQL Server cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when SQL Server cluster was created. 
name | **string**<br>Name of the SQL Server cluster. <br>The name must be unique within the folder, comply with [RFC 1035](https://www.ietf.org/rfc/rfc1035.txt) and be 1-63 characters long. 
description | **string**<br>Description of the SQL Server cluster. <br>Must be 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the SQL Server cluster as `key:value` pairs. <br>Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the SQL Server cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Description of monitoring systems relevant to the SQL Server cluster. 
config | **[ClusterConfig](#ClusterConfig5)**<br>Configuration of the SQL Server cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and works well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
sqlcollation | **string**<br>SQL Server Collation. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
service_account_id | **string**<br>ID of the service account which is used for access to Object Storage. 


### Monitoring {#Monitoring5}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the SQL Server cluster. 


### ClusterConfig {#ClusterConfig5}

Field | Description
--- | ---
version | **string**<br>Version of the SQL Server. 
sqlserver_config | **oneof:** `sqlserver_config_2016sp2std`, `sqlserver_config_2016sp2ent`, `sqlserver_config_2017std`, `sqlserver_config_2017ent`, `sqlserver_config_2019std` or `sqlserver_config_2019ent`<br>Configuration of the SQL Server instances in the cluster.
&nbsp;&nbsp;sqlserver_config_2016sp2std | **[config.SQLServerConfigSet2016sp2std](#SQLServerConfigSet2016sp2std)**<br>Configuration of the SQL Server 2016sp2 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2016sp2ent | **[config.SQLServerConfigSet2016sp2ent](#SQLServerConfigSet2016sp2ent)**<br>Configuration of the SQL Server 2016sp2 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2017std | **[config.SQLServerConfigSet2017std](#SQLServerConfigSet2017std)**<br>Configuration of the SQL Server 2017 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2017ent | **[config.SQLServerConfigSet2017ent](#SQLServerConfigSet2017ent)**<br>Configuration of the SQL Server 2017 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2019std | **[config.SQLServerConfigSet2019std](#SQLServerConfigSet2019std)**<br>Configuration of the SQL Server 2019 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2019ent | **[config.SQLServerConfigSet2019ent](#SQLServerConfigSet2019ent)**<br>Configuration of the SQL Server 2019 enterprise edition instance. 
resources | **[Resources](#Resources5)**<br>Resources allocated to SQL Server hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Start time for the daily backup in UTC timezone. 
access | **[Access](#Access5)**<br>Database access policy. 
secondary_connections | enum **SecondaryConnections**<br>Secondary replicas connection mode <ul><li>`SECONDARY_CONNECTIONS_OFF`: Connections to secondary replicas are prohibited</li><li>`SECONDARY_CONNECTIONS_READ_ONLY`: Secondary replicas are read-only</li></ul>


### Resources {#Resources5}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). <br>All available presets are listed in the [documentation](/docs/managed-sqlserver/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br>Type of the storage environment for the host. <br>Possible values: <ul><li>`network-hdd` - network HDD drive; </li><li>`network-ssd` - network SSD drive; </li><li>`local-ssd` - local SSD storage.</li></ul> 


### Access {#Access5}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access for DataLens. 
web_sql | **bool**<br>Allows access for Web SQL. 


## Move {#Move}

Moves the specified SQL Server cluster to the specified folder.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### MoveClusterRequest {#MoveClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to move. <br>To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
destination_folder_id | **string**<br>Required. ID of the destination folder. <br>To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the SQL Server cluster being moved. 
source_folder_id | **string**<br>ID of the source folder. 
destination_folder_id | **string**<br>ID of the destination folder. 


### Cluster {#Cluster6}

Field | Description
--- | ---
id | **string**<br>ID of the SQL Server cluster. <br>This ID is assigned by Managed Service for SQL Server at the moment of creation. 
folder_id | **string**<br>ID of the folder the SQL Server cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when SQL Server cluster was created. 
name | **string**<br>Name of the SQL Server cluster. <br>The name must be unique within the folder, comply with [RFC 1035](https://www.ietf.org/rfc/rfc1035.txt) and be 1-63 characters long. 
description | **string**<br>Description of the SQL Server cluster. <br>Must be 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the SQL Server cluster as `key:value` pairs. <br>Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the SQL Server cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring6)**<br>Description of monitoring systems relevant to the SQL Server cluster. 
config | **[ClusterConfig](#ClusterConfig6)**<br>Configuration of the SQL Server cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and works well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
sqlcollation | **string**<br>SQL Server Collation. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
service_account_id | **string**<br>ID of the service account which is used for access to Object Storage. 


### Monitoring {#Monitoring6}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the SQL Server cluster. 


### ClusterConfig {#ClusterConfig6}

Field | Description
--- | ---
version | **string**<br>Version of the SQL Server. 
sqlserver_config | **oneof:** `sqlserver_config_2016sp2std`, `sqlserver_config_2016sp2ent`, `sqlserver_config_2017std`, `sqlserver_config_2017ent`, `sqlserver_config_2019std` or `sqlserver_config_2019ent`<br>Configuration of the SQL Server instances in the cluster.
&nbsp;&nbsp;sqlserver_config_2016sp2std | **[config.SQLServerConfigSet2016sp2std](#SQLServerConfigSet2016sp2std)**<br>Configuration of the SQL Server 2016sp2 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2016sp2ent | **[config.SQLServerConfigSet2016sp2ent](#SQLServerConfigSet2016sp2ent)**<br>Configuration of the SQL Server 2016sp2 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2017std | **[config.SQLServerConfigSet2017std](#SQLServerConfigSet2017std)**<br>Configuration of the SQL Server 2017 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2017ent | **[config.SQLServerConfigSet2017ent](#SQLServerConfigSet2017ent)**<br>Configuration of the SQL Server 2017 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2019std | **[config.SQLServerConfigSet2019std](#SQLServerConfigSet2019std)**<br>Configuration of the SQL Server 2019 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2019ent | **[config.SQLServerConfigSet2019ent](#SQLServerConfigSet2019ent)**<br>Configuration of the SQL Server 2019 enterprise edition instance. 
resources | **[Resources](#Resources6)**<br>Resources allocated to SQL Server hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Start time for the daily backup in UTC timezone. 
access | **[Access](#Access6)**<br>Database access policy. 
secondary_connections | enum **SecondaryConnections**<br>Secondary replicas connection mode <ul><li>`SECONDARY_CONNECTIONS_OFF`: Connections to secondary replicas are prohibited</li><li>`SECONDARY_CONNECTIONS_READ_ONLY`: Secondary replicas are read-only</li></ul>


### Resources {#Resources6}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). <br>All available presets are listed in the [documentation](/docs/managed-sqlserver/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br>Type of the storage environment for the host. <br>Possible values: <ul><li>`network-hdd` - network HDD drive; </li><li>`network-ssd` - network SSD drive; </li><li>`local-ssd` - local SSD storage.</li></ul> 


### Access {#Access6}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access for DataLens. 
web_sql | **bool**<br>Allows access for Web SQL. 


## Backup {#Backup}

Creates a backup for the specified SQL Server cluster.

**rpc Backup ([BackupClusterRequest](#BackupClusterRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupClusterMetadata](#BackupClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster7)<br>

### BackupClusterRequest {#BackupClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to back up. <br>To get the SQL Server cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the SQL Server cluster being backed up. 


### Cluster {#Cluster7}

Field | Description
--- | ---
id | **string**<br>ID of the SQL Server cluster. <br>This ID is assigned by Managed Service for SQL Server at the moment of creation. 
folder_id | **string**<br>ID of the folder the SQL Server cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when SQL Server cluster was created. 
name | **string**<br>Name of the SQL Server cluster. <br>The name must be unique within the folder, comply with [RFC 1035](https://www.ietf.org/rfc/rfc1035.txt) and be 1-63 characters long. 
description | **string**<br>Description of the SQL Server cluster. <br>Must be 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the SQL Server cluster as `key:value` pairs. <br>Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the SQL Server cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring7)**<br>Description of monitoring systems relevant to the SQL Server cluster. 
config | **[ClusterConfig](#ClusterConfig7)**<br>Configuration of the SQL Server cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and works well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
sqlcollation | **string**<br>SQL Server Collation. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
service_account_id | **string**<br>ID of the service account which is used for access to Object Storage. 


### Monitoring {#Monitoring7}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the SQL Server cluster. 


### ClusterConfig {#ClusterConfig7}

Field | Description
--- | ---
version | **string**<br>Version of the SQL Server. 
sqlserver_config | **oneof:** `sqlserver_config_2016sp2std`, `sqlserver_config_2016sp2ent`, `sqlserver_config_2017std`, `sqlserver_config_2017ent`, `sqlserver_config_2019std` or `sqlserver_config_2019ent`<br>Configuration of the SQL Server instances in the cluster.
&nbsp;&nbsp;sqlserver_config_2016sp2std | **[config.SQLServerConfigSet2016sp2std](#SQLServerConfigSet2016sp2std)**<br>Configuration of the SQL Server 2016sp2 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2016sp2ent | **[config.SQLServerConfigSet2016sp2ent](#SQLServerConfigSet2016sp2ent)**<br>Configuration of the SQL Server 2016sp2 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2017std | **[config.SQLServerConfigSet2017std](#SQLServerConfigSet2017std)**<br>Configuration of the SQL Server 2017 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2017ent | **[config.SQLServerConfigSet2017ent](#SQLServerConfigSet2017ent)**<br>Configuration of the SQL Server 2017 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2019std | **[config.SQLServerConfigSet2019std](#SQLServerConfigSet2019std)**<br>Configuration of the SQL Server 2019 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2019ent | **[config.SQLServerConfigSet2019ent](#SQLServerConfigSet2019ent)**<br>Configuration of the SQL Server 2019 enterprise edition instance. 
resources | **[Resources](#Resources7)**<br>Resources allocated to SQL Server hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Start time for the daily backup in UTC timezone. 
access | **[Access](#Access7)**<br>Database access policy. 
secondary_connections | enum **SecondaryConnections**<br>Secondary replicas connection mode <ul><li>`SECONDARY_CONNECTIONS_OFF`: Connections to secondary replicas are prohibited</li><li>`SECONDARY_CONNECTIONS_READ_ONLY`: Secondary replicas are read-only</li></ul>


### Resources {#Resources7}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). <br>All available presets are listed in the [documentation](/docs/managed-sqlserver/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br>Type of the storage environment for the host. <br>Possible values: <ul><li>`network-hdd` - network HDD drive; </li><li>`network-ssd` - network SSD drive; </li><li>`local-ssd` - local SSD storage.</li></ul> 


### Access {#Access7}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access for DataLens. 
web_sql | **bool**<br>Allows access for Web SQL. 


## Restore {#Restore}

Creates a new SQL Server cluster using the specified backup.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster8)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. ID of the backup to create a new cluster from. <br>To get the backup ID, use a [ClusterService.ListBackups](#ListBackups) request. 
time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the moment to which the SQL Server cluster should be restored. 
name | **string**<br>Required. Name of the new SQL Server cluster to be created from the backup. The name must be unique within the folder. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the new SQL Server cluster to be created from the backup. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the new SQL Server cluster to be created from the backup as `key:value` pairs. <br>For example, `"project":"mvp"` or `"source":"dictionary"`. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster8)**<br>Deployment environment of the new SQL Server cluster to be created from the backup. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Configuration for the new SQL Server cluster to be created from the backup. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Configurations for SQL Server hosts that should be added to the cluster being created from the backup. 
network_id | **string**<br>ID of the network to create the SQL Server cluster in. The maximum string length in characters is 50.
folder_id | **string**<br>ID of the folder to create the SQL Server cluster in. <br>To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 


### ConfigSpec {#ConfigSpec2}

Field | Description
--- | ---
version | **string**<br>Version of SQL Server used in the cluster. <br>Possible values: <ul><li>2016sp2std, </li><li>2016sp2ent, </li><li>2017std, </li><li>2017ent, </li><li>2019std, </li><li>2019ent.</li></ul> 
sqlserver_config | **oneof:** `sqlserver_config_2016sp2std`, `sqlserver_config_2016sp2ent`, `sqlserver_config_2017std`, `sqlserver_config_2017ent`, `sqlserver_config_2019std` or `sqlserver_config_2019ent`<br>Configuration of an SQL Server cluster.
&nbsp;&nbsp;sqlserver_config_2016sp2std | **[config.SQLServerConfig2016sp2std](#SQLServerConfig2016sp2std)**<br>Configuration for an SQL Server 2016 SP2 Standard edition cluster. 
&nbsp;&nbsp;sqlserver_config_2016sp2ent | **[config.SQLServerConfig2016sp2ent](#SQLServerConfig2016sp2ent)**<br>Configuration for an SQL Server 2016 SP2 Enterprise edition cluster. 
&nbsp;&nbsp;sqlserver_config_2017std | **[config.SQLServerConfig2017std](#SQLServerConfig2017std)**<br>Configuration for an SQL Server 2017 Standard edition cluster. 
&nbsp;&nbsp;sqlserver_config_2017ent | **[config.SQLServerConfig2017ent](#SQLServerConfig2017ent)**<br>Configuration for an SQL Server 2017 Enterprise edition cluster. 
&nbsp;&nbsp;sqlserver_config_2019std | **[config.SQLServerConfig2019std](#SQLServerConfig2019std)**<br>Configuration for an SQL Server 2019 Standard edition cluster. 
&nbsp;&nbsp;sqlserver_config_2019ent | **[config.SQLServerConfig2019ent](#SQLServerConfig2019ent)**<br>Configuration for an SQL Server 2019 Enterprise edition cluster. 
resources | **[Resources](#Resources8)**<br>Resources allocated to SQL Server hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Start time for the daily backup in UTC timezone. 
access | **[Access](#Access8)**<br>Database access policy. 
secondary_connections | **[ClusterConfig.SecondaryConnections](#ClusterConfig8)**<br>Secondary replicas connection mode 


### Resources {#Resources8}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). <br>All available presets are listed in the [documentation](/docs/managed-sqlserver/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br>Type of the storage environment for the host. <br>Possible values: <ul><li>`network-hdd` - network HDD drive; </li><li>`network-ssd` - network SSD drive; </li><li>`local-ssd` - local SSD storage.</li></ul> 


### Access {#Access8}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access for DataLens. 
web_sql | **bool**<br>Allows access for Web SQL. 


### HostSpec {#HostSpec1}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. <br>To get the list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. <br>The ID of the network is set in the field [Cluster.network_id](#Cluster8). The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Determines whether the host gets a public IP address on creation. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed. <br>Possible values: <ul><li>`false` - do not assign a public IP to the host; </li><li>`true` - assign a public IP to the host.</li></ul> 


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
cluster_id | **string**<br>ID of the new SQL Server cluster being created from a backup. 
backup_id | **string**<br>ID of the backup being used for creating a cluster. 


### Cluster {#Cluster8}

Field | Description
--- | ---
id | **string**<br>ID of the SQL Server cluster. <br>This ID is assigned by Managed Service for SQL Server at the moment of creation. 
folder_id | **string**<br>ID of the folder the SQL Server cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when SQL Server cluster was created. 
name | **string**<br>Name of the SQL Server cluster. <br>The name must be unique within the folder, comply with [RFC 1035](https://www.ietf.org/rfc/rfc1035.txt) and be 1-63 characters long. 
description | **string**<br>Description of the SQL Server cluster. <br>Must be 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the SQL Server cluster as `key:value` pairs. <br>Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the SQL Server cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring8)**<br>Description of monitoring systems relevant to the SQL Server cluster. 
config | **[ClusterConfig](#ClusterConfig8)**<br>Configuration of the SQL Server cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and works well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
sqlcollation | **string**<br>SQL Server Collation. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
service_account_id | **string**<br>ID of the service account which is used for access to Object Storage. 


### Monitoring {#Monitoring8}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the SQL Server cluster. 


### ClusterConfig {#ClusterConfig8}

Field | Description
--- | ---
version | **string**<br>Version of the SQL Server. 
sqlserver_config | **oneof:** `sqlserver_config_2016sp2std`, `sqlserver_config_2016sp2ent`, `sqlserver_config_2017std`, `sqlserver_config_2017ent`, `sqlserver_config_2019std` or `sqlserver_config_2019ent`<br>Configuration of the SQL Server instances in the cluster.
&nbsp;&nbsp;sqlserver_config_2016sp2std | **[config.SQLServerConfigSet2016sp2std](#SQLServerConfigSet2016sp2std)**<br>Configuration of the SQL Server 2016sp2 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2016sp2ent | **[config.SQLServerConfigSet2016sp2ent](#SQLServerConfigSet2016sp2ent)**<br>Configuration of the SQL Server 2016sp2 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2017std | **[config.SQLServerConfigSet2017std](#SQLServerConfigSet2017std)**<br>Configuration of the SQL Server 2017 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2017ent | **[config.SQLServerConfigSet2017ent](#SQLServerConfigSet2017ent)**<br>Configuration of the SQL Server 2017 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2019std | **[config.SQLServerConfigSet2019std](#SQLServerConfigSet2019std)**<br>Configuration of the SQL Server 2019 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2019ent | **[config.SQLServerConfigSet2019ent](#SQLServerConfigSet2019ent)**<br>Configuration of the SQL Server 2019 enterprise edition instance. 
resources | **[Resources](#Resources9)**<br>Resources allocated to SQL Server hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Start time for the daily backup in UTC timezone. 
access | **[Access](#Access9)**<br>Database access policy. 
secondary_connections | enum **SecondaryConnections**<br>Secondary replicas connection mode <ul><li>`SECONDARY_CONNECTIONS_OFF`: Connections to secondary replicas are prohibited</li><li>`SECONDARY_CONNECTIONS_READ_ONLY`: Secondary replicas are read-only</li></ul>


## StartFailover {#StartFailover}

Starts a manual failover for a cluster.

**rpc StartFailover ([StartClusterFailoverRequest](#StartClusterFailoverRequest)) returns ([operation.Operation](#Operation8))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterFailoverMetadata](#StartClusterFailoverMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster9)<br>

### StartClusterFailoverRequest {#StartClusterFailoverRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of SQL Server cluster. The maximum string length in characters is 50.
host_name | **string**<br>Host name to switch master role to. <br>To get this name, make a [ClusterService.ListHosts](#ListHosts) request. The maximum string length in characters is 253.


### Operation {#Operation8}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster9)>**<br>if operation finished successfully. 


### StartClusterFailoverMetadata {#StartClusterFailoverMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the SQL Server cluster being failovered. 


### Cluster {#Cluster9}

Field | Description
--- | ---
id | **string**<br>ID of the SQL Server cluster. <br>This ID is assigned by Managed Service for SQL Server at the moment of creation. 
folder_id | **string**<br>ID of the folder the SQL Server cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when SQL Server cluster was created. 
name | **string**<br>Name of the SQL Server cluster. <br>The name must be unique within the folder, comply with [RFC 1035](https://www.ietf.org/rfc/rfc1035.txt) and be 1-63 characters long. 
description | **string**<br>Description of the SQL Server cluster. <br>Must be 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the SQL Server cluster as `key:value` pairs. <br>Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the SQL Server cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring9)**<br>Description of monitoring systems relevant to the SQL Server cluster. 
config | **[ClusterConfig](#ClusterConfig9)**<br>Configuration of the SQL Server cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: Cluster is alive and works well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: Cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
sqlcollation | **string**<br>SQL Server Collation. 
host_group_ids[] | **string**<br>Host groups hosting VMs of the cluster. 
service_account_id | **string**<br>ID of the service account which is used for access to Object Storage. 


### Monitoring {#Monitoring9}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the SQL Server cluster. 


### ClusterConfig {#ClusterConfig9}

Field | Description
--- | ---
version | **string**<br>Version of the SQL Server. 
sqlserver_config | **oneof:** `sqlserver_config_2016sp2std`, `sqlserver_config_2016sp2ent`, `sqlserver_config_2017std`, `sqlserver_config_2017ent`, `sqlserver_config_2019std` or `sqlserver_config_2019ent`<br>Configuration of the SQL Server instances in the cluster.
&nbsp;&nbsp;sqlserver_config_2016sp2std | **[config.SQLServerConfigSet2016sp2std](#SQLServerConfigSet2016sp2std)**<br>Configuration of the SQL Server 2016sp2 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2016sp2ent | **[config.SQLServerConfigSet2016sp2ent](#SQLServerConfigSet2016sp2ent)**<br>Configuration of the SQL Server 2016sp2 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2017std | **[config.SQLServerConfigSet2017std](#SQLServerConfigSet2017std)**<br>Configuration of the SQL Server 2017 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2017ent | **[config.SQLServerConfigSet2017ent](#SQLServerConfigSet2017ent)**<br>Configuration of the SQL Server 2017 enterprise edition instance. 
&nbsp;&nbsp;sqlserver_config_2019std | **[config.SQLServerConfigSet2019std](#SQLServerConfigSet2019std)**<br>Configuration of the SQL Server 2019 standard edition instance. 
&nbsp;&nbsp;sqlserver_config_2019ent | **[config.SQLServerConfigSet2019ent](#SQLServerConfigSet2019ent)**<br>Configuration of the SQL Server 2019 enterprise edition instance. 
resources | **[Resources](#Resources9)**<br>Resources allocated to SQL Server hosts. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Start time for the daily backup in UTC timezone. 
access | **[Access](#Access9)**<br>Database access policy. 
secondary_connections | enum **SecondaryConnections**<br>Secondary replicas connection mode <ul><li>`SECONDARY_CONNECTIONS_OFF`: Connections to secondary replicas are prohibited</li><li>`SECONDARY_CONNECTIONS_READ_ONLY`: Secondary replicas are read-only</li></ul>


### Resources {#Resources9}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). <br>All available presets are listed in the [documentation](/docs/managed-sqlserver/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br>Type of the storage environment for the host. <br>Possible values: <ul><li>`network-hdd` - network HDD drive; </li><li>`network-ssd` - network SSD drive; </li><li>`local-ssd` - local SSD storage.</li></ul> 


### Access {#Access9}

Field | Description
--- | ---
data_lens | **bool**<br>Allows access for DataLens. 
web_sql | **bool**<br>Allows access for Web SQL. 


## ListLogs {#ListLogs}

Retrieves logs for the specified SQL Server cluster. <br>For more information about logs, see the [Logs](/docs/managed-sqlserver/operations/cluster-logs) section in the documentation.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to request logs for. <br>To get the SQL Server cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from the logs table to request. <br>If no columns are specified, entire log records are returned. 
service_type | enum **ServiceType**<br>Type of the service to request logs about. <ul><li>`SQLSERVER_ERROR`: SQL Server error log.</li><li>`SQLSERVER_APPLICATION`: SQL Server application log.</li></ul>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Specifies a moment that the logs are requested from. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Specifies a moment that the logs are requested till. 
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) returned by the previous list request. The maximum string length in characters is 100.
always_next_page_token | **bool**<br>The service returns [next_page_token] even if the current page is empty. 
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <br><ol><li>A field name to filter by. Currently filtering can be applied to the [LogRecord.logs.message.hostname](#LogRecord) field only. </li><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>A value. Must be 1-63 characters long and match the regular expression `[a-z0-9.-]{1,61}`. </li></ol><br>Example of a filter: `message.hostname='node1.db.cloud.yandex.net'`. The maximum string length in characters is 1000.


### ListClusterLogsResponse {#ListClusterLogsResponse}

Field | Description
--- | ---
logs[] | **[LogRecord](#LogRecord)**<br>Requested log records. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterLogsRequest.page_size](#ListClusterLogsRequest), use the `next_page_token` as the value for the [ListClusterLogsRequest.page_token](#ListClusterLogsRequest) query parameter in the next list request. <br>Each subsequent list request has its own `next_page_token` to continue paging through the results. 


### LogRecord {#LogRecord}

Field | Description
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log record timestamp. 
message | **map<string,string>**<br>Contents of the log record. 


## ListOperations {#ListOperations}

Retrieves the list of operations for the specified SQL Server cluster.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to list operations for. <br>To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation9)**<br>List of operations for the specified SQL Server cluster. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest), use the `next_page_token` as the value for the [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest) query parameter in the next list request. <br>Each subsequent list request has its own `next_page_token` to continue paging through the results. 


### Operation {#Operation9}

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

Retrieves the list of available backups for the specified SQL Server cluster.

**rpc ListBackups ([ListClusterBackupsRequest](#ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#ListClusterBackupsResponse))**

### ListClusterBackupsRequest {#ListClusterBackupsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster. <br>To get the SQL Server cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterBackupsResponse {#ListClusterBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup)**<br>List of SQL Server backups. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterBackupsRequest.page_size](#ListClusterBackupsRequest), use the `next_page_token` as the value for the [ListClusterBackupsRequest.page_token](#ListClusterBackupsRequest) query parameter in the next list request. <br>Each subsequent list request has its own `next_page_token` to continue paging through the results. 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was completed. 
source_cluster_id | **string**<br>ID of the SQL Server cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was started. 
databases[] | **string**<br>List of databases included in the backup. 


## ListHosts {#ListHosts}

Retrieves the list of hosts for the specified SQL Server cluster.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster. <br>To get the SQL Server cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](#Host)**<br>List of SQL Server hosts. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) query parameter in the next list request. <br>Each subsequent list request has its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
name | **string**<br>Name of the SQL Server host. <br>The host name is assigned by Managed Service for SQL Server at the moment of creation and cannot be changed. 1-63 characters long. <br>The name is unique across all database hosts that exist on the platform as it defines the FQDN of the host. 
cluster_id | **string**<br>ID of the SQL Server host. <br>The ID is assigned by Managed Service for SQL Server at the moment of creation. 
zone_id | **string**<br>ID of the availability zone where the SQL Server host resides. 
resources | **[Resources](#Resources10)**<br>Resources allocated to the host. 
role | enum **Role**<br>Role of the host in the cluster. <ul><li>`ROLE_UNKNOWN`: Role of the host in the cluster is unknown.</li><li>`MASTER`: Host is the master SQL Server instance in the cluster.</li><li>`REPLICA`: Host is a replica SQL Server instance in the cluster.</li></ul>
health | enum **Health**<br>Status code of the aggregated health of the host. <ul><li>`HEALTH_UNKNOWN`: Health of the host is unknown.</li><li>`ALIVE`: The host is performing all its functions normally.</li><li>`DEAD`: The host is inoperable and cannot perform any of its essential functions.</li><li>`DEGRADED`: The host is degraded and can perform only some of its essential functions.</li></ul>
services[] | **[Service](#Service)**<br>Services provided by the host. 
subnet_id | **string**<br>ID of the subnet that the host belongs to. 
assign_public_ip | **bool**<br>Flag showing public IP assignment status to this host. 


### Resources {#Resources10}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory, etc.). <br>All available presets are listed in the [documentation](/docs/managed-sqlserver/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br>Type of the storage environment for the host. <br>Possible values: <ul><li>`network-hdd` - network HDD drive; </li><li>`network-ssd` - network SSD drive; </li><li>`local-ssd` - local SSD storage.</li></ul> 


### Service {#Service}

Field | Description
--- | ---
type | enum **Type**<br>Type of the service provided by the host. <ul><li>`SQLSERVER`: SQL Server service.</li></ul>
health | enum **Health**<br>Status code of server availability. <ul><li>`HEALTH_UNKNOWN`: Health of the server is unknown.</li><li>`ALIVE`: The server is working normally.</li><li>`DEAD`: The server is dead or unresponsive.</li></ul>


## UpdateHosts {#UpdateHosts}

Updates the specified hosts.

**rpc UpdateHosts ([UpdateClusterHostsRequest](#UpdateClusterHostsRequest)) returns ([operation.Operation](#Operation10))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterHostsMetadata](#UpdateClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateClusterHostsRequest {#UpdateClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to update hosts in. To get the SQL Server cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_host_specs[] | **[UpdateHostSpec](#UpdateHostSpec)**<br>New configurations to apply to hosts. The number of elements must be greater than 0.


### UpdateHostSpec {#UpdateHostSpec}

Field | Description
--- | ---
host_name | **string**<br>Required. Name of the host to update. <br>To get the SQL Server host name, use a [ClusterService.ListHosts](#ListHosts) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the SQL Server host should be updated. 
assign_public_ip | **bool**<br>Determines whether the host gets a public IP address on creation. 


### Operation {#Operation10}

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
cluster_id | **string**<br>ID of the SQL Server cluster to update hosts in. 
host_names[] | **string**<br>Names of the hosts being updated. 


