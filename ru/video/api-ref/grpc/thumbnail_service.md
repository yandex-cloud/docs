---
editable: false
sourcePath: en/_api-ref-grpc/video/api-ref/grpc/thumbnail_service.md
---

# Video API, gRPC: ThumbnailService

Thumbnail management service.

| Call | Description |
| --- | --- |
| [List](#List) | List thumbnails for channel. |
| [Create](#Create) | Create thumbnail. |
| [BatchGenerateDownloadURLs](#BatchGenerateDownloadURLs) | Generate urls for download images. |
| [GenerateUploadURL](#GenerateUploadURL) | Generate url for upload image. |

## Calls ThumbnailService {#calls}

## List {#List}

List thumbnails for channel.

**rpc List ([ListThumbnailRequest](#ListThumbnailRequest)) returns ([ListThumbnailResponse](#ListThumbnailResponse))**

### ListThumbnailRequest {#ListThumbnailRequest}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 
page_size | **int64**<br>The maximum number of the results per page to return. Default value: 100. 
page_token | **string**<br>Page token for getting the next page of the result. 


### ListThumbnailResponse {#ListThumbnailResponse}

Field | Description
--- | ---
thumbnails[] | **[Thumbnail](#Thumbnail)**<br>List of thumbnails. 
next_page_token | **string**<br>Token for getting the next page. 


### Thumbnail {#Thumbnail}

Field | Description
--- | ---
id | **string**<br>ID of the thumbnail. 
channel_id | **string**<br>ID of the channel where the thumbnail was created. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when thumbnail was created. 


## Create {#Create}

Create thumbnail.

**rpc Create ([CreateThumbnailRequest](#CreateThumbnailRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateThumbnailMetadata](#CreateThumbnailMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Thumbnail](#Thumbnail1)<br>

### CreateThumbnailRequest {#CreateThumbnailRequest}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateThumbnailMetadata](#CreateThumbnailMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Thumbnail](#Thumbnail1)>**<br>if operation finished successfully. 


### CreateThumbnailMetadata {#CreateThumbnailMetadata}

Field | Description
--- | ---
thumbnail_id | **string**<br>ID of the thumbnail. 


### Thumbnail {#Thumbnail1}

Field | Description
--- | ---
id | **string**<br>ID of the thumbnail. 
channel_id | **string**<br>ID of the channel where the thumbnail was created. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when thumbnail was created. 


## BatchGenerateDownloadURLs {#BatchGenerateDownloadURLs}

Generate urls for download images.

**rpc BatchGenerateDownloadURLs ([BatchGenerateDownloadURLsRequest](#BatchGenerateDownloadURLsRequest)) returns ([BatchGenerateDownloadURLsResponse](#BatchGenerateDownloadURLsResponse))**

### BatchGenerateDownloadURLsRequest {#BatchGenerateDownloadURLsRequest}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 
thumbnail_ids[] | **string**<br>List of thumbnails IDs. 


### BatchGenerateDownloadURLsResponse {#BatchGenerateDownloadURLsResponse}

Field | Description
--- | ---
download_urls[] | **[ThumbnailDownloadURL](#ThumbnailDownloadURL)**<br>List of download urls. 


### ThumbnailDownloadURL {#ThumbnailDownloadURL}

Field | Description
--- | ---
thumbnail_id | **string**<br>ID of the thumbnail. 
download_url | **string**<br>Download url. 


## GenerateUploadURL {#GenerateUploadURL}

Generate url for upload image.

**rpc GenerateUploadURL ([GenerateThumbnailUploadURLRequest](#GenerateThumbnailUploadURLRequest)) returns ([GenerateThumbnailUploadURLResponse](#GenerateThumbnailUploadURLResponse))**

### GenerateThumbnailUploadURLRequest {#GenerateThumbnailUploadURLRequest}

Field | Description
--- | ---
thumbnail_id | **string**<br>ID of the thumbnail. 


### GenerateThumbnailUploadURLResponse {#GenerateThumbnailUploadURLResponse}

Field | Description
--- | ---
upload_url | **string**<br>Upload url. 


