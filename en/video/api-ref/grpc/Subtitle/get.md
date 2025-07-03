---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Subtitle/get.md
---

# Video API, gRPC: SubtitleService.Get

Get a specific subtitle.

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
  "source_type": "SubtitleSourceType",
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

Subtitle language represented as a three-letter code according to ISO 639-2/T. ||
|| label | **string**

Subtitle caption to be displayed on screen during video playback. ||
|| status | enum **SubtitleStatus**

Subtitle status.

- `SUBTITLE_STATUS_UNSPECIFIED`: Subtitle status unspecified.
- `WAIT_UPLOADING`: Waiting for all the bytes to be loaded.
- `UPLOADED`: Uploading is complete. ||
|| source_type | enum **SubtitleSourceType**

Source type.

- `SUBTITLE_SOURCE_TYPE_UNSPECIFIED`: Subtitle source type unspecified.
- `MANUAL`: Manually uploaded subtitle.
- `GENERATED`: Automatically generated subtitle. ||
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