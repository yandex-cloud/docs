---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Playlist/getPlayerURL.md
---

# Video API, gRPC: PlaylistService.GetPlayerURL

Generates a player URL for watching the playlist.
The URL can include player parameters such as autoplay, mute, and visibility of interface controls.

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

Required field. ID of the playlist for which to generate a player URL. ||
|| params | **[PlaylistPlayerParams](#yandex.cloud.video.v1.PlaylistPlayerParams)**

Optional player parameters to customize the playback experience.
These parameters control initial player state such as mute, autoplay, and visibility of interface controls. ||
|#

## PlaylistPlayerParams {#yandex.cloud.video.v1.PlaylistPlayerParams}

#|
||Field | Description ||
|| mute | **bool**

If true, the player will start with audio muted.
Users can unmute the audio manually after playback starts. ||
|| autoplay | **bool**

If true, the playlist will start playing automatically when the player loads.
This may be subject to browser autoplay policies that restrict autoplay with sound. ||
|| hidden | **bool**

If true, the player interface controls will be hidden initially.
Users can typically reveal the controls by moving the mouse over the player. ||
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

Direct URL to the playlist player.
This URL can be used to access the playlist in a web browser
or shared with users who have appropriate permissions. ||
|| html | **string**

HTML embed code in iframe format that can be inserted into web pages.
This code allows the playlist to be embedded directly in third-party websites. ||
|#