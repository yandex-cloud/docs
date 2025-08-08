---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/playlists/{playlistId}
    method: get
    path:
      type: object
      properties:
        playlistId:
          description: |-
            **string**
            Required field. ID of the playlist to retrieve.
          type: string
      required:
        - playlistId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Playlist/get.md
---

# Video API, REST: Playlist.Get

Retrieves detailed information about a specific playlist by its ID.
Returns all playlist metadata, items, and related information.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/playlists/{playlistId}
```

## Path parameters

#|
||Field | Description ||
|| playlistId | **string**

Required field. ID of the playlist to retrieve. ||
|#

## Response {#yandex.cloud.video.v1.Playlist}

**HTTP Code: 200 - OK**

```json
{
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
```

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
|| items[] | **[PlaylistItem](#yandex.cloud.video.v1.PlaylistItem)**

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