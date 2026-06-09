# Video API, REST: Video.BatchGetPlayerURLs

Generates multiple player URLs for a list of videos in a specific channel in a single request.
This is more efficient than making multiple GetPlayerURL requests when retrieving several URLs.

## HTTP request

```
POST https://video.api.cloud.yandex.net/video/v1/videos:batchGetPlayerURLs
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

Required field. ID of the channel containing the videos for which to generate player URLs.

The maximum string length in characters is 50. ||
|| videoIds[] | **string**

List of video IDs for which to generate player URLs.

The maximum string length in characters for each value is 50. The number of elements must be in the range 1-100. ||
|| params | **[VideoPlayerParams](#yandex.cloud.video.v1.VideoPlayerParams)**

Optional player parameters to customize the playback experience.
These parameters control initial player state such as mute, autoplay, and visibility of interface controls.
These parameters will be applied to all generated player URLs. ||
|| signedUrlExpirationDuration | **string** (duration)

For episodes with signed URL access, specifies how long the generated URL will be valid.
If not provided, a default expiration duration will be used.
This setting applies to all videos in the batch that use sign_url_access. ||
|#

## VideoPlayerParams {#yandex.cloud.video.v1.VideoPlayerParams}

#|
||Field | Description ||
|| mute | **boolean**

If true, the player will start with audio muted.
Users can unmute the audio manually after playback starts. ||
|| autoplay | **boolean**

If true, the video will start playing automatically when the player loads.
This may be subject to browser autoplay policies that restrict autoplay with sound. ||
|| hidden | **boolean**

If true, the player interface controls will be hidden initially.
Users can typically reveal the controls by moving the mouse over the player. ||
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
|| playerUrls[] | **string**

List of player URLs corresponding to the requested video IDs.
The order of URLs matches the order of video IDs in the request. ||
|#