---
editable: false
sourcePath: en/_api-ref-grpc/managed-mongodb/api-ref/grpc/cluster_service.md
---

# Managed Service for MongoDB API, gRPC: ClusterService

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
| [RescheduleMaintenance](#RescheduleMaintenance) | Reschedules planned maintenance operation. |
| [ListLogs](#ListLogs) | Retrieves logs for the specified MongoDB cluster. |
| [StreamLogs](#StreamLogs) | Same as ListLogs but using server-side streaming. |
| [ListOperations](#ListOperations) | Retrieves the list of Operation resources for the specified cluster. |
| [ListBackups](#ListBackups) | Retrieves the list of available backups for the specified MongoDB cluster. |
| [ListHosts](#ListHosts) | Retrieves a list of hosts for the specified cluster. |
| [AddHosts](#AddHosts) | Creates new hosts for a cluster. |
| [DeleteHosts](#DeleteHosts) | Deletes the specified hosts for a cluster. |
| [UpdateHosts](#UpdateHosts) | Updates the specified parameters for the host. |
| [EnableSharding](#EnableSharding) | Enables sharding for the cluster: creates 3 mongoinfra (or 3 mongocfg and 2 mongos) hosts that would support adding and using shards in the cluster. |
| [GetShard](#GetShard) | Returns the specified shard. |
| [ListShards](#ListShards) | Retrieves a list of shards. |
| [AddShard](#AddShard) | Creates a new shard. |
| [DeleteShard](#DeleteShard) | Deletes the specified shard. |
| [ResetupHosts](#ResetupHosts) | Resetups hosts. |
| [RestartHosts](#RestartHosts) | Restarts hosts. |
| [StepdownHosts](#StepdownHosts) | Stepdown hosts. |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified MongoDB Cluster resource. <br>To get the list of available MongoDB Cluster resources, make a [List](#List) request.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB Cluster resource to return. To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](#ClusterConfig)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the MongoDB cluster. 


### ClusterConfig {#ClusterConfig}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB server software. Possible values: `3.6`, `4.0`, `4.2`, `4.4`, `4.4-enterprise`, `5.0`, `5.0-enterprise`, `6.0`, `6.0-enterprise`. 
feature_compatibility_version | **string**<br>MongoDB feature compatibility version. See usage details in [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/). <br>Possible values: <ul><li>`3.6` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or lower. </li><li>`4.0` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or lower. </li><li>`4.2` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or lower. </li><li>`4.4` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or lower. </li><li>`5.0` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 5.0 or lower. </li><li>`6.0` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 6.0 or lower.</li></ul> 
mongodb | **oneof:** `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise` or `mongodb_6_0_enterprise`<br>Configuration for MongoDB servers in the cluster.
&nbsp;&nbsp;mongodb_3_6 | **[Mongodb3_6](#Mongodb3_6)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. 
&nbsp;&nbsp;mongodb_4_0 | **[Mongodb4_0](#Mongodb4_0)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. 
&nbsp;&nbsp;mongodb_4_2 | **[Mongodb4_2](#Mongodb4_2)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. 
&nbsp;&nbsp;mongodb_4_4 | **[Mongodb4_4](#Mongodb4_4)**<br>Configuration and resource allocation for a MongoDB 4.4 cluster. 
&nbsp;&nbsp;mongodb_5_0 | **[Mongodb5_0](#Mongodb5_0)**<br>Configuration and resource allocation for a MongoDB 5.0 cluster. 
&nbsp;&nbsp;mongodb_6_0 | **[Mongodb6_0](#Mongodb6_0)**<br>Configuration and resource allocation for a MongoDB 6.0 cluster. 
&nbsp;&nbsp;mongodb_4_4_enterprise | **[Mongodb4_4_enterprise](#Mongodb4_4_enterprise)**<br>Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster. 
&nbsp;&nbsp;mongodb_5_0_enterprise | **[Mongodb5_0_enterprise](#Mongodb5_0_enterprise)**<br>Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster. 
&nbsp;&nbsp;mongodb_6_0_enterprise | **[Mongodb6_0_enterprise](#Mongodb6_0_enterprise)**<br>Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retain period of automatically created backup in days 
performance_diagnostics | **[PerformanceDiagnosticsConfig](#PerformanceDiagnosticsConfig)**<br>Performance Diagnostic 
access | **[Access](#Access)**<br>Access policy to DB 


### Mongodb3_6 {#Mongodb3_6}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod)**<br>Configuration and resource allocation for mongod in a MongoDB 3.6 cluster. 
mongocfg | **[MongoCfg](#MongoCfg)**<br>Configuration and resource allocation for mongocfg in a MongoDB 3.6 cluster. 
mongos | **[Mongos](#Mongos)**<br>Configuration and resource allocation for mongos in a MongoDB 3.6 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 3.6 cluster. 


### Mongod {#Mongod}

Field | Description
--- | ---
config | **`config.MongodConfigSet3_6`**<br>Configuration for a mongod 3.6 hosts. 
resources | **[Resources](#Resources)**<br>Resources allocated to MongoDB hosts. 


### MongoCfg {#MongoCfg}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet3_6`**<br> 
resources | **[Resources](#Resources)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos}

Field | Description
--- | ---
config | **`config.MongosConfigSet3_6`**<br> 
resources | **[Resources](#Resources)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet3_6](#MongosConfigSet3_6)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet3_6](#MongoCfgConfigSet3_6)**<br> 
resources | **[Resources](#Resources)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Mongodb4_0 {#Mongodb4_0}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod1)**<br>Configuration and resource allocation for mongod in a MongoDB 4.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg1)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.0 cluster. 
mongos | **[Mongos](#Mongos1)**<br>Configuration and resource allocation for mongos in a MongoDB 4.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra1)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.0 cluster. 


### Mongod {#Mongod1}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg1}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos1}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra1}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_0](#MongosConfigSet4_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_0](#MongoCfgConfigSet4_0)**<br> 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_2 {#Mongodb4_2}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod2)**<br>Configuration and resource allocation for mongod in a MongoDB 4.2 cluster. 
mongocfg | **[MongoCfg](#MongoCfg2)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.2 cluster. 
mongos | **[Mongos](#Mongos2)**<br>Configuration and resource allocation for mongos in a MongoDB 4.2 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra2)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.2 cluster. 


### Mongod {#Mongod2}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg2}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos2}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra2}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_2](#MongosConfigSet4_2)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_2](#MongoCfgConfigSet4_2)**<br> 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4 {#Mongodb4_4}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod3)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg3)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos3)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra3)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod3}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg3}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos3}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra3}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4](#MongosConfigSet4_4)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4](#MongoCfgConfigSet4_4)**<br> 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0 {#Mongodb5_0}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod4)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg4)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos4)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra4)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod4}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg4}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos4}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra4}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0](#MongosConfigSet5_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0](#MongoCfgConfigSet5_0)**<br> 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0 {#Mongodb6_0}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod5)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg5)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos5)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra5)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod5}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg5}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos5}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra5}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0](#MongosConfigSet6_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0](#MongoCfgConfigSet6_0)**<br> 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4_enterprise {#Mongodb4_4_enterprise}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod6)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg6)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos6)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra6)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod6}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4_enterprise`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg6}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4_enterprise`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos6}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4_enterprise`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra6}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4_enterprise](#MongosConfigSet4_4_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4_enterprise](#MongoCfgConfigSet4_4_enterprise)**<br> 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0_enterprise {#Mongodb5_0_enterprise}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod7)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg7)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos7)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra7)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod7}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0_enterprise`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg7}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0_enterprise`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos7}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0_enterprise`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra7}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0_enterprise](#MongosConfigSet5_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0_enterprise](#MongoCfgConfigSet5_0_enterprise)**<br> 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0_enterprise {#Mongodb6_0_enterprise}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod8)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg8)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos8)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra8)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod8}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0_enterprise`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg8}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0_enterprise`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos8}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0_enterprise`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra8}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0_enterprise](#MongosConfigSet6_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0_enterprise](#MongoCfgConfigSet6_0_enterprise)**<br> 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### PerformanceDiagnosticsConfig {#PerformanceDiagnosticsConfig}

Field | Description
--- | ---
profiling_enabled | **bool**<br> 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


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

Retrieves the list of MongoDB Cluster resources that belong to the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list MongoDB clusters in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by the previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can only use filtering with the [Cluster.name](#Cluster1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`.</li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of MongoDB Cluster resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster1}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow1)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation1)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring1}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the MongoDB cluster. 


### ClusterConfig {#ClusterConfig1}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB server software. Possible values: `3.6`, `4.0`, `4.2`, `4.4`, `4.4-enterprise`, `5.0`, `5.0-enterprise`, `6.0`, `6.0-enterprise`. 
feature_compatibility_version | **string**<br>MongoDB feature compatibility version. See usage details in [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/). <br>Possible values: <ul><li>`3.6` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or lower. </li><li>`4.0` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or lower. </li><li>`4.2` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or lower. </li><li>`4.4` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or lower. </li><li>`5.0` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 5.0 or lower. </li><li>`6.0` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 6.0 or lower.</li></ul> 
mongodb | **oneof:** `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise` or `mongodb_6_0_enterprise`<br>Configuration for MongoDB servers in the cluster.
&nbsp;&nbsp;mongodb_3_6 | **[Mongodb3_6](#Mongodb3_61)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. 
&nbsp;&nbsp;mongodb_4_0 | **[Mongodb4_0](#Mongodb4_01)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. 
&nbsp;&nbsp;mongodb_4_2 | **[Mongodb4_2](#Mongodb4_21)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. 
&nbsp;&nbsp;mongodb_4_4 | **[Mongodb4_4](#Mongodb4_41)**<br>Configuration and resource allocation for a MongoDB 4.4 cluster. 
&nbsp;&nbsp;mongodb_5_0 | **[Mongodb5_0](#Mongodb5_01)**<br>Configuration and resource allocation for a MongoDB 5.0 cluster. 
&nbsp;&nbsp;mongodb_6_0 | **[Mongodb6_0](#Mongodb6_01)**<br>Configuration and resource allocation for a MongoDB 6.0 cluster. 
&nbsp;&nbsp;mongodb_4_4_enterprise | **[Mongodb4_4_enterprise](#Mongodb4_4_enterprise1)**<br>Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster. 
&nbsp;&nbsp;mongodb_5_0_enterprise | **[Mongodb5_0_enterprise](#Mongodb5_0_enterprise1)**<br>Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster. 
&nbsp;&nbsp;mongodb_6_0_enterprise | **[Mongodb6_0_enterprise](#Mongodb6_0_enterprise1)**<br>Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retain period of automatically created backup in days 
performance_diagnostics | **[PerformanceDiagnosticsConfig](#PerformanceDiagnosticsConfig1)**<br>Performance Diagnostic 
access | **[Access](#Access1)**<br>Access policy to DB 


### Mongodb3_6 {#Mongodb3_61}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod9)**<br>Configuration and resource allocation for mongod in a MongoDB 3.6 cluster. 
mongocfg | **[MongoCfg](#MongoCfg9)**<br>Configuration and resource allocation for mongocfg in a MongoDB 3.6 cluster. 
mongos | **[Mongos](#Mongos9)**<br>Configuration and resource allocation for mongos in a MongoDB 3.6 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra9)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 3.6 cluster. 


### Mongod {#Mongod9}

Field | Description
--- | ---
config | **`config.MongodConfigSet3_6`**<br>Configuration for a mongod 3.6 hosts. 
resources | **[Resources](#Resources1)**<br>Resources allocated to MongoDB hosts. 


### MongoCfg {#MongoCfg9}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet3_6`**<br> 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos9}

Field | Description
--- | ---
config | **`config.MongosConfigSet3_6`**<br> 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra9}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet3_6](#MongosConfigSet3_6)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet3_6](#MongoCfgConfigSet3_6)**<br> 
resources | **[Resources](#Resources1)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Resources {#Resources1}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Mongodb4_0 {#Mongodb4_01}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod10)**<br>Configuration and resource allocation for mongod in a MongoDB 4.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg10)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.0 cluster. 
mongos | **[Mongos](#Mongos10)**<br>Configuration and resource allocation for mongos in a MongoDB 4.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra10)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.0 cluster. 


### Mongod {#Mongod10}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg10}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos10}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra10}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_0](#MongosConfigSet4_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_0](#MongoCfgConfigSet4_0)**<br> 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_2 {#Mongodb4_21}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod11)**<br>Configuration and resource allocation for mongod in a MongoDB 4.2 cluster. 
mongocfg | **[MongoCfg](#MongoCfg11)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.2 cluster. 
mongos | **[Mongos](#Mongos11)**<br>Configuration and resource allocation for mongos in a MongoDB 4.2 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra11)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.2 cluster. 


### Mongod {#Mongod11}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg11}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos11}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra11}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_2](#MongosConfigSet4_2)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_2](#MongoCfgConfigSet4_2)**<br> 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4 {#Mongodb4_41}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod12)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg12)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos12)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra12)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod12}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg12}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos12}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra12}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4](#MongosConfigSet4_4)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4](#MongoCfgConfigSet4_4)**<br> 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0 {#Mongodb5_01}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod13)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg13)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos13)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra13)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod13}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg13}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos13}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra13}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0](#MongosConfigSet5_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0](#MongoCfgConfigSet5_0)**<br> 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0 {#Mongodb6_01}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod14)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg14)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos14)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra14)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod14}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg14}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos14}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra14}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0](#MongosConfigSet6_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0](#MongoCfgConfigSet6_0)**<br> 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4_enterprise {#Mongodb4_4_enterprise1}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod15)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg15)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos15)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra15)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod15}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4_enterprise`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg15}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4_enterprise`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos15}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4_enterprise`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra15}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4_enterprise](#MongosConfigSet4_4_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4_enterprise](#MongoCfgConfigSet4_4_enterprise)**<br> 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0_enterprise {#Mongodb5_0_enterprise1}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod16)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg16)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos16)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra16)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod16}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0_enterprise`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg16}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0_enterprise`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos16}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0_enterprise`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra16}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0_enterprise](#MongosConfigSet5_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0_enterprise](#MongoCfgConfigSet5_0_enterprise)**<br> 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0_enterprise {#Mongodb6_0_enterprise1}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod17)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg17)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos17)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra17)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod17}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0_enterprise`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg17}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0_enterprise`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos17}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0_enterprise`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra17}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0_enterprise](#MongosConfigSet6_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0_enterprise](#MongoCfgConfigSet6_0_enterprise)**<br> 
resources | **[Resources](#Resources2)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### PerformanceDiagnosticsConfig {#PerformanceDiagnosticsConfig1}

Field | Description
--- | ---
profiling_enabled | **bool**<br> 


### Access {#Access1}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


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

Creates a MongoDB cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create MongoDB cluster in. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the MongoDB cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the MongoDB cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Required. Deployment environment of the MongoDB cluster. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Required. Configuration and resources for hosts that should be created for the MongoDB cluster. 
database_specs[] | **[DatabaseSpec](#DatabaseSpec)**<br>Descriptions of databases to be created in the MongoDB cluster. The number of elements must be greater than 0.
user_specs[] | **[UserSpec](#UserSpec)**<br>Descriptions of database users to be created in the MongoDB cluster. The number of elements must be greater than 0.
host_specs[] | **[HostSpec](#HostSpec)**<br>Individual configurations for hosts that should be created for the MongoDB cluster. The number of elements must be greater than 0.
network_id | **string**<br>Required. ID of the network to create the cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB used in the cluster. Possible values: `3.6`, `4.0`, `4.2`, `4.4`, `4.4-enterprise`, `5.0`, `5.0-enterprise`, `6.0`, `6.0-enterprise`. 
feature_compatibility_version | **string**<br>MongoDB feature compatibility version. See usage details in [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/). <br>Possible values: <ul><li>`3.6` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or older. </li><li>`4.0` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or older. </li><li>`4.2` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or older. </li><li>`4.4` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or older. </li><li>`5.0` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 4.4 or older. </li><li>`6.0` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 5.0 or older.</li></ul> 
mongodb_spec | **oneof:** `mongodb_spec_3_6`, `mongodb_spec_4_0`, `mongodb_spec_4_2`, `mongodb_spec_4_4`, `mongodb_spec_5_0`, `mongodb_spec_6_0`, `mongodb_spec_4_4_enterprise`, `mongodb_spec_5_0_enterprise` or `mongodb_spec_6_0_enterprise`<br>
&nbsp;&nbsp;mongodb_spec_3_6 | **[MongodbSpec3_6](#MongodbSpec3_6)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. 
&nbsp;&nbsp;mongodb_spec_4_0 | **[MongodbSpec4_0](#MongodbSpec4_0)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. 
&nbsp;&nbsp;mongodb_spec_4_2 | **[MongodbSpec4_2](#MongodbSpec4_2)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. 
&nbsp;&nbsp;mongodb_spec_4_4 | **[MongodbSpec4_4](#MongodbSpec4_4)**<br>Configuration and resource allocation for a MongoDB 4.4 cluster. 
&nbsp;&nbsp;mongodb_spec_5_0 | **[MongodbSpec5_0](#MongodbSpec5_0)**<br>Configuration and resource allocation for a MongoDB 5.0 cluster. 
&nbsp;&nbsp;mongodb_spec_6_0 | **[MongodbSpec6_0](#MongodbSpec6_0)**<br>Configuration and resource allocation for a MongoDB 6.0 cluster. 
&nbsp;&nbsp;mongodb_spec_4_4_enterprise | **[MongodbSpec4_4_enterprise](#MongodbSpec4_4_enterprise)**<br>Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster. 
&nbsp;&nbsp;mongodb_spec_5_0_enterprise | **[MongodbSpec5_0_enterprise](#MongodbSpec5_0_enterprise)**<br>Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster. 
&nbsp;&nbsp;mongodb_spec_6_0_enterprise | **[MongodbSpec6_0_enterprise](#MongodbSpec6_0_enterprise)**<br>Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retain period of automatically created backup in days Acceptable values are 7 to 35, inclusive.
performance_diagnostics | **[PerformanceDiagnosticsConfig](#PerformanceDiagnosticsConfig2)**<br>Performance Diagnosics configuration 
access | **[Access](#Access2)**<br>Access policy to DB 


### MongodbSpec3_6 {#MongodbSpec3_6}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod18)**<br>Configuration and resource allocation for mongod 3.6 hosts. 
mongocfg | **[MongoCfg](#MongoCfg18)**<br>Configuration and resource allocation for mongocfg 3.6 hosts. 
mongos | **[Mongos](#Mongos18)**<br>Configuration and resource allocation for mongos 3.6 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra18)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 3.6 hosts. 


### Mongod {#Mongod18}

Field | Description
--- | ---
config | **`config.MongodConfig3_6`**<br>Configuration for mongod 3.6 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg18}

Field | Description
--- | ---
config | **`config.MongoCfgConfig3_6`**<br>Configuration for mongocfg 3.6 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos18}

Field | Description
--- | ---
config | **`config.MongosConfig3_6`**<br>Configuration for mongos 3.6 hosts. 
resources | **[Resources](#Resources2)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra18}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig3_6](#MongosConfig3_6)**<br>Configuration for mongoinfra 3.6 hosts. 
config_mongocfg | **[config.MongoCfgConfig3_6](#MongoCfgConfig3_6)**<br> 
resources | **[Resources](#Resources2)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### Resources {#Resources2}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### MongodbSpec4_0 {#MongodbSpec4_0}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod19)**<br>Configuration and resource allocation for mongod 4.0 hosts. 
mongocfg | **[MongoCfg](#MongoCfg19)**<br>Configuration and resource allocation for mongocfg 4.0 hosts. 
mongos | **[Mongos](#Mongos19)**<br>Configuration and resource allocation for mongos 4.0 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra19)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.0 hosts. 


### Mongod {#Mongod19}

Field | Description
--- | ---
config | **`config.MongodConfig4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg19}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos19}

Field | Description
--- | ---
config | **`config.MongosConfig4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra19}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig4_0](#MongosConfig4_0)**<br>Configuration for mongoinfra 4.0 hosts. 
config_mongocfg | **[config.MongoCfgConfig4_0](#MongoCfgConfig4_0)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec4_2 {#MongodbSpec4_2}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod20)**<br>Configuration and resource allocation for mongod 4.2 hosts. 
mongocfg | **[MongoCfg](#MongoCfg20)**<br>Configuration and resource allocation for mongocfg 4.2 hosts. 
mongos | **[Mongos](#Mongos20)**<br>Configuration and resource allocation for mongos 4.2 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra20)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.2 hosts. 


### Mongod {#Mongod20}

Field | Description
--- | ---
config | **`config.MongodConfig4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg20}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos20}

Field | Description
--- | ---
config | **`config.MongosConfig4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra20}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig4_2](#MongosConfig4_2)**<br>Configuration for mongoinfra 4.2 hosts. 
config_mongocfg | **[config.MongoCfgConfig4_2](#MongoCfgConfig4_2)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec4_4 {#MongodbSpec4_4}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod21)**<br>Configuration and resource allocation for mongod 4.4 hosts. 
mongocfg | **[MongoCfg](#MongoCfg21)**<br>Configuration and resource allocation for mongocfg 4.4 hosts. 
mongos | **[Mongos](#Mongos21)**<br>Configuration and resource allocation for mongos 4.4 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra21)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.4 hosts. 


### Mongod {#Mongod21}

Field | Description
--- | ---
config | **`config.MongodConfig4_4`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg21}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_4`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos21}

Field | Description
--- | ---
config | **`config.MongosConfig4_4`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra21}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig4_4](#MongosConfig4_4)**<br>Configuration for mongoinfra 4.4 hosts. 
config_mongocfg | **[config.MongoCfgConfig4_4](#MongoCfgConfig4_4)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec5_0 {#MongodbSpec5_0}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod22)**<br>Configuration and resource allocation for mongod 5.0 hosts. 
mongocfg | **[MongoCfg](#MongoCfg22)**<br>Configuration and resource allocation for mongocfg 5.0 hosts. 
mongos | **[Mongos](#Mongos22)**<br>Configuration and resource allocation for mongos 5.0 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra22)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 5.0 hosts. 


### Mongod {#Mongod22}

Field | Description
--- | ---
config | **`config.MongodConfig5_0`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg22}

Field | Description
--- | ---
config | **`config.MongoCfgConfig5_0`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos22}

Field | Description
--- | ---
config | **`config.MongosConfig5_0`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra22}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig5_0](#MongosConfig5_0)**<br>Configuration for mongoinfra 5.0 hosts. 
config_mongocfg | **[config.MongoCfgConfig5_0](#MongoCfgConfig5_0)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec6_0 {#MongodbSpec6_0}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod23)**<br>Configuration and resource allocation for mongod 6.0 hosts. 
mongocfg | **[MongoCfg](#MongoCfg23)**<br>Configuration and resource allocation for mongocfg 6.0 hosts. 
mongos | **[Mongos](#Mongos23)**<br>Configuration and resource allocation for mongos 6.0 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra23)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 6.0 hosts. 


### Mongod {#Mongod23}

Field | Description
--- | ---
config | **`config.MongodConfig6_0`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg23}

Field | Description
--- | ---
config | **`config.MongoCfgConfig6_0`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos23}

Field | Description
--- | ---
config | **`config.MongosConfig6_0`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra23}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig6_0](#MongosConfig6_0)**<br>Configuration for mongoinfra 6.0 hosts. 
config_mongocfg | **[config.MongoCfgConfig6_0](#MongoCfgConfig6_0)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec4_4_enterprise {#MongodbSpec4_4_enterprise}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod24)**<br>Configuration and resource allocation for mongod 4.4 hosts. 
mongocfg | **[MongoCfg](#MongoCfg24)**<br>Configuration and resource allocation for mongocfg 4.4 hosts. 
mongos | **[Mongos](#Mongos24)**<br>Configuration and resource allocation for mongos 4.4 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra24)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.4 hosts. 


### Mongod {#Mongod24}

Field | Description
--- | ---
config | **`config.MongodConfig4_4_enterprise`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg24}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_4_enterprise`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos24}

Field | Description
--- | ---
config | **`config.MongosConfig4_4_enterprise`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra24}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig4_4_enterprise](#MongosConfig4_4_enterprise)**<br>Configuration for mongoinfra 4.4 hosts. 
config_mongocfg | **[config.MongoCfgConfig4_4_enterprise](#MongoCfgConfig4_4_enterprise)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec5_0_enterprise {#MongodbSpec5_0_enterprise}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod25)**<br>Configuration and resource allocation for mongod 5.0 hosts. 
mongocfg | **[MongoCfg](#MongoCfg25)**<br>Configuration and resource allocation for mongocfg 5.0 hosts. 
mongos | **[Mongos](#Mongos25)**<br>Configuration and resource allocation for mongos 5.0 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra25)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 5.0 hosts. 


### Mongod {#Mongod25}

Field | Description
--- | ---
config | **`config.MongodConfig5_0_enterprise`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg25}

Field | Description
--- | ---
config | **`config.MongoCfgConfig5_0_enterprise`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos25}

Field | Description
--- | ---
config | **`config.MongosConfig5_0_enterprise`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra25}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig5_0_enterprise](#MongosConfig5_0_enterprise)**<br>Configuration for mongoinfra 5.0 hosts. 
config_mongocfg | **[config.MongoCfgConfig5_0_enterprise](#MongoCfgConfig5_0_enterprise)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec6_0_enterprise {#MongodbSpec6_0_enterprise}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod26)**<br>Configuration and resource allocation for mongod 6.0 hosts. 
mongocfg | **[MongoCfg](#MongoCfg26)**<br>Configuration and resource allocation for mongocfg 6.0 hosts. 
mongos | **[Mongos](#Mongos26)**<br>Configuration and resource allocation for mongos 6.0 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra26)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 6.0 hosts. 


### Mongod {#Mongod26}

Field | Description
--- | ---
config | **`config.MongodConfig6_0_enterprise`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg26}

Field | Description
--- | ---
config | **`config.MongoCfgConfig6_0_enterprise`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos26}

Field | Description
--- | ---
config | **`config.MongosConfig6_0_enterprise`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra26}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig6_0_enterprise](#MongosConfig6_0_enterprise)**<br>Configuration for mongoinfra 6.0 hosts. 
config_mongocfg | **[config.MongoCfgConfig6_0_enterprise](#MongoCfgConfig6_0_enterprise)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### PerformanceDiagnosticsConfig {#PerformanceDiagnosticsConfig2}

Field | Description
--- | ---
profiling_enabled | **bool**<br> 


### Access {#Access2}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### DatabaseSpec {#DatabaseSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the MongoDB database. 1-63 characters long. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]{1,63} `.


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the MongoDB user. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Required. Password of the MongoDB user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission)**<br>Set of permissions to grant to the user. 


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | **string**<br>MongoDB roles for the `database_name` database that the permission grants. 


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The network ID is set in the [Cluster.network_id](#Cluster2) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 
type | **[Host.Type](#Host)**<br>Type of the host to be deployed. 
shard_name | **string**<br>Name of the shard that the host belongs to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
hidden | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Is host hidden in replSet 
secondary_delay_secs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of seconds "behind" the primary that this replica set member should "lag" 
priority | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br>Priority of host for the election in replSet 
tags | **map<string,string>**<br>Host tags 


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
cluster_id | **string**<br>ID of the MongoDB cluster that is being created. 


### Cluster {#Cluster2}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow2)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation2)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring2}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the MongoDB cluster. 


### ClusterConfig {#ClusterConfig2}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB server software. Possible values: `3.6`, `4.0`, `4.2`, `4.4`, `4.4-enterprise`, `5.0`, `5.0-enterprise`, `6.0`, `6.0-enterprise`. 
feature_compatibility_version | **string**<br>MongoDB feature compatibility version. See usage details in [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/). <br>Possible values: <ul><li>`3.6` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or lower. </li><li>`4.0` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or lower. </li><li>`4.2` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or lower. </li><li>`4.4` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or lower. </li><li>`5.0` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 5.0 or lower. </li><li>`6.0` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 6.0 or lower.</li></ul> 
mongodb | **oneof:** `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise` or `mongodb_6_0_enterprise`<br>Configuration for MongoDB servers in the cluster.
&nbsp;&nbsp;mongodb_3_6 | **[Mongodb3_6](#Mongodb3_62)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. 
&nbsp;&nbsp;mongodb_4_0 | **[Mongodb4_0](#Mongodb4_02)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. 
&nbsp;&nbsp;mongodb_4_2 | **[Mongodb4_2](#Mongodb4_22)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. 
&nbsp;&nbsp;mongodb_4_4 | **[Mongodb4_4](#Mongodb4_42)**<br>Configuration and resource allocation for a MongoDB 4.4 cluster. 
&nbsp;&nbsp;mongodb_5_0 | **[Mongodb5_0](#Mongodb5_02)**<br>Configuration and resource allocation for a MongoDB 5.0 cluster. 
&nbsp;&nbsp;mongodb_6_0 | **[Mongodb6_0](#Mongodb6_02)**<br>Configuration and resource allocation for a MongoDB 6.0 cluster. 
&nbsp;&nbsp;mongodb_4_4_enterprise | **[Mongodb4_4_enterprise](#Mongodb4_4_enterprise2)**<br>Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster. 
&nbsp;&nbsp;mongodb_5_0_enterprise | **[Mongodb5_0_enterprise](#Mongodb5_0_enterprise2)**<br>Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster. 
&nbsp;&nbsp;mongodb_6_0_enterprise | **[Mongodb6_0_enterprise](#Mongodb6_0_enterprise2)**<br>Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retain period of automatically created backup in days 
performance_diagnostics | **[PerformanceDiagnosticsConfig](#PerformanceDiagnosticsConfig3)**<br>Performance Diagnostic 
access | **[Access](#Access3)**<br>Access policy to DB 


### Mongodb3_6 {#Mongodb3_62}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod27)**<br>Configuration and resource allocation for mongod in a MongoDB 3.6 cluster. 
mongocfg | **[MongoCfg](#MongoCfg27)**<br>Configuration and resource allocation for mongocfg in a MongoDB 3.6 cluster. 
mongos | **[Mongos](#Mongos27)**<br>Configuration and resource allocation for mongos in a MongoDB 3.6 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra27)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 3.6 cluster. 


### Mongod {#Mongod27}

Field | Description
--- | ---
config | **`config.MongodConfigSet3_6`**<br>Configuration for a mongod 3.6 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to MongoDB hosts. 


### MongoCfg {#MongoCfg27}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet3_6`**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos27}

Field | Description
--- | ---
config | **`config.MongosConfigSet3_6`**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra27}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet3_6](#MongosConfigSet3_6)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet3_6](#MongoCfgConfigSet3_6)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_0 {#Mongodb4_02}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod28)**<br>Configuration and resource allocation for mongod in a MongoDB 4.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg28)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.0 cluster. 
mongos | **[Mongos](#Mongos28)**<br>Configuration and resource allocation for mongos in a MongoDB 4.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra28)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.0 cluster. 


### Mongod {#Mongod28}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg28}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos28}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra28}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_0](#MongosConfigSet4_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_0](#MongoCfgConfigSet4_0)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_2 {#Mongodb4_22}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod29)**<br>Configuration and resource allocation for mongod in a MongoDB 4.2 cluster. 
mongocfg | **[MongoCfg](#MongoCfg29)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.2 cluster. 
mongos | **[Mongos](#Mongos29)**<br>Configuration and resource allocation for mongos in a MongoDB 4.2 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra29)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.2 cluster. 


### Mongod {#Mongod29}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg29}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos29}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra29}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_2](#MongosConfigSet4_2)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_2](#MongoCfgConfigSet4_2)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4 {#Mongodb4_42}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod30)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg30)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos30)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra30)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod30}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg30}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos30}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra30}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4](#MongosConfigSet4_4)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4](#MongoCfgConfigSet4_4)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0 {#Mongodb5_02}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod31)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg31)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos31)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra31)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod31}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg31}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos31}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra31}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0](#MongosConfigSet5_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0](#MongoCfgConfigSet5_0)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0 {#Mongodb6_02}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod32)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg32)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos32)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra32)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod32}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg32}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos32}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra32}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0](#MongosConfigSet6_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0](#MongoCfgConfigSet6_0)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4_enterprise {#Mongodb4_4_enterprise2}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod33)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg33)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos33)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra33)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod33}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4_enterprise`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg33}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4_enterprise`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos33}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4_enterprise`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra33}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4_enterprise](#MongosConfigSet4_4_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4_enterprise](#MongoCfgConfigSet4_4_enterprise)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0_enterprise {#Mongodb5_0_enterprise2}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod34)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg34)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos34)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra34)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod34}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0_enterprise`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg34}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0_enterprise`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos34}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0_enterprise`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra34}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0_enterprise](#MongosConfigSet5_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0_enterprise](#MongoCfgConfigSet5_0_enterprise)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0_enterprise {#Mongodb6_0_enterprise2}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod35)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg35)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos35)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra35)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod35}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0_enterprise`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg35}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0_enterprise`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos35}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0_enterprise`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra35}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0_enterprise](#MongosConfigSet6_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0_enterprise](#MongoCfgConfigSet6_0_enterprise)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


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

Updates the specified MongoDB cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB Cluster resource to update. To get the MongoDB cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the MongoDB Cluster resource should be updated. 
description | **string**<br>New description of the MongoDB cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". <br>The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get](#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec)**<br>New configuration and resources for hosts in the cluster. 
name | **string**<br>New name for the cluster. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>New maintenance window settings for the cluster. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### ConfigSpec {#ConfigSpec1}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB used in the cluster. Possible values: `3.6`, `4.0`, `4.2`, `4.4`, `4.4-enterprise`, `5.0`, `5.0-enterprise`, `6.0`, `6.0-enterprise`. 
feature_compatibility_version | **string**<br>MongoDB feature compatibility version. See usage details in [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/). <br>Possible values: <ul><li>`3.6` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or older. </li><li>`4.0` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or older. </li><li>`4.2` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or older. </li><li>`4.4` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or older. </li><li>`5.0` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 4.4 or older. </li><li>`6.0` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 5.0 or older.</li></ul> 
mongodb_spec | **oneof:** `mongodb_spec_3_6`, `mongodb_spec_4_0`, `mongodb_spec_4_2`, `mongodb_spec_4_4`, `mongodb_spec_5_0`, `mongodb_spec_6_0`, `mongodb_spec_4_4_enterprise`, `mongodb_spec_5_0_enterprise` or `mongodb_spec_6_0_enterprise`<br>
&nbsp;&nbsp;mongodb_spec_3_6 | **[MongodbSpec3_6](#MongodbSpec3_6)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. 
&nbsp;&nbsp;mongodb_spec_4_0 | **[MongodbSpec4_0](#MongodbSpec4_0)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. 
&nbsp;&nbsp;mongodb_spec_4_2 | **[MongodbSpec4_2](#MongodbSpec4_2)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. 
&nbsp;&nbsp;mongodb_spec_4_4 | **[MongodbSpec4_4](#MongodbSpec4_4)**<br>Configuration and resource allocation for a MongoDB 4.4 cluster. 
&nbsp;&nbsp;mongodb_spec_5_0 | **[MongodbSpec5_0](#MongodbSpec5_0)**<br>Configuration and resource allocation for a MongoDB 5.0 cluster. 
&nbsp;&nbsp;mongodb_spec_6_0 | **[MongodbSpec6_0](#MongodbSpec6_0)**<br>Configuration and resource allocation for a MongoDB 6.0 cluster. 
&nbsp;&nbsp;mongodb_spec_4_4_enterprise | **[MongodbSpec4_4_enterprise](#MongodbSpec4_4_enterprise)**<br>Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster. 
&nbsp;&nbsp;mongodb_spec_5_0_enterprise | **[MongodbSpec5_0_enterprise](#MongodbSpec5_0_enterprise)**<br>Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster. 
&nbsp;&nbsp;mongodb_spec_6_0_enterprise | **[MongodbSpec6_0_enterprise](#MongodbSpec6_0_enterprise)**<br>Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retain period of automatically created backup in days Acceptable values are 7 to 35, inclusive.
performance_diagnostics | **[PerformanceDiagnosticsConfig](#PerformanceDiagnosticsConfig3)**<br>Performance Diagnosics configuration 
access | **[Access](#Access3)**<br>Access policy to DB 


### MongodbSpec3_6 {#MongodbSpec3_61}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod36)**<br>Configuration and resource allocation for mongod 3.6 hosts. 
mongocfg | **[MongoCfg](#MongoCfg36)**<br>Configuration and resource allocation for mongocfg 3.6 hosts. 
mongos | **[Mongos](#Mongos36)**<br>Configuration and resource allocation for mongos 3.6 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra36)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 3.6 hosts. 


### Mongod {#Mongod36}

Field | Description
--- | ---
config | **`config.MongodConfig3_6`**<br>Configuration for mongod 3.6 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg36}

Field | Description
--- | ---
config | **`config.MongoCfgConfig3_6`**<br>Configuration for mongocfg 3.6 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos36}

Field | Description
--- | ---
config | **`config.MongosConfig3_6`**<br>Configuration for mongos 3.6 hosts. 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra36}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig3_6](#MongosConfig3_6)**<br>Configuration for mongoinfra 3.6 hosts. 
config_mongocfg | **[config.MongoCfgConfig3_6](#MongoCfgConfig3_6)**<br> 
resources | **[Resources](#Resources3)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### Resources {#Resources3}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### MongodbSpec4_0 {#MongodbSpec4_01}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod37)**<br>Configuration and resource allocation for mongod 4.0 hosts. 
mongocfg | **[MongoCfg](#MongoCfg37)**<br>Configuration and resource allocation for mongocfg 4.0 hosts. 
mongos | **[Mongos](#Mongos37)**<br>Configuration and resource allocation for mongos 4.0 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra37)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.0 hosts. 


### Mongod {#Mongod37}

Field | Description
--- | ---
config | **`config.MongodConfig4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg37}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos37}

Field | Description
--- | ---
config | **`config.MongosConfig4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra37}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig4_0](#MongosConfig4_0)**<br>Configuration for mongoinfra 4.0 hosts. 
config_mongocfg | **[config.MongoCfgConfig4_0](#MongoCfgConfig4_0)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec4_2 {#MongodbSpec4_21}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod38)**<br>Configuration and resource allocation for mongod 4.2 hosts. 
mongocfg | **[MongoCfg](#MongoCfg38)**<br>Configuration and resource allocation for mongocfg 4.2 hosts. 
mongos | **[Mongos](#Mongos38)**<br>Configuration and resource allocation for mongos 4.2 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra38)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.2 hosts. 


### Mongod {#Mongod38}

Field | Description
--- | ---
config | **`config.MongodConfig4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg38}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos38}

Field | Description
--- | ---
config | **`config.MongosConfig4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra38}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig4_2](#MongosConfig4_2)**<br>Configuration for mongoinfra 4.2 hosts. 
config_mongocfg | **[config.MongoCfgConfig4_2](#MongoCfgConfig4_2)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec4_4 {#MongodbSpec4_41}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod39)**<br>Configuration and resource allocation for mongod 4.4 hosts. 
mongocfg | **[MongoCfg](#MongoCfg39)**<br>Configuration and resource allocation for mongocfg 4.4 hosts. 
mongos | **[Mongos](#Mongos39)**<br>Configuration and resource allocation for mongos 4.4 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra39)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.4 hosts. 


### Mongod {#Mongod39}

Field | Description
--- | ---
config | **`config.MongodConfig4_4`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg39}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_4`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos39}

Field | Description
--- | ---
config | **`config.MongosConfig4_4`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra39}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig4_4](#MongosConfig4_4)**<br>Configuration for mongoinfra 4.4 hosts. 
config_mongocfg | **[config.MongoCfgConfig4_4](#MongoCfgConfig4_4)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec5_0 {#MongodbSpec5_01}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod40)**<br>Configuration and resource allocation for mongod 5.0 hosts. 
mongocfg | **[MongoCfg](#MongoCfg40)**<br>Configuration and resource allocation for mongocfg 5.0 hosts. 
mongos | **[Mongos](#Mongos40)**<br>Configuration and resource allocation for mongos 5.0 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra40)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 5.0 hosts. 


### Mongod {#Mongod40}

Field | Description
--- | ---
config | **`config.MongodConfig5_0`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg40}

Field | Description
--- | ---
config | **`config.MongoCfgConfig5_0`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos40}

Field | Description
--- | ---
config | **`config.MongosConfig5_0`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra40}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig5_0](#MongosConfig5_0)**<br>Configuration for mongoinfra 5.0 hosts. 
config_mongocfg | **[config.MongoCfgConfig5_0](#MongoCfgConfig5_0)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec6_0 {#MongodbSpec6_01}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod41)**<br>Configuration and resource allocation for mongod 6.0 hosts. 
mongocfg | **[MongoCfg](#MongoCfg41)**<br>Configuration and resource allocation for mongocfg 6.0 hosts. 
mongos | **[Mongos](#Mongos41)**<br>Configuration and resource allocation for mongos 6.0 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra41)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 6.0 hosts. 


### Mongod {#Mongod41}

Field | Description
--- | ---
config | **`config.MongodConfig6_0`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg41}

Field | Description
--- | ---
config | **`config.MongoCfgConfig6_0`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos41}

Field | Description
--- | ---
config | **`config.MongosConfig6_0`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra41}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig6_0](#MongosConfig6_0)**<br>Configuration for mongoinfra 6.0 hosts. 
config_mongocfg | **[config.MongoCfgConfig6_0](#MongoCfgConfig6_0)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec4_4_enterprise {#MongodbSpec4_4_enterprise1}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod42)**<br>Configuration and resource allocation for mongod 4.4 hosts. 
mongocfg | **[MongoCfg](#MongoCfg42)**<br>Configuration and resource allocation for mongocfg 4.4 hosts. 
mongos | **[Mongos](#Mongos42)**<br>Configuration and resource allocation for mongos 4.4 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra42)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.4 hosts. 


### Mongod {#Mongod42}

Field | Description
--- | ---
config | **`config.MongodConfig4_4_enterprise`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg42}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_4_enterprise`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos42}

Field | Description
--- | ---
config | **`config.MongosConfig4_4_enterprise`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra42}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig4_4_enterprise](#MongosConfig4_4_enterprise)**<br>Configuration for mongoinfra 4.4 hosts. 
config_mongocfg | **[config.MongoCfgConfig4_4_enterprise](#MongoCfgConfig4_4_enterprise)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec5_0_enterprise {#MongodbSpec5_0_enterprise1}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod43)**<br>Configuration and resource allocation for mongod 5.0 hosts. 
mongocfg | **[MongoCfg](#MongoCfg43)**<br>Configuration and resource allocation for mongocfg 5.0 hosts. 
mongos | **[Mongos](#Mongos43)**<br>Configuration and resource allocation for mongos 5.0 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra43)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 5.0 hosts. 


### Mongod {#Mongod43}

Field | Description
--- | ---
config | **`config.MongodConfig5_0_enterprise`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg43}

Field | Description
--- | ---
config | **`config.MongoCfgConfig5_0_enterprise`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos43}

Field | Description
--- | ---
config | **`config.MongosConfig5_0_enterprise`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra43}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig5_0_enterprise](#MongosConfig5_0_enterprise)**<br>Configuration for mongoinfra 5.0 hosts. 
config_mongocfg | **[config.MongoCfgConfig5_0_enterprise](#MongoCfgConfig5_0_enterprise)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec6_0_enterprise {#MongodbSpec6_0_enterprise1}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod44)**<br>Configuration and resource allocation for mongod 6.0 hosts. 
mongocfg | **[MongoCfg](#MongoCfg44)**<br>Configuration and resource allocation for mongocfg 6.0 hosts. 
mongos | **[Mongos](#Mongos44)**<br>Configuration and resource allocation for mongos 6.0 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra44)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 6.0 hosts. 


### Mongod {#Mongod44}

Field | Description
--- | ---
config | **`config.MongodConfig6_0_enterprise`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg44}

Field | Description
--- | ---
config | **`config.MongoCfgConfig6_0_enterprise`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos44}

Field | Description
--- | ---
config | **`config.MongosConfig6_0_enterprise`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra44}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig6_0_enterprise](#MongosConfig6_0_enterprise)**<br>Configuration for mongoinfra 6.0 hosts. 
config_mongocfg | **[config.MongoCfgConfig6_0_enterprise](#MongoCfgConfig6_0_enterprise)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### PerformanceDiagnosticsConfig {#PerformanceDiagnosticsConfig3}

Field | Description
--- | ---
profiling_enabled | **bool**<br> 


### Access {#Access3}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


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
cluster_id | **string**<br>ID of the MongoDB Cluster resource that is being updated. 


### Cluster {#Cluster3}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](#ClusterConfig3)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation3)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring3}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the MongoDB cluster. 


### ClusterConfig {#ClusterConfig3}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB server software. Possible values: `3.6`, `4.0`, `4.2`, `4.4`, `4.4-enterprise`, `5.0`, `5.0-enterprise`, `6.0`, `6.0-enterprise`. 
feature_compatibility_version | **string**<br>MongoDB feature compatibility version. See usage details in [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/). <br>Possible values: <ul><li>`3.6` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or lower. </li><li>`4.0` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or lower. </li><li>`4.2` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or lower. </li><li>`4.4` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or lower. </li><li>`5.0` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 5.0 or lower. </li><li>`6.0` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 6.0 or lower.</li></ul> 
mongodb | **oneof:** `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise` or `mongodb_6_0_enterprise`<br>Configuration for MongoDB servers in the cluster.
&nbsp;&nbsp;mongodb_3_6 | **[Mongodb3_6](#Mongodb3_63)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. 
&nbsp;&nbsp;mongodb_4_0 | **[Mongodb4_0](#Mongodb4_03)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. 
&nbsp;&nbsp;mongodb_4_2 | **[Mongodb4_2](#Mongodb4_23)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. 
&nbsp;&nbsp;mongodb_4_4 | **[Mongodb4_4](#Mongodb4_43)**<br>Configuration and resource allocation for a MongoDB 4.4 cluster. 
&nbsp;&nbsp;mongodb_5_0 | **[Mongodb5_0](#Mongodb5_03)**<br>Configuration and resource allocation for a MongoDB 5.0 cluster. 
&nbsp;&nbsp;mongodb_6_0 | **[Mongodb6_0](#Mongodb6_03)**<br>Configuration and resource allocation for a MongoDB 6.0 cluster. 
&nbsp;&nbsp;mongodb_4_4_enterprise | **[Mongodb4_4_enterprise](#Mongodb4_4_enterprise3)**<br>Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster. 
&nbsp;&nbsp;mongodb_5_0_enterprise | **[Mongodb5_0_enterprise](#Mongodb5_0_enterprise3)**<br>Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster. 
&nbsp;&nbsp;mongodb_6_0_enterprise | **[Mongodb6_0_enterprise](#Mongodb6_0_enterprise3)**<br>Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retain period of automatically created backup in days 
performance_diagnostics | **[PerformanceDiagnosticsConfig](#PerformanceDiagnosticsConfig4)**<br>Performance Diagnostic 
access | **[Access](#Access4)**<br>Access policy to DB 


### Mongodb3_6 {#Mongodb3_63}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod45)**<br>Configuration and resource allocation for mongod in a MongoDB 3.6 cluster. 
mongocfg | **[MongoCfg](#MongoCfg45)**<br>Configuration and resource allocation for mongocfg in a MongoDB 3.6 cluster. 
mongos | **[Mongos](#Mongos45)**<br>Configuration and resource allocation for mongos in a MongoDB 3.6 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra45)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 3.6 cluster. 


### Mongod {#Mongod45}

Field | Description
--- | ---
config | **`config.MongodConfigSet3_6`**<br>Configuration for a mongod 3.6 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to MongoDB hosts. 


### MongoCfg {#MongoCfg45}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet3_6`**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos45}

Field | Description
--- | ---
config | **`config.MongosConfigSet3_6`**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra45}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet3_6](#MongosConfigSet3_6)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet3_6](#MongoCfgConfigSet3_6)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_0 {#Mongodb4_03}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod46)**<br>Configuration and resource allocation for mongod in a MongoDB 4.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg46)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.0 cluster. 
mongos | **[Mongos](#Mongos46)**<br>Configuration and resource allocation for mongos in a MongoDB 4.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra46)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.0 cluster. 


### Mongod {#Mongod46}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg46}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos46}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra46}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_0](#MongosConfigSet4_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_0](#MongoCfgConfigSet4_0)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_2 {#Mongodb4_23}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod47)**<br>Configuration and resource allocation for mongod in a MongoDB 4.2 cluster. 
mongocfg | **[MongoCfg](#MongoCfg47)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.2 cluster. 
mongos | **[Mongos](#Mongos47)**<br>Configuration and resource allocation for mongos in a MongoDB 4.2 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra47)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.2 cluster. 


### Mongod {#Mongod47}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg47}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos47}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra47}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_2](#MongosConfigSet4_2)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_2](#MongoCfgConfigSet4_2)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4 {#Mongodb4_43}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod48)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg48)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos48)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra48)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod48}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg48}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos48}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra48}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4](#MongosConfigSet4_4)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4](#MongoCfgConfigSet4_4)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0 {#Mongodb5_03}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod49)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg49)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos49)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra49)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod49}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg49}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos49}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra49}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0](#MongosConfigSet5_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0](#MongoCfgConfigSet5_0)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0 {#Mongodb6_03}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod50)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg50)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos50)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra50)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod50}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg50}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos50}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra50}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0](#MongosConfigSet6_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0](#MongoCfgConfigSet6_0)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4_enterprise {#Mongodb4_4_enterprise3}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod51)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg51)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos51)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra51)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod51}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4_enterprise`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg51}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4_enterprise`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos51}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4_enterprise`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra51}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4_enterprise](#MongosConfigSet4_4_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4_enterprise](#MongoCfgConfigSet4_4_enterprise)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0_enterprise {#Mongodb5_0_enterprise3}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod52)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg52)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos52)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra52)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod52}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0_enterprise`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg52}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0_enterprise`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos52}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0_enterprise`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra52}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0_enterprise](#MongosConfigSet5_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0_enterprise](#MongoCfgConfigSet5_0_enterprise)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0_enterprise {#Mongodb6_0_enterprise3}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod53)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg53)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos53)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra53)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod53}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0_enterprise`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg53}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0_enterprise`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos53}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0_enterprise`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra53}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0_enterprise](#MongosConfigSet6_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0_enterprise](#MongoCfgConfigSet6_0_enterprise)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### MaintenanceOperation {#MaintenanceOperation3}

Field | Description
--- | ---
info | **string**<br>Information about this maintenance operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time until which this maintenance operation is delayed. 


## Delete {#Delete}

Deletes the specified MongoDB cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to delete. To get the MongoDB cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the MongoDB cluster that is being deleted. 


## Start {#Start}

Start the specified MongoDB cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to start. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the MongoDB cluster. 


### Cluster {#Cluster4}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](#ClusterConfig4)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation4)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring4}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the MongoDB cluster. 


### ClusterConfig {#ClusterConfig4}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB server software. Possible values: `3.6`, `4.0`, `4.2`, `4.4`, `4.4-enterprise`, `5.0`, `5.0-enterprise`, `6.0`, `6.0-enterprise`. 
feature_compatibility_version | **string**<br>MongoDB feature compatibility version. See usage details in [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/). <br>Possible values: <ul><li>`3.6` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or lower. </li><li>`4.0` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or lower. </li><li>`4.2` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or lower. </li><li>`4.4` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or lower. </li><li>`5.0` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 5.0 or lower. </li><li>`6.0` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 6.0 or lower.</li></ul> 
mongodb | **oneof:** `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise` or `mongodb_6_0_enterprise`<br>Configuration for MongoDB servers in the cluster.
&nbsp;&nbsp;mongodb_3_6 | **[Mongodb3_6](#Mongodb3_64)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. 
&nbsp;&nbsp;mongodb_4_0 | **[Mongodb4_0](#Mongodb4_04)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. 
&nbsp;&nbsp;mongodb_4_2 | **[Mongodb4_2](#Mongodb4_24)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. 
&nbsp;&nbsp;mongodb_4_4 | **[Mongodb4_4](#Mongodb4_44)**<br>Configuration and resource allocation for a MongoDB 4.4 cluster. 
&nbsp;&nbsp;mongodb_5_0 | **[Mongodb5_0](#Mongodb5_04)**<br>Configuration and resource allocation for a MongoDB 5.0 cluster. 
&nbsp;&nbsp;mongodb_6_0 | **[Mongodb6_0](#Mongodb6_04)**<br>Configuration and resource allocation for a MongoDB 6.0 cluster. 
&nbsp;&nbsp;mongodb_4_4_enterprise | **[Mongodb4_4_enterprise](#Mongodb4_4_enterprise4)**<br>Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster. 
&nbsp;&nbsp;mongodb_5_0_enterprise | **[Mongodb5_0_enterprise](#Mongodb5_0_enterprise4)**<br>Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster. 
&nbsp;&nbsp;mongodb_6_0_enterprise | **[Mongodb6_0_enterprise](#Mongodb6_0_enterprise4)**<br>Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retain period of automatically created backup in days 
performance_diagnostics | **[PerformanceDiagnosticsConfig](#PerformanceDiagnosticsConfig4)**<br>Performance Diagnostic 
access | **[Access](#Access4)**<br>Access policy to DB 


### Mongodb3_6 {#Mongodb3_64}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod54)**<br>Configuration and resource allocation for mongod in a MongoDB 3.6 cluster. 
mongocfg | **[MongoCfg](#MongoCfg54)**<br>Configuration and resource allocation for mongocfg in a MongoDB 3.6 cluster. 
mongos | **[Mongos](#Mongos54)**<br>Configuration and resource allocation for mongos in a MongoDB 3.6 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra54)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 3.6 cluster. 


### Mongod {#Mongod54}

Field | Description
--- | ---
config | **`config.MongodConfigSet3_6`**<br>Configuration for a mongod 3.6 hosts. 
resources | **[Resources](#Resources4)**<br>Resources allocated to MongoDB hosts. 


### MongoCfg {#MongoCfg54}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet3_6`**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos54}

Field | Description
--- | ---
config | **`config.MongosConfigSet3_6`**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra54}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet3_6](#MongosConfigSet3_6)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet3_6](#MongoCfgConfigSet3_6)**<br> 
resources | **[Resources](#Resources4)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Resources {#Resources4}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Mongodb4_0 {#Mongodb4_04}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod55)**<br>Configuration and resource allocation for mongod in a MongoDB 4.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg55)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.0 cluster. 
mongos | **[Mongos](#Mongos55)**<br>Configuration and resource allocation for mongos in a MongoDB 4.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra55)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.0 cluster. 


### Mongod {#Mongod55}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg55}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos55}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra55}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_0](#MongosConfigSet4_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_0](#MongoCfgConfigSet4_0)**<br> 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_2 {#Mongodb4_24}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod56)**<br>Configuration and resource allocation for mongod in a MongoDB 4.2 cluster. 
mongocfg | **[MongoCfg](#MongoCfg56)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.2 cluster. 
mongos | **[Mongos](#Mongos56)**<br>Configuration and resource allocation for mongos in a MongoDB 4.2 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra56)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.2 cluster. 


### Mongod {#Mongod56}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg56}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos56}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra56}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_2](#MongosConfigSet4_2)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_2](#MongoCfgConfigSet4_2)**<br> 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4 {#Mongodb4_44}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod57)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg57)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos57)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra57)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod57}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg57}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos57}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra57}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4](#MongosConfigSet4_4)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4](#MongoCfgConfigSet4_4)**<br> 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0 {#Mongodb5_04}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod58)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg58)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos58)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra58)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod58}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg58}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos58}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra58}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0](#MongosConfigSet5_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0](#MongoCfgConfigSet5_0)**<br> 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0 {#Mongodb6_04}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod59)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg59)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos59)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra59)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod59}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg59}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos59}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra59}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0](#MongosConfigSet6_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0](#MongoCfgConfigSet6_0)**<br> 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4_enterprise {#Mongodb4_4_enterprise4}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod60)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg60)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos60)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra60)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod60}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4_enterprise`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg60}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4_enterprise`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos60}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4_enterprise`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra60}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4_enterprise](#MongosConfigSet4_4_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4_enterprise](#MongoCfgConfigSet4_4_enterprise)**<br> 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0_enterprise {#Mongodb5_0_enterprise4}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod61)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg61)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos61)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra61)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod61}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0_enterprise`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg61}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0_enterprise`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos61}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0_enterprise`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra61}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0_enterprise](#MongosConfigSet5_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0_enterprise](#MongoCfgConfigSet5_0_enterprise)**<br> 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0_enterprise {#Mongodb6_0_enterprise4}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod62)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg62)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos62)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra62)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod62}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0_enterprise`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg62}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0_enterprise`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos62}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0_enterprise`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra62}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0_enterprise](#MongosConfigSet6_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0_enterprise](#MongoCfgConfigSet6_0_enterprise)**<br> 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### PerformanceDiagnosticsConfig {#PerformanceDiagnosticsConfig4}

Field | Description
--- | ---
profiling_enabled | **bool**<br> 


### Access {#Access4}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


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

Stop the specified MongoDB cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to stop. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the MongoDB cluster. 


### Cluster {#Cluster5}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](#ClusterConfig5)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow5)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation5)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring5}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the MongoDB cluster. 


### ClusterConfig {#ClusterConfig5}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB server software. Possible values: `3.6`, `4.0`, `4.2`, `4.4`, `4.4-enterprise`, `5.0`, `5.0-enterprise`, `6.0`, `6.0-enterprise`. 
feature_compatibility_version | **string**<br>MongoDB feature compatibility version. See usage details in [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/). <br>Possible values: <ul><li>`3.6` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or lower. </li><li>`4.0` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or lower. </li><li>`4.2` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or lower. </li><li>`4.4` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or lower. </li><li>`5.0` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 5.0 or lower. </li><li>`6.0` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 6.0 or lower.</li></ul> 
mongodb | **oneof:** `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise` or `mongodb_6_0_enterprise`<br>Configuration for MongoDB servers in the cluster.
&nbsp;&nbsp;mongodb_3_6 | **[Mongodb3_6](#Mongodb3_65)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. 
&nbsp;&nbsp;mongodb_4_0 | **[Mongodb4_0](#Mongodb4_05)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. 
&nbsp;&nbsp;mongodb_4_2 | **[Mongodb4_2](#Mongodb4_25)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. 
&nbsp;&nbsp;mongodb_4_4 | **[Mongodb4_4](#Mongodb4_45)**<br>Configuration and resource allocation for a MongoDB 4.4 cluster. 
&nbsp;&nbsp;mongodb_5_0 | **[Mongodb5_0](#Mongodb5_05)**<br>Configuration and resource allocation for a MongoDB 5.0 cluster. 
&nbsp;&nbsp;mongodb_6_0 | **[Mongodb6_0](#Mongodb6_05)**<br>Configuration and resource allocation for a MongoDB 6.0 cluster. 
&nbsp;&nbsp;mongodb_4_4_enterprise | **[Mongodb4_4_enterprise](#Mongodb4_4_enterprise5)**<br>Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster. 
&nbsp;&nbsp;mongodb_5_0_enterprise | **[Mongodb5_0_enterprise](#Mongodb5_0_enterprise5)**<br>Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster. 
&nbsp;&nbsp;mongodb_6_0_enterprise | **[Mongodb6_0_enterprise](#Mongodb6_0_enterprise5)**<br>Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retain period of automatically created backup in days 
performance_diagnostics | **[PerformanceDiagnosticsConfig](#PerformanceDiagnosticsConfig5)**<br>Performance Diagnostic 
access | **[Access](#Access5)**<br>Access policy to DB 


### Mongodb3_6 {#Mongodb3_65}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod63)**<br>Configuration and resource allocation for mongod in a MongoDB 3.6 cluster. 
mongocfg | **[MongoCfg](#MongoCfg63)**<br>Configuration and resource allocation for mongocfg in a MongoDB 3.6 cluster. 
mongos | **[Mongos](#Mongos63)**<br>Configuration and resource allocation for mongos in a MongoDB 3.6 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra63)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 3.6 cluster. 


### Mongod {#Mongod63}

Field | Description
--- | ---
config | **`config.MongodConfigSet3_6`**<br>Configuration for a mongod 3.6 hosts. 
resources | **[Resources](#Resources5)**<br>Resources allocated to MongoDB hosts. 


### MongoCfg {#MongoCfg63}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet3_6`**<br> 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos63}

Field | Description
--- | ---
config | **`config.MongosConfigSet3_6`**<br> 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra63}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet3_6](#MongosConfigSet3_6)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet3_6](#MongoCfgConfigSet3_6)**<br> 
resources | **[Resources](#Resources5)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Resources {#Resources5}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Mongodb4_0 {#Mongodb4_05}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod64)**<br>Configuration and resource allocation for mongod in a MongoDB 4.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg64)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.0 cluster. 
mongos | **[Mongos](#Mongos64)**<br>Configuration and resource allocation for mongos in a MongoDB 4.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra64)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.0 cluster. 


### Mongod {#Mongod64}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg64}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos64}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra64}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_0](#MongosConfigSet4_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_0](#MongoCfgConfigSet4_0)**<br> 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_2 {#Mongodb4_25}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod65)**<br>Configuration and resource allocation for mongod in a MongoDB 4.2 cluster. 
mongocfg | **[MongoCfg](#MongoCfg65)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.2 cluster. 
mongos | **[Mongos](#Mongos65)**<br>Configuration and resource allocation for mongos in a MongoDB 4.2 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra65)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.2 cluster. 


### Mongod {#Mongod65}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg65}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos65}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra65}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_2](#MongosConfigSet4_2)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_2](#MongoCfgConfigSet4_2)**<br> 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4 {#Mongodb4_45}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod66)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg66)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos66)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra66)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod66}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg66}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos66}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra66}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4](#MongosConfigSet4_4)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4](#MongoCfgConfigSet4_4)**<br> 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0 {#Mongodb5_05}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod67)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg67)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos67)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra67)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod67}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg67}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos67}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra67}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0](#MongosConfigSet5_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0](#MongoCfgConfigSet5_0)**<br> 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0 {#Mongodb6_05}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod68)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg68)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos68)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra68)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod68}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg68}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos68}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra68}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0](#MongosConfigSet6_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0](#MongoCfgConfigSet6_0)**<br> 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4_enterprise {#Mongodb4_4_enterprise5}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod69)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg69)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos69)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra69)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod69}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4_enterprise`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg69}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4_enterprise`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos69}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4_enterprise`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra69}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4_enterprise](#MongosConfigSet4_4_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4_enterprise](#MongoCfgConfigSet4_4_enterprise)**<br> 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0_enterprise {#Mongodb5_0_enterprise5}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod70)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg70)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos70)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra70)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod70}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0_enterprise`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg70}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0_enterprise`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos70}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0_enterprise`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra70}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0_enterprise](#MongosConfigSet5_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0_enterprise](#MongoCfgConfigSet5_0_enterprise)**<br> 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0_enterprise {#Mongodb6_0_enterprise5}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod71)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg71)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos71)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra71)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod71}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0_enterprise`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg71}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0_enterprise`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos71}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0_enterprise`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra71}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0_enterprise](#MongosConfigSet6_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0_enterprise](#MongoCfgConfigSet6_0_enterprise)**<br> 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### PerformanceDiagnosticsConfig {#PerformanceDiagnosticsConfig5}

Field | Description
--- | ---
profiling_enabled | **bool**<br> 


### Access {#Access5}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


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

Moves the specified MongoDB cluster to the specified folder.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### MoveClusterRequest {#MoveClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to move. The maximum string length in characters is 50.
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
cluster_id | **string**<br>ID of the MongoDB cluster being moved. 
source_folder_id | **string**<br>ID of the source folder. 
destination_folder_id | **string**<br>ID of the destnation folder. 


### Cluster {#Cluster6}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring6)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](#ClusterConfig6)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow6)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation6)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring6}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the MongoDB cluster. 


### ClusterConfig {#ClusterConfig6}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB server software. Possible values: `3.6`, `4.0`, `4.2`, `4.4`, `4.4-enterprise`, `5.0`, `5.0-enterprise`, `6.0`, `6.0-enterprise`. 
feature_compatibility_version | **string**<br>MongoDB feature compatibility version. See usage details in [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/). <br>Possible values: <ul><li>`3.6` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or lower. </li><li>`4.0` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or lower. </li><li>`4.2` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or lower. </li><li>`4.4` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or lower. </li><li>`5.0` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 5.0 or lower. </li><li>`6.0` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 6.0 or lower.</li></ul> 
mongodb | **oneof:** `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise` or `mongodb_6_0_enterprise`<br>Configuration for MongoDB servers in the cluster.
&nbsp;&nbsp;mongodb_3_6 | **[Mongodb3_6](#Mongodb3_66)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. 
&nbsp;&nbsp;mongodb_4_0 | **[Mongodb4_0](#Mongodb4_06)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. 
&nbsp;&nbsp;mongodb_4_2 | **[Mongodb4_2](#Mongodb4_26)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. 
&nbsp;&nbsp;mongodb_4_4 | **[Mongodb4_4](#Mongodb4_46)**<br>Configuration and resource allocation for a MongoDB 4.4 cluster. 
&nbsp;&nbsp;mongodb_5_0 | **[Mongodb5_0](#Mongodb5_06)**<br>Configuration and resource allocation for a MongoDB 5.0 cluster. 
&nbsp;&nbsp;mongodb_6_0 | **[Mongodb6_0](#Mongodb6_06)**<br>Configuration and resource allocation for a MongoDB 6.0 cluster. 
&nbsp;&nbsp;mongodb_4_4_enterprise | **[Mongodb4_4_enterprise](#Mongodb4_4_enterprise6)**<br>Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster. 
&nbsp;&nbsp;mongodb_5_0_enterprise | **[Mongodb5_0_enterprise](#Mongodb5_0_enterprise6)**<br>Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster. 
&nbsp;&nbsp;mongodb_6_0_enterprise | **[Mongodb6_0_enterprise](#Mongodb6_0_enterprise6)**<br>Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retain period of automatically created backup in days 
performance_diagnostics | **[PerformanceDiagnosticsConfig](#PerformanceDiagnosticsConfig6)**<br>Performance Diagnostic 
access | **[Access](#Access6)**<br>Access policy to DB 


### Mongodb3_6 {#Mongodb3_66}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod72)**<br>Configuration and resource allocation for mongod in a MongoDB 3.6 cluster. 
mongocfg | **[MongoCfg](#MongoCfg72)**<br>Configuration and resource allocation for mongocfg in a MongoDB 3.6 cluster. 
mongos | **[Mongos](#Mongos72)**<br>Configuration and resource allocation for mongos in a MongoDB 3.6 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra72)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 3.6 cluster. 


### Mongod {#Mongod72}

Field | Description
--- | ---
config | **`config.MongodConfigSet3_6`**<br>Configuration for a mongod 3.6 hosts. 
resources | **[Resources](#Resources6)**<br>Resources allocated to MongoDB hosts. 


### MongoCfg {#MongoCfg72}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet3_6`**<br> 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos72}

Field | Description
--- | ---
config | **`config.MongosConfigSet3_6`**<br> 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra72}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet3_6](#MongosConfigSet3_6)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet3_6](#MongoCfgConfigSet3_6)**<br> 
resources | **[Resources](#Resources6)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Resources {#Resources6}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Mongodb4_0 {#Mongodb4_06}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod73)**<br>Configuration and resource allocation for mongod in a MongoDB 4.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg73)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.0 cluster. 
mongos | **[Mongos](#Mongos73)**<br>Configuration and resource allocation for mongos in a MongoDB 4.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra73)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.0 cluster. 


### Mongod {#Mongod73}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg73}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos73}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra73}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_0](#MongosConfigSet4_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_0](#MongoCfgConfigSet4_0)**<br> 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_2 {#Mongodb4_26}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod74)**<br>Configuration and resource allocation for mongod in a MongoDB 4.2 cluster. 
mongocfg | **[MongoCfg](#MongoCfg74)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.2 cluster. 
mongos | **[Mongos](#Mongos74)**<br>Configuration and resource allocation for mongos in a MongoDB 4.2 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra74)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.2 cluster. 


### Mongod {#Mongod74}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg74}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos74}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra74}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_2](#MongosConfigSet4_2)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_2](#MongoCfgConfigSet4_2)**<br> 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4 {#Mongodb4_46}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod75)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg75)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos75)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra75)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod75}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg75}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos75}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra75}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4](#MongosConfigSet4_4)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4](#MongoCfgConfigSet4_4)**<br> 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0 {#Mongodb5_06}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod76)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg76)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos76)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra76)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod76}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg76}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos76}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra76}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0](#MongosConfigSet5_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0](#MongoCfgConfigSet5_0)**<br> 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0 {#Mongodb6_06}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod77)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg77)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos77)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra77)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod77}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg77}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos77}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra77}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0](#MongosConfigSet6_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0](#MongoCfgConfigSet6_0)**<br> 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4_enterprise {#Mongodb4_4_enterprise6}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod78)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg78)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos78)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra78)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod78}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4_enterprise`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg78}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4_enterprise`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos78}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4_enterprise`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra78}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4_enterprise](#MongosConfigSet4_4_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4_enterprise](#MongoCfgConfigSet4_4_enterprise)**<br> 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0_enterprise {#Mongodb5_0_enterprise6}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod79)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg79)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos79)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra79)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod79}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0_enterprise`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg79}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0_enterprise`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos79}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0_enterprise`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra79}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0_enterprise](#MongosConfigSet5_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0_enterprise](#MongoCfgConfigSet5_0_enterprise)**<br> 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0_enterprise {#Mongodb6_0_enterprise6}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod80)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg80)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos80)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra80)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod80}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0_enterprise`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg80}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0_enterprise`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos80}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0_enterprise`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra80}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0_enterprise](#MongosConfigSet6_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0_enterprise](#MongoCfgConfigSet6_0_enterprise)**<br> 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### PerformanceDiagnosticsConfig {#PerformanceDiagnosticsConfig6}

Field | Description
--- | ---
profiling_enabled | **bool**<br> 


### Access {#Access6}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


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

Creates a backup for the specified MongoDB cluster.

**rpc Backup ([BackupClusterRequest](#BackupClusterRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupClusterMetadata](#BackupClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster7)<br>

### BackupClusterRequest {#BackupClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to back up. To get the MongoDB cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the MongoDB cluster that is being backed up. 


### Cluster {#Cluster7}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring7)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](#ClusterConfig7)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow7)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation7)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring7}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the MongoDB cluster. 


### ClusterConfig {#ClusterConfig7}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB server software. Possible values: `3.6`, `4.0`, `4.2`, `4.4`, `4.4-enterprise`, `5.0`, `5.0-enterprise`, `6.0`, `6.0-enterprise`. 
feature_compatibility_version | **string**<br>MongoDB feature compatibility version. See usage details in [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/). <br>Possible values: <ul><li>`3.6` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or lower. </li><li>`4.0` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or lower. </li><li>`4.2` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or lower. </li><li>`4.4` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or lower. </li><li>`5.0` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 5.0 or lower. </li><li>`6.0` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 6.0 or lower.</li></ul> 
mongodb | **oneof:** `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise` or `mongodb_6_0_enterprise`<br>Configuration for MongoDB servers in the cluster.
&nbsp;&nbsp;mongodb_3_6 | **[Mongodb3_6](#Mongodb3_67)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. 
&nbsp;&nbsp;mongodb_4_0 | **[Mongodb4_0](#Mongodb4_07)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. 
&nbsp;&nbsp;mongodb_4_2 | **[Mongodb4_2](#Mongodb4_27)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. 
&nbsp;&nbsp;mongodb_4_4 | **[Mongodb4_4](#Mongodb4_47)**<br>Configuration and resource allocation for a MongoDB 4.4 cluster. 
&nbsp;&nbsp;mongodb_5_0 | **[Mongodb5_0](#Mongodb5_07)**<br>Configuration and resource allocation for a MongoDB 5.0 cluster. 
&nbsp;&nbsp;mongodb_6_0 | **[Mongodb6_0](#Mongodb6_07)**<br>Configuration and resource allocation for a MongoDB 6.0 cluster. 
&nbsp;&nbsp;mongodb_4_4_enterprise | **[Mongodb4_4_enterprise](#Mongodb4_4_enterprise7)**<br>Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster. 
&nbsp;&nbsp;mongodb_5_0_enterprise | **[Mongodb5_0_enterprise](#Mongodb5_0_enterprise7)**<br>Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster. 
&nbsp;&nbsp;mongodb_6_0_enterprise | **[Mongodb6_0_enterprise](#Mongodb6_0_enterprise7)**<br>Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retain period of automatically created backup in days 
performance_diagnostics | **[PerformanceDiagnosticsConfig](#PerformanceDiagnosticsConfig7)**<br>Performance Diagnostic 
access | **[Access](#Access7)**<br>Access policy to DB 


### Mongodb3_6 {#Mongodb3_67}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod81)**<br>Configuration and resource allocation for mongod in a MongoDB 3.6 cluster. 
mongocfg | **[MongoCfg](#MongoCfg81)**<br>Configuration and resource allocation for mongocfg in a MongoDB 3.6 cluster. 
mongos | **[Mongos](#Mongos81)**<br>Configuration and resource allocation for mongos in a MongoDB 3.6 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra81)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 3.6 cluster. 


### Mongod {#Mongod81}

Field | Description
--- | ---
config | **`config.MongodConfigSet3_6`**<br>Configuration for a mongod 3.6 hosts. 
resources | **[Resources](#Resources7)**<br>Resources allocated to MongoDB hosts. 


### MongoCfg {#MongoCfg81}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet3_6`**<br> 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos81}

Field | Description
--- | ---
config | **`config.MongosConfigSet3_6`**<br> 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra81}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet3_6](#MongosConfigSet3_6)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet3_6](#MongoCfgConfigSet3_6)**<br> 
resources | **[Resources](#Resources7)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Resources {#Resources7}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Mongodb4_0 {#Mongodb4_07}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod82)**<br>Configuration and resource allocation for mongod in a MongoDB 4.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg82)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.0 cluster. 
mongos | **[Mongos](#Mongos82)**<br>Configuration and resource allocation for mongos in a MongoDB 4.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra82)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.0 cluster. 


### Mongod {#Mongod82}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg82}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos82}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra82}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_0](#MongosConfigSet4_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_0](#MongoCfgConfigSet4_0)**<br> 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_2 {#Mongodb4_27}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod83)**<br>Configuration and resource allocation for mongod in a MongoDB 4.2 cluster. 
mongocfg | **[MongoCfg](#MongoCfg83)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.2 cluster. 
mongos | **[Mongos](#Mongos83)**<br>Configuration and resource allocation for mongos in a MongoDB 4.2 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra83)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.2 cluster. 


### Mongod {#Mongod83}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg83}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos83}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra83}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_2](#MongosConfigSet4_2)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_2](#MongoCfgConfigSet4_2)**<br> 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4 {#Mongodb4_47}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod84)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg84)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos84)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra84)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod84}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg84}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos84}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra84}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4](#MongosConfigSet4_4)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4](#MongoCfgConfigSet4_4)**<br> 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0 {#Mongodb5_07}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod85)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg85)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos85)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra85)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod85}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg85}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos85}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra85}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0](#MongosConfigSet5_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0](#MongoCfgConfigSet5_0)**<br> 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0 {#Mongodb6_07}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod86)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg86)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos86)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra86)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod86}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg86}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos86}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra86}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0](#MongosConfigSet6_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0](#MongoCfgConfigSet6_0)**<br> 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4_enterprise {#Mongodb4_4_enterprise7}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod87)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg87)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos87)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra87)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod87}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4_enterprise`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg87}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4_enterprise`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos87}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4_enterprise`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra87}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4_enterprise](#MongosConfigSet4_4_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4_enterprise](#MongoCfgConfigSet4_4_enterprise)**<br> 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0_enterprise {#Mongodb5_0_enterprise7}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod88)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg88)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos88)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra88)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod88}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0_enterprise`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg88}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0_enterprise`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos88}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0_enterprise`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra88}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0_enterprise](#MongosConfigSet5_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0_enterprise](#MongoCfgConfigSet5_0_enterprise)**<br> 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0_enterprise {#Mongodb6_0_enterprise7}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod89)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg89)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos89)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra89)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod89}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0_enterprise`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg89}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0_enterprise`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos89}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0_enterprise`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra89}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0_enterprise](#MongosConfigSet6_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0_enterprise](#MongoCfgConfigSet6_0_enterprise)**<br> 
resources | **[Resources](#Resources8)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### PerformanceDiagnosticsConfig {#PerformanceDiagnosticsConfig7}

Field | Description
--- | ---
profiling_enabled | **bool**<br> 


### Access {#Access7}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


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

Creates a new MongoDB cluster using the specified backup.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster8)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. ID of the backup to create a cluster from. To get the backup ID, use a [ClusterService.ListBackups](#ListBackups) request. 
name | **string**<br>Required. Name of the new MongoDB cluster. The name must be unique within the folder. The name can't be changed after the MongoDB cluster is created. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the new MongoDB cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster8)**<br>Required. Deployment environment of the new MongoDB cluster. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Required. Configuration for the MongoDB cluster to be created. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Configurations for MongoDB hosts that should be created for the cluster that is being created from the backup. The number of elements must be greater than 0.
network_id | **string**<br>Required. ID of the network to create the MongoDB cluster in. The maximum string length in characters is 50.
folder_id | **string**<br>Required. ID of the folder to create the MongoDB cluster in. The maximum string length in characters is 50.
recovery_target_spec | **RecoveryTargetSpec**<br>Specification of the moment to which the MongoDB cluster should be restored. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### RecoveryTargetSpec {#RecoveryTargetSpec}

Field | Description
--- | ---
timestamp | **int64**<br>Timestamp of the recovery target Value must be greater than 0.


### ConfigSpec {#ConfigSpec2}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB used in the cluster. Possible values: `3.6`, `4.0`, `4.2`, `4.4`, `4.4-enterprise`, `5.0`, `5.0-enterprise`, `6.0`, `6.0-enterprise`. 
feature_compatibility_version | **string**<br>MongoDB feature compatibility version. See usage details in [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/). <br>Possible values: <ul><li>`3.6` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or older. </li><li>`4.0` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or older. </li><li>`4.2` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or older. </li><li>`4.4` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or older. </li><li>`5.0` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 4.4 or older. </li><li>`6.0` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 5.0 or older.</li></ul> 
mongodb_spec | **oneof:** `mongodb_spec_3_6`, `mongodb_spec_4_0`, `mongodb_spec_4_2`, `mongodb_spec_4_4`, `mongodb_spec_5_0`, `mongodb_spec_6_0`, `mongodb_spec_4_4_enterprise`, `mongodb_spec_5_0_enterprise` or `mongodb_spec_6_0_enterprise`<br>
&nbsp;&nbsp;mongodb_spec_3_6 | **[MongodbSpec3_6](#MongodbSpec3_6)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. 
&nbsp;&nbsp;mongodb_spec_4_0 | **[MongodbSpec4_0](#MongodbSpec4_0)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. 
&nbsp;&nbsp;mongodb_spec_4_2 | **[MongodbSpec4_2](#MongodbSpec4_2)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. 
&nbsp;&nbsp;mongodb_spec_4_4 | **[MongodbSpec4_4](#MongodbSpec4_4)**<br>Configuration and resource allocation for a MongoDB 4.4 cluster. 
&nbsp;&nbsp;mongodb_spec_5_0 | **[MongodbSpec5_0](#MongodbSpec5_0)**<br>Configuration and resource allocation for a MongoDB 5.0 cluster. 
&nbsp;&nbsp;mongodb_spec_6_0 | **[MongodbSpec6_0](#MongodbSpec6_0)**<br>Configuration and resource allocation for a MongoDB 6.0 cluster. 
&nbsp;&nbsp;mongodb_spec_4_4_enterprise | **[MongodbSpec4_4_enterprise](#MongodbSpec4_4_enterprise)**<br>Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster. 
&nbsp;&nbsp;mongodb_spec_5_0_enterprise | **[MongodbSpec5_0_enterprise](#MongodbSpec5_0_enterprise)**<br>Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster. 
&nbsp;&nbsp;mongodb_spec_6_0_enterprise | **[MongodbSpec6_0_enterprise](#MongodbSpec6_0_enterprise)**<br>Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retain period of automatically created backup in days Acceptable values are 7 to 35, inclusive.
performance_diagnostics | **[PerformanceDiagnosticsConfig](#PerformanceDiagnosticsConfig8)**<br>Performance Diagnosics configuration 
access | **[Access](#Access8)**<br>Access policy to DB 


### MongodbSpec3_6 {#MongodbSpec3_62}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod90)**<br>Configuration and resource allocation for mongod 3.6 hosts. 
mongocfg | **[MongoCfg](#MongoCfg90)**<br>Configuration and resource allocation for mongocfg 3.6 hosts. 
mongos | **[Mongos](#Mongos90)**<br>Configuration and resource allocation for mongos 3.6 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra90)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 3.6 hosts. 


### Mongod {#Mongod90}

Field | Description
--- | ---
config | **`config.MongodConfig3_6`**<br>Configuration for mongod 3.6 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg90}

Field | Description
--- | ---
config | **`config.MongoCfgConfig3_6`**<br>Configuration for mongocfg 3.6 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos90}

Field | Description
--- | ---
config | **`config.MongosConfig3_6`**<br>Configuration for mongos 3.6 hosts. 
resources | **[Resources](#Resources8)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra90}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig3_6](#MongosConfig3_6)**<br>Configuration for mongoinfra 3.6 hosts. 
config_mongocfg | **[config.MongoCfgConfig3_6](#MongoCfgConfig3_6)**<br> 
resources | **[Resources](#Resources8)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### Resources {#Resources8}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### MongodbSpec4_0 {#MongodbSpec4_02}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod91)**<br>Configuration and resource allocation for mongod 4.0 hosts. 
mongocfg | **[MongoCfg](#MongoCfg91)**<br>Configuration and resource allocation for mongocfg 4.0 hosts. 
mongos | **[Mongos](#Mongos91)**<br>Configuration and resource allocation for mongos 4.0 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra91)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.0 hosts. 


### Mongod {#Mongod91}

Field | Description
--- | ---
config | **`config.MongodConfig4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg91}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos91}

Field | Description
--- | ---
config | **`config.MongosConfig4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra91}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig4_0](#MongosConfig4_0)**<br>Configuration for mongoinfra 4.0 hosts. 
config_mongocfg | **[config.MongoCfgConfig4_0](#MongoCfgConfig4_0)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec4_2 {#MongodbSpec4_22}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod92)**<br>Configuration and resource allocation for mongod 4.2 hosts. 
mongocfg | **[MongoCfg](#MongoCfg92)**<br>Configuration and resource allocation for mongocfg 4.2 hosts. 
mongos | **[Mongos](#Mongos92)**<br>Configuration and resource allocation for mongos 4.2 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra92)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.2 hosts. 


### Mongod {#Mongod92}

Field | Description
--- | ---
config | **`config.MongodConfig4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg92}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos92}

Field | Description
--- | ---
config | **`config.MongosConfig4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra92}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig4_2](#MongosConfig4_2)**<br>Configuration for mongoinfra 4.2 hosts. 
config_mongocfg | **[config.MongoCfgConfig4_2](#MongoCfgConfig4_2)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec4_4 {#MongodbSpec4_42}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod93)**<br>Configuration and resource allocation for mongod 4.4 hosts. 
mongocfg | **[MongoCfg](#MongoCfg93)**<br>Configuration and resource allocation for mongocfg 4.4 hosts. 
mongos | **[Mongos](#Mongos93)**<br>Configuration and resource allocation for mongos 4.4 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra93)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.4 hosts. 


### Mongod {#Mongod93}

Field | Description
--- | ---
config | **`config.MongodConfig4_4`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg93}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_4`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos93}

Field | Description
--- | ---
config | **`config.MongosConfig4_4`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra93}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig4_4](#MongosConfig4_4)**<br>Configuration for mongoinfra 4.4 hosts. 
config_mongocfg | **[config.MongoCfgConfig4_4](#MongoCfgConfig4_4)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec5_0 {#MongodbSpec5_02}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod94)**<br>Configuration and resource allocation for mongod 5.0 hosts. 
mongocfg | **[MongoCfg](#MongoCfg94)**<br>Configuration and resource allocation for mongocfg 5.0 hosts. 
mongos | **[Mongos](#Mongos94)**<br>Configuration and resource allocation for mongos 5.0 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra94)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 5.0 hosts. 


### Mongod {#Mongod94}

Field | Description
--- | ---
config | **`config.MongodConfig5_0`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg94}

Field | Description
--- | ---
config | **`config.MongoCfgConfig5_0`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos94}

Field | Description
--- | ---
config | **`config.MongosConfig5_0`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra94}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig5_0](#MongosConfig5_0)**<br>Configuration for mongoinfra 5.0 hosts. 
config_mongocfg | **[config.MongoCfgConfig5_0](#MongoCfgConfig5_0)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec6_0 {#MongodbSpec6_02}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod95)**<br>Configuration and resource allocation for mongod 6.0 hosts. 
mongocfg | **[MongoCfg](#MongoCfg95)**<br>Configuration and resource allocation for mongocfg 6.0 hosts. 
mongos | **[Mongos](#Mongos95)**<br>Configuration and resource allocation for mongos 6.0 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra95)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 6.0 hosts. 


### Mongod {#Mongod95}

Field | Description
--- | ---
config | **`config.MongodConfig6_0`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg95}

Field | Description
--- | ---
config | **`config.MongoCfgConfig6_0`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos95}

Field | Description
--- | ---
config | **`config.MongosConfig6_0`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra95}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig6_0](#MongosConfig6_0)**<br>Configuration for mongoinfra 6.0 hosts. 
config_mongocfg | **[config.MongoCfgConfig6_0](#MongoCfgConfig6_0)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec4_4_enterprise {#MongodbSpec4_4_enterprise2}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod96)**<br>Configuration and resource allocation for mongod 4.4 hosts. 
mongocfg | **[MongoCfg](#MongoCfg96)**<br>Configuration and resource allocation for mongocfg 4.4 hosts. 
mongos | **[Mongos](#Mongos96)**<br>Configuration and resource allocation for mongos 4.4 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra96)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.4 hosts. 


### Mongod {#Mongod96}

Field | Description
--- | ---
config | **`config.MongodConfig4_4_enterprise`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg96}

Field | Description
--- | ---
config | **`config.MongoCfgConfig4_4_enterprise`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos96}

Field | Description
--- | ---
config | **`config.MongosConfig4_4_enterprise`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra96}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig4_4_enterprise](#MongosConfig4_4_enterprise)**<br>Configuration for mongoinfra 4.4 hosts. 
config_mongocfg | **[config.MongoCfgConfig4_4_enterprise](#MongoCfgConfig4_4_enterprise)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec5_0_enterprise {#MongodbSpec5_0_enterprise2}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod97)**<br>Configuration and resource allocation for mongod 5.0 hosts. 
mongocfg | **[MongoCfg](#MongoCfg97)**<br>Configuration and resource allocation for mongocfg 5.0 hosts. 
mongos | **[Mongos](#Mongos97)**<br>Configuration and resource allocation for mongos 5.0 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra97)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 5.0 hosts. 


### Mongod {#Mongod97}

Field | Description
--- | ---
config | **`config.MongodConfig5_0_enterprise`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg97}

Field | Description
--- | ---
config | **`config.MongoCfgConfig5_0_enterprise`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos97}

Field | Description
--- | ---
config | **`config.MongosConfig5_0_enterprise`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra97}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig5_0_enterprise](#MongosConfig5_0_enterprise)**<br>Configuration for mongoinfra 5.0 hosts. 
config_mongocfg | **[config.MongoCfgConfig5_0_enterprise](#MongoCfgConfig5_0_enterprise)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### MongodbSpec6_0_enterprise {#MongodbSpec6_0_enterprise2}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod98)**<br>Configuration and resource allocation for mongod 6.0 hosts. 
mongocfg | **[MongoCfg](#MongoCfg98)**<br>Configuration and resource allocation for mongocfg 6.0 hosts. 
mongos | **[Mongos](#Mongos98)**<br>Configuration and resource allocation for mongos 6.0 hosts. 
mongoinfra | **[MongoInfra](#MongoInfra98)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 6.0 hosts. 


### Mongod {#Mongod98}

Field | Description
--- | ---
config | **`config.MongodConfig6_0_enterprise`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongod host. 


### MongoCfg {#MongoCfg98}

Field | Description
--- | ---
config | **`config.MongoCfgConfig6_0_enterprise`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongocfg host. 


### Mongos {#Mongos98}

Field | Description
--- | ---
config | **`config.MongosConfig6_0_enterprise`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongos host. 


### MongoInfra {#MongoInfra98}

Field | Description
--- | ---
config_mongos | **[config.MongosConfig6_0_enterprise](#MongosConfig6_0_enterprise)**<br>Configuration for mongoinfra 6.0 hosts. 
config_mongocfg | **[config.MongoCfgConfig6_0_enterprise](#MongoCfgConfig6_0_enterprise)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to each mongoinfra (mongos+mongocfg) host. 


### PerformanceDiagnosticsConfig {#PerformanceDiagnosticsConfig8}

Field | Description
--- | ---
profiling_enabled | **bool**<br> 


### Access {#Access8}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


### HostSpec {#HostSpec1}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The network ID is set in the [Cluster.network_id](#Cluster8) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 
type | **[Host.Type](#Host)**<br>Type of the host to be deployed. 
shard_name | **string**<br>Name of the shard that the host belongs to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
hidden | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Is host hidden in replSet 
secondary_delay_secs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of seconds "behind" the primary that this replica set member should "lag" 
priority | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br>Priority of host for the election in replSet 
tags | **map<string,string>**<br>Host tags 


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
cluster_id | **string**<br>ID of the new MongoDB cluster that is being created from a backup. 
backup_id | **string**<br>ID of the backup that is being used for creating a cluster. 


### Cluster {#Cluster8}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring8)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](#ClusterConfig8)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow8)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation8)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring8}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the MongoDB cluster. 


### ClusterConfig {#ClusterConfig8}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB server software. Possible values: `3.6`, `4.0`, `4.2`, `4.4`, `4.4-enterprise`, `5.0`, `5.0-enterprise`, `6.0`, `6.0-enterprise`. 
feature_compatibility_version | **string**<br>MongoDB feature compatibility version. See usage details in [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/). <br>Possible values: <ul><li>`3.6` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or lower. </li><li>`4.0` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or lower. </li><li>`4.2` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or lower. </li><li>`4.4` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or lower. </li><li>`5.0` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 5.0 or lower. </li><li>`6.0` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 6.0 or lower.</li></ul> 
mongodb | **oneof:** `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise` or `mongodb_6_0_enterprise`<br>Configuration for MongoDB servers in the cluster.
&nbsp;&nbsp;mongodb_3_6 | **[Mongodb3_6](#Mongodb3_68)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. 
&nbsp;&nbsp;mongodb_4_0 | **[Mongodb4_0](#Mongodb4_08)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. 
&nbsp;&nbsp;mongodb_4_2 | **[Mongodb4_2](#Mongodb4_28)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. 
&nbsp;&nbsp;mongodb_4_4 | **[Mongodb4_4](#Mongodb4_48)**<br>Configuration and resource allocation for a MongoDB 4.4 cluster. 
&nbsp;&nbsp;mongodb_5_0 | **[Mongodb5_0](#Mongodb5_08)**<br>Configuration and resource allocation for a MongoDB 5.0 cluster. 
&nbsp;&nbsp;mongodb_6_0 | **[Mongodb6_0](#Mongodb6_08)**<br>Configuration and resource allocation for a MongoDB 6.0 cluster. 
&nbsp;&nbsp;mongodb_4_4_enterprise | **[Mongodb4_4_enterprise](#Mongodb4_4_enterprise8)**<br>Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster. 
&nbsp;&nbsp;mongodb_5_0_enterprise | **[Mongodb5_0_enterprise](#Mongodb5_0_enterprise8)**<br>Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster. 
&nbsp;&nbsp;mongodb_6_0_enterprise | **[Mongodb6_0_enterprise](#Mongodb6_0_enterprise8)**<br>Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retain period of automatically created backup in days 
performance_diagnostics | **[PerformanceDiagnosticsConfig](#PerformanceDiagnosticsConfig9)**<br>Performance Diagnostic 
access | **[Access](#Access9)**<br>Access policy to DB 


### Mongodb3_6 {#Mongodb3_68}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod99)**<br>Configuration and resource allocation for mongod in a MongoDB 3.6 cluster. 
mongocfg | **[MongoCfg](#MongoCfg99)**<br>Configuration and resource allocation for mongocfg in a MongoDB 3.6 cluster. 
mongos | **[Mongos](#Mongos99)**<br>Configuration and resource allocation for mongos in a MongoDB 3.6 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra99)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 3.6 cluster. 


### Mongod {#Mongod99}

Field | Description
--- | ---
config | **`config.MongodConfigSet3_6`**<br>Configuration for a mongod 3.6 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to MongoDB hosts. 


### MongoCfg {#MongoCfg99}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet3_6`**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos99}

Field | Description
--- | ---
config | **`config.MongosConfigSet3_6`**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra99}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet3_6](#MongosConfigSet3_6)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet3_6](#MongoCfgConfigSet3_6)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_0 {#Mongodb4_08}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod100)**<br>Configuration and resource allocation for mongod in a MongoDB 4.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg100)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.0 cluster. 
mongos | **[Mongos](#Mongos100)**<br>Configuration and resource allocation for mongos in a MongoDB 4.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra100)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.0 cluster. 


### Mongod {#Mongod100}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg100}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos100}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra100}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_0](#MongosConfigSet4_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_0](#MongoCfgConfigSet4_0)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_2 {#Mongodb4_28}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod101)**<br>Configuration and resource allocation for mongod in a MongoDB 4.2 cluster. 
mongocfg | **[MongoCfg](#MongoCfg101)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.2 cluster. 
mongos | **[Mongos](#Mongos101)**<br>Configuration and resource allocation for mongos in a MongoDB 4.2 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra101)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.2 cluster. 


### Mongod {#Mongod101}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg101}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos101}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra101}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_2](#MongosConfigSet4_2)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_2](#MongoCfgConfigSet4_2)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4 {#Mongodb4_48}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod102)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg102)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos102)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra102)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod102}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg102}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos102}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra102}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4](#MongosConfigSet4_4)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4](#MongoCfgConfigSet4_4)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0 {#Mongodb5_08}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod103)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg103)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos103)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra103)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod103}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg103}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos103}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra103}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0](#MongosConfigSet5_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0](#MongoCfgConfigSet5_0)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0 {#Mongodb6_08}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod104)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg104)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos104)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra104)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod104}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg104}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos104}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra104}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0](#MongosConfigSet6_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0](#MongoCfgConfigSet6_0)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4_enterprise {#Mongodb4_4_enterprise8}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod105)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg105)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos105)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra105)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod105}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4_enterprise`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg105}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4_enterprise`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos105}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4_enterprise`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra105}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4_enterprise](#MongosConfigSet4_4_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4_enterprise](#MongoCfgConfigSet4_4_enterprise)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0_enterprise {#Mongodb5_0_enterprise8}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod106)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg106)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos106)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra106)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod106}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0_enterprise`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg106}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0_enterprise`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos106}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0_enterprise`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra106}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0_enterprise](#MongosConfigSet5_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0_enterprise](#MongoCfgConfigSet5_0_enterprise)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0_enterprise {#Mongodb6_0_enterprise8}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod107)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg107)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos107)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra107)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod107}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0_enterprise`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg107}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0_enterprise`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos107}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0_enterprise`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra107}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0_enterprise](#MongosConfigSet6_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0_enterprise](#MongoCfgConfigSet6_0_enterprise)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


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
cluster_id | **string**<br>Required. ID of the MongoDB cluster to reschedule the maintenance operation for. The maximum string length in characters is 50.
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
cluster_id | **string**<br>Required. ID of the MongoDB cluster. 
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. The time until which this maintenance operation is to be delayed. 


### Cluster {#Cluster9}

Field | Description
--- | ---
id | **string**<br>ID of the MongoDB cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the MongoDB cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the MongoDB cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the MongoDB cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring9)**<br>Description of monitoring systems relevant to the MongoDB cluster. 
config | **[ClusterConfig](#ClusterConfig9)**<br>Configuration of the MongoDB cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
sharded | **bool**<br>Indicates current sharding status of the cluster. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow9)**<br>Maintenance window for the cluster. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation9)**<br>Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. 
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### Monitoring {#Monitoring9}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the MongoDB cluster. 


### ClusterConfig {#ClusterConfig9}

Field | Description
--- | ---
version | **string**<br>Version of MongoDB server software. Possible values: `3.6`, `4.0`, `4.2`, `4.4`, `4.4-enterprise`, `5.0`, `5.0-enterprise`, `6.0`, `6.0-enterprise`. 
feature_compatibility_version | **string**<br>MongoDB feature compatibility version. See usage details in [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/). <br>Possible values: <ul><li>`3.6` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or lower. </li><li>`4.0` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or lower. </li><li>`4.2` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or lower. </li><li>`4.4` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or lower. </li><li>`5.0` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 5.0 or lower. </li><li>`6.0` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 6.0 or lower.</li></ul> 
mongodb | **oneof:** `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise` or `mongodb_6_0_enterprise`<br>Configuration for MongoDB servers in the cluster.
&nbsp;&nbsp;mongodb_3_6 | **[Mongodb3_6](#Mongodb3_69)**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. 
&nbsp;&nbsp;mongodb_4_0 | **[Mongodb4_0](#Mongodb4_09)**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. 
&nbsp;&nbsp;mongodb_4_2 | **[Mongodb4_2](#Mongodb4_29)**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. 
&nbsp;&nbsp;mongodb_4_4 | **[Mongodb4_4](#Mongodb4_49)**<br>Configuration and resource allocation for a MongoDB 4.4 cluster. 
&nbsp;&nbsp;mongodb_5_0 | **[Mongodb5_0](#Mongodb5_09)**<br>Configuration and resource allocation for a MongoDB 5.0 cluster. 
&nbsp;&nbsp;mongodb_6_0 | **[Mongodb6_0](#Mongodb6_09)**<br>Configuration and resource allocation for a MongoDB 6.0 cluster. 
&nbsp;&nbsp;mongodb_4_4_enterprise | **[Mongodb4_4_enterprise](#Mongodb4_4_enterprise9)**<br>Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster. 
&nbsp;&nbsp;mongodb_5_0_enterprise | **[Mongodb5_0_enterprise](#Mongodb5_0_enterprise9)**<br>Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster. 
&nbsp;&nbsp;mongodb_6_0_enterprise | **[Mongodb6_0_enterprise](#Mongodb6_0_enterprise9)**<br>Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Retain period of automatically created backup in days 
performance_diagnostics | **[PerformanceDiagnosticsConfig](#PerformanceDiagnosticsConfig9)**<br>Performance Diagnostic 
access | **[Access](#Access9)**<br>Access policy to DB 


### Mongodb3_6 {#Mongodb3_69}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod108)**<br>Configuration and resource allocation for mongod in a MongoDB 3.6 cluster. 
mongocfg | **[MongoCfg](#MongoCfg108)**<br>Configuration and resource allocation for mongocfg in a MongoDB 3.6 cluster. 
mongos | **[Mongos](#Mongos108)**<br>Configuration and resource allocation for mongos in a MongoDB 3.6 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra108)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 3.6 cluster. 


### Mongod {#Mongod108}

Field | Description
--- | ---
config | **`config.MongodConfigSet3_6`**<br>Configuration for a mongod 3.6 hosts. 
resources | **[Resources](#Resources9)**<br>Resources allocated to MongoDB hosts. 


### MongoCfg {#MongoCfg108}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet3_6`**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos108}

Field | Description
--- | ---
config | **`config.MongosConfigSet3_6`**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra108}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet3_6](#MongosConfigSet3_6)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet3_6](#MongoCfgConfigSet3_6)**<br> 
resources | **[Resources](#Resources9)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Resources {#Resources9}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Mongodb4_0 {#Mongodb4_09}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod109)**<br>Configuration and resource allocation for mongod in a MongoDB 4.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg109)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.0 cluster. 
mongos | **[Mongos](#Mongos109)**<br>Configuration and resource allocation for mongos in a MongoDB 4.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra109)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.0 cluster. 


### Mongod {#Mongod109}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_0`**<br>Configuration for mongod 4.0 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg109}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_0`**<br>Configuration for mongocfg 4.0 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos109}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_0`**<br>Configuration for mongos 4.0 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra109}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_0](#MongosConfigSet4_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_0](#MongoCfgConfigSet4_0)**<br> 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_2 {#Mongodb4_29}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod110)**<br>Configuration and resource allocation for mongod in a MongoDB 4.2 cluster. 
mongocfg | **[MongoCfg](#MongoCfg110)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.2 cluster. 
mongos | **[Mongos](#Mongos110)**<br>Configuration and resource allocation for mongos in a MongoDB 4.2 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra110)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.2 cluster. 


### Mongod {#Mongod110}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_2`**<br>Configuration for mongod 4.2 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg110}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_2`**<br>Configuration for mongocfg 4.2 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos110}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_2`**<br>Configuration for mongos 4.2 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra110}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_2](#MongosConfigSet4_2)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_2](#MongoCfgConfigSet4_2)**<br> 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4 {#Mongodb4_49}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod111)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg111)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos111)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra111)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod111}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg111}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos111}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra111}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4](#MongosConfigSet4_4)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4](#MongoCfgConfigSet4_4)**<br> 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0 {#Mongodb5_09}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod112)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg112)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos112)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra112)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod112}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg112}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos112}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra112}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0](#MongosConfigSet5_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0](#MongoCfgConfigSet5_0)**<br> 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0 {#Mongodb6_09}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod113)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg113)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos113)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra113)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod113}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg113}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos113}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra113}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0](#MongosConfigSet6_0)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0](#MongoCfgConfigSet6_0)**<br> 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb4_4_enterprise {#Mongodb4_4_enterprise9}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod114)**<br>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. 
mongocfg | **[MongoCfg](#MongoCfg114)**<br>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. 
mongos | **[Mongos](#Mongos114)**<br>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra114)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. 


### Mongod {#Mongod114}

Field | Description
--- | ---
config | **`config.MongodConfigSet4_4_enterprise`**<br>Configuration for mongod 4.4 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg114}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet4_4_enterprise`**<br>Configuration for mongocfg 4.4 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos114}

Field | Description
--- | ---
config | **`config.MongosConfigSet4_4_enterprise`**<br>Configuration for mongos 4.4 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra114}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet4_4_enterprise](#MongosConfigSet4_4_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet4_4_enterprise](#MongoCfgConfigSet4_4_enterprise)**<br> 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb5_0_enterprise {#Mongodb5_0_enterprise9}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod115)**<br>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg115)**<br>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. 
mongos | **[Mongos](#Mongos115)**<br>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra115)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. 


### Mongod {#Mongod115}

Field | Description
--- | ---
config | **`config.MongodConfigSet5_0_enterprise`**<br>Configuration for mongod 5.0 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg115}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet5_0_enterprise`**<br>Configuration for mongocfg 5.0 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos115}

Field | Description
--- | ---
config | **`config.MongosConfigSet5_0_enterprise`**<br>Configuration for mongos 5.0 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra115}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet5_0_enterprise](#MongosConfigSet5_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet5_0_enterprise](#MongoCfgConfigSet5_0_enterprise)**<br> 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### Mongodb6_0_enterprise {#Mongodb6_0_enterprise9}

Field | Description
--- | ---
mongod | **[Mongod](#Mongod116)**<br>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. 
mongocfg | **[MongoCfg](#MongoCfg116)**<br>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. 
mongos | **[Mongos](#Mongos116)**<br>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. 
mongoinfra | **[MongoInfra](#MongoInfra116)**<br>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. 


### Mongod {#Mongod116}

Field | Description
--- | ---
config | **`config.MongodConfigSet6_0_enterprise`**<br>Configuration for mongod 6.0 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongod hosts. 


### MongoCfg {#MongoCfg116}

Field | Description
--- | ---
config | **`config.MongoCfgConfigSet6_0_enterprise`**<br>Configuration for mongocfg 6.0 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongocfg hosts. 


### Mongos {#Mongos116}

Field | Description
--- | ---
config | **`config.MongosConfigSet6_0_enterprise`**<br>Configuration for mongos 6.0 hosts. 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongos hosts. 


### MongoInfra {#MongoInfra116}

Field | Description
--- | ---
config_mongos | **[config.MongosConfigSet6_0_enterprise](#MongosConfigSet6_0_enterprise)**<br> 
config_mongocfg | **[config.MongoCfgConfigSet6_0_enterprise](#MongoCfgConfigSet6_0_enterprise)**<br> 
resources | **[Resources](#Resources10)**<br>Resources allocated to mongoinfra (mongos+mongocfg) hosts. 


### PerformanceDiagnosticsConfig {#PerformanceDiagnosticsConfig9}

Field | Description
--- | ---
profiling_enabled | **bool**<br> 


### Access {#Access9}

Field | Description
--- | ---
data_lens | **bool**<br>Allow access for DataLens. 
data_transfer | **bool**<br>Allow access for DataTransfer. 


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


## ListLogs {#ListLogs}

Retrieves logs for the specified MongoDB cluster. See the [Logs](/yandex-mdb-guide/concepts/logs.html) section in the developers guide for detailed logs description.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to request logs for. To get the MongoDB cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from the logs table to request. If no columns are specified, entire log records are returned. 
service_type | enum **ServiceType**<br>Type of the service to request logs about. <ul><li>`MONGOD`: Logs of MongoDB activity.</li><li>`AUDIT`: MongoDB Enterprise audit logs</li></ul>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. The maximum value is 1000.
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
cluster_id | **string**<br>Required. Required. ID of the MongoDB cluster. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from logs table to get in the response. 
service_type | enum **ServiceType**<br> <ul><li>`MONGOD`: Logs of MongoDB activity.</li><li>`AUDIT`: MongoDB Enterprise audit logs</li></ul>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request. If this field is not set, all existing logs will be sent and then the new ones as they appear. In essence it has 'tail -f' semantics. 
record_token | **string**<br>Record token. Set `record_token` to the `next_record_token` returned by a previous StreamLogs request to start streaming from next log record. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname](#LogRecord), [LogRecord.logs.message.severity](#LogRecord) fields. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-z0-9.-]{1,61}`. </li></ol>Examples of a filter: `message.hostname='node1.db.cloud.yandex.net'`, `message.severity IN ('E', 'F')` The maximum string length in characters is 1000.


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
cluster_id | **string**<br>Required. ID of the MongoDB Cluster resource to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation9)**<br>List of Operation resources for the specified MongoDB cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest), use the `next_page_token` as the value for the [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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

Retrieves the list of available backups for the specified MongoDB cluster.

**rpc ListBackups ([ListClusterBackupsRequest](#ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#ListClusterBackupsResponse))**

### ListClusterBackupsRequest {#ListClusterBackupsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster. To get the MongoDB cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterBackupsResponse {#ListClusterBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup)**<br>List of MongoDB Backup resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterBackupsRequest.page_size](#ListClusterBackupsRequest), use the `next_page_token` as the value for the [ListClusterBackupsRequest.page_token](#ListClusterBackupsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>ID of the backup. Required. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format (i.e. when the backup operation was completed). 
source_cluster_id | **string**<br>ID of the MongoDB cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was started. 
source_shard_names[] | **string**<br>Shard names used as a source for backup. 
size | **int64**<br>Size of backup in bytes 
type | enum **BackupType**<br>How this backup was created (manual/automatic/etc...) <ul><li>`AUTOMATED`: Backup created by automated daily schedule</li><li>`MANUAL`: Backup created by user request</li></ul>


## ListHosts {#ListHosts}

Retrieves a list of hosts for the specified cluster.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster. To get the MongoDB cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](#Host)**<br>List of Host resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
name | **string**<br>Name of the MongoDB host. The host name is assigned by MDB at creation time, and cannot be changed. 1-63 characters long. <br>The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. 
cluster_id | **string**<br>ID of the MongoDB host. The ID is assigned by MDB at creation time. 
zone_id | **string**<br>ID of the availability zone where the MongoDB host resides. 
resources | **[Resources](#Resources10)**<br>Resources allocated to the MongoDB host. 
role | enum **Role**<br>Role of the host in the cluster. If the field has default value, it is not returned in the response. <ul><li>`ROLE_UNKNOWN`: Role of the host in the cluster is unknown. Default value.</li><li>`PRIMARY`: Host is the primary MongoDB server in the cluster.</li><li>`SECONDARY`: Host is a secondary MongoDB server in the cluster.</li></ul>
health | enum **Health**<br>Aggregated health of the host. If the field has default value, it is not returned in the response. <ul><li>`HEALTH_UNKNOWN`: Health of the host is unknown. Default value.</li><li>`ALIVE`: The host is performing all its functions normally.</li><li>`DEAD`: The host is inoperable, and cannot perform any of its essential functions.</li><li>`DEGRADED`: The host is degraded, and can perform only some of its essential functions.</li></ul>
services[] | **[Service](#Service)**<br>Services provided by the host. 
subnet_id | **string**<br>ID of the subnet that the host belongs to. 
assign_public_ip | **bool**<br>Flag showing public IP assignment status to this host. 
shard_name | **string**<br>Shard which this host belongs to. 
type | enum **Type**<br>Host type. If the field has default value, it is not returned in the response. <ul><li>`TYPE_UNSPECIFIED`: Type of the host is unspecified. Default value.</li><li>`MONGOD`: A mongod host.</li><li>`MONGOS`: A mongos host.</li><li>`MONGOCFG`: A mongocfg host.</li><li>`MONGOINFRA`: A mongoinfra (mongos+mongocfg) host.</li></ul>
host_parameters | **[HostParameters](#HostParameters)**<br>Host parameters 


### HostParameters {#HostParameters}

Field | Description
--- | ---
hidden | **bool**<br> 
secondary_delay_secs | **int64**<br> 
priority | **double**<br> 
tags | **map<string,string>**<br> 


### Resources {#Resources10}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Service {#Service}

Field | Description
--- | ---
type | enum **Type**<br>Type of the service provided by the host. If the field has default value, it is not returned in the response. <ul><li>`TYPE_UNSPECIFIED`: Service type of the host is unspecified. Default value.</li><li>`MONGOD`: The host is running a mongod daemon.</li><li>`MONGOS`: The host is running a mongos daemon.</li><li>`MONGOCFG`: The host is running a MongoDB config server.</li></ul>
health | enum **Health**<br>Aggregated health of the service. If the field has default value, it is not returned in the response. <ul><li>`HEALTH_UNKNOWN`: Health of the server is unknown.</li><li>`ALIVE`: The server is working normally.</li><li>`DEAD`: The server is dead or unresponsive.</li></ul>


## AddHosts {#AddHosts}

Creates new hosts for a cluster.

**rpc AddHosts ([AddClusterHostsRequest](#AddClusterHostsRequest)) returns ([operation.Operation](#Operation10))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterHostsMetadata](#AddClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddClusterHostsRequest {#AddClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to add hosts to. To get the MongoDB cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
host_specs[] | **[HostSpec](#HostSpec)**<br>Configurations for MongoDB hosts that should be added to the cluster. The number of elements must be greater than 0.


### HostSpec {#HostSpec2}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The network ID is set in the [Cluster.network_id](#Cluster10) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 
type | **[Host.Type](#Host1)**<br>Type of the host to be deployed. 
shard_name | **string**<br>Name of the shard that the host belongs to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
hidden | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Is host hidden in replSet 
secondary_delay_secs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of seconds "behind" the primary that this replica set member should "lag" 
priority | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br>Priority of host for the election in replSet 
tags | **map<string,string>**<br>Host tags 


### Operation {#Operation10}

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
cluster_id | **string**<br>Required. ID of the MongoDB cluster to remove hosts from. To get the MongoDB cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
host_names[] | **string**<br>Names of hosts to delete. The number of elements must be greater than 0. The maximum string length in characters for each value is 253.


### Operation {#Operation11}

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


## UpdateHosts {#UpdateHosts}

Updates the specified parameters for the host.

**rpc UpdateHosts ([UpdateClusterHostsRequest](#UpdateClusterHostsRequest)) returns ([operation.Operation](#Operation12))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterHostsMetadata](#UpdateClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateClusterHostsRequest {#UpdateClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to update hosts from. To get the MongoDB cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_host_specs[] | **[UpdateHostSpec](#UpdateHostSpec)**<br>New configurations to apply to hosts. The number of elements must be greater than 0.


### UpdateHostSpec {#UpdateHostSpec}

Field | Description
--- | ---
host_name | **string**<br>Required. Names of hosts to update. The maximum string length in characters is 253.
hidden | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Is host hidden in replSet 
secondary_delay_secs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of seconds "behind" the primary that this replica set member should "lag" 
priority | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br>Priority of host for the election in replSet 
assign_public_ip | **bool**<br>Whether the host should get a public IP address on update. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the MongoDB host should be updated. 
tags | **map<string,string>**<br>Host tags 


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
cluster_id | **string**<br>ID of the MongoDB cluster to update host from. 
host_names[] | **string**<br>Name of host that are being updated. 


## EnableSharding {#EnableSharding}

Enables sharding for the cluster: creates 3 mongoinfra (or 3 mongocfg and 2 mongos) hosts that would support adding and using shards in the cluster.

**rpc EnableSharding ([EnableClusterShardingRequest](#EnableClusterShardingRequest)) returns ([operation.Operation](#Operation13))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[EnableClusterShardingMetadata](#EnableClusterShardingMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### EnableClusterShardingRequest {#EnableClusterShardingRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to enable sharding for. The maximum string length in characters is 50.
mongocfg | **[MongoCfg](#MongoCfg117)**<br>mongocfg specification for sharding. 
mongos | **[Mongos](#Mongos117)**<br>mongos specification for sharding. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Configurations for mongos and mongocfg hosts. The number of elements must be greater than 0.
mongoinfra | **[MongoInfra](#MongoInfra117)**<br>mongos specification for sharding. 


### MongoCfg {#MongoCfg117}

Field | Description
--- | ---
resources | **[Resources](#Resources11)**<br>Required. Resources for mongocfg hosts. 


### Mongos {#Mongos117}

Field | Description
--- | ---
resources | **[Resources](#Resources11)**<br>Required. Resources for mongos hosts. 


### MongoInfra {#MongoInfra117}

Field | Description
--- | ---
resources | **[Resources](#Resources11)**<br>Required. Resources for mongoinfra (mongos+mongocfg) hosts. 


### HostSpec {#HostSpec3}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The network ID is set in the [Cluster.network_id](#Cluster10) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 
type | **[Host.Type](#Host1)**<br>Type of the host to be deployed. 
shard_name | **string**<br>Name of the shard that the host belongs to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
hidden | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Is host hidden in replSet 
secondary_delay_secs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of seconds "behind" the primary that this replica set member should "lag" 
priority | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br>Priority of host for the election in replSet 
tags | **map<string,string>**<br>Host tags 


### Resources {#Resources11}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. Possible values: <ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### Operation {#Operation13}

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

**rpc GetShard ([GetClusterShardRequest](#GetClusterShardRequest)) returns ([Shard](#Shard))**

### GetClusterShardRequest {#GetClusterShardRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster that the shard belongs to. To get the cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name of the MongoDB shard to return. To get the name of the shard use a [ClusterService.ListShards](#ListShards) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br>Required. ID of the MongoDB cluster to list databases in. To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterShardsResponse.next_page_token](#ListClusterShardsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterShardsResponse.next_page_token](#ListClusterShardsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterShardsResponse {#ListClusterShardsResponse}

Field | Description
--- | ---
shards[] | **[Shard](#Shard1)**<br>List of MongoDB shards. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterShardsRequest.page_size](#ListClusterShardsRequest), use the `next_page_token` as the value for the [ListClusterShardsRequest.page_token](#ListClusterShardsRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Shard {#Shard1}

Field | Description
--- | ---
name | **string**<br>Name of the shard. 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 


## AddShard {#AddShard}

Creates a new shard.

**rpc AddShard ([AddClusterShardRequest](#AddClusterShardRequest)) returns ([operation.Operation](#Operation14))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterShardMetadata](#AddClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Shard](#Shard2)<br>

### AddClusterShardRequest {#AddClusterShardRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to add a shard to. To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name of the MongoDB shard to create. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
host_specs[] | **[HostSpec](#HostSpec)**<br>Configurations for mongod hosts to be created with the shard. The number of elements must be greater than 0.


### HostSpec {#HostSpec4}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The network ID is set in the [Cluster.network_id](#Cluster10) field. The maximum string length in characters is 50.
assign_public_ip | **bool**<br>Whether the host should get a public IP address on creation. <br>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed. <br>Possible values: <ul><li>false - don't assign a public IP to the host. </li><li>true - the host should have a public IP address.</li></ul> 
type | **[Host.Type](#Host1)**<br>Type of the host to be deployed. 
shard_name | **string**<br>Name of the shard that the host belongs to. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
hidden | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Is host hidden in replSet 
secondary_delay_secs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of seconds "behind" the primary that this replica set member should "lag" 
priority | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br>Priority of host for the election in replSet 
tags | **map<string,string>**<br>Host tags 


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
cluster_id | **string**<br>ID of the MongoDB cluster that a shard is being added to. 
shard_name | **string**<br>Name of the shard being added. 


### Shard {#Shard2}

Field | Description
--- | ---
name | **string**<br>Name of the shard. 
cluster_id | **string**<br>ID of the cluster that the shard belongs to. 


## DeleteShard {#DeleteShard}

Deletes the specified shard.

**rpc DeleteShard ([DeleteClusterShardRequest](#DeleteClusterShardRequest)) returns ([operation.Operation](#Operation15))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterShardMetadata](#DeleteClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterShardRequest {#DeleteClusterShardRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster to delete a shard in. To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
shard_name | **string**<br>Required. Name of the MongoDB shard to delete. To get the name of the shard use a [ClusterService.ListShards](#ListShards) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br>ID of the MongoDB cluster that a shard is being deleted in. 
shard_name | **string**<br>Name of the shard being deleted. 


## ResetupHosts {#ResetupHosts}

Resetups hosts.

**rpc ResetupHosts ([ResetupHostsRequest](#ResetupHostsRequest)) returns ([operation.Operation](#Operation16))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ResetupHostsMetadata](#ResetupHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### ResetupHostsRequest {#ResetupHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the MongoDB cluster. The maximum string length in characters is 50.
host_names[] | **string**<br>Required. Name of the hosts to resetup. The number of elements must be greater than 0. The maximum string length in characters for each value is 253.


### Operation {#Operation16}

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

Restarts hosts.

**rpc RestartHosts ([RestartHostsRequest](#RestartHostsRequest)) returns ([operation.Operation](#Operation17))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestartHostsMetadata](#RestartHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### RestartHostsRequest {#RestartHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the MongoDB cluster. The maximum string length in characters is 50.
host_names[] | **string**<br>Required. Name of the hosts to restart. The number of elements must be greater than 0. The maximum string length in characters for each value is 253.


### Operation {#Operation17}

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


## StepdownHosts {#StepdownHosts}

Stepdown hosts.

**rpc StepdownHosts ([StepdownHostsRequest](#StepdownHostsRequest)) returns ([operation.Operation](#Operation18))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StepdownHostsMetadata](#StepdownHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### StepdownHostsRequest {#StepdownHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the MongoDB cluster. The maximum string length in characters is 50.
host_names[] | **string**<br>Required. Name of the hosts to resetup. The number of elements must be greater than 0. The maximum string length in characters for each value is 253.


### Operation {#Operation18}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StepdownHostsMetadata](#StepdownHostsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### StepdownHostsMetadata {#StepdownHostsMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MongoDB cluster. 
host_names[] | **string**<br>Required. The name of hosts to resetup. 


