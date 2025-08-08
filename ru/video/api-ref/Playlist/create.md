---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/playlists
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            Required field. ID of the channel where the playlist will be created.
          type: string
        title:
          description: |-
            **string**
            Required field. Title of the playlist to be displayed in interfaces and players.
          type: string
        description:
          description: |-
            **string**
            Detailed description of the playlist content and context.
            Optional field that can provide additional information about the playlist.
          type: string
        items:
          description: |-
            **[PlaylistItem](/docs/video/api-ref/Playlist/get#yandex.cloud.video.v1.PlaylistItem)**
            List of items to include in the playlist.
            Each item represents a video or episode to be played in sequence.
            The order of items in this list determines the playback order.
          type: array
          items:
            oneOf:
              - type: object
                properties:
                  videoId:
                    description: |-
                      **string**
                      Identifier of a video included in the playlist.
                      Includes only one of the fields `videoId`, `episodeId`.
                      Specifies the content identifier type for this playlist item.
                    type: string
                  episodeId:
                    description: |-
                      **string**
                      Identifier of an episode included in the playlist.
                      Includes only one of the fields `videoId`, `episodeId`.
                      Specifies the content identifier type for this playlist item.
                    type: string
        stylePresetId:
          description: |-
            **string**
            ID of the style preset to be applied to the playlist player.
            Style presets control the visual appearance of the player.
          type: string
      required:
        - channelId
        - title
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Playlist/create.md
---

# Video API, REST: Playlist.Create

Creates a new playlist in the specified channel with the provided items.
Playlists can contain videos, episodes, or a mix of both content types.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/playlists
```

## Body parameters {#yandex.cloud.video.v1.CreatePlaylistRequest}

```json
{
  "channelId": "string",
  "title": "string",
  "description": "string",
  "items": [
    {
      // Includes only one of the fields `videoId`, `episodeId`
      "videoId": "string",
      "episodeId": "string",
      // end of the list of possible fields
      "position": "string"
    }
  ],
  "stylePresetId": "string"
}
```

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel where the playlist will be created. ||
|| title | **string**

Required field. Title of the playlist to be displayed in interfaces and players. ||
|| description | **string**

Detailed description of the playlist content and context.
Optional field that can provide additional information about the playlist. ||
|| items[] | **[PlaylistItem](#yandex.cloud.video.v1.PlaylistItem)**

List of items to include in the playlist.
Each item represents a video or episode to be played in sequence.
The order of items in this list determines the playback order. ||
|| stylePresetId | **string**

ID of the style preset to be applied to the playlist player.
Style presets control the visual appearance of the player. ||
|#

## PlaylistItem {#yandex.cloud.video.v1.PlaylistItem}

Represents a single item in a playlist.
Each item references either a video or an episode and specifies its position in the sequence.

#|
||Field | Description ||
|| videoId | **string**

Identifier of a video included in the playlist.

Includes only one of the fields `videoId`, `episodeId`.

Specifies the content identifier type for this playlist item. ||
|| episodeId | **string**

Identifier of an episode included in the playlist.

Includes only one of the fields `videoId`, `episodeId`.

Specifies the content identifier type for this playlist item. ||
|| position | **string** (int64)

Position of this item in the playlist sequence (zero-indexed).
Determines the playback order of content in the playlist. ||
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
    "playlistId": "string"
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
    "title": "string",
    "description": "string",
    "items": [
      {
        // Includes only one of the fields `videoId`, `episodeId`
        "videoId": "string",
        "episodeId": "string",
        // end of the list of possible fields
        "position": "string"
      }
    ],
    "stylePresetId": "string",
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
|| metadata | **[CreatePlaylistMetadata](#yandex.cloud.video.v1.CreatePlaylistMetadata)**

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
|| response | **[Playlist](#yandex.cloud.video.v1.Playlist)**

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

## CreatePlaylistMetadata {#yandex.cloud.video.v1.CreatePlaylistMetadata}

#|
||Field | Description ||
|| playlistId | **string**

ID of the playlist being created. ||
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

## Playlist {#yandex.cloud.video.v1.Playlist}

Entity representing an ordered collection of videos or episodes.
Playlists allow organizing content into sequences for improved user experience.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the playlist. ||
|| channelId | **string**

Identifier of the channel where this playlist is created and managed. ||
|| title | **string**

Title of the playlist displayed in interfaces and players. ||
|| description | **string**

Detailed description of the playlist's content and purpose. ||
|| items[] | **[PlaylistItem](#yandex.cloud.video.v1.PlaylistItem2)**

Ordered list of content items included in this playlist. ||
|| stylePresetId | **string**

Identifier of the style preset used in the player during playlist playback. ||
|| createdAt | **string** (date-time)

Timestamp when the playlist was initially created in the system.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp of the last modification to the playlist or its metadata.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## PlaylistItem {#yandex.cloud.video.v1.PlaylistItem2}

Represents a single item in a playlist.
Each item references either a video or an episode and specifies its position in the sequence.

#|
||Field | Description ||
|| videoId | **string**

Identifier of a video included in the playlist.

Includes only one of the fields `videoId`, `episodeId`.

Specifies the content identifier type for this playlist item. ||
|| episodeId | **string**

Identifier of an episode included in the playlist.

Includes only one of the fields `videoId`, `episodeId`.

Specifies the content identifier type for this playlist item. ||
|| position | **string** (int64)

Position of this item in the playlist sequence (zero-indexed).
Determines the playback order of content in the playlist. ||
|#