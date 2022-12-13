---
editable: false
---

# Managed Service for Elasticsearch API, gRPC: ClusterService

A set of methods for managing Elasticsearch clusters.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Elasticsearch cluster. |
| [List](#List) | Retrieves the list of Elasticsearch clusters that belong to the specified folder. |
| [Create](#Create) | Creates a new Elasticsearch cluster in the specified folder. |
| [Update](#Update) | Updates the specified Elasticsearch cluster. |
| [Delete](#Delete) | Deletes the specified Elasticsearch cluster. |
| [Move](#Move) | Moves the specified Elasticsearch cluster to the specified folder. |
| [Start](#Start) | Starts the specified Elasticsearch cluster. |
| [Stop](#Stop) | Stops the specified Elasticsearch cluster. |
| [Backup](#Backup) | Create a backup for the specified ElasticSearch cluster. |
| [ListBackups](#ListBackups) | Returns the list of available backups for the specified Elasticsearch cluster. |
| [Restore](#Restore) | Creates a new ElasticSearch cluster from the specified backup. |
| [ListLogs](#ListLogs) | Retrieves logs for the specified Elasticsearch cluster. |
| [StreamLogs](#StreamLogs) | Same as [ListLogs](#ListLogs) but using server-side streaming. |
| [ListOperations](#ListOperations) | Retrieves the list of operations for the specified Elasticsearch cluster. |
| [ListHosts](#ListHosts) | Retrieves a list of hosts for the specified Elasticsearch cluster. |
| [AddHosts](#AddHosts) | Adds new hosts to the specified Elasticsearch cluster. |
| [DeleteHosts](#DeleteHosts) | Deletes specified hosts from the specified Elasticsearch cluster. |
| [RescheduleMaintenance](#RescheduleMaintenance) | Reschedule planned maintenance operation. |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified Elasticsearch cluster. <br>To get the list of available Elasticsearch clusters, make a [List](#List) request.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Elasticsearch cluster to return. <br>To get the cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the Elasticsearch cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Elasticsearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Elasticsearch cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Elasticsearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Elasticsearch cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Elasticsearch cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring)**<br>Description of monitoring systems relevant to the Elasticsearch cluster. 
config | **[ClusterConfig](#ClusterConfig)**<br>Configuration of the Elasticsearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation)**<br>Maintenance operation planned at nearest maintenance_window. 


### Monitoring {#Monitoring}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Elasticsearch cluster. 


### ClusterConfig {#ClusterConfig}

Field | Description
--- | ---
version | **string**<br>Elasticsearch version. 
elasticsearch | **[Elasticsearch](#Elasticsearch)**<br>Configuration and resource allocation for Elasticsearch nodes. 
edition | **string**<br>ElasticSearch edition. 


### Elasticsearch {#Elasticsearch}

Field | Description
--- | ---
data_node | **[DataNode](#DataNode)**<br>Configuration and resource allocation for Elasticsearch data nodes. 
master_node | **[MasterNode](#MasterNode)**<br>Configuration and resource allocation for Elasticsearch master nodes. 
plugins[] | **string**<br>Cluster wide plugins 


### DataNode {#DataNode}

Field | Description
--- | ---
config | **oneof:** `elasticsearch_config_set_7`<br>
&nbsp;&nbsp;elasticsearch_config_set_7 | **[config.ElasticsearchConfigSet7](#ElasticsearchConfigSet7)**<br>Elasticsearch 7.x data node configuration. 
resources | **[Resources](#Resources)**<br>Resources allocated to Elasticsearch data nodes. 


### MasterNode {#MasterNode}

Field | Description
--- | ---
resources | **[Resources](#Resources)**<br>Resources allocated to Elasticsearch master nodes. 


### Resources {#Resources}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-elasticsearch/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. All available types are listed in the [documentation](/docs/managed-elasticsearch/concepts/storage). 


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
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## List {#List}

Retrieves the list of Elasticsearch clusters that belong to the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list Elasticsearch clusters in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by the previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name to filter by. Currently you can only use filtering with the [Cluster.name](#Cluster1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`. </li></ol><br>Example of a filter: `name NOT IN 'test,beta'`. The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of Elasticsearch clusters. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest), use `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster1}

Field | Description
--- | ---
id | **string**<br>ID of the Elasticsearch cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Elasticsearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Elasticsearch cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Elasticsearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Elasticsearch cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Elasticsearch cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Description of monitoring systems relevant to the Elasticsearch cluster. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Configuration of the Elasticsearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow1)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation1)**<br>Maintenance operation planned at nearest maintenance_window. 


### Monitoring {#Monitoring1}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Elasticsearch cluster. 


### ClusterConfig {#ClusterConfig1}

Field | Description
--- | ---
version | **string**<br>Elasticsearch version. 
elasticsearch | **[Elasticsearch](#Elasticsearch1)**<br>Configuration and resource allocation for Elasticsearch nodes. 
edition | **string**<br>ElasticSearch edition. 


### Elasticsearch {#Elasticsearch1}

Field | Description
--- | ---
data_node | **[DataNode](#DataNode1)**<br>Configuration and resource allocation for Elasticsearch data nodes. 
master_node | **[MasterNode](#MasterNode1)**<br>Configuration and resource allocation for Elasticsearch master nodes. 
plugins[] | **string**<br>Cluster wide plugins 


### DataNode {#DataNode1}

Field | Description
--- | ---
config | **oneof:** `elasticsearch_config_set_7`<br>
&nbsp;&nbsp;elasticsearch_config_set_7 | **[config.ElasticsearchConfigSet7](#ElasticsearchConfigSet7)**<br>Elasticsearch 7.x data node configuration. 
resources | **[Resources](#Resources1)**<br>Resources allocated to Elasticsearch data nodes. 


### MasterNode {#MasterNode1}

Field | Description
--- | ---
resources | **[Resources](#Resources1)**<br>Resources allocated to Elasticsearch master nodes. 


### Resources {#Resources1}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-elasticsearch/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. All available types are listed in the [documentation](/docs/managed-elasticsearch/concepts/storage). 


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
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation1}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Create {#Create}

Creates a new Elasticsearch cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create the Elasticsearch cluster in. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the Elasticsearch cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the Elasticsearch cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Elasticsearch cluster as `key:value` pairs. <br>For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Deployment environment of the Elasticsearch cluster. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Required. Elasticsearch and hosts configuration for the cluster. 
user_specs[] | **[UserSpec](#UserSpec)**<br>One or more descriptions of users to be created in Elasticsearch cluster. 
host_specs[] | **[HostSpec](#HostSpec)**<br>One or more configurations of hosts to be created in the Elasticsearch cluster. The number of elements must be greater than 0.
network_id | **string**<br>Required. ID of the network to create the Elasticsearch cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow2)**<br>Window of maintenance operations. 
extension_specs[] | **[ExtensionSpec](#ExtensionSpec)**<br> 


### ConfigSpec {#ConfigSpec}

Field | Description
--- | ---
version | **string**<br>Elasticsearch version. 
elasticsearch_spec | **[ElasticsearchSpec](#ElasticsearchSpec)**<br>Configuration and resource allocation for Elasticsearch nodes. 
edition | **string**<br>ElasticSearch edition. 
admin_password | **string**<br>Required. ElasticSearch admin password. 


### ElasticsearchSpec {#ElasticsearchSpec}

Field | Description
--- | ---
data_node | **[DataNode](#DataNode2)**<br>Configuration and resource allocation for Elasticsearch data nodes. 
master_node | **[MasterNode](#MasterNode2)**<br>Configuration and resource allocation for Elasticsearch master nodes. 
plugins[] | **string**<br>Cluster wide plugins The maximum string length in characters for each value is 50.


### DataNode {#DataNode2}

Field | Description
--- | ---
config | **oneof:** `elasticsearch_config_7`<br>Elasticsearch data node configuration.
&nbsp;&nbsp;elasticsearch_config_7 | **[config.ElasticsearchConfig7](#ElasticsearchConfig7)**<br>Elasticsearch data node configuration. 
resources | **[Resources](#Resources2)**<br>Resources allocated to Elasticsearch data nodes. 


### MasterNode {#MasterNode2}

Field | Description
--- | ---
resources | **[Resources](#Resources2)**<br>Resources allocated to Elasticsearch master nodes. 


### Resources {#Resources2}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-elasticsearch/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. All available types are listed in the [documentation](/docs/managed-elasticsearch/concepts/storage). 


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the Elasticsearch user. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Required. Password of the Elasticsearch user. The string length in characters must be 8-128.


### HostSpec {#HostSpec}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the host resides in. The maximum string length in characters is 50.
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the host. <br>If the value is `true`, then this host is available on the Internet via it's public IP address. 
type | **[Host.Type](#Host)**<br>Required. Host type. 
shard_name | **string**<br>The shard name to create on the host. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


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
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### ExtensionSpec {#ExtensionSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the extension. The maximum string length in characters is 50.
uri | **string**<br>URI of the zip archive to create the new extension from. Currently only supports links that are stored in Object Storage. 
disabled | **bool**<br>The flag shows whether to create the extension in disabled state. 


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
cluster_id | **string**<br>ID of the Elasticsearch cluster that is being created. 


### Cluster {#Cluster2}

Field | Description
--- | ---
id | **string**<br>ID of the Elasticsearch cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Elasticsearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Elasticsearch cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Elasticsearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Elasticsearch cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Elasticsearch cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Description of monitoring systems relevant to the Elasticsearch cluster. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Configuration of the Elasticsearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation2)**<br>Maintenance operation planned at nearest maintenance_window. 


### Monitoring {#Monitoring2}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Elasticsearch cluster. 


### ClusterConfig {#ClusterConfig2}

Field | Description
--- | ---
version | **string**<br>Elasticsearch version. 
elasticsearch | **[Elasticsearch](#Elasticsearch2)**<br>Configuration and resource allocation for Elasticsearch nodes. 
edition | **string**<br>ElasticSearch edition. 


### Elasticsearch {#Elasticsearch2}

Field | Description
--- | ---
data_node | **[DataNode](#DataNode3)**<br>Configuration and resource allocation for Elasticsearch data nodes. 
master_node | **[MasterNode](#MasterNode3)**<br>Configuration and resource allocation for Elasticsearch master nodes. 
plugins[] | **string**<br>Cluster wide plugins 


### DataNode {#DataNode3}

Field | Description
--- | ---
config | **oneof:** `elasticsearch_config_set_7`<br>
&nbsp;&nbsp;elasticsearch_config_set_7 | **[config.ElasticsearchConfigSet7](#ElasticsearchConfigSet7)**<br>Elasticsearch 7.x data node configuration. 
resources | **[Resources](#Resources3)**<br>Resources allocated to Elasticsearch data nodes. 


### MasterNode {#MasterNode3}

Field | Description
--- | ---
resources | **[Resources](#Resources3)**<br>Resources allocated to Elasticsearch master nodes. 


### MaintenanceOperation {#MaintenanceOperation2}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Update {#Update}

Updates the specified Elasticsearch cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Elasticsearch cluster to update. <br>To get the Elasticsearch cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
description | **string**<br>New description of the Elasticsearch cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the Elasticsearch cluster as `key:value` pairs. <br>For example, "project": "mvp" or "source": "dictionary". <br>The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get](#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpecUpdate](#ConfigSpecUpdate)**<br>New configuration and resources for hosts in the Elasticsearch cluster. <br>Use `update_mask` to prevent reverting all cluster settings that are not listed in `config_spec` to their default values. 
name | **string**<br>New name for the Elasticsearch cluster. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>Window of maintenance operations. 


### ConfigSpecUpdate {#ConfigSpecUpdate}

Field | Description
--- | ---
version | **string**<br>Elasticsearch version. 
elasticsearch_spec | **[ElasticsearchSpec](#ElasticsearchSpec)**<br>Configuration and resource allocation for Elasticsearch nodes. 
edition | **string**<br>ElasticSearch edition. 
admin_password | **string**<br>ElasticSearch admin password. 


### ElasticsearchSpec {#ElasticsearchSpec1}

Field | Description
--- | ---
data_node | **[DataNode](#DataNode4)**<br>Configuration and resource allocation for Elasticsearch data nodes. 
master_node | **[MasterNode](#MasterNode4)**<br>Configuration and resource allocation for Elasticsearch master nodes. 
plugins[] | **string**<br>Cluster wide plugins The maximum string length in characters for each value is 50.


### DataNode {#DataNode4}

Field | Description
--- | ---
config | **oneof:** `elasticsearch_config_7`<br>Elasticsearch data node configuration.
&nbsp;&nbsp;elasticsearch_config_7 | **[config.ElasticsearchConfig7](#ElasticsearchConfig7)**<br>Elasticsearch data node configuration. 
resources | **[Resources](#Resources3)**<br>Resources allocated to Elasticsearch data nodes. 


### MasterNode {#MasterNode4}

Field | Description
--- | ---
resources | **[Resources](#Resources3)**<br>Resources allocated to Elasticsearch master nodes. 


### Resources {#Resources3}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-elasticsearch/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. All available types are listed in the [documentation](/docs/managed-elasticsearch/concepts/storage). 


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
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


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
cluster_id | **string**<br>ID of the Elasticsearch cluster that is being updated. 


### Cluster {#Cluster3}

Field | Description
--- | ---
id | **string**<br>ID of the Elasticsearch cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Elasticsearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Elasticsearch cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Elasticsearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Elasticsearch cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Elasticsearch cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Description of monitoring systems relevant to the Elasticsearch cluster. 
config | **[ClusterConfig](#ClusterConfig3)**<br>Configuration of the Elasticsearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation3)**<br>Maintenance operation planned at nearest maintenance_window. 


### Monitoring {#Monitoring3}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Elasticsearch cluster. 


### ClusterConfig {#ClusterConfig3}

Field | Description
--- | ---
version | **string**<br>Elasticsearch version. 
elasticsearch | **[Elasticsearch](#Elasticsearch3)**<br>Configuration and resource allocation for Elasticsearch nodes. 
edition | **string**<br>ElasticSearch edition. 


### Elasticsearch {#Elasticsearch3}

Field | Description
--- | ---
data_node | **[DataNode](#DataNode5)**<br>Configuration and resource allocation for Elasticsearch data nodes. 
master_node | **[MasterNode](#MasterNode5)**<br>Configuration and resource allocation for Elasticsearch master nodes. 
plugins[] | **string**<br>Cluster wide plugins 


### DataNode {#DataNode5}

Field | Description
--- | ---
config | **oneof:** `elasticsearch_config_set_7`<br>
&nbsp;&nbsp;elasticsearch_config_set_7 | **[config.ElasticsearchConfigSet7](#ElasticsearchConfigSet7)**<br>Elasticsearch 7.x data node configuration. 
resources | **[Resources](#Resources4)**<br>Resources allocated to Elasticsearch data nodes. 


### MasterNode {#MasterNode5}

Field | Description
--- | ---
resources | **[Resources](#Resources4)**<br>Resources allocated to Elasticsearch master nodes. 


### MaintenanceOperation {#MaintenanceOperation3}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Delete {#Delete}

Deletes the specified Elasticsearch cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Elasticsearch cluster to delete. <br>To get the Elasticsearch cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the Elasticsearch cluster that is being deleted. 


## Move {#Move}

Moves the specified Elasticsearch cluster to the specified folder.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### MoveClusterRequest {#MoveClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Elasticsearch cluster to move. <br>To get the Elasticsearch cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
destination_folder_id | **string**<br>Required. ID of the destination folder. The maximum string length in characters is 50.


### Operation {#Operation3}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster4)>**<br>if operation finished successfully. 


### MoveClusterMetadata {#MoveClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Elasticsearch cluster being moved. 
source_folder_id | **string**<br>ID of the source folder. 
destination_folder_id | **string**<br>ID of the destination folder. 


### Cluster {#Cluster4}

Field | Description
--- | ---
id | **string**<br>ID of the Elasticsearch cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Elasticsearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Elasticsearch cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Elasticsearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Elasticsearch cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Elasticsearch cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Description of monitoring systems relevant to the Elasticsearch cluster. 
config | **[ClusterConfig](#ClusterConfig4)**<br>Configuration of the Elasticsearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation4)**<br>Maintenance operation planned at nearest maintenance_window. 


### Monitoring {#Monitoring4}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Elasticsearch cluster. 


### ClusterConfig {#ClusterConfig4}

Field | Description
--- | ---
version | **string**<br>Elasticsearch version. 
elasticsearch | **[Elasticsearch](#Elasticsearch4)**<br>Configuration and resource allocation for Elasticsearch nodes. 
edition | **string**<br>ElasticSearch edition. 


### Elasticsearch {#Elasticsearch4}

Field | Description
--- | ---
data_node | **[DataNode](#DataNode6)**<br>Configuration and resource allocation for Elasticsearch data nodes. 
master_node | **[MasterNode](#MasterNode6)**<br>Configuration and resource allocation for Elasticsearch master nodes. 
plugins[] | **string**<br>Cluster wide plugins 


### DataNode {#DataNode6}

Field | Description
--- | ---
config | **oneof:** `elasticsearch_config_set_7`<br>
&nbsp;&nbsp;elasticsearch_config_set_7 | **[config.ElasticsearchConfigSet7](#ElasticsearchConfigSet7)**<br>Elasticsearch 7.x data node configuration. 
resources | **[Resources](#Resources4)**<br>Resources allocated to Elasticsearch data nodes. 


### MasterNode {#MasterNode6}

Field | Description
--- | ---
resources | **[Resources](#Resources4)**<br>Resources allocated to Elasticsearch master nodes. 


### Resources {#Resources4}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-elasticsearch/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. All available types are listed in the [documentation](/docs/managed-elasticsearch/concepts/storage). 


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
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation4}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Start {#Start}

Starts the specified Elasticsearch cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Elasticsearch cluster to start. <br>To get the Elasticsearch cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation4}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster5)>**<br>if operation finished successfully. 


### StartClusterMetadata {#StartClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Elasticsearch cluster. 


### Cluster {#Cluster5}

Field | Description
--- | ---
id | **string**<br>ID of the Elasticsearch cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Elasticsearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Elasticsearch cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Elasticsearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Elasticsearch cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Elasticsearch cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Description of monitoring systems relevant to the Elasticsearch cluster. 
config | **[ClusterConfig](#ClusterConfig5)**<br>Configuration of the Elasticsearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow5)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation5)**<br>Maintenance operation planned at nearest maintenance_window. 


### Monitoring {#Monitoring5}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Elasticsearch cluster. 


### ClusterConfig {#ClusterConfig5}

Field | Description
--- | ---
version | **string**<br>Elasticsearch version. 
elasticsearch | **[Elasticsearch](#Elasticsearch5)**<br>Configuration and resource allocation for Elasticsearch nodes. 
edition | **string**<br>ElasticSearch edition. 


### Elasticsearch {#Elasticsearch5}

Field | Description
--- | ---
data_node | **[DataNode](#DataNode7)**<br>Configuration and resource allocation for Elasticsearch data nodes. 
master_node | **[MasterNode](#MasterNode7)**<br>Configuration and resource allocation for Elasticsearch master nodes. 
plugins[] | **string**<br>Cluster wide plugins 


### DataNode {#DataNode7}

Field | Description
--- | ---
config | **oneof:** `elasticsearch_config_set_7`<br>
&nbsp;&nbsp;elasticsearch_config_set_7 | **[config.ElasticsearchConfigSet7](#ElasticsearchConfigSet7)**<br>Elasticsearch 7.x data node configuration. 
resources | **[Resources](#Resources5)**<br>Resources allocated to Elasticsearch data nodes. 


### MasterNode {#MasterNode7}

Field | Description
--- | ---
resources | **[Resources](#Resources5)**<br>Resources allocated to Elasticsearch master nodes. 


### Resources {#Resources5}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-elasticsearch/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. All available types are listed in the [documentation](/docs/managed-elasticsearch/concepts/storage). 


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
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation5}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Stop {#Stop}

Stops the specified Elasticsearch cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Elasticsearch cluster to stop. <br>To get the Elasticsearch cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation5}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster6)>**<br>if operation finished successfully. 


### StopClusterMetadata {#StopClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Elasticsearch cluster. 


### Cluster {#Cluster6}

Field | Description
--- | ---
id | **string**<br>ID of the Elasticsearch cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Elasticsearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Elasticsearch cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Elasticsearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Elasticsearch cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Elasticsearch cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring6)**<br>Description of monitoring systems relevant to the Elasticsearch cluster. 
config | **[ClusterConfig](#ClusterConfig6)**<br>Configuration of the Elasticsearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow6)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation6)**<br>Maintenance operation planned at nearest maintenance_window. 


### Monitoring {#Monitoring6}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Elasticsearch cluster. 


### ClusterConfig {#ClusterConfig6}

Field | Description
--- | ---
version | **string**<br>Elasticsearch version. 
elasticsearch | **[Elasticsearch](#Elasticsearch6)**<br>Configuration and resource allocation for Elasticsearch nodes. 
edition | **string**<br>ElasticSearch edition. 


### Elasticsearch {#Elasticsearch6}

Field | Description
--- | ---
data_node | **[DataNode](#DataNode8)**<br>Configuration and resource allocation for Elasticsearch data nodes. 
master_node | **[MasterNode](#MasterNode8)**<br>Configuration and resource allocation for Elasticsearch master nodes. 
plugins[] | **string**<br>Cluster wide plugins 


### DataNode {#DataNode8}

Field | Description
--- | ---
config | **oneof:** `elasticsearch_config_set_7`<br>
&nbsp;&nbsp;elasticsearch_config_set_7 | **[config.ElasticsearchConfigSet7](#ElasticsearchConfigSet7)**<br>Elasticsearch 7.x data node configuration. 
resources | **[Resources](#Resources6)**<br>Resources allocated to Elasticsearch data nodes. 


### MasterNode {#MasterNode8}

Field | Description
--- | ---
resources | **[Resources](#Resources6)**<br>Resources allocated to Elasticsearch master nodes. 


### Resources {#Resources6}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-elasticsearch/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. All available types are listed in the [documentation](/docs/managed-elasticsearch/concepts/storage). 


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
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation6}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Backup {#Backup}

Create a backup for the specified ElasticSearch cluster.

**rpc Backup ([BackupClusterRequest](#BackupClusterRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupClusterMetadata](#BackupClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster7)<br>

### BackupClusterRequest {#BackupClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the ElasticSearch cluster to back up. The maximum string length in characters is 50.


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
cluster_id | **string**<br>ID of the ElasticSearch cluster. 


### Cluster {#Cluster7}

Field | Description
--- | ---
id | **string**<br>ID of the Elasticsearch cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Elasticsearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Elasticsearch cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Elasticsearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Elasticsearch cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Elasticsearch cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring7)**<br>Description of monitoring systems relevant to the Elasticsearch cluster. 
config | **[ClusterConfig](#ClusterConfig7)**<br>Configuration of the Elasticsearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow7)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation7)**<br>Maintenance operation planned at nearest maintenance_window. 


### Monitoring {#Monitoring7}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Elasticsearch cluster. 


### ClusterConfig {#ClusterConfig7}

Field | Description
--- | ---
version | **string**<br>Elasticsearch version. 
elasticsearch | **[Elasticsearch](#Elasticsearch7)**<br>Configuration and resource allocation for Elasticsearch nodes. 
edition | **string**<br>ElasticSearch edition. 


### Elasticsearch {#Elasticsearch7}

Field | Description
--- | ---
data_node | **[DataNode](#DataNode9)**<br>Configuration and resource allocation for Elasticsearch data nodes. 
master_node | **[MasterNode](#MasterNode9)**<br>Configuration and resource allocation for Elasticsearch master nodes. 
plugins[] | **string**<br>Cluster wide plugins 


### DataNode {#DataNode9}

Field | Description
--- | ---
config | **oneof:** `elasticsearch_config_set_7`<br>
&nbsp;&nbsp;elasticsearch_config_set_7 | **[config.ElasticsearchConfigSet7](#ElasticsearchConfigSet7)**<br>Elasticsearch 7.x data node configuration. 
resources | **[Resources](#Resources7)**<br>Resources allocated to Elasticsearch data nodes. 


### MasterNode {#MasterNode9}

Field | Description
--- | ---
resources | **[Resources](#Resources7)**<br>Resources allocated to Elasticsearch master nodes. 


### Resources {#Resources7}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-elasticsearch/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. All available types are listed in the [documentation](/docs/managed-elasticsearch/concepts/storage). 


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
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation7}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## ListBackups {#ListBackups}

Returns the list of available backups for the specified Elasticsearch cluster.

**rpc ListBackups ([ListClusterBackupsRequest](#ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#ListClusterBackupsResponse))**

### ListClusterBackupsRequest {#ListClusterBackupsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the Elasticsearch cluster. The maximum string length in characters is 50.
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
source_cluster_id | **string**<br>ID of the associated Elasticsearch cluster. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the backup operation was started. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the backup was created (i.e. when the backup operation completed). 
indices[] | **string**<br>Indices names. (max 100) The maximum number of elements is 100.
elasticsearch_version | **string**<br>Elasticsearch version used to create the snapshot 
size_bytes | **int64**<br>Total size of all indices in backup. in bytes 
indices_total | **int64**<br>Total count of indices in backup 


## Restore {#Restore}

Creates a new ElasticSearch cluster from the specified backup.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster8)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. Required. ID of the backup to restore from. 
name | **string**<br>Required. Name of the ElasticSearch cluster. The name must be unique within the folder. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the ElasticSearch cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Custom labels for the ElasticSearch cluster as `` key:value `` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster8)**<br>Deployment environment of the ElasticSearch cluster. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Required. Configuration and resources for hosts that should be created for the ElasticSearch cluster. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Required. Configuration of ElasticSearch hosts. The number of elements must be greater than 0.
network_id | **string**<br>Required. ID of the network to create the cluster in. The maximum string length in characters is 50.
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
folder_id | **string**<br>Required. ID of the folder to create the ElasticSearch cluster in. The maximum string length in characters is 50.
extension_specs[] | **[ExtensionSpec](#ExtensionSpec1)**<br> 


### ConfigSpec {#ConfigSpec1}

Field | Description
--- | ---
version | **string**<br>Elasticsearch version. 
elasticsearch_spec | **[ElasticsearchSpec](#ElasticsearchSpec)**<br>Configuration and resource allocation for Elasticsearch nodes. 
edition | **string**<br>ElasticSearch edition. 
admin_password | **string**<br>Required. ElasticSearch admin password. 


### ElasticsearchSpec {#ElasticsearchSpec2}

Field | Description
--- | ---
data_node | **[DataNode](#DataNode10)**<br>Configuration and resource allocation for Elasticsearch data nodes. 
master_node | **[MasterNode](#MasterNode10)**<br>Configuration and resource allocation for Elasticsearch master nodes. 
plugins[] | **string**<br>Cluster wide plugins The maximum string length in characters for each value is 50.


### DataNode {#DataNode10}

Field | Description
--- | ---
config | **oneof:** `elasticsearch_config_7`<br>Elasticsearch data node configuration.
&nbsp;&nbsp;elasticsearch_config_7 | **[config.ElasticsearchConfig7](#ElasticsearchConfig7)**<br>Elasticsearch data node configuration. 
resources | **[Resources](#Resources8)**<br>Resources allocated to Elasticsearch data nodes. 


### MasterNode {#MasterNode10}

Field | Description
--- | ---
resources | **[Resources](#Resources8)**<br>Resources allocated to Elasticsearch master nodes. 


### Resources {#Resources8}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-elasticsearch/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. All available types are listed in the [documentation](/docs/managed-elasticsearch/concepts/storage). 


### HostSpec {#HostSpec1}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the host resides in. The maximum string length in characters is 50.
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the host. <br>If the value is `true`, then this host is available on the Internet via it's public IP address. 
type | **[Host.Type](#Host)**<br>Required. Host type. 
shard_name | **string**<br>The shard name to create on the host. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### ExtensionSpec {#ExtensionSpec1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the extension. The maximum string length in characters is 50.
uri | **string**<br>URI of the zip archive to create the new extension from. Currently only supports links that are stored in Object Storage. 
disabled | **bool**<br>The flag shows whether to create the extension in disabled state. 


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
cluster_id | **string**<br>Required. ID of the new ElasticSearch cluster. 
backup_id | **string**<br>Required. ID of the backup used for recovery. 


### Cluster {#Cluster8}

Field | Description
--- | ---
id | **string**<br>ID of the Elasticsearch cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Elasticsearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Elasticsearch cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Elasticsearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Elasticsearch cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Elasticsearch cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring8)**<br>Description of monitoring systems relevant to the Elasticsearch cluster. 
config | **[ClusterConfig](#ClusterConfig8)**<br>Configuration of the Elasticsearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow8)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation8)**<br>Maintenance operation planned at nearest maintenance_window. 


### Monitoring {#Monitoring8}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Elasticsearch cluster. 


### ClusterConfig {#ClusterConfig8}

Field | Description
--- | ---
version | **string**<br>Elasticsearch version. 
elasticsearch | **[Elasticsearch](#Elasticsearch8)**<br>Configuration and resource allocation for Elasticsearch nodes. 
edition | **string**<br>ElasticSearch edition. 


### Elasticsearch {#Elasticsearch8}

Field | Description
--- | ---
data_node | **[DataNode](#DataNode11)**<br>Configuration and resource allocation for Elasticsearch data nodes. 
master_node | **[MasterNode](#MasterNode11)**<br>Configuration and resource allocation for Elasticsearch master nodes. 
plugins[] | **string**<br>Cluster wide plugins 


### DataNode {#DataNode11}

Field | Description
--- | ---
config | **oneof:** `elasticsearch_config_set_7`<br>
&nbsp;&nbsp;elasticsearch_config_set_7 | **[config.ElasticsearchConfigSet7](#ElasticsearchConfigSet7)**<br>Elasticsearch 7.x data node configuration. 
resources | **[Resources](#Resources9)**<br>Resources allocated to Elasticsearch data nodes. 


### MasterNode {#MasterNode11}

Field | Description
--- | ---
resources | **[Resources](#Resources9)**<br>Resources allocated to Elasticsearch master nodes. 


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
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation8}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## ListLogs {#ListLogs}

Retrieves logs for the specified Elasticsearch cluster. <br>For more information about logs, see the [Logs](/docs/managed-elasticsearch/operations/cluster-logs) section in the documentation.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Elasticsearch cluster to request logs for. <br>To get the Elasticsearch cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from the logs table to request. <br>If no columns are specified, full log records are returned. 
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request. 
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) returned by the previous list request. The maximum string length in characters is 100.
always_next_page_token | **bool**<br>The flag that defines behavior of providing the next page token. <br>If this flag is set to `true`, this API method will always return [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse), even if current page is empty. 
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name to filter by. Currently filtering can be applied to the `hostname` field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-z0-9.-]{1,61}`. </li></ol><br>Example of a filter: `message.hostname='node1.db.cloud.yandex.net'` The maximum string length in characters is 1000.
service_type | enum **ServiceType**<br>Type of the service to request logs about. 


### ListClusterLogsResponse {#ListClusterLogsResponse}

Field | Description
--- | ---
logs[] | **[LogRecord](#LogRecord)**<br>Requested log records. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterLogsRequest.page_size](#ListClusterLogsRequest), use `next_page_token` as the value for the [ListClusterLogsRequest.page_token](#ListClusterLogsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. <br>This value is interchangeable with [StreamLogRecord.next_record_token](#StreamLogRecord) from StreamLogs method. 


### LogRecord {#LogRecord}

Field | Description
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log record timestamp. 
message | **map<string,string>**<br>Contents of the log record. 


## StreamLogs {#StreamLogs}

Same as [ListLogs](#ListLogs) but using server-side streaming. Also supports `tail -f` semantics.

**rpc StreamLogs ([StreamClusterLogsRequest](#StreamClusterLogsRequest)) returns (stream [StreamLogRecord](#StreamLogRecord))**

### StreamClusterLogsRequest {#StreamClusterLogsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Elasticsearch cluster. <br>To get the Elasticsearch cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
column_filter[] | **string**<br>Columns from logs table to get in the response. <br>If no columns are specified, full log records are returned. 
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start timestamp for the logs request. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End timestamp for the logs request. <br>If this field is not set, all existing logs will be sent and then the new ones asthey appear. In essence it has `tail -f` semantics. 
record_token | **string**<br>Record token. <br>Set `record_token` to the [StreamLogRecord.next_record_token](#StreamLogRecord) returned by a previous [ClusterService.StreamLogs](#StreamLogs) request to start streaming from next log record. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name to filter by. Currently filtering can be applied to the `hostname` field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol><br>Example of a filter: `message.hostname='node1.db.cloud.yandex.net'` The maximum string length in characters is 1000.
service_type | enum **ServiceType**<br>Type of the service to request logs about. 


### StreamLogRecord {#StreamLogRecord}

Field | Description
--- | ---
record | **[LogRecord](#LogRecord)**<br>One of the requested log records. 
next_record_token | **string**<br>This token allows you to continue streaming logs starting from the exact same record. <br>To continue streaming, specify value of `next_record_token` as value for [StreamClusterLogsRequest.record_token](#StreamClusterLogsRequest) parameter in the next StreamLogs request. <br>This value is interchangeable with [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) from ListLogs method. 


### LogRecord {#LogRecord1}

Field | Description
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log record timestamp. 
message | **map<string,string>**<br>Contents of the log record. 


## ListOperations {#ListOperations}

Retrieves the list of operations for the specified Elasticsearch cluster.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Elasticsearch cluster to list operations for. <br>To get the Elasticsearch cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation8)**<br>List of operations for the specified Elasticsearch cluster. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest), use the `next_page_token` as the value for the [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation8}

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

Retrieves a list of hosts for the specified Elasticsearch cluster.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Elasticsearch cluster. <br>To get the Elasticsearch cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](#Host)**<br>List of hosts. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
name | **string**<br>Name of the host. 
cluster_id | **string**<br>ID of the Elasticsearch cluster. 
zone_id | **string**<br>ID of the availability zone where the host resides. 
type | enum **Type**<br>Host type. <ul><li>`DATA_NODE`: the host is an Elasticsearch data node.</li><li>`MASTER_NODE`: the host is an Elasticsearch master node.</li></ul>
resources | **[Resources](#Resources9)**<br> 
health | enum **Health**<br>Aggregated host health data. <ul><li>`UNKNOWN`: health of the host is unknown.</li><li>`ALIVE`: the host is performing all its functions normally.</li><li>`DEAD`: the host is inoperable and cannot perform any of its essential functions.</li><li>`DEGRADED`: the host is degraded and can perform only some of its essential functions.</li></ul>
services[] | **[Service](#Service)**<br>Services provided by the host. 
subnet_id | **string**<br>ID of the subnet the host resides in. 
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the host. <br>If the value is `true`, then this host is available on the Internet via it's public IP address. 


### Resources {#Resources9}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-elasticsearch/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. All available types are listed in the [documentation](/docs/managed-elasticsearch/concepts/storage). 


### Service {#Service}

Field | Description
--- | ---
type | enum **Type**<br>Type of the service provided by the host. <ul><li>`ELASTICSEARCH`: the Elasticsearch service.</li></ul>
health | enum **Health**<br>Service health data. <ul><li>`UNKNOWN`: health of the service is unknown.</li><li>`ALIVE`: the service is working normally.</li><li>`DEAD`: the service is dead or unresponsive.</li></ul>


## AddHosts {#AddHosts}

Adds new hosts to the specified Elasticsearch cluster.

**rpc AddHosts ([AddClusterHostsRequest](#AddClusterHostsRequest)) returns ([operation.Operation](#Operation9))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterHostsMetadata](#AddClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddClusterHostsRequest {#AddClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Elasticsearch cluster. <br>To get the Elasticsearch cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
host_specs[] | **[HostSpec](#HostSpec)**<br>One or more configurations of hosts to be added to the Elasticsearch cluster. The number of elements must be greater than 0.


### HostSpec {#HostSpec2}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the host resides. The maximum string length in characters is 50.
subnet_id | **string**<br>ID of the subnet the host resides in. The maximum string length in characters is 50.
assign_public_ip | **bool**<br>The flag that defines whether a public IP address is assigned to the host. <br>If the value is `true`, then this host is available on the Internet via it's public IP address. 
type | **[Host.Type](#Host1)**<br>Required. Host type. 
shard_name | **string**<br>The shard name to create on the host. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation9}

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
cluster_id | **string**<br>ID of the Elasticsearch cluster. 
host_names[] | **string**<br>Names of the host that are being added. 


## DeleteHosts {#DeleteHosts}

Deletes specified hosts from the specified Elasticsearch cluster.

**rpc DeleteHosts ([DeleteClusterHostsRequest](#DeleteClusterHostsRequest)) returns ([operation.Operation](#Operation10))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterHostsMetadata](#DeleteClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterHostsRequest {#DeleteClusterHostsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Elasticsearch cluster. <br>To get the Elasticsearch cluster ID, make a [ClusterService.List](#List) request. The maximum string length in characters is 50.
host_names[] | **string**<br>Names of the hosts to delete. The number of elements must be greater than 0. The maximum string length in characters for each value is 253.


### Operation {#Operation10}

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
cluster_id | **string**<br>ID of the Elasticsearch cluster. 
host_names[] | **string**<br>Names of the hosts that are being deleted. 


## RescheduleMaintenance {#RescheduleMaintenance}

Reschedule planned maintenance operation.

**rpc RescheduleMaintenance ([RescheduleMaintenanceRequest](#RescheduleMaintenanceRequest)) returns ([operation.Operation](#Operation11))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RescheduleMaintenanceMetadata](#RescheduleMaintenanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster9)<br>

### RescheduleMaintenanceRequest {#RescheduleMaintenanceRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the Elasticsearch cluster to maintenance reschedule. The maximum string length in characters is 50.
reschedule_type | enum **RescheduleType**<br>Required. Required. The type of reschedule request. 
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time for SPECIFIC_TIME reschedule. Limited by two weeks since first time scheduled. 


### Operation {#Operation11}

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
cluster_id | **string**<br>Required. ID of the Elasticsearch cluster. 
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. New time of the planned maintenance. Can be in the past for rescheduled to "IMMEDIATE". 


### Cluster {#Cluster9}

Field | Description
--- | ---
id | **string**<br>ID of the Elasticsearch cluster. This ID is assigned at creation time. 
folder_id | **string**<br>ID of the folder that the Elasticsearch cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Elasticsearch cluster. The name must be unique within the folder. 1-63 characters long. 
description | **string**<br>Description of the Elasticsearch cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Custom labels for the Elasticsearch cluster as `key:value` pairs. A maximum of 64 labels per resource is allowed. 
environment | enum **Environment**<br>Deployment environment of the Elasticsearch cluster. <ul><li>`PRODUCTION`: stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.</li><li>`PRESTABLE`: environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility.</li></ul>
monitoring[] | **[Monitoring](#Monitoring9)**<br>Description of monitoring systems relevant to the Elasticsearch cluster. 
config | **[ClusterConfig](#ClusterConfig9)**<br>Configuration of the Elasticsearch cluster. 
network_id | **string**<br>ID of the network that the cluster belongs to. 
health | enum **Health**<br>Aggregated cluster health. <ul><li>`HEALTH_UNKNOWN`: state of the cluster is unknown ([Host.health](#Host1) of all hosts in the cluster is `UNKNOWN`).</li><li>`ALIVE`: cluster is alive and well ([Host.health](#Host1) of all hosts in the cluster is `ALIVE`).</li><li>`DEAD`: cluster is inoperable ([Host.health](#Host1) of all hosts in the cluster is `DEAD`).</li><li>`DEGRADED`: cluster is in degraded state ([Host.health](#Host1) of at least one of the hosts in the cluster is not `ALIVE`).</li></ul>
status | enum **Status**<br>Current state of the cluster. <ul><li>`STATUS_UNKNOWN`: cluster state is unknown.</li><li>`CREATING`: cluster is being created.</li><li>`RUNNING`: cluster is running normally.</li><li>`ERROR`: cluster encountered a problem and cannot operate.</li><li>`UPDATING`: cluster is being updated.</li><li>`STOPPING`: cluster is stopping.</li><li>`STOPPED`: cluster stopped.</li><li>`STARTING`: cluster is starting.</li></ul>
security_group_ids[] | **string**<br>User security groups 
service_account_id | **string**<br>ID of the service account used for access to Object Storage. 
deletion_protection | **bool**<br>Deletion Protection inhibits deletion of the cluster 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow9)**<br>Window of maintenance operations. 
planned_operation | **[MaintenanceOperation](#MaintenanceOperation9)**<br>Maintenance operation planned at nearest maintenance_window. 


### Monitoring {#Monitoring9}

Field | Description
--- | ---
name | **string**<br>Name of the monitoring system. 
description | **string**<br>Description of the monitoring system. 
link | **string**<br>Link to the monitoring system charts for the Elasticsearch cluster. 


### ClusterConfig {#ClusterConfig9}

Field | Description
--- | ---
version | **string**<br>Elasticsearch version. 
elasticsearch | **[Elasticsearch](#Elasticsearch9)**<br>Configuration and resource allocation for Elasticsearch nodes. 
edition | **string**<br>ElasticSearch edition. 


### Elasticsearch {#Elasticsearch9}

Field | Description
--- | ---
data_node | **[DataNode](#DataNode12)**<br>Configuration and resource allocation for Elasticsearch data nodes. 
master_node | **[MasterNode](#MasterNode12)**<br>Configuration and resource allocation for Elasticsearch master nodes. 
plugins[] | **string**<br>Cluster wide plugins 


### DataNode {#DataNode12}

Field | Description
--- | ---
config | **oneof:** `elasticsearch_config_set_7`<br>
&nbsp;&nbsp;elasticsearch_config_set_7 | **[config.ElasticsearchConfigSet7](#ElasticsearchConfigSet7)**<br>Elasticsearch 7.x data node configuration. 
resources | **[Resources](#Resources10)**<br>Resources allocated to Elasticsearch data nodes. 


### MasterNode {#MasterNode12}

Field | Description
--- | ---
resources | **[Resources](#Resources10)**<br>Resources allocated to Elasticsearch master nodes. 


### Resources {#Resources10}

Field | Description
--- | ---
resource_preset_id | **string**<br>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the [documentation](/docs/managed-elasticsearch/concepts/instance-types). 
disk_size | **int64**<br>Volume of the storage available to a host, in bytes. 
disk_type_id | **string**<br>Type of the storage environment for the host. All available types are listed in the [documentation](/docs/managed-elasticsearch/concepts/storage). 


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
hour | **int64**<br>Hour of the day in UTC. Acceptable values are 1 to 24, inclusive.


### MaintenanceOperation {#MaintenanceOperation9}

Field | Description
--- | ---
info | **string**<br> The maximum string length in characters is 256.
delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


