---
editable: false
sourcePath: en/_api-ref-grpc/managed-kubernetes/api-ref/grpc/node_group_service.md
---

# Managed Services for Kubernetes API, gRPC: NodeGroupService

A set of methods for managing node groups.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified node group. |
| [List](#List) | Retrieves the list of node group in the specified Kubernetes cluster. |
| [Create](#Create) | Creates a node group in the specified Kubernetes cluster. |
| [Update](#Update) | Updates the specified node group. |
| [Delete](#Delete) | Deletes the specified node group. |
| [ListOperations](#ListOperations) | Lists operations for the specified node group. |
| [ListNodes](#ListNodes) | Retrieves the list of nodes in the specified Kubernetes cluster. |

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
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the node group. <ul><li>`PROVISIONING`: Node group is waiting for resources to be allocated.</li><li>`RUNNING`: Node group is running.</li><li>`RECONCILING`: Node group is waiting for some work to be done, such as upgrading node software.</li><li>`STOPPING`: Node group is being stopped.</li><li>`STOPPED`: Node group stopped.</li><li>`DELETING`: Node group is being deleted.</li><li>`STARTING`: Node group is being started.</li></ul>
node_template | **[NodeTemplate](#NodeTemplate)**<br>Node template that specifies parameters of the compute instances for the node group. 
scale_policy | **[ScalePolicy](#ScalePolicy)**<br>Scale policy of the node group.  For more information, see [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). 
allocation_policy | **[NodeGroupAllocationPolicy](#NodeGroupAllocationPolicy)**<br>Allocation policy by which resources for node group are allocated to zones and regions. 
deploy_policy | **[DeployPolicy](#DeployPolicy)**<br>Deploy policy according to which the updates are rolled out. 
instance_group_id | **string**<br>ID of the managed instance group associated with this node group. 
node_version | **string**<br>Version of Kubernetes components that runs on the nodes. Deprecated. Use version_info.current_version. 
version_info | **[VersionInfo](#VersionInfo)**<br>Detailed information about the Kubernetes version that is running on the node. 
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
metadata | **map<string,string>**<br>The metadata as `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the node. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 64 per resource. The maximum string length in characters for each value is 131072. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
v4_address_spec | **[NodeAddressSpec](#NodeAddressSpec)**<br>Specification for the create network interfaces for the node group compute instances. Deprecated, please use network_interface_specs. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy)**<br>Scheduling policy configuration. 
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec)**<br>New api, to specify network interfaces for the node group compute instances. Can not be used together with 'v4_address_spec' 
placement_policy | **[PlacementPolicy](#PlacementPolicy)**<br> 
network_settings | **[NetworkSettings](#NetworkSettings)**<br>this parameter allows to specify type of network acceleration used on nodes (instances) 
container_runtime_settings | **[ContainerRuntimeSettings](#ContainerRuntimeSettings)**<br> 


### NetworkSettings {#NetworkSettings}

Field | Description
--- | ---
type | enum **Type**<br>Required.  


### ContainerRuntimeSettings {#ContainerRuntimeSettings}

Field | Description
--- | ---
type | enum **Type**<br>Required.  


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


### VersionInfo {#VersionInfo}

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
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow)**<br>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC. 


### MaintenanceWindow {#MaintenanceWindow}

Field | Description
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` or `weekly_maintenance_window`<br>Maintenance policy.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow)**<br>Updating the master at any time. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow)**<br>Updating the master on any day during the specified time window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow)**<br>Updating the master on selected days during the specified time window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow}



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


### Taint {#Taint}

Field | Description
--- | ---
key | **string**<br>The taint key to be applied to a node. 
value | **string**<br>The taint value corresponding to the taint key. 
effect | enum **Effect**<br>The effect of the taint on pods that do not tolerate the taint. <ul><li>`NO_SCHEDULE`: Do not allow new pods to schedule onto the node unless they tolerate the taint, but allow all pods submitted to Kubelet without going through the scheduler to start, and allow all already-running pods to continue running.</li><li>`PREFER_NO_SCHEDULE`: Like NO_SCHEDULE, but the scheduler tries not to schedule new pods onto the node, rather than prohibiting new pods from scheduling onto the node entirely. Enforced by the scheduler.</li><li>`NO_EXECUTE`: Evict any already-running pods that do not tolerate the taint.</li></ul>


## List {#List}

Retrieves the list of node group in the specified Kubernetes cluster.

**rpc List ([ListNodeGroupsRequest](#ListNodeGroupsRequest)) returns ([ListNodeGroupsResponse](#ListNodeGroupsResponse))**

### ListNodeGroupsRequest {#ListNodeGroupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list node groups in. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListNodeGroupsResponse.next_page_token](#ListNodeGroupsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListNodeGroupsResponse.next_page_token](#ListNodeGroupsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on [NodeGroup.name](#NodeGroup1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> The maximum string length in characters is 1000.


### ListNodeGroupsResponse {#ListNodeGroupsResponse}

Field | Description
--- | ---
node_groups[] | **[NodeGroup](#NodeGroup1)**<br>List of node groups. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListNodeGroupsRequest.page_size](#ListNodeGroupsRequest), use the `next_page_token` as the value for the [ListNodeGroupsRequest.page_token](#ListNodeGroupsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### NodeGroup {#NodeGroup1}

Field | Description
--- | ---
id | **string**<br>ID of the node group. 
cluster_id | **string**<br>ID of the cluster that the node group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the node group. The name is unique within the folder. 
description | **string**<br>Description of the node group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the node group. <ul><li>`PROVISIONING`: Node group is waiting for resources to be allocated.</li><li>`RUNNING`: Node group is running.</li><li>`RECONCILING`: Node group is waiting for some work to be done, such as upgrading node software.</li><li>`STOPPING`: Node group is being stopped.</li><li>`STOPPED`: Node group stopped.</li><li>`DELETING`: Node group is being deleted.</li><li>`STARTING`: Node group is being started.</li></ul>
node_template | **[NodeTemplate](#NodeTemplate1)**<br>Node template that specifies parameters of the compute instances for the node group. 
scale_policy | **[ScalePolicy](#ScalePolicy1)**<br>Scale policy of the node group.  For more information, see [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). 
allocation_policy | **[NodeGroupAllocationPolicy](#NodeGroupAllocationPolicy1)**<br>Allocation policy by which resources for node group are allocated to zones and regions. 
deploy_policy | **[DeployPolicy](#DeployPolicy1)**<br>Deploy policy according to which the updates are rolled out. 
instance_group_id | **string**<br>ID of the managed instance group associated with this node group. 
node_version | **string**<br>Version of Kubernetes components that runs on the nodes. Deprecated. Use version_info.current_version. 
version_info | **[VersionInfo](#VersionInfo1)**<br>Detailed information about the Kubernetes version that is running on the node. 
maintenance_policy | **[NodeGroupMaintenancePolicy](#NodeGroupMaintenancePolicy1)**<br>Maintenance policy of the node group. 
allowed_unsafe_sysctls[] | **string**<br>Support for unsafe sysctl parameters. For more details see [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). 
node_taints[] | **[Taint](#Taint1)**<br>Taints that are applied to the nodes of the node group at creation time. 
node_labels | **map<string,string>**<br>Labels that are assigned to the nodes of the node group at creation time. 


### NodeTemplate {#NodeTemplate1}

Field | Description
--- | ---
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
labels | **map<string,string>**<br>these labels will be assigned to compute nodes (instances), created by the nodegroup No more than 32 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>ID of the hardware platform configuration for the node. 
resources_spec | **[ResourcesSpec](#ResourcesSpec1)**<br>Computing resources of the node such as the amount of memory and number of cores. 
boot_disk_spec | **[DiskSpec](#DiskSpec1)**<br>Specification for the boot disk that will be attached to the node. 
metadata | **map<string,string>**<br>The metadata as `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the node. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 64 per resource. The maximum string length in characters for each value is 131072. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
v4_address_spec | **[NodeAddressSpec](#NodeAddressSpec1)**<br>Specification for the create network interfaces for the node group compute instances. Deprecated, please use network_interface_specs. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy1)**<br>Scheduling policy configuration. 
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec1)**<br>New api, to specify network interfaces for the node group compute instances. Can not be used together with 'v4_address_spec' 
placement_policy | **[PlacementPolicy](#PlacementPolicy1)**<br> 
network_settings | **[NetworkSettings](#NetworkSettings1)**<br>this parameter allows to specify type of network acceleration used on nodes (instances) 
container_runtime_settings | **[ContainerRuntimeSettings](#ContainerRuntimeSettings1)**<br> 


### NetworkSettings {#NetworkSettings1}

Field | Description
--- | ---
type | enum **Type**<br>Required.  


### ContainerRuntimeSettings {#ContainerRuntimeSettings1}

Field | Description
--- | ---
type | enum **Type**<br>Required.  


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


### NodeAddressSpec {#NodeAddressSpec1}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec1)**<br>One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec1)**<br>Internal DNS configuration. 


### OneToOneNatSpec {#OneToOneNatSpec1}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>


### DnsRecordSpec {#DnsRecordSpec1}

Field | Description
--- | ---
fqdn | **string**<br>Required. FQDN (required). 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, private zone is used). 
ttl | **int64**<br>DNS record ttl, values in 0-86400 (optional). Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When set to true, also create PTR DNS record (optional). 


### SchedulingPolicy {#SchedulingPolicy1}

Field | Description
--- | ---
preemptible | **bool**<br>True for preemptible compute instances. Default value is false. Preemptible compute instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkInterfaceSpec {#NetworkInterfaceSpec1}

Field | Description
--- | ---
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[NodeAddressSpec](#NodeAddressSpec2)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[NodeAddressSpec](#NodeAddressSpec2)**<br>Primary IPv6 address that is assigned to the instance for this network interface. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PlacementPolicy {#PlacementPolicy1}

Field | Description
--- | ---
placement_group_id | **string**<br>Identifier of placement group 


### ScalePolicy {#ScalePolicy1}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale1)**<br>Fixed scale policy of the node group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale1)**<br>Auto scale policy of the node group. 


### FixedScale {#FixedScale1}

Field | Description
--- | ---
size | **int64**<br>Number of nodes in the node group. Acceptable values are 0 to 100, inclusive.


### AutoScale {#AutoScale1}

Field | Description
--- | ---
min_size | **int64**<br>Minimum number of nodes in the node group. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Maximum number of nodes in the node group. Acceptable values are 0 to 100, inclusive.
initial_size | **int64**<br>Initial number of nodes in the node group. Acceptable values are 0 to 100, inclusive.


### NodeGroupAllocationPolicy {#NodeGroupAllocationPolicy1}

Field | Description
--- | ---
locations[] | **[NodeGroupLocation](#NodeGroupLocation1)**<br>List of locations where resources for the node group will be allocated. 


### NodeGroupLocation {#NodeGroupLocation1}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the nodes may reside. 
subnet_id | **string**<br>ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted. 


### DeployPolicy {#DeployPolicy1}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.


### VersionInfo {#VersionInfo1}

Field | Description
--- | ---
current_version | **string**<br>Current Kubernetes version, format: major.minor (e.g. 1.15). 
new_revision_available | **bool**<br>Newer revisions may include Kubernetes patches (e.g 1.15.1 -> 1.15.2) as well as some internal component updates - new features or bug fixes in platform specific components either on the master or nodes. 
new_revision_summary | **string**<br>Description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false. 
version_deprecated | **bool**<br>The current version is on the deprecation schedule, component (master or node group) should be upgraded. 


### NodeGroupMaintenancePolicy {#NodeGroupMaintenancePolicy1}

Field | Description
--- | ---
auto_upgrade | **bool**<br>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled. 
auto_repair | **bool**<br>If set to true, automatic repairs are enabled. Default value is false. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow1)**<br>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC. 


### MaintenanceWindow {#MaintenanceWindow1}

Field | Description
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` or `weekly_maintenance_window`<br>Maintenance policy.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow1)**<br>Updating the master at any time. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow1)**<br>Updating the master on any day during the specified time window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow1)**<br>Updating the master on selected days during the specified time window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow1}



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


### Taint {#Taint1}

Field | Description
--- | ---
key | **string**<br>The taint key to be applied to a node. 
value | **string**<br>The taint value corresponding to the taint key. 
effect | enum **Effect**<br>The effect of the taint on pods that do not tolerate the taint. <ul><li>`NO_SCHEDULE`: Do not allow new pods to schedule onto the node unless they tolerate the taint, but allow all pods submitted to Kubelet without going through the scheduler to start, and allow all already-running pods to continue running.</li><li>`PREFER_NO_SCHEDULE`: Like NO_SCHEDULE, but the scheduler tries not to schedule new pods onto the node, rather than prohibiting new pods from scheduling onto the node entirely. Enforced by the scheduler.</li><li>`NO_EXECUTE`: Evict any already-running pods that do not tolerate the taint.</li></ul>


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
name | **string**<br>Name of the node group. The name must be unique within the folder. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the node group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
node_template | **[NodeTemplate](#NodeTemplate2)**<br>Required. Node template for creating the node group. 
scale_policy | **[ScalePolicy](#ScalePolicy2)**<br>Required. Scale policy of the node group. 
allocation_policy | **[NodeGroupAllocationPolicy](#NodeGroupAllocationPolicy2)**<br>Allocation policy of the node group by the zones and regions. 
deploy_policy | **[DeployPolicy](#DeployPolicy2)**<br>Deploy policy according to which the updates are rolled out. If not specified, the default is used. 
version | **string**<br>Version of Kubernetes components that runs on the nodes. 
maintenance_policy | **[NodeGroupMaintenancePolicy](#NodeGroupMaintenancePolicy2)**<br>Maintenance policy of the node group. 
allowed_unsafe_sysctls[] | **string**<br>Support for unsafe sysctl parameters. For more details see [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). The maximum string length in characters for each value is 253. Each value must match the regular expression ` ([a-z0-9]([-_a-z0-9]*[a-z0-9])?\\.)*([a-z0-9][-_a-z0-9]*)?[a-z0-9*] `.
node_taints[] | **[Taint](#Taint2)**<br>Taints that are applied to the nodes of the node group at creation time. 
node_labels | **map<string,string>**<br>Labels that are assigned to the nodes of the node group at creation time. 


### NodeTemplate {#NodeTemplate2}

Field | Description
--- | ---
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
labels | **map<string,string>**<br>these labels will be assigned to compute nodes (instances), created by the nodegroup No more than 32 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>ID of the hardware platform configuration for the node. 
resources_spec | **[ResourcesSpec](#ResourcesSpec2)**<br>Computing resources of the node such as the amount of memory and number of cores. 
boot_disk_spec | **[DiskSpec](#DiskSpec2)**<br>Specification for the boot disk that will be attached to the node. 
metadata | **map<string,string>**<br>The metadata as `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the node. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 64 per resource. The maximum string length in characters for each value is 131072. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
v4_address_spec | **[NodeAddressSpec](#NodeAddressSpec2)**<br>Specification for the create network interfaces for the node group compute instances. Deprecated, please use network_interface_specs. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy2)**<br>Scheduling policy configuration. 
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec2)**<br>New api, to specify network interfaces for the node group compute instances. Can not be used together with 'v4_address_spec' 
placement_policy | **[PlacementPolicy](#PlacementPolicy2)**<br> 
network_settings | **[NetworkSettings](#NetworkSettings2)**<br>this parameter allows to specify type of network acceleration used on nodes (instances) 
container_runtime_settings | **[ContainerRuntimeSettings](#ContainerRuntimeSettings2)**<br> 


### NetworkSettings {#NetworkSettings2}

Field | Description
--- | ---
type | enum **Type**<br>Required.  


### ContainerRuntimeSettings {#ContainerRuntimeSettings2}

Field | Description
--- | ---
type | enum **Type**<br>Required.  


### ResourcesSpec {#ResourcesSpec2}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the node, specified in bytes. The minimum value is 0.
cores | **int64**<br>Number of cores available to the node. The minimum value is 0.
core_fraction | **int64**<br>Baseline level of CPU performance with the possibility to burst performance above that baseline level. This field sets baseline performance for each core. Acceptable values are 0 to 100, inclusive.
gpus | **int64**<br>Number of GPUs available to the node. The minimum value is 0.


### DiskSpec {#DiskSpec2}

Field | Description
--- | ---
disk_type_id | **string**<br>ID of the disk type. Value must match the regular expression ` \|network-ssd\|network-hdd\|network-ssd-nonreplicated `.
disk_size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 0 to 4398046511104, inclusive.


### NodeAddressSpec {#NodeAddressSpec2}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec2)**<br>One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec2)**<br>Internal DNS configuration. 


### OneToOneNatSpec {#OneToOneNatSpec2}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>


### DnsRecordSpec {#DnsRecordSpec2}

Field | Description
--- | ---
fqdn | **string**<br>Required. FQDN (required). 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, private zone is used). 
ttl | **int64**<br>DNS record ttl, values in 0-86400 (optional). Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When set to true, also create PTR DNS record (optional). 


### SchedulingPolicy {#SchedulingPolicy2}

Field | Description
--- | ---
preemptible | **bool**<br>True for preemptible compute instances. Default value is false. Preemptible compute instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkInterfaceSpec {#NetworkInterfaceSpec2}

Field | Description
--- | ---
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[NodeAddressSpec](#NodeAddressSpec3)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[NodeAddressSpec](#NodeAddressSpec3)**<br>Primary IPv6 address that is assigned to the instance for this network interface. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PlacementPolicy {#PlacementPolicy2}

Field | Description
--- | ---
placement_group_id | **string**<br>Identifier of placement group 


### ScalePolicy {#ScalePolicy2}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale2)**<br>Fixed scale policy of the node group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale2)**<br>Auto scale policy of the node group. 


### FixedScale {#FixedScale2}

Field | Description
--- | ---
size | **int64**<br>Number of nodes in the node group. Acceptable values are 0 to 100, inclusive.


### AutoScale {#AutoScale2}

Field | Description
--- | ---
min_size | **int64**<br>Minimum number of nodes in the node group. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Maximum number of nodes in the node group. Acceptable values are 0 to 100, inclusive.
initial_size | **int64**<br>Initial number of nodes in the node group. Acceptable values are 0 to 100, inclusive.


### NodeGroupAllocationPolicy {#NodeGroupAllocationPolicy2}

Field | Description
--- | ---
locations[] | **[NodeGroupLocation](#NodeGroupLocation2)**<br>List of locations where resources for the node group will be allocated. 


### NodeGroupLocation {#NodeGroupLocation2}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the nodes may reside. 
subnet_id | **string**<br>ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted. 


### DeployPolicy {#DeployPolicy2}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.


### NodeGroupMaintenancePolicy {#NodeGroupMaintenancePolicy2}

Field | Description
--- | ---
auto_upgrade | **bool**<br>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled. 
auto_repair | **bool**<br>If set to true, automatic repairs are enabled. Default value is false. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow2)**<br>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC. 


### MaintenanceWindow {#MaintenanceWindow2}

Field | Description
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` or `weekly_maintenance_window`<br>Maintenance policy.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow2)**<br>Updating the master at any time. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow2)**<br>Updating the master on any day during the specified time window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow2)**<br>Updating the master on selected days during the specified time window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow2}



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


### Taint {#Taint2}

Field | Description
--- | ---
key | **string**<br>The taint key to be applied to a node. 
value | **string**<br>The taint value corresponding to the taint key. 
effect | enum **Effect**<br>The effect of the taint on pods that do not tolerate the taint. <ul><li>`NO_SCHEDULE`: Do not allow new pods to schedule onto the node unless they tolerate the taint, but allow all pods submitted to Kubelet without going through the scheduler to start, and allow all already-running pods to continue running.</li><li>`PREFER_NO_SCHEDULE`: Like NO_SCHEDULE, but the scheduler tries not to schedule new pods onto the node, rather than prohibiting new pods from scheduling onto the node entirely. Enforced by the scheduler.</li><li>`NO_EXECUTE`: Evict any already-running pods that do not tolerate the taint.</li></ul>


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


### NodeGroup {#NodeGroup2}

Field | Description
--- | ---
id | **string**<br>ID of the node group. 
cluster_id | **string**<br>ID of the cluster that the node group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the node group. The name is unique within the folder. 
description | **string**<br>Description of the node group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the node group. <ul><li>`PROVISIONING`: Node group is waiting for resources to be allocated.</li><li>`RUNNING`: Node group is running.</li><li>`RECONCILING`: Node group is waiting for some work to be done, such as upgrading node software.</li><li>`STOPPING`: Node group is being stopped.</li><li>`STOPPED`: Node group stopped.</li><li>`DELETING`: Node group is being deleted.</li><li>`STARTING`: Node group is being started.</li></ul>
node_template | **[NodeTemplate](#NodeTemplate3)**<br>Node template that specifies parameters of the compute instances for the node group. 
scale_policy | **[ScalePolicy](#ScalePolicy3)**<br>Scale policy of the node group.  For more information, see [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). 
allocation_policy | **[NodeGroupAllocationPolicy](#NodeGroupAllocationPolicy3)**<br>Allocation policy by which resources for node group are allocated to zones and regions. 
deploy_policy | **[DeployPolicy](#DeployPolicy3)**<br>Deploy policy according to which the updates are rolled out. 
instance_group_id | **string**<br>ID of the managed instance group associated with this node group. 
node_version | **string**<br>Version of Kubernetes components that runs on the nodes. Deprecated. Use version_info.current_version. 
version_info | **[VersionInfo](#VersionInfo2)**<br>Detailed information about the Kubernetes version that is running on the node. 
maintenance_policy | **[NodeGroupMaintenancePolicy](#NodeGroupMaintenancePolicy3)**<br>Maintenance policy of the node group. 
allowed_unsafe_sysctls[] | **string**<br>Support for unsafe sysctl parameters. For more details see [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). 
node_taints[] | **[Taint](#Taint3)**<br>Taints that are applied to the nodes of the node group at creation time. 
node_labels | **map<string,string>**<br>Labels that are assigned to the nodes of the node group at creation time. 


### VersionInfo {#VersionInfo2}

Field | Description
--- | ---
current_version | **string**<br>Current Kubernetes version, format: major.minor (e.g. 1.15). 
new_revision_available | **bool**<br>Newer revisions may include Kubernetes patches (e.g 1.15.1 -> 1.15.2) as well as some internal component updates - new features or bug fixes in platform specific components either on the master or nodes. 
new_revision_summary | **string**<br>Description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false. 
version_deprecated | **bool**<br>The current version is on the deprecation schedule, component (master or node group) should be upgraded. 


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
name | **string**<br>Name of the node group. The name must be unique within the folder. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the node group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. <br>Existing set of `labels` is completely replaced by the provided set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
node_template | **[NodeTemplate](#NodeTemplate3)**<br>Node template for the node group. Change may trigger nodes rolling reboot or recreate. 
scale_policy | **[ScalePolicy](#ScalePolicy3)**<br>Scale policy of the node group. 
allocation_policy | **[NodeGroupAllocationPolicy](#NodeGroupAllocationPolicy3)**<br>Allocation policy of the node group by the zones and regions. 
deploy_policy | **[DeployPolicy](#DeployPolicy3)**<br>Deploy policy according to which the updates are rolled out. If not specified, the default is used. 
version | **[UpdateVersionSpec](#UpdateVersionSpec)**<br>Version of Kubernetes components that runs on the nodes. 
maintenance_policy | **[NodeGroupMaintenancePolicy](#NodeGroupMaintenancePolicy3)**<br>Maintenance policy of the node group. 
allowed_unsafe_sysctls[] | **string**<br>Support for unsafe sysctl parameters. For more details see [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). The maximum string length in characters for each value is 253. Each value must match the regular expression ` ([a-z0-9]([-_a-z0-9]*[a-z0-9])?\\.)*([a-z0-9][-_a-z0-9]*)?[a-z0-9*] `.
node_taints[] | **[Taint](#Taint3)**<br>Taints that are applied to the nodes of the node group at creation time. 
node_labels | **map<string,string>**<br>Labels that are assigned to the nodes of the node group at creation time. 


### NodeTemplate {#NodeTemplate3}

Field | Description
--- | ---
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
labels | **map<string,string>**<br>these labels will be assigned to compute nodes (instances), created by the nodegroup No more than 32 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>ID of the hardware platform configuration for the node. 
resources_spec | **[ResourcesSpec](#ResourcesSpec3)**<br>Computing resources of the node such as the amount of memory and number of cores. 
boot_disk_spec | **[DiskSpec](#DiskSpec3)**<br>Specification for the boot disk that will be attached to the node. 
metadata | **map<string,string>**<br>The metadata as `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the node. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 64 per resource. The maximum string length in characters for each value is 131072. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
v4_address_spec | **[NodeAddressSpec](#NodeAddressSpec3)**<br>Specification for the create network interfaces for the node group compute instances. Deprecated, please use network_interface_specs. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy3)**<br>Scheduling policy configuration. 
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec3)**<br>New api, to specify network interfaces for the node group compute instances. Can not be used together with 'v4_address_spec' 
placement_policy | **[PlacementPolicy](#PlacementPolicy3)**<br> 
network_settings | **[NetworkSettings](#NetworkSettings3)**<br>this parameter allows to specify type of network acceleration used on nodes (instances) 
container_runtime_settings | **[ContainerRuntimeSettings](#ContainerRuntimeSettings3)**<br> 


### NetworkSettings {#NetworkSettings3}

Field | Description
--- | ---
type | enum **Type**<br>Required.  


### ContainerRuntimeSettings {#ContainerRuntimeSettings3}

Field | Description
--- | ---
type | enum **Type**<br>Required.  


### ResourcesSpec {#ResourcesSpec3}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the node, specified in bytes. The minimum value is 0.
cores | **int64**<br>Number of cores available to the node. The minimum value is 0.
core_fraction | **int64**<br>Baseline level of CPU performance with the possibility to burst performance above that baseline level. This field sets baseline performance for each core. Acceptable values are 0 to 100, inclusive.
gpus | **int64**<br>Number of GPUs available to the node. The minimum value is 0.


### DiskSpec {#DiskSpec3}

Field | Description
--- | ---
disk_type_id | **string**<br>ID of the disk type. Value must match the regular expression ` \|network-ssd\|network-hdd\|network-ssd-nonreplicated `.
disk_size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 0 to 4398046511104, inclusive.


### NodeAddressSpec {#NodeAddressSpec3}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec3)**<br>One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec3)**<br>Internal DNS configuration. 


### OneToOneNatSpec {#OneToOneNatSpec3}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>


### DnsRecordSpec {#DnsRecordSpec3}

Field | Description
--- | ---
fqdn | **string**<br>Required. FQDN (required). 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, private zone is used). 
ttl | **int64**<br>DNS record ttl, values in 0-86400 (optional). Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When set to true, also create PTR DNS record (optional). 


### SchedulingPolicy {#SchedulingPolicy3}

Field | Description
--- | ---
preemptible | **bool**<br>True for preemptible compute instances. Default value is false. Preemptible compute instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkInterfaceSpec {#NetworkInterfaceSpec3}

Field | Description
--- | ---
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[NodeAddressSpec](#NodeAddressSpec4)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[NodeAddressSpec](#NodeAddressSpec4)**<br>Primary IPv6 address that is assigned to the instance for this network interface. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PlacementPolicy {#PlacementPolicy3}

Field | Description
--- | ---
placement_group_id | **string**<br>Identifier of placement group 


### ScalePolicy {#ScalePolicy3}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale3)**<br>Fixed scale policy of the node group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale3)**<br>Auto scale policy of the node group. 


### FixedScale {#FixedScale3}

Field | Description
--- | ---
size | **int64**<br>Number of nodes in the node group. Acceptable values are 0 to 100, inclusive.


### AutoScale {#AutoScale3}

Field | Description
--- | ---
min_size | **int64**<br>Minimum number of nodes in the node group. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Maximum number of nodes in the node group. Acceptable values are 0 to 100, inclusive.
initial_size | **int64**<br>Initial number of nodes in the node group. Acceptable values are 0 to 100, inclusive.


### NodeGroupAllocationPolicy {#NodeGroupAllocationPolicy3}

Field | Description
--- | ---
locations[] | **[NodeGroupLocation](#NodeGroupLocation3)**<br>List of locations where resources for the node group will be allocated. 


### NodeGroupLocation {#NodeGroupLocation3}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the nodes may reside. 
subnet_id | **string**<br>ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted. 


### DeployPolicy {#DeployPolicy3}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.


### UpdateVersionSpec {#UpdateVersionSpec}

Field | Description
--- | ---
specifier | **oneof:** `version` or `latest_revision`<br>
&nbsp;&nbsp;version | **string**<br>Request update to a newer version of Kubernetes (1.x -> 1.y). 
&nbsp;&nbsp;latest_revision | **bool**<br>Request update to the latest revision for the current version. 


### NodeGroupMaintenancePolicy {#NodeGroupMaintenancePolicy3}

Field | Description
--- | ---
auto_upgrade | **bool**<br>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled. 
auto_repair | **bool**<br>If set to true, automatic repairs are enabled. Default value is false. 
maintenance_window | **[MaintenanceWindow](#MaintenanceWindow3)**<br>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC. 


### MaintenanceWindow {#MaintenanceWindow3}

Field | Description
--- | ---
policy | **oneof:** `anytime`, `daily_maintenance_window` or `weekly_maintenance_window`<br>Maintenance policy.
&nbsp;&nbsp;anytime | **[AnytimeMaintenanceWindow](#AnytimeMaintenanceWindow3)**<br>Updating the master at any time. 
&nbsp;&nbsp;daily_maintenance_window | **[DailyMaintenanceWindow](#DailyMaintenanceWindow3)**<br>Updating the master on any day during the specified time window. 
&nbsp;&nbsp;weekly_maintenance_window | **[WeeklyMaintenanceWindow](#WeeklyMaintenanceWindow3)**<br>Updating the master on selected days during the specified time window. 


### AnytimeMaintenanceWindow {#AnytimeMaintenanceWindow3}



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


### Taint {#Taint3}

Field | Description
--- | ---
key | **string**<br>The taint key to be applied to a node. 
value | **string**<br>The taint value corresponding to the taint key. 
effect | enum **Effect**<br>The effect of the taint on pods that do not tolerate the taint. <ul><li>`NO_SCHEDULE`: Do not allow new pods to schedule onto the node unless they tolerate the taint, but allow all pods submitted to Kubelet without going through the scheduler to start, and allow all already-running pods to continue running.</li><li>`PREFER_NO_SCHEDULE`: Like NO_SCHEDULE, but the scheduler tries not to schedule new pods onto the node, rather than prohibiting new pods from scheduling onto the node entirely. Enforced by the scheduler.</li><li>`NO_EXECUTE`: Evict any already-running pods that do not tolerate the taint.</li></ul>


### Operation {#Operation1}

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


### NodeGroup {#NodeGroup3}

Field | Description
--- | ---
id | **string**<br>ID of the node group. 
cluster_id | **string**<br>ID of the cluster that the node group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the node group. The name is unique within the folder. 
description | **string**<br>Description of the node group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the node group. <ul><li>`PROVISIONING`: Node group is waiting for resources to be allocated.</li><li>`RUNNING`: Node group is running.</li><li>`RECONCILING`: Node group is waiting for some work to be done, such as upgrading node software.</li><li>`STOPPING`: Node group is being stopped.</li><li>`STOPPED`: Node group stopped.</li><li>`DELETING`: Node group is being deleted.</li><li>`STARTING`: Node group is being started.</li></ul>
node_template | **[NodeTemplate](#NodeTemplate4)**<br>Node template that specifies parameters of the compute instances for the node group. 
scale_policy | **[ScalePolicy](#ScalePolicy4)**<br>Scale policy of the node group.  For more information, see [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). 
allocation_policy | **[NodeGroupAllocationPolicy](#NodeGroupAllocationPolicy4)**<br>Allocation policy by which resources for node group are allocated to zones and regions. 
deploy_policy | **[DeployPolicy](#DeployPolicy4)**<br>Deploy policy according to which the updates are rolled out. 
instance_group_id | **string**<br>ID of the managed instance group associated with this node group. 
node_version | **string**<br>Version of Kubernetes components that runs on the nodes. Deprecated. Use version_info.current_version. 
version_info | **[VersionInfo](#VersionInfo3)**<br>Detailed information about the Kubernetes version that is running on the node. 
maintenance_policy | **[NodeGroupMaintenancePolicy](#NodeGroupMaintenancePolicy4)**<br>Maintenance policy of the node group. 
allowed_unsafe_sysctls[] | **string**<br>Support for unsafe sysctl parameters. For more details see [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). 
node_taints[] | **[Taint](#Taint4)**<br>Taints that are applied to the nodes of the node group at creation time. 
node_labels | **map<string,string>**<br>Labels that are assigned to the nodes of the node group at creation time. 


### VersionInfo {#VersionInfo3}

Field | Description
--- | ---
current_version | **string**<br>Current Kubernetes version, format: major.minor (e.g. 1.15). 
new_revision_available | **bool**<br>Newer revisions may include Kubernetes patches (e.g 1.15.1 -> 1.15.2) as well as some internal component updates - new features or bug fixes in platform specific components either on the master or nodes. 
new_revision_summary | **string**<br>Description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false. 
version_deprecated | **bool**<br>The current version is on the deprecation schedule, component (master or node group) should be upgraded. 


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


### Operation {#Operation2}

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
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListNodeGroupOperationsRequest.page_size](#ListNodeGroupOperationsRequest), use the `next_page_token` as the value for the [ListNodeGroupOperationsRequest.page_token](#ListNodeGroupOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation3}

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

Retrieves the list of nodes in the specified Kubernetes cluster.

**rpc ListNodes ([ListNodeGroupNodesRequest](#ListNodeGroupNodesRequest)) returns ([ListNodeGroupNodesResponse](#ListNodeGroupNodesResponse))**

### ListNodeGroupNodesRequest {#ListNodeGroupNodesRequest}

Field | Description
--- | ---
node_group_id | **string**<br>Required. ID of the node group to list. To get the node group ID use a [NodeGroupService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListNodeGroupsResponse.next_page_token](#ListNodeGroupsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListNodeGroupNodesResponse.next_page_token](#ListNodeGroupNodesResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListNodeGroupNodesResponse {#ListNodeGroupNodesResponse}

Field | Description
--- | ---
nodes[] | **[Node](#Node)**<br>List of nodes. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListNodeGroupNodesRequest.page_size](#ListNodeGroupNodesRequest), use the `next_page_token` as the value for the [ListNodeGroupNodesRequest.page_token](#ListNodeGroupNodesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Node {#Node}

Field | Description
--- | ---
status | enum **Status**<br>Computed node status. <ul><li>`PROVISIONING`: Node instance is not yet created (e.g. in progress).</li><li>`NOT_CONNECTED`: Node instance is created but not registered (e.g. is still initializing).</li><li>`NOT_READY`: Node has connected but is not ready for workload (see conditions for details).</li><li>`READY`: Node has connected and ready for workload.</li><li>`MISSING`: Node is still registered but its instance is deleted (this is our bug).</li></ul>
spec | **[Spec](#Spec)**<br>Node specificaion. 
cloud_status | **[CloudStatus](#CloudStatus)**<br>Cloud instance status. Not available in `MISSING` status. 
kubernetes_status | **[KubernetesStatus](#KubernetesStatus)**<br>Kubernetes node status. Not available in `PROVISIONING` and `NOT_CONNECTED` states. 


### KubernetesStatus {#KubernetesStatus}

Field | Description
--- | ---
id | **string**<br>Node id (and instance name) 
conditions[] | **[Condition](#Condition)**<br>Conditions is an array of current observed node conditions. More info: https://kubernetes.io/docs/concepts/nodes/node/#condition 
taints[] | **[Taint](#Taint4)**<br>If specified, the node's taints. 
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
resources | **[ResourcesSpec](#ResourcesSpec4)**<br>Node group specified resources. 
disk | **[DiskSpec](#DiskSpec4)**<br>Node group specified disk. 


### Condition {#Condition}

Field | Description
--- | ---
type | **string**<br>Type of node condition. 
status | **string**<br>Status is the status of the condition. 
message | **string**<br>Human-readable message indicating details about last transition. 
last_heartbeat_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Last time we got an update on a given condition. 
last_transition_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Last time the condition transit from one status to another. 


### Taint {#Taint4}

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


### ResourcesSpec {#ResourcesSpec4}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the node, specified in bytes. The minimum value is 0.
cores | **int64**<br>Number of cores available to the node. The minimum value is 0.
core_fraction | **int64**<br>Baseline level of CPU performance with the possibility to burst performance above that baseline level. This field sets baseline performance for each core. Acceptable values are 0 to 100, inclusive.
gpus | **int64**<br>Number of GPUs available to the node. The minimum value is 0.


### DiskSpec {#DiskSpec4}

Field | Description
--- | ---
disk_type_id | **string**<br>ID of the disk type. Value must match the regular expression ` \|network-ssd\|network-hdd\|network-ssd-nonreplicated `.
disk_size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 0 to 4398046511104, inclusive.


