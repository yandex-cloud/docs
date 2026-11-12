---
editable: false
---

# Video API, gRPC: VideoService.RenewSource

Renews video source data for further upload.
This method is not applicable to videos in WAIT_UPLOADING and PROCESSING statuses.
Returns an operation which restores the previously uploaded video source upon cancellation.


## gRPC request

**rpc RenewSource ([RenewVideoSourceRequest](#yandex.cloud.video.v1.RenewVideoSourceRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## RenewVideoSourceRequest {#yandex.cloud.video.v1.RenewVideoSourceRequest}

```json
{
  "video_id": "string",
  // Includes only one of the fields `tusd`
  "tusd": {
    "file_size": "int64",
    "file_name": "string",
    "is_deferred": "bool"
  },
  // end of the list of possible fields
  "auto_transcode": "AutoTranscode"
}
```

#|
||Field | Description ||
|| video_id | **string**

Required field. ID of the video.

The maximum string length in characters is 50. ||
|| tusd | **[VideoTUSDParams](#yandex.cloud.video.v1.VideoTUSDParams)**

Upload video using the TUS (Tus Resumable Upload Protocol) protocol.
This is a push-based upload method where the client pushes data to the server.

Includes only one of the fields `tusd`.

Specifies the video upload source method (exactly one must be chosen). ||
|| auto_transcode | enum **AutoTranscode**

New auto-transcoding setting for the video.
Controls whether transcoding starts automatically after upload.

- `ENABLE`: Automatically start transcoding after the video upload is complete.
- `DISABLE`: Do not automatically transcode; requires manual initiation via the Transcode() method. ||
|#

## VideoTUSDParams {#yandex.cloud.video.v1.VideoTUSDParams}

#|
||Field | Description ||
|| file_size | **int64**

Total size of the file to be uploaded, in bytes.
MUST be positive if upload length is not deferred, otherwise MUST be 0.

The minimum value is 0. ||
|| file_name | **string**

Original name of the file being uploaded.
This is used for reference and does not affect the upload process. ||
|| is_deferred | **bool**

Defer upload file size.
File size MUST be provided by first client's PATCH request.
@see https://tus.io/protocols/resumable-upload#post ||
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