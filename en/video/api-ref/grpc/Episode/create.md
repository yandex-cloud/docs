---
editable: false
---

# Video API, gRPC: EpisodeService.Create

Creates a new episode associated with a stream or stream line.
Episodes can be configured with various settings including title, description,
time boundaries, and access rights.

## gRPC request

**rpc Create ([CreateEpisodeRequest](#yandex.cloud.video.v1.CreateEpisodeRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateEpisodeRequest {#yandex.cloud.video.v1.CreateEpisodeRequest}

```json
{
  // Includes only one of the fields `stream_id`, `line_id`
  "stream_id": "string",
  "line_id": "string",
  // end of the list of possible fields
  "title": "string",
  "description": "string",
  "thumbnail_id": "string",
  "start_time": "google.protobuf.Timestamp",
  "finish_time": "google.protobuf.Timestamp",
  "dvr_seconds": "int64",
  "style_preset_id": "string",
  // Includes only one of the fields `public_access`, `sign_url_access`
  "public_access": "EpisodePublicAccessParams",
  "sign_url_access": "EpisodeSignURLAccessParams"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| stream_id | **string**

ID of the stream.

The maximum string length in characters is 50.

Includes only one of the fields `stream_id`, `line_id`.

Parent resource ID to link the episode to (exactly one must be chosen). ||
|| line_id | **string**

ID of the line.

The maximum string length in characters is 50.

Includes only one of the fields `stream_id`, `line_id`.

Parent resource ID to link the episode to (exactly one must be chosen). ||
|| title | **string**

Required field. Episode title.

The maximum string length in characters is 300. ||
|| description | **string**

Episode description.

The maximum string length in characters is 5000. ||
|| thumbnail_id | **string**

ID of the thumbnail.

The maximum string length in characters is 50. ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Episode start time. ||
|| finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Episode finish time. ||
|| dvr_seconds | **int64**

Enables episode DVR mode.
Determines how many last seconds of the stream are available.
Possible values:
* `0`: infinite dvr size, the full length of the stream allowed to display
* `>0`: size of dvr window in seconds, the minimum value is 30s ||
|| style_preset_id | **string**

ID of the style preset.

The maximum string length in characters is 50. ||
|| public_access | **[EpisodePublicAccessParams](#yandex.cloud.video.v1.EpisodePublicAccessParams)**

Episode is publicly available.

Includes only one of the fields `public_access`, `sign_url_access`.

Episode access permission settings (exactly one must be chosen). ||
|| sign_url_access | **[EpisodeSignURLAccessParams](#yandex.cloud.video.v1.EpisodeSignURLAccessParams)**

Access to the episode is restricted by temporarily signed links.

Includes only one of the fields `public_access`, `sign_url_access`.

Episode access permission settings (exactly one must be chosen). ||
|#

## EpisodePublicAccessParams {#yandex.cloud.video.v1.EpisodePublicAccessParams}

Parameters for episode public access rights.

#|
||Field | Description ||
|| Empty | > ||
|#

## EpisodeSignURLAccessParams {#yandex.cloud.video.v1.EpisodeSignURLAccessParams}

Parameters for episode access restrictions based on temporary signed links.

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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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