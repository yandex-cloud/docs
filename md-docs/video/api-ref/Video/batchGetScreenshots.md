# Video API, REST: Video.BatchGetScreenshots

Retrieves screenshots taken during the video transcoding process for a list of videos.
This is more efficient than making multiple GetScreenshots requests when retrieving screenshots for several videos.

## HTTP request

```
POST https://video.api.cloud.yandex.net/video/v1/videos:batchGetScreenshots
```

## Body parameters {#yandex.cloud.video.v1.BatchGetVideoScreenshotsRequest}

```json
{
  "channelId": "string",
  "videoIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel containing the videos.

The maximum string length in characters is 50. ||
|| videoIds[] | **string**

List of video IDs for which to retrieve screenshots.

The maximum string length in characters for each value is 50. The number of elements must be in the range 1-100. ||
|#

## Response {#yandex.cloud.video.v1.BatchGetVideoScreenshotsResponse}

**HTTP Code: 200 - OK**

```json
{
  "videoScreenshots": [
    {
      "videoId": "string",
      "screenshots": [
        "string"
      ]
    }
  ]
}
```

#|
||Field | Description ||
|| videoScreenshots[] | **[VideoScreenshots](#yandex.cloud.video.v1.VideoScreenshots)**

List of screenshots for the requested videos. ||
|#

## VideoScreenshots {#yandex.cloud.video.v1.VideoScreenshots}

#|
||Field | Description ||
|| videoId | **string**

ID of the video for which screenshots are retrieved. ||
|| screenshots[] | **string**

List of URLs to screenshots taken during the video transcoding process.
These screenshots can be used for thumbnail selection or content preview.
Screenshots are typically taken at regular intervals throughout the video. ||
|#