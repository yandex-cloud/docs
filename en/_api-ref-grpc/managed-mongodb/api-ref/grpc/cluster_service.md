---
editable: false
---

# ClusterService

A set of methods for managing MongoDB Cluster resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified MongoDB Cluster resource. |
| [List](#List) | Retrieves the list of MongoDB Cluster resources that belong to the specified folder. |
| [Create](#Create) | Creates a MongoDB cluster in the specified folder. |
| [Update](#Update) | Updates the specified MongoDB cluster. |
| [Delete](#Delete) | Deletes the specified MongoDB cluster. |
| [Start](#Start) | Start the specified MongoDB cluster. |
| [Stop](#Stop) | Stop the specified MongoDB cluster. |
| [Move](#Move) | Moves the specified MongoDB cluster to the specified folder. |
| [Backup](#Backup) | Creates a backup for the specified MongoDB cluster. |
| [Restore](#Restore) | Creates a new MongoDB cluster using the specified backup. |
| [RescheduleMaintenance](#RescheduleMaintenance) | Reschedule planned maintenance operation. |
| [ListLogs](#ListLogs) | Retrieves logs for the specified MongoDB cluster. |
| [StreamLogs](#StreamLogs) | Same as ListLogs but using server-side streaming. |
| [ListOperations](#ListOperations) | Retrieves the list of Operation resources for the specified cluster. |
| [ListBackups](#ListBackups) | Retrieves the list of available backups for the specified MongoDB cluster. |
| [ListHosts](#ListHosts) | Retrieves a list of hosts for the specified cluster. |
| [AddHosts](#AddHosts) | Creates new hosts for a cluster. |
| [DeleteHosts](#DeleteHosts) | Deletes the specified hosts for a cluster. |
| [EnableSharding](#EnableSharding) | Enables sharding for the cluster: creates 3 mongocfg and 2 mongos hosts that would support adding and using shards in the cluster. |
| [GetShard](#GetShard) | Returns the specified shard. |
| [ListShards](#ListShards) | Retrieves a list of shards. |
| [AddShard](#AddShard) | Creates a new shard. |
| [DeleteShard](#DeleteShard) | Deletes the specified shard. |
| [ResetupHosts](#ResetupHosts) | Resetup hosts. |
| [RestartHosts](#RestartHosts) | Restart hosts. |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified MongoDB Cluster resource. <br>To get the list of available MongoDB Cluster resources, make a [List](#List) request.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](../cluster.proto#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB Cluster resource to return. To get the cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](../cluster.proto#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](../cluster.proto#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](../cluster.proto#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](../cluster.proto#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](../maintenance.proto#MaintenanceWindow)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](../maintenance.proto#MaintenanceOperation)**<br>Maintenance operation planned at nearest maintenance_window. 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the MongoDB cluster. 


### ClusterConfig {#ClusterConfig}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB server software. Possible values: `3.6`, `4.0`, `4.2`. 
feature_compatibility_version | **string**<br><ul><li>`3.6` — persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or lower. </li><li>`4.0` — persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or lower. </li><li>`4.2` — persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or lower.</li></ul> 
mongodb | **oneof:** `mongodb_3_6`, `mongodb_4_0` or `mongodb_4_2`<br>Configuration for MongoDB servers in the cluster.
&nbsp;&nbsp;mongodb_3_6 | **[Mongodb3_6](../cluster.proto#Mongodb3_6)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. 
&nbsp;&nbsp;mongodb_4_0 | **[Mongodb4_0](../cluster.proto#Mongodb4_0)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. 
&nbsp;&nbsp;mongodb_4_2 | **[Mongodb4_2](../cluster.proto#Mongodb4_2)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](../cluster.proto#Access)**<br>Access policy to DB 


### Mongodb3_6 {#Mongodb3_6}

Field | Description
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod)**<br>Configuration and resource allocation for mongod in a MongoDB 3.6 cluster. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg)**<br>Configuration and resource allocation for mongocfg in a MongoDB 3.6 cluster. 
mongos | **[Mongos](../cluster.proto#Mongos)**<br>Configuration and resource allocation for mongos in a MongoDB 3.6 cluster. 


### Mongod {#Mongod}

Field | Description
--- | ---
config | **`config.MongodConfigSet3_6`**<br>Configuration for a mongod 3.6 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to MongoDB hosts. 


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet3_6`**<br> 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos}

Field | Description
--- | ---
config | **`config.MongosConfigSet3_6`**<br> 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to mongocfg hosts. 


### Mongodb4_0 {#Mongodb4_0}

Field | Description
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod1)**<br>Configuration and resource allocation for mongod in a MongoDB 4.0 cluster. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg1)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.0 cluster. 
mongos | **[Mongos](../cluster.proto#Mongos1)**<br>Configuration and resource allocation for mongos in a MongoDB 4.0 cluster. 


### Mongod {#Mongod}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to mongos hosts. 


### Mongodb4_2 {#Mongodb4_2}

Field | Description
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod2)**<br>Configuration and resource allocation for mongod in a MongoDB 4.2 cluster. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg2)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.2 cluster. 
mongos | **[Mongos](../cluster.proto#Mongos2)**<br>Configuration and resource allocation for mongos in a MongoDB 4.2 cluster. 


### Mongod {#Mongod}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to mongos hosts. 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


### MaintenanceWindow {#MaintenanceWindow}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](../maintenance.proto#AnytimeMaintenanceWindow)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](../maintenance.proto#WeeklyMaintenanceWindow)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Field | Description
--- | ---
day | enum **WeekDay**<br> <ul><ul/>
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## List {#List}

Retrieves the list of MongoDB Cluster resources that belong to the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list MongoDB clusters in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently you can only use filtering with the [Cluster.name](../cluster.proto#Cluster1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Мust be 1-63 characters long and match the regular expression `^[a-zA-Z0-9_-]+$`.</li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](../cluster.proto#Cluster1)**<br>List of MongoDB Cluster resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest1), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest1) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring1)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig1)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](../cluster.proto#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](../cluster.proto#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](../cluster.proto#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](../cluster.proto#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](../maintenance.proto#MaintenanceWindow1)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](../maintenance.proto#MaintenanceOperation1)**<br>Maintenance operation planned at nearest maintenance_window. 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the MongoDB cluster. 


### ClusterConfig {#ClusterConfig}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB server software. Possible values: `3.6`, `4.0`, `4.2`. 
feature_compatibility_version | **string**<br><ul><li>`3.6` — persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or lower. </li><li>`4.0` — persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or lower. </li><li>`4.2` — persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or lower.</li></ul> 
mongodb | **oneof:** `mongodb_3_6`, `mongodb_4_0` or `mongodb_4_2`<br>Configuration for MongoDB servers in the cluster.
&nbsp;&nbsp;mongodb_3_6 | **[Mongodb3_6](../cluster.proto#Mongodb3_61)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. 
&nbsp;&nbsp;mongodb_4_0 | **[Mongodb4_0](../cluster.proto#Mongodb4_01)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. 
&nbsp;&nbsp;mongodb_4_2 | **[Mongodb4_2](../cluster.proto#Mongodb4_21)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](../cluster.proto#Access1)**<br>Access policy to DB 


### Mongodb3_6 {#Mongodb3_6}

Field | Description
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod3)**<br>Configuration and resource allocation for mongod in a MongoDB 3.6 cluster. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg3)**<br>Configuration and resource allocation for mongocfg in a MongoDB 3.6 cluster. 
mongos | **[Mongos](../cluster.proto#Mongos3)**<br>Configuration and resource allocation for mongos in a MongoDB 3.6 cluster. 


### Mongod {#Mongod}

Field | Description
--- | ---
config | **`config.MongodConfigSet3_6`**<br>Configuration for a mongod 3.6 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to MongoDB hosts. 


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet3_6`**<br> 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos}

Field | Description
--- | ---
config | **`config.MongosConfigSet3_6`**<br> 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to mongocfg hosts. 


### Mongodb4_0 {#Mongodb4_0}

Field | Description
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod4)**<br>Configuration and resource allocation for mongod in a MongoDB 4.0 cluster. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg4)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.0 cluster. 
mongos | **[Mongos](../cluster.proto#Mongos4)**<br>Configuration and resource allocation for mongos in a MongoDB 4.0 cluster. 


### Mongod {#Mongod}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to mongos hosts. 


### Mongodb4_2 {#Mongodb4_2}

Field | Description
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod5)**<br>Configuration and resource allocation for mongod in a MongoDB 4.2 cluster. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg5)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.2 cluster. 
mongos | **[Mongos](../cluster.proto#Mongos5)**<br>Configuration and resource allocation for mongos in a MongoDB 4.2 cluster. 


### Mongod {#Mongod}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to mongos hosts. 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


### MaintenanceWindow {#MaintenanceWindow}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](../maintenance.proto#AnytimeMaintenanceWindow1)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](../maintenance.proto#WeeklyMaintenanceWindow1)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Field | Description
--- | ---
day | enum **WeekDay**<br> <ul><ul/>
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Create {#Create}

Creates a MongoDB cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](../cluster.proto#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create MongoDB cluster in. false The maximum string length in characters is 50.
name | **string**<br>Required. Name of the MongoDB cluster. The name must be unique within the folder. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
description | **string**<br>Description of the MongoDB cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](../cluster.proto#Cluster2)**<br>Required. Deployment environment of the MongoDB cluster. false
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Required. Configuration and resources for hosts that should be created for the MongoDB cluster. false
database_specs[] | **[DatabaseSpec](../database.proto#DatabaseSpec)**<br>Descriptions of databases to be created in the MongoDB cluster. The number of elements must be greater than 0.
user_specs[] | **[UserSpec](../user.proto#UserSpec)**<br>Descriptions of database users to be created in the MongoDB cluster. The number of elements must be greater than 0.
host_specs[] | **[HostSpec](#HostSpec)**<br>Individual configurations for hosts that should be created for the MongoDB cluster. The number of elements must be greater than 0.
network_id | **string**<br>Required. ID of the network to create the cluster in. false The maximum string length in characters is 50.


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB used in the cluster. Possible values: `3.6`, `4.0`, `4.2`. 
feature_compatibility_version | **string**<br><ul><li>`3.6` — persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or older. </li><li>`4.0` — persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or older. </li><li>`4.2` — persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or older.</li></ul> 
mongodb_spec | **oneof:** `mongodb_spec_3_6`, `mongodb_spec_4_0` or `mongodb_spec_4_2`<br>
&nbsp;&nbsp;mongodb_spec_3_6 | **[MongodbSpec3_6](#MongodbSpec3_6)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. false
&nbsp;&nbsp;mongodb_spec_4_0 | **[MongodbSpec4_0](#MongodbSpec4_0)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. false
&nbsp;&nbsp;mongodb_spec_4_2 | **[MongodbSpec4_2](#MongodbSpec4_2)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. false
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](../cluster.proto#Access2)**<br>Access policy to DB 


### MongodbSpec3_6 {#MongodbSpec3_6}

Field | Description
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod6)**<br>Configuration and resource allocation for mongod 3.6 hosts. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg6)**<br>Configuration and resource allocation for mongocfg 3.6 hosts. 
mongos | **[Mongos](../cluster.proto#Mongos6)**<br>Configuration and resource allocation for mongos 3.6 hosts. 


### Mongod {#Mongod}

Field | Description
--- | ---
config | **`config.MongodConfig3_6`**<br>Configuration for mongod 3.6 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
config | **`config.MongoCfgConfig3_6`**<br>Configuration for mongocfg 3.6 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos}

Field | Description
--- | ---
config | **`config.MongosConfig3_6`**<br>Configuration for mongos 3.6 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongos host. 


### MongodbSpec4_0 {#MongodbSpec4_0}

Field | Description
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod7)**<br>Configuration and resource allocation for mongod 4.0 hosts. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg7)**<br>Configuration and resource allocation for mongocfg 4.0 hosts. 
mongos | **[Mongos](../cluster.proto#Mongos7)**<br>Configuration and resource allocation for mongos 4.0 hosts. 


### Mongod {#Mongod}

Field | Description
--- | ---
config | **`config.MongodConfig4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos}

Field | Description
--- | ---
config | **`config.MongosConfig4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongos host. 


### MongodbSpec4_2 {#MongodbSpec4_2}

Field | Description
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod8)**<br>Configuration and resource allocation for mongod 4.2 hosts. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg8)**<br>Configuration and resource allocation for mongocfg 4.2 hosts. 
mongos | **[Mongos](../cluster.proto#Mongos8)**<br>Configuration and resource allocation for mongos 4.2 hosts. 


### Mongod {#Mongod}

Field | Description
--- | ---
config | **`config.MongodConfig4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos}

Field | Description
--- | ---
config | **`config.MongosConfig4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongos host. 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


### DatabaseSpec {#DatabaseSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the MongoDB database. 1-63 characters long. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]{1,63} `.


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the MongoDB user. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Required. Password of the MongoDB user. false The string length in characters must be 8-128.
permissions[] | **[Permission](../user.proto#Permission)**<br>Set of permissions to grant to the user. 


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | **string**<br>MongoDB roles for the `database_name` database that the permission grants. 


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The network ID is set in the [Cluster.network_id](../cluster.proto#Cluster2) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false — don't assign a public IP to the host. </li><li>true — the host should have a public IP address.</li></ul> 
type | **[Host.Type](../cluster.proto#Host)**<br>Type of the host to be deployed. 
shard_name | **string**<br>Name of the shard that the host belongs to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](../cluster.proto#Cluster2)>**<br>if operation finished successfully. 


### CreateClusterMetadata {#CreateClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the MongoDB cluster that is being created. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring2)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig2)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](../cluster.proto#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](../cluster.proto#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](../cluster.proto#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](../cluster.proto#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](../maintenance.proto#MaintenanceWindow2)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](../maintenance.proto#MaintenanceOperation2)**<br>Maintenance operation planned at nearest maintenance_window. 


## Update {#Update}

Updates the specified MongoDB cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](../cluster.proto#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB Cluster resource to update. To get the MongoDB cluster ID use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the MongoDB Cluster resource should be updated. 
description | **string**<br>New description of the MongoDB cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". <br>The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get](#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec1)**<br>New configuration and resources for hosts in the cluster. 
name | **string**<br>New name for the cluster. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
maintenance_window | **[MaintenanceWindow](../maintenance.proto#MaintenanceWindow2)**<br>Window of maintenance operations. 


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB used in the cluster. Possible values: `3.6`, `4.0`, `4.2`. 
feature_compatibility_version | **string**<br><ul><li>`3.6` — persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or older. </li><li>`4.0` — persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or older. </li><li>`4.2` — persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or older.</li></ul> 
mongodb_spec | **oneof:** `mongodb_spec_3_6`, `mongodb_spec_4_0` or `mongodb_spec_4_2`<br>
&nbsp;&nbsp;mongodb_spec_3_6 | **[MongodbSpec3_6](#MongodbSpec3_61)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. false
&nbsp;&nbsp;mongodb_spec_4_0 | **[MongodbSpec4_0](#MongodbSpec4_01)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. false
&nbsp;&nbsp;mongodb_spec_4_2 | **[MongodbSpec4_2](#MongodbSpec4_21)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. false
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](../cluster.proto#Access3)**<br>Access policy to DB 


### MongodbSpec3_6 {#MongodbSpec3_6}

Field | Description
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod9)**<br>Configuration and resource allocation for mongod 3.6 hosts. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg9)**<br>Configuration and resource allocation for mongocfg 3.6 hosts. 
mongos | **[Mongos](../cluster.proto#Mongos9)**<br>Configuration and resource allocation for mongos 3.6 hosts. 


### Mongod {#Mongod}

Field | Description
--- | ---
config | **`config.MongodConfig3_6`**<br>Configuration for mongod 3.6 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
config | **`config.MongoCfgConfig3_6`**<br>Configuration for mongocfg 3.6 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos}

Field | Description
--- | ---
config | **`config.MongosConfig3_6`**<br>Configuration for mongos 3.6 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongos host. 


### MongodbSpec4_0 {#MongodbSpec4_0}

Field | Description
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod10)**<br>Configuration and resource allocation for mongod 4.0 hosts. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg10)**<br>Configuration and resource allocation for mongocfg 4.0 hosts. 
mongos | **[Mongos](../cluster.proto#Mongos10)**<br>Configuration and resource allocation for mongos 4.0 hosts. 


### Mongod {#Mongod}

Field | Description
--- | ---
config | **`config.MongodConfig4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos}

Field | Description
--- | ---
config | **`config.MongosConfig4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongos host. 


### MongodbSpec4_2 {#MongodbSpec4_2}

Field | Description
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod11)**<br>Configuration and resource allocation for mongod 4.2 hosts. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg11)**<br>Configuration and resource allocation for mongocfg 4.2 hosts. 
mongos | **[Mongos](../cluster.proto#Mongos11)**<br>Configuration and resource allocation for mongos 4.2 hosts. 


### Mongod {#Mongod}

Field | Description
--- | ---
config | **`config.MongodConfig4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos}

Field | Description
--- | ---
config | **`config.MongosConfig4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongos host. 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


### MaintenanceWindow {#MaintenanceWindow}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](../maintenance.proto#AnytimeMaintenanceWindow2)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](../maintenance.proto#WeeklyMaintenanceWindow2)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Field | Description
--- | ---
day | enum **WeekDay**<br> <ul><ul/>
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](../cluster.proto#Cluster3)>**<br>if operation finished successfully. 


### UpdateClusterMetadata {#UpdateClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the MongoDB Cluster resource that is being updated. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring2)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig2)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](../cluster.proto#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](../cluster.proto#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](../cluster.proto#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](../cluster.proto#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](../maintenance.proto#MaintenanceWindow3)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](../maintenance.proto#MaintenanceOperation2)**<br>Maintenance operation planned at nearest maintenance_window. 


## Delete {#Delete}

Deletes the specified MongoDB cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to delete. To get the MongoDB cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the MongoDB cluster that is being deleted. 


## Start {#Start}

Start the specified MongoDB cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](../cluster.proto#Cluster4)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to start. false The maximum string length in characters is 50.


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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](../cluster.proto#Cluster4)>**<br>if operation finished successfully. 


### StartClusterMetadata {#StartClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the MongoDB cluster. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring2)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig2)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](../cluster.proto#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](../cluster.proto#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](../cluster.proto#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](../cluster.proto#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](../maintenance.proto#MaintenanceWindow3)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](../maintenance.proto#MaintenanceOperation2)**<br>Maintenance operation planned at nearest maintenance_window. 


## Stop {#Stop}

Stop the specified MongoDB cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](../cluster.proto#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to stop. false The maximum string length in characters is 50.


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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](../cluster.proto#Cluster5)>**<br>if operation finished successfully. 


### StopClusterMetadata {#StopClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the MongoDB cluster. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring2)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig2)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](../cluster.proto#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](../cluster.proto#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](../cluster.proto#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](../cluster.proto#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](../maintenance.proto#MaintenanceWindow3)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](../maintenance.proto#MaintenanceOperation2)**<br>Maintenance operation planned at nearest maintenance_window. 


## Move {#Move}

Moves the specified MongoDB cluster to the specified folder.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](../cluster.proto#Cluster6)<br>

### MoveClusterRequest {#MoveClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to move. false The maximum string length in characters is 50.
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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](../cluster.proto#Cluster6)>**<br>if operation finished successfully. 


### MoveClusterMetadata {#MoveClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the MongoDB cluster being moved. 
source_folder_id | **string**<br>ID of the source folder. 
destination_folder_id | **string**<br>ID of the destnation folder. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring2)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig2)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](../cluster.proto#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](../cluster.proto#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](../cluster.proto#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](../cluster.proto#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](../maintenance.proto#MaintenanceWindow3)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](../maintenance.proto#MaintenanceOperation2)**<br>Maintenance operation planned at nearest maintenance_window. 


## Backup {#Backup}

Creates a backup for the specified MongoDB cluster.

**rpc Backup ([BackupClusterRequest](#BackupClusterRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupClusterMetadata](#BackupClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](../cluster.proto#Cluster7)<br>

### BackupClusterRequest {#BackupClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to back up. To get the MongoDB cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.


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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](../cluster.proto#Cluster7)>**<br>if operation finished successfully. 


### BackupClusterMetadata {#BackupClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the MongoDB cluster that is being backed up. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring2)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig2)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](../cluster.proto#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](../cluster.proto#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](../cluster.proto#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](../cluster.proto#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](../maintenance.proto#MaintenanceWindow3)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](../maintenance.proto#MaintenanceOperation2)**<br>Maintenance operation planned at nearest maintenance_window. 


## Restore {#Restore}

Creates a new MongoDB cluster using the specified backup.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](../cluster.proto#Cluster8)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. ID of the backup to create a cluster from. To get the backup ID, use a [ClusterService.ListBackups](#ListBackups) request. false
name | **string**<br>Required. Name of the new MongoDB cluster. The name must be unique within the folder. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the new MongoDB cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](../cluster.proto#Cluster8)**<br>Required. Deployment environment of the new MongoDB cluster. false
config_spec | **[ConfigSpec](#ConfigSpec2)**<br>Required. Configuration for the MongoDB cluster to be created. false
host_specs[] | **[HostSpec](#HostSpec1)**<br>Configurations for MongoDB hosts that should be created for the cluster that is being created from the backup. The number of elements must be greater than 0.
network_id | **string**<br>Required. ID of the network to create the MongoDB cluster in. false The maximum string length in characters is 50.
folder_id | **string**<br>Required. ID of the folder to create the MongoDB cluster in. The maximum string length in characters is 50.
recovery_target_spec | **RecoveryTargetSpec**<br>Specification of the moment to which the MongoDB cluster should be restored. 


### RecoveryTargetSpec {#RecoveryTargetSpec}

Field | Description
--- | ---
timestamp | **int64**<br>Timestamp of the recovery target Value must be greater than 0.


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB used in the cluster. Possible values: `3.6`, `4.0`, `4.2`. 
feature_compatibility_version | **string**<br><ul><li>`3.6` — persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or older. </li><li>`4.0` — persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or older. </li><li>`4.2` — persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or older.</li></ul> 
mongodb_spec | **oneof:** `mongodb_spec_3_6`, `mongodb_spec_4_0` or `mongodb_spec_4_2`<br>
&nbsp;&nbsp;mongodb_spec_3_6 | **[MongodbSpec3_6](#MongodbSpec3_62)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. false
&nbsp;&nbsp;mongodb_spec_4_0 | **[MongodbSpec4_0](#MongodbSpec4_02)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. false
&nbsp;&nbsp;mongodb_spec_4_2 | **[MongodbSpec4_2](#MongodbSpec4_22)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. false
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](../cluster.proto#Access4)**<br>Access policy to DB 


### MongodbSpec3_6 {#MongodbSpec3_6}

Field | Description
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod12)**<br>Configuration and resource allocation for mongod 3.6 hosts. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg12)**<br>Configuration and resource allocation for mongocfg 3.6 hosts. 
mongos | **[Mongos](../cluster.proto#Mongos12)**<br>Configuration and resource allocation for mongos 3.6 hosts. 


### Mongod {#Mongod}

Field | Description
--- | ---
config | **`config.MongodConfig3_6`**<br>Configuration for mongod 3.6 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
config | **`config.MongoCfgConfig3_6`**<br>Configuration for mongocfg 3.6 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos}

Field | Description
--- | ---
config | **`config.MongosConfig3_6`**<br>Configuration for mongos 3.6 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongos host. 


### MongodbSpec4_0 {#MongodbSpec4_0}

Field | Description
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod13)**<br>Configuration and resource allocation for mongod 4.0 hosts. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg13)**<br>Configuration and resource allocation for mongocfg 4.0 hosts. 
mongos | **[Mongos](../cluster.proto#Mongos13)**<br>Configuration and resource allocation for mongos 4.0 hosts. 


### Mongod {#Mongod}

Field | Description
--- | ---
config | **`config.MongodConfig4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos}

Field | Description
--- | ---
config | **`config.MongosConfig4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongos host. 


### MongodbSpec4_2 {#MongodbSpec4_2}

Field | Description
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod14)**<br>Configuration and resource allocation for mongod 4.2 hosts. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg14)**<br>Configuration and resource allocation for mongocfg 4.2 hosts. 
mongos | **[Mongos](../cluster.proto#Mongos14)**<br>Configuration and resource allocation for mongos 4.2 hosts. 


### Mongod {#Mongod}

Field | Description
--- | ---
config | **`config.MongodConfig4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos}

Field | Description
--- | ---
config | **`config.MongosConfig4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to each mongos host. 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens 


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The network ID is set in the [Cluster.network_id](../cluster.proto#Cluster8) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false — don't assign a public IP to the host. </li><li>true — the host should have a public IP address.</li></ul> 
type | **[Host.Type](../cluster.proto#Host)**<br>Type of the host to be deployed. 
shard_name | **string**<br>Name of the shard that the host belongs to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](../cluster.proto#Cluster8)>**<br>if operation finished successfully. 


### RestoreClusterMetadata {#RestoreClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the new MongoDB cluster that is being created from a backup. 
backup_id | **string**<br>ID of the backup that is being used for creating a cluster. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring2)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig2)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](../cluster.proto#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](../cluster.proto#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](../cluster.proto#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](../cluster.proto#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](../maintenance.proto#MaintenanceWindow3)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](../maintenance.proto#MaintenanceOperation2)**<br>Maintenance operation planned at nearest maintenance_window. 


## RescheduleMaintenance {#RescheduleMaintenance}

Reschedule planned maintenance operation.

**rpc RescheduleMaintenance ([RescheduleMaintenanceRequest](#RescheduleMaintenanceRequest)) returns ([operation.Operation](#Operation8))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RescheduleMaintenanceMetadata](#RescheduleMaintenanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](../cluster.proto#Cluster9)<br>

### RescheduleMaintenanceRequest {#RescheduleMaintenanceRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the MongoDB cluster to maintenance reschedule. false The maximum string length in characters is 50.
reschedule_type | enum **RescheduleType**<br>Required. Required. The type of reschedule request. false<ul><ul/>
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time for SPECIFIC_TIME reschedule. Limited by two weeks since first time scheduled. 


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](../cluster.proto#Cluster9)>**<br>if operation finished successfully. 


### RescheduleMaintenanceMetadata {#RescheduleMaintenanceMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster. 
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. New time of the planned maintenance. Can be in the past for rescheduled to "IMMEDIATE". 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring2)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig2)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](../cluster.proto#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](../cluster.proto#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](../cluster.proto#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](../cluster.proto#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](../maintenance.proto#MaintenanceWindow3)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](../maintenance.proto#MaintenanceOperation2)**<br>Maintenance operation planned at nearest maintenance_window. 


## ListLogs {#ListLogs}

Retrieves logs for the specified MongoDB cluster.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to request logs for. To get the MongoDB cluster ID use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from the logs table to request. If no columns are specified, entire log records are returned. 
service_type | enum **ServiceType**<br>Type of the service to request logs about. <ul><li>`MONGOD`: Logs of MongoDB activity.</li><ul/>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) returned by a previous list request. The maximum string length in characters is 100.


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
cluster_id | **string**<br>Required. Required. ID of the MongoDB cluster. false The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from logs table to get in the response. 
service_type | enum **ServiceType**<br> <ul><li>`MONGOD`: Logs of MongoDB activity.</li><ul/>
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
cluster_id | **string**<br>Required. ID of the MongoDB Cluster resource to list operations for. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation9)**<br>List of Operation resources for the specified MongoDB cluster. 
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

Retrieves the list of available backups for the specified MongoDB cluster.

**rpc ListBackups ([ListClusterBackupsRequest](#ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#ListClusterBackupsResponse))**

### ListClusterBackupsRequest {#ListClusterBackupsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster. To get the MongoDB cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterBackupsResponse {#ListClusterBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup)**<br>List of MongoDB Backup resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterBackupsRequest.page_size](#ListClusterBackupsRequest1), use the `next_page_token` as the value for the [ListClusterBackupsRequest.page_token](#ListClusterBackupsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format (i.e. when the backup operation was completed). 
source_cluster_id | **string**<br>ID of the MongoDB cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was started. 
source_shard_names[] | **string**<br>Shard names used as a source for backup. 


## ListHosts {#ListHosts}

Retrieves a list of hosts for the specified cluster.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster. To get the MongoDB cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](../cluster.proto#Host)**<br>List of Host resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest1), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
name | **string**<br>Name of the MongoDB host. The host name is assigned by MDB at creation time, and cannot be changed. 1-63 characters long. <br>The name is unique across all existing MDB hosts in Yandex.Cloud, as it defines the FQDN of the host. 
cluster_id | **string**<br>ID of the MongoDB host. The ID is assigned by MDB at creation time. 
zone_id | **string**<br>ID of the availability zone where the MongoDB host resides. 
resources | **[Resources](../cluster.proto#Resources)**<br>Resources allocated to the MongoDB host. 
role | enum **Role**<br>Role of the host in the cluster. <ul><li>`ROLE_UNKNOWN`: Role of the host in the cluster is unknown.</li><li>`PRIMARY`: Host is the primary MongoDB server in the cluster.</li><li>`SECONDARY`: Host is a secondary MongoDB server in the cluster.</li><ul/>
health | enum **Health**<br>Status code of the aggregated health of the host. <ul><li>`HEALTH_UNKNOWN`: Health of the host is unknown.</li><li>`ALIVE`: The host is performing all its functions normally.</li><li>`DEAD`: The host is inoperable, and cannot perform any of its essential functions.</li><li>`DEGRADED`: The host is degraded, and can perform only some of its essential functions.</li><ul/>
services[] | **[Service](../cluster.proto#Service)**<br>Services provided by the host. 
subnet_id | **string**<br>ID of the subnet that the host belongs to. 
assign_public_ip | **bool**<br>Flag showing public IP assignment status to this host. 
shard_name | **string**<br>Shard which this host belongs to. 
type | enum **Type**<br>Host type <ul><li>`MONGOD`: A mongod host.</li><li>`MONGOS`: A mongos host.</li><li>`MONGOCFG`: A mongocfg host.</li><ul/>


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br><ul><li>network-hdd — network HDD drive, </li><li>network-ssd — network SSD drive, </li><li>local-ssd — local SSD storage.</li></ul> 


### Service {#Service}

Field | Description
--- | ---
type | enum **Type**<br>Type of the service provided by the host. <ul><li>`MONGOD`: The host is running a mongod daemon.</li><li>`MONGOS`: The host is running a mongos daemon.</li><li>`MONGOCFG`: The host is running a MongoDB config server.</li><ul/>
health | enum **Health**<br>Status code of server availability. <ul><li>`HEALTH_UNKNOWN`: Health of the server is unknown.</li><li>`ALIVE`: The server is working normally.</li><li>`DEAD`: The server is dead or unresponsive.</li><ul/>


## AddHosts {#AddHosts}

Creates new hosts for a cluster.

**rpc AddHosts ([AddClusterHostsRequest](#AddClusterHostsRequest)) returns ([operation.Operation](#Operation10))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterHostsMetadata](#AddClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddClusterHostsRequest {#AddClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to add hosts to. To get the MongoDB cluster ID use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
host_specs[] | **[HostSpec](#HostSpec2)**<br>Configurations for MongoDB hosts that should be added to the cluster. The number of elements must be greater than 0.


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The network ID is set in the [Cluster.network_id](../cluster.proto#Cluster10) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false — don't assign a public IP to the host. </li><li>true — the host should have a public IP address.</li></ul> 
type | **[Host.Type](../cluster.proto#Host1)**<br>Type of the host to be deployed. 
shard_name | **string**<br>Name of the shard that the host belongs to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br>ID of the MongoDB cluster to which the hosts are being added. 
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
cluster_id | **string**<br>Required. ID of the MongoDB cluster to remove hosts from. To get the MongoDB cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
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
cluster_id | **string**<br>ID of the MongoDB cluster to remove hosts from. 
host_names[] | **string**<br>Names of hosts that are being deleted. 


## EnableSharding {#EnableSharding}

Enables sharding for the cluster: creates 3 mongocfg and 2 mongos hosts that would support adding and using shards in the cluster.

**rpc EnableSharding ([EnableClusterShardingRequest](#EnableClusterShardingRequest)) returns ([operation.Operation](#Operation12))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[EnableClusterShardingMetadata](#EnableClusterShardingMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### EnableClusterShardingRequest {#EnableClusterShardingRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to enable sharding for. false The maximum string length in characters is 50.
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg15)**<br>Required. mongocfg specification for sharding. false
mongos | **[Mongos](../cluster.proto#Mongos15)**<br>Required. mongos specification for sharding. false
host_specs[] | **[HostSpec](#HostSpec3)**<br>Configurations for mongos and mongocfg hosts. The number of elements must be greater than 0.


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
resources | **[Resources](../cluster.proto#Resources1)**<br>Required. Resources for mongocfg hosts. false


### Mongos {#Mongos}

Field | Description
--- | ---
resources | **[Resources](../cluster.proto#Resources1)**<br>Required. Resources for mongos hosts. false


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The network ID is set in the [Cluster.network_id](../cluster.proto#Cluster10) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false — don't assign a public IP to the host. </li><li>true — the host should have a public IP address.</li></ul> 
type | **[Host.Type](../cluster.proto#Host1)**<br>Type of the host to be deployed. 
shard_name | **string**<br>Name of the shard that the host belongs to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[EnableClusterShardingMetadata](#EnableClusterShardingMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### EnableClusterShardingMetadata {#EnableClusterShardingMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the MongoDB cluster that sharding is being enabled for. 


## GetShard {#GetShard}

Returns the specified shard.

**rpc GetShard ([GetClusterShardRequest](#GetClusterShardRequest)) returns ([Shard](../cluster.proto#Shard))**

### GetClusterShardRequest {#GetClusterShardRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster that the shard belongs to. To get the cluster ID use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name of the MongoDB shard to return. To get the name of the shard use a [ClusterService.ListShards](#ListShards) request. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Shard {#Shard}

Field | Description
--- | ---
name | **string**<br>Name of the shard. 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 


## ListShards {#ListShards}

Retrieves a list of shards.

**rpc ListShards ([ListClusterShardsRequest](#ListClusterShardsRequest)) returns ([ListClusterShardsResponse](#ListClusterShardsResponse))**

### ListClusterShardsRequest {#ListClusterShardsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to list databases in. To get the cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterShardsResponse.next_page_token](#ListClusterShardsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterShardsResponse.next_page_token](#ListClusterShardsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterShardsResponse {#ListClusterShardsResponse}

Field | Description
--- | ---
shards[] | **[Shard](../cluster.proto#Shard1)**<br>List of MongoDB shards. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterShardsRequest.page_size](#ListClusterShardsRequest1), use the `next_page_token` as the value for the [ListClusterShardsRequest.page_token](#ListClusterShardsRequest1) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Shard {#Shard}

Field | Description
--- | ---
name | **string**<br>Name of the shard. 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 


## AddShard {#AddShard}

Creates a new shard.

**rpc AddShard ([AddClusterShardRequest](#AddClusterShardRequest)) returns ([operation.Operation](#Operation13))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterShardMetadata](#AddClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Shard](../cluster.proto#Shard2)<br>

### AddClusterShardRequest {#AddClusterShardRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to add a shard to. To get the cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name of the MongoDB shard to create. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
host_specs[] | **[HostSpec](#HostSpec4)**<br>Configurations for mongod hosts to be created with the shard. The number of elements must be greater than 0.


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The network ID is set in the [Cluster.network_id](../cluster.proto#Cluster10) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false — don't assign a public IP to the host. </li><li>true — the host should have a public IP address.</li></ul> 
type | **[Host.Type](../cluster.proto#Host1)**<br>Type of the host to be deployed. 
shard_name | **string**<br>Name of the shard that the host belongs to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Shard](../cluster.proto#Shard2)>**<br>if operation finished successfully. 


### AddClusterShardMetadata {#AddClusterShardMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the MongoDB cluster that a shard is being added to. 
shard_name | **string**<br>Name of the shard being added. 


### Shard {#Shard}

Field | Description
--- | ---
name | **string**<br>Name of the shard. 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 


## DeleteShard {#DeleteShard}

Deletes the specified shard.

**rpc DeleteShard ([DeleteClusterShardRequest](#DeleteClusterShardRequest)) returns ([operation.Operation](#Operation14))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterShardMetadata](#DeleteClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterShardRequest {#DeleteClusterShardRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to delete a shard in. To get the cluster ID, use a [ClusterService.List](#List) request. false The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name of the MongoDB shard to delete. To get the name of the shard use a [ClusterService.ListShards](#ListShards) request. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br>ID of the MongoDB cluster that a shard is being deleted in. 
shard_name | **string**<br>Name of the shard being deleted. 


## ResetupHosts {#ResetupHosts}

Resetup hosts.

**rpc ResetupHosts ([ResetupHostsRequest](#ResetupHostsRequest)) returns ([operation.Operation](#Operation15))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ResetupHostsMetadata](#ResetupHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### ResetupHostsRequest {#ResetupHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the MongoDB cluster. false The maximum string length in characters is 50.
host_names[] | **string**<br>Required. Name of the hosts to resetup. The number of elements must be greater than 0. The maximum string length in characters for each value is 253.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ResetupHostsMetadata](#ResetupHostsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### ResetupHostsMetadata {#ResetupHostsMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster. 
host_names[] | **string**<br>Required. The name of hosts to resetup. 


## RestartHosts {#RestartHosts}

Restart hosts.

**rpc RestartHosts ([RestartHostsRequest](#RestartHostsRequest)) returns ([operation.Operation](#Operation16))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestartHostsMetadata](#RestartHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### RestartHostsRequest {#RestartHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the MongoDB cluster. false The maximum string length in characters is 50.
host_names[] | **string**<br>Required. Name of the hosts to restart. The number of elements must be greater than 0. The maximum string length in characters for each value is 253.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RestartHostsMetadata](#RestartHostsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### RestartHostsMetadata {#RestartHostsMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster. 
host_names[] | **string**<br>Required. The name of hosts to restart. 


