---
editable: false
sourcePath: en/_api-ref-grpc/compute/api-ref/grpc/host_group_service.md
---

# Compute Cloud API, gRPC: HostGroupService

A set of methods for managing groups of dedicated hosts.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified host group. |
| [List](#List) | Retrieves the list of host groups in the specified folder. |
| [Create](#Create) | Creates a host group in the specified folder. |
| [Update](#Update) | Updates the specified host group. |
| [Delete](#Delete) | Deletes the specified host group. |
| [ListOperations](#ListOperations) | Lists operations for the specified host group. |
| [ListInstances](#ListInstances) | Lists instances that belongs to the specified host group. |
| [ListHosts](#ListHosts) | Lists hosts that belongs to the specified host group. |

## Calls HostGroupService {#calls}

## Get {#Get}

Returns the specified host group.

**rpc Get ([GetHostGroupRequest](#GetHostGroupRequest)) returns ([HostGroup](#HostGroup))**

### GetHostGroupRequest {#GetHostGroupRequest}

Field | Description
--- | ---
host_group_id | **string**<br>Required. ID of the host group to return. To get the host group ID, use [HostGroupService.List](#List) request. The maximum string length in characters is 50.


### HostGroup {#HostGroup}

Field | Description
--- | ---
id | **string**<br>ID of the group. 
folder_id | **string**<br>ID of the folder that the group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the group. The name is unique within the folder. 
description | **string**<br>Description of the group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
zone_id | **string**<br>Availability zone where all dedicated hosts are allocated. 
status | enum **Status**<br>Status of the group. 
type_id | **string**<br>ID of host type. Resources provided by each host of the group. 
maintenance_policy | enum **MaintenancePolicy**<br>Behaviour on maintenance events. <ul><li>`RESTART`: Restart instances on the same host after maintenance event.</li><li>`MIGRATE`: Migrate instances to another host before maintenance event.</li></ul>
scale_policy | **[ScalePolicy](#ScalePolicy)**<br>Scale policy. Only fixed number of hosts are supported at this moment. 


### ScalePolicy {#ScalePolicy}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale)**<br> 


### FixedScale {#FixedScale}

Field | Description
--- | ---
size | **int64**<br> 


## List {#List}

Retrieves the list of host groups in the specified folder.

**rpc List ([ListHostGroupsRequest](#ListHostGroupsRequest)) returns ([ListHostGroupsResponse](#ListHostGroupsResponse))**

### ListHostGroupsRequest {#ListHostGroupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list host groups in. To get the folder ID, use [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListHostGroupsResponse.next_page_token](#ListHostGroupsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListHostGroupsResponse.next_page_token](#ListHostGroupsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`. <br>Each condition has the form `<field> <operator> <value>`, where: <ol><li>`<field>` is the field name. Currently you can use filtering only on the limited number of fields. </li><li>`<operator>` is a logical operator, one of `=`, `!=`, `IN`, `NOT IN`. </li><li>`<value>` represents a value. </li></ol>String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash). The maximum string length in characters is 1000.
order_by | **string**<br>By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted. The default sorting order is ascending The maximum string length in characters is 100.


### ListHostGroupsResponse {#ListHostGroupsResponse}

Field | Description
--- | ---
host_groups[] | **[HostGroup](#HostGroup1)**<br>Lists host groups for the specified folder. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListHostGroupsRequest.page_size](#ListHostGroupsRequest), use `next_page_token` as the value for the [ListHostGroupsRequest.page_token](#ListHostGroupsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### HostGroup {#HostGroup1}

Field | Description
--- | ---
id | **string**<br>ID of the group. 
folder_id | **string**<br>ID of the folder that the group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the group. The name is unique within the folder. 
description | **string**<br>Description of the group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
zone_id | **string**<br>Availability zone where all dedicated hosts are allocated. 
status | enum **Status**<br>Status of the group. 
type_id | **string**<br>ID of host type. Resources provided by each host of the group. 
maintenance_policy | enum **MaintenancePolicy**<br>Behaviour on maintenance events. <ul><li>`RESTART`: Restart instances on the same host after maintenance event.</li><li>`MIGRATE`: Migrate instances to another host before maintenance event.</li></ul>
scale_policy | **[ScalePolicy](#ScalePolicy1)**<br>Scale policy. Only fixed number of hosts are supported at this moment. 


### ScalePolicy {#ScalePolicy1}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale1)**<br> 


### FixedScale {#FixedScale1}

Field | Description
--- | ---
size | **int64**<br> 


## Create {#Create}

Creates a host group in the specified folder.

**rpc Create ([CreateHostGroupRequest](#CreateHostGroupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateHostGroupMetadata](#CreateHostGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[HostGroup](#HostGroup2)<br>

### CreateHostGroupRequest {#CreateHostGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a host group in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
zone_id | **string**<br>Required. Availability zone where all dedicated hosts will be allocated. The maximum string length in characters is 50.
type_id | **string**<br>Required. ID of host type. Resources provided by each host of the group. The maximum string length in characters is 50.
maintenance_policy | enum **MaintenancePolicy**<br>Behaviour on maintenance events. <ul><li>`RESTART`: Restart instances on the same host after maintenance event.</li><li>`MIGRATE`: Migrate instances to another host before maintenance event.</li></ul>
scale_policy | **[ScalePolicy](#ScalePolicy2)**<br>Scale policy. Only fixed number of hosts are supported at this moment. 


### ScalePolicy {#ScalePolicy2}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale2)**<br> 


### FixedScale {#FixedScale2}

Field | Description
--- | ---
size | **int64**<br> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateHostGroupMetadata](#CreateHostGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[HostGroup](#HostGroup2)>**<br>if operation finished successfully. 


### CreateHostGroupMetadata {#CreateHostGroupMetadata}

Field | Description
--- | ---
host_group_id | **string**<br>ID of the host group that is being created. 


### HostGroup {#HostGroup2}

Field | Description
--- | ---
id | **string**<br>ID of the group. 
folder_id | **string**<br>ID of the folder that the group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the group. The name is unique within the folder. 
description | **string**<br>Description of the group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
zone_id | **string**<br>Availability zone where all dedicated hosts are allocated. 
status | enum **Status**<br>Status of the group. 
type_id | **string**<br>ID of host type. Resources provided by each host of the group. 
maintenance_policy | enum **MaintenancePolicy**<br>Behaviour on maintenance events. <ul><li>`RESTART`: Restart instances on the same host after maintenance event.</li><li>`MIGRATE`: Migrate instances to another host before maintenance event.</li></ul>
scale_policy | **[ScalePolicy](#ScalePolicy3)**<br>Scale policy. Only fixed number of hosts are supported at this moment. 


## Update {#Update}

Updates the specified host group.

**rpc Update ([UpdateHostGroupRequest](#UpdateHostGroupRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateHostGroupMetadata](#UpdateHostGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[HostGroup](#HostGroup3)<br>

### UpdateHostGroupRequest {#UpdateHostGroupRequest}

Field | Description
--- | ---
host_group_id | **string**<br>Required. ID of the host group to update. To get the host group ID, use an [HostGroupService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the HostGroup resource are going to be updated. 
name | **string**<br>Name of the group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. <br>The existing set of `labels` is completely replaced by the provided set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
maintenance_policy | enum **MaintenancePolicy**<br>Behaviour on maintenance events <ul><li>`RESTART`: Restart instances on the same host after maintenance event.</li><li>`MIGRATE`: Migrate instances to another host before maintenance event.</li></ul>
scale_policy | **[ScalePolicy](#ScalePolicy3)**<br>Scale policy. Only fixed number of hosts are supported at this moment. 


### ScalePolicy {#ScalePolicy3}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale3)**<br> 


### FixedScale {#FixedScale3}

Field | Description
--- | ---
size | **int64**<br> 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateHostGroupMetadata](#UpdateHostGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[HostGroup](#HostGroup3)>**<br>if operation finished successfully. 


### UpdateHostGroupMetadata {#UpdateHostGroupMetadata}

Field | Description
--- | ---
host_group_id | **string**<br>ID of the host group that is being updated. 


### HostGroup {#HostGroup3}

Field | Description
--- | ---
id | **string**<br>ID of the group. 
folder_id | **string**<br>ID of the folder that the group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the group. The name is unique within the folder. 
description | **string**<br>Description of the group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
zone_id | **string**<br>Availability zone where all dedicated hosts are allocated. 
status | enum **Status**<br>Status of the group. 
type_id | **string**<br>ID of host type. Resources provided by each host of the group. 
maintenance_policy | enum **MaintenancePolicy**<br>Behaviour on maintenance events. <ul><li>`RESTART`: Restart instances on the same host after maintenance event.</li><li>`MIGRATE`: Migrate instances to another host before maintenance event.</li></ul>
scale_policy | **[ScalePolicy](#ScalePolicy4)**<br>Scale policy. Only fixed number of hosts are supported at this moment. 


## Delete {#Delete}

Deletes the specified host group.

**rpc Delete ([DeleteHostGroupRequest](#DeleteHostGroupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteHostGroupMetadata](#DeleteHostGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteHostGroupRequest {#DeleteHostGroupRequest}

Field | Description
--- | ---
host_group_id | **string**<br>Required. ID of the host group to delete. To get the host group ID, use [HostGroupService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteHostGroupMetadata](#DeleteHostGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteHostGroupMetadata {#DeleteHostGroupMetadata}

Field | Description
--- | ---
host_group_id | **string**<br>ID of the host group that is being deleted. 


## ListOperations {#ListOperations}

Lists operations for the specified host group.

**rpc ListOperations ([ListHostGroupOperationsRequest](#ListHostGroupOperationsRequest)) returns ([ListHostGroupOperationsResponse](#ListHostGroupOperationsResponse))**

### ListHostGroupOperationsRequest {#ListHostGroupOperationsRequest}

Field | Description
--- | ---
host_group_id | **string**<br>Required. ID of the host group to list operations for. To get the host group ID, use [HostGroupService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListHostGroupOperationsResponse.next_page_token](#ListHostGroupOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListHostGroupOperationsResponse.next_page_token](#ListHostGroupOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListHostGroupOperationsResponse {#ListHostGroupOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified host group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListHostGroupOperationsRequest.page_size](#ListHostGroupOperationsRequest), use the `next_page_token` as the value for the [ListHostGroupOperationsRequest.page_token](#ListHostGroupOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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


## ListInstances {#ListInstances}

Lists instances that belongs to the specified host group.

**rpc ListInstances ([ListHostGroupInstancesRequest](#ListHostGroupInstancesRequest)) returns ([ListHostGroupInstancesResponse](#ListHostGroupInstancesResponse))**

### ListHostGroupInstancesRequest {#ListHostGroupInstancesRequest}

Field | Description
--- | ---
host_group_id | **string**<br>Required. ID of the host group to list instances for. To get the host group ID, use [HostGroupService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListHostGroupInstancesResponse.next_page_token](#ListHostGroupInstancesResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListHostGroupInstancesResponse.next_page_token](#ListHostGroupInstancesResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>Filter support is not currently implemented. Any filters are ignored. The maximum string length in characters is 1000.


### ListHostGroupInstancesResponse {#ListHostGroupInstancesResponse}

Field | Description
--- | ---
instances[] | **[Instance](#Instance)**<br>Lists instances for the specified host group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is more than [ListHostGroupInstancesRequest.page_size](#ListHostGroupInstancesRequest), use `next_page_token` as the value for the [ListHostGroupInstancesRequest.page_token](#ListHostGroupInstancesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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
gpu_settings | **[GpuSettings](#GpuSettings)**<br>GPU settings 
fqdn | **string**<br>A domain name of the instance. FQDN is defined by the server in the format `<hostname>.<region_id>.internal` when the instance is created. If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy)**<br>Scheduling policy configuration. 
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
network_settings | **[NetworkSettings](#NetworkSettings)**<br>Network Settings 
placement_policy | **[PlacementPolicy](#PlacementPolicy)**<br>Placement policy configuration. 
host_group_id | **string**<br>ID of the dedicated host group that the instance belongs to. 
host_id | **string**<br>ID of the dedicated host that the instance belongs to. 


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


### GpuSettings {#GpuSettings}

Field | Description
--- | ---
gpu_cluster_id | **string**<br>Attach instance to specified GPU cluster. 


### SchedulingPolicy {#SchedulingPolicy}

Field | Description
--- | ---
preemptible | **bool**<br>True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings}

Field | Description
--- | ---
type | enum **Type**<br>Network Type <ul><li>`STANDARD`: Standard network.</li><li>`SOFTWARE_ACCELERATED`: Software accelerated network.</li><li>`HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).</li></ul>


### PlacementPolicy {#PlacementPolicy}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 
placement_group_partition | **int64**<br>Placement group partition 


### HostAffinityRule {#HostAffinityRule}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action 
values[] | **string**<br>Affinity value or host ID or host group ID 


## ListHosts {#ListHosts}

Lists hosts that belongs to the specified host group.

**rpc ListHosts ([ListHostGroupHostsRequest](#ListHostGroupHostsRequest)) returns ([ListHostGroupHostsResponse](#ListHostGroupHostsResponse))**

### ListHostGroupHostsRequest {#ListHostGroupHostsRequest}

Field | Description
--- | ---
host_group_id | **string**<br>Required. ID of the host group to list hosts for. To get the host group ID, use [HostGroupService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListHostGroupHostsResponse.next_page_token](#ListHostGroupHostsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListHostGroupHostsResponse.next_page_token](#ListHostGroupHostsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListHostGroupHostsResponse {#ListHostGroupHostsResponse}

Field | Description
--- | ---
hosts[] | **[Host](#Host)**<br>Lists hosts for the specified host group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is more than [ListHostGroupHostsRequest.page_size](#ListHostGroupHostsRequest), use `next_page_token` as the value for the [ListHostGroupHostsRequest.page_token](#ListHostGroupHostsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Host {#Host}

Field | Description
--- | ---
id | **string**<br>ID of the host. 
status | enum **Status**<br>Current status of the host. New instances are unable to start on host in DOWN status. 
server_id | **string**<br>ID of the physical server that the host belongs to. 


