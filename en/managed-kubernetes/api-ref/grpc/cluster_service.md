---
editable: false
sourcePath: en/_api-ref-grpc/managed-kubernetes/api-ref/grpc/cluster_service.md
---

# Managed Services for Kubernetes API, gRPC: ClusterService

A set of methods for managing Kubernetes cluster.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Kubernetes cluster. |
| [List](#List) | Retrieves the list of Kubernetes cluster in the specified folder. |
| [Create](#Create) | Creates a Kubernetes cluster in the specified folder. |
| [Update](#Update) | Updates the specified Kubernetes cluster. |
| [Delete](#Delete) | Deletes the specified Kubernetes cluster. |
| [Stop](#Stop) | Stops the specified Kubernetes cluster. |
| [Start](#Start) | Starts the specified Kubernetes cluster. |
| [ListNodeGroups](#ListNodeGroups) | Lists nodegroup for the specified Kubernetes cluster. |
| [ListOperations](#ListOperations) | Lists operations for the specified Kubernetes cluster. |
| [ListNodes](#ListNodes) | Lists cluster's nodes. |

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
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the Kubernetes cluster. <ul><li>`PROVISIONING`: Kubernetes cluster is waiting for resources to be allocated.</li><li>`RUNNING`: Kubernetes cluster is running.</li><li>`RECONCILING`: Kubernetes cluster is being reconciled.</li><li>`STOPPING`: Kubernetes cluster is being stopped.</li><li>`STOPPED`: Kubernetes cluster stopped.</li><li>`DELETING`: Kubernetes cluster is being deleted.</li><li>`STARTING`: Kubernetes cluster is being started.</li></ul>
health | enum **Health**<br>Health of the Kubernetes cluster. <ul><li>`HEALTHY`: Kubernetes cluster is alive and well.</li><li>`UNHEALTHY`: Kubernetes cluster is inoperable.</li></ul>
network_id | **string**<br>ID of the network the Kubernetes cluster belongs to. 
master | **[Master](#Master)**<br>Properties of the master for the Kubernetes cluster. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy)**<br>Allocation policy for IP addresses of services and pods inside the Kubernetes cluster in different availability zones. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Gateway IPv4 address. The maximum string length in characters is 15.
service_account_id | **string**<br>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. 
node_service_account_id | **string**<br>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. 
release_channel | enum **ReleaseChannel**<br>When creating a Kubernetes cluster, you should specify one of three release channels. The release channel contains several Kubernetes versions. Channels differ in the set of available versions, the management of auto-updates, and the updates received. You can't change the channel once the Kubernetes cluster is created, you can only recreate the Kubernetes cluster and specify a new release channel. For more details see [documentation](https://cloud.yandex.com/docs/managed-kubernetes/concepts/release-channels-and-updates). <ul><li>`RAPID`: Minor updates with new functions and improvements are often added. You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.</li><li>`REGULAR`: New functions and improvements are added in chunks shortly after they appear on `RAPID`.</li><li>`STABLE`: Only updates related to bug fixes or security improvements are added.</li></ul>
network_policy | **[NetworkPolicy](#NetworkPolicy)**<br> 
kms_provider | **[KMSProvider](#KMSProvider)**<br>KMS provider configuration. 
log_group_id | **string**<br>Log group where cluster stores cluster system logs, like audit, events, or controlplane logs. 
network_implementation | **oneof:** `cilium`<br>
&nbsp;&nbsp;cilium | **[Cilium](#Cilium)**<br> 


### Master {#Master}

Field | Description
--- | ---
master_type | **oneof:** `zonal_master` or `regional_master`<br>
&nbsp;&nbsp;zonal_master | **[ZonalMaster](#ZonalMaster)**<br>Parameters of the availability zone for the master. 
&nbsp;&nbsp;regional_master | **[RegionalMaster](#RegionalMaster)**<br>Parameters of the region for the master. 
locations[] | **[Location](#Location)**<br>Locations specification for Kubernetes control-plane (master) instances. 
etcd_cluster_size | **int64**<br>Number of etcd nodes in cluster. 
version | **string**<br>Version of Kubernetes components that runs on the master. 
endpoints | **[MasterEndpoints](#MasterEndpoints)**<br>Endpoints of the master. Endpoints constitute of scheme and port (i.e. `https://ip-address:port`) and can be used by the clients to communicate with the Kubernetes API of the Kubernetes cluster. 
master_auth | **[MasterAuth](#MasterAuth)**<br>Master authentication parameters are used to establish trust between the master and a client. 
version_info | **[VersionInfo](#VersionInfo)**<br>Detailed information about the Kubernetes version that is running on the master. 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy)**<br>Maintenance policy of the master. 
security_group_ids[] | **string**<br>Master security groups. 
master_logging | **[MasterLogging](#MasterLogging)**<br>Cloud Logging for master components. 


### ZonalMaster {#ZonalMaster}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the master resides. 
internal_v4_address | **string**<br>IPv4 internal network address that is assigned to the master. 
external_v4_address | **string**<br>IPv4 external network address that is assigned to the master. 


### RegionalMaster {#RegionalMaster}

Field | Description
--- | ---
region_id | **string**<br>ID of the region where the master resides. 
internal_v4_address | **string**<br>IPv4 internal network address that is assigned to the master. 
external_v4_address | **string**<br>IPv4 external network address that is assigned to the master. 
external_v6_address | **string**<br>IPv6 external network address that is assigned to the master. 


### Location {#Location}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the master resides. 
subnet_id | **string**<br>ID of the VPC network's subnet where the master resides. 


### MasterEndpoints {#MasterEndpoints}

Field | Description
--- | ---
internal_v4_endpoint | **string**<br>Internal endpoint that can be used to connect to the master from cloud networks. 
external_v4_endpoint | **string**<br>External endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud). 
external_v6_endpoint | **string**<br>External IPv6 endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud). 


### MasterAuth {#MasterAuth}

Field | Description
--- | ---
cluster_ca_certificate | **string**<br>PEM-encoded public certificate that is the root of trust for the Kubernetes cluster. 


### VersionInfo {#VersionInfo}

Field | Description
--- | ---
current_version | **string**<br>Current Kubernetes version, format: major.minor (e.g. 1.15). 
new_revision_available | **bool**<br>Newer revisions may include Kubernetes patches (e.g 1.15.1 -> 1.15.2) as well as some internal component updates - new features or bug fixes in platform specific components either on the master or nodes. 
new_revision_summary | **string**<br>Description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false. 
version_deprecated | **bool**<br>The current version is on the deprecation schedule, component (master or node group) should be upgraded. 


### MasterMaintenancePolicy {#MasterMaintenancePolicy}

Field | Description
--- | ---
auto_upgrade | **bool**<br>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow)**<br>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC. 


### MaintenanceWindow {#MaintenanceWindow}

Field | Description
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` or `weekly_maintenance_window`<br>Maintenance policy.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow)**<br>Updating the master at any time. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow)**<br>Updating the master on any day during the specified time window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow)**<br>Updating the master on selected days during the specified time window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}

Empty.

### DailyMaintenanceWindow {#DailyMaintenanceWindow}

Field | Description
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required. Window start time, in the UTC timezone. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Window duration. Acceptable values are 1h to 24h, inclusive.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow)**<br>Days of the week and the maintenance window for these days when automatic updates are allowed. The number of elements must be in the range 1-7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br>Days of the week when automatic updates are allowed. The number of elements must be in the range 1-7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required. Window start time, in the UTC timezone. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Window duration. Acceptable values are 1h to 24h, inclusive.


### MasterLogging {#MasterLogging}

Field | Description
--- | ---
enabled | **bool**<br>Identifies whether Cloud Logging is enabled for master components. 
destination | **oneof:** `log_group_id` or `folder_id`<br>The destination of master components' logs.
&nbsp;&nbsp;log_group_id | **string**<br>ID of the log group where logs of master components should be stored. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder where logs should be stored (in default group). Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
audit_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for audit logs. 
cluster_autoscaler_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for cluster-autoscaler. 
kube_apiserver_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for kube-apiserver. 
events_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for events. 


### IPAllocationPolicy {#IPAllocationPolicy}

Field | Description
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR block. IP range for allocating pod addresses. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets. 
node_ipv4_cidr_mask_size | **int64**<br>Size of the masks that are assigned for each node in the cluster. <br>If not specified, 24 is used. Value must be equal to 0,24,25,26,27,28.
service_ipv4_cidr_block | **string**<br>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. 
cluster_ipv6_cidr_block | **string**<br>IPv6 range for allocating pod IP addresses. 
service_ipv6_cidr_block | **string**<br>IPv6 range for allocating Kubernetes service IP addresses 


### NetworkPolicy {#NetworkPolicy}

Field | Description
--- | ---
provider | enum **Provider**<br> 


### KMSProvider {#KMSProvider}

Field | Description
--- | ---
key_id | **string**<br>KMS key ID for secrets encryption. To obtain a KMS key ID use a [yandex.cloud.kms.v1.SymmetricKeyService.List](/docs/kms/api-ref/grpc/symmetric_key_service#List) request. 


### Cilium {#Cilium}

Field | Description
--- | ---
routing_mode | enum **RoutingMode**<br> 


## List {#List}

Retrieves the list of Kubernetes cluster in the specified folder.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list Kubernetes cluster in. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#ListClustersResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#ListClustersResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on [Cluster.name](#Cluster1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> The maximum string length in characters is 1000.


### ListClustersResponse {#ListClustersResponse}

Field | Description
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>List of Kubernetes cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClustersRequest.page_size](#ListClustersRequest), use the `next_page_token` as the value for the [ListClustersRequest.page_token](#ListClustersRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Cluster {#Cluster1}

Field | Description
--- | ---
id | **string**<br>ID of the Kubernetes cluster. 
folder_id | **string**<br>ID of the folder that the Kubernetes cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Kubernetes cluster. 
description | **string**<br>Description of the Kubernetes cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the Kubernetes cluster. <ul><li>`PROVISIONING`: Kubernetes cluster is waiting for resources to be allocated.</li><li>`RUNNING`: Kubernetes cluster is running.</li><li>`RECONCILING`: Kubernetes cluster is being reconciled.</li><li>`STOPPING`: Kubernetes cluster is being stopped.</li><li>`STOPPED`: Kubernetes cluster stopped.</li><li>`DELETING`: Kubernetes cluster is being deleted.</li><li>`STARTING`: Kubernetes cluster is being started.</li></ul>
health | enum **Health**<br>Health of the Kubernetes cluster. <ul><li>`HEALTHY`: Kubernetes cluster is alive and well.</li><li>`UNHEALTHY`: Kubernetes cluster is inoperable.</li></ul>
network_id | **string**<br>ID of the network the Kubernetes cluster belongs to. 
master | **[Master](#Master1)**<br>Properties of the master for the Kubernetes cluster. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy1)**<br>Allocation policy for IP addresses of services and pods inside the Kubernetes cluster in different availability zones. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Gateway IPv4 address. The maximum string length in characters is 15.
service_account_id | **string**<br>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. 
node_service_account_id | **string**<br>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. 
release_channel | enum **ReleaseChannel**<br>When creating a Kubernetes cluster, you should specify one of three release channels. The release channel contains several Kubernetes versions. Channels differ in the set of available versions, the management of auto-updates, and the updates received. You can't change the channel once the Kubernetes cluster is created, you can only recreate the Kubernetes cluster and specify a new release channel. For more details see [documentation](https://cloud.yandex.com/docs/managed-kubernetes/concepts/release-channels-and-updates). <ul><li>`RAPID`: Minor updates with new functions and improvements are often added. You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.</li><li>`REGULAR`: New functions and improvements are added in chunks shortly after they appear on `RAPID`.</li><li>`STABLE`: Only updates related to bug fixes or security improvements are added.</li></ul>
network_policy | **[NetworkPolicy](#NetworkPolicy1)**<br> 
kms_provider | **[KMSProvider](#KMSProvider1)**<br>KMS provider configuration. 
log_group_id | **string**<br>Log group where cluster stores cluster system logs, like audit, events, or controlplane logs. 
network_implementation | **oneof:** `cilium`<br>
&nbsp;&nbsp;cilium | **[Cilium](#Cilium1)**<br> 


### Master {#Master1}

Field | Description
--- | ---
master_type | **oneof:** `zonal_master` or `regional_master`<br>
&nbsp;&nbsp;zonal_master | **[ZonalMaster](#ZonalMaster1)**<br>Parameters of the availability zone for the master. 
&nbsp;&nbsp;regional_master | **[RegionalMaster](#RegionalMaster1)**<br>Parameters of the region for the master. 
locations[] | **[Location](#Location1)**<br>Locations specification for Kubernetes control-plane (master) instances. 
etcd_cluster_size | **int64**<br>Number of etcd nodes in cluster. 
version | **string**<br>Version of Kubernetes components that runs on the master. 
endpoints | **[MasterEndpoints](#MasterEndpoints1)**<br>Endpoints of the master. Endpoints constitute of scheme and port (i.e. `https://ip-address:port`) and can be used by the clients to communicate with the Kubernetes API of the Kubernetes cluster. 
master_auth | **[MasterAuth](#MasterAuth1)**<br>Master authentication parameters are used to establish trust between the master and a client. 
version_info | **[VersionInfo](#VersionInfo1)**<br>Detailed information about the Kubernetes version that is running on the master. 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy1)**<br>Maintenance policy of the master. 
security_group_ids[] | **string**<br>Master security groups. 
master_logging | **[MasterLogging](#MasterLogging1)**<br>Cloud Logging for master components. 


### ZonalMaster {#ZonalMaster1}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the master resides. 
internal_v4_address | **string**<br>IPv4 internal network address that is assigned to the master. 
external_v4_address | **string**<br>IPv4 external network address that is assigned to the master. 


### RegionalMaster {#RegionalMaster1}

Field | Description
--- | ---
region_id | **string**<br>ID of the region where the master resides. 
internal_v4_address | **string**<br>IPv4 internal network address that is assigned to the master. 
external_v4_address | **string**<br>IPv4 external network address that is assigned to the master. 
external_v6_address | **string**<br>IPv6 external network address that is assigned to the master. 


### Location {#Location1}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the master resides. 
subnet_id | **string**<br>ID of the VPC network's subnet where the master resides. 


### MasterEndpoints {#MasterEndpoints1}

Field | Description
--- | ---
internal_v4_endpoint | **string**<br>Internal endpoint that can be used to connect to the master from cloud networks. 
external_v4_endpoint | **string**<br>External endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud). 
external_v6_endpoint | **string**<br>External IPv6 endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud). 


### MasterAuth {#MasterAuth1}

Field | Description
--- | ---
cluster_ca_certificate | **string**<br>PEM-encoded public certificate that is the root of trust for the Kubernetes cluster. 


### VersionInfo {#VersionInfo1}

Field | Description
--- | ---
current_version | **string**<br>Current Kubernetes version, format: major.minor (e.g. 1.15). 
new_revision_available | **bool**<br>Newer revisions may include Kubernetes patches (e.g 1.15.1 -> 1.15.2) as well as some internal component updates - new features or bug fixes in platform specific components either on the master or nodes. 
new_revision_summary | **string**<br>Description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false. 
version_deprecated | **bool**<br>The current version is on the deprecation schedule, component (master or node group) should be upgraded. 


### MasterMaintenancePolicy {#MasterMaintenancePolicy1}

Field | Description
--- | ---
auto_upgrade | **bool**<br>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow1)**<br>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC. 


### MaintenanceWindow {#MaintenanceWindow1}

Field | Description
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` or `weekly_maintenance_window`<br>Maintenance policy.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow1)**<br>Updating the master at any time. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow1)**<br>Updating the master on any day during the specified time window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow1)**<br>Updating the master on selected days during the specified time window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow1}

Empty.

### DailyMaintenanceWindow {#DailyMaintenanceWindow1}

Field | Description
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required. Window start time, in the UTC timezone. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Window duration. Acceptable values are 1h to 24h, inclusive.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow1}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow1)**<br>Days of the week and the maintenance window for these days when automatic updates are allowed. The number of elements must be in the range 1-7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow1}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br>Days of the week when automatic updates are allowed. The number of elements must be in the range 1-7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required. Window start time, in the UTC timezone. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Window duration. Acceptable values are 1h to 24h, inclusive.


### MasterLogging {#MasterLogging1}

Field | Description
--- | ---
enabled | **bool**<br>Identifies whether Cloud Logging is enabled for master components. 
destination | **oneof:** `log_group_id` or `folder_id`<br>The destination of master components' logs.
&nbsp;&nbsp;log_group_id | **string**<br>ID of the log group where logs of master components should be stored. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder where logs should be stored (in default group). Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
audit_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for audit logs. 
cluster_autoscaler_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for cluster-autoscaler. 
kube_apiserver_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for kube-apiserver. 
events_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for events. 


### IPAllocationPolicy {#IPAllocationPolicy1}

Field | Description
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR block. IP range for allocating pod addresses. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets. 
node_ipv4_cidr_mask_size | **int64**<br>Size of the masks that are assigned for each node in the cluster. <br>If not specified, 24 is used. Value must be equal to 0,24,25,26,27,28.
service_ipv4_cidr_block | **string**<br>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. 
cluster_ipv6_cidr_block | **string**<br>IPv6 range for allocating pod IP addresses. 
service_ipv6_cidr_block | **string**<br>IPv6 range for allocating Kubernetes service IP addresses 


### NetworkPolicy {#NetworkPolicy1}

Field | Description
--- | ---
provider | enum **Provider**<br> 


### KMSProvider {#KMSProvider1}

Field | Description
--- | ---
key_id | **string**<br>KMS key ID for secrets encryption. To obtain a KMS key ID use a [yandex.cloud.kms.v1.SymmetricKeyService.List](/docs/kms/api-ref/grpc/symmetric_key_service#List) request. 


### Cilium {#Cilium1}

Field | Description
--- | ---
routing_mode | enum **RoutingMode**<br> 


## Create {#Create}

Creates a Kubernetes cluster in the specified folder.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a Kubernetes cluster in. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
name | **string**<br>Name of the Kubernetes cluster. The name must be unique within the folder. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the Kubernetes cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
network_id | **string**<br>Required. ID of the network. 
master_spec | **[MasterSpec](#MasterSpec)**<br>Required. Master specification of the Kubernetes cluster. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy2)**<br>IP allocation policy of the Kubernetes cluster. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Gateway IPv4 address. 
service_account_id | **string**<br>Required. Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. Selected service account should have `edit` role on the folder where the Kubernetes cluster will be located and on the folder where selected network resides. 
node_service_account_id | **string**<br>Required. Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. 
release_channel | enum **ReleaseChannel**<br>Release channel for the master. <ul><li>`RAPID`: Minor updates with new functions and improvements are often added. You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.</li><li>`REGULAR`: New functions and improvements are added in chunks shortly after they appear on `RAPID`.</li><li>`STABLE`: Only updates related to bug fixes or security improvements are added.</li></ul>
network_policy | **[NetworkPolicy](#NetworkPolicy2)**<br> 
kms_provider | **[KMSProvider](#KMSProvider2)**<br>KMS provider configuration. 
network_implementation | **oneof:** `cilium`<br>
&nbsp;&nbsp;cilium | **[Cilium](#Cilium2)**<br> 


### MasterSpec {#MasterSpec}

Field | Description
--- | ---
master_type | **oneof:** `zonal_master_spec` or `regional_master_spec`<br>
&nbsp;&nbsp;zonal_master_spec | **[ZonalMasterSpec](#ZonalMasterSpec)**<br>Specification of the zonal master. 
&nbsp;&nbsp;regional_master_spec | **[RegionalMasterSpec](#RegionalMasterSpec)**<br>Specification of the regional master. 
locations[] | **[LocationSpec](#LocationSpec)**<br>Locations specification for Kubernetes control-plane (master) instances. Works in conjunction with `etcd_cluster_size`. See it's documentation for details. Possible combinations: <ul><li>1 location and etcd_cluster_size = 1 - a single node cluster whose availability is limited by the availability of a single Compute Instance; downtime is expected during cluster updates. </li><li>1 location and etcd_cluster_size = 3 - a highly available cluster within a single availability zone; can survive the failure of a Compute Instance, a server, or an individual server rack. </li><li>3 location and etcd_cluster_size = 3 - a highly available cluster with each etcd instance located within separate availability zone; can survive the failure of a single availability zone.</li></ul> 
etcd_cluster_size | **int64**<br>Number of etcd nodes in cluster. Works in conjunction with `locations`. See it's documentation for details. Optional. If not set, will be assumed equal to the number of locations. Value must be equal to 0,1,3.
version | **string**<br>Version of Kubernetes components that runs on the master. 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy2)**<br>Maintenance policy of the master. 
security_group_ids[] | **string**<br>Master security groups. 
master_logging | **[MasterLogging](#MasterLogging2)**<br>Cloud Logging for master components. 


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

Field | Description
--- | ---
address | **string**<br>IP address. 


### RegionalMasterSpec {#RegionalMasterSpec}

Field | Description
--- | ---
region_id | **string**<br>Required. ID of the availability zone where the master resides. 
locations[] | **[MasterLocation](#MasterLocation)**<br>List of locations where the master will be allocated. 
external_v4_address_spec | **[ExternalAddressSpec](#ExternalAddressSpec)**<br>Specify to allocate a static public IP for the master. 
external_v6_address_spec | **[ExternalAddressSpec](#ExternalAddressSpec)**<br>Specification of parameters for external IPv6 networking. 


### MasterLocation {#MasterLocation}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone. 
internal_v4_address_spec | **[InternalAddressSpec](#InternalAddressSpec)**<br>If not specified and there is a single subnet in specified zone, address in this subnet will be allocated. 


### LocationSpec {#LocationSpec}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the master resides. 
subnet_id | **string**<br>ID of the VPC network's subnet where the master resides. If not specified and there is a single subnet in specified zone, address in this subnet will be allocated. 


### MasterMaintenancePolicy {#MasterMaintenancePolicy2}

Field | Description
--- | ---
auto_upgrade | **bool**<br>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow2)**<br>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC. 


### MaintenanceWindow {#MaintenanceWindow2}

Field | Description
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` or `weekly_maintenance_window`<br>Maintenance policy.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow2)**<br>Updating the master at any time. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow2)**<br>Updating the master on any day during the specified time window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow2)**<br>Updating the master on selected days during the specified time window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow2}

Empty.

### DailyMaintenanceWindow {#DailyMaintenanceWindow2}

Field | Description
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required. Window start time, in the UTC timezone. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Window duration. Acceptable values are 1h to 24h, inclusive.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow2}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow2)**<br>Days of the week and the maintenance window for these days when automatic updates are allowed. The number of elements must be in the range 1-7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow2}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br>Days of the week when automatic updates are allowed. The number of elements must be in the range 1-7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required. Window start time, in the UTC timezone. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Window duration. Acceptable values are 1h to 24h, inclusive.


### MasterLogging {#MasterLogging2}

Field | Description
--- | ---
enabled | **bool**<br>Identifies whether Cloud Logging is enabled for master components. 
destination | **oneof:** `log_group_id` or `folder_id`<br>The destination of master components' logs.
&nbsp;&nbsp;log_group_id | **string**<br>ID of the log group where logs of master components should be stored. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder where logs should be stored (in default group). Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
audit_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for audit logs. 
cluster_autoscaler_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for cluster-autoscaler. 
kube_apiserver_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for kube-apiserver. 
events_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for events. 


### IPAllocationPolicy {#IPAllocationPolicy2}

Field | Description
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR block. IP range for allocating pod addresses. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets. 
node_ipv4_cidr_mask_size | **int64**<br>Size of the masks that are assigned for each node in the cluster. <br>If not specified, 24 is used. Value must be equal to 0,24,25,26,27,28.
service_ipv4_cidr_block | **string**<br>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. 
cluster_ipv6_cidr_block | **string**<br>IPv6 range for allocating pod IP addresses. 
service_ipv6_cidr_block | **string**<br>IPv6 range for allocating Kubernetes service IP addresses 


### NetworkPolicy {#NetworkPolicy2}

Field | Description
--- | ---
provider | enum **Provider**<br> 


### KMSProvider {#KMSProvider2}

Field | Description
--- | ---
key_id | **string**<br>KMS key ID for secrets encryption. To obtain a KMS key ID use a [yandex.cloud.kms.v1.SymmetricKeyService.List](/docs/kms/api-ref/grpc/symmetric_key_service#List) request. 


### Cilium {#Cilium2}

Field | Description
--- | ---
routing_mode | enum **RoutingMode**<br> 


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


### Cluster {#Cluster2}

Field | Description
--- | ---
id | **string**<br>ID of the Kubernetes cluster. 
folder_id | **string**<br>ID of the folder that the Kubernetes cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Kubernetes cluster. 
description | **string**<br>Description of the Kubernetes cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the Kubernetes cluster. <ul><li>`PROVISIONING`: Kubernetes cluster is waiting for resources to be allocated.</li><li>`RUNNING`: Kubernetes cluster is running.</li><li>`RECONCILING`: Kubernetes cluster is being reconciled.</li><li>`STOPPING`: Kubernetes cluster is being stopped.</li><li>`STOPPED`: Kubernetes cluster stopped.</li><li>`DELETING`: Kubernetes cluster is being deleted.</li><li>`STARTING`: Kubernetes cluster is being started.</li></ul>
health | enum **Health**<br>Health of the Kubernetes cluster. <ul><li>`HEALTHY`: Kubernetes cluster is alive and well.</li><li>`UNHEALTHY`: Kubernetes cluster is inoperable.</li></ul>
network_id | **string**<br>ID of the network the Kubernetes cluster belongs to. 
master | **[Master](#Master2)**<br>Properties of the master for the Kubernetes cluster. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy3)**<br>Allocation policy for IP addresses of services and pods inside the Kubernetes cluster in different availability zones. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Gateway IPv4 address. The maximum string length in characters is 15.
service_account_id | **string**<br>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. 
node_service_account_id | **string**<br>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. 
release_channel | enum **ReleaseChannel**<br>When creating a Kubernetes cluster, you should specify one of three release channels. The release channel contains several Kubernetes versions. Channels differ in the set of available versions, the management of auto-updates, and the updates received. You can't change the channel once the Kubernetes cluster is created, you can only recreate the Kubernetes cluster and specify a new release channel. For more details see [documentation](https://cloud.yandex.com/docs/managed-kubernetes/concepts/release-channels-and-updates). <ul><li>`RAPID`: Minor updates with new functions and improvements are often added. You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.</li><li>`REGULAR`: New functions and improvements are added in chunks shortly after they appear on `RAPID`.</li><li>`STABLE`: Only updates related to bug fixes or security improvements are added.</li></ul>
network_policy | **[NetworkPolicy](#NetworkPolicy3)**<br> 
kms_provider | **[KMSProvider](#KMSProvider3)**<br>KMS provider configuration. 
log_group_id | **string**<br>Log group where cluster stores cluster system logs, like audit, events, or controlplane logs. 
network_implementation | **oneof:** `cilium`<br>
&nbsp;&nbsp;cilium | **[Cilium](#Cilium3)**<br> 


### Master {#Master2}

Field | Description
--- | ---
master_type | **oneof:** `zonal_master` or `regional_master`<br>
&nbsp;&nbsp;zonal_master | **[ZonalMaster](#ZonalMaster2)**<br>Parameters of the availability zone for the master. 
&nbsp;&nbsp;regional_master | **[RegionalMaster](#RegionalMaster2)**<br>Parameters of the region for the master. 
locations[] | **[Location](#Location2)**<br>Locations specification for Kubernetes control-plane (master) instances. 
etcd_cluster_size | **int64**<br>Number of etcd nodes in cluster. 
version | **string**<br>Version of Kubernetes components that runs on the master. 
endpoints | **[MasterEndpoints](#MasterEndpoints2)**<br>Endpoints of the master. Endpoints constitute of scheme and port (i.e. `https://ip-address:port`) and can be used by the clients to communicate with the Kubernetes API of the Kubernetes cluster. 
master_auth | **[MasterAuth](#MasterAuth2)**<br>Master authentication parameters are used to establish trust between the master and a client. 
version_info | **[VersionInfo](#VersionInfo2)**<br>Detailed information about the Kubernetes version that is running on the master. 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy3)**<br>Maintenance policy of the master. 
security_group_ids[] | **string**<br>Master security groups. 
master_logging | **[MasterLogging](#MasterLogging3)**<br>Cloud Logging for master components. 


### ZonalMaster {#ZonalMaster2}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the master resides. 
internal_v4_address | **string**<br>IPv4 internal network address that is assigned to the master. 
external_v4_address | **string**<br>IPv4 external network address that is assigned to the master. 


### RegionalMaster {#RegionalMaster2}

Field | Description
--- | ---
region_id | **string**<br>ID of the region where the master resides. 
internal_v4_address | **string**<br>IPv4 internal network address that is assigned to the master. 
external_v4_address | **string**<br>IPv4 external network address that is assigned to the master. 
external_v6_address | **string**<br>IPv6 external network address that is assigned to the master. 


### Location {#Location2}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the master resides. 
subnet_id | **string**<br>ID of the VPC network's subnet where the master resides. 


### MasterEndpoints {#MasterEndpoints2}

Field | Description
--- | ---
internal_v4_endpoint | **string**<br>Internal endpoint that can be used to connect to the master from cloud networks. 
external_v4_endpoint | **string**<br>External endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud). 
external_v6_endpoint | **string**<br>External IPv6 endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud). 


### MasterAuth {#MasterAuth2}

Field | Description
--- | ---
cluster_ca_certificate | **string**<br>PEM-encoded public certificate that is the root of trust for the Kubernetes cluster. 


### VersionInfo {#VersionInfo2}

Field | Description
--- | ---
current_version | **string**<br>Current Kubernetes version, format: major.minor (e.g. 1.15). 
new_revision_available | **bool**<br>Newer revisions may include Kubernetes patches (e.g 1.15.1 -> 1.15.2) as well as some internal component updates - new features or bug fixes in platform specific components either on the master or nodes. 
new_revision_summary | **string**<br>Description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false. 
version_deprecated | **bool**<br>The current version is on the deprecation schedule, component (master or node group) should be upgraded. 


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
name | **string**<br>Name of the Kubernetes cluster. The name must be unique within the folder. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the Kubernetes cluster. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. <br>Existing set of `labels` is completely replaced by the provided set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Gateway IPv4 address. The maximum string length in characters is 15.
master_spec | **[MasterUpdateSpec](#MasterUpdateSpec)**<br>Specification of the master update. 
service_account_id | **string**<br>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. Selected service account should have `edit` role on the folder where the Kubernetes cluster will be located and on the folder where selected network resides. 
node_service_account_id | **string**<br>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. 
network_policy | **[NetworkPolicy](#NetworkPolicy3)**<br> 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy3)**<br> 


### MasterUpdateSpec {#MasterUpdateSpec}

Field | Description
--- | ---
version | **[UpdateVersionSpec](#UpdateVersionSpec)**<br>Specification of the master update. 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy3)**<br>Maintenance policy of the master. 
security_group_ids[] | **string**<br>Master security groups. 
master_logging | **[MasterLogging](#MasterLogging3)**<br>Cloud Logging for master components. 
locations[] | **[LocationSpec](#LocationSpec)**<br>Update master instance locations. 


### UpdateVersionSpec {#UpdateVersionSpec}

Field | Description
--- | ---
specifier | **oneof:** `version` or `latest_revision`<br>
&nbsp;&nbsp;version | **string**<br>Request update to a newer version of Kubernetes (1.x -> 1.y). 
&nbsp;&nbsp;latest_revision | **bool**<br>Request update to the latest revision for the current version. 


### MasterMaintenancePolicy {#MasterMaintenancePolicy3}

Field | Description
--- | ---
auto_upgrade | **bool**<br>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC. 


### MaintenanceWindow {#MaintenanceWindow3}

Field | Description
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` or `weekly_maintenance_window`<br>Maintenance policy.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow3)**<br>Updating the master at any time. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow3)**<br>Updating the master on any day during the specified time window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow3)**<br>Updating the master on selected days during the specified time window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow3}

Empty.

### DailyMaintenanceWindow {#DailyMaintenanceWindow3}

Field | Description
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required. Window start time, in the UTC timezone. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Window duration. Acceptable values are 1h to 24h, inclusive.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow3}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow3)**<br>Days of the week and the maintenance window for these days when automatic updates are allowed. The number of elements must be in the range 1-7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow3}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br>Days of the week when automatic updates are allowed. The number of elements must be in the range 1-7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required. Window start time, in the UTC timezone. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Window duration. Acceptable values are 1h to 24h, inclusive.


### MasterLogging {#MasterLogging3}

Field | Description
--- | ---
enabled | **bool**<br>Identifies whether Cloud Logging is enabled for master components. 
destination | **oneof:** `log_group_id` or `folder_id`<br>The destination of master components' logs.
&nbsp;&nbsp;log_group_id | **string**<br>ID of the log group where logs of master components should be stored. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder where logs should be stored (in default group). Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
audit_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for audit logs. 
cluster_autoscaler_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for cluster-autoscaler. 
kube_apiserver_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for kube-apiserver. 
events_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for events. 


### LocationSpec {#LocationSpec1}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the master resides. 
subnet_id | **string**<br>ID of the VPC network's subnet where the master resides. If not specified and there is a single subnet in specified zone, address in this subnet will be allocated. 


### NetworkPolicy {#NetworkPolicy3}

Field | Description
--- | ---
provider | enum **Provider**<br> 


### IPAllocationPolicy {#IPAllocationPolicy3}

Field | Description
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR block. IP range for allocating pod addresses. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets. 
node_ipv4_cidr_mask_size | **int64**<br>Size of the masks that are assigned for each node in the cluster. <br>If not specified, 24 is used. Value must be equal to 0,24,25,26,27,28.
service_ipv4_cidr_block | **string**<br>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. 
cluster_ipv6_cidr_block | **string**<br>IPv6 range for allocating pod IP addresses. 
service_ipv6_cidr_block | **string**<br>IPv6 range for allocating Kubernetes service IP addresses 


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
cluster_id | **string**<br>ID of the Kubernetes cluster that is being updated. 


### Cluster {#Cluster3}

Field | Description
--- | ---
id | **string**<br>ID of the Kubernetes cluster. 
folder_id | **string**<br>ID of the folder that the Kubernetes cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Kubernetes cluster. 
description | **string**<br>Description of the Kubernetes cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the Kubernetes cluster. <ul><li>`PROVISIONING`: Kubernetes cluster is waiting for resources to be allocated.</li><li>`RUNNING`: Kubernetes cluster is running.</li><li>`RECONCILING`: Kubernetes cluster is being reconciled.</li><li>`STOPPING`: Kubernetes cluster is being stopped.</li><li>`STOPPED`: Kubernetes cluster stopped.</li><li>`DELETING`: Kubernetes cluster is being deleted.</li><li>`STARTING`: Kubernetes cluster is being started.</li></ul>
health | enum **Health**<br>Health of the Kubernetes cluster. <ul><li>`HEALTHY`: Kubernetes cluster is alive and well.</li><li>`UNHEALTHY`: Kubernetes cluster is inoperable.</li></ul>
network_id | **string**<br>ID of the network the Kubernetes cluster belongs to. 
master | **[Master](#Master3)**<br>Properties of the master for the Kubernetes cluster. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy4)**<br>Allocation policy for IP addresses of services and pods inside the Kubernetes cluster in different availability zones. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Gateway IPv4 address. The maximum string length in characters is 15.
service_account_id | **string**<br>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. 
node_service_account_id | **string**<br>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. 
release_channel | enum **ReleaseChannel**<br>When creating a Kubernetes cluster, you should specify one of three release channels. The release channel contains several Kubernetes versions. Channels differ in the set of available versions, the management of auto-updates, and the updates received. You can't change the channel once the Kubernetes cluster is created, you can only recreate the Kubernetes cluster and specify a new release channel. For more details see [documentation](https://cloud.yandex.com/docs/managed-kubernetes/concepts/release-channels-and-updates). <ul><li>`RAPID`: Minor updates with new functions and improvements are often added. You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.</li><li>`REGULAR`: New functions and improvements are added in chunks shortly after they appear on `RAPID`.</li><li>`STABLE`: Only updates related to bug fixes or security improvements are added.</li></ul>
network_policy | **[NetworkPolicy](#NetworkPolicy4)**<br> 
kms_provider | **[KMSProvider](#KMSProvider3)**<br>KMS provider configuration. 
log_group_id | **string**<br>Log group where cluster stores cluster system logs, like audit, events, or controlplane logs. 
network_implementation | **oneof:** `cilium`<br>
&nbsp;&nbsp;cilium | **[Cilium](#Cilium3)**<br> 


### Master {#Master3}

Field | Description
--- | ---
master_type | **oneof:** `zonal_master` or `regional_master`<br>
&nbsp;&nbsp;zonal_master | **[ZonalMaster](#ZonalMaster3)**<br>Parameters of the availability zone for the master. 
&nbsp;&nbsp;regional_master | **[RegionalMaster](#RegionalMaster3)**<br>Parameters of the region for the master. 
locations[] | **[Location](#Location3)**<br>Locations specification for Kubernetes control-plane (master) instances. 
etcd_cluster_size | **int64**<br>Number of etcd nodes in cluster. 
version | **string**<br>Version of Kubernetes components that runs on the master. 
endpoints | **[MasterEndpoints](#MasterEndpoints3)**<br>Endpoints of the master. Endpoints constitute of scheme and port (i.e. `https://ip-address:port`) and can be used by the clients to communicate with the Kubernetes API of the Kubernetes cluster. 
master_auth | **[MasterAuth](#MasterAuth3)**<br>Master authentication parameters are used to establish trust between the master and a client. 
version_info | **[VersionInfo](#VersionInfo3)**<br>Detailed information about the Kubernetes version that is running on the master. 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy4)**<br>Maintenance policy of the master. 
security_group_ids[] | **string**<br>Master security groups. 
master_logging | **[MasterLogging](#MasterLogging4)**<br>Cloud Logging for master components. 


### ZonalMaster {#ZonalMaster3}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the master resides. 
internal_v4_address | **string**<br>IPv4 internal network address that is assigned to the master. 
external_v4_address | **string**<br>IPv4 external network address that is assigned to the master. 


### RegionalMaster {#RegionalMaster3}

Field | Description
--- | ---
region_id | **string**<br>ID of the region where the master resides. 
internal_v4_address | **string**<br>IPv4 internal network address that is assigned to the master. 
external_v4_address | **string**<br>IPv4 external network address that is assigned to the master. 
external_v6_address | **string**<br>IPv6 external network address that is assigned to the master. 


### Location {#Location3}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the master resides. 
subnet_id | **string**<br>ID of the VPC network's subnet where the master resides. 


### MasterEndpoints {#MasterEndpoints3}

Field | Description
--- | ---
internal_v4_endpoint | **string**<br>Internal endpoint that can be used to connect to the master from cloud networks. 
external_v4_endpoint | **string**<br>External endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud). 
external_v6_endpoint | **string**<br>External IPv6 endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud). 


### MasterAuth {#MasterAuth3}

Field | Description
--- | ---
cluster_ca_certificate | **string**<br>PEM-encoded public certificate that is the root of trust for the Kubernetes cluster. 


### VersionInfo {#VersionInfo3}

Field | Description
--- | ---
current_version | **string**<br>Current Kubernetes version, format: major.minor (e.g. 1.15). 
new_revision_available | **bool**<br>Newer revisions may include Kubernetes patches (e.g 1.15.1 -> 1.15.2) as well as some internal component updates - new features or bug fixes in platform specific components either on the master or nodes. 
new_revision_summary | **string**<br>Description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false. 
version_deprecated | **bool**<br>The current version is on the deprecation schedule, component (master or node group) should be upgraded. 


### KMSProvider {#KMSProvider3}

Field | Description
--- | ---
key_id | **string**<br>KMS key ID for secrets encryption. To obtain a KMS key ID use a [yandex.cloud.kms.v1.SymmetricKeyService.List](/docs/kms/api-ref/grpc/symmetric_key_service#List) request. 


### Cilium {#Cilium3}

Field | Description
--- | ---
routing_mode | enum **RoutingMode**<br> 


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
cluster_id | **string**<br>ID of the Kubernetes cluster that is being deleted. 


## Stop {#Stop}

Stops the specified Kubernetes cluster.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StopClusterRequest {#StopClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Kubernetes cluster to stop. To get Kubernetes cluster ID use a [ClusterService.List](#List) request. 


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
cluster_id | **string**<br>ID of the Kubernetes cluster that is being stopped. 


### Cluster {#Cluster4}

Field | Description
--- | ---
id | **string**<br>ID of the Kubernetes cluster. 
folder_id | **string**<br>ID of the folder that the Kubernetes cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Kubernetes cluster. 
description | **string**<br>Description of the Kubernetes cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the Kubernetes cluster. <ul><li>`PROVISIONING`: Kubernetes cluster is waiting for resources to be allocated.</li><li>`RUNNING`: Kubernetes cluster is running.</li><li>`RECONCILING`: Kubernetes cluster is being reconciled.</li><li>`STOPPING`: Kubernetes cluster is being stopped.</li><li>`STOPPED`: Kubernetes cluster stopped.</li><li>`DELETING`: Kubernetes cluster is being deleted.</li><li>`STARTING`: Kubernetes cluster is being started.</li></ul>
health | enum **Health**<br>Health of the Kubernetes cluster. <ul><li>`HEALTHY`: Kubernetes cluster is alive and well.</li><li>`UNHEALTHY`: Kubernetes cluster is inoperable.</li></ul>
network_id | **string**<br>ID of the network the Kubernetes cluster belongs to. 
master | **[Master](#Master4)**<br>Properties of the master for the Kubernetes cluster. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy4)**<br>Allocation policy for IP addresses of services and pods inside the Kubernetes cluster in different availability zones. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Gateway IPv4 address. The maximum string length in characters is 15.
service_account_id | **string**<br>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. 
node_service_account_id | **string**<br>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. 
release_channel | enum **ReleaseChannel**<br>When creating a Kubernetes cluster, you should specify one of three release channels. The release channel contains several Kubernetes versions. Channels differ in the set of available versions, the management of auto-updates, and the updates received. You can't change the channel once the Kubernetes cluster is created, you can only recreate the Kubernetes cluster and specify a new release channel. For more details see [documentation](https://cloud.yandex.com/docs/managed-kubernetes/concepts/release-channels-and-updates). <ul><li>`RAPID`: Minor updates with new functions and improvements are often added. You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.</li><li>`REGULAR`: New functions and improvements are added in chunks shortly after they appear on `RAPID`.</li><li>`STABLE`: Only updates related to bug fixes or security improvements are added.</li></ul>
network_policy | **[NetworkPolicy](#NetworkPolicy4)**<br> 
kms_provider | **[KMSProvider](#KMSProvider4)**<br>KMS provider configuration. 
log_group_id | **string**<br>Log group where cluster stores cluster system logs, like audit, events, or controlplane logs. 
network_implementation | **oneof:** `cilium`<br>
&nbsp;&nbsp;cilium | **[Cilium](#Cilium4)**<br> 


### Master {#Master4}

Field | Description
--- | ---
master_type | **oneof:** `zonal_master` or `regional_master`<br>
&nbsp;&nbsp;zonal_master | **[ZonalMaster](#ZonalMaster4)**<br>Parameters of the availability zone for the master. 
&nbsp;&nbsp;regional_master | **[RegionalMaster](#RegionalMaster4)**<br>Parameters of the region for the master. 
locations[] | **[Location](#Location4)**<br>Locations specification for Kubernetes control-plane (master) instances. 
etcd_cluster_size | **int64**<br>Number of etcd nodes in cluster. 
version | **string**<br>Version of Kubernetes components that runs on the master. 
endpoints | **[MasterEndpoints](#MasterEndpoints4)**<br>Endpoints of the master. Endpoints constitute of scheme and port (i.e. `https://ip-address:port`) and can be used by the clients to communicate with the Kubernetes API of the Kubernetes cluster. 
master_auth | **[MasterAuth](#MasterAuth4)**<br>Master authentication parameters are used to establish trust between the master and a client. 
version_info | **[VersionInfo](#VersionInfo4)**<br>Detailed information about the Kubernetes version that is running on the master. 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy4)**<br>Maintenance policy of the master. 
security_group_ids[] | **string**<br>Master security groups. 
master_logging | **[MasterLogging](#MasterLogging4)**<br>Cloud Logging for master components. 


### ZonalMaster {#ZonalMaster4}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the master resides. 
internal_v4_address | **string**<br>IPv4 internal network address that is assigned to the master. 
external_v4_address | **string**<br>IPv4 external network address that is assigned to the master. 


### RegionalMaster {#RegionalMaster4}

Field | Description
--- | ---
region_id | **string**<br>ID of the region where the master resides. 
internal_v4_address | **string**<br>IPv4 internal network address that is assigned to the master. 
external_v4_address | **string**<br>IPv4 external network address that is assigned to the master. 
external_v6_address | **string**<br>IPv6 external network address that is assigned to the master. 


### Location {#Location4}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the master resides. 
subnet_id | **string**<br>ID of the VPC network's subnet where the master resides. 


### MasterEndpoints {#MasterEndpoints4}

Field | Description
--- | ---
internal_v4_endpoint | **string**<br>Internal endpoint that can be used to connect to the master from cloud networks. 
external_v4_endpoint | **string**<br>External endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud). 
external_v6_endpoint | **string**<br>External IPv6 endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud). 


### MasterAuth {#MasterAuth4}

Field | Description
--- | ---
cluster_ca_certificate | **string**<br>PEM-encoded public certificate that is the root of trust for the Kubernetes cluster. 


### VersionInfo {#VersionInfo4}

Field | Description
--- | ---
current_version | **string**<br>Current Kubernetes version, format: major.minor (e.g. 1.15). 
new_revision_available | **bool**<br>Newer revisions may include Kubernetes patches (e.g 1.15.1 -> 1.15.2) as well as some internal component updates - new features or bug fixes in platform specific components either on the master or nodes. 
new_revision_summary | **string**<br>Description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false. 
version_deprecated | **bool**<br>The current version is on the deprecation schedule, component (master or node group) should be upgraded. 


### MasterMaintenancePolicy {#MasterMaintenancePolicy4}

Field | Description
--- | ---
auto_upgrade | **bool**<br>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow4)**<br>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC. 


### MaintenanceWindow {#MaintenanceWindow4}

Field | Description
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` or `weekly_maintenance_window`<br>Maintenance policy.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow4)**<br>Updating the master at any time. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow4)**<br>Updating the master on any day during the specified time window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow4)**<br>Updating the master on selected days during the specified time window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow4}

Empty.

### DailyMaintenanceWindow {#DailyMaintenanceWindow4}

Field | Description
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required. Window start time, in the UTC timezone. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Window duration. Acceptable values are 1h to 24h, inclusive.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow4}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow4)**<br>Days of the week and the maintenance window for these days when automatic updates are allowed. The number of elements must be in the range 1-7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow4}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br>Days of the week when automatic updates are allowed. The number of elements must be in the range 1-7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required. Window start time, in the UTC timezone. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Window duration. Acceptable values are 1h to 24h, inclusive.


### MasterLogging {#MasterLogging4}

Field | Description
--- | ---
enabled | **bool**<br>Identifies whether Cloud Logging is enabled for master components. 
destination | **oneof:** `log_group_id` or `folder_id`<br>The destination of master components' logs.
&nbsp;&nbsp;log_group_id | **string**<br>ID of the log group where logs of master components should be stored. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder where logs should be stored (in default group). Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
audit_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for audit logs. 
cluster_autoscaler_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for cluster-autoscaler. 
kube_apiserver_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for kube-apiserver. 
events_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for events. 


### IPAllocationPolicy {#IPAllocationPolicy4}

Field | Description
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR block. IP range for allocating pod addresses. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets. 
node_ipv4_cidr_mask_size | **int64**<br>Size of the masks that are assigned for each node in the cluster. <br>If not specified, 24 is used. Value must be equal to 0,24,25,26,27,28.
service_ipv4_cidr_block | **string**<br>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. 
cluster_ipv6_cidr_block | **string**<br>IPv6 range for allocating pod IP addresses. 
service_ipv6_cidr_block | **string**<br>IPv6 range for allocating Kubernetes service IP addresses 


### NetworkPolicy {#NetworkPolicy4}

Field | Description
--- | ---
provider | enum **Provider**<br> 


### KMSProvider {#KMSProvider4}

Field | Description
--- | ---
key_id | **string**<br>KMS key ID for secrets encryption. To obtain a KMS key ID use a [yandex.cloud.kms.v1.SymmetricKeyService.List](/docs/kms/api-ref/grpc/symmetric_key_service#List) request. 


### Cilium {#Cilium4}

Field | Description
--- | ---
routing_mode | enum **RoutingMode**<br> 


## Start {#Start}

Starts the specified Kubernetes cluster.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StartClusterRequest {#StartClusterRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Kubernetes cluster to start. To get Kubernetes cluster ID use a [ClusterService.List](#List) request. 


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
cluster_id | **string**<br>ID of the Kubernetes cluster that is being started. 


### Cluster {#Cluster5}

Field | Description
--- | ---
id | **string**<br>ID of the Kubernetes cluster. 
folder_id | **string**<br>ID of the folder that the Kubernetes cluster belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the Kubernetes cluster. 
description | **string**<br>Description of the Kubernetes cluster. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the Kubernetes cluster. <ul><li>`PROVISIONING`: Kubernetes cluster is waiting for resources to be allocated.</li><li>`RUNNING`: Kubernetes cluster is running.</li><li>`RECONCILING`: Kubernetes cluster is being reconciled.</li><li>`STOPPING`: Kubernetes cluster is being stopped.</li><li>`STOPPED`: Kubernetes cluster stopped.</li><li>`DELETING`: Kubernetes cluster is being deleted.</li><li>`STARTING`: Kubernetes cluster is being started.</li></ul>
health | enum **Health**<br>Health of the Kubernetes cluster. <ul><li>`HEALTHY`: Kubernetes cluster is alive and well.</li><li>`UNHEALTHY`: Kubernetes cluster is inoperable.</li></ul>
network_id | **string**<br>ID of the network the Kubernetes cluster belongs to. 
master | **[Master](#Master5)**<br>Properties of the master for the Kubernetes cluster. 
ip_allocation_policy | **[IPAllocationPolicy](#IPAllocationPolicy5)**<br>Allocation policy for IP addresses of services and pods inside the Kubernetes cluster in different availability zones. 
internet_gateway | **oneof:** `gateway_ipv4_address`<br>
&nbsp;&nbsp;gateway_ipv4_address | **string**<br>Gateway IPv4 address. The maximum string length in characters is 15.
service_account_id | **string**<br>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. 
node_service_account_id | **string**<br>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. 
release_channel | enum **ReleaseChannel**<br>When creating a Kubernetes cluster, you should specify one of three release channels. The release channel contains several Kubernetes versions. Channels differ in the set of available versions, the management of auto-updates, and the updates received. You can't change the channel once the Kubernetes cluster is created, you can only recreate the Kubernetes cluster and specify a new release channel. For more details see [documentation](https://cloud.yandex.com/docs/managed-kubernetes/concepts/release-channels-and-updates). <ul><li>`RAPID`: Minor updates with new functions and improvements are often added. You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.</li><li>`REGULAR`: New functions and improvements are added in chunks shortly after they appear on `RAPID`.</li><li>`STABLE`: Only updates related to bug fixes or security improvements are added.</li></ul>
network_policy | **[NetworkPolicy](#NetworkPolicy5)**<br> 
kms_provider | **[KMSProvider](#KMSProvider5)**<br>KMS provider configuration. 
log_group_id | **string**<br>Log group where cluster stores cluster system logs, like audit, events, or controlplane logs. 
network_implementation | **oneof:** `cilium`<br>
&nbsp;&nbsp;cilium | **[Cilium](#Cilium5)**<br> 


### Master {#Master5}

Field | Description
--- | ---
master_type | **oneof:** `zonal_master` or `regional_master`<br>
&nbsp;&nbsp;zonal_master | **[ZonalMaster](#ZonalMaster5)**<br>Parameters of the availability zone for the master. 
&nbsp;&nbsp;regional_master | **[RegionalMaster](#RegionalMaster5)**<br>Parameters of the region for the master. 
locations[] | **[Location](#Location5)**<br>Locations specification for Kubernetes control-plane (master) instances. 
etcd_cluster_size | **int64**<br>Number of etcd nodes in cluster. 
version | **string**<br>Version of Kubernetes components that runs on the master. 
endpoints | **[MasterEndpoints](#MasterEndpoints5)**<br>Endpoints of the master. Endpoints constitute of scheme and port (i.e. `https://ip-address:port`) and can be used by the clients to communicate with the Kubernetes API of the Kubernetes cluster. 
master_auth | **[MasterAuth](#MasterAuth5)**<br>Master authentication parameters are used to establish trust between the master and a client. 
version_info | **[VersionInfo](#VersionInfo5)**<br>Detailed information about the Kubernetes version that is running on the master. 
maintenance_policy | **[MasterMaintenancePolicy](#MasterMaintenancePolicy5)**<br>Maintenance policy of the master. 
security_group_ids[] | **string**<br>Master security groups. 
master_logging | **[MasterLogging](#MasterLogging5)**<br>Cloud Logging for master components. 


### ZonalMaster {#ZonalMaster5}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the master resides. 
internal_v4_address | **string**<br>IPv4 internal network address that is assigned to the master. 
external_v4_address | **string**<br>IPv4 external network address that is assigned to the master. 


### RegionalMaster {#RegionalMaster5}

Field | Description
--- | ---
region_id | **string**<br>ID of the region where the master resides. 
internal_v4_address | **string**<br>IPv4 internal network address that is assigned to the master. 
external_v4_address | **string**<br>IPv4 external network address that is assigned to the master. 
external_v6_address | **string**<br>IPv6 external network address that is assigned to the master. 


### Location {#Location5}

Field | Description
--- | ---
zone_id | **string**<br>ID of the availability zone where the master resides. 
subnet_id | **string**<br>ID of the VPC network's subnet where the master resides. 


### MasterEndpoints {#MasterEndpoints5}

Field | Description
--- | ---
internal_v4_endpoint | **string**<br>Internal endpoint that can be used to connect to the master from cloud networks. 
external_v4_endpoint | **string**<br>External endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud). 
external_v6_endpoint | **string**<br>External IPv6 endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud). 


### MasterAuth {#MasterAuth5}

Field | Description
--- | ---
cluster_ca_certificate | **string**<br>PEM-encoded public certificate that is the root of trust for the Kubernetes cluster. 


### VersionInfo {#VersionInfo5}

Field | Description
--- | ---
current_version | **string**<br>Current Kubernetes version, format: major.minor (e.g. 1.15). 
new_revision_available | **bool**<br>Newer revisions may include Kubernetes patches (e.g 1.15.1 -> 1.15.2) as well as some internal component updates - new features or bug fixes in platform specific components either on the master or nodes. 
new_revision_summary | **string**<br>Description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false. 
version_deprecated | **bool**<br>The current version is on the deprecation schedule, component (master or node group) should be upgraded. 


### MasterMaintenancePolicy {#MasterMaintenancePolicy5}

Field | Description
--- | ---
auto_upgrade | **bool**<br>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow5)**<br>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC. 


### MaintenanceWindow {#MaintenanceWindow5}

Field | Description
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` or `weekly_maintenance_window`<br>Maintenance policy.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow5)**<br>Updating the master at any time. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow5)**<br>Updating the master on any day during the specified time window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow5)**<br>Updating the master on selected days during the specified time window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow5}

Empty.

### DailyMaintenanceWindow {#DailyMaintenanceWindow5}

Field | Description
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required. Window start time, in the UTC timezone. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Window duration. Acceptable values are 1h to 24h, inclusive.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow5}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow5)**<br>Days of the week and the maintenance window for these days when automatic updates are allowed. The number of elements must be in the range 1-7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow5}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br>Days of the week when automatic updates are allowed. The number of elements must be in the range 1-7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required. Window start time, in the UTC timezone. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Window duration. Acceptable values are 1h to 24h, inclusive.


### MasterLogging {#MasterLogging5}

Field | Description
--- | ---
enabled | **bool**<br>Identifies whether Cloud Logging is enabled for master components. 
destination | **oneof:** `log_group_id` or `folder_id`<br>The destination of master components' logs.
&nbsp;&nbsp;log_group_id | **string**<br>ID of the log group where logs of master components should be stored. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder where logs should be stored (in default group). Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
audit_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for audit logs. 
cluster_autoscaler_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for cluster-autoscaler. 
kube_apiserver_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for kube-apiserver. 
events_enabled | **bool**<br>Identifies whether Cloud Logging is enabled for events. 


### IPAllocationPolicy {#IPAllocationPolicy5}

Field | Description
--- | ---
cluster_ipv4_cidr_block | **string**<br>CIDR block. IP range for allocating pod addresses. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets. 
node_ipv4_cidr_mask_size | **int64**<br>Size of the masks that are assigned for each node in the cluster. <br>If not specified, 24 is used. Value must be equal to 0,24,25,26,27,28.
service_ipv4_cidr_block | **string**<br>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from. <br>It should not overlap with any subnet in the network the Kubernetes cluster located in. 
cluster_ipv6_cidr_block | **string**<br>IPv6 range for allocating pod IP addresses. 
service_ipv6_cidr_block | **string**<br>IPv6 range for allocating Kubernetes service IP addresses 


### NetworkPolicy {#NetworkPolicy5}

Field | Description
--- | ---
provider | enum **Provider**<br> 


### KMSProvider {#KMSProvider5}

Field | Description
--- | ---
key_id | **string**<br>KMS key ID for secrets encryption. To obtain a KMS key ID use a [yandex.cloud.kms.v1.SymmetricKeyService.List](/docs/kms/api-ref/grpc/symmetric_key_service#List) request. 


### Cilium {#Cilium5}

Field | Description
--- | ---
routing_mode | enum **RoutingMode**<br> 


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
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterNodeGroupsRequest.page_size](#ListClusterNodeGroupsRequest), use the `next_page_token` as the value for the [ListClusterNodeGroupsRequest.page_token](#ListClusterNodeGroupsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### NodeGroup {#NodeGroup}

Field | Description
--- | ---
id | **string**<br>ID of the node group. 
cluster_id | **string**<br>ID of the cluster that the node group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the node group. The name is unique within the folder. 
description | **string**<br>Description of the node group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the node group. <ul><li>`PROVISIONING`: Node group is waiting for resources to be allocated.</li><li>`RUNNING`: Node group is running.</li><li>`RECONCILING`: Node group is waiting for some work to be done, such as upgrading node software.</li><li>`STOPPING`: Node group is being stopped.</li><li>`STOPPED`: Node group stopped.</li><li>`DELETING`: Node group is being deleted.</li><li>`STARTING`: Node group is being started.</li></ul>
node_template | **[NodeTemplate](#NodeTemplate)**<br>Node template that specifies parameters of the compute instances for the node group. 
scale_policy | **[ScalePolicy](#ScalePolicy)**<br>Scale policy of the node group.  For more information, see [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). 
allocation_policy | **[NodeGroupAllocationPolicy](#NodeGroupAllocationPolicy)**<br>Allocation policy by which resources for node group are allocated to zones and regions. 
deploy_policy | **[DeployPolicy](#DeployPolicy)**<br>Deploy policy according to which the updates are rolled out. 
instance_group_id | **string**<br>ID of the managed instance group associated with this node group. 
node_version | **string**<br>Version of Kubernetes components that runs on the nodes. Deprecated. Use version_info.current_version. 
version_info | **[VersionInfo](#VersionInfo6)**<br>Detailed information about the Kubernetes version that is running on the node. 
maintenance_policy | **[NodeGroupMaintenancePolicy](#NodeGroupMaintenancePolicy)**<br>Maintenance policy of the node group. 
allowed_unsafe_sysctls[] | **string**<br>Support for unsafe sysctl parameters. For more details see [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). 
node_taints[] | **[Taint](#Taint)**<br>Taints that are applied to the nodes of the node group at creation time. 
node_labels | **map<string,string>**<br>Labels that are assigned to the nodes of the node group at creation time. 


### NodeTemplate {#NodeTemplate}

Field | Description
--- | ---
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
labels | **map<string,string>**<br>these labels will be assigned to compute nodes (instances), created by the nodegroup No more than 32 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>ID of the hardware platform configuration for the node. 
resources_spec | **[ResourcesSpec](#ResourcesSpec)**<br>Computing resources of the node such as the amount of memory and number of cores. 
boot_disk_spec | **[DiskSpec](#DiskSpec)**<br>Specification for the boot disk that will be attached to the node. 
metadata | **map<string,string>**<br>The metadata as `key:value` pairs assigned to this instance template. Only SSH keys are supported as metadata. <br>For more information, see [Connecting to a node over SSH](/docs/managed-kubernetes/operations/node-connect-ssh). No more than 64 per resource. The maximum string length in characters for each value is 131072. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
v4_address_spec | **[NodeAddressSpec](#NodeAddressSpec)**<br>Specification for the create network interfaces for the node group compute instances. Deprecated, please use network_interface_specs. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy)**<br>Scheduling policy configuration. 
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec)**<br>New api, to specify network interfaces for the node group compute instances. Can not be used together with 'v4_address_spec' 
placement_policy | **[PlacementPolicy](#PlacementPolicy)**<br> 
network_settings | **[NetworkSettings](#NetworkSettings)**<br>this parameter allows to specify type of network acceleration used on nodes (instances) 
container_runtime_settings | **[ContainerRuntimeSettings](#ContainerRuntimeSettings)**<br> 
container_network_settings | **[ContainerNetworkSettings](#ContainerNetworkSettings)**<br> 
gpu_settings | **[GpuSettings](#GpuSettings)**<br>GPU settings 


### NetworkSettings {#NetworkSettings}

Field | Description
--- | ---
type | enum **Type**<br>Required.  


### ContainerRuntimeSettings {#ContainerRuntimeSettings}

Field | Description
--- | ---
type | enum **Type**<br>Required.  


### ContainerNetworkSettings {#ContainerNetworkSettings}

Field | Description
--- | ---
pod_mtu | **int64**<br> 


### ResourcesSpec {#ResourcesSpec}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the node, specified in bytes. The minimum value is 0.
cores | **int64**<br>Number of cores available to the node. The minimum value is 0.
core_fraction | **int64**<br>Baseline level of CPU performance with the possibility to burst performance above that baseline level. This field sets baseline performance for each core. Acceptable values are 0 to 100, inclusive.
gpus | **int64**<br>Number of GPUs available to the node. The minimum value is 0.


### DiskSpec {#DiskSpec}

Field | Description
--- | ---
disk_type_id | **string**<br>ID of the disk type. Value must match the regular expression ` \|network-ssd\|network-hdd\|network-ssd-nonreplicated `.
disk_size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 0 to 4398046511104, inclusive.


### NodeAddressSpec {#NodeAddressSpec}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec)**<br>One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec)**<br>Internal DNS configuration. 


### OneToOneNatSpec {#OneToOneNatSpec}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>


### DnsRecordSpec {#DnsRecordSpec}

Field | Description
--- | ---
fqdn | **string**<br>Required. FQDN (required). 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, private zone is used). 
ttl | **int64**<br>DNS record ttl, values in 0-86400 (optional). Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When set to true, also create PTR DNS record (optional). 


### SchedulingPolicy {#SchedulingPolicy}

Field | Description
--- | ---
preemptible | **bool**<br>True for preemptible compute instances. Default value is false. Preemptible compute instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkInterfaceSpec {#NetworkInterfaceSpec}

Field | Description
--- | ---
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[NodeAddressSpec](#NodeAddressSpec1)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[NodeAddressSpec](#NodeAddressSpec1)**<br>Primary IPv6 address that is assigned to the instance for this network interface. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PlacementPolicy {#PlacementPolicy}

Field | Description
--- | ---
placement_group_id | **string**<br>Identifier of placement group 


### GpuSettings {#GpuSettings}

Field | Description
--- | ---
gpu_cluster_id | **string**<br>GPU cluster id, that mk8s node will join. 
gpu_environment | enum **GpuEnvironment**<br>GPU environment configured on node. <ul><li>`GPU_ENVIRONMENT_UNSPECIFIED`: Use one of the values below, depending on the default for the specific Cloud installation.</li><li>`RUNC_DRIVERS_CUDA`: Use a node image with the pre-installed GPU toolkit, drivers and CUDA.</li><li>`RUNC`: Use a node image with the pre-installed GPU toolkit but without drivers. You should install drivers on a node yourself in that case. There are tools to help you to do that, for example gpu-operator.</li></ul>


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


### DeployPolicy {#DeployPolicy}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.


### VersionInfo {#VersionInfo6}

Field | Description
--- | ---
current_version | **string**<br>Current Kubernetes version, format: major.minor (e.g. 1.15). 
new_revision_available | **bool**<br>Newer revisions may include Kubernetes patches (e.g 1.15.1 -> 1.15.2) as well as some internal component updates - new features or bug fixes in platform specific components either on the master or nodes. 
new_revision_summary | **string**<br>Description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false. 
version_deprecated | **bool**<br>The current version is on the deprecation schedule, component (master or node group) should be upgraded. 


### NodeGroupMaintenancePolicy {#NodeGroupMaintenancePolicy}

Field | Description
--- | ---
auto_upgrade | **bool**<br>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled. 
auto_repair | **bool**<br>If set to true, automatic repairs are enabled. Default value is false. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow6)**<br>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC. 


### MaintenanceWindow {#MaintenanceWindow6}

Field | Description
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` or `weekly_maintenance_window`<br>Maintenance policy.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow6)**<br>Updating the master at any time. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow6)**<br>Updating the master on any day during the specified time window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow6)**<br>Updating the master on selected days during the specified time window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow6}

Empty.

### DailyMaintenanceWindow {#DailyMaintenanceWindow6}

Field | Description
--- | ---
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required. Window start time, in the UTC timezone. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Window duration. Acceptable values are 1h to 24h, inclusive.


### WeeklyMaintenanceWindow {#WeeklyMaintenanceWindow6}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekMaintenanceWindow](#DaysOfWeekMaintenanceWindow6)**<br>Days of the week and the maintenance window for these days when automatic updates are allowed. The number of elements must be in the range 1-7.


### DaysOfWeekMaintenanceWindow {#DaysOfWeekMaintenanceWindow6}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br>Days of the week when automatic updates are allowed. The number of elements must be in the range 1-7.
start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required. Window start time, in the UTC timezone. 
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Window duration. Acceptable values are 1h to 24h, inclusive.


### Taint {#Taint}

Field | Description
--- | ---
key | **string**<br>The taint key to be applied to a node. 
value | **string**<br>The taint value corresponding to the taint key. 
effect | enum **Effect**<br>The effect of the taint on pods that do not tolerate the taint. <ul><li>`NO_SCHEDULE`: Do not allow new pods to schedule onto the node unless they tolerate the taint, but allow all pods submitted to Kubelet without going through the scheduler to start, and allow all already-running pods to continue running.</li><li>`PREFER_NO_SCHEDULE`: Like NO_SCHEDULE, but the scheduler tries not to schedule new pods onto the node, rather than prohibiting new pods from scheduling onto the node entirely. Enforced by the scheduler.</li><li>`NO_EXECUTE`: Evict any already-running pods that do not tolerate the taint.</li></ul>


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
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest), use the `next_page_token` as the value for the [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation5}

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


## ListNodes {#ListNodes}

Lists cluster's nodes.

**rpc ListNodes ([ListClusterNodesRequest](#ListClusterNodesRequest)) returns ([ListClusterNodesResponse](#ListClusterNodesResponse))**

### ListClusterNodesRequest {#ListClusterNodesRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Kubernetes cluster to list nodes in. To get the Kubernetes cluster ID use a [ClusterService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListClusterNodesResponse.next_page_token](#ListClusterNodesResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListClusterNodeGroupsResponse.next_page_token](#ListClusterNodeGroupsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListClusterNodesResponse {#ListClusterNodesResponse}

Field | Description
--- | ---
nodes[] | **[Node](#Node)**<br>List of nodes for the specified Kubernetes cluster. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListClusterNodesRequest.page_size](#ListClusterNodesRequest), use the `next_page_token` as the value for the [ListClusterNodesRequest.page_token](#ListClusterNodesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Node {#Node}

Field | Description
--- | ---
status | enum **Status**<br>Computed node status. <ul><li>`PROVISIONING`: Node instance is not yet created (e.g. in progress).</li><li>`NOT_CONNECTED`: Node instance is created but not registered (e.g. is still initializing).</li><li>`NOT_READY`: Node has connected but is not ready for workload (see conditions for details).</li><li>`READY`: Node has connected and ready for workload.</li><li>`MISSING`: Node is still registered but its instance is deleted (this is our bug).</li><li>`STOPPED`: Node is stopped</li><li>`UNKNOWN`: Backend request to kubernetes api was unsuccessful.</li></ul>
spec | **[Spec](#Spec)**<br>Node specificaion. 
cloud_status | **[CloudStatus](#CloudStatus)**<br>Cloud instance status. Not available in `MISSING` status. 
kubernetes_status | **[KubernetesStatus](#KubernetesStatus)**<br>Kubernetes node status. Not available in `PROVISIONING` and `NOT_CONNECTED` states. 


### KubernetesStatus {#KubernetesStatus}

Field | Description
--- | ---
id | **string**<br>Node id (and instance name) 
conditions[] | **[Condition](#Condition)**<br>Conditions is an array of current observed node conditions. More info: https://kubernetes.io/docs/concepts/nodes/node/#condition 
taints[] | **[Taint](#Taint1)**<br>If specified, the node's taints. 
attached_volumes[] | **[AttachedVolume](#AttachedVolume)**<br>List of volumes that are attached to the node. 


### CloudStatus {#CloudStatus}

Field | Description
--- | ---
id | **string**<br>Compute instance id 
status | **string**<br>IG instance status 
status_message | **string**<br>IG instance status message 


### Spec {#Spec}

Field | Description
--- | ---
resources | **[ResourcesSpec](#ResourcesSpec1)**<br>Node group specified resources. 
disk | **[DiskSpec](#DiskSpec1)**<br>Node group specified disk. 


### Condition {#Condition}

Field | Description
--- | ---
type | **string**<br>Type of node condition. 
status | **string**<br>Status is the status of the condition. 
message | **string**<br>Human-readable message indicating details about last transition. 
last_heartbeat_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Last time we got an update on a given condition. 
last_transition_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Last time the condition transit from one status to another. 


### Taint {#Taint1}

Field | Description
--- | ---
key | **string**<br>The taint key to be applied to a node. 
value | **string**<br>The taint value corresponding to the taint key. 
effect | enum **Effect**<br>The effect of the taint on pods that do not tolerate the taint. <ul><li>`NO_SCHEDULE`: Do not allow new pods to schedule onto the node unless they tolerate the taint, but allow all pods submitted to Kubelet without going through the scheduler to start, and allow all already-running pods to continue running.</li><li>`PREFER_NO_SCHEDULE`: Like NO_SCHEDULE, but the scheduler tries not to schedule new pods onto the node, rather than prohibiting new pods from scheduling onto the node entirely. Enforced by the scheduler.</li><li>`NO_EXECUTE`: Evict any already-running pods that do not tolerate the taint.</li></ul>


### AttachedVolume {#AttachedVolume}

Field | Description
--- | ---
driver_name | **string**<br>Name of the driver which has attached the volume 
volume_handle | **string**<br>Volume handle (cloud disk id) 


### ResourcesSpec {#ResourcesSpec1}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the node, specified in bytes. The minimum value is 0.
cores | **int64**<br>Number of cores available to the node. The minimum value is 0.
core_fraction | **int64**<br>Baseline level of CPU performance with the possibility to burst performance above that baseline level. This field sets baseline performance for each core. Acceptable values are 0 to 100, inclusive.
gpus | **int64**<br>Number of GPUs available to the node. The minimum value is 0.


### DiskSpec {#DiskSpec1}

Field | Description
--- | ---
disk_type_id | **string**<br>ID of the disk type. Value must match the regular expression ` \|network-ssd\|network-hdd\|network-ssd-nonreplicated `.
disk_size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 0 to 4398046511104, inclusive.


