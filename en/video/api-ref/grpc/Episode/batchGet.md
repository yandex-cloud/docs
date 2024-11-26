---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Episode/batchGet.md
---

# Video API, gRPC: EpisodeService.BatchGet

Batch get episodes for channel.

## gRPC request

**rpc BatchGet ([BatchGetEpisodesRequest](#yandex.cloud.video.v1.BatchGetEpisodesRequest)) returns ([BatchGetEpisodesResponse](#yandex.cloud.video.v1.BatchGetEpisodesResponse))**

## BatchGetEpisodesRequest {#yandex.cloud.video.v1.BatchGetEpisodesRequest}

```json
{
  "channel_id": "string",
  "episode_ids": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel. ||
|| episode_ids[] | **string**

List of requested episode IDs. ||
|#

## BatchGetEpisodesResponse {#yandex.cloud.video.v1.BatchGetEpisodesResponse}

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
  ]
}
```

#|
||Field | Description ||
|| episodes[] | **[Episode](#yandex.cloud.video.v1.Episode)**

List of episodes for specific channel. ||
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

Channel title. ||
|| description | **string**

Channel description. ||
|| thumbnail_id | **string**

ID of the thumbnail. ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Episode start time. ||
|| finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Episode finish time. ||
|| dvr_seconds | **int64**

Enables episode DVR mode. DVR seconds determines how many last seconds of the stream are available.

possible values:
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