---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Playlist/getPlayerURL.md
---

# Video API, REST: Playlist.GetPlayerURL

Get player url.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/playlists/{playlistId}:getPlayerURL
```

## Path parameters

#|
||Field | Description ||
|| playlistId | **string**

Required field. ID of the playlist. ||
|#

## Query parameters {#yandex.cloud.video.v1.GetPlaylistPlayerURLRequest}

#|
||Field | Description ||
|| params | **[PlaylistPlayerParams](#yandex.cloud.video.v1.PlaylistPlayerParams)** ||
|#

## PlaylistPlayerParams {#yandex.cloud.video.v1.PlaylistPlayerParams}

#|
||Field | Description ||
|| mute | **boolean**

If true, a player will be muted by default. ||
|| autoplay | **boolean**

If true, playback will start automatically. ||
|| hidden | **boolean**

If true, a player interface will be hidden by default. ||
|#

## Response {#yandex.cloud.video.v1.GetPlaylistPlayerURLResponse}

**HTTP Code: 200 - OK**

```json
{
  "playerUrl": "string",
  "html": "string"
}
```

#|
||Field | Description ||
|| playerUrl | **string**

Direct link to the playlist. ||
|| html | **string**

HTML embed code in Iframe format. ||
|#