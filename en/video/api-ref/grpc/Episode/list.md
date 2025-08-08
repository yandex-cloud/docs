---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Episode/list.md
---

# Video API, gRPC: EpisodeService.List

Lists all episodes associated with a specific stream or stream line with pagination support.
Results can be filtered and sorted using the provided parameters.

## gRPC request

**rpc List ([ListEpisodesRequest](#yandex.cloud.video.v1.ListEpisodesRequest)) returns ([ListEpisodesResponse](#yandex.cloud.video.v1.ListEpisodesResponse))**

## ListEpisodesRequest {#yandex.cloud.video.v1.ListEpisodesRequest}

```json
{
  // Includes only one of the fields `stream_id`, `line_id`
  "stream_id": "string",
  "line_id": "string",
  // end of the list of possible fields
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| stream_id | **string**

ID of the stream containing the episodes to list.

Includes only one of the fields `stream_id`, `line_id`.

Specifies the parent resource to list episodes from (exactly one must be chosen). ||
|| line_id | **string**

ID of the stream line containing the episodes to list.

Includes only one of the fields `stream_id`, `line_id`.

Specifies the parent resource to list episodes from (exactly one must be chosen). ||
|| page_size | **int64**

The maximum number of episodes to return per page. ||
|| page_token | **string**

Page token for retrieving the next page of results.
This token is obtained from the next_page_token field in the previous ListEpisodesResponse. ||
|| order_by | **string**

Specifies the ordering of results.
Format is "<field> <order>" (e.g., "createdAt desc").
Default: "id asc".
Supported fields: ["id", "createdAt", "updatedAt"].
Both snake_case and camelCase field names are supported. ||
|| filter | **string**

Filter expression to narrow down the list of returned episodes.
Expressions consist of terms connected by logical operators.
Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
with inner quotes being backslash-escaped.

Supported logical operators: ["AND", "OR"].
Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
Parentheses can be used to group logical expressions.

Example: `title:'highlight' AND id='episode-1'`

Filterable fields: ["id", "title"].
Both snake_case and camelCase field names are supported. ||
|#

## ListEpisodesResponse {#yandex.cloud.video.v1.ListEpisodesResponse}

```json
{
  "episodes": [
    {
      "id": "string",
      "stream_id": "string",
      "line_id": "string",
      "title": "string",
      "description": "string",
      "thumbnail_id": "string",
      "start_time": "google.protobuf.Timestamp",
      "finish_time": "google.protobuf.Timestamp",
      "dvr_seconds": "int64",
      "visibility_status": "VisibilityStatus",
      "style_preset_id": "string",
      // Includes only one of the fields `public_access`, `sign_url_access`
      "public_access": "EpisodePublicAccessRights",
      "sign_url_access": "EpisodeSignURLAccessRights",
      // end of the list of possible fields
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| episodes[] | **[Episode](#yandex.cloud.video.v1.Episode)**

List of episodes matching the request criteria.
May be empty if no episodes match the criteria or if the parent resource has no episodes. ||
|| next_page_token | **string**

Token for retrieving the next page of results.
Empty if there are no more results available. ||
|#

## Episode {#yandex.cloud.video.v1.Episode}

Entity representing a stream fragment that can be accessed independently.
Episodes can be linked to either a stream or a line
and provide a way to reference specific portions of the corresponding content.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the episode. ||
|| stream_id | **string**

Identifier of the stream this episode is linked to.
Optional, empty if the episode is linked to a line. ||
|| line_id | **string**

Identifier of the line this episode is linked to.
Optional, empty if the episode is linked to a stream. ||
|| title | **string**

Title of the episode displayed in interfaces and players. ||
|| description | **string**

Detailed description of the episode content and context. ||
|| thumbnail_id | **string**

Identifier of the thumbnail image used to represent the episode visually. ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp marking the beginning of the episode content. ||
|| finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp marking the end of the episode content. ||
|| dvr_seconds | **int64**

Controls the Digital Video Recording (DVR) functionality for the episode.
Determines how many seconds of the stream are available for time-shifted viewing.

Possible values:
* `0`: Infinite DVR size, the full length of the stream is available for viewing.
* `>0`: Size of DVR window in seconds, the minimum value is 30s. ||
|| visibility_status | enum **VisibilityStatus**

Current visibility status controlling whether the episode is publicly available.

- `VISIBILITY_STATUS_UNSPECIFIED`: The visibility status is not specified.
- `PUBLISHED`: The episode is publicly available, subject to its access permission settings.
- `UNPUBLISHED`: The episode is available only to administrators. ||
|| style_preset_id | **string**

Identifier of the style preset used in the player during episode playback. ||
|| public_access | **[EpisodePublicAccessRights](#yandex.cloud.video.v1.EpisodePublicAccessRights)**

Allows unrestricted public access to the episode via direct link.
No additional authorization or access control is applied.

Includes only one of the fields `public_access`, `sign_url_access`.

Specifies the episode access permission settings. ||
|| sign_url_access | **[EpisodeSignURLAccessRights](#yandex.cloud.video.v1.EpisodeSignURLAccessRights)**

Restricts episode access using URL signatures for secure time-limited access.

Includes only one of the fields `public_access`, `sign_url_access`.

Specifies the episode access permission settings. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the episode was initially created in the system. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the last modification to the episode or its metadata. ||
|#

## EpisodePublicAccessRights {#yandex.cloud.video.v1.EpisodePublicAccessRights}

Represents public access rights for an episode.
When this access type is set, the episode is publicly accessible via direct link.

#|
||Field | Description ||
|| Empty | > ||
|#

## EpisodeSignURLAccessRights {#yandex.cloud.video.v1.EpisodeSignURLAccessRights}

Represents access rights controlled by URL signatures.
When this access type is set, the episode is accessible only via properly signed temporary link.

#|
||Field | Description ||
|| Empty | > ||
|#