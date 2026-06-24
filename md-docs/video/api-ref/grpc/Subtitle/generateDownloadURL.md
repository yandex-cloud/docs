# Video API, gRPC: SubtitleService.GenerateDownloadURL

Generates a URL for downloading the original subtitle file.
This URL can be used to retrieve the subtitle content in its original format.
The URL is pre-signed and has a limited validity period.

## gRPC request

**rpc GenerateDownloadURL ([GenerateSubtitleDownloadURLRequest](#yandex.cloud.video.v1.GenerateSubtitleDownloadURLRequest)) returns ([GenerateSubtitleDownloadURLResponse](#yandex.cloud.video.v1.GenerateSubtitleDownloadURLResponse))**

## GenerateSubtitleDownloadURLRequest {#yandex.cloud.video.v1.GenerateSubtitleDownloadURLRequest}

```json
{
  "subtitle_id": "string"
}
```

#|
||Field | Description ||
|| subtitle_id | **string**

Required field. ID of the subtitle for which to generate a download URL.

The maximum string length in characters is 50. ||
|#

## GenerateSubtitleDownloadURLResponse {#yandex.cloud.video.v1.GenerateSubtitleDownloadURLResponse}

```json
{
  "download_url": "string"
}
```

#|
||Field | Description ||
|| download_url | **string**

Pre-signed URL for downloading the subtitle file.
This URL can be used with an HTTP GET request to download the subtitle file.
The URL has a limited validity period and will expire after a certain time. ||
|#