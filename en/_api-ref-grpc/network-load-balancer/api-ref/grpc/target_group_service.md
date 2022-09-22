---
editable: false
---

# TargetGroupService

A set of methods for managing TargetGroup resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified TargetGroup resource. |
| [List](#List) | Retrieves the list of TargetGroup resources in the specified folder. |
| [Create](#Create) | Creates a target group in the specified folder and adds the specified targets to it. |
| [Update](#Update) | Updates the specified target group. |
| [Delete](#Delete) | Deletes the specified target group. |
| [AddTargets](#AddTargets) | Adds targets to the target group. |
| [RemoveTargets](#RemoveTargets) | Removes targets from the target group. |
| [ListOperations](#ListOperations) | Lists operations for the specified target group. |

## Calls TargetGroupService {#calls}

## Get {#Get}

Returns the specified TargetGroup resource.

**rpc Get ([GetTargetGroupRequest](#GetTargetGroupRequest)) returns ([TargetGroup](#TargetGroup))**

### GetTargetGroupRequest {#GetTargetGroupRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the TargetGroup resource to return. To get the target group ID, use a [TargetGroupService.List](#List) request. The maximum string length in characters is 50.


### TargetGroup {#TargetGroup}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the target group. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the target group. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the target group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
region_id | **string**<br>ID of the region where the target group resides. 
targets[] | **[Target](#Target)**<br>A list of targets in the target group. 


### Target {#Target}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the subnet that targets are connected to. All targets in the target group must be connected to the same subnet within a single availability zone. The maximum string length in characters is 50.
address | **string**<br>IP address of the target. 


## List {#List}

Retrieves the list of TargetGroup resources in the specified folder.

**rpc List ([ListTargetGroupsRequest](#ListTargetGroupsRequest)) returns ([ListTargetGroupsResponse](#ListTargetGroupsResponse))**

### ListTargetGroupsRequest {#ListTargetGroupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list target groups in. To get the folder ID, use a [TargetGroupService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListTargetGroupsResponse.next_page_token](#ListTargetGroupsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListTargetGroupsResponse.next_page_token](#ListTargetGroupsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can only filter by the [TargetGroup.name](#TargetGroup1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> The maximum string length in characters is 1000.


### ListTargetGroupsResponse {#ListTargetGroupsResponse}

Field | Description
--- | ---
target_groups[] | **[TargetGroup](#TargetGroup1)**<br>List of TargetGroup resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListTargetGroupsRequest.page_size](#ListTargetGroupsRequest), use the `next_page_token` as the value for the [ListTargetGroupsRequest.page_token](#ListTargetGroupsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### TargetGroup {#TargetGroup1}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the target group. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the target group. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the target group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
region_id | **string**<br>ID of the region where the target group resides. 
targets[] | **[Target](#Target1)**<br>A list of targets in the target group. 


### Target {#Target1}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the subnet that targets are connected to. All targets in the target group must be connected to the same subnet within a single availability zone. The maximum string length in characters is 50.
address | **string**<br>IP address of the target. 


## Create {#Create}

Creates a target group in the specified folder and adds the specified targets to it.

**rpc Create ([CreateTargetGroupRequest](#CreateTargetGroupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateTargetGroupMetadata](#CreateTargetGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[TargetGroup](#TargetGroup2)<br>

### CreateTargetGroupRequest {#CreateTargetGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list target groups in. To get the folder ID, use a [TargetGroupService.List](#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the target group. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
region_id | **string**<br>ID of the availability zone where the target group resides. The maximum string length in characters is 50.
targets[] | **[Target](#Target2)**<br>List of targets within the target group. 


### Target {#Target2}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the subnet that targets are connected to. All targets in the target group must be connected to the same subnet within a single availability zone. The maximum string length in characters is 50.
address | **string**<br>IP address of the target. 


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
id | **string**<br>Output only. ID of the target group. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the target group. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the target group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
region_id | **string**<br>ID of the region where the target group resides. 
targets[] | **[Target](#Target3)**<br>A list of targets in the target group. 


## Update {#Update}

Updates the specified target group.

**rpc Update ([UpdateTargetGroupRequest](#UpdateTargetGroupRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateTargetGroupMetadata](#UpdateTargetGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[TargetGroup](#TargetGroup3)<br>

### UpdateTargetGroupRequest {#UpdateTargetGroupRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the TargetGroup resource to update. To get the target group ID, use a [TargetGroupService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the TargetGroup resource are going to be updated. 
name | **string**<br>Name of the target group. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. <br>The existing set of `` labels `` is completely replaced with the provided set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
targets[] | **[Target](#Target3)**<br>A new list of targets for this target group. 


### Target {#Target3}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the subnet that targets are connected to. All targets in the target group must be connected to the same subnet within a single availability zone. The maximum string length in characters is 50.
address | **string**<br>IP address of the target. 


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
id | **string**<br>Output only. ID of the target group. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the target group. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the target group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
region_id | **string**<br>ID of the region where the target group resides. 
targets[] | **[Target](#Target4)**<br>A list of targets in the target group. 


## Delete {#Delete}

Deletes the specified target group.

**rpc Delete ([DeleteTargetGroupRequest](#DeleteTargetGroupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteTargetGroupMetadata](#DeleteTargetGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteTargetGroupRequest {#DeleteTargetGroupRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the target group to delete. To get the target group ID, use a [TargetGroupService.List](#List) request. The maximum string length in characters is 50.


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

Adds targets to the target group.

**rpc AddTargets ([AddTargetsRequest](#AddTargetsRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddTargetsMetadata](#AddTargetsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[TargetGroup](#TargetGroup4)<br>

### AddTargetsRequest {#AddTargetsRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the TargetGroup resource to add targets to. To get the target group ID, use a [TargetGroupService.List](#List) request. The maximum string length in characters is 50.
targets[] | **[Target](#Target4)**<br>List of targets to add to the target group. The minimum number of elements is 1.


### Target {#Target4}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the subnet that targets are connected to. All targets in the target group must be connected to the same subnet within a single availability zone. The maximum string length in characters is 50.
address | **string**<br>IP address of the target. 


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
target_group_id | **string**<br>ID of the target group that targets are being added to. 


### TargetGroup {#TargetGroup4}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the target group. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the target group. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the target group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
region_id | **string**<br>ID of the region where the target group resides. 
targets[] | **[Target](#Target5)**<br>A list of targets in the target group. 


## RemoveTargets {#RemoveTargets}

Removes targets from the target group.

**rpc RemoveTargets ([RemoveTargetsRequest](#RemoveTargetsRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveTargetsMetadata](#RemoveTargetsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[TargetGroup](#TargetGroup5)<br>

### RemoveTargetsRequest {#RemoveTargetsRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the target group to remove targets from. To get the target group ID, use a [TargetGroupService.List](#List) request. The maximum string length in characters is 50.
targets[] | **[Target](#Target5)**<br>List of targets to remove from the target group. The minimum number of elements is 1.


### Target {#Target5}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the subnet that targets are connected to. All targets in the target group must be connected to the same subnet within a single availability zone. The maximum string length in characters is 50.
address | **string**<br>IP address of the target. 


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
target_group_id | **string**<br>ID of the target group that targets are being removed from. 


### TargetGroup {#TargetGroup5}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the target group. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the target group. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the target group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
region_id | **string**<br>ID of the region where the target group resides. 
targets[] | **[Target](#Target6)**<br>A list of targets in the target group. 


## ListOperations {#ListOperations}

Lists operations for the specified target group.

**rpc ListOperations ([ListTargetGroupOperationsRequest](#ListTargetGroupOperationsRequest)) returns ([ListTargetGroupOperationsResponse](#ListTargetGroupOperationsResponse))**

### ListTargetGroupOperationsRequest {#ListTargetGroupOperationsRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the TargetGroup resource to update. To get the target group ID, use a [TargetGroupService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListTargetGroupOperationsResponse.next_page_token](#ListTargetGroupOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListTargetGroupOperationsResponse.next_page_token](#ListTargetGroupOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListTargetGroupOperationsResponse {#ListTargetGroupOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>List of operations for the specified target group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListTargetGroupOperationsRequest.page_size](#ListTargetGroupOperationsRequest), use the `next_page_token` as the value for the [ListTargetGroupOperationsRequest.page_token](#ListTargetGroupOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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


