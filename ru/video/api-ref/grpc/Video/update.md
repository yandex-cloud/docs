---
editable: false
---

# Video API, gRPC: VideoService.Update

Updates an existing video's metadata and settings.
Only fields specified in the field_mask will be updated.

## gRPC request

**rpc Update ([UpdateVideoRequest](#yandex.cloud.video.v1.UpdateVideoRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateVideoRequest {#yandex.cloud.video.v1.UpdateVideoRequest}

```json
{
  "video_id": "string",
  "field_mask": "google.protobuf.FieldMask",
  "title": "string",
  "description": "string",
  "thumbnail_id": "string",
  "auto_transcode": "AutoTranscode",
  "style_preset_id": "string",
  "enable_ad": "google.protobuf.BoolValue",
  "labels": "map<string, string>",
  // Includes only one of the fields `public_access`, `sign_url_access`
  "public_access": "VideoPublicAccessParams",
  "sign_url_access": "VideoSignURLAccessParams"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| video_id | **string**

Required field. ID of the video to update.

The maximum string length in characters is 50. ||
|| field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Required field. Field mask specifying which fields of the video should be updated.
Only fields specified in this mask will be modified;
all other fields will retain their current values.
This allows for partial updates. ||
|| title | **string**

New title for the video.

The maximum string length in characters is 300. ||
|| description | **string**

New description for the video.

The maximum string length in characters is 5000. ||
|| thumbnail_id | **string**

New thumbnail ID for the video.

The maximum string length in characters is 50. ||
|| auto_transcode | enum **AutoTranscode**

New auto-transcoding setting for the video.
Controls whether transcoding starts automatically after upload.

- `ENABLE`: Automatically start transcoding after the video upload is complete.
- `DISABLE`: Do not automatically transcode; requires manual initiation via the Transcode() method. ||
|| style_preset_id | **string**

New style preset ID for the video.

The maximum string length in characters is 50. ||
|| enable_ad | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

New advertisement setting for the video.
Set to false to disable advertisements for this specific video. ||
|| labels | **object** (map<**string**, **string**>)

New custom labels for the video as `key:value` pairs.
Maximum 64 labels per video.
If provided, replaces all existing labels.

The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_.@:/0-9a-zA-Z]* `. No more than 64 per resource. ||
|| public_access | **[VideoPublicAccessParams](#yandex.cloud.video.v1.VideoPublicAccessParams)**

Makes the video publicly accessible to anyone with the direct link.

Includes only one of the fields `public_access`, `sign_url_access`.

New access rights setting for the video. ||
|| sign_url_access | **[VideoSignURLAccessParams](#yandex.cloud.video.v1.VideoSignURLAccessParams)**

Restricts video access using URL signatures for secure time-limited access.

Includes only one of the fields `public_access`, `sign_url_access`.

New access rights setting for the video. ||
|#

## VideoPublicAccessParams {#yandex.cloud.video.v1.VideoPublicAccessParams}

Parameters for video public access rights.

#|
||Field | Description ||
|| Empty | > ||
|#

## VideoSignURLAccessParams {#yandex.cloud.video.v1.VideoSignURLAccessParams}

Parameters for video access restrictions based on temporary signed links.

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