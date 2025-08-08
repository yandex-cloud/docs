---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Thumbnail/create.md
---

# Video API, gRPC: ThumbnailService.Create

Creates a new thumbnail record for a specific resource.
This method only creates the metadata record; the actual image must be uploaded
using the URL obtained from the GenerateUploadURL method.

## gRPC request

**rpc Create ([CreateThumbnailRequest](#yandex.cloud.video.v1.CreateThumbnailRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateThumbnailRequest {#yandex.cloud.video.v1.CreateThumbnailRequest}

```json
{
  "channel_id": "string",
  // Includes only one of the fields `episode_id`, `video_id`
  "episode_id": "string",
  "video_id": "string"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| channel_id | **string**

[Deprecated] ID of the channel. ||
|| episode_id | **string**

ID of the episode to associate the thumbnail with.

Includes only one of the fields `episode_id`, `video_id`. ||
|| video_id | **string**

ID of the video to associate the thumbnail with.

Includes only one of the fields `episode_id`, `video_id`. ||
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
    "thumbnail_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "channel_id": "string",
    // Includes only one of the fields `episode_id`, `video_id`
    "episode_id": "string",
    "video_id": "string",
    // end of the list of possible fields
    "created_at": "google.protobuf.Timestamp"
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
|| metadata | **[CreateThumbnailMetadata](#yandex.cloud.video.v1.CreateThumbnailMetadata)**

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
|| response | **[Thumbnail](#yandex.cloud.video.v1.Thumbnail)**

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

## CreateThumbnailMetadata {#yandex.cloud.video.v1.CreateThumbnailMetadata}

#|
||Field | Description ||
|| thumbnail_id | **string**

ID of the thumbnail being created. ||
|#

## Thumbnail {#yandex.cloud.video.v1.Thumbnail}

Entity representing an image used as a visual representation for various content entities.
Thumbnails provide preview images for channels, streams, episodes, videos, and stream lines.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the thumbnail. ||
|| channel_id | **string**

Identifier of the channel where the thumbnail is created and managed. ||
|| episode_id | **string**

ID of the episode which the thumbnail is associated with.

Includes only one of the fields `episode_id`, `video_id`. ||
|| video_id | **string**

ID of the video which the thumbnail is associated with.

Includes only one of the fields `episode_id`, `video_id`. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the thumbnail was initially created in the system. ||
|#