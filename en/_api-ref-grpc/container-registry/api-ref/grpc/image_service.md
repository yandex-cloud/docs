---
editable: false
---

# ImageService

A set of methods for managing Image resources.

| Call | Description |
| --- | --- |
| [List](#List) | Retrieves the list of Image resources in the specified registry or repository. |
| [Get](#Get) | Returns the specified Image resource. |
| [Delete](#Delete) | Deletes the specified Docker image. |

## Calls ImageService {#calls}

## List {#List}

Retrieves the list of Image resources in the specified registry or repository.

**rpc List ([ListImagesRequest](#ListImagesRequest)) returns ([ListImagesResponse](#ListImagesResponse))**

### ListImagesRequest {#ListImagesRequest}

Field | Description
--- | ---
registry_id | **string**<br>ID of the registry to list Docker images in. <br>`registry_id` is ignored if a [ListImagesRequest.repository_name](#ListImagesRequest) is specified in the request. <br>To get the registry ID use a [RegistryService.List](./registry_service#List) request. The maximum string length in characters is 50.
repository_name | **string**<br>Name of the repository to list Docker images in. <br>To get the repository name use a [RepositoryService.List](./repository_service#List) request. Value must match the regular expression ` \|[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* `.
folder_id | **string**<br>ID of the folder to list Docker images in. <br>`folder_id` is ignored if a [ListImagesRequest.repository_name](#ListImagesRequest) or a [ListImagesRequest.registry_id](#ListImagesRequest) are specified in the request. <br>To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListImagesResponse.next_page_token](#ListImagesResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListImagesResponse.next_page_token](#ListImagesResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on [Image.name](#Image) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be a maximum of 256 characters long and match the regular expression `[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))`.</li></ol> The maximum string length in characters is 1000.
order_by | **string**<br> The maximum string length in characters is 100.


### ListImagesResponse {#ListImagesResponse}

Field | Description
--- | ---
images[] | **[Image](#Image)**<br>List of Image resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListImagesRequest.page_size](#ListImagesRequest), use the `next_page_token` as the value for the [ListImagesRequest.page_token](#ListImagesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Image {#Image}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the Docker image. 
name | **string**<br>Name of the Docker image. The name is unique within the registry. 
digest | **string**<br>Content-addressable identifier of the Docker image. 
compressed_size | **int64**<br>Compressed size of the Docker image, specified in bytes. 
config | **[Blob](#Blob)**<br>Configuration of the Docker image. 
layers[] | **[Blob](#Blob)**<br>Layers of the Docker image. 
tags[] | **string**<br>Tags of the Docker image. <br>Each tag is unique within the repository. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 


### Blob {#Blob}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the blob. 
digest | **string**<br>Content-addressable identifier of the blob. 
size | **int64**<br>Size of the blob, specified in bytes. 
urls[] | **string**<br>List of blob urls. 


## Get {#Get}

Returns the specified Image resource. <br>To get the list of available Image resources, make a [List](#List) request.

**rpc Get ([GetImageRequest](#GetImageRequest)) returns ([Image](#Image1))**

### GetImageRequest {#GetImageRequest}

Field | Description
--- | ---
image_id | **string**<br>Required. ID of the Docker image resource to return. <br>To get the Docker image ID use a [ImageService.List](#List) request. The maximum string length in characters is 50.


### Image {#Image1}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the Docker image. 
name | **string**<br>Name of the Docker image. The name is unique within the registry. 
digest | **string**<br>Content-addressable identifier of the Docker image. 
compressed_size | **int64**<br>Compressed size of the Docker image, specified in bytes. 
config | **[Blob](#Blob1)**<br>Configuration of the Docker image. 
layers[] | **[Blob](#Blob1)**<br>Layers of the Docker image. 
tags[] | **string**<br>Tags of the Docker image. <br>Each tag is unique within the repository. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 


### Blob {#Blob1}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the blob. 
digest | **string**<br>Content-addressable identifier of the blob. 
size | **int64**<br>Size of the blob, specified in bytes. 
urls[] | **string**<br>List of blob urls. 


## Delete {#Delete}

Deletes the specified Docker image.

**rpc Delete ([DeleteImageRequest](#DeleteImageRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteImageMetadata](#DeleteImageMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteImageRequest {#DeleteImageRequest}

Field | Description
--- | ---
image_id | **string**<br>Required. ID of the Docker image to delete. <br>To get Docker image ID use a [ImageService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteImageMetadata](#DeleteImageMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteImageMetadata {#DeleteImageMetadata}

Field | Description
--- | ---
image_id | **string**<br>ID of the Docker image that is being deleted. 


