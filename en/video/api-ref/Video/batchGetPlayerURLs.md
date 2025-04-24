---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Video/batchGetPlayerURLs.md
---

# Video API, REST: Video.BatchGetPlayerURLs

Batch get player urls.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/videos:batchGetPlayerURLs
```

## Body parameters {#yandex.cloud.video.v1.BatchGetVideoPlayerURLsRequest}

```json
{
  "channelId": "string",
  "videoIds": [
    "string"
  ],
  "params": {
    "mute": "boolean",
    "autoplay": "boolean",
    "hidden": "boolean"
  },
  "signedUrlExpirationDuration": "string"
}
```

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel. ||
|| videoIds[] | **string**

List of requested video IDs. ||
|| params | **[VideoPlayerParams](#yandex.cloud.video.v1.VideoPlayerParams)** ||
|| signedUrlExpirationDuration | **string** (duration)

Optional field, used to set custom url expiration duration for videos with sign_url_access ||
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

## Response {#yandex.cloud.video.v1.BatchGetVideoPlayerURLsResponse}

**HTTP Code: 200 - OK**

```json
{
  "playerUrls": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| playerUrls[] | **string** ||
|#