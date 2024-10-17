---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Video/getPlayerURL.md
---

# Video API, gRPC: VideoService.GetPlayerURL {#GetPlayerURL}

Returns url to the player.

## gRPC request

**rpc GetPlayerURL ([GetVideoPlayerURLRequest](#yandex.cloud.video.v1.GetVideoPlayerURLRequest)) returns ([GetVideoPlayerURLResponse](#yandex.cloud.video.v1.GetVideoPlayerURLResponse))**

## GetVideoPlayerURLRequest {#yandex.cloud.video.v1.GetVideoPlayerURLRequest}

```json
{
  "videoId": "string",
  "params": {
    "mute": "bool",
    "autoplay": "bool",
    "hidden": "bool"
  }
}
```

#|
||Field | Description ||
|| videoId | **string**

ID of the video. ||
|| params | **[VideoPlayerParams](#yandex.cloud.video.v1.VideoPlayerParams)** ||
|#

## VideoPlayerParams {#yandex.cloud.video.v1.VideoPlayerParams}

#|
||Field | Description ||
|| mute | **bool**

If true, a player will be muted by default. ||
|| autoplay | **bool**

If true, playback will start automatically. ||
|| hidden | **bool**

If true, a player interface will be hidden by default. ||
|#

## GetVideoPlayerURLResponse {#yandex.cloud.video.v1.GetVideoPlayerURLResponse}

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