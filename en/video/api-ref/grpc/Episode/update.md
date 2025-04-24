---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Episode/update.md
---

# Video API, gRPC: EpisodeService.Update

Update episode.

## gRPC request

**rpc Update ([UpdateEpisodeRequest](#yandex.cloud.video.v1.UpdateEpisodeRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateEpisodeRequest {#yandex.cloud.video.v1.UpdateEpisodeRequest}

```json
{
  "episode_id": "string",
  "field_mask": "google.protobuf.FieldMask",
  "title": "string",
  "description": "string",
  "thumbnail_id": "string",
  "start_time": "google.protobuf.Timestamp",
  "finish_time": "google.protobuf.Timestamp",
  "dvr_seconds": "int64",
  // Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`
  "public_access": "EpisodePublicAccessParams",
  "auth_system_access": "EpisodeAuthSystemAccessParams",
  "sign_url_access": "EpisodeSignURLAccessParams"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| episode_id | **string**

Required field. ID of the episode. ||
|| field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Required field. Field mask that specifies which fields of the episode are going to be updated. ||
|| title | **string**

Episode title. ||
|| description | **string**

Episode description. ||
|| thumbnail_id | **string**

ID of the thumbnail. ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Episode finish time. ||
|| dvr_seconds | **int64**

Enables episode DVR mode.
Determines how many last seconds of the stream are available.

Possible values:
* `0`: infinite dvr size, the full length of the stream allowed to display
* `>0`: size of dvr window in seconds, the minimum value is 30s ||
|| public_access | **[EpisodePublicAccessParams](#yandex.cloud.video.v1.EpisodePublicAccessParams)**

Episode is available to everyone.

Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`.

Episode access rights. ||
|| auth_system_access | **[EpisodeAuthSystemAccessParams](#yandex.cloud.video.v1.EpisodeAuthSystemAccessParams)**

Checking access rights using the authorization system.

Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`.

Episode access rights. ||
|| sign_url_access | **[EpisodeSignURLAccessParams](#yandex.cloud.video.v1.EpisodeSignURLAccessParams)**

Checking access rights using url's signature.

Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`.

Episode access rights. ||
|#

## EpisodePublicAccessParams {#yandex.cloud.video.v1.EpisodePublicAccessParams}

#|
||Field | Description ||
|| Empty | > ||
|#

## EpisodeAuthSystemAccessParams {#yandex.cloud.video.v1.EpisodeAuthSystemAccessParams}

#|
||Field | Description ||
|| Empty | > ||
|#

## EpisodeSignURLAccessParams {#yandex.cloud.video.v1.EpisodeSignURLAccessParams}

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
    // Includes only one of the fields `public_access`, `auth_system_access`, `sign_url_access`
    "public_access": "EpisodePublicAccessRights",
    "auth_system_access": "EpisodeAuthSystemAccessRights",
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
|| metadata | **[UpdateEpisodeMetadata](#yandex.cloud.video.v1.UpdateEpisodeMetadata)**

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

## UpdateEpisodeMetadata {#yandex.cloud.video.v1.UpdateEpisodeMetadata}

#|
||Field | Description ||
|| episode_id | **string**

ID of the episode. ||
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