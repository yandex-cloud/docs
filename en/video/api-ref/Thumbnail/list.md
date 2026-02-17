---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/thumbnails
    method: get
    path: null
    query:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            [Deprecated] ID of the channel.
            The maximum string length in characters is 50.
          type: string
        episodeId:
          description: |-
            **string**
            ID of the episode containing the thumbnails to list.
            The maximum string length in characters is 50.
            Includes only one of the fields `episodeId`, `videoId`.
          type: string
        videoId:
          description: |-
            **string**
            ID of the video containing the thumbnails to list.
            The maximum string length in characters is 50.
            Includes only one of the fields `episodeId`, `videoId`.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of thumbnails to return per page.
            The maximum value is 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token for retrieving the next page of results.
            This token is obtained from the next_page_token field in the previous ListThumbnailResponse.
            The maximum string length in characters is 15000.
          type: string
      additionalProperties: false
      oneOf:
        - required:
            - episodeId
        - required:
            - videoId
    body: null
    definitions: null
---

# Video API, REST: Thumbnail.List

Lists all thumbnails associated with a specific resource (channel, stream, video, etc.)
with pagination support.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/thumbnails
```

## Query parameters {#yandex.cloud.video.v1.ListThumbnailRequest}

#|
||Field | Description ||
|| channelId | **string**

[Deprecated] ID of the channel.

The maximum string length in characters is 50. ||
|| episodeId | **string**

ID of the episode containing the thumbnails to list.

The maximum string length in characters is 50.

Includes only one of the fields `episodeId`, `videoId`. ||
|| videoId | **string**

ID of the video containing the thumbnails to list.

The maximum string length in characters is 50.

Includes only one of the fields `episodeId`, `videoId`. ||
|| pageSize | **string** (int64)

The maximum number of thumbnails to return per page.

The maximum value is 100. ||
|| pageToken | **string**

Page token for retrieving the next page of results.
This token is obtained from the next_page_token field in the previous ListThumbnailResponse.

The maximum string length in characters is 15000. ||
|#

## Response {#yandex.cloud.video.v1.ListThumbnailResponse}

**HTTP Code: 200 - OK**

```json
{
  "thumbnails": [
    {
      "id": "string",
      "channelId": "string",
      // Includes only one of the fields `episodeId`, `videoId`
      "episodeId": "string",
      "videoId": "string",
      // end of the list of possible fields
      "createdAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| thumbnails[] | **[Thumbnail](#yandex.cloud.video.v1.Thumbnail)**

List of thumbnails matching the request criteria.
May be empty if no thumbnails match the criteria or if the parent resource has no thumbnails. ||
|| nextPageToken | **string**

Token for retrieving the next page of results.
Empty if there are no more results available. ||
|#

## Thumbnail {#yandex.cloud.video.v1.Thumbnail}

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