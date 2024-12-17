---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Video/transcode.md
---

# Video API, gRPC: VideoService.Transcode

Transcode video.

## gRPC request

**rpc Transcode ([TranscodeVideoRequest](#yandex.cloud.video.v1.TranscodeVideoRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## TranscodeVideoRequest {#yandex.cloud.video.v1.TranscodeVideoRequest}

```json
{
  "video_id": "string",
  "field_mask": "google.protobuf.FieldMask",
  "subtitle_ids": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| video_id | **string**

ID of the video. ||
|| field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which transcoding specific fields of the video
are going to be updated. ||
|| subtitle_ids[] | **string**

IDs of active video subtitles. ||
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
    "video_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "channel_id": "string",
    "title": "string",
    "description": "string",
    "thumbnail_id": "string",
    "status": "VideoStatus",
    "duration": "google.protobuf.Duration",
    "visibility_status": "VisibilityStatus",
    "auto_transcode": "AutoTranscode",
    "subtitle_ids": [
      "string"
    ],
    // Includes only one of the fields `tusd`
    "tusd": {
      "url": "string"
    },
    // end of the list of possible fields
    // Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`
    "public_access": "VideoPublicAccessRights",
    "auth_system_access": "VideoAuthSystemAccessRights",
    "sign_url_access": "VideoSignURLAccessRights",
    // end of the list of possible fields
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp",
    "labels": "map<string, string>"
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
|| metadata | **[TranscodeVideoMetadata](#yandex.cloud.video.v1.TranscodeVideoMetadata)**

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
|| response | **[Video](#yandex.cloud.video.v1.Video)**

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

## TranscodeVideoMetadata {#yandex.cloud.video.v1.TranscodeVideoMetadata}

#|
||Field | Description ||
|| video_id | **string**

ID of the video. ||
|#

## Video {#yandex.cloud.video.v1.Video}

#|
||Field | Description ||
|| id | **string**

ID of the video. ||
|| channel_id | **string**

ID of the channel where the video was created. ||
|| title | **string**

Video title. ||
|| description | **string**

Video description. ||
|| thumbnail_id | **string**

ID of the thumbnail. ||
|| status | enum **VideoStatus**

Video status.

- `VIDEO_STATUS_UNSPECIFIED`: Video status unspecified.
- `WAIT_UPLOADING`: Waiting for the whole number of bytes to be loaded.
- `PROCESSING`: Video processing.
- `READY`: Video is ready, processing is completed.
- `ERROR`: An error occurred during video processing. ||
|| duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Video duration. Optional, may be empty until the transcoding result is ready. ||
|| visibility_status | enum **VisibilityStatus**

Video visibility status.

- `VISIBILITY_STATUS_UNSPECIFIED`: Visibility status unspecified.
- `PUBLISHED`: Video is published and available for viewing.
- `UNPUBLISHED`: Video is unpublished, only admin can watch. ||
|| auto_transcode | enum **AutoTranscode**

Auto start transcoding.
If set to ENABLE, transcoding process is initiated automatically after video upload.
If set to DISABLE, manual "Transcode()" call is required instead.

- `AUTO_TRANSCODE_UNSPECIFIED`: Unspecified auto transcoding value.
- `ENABLE`: Enable auto transcoding.
- `DISABLE`: Disable auto transcoding. ||
|| subtitle_ids[] | **string**

IDs of active video subtitles. ||
|| tusd | **[VideoTUSDSource](#yandex.cloud.video.v1.VideoTUSDSource)**

Upload video using the tus protocol.

Includes only one of the fields `tusd`.

Source type. ||
|| public_access | **[VideoPublicAccessRights](#yandex.cloud.video.v1.VideoPublicAccessRights)**

Video is available to everyone.

Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`.

Video access rights. ||
|| auth_system_access | **[VideoAuthSystemAccessRights](#yandex.cloud.video.v1.VideoAuthSystemAccessRights)**

Checking access rights using the authorization system.

Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`.

Video access rights. ||
|| sign_url_access | **[VideoSignURLAccessRights](#yandex.cloud.video.v1.VideoSignURLAccessRights)**

Checking access rights using url's signature.

Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`.

Video access rights. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when video was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last video update. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
|#

## VideoTUSDSource {#yandex.cloud.video.v1.VideoTUSDSource}

#|
||Field | Description ||
|| url | **string**

URL for uploading video via the tus protocol. ||
|#

## VideoPublicAccessRights {#yandex.cloud.video.v1.VideoPublicAccessRights}

#|
||Field | Description ||
|| Empty | > ||
|#

## VideoAuthSystemAccessRights {#yandex.cloud.video.v1.VideoAuthSystemAccessRights}

#|
||Field | Description ||
|| Empty | > ||
|#

## VideoSignURLAccessRights {#yandex.cloud.video.v1.VideoSignURLAccessRights}

#|
||Field | Description ||
|| Empty | > ||
|#