---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/subtitles
    method: get
    path: null
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of subtitles to return per page.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token for retrieving the next page of results.
            This token is obtained from the next_page_token field in the previous ListSubtitlesResponse.
          type: string
        videoId:
          description: |-
            **string**
            ID of the video containing the subtitles to list.
            Includes only one of the fields `videoId`.
            Specifies the parent resource to list subtitles from (exactly one must be chosen).
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Subtitle/list.md
---

# Video API, REST: Subtitle.List

Lists all subtitles associated with a specific video with pagination support.
Results can be filtered and sorted using the provided parameters.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/subtitles
```

## Query parameters {#yandex.cloud.video.v1.ListSubtitlesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of subtitles to return per page. ||
|| pageToken | **string**

Page token for retrieving the next page of results.
This token is obtained from the next_page_token field in the previous ListSubtitlesResponse. ||
|| videoId | **string**

ID of the video containing the subtitles to list.

Includes only one of the fields `videoId`.

Specifies the parent resource to list subtitles from (exactly one must be chosen). ||
|#

## Response {#yandex.cloud.video.v1.ListSubtitlesResponse}

**HTTP Code: 200 - OK**

```json
{
  "subtitles": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| subtitles[] | **[Subtitle](#yandex.cloud.video.v1.Subtitle)**

List of subtitles matching the request criteria.
May be empty if no subtitles match the criteria or if the video has no subtitles. ||
|| nextPageToken | **string**

Token for retrieving the next page of results.
Empty if there are no more results available. ||
|#

## Subtitle {#yandex.cloud.video.v1.Subtitle}

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