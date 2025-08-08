---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Thumbnail/get.md
---

# Video API, gRPC: ThumbnailService.Get

Retrieves detailed information about a specific thumbnail by its ID.
Returns all thumbnail metadata and related information.

## gRPC request

**rpc Get ([GetThumbnailRequest](#yandex.cloud.video.v1.GetThumbnailRequest)) returns ([Thumbnail](#yandex.cloud.video.v1.Thumbnail))**

## GetThumbnailRequest {#yandex.cloud.video.v1.GetThumbnailRequest}

```json
{
  "thumbnail_id": "string"
}
```

#|
||Field | Description ||
|| thumbnail_id | **string**

Required field. ID of the thumbnail to retrieve.
Must be a valid thumbnail identifier string. ||
|#

## Thumbnail {#yandex.cloud.video.v1.Thumbnail}

```json
{
  "id": "string",
  "channel_id": "string",
  // Includes only one of the fields `episode_id`, `video_id`
  "episode_id": "string",
  "video_id": "string",
  // end of the list of possible fields
  "created_at": "google.protobuf.Timestamp"
}
```

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