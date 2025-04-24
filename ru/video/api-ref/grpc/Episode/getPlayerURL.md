---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Episode/getPlayerURL.md
---

# Video API, gRPC: EpisodeService.GetPlayerURL

Get player url.

## gRPC request

**rpc GetPlayerURL ([GetEpisodePlayerURLRequest](#yandex.cloud.video.v1.GetEpisodePlayerURLRequest)) returns ([GetEpisodePlayerURLResponse](#yandex.cloud.video.v1.GetEpisodePlayerURLResponse))**

## GetEpisodePlayerURLRequest {#yandex.cloud.video.v1.GetEpisodePlayerURLRequest}

```json
{
  "episode_id": "string",
  "params": {
    "mute": "bool",
    "autoplay": "bool",
    "hidden": "bool"
  },
  "signed_url_expiration_duration": "google.protobuf.Duration"
}
```

#|
||Field | Description ||
|| episode_id | **string**

Required field. ID of the episode. ||
|| params | **[EpisodePlayerParams](#yandex.cloud.video.v1.EpisodePlayerParams)** ||
|| signed_url_expiration_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Optional field, used to set custom url expiration duration for episodes with sign_url_access ||
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
  "player_url": "string",
  "html": "string"
}
```

#|
||Field | Description ||
|| player_url | **string**

Direct link to the episode. ||
|| html | **string**

HTML embed code in Iframe format. ||
|#