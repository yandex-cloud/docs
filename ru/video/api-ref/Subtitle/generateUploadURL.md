---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Subtitle/generateUploadURL.md
---

# Video API, REST: Subtitle.GenerateUploadURL

Generate an upload URL to add a new subtitle file.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/subtitles/{subtitleId}:generateUploadURL
```

## Path parameters

#|
||Field | Description ||
|| subtitleId | **string**

Required field. ID of the subtitle. ||
|#

## Response {#yandex.cloud.video.v1.GenerateSubtitleUploadURLResponse}

**HTTP Code: 200 - OK**

```json
{
  "uploadUrl": "string"
}
```

#|
||Field | Description ||
|| uploadUrl | **string**

Upload url. ||
|#