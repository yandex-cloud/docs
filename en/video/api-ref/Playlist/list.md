---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/playlists
    method: get
    path: null
    query:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            Required field. ID of the channel containing the playlists to list.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of playlists to return per page.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token for retrieving the next page of results.
            This token is obtained from the next_page_token field in the previous ListPlaylistsResponse.
          type: string
        orderBy:
          description: |-
            **string**
            Specifies the ordering of results.
            Format is "<field> <order>" (e.g., "createdAt desc").
            Default: "id asc".
            Supported fields: ["id", "title", "createdAt", "updatedAt"].
            Both snake_case and camelCase field names are supported.
          type: string
        filter:
          description: |-
            **string**
            Filter expression to narrow down the list of returned playlists.
            Expressions consist of terms connected by logical operators.
            Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
            with inner quotes being backslash-escaped.
            Supported logical operators: ["AND", "OR"].
            Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
            Parentheses can be used to group logical expressions.
            Example: `title:'highlights' AND id='playlist-1'`
            Filterable fields: ["id", "title"].
            Both snake_case and camelCase field names are supported.
          type: string
      required:
        - channelId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Playlist/list.md
---

# Video API, REST: Playlist.List

Lists all playlists in a specific channel with pagination support.
Results can be filtered and sorted using the provided parameters.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/playlists
```

## Query parameters {#yandex.cloud.video.v1.ListPlaylistsRequest}

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel containing the playlists to list. ||
|| pageSize | **string** (int64)

The maximum number of playlists to return per page. ||
|| pageToken | **string**

Page token for retrieving the next page of results.
This token is obtained from the next_page_token field in the previous ListPlaylistsResponse. ||
|| orderBy | **string**

Specifies the ordering of results.
Format is "<field> <order>" (e.g., "createdAt desc").
Default: "id asc".
Supported fields: ["id", "title", "createdAt", "updatedAt"].
Both snake_case and camelCase field names are supported. ||
|| filter | **string**

Filter expression to narrow down the list of returned playlists.
Expressions consist of terms connected by logical operators.
Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
with inner quotes being backslash-escaped.

Supported logical operators: ["AND", "OR"].
Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
Parentheses can be used to group logical expressions.

Example: `title:'highlights' AND id='playlist-1'`

Filterable fields: ["id", "title"].
Both snake_case and camelCase field names are supported. ||
|#

## Response {#yandex.cloud.video.v1.ListPlaylistsResponse}

**HTTP Code: 200 - OK**

```json
{
  "playlists": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| playlists[] | **[Playlist](#yandex.cloud.video.v1.Playlist)**

List of playlists matching the request criteria.
May be empty if no playlists match the criteria or if the channel has no playlists. ||
|| nextPageToken | **string**

Token for retrieving the next page of results.
Empty if there are no more results available. ||
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