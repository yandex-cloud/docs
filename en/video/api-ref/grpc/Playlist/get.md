---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Playlist/get.md
---

# Video API, gRPC: PlaylistService.Get

Returns the specific playlist.

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

Required field. ID of the playlist. ||
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
  "created_at": "google.protobuf.Timestamp",
  "updated_at": "google.protobuf.Timestamp"
}
```

Entity representing an ordered list of videos or episodes.

#|
||Field | Description ||
|| id | **string**

ID of the playlist. ||
|| channel_id | **string**

ID of the channel to create the playlist in. ||
|| title | **string**

Playlist title. ||
|| description | **string**

Playlist description. ||
|| items[] | **[PlaylistItem](#yandex.cloud.video.v1.PlaylistItem)**

List of playlist items. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when playlist was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last playlist update. ||
|#

## PlaylistItem {#yandex.cloud.video.v1.PlaylistItem}

#|
||Field | Description ||
|| video_id | **string**

ID of the video.

Includes only one of the fields `video_id`, `episode_id`. ||
|| episode_id | **string**

ID of the episode.

Includes only one of the fields `video_id`, `episode_id`. ||
|| position | **int64**

Item position (zero-indexed). ||
|#