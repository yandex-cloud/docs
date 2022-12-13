---
editable: false
sourcePath: en/_api-ref-grpc/logging/api-ref/grpc/log_group_service.md
---

# Cloud Logging Service, gRPC: LogGroupService

A set of methods for managing log groups.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified log group. |
| [Stats](#Stats) | Returns stats for the specified log group. |
| [List](#List) | Retrieves the list of log groups in the specified folder. |
| [Create](#Create) | Creates a log group in the specified folder. |
| [Update](#Update) | Updates the specified log group. |
| [Delete](#Delete) | Deletes the specified log group. |
| [ListResources](#ListResources) | Retrieves the resources (type and IDs) in the specified log group. |
| [ListOperations](#ListOperations) | Lists operations for the specified log group. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified log group. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the specified log group. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified log group. |

## Calls LogGroupService {#calls}

## Get {#Get}

Returns the specified log group. <br>To get the list of all available log groups, make a [List](#List) request.

**rpc Get ([GetLogGroupRequest](#GetLogGroupRequest)) returns ([LogGroup](#LogGroup))**

### GetLogGroupRequest {#GetLogGroupRequest}

Field | Description
--- | ---
log_group_id | **string**<br>Required. ID of the log group to return. <br>To get a log group ID make a [LogGroupService.List](#List) request. The maximum string length in characters is 64.


### LogGroup {#LogGroup}

Field | Description
--- | ---
id | **string**<br>Log group ID. 
folder_id | **string**<br>Log group folder ID. 
cloud_id | **string**<br>Log group cloud ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log group creation time. 
name | **string**<br>Log group name. 
description | **string**<br>Log group description. 
labels | **map<string,string>**<br>Log group labels. 
status | enum **Status**<br>Status of the log group. <ul><li>`STATUS_UNSPECIFIED`: Unknown status. <br>Should never occur.</li><li>`CREATING`: Log group is creating.</li><li>`ACTIVE`: Log group is ready to accept messages,</li><li>`DELETING`: Log group is being deleted. <br>No messages will be accepted.</li><li>`ERROR`: Log group is in failed state.</li></ul>
retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Log group entry retention period. <br>Entries will be present in group during this period. 
data_stream | **string**<br>Data stream name 


## Stats {#Stats}

Returns stats for the specified log group.

**rpc Stats ([GetLogGroupStatsRequest](#GetLogGroupStatsRequest)) returns ([GetLogGroupStatsResponse](#GetLogGroupStatsResponse))**

### GetLogGroupStatsRequest {#GetLogGroupStatsRequest}

Field | Description
--- | ---
log_group_id | **string**<br>Required. ID of the log group to return stats for. <br>To get a log group ID make a [LogGroupService.List](#List) request. The maximum string length in characters is 64.


### GetLogGroupStatsResponse {#GetLogGroupStatsResponse}

Field | Description
--- | ---
log_group_id | **string**<br>Log group ID the stats are returned for. 
bytes | **int64**<br>Size of data in log group in bytes. 
records | **int64**<br>Amount of records in log group. 


## List {#List}

Retrieves the list of log groups in the specified folder.

**rpc List ([ListLogGroupsRequest](#ListLogGroupsRequest)) returns ([ListLogGroupsResponse](#ListLogGroupsResponse))**

### ListLogGroupsRequest {#ListLogGroupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID of the log groups to return. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 64.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListLogGroupsResponse.next_page_token](#ListLogGroupsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListLogGroupsResponse.next_page_token](#ListLogGroupsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters log groups listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can only be applied to the [LogGroup.name](#LogGroup1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name=my-log-group`. The maximum string length in characters is 1000.


### ListLogGroupsResponse {#ListLogGroupsResponse}

Field | Description
--- | ---
groups[] | **[LogGroup](#LogGroup1)**<br>List of log groups in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListLogGroupsRequest.page_size](#ListLogGroupsRequest), use `next_page_token` as the value for the [ListLogGroupsRequest.page_token](#ListLogGroupsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### LogGroup {#LogGroup1}

Field | Description
--- | ---
id | **string**<br>Log group ID. 
folder_id | **string**<br>Log group folder ID. 
cloud_id | **string**<br>Log group cloud ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log group creation time. 
name | **string**<br>Log group name. 
description | **string**<br>Log group description. 
labels | **map<string,string>**<br>Log group labels. 
status | enum **Status**<br>Status of the log group. <ul><li>`STATUS_UNSPECIFIED`: Unknown status. <br>Should never occur.</li><li>`CREATING`: Log group is creating.</li><li>`ACTIVE`: Log group is ready to accept messages,</li><li>`DELETING`: Log group is being deleted. <br>No messages will be accepted.</li><li>`ERROR`: Log group is in failed state.</li></ul>
retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Log group entry retention period. <br>Entries will be present in group during this period. 
data_stream | **string**<br>Data stream name 


## Create {#Create}

Creates a log group in the specified folder.

**rpc Create ([CreateLogGroupRequest](#CreateLogGroupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateLogGroupMetadata](#CreateLogGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LogGroup](#LogGroup2)<br>

### CreateLogGroupRequest {#CreateLogGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a log group in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 64.
name | **string**<br>Name of the log group. The name must be unique within the folder. Value must match the regular expression ` ([a-z]([-a-z0-9]{1,61}[a-z0-9])?)? `.
description | **string**<br>Description of the log group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Log group labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Log group entry retention period. <br>Entries will be present in group during this period. If specified, must be non-negative. Empty or zero value is treated as no limit. 
data_stream | **string**<br>If specified, all log records will be written to this data stream The maximum string length in characters is 512.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateLogGroupMetadata](#CreateLogGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LogGroup](#LogGroup2)>**<br>if operation finished successfully. 


### CreateLogGroupMetadata {#CreateLogGroupMetadata}

Field | Description
--- | ---
log_group_id | **string**<br>ID of the log group being created. 


### LogGroup {#LogGroup2}

Field | Description
--- | ---
id | **string**<br>Log group ID. 
folder_id | **string**<br>Log group folder ID. 
cloud_id | **string**<br>Log group cloud ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log group creation time. 
name | **string**<br>Log group name. 
description | **string**<br>Log group description. 
labels | **map<string,string>**<br>Log group labels. 
status | enum **Status**<br>Status of the log group. <ul><li>`STATUS_UNSPECIFIED`: Unknown status. <br>Should never occur.</li><li>`CREATING`: Log group is creating.</li><li>`ACTIVE`: Log group is ready to accept messages,</li><li>`DELETING`: Log group is being deleted. <br>No messages will be accepted.</li><li>`ERROR`: Log group is in failed state.</li></ul>
retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Log group entry retention period. <br>Entries will be present in group during this period. 
data_stream | **string**<br>Data stream name 


## Update {#Update}

Updates the specified log group.

**rpc Update ([UpdateLogGroupRequest](#UpdateLogGroupRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateLogGroupMetadata](#UpdateLogGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LogGroup](#LogGroup3)<br>

### UpdateLogGroupRequest {#UpdateLogGroupRequest}

Field | Description
--- | ---
log_group_id | **string**<br>Required. ID of the log group to update. <br>To get a log group ID make a [LogGroupService.List](#List) request. The maximum string length in characters is 64.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the function should be updated. 
name | **string**<br>New name of the log group. The name must be unique within the folder. Value must match the regular expression ` ([a-z]([-a-z0-9]{1,61}[a-z0-9])?)? `.
description | **string**<br>New Description of the log group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>New log group labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>New log group entry retention period. <br>Entries will be present in group during this period. If specified, must be non-negative. Empty or zero value is treated as no limit. 
data_stream | **string**<br>If specified, log records will be written to this data stream The maximum string length in characters is 512.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateLogGroupMetadata](#UpdateLogGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LogGroup](#LogGroup3)>**<br>if operation finished successfully. 


### UpdateLogGroupMetadata {#UpdateLogGroupMetadata}

Field | Description
--- | ---
log_group_id | **string**<br>ID of the log group being updated. 


### LogGroup {#LogGroup3}

Field | Description
--- | ---
id | **string**<br>Log group ID. 
folder_id | **string**<br>Log group folder ID. 
cloud_id | **string**<br>Log group cloud ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log group creation time. 
name | **string**<br>Log group name. 
description | **string**<br>Log group description. 
labels | **map<string,string>**<br>Log group labels. 
status | enum **Status**<br>Status of the log group. <ul><li>`STATUS_UNSPECIFIED`: Unknown status. <br>Should never occur.</li><li>`CREATING`: Log group is creating.</li><li>`ACTIVE`: Log group is ready to accept messages,</li><li>`DELETING`: Log group is being deleted. <br>No messages will be accepted.</li><li>`ERROR`: Log group is in failed state.</li></ul>
retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Log group entry retention period. <br>Entries will be present in group during this period. 
data_stream | **string**<br>Data stream name 


## Delete {#Delete}

Deletes the specified log group.

**rpc Delete ([DeleteLogGroupRequest](#DeleteLogGroupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteLogGroupMetadata](#DeleteLogGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteLogGroupRequest {#DeleteLogGroupRequest}

Field | Description
--- | ---
log_group_id | **string**<br>Required. ID of the log group to delete. <br>To get a log group ID make a [LogGroupService.List](#List) request. The maximum string length in characters is 64.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteLogGroupMetadata](#DeleteLogGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteLogGroupMetadata {#DeleteLogGroupMetadata}

Field | Description
--- | ---
log_group_id | **string**<br>ID of the log group being deleted. 


## ListResources {#ListResources}

Retrieves the resources (type and IDs) in the specified log group.

**rpc ListResources ([ListResourcesRequest](#ListResourcesRequest)) returns ([ListResourcesResponse](#ListResourcesResponse))**

### ListResourcesRequest {#ListResourcesRequest}

Field | Description
--- | ---
log_group_id | **string**<br>Required. ID of the log group to list resources for. <br>To get a log group ID make a [LogGroupService.List](#List) request. The maximum string length in characters is 64.
type | **string**<br>Resource type to return resources for. <br>If not specified, [ListResourcesResponse](#ListResourcesResponse) will contain information about all resource types. The maximum string length in characters is 256.


### ListResourcesResponse {#ListResourcesResponse}

Field | Description
--- | ---
resources[] | **[LogGroupResource](#LogGroupResource)**<br>List of resources present in log group. 


### LogGroupResource {#LogGroupResource}

Field | Description
--- | ---
type | **string**<br>Resource type. <br>Collected from log entries inside log group. 
ids[] | **string**<br>List of resource IDs with the same resource type. 


## ListOperations {#ListOperations}

Lists operations for the specified log group.

**rpc ListOperations ([ListOperationsRequest](#ListOperationsRequest)) returns ([ListOperationsResponse](#ListOperationsResponse))**

### ListOperationsRequest {#ListOperationsRequest}

Field | Description
--- | ---
log_group_id | **string**<br>Required. ID of the log group to list operations for. <br>To get a log group ID make a [LogGroupService.List](#List) request. The maximum string length in characters is 64.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListOperationsResponse.next_page_token](#ListOperationsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListOperationsResponse.next_page_token](#ListOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can be applied to the [operation.Operation.description](#Operation3), [operation.Operation.created_at](#Operation3), [operation.Operation.modified_at](#Operation3), [operation.Operation.created_by](#Operation3), [operation.Operation.done](#Operation3) fields. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Examples of a filter: `done=false`, `created_by='John.Doe'`. The maximum string length in characters is 1000.


### ListOperationsResponse {#ListOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified log group. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListOperationsRequest.page_size](#ListOperationsRequest), use `next_page_token` as the value for the [ListOperationsRequest.page_token](#ListOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


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


## ListAccessBindings {#ListAccessBindings}

Lists existing access bindings for the specified log group.

**rpc ListAccessBindings ([ListAccessBindingsRequest](#ListAccessBindingsRequest)) returns ([ListAccessBindingsResponse](#ListAccessBindingsResponse))**

### ListAccessBindingsRequest {#ListAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource to list access bindings for. <br>To get the resource ID, use a corresponding List request. For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/cloud_service#List) request to get the Cloud resource ID. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. Set `page_token` to the [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) returned by a previous list request to get the next page of results. The maximum string length in characters is 100.


### ListAccessBindingsResponse {#ListAccessBindingsResponse}

Field | Description
--- | ---
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>List of access bindings for the specified resource. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListAccessBindingsRequest.page_size](#ListAccessBindingsRequest), use the `next_page_token` as the value for the [ListAccessBindingsRequest.page_token](#ListAccessBindingsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### AccessBinding {#AccessBinding}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


## SetAccessBindings {#SetAccessBindings}

Sets access bindings for the specified log group.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### SetAccessBindingsRequest {#SetAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being set. <br>To get the resource ID, use a corresponding List request. The maximum string length in characters is 50.
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>Required. Access bindings to be set. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding1}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject1}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### SetAccessBindingsMetadata {#SetAccessBindingsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of the resource for which access bindings are being set. 


## UpdateAccessBindings {#UpdateAccessBindings}

Updates access bindings for the specified log group.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateAccessBindingsRequest {#UpdateAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being updated. The maximum string length in characters is 50.
access_binding_deltas[] | **[AccessBindingDelta](#AccessBindingDelta)**<br>Required. Updates to access bindings. The number of elements must be greater than 0.


### AccessBindingDelta {#AccessBindingDelta}

Field | Description
--- | ---
action | enum **AccessBindingAction**<br>Required. The action that is being performed on an access binding. <ul><li>`ADD`: Addition of an access binding.</li><li>`REMOVE`: Removal of an access binding.</li></ul>
access_binding | **[AccessBinding](#AccessBinding)**<br>Required. Access binding. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding2}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject2}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### UpdateAccessBindingsMetadata {#UpdateAccessBindingsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of the resource for which access bindings are being updated. 


