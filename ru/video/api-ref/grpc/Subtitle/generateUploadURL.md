---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Subtitle/generateUploadURL.md
---

# Video API, gRPC: SubtitleService.GenerateUploadURL

Generates a URL for uploading a subtitle file to an existing subtitle record.
This URL can be used to upload the actual subtitle file using an HTTP PUT request.
The URL is pre-signed and has a limited validity period.

## gRPC request

**rpc GenerateUploadURL ([GenerateSubtitleUploadURLRequest](#yandex.cloud.video.v1.GenerateSubtitleUploadURLRequest)) returns ([GenerateSubtitleUploadURLResponse](#yandex.cloud.video.v1.GenerateSubtitleUploadURLResponse))**

## GenerateSubtitleUploadURLRequest {#yandex.cloud.video.v1.GenerateSubtitleUploadURLRequest}

```json
{
  "subtitle_id": "string"
}
```

#|
||Field | Description ||
|| subtitle_id | **string**

Required field. ID of the subtitle for which to generate an upload URL. ||
|#

## GenerateSubtitleUploadURLResponse {#yandex.cloud.video.v1.GenerateSubtitleUploadURLResponse}

```json
{
  "upload_url": "string"
}
```

#|
||Field | Description ||
|| upload_url | **string**

Pre-signed URL for uploading the subtitle file.
This URL can be used with an HTTP PUT request to upload the subtitle file.
The URL has a limited validity period and will expire after a certain time. ||
|#