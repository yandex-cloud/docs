---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Video/performAction.md
---

# Video API, gRPC: VideoService.PerformAction {#PerformAction}

Perform an action on the episode.

## gRPC request

**rpc PerformAction ([PerformVideoActionRequest](#yandex.cloud.video.v1.PerformVideoActionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## PerformVideoActionRequest {#yandex.cloud.video.v1.PerformVideoActionRequest}

```json
{
  "videoId": "string",
  // Includes only one of the fields `publish`, `unpublish`
  "publish": "PublishVideoAction",
  "unpublish": "UnpublishVideoAction"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| videoId | **string**

ID of the video. ||
|| publish | **[PublishVideoAction](#yandex.cloud.video.v1.PublishVideoAction)**

Includes only one of the fields `publish`, `unpublish`. ||
|| unpublish | **[UnpublishVideoAction](#yandex.cloud.video.v1.UnpublishVideoAction)**

Includes only one of the fields `publish`, `unpublish`. ||
|#

## PublishVideoAction {#yandex.cloud.video.v1.PublishVideoAction}

#|
||Field | Description ||
|| Empty | > ||
|#

## UnpublishVideoAction {#yandex.cloud.video.v1.UnpublishVideoAction}

#|
||Field | Description ||
|| Empty | > ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "videoId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "channelId": "string",
    "title": "string",
    "description": "string",
    "thumbnailId": "string",
    "status": "VideoStatus",
    "duration": "google.protobuf.Duration",
    "visibilityStatus": "VisibilityStatus",
    // Includes only one of the fields `tusd`
    "tusd": {
      "url": "string"
    },
    // end of the list of possible fields
    // Includes only one of the fields `publicAccess`, `authSystemAccess`
    "publicAccess": "VideoPublicAccessRights",
    "authSystemAccess": "VideoAuthSystemAccessRights",
    // end of the list of possible fields
    "createdAt": "google.protobuf.Timestamp",
    "updatedAt": "google.protobuf.Timestamp",
    "labels": "string"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[PerformVideoActionMetadata](#yandex.cloud.video.v1.PerformVideoActionMetadata)**

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

## PerformVideoActionMetadata {#yandex.cloud.video.v1.PerformVideoActionMetadata}

#|
||Field | Description ||
|| videoId | **string**

ID of the video. ||
|#

## Video {#yandex.cloud.video.v1.Video}

#|
||Field | Description ||
|| id | **string**

ID of the video. ||
|| channelId | **string**

ID of the channel where the video was created. ||
|| title | **string**

Video title. ||
|| description | **string**

Video description. ||
|| thumbnailId | **string**

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
|| visibilityStatus | enum **VisibilityStatus**

Video visibility status.

- `VISIBILITY_STATUS_UNSPECIFIED`: Visibility status unspecified.
- `PUBLISHED`: Video is published and available for viewing.
- `UNPUBLISHED`: Video is unpublished, only admin can watch. ||
|| tusd | **[VideoTUSDSource](#yandex.cloud.video.v1.VideoTUSDSource)**

Upload video using the tus protocol.

Includes only one of the fields `tusd`.

Source type. ||
|| publicAccess | **[VideoPublicAccessRights](#yandex.cloud.video.v1.VideoPublicAccessRights)**

Video is available to everyone.

Includes only one of the fields `publicAccess`, `authSystemAccess`.

Video access rights. ||
|| authSystemAccess | **[VideoAuthSystemAccessRights](#yandex.cloud.video.v1.VideoAuthSystemAccessRights)**

Checking access rights using the authorization system.

Includes only one of the fields `publicAccess`, `authSystemAccess`.

Video access rights. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when video was created. ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last video update. ||
|| labels | **string**

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