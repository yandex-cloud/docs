---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Thumbnail/list.md
---

# Video API, gRPC: ThumbnailService.List

Lists all thumbnails associated with a specific resource (channel, stream, video, etc.)
with pagination support.

## gRPC request

**rpc List ([ListThumbnailRequest](#yandex.cloud.video.v1.ListThumbnailRequest)) returns ([ListThumbnailResponse](#yandex.cloud.video.v1.ListThumbnailResponse))**

## ListThumbnailRequest {#yandex.cloud.video.v1.ListThumbnailRequest}

```json
{
  "channel_id": "string",
  // Includes only one of the fields `episode_id`, `video_id`
  "episode_id": "string",
  "video_id": "string",
  // end of the list of possible fields
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| channel_id | **string**

[Deprecated] ID of the channel. ||
|| episode_id | **string**

ID of the episode containing the thumbnails to list.

Includes only one of the fields `episode_id`, `video_id`. ||
|| video_id | **string**

ID of the video containing the thumbnails to list.

Includes only one of the fields `episode_id`, `video_id`. ||
|| page_size | **int64**

The maximum number of thumbnails to return per page. ||
|| page_token | **string**

Page token for retrieving the next page of results.
This token is obtained from the next_page_token field in the previous ListThumbnailResponse. ||
|#

## ListThumbnailResponse {#yandex.cloud.video.v1.ListThumbnailResponse}

```json
{
  "thumbnails": [
    {
      "id": "string",
      "channel_id": "string",
      // Includes only one of the fields `episode_id`, `video_id`
      "episode_id": "string",
      "video_id": "string",
      // end of the list of possible fields
      "created_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| thumbnails[] | **[Thumbnail](#yandex.cloud.video.v1.Thumbnail)**

List of thumbnails matching the request criteria.
May be empty if no thumbnails match the criteria or if the parent resource has no thumbnails. ||
|| next_page_token | **string**

Token for retrieving the next page of results.
Empty if there are no more results available. ||
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