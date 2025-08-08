---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Playlist/create.md
---

# Video API, gRPC: PlaylistService.Create

Creates a new playlist in the specified channel with the provided items.
Playlists can contain videos, episodes, or a mix of both content types.

## gRPC request

**rpc Create ([CreatePlaylistRequest](#yandex.cloud.video.v1.CreatePlaylistRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreatePlaylistRequest {#yandex.cloud.video.v1.CreatePlaylistRequest}

```json
{
  "channel_id": "string",
  "title": "string",
  "description": "string",
  "items": [
    {
      // Includes only one of the fields `video_id`, `episode_id`
      "video_id": "string",
      "episode_id": "string",
      // end of the list of possible fields
      "position": "int64"
    }
  ],
  "style_preset_id": "string"
}
```

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel where the playlist will be created. ||
|| title | **string**

Required field. Title of the playlist to be displayed in interfaces and players. ||
|| description | **string**

Detailed description of the playlist content and context.
Optional field that can provide additional information about the playlist. ||
|| items[] | **[PlaylistItem](#yandex.cloud.video.v1.PlaylistItem)**

List of items to include in the playlist.
Each item represents a video or episode to be played in sequence.
The order of items in this list determines the playback order. ||
|| style_preset_id | **string**

ID of the style preset to be applied to the playlist player.
Style presets control the visual appearance of the player. ||
|#

## PlaylistItem {#yandex.cloud.video.v1.PlaylistItem}

Represents a single item in a playlist.
Each item references either a video or an episode and specifies its position in the sequence.

#|
||Field | Description ||
|| video_id | **string**

Identifier of a video included in the playlist.

Includes only one of the fields `video_id`, `episode_id`.

Specifies the content identifier type for this playlist item. ||
|| episode_id | **string**

Identifier of an episode included in the playlist.

Includes only one of the fields `video_id`, `episode_id`.

Specifies the content identifier type for this playlist item. ||
|| position | **int64**

Position of this item in the playlist sequence (zero-indexed).
Determines the playback order of content in the playlist. ||
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
    "playlist_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "channel_id": "string",
    "title": "string",
    "description": "string",
    "items": [
      {
        // Includes only one of the fields `video_id`, `episode_id`
        "video_id": "string",
        "episode_id": "string",
        // end of the list of possible fields
        "position": "int64"
      }
    ],
    "style_preset_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp"
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
|| metadata | **[CreatePlaylistMetadata](#yandex.cloud.video.v1.CreatePlaylistMetadata)**

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
|| response | **[Playlist](#yandex.cloud.video.v1.Playlist)**

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

## CreatePlaylistMetadata {#yandex.cloud.video.v1.CreatePlaylistMetadata}

#|
||Field | Description ||
|| playlist_id | **string**

ID of the playlist being created. ||
|#

## Playlist {#yandex.cloud.video.v1.Playlist}

Entity representing an ordered collection of videos or episodes.
Playlists allow organizing content into sequences for improved user experience.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the playlist. ||
|| channel_id | **string**

Identifier of the channel where this playlist is created and managed. ||
|| title | **string**

Title of the playlist displayed in interfaces and players. ||
|| description | **string**

Detailed description of the playlist's content and purpose. ||
|| items[] | **[PlaylistItem](#yandex.cloud.video.v1.PlaylistItem2)**

Ordered list of content items included in this playlist. ||
|| style_preset_id | **string**

Identifier of the style preset used in the player during playlist playback. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the playlist was initially created in the system. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the last modification to the playlist or its metadata. ||
|#

## PlaylistItem {#yandex.cloud.video.v1.PlaylistItem2}

Represents a single item in a playlist.
Each item references either a video or an episode and specifies its position in the sequence.

#|
||Field | Description ||
|| video_id | **string**

Identifier of a video included in the playlist.

Includes only one of the fields `video_id`, `episode_id`.

Specifies the content identifier type for this playlist item. ||
|| episode_id | **string**

Identifier of an episode included in the playlist.

Includes only one of the fields `video_id`, `episode_id`.

Specifies the content identifier type for this playlist item. ||
|| position | **int64**

Position of this item in the playlist sequence (zero-indexed).
Determines the playback order of content in the playlist. ||
|#