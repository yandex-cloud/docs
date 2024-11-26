---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Thumbnail/batchGenerateDownloadURLs.md
---

# Video API, gRPC: ThumbnailService.BatchGenerateDownloadURLs

Generate urls for download images.

## gRPC request

**rpc BatchGenerateDownloadURLs ([BatchGenerateDownloadURLsRequest](#yandex.cloud.video.v1.BatchGenerateDownloadURLsRequest)) returns ([BatchGenerateDownloadURLsResponse](#yandex.cloud.video.v1.BatchGenerateDownloadURLsResponse))**

## BatchGenerateDownloadURLsRequest {#yandex.cloud.video.v1.BatchGenerateDownloadURLsRequest}

```json
{
  "channel_id": "string",
  "thumbnail_ids": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel. ||
|| thumbnail_ids[] | **string**

List of thumbnails IDs. ||
|#

## BatchGenerateDownloadURLsResponse {#yandex.cloud.video.v1.BatchGenerateDownloadURLsResponse}

```json
{
  "download_urls": [
    {
      "thumbnail_id": "string",
      "download_url": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| download_urls[] | **[ThumbnailDownloadURL](#yandex.cloud.video.v1.ThumbnailDownloadURL)**

List of download urls. ||
|#

## ThumbnailDownloadURL {#yandex.cloud.video.v1.ThumbnailDownloadURL}

#|
||Field | Description ||
|| thumbnail_id | **string**

ID of the thumbnail. ||
|| download_url | **string**

Download url. ||
|#