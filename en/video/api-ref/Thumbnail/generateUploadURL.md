---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/thumbnails/{thumbnailId}:generateUploadURL
    method: post
    path:
      type: object
      properties:
        thumbnailId:
          description: |-
            **string**
            Required field. ID of the thumbnail for which to generate an upload URL.
            The thumbnail record must already exist, typically created using the Create method.
          type: string
      required:
        - thumbnailId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Thumbnail/generateUploadURL.md
---

# Video API, REST: Thumbnail.GenerateUploadURL

Generates a URL for uploading an image to an existing thumbnail record.
This URL can be used to upload the actual image file using an HTTP PUT request.
The URL is pre-signed and has a limited validity period.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/thumbnails/{thumbnailId}:generateUploadURL
```

## Path parameters

#|
||Field | Description ||
|| thumbnailId | **string**

Required field. ID of the thumbnail for which to generate an upload URL.
The thumbnail record must already exist, typically created using the Create method. ||
|#

## Response {#yandex.cloud.video.v1.GenerateThumbnailUploadURLResponse}

**HTTP Code: 200 - OK**

```json
{
  "uploadUrl": "string"
}
```

#|
||Field | Description ||
|| uploadUrl | **string**

Pre-signed URL for uploading the thumbnail image.
This URL can be used with an HTTP PUT request to upload the image file.
The URL has a limited validity period and will expire after a certain time. ||
|#