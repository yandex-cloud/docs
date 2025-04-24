---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Video/batchGetPlayerURLs.md
---

# Video API, gRPC: VideoService.BatchGetPlayerURLs

Batch get player urls.

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

Required field. ID of the channel. ||
|| video_ids[] | **string**

List of requested video IDs. ||
|| params | **[VideoPlayerParams](#yandex.cloud.video.v1.VideoPlayerParams)** ||
|| signed_url_expiration_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Optional field, used to set custom url expiration duration for videos with sign_url_access ||
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
|| player_urls[] | **string** ||
|#