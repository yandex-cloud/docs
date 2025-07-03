---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Subtitle/create.md
---

# Video API, gRPC: SubtitleService.Create

Create a new subtitle.

## gRPC request

**rpc Create ([CreateSubtitleRequest](#yandex.cloud.video.v1.CreateSubtitleRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateSubtitleRequest {#yandex.cloud.video.v1.CreateSubtitleRequest}

```json
{
  "language": "string",
  "label": "string",
  // Includes only one of the fields `video_id`
  "video_id": "string",
  // end of the list of possible fields
  // Includes only one of the fields `upload`
  "upload": {
    "filename": "string"
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| language | **string**

Subtitle language represented as a three-letter code according to ISO 639-2/T. ||
|| label | **string**

Contains the subtitle label (or title) that will be displayed on screen during video playback.
Should provide a concise and accurate representation of the spoken content.
If not provided, it will be auto-generated based on the specified language. ||
|| video_id | **string**

ID of the video.

Includes only one of the fields `video_id`. ||
|| upload | **[SubtitleUploadParams](#yandex.cloud.video.v1.SubtitleUploadParams)**

Upload subtitle.

Includes only one of the fields `upload`.

Source type. ||
|#

## SubtitleUploadParams {#yandex.cloud.video.v1.SubtitleUploadParams}

#|
||Field | Description ||
|| filename | **string**

Required field.  ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "subtitle_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateSubtitleMetadata](#yandex.cloud.video.v1.CreateSubtitleMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Subtitle](#yandex.cloud.video.v1.Subtitle)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateSubtitleMetadata {#yandex.cloud.video.v1.CreateSubtitleMetadata}

#|
||Field | Description ||
|| subtitle_id | **string**

ID of the subtitle. ||
|#

## Subtitle {#yandex.cloud.video.v1.Subtitle}

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