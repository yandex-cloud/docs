---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/thumbnails
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            [Deprecated] ID of the channel.
          type: string
        episodeId:
          description: |-
            **string**
            ID of the episode to associate the thumbnail with.
            Includes only one of the fields `episodeId`, `videoId`.
          type: string
        videoId:
          description: |-
            **string**
            ID of the video to associate the thumbnail with.
            Includes only one of the fields `episodeId`, `videoId`.
          type: string
      additionalProperties: false
      oneOf:
        - required:
            - episodeId
        - required:
            - videoId
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Thumbnail/create.md
---

# Video API, REST: Thumbnail.Create

Creates a new thumbnail record for a specific resource.
This method only creates the metadata record; the actual image must be uploaded
using the URL obtained from the GenerateUploadURL method.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/thumbnails
```

## Body parameters {#yandex.cloud.video.v1.CreateThumbnailRequest}

```json
{
  "channelId": "string",
  // Includes only one of the fields `episodeId`, `videoId`
  "episodeId": "string",
  "videoId": "string"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| channelId | **string**

[Deprecated] ID of the channel. ||
|| episodeId | **string**

ID of the episode to associate the thumbnail with.

Includes only one of the fields `episodeId`, `videoId`. ||
|| videoId | **string**

ID of the video to associate the thumbnail with.

Includes only one of the fields `episodeId`, `videoId`. ||
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
    "thumbnailId": "string"
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
    "channelId": "string",
    // Includes only one of the fields `episodeId`, `videoId`
    "episodeId": "string",
    "videoId": "string",
    // end of the list of possible fields
    "createdAt": "string"
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
|| metadata | **[CreateThumbnailMetadata](#yandex.cloud.video.v1.CreateThumbnailMetadata)**

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
|| response | **[Thumbnail](#yandex.cloud.video.v1.Thumbnail)**

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

## CreateThumbnailMetadata {#yandex.cloud.video.v1.CreateThumbnailMetadata}

#|
||Field | Description ||
|| thumbnailId | **string**

ID of the thumbnail being created. ||
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