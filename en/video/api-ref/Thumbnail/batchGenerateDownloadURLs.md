---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/thumbnails:batchGenerateDownloadURLs
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            Required field. ID of the channel containing the thumbnails.
          type: string
        thumbnailIds:
          description: |-
            **string**
            List of thumbnail IDs for which to generate download URLs.
          type: array
          items:
            type: string
      required:
        - channelId
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Thumbnail/batchGenerateDownloadURLs.md
---

# Video API, REST: Thumbnail.BatchGenerateDownloadURLs

Generates download URLs for multiple thumbnails in a single request.
The response includes URLs for both original and scaled versions of each thumbnail.
This is useful for efficiently retrieving multiple thumbnails at once.

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

Required field. ID of the channel containing the thumbnails. ||
|| thumbnailIds[] | **string**

List of thumbnail IDs for which to generate download URLs. ||
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

List of download URLs for the requested thumbnails.
Each entry contains URLs for both the original image and various scaled versions. ||
|#

## ThumbnailDownloadURL {#yandex.cloud.video.v1.ThumbnailDownloadURL}

#|
||Field | Description ||
|| thumbnailId | **string**

ID of the thumbnail for which download URLs are provided. ||
|| originalUrl | **string**

URL for downloading the original, unmodified thumbnail image.
This provides access to the image at its original resolution and format. ||
|| scaledUrls[] | **[ScaledURL](#yandex.cloud.video.v1.ThumbnailDownloadURL.ScaledURL)**

List of URLs for downloading scaled versions of the thumbnail.
Different scaled versions are optimized for different display sizes and purposes. ||
|#

## ScaledURL {#yandex.cloud.video.v1.ThumbnailDownloadURL.ScaledURL}

Represents a URL for a specific scaled version of a thumbnail image.

#|
||Field | Description ||
|| url | **string**

URL for downloading this scaled version of the thumbnail. ||
|| maxWidth | **string** (int64)

Maximum width in pixels of the scaled image.
The actual width may be smaller to maintain the aspect ratio. ||
|| maxHeight | **string** (int64)

Maximum height in pixels of the scaled image.
The actual height may be smaller to maintain the aspect ratio. ||
|| imageFormat | **enum** (ImageFormat)

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