[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Subtitle](index.md) > GenerateDownloadURL

# Video API, REST: Subtitle.GenerateDownloadURL

Generates a URL for downloading the original subtitle file.
This URL can be used to retrieve the subtitle content in its original format.
The URL is pre-signed and has a limited validity period.

## HTTP request

```
POST https://video.api.cloud.yandex.net/video/v1/subtitles/{subtitleId}:generateDownloadURL
```

## Path parameters

#|
||Field | Description ||
|| subtitleId | **string**

Required field. ID of the subtitle for which to generate a download URL.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.video.v1.GenerateSubtitleDownloadURLResponse}

**HTTP Code: 200 - OK**

```json
{
  "downloadUrl": "string"
}
```

#|
||Field | Description ||
|| downloadUrl | **string**

Pre-signed URL for downloading the subtitle file.
This URL can be used with an HTTP GET request to download the subtitle file.
The URL has a limited validity period and will expire after a certain time. ||
|#