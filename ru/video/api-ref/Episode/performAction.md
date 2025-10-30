---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/episodes/{episodeId}:performAction
    method: post
    path:
      type: object
      properties:
        episodeId:
          description: |-
            **string**
            Required field. ID of the episode on which to perform the action.
          type: string
      required:
        - episodeId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        publish:
          description: |-
            **object**
            Publish the episode, making it available for watching.
            Changes the episode's visibility status to PUBLISHED.
            Includes only one of the fields `publish`, `unpublish`.
            Specifies which action to perform on the episode (exactly one must be chosen).
          $ref: '#/definitions/PublishEpisodeAction'
        unpublish:
          description: |-
            **object**
            Unpublish the episode, making it unavailable for watching.
            Changes the episode's visibility status to UNPUBLISHED.
            Includes only one of the fields `publish`, `unpublish`.
            Specifies which action to perform on the episode (exactly one must be chosen).
          $ref: '#/definitions/UnpublishEpisodeAction'
      additionalProperties: false
      oneOf:
        - required:
            - publish
        - required:
            - unpublish
    definitions:
      PublishEpisodeAction:
        type: object
        properties: {}
      UnpublishEpisodeAction:
        type: object
        properties: {}
sourcePath: en/_api-ref/video/v1/api-ref/Episode/performAction.md
---

# Video API, REST: Episode.PerformAction

Performs a specific action on an episode, such as publishing or unpublishing.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/episodes/{episodeId}:performAction
```

## Path parameters

#|
||Field | Description ||
|| episodeId | **string**

Required field. ID of the episode on which to perform the action. ||
|#

## Body parameters {#yandex.cloud.video.v1.PerformEpisodeActionRequest}

```json
{
  // Includes only one of the fields `publish`, `unpublish`
  "publish": "object",
  "unpublish": "object"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| publish | **object**

Publish the episode, making it available for watching.
Changes the episode's visibility status to PUBLISHED.

Includes only one of the fields `publish`, `unpublish`.

Specifies which action to perform on the episode (exactly one must be chosen). ||
|| unpublish | **object**

Unpublish the episode, making it unavailable for watching.
Changes the episode's visibility status to UNPUBLISHED.

Includes only one of the fields `publish`, `unpublish`.

Specifies which action to perform on the episode (exactly one must be chosen). ||
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
    "episodeId": "string"
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
    "streamId": "string",
    "lineId": "string",
    "title": "string",
    "description": "string",
    "thumbnailId": "string",
    "startTime": "string",
    "finishTime": "string",
    "dvrSeconds": "string",
    "visibilityStatus": "string",
    "stylePresetId": "string",
    // Includes only one of the fields `publicAccess`, `signUrlAccess`
    "publicAccess": "object",
    "signUrlAccess": "object",
    // end of the list of possible fields
    "createdAt": "string",
    "updatedAt": "string"
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
|| metadata | **[PerformEpisodeActionMetadata](#yandex.cloud.video.v1.PerformEpisodeActionMetadata)**

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
|| response | **[Episode](#yandex.cloud.video.v1.Episode)**

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

## PerformEpisodeActionMetadata {#yandex.cloud.video.v1.PerformEpisodeActionMetadata}

#|
||Field | Description ||
|| episodeId | **string**

ID of the episode on which the action is being performed.
This identifier can be used to track the action operation
and to verify that the action is being applied to the correct episode. ||
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

## Episode {#yandex.cloud.video.v1.Episode}

Entity representing a stream fragment that can be accessed independently.
Episodes can be linked to either a stream or a line
and provide a way to reference specific portions of the corresponding content.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the episode. ||
|| streamId | **string**

Identifier of the stream this episode is linked to.
Optional, empty if the episode is linked to a line. ||
|| lineId | **string**

Identifier of the line this episode is linked to.
Optional, empty if the episode is linked to a stream. ||
|| title | **string**

Title of the episode displayed in interfaces and players. ||
|| description | **string**

Detailed description of the episode content and context. ||
|| thumbnailId | **string**

Identifier of the thumbnail image used to represent the episode visually. ||
|| startTime | **string** (date-time)

Timestamp marking the beginning of the episode content.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| finishTime | **string** (date-time)

Timestamp marking the end of the episode content.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| dvrSeconds | **string** (int64)

Controls the Digital Video Recording (DVR) functionality for the episode.
Determines how many seconds of the stream are available for time-shifted viewing.

Possible values:
* `0`: Infinite DVR size, the full length of the stream is available for viewing.
* `>0`: Size of DVR window in seconds, the minimum value is 30s. ||
|| visibilityStatus | **enum** (VisibilityStatus)

Current visibility status controlling whether the episode is publicly available.

- `VISIBILITY_STATUS_UNSPECIFIED`: The visibility status is not specified.
- `PUBLISHED`: The episode is publicly available, subject to its access permission settings.
- `UNPUBLISHED`: The episode is available only to administrators. ||
|| stylePresetId | **string**

Identifier of the style preset used in the player during episode playback. ||
|| publicAccess | **object**

Allows unrestricted public access to the episode via direct link.
No additional authorization or access control is applied.

Includes only one of the fields `publicAccess`, `signUrlAccess`.

Specifies the episode access permission settings. ||
|| signUrlAccess | **object**

Restricts episode access using URL signatures for secure time-limited access.

Includes only one of the fields `publicAccess`, `signUrlAccess`.

Specifies the episode access permission settings. ||
|| createdAt | **string** (date-time)

Timestamp when the episode was initially created in the system.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp of the last modification to the episode or its metadata.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#