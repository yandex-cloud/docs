---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Episode/getPlayerURL.md
---

# Video API, gRPC: EpisodeService.GetPlayerURL

Generates a player URL for watching the episode.
The URL can include player parameters such as autoplay, mute, and visibility of interface controls.
For episodes with signed URL access, an expiration duration can be specified.

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

Required field. ID of the episode for which to generate a player URL. ||
|| params | **[EpisodePlayerParams](#yandex.cloud.video.v1.EpisodePlayerParams)**

Optional player parameters to customize the playback experience.
These parameters control initial player state such as mute, autoplay, and visibility of interface controls. ||
|| signed_url_expiration_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

For episodes with signed URL access, specifies how long the generated URL will be valid.
If not provided, a default expiration duration will be used. ||
|#

## EpisodePlayerParams {#yandex.cloud.video.v1.EpisodePlayerParams}

#|
||Field | Description ||
|| mute | **bool**

If true, the player will start with audio muted.
Users can unmute the audio manually after playback starts. ||
|| autoplay | **bool**

If true, the episode will start playing automatically when the player loads.
This may be subject to browser autoplay policies that restrict autoplay with sound. ||
|| hidden | **bool**

If true, the player interface controls will be hidden initially.
Users can typically reveal the controls by moving the mouse over the player. ||
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

Direct URL to the episode player.
This URL can be used to access the episode in a web browser
or shared with users who have appropriate permissions. ||
|| html | **string**

HTML embed code in iframe format that can be inserted into web pages.
This code allows the episode to be embedded directly in third-party websites. ||
|#