---
editable: false
---

# ClusterService

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
cluster_id | **string**<br>Required. ID of the PostgreSQL Cluster resource to return. To get the cluster ID use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


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
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11` or `postgresql_config_12`<br>Configuration for PostgreSQL servers in the cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration of a PostgreSQL 9.6 server. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration of a PostgreSQL 10 1C server. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration of a PostgreSQL 10 server. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration of a PostgreSQL 11 server. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration of a PostgreSQL 12 server. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access)**<br>Access policy to DB 


### ConnectionPoolerConfig {#ConnectionPoolerConfig}

Field | Description
--- | ---
pooling_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Session pooling mode.</li><li>`TRANSACTION`: Transaction pooling mode.</li><li>`STATEMENT`: Statement pooling mode.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Setting `server_reset_query_always` parameter in PgBouncer. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br><ul><li>network-hdd — network HDD drive, </li><li>network-ssd — network SSD drive, </li><li>local-ssd — local SSD storage.</li></ul> 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


## List {#List}

Retrieves the list of PostgreSQL Cluster resources that belong to the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list PostgreSQL clusters in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently you can only use filtering with the [Cluster.name](#Cluster1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Мust be 1-63 characters long and match the regular expression `^[a-zA-Z0-9_-]+$`.</li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of PostgreSQL Cluster resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest1), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest1) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


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
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11` or `postgresql_config_12`<br>Configuration for PostgreSQL servers in the cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration of a PostgreSQL 9.6 server. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration of a PostgreSQL 10 1C server. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration of a PostgreSQL 10 server. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration of a PostgreSQL 11 server. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration of a PostgreSQL 12 server. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig1)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources1)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access1)**<br>Access policy to DB 


### ConnectionPoolerConfig {#ConnectionPoolerConfig}

Field | Description
--- | ---
pooling_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Session pooling mode.</li><li>`TRANSACTION`: Transaction pooling mode.</li><li>`STATEMENT`: Statement pooling mode.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Setting `server_reset_query_always` parameter in PgBouncer. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br><ul><li>network-hdd — network HDD drive, </li><li>network-ssd — network SSD drive, </li><li>local-ssd — local SSD storage.</li></ul> 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


## Create {#Create}

