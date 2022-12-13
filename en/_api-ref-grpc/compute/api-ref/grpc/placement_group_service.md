---
editable: false
---

# Compute Cloud API, gRPC: PlacementGroupService

A set of methods for managing placement groups.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified placement group. |
| [List](#List) | Retrieves the list of placement groups in the specified folder. |
| [Create](#Create) | Creates a placement group in the specified folder. |
| [Update](#Update) | Updates the specified placement group. |
| [Delete](#Delete) | Deletes the specified placement group. |
| [ListInstances](#ListInstances) | Lists instances for the specified placement group. |
| [ListOperations](#ListOperations) | Lists operations for the specified placement group. |

## Calls PlacementGroupService {#calls}

## Get {#Get}

Returns the specified placement group. <br>To get the list of all available placement groups, make a [List](#List) request.

**rpc Get ([GetPlacementGroupRequest](#GetPlacementGroupRequest)) returns ([PlacementGroup](#PlacementGroup))**

### GetPlacementGroupRequest {#GetPlacementGroupRequest}

Field | Description
--- | ---
placement_group_id | **string**<br>ID of the placement group to return. <br>To get a placement group ID make a [PlacementGroupService.List](#List) request. 


### PlacementGroup {#PlacementGroup}

Field | Description
--- | ---
id | **string**<br>ID of the placement group. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the placement group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the placement group. The name is unique within the folder. 
description | **string**<br>Description of the placement group. 0-256 characters long. 
labels | **map<string,string>**<br>Placement group labels as `key:value` pairs. 
placement_strategy | **oneof:** `spread_placement_strategy`<br>Placement strategy. To specify a placement strategy, send the corresponding field containing an empty structure.
&nbsp;&nbsp;spread_placement_strategy | **[SpreadPlacementStrategy](#SpreadPlacementStrategy)**<br>Anti-affinity placement strategy (`spread`). Instances are distributed over distinct failure domains. 


### SpreadPlacementStrategy {#SpreadPlacementStrategy}



## List {#List}

Retrieves the list of placement groups in the specified folder.

**rpc List ([ListPlacementGroupsRequest](#ListPlacementGroupsRequest)) returns ([ListPlacementGroupsResponse](#ListPlacementGroupsResponse))**

### ListPlacementGroupsRequest {#ListPlacementGroupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>ID of the folder to list placement groups in. <br>To get the folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListPlacementGroupsResponse.next_page_token](#ListPlacementGroupsResponse) that can be used to get the next page of results in subsequent list requests. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListPlacementGroupsResponse.next_page_token](#ListPlacementGroupsResponse) returned by a previous list request. 
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on the [PlacementGroup.name](#PlacementGroup1) field. 


### ListPlacementGroupsResponse {#ListPlacementGroupsResponse}

Field | Description
--- | ---
placement_groups[] | **[PlacementGroup](#PlacementGroup1)**<br>Lists placement groups in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListPlacementGroupsRequest.page_size](#ListPlacementGroupsRequest), use `next_page_token` as the value for the [ListPlacementGroupsRequest.page_token](#ListPlacementGroupsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### PlacementGroup {#PlacementGroup1}

Field | Description
--- | ---
id | **string**<br>ID of the placement group. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the placement group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the placement group. The name is unique within the folder. 
description | **string**<br>Description of the placement group. 0-256 characters long. 
labels | **map<string,string>**<br>Placement group labels as `key:value` pairs. 
placement_strategy | **oneof:** `spread_placement_strategy`<br>Placement strategy. To specify a placement strategy, send the corresponding field containing an empty structure.
&nbsp;&nbsp;spread_placement_strategy | **[SpreadPlacementStrategy](#SpreadPlacementStrategy1)**<br>Anti-affinity placement strategy (`spread`). Instances are distributed over distinct failure domains. 


### SpreadPlacementStrategy {#SpreadPlacementStrategy1}



## Create {#Create}

Creates a placement group in the specified folder.

**rpc Create ([CreatePlacementGroupRequest](#CreatePlacementGroupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreatePlacementGroupMetadata](#CreatePlacementGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[PlacementGroup](#PlacementGroup2)<br>

### CreatePlacementGroupRequest {#CreatePlacementGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>ID of the folder to create a placement group in. <br>To get a folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
name | **string**<br>Name of the placement group. 
description | **string**<br>Description of the placement group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
placement_strategy | **oneof:** `spread_placement_strategy`<br>Placement strategy.
&nbsp;&nbsp;spread_placement_strategy | **[SpreadPlacementStrategy](#SpreadPlacementStrategy2)**<br>Anti-affinity placement strategy (`spread`). Instances are distributed over distinct failure domains. 


### SpreadPlacementStrategy {#SpreadPlacementStrategy2}



### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreatePlacementGroupMetadata](#CreatePlacementGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PlacementGroup](#PlacementGroup2)>**<br>if operation finished successfully. 


### CreatePlacementGroupMetadata {#CreatePlacementGroupMetadata}

Field | Description
--- | ---
placement_group_id | **string**<br>ID of the placement group that is being created. 


### PlacementGroup {#PlacementGroup2}

Field | Description
--- | ---
id | **string**<br>ID of the placement group. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the placement group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the placement group. The name is unique within the folder. 
description | **string**<br>Description of the placement group. 0-256 characters long. 
labels | **map<string,string>**<br>Placement group labels as `key:value` pairs. 
placement_strategy | **oneof:** `spread_placement_strategy`<br>Placement strategy. To specify a placement strategy, send the corresponding field containing an empty structure.
&nbsp;&nbsp;spread_placement_strategy | **[SpreadPlacementStrategy](#SpreadPlacementStrategy3)**<br>Anti-affinity placement strategy (`spread`). Instances are distributed over distinct failure domains. 


## Update {#Update}

Updates the specified placement group.

**rpc Update ([UpdatePlacementGroupRequest](#UpdatePlacementGroupRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdatePlacementGroupMetadata](#UpdatePlacementGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[PlacementGroup](#PlacementGroup3)<br>

### UpdatePlacementGroupRequest {#UpdatePlacementGroupRequest}

Field | Description
--- | ---
placement_group_id | **string**<br>ID of the placement group to update. <br>To get the placement group ID, use an [PlacementGroupService.List](#List) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the PlacementGroup resource should be updated. 
name | **string**<br>Name of the placement group. 
description | **string**<br>Description of the placement group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. <br>The existing set of `labels` is completely replaced by the provided set. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdatePlacementGroupMetadata](#UpdatePlacementGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PlacementGroup](#PlacementGroup3)>**<br>if operation finished successfully. 


### UpdatePlacementGroupMetadata {#UpdatePlacementGroupMetadata}

Field | Description
--- | ---
placement_group_id | **string**<br>ID of the placement group that is being updated. 


### PlacementGroup {#PlacementGroup3}

Field | Description
--- | ---
id | **string**<br>ID of the placement group. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the placement group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the placement group. The name is unique within the folder. 
description | **string**<br>Description of the placement group. 0-256 characters long. 
labels | **map<string,string>**<br>Placement group labels as `key:value` pairs. 
placement_strategy | **oneof:** `spread_placement_strategy`<br>Placement strategy. To specify a placement strategy, send the corresponding field containing an empty structure.
&nbsp;&nbsp;spread_placement_strategy | **[SpreadPlacementStrategy](#SpreadPlacementStrategy3)**<br>Anti-affinity placement strategy (`spread`). Instances are distributed over distinct failure domains. 


### SpreadPlacementStrategy {#SpreadPlacementStrategy3}



## Delete {#Delete}

Deletes the specified placement group.

**rpc Delete ([DeletePlacementGroupRequest](#DeletePlacementGroupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeletePlacementGroupMetadata](#DeletePlacementGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeletePlacementGroupRequest {#DeletePlacementGroupRequest}

Field | Description
--- | ---
placement_group_id | **string**<br>ID of the placement group to delete. <br>To get the placement group ID, use [PlacementGroupService.List](#List) request. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeletePlacementGroupMetadata](#DeletePlacementGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeletePlacementGroupMetadata {#DeletePlacementGroupMetadata}

Field | Description
--- | ---
placement_group_id | **string**<br>ID of the placement group that is being deleted. 


## ListInstances {#ListInstances}

Lists instances for the specified placement group.

**rpc ListInstances ([ListPlacementGroupInstancesRequest](#ListPlacementGroupInstancesRequest)) returns ([ListPlacementGroupInstancesResponse](#ListPlacementGroupInstancesResponse))**

### ListPlacementGroupInstancesRequest {#ListPlacementGroupInstancesRequest}

Field | Description
--- | ---
placement_group_id | **string**<br>ID of the placement group to list instances for. <br>To get the placement group ID, use [PlacementGroupService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListPlacementGroupInstancesResponse.next_page_token](#ListPlacementGroupInstancesResponse) that can be used to get the next page of results in subsequent list requests. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListPlacementGroupInstancesResponse.next_page_token](#ListPlacementGroupInstancesResponse) returned by a previous list request. 


### ListPlacementGroupInstancesResponse {#ListPlacementGroupInstancesResponse}

Field | Description
--- | ---
instances[] | **[Instance](#Instance)**<br>Lists instances for the specified placement group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is more than [ListPlacementGroupInstancesRequest.page_size](#ListPlacementGroupInstancesRequest), use `next_page_token` as the value for the [ListPlacementGroupInstancesRequest.page_token](#ListPlacementGroupInstancesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Instance {#Instance}

Field | Description
--- | ---
id | **string**<br>ID of the instance. 
folder_id | **string**<br>ID of the folder that the instance belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the instance. 1-63 characters long. 
description | **string**<br>Description of the instance. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
zone_id | **string**<br>ID of the availability zone where the instance resides. 
platform_id | **string**<br>ID of the hardware platform configuration for the instance. 
resources | **[Resources](#Resources)**<br>Computing resources of the instance such as the amount of memory and number of cores. 
status | enum **Status**<br>Status of the instance. <ul><li>`PROVISIONING`: Instance is waiting for resources to be allocated.</li><li>`RUNNING`: Instance is running normally.</li><li>`STOPPING`: Instance is being stopped.</li><li>`STOPPED`: Instance stopped.</li><li>`STARTING`: Instance is being started.</li><li>`RESTARTING`: Instance is being restarted.</li><li>`UPDATING`: Instance is being updated.</li><li>`ERROR`: Instance encountered a problem and cannot operate.</li><li>`CRASHED`: Instance crashed and will be restarted automatically.</li><li>`DELETING`: Instance is being deleted.</li></ul>
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
metadata_options | **[MetadataOptions](#MetadataOptions)**<br>Options allow user to configure access to instance's metadata 
boot_disk | **[AttachedDisk](#AttachedDisk)**<br>Boot disk that is attached to the instance. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk)**<br>Array of secondary disks that are attached to the instance. 
local_disks[] | **[AttachedLocalDisk](#AttachedLocalDisk)**<br>Array of local disks that are attached to the instance. 
filesystems[] | **[AttachedFilesystem](#AttachedFilesystem)**<br>Array of filesystems that are attached to the instance. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface)**<br>Array of network interfaces that are attached to the instance. 
fqdn | **string**<br>A domain name of the instance. FQDN is defined by the server in the format `<hostname>.<region_id>.internal` when the instance is created. If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy)**<br>Scheduling policy configuration. 
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
network_settings | **[NetworkSettings](#NetworkSettings)**<br>Network Settings 
placement_policy | **[PlacementPolicy](#PlacementPolicy)**<br>Placement policy configuration. 


### Resources {#Resources}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. 
cores | **int64**<br>The number of cores available to the instance. 
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. 
gpus | **int64**<br>The number of GPUs available to the instance. 


### MetadataOptions {#MetadataOptions}

Field | Description
--- | ---
gce_http_endpoint | enum **MetadataOption**<br>Enabled access to GCE flavored metadata <ul><li>`ENABLED`: Option is enabled</li><li>`DISABLED`: Option is disabled</li></ul>
aws_v1_http_endpoint | enum **MetadataOption**<br>Enabled access to AWS flavored metadata (IMDSv1) <ul><li>`ENABLED`: Option is enabled</li><li>`DISABLED`: Option is disabled</li></ul>
gce_http_token | enum **MetadataOption**<br>Enabled access to IAM credentials with GCE flavored metadata <ul><li>`ENABLED`: Option is enabled</li><li>`DISABLED`: Option is disabled</li></ul>
aws_v1_http_token | enum **MetadataOption**<br>Enabled access to IAM credentials with AWS flavored metadata (IMDSv1) <ul><li>`ENABLED`: Option is enabled</li><li>`DISABLED`: Option is disabled</li></ul>


### AttachedDisk {#AttachedDisk}

Field | Description
--- | ---
mode | enum **Mode**<br>Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li></ul>
device_name | **string**<br>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. 
auto_delete | **bool**<br>Specifies whether the disk will be auto-deleted when the instance is deleted. 
disk_id | **string**<br>ID of the disk that is attached to the instance. 


### AttachedLocalDisk {#AttachedLocalDisk}

Field | Description
--- | ---
size | **int64**<br>Size of the disk, specified in bytes. 
device_name | **string**<br>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. 


### AttachedFilesystem {#AttachedFilesystem}

Field | Description
--- | ---
mode | enum **Mode**<br>Access mode to the filesystem. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li></ul>
device_name | **string**<br>Name of the device representing the filesystem on the instance. <br>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc. 
filesystem_id | **string**<br>ID of the filesystem that is attached to the instance. 


### NetworkInterface {#NetworkInterface}

Field | Description
--- | ---
index | **string**<br>The index of the network interface, generated by the server, 0,1,2... etc. Currently only one network interface is supported per instance. 
mac_address | **string**<br>MAC address that is assigned to the network interface. 
subnet_id | **string**<br>ID of the subnet. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>ID's of security groups attached to the interface 


### PrimaryAddress {#PrimaryAddress}

Field | Description
--- | ---
address | **string**<br>An IPv4 internal network address that is assigned to the instance for this network interface. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat)**<br>One-to-one NAT configuration. If missing, NAT has not been set up. 
dns_records[] | **[DnsRecord](#DnsRecord)**<br>Internal DNS configuration 


### OneToOneNat {#OneToOneNat}

Field | Description
--- | ---
address | **string**<br>An external IP address associated with this instance. 
ip_version | enum **IpVersion**<br>IP version for the external IP address. <ul><li>`IPV4`: IPv4 address, for example 192.0.2.235.</li><li>`IPV6`: IPv6 address. Not available yet.</li></ul>
dns_records[] | **[DnsRecord](#DnsRecord)**<br>External DNS configuration 


### DnsRecord {#DnsRecord}

Field | Description
--- | ---
fqdn | **string**<br>Name of the A/AAAA record as specified when creating the instance. Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id). 
dns_zone_id | **string**<br>DNS zone id for the record (optional, if not set, some private zone is used). 
ttl | **int64**<br>DNS record ttl (optional, if not set, a reasonable default is used.) 
ptr | **bool**<br>When true, indicates there is a corresponding auto-created PTR DNS record. 


### SchedulingPolicy {#SchedulingPolicy}

Field | Description
--- | ---
preemptible | **bool**<br>True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Network Type <ul><li>`STANDARD`: Standard network.</li><li>`SOFTWARE_ACCELERATED`: Software accelerated network.</li><li>`HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).</li></ul>


### PlacementPolicy {#PlacementPolicy}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action 
values[] | **string**<br>Affinity value or host ID or host group ID 


## ListOperations {#ListOperations}

Lists operations for the specified placement group.

**rpc ListOperations ([ListPlacementGroupOperationsRequest](#ListPlacementGroupOperationsRequest)) returns ([ListPlacementGroupOperationsResponse](#ListPlacementGroupOperationsResponse))**

### ListPlacementGroupOperationsRequest {#ListPlacementGroupOperationsRequest}

Field | Description
--- | ---
placement_group_id | **string**<br>ID of the placement group to list operations for. <br>To get the placement group ID, use [PlacementGroupService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListPlacementGroupOperationsResponse.next_page_token](#ListPlacementGroupOperationsResponse) that can be used to get the next page of results in subsequent list requests. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListPlacementGroupOperationsResponse.next_page_token](#ListPlacementGroupOperationsResponse) returned by a previous list request. 


### ListPlacementGroupOperationsResponse {#ListPlacementGroupOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified placement group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListPlacementGroupOperationsRequest.page_size](#ListPlacementGroupOperationsRequest), use the `next_page_token` as the value for the [ListPlacementGroupOperationsRequest.page_token](#ListPlacementGroupOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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


