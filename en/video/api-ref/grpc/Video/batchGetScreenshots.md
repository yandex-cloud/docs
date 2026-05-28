---
editable: false
---

# Video API, gRPC: VideoService.BatchGetScreenshots

Retrieves screenshots taken during the video transcoding process for a list of videos.
This is more efficient than making multiple GetScreenshots requests when retrieving screenshots for several videos.

## gRPC request

**rpc BatchGetScreenshots ([BatchGetVideoScreenshotsRequest](#yandex.cloud.video.v1.BatchGetVideoScreenshotsRequest)) returns ([BatchGetVideoScreenshotsResponse](#yandex.cloud.video.v1.BatchGetVideoScreenshotsResponse))**

## BatchGetVideoScreenshotsRequest {#yandex.cloud.video.v1.BatchGetVideoScreenshotsRequest}

```json
{
  "channel_id": "string",
  "video_ids": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel containing the videos.

The maximum string length in characters is 50. ||
|| video_ids[] | **string**

List of video IDs for which to retrieve screenshots.

The maximum string length in characters for each value is 50. The number of elements must be in the range 1-100. ||
|#

## BatchGetVideoScreenshotsResponse {#yandex.cloud.video.v1.BatchGetVideoScreenshotsResponse}

```json
{
  "video_screenshots": [
    {
      "video_id": "string",
      "screenshots": [
        "string"
      ]
    }
  ]
}
```

#|
||Field | Description ||
|| video_screenshots[] | **[VideoScreenshots](#yandex.cloud.video.v1.VideoScreenshots)**

List of screenshots for the requested videos. ||
|#

## VideoScreenshots {#yandex.cloud.video.v1.VideoScreenshots}

#|
||Field | Description ||
|| video_id | **string**

ID of the video for which screenshots are retrieved. ||
|| screenshots[] | **string**

List of URLs to screenshots taken during the video transcoding process.
These screenshots can be used for thumbnail selection or content preview.
Screenshots are typically taken at regular intervals throughout the video. ||
|#