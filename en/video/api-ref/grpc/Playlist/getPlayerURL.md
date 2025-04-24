---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Playlist/getPlayerURL.md
---

# Video API, gRPC: PlaylistService.GetPlayerURL

Get player url.

## gRPC request

**rpc GetPlayerURL ([GetPlaylistPlayerURLRequest](#yandex.cloud.video.v1.GetPlaylistPlayerURLRequest)) returns ([GetPlaylistPlayerURLResponse](#yandex.cloud.video.v1.GetPlaylistPlayerURLResponse))**

## GetPlaylistPlayerURLRequest {#yandex.cloud.video.v1.GetPlaylistPlayerURLRequest}

```json
{
  "playlist_id": "string",
  "params": {
    "mute": "bool",
    "autoplay": "bool",
    "hidden": "bool"
  }
}
```

#|
||Field | Description ||
|| playlist_id | **string**

Required field. ID of the playlist. ||
|| params | **[PlaylistPlayerParams](#yandex.cloud.video.v1.PlaylistPlayerParams)** ||
|#

## PlaylistPlayerParams {#yandex.cloud.video.v1.PlaylistPlayerParams}

#|
||Field | Description ||
|| mute | **bool**

If true, a player will be muted by default. ||
|| autoplay | **bool**

If true, playback will start automatically. ||
|| hidden | **bool**

If true, a player interface will be hidden by default. ||
|#

## GetPlaylistPlayerURLResponse {#yandex.cloud.video.v1.GetPlaylistPlayerURLResponse}

```json
{
  "player_url": "string",
  "html": "string"
}
```

#|
||Field | Description ||
|| player_url | **string**

Direct link to the playlist. ||
|| html | **string**

HTML embed code in Iframe format. ||
|#