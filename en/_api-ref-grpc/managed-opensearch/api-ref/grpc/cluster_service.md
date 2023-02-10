---
editable: false
---

# Managed Service for OpenSearch API, gRPC: ClusterService

A set of methods for managing OpenSearch clusters.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified OpenSearch cluster. |
| [List](#List) | Retrieves the list of OpenSearch clusters that belong to the specified folder. |
| [Create](#Create) | Creates an OpenSearch cluster in the specified folder. |
| [Update](#Update) | Updates the specified OpenSearch cluster. |
| [Delete](#Delete) | Deletes the specified OpenSearch cluster. |
| [Backup](#Backup) | Creates a backup for the specified OpenSearch cluster. |
| [Restore](#Restore) | Creates a new OpenSearch cluster using the specified backup. |
| [RescheduleMaintenance](#RescheduleMaintenance) | Reschedules a planned maintenance operation. |
| [ListBackups](#ListBackups) | Returns a list of available backups for the specified OpenSearch cluster. |
| [Move](#Move) | Moves the specified OpenSearch cluster to the specified folder. |
| [Start](#Start) | Starts the specified OpenSearch cluster. |
| [Stop](#Stop) | Stops the specified OpenSearch cluster. |
| [ListLogs](#ListLogs) | Retrieves logs for the specified OpenSearch cluster. |
| [StreamLogs](#StreamLogs) | Same as ListLogs but using server-side streaming. |
| [ListOperations](#ListOperations) | Retrieves the list of Operation resources for the specified cluster. |
| [ListHosts](#ListHosts) | Retrieves a list of hosts for the specified cluster. |
| [AddOpenSearchNodeGroup](#AddOpenSearchNodeGroup) | Creates an OpenSearch type host group. |
| [DeleteOpenSearchNodeGroup](#DeleteOpenSearchNodeGroup) | Deletes an OpenSearch type host group. |
| [UpdateOpenSearchNodeGroup](#UpdateOpenSearchNodeGroup) | Updates an OpenSearch type host group. |
| [AddDashboardsNodeGroup](#AddDashboardsNodeGroup) | Creates a Dashboards type host group. |
| [DeleteDashboardsNodeGroup](#DeleteDashboardsNodeGroup) | Deletes a Dashboards type host group. |
| [UpdateDashboardsNodeGroup](#UpdateDashboardsNodeGroup) | Updates a Dashboards type host group. |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified OpenSearch cluster. <br>To get the list of all available OpenSearch clusters, make a [List](#List) request.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster to return. <br>To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
service_account_id | **string**<br>ID of the service account used to access Object Storage. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow)**<br>Cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation)**<br>Maintenance operation planned at nearest `maintenance_window`. 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the OpenSearch cluster. 


### ClusterConfig {#ClusterConfig}

Field | Description
--- | ---
version | **string**<br>Version of the OpenSearch server software. 
opensearch | **[OpenSearch](#OpenSearch)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards)**<br>Dashboards configuration. 
access | **[Access](#Access)**<br>Access policy for external services. 


### OpenSearch {#OpenSearch}

Field | Description
--- | ---
plugins[] | **string**<br>Names of the cluster plugins. 
node_groups[] | **[NodeGroup](#NodeGroup)**<br>Host groups of the OpenSearch type. 


### NodeGroup {#NodeGroup}

Field | Description
--- | ---
name | **string**<br>Name of the group. Must be 1-63 characters long. 
resources | **[Resources](#Resources)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 
roles[] | enum **GroupRole**<br>Roles of the host group. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### Dashboards {#Dashboards}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup1)**<br>Host groups of the Dashboards type. 


### NodeGroup {#NodeGroup1}

Field | Description
--- | ---
name | **string**<br>Name of the group. 1-63 characters long. 
resources | **[Resources](#Resources1)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 


### Access {#Access}

Field | Description
--- | ---
data_transfer | **bool**<br>Determines whether the access to Data Transfer is allowed. 
serverless | **bool**<br>Determines whether the access to Serverless is allowed. 


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
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last maintenance window. 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the next maintenance window. 


## List {#List}

Retrieves the list of OpenSearch clusters that belong to the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list OpenSearch clusters in. <br>To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by the previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <br><ol><li>The field name. Currently you can only use filtering with the [Cluster.name](#Cluster1) field. </li></ol><br><ol><li>An `=` operator. </li></ol><br><ol><li>The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`.</li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of OpenSearch clusters. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest) parameter in the next list request. <br>Each subsequent list request has its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster1}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
service_account_id | **string**<br>ID of the service account used to access Object Storage. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow1)**<br>Cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation1)**<br>Maintenance operation planned at nearest `maintenance_window`. 


### Monitoring {#Monitoring1}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the OpenSearch cluster. 


### ClusterConfig {#ClusterConfig1}

Field | Description
--- | ---
version | **string**<br>Version of the OpenSearch server software. 
opensearch | **[OpenSearch](#OpenSearch1)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards1)**<br>Dashboards configuration. 
access | **[Access](#Access1)**<br>Access policy for external services. 


### OpenSearch {#OpenSearch1}

Field | Description
--- | ---
plugins[] | **string**<br>Names of the cluster plugins. 
node_groups[] | **[NodeGroup](#NodeGroup2)**<br>Host groups of the OpenSearch type. 


### NodeGroup {#NodeGroup2}

Field | Description
--- | ---
name | **string**<br>Name of the group. Must be 1-63 characters long. 
resources | **[Resources](#Resources1)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 
roles[] | enum **GroupRole**<br>Roles of the host group. 


### Resources {#Resources1}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### Dashboards {#Dashboards1}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup3)**<br>Host groups of the Dashboards type. 


### NodeGroup {#NodeGroup3}

Field | Description
--- | ---
name | **string**<br>Name of the group. 1-63 characters long. 
resources | **[Resources](#Resources2)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 


### Access {#Access1}

Field | Description
--- | ---
data_transfer | **bool**<br>Determines whether the access to Data Transfer is allowed. 
serverless | **bool**<br>Determines whether the access to Serverless is allowed. 


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
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last maintenance window. 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the next maintenance window. 


## Create {#Create}

Creates an OpenSearch cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create the OpenSearch cluster in. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the OpenSearch cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the OpenSearch cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `key:value` pairs. For example, `"project": "mvp"` or `"source": "dictionary"`. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Deployment environment of the OpenSearch cluster. 
config_spec | **[ConfigCreateSpec](#ConfigCreateSpec)**<br>Required. OpenSearch cluster configuration. 
network_id | **string**<br>Required. ID of the network to create the cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>User security groups. 
service_account_id | **string**<br>ID of the service account used to access Object Storage. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow2)**<br>Cluster maintenance window. Should be defined by either one of the two options. 


### ConfigCreateSpec {#ConfigCreateSpec}

Field | Description
--- | ---
version | **string**<br>OpenSearch version. 
admin_password | **string**<br>Required. OpenSearch admin password. 
opensearch_spec | **[OpenSearchCreateSpec](#OpenSearchCreateSpec)**<br>OpenSearch configuration. 
dashboards_spec | **[DashboardsCreateSpec](#DashboardsCreateSpec)**<br>Dashboards configuration. 
access | **[Access](#Access2)**<br>Access policy for external services. 


### OpenSearchCreateSpec {#OpenSearchCreateSpec}

Field | Description
--- | ---
plugins[] | **string**<br>Names of the cluster plugins. 
node_groups[] | **[NodeGroup](#NodeGroup4)**<br>OpenSearch type host groups of the cluster. 


### NodeGroup {#NodeGroup4}

Field | Description
--- | ---
name | **string**<br>Required. Name of the group. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
resources | **[Resources](#Resources2)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. The minimum value is 1.
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. The maximum number of elements is 10. The maximum string length in characters for each value is 50.
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. The maximum number of elements is 10. The maximum string length in characters for each value is 50.
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 
roles[] | **[OpenSearch.GroupRole](#OpenSearch2)**<br>Roles of the hosts in the group. 


### Resources {#Resources2}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### DashboardsCreateSpec {#DashboardsCreateSpec}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup5)**<br>Dashboards type host groups of the cluster. 


### NodeGroup {#NodeGroup5}

Field | Description
--- | ---
name | **string**<br>Required. Name of the group. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
resources | **[Resources](#Resources3)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. The minimum value is 1.
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. The maximum number of elements is 10. The maximum string length in characters for each value is 50.
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 


### Access {#Access2}

Field | Description
--- | ---
data_transfer | **bool**<br>Determines whether the access to Data Transfer is allowed. 
serverless | **bool**<br>Determines whether the access to Serverless is allowed. 


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
cluster_id | **string**<br>ID of the OpenSearch cluster that is being created. 


### Cluster {#Cluster2}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
service_account_id | **string**<br>ID of the service account used to access Object Storage. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>Cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation2)**<br>Maintenance operation planned at nearest `maintenance_window`. 


### Monitoring {#Monitoring2}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the OpenSearch cluster. 


### ClusterConfig {#ClusterConfig2}

Field | Description
--- | ---
version | **string**<br>Version of the OpenSearch server software. 
opensearch | **[OpenSearch](#OpenSearch2)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards2)**<br>Dashboards configuration. 
access | **[Access](#Access3)**<br>Access policy for external services. 


### OpenSearch {#OpenSearch2}

Field | Description
--- | ---
plugins[] | **string**<br>Names of the cluster plugins. 
node_groups[] | **[NodeGroup](#NodeGroup6)**<br>Host groups of the OpenSearch type. 


### NodeGroup {#NodeGroup6}

Field | Description
--- | ---
name | **string**<br>Name of the group. Must be 1-63 characters long. 
resources | **[Resources](#Resources3)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 
roles[] | enum **GroupRole**<br>Roles of the host group. 


### Dashboards {#Dashboards2}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup7)**<br>Host groups of the Dashboards type. 


### NodeGroup {#NodeGroup7}

Field | Description
--- | ---
name | **string**<br>Name of the group. 1-63 characters long. 
resources | **[Resources](#Resources3)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 


### MaintenanceOperation {#MaintenanceOperation2}

Field | Description
--- | ---
info | **string**<br>The description of the operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last maintenance window. 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the next maintenance window. 


## Update {#Update}

Updates the specified OpenSearch cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster resource to update. To get the OpenSearch cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the OpenSearch cluster resource should be updated. 
description | **string**<br>New description of the OpenSearch cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `key:value` pairs. For example, `"project": "mvp"` or `"source": "dictionary"`. <br>The new set of labels completely replaces the old one. To add a label, request the current set with the [ClusterService.Get](#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigUpdateSpec](#ConfigUpdateSpec)**<br>New cluster configuration 
name | **string**<br>New name for the cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used to access Object Storage. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>Cluster maintenance window. Should be defined by either one of the two options. 


### ConfigUpdateSpec {#ConfigUpdateSpec}

Field | Description
--- | ---
version | **string**<br>OpenSearch version. 
admin_password | **string**<br>Required. OpenSearch admin password. 
opensearch_spec | **[OpenSearchClusterUpdateSpec](#OpenSearchClusterUpdateSpec)**<br>OpenSearch configuration. 
dashboards_spec | **[DashboardsClusterUpdateSpec](#DashboardsClusterUpdateSpec)**<br>Dashboards configuration. 
access | **[Access](#Access3)**<br>Access policy for external services. 


### OpenSearchClusterUpdateSpec {#OpenSearchClusterUpdateSpec}

Field | Description
--- | ---
plugins[] | **string**<br>Names of the cluster plugins. 


### DashboardsClusterUpdateSpec {#DashboardsClusterUpdateSpec}



### Access {#Access3}

Field | Description
--- | ---
data_transfer | **bool**<br>Determines whether the access to Data Transfer is allowed. 
serverless | **bool**<br>Determines whether the access to Serverless is allowed. 


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
cluster_id | **string**<br>ID of the OpenSearch cluster resource that is being updated. 


### Cluster {#Cluster3}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig3)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
service_account_id | **string**<br>ID of the service account used to access Object Storage. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation3)**<br>Maintenance operation planned at nearest `maintenance_window`. 


### Monitoring {#Monitoring3}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the OpenSearch cluster. 


### ClusterConfig {#ClusterConfig3}

Field | Description
--- | ---
version | **string**<br>Version of the OpenSearch server software. 
opensearch | **[OpenSearch](#OpenSearch3)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards3)**<br>Dashboards configuration. 
access | **[Access](#Access4)**<br>Access policy for external services. 


### OpenSearch {#OpenSearch3}

Field | Description
--- | ---
plugins[] | **string**<br>Names of the cluster plugins. 
node_groups[] | **[NodeGroup](#NodeGroup8)**<br>Host groups of the OpenSearch type. 


### NodeGroup {#NodeGroup8}

Field | Description
--- | ---
name | **string**<br>Name of the group. Must be 1-63 characters long. 
resources | **[Resources](#Resources3)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 
roles[] | enum **GroupRole**<br>Roles of the host group. 


### Resources {#Resources3}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### Dashboards {#Dashboards3}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup9)**<br>Host groups of the Dashboards type. 


### NodeGroup {#NodeGroup9}

Field | Description
--- | ---
name | **string**<br>Name of the group. 1-63 characters long. 
resources | **[Resources](#Resources4)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 


### MaintenanceOperation {#MaintenanceOperation3}

Field | Description
--- | ---
info | **string**<br>The description of the operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last maintenance window. 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the next maintenance window. 


## Delete {#Delete}

Deletes the specified OpenSearch cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster to delete. To get the OpenSearch cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the OpenSearch cluster that is being deleted. 


## Backup {#Backup}

Creates a backup for the specified OpenSearch cluster.

**rpc Backup ([BackupClusterRequest](#BackupClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupClusterMetadata](#BackupClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### BackupClusterRequest {#BackupClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster to back up. <br>To get the ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation3}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster4)>**<br>if operation finished successfully. 


### BackupClusterMetadata {#BackupClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the OpenSearch cluster being backed up. 


### Cluster {#Cluster4}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig4)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
service_account_id | **string**<br>ID of the service account used to access Object Storage. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation4)**<br>Maintenance operation planned at nearest `maintenance_window`. 


### Monitoring {#Monitoring4}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the OpenSearch cluster. 


### ClusterConfig {#ClusterConfig4}

Field | Description
--- | ---
version | **string**<br>Version of the OpenSearch server software. 
opensearch | **[OpenSearch](#OpenSearch4)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards4)**<br>Dashboards configuration. 
access | **[Access](#Access4)**<br>Access policy for external services. 


### OpenSearch {#OpenSearch4}

Field | Description
--- | ---
plugins[] | **string**<br>Names of the cluster plugins. 
node_groups[] | **[NodeGroup](#NodeGroup10)**<br>Host groups of the OpenSearch type. 


### NodeGroup {#NodeGroup10}

Field | Description
--- | ---
name | **string**<br>Name of the group. Must be 1-63 characters long. 
resources | **[Resources](#Resources4)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 
roles[] | enum **GroupRole**<br>Roles of the host group. 


### Resources {#Resources4}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### Dashboards {#Dashboards4}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup11)**<br>Host groups of the Dashboards type. 


### NodeGroup {#NodeGroup11}

Field | Description
--- | ---
name | **string**<br>Name of the group. 1-63 characters long. 
resources | **[Resources](#Resources5)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 


### Access {#Access4}

Field | Description
--- | ---
data_transfer | **bool**<br>Determines whether the access to Data Transfer is allowed. 
serverless | **bool**<br>Determines whether the access to Serverless is allowed. 


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
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last maintenance window. 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the next maintenance window. 


## Restore {#Restore}

Creates a new OpenSearch cluster using the specified backup.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. ID of the backup to create a new cluster from. <br>To get the backup ID, use a [ClusterService.ListBackups](#ListBackups) request. 
name | **string**<br>Required. Name of the new OpenSearch cluster to be created from the backup. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the new OpenSearch cluster to be created from the backup. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the new OpenSearch cluster to be created from the backup as `key:value` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster5)**<br>Deployment environment of the new OpenSearch cluster to be created from the backup. 
config_spec | **[ConfigCreateSpec](#ConfigCreateSpec)**<br>Required. Configuration for the new OpenSearch cluster to be created from the backup. 
network_id | **string**<br>Required. ID of the network to create the cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>User security groups. 
service_account_id | **string**<br>ID of the service account used to access Object Storage. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
folder_id | **string**<br>Required. ID of the folder to create the OpenSearch cluster in. <br>To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow5)**<br>Cluster maintenance window. Should be defined by either one of the two options. 


### ConfigCreateSpec {#ConfigCreateSpec1}

Field | Description
--- | ---
version | **string**<br>OpenSearch version. 
admin_password | **string**<br>Required. OpenSearch admin password. 
opensearch_spec | **[OpenSearchCreateSpec](#OpenSearchCreateSpec)**<br>OpenSearch configuration. 
dashboards_spec | **[DashboardsCreateSpec](#DashboardsCreateSpec)**<br>Dashboards configuration. 
access | **[Access](#Access5)**<br>Access policy for external services. 


### OpenSearchCreateSpec {#OpenSearchCreateSpec1}

Field | Description
--- | ---
plugins[] | **string**<br>Names of the cluster plugins. 
node_groups[] | **[NodeGroup](#NodeGroup12)**<br>OpenSearch type host groups of the cluster. 


### NodeGroup {#NodeGroup12}

Field | Description
--- | ---
name | **string**<br>Required. Name of the group. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
resources | **[Resources](#Resources5)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. The minimum value is 1.
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. The maximum number of elements is 10. The maximum string length in characters for each value is 50.
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. The maximum number of elements is 10. The maximum string length in characters for each value is 50.
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 
roles[] | **[OpenSearch.GroupRole](#OpenSearch5)**<br>Roles of the hosts in the group. 


### Resources {#Resources5}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### DashboardsCreateSpec {#DashboardsCreateSpec1}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup13)**<br>Dashboards type host groups of the cluster. 


### NodeGroup {#NodeGroup13}

Field | Description
--- | ---
name | **string**<br>Required. Name of the group. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
resources | **[Resources](#Resources6)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. The minimum value is 1.
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. The maximum number of elements is 10. The maximum string length in characters for each value is 50.
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 


### Access {#Access5}

Field | Description
--- | ---
data_transfer | **bool**<br>Determines whether the access to Data Transfer is allowed. 
serverless | **bool**<br>Determines whether the access to Serverless is allowed. 


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


### Operation {#Operation4}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster5)>**<br>if operation finished successfully. 


### RestoreClusterMetadata {#RestoreClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the new OpenSearch cluster being created from a backup. 
backup_id | **string**<br>ID of the backup being used for creating a cluster. 


### Cluster {#Cluster5}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig5)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
service_account_id | **string**<br>ID of the service account used to access Object Storage. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow6)**<br>Cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation5)**<br>Maintenance operation planned at nearest `maintenance_window`. 


### Monitoring {#Monitoring5}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the OpenSearch cluster. 


### ClusterConfig {#ClusterConfig5}

Field | Description
--- | ---
version | **string**<br>Version of the OpenSearch server software. 
opensearch | **[OpenSearch](#OpenSearch5)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards5)**<br>Dashboards configuration. 
access | **[Access](#Access6)**<br>Access policy for external services. 


### OpenSearch {#OpenSearch5}

Field | Description
--- | ---
plugins[] | **string**<br>Names of the cluster plugins. 
node_groups[] | **[NodeGroup](#NodeGroup14)**<br>Host groups of the OpenSearch type. 


### NodeGroup {#NodeGroup14}

Field | Description
--- | ---
name | **string**<br>Name of the group. Must be 1-63 characters long. 
resources | **[Resources](#Resources6)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 
roles[] | enum **GroupRole**<br>Roles of the host group. 


### Dashboards {#Dashboards5}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup15)**<br>Host groups of the Dashboards type. 


### NodeGroup {#NodeGroup15}

Field | Description
--- | ---
name | **string**<br>Name of the group. 1-63 characters long. 
resources | **[Resources](#Resources6)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 


### MaintenanceOperation {#MaintenanceOperation5}

Field | Description
--- | ---
info | **string**<br>The description of the operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last maintenance window. 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the next maintenance window. 


## RescheduleMaintenance {#RescheduleMaintenance}

Reschedules a planned maintenance operation.

**rpc RescheduleMaintenance ([RescheduleMaintenanceRequest](#RescheduleMaintenanceRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RescheduleMaintenanceMetadata](#RescheduleMaintenanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### RescheduleMaintenanceRequest {#RescheduleMaintenanceRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster to reschedule the maintenance operation for. <br>To get the ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
reschedule_type | enum **RescheduleType**<br>Required. The type of the reschedule request. <ul><li>`RESCHEDULE_TYPE_UNSPECIFIED`: Time of the maintenance is not specified..</li><li>`IMMEDIATE`: Start the maintenance operation immediately.</li><li>`NEXT_AVAILABLE_WINDOW`: Start the maintenance operation within the next available maintenance window.</li><li>`SPECIFIC_TIME`: Start the maintenance operation at the specific time.</li></ul>
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time until which this maintenance operation should be delayed. The value should be ahead of the first time when the maintenance operation has been scheduled for no more than two weeks. The value can also point to a moment in the past if `reschedule_type.IMMEDIATE` reschedule type is selected. 


### Operation {#Operation5}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster6)>**<br>if operation finished successfully. 


### RescheduleMaintenanceMetadata {#RescheduleMaintenanceMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the OpenSearch cluster where the reschedule is applied. 
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time until which this maintenance operation is to be delayed. 


### Cluster {#Cluster6}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring6)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig6)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
service_account_id | **string**<br>ID of the service account used to access Object Storage. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow6)**<br>Cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation6)**<br>Maintenance operation planned at nearest `maintenance_window`. 


### Monitoring {#Monitoring6}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the OpenSearch cluster. 


### ClusterConfig {#ClusterConfig6}

Field | Description
--- | ---
version | **string**<br>Version of the OpenSearch server software. 
opensearch | **[OpenSearch](#OpenSearch6)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards6)**<br>Dashboards configuration. 
access | **[Access](#Access6)**<br>Access policy for external services. 


### OpenSearch {#OpenSearch6}

Field | Description
--- | ---
plugins[] | **string**<br>Names of the cluster plugins. 
node_groups[] | **[NodeGroup](#NodeGroup16)**<br>Host groups of the OpenSearch type. 


### NodeGroup {#NodeGroup16}

Field | Description
--- | ---
name | **string**<br>Name of the group. Must be 1-63 characters long. 
resources | **[Resources](#Resources6)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 
roles[] | enum **GroupRole**<br>Roles of the host group. 


### Resources {#Resources6}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### Dashboards {#Dashboards6}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup17)**<br>Host groups of the Dashboards type. 


### NodeGroup {#NodeGroup17}

Field | Description
--- | ---
name | **string**<br>Name of the group. 1-63 characters long. 
resources | **[Resources](#Resources7)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 


### Access {#Access6}

Field | Description
--- | ---
data_transfer | **bool**<br>Determines whether the access to Data Transfer is allowed. 
serverless | **bool**<br>Determines whether the access to Serverless is allowed. 


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
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last maintenance window. 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the next maintenance window. 


## ListBackups {#ListBackups}

Returns a list of available backups for the specified OpenSearch cluster.

**rpc ListBackups ([ListClusterBackupsRequest](#ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#ListClusterBackupsResponse))**

### ListClusterBackupsRequest {#ListClusterBackupsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster. <br>To get the ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterBackupsResponse {#ListClusterBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup)**<br>List of the OpenSearch cluster backups. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest) parameter in the next list request. <br>Each subsequent list request has its own `next_page_token` to continue paging through the results. 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>Required. ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
source_cluster_id | **string**<br>ID of the OpenSearch cluster that the backup was created for. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was started. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the backup operation was completed. 
indices[] | **string**<br>Names of indices in the backup. The maximum number of elements is 100.
opensearch_version | **string**<br>OpenSearch version used to create the backup. 
size_bytes | **int64**<br>Size of the backup in bytes. 
indices_total | **int64**<br>The number of indices in the backup. 


## Move {#Move}

Moves the specified OpenSearch cluster to the specified folder.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster7)<br>

### MoveClusterRequest {#MoveClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster to move. The maximum string length in characters is 50.
destination_folder_id | **string**<br>Required. ID of the destination folder. The maximum string length in characters is 50.


### Operation {#Operation6}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster7)>**<br>if operation finished successfully. 


### MoveClusterMetadata {#MoveClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the OpenSearch cluster being moved. 
source_folder_id | **string**<br>ID of the source folder. 
destination_folder_id | **string**<br>ID of the destnation folder. 


### Cluster {#Cluster7}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring7)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig7)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
service_account_id | **string**<br>ID of the service account used to access Object Storage. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow7)**<br>Cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation7)**<br>Maintenance operation planned at nearest `maintenance_window`. 


### Monitoring {#Monitoring7}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the OpenSearch cluster. 


### ClusterConfig {#ClusterConfig7}

Field | Description
--- | ---
version | **string**<br>Version of the OpenSearch server software. 
opensearch | **[OpenSearch](#OpenSearch7)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards7)**<br>Dashboards configuration. 
access | **[Access](#Access7)**<br>Access policy for external services. 


### OpenSearch {#OpenSearch7}

Field | Description
--- | ---
plugins[] | **string**<br>Names of the cluster plugins. 
node_groups[] | **[NodeGroup](#NodeGroup18)**<br>Host groups of the OpenSearch type. 


### NodeGroup {#NodeGroup18}

Field | Description
--- | ---
name | **string**<br>Name of the group. Must be 1-63 characters long. 
resources | **[Resources](#Resources7)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 
roles[] | enum **GroupRole**<br>Roles of the host group. 


### Resources {#Resources7}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### Dashboards {#Dashboards7}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup19)**<br>Host groups of the Dashboards type. 


### NodeGroup {#NodeGroup19}

Field | Description
--- | ---
name | **string**<br>Name of the group. 1-63 characters long. 
resources | **[Resources](#Resources8)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 


### Access {#Access7}

Field | Description
--- | ---
data_transfer | **bool**<br>Determines whether the access to Data Transfer is allowed. 
serverless | **bool**<br>Determines whether the access to Serverless is allowed. 


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


### MaintenanceOperation {#MaintenanceOperation7}

Field | Description
--- | ---
info | **string**<br>The description of the operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last maintenance window. 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the next maintenance window. 


## Start {#Start}

Starts the specified OpenSearch cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster8)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster to start. To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation7}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster8)>**<br>if operation finished successfully. 


### StartClusterMetadata {#StartClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the OpenSearch cluster being started. 


### Cluster {#Cluster8}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring8)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig8)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
service_account_id | **string**<br>ID of the service account used to access Object Storage. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow8)**<br>Cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation8)**<br>Maintenance operation planned at nearest `maintenance_window`. 


### Monitoring {#Monitoring8}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the OpenSearch cluster. 


### ClusterConfig {#ClusterConfig8}

Field | Description
--- | ---
version | **string**<br>Version of the OpenSearch server software. 
opensearch | **[OpenSearch](#OpenSearch8)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards8)**<br>Dashboards configuration. 
access | **[Access](#Access8)**<br>Access policy for external services. 


### OpenSearch {#OpenSearch8}

Field | Description
--- | ---
plugins[] | **string**<br>Names of the cluster plugins. 
node_groups[] | **[NodeGroup](#NodeGroup20)**<br>Host groups of the OpenSearch type. 


### NodeGroup {#NodeGroup20}

Field | Description
--- | ---
name | **string**<br>Name of the group. Must be 1-63 characters long. 
resources | **[Resources](#Resources8)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 
roles[] | enum **GroupRole**<br>Roles of the host group. 


### Resources {#Resources8}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### Dashboards {#Dashboards8}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup21)**<br>Host groups of the Dashboards type. 


### NodeGroup {#NodeGroup21}

Field | Description
--- | ---
name | **string**<br>Name of the group. 1-63 characters long. 
resources | **[Resources](#Resources9)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 


### Access {#Access8}

Field | Description
--- | ---
data_transfer | **bool**<br>Determines whether the access to Data Transfer is allowed. 
serverless | **bool**<br>Determines whether the access to Serverless is allowed. 


### MaintenanceWindow {#MaintenanceWindow8}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow8)**<br>An any-time maintenance window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow8)**<br>A weekly maintenance window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow8}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow8}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week. <ul><li>`MON`: Monday</li><li>`TUE`: Tuesday</li><li>`WED`: Wednesday</li><li>`THU`: Thursday</li><li>`FRI`: Friday</li><li>`SAT`: Saturday</li><li>`SUN`: Sunday</li></ul>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation8}

Field | Description
--- | ---
info | **string**<br>The description of the operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last maintenance window. 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the next maintenance window. 


## Stop {#Stop}

Stops the specified OpenSearch cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation8))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster9)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster to stop. To get the cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation8}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster9)>**<br>if operation finished successfully. 


### StopClusterMetadata {#StopClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the OpenSearch cluster being stopped. 


### Cluster {#Cluster9}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by the platform at the moment of cluster creation. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the cluster was created. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `key:value` pairs. Maximum 64 labels per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring9)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig9)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the cloud network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is working normally ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster has encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster has stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups. 
service_account_id | **string**<br>ID of the service account used to access Object Storage. 
deletion_protection | **bool**<br>Determines whether the cluster is protected from being deleted. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow9)**<br>Cluster maintenance window. Should be defined by either one of the two options. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation9)**<br>Maintenance operation planned at nearest `maintenance_window`. 


### Monitoring {#Monitoring9}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the OpenSearch cluster. 


### ClusterConfig {#ClusterConfig9}

Field | Description
--- | ---
version | **string**<br>Version of the OpenSearch server software. 
opensearch | **[OpenSearch](#OpenSearch9)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards9)**<br>Dashboards configuration. 
access | **[Access](#Access9)**<br>Access policy for external services. 


### OpenSearch {#OpenSearch9}

Field | Description
--- | ---
plugins[] | **string**<br>Names of the cluster plugins. 
node_groups[] | **[NodeGroup](#NodeGroup22)**<br>Host groups of the OpenSearch type. 


### NodeGroup {#NodeGroup22}

Field | Description
--- | ---
name | **string**<br>Name of the group. Must be 1-63 characters long. 
resources | **[Resources](#Resources9)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 
roles[] | enum **GroupRole**<br>Roles of the host group. 


### Resources {#Resources9}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### Dashboards {#Dashboards9}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup23)**<br>Host groups of the Dashboards type. 


### NodeGroup {#NodeGroup23}

Field | Description
--- | ---
name | **string**<br>Name of the group. 1-63 characters long. 
resources | **[Resources](#Resources10)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
zone_ids[] | **string**<br>IDs of the availability zones the hosts belong to. 
subnet_ids[] | **string**<br>IDs of the subnets that the hosts belong to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the hosts in the group. 


### Access {#Access9}

Field | Description
--- | ---
data_transfer | **bool**<br>Determines whether the access to Data Transfer is allowed. 
serverless | **bool**<br>Determines whether the access to Serverless is allowed. 


### MaintenanceWindow {#MaintenanceWindow9}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow9)**<br>An any-time maintenance window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow9)**<br>A weekly maintenance window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow9}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow9}

Field | Description
--- | ---
day | enum **WeekDay**<br>Day of the week. <ul><li>`MON`: Monday</li><li>`TUE`: Tuesday</li><li>`WED`: Wednesday</li><li>`THU`: Thursday</li><li>`FRI`: Friday</li><li>`SAT`: Saturday</li><li>`SUN`: Sunday</li></ul>
hour | **int64**<br>Hour of the day in the UTC timezone. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation9}

Field | Description
--- | ---
info | **string**<br>The description of the operation. The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Delay time for the maintenance operation. 
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last maintenance window. 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the next maintenance window. 


## ListLogs {#ListLogs}

Retrieves logs for the specified OpenSearch cluster. For detailed description, see the [Logs](/yandex-mdb-guide/concepts/logs.html) section in the developer's guide.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster to request logs for. <br>To get the OpenSearch cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from log table to request. If no columns are specified, entire log records are returned. 
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request. 
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) returned by the previous list request. The maximum string length in characters is 100.
always_next_page_token | **bool**<br>The service always returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse), even if the current page is empty. 
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <br><ol><li>A field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname](#LogRecord) field. </li></ol><br><ol><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li></ol><br><ol><li>A value. Must be 1-63 characters long and match the regular expression `^[a-z0-9.-]{1,61}$`. </li></ol><br>Examples of a filter: <ul><li>`message.hostname='node1.db.cloud.yandex.net'`; </li><li>`message.error_severity IN ("ERROR", "FATAL", "PANIC") AND message.hostname = "node1.db.cloud.yandex.net"`.</li></ul> The maximum string length in characters is 1000.
service_type | enum **ServiceType**<br>Type of the service to request logs about. <ul><li>`SERVICE_TYPE_UNSPECIFIED`: Type is not specified.</li><li>`OPENSEARCH`: OpenSearch logs.</li><li>`DASHBOARDS`: Dashboards logs.</li></ul>


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

Same as ListLogs but using server-side streaming. Also allows for 'tail -f' semantics.

**rpc StreamLogs ([StreamClusterLogsRequest](#StreamClusterLogsRequest)) returns (stream [StreamLogRecord](#StreamLogRecord))**

### StreamClusterLogsRequest {#StreamClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from log table to get in the response. If no columns are specified, entire log records are returned. 
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request. <br>If this field is not set, all existing logs are sent as well as the new ones as they appear. <br>In essence it has `tail -f` semantics. 
record_token | **string**<br>Record token. Set `record_token` to the `next_record_token` returned by the previous [StreamLogs](#StreamLogs) request to start streaming from the next log record. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <br><ol><li>A field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname](#LogRecord) field. </li></ol><br><ol><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li></ol><br><ol><li>A value. Must be 1-63 characters long and match the regular expression `^[a-z0-9.-]{1,61}$`. </li></ol><br>Examples of a filter: <ul><li>`message.hostname='node1.db.cloud.yandex.net'`; </li><li>`message.error_severity IN ("ERROR", "FATAL", "PANIC") AND message.hostname = "node1.db.cloud.yandex.net"`.</li></ul> The maximum string length in characters is 1000.
service_type | enum **ServiceType**<br>Type of the service to request logs about. <ul><li>`SERVICE_TYPE_UNSPECIFIED`: Type is not specified.</li><li>`OPENSEARCH`: OpenSearch logs.</li><li>`DASHBOARDS`: Dashboards logs.</li></ul>


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


## ListOperations {#ListOperations}

Retrieves the list of Operation resources for the specified cluster.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster resource to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation9)**<br>List of Operation resources for the specified OpenSearch cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest), use the `next_page_token` as the value for the [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest) query parameter in the next list request. <br>Each subsequent list request has its own `next_page_token` to continue paging through the results. 


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


## ListHosts {#ListHosts}

Retrieves a list of hosts for the specified cluster.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster. To get the OpenSearch cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
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
name | **string**<br>Required. Name of the OpenSearch host. <br>The host name is assigned by the platform at creation time and cannot be changed. <br>The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. 
cluster_id | **string**<br>Required. ID of the OpenSearch cluster. The ID is assigned by the platform at creation time. 
zone_id | **string**<br>ID of the availability zone the OpenSearch host belongs to. 
resources | **[Resources](#Resources10)**<br>Resources allocated to the OpenSearch host. 
type | enum **Type**<br>Type of the host. <ul><li>`TYPE_UNSPECIFIED`: The type is not specified.</li><li>`OPENSEARCH`: An OpenSearch type host.</li><li>`DASHBOARDS`: A Dashboards type host.</li></ul>
health | enum **Health**<br>Status code of the aggregated health of the host. <ul><li>`UNKNOWN`: Health of the host is unknown.</li><li>`ALIVE`: The host is performing all its functions normally.</li><li>`DEAD`: The host is inoperable and cannot perform any of its essential functions.</li><li>`DEGRADED`: The host is working below capacity or not fully functional.</li></ul>
subnet_id | **string**<br>ID of the subnet that the host belongs to. 
assign_public_ip | **bool**<br>Determines whether a public IP is assigned to the host. 
system | **[SystemMetrics](#SystemMetrics)**<br>Resources used by the host. 
node_group | **string**<br>Name of the host group that the host belongs to. 
roles[] | **[OpenSearch.GroupRole](#OpenSearch10)**<br>Roles of the host. 


### CPUMetric {#CPUMetric}

Field | Description
--- | ---
timestamp | **int64**<br>Time of the record. 
used | **double**<br>Percentage of the CPU used. 


### MemoryMetric {#MemoryMetric}

Field | Description
--- | ---
timestamp | **int64**<br>Time of the record. 
used | **int64**<br>The amount of RAM used, in bytes. 
total | **int64**<br>Total amount of RAM allocated to the host. 


### DiskMetric {#DiskMetric}

Field | Description
--- | ---
timestamp | **int64**<br>Time of the record. 
used | **int64**<br>The amount of disk space used, in bytes. 
total | **int64**<br>Total amount of disk space allocated to the host. 


### SystemMetrics {#SystemMetrics}

Field | Description
--- | ---
cpu | **[CPUMetric](#CPUMetric)**<br>CPU usage of the host. 
memory | **[MemoryMetric](#MemoryMetric)**<br>RAM usage of the host. 
disk | **[DiskMetric](#DiskMetric)**<br>Disk usage of the host. 


### Resources {#Resources10}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


## AddOpenSearchNodeGroup {#AddOpenSearchNodeGroup}

Creates an OpenSearch type host group.

**rpc AddOpenSearchNodeGroup ([AddOpenSearchNodeGroupRequest](#AddOpenSearchNodeGroupRequest)) returns ([operation.Operation](#Operation10))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddNodeGroupMetadata](#AddNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddOpenSearchNodeGroupRequest {#AddOpenSearchNodeGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster to create the OpenSearch type host group in. <br>To get the ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
node_group_spec | **[OpenSearchCreateSpec.NodeGroup](#OpenSearchCreateSpec)**<br>Configuration of the new host group. 


### Operation {#Operation10}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddNodeGroupMetadata](#AddNodeGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### AddNodeGroupMetadata {#AddNodeGroupMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the OpenSearch cluster where the host group is being created. 
name | **string**<br>Name of the host group being created. 


## DeleteOpenSearchNodeGroup {#DeleteOpenSearchNodeGroup}

Deletes an OpenSearch type host group.

**rpc DeleteOpenSearchNodeGroup ([DeleteOpenSearchNodeGroupRequest](#DeleteOpenSearchNodeGroupRequest)) returns ([operation.Operation](#Operation11))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteNodeGroupMetadata](#DeleteNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteOpenSearchNodeGroupRequest {#DeleteOpenSearchNodeGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster to delete the OpenSearch type host group in. <br>To get the ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the OpenSearch type host group to delete. 


### Operation {#Operation11}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteNodeGroupMetadata](#DeleteNodeGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteNodeGroupMetadata {#DeleteNodeGroupMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the OpenSearch cluster where the host group is being deleted. 
name | **string**<br>Name of the host group being deleted. 


## UpdateOpenSearchNodeGroup {#UpdateOpenSearchNodeGroup}

Updates an OpenSearch type host group.

**rpc UpdateOpenSearchNodeGroup ([UpdateOpenSearchNodeGroupRequest](#UpdateOpenSearchNodeGroupRequest)) returns ([operation.Operation](#Operation12))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateNodeGroupMetadata](#UpdateNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateOpenSearchNodeGroupRequest {#UpdateOpenSearchNodeGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster to update the OpenSearch type host group in. <br>To get the ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the OpenSearch type host group to be updated. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the host group configuration should be updated. 
node_group_spec | **[OpenSearchNodeGroupUpdateSpec](#OpenSearchNodeGroupUpdateSpec)**<br>New configuration for the host group. 


### OpenSearchNodeGroupUpdateSpec {#OpenSearchNodeGroupUpdateSpec}

Field | Description
--- | ---
resources | **[Resources](#Resources11)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 
roles[] | **[OpenSearch.GroupRole](#OpenSearch10)**<br>Roles of the host group. 


### Resources {#Resources11}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### Operation {#Operation12}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateNodeGroupMetadata](#UpdateNodeGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### UpdateNodeGroupMetadata {#UpdateNodeGroupMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the OpenSearch cluster where the host group is being updated. 
name | **string**<br>Name of the host group being updated. 


## AddDashboardsNodeGroup {#AddDashboardsNodeGroup}

Creates a Dashboards type host group.

**rpc AddDashboardsNodeGroup ([AddDashboardsNodeGroupRequest](#AddDashboardsNodeGroupRequest)) returns ([operation.Operation](#Operation13))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddNodeGroupMetadata](#AddNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddDashboardsNodeGroupRequest {#AddDashboardsNodeGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster to create the Dashboards type host group in. <br>To get the ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
node_group_spec | **[DashboardsCreateSpec.NodeGroup](#DashboardsCreateSpec)**<br>Configuration of the new host group. 


### Operation {#Operation13}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddNodeGroupMetadata](#AddNodeGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### AddNodeGroupMetadata {#AddNodeGroupMetadata1}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the OpenSearch cluster where the host group is being created. 
name | **string**<br>Name of the host group being created. 


## DeleteDashboardsNodeGroup {#DeleteDashboardsNodeGroup}

Deletes a Dashboards type host group.

**rpc DeleteDashboardsNodeGroup ([DeleteDashboardsNodeGroupRequest](#DeleteDashboardsNodeGroupRequest)) returns ([operation.Operation](#Operation14))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteNodeGroupMetadata](#DeleteNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDashboardsNodeGroupRequest {#DeleteDashboardsNodeGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster to delete the Dashboards type host group in. <br>To get the ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the Dashboards type host group to delete. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation14}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteNodeGroupMetadata](#DeleteNodeGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteNodeGroupMetadata {#DeleteNodeGroupMetadata1}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the OpenSearch cluster where the host group is being deleted. 
name | **string**<br>Name of the host group being deleted. 


## UpdateDashboardsNodeGroup {#UpdateDashboardsNodeGroup}

Updates a Dashboards type host group.

**rpc UpdateDashboardsNodeGroup ([UpdateDashboardsNodeGroupRequest](#UpdateDashboardsNodeGroupRequest)) returns ([operation.Operation](#Operation15))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateNodeGroupMetadata](#UpdateNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateDashboardsNodeGroupRequest {#UpdateDashboardsNodeGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster to update the Dashboards type host group in. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the Dashboards type host group to be updated. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the host group configuration should be updated. 
node_group_spec | **[DashboardsNodeGroupUpdateSpec](#DashboardsNodeGroupUpdateSpec)**<br>New configuration for the host group. 


### DashboardsNodeGroupUpdateSpec {#DashboardsNodeGroupUpdateSpec}

Field | Description
--- | ---
resources | **[Resources](#Resources12)**<br>Resources allocated to the hosts. 
hosts_count | **int64**<br>Number of hosts in the group. 


### Resources {#Resources12}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources allocated to a host. 
disk_size | **int64**<br>Volume of the storage used by the host, in bytes. 
disk_type_id | **string**<br>Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. 


### Operation {#Operation15}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateNodeGroupMetadata](#UpdateNodeGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### UpdateNodeGroupMetadata {#UpdateNodeGroupMetadata1}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the OpenSearch cluster where the host group is being updated. 
name | **string**<br>Name of the host group being updated. 


