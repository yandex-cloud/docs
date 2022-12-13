---
editable: false
---

# Application Load Balancer API, gRPC: TargetGroupService

A set of methods for managing target groups.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified target group. |
| [List](#List) | Lists target groups in the specified folder. |
| [Create](#Create) | Creates a target group in the specified folder. |
| [Update](#Update) | Updates the specified target group. |
| [Delete](#Delete) | Deletes the specified target group. |
| [AddTargets](#AddTargets) | Adds targets to the specified target group. |
| [RemoveTargets](#RemoveTargets) | Removes targets from the specified target group. |
| [ListOperations](#ListOperations) | Lists operations for the specified target group. |

## Calls TargetGroupService {#calls}

## Get {#Get}

Returns the specified target group. <br>To get the list of all available target groups, make a [List](#List) request.

**rpc Get ([GetTargetGroupRequest](#GetTargetGroupRequest)) returns ([TargetGroup](#TargetGroup))**

### GetTargetGroupRequest {#GetTargetGroupRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the target group to return. <br>To get the target group ID, make a [TargetGroupService.List](#List) request. 


### TargetGroup {#TargetGroup}

Field | Description
--- | ---
id | **string**<br>ID of the target group. Generated at creation time. 
name | **string**<br>Name of the target group. The name is unique within the folder. 
description | **string**<br>Description of the target group. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
labels | **map<string,string>**<br>Target group labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
targets[] | **[Target](#Target)**<br>List of targets in the target group. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### Target {#Target}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>Reference to the target. As of now, targets must only be referred to by their IP addresses.
&nbsp;&nbsp;ip_address | **string**<br>IP address of the target. 
subnet_id | **string**<br>ID of the subnet that the target is connected to. 
private_ipv4_address | **bool**<br>If set, will not require `subnet_id` to validate the target. Instead, the address should belong to one of the following ranges: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 Only one of `subnet_id` or `private_ipv4_address` should be set. 


## List {#List}

Lists target groups in the specified folder.

**rpc List ([ListTargetGroupsRequest](#ListTargetGroupsRequest)) returns ([ListTargetGroupsResponse](#ListTargetGroupsResponse))**

### ListTargetGroupsRequest {#ListTargetGroupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list target groups in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListTargetGroupsResponse.next_page_token](#ListTargetGroupsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListTargetGroupsResponse.next_page_token](#ListTargetGroupsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters target groups listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering only on [TargetGroup.name](#TargetGroup1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name=my-target-group`. The maximum string length in characters is 1000.


### ListTargetGroupsResponse {#ListTargetGroupsResponse}

Field | Description
--- | ---
target_groups[] | **[TargetGroup](#TargetGroup1)**<br>List of target groups in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListTargetGroupsRequest.page_size](#ListTargetGroupsRequest), use `next_page_token` as the value for the [ListTargetGroupsRequest.page_token](#ListTargetGroupsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### TargetGroup {#TargetGroup1}

Field | Description
--- | ---
id | **string**<br>ID of the target group. Generated at creation time. 
name | **string**<br>Name of the target group. The name is unique within the folder. 
description | **string**<br>Description of the target group. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
labels | **map<string,string>**<br>Target group labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
targets[] | **[Target](#Target1)**<br>List of targets in the target group. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### Target {#Target1}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>Reference to the target. As of now, targets must only be referred to by their IP addresses.
&nbsp;&nbsp;ip_address | **string**<br>IP address of the target. 
subnet_id | **string**<br>ID of the subnet that the target is connected to. 
private_ipv4_address | **bool**<br>If set, will not require `subnet_id` to validate the target. Instead, the address should belong to one of the following ranges: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 Only one of `subnet_id` or `private_ipv4_address` should be set. 


## Create {#Create}

Creates a target group in the specified folder.

**rpc Create ([CreateTargetGroupRequest](#CreateTargetGroupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateTargetGroupMetadata](#CreateTargetGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[TargetGroup](#TargetGroup2)<br>

### CreateTargetGroupRequest {#CreateTargetGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a target group in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
name | **string**<br>Name of the target group. The name must be unique within the folder. Value must match the regular expression ` ([a-z]([-a-z0-9]{0,61}[a-z0-9])?)? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Target group labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
targets[] | **[Target](#Target2)**<br>List of targets in the target group. 


### Target {#Target2}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>Reference to the target. As of now, targets must only be referred to by their IP addresses.
&nbsp;&nbsp;ip_address | **string**<br>IP address of the target. 
subnet_id | **string**<br>ID of the subnet that the target is connected to. 
private_ipv4_address | **bool**<br>If set, will not require `subnet_id` to validate the target. Instead, the address should belong to one of the following ranges: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 Only one of `subnet_id` or `private_ipv4_address` should be set. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateTargetGroupMetadata](#CreateTargetGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[TargetGroup](#TargetGroup2)>**<br>if operation finished successfully. 


### CreateTargetGroupMetadata {#CreateTargetGroupMetadata}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the target group that is being created. 


### TargetGroup {#TargetGroup2}

Field | Description
--- | ---
id | **string**<br>ID of the target group. Generated at creation time. 
name | **string**<br>Name of the target group. The name is unique within the folder. 
description | **string**<br>Description of the target group. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
labels | **map<string,string>**<br>Target group labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
targets[] | **[Target](#Target3)**<br>List of targets in the target group. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## Update {#Update}

Updates the specified target group.

**rpc Update ([UpdateTargetGroupRequest](#UpdateTargetGroupRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateTargetGroupMetadata](#UpdateTargetGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[TargetGroup](#TargetGroup3)<br>

### UpdateTargetGroupRequest {#UpdateTargetGroupRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the target group to update. <br>To get the target group ID, make a [TargetGroupService.List](#List) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the target group should be updated. 
name | **string**<br>New name for the target group. The name must be unique within the folder. Value must match the regular expression ` ([a-z]([-a-z0-9]{0,61}[a-z0-9])?)? `.
description | **string**<br>New description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Target group labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). <br>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: <ol><li>Get the current set of labels with a [TargetGroupService.Get](#Get) request. </li><li>Add or remove a label in this set. </li><li>Send the new set in this field.</li></ol> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
targets[] | **[Target](#Target3)**<br>New list of targets in the target group. <br>Existing list of targets is completely replaced by the specified list, so if you just want to add or remove a target, make a [TargetGroupService.AddTargets](#AddTargets) request or a [TargetGroupService.RemoveTargets](#RemoveTargets) request. 


### Target {#Target3}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>Reference to the target. As of now, targets must only be referred to by their IP addresses.
&nbsp;&nbsp;ip_address | **string**<br>IP address of the target. 
subnet_id | **string**<br>ID of the subnet that the target is connected to. 
private_ipv4_address | **bool**<br>If set, will not require `subnet_id` to validate the target. Instead, the address should belong to one of the following ranges: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 Only one of `subnet_id` or `private_ipv4_address` should be set. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateTargetGroupMetadata](#UpdateTargetGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[TargetGroup](#TargetGroup3)>**<br>if operation finished successfully. 


### UpdateTargetGroupMetadata {#UpdateTargetGroupMetadata}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the target group that is being updated. 


### TargetGroup {#TargetGroup3}

Field | Description
--- | ---
id | **string**<br>ID of the target group. Generated at creation time. 
name | **string**<br>Name of the target group. The name is unique within the folder. 
description | **string**<br>Description of the target group. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
labels | **map<string,string>**<br>Target group labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
targets[] | **[Target](#Target4)**<br>List of targets in the target group. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## Delete {#Delete}

Deletes the specified target group.

**rpc Delete ([DeleteTargetGroupRequest](#DeleteTargetGroupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteTargetGroupMetadata](#DeleteTargetGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteTargetGroupRequest {#DeleteTargetGroupRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the target group to delete. <br>To get the target group ID, make a [TargetGroupService.List](#List) request. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteTargetGroupMetadata](#DeleteTargetGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteTargetGroupMetadata {#DeleteTargetGroupMetadata}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the target group that is being deleted. 


## AddTargets {#AddTargets}

Adds targets to the specified target group.

**rpc AddTargets ([AddTargetsRequest](#AddTargetsRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddTargetsMetadata](#AddTargetsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[TargetGroup](#TargetGroup4)<br>

### AddTargetsRequest {#AddTargetsRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the target group to add targets to. <br>To get the target group ID, make a [TargetGroupService.List](#List) request. 
targets[] | **[Target](#Target4)**<br>List of targets to add to the target group. The number of elements must be greater than 0.


### Target {#Target4}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>Reference to the target. As of now, targets must only be referred to by their IP addresses.
&nbsp;&nbsp;ip_address | **string**<br>IP address of the target. 
subnet_id | **string**<br>ID of the subnet that the target is connected to. 
private_ipv4_address | **bool**<br>If set, will not require `subnet_id` to validate the target. Instead, the address should belong to one of the following ranges: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 Only one of `subnet_id` or `private_ipv4_address` should be set. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddTargetsMetadata](#AddTargetsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[TargetGroup](#TargetGroup4)>**<br>if operation finished successfully. 


### AddTargetsMetadata {#AddTargetsMetadata}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the target group that the targets are being added to. 


### TargetGroup {#TargetGroup4}

Field | Description
--- | ---
id | **string**<br>ID of the target group. Generated at creation time. 
name | **string**<br>Name of the target group. The name is unique within the folder. 
description | **string**<br>Description of the target group. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
labels | **map<string,string>**<br>Target group labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
targets[] | **[Target](#Target5)**<br>List of targets in the target group. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## RemoveTargets {#RemoveTargets}

Removes targets from the specified target group.

**rpc RemoveTargets ([RemoveTargetsRequest](#RemoveTargetsRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveTargetsMetadata](#RemoveTargetsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[TargetGroup](#TargetGroup5)<br>

### RemoveTargetsRequest {#RemoveTargetsRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the target group to remove targets from. <br>To get the target group ID, make a [TargetGroupService.List](#List) request. 
targets[] | **[Target](#Target5)**<br>List of targets to remove from the target group. The number of elements must be greater than 0.


### Target {#Target5}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>Reference to the target. As of now, targets must only be referred to by their IP addresses.
&nbsp;&nbsp;ip_address | **string**<br>IP address of the target. 
subnet_id | **string**<br>ID of the subnet that the target is connected to. 
private_ipv4_address | **bool**<br>If set, will not require `subnet_id` to validate the target. Instead, the address should belong to one of the following ranges: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 Only one of `subnet_id` or `private_ipv4_address` should be set. 


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RemoveTargetsMetadata](#RemoveTargetsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[TargetGroup](#TargetGroup5)>**<br>if operation finished successfully. 


### RemoveTargetsMetadata {#RemoveTargetsMetadata}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the target group that the targets are being removed from. 


### TargetGroup {#TargetGroup5}

Field | Description
--- | ---
id | **string**<br>ID of the target group. Generated at creation time. 
name | **string**<br>Name of the target group. The name is unique within the folder. 
description | **string**<br>Description of the target group. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
labels | **map<string,string>**<br>Target group labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
targets[] | **[Target](#Target6)**<br>List of targets in the target group. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## ListOperations {#ListOperations}

Lists operations for the specified target group.

**rpc ListOperations ([ListTargetGroupOperationsRequest](#ListTargetGroupOperationsRequest)) returns ([ListTargetGroupOperationsResponse](#ListTargetGroupOperationsResponse))**

### ListTargetGroupOperationsRequest {#ListTargetGroupOperationsRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the target group to get operations for. <br>To get the target group ID, use a [TargetGroupService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListTargetGroupOperationsResponse.next_page_token](#ListTargetGroupOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListTargetGroupOperationsResponse.next_page_token](#ListTargetGroupOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListTargetGroupOperationsResponse {#ListTargetGroupOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>List of operations for the specified target group. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListTargetGroupOperationsRequest.page_size](#ListTargetGroupOperationsRequest), use `next_page_token` as the value for the [ListTargetGroupOperationsRequest.page_token](#ListTargetGroupOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


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


