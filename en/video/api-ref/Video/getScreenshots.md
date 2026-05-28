---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/videos/{videoId}:getScreenshots
    method: get
    path:
      type: object
      properties:
        videoId:
          description: |-
            **string**
            Required field. ID of the video for which to retrieve screenshots.
            The maximum string length in characters is 50.
          type: string
      required:
        - videoId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Video API, REST: Video.GetScreenshots

Retrieves screenshots taken during the video transcoding process.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/videos/{videoId}:getScreenshots
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