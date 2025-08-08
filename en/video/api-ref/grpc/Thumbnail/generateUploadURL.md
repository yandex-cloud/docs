---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Thumbnail/generateUploadURL.md
---

# Video API, gRPC: ThumbnailService.GenerateUploadURL

Generates a URL for uploading an image to an existing thumbnail record.
This URL can be used to upload the actual image file using an HTTP PUT request.
The URL is pre-signed and has a limited validity period.

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

Required field. ID of the thumbnail for which to generate an upload URL.
The thumbnail record must already exist, typically created using the Create method. ||
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

Pre-signed URL for uploading the thumbnail image.
This URL can be used with an HTTP PUT request to upload the image file.
The URL has a limited validity period and will expire after a certain time. ||
|#