---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Video/getPlayerURL.md
---

# Video API, gRPC: VideoService.GetPlayerURL

Generates a standard player URL for watching the video.
The URL respects the video's access rights and can include custom player parameters.
For videos with signed URL access, an expiration duration can be specified.

## gRPC request

**rpc GetPlayerURL ([GetVideoPlayerURLRequest](#yandex.cloud.video.v1.GetVideoPlayerURLRequest)) returns ([GetVideoPlayerURLResponse](#yandex.cloud.video.v1.GetVideoPlayerURLResponse))**

## GetVideoPlayerURLRequest {#yandex.cloud.video.v1.GetVideoPlayerURLRequest}

```json
{
  "video_id": "string",
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
|| video_id | **string**

Required field. ID of the video for which to generate a player URL. ||
|| params | **[VideoPlayerParams](#yandex.cloud.video.v1.VideoPlayerParams)**

Optional player parameters to customize the playback experience.
These parameters control initial player state such as mute, autoplay, and visibility of interface controls. ||
|| signed_url_expiration_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

For episodes with signed URL access, specifies how long the generated URL will be valid.
If not provided, a default expiration duration will be used. ||
|#

## VideoPlayerParams {#yandex.cloud.video.v1.VideoPlayerParams}

#|
||Field | Description ||
|| mute | **bool**

If true, the player will start with audio muted.
Users can unmute the audio manually after playback starts. ||
|| autoplay | **bool**

If true, the video will start playing automatically when the player loads.
This may be subject to browser autoplay policies that restrict autoplay with sound. ||
|| hidden | **bool**

If true, the player interface controls will be hidden initially.
Users can typically reveal the controls by moving the mouse over the player. ||
|#

## GetVideoPlayerURLResponse {#yandex.cloud.video.v1.GetVideoPlayerURLResponse}

```json
{
  "player_url": "string",
  "html": "string"
}
```

#|
||Field | Description ||
|| player_url | **string**

Direct URL to the video player.
This URL can be used to access the video in a web browser
or shared with users who have appropriate permissions. ||
|| html | **string**

HTML embed code in iframe format that can be inserted into web pages.
This code allows the video to be embedded directly in third-party websites. ||
|#