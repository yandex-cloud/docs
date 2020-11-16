---
editable: false
---

# FunctionService

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
status | enum **Status**<br>Status of the function. <ul><li>`CREATING`: Function is being created.</li><li>`ACTIVE`: Function is ready to be invoked.</li><li>`DELETING`: Function is being deleted.</li><li>`ERROR`: Function failed.</li><ul/>


## List {#List}

Retrieves the list of functions in the specified folder.

**rpc List ([ListFunctionsRequest](#ListFunctionsRequest)) returns ([ListFunctionsResponse](#ListFunctionsResponse))**

### ListFunctionsRequest {#ListFunctionsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list functions in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [ListFunctionsResponse.next_page_token](#ListFunctionsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListFunctionsResponse.next_page_token](#ListFunctionsResponse) returned by a previous list request. 
filter | **string**<br><ol><li>The field name. Currently filtering can only be applied to the [Function.name](#Function1) field. </li><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. </li></ol> 


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
status | enum **Status**<br>Status of the function. <ul><li>`CREATING`: Function is being created.</li><li>`ACTIVE`: Function is ready to be invoked.</li><li>`DELETING`: Function is being deleted.</li><li>`ERROR`: Function failed.</li><ul/>


## Create {#Create}

Creates a function in the specified folder.

**rpc Create ([CreateFunctionRequest](#CreateFunctionRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateFunctionMetadata](#CreateFunctionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Function](#Function2)<br>

### CreateFunctionRequest {#CreateFunctionRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a function in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. 
name | **string**<br>Name of the function. The name must be unique within the folder. Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
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
status | enum **Status**<br>Status of the function. <ul><li>`CREATING`: Function is being created.</li><li>`ACTIVE`: Function is ready to be invoked.</li><li>`DELETING`: Function is being deleted.</li><li>`ERROR`: Function failed.</li><ul/>


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
name | **string**<br>New name for the function. The name must be unique within the folder. Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
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
status | enum **Status**<br>Status of the function. <ul><li>`CREATING`: Function is being created.</li><li>`ACTIVE`: Function is ready to be invoked.</li><li>`DELETING`: Function is being deleted.</li><li>`ERROR`: Function failed.</li><ul/>


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
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li><ul/>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 


### Resources {#Resources}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes. Acceptable values are 134217728 to 2147483648, inclusive.


### Connectivity {#Connectivity}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. 


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
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li><ul/>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity1)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 


### Resources {#Resources1}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes. Acceptable values are 134217728 to 2147483648, inclusive.


### Connectivity {#Connectivity1}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. 


## GetVersionByTag {#GetVersionByTag}

Returns all versions with the specified tag. <br>To get the list of all available versions, make a [ListVersions](#ListVersions) request.

**rpc GetVersionByTag ([GetFunctionVersionByTagRequest](#GetFunctionVersionByTagRequest)) returns ([Version](#Version2))**

### GetFunctionVersionByTagRequest {#GetFunctionVersionByTagRequest}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function whose versions should be listed. <br>To get a function ID use a [FunctionService.List](#List) request. 
tag | **string**<br>Version tag. <br>To get the history of version tags make a [FunctionService.ListTagHistory](#ListTagHistory) request. Value must match the regular expression ` [a-z][-_0-9a-z]*|[$]latest `.


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
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li><ul/>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity2)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 


### Resources {#Resources2}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes. Acceptable values are 134217728 to 2147483648, inclusive.


### Connectivity {#Connectivity2}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. 


## GetFunctionVersionByTag {#GetFunctionVersionByTag}

Deprecated. Use [GetVersionByTag](#GetVersionByTag).

**rpc GetFunctionVersionByTag ([GetFunctionVersionByTagRequest](#GetFunctionVersionByTagRequest)) returns ([Version](#Version3))**

### GetFunctionVersionByTagRequest {#GetFunctionVersionByTagRequest1}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function whose versions should be listed. <br>To get a function ID use a [FunctionService.List](#List) request. 
tag | **string**<br>Version tag. <br>To get the history of version tags make a [FunctionService.ListTagHistory](#ListTagHistory) request. Value must match the regular expression ` [a-z][-_0-9a-z]*|[$]latest `.


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
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li><ul/>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity3)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 


### Resources {#Resources3}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes. Acceptable values are 134217728 to 2147483648, inclusive.


### Connectivity {#Connectivity3}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. 


## ListVersions {#ListVersions}

Retrieves the list of versions for the specified function, or of all function versions in the specified folder.

**rpc ListVersions ([ListFunctionsVersionsRequest](#ListFunctionsVersionsRequest)) returns ([ListFunctionsVersionsResponse](#ListFunctionsVersionsResponse))**

### ListFunctionsVersionsRequest {#ListFunctionsVersionsRequest}

Field | Description
--- | ---
id | **oneof:** `folder_id` or `function_id`<br>
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder to list function versions for. To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. 
&nbsp;&nbsp;function_id | **string**<br>ID of the function to list versions for. To get a function ID use a [FunctionService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [ListFunctionsVersionsResponse.next_page_token](#ListFunctionsVersionsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListFunctionsVersionsResponse.next_page_token](#ListFunctionsVersionsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently filtering can only be applied to the [Function.name](#Function4) field. </li><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. </li></ol> The maximum string length in characters is 1000.


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
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li><ul/>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity4)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 


### Resources {#Resources4}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes. Acceptable values are 134217728 to 2147483648, inclusive.


### Connectivity {#Connectivity4}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. 


## ListFunctionVersions {#ListFunctionVersions}

Deprecated. Use [ListVersions](#ListVersions).

**rpc ListFunctionVersions ([ListFunctionsVersionsRequest](#ListFunctionsVersionsRequest)) returns ([ListFunctionsVersionsResponse](#ListFunctionsVersionsResponse))**

### ListFunctionsVersionsRequest {#ListFunctionsVersionsRequest1}

Field | Description
--- | ---
id | **oneof:** `folder_id` or `function_id`<br>
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder to list function versions for. To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. 
&nbsp;&nbsp;function_id | **string**<br>ID of the function to list versions for. To get a function ID use a [FunctionService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [ListFunctionsVersionsResponse.next_page_token](#ListFunctionsVersionsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListFunctionsVersionsResponse.next_page_token](#ListFunctionsVersionsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently filtering can only be applied to the [Function.name](#Function4) field. </li><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. </li></ol> The maximum string length in characters is 1000.


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
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li><ul/>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity5)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 


### Resources {#Resources5}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes. Acceptable values are 134217728 to 2147483648, inclusive.


### Connectivity {#Connectivity5}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. 


## SetTag {#SetTag}

Set a tag for the specified version of a function.

**rpc SetTag ([SetFunctionTagRequest](#SetFunctionTagRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetFunctionTagMetadata](#SetFunctionTagMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Version](#Version6)<br>

### SetFunctionTagRequest {#SetFunctionTagRequest}

Field | Description
--- | ---
function_version_id | **string**<br>Required. ID of the version to set the tag for. <br>To get a version ID make a [FunctionService.ListVersions](#ListVersions) request. 
tag | **string**<br>Tag to set for the version. Value must match the regular expression ` [a-z][-_0-9a-z]* `.


### Operation {#Operation3}

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
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li><ul/>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity6)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 


### Resources {#Resources6}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes. Acceptable values are 134217728 to 2147483648, inclusive.


### Connectivity {#Connectivity6}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. 


## RemoveTag {#RemoveTag}

Remove a tag from the specified version of a function.

**rpc RemoveTag ([RemoveFunctionTagRequest](#RemoveFunctionTagRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveFunctionTagMetadata](#RemoveFunctionTagMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Version](#Version7)<br>

### RemoveFunctionTagRequest {#RemoveFunctionTagRequest}

Field | Description
--- | ---
function_version_id | **string**<br>Required. ID of the version to remove a tag from. <br>To get the a version ID make a [FunctionService.ListVersions](#ListVersions) request. 
tag | **string**<br>Tag to remove from the specified version. Value must match the regular expression ` [a-z][-_0-9a-z]* `.


### Operation {#Operation4}

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
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li><ul/>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity7)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 


### Resources {#Resources7}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes. Acceptable values are 134217728 to 2147483648, inclusive.


### Connectivity {#Connectivity7}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. 


## ListTagHistory {#ListTagHistory}

Returns the log of tags assigned to versions of the specified function.

**rpc ListTagHistory ([ListFunctionTagHistoryRequest](#ListFunctionTagHistoryRequest)) returns ([ListFunctionTagHistoryResponse](#ListFunctionTagHistoryResponse))**

### ListFunctionTagHistoryRequest {#ListFunctionTagHistoryRequest}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to retrieve tag history for. <br>To get a function ID, make a [FunctionService.List](#List) request. 
tag | **string**<br>Specific tag that history should be limited to. Value must match the regular expression ` [a-z][-_0-9a-z]*|[$]latest `.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `pageSize`, the service returns a [ListFunctionOperationsResponse.next_page_token](#ListFunctionOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListFunctionOperationsResponse.next_page_token](#ListFunctionOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently filtering can only be applied to the [Function.name](#Function4) field. </li><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. </li></ol> The maximum string length in characters is 1000.


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
tag | **string**<br>Specific tag that history should be limited to. Value must match the regular expression ` [a-z][-_0-9a-z]*|[$]latest `.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `pageSize`, the service returns a [ListFunctionOperationsResponse.next_page_token](#ListFunctionOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListFunctionOperationsResponse.next_page_token](#ListFunctionOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently filtering can only be applied to the [Function.name](#Function4) field. </li><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. </li></ol> The maximum string length in characters is 1000.


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

**rpc CreateVersion ([CreateFunctionVersionRequest](#CreateFunctionVersionRequest)) returns ([operation.Operation](#Operation5))**

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


### Resources {#Resources8}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes. Acceptable values are 134217728 to 2147483648, inclusive.


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
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. 


### Operation {#Operation5}

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
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li><ul/>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity9)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 


### Resources {#Resources9}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes. Acceptable values are 134217728 to 2147483648, inclusive.


### Connectivity {#Connectivity9}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. 


## CreateFunctionVersion {#CreateFunctionVersion}

Deprecated. Use [CreateVersion](#CreateVersion).

**rpc CreateFunctionVersion ([CreateFunctionVersionRequest](#CreateFunctionVersionRequest)) returns ([operation.Operation](#Operation6))**

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
resources | **[Resources](#Resources10)**<br>Required. Resources allocated to the version. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Timeout for the execution of the version. <br>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. 
service_account_id | **string**<br>ID of the service account to associate with the version. 
package_source | **oneof:** `package`, `content` or `version_id`<br>Source of the deployment package for the version.
&nbsp;&nbsp;package | **[Package](#Package1)**<br>Functions deployment package. 
&nbsp;&nbsp;content | **bytes**<br>Content of the deployment package. The maximum string length in characters is 52428800.
&nbsp;&nbsp;version_id | **string**<br>ID of the version to be copied from. Source version must belong to the same folder as the created version and the user must have read permissions to the source version. 
environment | **map<string,string>**<br>Environment settings for the version. The maximum string length in characters for each value is 4096. Each key must match the regular expression ` [a-zA-Z][a-zA-Z0-9_]* `.
tag[] | **string**<br>Function version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). Each value must match the regular expression ` [a-z][-_0-9a-z]* `.
connectivity | **[Connectivity](#Connectivity10)**<br>Function version connectivity. If specified the version will be attached to specified network/subnet(s). 


### Resources {#Resources10}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes. Acceptable values are 134217728 to 2147483648, inclusive.


### Package {#Package1}

Field | Description
--- | ---
bucket_name | **string**<br>Required. Name of the bucket that stores the code for the version. 
object_name | **string**<br>Required. Name of the object in the bucket that stores the code for the version. 
sha256 | **string**<br>SHA256 hash of the version deployment package. 


### Connectivity {#Connectivity10}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. 


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
resources | **[Resources](#Resources11)**<br>Resources allocated to the version. 
execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the execution of the version. <br>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. 
service_account_id | **string**<br>ID of the service account associated with the version. 
image_size | **int64**<br>Final size of the deployment package after unpacking. 
status | enum **Status**<br>Status of the version. <ul><li>`CREATING`: Version is being created.</li><li>`ACTIVE`: Version is ready to use.</li><ul/>
tags[] | **string**<br>Version tags. For details, see [Version tag](/docs/functions/concepts/function#tag). 
log_group_id | **string**<br>ID of the log group for the version. 
environment | **map<string,string>**<br>Environment settings for the version. 
connectivity | **[Connectivity](#Connectivity11)**<br>Network access. If specified the version will be attached to specified network/subnet(s). 


### Resources {#Resources11}

Field | Description
--- | ---
memory | **int64**<br>Amount of memory available to the version, specified in bytes. Acceptable values are 134217728 to 2147483648, inclusive.


### Connectivity {#Connectivity11}

Field | Description
--- | ---
network_id | **string**<br>Network the version will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones. 


## ListRuntimes {#ListRuntimes}

Lists available runtime environments for the specified function.

**rpc ListRuntimes ([ListRuntimesRequest](#ListRuntimesRequest)) returns ([ListRuntimesResponse](#ListRuntimesResponse))**

### ListRuntimesRequest {#ListRuntimesRequest}



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
filter | **string**<br><ol><li>The field name. Currently filtering can be applied to the [operation.Operation.done](#Operation7), [operation.Operation.created_by](#Operation7) field. </li><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. </li></ol> The maximum string length in characters is 1000.


### ListFunctionOperationsResponse {#ListFunctionOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation7)**<br>List of operations for the specified function. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListFunctionOperationsRequest.page_size](#ListFunctionOperationsRequest), use `nextPageToken` as the value for the [ListFunctionOperationsRequest.page_token](#ListFunctionOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### Operation {#Operation7}

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
resource_id | **string**<br>Required. ID of the resource to list access bindings for. <br>To get the resource ID, use a corresponding List request. For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/grpc/cloud_service#List) request to get the Cloud resource ID. The maximum string length in characters is 50.
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
id | **string**<br>Required. <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul> The maximum string length in characters is 50.
type | **string**<br>Required. <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul> The maximum string length in characters is 100.


## SetAccessBindings {#SetAccessBindings}

Sets access bindings for the function.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation8))**

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
id | **string**<br>Required. <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul> The maximum string length in characters is 50.
type | **string**<br>Required. <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul> The maximum string length in characters is 100.


### Operation {#Operation8}

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

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation9))**

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
action | enum **AccessBindingAction**<br>Required. The action that is being performed on an access binding. <ul><li>`ADD`: Addition of an access binding.</li><li>`REMOVE`: Removal of an access binding.</li><ul/>
access_binding | **[AccessBinding](#AccessBinding)**<br>Required. Access binding. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding2}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject2}

Field | Description
--- | ---
id | **string**<br>Required. <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul> The maximum string length in characters is 50.
type | **string**<br>Required. <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul> The maximum string length in characters is 100.


### Operation {#Operation9}

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


