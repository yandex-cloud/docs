---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/videos/{videoId}:generateDownloadURL
    method: post
    path:
      type: object
      properties:
        videoId:
          description: |-
            **string**
            Required field. ID of the video for which to generate a download URL.
            The maximum string length in characters is 50.
          type: string
      required:
        - videoId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Video/generateDownloadURL.md
---

# Video API, REST: Video.GenerateDownloadURL

Generates a URL for downloading the original video file.
This URL is time-limited and provides direct access to the source video.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/videos/{videoId}:generateDownloadURL
```

## Path parameters

#|
||Field | Description ||
|| videoId | **string**

Required field. ID of the video for which to generate a download URL.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.video.v1.GenerateVideoDownloadURLResponse}

**HTTP Code: 200 - OK**

```json
{
  "downloadUrl": "string"
}
```

#|
||Field | Description ||
|| downloadUrl | **string**

Time-limited URL for downloading the original video file.
This URL provides direct access to the source video file
and can be used with standard download tools. ||
|#