---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Subtitle/get.md
---

# Video API, gRPC: SubtitleService.Get

Return a specific subtitle.

## gRPC request

**rpc Get ([GetSubtitleRequest](#yandex.cloud.video.v1.GetSubtitleRequest)) returns ([Subtitle](#yandex.cloud.video.v1.Subtitle))**

## GetSubtitleRequest {#yandex.cloud.video.v1.GetSubtitleRequest}

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

## Subtitle {#yandex.cloud.video.v1.Subtitle}

```json
{
  "id": "string",
  "language": "string",
  "label": "string",
  "status": "SubtitleStatus",
  "filename": "string",
  "created_at": "google.protobuf.Timestamp",
  "updated_at": "google.protobuf.Timestamp",
  // Includes only one of the fields `video_id`
  "video_id": "string"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| id | **string**

ID of the subtitle. ||
|| language | **string**

Subtitle language represented as a three-letter ISO 639-3 code. ||
|| label | **string**

Subtitle caption to be displayed on screen during video playback. ||
|| status | enum **SubtitleStatus**

Subtitle status.

- `SUBTITLE_STATUS_UNSPECIFIED`: Subtitle status unspecified.
- `WAIT_UPLOADING`: Waiting for all the bytes to be loaded.
- `UPLOADED`: Uploading is complete. ||
|| filename | **string**

Subtitle filename. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when subtitle was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last subtitle update. ||
|| video_id | **string**

ID of the video.

Includes only one of the fields `video_id`. ||
|#