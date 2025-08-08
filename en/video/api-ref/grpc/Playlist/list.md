---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Playlist/list.md
---

# Video API, gRPC: PlaylistService.List

Lists all playlists in a specific channel with pagination support.
Results can be filtered and sorted using the provided parameters.

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

Required field. ID of the channel containing the playlists to list. ||
|| page_size | **int64**

The maximum number of playlists to return per page. ||
|| page_token | **string**

Page token for retrieving the next page of results.
This token is obtained from the next_page_token field in the previous ListPlaylistsResponse. ||
|| order_by | **string**

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
      "style_preset_id": "string",
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

List of playlists matching the request criteria.
May be empty if no playlists match the criteria or if the channel has no playlists. ||
|| next_page_token | **string**

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
|| channel_id | **string**

Identifier of the channel where this playlist is created and managed. ||
|| title | **string**

Title of the playlist displayed in interfaces and players. ||
|| description | **string**

Detailed description of the playlist's content and purpose. ||
|| items[] | **[PlaylistItem](#yandex.cloud.video.v1.PlaylistItem)**

Ordered list of content items included in this playlist. ||
|| style_preset_id | **string**

Identifier of the style preset used in the player during playlist playback. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the playlist was initially created in the system. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the last modification to the playlist or its metadata. ||
|#

## PlaylistItem {#yandex.cloud.video.v1.PlaylistItem}

Represents a single item in a playlist.
Each item references either a video or an episode and specifies its position in the sequence.

#|
||Field | Description ||
|| video_id | **string**

Identifier of a video included in the playlist.

Includes only one of the fields `video_id`, `episode_id`.

Specifies the content identifier type for this playlist item. ||
|| episode_id | **string**

Identifier of an episode included in the playlist.

Includes only one of the fields `video_id`, `episode_id`.

Specifies the content identifier type for this playlist item. ||
|| position | **int64**

Position of this item in the playlist sequence (zero-indexed).
Determines the playback order of content in the playlist. ||
|#