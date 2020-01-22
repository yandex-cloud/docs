---
editable: false
---

# ClusterService

A set of methods for managing Kubernetes cluster.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Kubernetes cluster. |
| [List](#List) | Retrieves the list of Kubernetes cluster in the specified folder. |
| [Create](#Create) | Creates a Kubernetes cluster in the specified folder. |
| [Update](#Update) | Updates the specified Kubernetes cluster. |
| [Delete](#Delete) | Deletes the specified Kubernetes cluster. |
| [Stop](#Stop) |  |
| [Start](#Start) |  |
| [ListNodeGroups](#ListNodeGroups) | Lists nodegroup for the specified Kubernetes cluster. |
| [ListOperations](#ListOperations) | Lists operations for the specified Kubernetes cluster. |

## Calls ClusterService {#calls}

## Get {#Get}

Returns the specified Kubernetes cluster. <br>To get the list of available Kubernetes cluster, make a [List](#List) request.

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Kubernetes cluster to return. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the Kubernetes cluster. 
folder_id | **string**<br>ID of the folder that the Kubernetes cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Kubernetes cluster. 
description | **string**<br>Description of the Kubernetes cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Мaximum of 64 per resource. 
status | enum **Status**<br>Status of the Kubernetes cluster. <ul><li>`PROVISIONING`: Kubernetes cluster is waiting for resources to be allocated.</li><li>`RUNNING`: Kubernetes cluster is running.</li><li>`RECONCILING`: Kubernetes cluster is being reconciled.</li><li>`STOPPING`: Kubernetes cluster is being stopped.</li><li>`STOPPED`: Kubernetes cluster stopped.</li><li>`DELETING`: Kubernetes cluster is being deleted.</li><li>`STARTING`: Kubernetes cluster is being started.</li><ul/>
health | enum **Health**<br>Health of the Kubernetes cluster. <ul><li>`HEALTHY`: Kubernetes cluster is alive and well.</li><li>`UNHEALTHY`: Kubernetes cluster is inoperable.</li><ul/>
network_id | **string**<br>ID of the network the Kubernetes cluster belongs to. 
master | **[Master](#Master)**<br>Properties of the master for the Kubernetes cluster. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy)**<br>Allocation policy for IP addresses of services and pods inside the Kubernetes cluster in different availability zones. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Gateway IPv4 address. The maximum string length in characters is 15.
service_account_id | **string**<br>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. 
node_service_account_id | **string**<br>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. 
release_channel | enum **ReleaseChannel**<br> <ul><ul/>


### Master {#Master}

Field | Description
--- | ---
master_type | **oneof:** `zonal_master` or `regional_master`<br>
&nbsp;&nbsp;zonal_master | **[ZonalMaster](#ZonalMaster)**<br>Parameters of the availability zone for the master. 
&nbsp;&nbsp;regional_master | **[RegionalMaster](#RegionalMaster)**<br>Parameters of the region for the master. 
version | **string**<br>Version of Kubernetes components that runs on the master. 
endpoints | **[MasterEndpoints](#MasterEndpoints)**<br>Endpoints of the master. Endpoints constitute of scheme and port (i.e. `https://ip-address:port`) and can be used by the clients to communicate with the Kubernetes API of the Kubernetes cluster. 
master_auth | **[MasterAuth](#MasterAuth)**<br>Master authentication parameters are used to establish trust between the master and a client. 
version_info | **[VersionInfo](#VersionInfo)**<br> 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy)**<br> 


### ZonalMaster {#ZonalMaster}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the master resides. 
internal_v4_address | **string**<br>An IPv4 internal network address that is assigned to the master. 
external_v4_address | **string**<br>An IPv4 external network address that is assigned to the master. 


### RegionalMaster {#RegionalMaster}

Field | Description
--- | ---
region_id | **string**<br>ID of the region where the master resides. 
internal_v4_address | **string**<br>An IPv4 internal network address that is assigned to the master. 
external_v4_address | **string**<br>An IPv4 external network address that is assigned to the master. 


### MasterEndpoints {#MasterEndpoints}

Field | Description
--- | ---
internal_v4_endpoint | **string**<br>Internal endpoint that can be used to connect to the master from cloud networks. 
external_v4_endpoint | **string**<br>External endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud). 


### MasterAuth {#MasterAuth}

Field | Description
--- | ---
cluster_ca_certificate | **string**<br>PEM-encoded public certificate that is the root of trust for the Kubernetes cluster. 


### VersionInfo {#VersionInfo}

Field | Description
--- | ---
current_version | **string**<br>Current kubernetes version, major.minor (e.g. 1.15). 
new_revision_available | **bool**<br>Newer revisions may include kubernetes patches (e.g 1.15.1 -> 1.15.2) as well as some internal component updates - new features or bug fixes in yandex-specific components either on the master or nodes. 
new_revision_summary | **string**<br>Human readable description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false. 
version_deprecated | **bool**<br>The current version is on the deprecation schedule, component (master or node group) should be upgraded. 


### MasterMaintenancePolicy {#MasterMaintenancePolicy}

Field | Description
--- | ---
auto_upgrade | **bool**<br> 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow)**<br> 


### MaintenanceWindow {#MaintenanceWindow}

Field | Description
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow)**<br> 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}



### DailyMaintenanceWindow {#DailyMaintenanceWindow}

Field | Description
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> Acceptable values are 1h to 24h, inclusive.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> Acceptable values are 1h to 24h, inclusive.


### IPAllocationPolicy {#IPAllocationPolicy}

Field | Description
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR block. IP range for allocating pod addresses. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets. 
service_ipv4_cidr_block | **string**<br>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. 


## List {#List}

Retrieves the list of Kubernetes cluster in the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list Kubernetes cluster in. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently you can use filtering only on [Cluster.name](#Cluster1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 1-61 characters long and match the regular expression `|[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of Kubernetes cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest1), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the Kubernetes cluster. 
folder_id | **string**<br>ID of the folder that the Kubernetes cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Kubernetes cluster. 
description | **string**<br>Description of the Kubernetes cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Мaximum of 64 per resource. 
status | enum **Status**<br>Status of the Kubernetes cluster. <ul><li>`PROVISIONING`: Kubernetes cluster is waiting for resources to be allocated.</li><li>`RUNNING`: Kubernetes cluster is running.</li><li>`RECONCILING`: Kubernetes cluster is being reconciled.</li><li>`STOPPING`: Kubernetes cluster is being stopped.</li><li>`STOPPED`: Kubernetes cluster stopped.</li><li>`DELETING`: Kubernetes cluster is being deleted.</li><li>`STARTING`: Kubernetes cluster is being started.</li><ul/>
health | enum **Health**<br>Health of the Kubernetes cluster. <ul><li>`HEALTHY`: Kubernetes cluster is alive and well.</li><li>`UNHEALTHY`: Kubernetes cluster is inoperable.</li><ul/>
network_id | **string**<br>ID of the network the Kubernetes cluster belongs to. 
master | **[Master](#Master1)**<br>Properties of the master for the Kubernetes cluster. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy1)**<br>Allocation policy for IP addresses of services and pods inside the Kubernetes cluster in different availability zones. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Gateway IPv4 address. The maximum string length in characters is 15.
service_account_id | **string**<br>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. 
node_service_account_id | **string**<br>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. 
release_channel | enum **ReleaseChannel**<br> <ul><ul/>


### Master {#Master}

Field | Description
--- | ---
master_type | **oneof:** `zonal_master` or `regional_master`<br>
&nbsp;&nbsp;zonal_master | **[ZonalMaster](#ZonalMaster1)**<br>Parameters of the availability zone for the master. 
&nbsp;&nbsp;regional_master | **[RegionalMaster](#RegionalMaster1)**<br>Parameters of the region for the master. 
version | **string**<br>Version of Kubernetes components that runs on the master. 
endpoints | **[MasterEndpoints](#MasterEndpoints1)**<br>Endpoints of the master. Endpoints constitute of scheme and port (i.e. `https://ip-address:port`) and can be used by the clients to communicate with the Kubernetes API of the Kubernetes cluster. 
master_auth | **[MasterAuth](#MasterAuth1)**<br>Master authentication parameters are used to establish trust between the master and a client. 
version_info | **[VersionInfo](#VersionInfo1)**<br> 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy1)**<br> 


### ZonalMaster {#ZonalMaster}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the master resides. 
internal_v4_address | **string**<br>An IPv4 internal network address that is assigned to the master. 
external_v4_address | **string**<br>An IPv4 external network address that is assigned to the master. 


### RegionalMaster {#RegionalMaster}

Field | Description
--- | ---
region_id | **string**<br>ID of the region where the master resides. 
internal_v4_address | **string**<br>An IPv4 internal network address that is assigned to the master. 
external_v4_address | **string**<br>An IPv4 external network address that is assigned to the master. 


### MasterEndpoints {#MasterEndpoints}

Field | Description
--- | ---
internal_v4_endpoint | **string**<br>Internal endpoint that can be used to connect to the master from cloud networks. 
external_v4_endpoint | **string**<br>External endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud). 


### MasterAuth {#MasterAuth}

Field | Description
--- | ---
cluster_ca_certificate | **string**<br>PEM-encoded public certificate that is the root of trust for the Kubernetes cluster. 


### VersionInfo {#VersionInfo}

Field | Description
--- | ---
current_version | **string**<br>Current kubernetes version, major.minor (e.g. 1.15). 
new_revision_available | **bool**<br>Newer revisions may include kubernetes patches (e.g 1.15.1 -> 1.15.2) as well as some internal component updates - new features or bug fixes in yandex-specific components either on the master or nodes. 
new_revision_summary | **string**<br>Human readable description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false. 
version_deprecated | **bool**<br>The current version is on the deprecation schedule, component (master or node group) should be upgraded. 


### MasterMaintenancePolicy {#MasterMaintenancePolicy}

Field | Description
--- | ---
auto_upgrade | **bool**<br> 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow1)**<br> 


### MaintenanceWindow {#MaintenanceWindow}

Field | Description
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow1)**<br> 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow1)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow1)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}



### DailyMaintenanceWindow {#DailyMaintenanceWindow}

Field | Description
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> Acceptable values are 1h to 24h, inclusive.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow1)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> Acceptable values are 1h to 24h, inclusive.


### IPAllocationPolicy {#IPAllocationPolicy}

Field | Description
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR block. IP range for allocating pod addresses. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets. 
service_ipv4_cidr_block | **string**<br>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. 


## Create {#Create}

Creates a Kubernetes cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a Kubernetes cluster in. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. 
name | **string**<br>Name of the Kubernetes cluster. The name must be unique within the folder. Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the Kubernetes cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
network_id | **string**<br>Required. ID of the network. 
master_spec | **[MasterSpec](#MasterSpec)**<br>Required. IP allocation policy of the Kubernetes cluster. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy2)**<br>IP allocation policy of the Kubernetes cluster. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Gateway IPv4 address. 
service_account_id | **string**<br>Required. Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. Selected service account should have `edit` role on the folder where the Kubernetes cluster will be located and on the folder where selected network resides. 
node_service_account_id | **string**<br>Required. Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. 
release_channel | enum **ReleaseChannel**<br> <ul><ul/>


### MasterSpec {#MasterSpec}

Field | Description
--- | ---
master_type | **oneof:** `zonal_master_spec` or `regional_master_spec`<br>
&nbsp;&nbsp;zonal_master_spec | **[ZonalMasterSpec](#ZonalMasterSpec)**<br>Specification of the master availability zone. 
&nbsp;&nbsp;regional_master_spec | **[RegionalMasterSpec](#RegionalMasterSpec)**<br> 
version | **string**<br> 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy2)**<br> 


### ZonalMasterSpec {#ZonalMasterSpec}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone. 
internal_v4_address_spec | **[InternalAddressSpec](#InternalAddressSpec)**<br>Specification of parameters for internal IPv4 networking. 
external_v4_address_spec | **[ExternalAddressSpec](#ExternalAddressSpec)**<br>Specification of parameters for external IPv4 networking. 


### InternalAddressSpec {#InternalAddressSpec}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the subnet. If no ID is specified, and there only one subnet in specified zone, an address in this subnet will be allocated. 


### ExternalAddressSpec {#ExternalAddressSpec}



### RegionalMasterSpec {#RegionalMasterSpec}

Field | Description
--- | ---
region_id | **string**<br>Required.  
locations[] | **[MasterLocation](#MasterLocation)**<br> 
external_v4_address_spec | **[ExternalAddressSpec](#ExternalAddressSpec1)**<br>Specify to allocate a static public IP for the master 


### MasterLocation {#MasterLocation}

Field | Description
--- | ---
zone_id | **string**<br>Required.  
internal_v4_address_spec | **[InternalAddressSpec](#InternalAddressSpec1)**<br>If not specified and there is a single subnet in specified zone, address in this subnet will be allocated. 


### InternalAddressSpec {#InternalAddressSpec}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the subnet. If no ID is specified, and there only one subnet in specified zone, an address in this subnet will be allocated. 


### ExternalAddressSpec {#ExternalAddressSpec}



### MasterMaintenancePolicy {#MasterMaintenancePolicy}

Field | Description
--- | ---
auto_upgrade | **bool**<br> 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow2)**<br> 


### MaintenanceWindow {#MaintenanceWindow}

Field | Description
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow2)**<br> 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow2)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow2)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}



### DailyMaintenanceWindow {#DailyMaintenanceWindow}

Field | Description
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> Acceptable values are 1h to 24h, inclusive.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow2)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> Acceptable values are 1h to 24h, inclusive.


### IPAllocationPolicy {#IPAllocationPolicy}

Field | Description
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR block. IP range for allocating pod addresses. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets. 
service_ipv4_cidr_block | **string**<br>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. 


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
cluster_id | **string**<br>ID of the Kubernetes cluster that is being created. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the Kubernetes cluster. 
folder_id | **string**<br>ID of the folder that the Kubernetes cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Kubernetes cluster. 
description | **string**<br>Description of the Kubernetes cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Мaximum of 64 per resource. 
status | enum **Status**<br>Status of the Kubernetes cluster. <ul><li>`PROVISIONING`: Kubernetes cluster is waiting for resources to be allocated.</li><li>`RUNNING`: Kubernetes cluster is running.</li><li>`RECONCILING`: Kubernetes cluster is being reconciled.</li><li>`STOPPING`: Kubernetes cluster is being stopped.</li><li>`STOPPED`: Kubernetes cluster stopped.</li><li>`DELETING`: Kubernetes cluster is being deleted.</li><li>`STARTING`: Kubernetes cluster is being started.</li><ul/>
health | enum **Health**<br>Health of the Kubernetes cluster. <ul><li>`HEALTHY`: Kubernetes cluster is alive and well.</li><li>`UNHEALTHY`: Kubernetes cluster is inoperable.</li><ul/>
network_id | **string**<br>ID of the network the Kubernetes cluster belongs to. 
master | **[Master](#Master2)**<br>Properties of the master for the Kubernetes cluster. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy3)**<br>Allocation policy for IP addresses of services and pods inside the Kubernetes cluster in different availability zones. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Gateway IPv4 address. The maximum string length in characters is 15.
service_account_id | **string**<br>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. 
node_service_account_id | **string**<br>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. 
release_channel | enum **ReleaseChannel**<br> <ul><ul/>


## Update {#Update}

Updates the specified Kubernetes cluster.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Kubernetes cluster to update. To get the Kubernetes cluster ID use a [ClusterService.List](#List) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
name | **string**<br>Name of the Kubernetes cluster. The name must be unique within the folder. Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the Kubernetes cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. <br>Existing set of `labels` is completely replaced by the provided set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br> The maximum string length in characters is 15.
master_spec | **[MasterUpdateSpec](#MasterUpdateSpec)**<br> 
service_account_id | **string**<br>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. Selected service account should have `edit` role on the folder where the Kubernetes cluster will be located and on the folder where selected network resides. 
node_service_account_id | **string**<br>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. 


### MasterUpdateSpec {#MasterUpdateSpec}

Field | Description
--- | ---
version | **[UpdateVersionSpec](#UpdateVersionSpec)**<br> 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy3)**<br> 


### UpdateVersionSpec {#UpdateVersionSpec}

Field | Description
--- | ---
specifier | **oneof:** `version` or `latest_revision`<br>
&nbsp;&nbsp;version | **string**<br>Request update to a newer version of kubernetes (1.x -> 1.y). 
&nbsp;&nbsp;latest_revision | **bool**<br>Request update to the latest revision for the current version. 


### MasterMaintenancePolicy {#MasterMaintenancePolicy}

Field | Description
--- | ---
auto_upgrade | **bool**<br> 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br> 


### MaintenanceWindow {#MaintenanceWindow}

Field | Description
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow3)**<br> 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow3)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow3)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}



### DailyMaintenanceWindow {#DailyMaintenanceWindow}

Field | Description
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> Acceptable values are 1h to 24h, inclusive.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow3)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> Acceptable values are 1h to 24h, inclusive.


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
cluster_id | **string**<br>ID of the Kubernetes cluster that is being updated. 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the Kubernetes cluster. 
folder_id | **string**<br>ID of the folder that the Kubernetes cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Kubernetes cluster. 
description | **string**<br>Description of the Kubernetes cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Мaximum of 64 per resource. 
status | enum **Status**<br>Status of the Kubernetes cluster. <ul><li>`PROVISIONING`: Kubernetes cluster is waiting for resources to be allocated.</li><li>`RUNNING`: Kubernetes cluster is running.</li><li>`RECONCILING`: Kubernetes cluster is being reconciled.</li><li>`STOPPING`: Kubernetes cluster is being stopped.</li><li>`STOPPED`: Kubernetes cluster stopped.</li><li>`DELETING`: Kubernetes cluster is being deleted.</li><li>`STARTING`: Kubernetes cluster is being started.</li><ul/>
health | enum **Health**<br>Health of the Kubernetes cluster. <ul><li>`HEALTHY`: Kubernetes cluster is alive and well.</li><li>`UNHEALTHY`: Kubernetes cluster is inoperable.</li><ul/>
network_id | **string**<br>ID of the network the Kubernetes cluster belongs to. 
master | **[Master](#Master2)**<br>Properties of the master for the Kubernetes cluster. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy3)**<br>Allocation policy for IP addresses of services and pods inside the Kubernetes cluster in different availability zones. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Gateway IPv4 address. The maximum string length in characters is 15.
service_account_id | **string**<br>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. 
node_service_account_id | **string**<br>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. 
release_channel | enum **ReleaseChannel**<br> <ul><ul/>


## Delete {#Delete}

Deletes the specified Kubernetes cluster.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Kubernetes cluster to delete. To get Kubernetes cluster ID use a [ClusterService.List](#List) request. 


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
cluster_id | **string**<br>ID of the Kubernetes cluster that is being deleted. 


## Stop {#Stop}



**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  
service_account_id | **string**<br> 


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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster4)>**<br>if operation finished successfully. 


### StopClusterMetadata {#StopClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br> 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the Kubernetes cluster. 
folder_id | **string**<br>ID of the folder that the Kubernetes cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Kubernetes cluster. 
description | **string**<br>Description of the Kubernetes cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Мaximum of 64 per resource. 
status | enum **Status**<br>Status of the Kubernetes cluster. <ul><li>`PROVISIONING`: Kubernetes cluster is waiting for resources to be allocated.</li><li>`RUNNING`: Kubernetes cluster is running.</li><li>`RECONCILING`: Kubernetes cluster is being reconciled.</li><li>`STOPPING`: Kubernetes cluster is being stopped.</li><li>`STOPPED`: Kubernetes cluster stopped.</li><li>`DELETING`: Kubernetes cluster is being deleted.</li><li>`STARTING`: Kubernetes cluster is being started.</li><ul/>
health | enum **Health**<br>Health of the Kubernetes cluster. <ul><li>`HEALTHY`: Kubernetes cluster is alive and well.</li><li>`UNHEALTHY`: Kubernetes cluster is inoperable.</li><ul/>
network_id | **string**<br>ID of the network the Kubernetes cluster belongs to. 
master | **[Master](#Master2)**<br>Properties of the master for the Kubernetes cluster. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy3)**<br>Allocation policy for IP addresses of services and pods inside the Kubernetes cluster in different availability zones. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Gateway IPv4 address. The maximum string length in characters is 15.
service_account_id | **string**<br>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. 
node_service_account_id | **string**<br>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. 
release_channel | enum **ReleaseChannel**<br> <ul><ul/>


## Start {#Start}



**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  


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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster5)>**<br>if operation finished successfully. 


### StartClusterMetadata {#StartClusterMetadata}

Field | Description
--- | ---
cluster_id | **string**<br> 


### Cluster {#Cluster}

Field | Description
--- | ---
id | **string**<br>ID of the Kubernetes cluster. 
folder_id | **string**<br>ID of the folder that the Kubernetes cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Kubernetes cluster. 
description | **string**<br>Description of the Kubernetes cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Мaximum of 64 per resource. 
status | enum **Status**<br>Status of the Kubernetes cluster. <ul><li>`PROVISIONING`: Kubernetes cluster is waiting for resources to be allocated.</li><li>`RUNNING`: Kubernetes cluster is running.</li><li>`RECONCILING`: Kubernetes cluster is being reconciled.</li><li>`STOPPING`: Kubernetes cluster is being stopped.</li><li>`STOPPED`: Kubernetes cluster stopped.</li><li>`DELETING`: Kubernetes cluster is being deleted.</li><li>`STARTING`: Kubernetes cluster is being started.</li><ul/>
health | enum **Health**<br>Health of the Kubernetes cluster. <ul><li>`HEALTHY`: Kubernetes cluster is alive and well.</li><li>`UNHEALTHY`: Kubernetes cluster is inoperable.</li><ul/>
network_id | **string**<br>ID of the network the Kubernetes cluster belongs to. 
master | **[Master](#Master2)**<br>Properties of the master for the Kubernetes cluster. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy3)**<br>Allocation policy for IP addresses of services and pods inside the Kubernetes cluster in different availability zones. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Gateway IPv4 address. The maximum string length in characters is 15.
service_account_id | **string**<br>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. 
node_service_account_id | **string**<br>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. 
release_channel | enum **ReleaseChannel**<br> <ul><ul/>


## ListNodeGroups {#ListNodeGroups}

Lists nodegroup for the specified Kubernetes cluster.

**rpc ListNodeGroups ([ListClusterNodeGroupsRequest](#ListClusterNodeGroupsRequest)) returns ([ListClusterNodeGroupsResponse](#ListClusterNodeGroupsResponse))**

### ListClusterNodeGroupsRequest {#ListClusterNodeGroupsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Kubernetes cluster to list node groups in. To get the Kubernetes cluster ID use a [ClusterService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterNodeGroupsResponse.next_page_token](#ListClusterNodeGroupsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterNodeGroupsResponse.next_page_token](#ListClusterNodeGroupsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on [Cluster.name](#Cluster6) field. The maximum string length in characters is 1000.


### ListClusterNodeGroupsResponse {#ListClusterNodeGroupsResponse}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup)**<br>List of node groups for the specified Kubernetes cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterNodeGroupsRequest.page_size](#ListClusterNodeGroupsRequest1), use the `next_page_token` as the value for the [ListClusterNodeGroupsRequest.page_token](#ListClusterNodeGroupsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### NodeGroup {#NodeGroup}

Field | Description
--- | ---
id | **string**<br>ID of the node group. 
cluster_id | **string**<br>ID of the cluster that the node group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the node group. The name is unique within the folder. 
description | **string**<br>Description of the node group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Мaximum of 64 per resource. 
status | enum **Status**<br>Status of the node group. <ul><li>`PROVISIONING`: Node group is waiting for resources to be allocated.</li><li>`RUNNING`: Node group is running.</li><li>`RECONCILING`: Node group is waiting for some work to be done, such as upgrading node software.</li><li>`STOPPING`: Node group is being stopped.</li><li>`STOPPED`: Node group stopped.</li><li>`DELETING`: Node group is being deleted.</li><li>`STARTING`: Node group is being started.</li><ul/>
node_template | **[NodeTemplate](#NodeTemplate)**<br>Node template that specifies parameters of the compute instances for the node group. 
scale_policy | **[ScalePolicy](#ScalePolicy)**<br>Scale policy of the node group.  For more information, see [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). 
allocation_policy | **[NodeGroupAllocationPolicy](#NodeGroupAllocationPolicy)**<br>Allocation policy by which resources for node group are allocated to zones and regions. 
instance_group_id | **string**<br>ID of the managed instance group associated with this node group. 
node_version | **string**<br>Version of Kubernetes components that runs on the nodes. Deprecated. Use version_info.current_version. 
version_info | **[VersionInfo](#VersionInfo2)**<br> 
maintenance_policy | **[NodeGroupMaintenancePolicy](#NodeGroupMaintenancePolicy)**<br> 


### NodeTemplate {#NodeTemplate}

Field | Description
--- | ---
platform_id | **string**<br>ID of the hardware platform configuration for the node. 
resources_spec | **[ResourcesSpec](#ResourcesSpec)**<br>Computing resources of the node such as the amount of memory and number of cores. 
boot_disk_spec | **[DiskSpec](#DiskSpec)**<br>Specification for the boot disk that will be attached to the node. The metadata as `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the node. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
metadata | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 131072. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
v4_address_spec | **[NodeAddressSpec](#NodeAddressSpec)**<br>Specification for the create network interfaces for the node group compute instances. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy)**<br>Scheduling policy configuration. 


### ResourcesSpec {#ResourcesSpec}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the node, specified in bytes. Acceptable values are 0 to 274877906944, inclusive.
cores | **int64**<br>Number of cores available to the node. Value must be equal to 0,1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32.
core_fraction | **int64**<br>Baseline level of CPU performance with the possibility to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.


### DiskSpec {#DiskSpec}

Field | Description
--- | ---
disk_type_id | **string**<br>ID of the disk type. Value must match the regular expression ` |network-ssd|network-hdd `.
disk_size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 0 to 4398046511104, inclusive.


### NodeAddressSpec {#NodeAddressSpec}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec)**<br>One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up. 


### OneToOneNatSpec {#OneToOneNatSpec}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy}

Field | Description
--- | ---
preemptible | **bool**<br>True for preemptible compute instances. Default value is false. Preemptible compute instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### ScalePolicy {#ScalePolicy}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale)**<br>Fixed scale policy of the node group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale)**<br>Auto scale policy of the node group. 


### FixedScale {#FixedScale}

Field | Description
--- | ---
size | **int64**<br>Number of nodes in the node group. Acceptable values are 0 to 100, inclusive.


### AutoScale {#AutoScale}

Field | Description
--- | ---
min_size | **int64**<br>Minimum number of nodes in the node group. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Maximum number of nodes in the node group. Acceptable values are 0 to 100, inclusive.
initial_size | **int64**<br>Initial number of nodes in the node group. Acceptable values are 0 to 100, inclusive.


### NodeGroupAllocationPolicy {#NodeGroupAllocationPolicy}

Field | Description
--- | ---
locations[] | **[NodeGroupLocation](#NodeGroupLocation)**<br>List of locations where resources for the node group will be allocated. 


### NodeGroupLocation {#NodeGroupLocation}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the nodes may reside. 
subnet_id | **string**<br>ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted. 


### VersionInfo {#VersionInfo}

Field | Description
--- | ---
current_version | **string**<br>Current kubernetes version, major.minor (e.g. 1.15). 
new_revision_available | **bool**<br>Newer revisions may include kubernetes patches (e.g 1.15.1 -> 1.15.2) as well as some internal component updates - new features or bug fixes in yandex-specific components either on the master or nodes. 
new_revision_summary | **string**<br>Human readable description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false. 
version_deprecated | **bool**<br>The current version is on the deprecation schedule, component (master or node group) should be upgraded. 


### NodeGroupMaintenancePolicy {#NodeGroupMaintenancePolicy}

Field | Description
--- | ---
auto_upgrade | **bool**<br> 
auto_repair | **bool**<br> 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br> 


### MaintenanceWindow {#MaintenanceWindow}

Field | Description
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` or `weekly_maintenance_window`<br>
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow4)**<br> 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow4)**<br> 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow4)**<br> 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}



### DailyMaintenanceWindow {#DailyMaintenanceWindow}

Field | Description
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> Acceptable values are 1h to 24h, inclusive.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow4)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> Acceptable values are 1h to 24h, inclusive.


## ListOperations {#ListOperations}

Lists operations for the specified Kubernetes cluster.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Kubernetes cluster to list operations for. 
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on [Cluster.name](#Cluster6) field. The maximum string length in characters is 1000.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>List of operations for the specified Kubernetes cluster. 
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


