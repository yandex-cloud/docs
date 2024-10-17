---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Thumbnail/generateUploadURL.md
---

# Video API, gRPC: ThumbnailService.GenerateUploadURL {#GenerateUploadURL}

Generate url for upload image.

## gRPC request

**rpc GenerateUploadURL ([GenerateThumbnailUploadURLRequest](#yandex.cloud.video.v1.GenerateThumbnailUploadURLRequest)) returns ([GenerateThumbnailUploadURLResponse](#yandex.cloud.video.v1.GenerateThumbnailUploadURLResponse))**

## GenerateThumbnailUploadURLRequest {#yandex.cloud.video.v1.GenerateThumbnailUploadURLRequest}

```json
{
  "thumbnailId": "string"
}
```

#|
||Field | Description ||
|| thumbnailId | **string**

ID of the thumbnail. ||
|#

## GenerateThumbnailUploadURLResponse {#yandex.cloud.video.v1.GenerateThumbnailUploadURLResponse}

```json
{
  "uploadUrl": "string"
}
```

#|
||Field | Description ||
|| uploadUrl | **string**

Upload url. ||
|#