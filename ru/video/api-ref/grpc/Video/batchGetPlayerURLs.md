---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Video/batchGetPlayerURLs.md
---

# Video API, gRPC: VideoService.BatchGetPlayerURLs

Generates multiple player URLs for a list of videos in a specific channel in a single request.
This is more efficient than making multiple GetPlayerURL requests when retrieving several URLs.

## gRPC request

**rpc BatchGetPlayerURLs ([BatchGetVideoPlayerURLsRequest](#yandex.cloud.video.v1.BatchGetVideoPlayerURLsRequest)) returns ([BatchGetVideoPlayerURLsResponse](#yandex.cloud.video.v1.BatchGetVideoPlayerURLsResponse))**

## BatchGetVideoPlayerURLsRequest {#yandex.cloud.video.v1.BatchGetVideoPlayerURLsRequest}

```json
{
  "channel_id": "string",
  "video_ids": [
    "string"
  ],
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
|| channel_id | **string**

Required field. ID of the channel containing the videos for which to generate player URLs. ||
|| video_ids[] | **string**

List of video IDs for which to generate player URLs. ||
|| params | **[VideoPlayerParams](#yandex.cloud.video.v1.VideoPlayerParams)**

Optional player parameters to customize the playback experience.
These parameters control initial player state such as mute, autoplay, and visibility of interface controls.
These parameters will be applied to all generated player URLs. ||
|| signed_url_expiration_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

For episodes with signed URL access, specifies how long the generated URL will be valid.
If not provided, a default expiration duration will be used.
This setting applies to all videos in the batch that use sign_url_access. ||
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

## BatchGetVideoPlayerURLsResponse {#yandex.cloud.video.v1.BatchGetVideoPlayerURLsResponse}

```json
{
  "player_urls": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| player_urls[] | **string**

List of player URLs corresponding to the requested video IDs.
The order of URLs matches the order of video IDs in the request. ||
|#