---
editable: false
sourcePath: en/_api-ref-grpc/ai/files/v1/files/api-ref/grpc/File/getUrl.md
---

# Files API, gRPC: FileService.GetUrl {#GetUrl}

Retrieve a URL for accessing or downloading a specific file.

## gRPC request

**rpc GetUrl ([GetFileUrlRequest](#yandex.cloud.ai.files.v1.GetFileUrlRequest)) returns ([GetFileUrlResponse](#yandex.cloud.ai.files.v1.GetFileUrlResponse))**

## GetFileUrlRequest {#yandex.cloud.ai.files.v1.GetFileUrlRequest}

```json
{
  "fileId": "string"
}
```

Request message for retrieving the URL of a specific file.

#|
||Field | Description ||
|| fileId | **string**

Required field. ID of the file which the URL is requested. ||
|#

## GetFileUrlResponse {#yandex.cloud.ai.files.v1.GetFileUrlResponse}

```json
{
  "url": "string"
}
```

Response message containing the URL to access the requested file.

#|
||Field | Description ||
|| url | **string**

URL that can be used to access or download the file. ||
|#