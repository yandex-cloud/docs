---
editable: false
---

# ClusterService

A set of methods for managing OpenSearch clusters.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified OpenSearch Cluster resource. |
| [List](#List) | Retrieves the list of OpenSearch clusters. |
| [Create](#Create) | Creates an OpenSearch cluster. |
| [Update](#Update) | Updates the specified OpenSearch cluster. |
| [Delete](#Delete) | Deletes the specified OpenSearch cluster. |
| [Backup](#Backup) | Create a backup for the specified OpenSearch cluster. |
| [Restore](#Restore) | Creates a new OpenSearch cluster from the specified backup. |
| [RescheduleMaintenance](#RescheduleMaintenance) | Reschedule planned maintenance operation. |
| [ListBackups](#ListBackups) | Returns the list of available backups for the specified OpenSearch cluster. |
| [Move](#Move) | Moves the specified OpenSearch cluster to the specified folder. |
| [Start](#Start) | Start the specified OpenSearch cluster. |
| [Stop](#Stop) | Stop the specified OpenSearch cluster. |
| [ListLogs](#ListLogs) | Retrieves logs for the specified OpenSearch cluster. |
| [StreamLogs](#StreamLogs) | Same as ListLogs but using server-side streaming. |
| [ListOperations](#ListOperations) | Retrieves the list of Operation resources for the specified cluster. |
| [ListHosts](#ListHosts) | Retrieves a list of hosts for the specified cluster. |
| [AddOpenSearchNodeGroup](#AddOpenSearchNodeGroup) | Add an OpenSearch node group |
| [DeleteOpenSearchNodeGroup](#DeleteOpenSearchNodeGroup) |  |
| [UpdateOpenSearchNodeGroup](#UpdateOpenSearchNodeGroup) |  |
| [AddDashboardsNodeGroup](#AddDashboardsNodeGroup) |  |
| [DeleteDashboardsNodeGroup](#DeleteDashboardsNodeGroup) |  |
| [UpdateDashboardsNodeGroup](#UpdateDashboardsNodeGroup) |  |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified OpenSearch Cluster resource.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster to return. To get the cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow)**<br>Window of maintenance operations 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation)**<br>Maintenance operation planned at nearest maintenance_window 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts. 


### ClusterConfig {#ClusterConfig}

Field | Description
--- | ---
version | **string**<br>OpenSearch version. 
opensearch | **[OpenSearch](#OpenSearch)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards)**<br>Dashboards configuration. 
access | **[Access](#Access)**<br>Services access 


### OpenSearch {#OpenSearch}

Field | Description
--- | ---
plugins[] | **string**<br>Cluster plugins 
node_groups[] | **[NodeGroup](#NodeGroup)**<br> 


### NodeGroup {#NodeGroup}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zones for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 
roles[] | enum **GroupRole**<br> 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### Dashboards {#Dashboards}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup1)**<br> 


### NodeGroup {#NodeGroup1}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources1)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zone for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 


### Access {#Access}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. NOTE: Do not propagate to public API until Data Transfer integration is required. 
serverless | **bool**<br>Allow access for Serverless. NOTE: Do not propagate to public API until Serverless integration is required. 


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
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## List {#List}

Retrieves the list of OpenSearch clusters.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list OpenSearch clusters in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can only use filtering with the [Cluster.name](#Cluster1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 1-63 characters long and match the regular expression `^[a-zA-Z0-9_-]+$`.</li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of OpenSearch clusters. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster1}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow1)**<br>Window of maintenance operations 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation1)**<br>Maintenance operation planned at nearest maintenance_window 


### Monitoring {#Monitoring1}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts. 


### ClusterConfig {#ClusterConfig1}

Field | Description
--- | ---
version | **string**<br>OpenSearch version. 
opensearch | **[OpenSearch](#OpenSearch1)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards1)**<br>Dashboards configuration. 
access | **[Access](#Access1)**<br>Services access 


### OpenSearch {#OpenSearch1}

Field | Description
--- | ---
plugins[] | **string**<br>Cluster plugins 
node_groups[] | **[NodeGroup](#NodeGroup2)**<br> 


### NodeGroup {#NodeGroup2}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources1)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zones for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 
roles[] | enum **GroupRole**<br> 


### Resources {#Resources1}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### Dashboards {#Dashboards1}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup3)**<br> 


### NodeGroup {#NodeGroup3}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources2)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zone for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 


### Access {#Access1}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. NOTE: Do not propagate to public API until Data Transfer integration is required. 
serverless | **bool**<br>Allow access for Serverless. NOTE: Do not propagate to public API until Serverless integration is required. 


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
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation1}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Create {#Create}

Creates an OpenSearch cluster.

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
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Deployment environment of the OpenSearch cluster. 
config_spec | **[ConfigCreateSpec](#ConfigCreateSpec)**<br>Required. Cluster configuration and resources for hosts that should be created for the OpenSearch cluster. 
network_id | **string**<br>Required. ID of the network to create the cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow2)**<br>Window of maintenance operations 


### ConfigCreateSpec {#ConfigCreateSpec}

Field | Description
--- | ---
version | **string**<br>OpenSearch version. 
admin_password | **string**<br>Required. OpenSearch admin password. 
opensearch_spec | **[OpenSearchCreateSpec](#OpenSearchCreateSpec)**<br>OpenSearch configuration 
dashboards_spec | **[DashboardsCreateSpec](#DashboardsCreateSpec)**<br>Dashboards configuration 
access | **[Access](#Access2)**<br>Access for other services. 


### OpenSearchCreateSpec {#OpenSearchCreateSpec}

Field | Description
--- | ---
plugins[] | **string**<br>Cluster plugins 
node_groups[] | **[NodeGroup](#NodeGroup4)**<br> 


### NodeGroup {#NodeGroup4}

Field | Description
--- | ---
name | **string**<br>Required. Required. Name of the group to be created. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
resources | **[Resources](#Resources2)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group The minimum value is 1.
zone_ids[] | **string**<br>IDs of the availability zone for hosts The maximum number of elements is 10. The maximum string length in characters for each value is 50.
subnet_ids[] | **string**<br>IDs of the subnetworks in respective zones. The maximum number of elements is 10. The maximum string length in characters for each value is 50.
assign_public_ip | **bool**<br> 
roles[] | **[OpenSearch.GroupRole](#OpenSearch2)**<br> 


### Resources {#Resources2}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### DashboardsCreateSpec {#DashboardsCreateSpec}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup5)**<br> 


### NodeGroup {#NodeGroup5}

Field | Description
--- | ---
name | **string**<br>Required. Required. Name of the group to be created. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
resources | **[Resources](#Resources3)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group The minimum value is 1.
zone_ids[] | **string**<br>IDs of the availability zone for hosts 
subnet_ids[] | **string**<br>IDs of the subnetworks in respective zones. The maximum number of elements is 10. The maximum string length in characters for each value is 50.
assign_public_ip | **bool**<br> 


### Access {#Access2}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. NOTE: Do not propagate to public API until Data Transfer integration is required. 
serverless | **bool**<br>Allow access for Serverless. NOTE: Do not propagate to public API until Serverless integration is required. 


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
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC Acceptable values are 1 to 24, inclusive.


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
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>Window of maintenance operations 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation2)**<br>Maintenance operation planned at nearest maintenance_window 


### Monitoring {#Monitoring2}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts. 


### ClusterConfig {#ClusterConfig2}

Field | Description
--- | ---
version | **string**<br>OpenSearch version. 
opensearch | **[OpenSearch](#OpenSearch2)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards2)**<br>Dashboards configuration. 
access | **[Access](#Access3)**<br>Services access 


### OpenSearch {#OpenSearch2}

Field | Description
--- | ---
plugins[] | **string**<br>Cluster plugins 
node_groups[] | **[NodeGroup](#NodeGroup6)**<br> 


### NodeGroup {#NodeGroup6}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources3)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zones for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 
roles[] | enum **GroupRole**<br> 


### Dashboards {#Dashboards2}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup7)**<br> 


### NodeGroup {#NodeGroup7}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources3)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zone for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 


### MaintenanceOperation {#MaintenanceOperation2}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Update {#Update}

Updates the specified OpenSearch cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch Cluster resource to update. To get the OpenSearch cluster ID, use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the OpenSearch cluster should be updated. 
description | **string**<br>New description of the OpenSearch cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". <br>The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get](#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigUpdateSpec](#ConfigUpdateSpec)**<br>New cluster configuration 
name | **string**<br>The new name of the Opensearch cluster. The name must be unique within the folder. The name must be 1-63 characters long and match the regular expression `^[a-zA-Z0-9_-]+$`. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>Window of maintenance operations 


### ConfigUpdateSpec {#ConfigUpdateSpec}

Field | Description
--- | ---
version | **string**<br>OpenSearch version. 
admin_password | **string**<br>Required. OpenSearch admin password. 
opensearch_spec | **[OpenSearchClusterUpdateSpec](#OpenSearchClusterUpdateSpec)**<br>OpenSearch configuration 
dashboards_spec | **[DashboardsClusterUpdateSpec](#DashboardsClusterUpdateSpec)**<br>Dashboards configuration 
access | **[Access](#Access3)**<br>Access for other services. 


### OpenSearchClusterUpdateSpec {#OpenSearchClusterUpdateSpec}

Field | Description
--- | ---
plugins[] | **string**<br>Cluster plugins 


### DashboardsClusterUpdateSpec {#DashboardsClusterUpdateSpec}



### Access {#Access3}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. NOTE: Do not propagate to public API until Data Transfer integration is required. 
serverless | **bool**<br>Allow access for Serverless. NOTE: Do not propagate to public API until Serverless integration is required. 


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
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC Acceptable values are 1 to 24, inclusive.


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
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig3)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Window of maintenance operations 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation3)**<br>Maintenance operation planned at nearest maintenance_window 


### Monitoring {#Monitoring3}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts. 


### ClusterConfig {#ClusterConfig3}

Field | Description
--- | ---
version | **string**<br>OpenSearch version. 
opensearch | **[OpenSearch](#OpenSearch3)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards3)**<br>Dashboards configuration. 
access | **[Access](#Access4)**<br>Services access 


### OpenSearch {#OpenSearch3}

Field | Description
--- | ---
plugins[] | **string**<br>Cluster plugins 
node_groups[] | **[NodeGroup](#NodeGroup8)**<br> 


### NodeGroup {#NodeGroup8}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources3)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zones for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 
roles[] | enum **GroupRole**<br> 


### Resources {#Resources3}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### Dashboards {#Dashboards3}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup9)**<br> 


### NodeGroup {#NodeGroup9}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources4)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zone for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 


### MaintenanceOperation {#MaintenanceOperation3}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


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

Create a backup for the specified OpenSearch cluster.

**rpc Backup ([BackupClusterRequest](#BackupClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupClusterMetadata](#BackupClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### BackupClusterRequest {#BackupClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the OpenSearch cluster to back up. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the OpenSearch cluster. 


### Cluster {#Cluster4}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig4)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Window of maintenance operations 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation4)**<br>Maintenance operation planned at nearest maintenance_window 


### Monitoring {#Monitoring4}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts. 


### ClusterConfig {#ClusterConfig4}

Field | Description
--- | ---
version | **string**<br>OpenSearch version. 
opensearch | **[OpenSearch](#OpenSearch4)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards4)**<br>Dashboards configuration. 
access | **[Access](#Access4)**<br>Services access 


### OpenSearch {#OpenSearch4}

Field | Description
--- | ---
plugins[] | **string**<br>Cluster plugins 
node_groups[] | **[NodeGroup](#NodeGroup10)**<br> 


### NodeGroup {#NodeGroup10}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources4)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zones for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 
roles[] | enum **GroupRole**<br> 


### Resources {#Resources4}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### Dashboards {#Dashboards4}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup11)**<br> 


### NodeGroup {#NodeGroup11}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources5)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zone for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 


### Access {#Access4}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. NOTE: Do not propagate to public API until Data Transfer integration is required. 
serverless | **bool**<br>Allow access for Serverless. NOTE: Do not propagate to public API until Serverless integration is required. 


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
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation4}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Restore {#Restore}

Creates a new OpenSearch cluster from the specified backup.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. Required. ID of the backup to restore from. 
name | **string**<br>Required. Name of the OpenSearch cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the OpenSearch cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster5)**<br>Deployment environment of the OpenSearch cluster. 
config_spec | **[ConfigCreateSpec](#ConfigCreateSpec)**<br>Required. Cluster Configuration. 
network_id | **string**<br>Required. ID of the network to create the cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
folder_id | **string**<br>Required. ID of the folder to create the OpenSearch cluster in. The maximum string length in characters is 50.
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow5)**<br>Window of maintenance operations 


### ConfigCreateSpec {#ConfigCreateSpec1}

Field | Description
--- | ---
version | **string**<br>OpenSearch version. 
admin_password | **string**<br>Required. OpenSearch admin password. 
opensearch_spec | **[OpenSearchCreateSpec](#OpenSearchCreateSpec)**<br>OpenSearch configuration 
dashboards_spec | **[DashboardsCreateSpec](#DashboardsCreateSpec)**<br>Dashboards configuration 
access | **[Access](#Access5)**<br>Access for other services. 


### OpenSearchCreateSpec {#OpenSearchCreateSpec1}

Field | Description
--- | ---
plugins[] | **string**<br>Cluster plugins 
node_groups[] | **[NodeGroup](#NodeGroup12)**<br> 


### NodeGroup {#NodeGroup12}

Field | Description
--- | ---
name | **string**<br>Required. Required. Name of the group to be created. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
resources | **[Resources](#Resources5)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group The minimum value is 1.
zone_ids[] | **string**<br>IDs of the availability zone for hosts The maximum number of elements is 10. The maximum string length in characters for each value is 50.
subnet_ids[] | **string**<br>IDs of the subnetworks in respective zones. The maximum number of elements is 10. The maximum string length in characters for each value is 50.
assign_public_ip | **bool**<br> 
roles[] | **[OpenSearch.GroupRole](#OpenSearch5)**<br> 


### Resources {#Resources5}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### DashboardsCreateSpec {#DashboardsCreateSpec1}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup13)**<br> 


### NodeGroup {#NodeGroup13}

Field | Description
--- | ---
name | **string**<br>Required. Required. Name of the group to be created. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
resources | **[Resources](#Resources6)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group The minimum value is 1.
zone_ids[] | **string**<br>IDs of the availability zone for hosts 
subnet_ids[] | **string**<br>IDs of the subnetworks in respective zones. The maximum number of elements is 10. The maximum string length in characters for each value is 50.
assign_public_ip | **bool**<br> 


### Access {#Access5}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. NOTE: Do not propagate to public API until Data Transfer integration is required. 
serverless | **bool**<br>Allow access for Serverless. NOTE: Do not propagate to public API until Serverless integration is required. 


### MaintenanceWindow {#MaintenanceWindow5}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow5)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow5)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow5}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow5}

Field | Description
--- | ---
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC Acceptable values are 1 to 24, inclusive.


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
cluster_id | **string**<br>Required. ID of the new OpenSearch cluster. 
backup_id | **string**<br>Required. ID of the backup used for recovery. 


### Cluster {#Cluster5}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig5)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow6)**<br>Window of maintenance operations 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation5)**<br>Maintenance operation planned at nearest maintenance_window 


### Monitoring {#Monitoring5}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts. 


### ClusterConfig {#ClusterConfig5}

Field | Description
--- | ---
version | **string**<br>OpenSearch version. 
opensearch | **[OpenSearch](#OpenSearch5)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards5)**<br>Dashboards configuration. 
access | **[Access](#Access6)**<br>Services access 


### OpenSearch {#OpenSearch5}

Field | Description
--- | ---
plugins[] | **string**<br>Cluster plugins 
node_groups[] | **[NodeGroup](#NodeGroup14)**<br> 


### NodeGroup {#NodeGroup14}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources6)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zones for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 
roles[] | enum **GroupRole**<br> 


### Dashboards {#Dashboards5}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup15)**<br> 


### NodeGroup {#NodeGroup15}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources6)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zone for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 


### MaintenanceOperation {#MaintenanceOperation5}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## RescheduleMaintenance {#RescheduleMaintenance}

Reschedule planned maintenance operation.

**rpc RescheduleMaintenance ([RescheduleMaintenanceRequest](#RescheduleMaintenanceRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RescheduleMaintenanceMetadata](#RescheduleMaintenanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### RescheduleMaintenanceRequest {#RescheduleMaintenanceRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the OpenSearch cluster to maintenance reschedule. The maximum string length in characters is 50.
reschedule_type | enum **RescheduleType**<br>Required. Required. The type of reschedule request. 
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time for SPECIFIC_TIME reschedule. Limited by two weeks since first time scheduled. 


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
cluster_id | **string**<br>Required. ID of the OpenSearch cluster. 
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. New time of the planned maintenance. Can be in the past for rescheduled to "IMMEDIATE". 


### Cluster {#Cluster6}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring6)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig6)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow6)**<br>Window of maintenance operations 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation6)**<br>Maintenance operation planned at nearest maintenance_window 


### Monitoring {#Monitoring6}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts. 


### ClusterConfig {#ClusterConfig6}

Field | Description
--- | ---
version | **string**<br>OpenSearch version. 
opensearch | **[OpenSearch](#OpenSearch6)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards6)**<br>Dashboards configuration. 
access | **[Access](#Access6)**<br>Services access 


### OpenSearch {#OpenSearch6}

Field | Description
--- | ---
plugins[] | **string**<br>Cluster plugins 
node_groups[] | **[NodeGroup](#NodeGroup16)**<br> 


### NodeGroup {#NodeGroup16}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources6)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zones for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 
roles[] | enum **GroupRole**<br> 


### Resources {#Resources6}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### Dashboards {#Dashboards6}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup17)**<br> 


### NodeGroup {#NodeGroup17}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources7)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zone for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 


### Access {#Access6}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. NOTE: Do not propagate to public API until Data Transfer integration is required. 
serverless | **bool**<br>Allow access for Serverless. NOTE: Do not propagate to public API until Serverless integration is required. 


### MaintenanceWindow {#MaintenanceWindow6}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow6)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow6)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow6}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow6}

Field | Description
--- | ---
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation6}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## ListBackups {#ListBackups}

Returns the list of available backups for the specified OpenSearch cluster.

**rpc ListBackups ([ListClusterBackupsRequest](#ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#ListClusterBackupsResponse))**

### ListClusterBackupsRequest {#ListClusterBackupsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the OpenSearch cluster. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListClusterBackups requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. Set `page_token` to the `next_page_token` returned by a previous ListClusterBackups request to get the next page of results. The maximum string length in characters is 100.


### ListClusterBackupsResponse {#ListClusterBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup)**<br>Requested list of backups. 
next_page_token | **string**<br>This token allows you to get the next page of results for ListClusterBackups requests, if the number of results is larger than `page_size` specified in the request. To get the next page, specify the value of `next_page_token` as a value for the `page_token` parameter in the next ListClusterBackups request. Subsequent ListClusterBackups requests will have their own `next_page_token` to continue paging through the results. 


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>Required. ID of the backup. 
folder_id | **string**<br>ID of the folder that the backup belongs to. 
source_cluster_id | **string**<br>ID of the associated OpenSearch cluster. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the backup operation was started. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the backup was created (i.e. when the backup operation completed). 
indices[] | **string**<br>Indices names. (max 100) The maximum number of elements is 100.
opensearch_version | **string**<br>OpenSearch version used to create the snapshot 
size_bytes | **int64**<br>Total size of all indices in backup. in bytes 
indices_total | **int64**<br>Total count of indices in backup 


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
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring7)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig7)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow7)**<br>Window of maintenance operations 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation7)**<br>Maintenance operation planned at nearest maintenance_window 


### Monitoring {#Monitoring7}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts. 


### ClusterConfig {#ClusterConfig7}

Field | Description
--- | ---
version | **string**<br>OpenSearch version. 
opensearch | **[OpenSearch](#OpenSearch7)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards7)**<br>Dashboards configuration. 
access | **[Access](#Access7)**<br>Services access 


### OpenSearch {#OpenSearch7}

Field | Description
--- | ---
plugins[] | **string**<br>Cluster plugins 
node_groups[] | **[NodeGroup](#NodeGroup18)**<br> 


### NodeGroup {#NodeGroup18}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources7)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zones for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 
roles[] | enum **GroupRole**<br> 


### Resources {#Resources7}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### Dashboards {#Dashboards7}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup19)**<br> 


### NodeGroup {#NodeGroup19}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources8)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zone for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 


### Access {#Access7}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. NOTE: Do not propagate to public API until Data Transfer integration is required. 
serverless | **bool**<br>Allow access for Serverless. NOTE: Do not propagate to public API until Serverless integration is required. 


### MaintenanceWindow {#MaintenanceWindow7}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow7)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow7)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow7}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow7}

Field | Description
--- | ---
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation7}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Start {#Start}

Start the specified OpenSearch cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster8)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the OpenSearch cluster to start. The maximum string length in characters is 50.


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
cluster_id | **string**<br>Required. ID of the OpenSearch cluster. 


### Cluster {#Cluster8}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring8)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig8)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow8)**<br>Window of maintenance operations 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation8)**<br>Maintenance operation planned at nearest maintenance_window 


### Monitoring {#Monitoring8}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts. 


### ClusterConfig {#ClusterConfig8}

Field | Description
--- | ---
version | **string**<br>OpenSearch version. 
opensearch | **[OpenSearch](#OpenSearch8)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards8)**<br>Dashboards configuration. 
access | **[Access](#Access8)**<br>Services access 


### OpenSearch {#OpenSearch8}

Field | Description
--- | ---
plugins[] | **string**<br>Cluster plugins 
node_groups[] | **[NodeGroup](#NodeGroup20)**<br> 


### NodeGroup {#NodeGroup20}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources8)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zones for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 
roles[] | enum **GroupRole**<br> 


### Resources {#Resources8}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### Dashboards {#Dashboards8}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup21)**<br> 


### NodeGroup {#NodeGroup21}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources9)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zone for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 


### Access {#Access8}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. NOTE: Do not propagate to public API until Data Transfer integration is required. 
serverless | **bool**<br>Allow access for Serverless. NOTE: Do not propagate to public API until Serverless integration is required. 


### MaintenanceWindow {#MaintenanceWindow8}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow8)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow8)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow8}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow8}

Field | Description
--- | ---
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation8}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Stop {#Stop}

Stop the specified OpenSearch cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation8))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster9)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the OpenSearch cluster to stop. The maximum string length in characters is 50.


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
cluster_id | **string**<br>Required. ID of the OpenSearch cluster. 


### Cluster {#Cluster9}

Field | Description
--- | ---
id | **string**<br>ID of the OpenSearch cluster. This ID is assigned by MDB at creation time. 
folder_id | **string**<br>ID of the folder that the OpenSearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the OpenSearch cluster. The name is unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the OpenSearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the OpenSearch cluster as `` key:value `` pairs. Maximum 64 per resource. 
environment | enum **Environment**<br>Deployment environment of the OpenSearch cluster. <ul><li>`PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring9)**<br>Description of monitoring systems relevant to the OpenSearch cluster. 
config | **[ClusterConfig](#ClusterConfig9)**<br>Configuration of the OpenSearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](#Host) for every host in the cluster is UNKNOWN).</li><li>`ALIVE`: Cluster is alive and well ([Host.health](#Host) for every host in the cluster is ALIVE).</li><li>`DEAD`: Cluster is inoperable ([Host.health](#Host) for every host in the cluster is DEAD).</li><li>`DEGRADED`: Cluster is working below capacity ([Host.health](#Host) for at least one host in the cluster is not ALIVE).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: Cluster state is unknown.</li><li>`CREATING`: Cluster is being created.</li><li>`RUNNING`: Cluster is running normally.</li><li>`ERROR`: Cluster encountered a problem and cannot operate.</li><li>`UPDATING`: Cluster is being updated.</li><li>`STOPPING`: Cluster is stopping.</li><li>`STOPPED`: Cluster stopped.</li><li>`STARTING`: Cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Yandex Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow9)**<br>Window of maintenance operations 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation9)**<br>Maintenance operation planned at nearest maintenance_window 


### Monitoring {#Monitoring9}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts. 


### ClusterConfig {#ClusterConfig9}

Field | Description
--- | ---
version | **string**<br>OpenSearch version. 
opensearch | **[OpenSearch](#OpenSearch9)**<br>OpenSearch configuration. 
dashboards | **[Dashboards](#Dashboards9)**<br>Dashboards configuration. 
access | **[Access](#Access9)**<br>Services access 


### OpenSearch {#OpenSearch9}

Field | Description
--- | ---
plugins[] | **string**<br>Cluster plugins 
node_groups[] | **[NodeGroup](#NodeGroup22)**<br> 


### NodeGroup {#NodeGroup22}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources9)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zones for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 
roles[] | enum **GroupRole**<br> 


### Resources {#Resources9}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


### Dashboards {#Dashboards9}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup23)**<br> 


### NodeGroup {#NodeGroup23}

Field | Description
--- | ---
name | **string**<br>Name of the group. 
resources | **[Resources](#Resources10)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group 
zone_ids[] | **string**<br>IDs of the availability zone for hosts 
subnet_ids[] | **string**<br>IDs of the subnets for hosts 
assign_public_ip | **bool**<br> 


### Access {#Access9}

Field | Description
--- | ---
data_transfer | **bool**<br>Allow access for DataTransfer. NOTE: Do not propagate to public API until Data Transfer integration is required. 
serverless | **bool**<br>Allow access for Serverless. NOTE: Do not propagate to public API until Serverless integration is required. 


### MaintenanceWindow {#MaintenanceWindow9}

Field | Description
--- | ---
policy | **oneof:** `anytime` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow9)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow9)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow9}



### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow9}

Field | Description
--- | ---
day | enum **WeekDay**<br> 
hour | **int64**<br>Hour of the day in UTC Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation9}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## ListLogs {#ListLogs}

Retrieves logs for the specified OpenSearch cluster. See the [Logs](/yandex-mdb-guide/concepts/logs.html) section in the developers guide for detailed logs description.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster to request logs for. To get the OpenSearch cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from the logs table to request. If no columns are specified, entire log records are returned. 
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) returned by a previous list request. The maximum string length in characters is 100.
always_next_page_token | **bool**<br>Always return `next_page_token`, even if current page is empty. 
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname](#LogRecord) field. </li><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 1-63 characters long and match the regular expression `^[a-z0-9.-]{1,61}$`. </li></ol>Examples of a filter: `message.hostname='node1.db.cloud.yandex.net'` The maximum string length in characters is 1000.
service_type | enum **ServiceType**<br>Type of the service to request logs about. 


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
cluster_id | **string**<br>Required. Required. ID of the OpenSearch cluster. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from logs table to get in the response. 
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request. If this field is not set, all existing logs will be sent and then the new ones as they appear. In essence it has 'tail -f' semantics. 
record_token | **string**<br>Record token. Set `record_token` to the `next_record_token` returned by a previous StreamLogs request to start streaming from next log record. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently filtering can be applied to the [LogRecord.logs.hostname](#LogRecord) field. </li><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. </li></ol>Examples of a filter: `message.hostname='node1.db.cloud.yandex.net'` The maximum string length in characters is 1000.
service_type | enum **ServiceType**<br>Type of the service to request logs about. 


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
cluster_id | **string**<br>Required. ID of the OpenSearch cluster resource to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token.  To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation9)**<br>List of Operation resources for the specified OpenSearch cluster. 
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


## ListHosts {#ListHosts}

Retrieves a list of hosts for the specified cluster.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the OpenSearch cluster. To get the OpenSearch cluster ID use a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](#Host)**<br>List of Host resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
name | **string**<br>Required. Name of the host. 
cluster_id | **string**<br>Required. ID of the OpenSearch cluster. 
zone_id | **string**<br>ID of the availability zone. 
resources | **[Resources](#Resources10)**<br>Resources allocated to the host. 
type | enum **Type**<br>Host type. 
health | enum **Health**<br>Aggregated host health 
subnet_id | **string**<br> 
assign_public_ip | **bool**<br> 
system | **[SystemMetrics](#SystemMetrics)**<br>System metrics 
node_group | **string**<br>Which node group the host belongs to 
roles[] | **[OpenSearch.GroupRole](#OpenSearch10)**<br> 


### CPUMetric {#CPUMetric}

Field | Description
--- | ---
timestamp | **int64**<br> 
used | **double**<br> 


### MemoryMetric {#MemoryMetric}

Field | Description
--- | ---
timestamp | **int64**<br> 
used | **int64**<br> 
total | **int64**<br> 


### DiskMetric {#DiskMetric}

Field | Description
--- | ---
timestamp | **int64**<br> 
used | **int64**<br> 
total | **int64**<br> 


### SystemMetrics {#SystemMetrics}

Field | Description
--- | ---
cpu | **[CPUMetric](#CPUMetric)**<br> 
memory | **[MemoryMetric](#MemoryMetric)**<br> 
disk | **[DiskMetric](#DiskMetric)**<br> 


### Resources {#Resources10}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


## AddOpenSearchNodeGroup {#AddOpenSearchNodeGroup}

Add an OpenSearch node group

**rpc AddOpenSearchNodeGroup ([AddOpenSearchNodeGroupRequest](#AddOpenSearchNodeGroupRequest)) returns ([operation.Operation](#Operation10))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddNodeGroupMetadata](#AddNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddOpenSearchNodeGroupRequest {#AddOpenSearchNodeGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
node_group_spec | **[OpenSearchCreateSpec.NodeGroup](#OpenSearchCreateSpec)**<br> 


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
cluster_id | **string**<br> 
name | **string**<br> 


## DeleteOpenSearchNodeGroup {#DeleteOpenSearchNodeGroup}



**rpc DeleteOpenSearchNodeGroup ([DeleteOpenSearchNodeGroupRequest](#DeleteOpenSearchNodeGroupRequest)) returns ([operation.Operation](#Operation11))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteNodeGroupMetadata](#DeleteNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteOpenSearchNodeGroupRequest {#DeleteOpenSearchNodeGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the OpenSearch cluster. The maximum string length in characters is 50.
name | **string**<br> 


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
cluster_id | **string**<br> 
name | **string**<br> 


## UpdateOpenSearchNodeGroup {#UpdateOpenSearchNodeGroup}



**rpc UpdateOpenSearchNodeGroup ([UpdateOpenSearchNodeGroupRequest](#UpdateOpenSearchNodeGroupRequest)) returns ([operation.Operation](#Operation12))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateNodeGroupMetadata](#UpdateNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateOpenSearchNodeGroupRequest {#UpdateOpenSearchNodeGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the OpenSearch cluster. The maximum string length in characters is 50.
name | **string**<br>Required. Required. Name of the group to be updated. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
node_group_spec | **[OpenSearchNodeGroupUpdateSpec](#OpenSearchNodeGroupUpdateSpec)**<br> 


### OpenSearchNodeGroupUpdateSpec {#OpenSearchNodeGroupUpdateSpec}

Field | Description
--- | ---
resources | **[Resources](#Resources11)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group. 
roles[] | **[OpenSearch.GroupRole](#OpenSearch10)**<br>Opensearch roles applicable to the node group. 


### Resources {#Resources11}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


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
cluster_id | **string**<br> 
name | **string**<br> 


## AddDashboardsNodeGroup {#AddDashboardsNodeGroup}



**rpc AddDashboardsNodeGroup ([AddDashboardsNodeGroupRequest](#AddDashboardsNodeGroupRequest)) returns ([operation.Operation](#Operation13))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddNodeGroupMetadata](#AddNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddDashboardsNodeGroupRequest {#AddDashboardsNodeGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
node_group_spec | **[DashboardsCreateSpec.NodeGroup](#DashboardsCreateSpec)**<br> 


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
cluster_id | **string**<br> 
name | **string**<br> 


## DeleteDashboardsNodeGroup {#DeleteDashboardsNodeGroup}



**rpc DeleteDashboardsNodeGroup ([DeleteDashboardsNodeGroupRequest](#DeleteDashboardsNodeGroupRequest)) returns ([operation.Operation](#Operation14))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteNodeGroupMetadata](#DeleteNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDashboardsNodeGroupRequest {#DeleteDashboardsNodeGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the OpenSearch cluster. The maximum string length in characters is 50.
name | **string**<br>Required.  The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br> 
name | **string**<br> 


## UpdateDashboardsNodeGroup {#UpdateDashboardsNodeGroup}



**rpc UpdateDashboardsNodeGroup ([UpdateDashboardsNodeGroupRequest](#UpdateDashboardsNodeGroupRequest)) returns ([operation.Operation](#Operation15))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateNodeGroupMetadata](#UpdateNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateDashboardsNodeGroupRequest {#UpdateDashboardsNodeGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the OpenSearch cluster. The maximum string length in characters is 50.
name | **string**<br>Required. Required. Name of the group to be updated. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
node_group_spec | **[DashboardsNodeGroupUpdateSpec](#DashboardsNodeGroupUpdateSpec)**<br> 


### DashboardsNodeGroupUpdateSpec {#DashboardsNodeGroupUpdateSpec}

Field | Description
--- | ---
resources | **[Resources](#Resources12)**<br>Resources allocated to data node hosts. 
hosts_count | **int64**<br>Number of nodes in the group. 


### Resources {#Resources12}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. 


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
cluster_id | **string**<br> 
name | **string**<br> 