Creates a PostgreSQL cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create the PostgreSQL cluster in. false The maximum string length in characters is 50.
name | **string**<br>Required. Name of the PostgreSQL cluster. The name must be unique within the folder. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the PostgreSQL cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Required. Deployment environment of the PostgreSQL cluster. false
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Required. Configuration and resources for hosts that should be created for the PostgreSQL cluster. false
database_specs[] | **[DatabaseSpec](#DatabaseSpec)**<br>Required. Descriptions of databases to be created in the PostgreSQL cluster. false
user_specs[] | **[UserSpec](#UserSpec)**<br>Required. Descriptions of database users to be created in the PostgreSQL cluster. false
host_specs[] | **[HostSpec](#HostSpec)**<br>Required. Individual configurations for hosts that should be created for the PostgreSQL cluster. false
network_id | **string**<br>Required. ID of the network to create the cluster in. false The maximum string length in characters is 50.


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL used in the cluster. Possible values: `9.6`, `10`, `10_1c`, `11`, `12`. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11` or `postgresql_config_12`<br>Configuration of a PostgreSQL cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration for a PostgreSQL 9.6 cluster. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration for a PostgreSQL 10 1C cluster. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration for a PostgreSQL 10 cluster. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration for a PostgreSQL 11 cluster. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration for a PostgreSQL 12 cluster. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig2)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources2)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access2)**<br>Access policy to DB 


### ConnectionPoolerConfig {#ConnectionPoolerConfig}

Field | Description
--- | ---
pooling_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Session pooling mode.</li><li>`TRANSACTION`: Transaction pooling mode.</li><li>`STATEMENT`: Statement pooling mode.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Setting `server_reset_query_always` parameter in PgBouncer. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br><ul><li>network-hdd — network HDD drive, </li><li>network-ssd — network SSD drive, </li><li>local-ssd — local SSD storage.</li></ul> 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


### DatabaseSpec {#DatabaseSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the PostgreSQL database. 1-63 characters long. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
owner | **string**<br>Required. Name of the user to be assigned as the owner of the database. To get the list of available PostgreSQL users, make a [UserService.List](./user_service#List) request. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
lc_collate | **string**<br>POSIX locale for string sorting order. Can only be set at creation time. Value must match the regular expression ` |[a-zA-Z_]+.UTF-8|C `.
lc_ctype | **string**<br>POSIX locale for character classification. Can only be set at creation time. Value must match the regular expression ` |[a-zA-Z_]+.UTF-8|C `.
extensions[] | **[Extension](#Extension)**<br>PostgreSQL extensions to be enabled for the database. 


### Extension {#Extension}

Field | Description
--- | ---
name | **string**<br>Name of the extension, e.g. `pg_trgm` or `pg_btree`. Extensions supported by Managed Service for PostgreSQL are [listed in the Developer's Guide](/docs/managed-postgresql/operations/cluster-extensions). 
version | **string**<br>Version of the extension. 


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the PostgreSQL user. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Required. Password of the PostgreSQL user. false The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission)**<br>Set of permissions to grant to the user. 
conn_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Number of database connections that should be available to the user. The minimum value is 10.
settings | **[UserSettings](#UserSettings)**<br>Postgresql settings for this user 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>User can login (default True) 
grants[] | **string**<br>User grants (GRANT <role> TO <user>), role must be other user The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-zA-Z0-9_]* `.


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 


### UserSettings {#UserSettings}

Field | Description
--- | ---
default_transaction_isolation | enum **TransactionIsolation**<br> <ul><ul/>
lock_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>in milliseconds. 
log_min_duration_statement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>in milliseconds. 
synchronous_commit | enum **SynchronousCommit**<br> <ul><ul/>
temp_file_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>in bytes. 
log_statement | enum **LogStatement**<br> <ul><ul/>


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster2). The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false — don't assign a public IP to the host. </li><li>true — the host should have a public IP address.</li></ul> 
replication_source | **string**<br>[Host.name](#Host) of the host to be used as the replication source (for cascading replication). 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Priority of the host as a replica. A higher value corresponds to higher priority. <br>The host with the highest priority is the synchronous replica. All others are asynchronous. The synchronous replica replaces the master when needed. <br>When a replica becomes the master, its priority is ignored. 
config_spec | **[ConfigHostSpec](#ConfigHostSpec)**<br>Configuration of a PostgreSQL server for the host. 


### ConfigHostSpec {#ConfigHostSpec}

Field | Description
--- | ---
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11` or `postgresql_config_12`<br>
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**<br>Configuration for a host with PostgreSQL 9.6 server deployed. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**<br>Configuration for a host with PostgreSQL 10 1C server deployed. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**<br>Configuration for a host with PostgreSQL 10 server deployed. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**<br>Configuration for a host with PostgreSQL 11 server deployed. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**<br>Configuration for a host with PostgreSQL 12 server deployed. 


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


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


## Update {#Update}

Updates the specified PostgreSQL cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL Cluster resource to update. To get the PostgreSQL cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the PostgreSQL Cluster resource should be updated. 
description | **string**<br>New description of the PostgreSQL cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". <br>The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get](#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec1)**<br>New configuration and resources for hosts in the cluster. 
name | **string**<br>New name for the cluster. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL used in the cluster. Possible values: `9.6`, `10`, `10_1c`, `11`, `12`. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11` or `postgresql_config_12`<br>Configuration of a PostgreSQL cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration for a PostgreSQL 9.6 cluster. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration for a PostgreSQL 10 1C cluster. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration for a PostgreSQL 10 cluster. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration for a PostgreSQL 11 cluster. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration for a PostgreSQL 12 cluster. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig3)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources3)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access3)**<br>Access policy to DB 


### ConnectionPoolerConfig {#ConnectionPoolerConfig}

Field | Description
--- | ---
pooling_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Session pooling mode.</li><li>`TRANSACTION`: Transaction pooling mode.</li><li>`STATEMENT`: Statement pooling mode.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Setting `server_reset_query_always` parameter in PgBouncer. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br><ul><li>network-hdd — network HDD drive, </li><li>network-ssd — network SSD drive, </li><li>local-ssd — local SSD storage.</li></ul> 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


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
cluster_id | **string**<br>ID of the PostgreSQL Cluster resource that is being updated. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


## Delete {#Delete}

Deletes the specified PostgreSQL cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to delete. To get the PostgreSQL cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.


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
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to start. false The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the PostgreSQL cluster. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


## Stop {#Stop}

Stop the specified PostgreSQL cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to stop. false The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the PostgreSQL cluster. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


## Move {#Move}

Moves the specified PostgreSQL cluster to the specified folder.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### MoveClusterRequest {#MoveClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to move. false The maximum string length in characters is 50.
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
cluster_id | **string**<br>ID of the PostgreSQL cluster being moved. 
source_folder_id | **string**<br>ID of the source folder. 
destination_folder_id | **string**<br>ID of the destnation folder. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


## Backup {#Backup}

Creates a backup for the specified PostgreSQL cluster.

**rpc Backup ([BackupClusterRequest](#BackupClusterRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupClusterMetadata](#BackupClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster7)<br>

### BackupClusterRequest {#BackupClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to back up. To get the PostgreSQL cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.


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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster7)>**<br>if operation finished successfully. 


### BackupClusterMetadata {#BackupClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the PostgreSQL cluster that is being backed up. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


## Restore {#Restore}

Creates a new PostgreSQL cluster using the specified backup.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster8)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. ID of the backup to create a cluster from. To get the backup ID, use a [ClusterService.ListBackups](#ListBackups) request. false
time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the moment to which the PostgreSQL cluster should be restored. false
time_inclusive | **bool**<br><ul><li>false (default) — the restore point refers to the first backup moment before `time`. </li><li>true — the restore point refers to the first backup point after `time`.</li></ul> 
name | **string**<br>Required. Name of the new PostgreSQL cluster. The name must be unique within the folder. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the new PostgreSQL cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster8)**<br>Deployment environment of the new PostgreSQL cluster. 
config_spec | **[ConfigSpec](#ConfigSpec2)**<br>Configuration for the PostgreSQL cluster to be created. 
host_specs[] | **[HostSpec](#HostSpec1)**<br>Configurations for PostgreSQL hosts that should be created for the cluster that is being created from the backup. The number of elements must be greater than 0.
network_id | **string**<br>Required. ID of the network to create the PostgreSQL cluster in. false The maximum string length in characters is 50.
folder_id | **string**<br>ID of the folder to create the PostgreSQL cluster in. The maximum string length in characters is 50.


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Version of PostgreSQL used in the cluster. Possible values: `9.6`, `10`, `10_1c`, `11`, `12`. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11` or `postgresql_config_12`<br>Configuration of a PostgreSQL cluster.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Configuration for a PostgreSQL 9.6 cluster. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Configuration for a PostgreSQL 10 1C cluster. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Configuration for a PostgreSQL 10 cluster. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Configuration for a PostgreSQL 11 cluster. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Configuration for a PostgreSQL 12 cluster. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig4)**<br>Configuration of the connection pooler. 
resources | **[Resources](#Resources4)**<br>Resources allocated to PostgreSQL hosts. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Configuration setting which enables/disables autofailover in cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access4)**<br>Access policy to DB 


### ConnectionPoolerConfig {#ConnectionPoolerConfig}

Field | Description
--- | ---
pooling_mode | enum **PoolingMode**<br>Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Session pooling mode.</li><li>`TRANSACTION`: Transaction pooling mode.</li><li>`STATEMENT`: Statement pooling mode.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Setting `server_reset_query_always` parameter in PgBouncer. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br><ul><li>network-hdd — network HDD drive, </li><li>network-ssd — network SSD drive, </li><li>local-ssd — local SSD storage.</li></ul> 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster8). The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false — don't assign a public IP to the host. </li><li>true — the host should have a public IP address.</li></ul> 
replication_source | **string**<br>[Host.name](#Host) of the host to be used as the replication source (for cascading replication). 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Priority of the host as a replica. A higher value corresponds to higher priority. <br>The host with the highest priority is the synchronous replica. All others are asynchronous. The synchronous replica replaces the master when needed. <br>When a replica becomes the master, its priority is ignored. 
config_spec | **[ConfigHostSpec](#ConfigHostSpec1)**<br>Configuration of a PostgreSQL server for the host. 


### ConfigHostSpec {#ConfigHostSpec}

Field | Description
--- | ---
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11` or `postgresql_config_12`<br>
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**<br>Configuration for a host with PostgreSQL 9.6 server deployed. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**<br>Configuration for a host with PostgreSQL 10 1C server deployed. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**<br>Configuration for a host with PostgreSQL 10 server deployed. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**<br>Configuration for a host with PostgreSQL 11 server deployed. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**<br>Configuration for a host with PostgreSQL 12 server deployed. 


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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster8)>**<br>if operation finished successfully. 


### RestoreClusterMetadata {#RestoreClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the new PostgreSQL cluster that is being created from a backup. 
backup_id | **string**<br>ID of the backup that is being used for creating a cluster. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


## StartFailover {#StartFailover}

Start a manual failover on the specified PostgreSQL cluster.

**rpc StartFailover ([StartClusterFailoverRequest](#StartClusterFailoverRequest)) returns ([operation.Operation](#Operation8))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterFailoverMetadata](#StartClusterFailoverMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster9)<br>

### StartClusterFailoverRequest {#StartClusterFailoverRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of PostgreSQL cluster. false The maximum string length in characters is 50.
host_name | **string**<br>New master host. Switch to the most up-to-date replica if not provided. The maximum string length in characters is 253.


### Operation {#Operation}

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
cluster_id | **string**<br>ID of the PostgreSQL cluster being failovered. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the PostgreSQL cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the PostgreSQL cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the PostgreSQL cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the PostgreSQL cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the PostgreSQL cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the PostgreSQL cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the PostgreSQL cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>


## ListLogs {#ListLogs}

Retrieves logs for the specified PostgreSQL cluster.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to request logs for. To get the PostgreSQL cluster ID use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from the logs table to request. If no columns are specified, entire log records are returned. 
service_type | enum **ServiceType**<br>Type of the service to request logs about. <ul><li>`POSTGRESQL`: Logs of PostgreSQL activity.</li><li>`POOLER`: Logs of connection pooler activity.</li><ul/>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) returned by a previous list request. The maximum string length in characters is 100.
always_next_page_token | **bool**<br>Always return `next_page_token`, even if current page is empty. 


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
cluster_id | **string**<br>Required. Required. ID of the PostgreSQL cluster. false The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from logs table to get in the response. 
service_type | enum **ServiceType**<br> <ul><li>`POSTGRESQL`: Logs of PostgreSQL activity.</li><li>`POOLER`: Logs of connection pooler activity.</li><ul/>
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
cluster_id | **string**<br>Required. ID of the PostgreSQL Cluster resource to list operations for. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation9)**<br>List of Operation resources for the specified PostgreSQL cluster. 
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

Retrieves the list of available backups for the specified PostgreSQL cluster.

**rpc ListBackups ([ListClusterBackupsRequest](#ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#ListClusterBackupsResponse))**

### ListClusterBackupsRequest {#ListClusterBackupsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster. To get the PostgreSQL cluster ID use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterBackupsResponse {#ListClusterBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup)**<br>List of PostgreSQL Backup resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterBackupsRequest.page_size](#ListClusterBackupsRequest1), use the `next_page_token` as the value for the [ListClusterBackupsRequest.page_token](#ListClusterBackupsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format (i.e. when the backup operation was completed). 
source_cluster_id | **string**<br>ID of the PostgreSQL cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was started. 


## ListHosts {#ListHosts}

Retrieves a list of hosts for the specified cluster.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster. To get the PostgreSQL cluster ID use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](#Host)**<br>List of Host resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest1), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
name | **string**<br>Name of the PostgreSQL host. The host name is assigned by MDB at creation time, and cannot be changed. 1-63 characters long. <br>The name is unique across all existing MDB hosts in Yandex.Cloud, as it defines the FQDN of the host. 
cluster_id | **string**<br>ID of the PostgreSQL host. The ID is assigned by MDB at creation time. 
zone_id | **string**<br>ID of the availability zone where the PostgreSQL host resides. 
resources | **[Resources](#Resources5)**<br>Resources allocated to the PostgreSQL host. 
role | enum **Role**<br>Role of the host in the cluster. <ul><li>`ROLE_UNKNOWN`: Role of the host in the cluster is unknown.</li><li>`MASTER`: Host is the master PostgreSQL server in the cluster.</li><li>`REPLICA`: Host is a replica (standby) PostgreSQL server in the cluster.</li><ul/>
health | enum **Health**<br>Status code of the aggregated health of the host. <ul><li>`HEALTH_UNKNOWN`: Health of the host is unknown.</li><li>`ALIVE`: The host is performing all its functions normally.</li><li>`DEAD`: The host is inoperable, and cannot perform any of its essential functions.</li><li>`DEGRADED`: The host is degraded, and can perform only some of its essential functions.</li><ul/>
services[] | **[Service](#Service)**<br>Services provided by the host. 
subnet_id | **string**<br>ID of the subnet that the host belongs to. 
replication_source | **string**<br>Name of the host to be used as the replication source for cascading replication. 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Priority of the host as a replica. Higher value means higher priority. <br>The host with the highest priority is the synchronous replica. All others are asynchronous. The synchronous replica replaces the master when needed. <br>When a replica becomes the master, its priority is ignored. 
config | **[HostConfig](#HostConfig)**<br>Configuration of a PostgreSQL server for the host. 
assign_public_ip | **bool**<br>Flag showing public IP assignment status to this host. 
replica_type | enum **ReplicaType**<br> <ul><ul/>


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br><ul><li>network-hdd — network HDD drive, </li><li>network-ssd — network SSD drive, </li><li>local-ssd — local SSD storage.</li></ul> 


### Service {#Service}

Field | Description
--- | ---
type | enum **Type**<br>Type of the service provided by the host. <ul><li>`POSTGRESQL`: The host is a PostgreSQL server.</li><li>`POOLER`: The host is a PgBouncer server.</li><ul/>
health | enum **Health**<br>Status code of server availability. <ul><li>`HEALTH_UNKNOWN`: Health of the server is unknown.</li><li>`ALIVE`: The server is working normally.</li><li>`DEAD`: The server is dead or unresponsive.</li><ul/>


### HostConfig {#HostConfig}

Field | Description
--- | ---
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11` or `postgresql_config_12`<br>Configuration of a PostgreSQL server for the host.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**<br>Configuration for a host with PostgreSQL 9.6 server deployed. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**<br>Configuration for a host with PostgreSQL 10 1C server deployed. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**<br>Configuration for a host with PostgreSQL 10 server deployed. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**<br>Configuration for a host with PostgreSQL 11 server deployed. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**<br>Configuration for a host with PostgreSQL 12 server deployed. 


## AddHosts {#AddHosts}

Creates new hosts for a cluster.

**rpc AddHosts ([AddClusterHostsRequest](#AddClusterHostsRequest)) returns ([operation.Operation](#Operation10))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterHostsMetadata](#AddClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddClusterHostsRequest {#AddClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to add hosts to. To get the PostgreSQL cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
host_specs[] | **[HostSpec](#HostSpec2)**<br>Configurations for PostgreSQL hosts that should be added to the cluster. The number of elements must be greater than 0.


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster10). The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false — don't assign a public IP to the host. </li><li>true — the host should have a public IP address.</li></ul> 
replication_source | **string**<br>[Host.name](#Host1) of the host to be used as the replication source (for cascading replication). 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Priority of the host as a replica. A higher value corresponds to higher priority. <br>The host with the highest priority is the synchronous replica. All others are asynchronous. The synchronous replica replaces the master when needed. <br>When a replica becomes the master, its priority is ignored. 
config_spec | **[ConfigHostSpec](#ConfigHostSpec2)**<br>Configuration of a PostgreSQL server for the host. 


### ConfigHostSpec {#ConfigHostSpec}

Field | Description
--- | ---
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11` or `postgresql_config_12`<br>
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**<br>Configuration for a host with PostgreSQL 9.6 server deployed. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**<br>Configuration for a host with PostgreSQL 10 1C server deployed. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**<br>Configuration for a host with PostgreSQL 10 server deployed. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**<br>Configuration for a host with PostgreSQL 11 server deployed. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**<br>Configuration for a host with PostgreSQL 12 server deployed. 


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
cluster_id | **string**<br>ID of the PostgreSQL cluster to which the hosts are being added. 
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
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to remove hosts from. To get the PostgreSQL cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
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
cluster_id | **string**<br>ID of the PostgreSQL cluster to remove hosts from. 
host_names[] | **string**<br>Names of hosts that are being deleted. 


## UpdateHosts {#UpdateHosts}

Updates the specified hosts.

**rpc UpdateHosts ([UpdateClusterHostsRequest](#UpdateClusterHostsRequest)) returns ([operation.Operation](#Operation12))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterHostsMetadata](#UpdateClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateClusterHostsRequest {#UpdateClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the PostgreSQL cluster to update hosts in. To get the PostgreSQL cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
update_host_specs[] | **[UpdateHostSpec](#UpdateHostSpec)**<br>New configurations to apply to hosts. The number of elements must be greater than 0.


### UpdateHostSpec {#UpdateHostSpec}

Field | Description
--- | ---
host_name | **string**<br>Required. Name of the host to update. To get the PostgreSQL host name, use a [ClusterService.ListHosts](#ListHosts) request. false
replication_source | **string**<br>[Host.name](#Host1) of the host to be used as the replication source (for cascading replication). To get the PostgreSQL host name, use a [ClusterService.ListHosts](#ListHosts) request. 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The host with the highest priority is the synchronous replica. All others are asynchronous. The synchronous replica replaces the master when needed. <br>When a replica becomes the master, its priority is ignored. 
config_spec | **[ConfigHostSpec](#ConfigHostSpec3)**<br>Configuration of a PostgreSQL server for the host. 


### ConfigHostSpec {#ConfigHostSpec}

Field | Description
--- | ---
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11` or `postgresql_config_12`<br>
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**<br>Configuration for a host with PostgreSQL 9.6 server deployed. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**<br>Configuration for a host with PostgreSQL 10 1C server deployed. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**<br>Configuration for a host with PostgreSQL 10 server deployed. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**<br>Configuration for a host with PostgreSQL 11 server deployed. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**<br>Configuration for a host with PostgreSQL 12 server deployed. 


### Operation {#Operation}

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


