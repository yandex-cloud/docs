---
editable: false
---

# NodeGroupService

A set of methods for managing node groups.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified node group. |
| [List](#List) | Retrieves the list of node group in the specified Kubernetes cluster. |
| [Create](#Create) | Creates a node group in the specified Kubernetes cluster. |
| [Update](#Update) | Updates the specified node group. |
| [Delete](#Delete) | Deletes the specified node group. |
| [ListOperations](#ListOperations) | Lists operations for the specified node group. |

## Calls NodeGroupService {#calls}

## Get {#Get}

Returns the specified node group. <br>To get the list of available node group, make a [List](#List) request.

**rpc Get ([GetNodeGroupRequest](#GetNodeGroupRequest)) returns ([NodeGroup](#NodeGroup))**

### GetNodeGroupRequest {#GetNodeGroupRequest}

Field | Description
--- | ---
node_group_id | **string**<br>Required. ID of the node group to return. To get the node group ID use a [NodeGroupService.List](#List) request. 


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
version_info | **[VersionInfo](#VersionInfo)**<br> 
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


## List {#List}

Retrieves the list of node group in the specified Kubernetes cluster.

**rpc List ([ListNodeGroupsRequest](#ListNodeGroupsRequest)) returns ([ListNodeGroupsResponse](#ListNodeGroupsResponse))**

### ListNodeGroupsRequest {#ListNodeGroupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list node groups in. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListNodeGroupsResponse.next_page_token](#ListNodeGroupsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListNodeGroupsResponse.next_page_token](#ListNodeGroupsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently you can use filtering only on [NodeGroup.name](#NodeGroup1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 1-61 characters long and match the regular expression `|[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> The maximum string length in characters is 1000.


### ListNodeGroupsResponse {#ListNodeGroupsResponse}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup1)**<br>List of node groups. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListNodeGroupsRequest.page_size](#ListNodeGroupsRequest1), use the `next_page_token` as the value for the [ListNodeGroupsRequest.page_token](#ListNodeGroupsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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
node_template | **[NodeTemplate](#NodeTemplate1)**<br>Node template that specifies parameters of the compute instances for the node group. 
scale_policy | **[ScalePolicy](#ScalePolicy1)**<br>Scale policy of the node group.  For more information, see [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). 
allocation_policy | **[NodeGroupAllocationPolicy](#NodeGroupAllocationPolicy1)**<br>Allocation policy by which resources for node group are allocated to zones and regions. 
instance_group_id | **string**<br>ID of the managed instance group associated with this node group. 
node_version | **string**<br>Version of Kubernetes components that runs on the nodes. Deprecated. Use version_info.current_version. 
version_info | **[VersionInfo](#VersionInfo1)**<br> 
maintenance_policy | **[NodeGroupMaintenancePolicy](#NodeGroupMaintenancePolicy1)**<br> 


### NodeTemplate {#NodeTemplate}

Field | Description
--- | ---
platform_id | **string**<br>ID of the hardware platform configuration for the node. 
resources_spec | **[ResourcesSpec](#ResourcesSpec1)**<br>Computing resources of the node such as the amount of memory and number of cores. 
boot_disk_spec | **[DiskSpec](#DiskSpec1)**<br>Specification for the boot disk that will be attached to the node. The metadata as `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the node. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
metadata | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 131072. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
v4_address_spec | **[NodeAddressSpec](#NodeAddressSpec1)**<br>Specification for the create network interfaces for the node group compute instances. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy1)**<br>Scheduling policy configuration. 


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
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec1)**<br>One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up. 


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
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale1)**<br>Fixed scale policy of the node group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale1)**<br>Auto scale policy of the node group. 


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
locations[] | **[NodeGroupLocation](#NodeGroupLocation1)**<br>List of locations where resources for the node group will be allocated. 


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


## Create {#Create}

Creates a node group in the specified Kubernetes cluster.

**rpc Create ([CreateNodeGroupRequest](#CreateNodeGroupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateNodeGroupMetadata](#CreateNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[NodeGroup](#NodeGroup2)<br>

### CreateNodeGroupRequest {#CreateNodeGroupRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Kubernetes cluster to create a node group in. To get the Kubernetes cluster ID, use a [ClusterService.List](./cluster_service#List) request. 
name | **string**<br>Name of the node group. The name must be unique within the folder. Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the node group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
node_template | **[NodeTemplate](#NodeTemplate2)**<br>Required. Node template for creating the node group. 
scale_policy | **[ScalePolicy](#ScalePolicy2)**<br>Required. Scale policy of the node group. 
allocation_policy | **[NodeGroupAllocationPolicy](#NodeGroupAllocationPolicy2)**<br>Allocation policy of the node group by the zones and regions. 
version | **string**<br> 
maintenance_policy | **[NodeGroupMaintenancePolicy](#NodeGroupMaintenancePolicy2)**<br> 
allowed_unsafe_sysctls[] | **string**<br> 


### NodeTemplate {#NodeTemplate}

Field | Description
--- | ---
platform_id | **string**<br>ID of the hardware platform configuration for the node. 
resources_spec | **[ResourcesSpec](#ResourcesSpec2)**<br>Computing resources of the node such as the amount of memory and number of cores. 
boot_disk_spec | **[DiskSpec](#DiskSpec2)**<br>Specification for the boot disk that will be attached to the node. The metadata as `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the node. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
metadata | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 131072. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
v4_address_spec | **[NodeAddressSpec](#NodeAddressSpec2)**<br>Specification for the create network interfaces for the node group compute instances. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy2)**<br>Scheduling policy configuration. 


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
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec2)**<br>One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up. 


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
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale2)**<br>Fixed scale policy of the node group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale2)**<br>Auto scale policy of the node group. 


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
locations[] | **[NodeGroupLocation](#NodeGroupLocation2)**<br>List of locations where resources for the node group will be allocated. 


### NodeGroupLocation {#NodeGroupLocation}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the nodes may reside. 
subnet_id | **string**<br>ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted. 


### NodeGroupMaintenancePolicy {#NodeGroupMaintenancePolicy}

Field | Description
--- | ---
auto_upgrade | **bool**<br> 
auto_repair | **bool**<br> 
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


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateNodeGroupMetadata](#CreateNodeGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[NodeGroup](#NodeGroup2)>**<br>if operation finished successfully. 


### CreateNodeGroupMetadata {#CreateNodeGroupMetadata}

Field | Description
--- | ---
node_group_id | **string**<br>ID of the node group that is being created. 


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
node_template | **[NodeTemplate](#NodeTemplate3)**<br>Node template that specifies parameters of the compute instances for the node group. 
scale_policy | **[ScalePolicy](#ScalePolicy3)**<br>Scale policy of the node group.  For more information, see [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). 
allocation_policy | **[NodeGroupAllocationPolicy](#NodeGroupAllocationPolicy3)**<br>Allocation policy by which resources for node group are allocated to zones and regions. 
instance_group_id | **string**<br>ID of the managed instance group associated with this node group. 
node_version | **string**<br>Version of Kubernetes components that runs on the nodes. Deprecated. Use version_info.current_version. 
version_info | **[VersionInfo](#VersionInfo2)**<br> 
maintenance_policy | **[NodeGroupMaintenancePolicy](#NodeGroupMaintenancePolicy3)**<br> 


## Update {#Update}

Updates the specified node group.

**rpc Update ([UpdateNodeGroupRequest](#UpdateNodeGroupRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateNodeGroupMetadata](#UpdateNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[NodeGroup](#NodeGroup3)<br>

### UpdateNodeGroupRequest {#UpdateNodeGroupRequest}

Field | Description
--- | ---
node_group_id | **string**<br>Required. ID of the node group to update. To get the node group ID use a [NodeGroupService.List](#List) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the node group are going to be updated. 
name | **string**<br>Name of the node group. The name must be unique within the folder. Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the node group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. <br>Existing set of `labels` is completely replaced by the provided set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
node_template | **[NodeTemplate](#NodeTemplate3)**<br>Node template for the node group. Change may trigger nodes rolling reboot or recreate. 
scale_policy | **[ScalePolicy](#ScalePolicy3)**<br>Scale policy of the node group. 
allocation_policy | **[NodeGroupAllocationPolicy](#NodeGroupAllocationPolicy3)**<br>Allocation policy of the node group by the zones and regions. 
version | **[UpdateVersionSpec](#UpdateVersionSpec)**<br> 
maintenance_policy | **[NodeGroupMaintenancePolicy](#NodeGroupMaintenancePolicy3)**<br> 
allowed_unsafe_sysctls[] | **string**<br> 


### NodeTemplate {#NodeTemplate}

Field | Description
--- | ---
platform_id | **string**<br>ID of the hardware platform configuration for the node. 
resources_spec | **[ResourcesSpec](#ResourcesSpec3)**<br>Computing resources of the node such as the amount of memory and number of cores. 
boot_disk_spec | **[DiskSpec](#DiskSpec3)**<br>Specification for the boot disk that will be attached to the node. The metadata as `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the node. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
metadata | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 131072. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
v4_address_spec | **[NodeAddressSpec](#NodeAddressSpec3)**<br>Specification for the create network interfaces for the node group compute instances. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy3)**<br>Scheduling policy configuration. 


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
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec3)**<br>One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up. 


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
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale3)**<br>Fixed scale policy of the node group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale3)**<br>Auto scale policy of the node group. 


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
locations[] | **[NodeGroupLocation](#NodeGroupLocation3)**<br>List of locations where resources for the node group will be allocated. 


### NodeGroupLocation {#NodeGroupLocation}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the nodes may reside. 
subnet_id | **string**<br>ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted. 


### UpdateVersionSpec {#UpdateVersionSpec}

Field | Description
--- | ---
specifier | **oneof:** `version` or `latest_revision`<br>
&nbsp;&nbsp;version | **string**<br>Request update to a newer version of kubernetes (1.x -> 1.y). 
&nbsp;&nbsp;latest_revision | **bool**<br>Request update to the latest revision for the current version. 


### NodeGroupMaintenancePolicy {#NodeGroupMaintenancePolicy}

Field | Description
--- | ---
auto_upgrade | **bool**<br> 
auto_repair | **bool**<br> 
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateNodeGroupMetadata](#UpdateNodeGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[NodeGroup](#NodeGroup3)>**<br>if operation finished successfully. 


### UpdateNodeGroupMetadata {#UpdateNodeGroupMetadata}

Field | Description
--- | ---
node_group_id | **string**<br>Required. ID of the Node group that is being updated. 


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
node_template | **[NodeTemplate](#NodeTemplate4)**<br>Node template that specifies parameters of the compute instances for the node group. 
scale_policy | **[ScalePolicy](#ScalePolicy4)**<br>Scale policy of the node group.  For more information, see [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). 
allocation_policy | **[NodeGroupAllocationPolicy](#NodeGroupAllocationPolicy4)**<br>Allocation policy by which resources for node group are allocated to zones and regions. 
instance_group_id | **string**<br>ID of the managed instance group associated with this node group. 
node_version | **string**<br>Version of Kubernetes components that runs on the nodes. Deprecated. Use version_info.current_version. 
version_info | **[VersionInfo](#VersionInfo2)**<br> 
maintenance_policy | **[NodeGroupMaintenancePolicy](#NodeGroupMaintenancePolicy4)**<br> 


## Delete {#Delete}

Deletes the specified node group.

**rpc Delete ([DeleteNodeGroupRequest](#DeleteNodeGroupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteNodeGroupMetadata](#DeleteNodeGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteNodeGroupRequest {#DeleteNodeGroupRequest}

Field | Description
--- | ---
node_group_id | **string**<br>Required. ID of the node group to delete. To get node group ID use a [NodeGroupService.List](#List) request. 


### Operation {#Operation}

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
node_group_id | **string**<br>ID of the node group that is being deleted. 


## ListOperations {#ListOperations}

Lists operations for the specified node group.

**rpc ListOperations ([ListNodeGroupOperationsRequest](#ListNodeGroupOperationsRequest)) returns ([ListNodeGroupOperationsResponse](#ListNodeGroupOperationsResponse))**

### ListNodeGroupOperationsRequest {#ListNodeGroupOperationsRequest}

Field | Description
--- | ---
node_group_id | **string**<br>Required. ID of the node group to list operations for. 
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListNodeGroupOperationsResponse.next_page_token](#ListNodeGroupOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListNodeGroupOperationsResponse.next_page_token](#ListNodeGroupOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on [NodeGroup.name](#NodeGroup4) field. The maximum string length in characters is 1000.


### ListNodeGroupOperationsResponse {#ListNodeGroupOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified node group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListNodeGroupOperationsRequest.page_size](#ListNodeGroupOperationsRequest1), use the `next_page_token` as the value for the [ListNodeGroupOperationsRequest.page_token](#ListNodeGroupOperationsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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


