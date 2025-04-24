---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Thumbnail/batchGenerateDownloadURLs.md
---

# Video API, gRPC: ThumbnailService.BatchGenerateDownloadURLs

Generate urls for downloading images.

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
      "original_url": "string",
      "scaled_urls": [
        {
          "url": "string",
          "max_width": "int64",
          "max_height": "int64",
          "image_format": "ImageFormat"
        }
      ]
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
|| original_url | **string**

Original download url. ||
|| scaled_urls[] | **[ScaledURL](#yandex.cloud.video.v1.ThumbnailDownloadURL.ScaledURL)**

List of download urls, one per each available image size. ||
|#

## ScaledURL {#yandex.cloud.video.v1.ThumbnailDownloadURL.ScaledURL}

#|
||Field | Description ||
|| url | **string**

Download url. ||
|| max_width | **int64**

Maximum width of the rectangle to inscribe the thumbnail into. ||
|| max_height | **int64**

Maximum height of the rectangle to inscribe the thumbnail into. ||
|| image_format | enum **ImageFormat**

Image format.

- `IMAGE_FORMAT_UNSPECIFIED`: Image format unspecified.
- `JPEG`: JPEG image format.
- `WEBP`: WebP image format. ||
|#