---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Episode/list.md
---

# Video API, gRPC: EpisodeService.List {#List}

List episodes for stream or line.

## gRPC request

**rpc List ([ListEpisodesRequest](#yandex.cloud.video.v1.ListEpisodesRequest)) returns ([ListEpisodesResponse](#yandex.cloud.video.v1.ListEpisodesResponse))**

## ListEpisodesRequest {#yandex.cloud.video.v1.ListEpisodesRequest}

```json
{
  // Includes only one of the fields `streamId`, `lineId`
  "streamId": "string",
  "lineId": "string",
  // end of the list of possible fields
  "pageSize": "int64",
  "pageToken": "string",
  "orderBy": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| streamId | **string**

ID of the stream.

Includes only one of the fields `streamId`, `lineId`. ||
|| lineId | **string**

ID of the line.

Includes only one of the fields `streamId`, `lineId`. ||
|| pageSize | **int64**

The maximum number of the results per page to return. Default value: 100. ||
|| pageToken | **string**

Page token for getting the next page of the result. ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
Possible fields: ["id", "createdAt", "updatedAt"]
Both snake_case and camelCase are supported for fields. ||
|| filter | **string**

Filter expression that filters resources listed in the response.
Expressions are composed of terms connected by logic operators.
Value in quotes: `'` or `"`
Example: "key1='value' AND key2='value'"
Supported operators: ["AND"].
Supported fields: ["title"]
Both snake_case and camelCase are supported for fields. ||
|#

## ListEpisodesResponse {#yandex.cloud.video.v1.ListEpisodesResponse}

```json
{
  "episodes": [
    {
      "id": "string",
      "streamId": "string",
      "lineId": "string",
      "title": "string",
      "description": "string",
      "thumbnailId": "string",
      "startTime": "google.protobuf.Timestamp",
      "finishTime": "google.protobuf.Timestamp",
      "dvrSeconds": "int64",
      "visibilityStatus": "VisibilityStatus",
      // Includes only one of the fields `publicAccess`, `authSystemAccess`
      "publicAccess": "EpisodePublicAccessRights",
      "authSystemAccess": "EpisodeAuthSystemAccessRights",
      // end of the list of possible fields
      "createdAt": "google.protobuf.Timestamp",
      "updatedAt": "google.protobuf.Timestamp"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| episodes[] | **[Episode](#yandex.cloud.video.v1.Episode)**

List of episodes for specific parent_id. ||
|| nextPageToken | **string**

Token for getting the next page. ||
|#

## Episode {#yandex.cloud.video.v1.Episode}

#|
||Field | Description ||
|| id | **string**

ID of the episode. ||
|| streamId | **string**

ID of the stream. Optional, empty if the episode is linked to the line ||
|| lineId | **string**

ID of the line. Optional, empty if the episode is linked to the stream ||
|| title | **string**

Channel title. ||
|| description | **string**

Channel description. ||
|| thumbnailId | **string**

ID of the thumbnail. ||
|| startTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Episode start time. ||
|| finishTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Episode finish time. ||
|| dvrSeconds | **int64**

Enables episode DVR mode. DVR seconds determines how many last seconds of the stream are available.

possible values:
* `0`: infinite dvr size, the full length of the stream allowed to display
* `>0`: size of dvr window in seconds, the minimum value is 30s ||
|| visibilityStatus | enum **VisibilityStatus**

- `VISIBILITY_STATUS_UNSPECIFIED`
- `PUBLISHED`
- `UNPUBLISHED` ||
|| publicAccess | **[EpisodePublicAccessRights](#yandex.cloud.video.v1.EpisodePublicAccessRights)**

Episode is available to everyone.

Includes only one of the fields `publicAccess`, `authSystemAccess`.

Episode access rights. ||
|| authSystemAccess | **[EpisodeAuthSystemAccessRights](#yandex.cloud.video.v1.EpisodeAuthSystemAccessRights)**

Checking access rights using the authorization system.

Includes only one of the fields `publicAccess`, `authSystemAccess`.

Episode access rights. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when episode was created. ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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