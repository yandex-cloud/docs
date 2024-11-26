---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Video/getPlayerURL.md
---

# Video API, REST: Video.GetPlayerURL

Returns url to the player.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/videos/{videoId}:getPlayerURL
```

## Path parameters

#|
||Field | Description ||
|| videoId | **string**

Required field. ID of the video. ||
|#

## Query parameters {#yandex.cloud.video.v1.GetVideoPlayerURLRequest}

#|
||Field | Description ||
|| params | **[VideoPlayerParams](#yandex.cloud.video.v1.VideoPlayerParams)** ||
|#

## VideoPlayerParams {#yandex.cloud.video.v1.VideoPlayerParams}

#|
||Field | Description ||
|| mute | **boolean**

If true, a player will be muted by default. ||
|| autoplay | **boolean**

If true, playback will start automatically. ||
|| hidden | **boolean**

If true, a player interface will be hidden by default. ||
|#

## Response {#yandex.cloud.video.v1.GetVideoPlayerURLResponse}

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

Direct link to the video. ||
|| html | **string**

HTML embed code in Iframe format. ||
|#