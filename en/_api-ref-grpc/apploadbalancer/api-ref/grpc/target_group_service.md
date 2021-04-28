---
editable: false
---

# TargetGroupService



| Call | Description |
| --- | --- |
| [Get](#Get) |  |
| [List](#List) |  |
| [Create](#Create) |  |
| [Update](#Update) |  |
| [Delete](#Delete) |  |
| [AddTargets](#AddTargets) |  |
| [RemoveTargets](#RemoveTargets) |  |
| [ListOperations](#ListOperations) | Lists operations for the specified target group. |

## Calls TargetGroupService {#calls}

## Get {#Get}



**rpc Get ([GetTargetGroupRequest](#GetTargetGroupRequest)) returns ([TargetGroup](#TargetGroup))**

### GetTargetGroupRequest {#GetTargetGroupRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required.  


### TargetGroup {#TargetGroup}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the target group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the target group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
targets[] | **[Target](#Target)**<br>NOTE: all endpoints must use the same address_type - either ip or hostname. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the target group. 


### Target {#Target}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>
&nbsp;&nbsp;ip_address | **string**<br> 
subnet_id | **string**<br>ID of the subnet that target connected to. 


## List {#List}



**rpc List ([ListTargetGroupsRequest](#ListTargetGroupsRequest)) returns ([ListTargetGroupsResponse](#ListTargetGroupsResponse))**

### ListTargetGroupsRequest {#ListTargetGroupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required.  
page_size | **int64**<br> Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br> The maximum string length in characters is 100.
filter | **string**<br> The maximum string length in characters is 1000.


### ListTargetGroupsResponse {#ListTargetGroupsResponse}

Field | Description
--- | ---
target_groups[] | **[TargetGroup](#TargetGroup1)**<br> 
next_page_token | **string**<br> 


### TargetGroup {#TargetGroup1}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the target group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the target group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
targets[] | **[Target](#Target1)**<br>NOTE: all endpoints must use the same address_type - either ip or hostname. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the target group. 


### Target {#Target1}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>
&nbsp;&nbsp;ip_address | **string**<br> 
subnet_id | **string**<br>ID of the subnet that target connected to. 


## Create {#Create}



**rpc Create ([CreateTargetGroupRequest](#CreateTargetGroupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateTargetGroupMetadata](#CreateTargetGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[TargetGroup](#TargetGroup2)<br>

### CreateTargetGroupRequest {#CreateTargetGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required.  
name | **string**<br> Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
targets[] | **[Target](#Target2)**<br> 


### Target {#Target2}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>
&nbsp;&nbsp;ip_address | **string**<br> 
subnet_id | **string**<br>ID of the subnet that target connected to. 


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
target_group_id | **string**<br> 


### TargetGroup {#TargetGroup2}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the target group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the target group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
targets[] | **[Target](#Target3)**<br>NOTE: all endpoints must use the same address_type - either ip or hostname. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the target group. 


### Target {#Target3}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>
&nbsp;&nbsp;ip_address | **string**<br> 
subnet_id | **string**<br>ID of the subnet that target connected to. 


## Update {#Update}



**rpc Update ([UpdateTargetGroupRequest](#UpdateTargetGroupRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateTargetGroupMetadata](#UpdateTargetGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[TargetGroup](#TargetGroup3)<br>

### UpdateTargetGroupRequest {#UpdateTargetGroupRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required.  
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
name | **string**<br> Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
targets[] | **[Target](#Target4)**<br> 


### Target {#Target4}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>
&nbsp;&nbsp;ip_address | **string**<br> 
subnet_id | **string**<br>ID of the subnet that target connected to. 


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
target_group_id | **string**<br> 


### TargetGroup {#TargetGroup3}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the target group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the target group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
targets[] | **[Target](#Target5)**<br>NOTE: all endpoints must use the same address_type - either ip or hostname. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the target group. 


### Target {#Target5}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>
&nbsp;&nbsp;ip_address | **string**<br> 
subnet_id | **string**<br>ID of the subnet that target connected to. 


## Delete {#Delete}



**rpc Delete ([DeleteTargetGroupRequest](#DeleteTargetGroupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteTargetGroupMetadata](#DeleteTargetGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteTargetGroupRequest {#DeleteTargetGroupRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required.  


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
target_group_id | **string**<br> 


## AddTargets {#AddTargets}



**rpc AddTargets ([AddTargetsRequest](#AddTargetsRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddTargetsMetadata](#AddTargetsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[TargetGroup](#TargetGroup4)<br>

### AddTargetsRequest {#AddTargetsRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required.  
targets[] | **[Target](#Target6)**<br> The number of elements must be greater than 0.


### Target {#Target6}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>
&nbsp;&nbsp;ip_address | **string**<br> 
subnet_id | **string**<br>ID of the subnet that target connected to. 


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
target_group_id | **string**<br> 


### TargetGroup {#TargetGroup4}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the target group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the target group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
targets[] | **[Target](#Target7)**<br>NOTE: all endpoints must use the same address_type - either ip or hostname. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the target group. 


### Target {#Target7}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>
&nbsp;&nbsp;ip_address | **string**<br> 
subnet_id | **string**<br>ID of the subnet that target connected to. 


## RemoveTargets {#RemoveTargets}



**rpc RemoveTargets ([RemoveTargetsRequest](#RemoveTargetsRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveTargetsMetadata](#RemoveTargetsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[TargetGroup](#TargetGroup5)<br>

### RemoveTargetsRequest {#RemoveTargetsRequest}

Field | Description
--- | ---
target_group_id | **string**<br>Required.  
targets[] | **[Target](#Target8)**<br> The number of elements must be greater than 0.


### Target {#Target8}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>
&nbsp;&nbsp;ip_address | **string**<br> 
subnet_id | **string**<br>ID of the subnet that target connected to. 


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
target_group_id | **string**<br> 


### TargetGroup {#TargetGroup5}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the target group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the target group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the target group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
targets[] | **[Target](#Target9)**<br>NOTE: all endpoints must use the same address_type - either ip or hostname. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the target group. 


### Target {#Target9}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>
&nbsp;&nbsp;ip_address | **string**<br> 
subnet_id | **string**<br>ID of the subnet that target connected to. 


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


