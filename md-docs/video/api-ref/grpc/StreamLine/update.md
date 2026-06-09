# Video API, gRPC: StreamLineService.Update

Updates an existing stream line's metadata and configuration.
Only fields specified in the field_mask will be updated.

## gRPC request

**rpc Update ([UpdateStreamLineRequest](#yandex.cloud.video.v1.UpdateStreamLineRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateStreamLineRequest {#yandex.cloud.video.v1.UpdateStreamLineRequest}

```json
{
  "stream_line_id": "string",
  "field_mask": "google.protobuf.FieldMask",
  "title": "string",
  // Includes only one of the fields `rtmp_push`, `rtmp_pull`, `srt_pull`
  "rtmp_push": "RTMPPushParams",
  "rtmp_pull": {
    "url": "string"
  },
  "srt_pull": {
    "url": "string"
  },
  // end of the list of possible fields
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| stream_line_id | **string**

Required field. ID of the line.

The maximum string length in characters is 50. ||
|| field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Required field. Field mask specifying which fields of the stream line should be updated.
Only fields specified in this mask will be modified;
all other fields will retain their current values.
This allows for partial updates. ||
|| title | **string**

Line title.

The maximum string length in characters is 300. ||
|| rtmp_push | **[RTMPPushParams](#yandex.cloud.video.v1.RTMPPushParams)**

RTMP push input type.

Includes only one of the fields `rtmp_push`, `rtmp_pull`, `srt_pull`.

Video signal settings. ||
|| rtmp_pull | **[RTMPPullParams](#yandex.cloud.video.v1.RTMPPullParams)**

RTMP pull input type.

Includes only one of the fields `rtmp_push`, `rtmp_pull`, `srt_pull`.

Video signal settings. ||
|| srt_pull | **[SRTPullParams](#yandex.cloud.video.v1.SRTPullParams)**

SRT pull input type.

Includes only one of the fields `rtmp_push`, `rtmp_pull`, `srt_pull`.

Video signal settings. ||
|| labels | **object** (map<**string**, **string**>)

New custom labels for the stream line as `key:value` pairs.
Maximum 64 labels per stream line.
If provided, replaces all existing labels.

The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_.@:/0-9a-zA-Z]* `. No more than 64 per resource. ||
|#

## RTMPPushParams {#yandex.cloud.video.v1.RTMPPushParams}

Parameters for creating an RTMP push input type stream line.

#|
||Field | Description ||
|| Empty | > ||
|#

## RTMPPullParams {#yandex.cloud.video.v1.RTMPPullParams}

Parameters for creating an RTMP pull input type stream line.

#|
||Field | Description ||
|| url | **string**

Required field. The RTMP URL from which to pull the video stream.
Must be a valid RTMP URL starting with "rtmp://".

Value must match the regular expression ` rtmp://.* `. ||
|#

## SRTPullParams {#yandex.cloud.video.v1.SRTPullParams}

Parameters for creating an SRT pull input type stream line.

#|
||Field | Description ||
|| url | **string**

Required field. The SRT URL from which to pull the video stream.
Must be a valid SRT URL starting with "srt://".

Value must match the regular expression ` srt://.* `. ||
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

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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