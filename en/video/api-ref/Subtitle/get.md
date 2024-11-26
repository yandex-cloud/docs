---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Subtitle/get.md
---

# Video API, REST: Subtitle.Get

Return a specific subtitle.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/subtitles/{subtitleId}
```

## Path parameters

#|
||Field | Description ||
|| subtitleId | **string**

Required field. ID of the subtitle. ||
|#

## Response {#yandex.cloud.video.v1.Subtitle}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "language": "string",
  "label": "string",
  "status": "string",
  "filename": "string",
  "createdAt": "string",
  "updatedAt": "string",
  // Includes only one of the fields `videoId`
  "videoId": "string"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| id | **string**

ID of the subtitle. ||
|| language | **string**

Subtitle language represented as a three-letter ISO 639-3 code. ||
|| label | **string**

Subtitle caption to be displayed on screen during video playback. ||
|| status | **enum** (SubtitleStatus)

Subtitle status.

- `SUBTITLE_STATUS_UNSPECIFIED`: Subtitle status unspecified.
- `WAIT_UPLOADING`: Waiting for all the bytes to be loaded.
- `UPLOADED`: Uploading is complete. ||
|| filename | **string**

Subtitle filename. ||
|| createdAt | **string** (date-time)

Time when subtitle was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Time of last subtitle update.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| videoId | **string**

ID of the video.

Includes only one of the fields `videoId`. ||
|#