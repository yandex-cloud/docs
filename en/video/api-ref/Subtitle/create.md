---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/subtitles
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        language:
          description: |-
            **string**
            Subtitle language represented as a three-letter code according to ISO 639-2/T.
          pattern: ara|deu|eng|fra|ita|jpn|kaz|kor|rus|spa|tur|ukr|zho
          type: string
        label:
          description: |-
            **string**
            Contains the subtitle label (or title) that will be displayed on screen during video playback.
            Should provide a concise and accurate representation of the spoken content.
            If not provided, it will be auto-generated based on the specified language.
          type: string
        videoId:
          description: |-
            **string**
            ID of the video.
            Includes only one of the fields `videoId`.
          type: string
        upload:
          description: |-
            **[SubtitleUploadParams](/docs/video/api-ref/Subtitle/create#yandex.cloud.video.v1.SubtitleUploadParams)**
            Upload subtitle.
            Includes only one of the fields `upload`.
            Source type.
          $ref: '#/definitions/SubtitleUploadParams'
      additionalProperties: false
    definitions:
      SubtitleUploadParams:
        type: object
        properties:
          filename:
            description: |-
              **string**
              Required field. Original filename of the subtitle file being uploaded.
            type: string
        required:
          - filename
sourcePath: en/_api-ref/video/v1/api-ref/Subtitle/create.md
---

# Video API, REST: Subtitle.Create

Creates a new subtitle record for a specific video.
This method only creates the metadata record; the actual subtitle file must be uploaded
using the URL obtained from the GenerateUploadURL method.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/subtitles
```

## Body parameters {#yandex.cloud.video.v1.CreateSubtitleRequest}

```json
{
  "language": "string",
  "label": "string",
  // Includes only one of the fields `videoId`
  "videoId": "string",
  // end of the list of possible fields
  // Includes only one of the fields `upload`
  "upload": {
    "filename": "string"
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| language | **string**

Subtitle language represented as a three-letter code according to ISO 639-2/T. ||
|| label | **string**

Contains the subtitle label (or title) that will be displayed on screen during video playback.
Should provide a concise and accurate representation of the spoken content.
If not provided, it will be auto-generated based on the specified language. ||
|| videoId | **string**

ID of the video.

Includes only one of the fields `videoId`. ||
|| upload | **[SubtitleUploadParams](#yandex.cloud.video.v1.SubtitleUploadParams)**

Upload subtitle.

Includes only one of the fields `upload`.

Source type. ||
|#

## SubtitleUploadParams {#yandex.cloud.video.v1.SubtitleUploadParams}

#|
||Field | Description ||
|| filename | **string**

Required field. Original filename of the subtitle file being uploaded. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "subtitleId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateSubtitleMetadata](#yandex.cloud.video.v1.CreateSubtitleMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Subtitle](#yandex.cloud.video.v1.Subtitle)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateSubtitleMetadata {#yandex.cloud.video.v1.CreateSubtitleMetadata}

#|
||Field | Description ||
|| subtitleId | **string**

ID of the subtitle being created. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
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