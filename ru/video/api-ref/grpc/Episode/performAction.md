---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Episode/performAction.md
---

# Video API, gRPC: EpisodeService.PerformAction

Performs a specific action on an episode, such as publishing or unpublishing.

## gRPC request

**rpc PerformAction ([PerformEpisodeActionRequest](#yandex.cloud.video.v1.PerformEpisodeActionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## PerformEpisodeActionRequest {#yandex.cloud.video.v1.PerformEpisodeActionRequest}

```json
{
  "episode_id": "string",
  // Includes only one of the fields `publish`, `unpublish`
  "publish": "PublishEpisodeAction",
  "unpublish": "UnpublishEpisodeAction"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| episode_id | **string**

Required field. ID of the episode on which to perform the action. ||
|| publish | **[PublishEpisodeAction](#yandex.cloud.video.v1.PublishEpisodeAction)**

Publish the episode, making it available for watching.
Changes the episode's visibility status to PUBLISHED.

Includes only one of the fields `publish`, `unpublish`.

Specifies which action to perform on the episode (exactly one must be chosen). ||
|| unpublish | **[UnpublishEpisodeAction](#yandex.cloud.video.v1.UnpublishEpisodeAction)**

Unpublish the episode, making it unavailable for watching.
Changes the episode's visibility status to UNPUBLISHED.

Includes only one of the fields `publish`, `unpublish`.

Specifies which action to perform on the episode (exactly one must be chosen). ||
|#

## PublishEpisodeAction {#yandex.cloud.video.v1.PublishEpisodeAction}

Parameters for the publish action.

#|
||Field | Description ||
|| Empty | > ||
|#

## UnpublishEpisodeAction {#yandex.cloud.video.v1.UnpublishEpisodeAction}

Parameters for the unpublish action.

#|
||Field | Description ||
|| Empty | > ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "episode_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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
|| episode_id | **string**

ID of the episode on which the action is being performed.
This identifier can be used to track the action operation
and to verify that the action is being applied to the correct episode. ||
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