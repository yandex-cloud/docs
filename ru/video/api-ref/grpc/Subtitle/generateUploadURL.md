---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Subtitle/generateUploadURL.md
---

# Video API, gRPC: SubtitleService.GenerateUploadURL

Generate an upload URL to add a new subtitle file.

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

Required field. ID of the subtitle. ||
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

Upload url. ||
|#