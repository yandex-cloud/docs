---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/subtitles/{subtitleId}
    method: get
    path:
      type: object
      properties:
        subtitleId:
          description: |-
            **string**
            Required field. ID of the subtitle to retrieve.
          type: string
      required:
        - subtitleId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Subtitle/get.md
---

# Video API, REST: Subtitle.Get

Retrieves detailed information about a specific subtitle by its ID.
Returns all subtitle metadata and related information.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/subtitles/{subtitleId}
```

## Path parameters

#|
||Field | Description ||
|| subtitleId | **string**

Required field. ID of the subtitle to retrieve. ||
|#

## Response {#yandex.cloud.video.v1.Subtitle}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "language": "string",
  "label": "string",
  "status": "string",
  "sourceType": "string",
  "filename": "string",
  "createdAt": "string",
  "updatedAt": "string",
  // Includes only one of the fields `videoId`
  "videoId": "string"
  // end of the list of possible fields
}
```

Entity representing a subtitle track that can be associated with a video.
Subtitles provide text versions of the audio content, enabling accessibility
and multilingual support for video content.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the subtitle track. ||
|| language | **string**

Language of the subtitle content according to ISO 639-2/T. ||
|| label | **string**

Display label for the subtitle track shown in the video player's subtitle selection menu. ||
|| status | **enum** (SubtitleStatus)

Current processing status of the subtitle.

- `SUBTITLE_STATUS_UNSPECIFIED`: The subtitle status is not specified.
- `WAIT_UPLOADING`: The subtitle file upload is in progress, waiting for all bytes to be received.
- `UPLOADED`: The subtitle file has been fully uploaded and is ready for use. ||
|| sourceType | **enum** (SubtitleSourceType)

Indicates how the subtitle was created or obtained.

- `SUBTITLE_SOURCE_TYPE_UNSPECIFIED`: The subtitle source type is not specified.
- `MANUAL`: The subtitle was manually created and uploaded by a user.
- `GENERATED`: The subtitle was automatically generated through speech recognition. ||
|| filename | **string**

Original filename of the subtitle file. ||
|| createdAt | **string** (date-time)

Timestamp when the subtitle was initially created in the system.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp of the last modification to the subtitle or its metadata.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| videoId | **string**

Identifier of the video this subtitle belongs to.

Includes only one of the fields `videoId`.

Specifies the parent content this subtitle is associated with. ||
|#