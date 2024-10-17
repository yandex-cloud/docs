---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Episode/get.md
---

# Video API, gRPC: EpisodeService.Get {#Get}

Returns the specific channel.

## gRPC request

**rpc Get ([GetEpisodeRequest](#yandex.cloud.video.v1.GetEpisodeRequest)) returns ([Episode](#yandex.cloud.video.v1.Episode))**

## GetEpisodeRequest {#yandex.cloud.video.v1.GetEpisodeRequest}

```json
{
  "episodeId": "string"
}
```

#|
||Field | Description ||
|| episodeId | **string**

ID of the episode. ||
|#

## Episode {#yandex.cloud.video.v1.Episode}

```json
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
```

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