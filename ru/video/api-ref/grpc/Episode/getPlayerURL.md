---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Episode/getPlayerURL.md
---

# Video API, gRPC: EpisodeService.GetPlayerURL {#GetPlayerURL}

Returns url to the player.

## gRPC request

**rpc GetPlayerURL ([GetEpisodePlayerURLRequest](#yandex.cloud.video.v1.GetEpisodePlayerURLRequest)) returns ([GetEpisodePlayerURLResponse](#yandex.cloud.video.v1.GetEpisodePlayerURLResponse))**

## GetEpisodePlayerURLRequest {#yandex.cloud.video.v1.GetEpisodePlayerURLRequest}

```json
{
  "episodeId": "string",
  "params": {
    "mute": "bool",
    "autoplay": "bool",
    "hidden": "bool"
  }
}
```

#|
||Field | Description ||
|| episodeId | **string**

ID of the episode. ||
|| params | **[EpisodePlayerParams](#yandex.cloud.video.v1.EpisodePlayerParams)** ||
|#

## EpisodePlayerParams {#yandex.cloud.video.v1.EpisodePlayerParams}

#|
||Field | Description ||
|| mute | **bool**

If true, a player will be muted by default. ||
|| autoplay | **bool**

If true, playback will start automatically. ||
|| hidden | **bool**

If true, a player interface will be hidden by default. ||
|#

## GetEpisodePlayerURLResponse {#yandex.cloud.video.v1.GetEpisodePlayerURLResponse}

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