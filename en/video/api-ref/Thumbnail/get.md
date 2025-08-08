---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/thumbnails/{thumbnailId}
    method: get
    path:
      type: object
      properties:
        thumbnailId:
          description: |-
            **string**
            Required field. ID of the thumbnail to retrieve.
            Must be a valid thumbnail identifier string.
          type: string
      required:
        - thumbnailId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Thumbnail/get.md
---

# Video API, REST: Thumbnail.Get

Retrieves detailed information about a specific thumbnail by its ID.
Returns all thumbnail metadata and related information.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/thumbnails/{thumbnailId}
```

## Path parameters

#|
||Field | Description ||
|| thumbnailId | **string**

Required field. ID of the thumbnail to retrieve.
Must be a valid thumbnail identifier string. ||
|#

## Response {#yandex.cloud.video.v1.Thumbnail}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "channelId": "string",
  // Includes only one of the fields `episodeId`, `videoId`
  "episodeId": "string",
  "videoId": "string",
  // end of the list of possible fields
  "createdAt": "string"
}
```

Entity representing an image used as a visual representation for various content entities.
Thumbnails provide preview images for channels, streams, episodes, videos, and stream lines.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the thumbnail. ||
|| channelId | **string**

Identifier of the channel where the thumbnail is created and managed. ||
|| episodeId | **string**

ID of the episode which the thumbnail is associated with.

Includes only one of the fields `episodeId`, `videoId`. ||
|| videoId | **string**

ID of the video which the thumbnail is associated with.

Includes only one of the fields `episodeId`, `videoId`. ||
|| createdAt | **string** (date-time)

Timestamp when the thumbnail was initially created in the system.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#