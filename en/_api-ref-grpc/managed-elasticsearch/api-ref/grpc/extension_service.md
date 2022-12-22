---
editable: false
---

# Managed Service for Elasticsearch API, gRPC: ExtensionService



| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified extension of Elasticsearch cluster. |
| [List](#List) | Returns the list of available extensions for the specified Elasticsearch cluster. |
| [Create](#Create) | Creates new extension version. |
| [Update](#Update) | Updates the specified extension. |
| [Delete](#Delete) | Deletes the specified extension. |

## Calls ExtensionService {#calls}

## Get {#Get}

Returns the specified extension of Elasticsearch cluster.

**rpc Get ([GetExtensionRequest](#GetExtensionRequest)) returns ([Extension](#Extension))**

### GetExtensionRequest {#GetExtensionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster. The maximum string length in characters is 50.
extension_id | **string**<br>Required. ID of the extension to return. 


### Extension {#Extension}

Field | Description
--- | ---
name | **string**<br>Name of the extension. 
id | **string**<br>Unique ID of the extension. 
cluster_id | **string**<br>ID of the Elasticsearch cluster the extension belongs to. 
version | **int64**<br>Version of the extension. 
active | **bool**<br>The flag shows whether the extension is active. 


## List {#List}

Returns the list of available extensions for the specified Elasticsearch cluster.

**rpc List ([ListExtensionsRequest](#ListExtensionsRequest)) returns ([ListExtensionsResponse](#ListExtensionsResponse))**

### ListExtensionsRequest {#ListExtensionsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to list extensions in. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the API returns a [ListExtensionsResponse.next_page_token](#ListExtensionsResponse) that can be used to get the next page of results in subsequent [ExtensionService.List](#List) requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token that can be used to iterate through multiple pages of results. <br>To get the next page of results, set `page_token` to the [ListExtensionsResponse.next_page_token](#ListExtensionsResponse) returned by the previous [ExtensionService.List](#List) request. The maximum string length in characters is 100.


### ListExtensionsResponse {#ListExtensionsResponse}

Field | Description
--- | ---
extensions[] | **[Extension](#Extension1)**<br>Requested list of extensions. 
next_page_token | **string**<br>The token that can be used to get the next page of results. <br>If the number of results is larger than [ListExtensionsRequest.page_size](#ListExtensionsRequest), use the `next_page_token` as the value for the [ListExtensionsRequest.page_token](#ListExtensionsRequest) in the subsequent [ExtensionService.List](#List) request to iterate through multiple pages of results. <br>Each of the subsequent [ExtensionService.List](#List) requests should use the `next_page_token` value returned in the previous request to continue paging through the results. 


### Extension {#Extension1}

Field | Description
--- | ---
name | **string**<br>Name of the extension. 
id | **string**<br>Unique ID of the extension. 
cluster_id | **string**<br>ID of the Elasticsearch cluster the extension belongs to. 
version | **int64**<br>Version of the extension. 
active | **bool**<br>The flag shows whether the extension is active. 


## Create {#Create}

Creates new extension version.

**rpc Create ([CreateExtensionRequest](#CreateExtensionRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateExtensionMetadata](#CreateExtensionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Extension](#Extension2)<br>

### CreateExtensionRequest {#CreateExtensionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the extension. The maximum string length in characters is 50.
uri | **string**<br>Required. URI of the zip archive to create the new extension from. Currently only supports links that are stored in Object Storage. 
disabled | **bool**<br>The flag that disables the extension. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateExtensionMetadata](#CreateExtensionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Extension](#Extension2)>**<br>if operation finished successfully. 


### CreateExtensionMetadata {#CreateExtensionMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster. The maximum string length in characters is 50.
extension_id | **string**<br>Required. ID of the extension. 


### Extension {#Extension2}

Field | Description
--- | ---
name | **string**<br>Name of the extension. 
id | **string**<br>Unique ID of the extension. 
cluster_id | **string**<br>ID of the Elasticsearch cluster the extension belongs to. 
version | **int64**<br>Version of the extension. 
active | **bool**<br>The flag shows whether the extension is active. 


## Update {#Update}

Updates the specified extension.

**rpc Update ([UpdateExtensionRequest](#UpdateExtensionRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateExtensionMetadata](#UpdateExtensionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Extension](#Extension3)<br>

### UpdateExtensionRequest {#UpdateExtensionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster. The maximum string length in characters is 50.
extension_id | **string**<br>Required. ID of the extension to update. 
active | **bool**<br>The flag shows whether to make the extension active. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateExtensionMetadata](#UpdateExtensionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Extension](#Extension3)>**<br>if operation finished successfully. 


### UpdateExtensionMetadata {#UpdateExtensionMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster. The maximum string length in characters is 50.
extension_id | **string**<br>Required. ID of the extension. 


### Extension {#Extension3}

Field | Description
--- | ---
name | **string**<br>Name of the extension. 
id | **string**<br>Unique ID of the extension. 
cluster_id | **string**<br>ID of the Elasticsearch cluster the extension belongs to. 
version | **int64**<br>Version of the extension. 
active | **bool**<br>The flag shows whether the extension is active. 


## Delete {#Delete}

Deletes the specified extension.

**rpc Delete ([DeleteExtensionRequest](#DeleteExtensionRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteExtensionMetadata](#DeleteExtensionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteExtensionRequest {#DeleteExtensionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster. The maximum string length in characters is 50.
extension_id | **string**<br>Required. ID of the extension to delete. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteExtensionMetadata](#DeleteExtensionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteExtensionMetadata {#DeleteExtensionMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster. The maximum string length in characters is 50.
extension_id | **string**<br>Required. ID of the extension to delete. 


