---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Thumbnail/batchGenerateDownloadURLs.md
---

# Video API, REST: Thumbnail.BatchGenerateDownloadURLs {#BatchGenerateDownloadURLs}

Generate urls for download images.

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

ID of the channel. ||
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