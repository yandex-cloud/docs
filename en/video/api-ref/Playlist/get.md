---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Playlist/get.md
---

# Video API, REST: Playlist.Get

Returns the specific playlist.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/playlists/{playlistId}
```

## Path parameters

#|
||Field | Description ||
|| playlistId | **string**

Required field. ID of the playlist. ||
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
  "createdAt": "string",
  "updatedAt": "string"
}
```

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