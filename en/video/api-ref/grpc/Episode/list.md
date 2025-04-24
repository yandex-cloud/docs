---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Episode/list.md
---

# Video API, gRPC: EpisodeService.List

List episodes for stream or line.

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

ID of the stream.

Includes only one of the fields `stream_id`, `line_id`. ||
|| line_id | **string**

ID of the line.

Includes only one of the fields `stream_id`, `line_id`. ||
|| page_size | **int64**

The maximum number of the results per page to return.
Default value: 100. ||
|| page_token | **string**

Page token for getting the next page of the result. ||
|| order_by | **string**

By which column the listing should be ordered and in which direction,
format is "<field> <order>" (e.g. "createdAt desc").
Default: "id asc".
Possible fields: ["id", "createdAt", "updatedAt"].
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
      // Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`
      "public_access": "EpisodePublicAccessRights",
      "auth_system_access": "EpisodeAuthSystemAccessRights",
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

List of episodes for specific parent_id. ||
|| next_page_token | **string**

Token for getting the next page. ||
|#

## Episode {#yandex.cloud.video.v1.Episode}

#|
||Field | Description ||
|| id | **string**

ID of the episode. ||
|| stream_id | **string**

ID of the stream. Optional, empty if the episode is linked to the line ||
|| line_id | **string**

ID of the line. Optional, empty if the episode is linked to the stream ||
|| title | **string**

Episode title. ||
|| description | **string**

Episode description. ||
|| thumbnail_id | **string**

ID of the thumbnail. ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Episode start time. ||
|| finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Episode finish time. ||
|| dvr_seconds | **int64**

Enables episode DVR mode.
Determines how many last seconds of the stream are available for watching.

Possible values:
* `0`: infinite dvr size, the full length of the stream allowed to display
* `>0`: size of dvr window in seconds, the minimum value is 30s ||
|| visibility_status | enum **VisibilityStatus**

- `VISIBILITY_STATUS_UNSPECIFIED`
- `PUBLISHED`
- `UNPUBLISHED` ||
|| public_access | **[EpisodePublicAccessRights](#yandex.cloud.video.v1.EpisodePublicAccessRights)**

Episode is available to everyone.

Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`.

Episode access rights. ||
|| auth_system_access | **[EpisodeAuthSystemAccessRights](#yandex.cloud.video.v1.EpisodeAuthSystemAccessRights)**

Checking access rights using the authorization system.

Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`.

Episode access rights. ||
|| sign_url_access | **[EpisodeSignURLAccessRights](#yandex.cloud.video.v1.EpisodeSignURLAccessRights)**

Checking access rights using url's signature.

Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`.

Episode access rights. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when episode was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last episode update. ||
|#

## EpisodePublicAccessRights {#yandex.cloud.video.v1.EpisodePublicAccessRights}

#|
||Field | Description ||
|| Empty | > ||
|#

## EpisodeAuthSystemAccessRights {#yandex.cloud.video.v1.EpisodeAuthSystemAccessRights}

#|
||Field | Description ||
|| Empty | > ||
|#

## EpisodeSignURLAccessRights {#yandex.cloud.video.v1.EpisodeSignURLAccessRights}

#|
||Field | Description ||
|| Empty | > ||
|#