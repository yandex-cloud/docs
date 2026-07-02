[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Video](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Video](index.md) > GetScreenshots

# Video API, gRPC: VideoService.GetScreenshots

Retrieves screenshots taken during the video transcoding process.

## gRPC request

**rpc GetScreenshots ([GetVideoScreenshotsRequest](#yandex.cloud.video.v1.GetVideoScreenshotsRequest)) returns ([GetVideoScreenshotsResponse](#yandex.cloud.video.v1.GetVideoScreenshotsResponse))**

## GetVideoScreenshotsRequest {#yandex.cloud.video.v1.GetVideoScreenshotsRequest}

```json
{
  "video_id": "string"
}
```

#|
||Field | Description ||
|| video_id | **string**

Required field. ID of the video for which to retrieve screenshots.

The maximum string length in characters is 50. ||
|#

## GetVideoScreenshotsResponse {#yandex.cloud.video.v1.GetVideoScreenshotsResponse}

```json
{
  "screenshots": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| screenshots[] | **string**

List of URLs to screenshots taken during the video transcoding process.
These screenshots can be used for thumbnail selection or content preview.
Screenshots are typically taken at regular intervals throughout the video. ||
|#