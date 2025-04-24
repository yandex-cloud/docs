---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Playlist/list.md
---

# Video API, REST: Playlist.List

List playlists for a channel.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/playlists
```

## Query parameters {#yandex.cloud.video.v1.ListPlaylistsRequest}

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel. ||
|| pageSize | **string** (int64)

The maximum number of the results per page to return.
Default value: 100. ||
|| pageToken | **string**

Page token for getting the next page of the result. ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction,
format is "<field> <order>" (e.g. "createdAt desc").
Default: "id asc".
Possible fields: ["id", "title", "createdAt", "updatedAt"].
Both snake_case and camelCase are supported for fields. ||
|| filter | **string**

Filter expression that filters resources listed in the response.
Expressions are composed of terms connected by logic operators.
If value contains spaces or quotes,
it should be in quotes (`'` or `"`) with the inner quotes being backslash escaped.
Supported logical operators: ["AND", "OR"].
Supported string match operators: ["=", "!=", ":"].
Operator ":" stands for substring matching.
Filter expressions may also contain parentheses to group logical operands.
Example: `key1='value' AND (key2!='\'value\'' OR key2:"\"value\"")`
Supported fields: ["id", "title"].
Both snake_case and camelCase are supported for fields. ||
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

List of playlists for specific channel. ||
|| nextPageToken | **string**

Token for getting the next page. ||
|#

## Playlist {#yandex.cloud.video.v1.Playlist}

Entity representing an ordered list of videos or episodes.

#|
||Field | Description ||
|| id | **string**

ID of the playlist. ||
|| channelId | **string**

ID of the channel to create the playlist in. ||
|| title | **string**

Playlist title. ||
|| description | **string**

Playlist description. ||
|| items[] | **[PlaylistItem](#yandex.cloud.video.v1.PlaylistItem)**

List of playlist items. ||
|| createdAt | **string** (date-time)

Time when playlist was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Time of last playlist update.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## PlaylistItem {#yandex.cloud.video.v1.PlaylistItem}

#|
||Field | Description ||
|| videoId | **string**

ID of the video.

Includes only one of the fields `videoId`, `episodeId`. ||
|| episodeId | **string**

ID of the episode.

Includes only one of the fields `videoId`, `episodeId`. ||
|| position | **string** (int64)

Item position (zero-indexed). ||
|#