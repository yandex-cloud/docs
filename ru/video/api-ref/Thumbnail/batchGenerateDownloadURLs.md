---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Thumbnail/batchGenerateDownloadURLs.md
---

# Video API, REST: Thumbnail.BatchGenerateDownloadURLs

Generate urls for downloading images.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/thumbnails:batchGenerateDownloadURLs
```

## Body parameters {#yandex.cloud.video.v1.BatchGenerateDownloadURLsRequest}

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

Required field. ID of the channel. ||
|| thumbnailIds[] | **string**

List of thumbnails IDs. ||
|#

## Response {#yandex.cloud.video.v1.BatchGenerateDownloadURLsResponse}

**HTTP Code: 200 - OK**

```json
{
  "downloadUrls": [
    {
      "thumbnailId": "string",
      "originalUrl": "string",
      "scaledUrls": [
        {
          "url": "string",
          "maxWidth": "string",
          "maxHeight": "string",
          "imageFormat": "string"
        }
      ]
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
|| originalUrl | **string**

Original download url. ||
|| scaledUrls[] | **[ScaledURL](#yandex.cloud.video.v1.ThumbnailDownloadURL.ScaledURL)**

List of download urls, one per each available image size. ||
|#

## ScaledURL {#yandex.cloud.video.v1.ThumbnailDownloadURL.ScaledURL}

#|
||Field | Description ||
|| url | **string**

Download url. ||
|| maxWidth | **string** (int64)

Maximum width of the rectangle to inscribe the thumbnail into. ||
|| maxHeight | **string** (int64)

Maximum height of the rectangle to inscribe the thumbnail into. ||
|| imageFormat | **enum** (ImageFormat)

Image format.

- `IMAGE_FORMAT_UNSPECIFIED`: Image format unspecified.
- `JPEG`: JPEG image format.
- `WEBP`: WebP image format. ||
|#