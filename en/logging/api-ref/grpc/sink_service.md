---
editable: false
sourcePath: en/_api-ref-grpc/logging/api-ref/grpc/sink_service.md
---

# Cloud Logging Service, gRPC: SinkService

A set of methods for managing log sinks.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified sink. |
| [List](#List) | Retrieves the list of sinks in the specified folder. |
| [Create](#Create) | Creates a sink in the specified folder. |
| [Update](#Update) | Updates the specified sink. |
| [Delete](#Delete) | Deletes the specified sink. |
| [ListOperations](#ListOperations) | Lists operations for the specified sink. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified sink. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the specified sink. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified sink. |

## Calls SinkService {#calls}

## Get {#Get}

Returns the specified sink. <br>To get the list of all available sinks, make a [List](#List) request.

**rpc Get ([GetSinkRequest](#GetSinkRequest)) returns ([Sink](#Sink))**

### GetSinkRequest {#GetSinkRequest}

Field | Description
--- | ---
sink_id | **string**<br>Required. ID of the sink to return. <br>To get a sink ID make a [SinkService.List](#List) request. The maximum string length in characters is 64.


### Sink {#Sink}

Field | Description
--- | ---
id | **string**<br>Sink ID. 
folder_id | **string**<br>Sink folder ID. 
cloud_id | **string**<br>Sink cloud ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Sink creation time. 
name | **string**<br>Sink name. 
description | **string**<br>Sink description. 
labels | **map<string,string>**<br>Sink labels. 
service_account_id | **string**<br>Logs will be written to the sink on behalf of this service account 
sink | **oneof:** `yds` or `s3`<br>Logs destination
&nbsp;&nbsp;yds | **[Yds](#Yds)**<br>Yandex data stream 
&nbsp;&nbsp;s3 | **[S3](#S3)**<br>Object storage 


### Yds {#Yds}

Field | Description
--- | ---
stream_name | **string**<br>Fully qualified name of data stream The maximum string length in characters is 512.


### S3 {#S3}

Field | Description
--- | ---
bucket | **string**<br>Object storage bucket Value must match the regular expression ` [a-zA-Z0-9][-a-zA-Z0-9.]{2,62} `.
prefix | **string**<br>Prefix to use for saved log object names The maximum string length in characters is 1024.


## List {#List}

Retrieves the list of sinks in the specified folder.

**rpc List ([ListSinksRequest](#ListSinksRequest)) returns ([ListSinksResponse](#ListSinksResponse))**

### ListSinksRequest {#ListSinksRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID of the sinks to return. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 64.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSinkssResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSinksResponse.next_page_token](#ListSinksResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters sinks listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can only be applied to the [Sink.name](#Sink1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name="my-sink"`. The maximum string length in characters is 1000.


### ListSinksResponse {#ListSinksResponse}

Field | Description
--- | ---
sinks[] | **[Sink](#Sink1)**<br>List of sinks in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListSinksRequest.page_size](#ListSinksRequest), use `next_page_token` as the value for the [ListSinksRequest.page_token](#ListSinksRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Sink {#Sink1}

Field | Description
--- | ---
id | **string**<br>Sink ID. 
folder_id | **string**<br>Sink folder ID. 
cloud_id | **string**<br>Sink cloud ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Sink creation time. 
name | **string**<br>Sink name. 
description | **string**<br>Sink description. 
labels | **map<string,string>**<br>Sink labels. 
service_account_id | **string**<br>Logs will be written to the sink on behalf of this service account 
sink | **oneof:** `yds` or `s3`<br>Logs destination
&nbsp;&nbsp;yds | **[Yds](#Yds1)**<br>Yandex data stream 
&nbsp;&nbsp;s3 | **[S3](#S31)**<br>Object storage 


### Yds {#Yds1}

Field | Description
--- | ---
stream_name | **string**<br>Fully qualified name of data stream The maximum string length in characters is 512.


### S3 {#S31}

Field | Description
--- | ---
bucket | **string**<br>Object storage bucket Value must match the regular expression ` [a-zA-Z0-9][-a-zA-Z0-9.]{2,62} `.
prefix | **string**<br>Prefix to use for saved log object names The maximum string length in characters is 1024.


## Create {#Create}

Creates a sink in the specified folder.

**rpc Create ([CreateSinkRequest](#CreateSinkRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateSinkMetadata](#CreateSinkMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Sink](#Sink2)<br>

### CreateSinkRequest {#CreateSinkRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a sink in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 64.
name | **string**<br>Name of the sink. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the sink. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Sink labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
service_account_id | **string**<br>Logs will be written to the sink on behalf of this service account Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
sink | **oneof:** `yds` or `s3`<br>Logs destination
&nbsp;&nbsp;yds | **[Sink.Yds](#Sink2)**<br>Yandex data stream 
&nbsp;&nbsp;s3 | **[Sink.S3](#Sink2)**<br>Object storage 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateSinkMetadata](#CreateSinkMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Sink](#Sink2)>**<br>if operation finished successfully. 


### CreateSinkMetadata {#CreateSinkMetadata}

Field | Description
--- | ---
sink_id | **string**<br>ID of the sink being created. 


### Sink {#Sink2}

Field | Description
--- | ---
id | **string**<br>Sink ID. 
folder_id | **string**<br>Sink folder ID. 
cloud_id | **string**<br>Sink cloud ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Sink creation time. 
name | **string**<br>Sink name. 
description | **string**<br>Sink description. 
labels | **map<string,string>**<br>Sink labels. 
service_account_id | **string**<br>Logs will be written to the sink on behalf of this service account 
sink | **oneof:** `yds` or `s3`<br>Logs destination
&nbsp;&nbsp;yds | **[Yds](#Yds2)**<br>Yandex data stream 
&nbsp;&nbsp;s3 | **[S3](#S32)**<br>Object storage 


### Yds {#Yds2}

Field | Description
--- | ---
stream_name | **string**<br>Fully qualified name of data stream The maximum string length in characters is 512.


### S3 {#S32}

Field | Description
--- | ---
bucket | **string**<br>Object storage bucket Value must match the regular expression ` [a-zA-Z0-9][-a-zA-Z0-9.]{2,62} `.
prefix | **string**<br>Prefix to use for saved log object names The maximum string length in characters is 1024.


## Update {#Update}

Updates the specified sink.

**rpc Update ([UpdateSinkRequest](#UpdateSinkRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSinkMetadata](#UpdateSinkMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Sink](#Sink3)<br>

### UpdateSinkRequest {#UpdateSinkRequest}

Field | Description
--- | ---
sink_id | **string**<br>Required. ID of the sink to update. <br>To get a sink ID make a [SinkService.List](#List) request. The maximum string length in characters is 64.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the function should be updated. 
name | **string**<br>New name of the sink. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>New Description of the sink. The maximum string length in characters is 256.
labels | **map<string,string>**<br>New sink labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
service_account_id | **string**<br>new service account to use for logs writing to the sink. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
sink | **oneof:** `yds` or `s3`<br>New logs destination
&nbsp;&nbsp;yds | **[Sink.Yds](#Sink3)**<br>Yandex data stream 
&nbsp;&nbsp;s3 | **[Sink.S3](#Sink3)**<br>Object storage 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSinkMetadata](#UpdateSinkMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Sink](#Sink3)>**<br>if operation finished successfully. 


### UpdateSinkMetadata {#UpdateSinkMetadata}

Field | Description
--- | ---
sink_id | **string**<br>ID of the sink being updated. 


### Sink {#Sink3}

Field | Description
--- | ---
id | **string**<br>Sink ID. 
folder_id | **string**<br>Sink folder ID. 
cloud_id | **string**<br>Sink cloud ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Sink creation time. 
name | **string**<br>Sink name. 
description | **string**<br>Sink description. 
labels | **map<string,string>**<br>Sink labels. 
service_account_id | **string**<br>Logs will be written to the sink on behalf of this service account 
sink | **oneof:** `yds` or `s3`<br>Logs destination
&nbsp;&nbsp;yds | **[Yds](#Yds3)**<br>Yandex data stream 
&nbsp;&nbsp;s3 | **[S3](#S33)**<br>Object storage 


### Yds {#Yds3}

Field | Description
--- | ---
stream_name | **string**<br>Fully qualified name of data stream The maximum string length in characters is 512.


### S3 {#S33}

Field | Description
--- | ---
bucket | **string**<br>Object storage bucket Value must match the regular expression ` [a-zA-Z0-9][-a-zA-Z0-9.]{2,62} `.
prefix | **string**<br>Prefix to use for saved log object names The maximum string length in characters is 1024.


## Delete {#Delete}

Deletes the specified sink.

**rpc Delete ([DeleteSinkRequest](#DeleteSinkRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteSinkMetadata](#DeleteSinkMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteSinkRequest {#DeleteSinkRequest}

Field | Description
--- | ---
sink_id | **string**<br>Required. ID of the sink to delete. <br>To get a sink ID make a [SinkService.List](#List) request. The maximum string length in characters is 64.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteSinkMetadata](#DeleteSinkMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteSinkMetadata {#DeleteSinkMetadata}

Field | Description
--- | ---
sink_id | **string**<br>ID of the sink being deleted. 


## ListOperations {#ListOperations}

Lists operations for the specified sink.

**rpc ListOperations ([ListSinkOperationsRequest](#ListSinkOperationsRequest)) returns ([ListSinkOperationsResponse](#ListSinkOperationsResponse))**

### ListSinkOperationsRequest {#ListSinkOperationsRequest}

Field | Description
--- | ---
sink_id | **string**<br>Required. ID of the sink to list operations for. <br>To get a sink ID make a [SinkService.List](#List) request. The maximum string length in characters is 64.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSinkOperationsResponse.next_page_token](#ListSinkOperationsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSinkOperationsResponse.next_page_token](#ListSinkOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can be applied to the [operation.Operation.description](#Operation3), [operation.Operation.created_at](#Operation3), [operation.Operation.modified_at](#Operation3), [operation.Operation.created_by](#Operation3), [operation.Operation.done](#Operation3) fields. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Examples of a filter: `done=false`, `created_by='John.Doe'`. The maximum string length in characters is 1000.


### ListSinkOperationsResponse {#ListSinkOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified sink. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListOSinkperationsRequest.page_size], use `next_page_token` as the value for the [ListSinkOperationsRequest.page_token](#ListSinkOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


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

Lists existing access bindings for the specified sink.

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

Sets access bindings for the specified sink.

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

Updates access bindings for the specified sink.

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


