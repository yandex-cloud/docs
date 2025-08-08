---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Thumbnail/batchGenerateDownloadURLs.md
---

# Video API, gRPC: ThumbnailService.BatchGenerateDownloadURLs

Generates download URLs for multiple thumbnails in a single request.
The response includes URLs for both original and scaled versions of each thumbnail.
This is useful for efficiently retrieving multiple thumbnails at once.

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

Required field. ID of the channel containing the thumbnails. ||
|| thumbnail_ids[] | **string**

List of thumbnail IDs for which to generate download URLs. ||
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

List of download URLs for the requested thumbnails.
Each entry contains URLs for both the original image and various scaled versions. ||
|#

## ThumbnailDownloadURL {#yandex.cloud.video.v1.ThumbnailDownloadURL}

#|
||Field | Description ||
|| thumbnail_id | **string**

ID of the thumbnail for which download URLs are provided. ||
|| original_url | **string**

URL for downloading the original, unmodified thumbnail image.
This provides access to the image at its original resolution and format. ||
|| scaled_urls[] | **[ScaledURL](#yandex.cloud.video.v1.ThumbnailDownloadURL.ScaledURL)**

List of URLs for downloading scaled versions of the thumbnail.
Different scaled versions are optimized for different display sizes and purposes. ||
|#

## ScaledURL {#yandex.cloud.video.v1.ThumbnailDownloadURL.ScaledURL}

Represents a URL for a specific scaled version of a thumbnail image.

#|
||Field | Description ||
|| url | **string**

URL for downloading this scaled version of the thumbnail. ||
|| max_width | **int64**

Maximum width in pixels of the scaled image.
The actual width may be smaller to maintain the aspect ratio. ||
|| max_height | **int64**

Maximum height in pixels of the scaled image.
The actual height may be smaller to maintain the aspect ratio. ||
|| image_format | enum **ImageFormat**

Format of the scaled image (JPEG, WebP, etc.).
Different formats offer different trade-offs between quality and file size.

- `IMAGE_FORMAT_UNSPECIFIED`: The image format is not specified.
- `JPEG`: JPEG image format.
Provides good compression with some quality loss.
Widely supported across all platforms and browsers.
- `WEBP`: WebP image format.
Provides better compression than JPEG with similar quality.
May not be supported on all platforms and older browsers. ||
|#