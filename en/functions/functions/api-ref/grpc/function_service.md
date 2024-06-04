---
editable: false
sourcePath: en/_api-ref-grpc/functions/functions/functions/api-ref/grpc/function_service.md
---

# Cloud Functions Service, gRPC: FunctionService

A set of methods for managing serverless functions.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified function. |
| [List](#List) | Retrieves the list of functions in the specified folder. |
| [Create](#Create) | Creates a function in the specified folder. |
| [Update](#Update) | Updates the specified function. |
| [Delete](#Delete) | Deletes the specified function. |
| [GetVersion](#GetVersion) | Returns the specified version of a function. |
| [GetFunctionVersion](#GetFunctionVersion) | Deprecated. |
| [GetVersionByTag](#GetVersionByTag) | Returns all versions with the specified tag. |
| [GetFunctionVersionByTag](#GetFunctionVersionByTag) | Deprecated. |
| [ListVersions](#ListVersions) | Retrieves the list of versions for the specified function, or of all function versions in the specified folder. |
| [ListFunctionVersions](#ListFunctionVersions) | Deprecated. |
| [DeleteVersion](#DeleteVersion) | Deletes the specified version of a function. |
| [SetTag](#SetTag) | Set a tag for the specified version of a function. |
| [RemoveTag](#RemoveTag) | Remove a tag from the specified version of a function. |
| [ListTagHistory](#ListTagHistory) | Returns the log of tags assigned to versions of the specified function. |
| [ListFunctionTagHistory](#ListFunctionTagHistory) | Deprecated. |
| [CreateVersion](#CreateVersion) | Creates a version for the specified function. |
| [CreateFunctionVersion](#CreateFunctionVersion) | Deprecated. |
| [ListRuntimes](#ListRuntimes) | Lists available runtime environments for the specified function. |
| [ListOperations](#ListOperations) | Lists operations for the specified function. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified function. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the function. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified function. |
| [ListScalingPolicies](#ListScalingPolicies) | Lists existing scaling policies for specified function |
| [SetScalingPolicy](#SetScalingPolicy) | Set scaling policy for specified function and tag |
| [RemoveScalingPolicy](#RemoveScalingPolicy) | Remove scaling policy for specified function and tag |

## Calls FunctionService {#calls}

## Get {#Get}

Returns the specified function. <br>To get the list of all available functions, make a [List](#List) request.

**rpc Get ([GetFunctionRequest](#GetFunctionRequest)) returns ([Function](#Function))**

### GetFunctionRequest {#GetFunctionRequest}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to return. <br>To get a function ID make a [FunctionService.List](#List) request. 


### Function {#Function}

Field | Description
--- | ---
id | **string**<br>ID of the function. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the function belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the function. 
name | **string**<br>Name of the function. The name is unique within the folder. The string length in characters must be 3-63.
description | **string**<br>Description of the function. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Function labels as `key:value` pairs. No more than 64 per resource.
log_group_id | **string**<br>ID of the log group for the function. 
http_invoke_url | **string**<br>URL that needs to be requested to invoke the function. 
status | enum **Status**<br>Status of the function. <ul><li>`CREATING`: Function is being created.</li><li>`ACTIVE`: Function is ready to be invoked.</li><li>`DELETING`: Function is being deleted.</li><li>`ERROR`: Function failed.</li></ul>


## List {#List}

Retrieves the list of functions in the specified folder.

**rpc List ([ListFunctionsRequest](#ListFunctionsRequest)) returns ([ListFunctionsResponse](#ListFunctionsResponse))**

### ListFunctionsRequest {#ListFunctionsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list functions in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [ListFunctionsResponse.next_page_token](#ListFunctionsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListFunctionsResponse.next_page_token](#ListFunctionsResponse) returned by a previous list request. 
filter | **string**<br>A filter expression that filters functions listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can only be applied to the [Function.name](#Function1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name="my-function"`. 


### ListFunctionsResponse {#ListFunctionsResponse}

Field | Description
--- | ---
functions[] | **[Function](#Function1)**<br>List of functions in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListFunctionsRequest.page_size](#ListFunctionsRequest), use `nextPageToken` as the value for the [ListFunctionsRequest.page_token](#ListFunctionsRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### Function {#Function1}

Field | Description
--- | ---
id | **string**<br>ID of the function. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the function belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the function. 
name | **string**<br>Name of the function. The name is unique within the folder. The string length in characters must be 3-63.
description | **string**<br>Description of the function. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Function labels as `key:value` pairs. No more than 64 per resource.
log_group_id | **string**<br>ID of the log group for the function. 
http_invoke_url | **string**<br>URL that needs to be requested to invoke the function. 
status | enum **Status**<br>Status of the function. <ul><li>`CREATING`: Function is being created.</li><li>`ACTIVE`: Function is ready to be invoked.</li><li>`DELETING`: Function is being deleted.</li><li>`ERROR`: Function failed.</li></ul>


## Create {#Create}

Creates a function in the specified folder.

**rpc Create ([CreateFunctionRequest](#CreateFunctionRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateFunctionMetadata](#CreateFunctionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Function](#Function2)<br>

### CreateFunctionRequest {#CreateFunctionRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a function in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
name | **string**<br>Name of the function. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the function. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateFunctionMetadata](#CreateFunctionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Function](#Function2)>**<br>if operation finished successfully. 


### CreateFunctionMetadata {#CreateFunctionMetadata}

Field | Description
--- | ---
function_id | **string**<br>ID of the function that is being created. 


### Function {#Function2}

Field | Description
--- | ---
id | **string**<br>ID of the function. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the function belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the function. 
name | **string**<br>Name of the function. The name is unique within the folder. The string length in characters must be 3-63.
description | **string**<br>Description of the function. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Function labels as `key:value` pairs. No more than 64 per resource.
log_group_id | **string**<br>ID of the log group for the function. 
http_invoke_url | **string**<br>URL that needs to be requested to invoke the function. 
status | enum **Status**<br>Status of the function. <ul><li>`CREATING`: Function is being created.</li><li>`ACTIVE`: Function is ready to be invoked.</li><li>`DELETING`: Function is being deleted.</li><li>`ERROR`: Function failed.</li></ul>


## Update {#Update}

Updates the specified function.

**rpc Update ([UpdateFunctionRequest](#UpdateFunctionRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateFunctionMetadata](#UpdateFunctionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Function](#Function3)<br>

### UpdateFunctionRequest {#UpdateFunctionRequest}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to update. <br>To get a function ID make a [FunctionService.List](#List) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the function should be updated. 
name | **string**<br>New name for the function. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>New description for the function. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Function labels as `key:value` pairs. <br>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label, request the current set of labels with a [FunctionService.Get](#Get) request. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateFunctionMetadata](#UpdateFunctionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Function](#Function3)>**<br>if operation finished successfully. 


### UpdateFunctionMetadata {#UpdateFunctionMetadata}

Field | Description
--- | ---
function_id | **string**<br>ID of the function that is being updated. 


### Function {#Function3}

Field | Description
--- | ---
id | **string**<br>ID of the function. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the function belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the function. 
name | **string**<br>Name of the function. The name is unique within the folder. The string length in characters must be 3-63.
description | **string**<br>Description of the function. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Function labels as `key:value` pairs. No more than 64 per resource.
log_group_id | **string**<br>ID of the log group for the function. 
http_invoke_url | **string**<br>URL that needs to be requested to invoke the function. 
status | enum **Status**<br>Status of the function. <ul><li>`CREATING`: Function is being created.</li><li>`ACTIVE`: Function is ready to be invoked.</li><li>`DELETING`: Function is being deleted.</li><li>`ERROR`: Function failed.</li></ul>


## Delete {#Delete}

Deletes the specified function.

**rpc Delete ([DeleteFunctionRequest](#DeleteFunctionRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteFunctionMetadata](#DeleteFunctionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteFunctionRequest {#DeleteFunctionRequest}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to delete. To get a function ID make a [FunctionService.List](#List) request. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteFunctionMetadata](#DeleteFunctionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteFunctionMetadata {#DeleteFunctionMetadata}

Field | Description
--- | ---
function_id | **string**<br>ID of the function that is being deleted. 


## GetVersion {#GetVersion}

Returns the specified version of a function. <br>To get the list of available version, make a [ListVersions](#ListVersions) request.

**rpc GetVersion ([GetFunctionVersionRequest](#GetFunctionVersionRequest)) returns ([Version](#Version))**

### GetFunctionVersionRequest {#GetFunctionVersionRequest}

Field | Description
--- | ---
function_version_id | **string**<br>Required. ID of the version to return. <br>To get a version ID make a [FunctionService.ListVersions](#ListVersions) request. 


### Version {#Version}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
function_id | **string**<br>ID of the function that the version belongs to. 
description | **string**<br>Description of the version. The string length in characters must be 0-256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the version. 
runtime | **string**<br>ID of the runtime environment for the function. <br>Supported environments and their identifiers are listed in the [Runtime environments](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Entrypoint for the function: the name of the function to be called as the handler. <br>Specified in the format `<function file name>.<handler name>`, for example, `index.myFunction`. 
resources | **[Resources](#Resources)**<br>Resources allocated to the version. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the execution of the version. <br>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. 
service_account_id | **string**<br>ID of the service account associated with the version. 
image_size | **int64**<br>Final size of the deployment package after unpacking. 
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li></ul>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 
named_service_accounts | **map<string,string>**<br>Additional service accounts to be used by the version. 
secrets[] | **[Secret](#Secret)**<br>Yandex Lockbox secrets to be used by the version. 
log_options | **[LogOptions](#LogOptions)**<br>Options for logging from the function 
storage_mounts[] | **[StorageMount](#StorageMount)**<br>S3 mounts to be used by the version. 
async_invocation_config | **[AsyncInvocationConfig](#AsyncInvocationConfig)**<br>Config for asynchronous invocations of the version 
tmpfs_size | **int64**<br>Optional size of in-memory mounted /tmp directory in bytes. 
concurrency | **int64**<br>The maximum number of requests processed by a function instance at the same time Acceptable values are 0 to 16, inclusive.


### Resources {#Resources}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes, multiple of 128MB. Acceptable values are 134217728 to 4294967296, inclusive.


### Connectivity {#Connectivity}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. The string length in characters for each value must be greater than 0.


### Secret {#Secret}

Field | Description
--- | ---
id | **string**<br>ID of Yandex Lockbox secret. 
version_id | **string**<br>ID of Yandex Lockbox version. 
key | **string**<br>Key in secret's payload, which value to be delivered into function environment. 
reference | **oneof:** `environment_variable`<br>
&nbsp;&nbsp;environment_variable | **string**<br>environment variable in which secret's value to be delivered. 


### LogOptions {#LogOptions}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from function disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>Log entries destination.
&nbsp;&nbsp;log_group_id | **string**<br>Entry should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>Entry should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


### StorageMount {#StorageMount}

Field | Description
--- | ---
bucket_id | **string**<br>Required. S3 bucket name for mounting. The string length in characters must be 3-63. Value must match the regular expression ` [-.0-9a-zA-Z]* `.
prefix | **string**<br>S3 bucket prefix for mounting. 
mount_point_name | **string**<br>Required. Mount point directory name (not path) for mounting. The string length in characters must be 1-100. Value must match the regular expression ` [-_0-9a-zA-Z]* `.
read_only | **bool**<br>Is mount read only. 


### AsyncInvocationConfig {#AsyncInvocationConfig}

Field | Description
--- | ---
retries_count | **int64**<br>Number of retries of version invocation Acceptable values are 0 to 100, inclusive.
success_target | **[ResponseTarget](#ResponseTarget)**<br>Required. Target for successful result of the version's invocation 
failure_target | **[ResponseTarget](#ResponseTarget)**<br>Required. Target for unsuccessful result, if all retries failed 
service_account_id | **string**<br>Service account which can invoke version 


### ResponseTarget {#ResponseTarget}

Field | Description
--- | ---
target | **oneof:** `empty_target` or `ymq_target`<br>
&nbsp;&nbsp;empty_target | **[EmptyTarget](#EmptyTarget)**<br>Target to ignore a result 
&nbsp;&nbsp;ymq_target | **[YMQTarget](#YMQTarget)**<br>Target to send a result to ymq 


### EmptyTarget {#EmptyTarget}

Empty.

### YMQTarget {#YMQTarget}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


## GetFunctionVersion {#GetFunctionVersion}

Deprecated. Use [GetVersion](#GetVersion).

**rpc GetFunctionVersion ([GetFunctionVersionRequest](#GetFunctionVersionRequest)) returns ([Version](#Version1))**

### GetFunctionVersionRequest {#GetFunctionVersionRequest1}

Field | Description
--- | ---
function_version_id | **string**<br>Required. ID of the version to return. <br>To get a version ID make a [FunctionService.ListVersions](#ListVersions) request. 


### Version {#Version1}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
function_id | **string**<br>ID of the function that the version belongs to. 
description | **string**<br>Description of the version. The string length in characters must be 0-256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the version. 
runtime | **string**<br>ID of the runtime environment for the function. <br>Supported environments and their identifiers are listed in the [Runtime environments](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Entrypoint for the function: the name of the function to be called as the handler. <br>Specified in the format `<function file name>.<handler name>`, for example, `index.myFunction`. 
resources | **[Resources](#Resources1)**<br>Resources allocated to the version. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the execution of the version. <br>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. 
service_account_id | **string**<br>ID of the service account associated with the version. 
image_size | **int64**<br>Final size of the deployment package after unpacking. 
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li></ul>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity1)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 
named_service_accounts | **map<string,string>**<br>Additional service accounts to be used by the version. 
secrets[] | **[Secret](#Secret1)**<br>Yandex Lockbox secrets to be used by the version. 
log_options | **[LogOptions](#LogOptions1)**<br>Options for logging from the function 
storage_mounts[] | **[StorageMount](#StorageMount1)**<br>S3 mounts to be used by the version. 
async_invocation_config | **[AsyncInvocationConfig](#AsyncInvocationConfig1)**<br>Config for asynchronous invocations of the version 
tmpfs_size | **int64**<br>Optional size of in-memory mounted /tmp directory in bytes. 
concurrency | **int64**<br>The maximum number of requests processed by a function instance at the same time Acceptable values are 0 to 16, inclusive.


### Resources {#Resources1}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes, multiple of 128MB. Acceptable values are 134217728 to 4294967296, inclusive.


### Connectivity {#Connectivity1}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. The string length in characters for each value must be greater than 0.


### Secret {#Secret1}

Field | Description
--- | ---
id | **string**<br>ID of Yandex Lockbox secret. 
version_id | **string**<br>ID of Yandex Lockbox version. 
key | **string**<br>Key in secret's payload, which value to be delivered into function environment. 
reference | **oneof:** `environment_variable`<br>
&nbsp;&nbsp;environment_variable | **string**<br>environment variable in which secret's value to be delivered. 


### LogOptions {#LogOptions1}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from function disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>Log entries destination.
&nbsp;&nbsp;log_group_id | **string**<br>Entry should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>Entry should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


### StorageMount {#StorageMount1}

Field | Description
--- | ---
bucket_id | **string**<br>Required. S3 bucket name for mounting. The string length in characters must be 3-63. Value must match the regular expression ` [-.0-9a-zA-Z]* `.
prefix | **string**<br>S3 bucket prefix for mounting. 
mount_point_name | **string**<br>Required. Mount point directory name (not path) for mounting. The string length in characters must be 1-100. Value must match the regular expression ` [-_0-9a-zA-Z]* `.
read_only | **bool**<br>Is mount read only. 


### AsyncInvocationConfig {#AsyncInvocationConfig1}

Field | Description
--- | ---
retries_count | **int64**<br>Number of retries of version invocation Acceptable values are 0 to 100, inclusive.
success_target | **[ResponseTarget](#ResponseTarget1)**<br>Required. Target for successful result of the version's invocation 
failure_target | **[ResponseTarget](#ResponseTarget1)**<br>Required. Target for unsuccessful result, if all retries failed 
service_account_id | **string**<br>Service account which can invoke version 


### ResponseTarget {#ResponseTarget1}

Field | Description
--- | ---
target | **oneof:** `empty_target` or `ymq_target`<br>
&nbsp;&nbsp;empty_target | **[EmptyTarget](#EmptyTarget1)**<br>Target to ignore a result 
&nbsp;&nbsp;ymq_target | **[YMQTarget](#YMQTarget1)**<br>Target to send a result to ymq 


### EmptyTarget {#EmptyTarget1}

Empty.

### YMQTarget {#YMQTarget1}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


## GetVersionByTag {#GetVersionByTag}

Returns all versions with the specified tag. <br>To get the list of all available versions, make a [ListVersions](#ListVersions) request.

**rpc GetVersionByTag ([GetFunctionVersionByTagRequest](#GetFunctionVersionByTagRequest)) returns ([Version](#Version2))**

### GetFunctionVersionByTagRequest {#GetFunctionVersionByTagRequest}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function whose versions should be listed. <br>To get a function ID use a [FunctionService.List](#List) request. 
tag | **string**<br>Version tag. <br>To get the history of version tags make a [FunctionService.ListTagHistory](#ListTagHistory) request. Value must match the regular expression ` [a-z][-_0-9a-z]*\|[$]latest `.


### Version {#Version2}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
function_id | **string**<br>ID of the function that the version belongs to. 
description | **string**<br>Description of the version. The string length in characters must be 0-256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the version. 
runtime | **string**<br>ID of the runtime environment for the function. <br>Supported environments and their identifiers are listed in the [Runtime environments](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Entrypoint for the function: the name of the function to be called as the handler. <br>Specified in the format `<function file name>.<handler name>`, for example, `index.myFunction`. 
resources | **[Resources](#Resources2)**<br>Resources allocated to the version. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the execution of the version. <br>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. 
service_account_id | **string**<br>ID of the service account associated with the version. 
image_size | **int64**<br>Final size of the deployment package after unpacking. 
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li></ul>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity2)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 
named_service_accounts | **map<string,string>**<br>Additional service accounts to be used by the version. 
secrets[] | **[Secret](#Secret2)**<br>Yandex Lockbox secrets to be used by the version. 
log_options | **[LogOptions](#LogOptions2)**<br>Options for logging from the function 
storage_mounts[] | **[StorageMount](#StorageMount2)**<br>S3 mounts to be used by the version. 
async_invocation_config | **[AsyncInvocationConfig](#AsyncInvocationConfig2)**<br>Config for asynchronous invocations of the version 
tmpfs_size | **int64**<br>Optional size of in-memory mounted /tmp directory in bytes. 
concurrency | **int64**<br>The maximum number of requests processed by a function instance at the same time Acceptable values are 0 to 16, inclusive.


### Resources {#Resources2}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes, multiple of 128MB. Acceptable values are 134217728 to 4294967296, inclusive.


### Connectivity {#Connectivity2}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. The string length in characters for each value must be greater than 0.


### Secret {#Secret2}

Field | Description
--- | ---
id | **string**<br>ID of Yandex Lockbox secret. 
version_id | **string**<br>ID of Yandex Lockbox version. 
key | **string**<br>Key in secret's payload, which value to be delivered into function environment. 
reference | **oneof:** `environment_variable`<br>
&nbsp;&nbsp;environment_variable | **string**<br>environment variable in which secret's value to be delivered. 


### LogOptions {#LogOptions2}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from function disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>Log entries destination.
&nbsp;&nbsp;log_group_id | **string**<br>Entry should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>Entry should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


### StorageMount {#StorageMount2}

Field | Description
--- | ---
bucket_id | **string**<br>Required. S3 bucket name for mounting. The string length in characters must be 3-63. Value must match the regular expression ` [-.0-9a-zA-Z]* `.
prefix | **string**<br>S3 bucket prefix for mounting. 
mount_point_name | **string**<br>Required. Mount point directory name (not path) for mounting. The string length in characters must be 1-100. Value must match the regular expression ` [-_0-9a-zA-Z]* `.
read_only | **bool**<br>Is mount read only. 


### AsyncInvocationConfig {#AsyncInvocationConfig2}

Field | Description
--- | ---
retries_count | **int64**<br>Number of retries of version invocation Acceptable values are 0 to 100, inclusive.
success_target | **[ResponseTarget](#ResponseTarget2)**<br>Required. Target for successful result of the version's invocation 
failure_target | **[ResponseTarget](#ResponseTarget2)**<br>Required. Target for unsuccessful result, if all retries failed 
service_account_id | **string**<br>Service account which can invoke version 


### ResponseTarget {#ResponseTarget2}

Field | Description
--- | ---
target | **oneof:** `empty_target` or `ymq_target`<br>
&nbsp;&nbsp;empty_target | **[EmptyTarget](#EmptyTarget2)**<br>Target to ignore a result 
&nbsp;&nbsp;ymq_target | **[YMQTarget](#YMQTarget2)**<br>Target to send a result to ymq 


### EmptyTarget {#EmptyTarget2}

Empty.

### YMQTarget {#YMQTarget2}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


## GetFunctionVersionByTag {#GetFunctionVersionByTag}

Deprecated. Use [GetVersionByTag](#GetVersionByTag).

**rpc GetFunctionVersionByTag ([GetFunctionVersionByTagRequest](#GetFunctionVersionByTagRequest)) returns ([Version](#Version3))**

### GetFunctionVersionByTagRequest {#GetFunctionVersionByTagRequest1}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function whose versions should be listed. <br>To get a function ID use a [FunctionService.List](#List) request. 
tag | **string**<br>Version tag. <br>To get the history of version tags make a [FunctionService.ListTagHistory](#ListTagHistory) request. Value must match the regular expression ` [a-z][-_0-9a-z]*\|[$]latest `.


### Version {#Version3}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
function_id | **string**<br>ID of the function that the version belongs to. 
description | **string**<br>Description of the version. The string length in characters must be 0-256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the version. 
runtime | **string**<br>ID of the runtime environment for the function. <br>Supported environments and their identifiers are listed in the [Runtime environments](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Entrypoint for the function: the name of the function to be called as the handler. <br>Specified in the format `<function file name>.<handler name>`, for example, `index.myFunction`. 
resources | **[Resources](#Resources3)**<br>Resources allocated to the version. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the execution of the version. <br>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. 
service_account_id | **string**<br>ID of the service account associated with the version. 
image_size | **int64**<br>Final size of the deployment package after unpacking. 
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li></ul>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity3)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 
named_service_accounts | **map<string,string>**<br>Additional service accounts to be used by the version. 
secrets[] | **[Secret](#Secret3)**<br>Yandex Lockbox secrets to be used by the version. 
log_options | **[LogOptions](#LogOptions3)**<br>Options for logging from the function 
storage_mounts[] | **[StorageMount](#StorageMount3)**<br>S3 mounts to be used by the version. 
async_invocation_config | **[AsyncInvocationConfig](#AsyncInvocationConfig3)**<br>Config for asynchronous invocations of the version 
tmpfs_size | **int64**<br>Optional size of in-memory mounted /tmp directory in bytes. 
concurrency | **int64**<br>The maximum number of requests processed by a function instance at the same time Acceptable values are 0 to 16, inclusive.


### Resources {#Resources3}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes, multiple of 128MB. Acceptable values are 134217728 to 4294967296, inclusive.


### Connectivity {#Connectivity3}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. The string length in characters for each value must be greater than 0.


### Secret {#Secret3}

Field | Description
--- | ---
id | **string**<br>ID of Yandex Lockbox secret. 
version_id | **string**<br>ID of Yandex Lockbox version. 
key | **string**<br>Key in secret's payload, which value to be delivered into function environment. 
reference | **oneof:** `environment_variable`<br>
&nbsp;&nbsp;environment_variable | **string**<br>environment variable in which secret's value to be delivered. 


### LogOptions {#LogOptions3}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from function disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>Log entries destination.
&nbsp;&nbsp;log_group_id | **string**<br>Entry should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>Entry should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


### StorageMount {#StorageMount3}

Field | Description
--- | ---
bucket_id | **string**<br>Required. S3 bucket name for mounting. The string length in characters must be 3-63. Value must match the regular expression ` [-.0-9a-zA-Z]* `.
prefix | **string**<br>S3 bucket prefix for mounting. 
mount_point_name | **string**<br>Required. Mount point directory name (not path) for mounting. The string length in characters must be 1-100. Value must match the regular expression ` [-_0-9a-zA-Z]* `.
read_only | **bool**<br>Is mount read only. 


### AsyncInvocationConfig {#AsyncInvocationConfig3}

Field | Description
--- | ---
retries_count | **int64**<br>Number of retries of version invocation Acceptable values are 0 to 100, inclusive.
success_target | **[ResponseTarget](#ResponseTarget3)**<br>Required. Target for successful result of the version's invocation 
failure_target | **[ResponseTarget](#ResponseTarget3)**<br>Required. Target for unsuccessful result, if all retries failed 
service_account_id | **string**<br>Service account which can invoke version 


### ResponseTarget {#ResponseTarget3}

Field | Description
--- | ---
target | **oneof:** `empty_target` or `ymq_target`<br>
&nbsp;&nbsp;empty_target | **[EmptyTarget](#EmptyTarget3)**<br>Target to ignore a result 
&nbsp;&nbsp;ymq_target | **[YMQTarget](#YMQTarget3)**<br>Target to send a result to ymq 


### EmptyTarget {#EmptyTarget3}

Empty.

### YMQTarget {#YMQTarget3}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


## ListVersions {#ListVersions}

Retrieves the list of versions for the specified function, or of all function versions in the specified folder.

**rpc ListVersions ([ListFunctionsVersionsRequest](#ListFunctionsVersionsRequest)) returns ([ListFunctionsVersionsResponse](#ListFunctionsVersionsResponse))**

### ListFunctionsVersionsRequest {#ListFunctionsVersionsRequest}

Field | Description
--- | ---
id | **oneof:** `folder_id` or `function_id`<br>
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder to list function versions for. To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
&nbsp;&nbsp;function_id | **string**<br>ID of the function to list versions for. To get a function ID use a [FunctionService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [ListFunctionsVersionsResponse.next_page_token](#ListFunctionsVersionsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListFunctionsVersionsResponse.next_page_token](#ListFunctionsVersionsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can only be applied to the [Version.status](#Version4) and [Version.runtime](#Version4) fields. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `status="ACTIVE"`. The maximum string length in characters is 1000.


### ListFunctionsVersionsResponse {#ListFunctionsVersionsResponse}

Field | Description
--- | ---
versions[] | **[Version](#Version4)**<br>List of versions for the specified folder or function. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListFunctionsVersionsRequest.page_size](#ListFunctionsVersionsRequest), use `nextPageToken` as the value for the [ListFunctionsVersionsRequest.page_token](#ListFunctionsVersionsRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### Version {#Version4}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
function_id | **string**<br>ID of the function that the version belongs to. 
description | **string**<br>Description of the version. The string length in characters must be 0-256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the version. 
runtime | **string**<br>ID of the runtime environment for the function. <br>Supported environments and their identifiers are listed in the [Runtime environments](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Entrypoint for the function: the name of the function to be called as the handler. <br>Specified in the format `<function file name>.<handler name>`, for example, `index.myFunction`. 
resources | **[Resources](#Resources4)**<br>Resources allocated to the version. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the execution of the version. <br>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. 
service_account_id | **string**<br>ID of the service account associated with the version. 
image_size | **int64**<br>Final size of the deployment package after unpacking. 
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li></ul>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity4)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 
named_service_accounts | **map<string,string>**<br>Additional service accounts to be used by the version. 
secrets[] | **[Secret](#Secret4)**<br>Yandex Lockbox secrets to be used by the version. 
log_options | **[LogOptions](#LogOptions4)**<br>Options for logging from the function 
storage_mounts[] | **[StorageMount](#StorageMount4)**<br>S3 mounts to be used by the version. 
async_invocation_config | **[AsyncInvocationConfig](#AsyncInvocationConfig4)**<br>Config for asynchronous invocations of the version 
tmpfs_size | **int64**<br>Optional size of in-memory mounted /tmp directory in bytes. 
concurrency | **int64**<br>The maximum number of requests processed by a function instance at the same time Acceptable values are 0 to 16, inclusive.


### Resources {#Resources4}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes, multiple of 128MB. Acceptable values are 134217728 to 4294967296, inclusive.


### Connectivity {#Connectivity4}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. The string length in characters for each value must be greater than 0.


### Secret {#Secret4}

Field | Description
--- | ---
id | **string**<br>ID of Yandex Lockbox secret. 
version_id | **string**<br>ID of Yandex Lockbox version. 
key | **string**<br>Key in secret's payload, which value to be delivered into function environment. 
reference | **oneof:** `environment_variable`<br>
&nbsp;&nbsp;environment_variable | **string**<br>environment variable in which secret's value to be delivered. 


### LogOptions {#LogOptions4}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from function disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>Log entries destination.
&nbsp;&nbsp;log_group_id | **string**<br>Entry should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>Entry should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


### StorageMount {#StorageMount4}

Field | Description
--- | ---
bucket_id | **string**<br>Required. S3 bucket name for mounting. The string length in characters must be 3-63. Value must match the regular expression ` [-.0-9a-zA-Z]* `.
prefix | **string**<br>S3 bucket prefix for mounting. 
mount_point_name | **string**<br>Required. Mount point directory name (not path) for mounting. The string length in characters must be 1-100. Value must match the regular expression ` [-_0-9a-zA-Z]* `.
read_only | **bool**<br>Is mount read only. 


### AsyncInvocationConfig {#AsyncInvocationConfig4}

Field | Description
--- | ---
retries_count | **int64**<br>Number of retries of version invocation Acceptable values are 0 to 100, inclusive.
success_target | **[ResponseTarget](#ResponseTarget4)**<br>Required. Target for successful result of the version's invocation 
failure_target | **[ResponseTarget](#ResponseTarget4)**<br>Required. Target for unsuccessful result, if all retries failed 
service_account_id | **string**<br>Service account which can invoke version 


### ResponseTarget {#ResponseTarget4}

Field | Description
--- | ---
target | **oneof:** `empty_target` or `ymq_target`<br>
&nbsp;&nbsp;empty_target | **[EmptyTarget](#EmptyTarget4)**<br>Target to ignore a result 
&nbsp;&nbsp;ymq_target | **[YMQTarget](#YMQTarget4)**<br>Target to send a result to ymq 


### EmptyTarget {#EmptyTarget4}

Empty.

### YMQTarget {#YMQTarget4}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


## ListFunctionVersions {#ListFunctionVersions}

Deprecated. Use [ListVersions](#ListVersions).

**rpc ListFunctionVersions ([ListFunctionsVersionsRequest](#ListFunctionsVersionsRequest)) returns ([ListFunctionsVersionsResponse](#ListFunctionsVersionsResponse))**

### ListFunctionsVersionsRequest {#ListFunctionsVersionsRequest1}

Field | Description
--- | ---
id | **oneof:** `folder_id` or `function_id`<br>
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder to list function versions for. To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
&nbsp;&nbsp;function_id | **string**<br>ID of the function to list versions for. To get a function ID use a [FunctionService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [ListFunctionsVersionsResponse.next_page_token](#ListFunctionsVersionsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListFunctionsVersionsResponse.next_page_token](#ListFunctionsVersionsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can only be applied to the [Version.status](#Version5) and [Version.runtime](#Version5) fields. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `status="ACTIVE"`. The maximum string length in characters is 1000.


### ListFunctionsVersionsResponse {#ListFunctionsVersionsResponse1}

Field | Description
--- | ---
versions[] | **[Version](#Version5)**<br>List of versions for the specified folder or function. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListFunctionsVersionsRequest.page_size](#ListFunctionsVersionsRequest), use `nextPageToken` as the value for the [ListFunctionsVersionsRequest.page_token](#ListFunctionsVersionsRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### Version {#Version5}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
function_id | **string**<br>ID of the function that the version belongs to. 
description | **string**<br>Description of the version. The string length in characters must be 0-256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the version. 
runtime | **string**<br>ID of the runtime environment for the function. <br>Supported environments and their identifiers are listed in the [Runtime environments](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Entrypoint for the function: the name of the function to be called as the handler. <br>Specified in the format `<function file name>.<handler name>`, for example, `index.myFunction`. 
resources | **[Resources](#Resources5)**<br>Resources allocated to the version. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the execution of the version. <br>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. 
service_account_id | **string**<br>ID of the service account associated with the version. 
image_size | **int64**<br>Final size of the deployment package after unpacking. 
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li></ul>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity5)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 
named_service_accounts | **map<string,string>**<br>Additional service accounts to be used by the version. 
secrets[] | **[Secret](#Secret5)**<br>Yandex Lockbox secrets to be used by the version. 
log_options | **[LogOptions](#LogOptions5)**<br>Options for logging from the function 
storage_mounts[] | **[StorageMount](#StorageMount5)**<br>S3 mounts to be used by the version. 
async_invocation_config | **[AsyncInvocationConfig](#AsyncInvocationConfig5)**<br>Config for asynchronous invocations of the version 
tmpfs_size | **int64**<br>Optional size of in-memory mounted /tmp directory in bytes. 
concurrency | **int64**<br>The maximum number of requests processed by a function instance at the same time Acceptable values are 0 to 16, inclusive.


### Resources {#Resources5}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes, multiple of 128MB. Acceptable values are 134217728 to 4294967296, inclusive.


### Connectivity {#Connectivity5}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. The string length in characters for each value must be greater than 0.


### Secret {#Secret5}

Field | Description
--- | ---
id | **string**<br>ID of Yandex Lockbox secret. 
version_id | **string**<br>ID of Yandex Lockbox version. 
key | **string**<br>Key in secret's payload, which value to be delivered into function environment. 
reference | **oneof:** `environment_variable`<br>
&nbsp;&nbsp;environment_variable | **string**<br>environment variable in which secret's value to be delivered. 


### LogOptions {#LogOptions5}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from function disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>Log entries destination.
&nbsp;&nbsp;log_group_id | **string**<br>Entry should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>Entry should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


### StorageMount {#StorageMount5}

Field | Description
--- | ---
bucket_id | **string**<br>Required. S3 bucket name for mounting. The string length in characters must be 3-63. Value must match the regular expression ` [-.0-9a-zA-Z]* `.
prefix | **string**<br>S3 bucket prefix for mounting. 
mount_point_name | **string**<br>Required. Mount point directory name (not path) for mounting. The string length in characters must be 1-100. Value must match the regular expression ` [-_0-9a-zA-Z]* `.
read_only | **bool**<br>Is mount read only. 


### AsyncInvocationConfig {#AsyncInvocationConfig5}

Field | Description
--- | ---
retries_count | **int64**<br>Number of retries of version invocation Acceptable values are 0 to 100, inclusive.
success_target | **[ResponseTarget](#ResponseTarget5)**<br>Required. Target for successful result of the version's invocation 
failure_target | **[ResponseTarget](#ResponseTarget5)**<br>Required. Target for unsuccessful result, if all retries failed 
service_account_id | **string**<br>Service account which can invoke version 


### ResponseTarget {#ResponseTarget5}

Field | Description
--- | ---
target | **oneof:** `empty_target` or `ymq_target`<br>
&nbsp;&nbsp;empty_target | **[EmptyTarget](#EmptyTarget5)**<br>Target to ignore a result 
&nbsp;&nbsp;ymq_target | **[YMQTarget](#YMQTarget5)**<br>Target to send a result to ymq 


### EmptyTarget {#EmptyTarget5}

Empty.

### YMQTarget {#YMQTarget5}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


## DeleteVersion {#DeleteVersion}

Deletes the specified version of a function. <br>NOTE: old untagged function versions are deleted automatically.

**rpc DeleteVersion ([DeleteFunctionVersionRequest](#DeleteFunctionVersionRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteFunctionVersionMetadata](#DeleteFunctionVersionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteFunctionVersionRequest {#DeleteFunctionVersionRequest}

Field | Description
--- | ---
function_version_id | **string**<br>Required. ID of the function's version to delete. 
force | **bool**<br>Forces deletion of the version tags. <br>If the value equals false and the function has tags with the selected version then request returns an error. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteFunctionVersionMetadata](#DeleteFunctionVersionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteFunctionVersionMetadata {#DeleteFunctionVersionMetadata}

Field | Description
--- | ---
function_version_id | **string**<br>ID of the function's version is being deleted. 


## SetTag {#SetTag}

Set a tag for the specified version of a function.

**rpc SetTag ([SetFunctionTagRequest](#SetFunctionTagRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetFunctionTagMetadata](#SetFunctionTagMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Version](#Version6)<br>

### SetFunctionTagRequest {#SetFunctionTagRequest}

Field | Description
--- | ---
function_version_id | **string**<br>Required. ID of the version to set the tag for. <br>To get a version ID make a [FunctionService.ListVersions](#ListVersions) request. 
tag | **string**<br>Tag to set for the version. Value must match the regular expression ` [a-z][-_0-9a-z]* `.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetFunctionTagMetadata](#SetFunctionTagMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Version](#Version6)>**<br>if operation finished successfully. 


### SetFunctionTagMetadata {#SetFunctionTagMetadata}

Field | Description
--- | ---
function_version_id | **string**<br>ID of the function versions that is being tagged. 


### Version {#Version6}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
function_id | **string**<br>ID of the function that the version belongs to. 
description | **string**<br>Description of the version. The string length in characters must be 0-256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the version. 
runtime | **string**<br>ID of the runtime environment for the function. <br>Supported environments and their identifiers are listed in the [Runtime environments](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Entrypoint for the function: the name of the function to be called as the handler. <br>Specified in the format `<function file name>.<handler name>`, for example, `index.myFunction`. 
resources | **[Resources](#Resources6)**<br>Resources allocated to the version. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the execution of the version. <br>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. 
service_account_id | **string**<br>ID of the service account associated with the version. 
image_size | **int64**<br>Final size of the deployment package after unpacking. 
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li></ul>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity6)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 
named_service_accounts | **map<string,string>**<br>Additional service accounts to be used by the version. 
secrets[] | **[Secret](#Secret6)**<br>Yandex Lockbox secrets to be used by the version. 
log_options | **[LogOptions](#LogOptions6)**<br>Options for logging from the function 
storage_mounts[] | **[StorageMount](#StorageMount6)**<br>S3 mounts to be used by the version. 
async_invocation_config | **[AsyncInvocationConfig](#AsyncInvocationConfig6)**<br>Config for asynchronous invocations of the version 
tmpfs_size | **int64**<br>Optional size of in-memory mounted /tmp directory in bytes. 
concurrency | **int64**<br>The maximum number of requests processed by a function instance at the same time Acceptable values are 0 to 16, inclusive.


### Resources {#Resources6}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes, multiple of 128MB. Acceptable values are 134217728 to 4294967296, inclusive.


### Connectivity {#Connectivity6}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. The string length in characters for each value must be greater than 0.


### Secret {#Secret6}

Field | Description
--- | ---
id | **string**<br>ID of Yandex Lockbox secret. 
version_id | **string**<br>ID of Yandex Lockbox version. 
key | **string**<br>Key in secret's payload, which value to be delivered into function environment. 
reference | **oneof:** `environment_variable`<br>
&nbsp;&nbsp;environment_variable | **string**<br>environment variable in which secret's value to be delivered. 


### LogOptions {#LogOptions6}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from function disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>Log entries destination.
&nbsp;&nbsp;log_group_id | **string**<br>Entry should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>Entry should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


### StorageMount {#StorageMount6}

Field | Description
--- | ---
bucket_id | **string**<br>Required. S3 bucket name for mounting. The string length in characters must be 3-63. Value must match the regular expression ` [-.0-9a-zA-Z]* `.
prefix | **string**<br>S3 bucket prefix for mounting. 
mount_point_name | **string**<br>Required. Mount point directory name (not path) for mounting. The string length in characters must be 1-100. Value must match the regular expression ` [-_0-9a-zA-Z]* `.
read_only | **bool**<br>Is mount read only. 


### AsyncInvocationConfig {#AsyncInvocationConfig6}

Field | Description
--- | ---
retries_count | **int64**<br>Number of retries of version invocation Acceptable values are 0 to 100, inclusive.
success_target | **[ResponseTarget](#ResponseTarget6)**<br>Required. Target for successful result of the version's invocation 
failure_target | **[ResponseTarget](#ResponseTarget6)**<br>Required. Target for unsuccessful result, if all retries failed 
service_account_id | **string**<br>Service account which can invoke version 


### ResponseTarget {#ResponseTarget6}

Field | Description
--- | ---
target | **oneof:** `empty_target` or `ymq_target`<br>
&nbsp;&nbsp;empty_target | **[EmptyTarget](#EmptyTarget6)**<br>Target to ignore a result 
&nbsp;&nbsp;ymq_target | **[YMQTarget](#YMQTarget6)**<br>Target to send a result to ymq 


### EmptyTarget {#EmptyTarget6}

Empty.

### YMQTarget {#YMQTarget6}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


## RemoveTag {#RemoveTag}

Remove a tag from the specified version of a function.

**rpc RemoveTag ([RemoveFunctionTagRequest](#RemoveFunctionTagRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveFunctionTagMetadata](#RemoveFunctionTagMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Version](#Version7)<br>

### RemoveFunctionTagRequest {#RemoveFunctionTagRequest}

Field | Description
--- | ---
function_version_id | **string**<br>Required. ID of the version to remove a tag from. <br>To get the a version ID make a [FunctionService.ListVersions](#ListVersions) request. 
tag | **string**<br>Tag to remove from the specified version. Value must match the regular expression ` [a-z][-_0-9a-z]* `.


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RemoveFunctionTagMetadata](#RemoveFunctionTagMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Version](#Version7)>**<br>if operation finished successfully. 


### RemoveFunctionTagMetadata {#RemoveFunctionTagMetadata}

Field | Description
--- | ---
function_version_id | **string**<br>ID of the function versions that is being untagged. 


### Version {#Version7}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
function_id | **string**<br>ID of the function that the version belongs to. 
description | **string**<br>Description of the version. The string length in characters must be 0-256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the version. 
runtime | **string**<br>ID of the runtime environment for the function. <br>Supported environments and their identifiers are listed in the [Runtime environments](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Entrypoint for the function: the name of the function to be called as the handler. <br>Specified in the format `<function file name>.<handler name>`, for example, `index.myFunction`. 
resources | **[Resources](#Resources7)**<br>Resources allocated to the version. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the execution of the version. <br>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. 
service_account_id | **string**<br>ID of the service account associated with the version. 
image_size | **int64**<br>Final size of the deployment package after unpacking. 
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li></ul>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity7)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 
named_service_accounts | **map<string,string>**<br>Additional service accounts to be used by the version. 
secrets[] | **[Secret](#Secret7)**<br>Yandex Lockbox secrets to be used by the version. 
log_options | **[LogOptions](#LogOptions7)**<br>Options for logging from the function 
storage_mounts[] | **[StorageMount](#StorageMount7)**<br>S3 mounts to be used by the version. 
async_invocation_config | **[AsyncInvocationConfig](#AsyncInvocationConfig7)**<br>Config for asynchronous invocations of the version 
tmpfs_size | **int64**<br>Optional size of in-memory mounted /tmp directory in bytes. 
concurrency | **int64**<br>The maximum number of requests processed by a function instance at the same time Acceptable values are 0 to 16, inclusive.


### Resources {#Resources7}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes, multiple of 128MB. Acceptable values are 134217728 to 4294967296, inclusive.


### Connectivity {#Connectivity7}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. The string length in characters for each value must be greater than 0.


### Secret {#Secret7}

Field | Description
--- | ---
id | **string**<br>ID of Yandex Lockbox secret. 
version_id | **string**<br>ID of Yandex Lockbox version. 
key | **string**<br>Key in secret's payload, which value to be delivered into function environment. 
reference | **oneof:** `environment_variable`<br>
&nbsp;&nbsp;environment_variable | **string**<br>environment variable in which secret's value to be delivered. 


### LogOptions {#LogOptions7}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from function disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>Log entries destination.
&nbsp;&nbsp;log_group_id | **string**<br>Entry should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>Entry should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


### StorageMount {#StorageMount7}

Field | Description
--- | ---
bucket_id | **string**<br>Required. S3 bucket name for mounting. The string length in characters must be 3-63. Value must match the regular expression ` [-.0-9a-zA-Z]* `.
prefix | **string**<br>S3 bucket prefix for mounting. 
mount_point_name | **string**<br>Required. Mount point directory name (not path) for mounting. The string length in characters must be 1-100. Value must match the regular expression ` [-_0-9a-zA-Z]* `.
read_only | **bool**<br>Is mount read only. 


### AsyncInvocationConfig {#AsyncInvocationConfig7}

Field | Description
--- | ---
retries_count | **int64**<br>Number of retries of version invocation Acceptable values are 0 to 100, inclusive.
success_target | **[ResponseTarget](#ResponseTarget7)**<br>Required. Target for successful result of the version's invocation 
failure_target | **[ResponseTarget](#ResponseTarget7)**<br>Required. Target for unsuccessful result, if all retries failed 
service_account_id | **string**<br>Service account which can invoke version 


### ResponseTarget {#ResponseTarget7}

Field | Description
--- | ---
target | **oneof:** `empty_target` or `ymq_target`<br>
&nbsp;&nbsp;empty_target | **[EmptyTarget](#EmptyTarget7)**<br>Target to ignore a result 
&nbsp;&nbsp;ymq_target | **[YMQTarget](#YMQTarget7)**<br>Target to send a result to ymq 


### EmptyTarget {#EmptyTarget7}

Empty.

### YMQTarget {#YMQTarget7}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


## ListTagHistory {#ListTagHistory}

Returns the log of tags assigned to versions of the specified function.

**rpc ListTagHistory ([ListFunctionTagHistoryRequest](#ListFunctionTagHistoryRequest)) returns ([ListFunctionTagHistoryResponse](#ListFunctionTagHistoryResponse))**

### ListFunctionTagHistoryRequest {#ListFunctionTagHistoryRequest}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to retrieve tag history for. <br>To get a function ID, make a [FunctionService.List](#List) request. 
tag | **string**<br>Specific tag that history should be limited to. Value must match the regular expression ` [a-z][-_0-9a-z]*\|[$]latest `.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `pageSize`, the service returns a [ListFunctionOperationsResponse.next_page_token](#ListFunctionOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListFunctionOperationsResponse.next_page_token](#ListFunctionOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can only be applied to the [FunctionTagHistoryRecord.effective_from] and [FunctionTagHistoryRecord.effective_to] fields. </li><li>An `=` or `>` or `<` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>For example, `effective_to>2021-01-01T12:00:00Z`. The maximum string length in characters is 1000.


### ListFunctionTagHistoryResponse {#ListFunctionTagHistoryResponse}

Field | Description
--- | ---
function_tag_history_record[] | **FunctionTagHistoryRecord**<br>Set of relevant tag history records. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListFunctionTagHistoryRequest.page_size](#ListFunctionTagHistoryRequest), use `nextPageToken` as the value for the [ListFunctionTagHistoryRequest.page_token](#ListFunctionTagHistoryRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### FunctionTagHistoryRecord {#FunctionTagHistoryRecord}

Field | Description
--- | ---
function_id | **string**<br>ID of the function that the record is about. 
function_version_id | **string**<br>ID of the function version that the record is about. 
tag | **string**<br>Tag that was set for the version at some point. 
effective_from | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp when the tag started being active for the function. 
effective_to | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp when the tag stopped being active for the function. 


## ListFunctionTagHistory {#ListFunctionTagHistory}

Deprecated. Use [ListTagHistory](#ListTagHistory).

**rpc ListFunctionTagHistory ([ListFunctionTagHistoryRequest](#ListFunctionTagHistoryRequest)) returns ([ListFunctionTagHistoryResponse](#ListFunctionTagHistoryResponse))**

### ListFunctionTagHistoryRequest {#ListFunctionTagHistoryRequest1}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to retrieve tag history for. <br>To get a function ID, make a [FunctionService.List](#List) request. 
tag | **string**<br>Specific tag that history should be limited to. Value must match the regular expression ` [a-z][-_0-9a-z]*\|[$]latest `.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `pageSize`, the service returns a [ListFunctionOperationsResponse.next_page_token](#ListFunctionOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListFunctionOperationsResponse.next_page_token](#ListFunctionOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can only be applied to the [FunctionTagHistoryRecord.effective_from] and [FunctionTagHistoryRecord.effective_to] fields. </li><li>An `=` or `>` or `<` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>For example, `effective_to>2021-01-01T12:00:00Z`. The maximum string length in characters is 1000.


### ListFunctionTagHistoryResponse {#ListFunctionTagHistoryResponse1}

Field | Description
--- | ---
function_tag_history_record[] | **FunctionTagHistoryRecord**<br>Set of relevant tag history records. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListFunctionTagHistoryRequest.page_size](#ListFunctionTagHistoryRequest), use `nextPageToken` as the value for the [ListFunctionTagHistoryRequest.page_token](#ListFunctionTagHistoryRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### FunctionTagHistoryRecord {#FunctionTagHistoryRecord1}

Field | Description
--- | ---
function_id | **string**<br>ID of the function that the record is about. 
function_version_id | **string**<br>ID of the function version that the record is about. 
tag | **string**<br>Tag that was set for the version at some point. 
effective_from | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp when the tag started being active for the function. 
effective_to | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp when the tag stopped being active for the function. 


## CreateVersion {#CreateVersion}

Creates a version for the specified function.

**rpc CreateVersion ([CreateFunctionVersionRequest](#CreateFunctionVersionRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateFunctionVersionMetadata](#CreateFunctionVersionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Version](#Version8)<br>

### CreateFunctionVersionRequest {#CreateFunctionVersionRequest}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to create a version for. <br>To get a function ID, make a [FunctionService.List](#List) request. 
runtime | **string**<br>Required. Runtime environment for the version. 
description | **string**<br>Description of the version The string length in characters must be 0-256.
entrypoint | **string**<br>Required. Entrypoint of the version. 
resources | **[Resources](#Resources8)**<br>Required. Resources allocated to the version. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Timeout for the execution of the version. <br>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. 
service_account_id | **string**<br>ID of the service account to associate with the version. 
package_source | **oneof:** `package`, `content` or `version_id`<br>Source of the deployment package for the version.
&nbsp;&nbsp;package | **[Package](#Package)**<br>Functions deployment package. 
&nbsp;&nbsp;content | **bytes**<br>Content of the deployment package. The maximum string length in characters is 52428800.
&nbsp;&nbsp;version_id | **string**<br>ID of the version to be copied from. Source version must belong to the same folder as the created version and the user must have read permissions to the source version. 
environment | **map<string,string>**<br>Environment settings for the version. The maximum string length in characters for each value is 4096. Each key must match the regular expression ` [a-zA-Z][a-zA-Z0-9_]* `.
tag[] | **string**<br>Function version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). Each value must match the regular expression ` [a-z][-_0-9a-z]* `.
connectivity | **[Connectivity](#Connectivity8)**<br>Function version connectivity. If specified the version will be attached to specified network/subnet(s). 
named_service_accounts | **map<string,string>**<br>Additional service accounts to be used by the version. 
secrets[] | **[Secret](#Secret8)**<br>Yandex Lockbox secrets to be used by the version. 
log_options | **[LogOptions](#LogOptions8)**<br>Options for logging from the function 
storage_mounts[] | **[StorageMount](#StorageMount8)**<br>S3 mounts to be used by the version. 
async_invocation_config | **[AsyncInvocationConfig](#AsyncInvocationConfig8)**<br>Config for asynchronous invocations of the version 
tmpfs_size | **int64**<br>Optional size of in-memory mounted /tmp directory in bytes. Available for versions with resources.memory greater or equal to 1024 MiB. <br>0 or in range from 512 MiB to 3/4 of resources.memory. 
concurrency | **int64**<br>The maximum number of requests processed by a function instance at the same time Acceptable values are 0 to 16, inclusive.


### Resources {#Resources8}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes, multiple of 128MB. Acceptable values are 134217728 to 4294967296, inclusive.


### Package {#Package}

Field | Description
--- | ---
bucket_name | **string**<br>Required. Name of the bucket that stores the code for the version. 
object_name | **string**<br>Required. Name of the object in the bucket that stores the code for the version. 
sha256 | **string**<br>SHA256 hash of the version deployment package. 


### Connectivity {#Connectivity8}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. The string length in characters for each value must be greater than 0.


### Secret {#Secret8}

Field | Description
--- | ---
id | **string**<br>ID of Yandex Lockbox secret. 
version_id | **string**<br>ID of Yandex Lockbox version. 
key | **string**<br>Key in secret's payload, which value to be delivered into function environment. 
reference | **oneof:** `environment_variable`<br>
&nbsp;&nbsp;environment_variable | **string**<br>environment variable in which secret's value to be delivered. 


### LogOptions {#LogOptions8}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from function disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>Log entries destination.
&nbsp;&nbsp;log_group_id | **string**<br>Entry should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>Entry should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


### StorageMount {#StorageMount8}

Field | Description
--- | ---
bucket_id | **string**<br>Required. S3 bucket name for mounting. The string length in characters must be 3-63. Value must match the regular expression ` [-.0-9a-zA-Z]* `.
prefix | **string**<br>S3 bucket prefix for mounting. 
mount_point_name | **string**<br>Required. Mount point directory name (not path) for mounting. The string length in characters must be 1-100. Value must match the regular expression ` [-_0-9a-zA-Z]* `.
read_only | **bool**<br>Is mount read only. 


### AsyncInvocationConfig {#AsyncInvocationConfig8}

Field | Description
--- | ---
retries_count | **int64**<br>Number of retries of version invocation Acceptable values are 0 to 100, inclusive.
success_target | **[ResponseTarget](#ResponseTarget8)**<br>Required. Target for successful result of the version's invocation 
failure_target | **[ResponseTarget](#ResponseTarget8)**<br>Required. Target for unsuccessful result, if all retries failed 
service_account_id | **string**<br>Service account which can invoke version 


### ResponseTarget {#ResponseTarget8}

Field | Description
--- | ---
target | **oneof:** `empty_target` or `ymq_target`<br>
&nbsp;&nbsp;empty_target | **[EmptyTarget](#EmptyTarget8)**<br>Target to ignore a result 
&nbsp;&nbsp;ymq_target | **[YMQTarget](#YMQTarget8)**<br>Target to send a result to ymq 


### EmptyTarget {#EmptyTarget8}

Empty.

### YMQTarget {#YMQTarget8}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateFunctionVersionMetadata](#CreateFunctionVersionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Version](#Version8)>**<br>if operation finished successfully. 


### CreateFunctionVersionMetadata {#CreateFunctionVersionMetadata}

Field | Description
--- | ---
function_version_id | **string**<br>ID of the version that is being created. 


### Version {#Version8}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
function_id | **string**<br>ID of the function that the version belongs to. 
description | **string**<br>Description of the version. The string length in characters must be 0-256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the version. 
runtime | **string**<br>ID of the runtime environment for the function. <br>Supported environments and their identifiers are listed in the [Runtime environments](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Entrypoint for the function: the name of the function to be called as the handler. <br>Specified in the format `<function file name>.<handler name>`, for example, `index.myFunction`. 
resources | **[Resources](#Resources9)**<br>Resources allocated to the version. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the execution of the version. <br>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. 
service_account_id | **string**<br>ID of the service account associated with the version. 
image_size | **int64**<br>Final size of the deployment package after unpacking. 
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li></ul>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity9)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 
named_service_accounts | **map<string,string>**<br>Additional service accounts to be used by the version. 
secrets[] | **[Secret](#Secret9)**<br>Yandex Lockbox secrets to be used by the version. 
log_options | **[LogOptions](#LogOptions9)**<br>Options for logging from the function 
storage_mounts[] | **[StorageMount](#StorageMount9)**<br>S3 mounts to be used by the version. 
async_invocation_config | **[AsyncInvocationConfig](#AsyncInvocationConfig9)**<br>Config for asynchronous invocations of the version 
tmpfs_size | **int64**<br>Optional size of in-memory mounted /tmp directory in bytes. 
concurrency | **int64**<br>The maximum number of requests processed by a function instance at the same time Acceptable values are 0 to 16, inclusive.


## CreateFunctionVersion {#CreateFunctionVersion}

Deprecated. Use [CreateVersion](#CreateVersion).

**rpc CreateFunctionVersion ([CreateFunctionVersionRequest](#CreateFunctionVersionRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateFunctionVersionMetadata](#CreateFunctionVersionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Version](#Version9)<br>

### CreateFunctionVersionRequest {#CreateFunctionVersionRequest1}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to create a version for. <br>To get a function ID, make a [FunctionService.List](#List) request. 
runtime | **string**<br>Required. Runtime environment for the version. 
description | **string**<br>Description of the version The string length in characters must be 0-256.
entrypoint | **string**<br>Required. Entrypoint of the version. 
resources | **[Resources](#Resources9)**<br>Required. Resources allocated to the version. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Timeout for the execution of the version. <br>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. 
service_account_id | **string**<br>ID of the service account to associate with the version. 
package_source | **oneof:** `package`, `content` or `version_id`<br>Source of the deployment package for the version.
&nbsp;&nbsp;package | **[Package](#Package1)**<br>Functions deployment package. 
&nbsp;&nbsp;content | **bytes**<br>Content of the deployment package. The maximum string length in characters is 52428800.
&nbsp;&nbsp;version_id | **string**<br>ID of the version to be copied from. Source version must belong to the same folder as the created version and the user must have read permissions to the source version. 
environment | **map<string,string>**<br>Environment settings for the version. The maximum string length in characters for each value is 4096. Each key must match the regular expression ` [a-zA-Z][a-zA-Z0-9_]* `.
tag[] | **string**<br>Function version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). Each value must match the regular expression ` [a-z][-_0-9a-z]* `.
connectivity | **[Connectivity](#Connectivity9)**<br>Function version connectivity. If specified the version will be attached to specified network/subnet(s). 
named_service_accounts | **map<string,string>**<br>Additional service accounts to be used by the version. 
secrets[] | **[Secret](#Secret9)**<br>Yandex Lockbox secrets to be used by the version. 
log_options | **[LogOptions](#LogOptions9)**<br>Options for logging from the function 
storage_mounts[] | **[StorageMount](#StorageMount9)**<br>S3 mounts to be used by the version. 
async_invocation_config | **[AsyncInvocationConfig](#AsyncInvocationConfig9)**<br>Config for asynchronous invocations of the version 
tmpfs_size | **int64**<br>Optional size of in-memory mounted /tmp directory in bytes. Available for versions with resources.memory greater or equal to 1024 MiB. <br>0 or in range from 512 MiB to 3/4 of resources.memory. 
concurrency | **int64**<br>The maximum number of requests processed by a function instance at the same time Acceptable values are 0 to 16, inclusive.


### Resources {#Resources9}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes, multiple of 128MB. Acceptable values are 134217728 to 4294967296, inclusive.


### Package {#Package1}

Field | Description
--- | ---
bucket_name | **string**<br>Required. Name of the bucket that stores the code for the version. 
object_name | **string**<br>Required. Name of the object in the bucket that stores the code for the version. 
sha256 | **string**<br>SHA256 hash of the version deployment package. 


### Connectivity {#Connectivity9}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. The string length in characters for each value must be greater than 0.


### Secret {#Secret9}

Field | Description
--- | ---
id | **string**<br>ID of Yandex Lockbox secret. 
version_id | **string**<br>ID of Yandex Lockbox version. 
key | **string**<br>Key in secret's payload, which value to be delivered into function environment. 
reference | **oneof:** `environment_variable`<br>
&nbsp;&nbsp;environment_variable | **string**<br>environment variable in which secret's value to be delivered. 


### LogOptions {#LogOptions9}

Field | Description
--- | ---
disabled | **bool**<br>Is logging from function disabled. 
destination | **oneof:** `log_group_id` or `folder_id`<br>Log entries destination.
&nbsp;&nbsp;log_group_id | **string**<br>Entry should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>Entry should be written to default log group for specified folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
min_level | **`yandex.cloud.logging.v1.LogLevel.Level`**<br>Minimum log entry level. <br>See [LogLevel.Level] for details. 


### StorageMount {#StorageMount9}

Field | Description
--- | ---
bucket_id | **string**<br>Required. S3 bucket name for mounting. The string length in characters must be 3-63. Value must match the regular expression ` [-.0-9a-zA-Z]* `.
prefix | **string**<br>S3 bucket prefix for mounting. 
mount_point_name | **string**<br>Required. Mount point directory name (not path) for mounting. The string length in characters must be 1-100. Value must match the regular expression ` [-_0-9a-zA-Z]* `.
read_only | **bool**<br>Is mount read only. 


### AsyncInvocationConfig {#AsyncInvocationConfig9}

Field | Description
--- | ---
retries_count | **int64**<br>Number of retries of version invocation Acceptable values are 0 to 100, inclusive.
success_target | **[ResponseTarget](#ResponseTarget9)**<br>Required. Target for successful result of the version's invocation 
failure_target | **[ResponseTarget](#ResponseTarget9)**<br>Required. Target for unsuccessful result, if all retries failed 
service_account_id | **string**<br>Service account which can invoke version 


### ResponseTarget {#ResponseTarget9}

Field | Description
--- | ---
target | **oneof:** `empty_target` or `ymq_target`<br>
&nbsp;&nbsp;empty_target | **[EmptyTarget](#EmptyTarget9)**<br>Target to ignore a result 
&nbsp;&nbsp;ymq_target | **[YMQTarget](#YMQTarget9)**<br>Target to send a result to ymq 


### EmptyTarget {#EmptyTarget9}

Empty.

### YMQTarget {#YMQTarget9}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


### Operation {#Operation7}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateFunctionVersionMetadata](#CreateFunctionVersionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Version](#Version9)>**<br>if operation finished successfully. 


### CreateFunctionVersionMetadata {#CreateFunctionVersionMetadata1}

Field | Description
--- | ---
function_version_id | **string**<br>ID of the version that is being created. 


### Version {#Version9}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
function_id | **string**<br>ID of the function that the version belongs to. 
description | **string**<br>Description of the version. The string length in characters must be 0-256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the version. 
runtime | **string**<br>ID of the runtime environment for the function. <br>Supported environments and their identifiers are listed in the [Runtime environments](/docs/functions/concepts/runtime). 
entrypoint | **string**<br>Entrypoint for the function: the name of the function to be called as the handler. <br>Specified in the format `<function file name>.<handler name>`, for example, `index.myFunction`. 
resources | **[Resources](#Resources10)**<br>Resources allocated to the version. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the execution of the version. <br>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. 
service_account_id | **string**<br>ID of the service account associated with the version. 
image_size | **int64**<br>Final size of the deployment package after unpacking. 
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li></ul>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity10)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 
named_service_accounts | **map<string,string>**<br>Additional service accounts to be used by the version. 
secrets[] | **[Secret](#Secret10)**<br>Yandex Lockbox secrets to be used by the version. 
log_options | **[LogOptions](#LogOptions10)**<br>Options for logging from the function 
storage_mounts[] | **[StorageMount](#StorageMount10)**<br>S3 mounts to be used by the version. 
async_invocation_config | **[AsyncInvocationConfig](#AsyncInvocationConfig10)**<br>Config for asynchronous invocations of the version 
tmpfs_size | **int64**<br>Optional size of in-memory mounted /tmp directory in bytes. 
concurrency | **int64**<br>The maximum number of requests processed by a function instance at the same time Acceptable values are 0 to 16, inclusive.


## ListRuntimes {#ListRuntimes}

Lists available runtime environments for the specified function.

**rpc ListRuntimes ([ListRuntimesRequest](#ListRuntimesRequest)) returns ([ListRuntimesResponse](#ListRuntimesResponse))**

### ListRuntimesRequest {#ListRuntimesRequest}

Empty.

### ListRuntimesResponse {#ListRuntimesResponse}

Field | Description
--- | ---
runtimes[] | **string**<br>Runtime environments available for the specified function. 


## ListOperations {#ListOperations}

Lists operations for the specified function.

**rpc ListOperations ([ListFunctionOperationsRequest](#ListFunctionOperationsRequest)) returns ([ListFunctionOperationsResponse](#ListFunctionOperationsResponse))**

### ListFunctionOperationsRequest {#ListFunctionOperationsRequest}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to list operations for. 
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `pageSize`, the service returns a [ListFunctionOperationsResponse.next_page_token](#ListFunctionOperationsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListFunctionOperationsResponse.next_page_token](#ListFunctionOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can be applied to the [operation.Operation.done](#Operation8), [operation.Operation.created_by](#Operation8) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Examples of a filter: `done=false`, `created_by='John.Doe'`. The maximum string length in characters is 1000.


### ListFunctionOperationsResponse {#ListFunctionOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation8)**<br>List of operations for the specified function. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListFunctionOperationsRequest.page_size](#ListFunctionOperationsRequest), use `nextPageToken` as the value for the [ListFunctionOperationsRequest.page_token](#ListFunctionOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### Operation {#Operation8}

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

Lists existing access bindings for the specified function.

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

Sets access bindings for the function.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation9))**

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


### Operation {#Operation9}

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

Updates access bindings for the specified function.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation10))**

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


### Operation {#Operation10}

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


## ListScalingPolicies {#ListScalingPolicies}

Lists existing scaling policies for specified function

**rpc ListScalingPolicies ([ListScalingPoliciesRequest](#ListScalingPoliciesRequest)) returns ([ListScalingPoliciesResponse](#ListScalingPoliciesResponse))**

### ListScalingPoliciesRequest {#ListScalingPoliciesRequest}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to retrieve scaling policies for. <br>To get a function ID, make a [FunctionService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `pageSize`, the service returns a [ListScalingPoliciesResponse.next_page_token](#ListScalingPoliciesResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListScalingPoliciesResponse.next_page_token](#ListScalingPoliciesResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListScalingPoliciesResponse {#ListScalingPoliciesResponse}

Field | Description
--- | ---
scaling_policies[] | **[ScalingPolicy](#ScalingPolicy)**<br>Set of relevant scaling policies. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListScalingPoliciesRequest.page_size](#ListScalingPoliciesRequest), use `nextPageToken` as the value for the [ListScalingPoliciesRequest.page_token](#ListScalingPoliciesRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### ScalingPolicy {#ScalingPolicy}

Field | Description
--- | ---
function_id | **string**<br>ID of the function that the scaling policy belongs to. 
tag | **string**<br>Tag of the version that the scaling policy belongs to. For details, see [Version tag](/docs/functions/concepts/function#tag). 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the scaling policy 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Modification timestamp for the scaling policy 
provisioned_instances_count | **int64**<br>Minimum guaranteed provisioned instances count for all zones in total. Billed separately. 
zone_instances_limit | **int64**<br>Upper limit for instance count in each zone. 0 means no limit. 
zone_requests_limit | **int64**<br>Upper limit of requests count in each zone. 0 means no limit. 


## SetScalingPolicy {#SetScalingPolicy}

Set scaling policy for specified function and tag

**rpc SetScalingPolicy ([SetScalingPolicyRequest](#SetScalingPolicyRequest)) returns ([operation.Operation](#Operation11))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetScalingPolicyMetadata](#SetScalingPolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ScalingPolicy](#ScalingPolicy1)<br>

### SetScalingPolicyRequest {#SetScalingPolicyRequest}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to retrieve scaling policies for. <br>To get a function ID, make a [FunctionService.List](#List) request. 
tag | **string**<br>Required. Version tag. <br>To get the history of version tags make a [FunctionService.ListTagHistory](#ListTagHistory) request. Value must match the regular expression ` [a-z][-_0-9a-z]*\|[$]latest `.
provisioned_instances_count | **int64**<br>Minimum guaranteed provisioned instances count for all zones in total. Billed separately. Acceptable values are 0 to 1000, inclusive.
zone_instances_limit | **int64**<br>Upper limit for instance count in each zone. 0 means no limit. Acceptable values are 0 to 1000, inclusive.
zone_requests_limit | **int64**<br>Upper limit of requests count in each zone. 0 means no limit. Acceptable values are 0 to 1000, inclusive.


### Operation {#Operation11}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetScalingPolicyMetadata](#SetScalingPolicyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ScalingPolicy](#ScalingPolicy1)>**<br>if operation finished successfully. 


### SetScalingPolicyMetadata {#SetScalingPolicyMetadata}

Field | Description
--- | ---
function_id | **string**<br>ID of the function for which scaling policy was set. 


### ScalingPolicy {#ScalingPolicy1}

Field | Description
--- | ---
function_id | **string**<br>ID of the function that the scaling policy belongs to. 
tag | **string**<br>Tag of the version that the scaling policy belongs to. For details, see [Version tag](/docs/functions/concepts/function#tag). 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the scaling policy 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Modification timestamp for the scaling policy 
provisioned_instances_count | **int64**<br>Minimum guaranteed provisioned instances count for all zones in total. Billed separately. 
zone_instances_limit | **int64**<br>Upper limit for instance count in each zone. 0 means no limit. 
zone_requests_limit | **int64**<br>Upper limit of requests count in each zone. 0 means no limit. 


## RemoveScalingPolicy {#RemoveScalingPolicy}

Remove scaling policy for specified function and tag

**rpc RemoveScalingPolicy ([RemoveScalingPolicyRequest](#RemoveScalingPolicyRequest)) returns ([operation.Operation](#Operation12))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveScalingPolicyMetadata](#RemoveScalingPolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### RemoveScalingPolicyRequest {#RemoveScalingPolicyRequest}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to remove scaling policies for. <br>To get a function ID, make a [FunctionService.List](#List) request. 
tag | **string**<br>Required. Version tag. <br>To get the history of version tags make a [FunctionService.ListTagHistory](#ListTagHistory) request. Value must match the regular expression ` [a-z][-_0-9a-z]*\|[$]latest `.


### Operation {#Operation12}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RemoveScalingPolicyMetadata](#RemoveScalingPolicyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### RemoveScalingPolicyMetadata {#RemoveScalingPolicyMetadata}

Field | Description
--- | ---
function_id | **string**<br>ID of the function for which scaling policy was removed. 


