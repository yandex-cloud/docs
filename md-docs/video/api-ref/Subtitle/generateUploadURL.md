# Video API, REST: Subtitle.GenerateUploadURL

Generates a URL for uploading a subtitle file to an existing subtitle record.
This URL can be used to upload the actual subtitle file using an HTTP PUT request.
The URL is pre-signed and has a limited validity period.

## HTTP request

```
GET https://video.api.cloud.yandex.net/video/v1/subtitles/{subtitleId}:generateUploadURL
```

## Path parameters

#|
||Field | Description ||
|| subtitleId | **string**

Required field. ID of the subtitle for which to generate an upload URL.

The maximum string length in characters is 50. ||
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

Pre-signed URL for uploading the subtitle file.
This URL can be used with an HTTP PUT request to upload the subtitle file.
The URL has a limited validity period and will expire after a certain time. ||
|#