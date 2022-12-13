---
editable: false
---

# Compute Cloud API, gRPC: FilesystemService

A set of methods for managing filesystems.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified filesystem. |
| [List](#List) | Lists filesystems in the specified folder. |
| [Create](#Create) | Creates a filesystem in the specified folder. |
| [Update](#Update) | Updates the specified filesystem. |
| [Delete](#Delete) | Deletes the specified filesystem. |
| [ListOperations](#ListOperations) | Lists operations for the specified filesystem. |

## Calls FilesystemService {#calls}

## Get {#Get}

Returns the specified filesystem. <br>To get the list of available filesystems, make a [List](#List) request.

**rpc Get ([GetFilesystemRequest](#GetFilesystemRequest)) returns ([Filesystem](#Filesystem))**

### GetFilesystemRequest {#GetFilesystemRequest}

Field | Description
--- | ---
filesystem_id | **string**<br>Required. ID of the filesystem to return. <br>To get the filesystem ID, make a [FilesystemService.List](#List) request. The maximum string length in characters is 50.


### Filesystem {#Filesystem}

Field | Description
--- | ---
id | **string**<br>ID of the filesystem. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the filesystem belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the filesystem. The name is unique within the folder. 
description | **string**<br>Description of the filesystem. 
labels | **map<string,string>**<br>Filesystem labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
type_id | **string**<br>ID of the filesystem type. <br>To get a list of available filesystem types, make a [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/grpc/disk_type_service#List) request. 
zone_id | **string**<br>ID of the availability zone where the filesystem resides. <br>A filesystem can be attached only to instances residing in the same availability zone. 
size | **int64**<br>Size of the filesystem, specified in bytes. 
block_size | **int64**<br>Block size used for the filesystem, specified in bytes. 
status | enum **Status**<br>Current status of the filesystem. <ul><li>`CREATING`: The filesystem is being created.</li><li>`READY`: The filesystem is ready to use.</li><li>`ERROR`: The filesystem encountered a problem and cannot operate.</li><li>`DELETING`: The filesystem is being deleted.</li></ul>


## List {#List}

Lists filesystems in the specified folder.

**rpc List ([ListFilesystemsRequest](#ListFilesystemsRequest)) returns ([ListFilesystemsResponse](#ListFilesystemsResponse))**

### ListFilesystemsRequest {#ListFilesystemsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list filesystems in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListFilesystemsResponse.next_page_token](#ListFilesystemsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListFilesystemsResponse.next_page_token](#ListFilesystemsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters filesystems listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering only on the [Filesystem.name](#Filesystem1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z]([-a-z0-9]{,61}[a-z0-9])?`. </li></ol>Example of a filter: `name=my-filesystem`. 


### ListFilesystemsResponse {#ListFilesystemsResponse}

Field | Description
--- | ---
filesystems[] | **[Filesystem](#Filesystem1)**<br>List of filesystems in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListFilesystemsRequest.page_size](#ListFilesystemsRequest), use `next_page_token` as the value for the [ListFilesystemsRequest.page_token](#ListFilesystemsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Filesystem {#Filesystem1}

Field | Description
--- | ---
id | **string**<br>ID of the filesystem. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the filesystem belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the filesystem. The name is unique within the folder. 
description | **string**<br>Description of the filesystem. 
labels | **map<string,string>**<br>Filesystem labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
type_id | **string**<br>ID of the filesystem type. <br>To get a list of available filesystem types, make a [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/grpc/disk_type_service#List) request. 
zone_id | **string**<br>ID of the availability zone where the filesystem resides. <br>A filesystem can be attached only to instances residing in the same availability zone. 
size | **int64**<br>Size of the filesystem, specified in bytes. 
block_size | **int64**<br>Block size used for the filesystem, specified in bytes. 
status | enum **Status**<br>Current status of the filesystem. <ul><li>`CREATING`: The filesystem is being created.</li><li>`READY`: The filesystem is ready to use.</li><li>`ERROR`: The filesystem encountered a problem and cannot operate.</li><li>`DELETING`: The filesystem is being deleted.</li></ul>


## Create {#Create}

Creates a filesystem in the specified folder.

**rpc Create ([CreateFilesystemRequest](#CreateFilesystemRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateFilesystemMetadata](#CreateFilesystemMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Filesystem](#Filesystem2)<br>

### CreateFilesystemRequest {#CreateFilesystemRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a filesystem in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the filesystem. The name must be unique within the folder. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the filesystem. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Filesystem labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
type_id | **string**<br>ID of the filesystem type. <br>To get a list of available filesystem types, make a [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/grpc/disk_type_service#List) request. <br>The filesystem type cannot be updated after the filesystem creation. The maximum string length in characters is 50.
zone_id | **string**<br>Required. ID of the availability zone where the filesystem resides. <br>To get a list of available zones, make a [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. <br>A filesystem can be attached only to virtual machines residing in the same availability zone. The filesystem availability zone cannot be updated after the filesystem creation. The maximum string length in characters is 50.
size | **int64**<br>Required. Size of the filesystem, specified in bytes. <br>The size of the filesystem cannot be updated after the filesystem creation. 
block_size | **int64**<br>Block size used for the filesystem, specified in bytes. <br>The block size cannot be updated after the filesystem creation. <br>Default value: 4096. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateFilesystemMetadata](#CreateFilesystemMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Filesystem](#Filesystem2)>**<br>if operation finished successfully. 


### CreateFilesystemMetadata {#CreateFilesystemMetadata}

Field | Description
--- | ---
filesystem_id | **string**<br>ID of the filesystem that is being created. 


### Filesystem {#Filesystem2}

Field | Description
--- | ---
id | **string**<br>ID of the filesystem. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the filesystem belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the filesystem. The name is unique within the folder. 
description | **string**<br>Description of the filesystem. 
labels | **map<string,string>**<br>Filesystem labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
type_id | **string**<br>ID of the filesystem type. <br>To get a list of available filesystem types, make a [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/grpc/disk_type_service#List) request. 
zone_id | **string**<br>ID of the availability zone where the filesystem resides. <br>A filesystem can be attached only to instances residing in the same availability zone. 
size | **int64**<br>Size of the filesystem, specified in bytes. 
block_size | **int64**<br>Block size used for the filesystem, specified in bytes. 
status | enum **Status**<br>Current status of the filesystem. <ul><li>`CREATING`: The filesystem is being created.</li><li>`READY`: The filesystem is ready to use.</li><li>`ERROR`: The filesystem encountered a problem and cannot operate.</li><li>`DELETING`: The filesystem is being deleted.</li></ul>


## Update {#Update}

Updates the specified filesystem.

**rpc Update ([UpdateFilesystemRequest](#UpdateFilesystemRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateFilesystemMetadata](#UpdateFilesystemMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Filesystem](#Filesystem3)<br>

### UpdateFilesystemRequest {#UpdateFilesystemRequest}

Field | Description
--- | ---
filesystem_id | **string**<br>Required. ID of the filesystem to update. <br>To get the filesystem ID, make a [FilesystemService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the filesystem should be updated. 
name | **string**<br>New name of the filesystem. The name must be unique within the folder. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>New description of the filesystem. The maximum string length in characters is 256.
labels | **map<string,string>**<br>New filesystem labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). <br>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: <ol><li>Get the current set of labels with a [FilesystemService.Get](#Get) request. </li><li>Add or remove a label in this set. </li><li>Send the new set in this field.</li></ol> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
size | **int64**<br>Size of the filesystem, specified in bytes. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateFilesystemMetadata](#UpdateFilesystemMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Filesystem](#Filesystem3)>**<br>if operation finished successfully. 


### UpdateFilesystemMetadata {#UpdateFilesystemMetadata}

Field | Description
--- | ---
filesystem_id | **string**<br>ID of the filesystem that is being updated. 


### Filesystem {#Filesystem3}

Field | Description
--- | ---
id | **string**<br>ID of the filesystem. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the filesystem belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the filesystem. The name is unique within the folder. 
description | **string**<br>Description of the filesystem. 
labels | **map<string,string>**<br>Filesystem labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
type_id | **string**<br>ID of the filesystem type. <br>To get a list of available filesystem types, make a [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/grpc/disk_type_service#List) request. 
zone_id | **string**<br>ID of the availability zone where the filesystem resides. <br>A filesystem can be attached only to instances residing in the same availability zone. 
size | **int64**<br>Size of the filesystem, specified in bytes. 
block_size | **int64**<br>Block size used for the filesystem, specified in bytes. 
status | enum **Status**<br>Current status of the filesystem. <ul><li>`CREATING`: The filesystem is being created.</li><li>`READY`: The filesystem is ready to use.</li><li>`ERROR`: The filesystem encountered a problem and cannot operate.</li><li>`DELETING`: The filesystem is being deleted.</li></ul>


## Delete {#Delete}

Deletes the specified filesystem. <br>Deleting a filesystem removes its data permanently and is irreversible. <br>It is not possible to delete a filesystem that is attached to an instance.

**rpc Delete ([DeleteFilesystemRequest](#DeleteFilesystemRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteFilesystemMetadata](#DeleteFilesystemMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteFilesystemRequest {#DeleteFilesystemRequest}

Field | Description
--- | ---
filesystem_id | **string**<br>Required. ID of the filesystem to delete. <br>To get the filesystem ID, make a [FilesystemService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteFilesystemMetadata](#DeleteFilesystemMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteFilesystemMetadata {#DeleteFilesystemMetadata}

Field | Description
--- | ---
filesystem_id | **string**<br>ID of the filesystem that is being deleted. 


## ListOperations {#ListOperations}

Lists operations for the specified filesystem.

**rpc ListOperations ([ListFilesystemOperationsRequest](#ListFilesystemOperationsRequest)) returns ([ListFilesystemOperationsResponse](#ListFilesystemOperationsResponse))**

### ListFilesystemOperationsRequest {#ListFilesystemOperationsRequest}

Field | Description
--- | ---
filesystem_id | **string**<br>Required. ID of the filesystem to list operations for. <br>To get the filesystem ID, make a [FilesystemService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListFilesystemOperationsResponse.next_page_token](#ListFilesystemOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListFilesystemOperationsResponse.next_page_token](#ListFilesystemOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListFilesystemOperationsResponse {#ListFilesystemOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified filesystem. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListFilesystemOperationsRequest.page_size](#ListFilesystemOperationsRequest), use `next_page_token` as the value for the [ListFilesystemOperationsRequest.page_token](#ListFilesystemOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


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


