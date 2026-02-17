---
editable: false
---

# Video API, gRPC: VideoService.GenerateDownloadURL

Generates a URL for downloading the original video file.
This URL is time-limited and provides direct access to the source video.

## gRPC request

**rpc GenerateDownloadURL ([GenerateVideoDownloadURLRequest](#yandex.cloud.video.v1.GenerateVideoDownloadURLRequest)) returns ([GenerateVideoDownloadURLResponse](#yandex.cloud.video.v1.GenerateVideoDownloadURLResponse))**

## GenerateVideoDownloadURLRequest {#yandex.cloud.video.v1.GenerateVideoDownloadURLRequest}

```json
{
  "video_id": "string"
}
```

#|
||Field | Description ||
|| video_id | **string**

Required field. ID of the video for which to generate a download URL.

The maximum string length in characters is 50. ||
|#

## GenerateVideoDownloadURLResponse {#yandex.cloud.video.v1.GenerateVideoDownloadURLResponse}

```json
{
  "download_url": "string"
}
```

#|
||Field | Description ||
|| download_url | **string**

Time-limited URL for downloading the original video file.
This URL provides direct access to the source video file
and can be used with standard download tools. ||
|#