---
editable: false
sourcePath: en/_api-ref-grpc/logging/api-ref/grpc/export_service.md
---

# Cloud Logging Service, gRPC: ExportService

A set of methods for managing log exports.

| Call | Description |
| --- | --- |
| [Run](#Run) | Run new logs export from log group to sink |
| [Get](#Get) | Returns the specified export. |
| [List](#List) | Retrieves the list of exports in the specified folder. |
| [Create](#Create) | Creates a export in the specified folder. |
| [Update](#Update) | Updates the specified export. |
| [Delete](#Delete) | Deletes the specified export. |
| [ListOperations](#ListOperations) | Lists operations for the specified export. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified export. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the specified export. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified export. |

## Calls ExportService {#calls}

## Run {#Run}

Run new logs export from log group to sink

**rpc Run ([RunExportRequest](#RunExportRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RunExportMetadata](#RunExportMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[RunExportDetails](#RunExportDetails)<br>

### RunExportRequest {#RunExportRequest}

Field | Description
--- | ---
group_id | **string**<br>Required.  The maximum string length in characters is 64.
sink_id | **string**<br>Required.  The maximum string length in characters is 64.
params | **[ExportParams](#ExportParams)**<br>Required.  
result_filename | **string**<br>Required.  
since | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required.  
until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required.  


### ExportParams {#ExportParams}

Field | Description
--- | ---
resource_types[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
resource_ids[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
stream_names[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
levels[] | **[LogLevel.Level](#LogLevel)**<br> The maximum number of elements is 10.
filter | **string**<br> The maximum string length in characters is 1000.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RunExportMetadata](#RunExportMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RunExportDetails](#RunExportDetails)>**<br>if operation finished successfully. 


### RunExportMetadata {#RunExportMetadata}

Field | Description
--- | ---
group_id | **string**<br> 
sink_id | **string**<br> 
result_filename | **string**<br> 


### RunExportDetails {#RunExportDetails}

Field | Description
--- | ---
group_id | **string**<br> 
sink_id | **string**<br> 
params | **[ExportParams](#ExportParams1)**<br> 
result_filename | **string**<br> 
since | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Get {#Get}

Returns the specified export. <br>To get the list of all available exports, make a [List](#List) request.

**rpc Get ([GetExportRequest](#GetExportRequest)) returns ([Export](#Export))**

### GetExportRequest {#GetExportRequest}

Field | Description
--- | ---
export_id | **string**<br>Required. ID of the export to return. <br>To get a export ID make a [ExportService.List](#List) request. The maximum string length in characters is 64.


### Export {#Export}

Field | Description
--- | ---
id | **string**<br>Export ID. 
folder_id | **string**<br>Export folder ID. 
cloud_id | **string**<br>Export cloud ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Export creation time. 
name | **string**<br>Export name. 
description | **string**<br>Export description. 
labels | **map<string,string>**<br>Export lables. 
group_id | **string**<br>Group logs are exported from. 
sink_id | **string**<br>Sink logs are exported to. 
params | **[ExportParams](#ExportParams1)**<br>Parameters of logs filtration. 


### ExportParams {#ExportParams1}

Field | Description
--- | ---
resource_types[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
resource_ids[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
stream_names[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
levels[] | **[LogLevel.Level](#LogLevel)**<br> The maximum number of elements is 10.
filter | **string**<br> The maximum string length in characters is 1000.


## List {#List}

Retrieves the list of exports in the specified folder.

**rpc List ([ListExportsRequest](#ListExportsRequest)) returns ([ListExportsResponse](#ListExportsResponse))**

### ListExportsRequest {#ListExportsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID of the exports to return. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 64.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListExportssResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListExportsResponse.next_page_token](#ListExportsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters exports listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can only be applied to the [Export.name](#Export1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name="my-export"`. The maximum string length in characters is 1000.


### ListExportsResponse {#ListExportsResponse}

Field | Description
--- | ---
exports[] | **[Export](#Export1)**<br>List of exports in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListExportsRequest.page_size](#ListExportsRequest), use `next_page_token` as the value for the [ListExportsRequest.page_token](#ListExportsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Export {#Export1}

Field | Description
--- | ---
id | **string**<br>Export ID. 
folder_id | **string**<br>Export folder ID. 
cloud_id | **string**<br>Export cloud ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Export creation time. 
name | **string**<br>Export name. 
description | **string**<br>Export description. 
labels | **map<string,string>**<br>Export lables. 
group_id | **string**<br>Group logs are exported from. 
sink_id | **string**<br>Sink logs are exported to. 
params | **[ExportParams](#ExportParams2)**<br>Parameters of logs filtration. 


### ExportParams {#ExportParams2}

Field | Description
--- | ---
resource_types[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
resource_ids[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
stream_names[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
levels[] | **[LogLevel.Level](#LogLevel)**<br> The maximum number of elements is 10.
filter | **string**<br> The maximum string length in characters is 1000.


## Create {#Create}

Creates a export in the specified folder.

**rpc Create ([CreateExportRequest](#CreateExportRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateExportMetadata](#CreateExportMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Export](#Export2)<br>

### CreateExportRequest {#CreateExportRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a export in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 64.
name | **string**<br>Name of the export. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the export. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Export labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
group_id | **string**<br>Required. Logging Group ID logs exported from The maximum string length in characters is 64.
sink_id | **string**<br>Required. Logging Sink ID logs exported to The maximum string length in characters is 64.
params | **[ExportParams](#ExportParams3)**<br>Required. Parameters for logs filtration 


### ExportParams {#ExportParams3}

Field | Description
--- | ---
resource_types[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
resource_ids[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
stream_names[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
levels[] | **[LogLevel.Level](#LogLevel)**<br> The maximum number of elements is 10.
filter | **string**<br> The maximum string length in characters is 1000.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateExportMetadata](#CreateExportMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Export](#Export2)>**<br>if operation finished successfully. 


### CreateExportMetadata {#CreateExportMetadata}

Field | Description
--- | ---
export_id | **string**<br>ID of the export being created. 


### Export {#Export2}

Field | Description
--- | ---
id | **string**<br>Export ID. 
folder_id | **string**<br>Export folder ID. 
cloud_id | **string**<br>Export cloud ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Export creation time. 
name | **string**<br>Export name. 
description | **string**<br>Export description. 
labels | **map<string,string>**<br>Export lables. 
group_id | **string**<br>Group logs are exported from. 
sink_id | **string**<br>Sink logs are exported to. 
params | **[ExportParams](#ExportParams4)**<br>Parameters of logs filtration. 


## Update {#Update}

Updates the specified export.

**rpc Update ([UpdateExportRequest](#UpdateExportRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateExportMetadata](#UpdateExportMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Export](#Export3)<br>

### UpdateExportRequest {#UpdateExportRequest}

Field | Description
--- | ---
export_id | **string**<br>Required. ID of the export to update. <br>To get a export ID make a [ExportService.List](#List) request. The maximum string length in characters is 64.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the function should be updated. 
name | **string**<br>New name of the export. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>New Description of the export. The maximum string length in characters is 256.
labels | **map<string,string>**<br>New export labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
group_id | **string**<br>Required. New logging Group ID logs exported from The maximum string length in characters is 64.
sink_id | **string**<br>Required. New logging Sink ID logs exported to The maximum string length in characters is 64.
params | **[ExportParams](#ExportParams4)**<br>Required. New parameters for logs filtration 


### ExportParams {#ExportParams4}

Field | Description
--- | ---
resource_types[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
resource_ids[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
stream_names[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
levels[] | **[LogLevel.Level](#LogLevel)**<br> The maximum number of elements is 10.
filter | **string**<br> The maximum string length in characters is 1000.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateExportMetadata](#UpdateExportMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Export](#Export3)>**<br>if operation finished successfully. 


### UpdateExportMetadata {#UpdateExportMetadata}

Field | Description
--- | ---
export_id | **string**<br>ID of the export being updated. 


### Export {#Export3}

Field | Description
--- | ---
id | **string**<br>Export ID. 
folder_id | **string**<br>Export folder ID. 
cloud_id | **string**<br>Export cloud ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Export creation time. 
name | **string**<br>Export name. 
description | **string**<br>Export description. 
labels | **map<string,string>**<br>Export lables. 
group_id | **string**<br>Group logs are exported from. 
sink_id | **string**<br>Sink logs are exported to. 
params | **[ExportParams](#ExportParams5)**<br>Parameters of logs filtration. 


## Delete {#Delete}

Deletes the specified export.

**rpc Delete ([DeleteExportRequest](#DeleteExportRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteExportMetadata](#DeleteExportMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteExportRequest {#DeleteExportRequest}

Field | Description
--- | ---
export_id | **string**<br>Required. ID of the export to delete. <br>To get a export ID make a [ExportService.List](#List) request. The maximum string length in characters is 64.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteExportMetadata](#DeleteExportMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteExportMetadata {#DeleteExportMetadata}

Field | Description
--- | ---
export_id | **string**<br>ID of the export being deleted. 


## ListOperations {#ListOperations}

Lists operations for the specified export.

**rpc ListOperations ([ListExportOperationsRequest](#ListExportOperationsRequest)) returns ([ListExportOperationsResponse](#ListExportOperationsResponse))**

### ListExportOperationsRequest {#ListExportOperationsRequest}

Field | Description
--- | ---
export_id | **string**<br>Required. ID of the export to list operations for. <br>To get a export ID make a [ExportService.List](#List) request. The maximum string length in characters is 64.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListExportOperationsResponse.next_page_token](#ListExportOperationsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListExportOperationsResponse.next_page_token](#ListExportOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can be applied to the [operation.Operation.description](#Operation4), [operation.Operation.created_at](#Operation4), [operation.Operation.modified_at](#Operation4), [operation.Operation.created_by](#Operation4), [operation.Operation.done](#Operation4) fields. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Examples of a filter: `done=false`, `created_by='John.Doe'`. The maximum string length in characters is 1000.


### ListExportOperationsResponse {#ListExportOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation4)**<br>List of operations for the specified export. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListOExportperationsRequest.page_size], use `next_page_token` as the value for the [ListExportOperationsRequest.page_token](#ListExportOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation4}

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

Lists existing access bindings for the specified export.

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

Sets access bindings for the specified export.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation5))**

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


### Operation {#Operation5}

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

Updates access bindings for the specified export.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation6))**

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


### Operation {#Operation6}

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


