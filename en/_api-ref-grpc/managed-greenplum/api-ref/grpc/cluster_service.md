---
editable: false
---

# ClusterService

A set of methods for managing Greenplum clusters.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Greenplum cluster. |
| [List](#List) | Retrieves a list of Greenplum clusters that belong to the specified folder. |
| [Create](#Create) | Creates a Greenplum cluster in the specified folder. |
| [Delete](#Delete) | Deletes the specified Greenplum cluster. |
| [Start](#Start) | Starts the specified Greenplum cluster. |
| [Stop](#Stop) | Stops the specified Greenplum cluster. |
| [ListOperations](#ListOperations) | Retrieves the list of Operation resources for the specified cluster. |
| [ListMasterHosts](#ListMasterHosts) | Retrieves a list of master hosts for the specified cluster. |
| [ListSegmentHosts](#ListSegmentHosts) | Retrieves a list of segment hosts for the specified cluster. |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified Greenplum cluster. <br>To get the list of available Greenplum clusters, make a [List](#List) request.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum Cluster resource to return. To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Greenplum cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Required. Name of the Greenplum cluster. The name is unique within the folder. 1-63 characters long. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig)**<br>Green plum cluster config 
description | **string**<br>Description of the Greenplum cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Greenplum cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring)**<br>Description of monitoring systems relevant to the Greenplum cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig)**<br>Configuration of the Greenplum master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig)**<br>Configuration of the Greenplum segment subcluster. 
master_host_count | **int64**<br>Number of hosts of the master subcluster 
segment_host_count | **int64**<br>Number of hosts of the segment subcluster 
segment_in_host | **int64**<br>Number of segments in the host 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation)**<br>Maintenance operation planned at nearest maintenance_window. 
security_group_ids[] | **string**<br>User security groups 
user_name | **string**<br>Owner user name 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### GreenplumConfig {#GreenplumConfig}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster1). The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false - don't assign a public IP to the master hosts. </li><li>true - the master hosts should have a public IP address.</li></ul> 


### Access {#Access}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to Yandex DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the Yandex.Cloud management console. 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig}

Field | Description
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to Greenplum master subcluster hosts. 
config | **[GreenplumMasterConfigSet](#GreenplumMasterConfigSet)**<br>Configuration settings of a Greenplum master server. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br><ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### GreenplumMasterConfigSet {#GreenplumMasterConfigSet}

Field | Description
--- | ---
effective_config | **[GreenplumMasterConfig](#GreenplumMasterConfig)**<br>Required. Effective settings for a Greenplum master subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumMasterConfig](#GreenplumMasterConfig)**<br>User-defined settings for a Greenplum master subcluster. 
default_config | **[GreenplumMasterConfig](#GreenplumMasterConfig)**<br>Default configuration for a Greenplum master subcluster. 


### GreenplumMasterConfig {#GreenplumMasterConfig}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the Greenplum master subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. <ul><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
timezone | **google.protobuf.StringValue**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig}

Field | Description
--- | ---
resources | **[Resources](#Resources1)**<br>Resources allocated to Greenplum segment subcluster hosts. 
config | **[GreenplumSegmentConfigSet](#GreenplumSegmentConfigSet)**<br>Configuration settings of a Greenplum segment server. 


### Resources {#Resources1}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br><ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### GreenplumSegmentConfigSet {#GreenplumSegmentConfigSet}

Field | Description
--- | ---
effective_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig)**<br>Required. Effective settings for a Greenplum segment subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig)**<br>User-defined settings for a Greenplum segment subcluster. 
default_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig)**<br>Default configuration for a Greenplum segment subcluster. 


### GreenplumSegmentConfig {#GreenplumSegmentConfig}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the Greenplum segment subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. <ul><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 


### MaintenanceWindow {#MaintenanceWindow}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow)**<br> 


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

Retrieves a list of Greenplum clusters that belong to the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list Greenplum clusters in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently you can only use filtering with the [Cluster.name](#Cluster1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 1-63 characters long and match the regular expression `^[a-zA-Z0-9_-]+$`.</li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of Greenplum Cluster resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster1}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Greenplum cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Required. Name of the Greenplum cluster. The name is unique within the folder. 1-63 characters long. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig1)**<br>Green plum cluster config 
description | **string**<br>Description of the Greenplum cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Greenplum cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Description of monitoring systems relevant to the Greenplum cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig1)**<br>Configuration of the Greenplum master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig1)**<br>Configuration of the Greenplum segment subcluster. 
master_host_count | **int64**<br>Number of hosts of the master subcluster 
segment_host_count | **int64**<br>Number of hosts of the segment subcluster 
segment_in_host | **int64**<br>Number of segments in the host 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow1)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation1)**<br>Maintenance operation planned at nearest maintenance_window. 
security_group_ids[] | **string**<br>User security groups 
user_name | **string**<br>Owner user name 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### GreenplumConfig {#GreenplumConfig1}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access1)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster2). The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false - don't assign a public IP to the master hosts. </li><li>true - the master hosts should have a public IP address.</li></ul> 


### Access {#Access1}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to Yandex DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the Yandex.Cloud management console. 


### Monitoring {#Monitoring1}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig1}

Field | Description
--- | ---
resources | **[Resources](#Resources2)**<br>Resources allocated to Greenplum master subcluster hosts. 
config | **[GreenplumMasterConfigSet](#GreenplumMasterConfigSet1)**<br>Configuration settings of a Greenplum master server. 


### Resources {#Resources2}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br><ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### GreenplumMasterConfigSet {#GreenplumMasterConfigSet1}

Field | Description
--- | ---
effective_config | **[GreenplumMasterConfig](#GreenplumMasterConfig1)**<br>Required. Effective settings for a Greenplum master subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumMasterConfig](#GreenplumMasterConfig1)**<br>User-defined settings for a Greenplum master subcluster. 
default_config | **[GreenplumMasterConfig](#GreenplumMasterConfig1)**<br>Default configuration for a Greenplum master subcluster. 


### GreenplumMasterConfig {#GreenplumMasterConfig1}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the Greenplum master subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. <ul><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
timezone | **google.protobuf.StringValue**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig1}

Field | Description
--- | ---
resources | **[Resources](#Resources3)**<br>Resources allocated to Greenplum segment subcluster hosts. 
config | **[GreenplumSegmentConfigSet](#GreenplumSegmentConfigSet1)**<br>Configuration settings of a Greenplum segment server. 


### Resources {#Resources3}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br><ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### GreenplumSegmentConfigSet {#GreenplumSegmentConfigSet1}

Field | Description
--- | ---
effective_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig1)**<br>Required. Effective settings for a Greenplum segment subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig1)**<br>User-defined settings for a Greenplum segment subcluster. 
default_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig1)**<br>Default configuration for a Greenplum segment subcluster. 


### GreenplumSegmentConfig {#GreenplumSegmentConfig1}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the Greenplum segment subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. <ul><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 


### MaintenanceWindow {#MaintenanceWindow1}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow1)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow1)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow1}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow1}

Field | Description
--- | ---
day | enum **WeekDay**<br> <ul><ul/>
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation1}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Create {#Create}

Creates a Greenplum cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create the Greenplum cluster in. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the Greenplum cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the Greenplum cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Greenplum cluster as `key:value` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Required. Deployment environment of the Greenplum cluster. 
config | **[GreenplumConfig](#GreenplumConfig2)**<br>Green plum cluster config 
master_config | **[MasterSubclusterConfigSpec](#MasterSubclusterConfigSpec)**<br>Configuration of the Greenplum master subcluster. 
segment_config | **[SegmentSubclusterConfigSpec](#SegmentSubclusterConfigSpec)**<br>Configuration of the Greenplum segment subcluster. 
master_host_count | **int64**<br>Number of hosts of the master subcluster 
segment_in_host | **int64**<br>Number of segments in the host 
segment_host_count | **int64**<br>Number of hosts of the segment subcluster 
user_name | **string**<br>Owner user name 
user_password | **string**<br>Required. Owner user password The string length in characters must be 8-128.
network_id | **string**<br>Required. ID of the network to create the cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>User security groups 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### GreenplumConfig {#GreenplumConfig2}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access2)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster2). The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false - don't assign a public IP to the master hosts. </li><li>true - the master hosts should have a public IP address.</li></ul> 


### Access {#Access2}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to Yandex DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the Yandex.Cloud management console. 


### MasterSubclusterConfigSpec {#MasterSubclusterConfigSpec}

Field | Description
--- | ---
resources | **[Resources](#Resources4)**<br>Resources allocated to Greenplum master subcluster hosts. 
config | **[GreenplumMasterConfig](#GreenplumMasterConfig2)**<br>Configuration settings of a Greenplum master server. 


### Resources {#Resources4}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br><ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### GreenplumMasterConfig {#GreenplumMasterConfig2}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the Greenplum master subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. <ul><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
timezone | **google.protobuf.StringValue**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 


### SegmentSubclusterConfigSpec {#SegmentSubclusterConfigSpec}

Field | Description
--- | ---
resources | **[Resources](#Resources5)**<br>Resources allocated to Greenplum segment subcluster hosts. 
config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig2)**<br>Configuration settings of a Greenplum segment server. 


### Resources {#Resources5}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br><ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### GreenplumSegmentConfig {#GreenplumSegmentConfig2}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the Greenplum segment subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. <ul><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 


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
cluster_id | **string**<br>ID of the Greenplum cluster that is being created. 


### Cluster {#Cluster2}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Greenplum cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Required. Name of the Greenplum cluster. The name is unique within the folder. 1-63 characters long. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig3)**<br>Green plum cluster config 
description | **string**<br>Description of the Greenplum cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Greenplum cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the Greenplum cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig2)**<br>Configuration of the Greenplum master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig2)**<br>Configuration of the Greenplum segment subcluster. 
master_host_count | **int64**<br>Number of hosts of the master subcluster 
segment_host_count | **int64**<br>Number of hosts of the segment subcluster 
segment_in_host | **int64**<br>Number of segments in the host 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow2)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation2)**<br>Maintenance operation planned at nearest maintenance_window. 
security_group_ids[] | **string**<br>User security groups 
user_name | **string**<br>Owner user name 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### GreenplumConfig {#GreenplumConfig3}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access3)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster3). The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false - don't assign a public IP to the master hosts. </li><li>true - the master hosts should have a public IP address.</li></ul> 


### Access {#Access3}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to Yandex DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the Yandex.Cloud management console. 


### Monitoring {#Monitoring2}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig2}

Field | Description
--- | ---
resources | **[Resources](#Resources6)**<br>Resources allocated to Greenplum master subcluster hosts. 
config | **[GreenplumMasterConfigSet](#GreenplumMasterConfigSet2)**<br>Configuration settings of a Greenplum master server. 


### Resources {#Resources6}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br><ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### GreenplumMasterConfigSet {#GreenplumMasterConfigSet2}

Field | Description
--- | ---
effective_config | **[GreenplumMasterConfig](#GreenplumMasterConfig3)**<br>Required. Effective settings for a Greenplum master subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumMasterConfig](#GreenplumMasterConfig3)**<br>User-defined settings for a Greenplum master subcluster. 
default_config | **[GreenplumMasterConfig](#GreenplumMasterConfig3)**<br>Default configuration for a Greenplum master subcluster. 


### GreenplumMasterConfig {#GreenplumMasterConfig3}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the Greenplum master subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. <ul><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
timezone | **google.protobuf.StringValue**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig2}

Field | Description
--- | ---
resources | **[Resources](#Resources7)**<br>Resources allocated to Greenplum segment subcluster hosts. 
config | **[GreenplumSegmentConfigSet](#GreenplumSegmentConfigSet2)**<br>Configuration settings of a Greenplum segment server. 


### Resources {#Resources7}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br><ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### GreenplumSegmentConfigSet {#GreenplumSegmentConfigSet2}

Field | Description
--- | ---
effective_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig3)**<br>Required. Effective settings for a Greenplum segment subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig3)**<br>User-defined settings for a Greenplum segment subcluster. 
default_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig3)**<br>Default configuration for a Greenplum segment subcluster. 


### GreenplumSegmentConfig {#GreenplumSegmentConfig3}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the Greenplum segment subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. <ul><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 


### MaintenanceWindow {#MaintenanceWindow2}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow2)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow2)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow2}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow2}

Field | Description
--- | ---
day | enum **WeekDay**<br> <ul><ul/>
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation2}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Delete {#Delete}

Deletes the specified Greenplum cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum cluster to delete. To get the Greenplum cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation1}

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
cluster_id | **string**<br>ID of the Greenplum cluster that is being deleted. 


## Start {#Start}

Starts the specified Greenplum cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum cluster to start. The maximum string length in characters is 50.


### Operation {#Operation2}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster3)>**<br>if operation finished successfully. 


### StartClusterMetadata {#StartClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Greenplum cluster being started. 


### Cluster {#Cluster3}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Greenplum cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Required. Name of the Greenplum cluster. The name is unique within the folder. 1-63 characters long. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig4)**<br>Green plum cluster config 
description | **string**<br>Description of the Greenplum cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Greenplum cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Description of monitoring systems relevant to the Greenplum cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig3)**<br>Configuration of the Greenplum master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig3)**<br>Configuration of the Greenplum segment subcluster. 
master_host_count | **int64**<br>Number of hosts of the master subcluster 
segment_host_count | **int64**<br>Number of hosts of the segment subcluster 
segment_in_host | **int64**<br>Number of segments in the host 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation3)**<br>Maintenance operation planned at nearest maintenance_window. 
security_group_ids[] | **string**<br>User security groups 
user_name | **string**<br>Owner user name 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### GreenplumConfig {#GreenplumConfig4}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access4)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster4). The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false - don't assign a public IP to the master hosts. </li><li>true - the master hosts should have a public IP address.</li></ul> 


### Access {#Access4}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to Yandex DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the Yandex.Cloud management console. 


### Monitoring {#Monitoring3}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig3}

Field | Description
--- | ---
resources | **[Resources](#Resources8)**<br>Resources allocated to Greenplum master subcluster hosts. 
config | **[GreenplumMasterConfigSet](#GreenplumMasterConfigSet3)**<br>Configuration settings of a Greenplum master server. 


### Resources {#Resources8}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br><ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### GreenplumMasterConfigSet {#GreenplumMasterConfigSet3}

Field | Description
--- | ---
effective_config | **[GreenplumMasterConfig](#GreenplumMasterConfig4)**<br>Required. Effective settings for a Greenplum master subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumMasterConfig](#GreenplumMasterConfig4)**<br>User-defined settings for a Greenplum master subcluster. 
default_config | **[GreenplumMasterConfig](#GreenplumMasterConfig4)**<br>Default configuration for a Greenplum master subcluster. 


### GreenplumMasterConfig {#GreenplumMasterConfig4}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the Greenplum master subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. <ul><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
timezone | **google.protobuf.StringValue**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig3}

Field | Description
--- | ---
resources | **[Resources](#Resources9)**<br>Resources allocated to Greenplum segment subcluster hosts. 
config | **[GreenplumSegmentConfigSet](#GreenplumSegmentConfigSet3)**<br>Configuration settings of a Greenplum segment server. 


### Resources {#Resources9}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br><ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### GreenplumSegmentConfigSet {#GreenplumSegmentConfigSet3}

Field | Description
--- | ---
effective_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig4)**<br>Required. Effective settings for a Greenplum segment subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig4)**<br>User-defined settings for a Greenplum segment subcluster. 
default_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig4)**<br>Default configuration for a Greenplum segment subcluster. 


### GreenplumSegmentConfig {#GreenplumSegmentConfig4}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the Greenplum segment subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. <ul><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 


### MaintenanceWindow {#MaintenanceWindow3}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow3)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow3)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow3}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow3}

Field | Description
--- | ---
day | enum **WeekDay**<br> <ul><ul/>
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation3}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Stop {#Stop}

Stops the specified Greenplum cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum cluster to stop. The maximum string length in characters is 50.


### Operation {#Operation3}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster4)>**<br>if operation finished successfully. 


### StopClusterMetadata {#StopClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Greenplum cluster being stopped. 


### Cluster {#Cluster4}

Field | Description
--- | ---
id | **string**<br>ID of the Greenplum cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the Greenplum cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Required. Name of the Greenplum cluster. The name is unique within the folder. 1-63 characters long. The maximum string length in characters is 63.
config | **[GreenplumConfig](#GreenplumConfig5)**<br>Green plum cluster config 
description | **string**<br>Description of the Greenplum cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Greenplum cluster as `key:value` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the Greenplum cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Description of monitoring systems relevant to the Greenplum cluster. 
master_config | **[MasterSubclusterConfig](#MasterSubclusterConfig4)**<br>Configuration of the Greenplum master subcluster. 
segment_config | **[SegmentSubclusterConfig](#SegmentSubclusterConfig4)**<br>Configuration of the Greenplum segment subcluster. 
master_host_count | **int64**<br>Number of hosts of the master subcluster 
segment_host_count | **int64**<br>Number of hosts of the segment subcluster 
segment_in_host | **int64**<br>Number of segments in the host 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li><ul/>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li><ul/>
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation4)**<br>Maintenance operation planned at nearest maintenance_window. 
security_group_ids[] | **string**<br>User security groups 
user_name | **string**<br>Owner user name 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 


### GreenplumConfig {#GreenplumConfig5}

Field | Description
--- | ---
version | **string**<br>Version of the Greenplum server software. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Time to start the daily backup, in the UTC timezone. 
access | **[Access](#Access5)**<br>Access policy for external services. 
zone_id | **string**<br>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id](#Cluster5). The maximum string length in characters is 50.
assign_public_ip | **bool**<br><ul><li>false - don't assign a public IP to the master hosts. </li><li>true - the master hosts should have a public IP address.</li></ul> 


### Access {#Access5}

Field | Description
--- | ---
data_lens | **bool**<br>Allow to export data from the cluster to Yandex DataLens. 
web_sql | **bool**<br>Allow SQL queries to the cluster databases from the Yandex.Cloud management console. 


### Monitoring {#Monitoring4}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Greenplum cluster. 


### MasterSubclusterConfig {#MasterSubclusterConfig4}

Field | Description
--- | ---
resources | **[Resources](#Resources10)**<br>Resources allocated to Greenplum master subcluster hosts. 
config | **[GreenplumMasterConfigSet](#GreenplumMasterConfigSet4)**<br>Configuration settings of a Greenplum master server. 


### Resources {#Resources10}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br><ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### GreenplumMasterConfigSet {#GreenplumMasterConfigSet4}

Field | Description
--- | ---
effective_config | **[GreenplumMasterConfig](#GreenplumMasterConfig5)**<br>Required. Effective settings for a Greenplum master subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumMasterConfig](#GreenplumMasterConfig5)**<br>User-defined settings for a Greenplum master subcluster. 
default_config | **[GreenplumMasterConfig](#GreenplumMasterConfig5)**<br>Default configuration for a Greenplum master subcluster. 


### GreenplumMasterConfig {#GreenplumMasterConfig5}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the Greenplum master subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. <ul><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 
timezone | **google.protobuf.StringValue**<br>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. 


### SegmentSubclusterConfig {#SegmentSubclusterConfig4}

Field | Description
--- | ---
resources | **[Resources](#Resources11)**<br>Resources allocated to Greenplum segment subcluster hosts. 
config | **[GreenplumSegmentConfigSet](#GreenplumSegmentConfigSet4)**<br>Configuration settings of a Greenplum segment server. 


### Resources {#Resources11}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br><ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


### GreenplumSegmentConfigSet {#GreenplumSegmentConfigSet4}

Field | Description
--- | ---
effective_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig5)**<br>Required. Effective settings for a Greenplum segment subcluster (a combination of settings defined in `user_config` and `default_config`). 
user_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig5)**<br>User-defined settings for a Greenplum segment subcluster. 
default_config | **[GreenplumSegmentConfig](#GreenplumSegmentConfig5)**<br>Default configuration for a Greenplum segment subcluster. 


### GreenplumSegmentConfig {#GreenplumSegmentConfig5}

Field | Description
--- | ---
log_level | enum **LogLevel**<br>Logging level for the Greenplum segment subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR. <ul><ul/>
max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum number of inbound connections. 


### MaintenanceWindow {#MaintenanceWindow4}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow4)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow4)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow4}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow4}

Field | Description
--- | ---
day | enum **WeekDay**<br> <ul><ul/>
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation4}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## ListOperations {#ListOperations}

Retrieves the list of Operation resources for the specified cluster.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum Cluster resource to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation4)**<br>List of Operation resources for the specified Greenplum cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest), use the `next_page_token` as the value for the [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation4}

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
cluster_id | **string**<br>Required. ID of the Greenplum cluster. To get the Greenplum cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](#Host)**<br>Requested list of hosts for the cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
name | **string**<br>Required. Name of the Greenplum host. The host name is assigned by MDB at creation time, and cannot be changed. 1-63 characters long. <br>The name is unique across all existing MDB hosts in Yandex.Cloud, as it defines the FQDN of the host. The maximum string length in characters is 63.
cluster_id | **string**<br>ID of the Greenplum cluster. The ID is assigned by MDB at creation time. 
zone_id | **string**<br>ID of the availability zone where the Greenplum host resides. 
type | enum **Type**<br>Type of the host. <ul><li>`MASTER`: Greenplum master host.</li><li>`REPLICA`: Greenplum master host.</li><li>`SEGMENT`: Greenplum segment host.</li><ul/>
resources | **[Resources](#Resources12)**<br>Resources allocated to the Greenplum host. 
health | enum **Health**<br>Status code of the aggregated health of the host. <ul><li>`UNKNOWN`: Health of the host is unknown.</li><li>`ALIVE`: The host is performing all its functions normally.</li><li>`DEAD`: The host is inoperable, and cannot perform any of its essential functions.</li><li>`DEGRADED`: The host is working below capacity or not fully functional.</li><ul/>
subnet_id | **string**<br>ID of the subnet that the host belongs to. 
assign_public_ip | **bool**<br>Flag showing public IP assignment status to this host. 


### Resources {#Resources12}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br><ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


## ListSegmentHosts {#ListSegmentHosts}

Retrieves a list of segment hosts for the specified cluster.

**rpc ListSegmentHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest1}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum cluster. To get the Greenplum cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse1}

Field | Description
--- | ---
hosts[] | **[Host](#Host1)**<br>Requested list of hosts for the cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Host {#Host1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the Greenplum host. The host name is assigned by MDB at creation time, and cannot be changed. 1-63 characters long. <br>The name is unique across all existing MDB hosts in Yandex.Cloud, as it defines the FQDN of the host. The maximum string length in characters is 63.
cluster_id | **string**<br>ID of the Greenplum cluster. The ID is assigned by MDB at creation time. 
zone_id | **string**<br>ID of the availability zone where the Greenplum host resides. 
type | enum **Type**<br>Type of the host. <ul><li>`MASTER`: Greenplum master host.</li><li>`REPLICA`: Greenplum master host.</li><li>`SEGMENT`: Greenplum segment host.</li><ul/>
resources | **[Resources](#Resources13)**<br>Resources allocated to the Greenplum host. 
health | enum **Health**<br>Status code of the aggregated health of the host. <ul><li>`UNKNOWN`: Health of the host is unknown.</li><li>`ALIVE`: The host is performing all its functions normally.</li><li>`DEAD`: The host is inoperable, and cannot perform any of its essential functions.</li><li>`DEGRADED`: The host is working below capacity or not fully functional.</li><ul/>
subnet_id | **string**<br>ID of the subnet that the host belongs to. 
assign_public_ip | **bool**<br>Flag showing public IP assignment status to this host. 


### Resources {#Resources13}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host. 
disk_type_id | **string**<br><ul><li>network-hdd - network HDD drive, </li><li>network-ssd - network SSD drive, </li><li>local-ssd - local SSD storage.</li></ul> 


