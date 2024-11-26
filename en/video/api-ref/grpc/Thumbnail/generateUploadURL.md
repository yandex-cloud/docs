---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Thumbnail/generateUploadURL.md
---

# Video API, gRPC: ThumbnailService.GenerateUploadURL

Generate url for upload image.

## gRPC request

**rpc GenerateUploadURL ([GenerateThumbnailUploadURLRequest](#yandex.cloud.video.v1.GenerateThumbnailUploadURLRequest)) returns ([GenerateThumbnailUploadURLResponse](#yandex.cloud.video.v1.GenerateThumbnailUploadURLResponse))**

## GenerateThumbnailUploadURLRequest {#yandex.cloud.video.v1.GenerateThumbnailUploadURLRequest}

```json
{
  "thumbnail_id": "string"
}
```

#|
||Field | Description ||
|| thumbnail_id | **string**

Required field. ID of the thumbnail. ||
|#

## GenerateThumbnailUploadURLResponse {#yandex.cloud.video.v1.GenerateThumbnailUploadURLResponse}

```json
{
  "upload_url": "string"
}
```

#|
||Field | Description ||
|| upload_url | **string**

Upload url. ||
|#