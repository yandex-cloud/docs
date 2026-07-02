[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Video](index.md) > GetScreenshots

# Video API, REST: Video.GetScreenshots

Retrieves screenshots taken during the video transcoding process.

## HTTP request

```
GET https://video.api.cloud.yandex.net/video/v1/videos/{videoId}:getScreenshots
```

## Path parameters

#|
||Field | Description ||
|| videoId | **string**

Required field. ID of the video for which to retrieve screenshots.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.video.v1.GetVideoScreenshotsResponse}

**HTTP Code: 200 - OK**

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