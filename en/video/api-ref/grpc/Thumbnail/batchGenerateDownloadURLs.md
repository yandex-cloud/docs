---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Thumbnail/batchGenerateDownloadURLs.md
---

# Video API, gRPC: ThumbnailService.BatchGenerateDownloadURLs {#BatchGenerateDownloadURLs}

Generate urls for download images.

## gRPC request

**rpc BatchGenerateDownloadURLs ([BatchGenerateDownloadURLsRequest](#yandex.cloud.video.v1.BatchGenerateDownloadURLsRequest)) returns ([BatchGenerateDownloadURLsResponse](#yandex.cloud.video.v1.BatchGenerateDownloadURLsResponse))**

## BatchGenerateDownloadURLsRequest {#yandex.cloud.video.v1.BatchGenerateDownloadURLsRequest}

```json
{
  "channelId": "string",
  "thumbnailIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| channelId | **string**

ID of the channel. ||
|| thumbnailIds[] | **string**

List of thumbnails IDs. ||
|#

## BatchGenerateDownloadURLsResponse {#yandex.cloud.video.v1.BatchGenerateDownloadURLsResponse}

```json
{
  "downloadUrls": [
    {
      "thumbnailId": "string",
      "downloadUrl": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| downloadUrls[] | **[ThumbnailDownloadURL](#yandex.cloud.video.v1.ThumbnailDownloadURL)**

List of download urls. ||
|#

## ThumbnailDownloadURL {#yandex.cloud.video.v1.ThumbnailDownloadURL}

#|
||Field | Description ||
|| thumbnailId | **string**

ID of the thumbnail. ||
|| downloadUrl | **string**

Download url. ||
|#