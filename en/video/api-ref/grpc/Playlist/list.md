---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Playlist/list.md
---

# Video API, gRPC: PlaylistService.List

List playlists for a channel.

## gRPC request

**rpc List ([ListPlaylistsRequest](#yandex.cloud.video.v1.ListPlaylistsRequest)) returns ([ListPlaylistsResponse](#yandex.cloud.video.v1.ListPlaylistsResponse))**

## ListPlaylistsRequest {#yandex.cloud.video.v1.ListPlaylistsRequest}

```json
{
  "channel_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel. ||
|| page_size | **int64**

The maximum number of the results per page to return.
Default value: 100. ||
|| page_token | **string**

Page token for getting the next page of the result. ||
|| order_by | **string**

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

## ListPlaylistsResponse {#yandex.cloud.video.v1.ListPlaylistsResponse}

```json
{
  "playlists": [
    {
      "id": "string",
      "channel_id": "string",
      "title": "string",
      "description": "string",
      "items": [
        {
          // Includes only one of the fields `video_id`, `episode_id`
          "video_id": "string",
          "episode_id": "string",
          // end of the list of possible fields
          "position": "int64"
        }
      ],
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| playlists[] | **[Playlist](#yandex.cloud.video.v1.Playlist)**

List of playlists for specific channel. ||
|| next_page_token | **string**

Token for getting the next page. ||
|#

## Playlist {#yandex.cloud.video.v1.Playlist}

Entity representing an ordered list of videos or episodes.

#|
||Field | Description ||
|| id | **string**

ID of the playlist. ||
|| channel_id | **string**

ID of the channel to create the playlist in. ||
|| title | **string**

Playlist title. ||
|| description | **string**

Playlist description. ||
|| items[] | **[PlaylistItem](#yandex.cloud.video.v1.PlaylistItem)**

List of playlist items. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when playlist was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last playlist update. ||
|#

## PlaylistItem {#yandex.cloud.video.v1.PlaylistItem}

#|
||Field | Description ||
|| video_id | **string**

ID of the video.

Includes only one of the fields `video_id`, `episode_id`. ||
|| episode_id | **string**

ID of the episode.

Includes only one of the fields `video_id`, `episode_id`. ||
|| position | **int64**

Item position (zero-indexed). ||
|#