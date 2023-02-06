---
editable: false
---

# Cloud Desktop API, gRPC: DesktopService

A set of methods for managing desktop resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified desktop resource. |
| [GetRdpFile](#GetRdpFile) | Returns a RDP file for the specified desktop. |
| [List](#List) | Retrieves the list of desktop resources. |
| [ListOperations](#ListOperations) | Returns list of the operations for the specified desktop. |
| [Create](#Create) | Creates desktop in the specified folder. |
| [Delete](#Delete) | Deletes the specified desktop. |
| [ResetPassword](#ResetPassword) | Reset password |
| [Restart](#Restart) | Restart the specified desktop. |

## Calls DesktopService {#calls}

## Get {#Get}

Returns the specified desktop resource. <br>To get the list of available desktops, make a [List](#List) request.

**rpc Get ([GetDesktopRequest](#GetDesktopRequest)) returns ([Desktop](#Desktop))**

### GetDesktopRequest {#GetDesktopRequest}

Field | Description
--- | ---
desktop_id | **string**<br>Required. ID of the desktop resource to return. <br>To get the desktop ID use a [DesktopService.List](#List) request. The maximum string length in characters is 50.


### Desktop {#Desktop}

Field | Description
--- | ---
id | **string**<br>Desktop ID. 
folder_id | **string**<br>ID of the folder that the desktop belongs to. 
desktop_group_id | **string**<br>ID of the desktop group that the desktop belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
status | enum **Status**<br>Status of the desktop. <ul><li>`CREATING`: Desktop is being created.</li><li>`ACTIVE`: Desktop is ready to use.</li><li>`DELETING`: Desktop is being deleted.</li></ul>
name | **string**<br>Name of the desktop. 
resources | **[Resources](#Resources)**<br>Resources of the desktop. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface)**<br> 
users[] | **[User](#User)**<br> 


### Resources {#Resources}

Field | Description
--- | ---
memory | **int64**<br> The minimum value is 1.
cores | **int64**<br> The minimum value is 1.
core_fraction | **int64**<br> Acceptable values are 0 to 100, inclusive.


### NetworkInterface {#NetworkInterface}

Field | Description
--- | ---
network_id | **string**<br>Required.  The maximum string length in characters is 50.
subnet_id | **string**<br>Required.  The maximum string length in characters is 50.


### User {#User}

Field | Description
--- | ---
subject_id | **string**<br>Required. Identity of the access binding. 


## GetRdpFile {#GetRdpFile}

Returns a RDP file for the specified desktop.

**rpc GetRdpFile ([GetRdpFileRequest](#GetRdpFileRequest)) returns ([RdpFileResponse](#RdpFileResponse))**

### GetRdpFileRequest {#GetRdpFileRequest}

Field | Description
--- | ---
desktop_id | **string**<br>Required. ID of the desktop resource to return. <br>To get the desktop ID use a [DesktopService.List](#List) request. The maximum string length in characters is 50.
user | **[User](#User1)**<br>User of the desktop. 


### User {#User1}

Field | Description
--- | ---
subject_id | **string**<br>Required. Identity of the access binding. 


### RdpFileResponse {#RdpFileResponse}

Field | Description
--- | ---
headers | **map<string,string>**<br>HTTP headers mapping. 
content | **string**<br>RDP file content. 


## List {#List}

Retrieves the list of desktop resources.

**rpc List ([ListDesktopsRequest](#ListDesktopsRequest)) returns ([ListDesktopsResponse](#ListDesktopsResponse))**

### ListDesktopsRequest {#ListDesktopsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a DesktopGroup in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDesktopsResponse.next_page_token](#ListDesktopsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDesktopsResponse.next_page_token](#ListDesktopsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on [Desktop.name](#Desktop1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>Value or a list of values to compare against the values of the field.</li></ol> The maximum string length in characters is 1000.
order_by | **string**<br>Sorting the list by [Desktop.name](#Desktop1), [Desktop.created_at](#Desktop1) and [Desktop.status](#Desktop1) fields. The default sorting order is ascending. The maximum string length in characters is 100.


### ListDesktopsResponse {#ListDesktopsResponse}

Field | Description
--- | ---
desktops[] | **[Desktop](#Desktop1)**<br>List of desktops. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListDesktopsRequest.page_size](#ListDesktopsRequest), use the `next_page_token` as the value for the [ListDesktopsRequest.page_token](#ListDesktopsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Desktop {#Desktop1}

Field | Description
--- | ---
id | **string**<br>Desktop ID. 
folder_id | **string**<br>ID of the folder that the desktop belongs to. 
desktop_group_id | **string**<br>ID of the desktop group that the desktop belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
status | enum **Status**<br>Status of the desktop. <ul><li>`CREATING`: Desktop is being created.</li><li>`ACTIVE`: Desktop is ready to use.</li><li>`DELETING`: Desktop is being deleted.</li></ul>
name | **string**<br>Name of the desktop. 
resources | **[Resources](#Resources1)**<br>Resources of the desktop. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface1)**<br> 
users[] | **[User](#User2)**<br> 


### Resources {#Resources1}

Field | Description
--- | ---
memory | **int64**<br> The minimum value is 1.
cores | **int64**<br> The minimum value is 1.
core_fraction | **int64**<br> Acceptable values are 0 to 100, inclusive.


### NetworkInterface {#NetworkInterface1}

Field | Description
--- | ---
network_id | **string**<br>Required.  The maximum string length in characters is 50.
subnet_id | **string**<br>Required.  The maximum string length in characters is 50.


### User {#User2}

Field | Description
--- | ---
subject_id | **string**<br>Required. Identity of the access binding. 


## ListOperations {#ListOperations}

Returns list of the operations for the specified desktop.

**rpc ListOperations ([ListDesktopOperationsRequest](#ListDesktopOperationsRequest)) returns ([ListDesktopOperationsResponse](#ListDesktopOperationsResponse))**

### ListDesktopOperationsRequest {#ListDesktopOperationsRequest}

Field | Description
--- | ---
desktop_id | **string**<br>Required. ID of the desktop. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDesktopOperationsResponse.next_page_token](#ListDesktopOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDesktopOperationsResponse.next_page_token](#ListDesktopOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on [Desktop.name](#Desktop2) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>Value or a list of values to compare against the values of the field.</li></ol> The maximum string length in characters is 1000.


### ListDesktopOperationsResponse {#ListDesktopOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation)**<br>List of operations for the specified desktop. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListDesktopOperationsRequest.page_size](#ListDesktopOperationsRequest), use the `next_page_token` as the value for the [ListDesktopOperationsRequest.page_token](#ListDesktopOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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


## Create {#Create}

Creates desktop in the specified folder.

**rpc Create ([CreateDesktopRequest](#CreateDesktopRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDesktopMetadata](#CreateDesktopMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Desktop](#Desktop2)<br>

### CreateDesktopRequest {#CreateDesktopRequest}

Field | Description
--- | ---
desktop_group_id | **string**<br>Required. ID of the desktop group. The maximum string length in characters is 50.
users[] | **[User](#User3)**<br>List of users. The number of elements must be greater than 0.


### User {#User3}

Field | Description
--- | ---
subject_id | **string**<br>Required. Identity of the access binding. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateDesktopMetadata](#CreateDesktopMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Desktop](#Desktop2)>**<br>if operation finished successfully. 


### CreateDesktopMetadata {#CreateDesktopMetadata}

Field | Description
--- | ---
desktop_id | **string**<br>ID of the desktop that is being created. 


### Desktop {#Desktop2}

Field | Description
--- | ---
id | **string**<br>Desktop ID. 
folder_id | **string**<br>ID of the folder that the desktop belongs to. 
desktop_group_id | **string**<br>ID of the desktop group that the desktop belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
status | enum **Status**<br>Status of the desktop. <ul><li>`CREATING`: Desktop is being created.</li><li>`ACTIVE`: Desktop is ready to use.</li><li>`DELETING`: Desktop is being deleted.</li></ul>
name | **string**<br>Name of the desktop. 
resources | **[Resources](#Resources2)**<br>Resources of the desktop. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface2)**<br> 
users[] | **[User](#User4)**<br> 


### Resources {#Resources2}

Field | Description
--- | ---
memory | **int64**<br> The minimum value is 1.
cores | **int64**<br> The minimum value is 1.
core_fraction | **int64**<br> Acceptable values are 0 to 100, inclusive.


### NetworkInterface {#NetworkInterface2}

Field | Description
--- | ---
network_id | **string**<br>Required.  The maximum string length in characters is 50.
subnet_id | **string**<br>Required.  The maximum string length in characters is 50.


## Delete {#Delete}

Deletes the specified desktop.

**rpc Delete ([DeleteDesktopRequest](#DeleteDesktopRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDesktopMetadata](#DeleteDesktopMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDesktopRequest {#DeleteDesktopRequest}

Field | Description
--- | ---
desktop_id | **string**<br>Required. ID of the desktop to delete. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteDesktopMetadata](#DeleteDesktopMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteDesktopMetadata {#DeleteDesktopMetadata}

Field | Description
--- | ---
desktop_id | **string**<br>ID of the desktop that is being deleted. 


## ResetPassword {#ResetPassword}

Reset password

**rpc ResetPassword ([ResetPasswordRequest](#ResetPasswordRequest)) returns ([ResetPasswordResponse](#ResetPasswordResponse))**

### ResetPasswordRequest {#ResetPasswordRequest}

Field | Description
--- | ---
desktop_id | **string**<br>Required. ID of the desktop. The maximum string length in characters is 50.
user | **[User](#User4)**<br>Required. User of the desktop. 


### User {#User4}

Field | Description
--- | ---
subject_id | **string**<br>Required. Identity of the access binding. 


### ResetPasswordResponse {#ResetPasswordResponse}

Field | Description
--- | ---
password | **string**<br>Generated password 


## Restart {#Restart}

Restart the specified desktop.

**rpc Restart ([RestartRequest](#RestartRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestartDesktopMetadata](#RestartDesktopMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Desktop](#Desktop3)<br>

### RestartRequest {#RestartRequest}

Field | Description
--- | ---
desktop_id | **string**<br>Required. ID of the desktop. The maximum string length in characters is 50.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RestartDesktopMetadata](#RestartDesktopMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Desktop](#Desktop3)>**<br>if operation finished successfully. 


### RestartDesktopMetadata {#RestartDesktopMetadata}

Field | Description
--- | ---
desktop_id | **string**<br>ID of the desktop. 


### Desktop {#Desktop3}

Field | Description
--- | ---
id | **string**<br>Desktop ID. 
folder_id | **string**<br>ID of the folder that the desktop belongs to. 
desktop_group_id | **string**<br>ID of the desktop group that the desktop belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
status | enum **Status**<br>Status of the desktop. <ul><li>`CREATING`: Desktop is being created.</li><li>`ACTIVE`: Desktop is ready to use.</li><li>`DELETING`: Desktop is being deleted.</li></ul>
name | **string**<br>Name of the desktop. 
resources | **[Resources](#Resources3)**<br>Resources of the desktop. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface3)**<br> 
users[] | **[User](#User5)**<br> 


### Resources {#Resources3}

Field | Description
--- | ---
memory | **int64**<br> The minimum value is 1.
cores | **int64**<br> The minimum value is 1.
core_fraction | **int64**<br> Acceptable values are 0 to 100, inclusive.


### NetworkInterface {#NetworkInterface3}

Field | Description
--- | ---
network_id | **string**<br>Required.  The maximum string length in characters is 50.
subnet_id | **string**<br>Required.  The maximum string length in characters is 50.


### User {#User5}

Field | Description
--- | ---
subject_id | **string**<br>Required. Identity of the access binding. 


