---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Thumbnail/list.md
---

# Video API, REST: Thumbnail.List {#List}

List thumbnails for channel.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/thumbnails
```

## Query parameters {#yandex.cloud.video.v1.ListThumbnailRequest}

#|
||Field | Description ||
|| channelId | **string**

ID of the channel. ||
|| pageSize | **string** (int64)

The maximum number of the results per page to return. Default value: 100. ||
|| pageToken | **string**

Page token for getting the next page of the result. ||
|#

## Response {#yandex.cloud.video.v1.ListThumbnailResponse}

**HTTP Code: 200 - OK**

```json
{
  "thumbnails": [
    {
      "id": "string",
      "channelId": "string",
      "createdAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| thumbnails[] | **[Thumbnail](#yandex.cloud.video.v1.Thumbnail)**

List of thumbnails. ||
|| nextPageToken | **string**

Token for getting the next page. ||
|#

## Thumbnail {#yandex.cloud.video.v1.Thumbnail}

#|
||Field | Description ||
|| id | **string**

ID of the thumbnail. ||
|| channelId | **string**

ID of the channel where the thumbnail was created. ||
|| createdAt | **string** (date-time)

Time when thumbnail was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#