---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Episode/performAction.md
---

# Video API, gRPC: EpisodeService.PerformAction {#PerformAction}

Perform an action on the episode.

## gRPC request

**rpc PerformAction ([PerformEpisodeActionRequest](#yandex.cloud.video.v1.PerformEpisodeActionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## PerformEpisodeActionRequest {#yandex.cloud.video.v1.PerformEpisodeActionRequest}

```json
{
  "episodeId": "string",
  // Includes only one of the fields `publish`, `unpublish`
  "publish": "PublishEpisodeAction",
  "unpublish": "UnpublishEpisodeAction"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| episodeId | **string**

ID of the episode. ||
|| publish | **[PublishEpisodeAction](#yandex.cloud.video.v1.PublishEpisodeAction)**

Includes only one of the fields `publish`, `unpublish`. ||
|| unpublish | **[UnpublishEpisodeAction](#yandex.cloud.video.v1.UnpublishEpisodeAction)**

Includes only one of the fields `publish`, `unpublish`. ||
|#

## PublishEpisodeAction {#yandex.cloud.video.v1.PublishEpisodeAction}

#|
||Field | Description ||
|| Empty | > ||
|#

## UnpublishEpisodeAction {#yandex.cloud.video.v1.UnpublishEpisodeAction}

#|
||Field | Description ||
|| Empty | > ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "episodeId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[PerformEpisodeActionMetadata](#yandex.cloud.video.v1.PerformEpisodeActionMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Episode](#yandex.cloud.video.v1.Episode)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## PerformEpisodeActionMetadata {#yandex.cloud.video.v1.PerformEpisodeActionMetadata}

#|
||Field | Description ||
|| episodeId | **string**

ID of the episode. ||
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