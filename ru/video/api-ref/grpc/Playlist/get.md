---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Playlist/get.md
---

# Video API, gRPC: PlaylistService.Get

Retrieves detailed information about a specific playlist by its ID.
Returns all playlist metadata, items, and related information.

## gRPC request

**rpc Get ([GetPlaylistRequest](#yandex.cloud.video.v1.GetPlaylistRequest)) returns ([Playlist](#yandex.cloud.video.v1.Playlist))**

## GetPlaylistRequest {#yandex.cloud.video.v1.GetPlaylistRequest}

```json
{
  "playlist_id": "string"
}
```

#|
||Field | Description ||
|| playlist_id | **string**

Required field. ID of the playlist to retrieve. ||
|#

## Playlist {#yandex.cloud.video.v1.Playlist}

```json
{
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
```

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
|| items[] | **[PlaylistItem](#yandex.cloud.video.v1.PlaylistItem)**

Ordered list of content items included in this playlist. ||
|| style_preset_id | **string**

Identifier of the style preset used in the player during playlist playback. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the playlist was initially created in the system. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the last modification to the playlist or its metadata. ||
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