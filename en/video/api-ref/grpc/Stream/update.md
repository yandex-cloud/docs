---
editable: false
---

# Video API, gRPC: StreamService.Update

Updates an existing stream's metadata and settings.
Only fields specified in the field_mask will be updated.

## gRPC request

**rpc Update ([UpdateStreamRequest](#yandex.cloud.video.v1.UpdateStreamRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateStreamRequest {#yandex.cloud.video.v1.UpdateStreamRequest}

```json
{
  "stream_id": "string",
  "field_mask": "google.protobuf.FieldMask",
  "title": "string",
  "description": "string",
  "thumbnail_id": "string",
  "auto_publish": "google.protobuf.BoolValue",
  "labels": "map<string, string>",
  // Includes only one of the fields `on_demand`, `schedule`
  "on_demand": "OnDemandParams",
  "schedule": {
    "start_time": "google.protobuf.Timestamp",
    "finish_time": "google.protobuf.Timestamp"
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| stream_id | **string**

Required field. ID of the stream.

The maximum string length in characters is 50. ||
|| field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Required field. Field mask specifying which fields of the stream should be updated.
Only fields specified in this mask will be modified;
all other fields will retain their current values.
This allows for partial updates. ||
|| title | **string**

Stream title.

The maximum string length in characters is 300. ||
|| description | **string**

Stream description.

The maximum string length in characters is 4000. ||
|| thumbnail_id | **string**

ID of the thumbnail.

The maximum string length in characters is 50. ||
|| auto_publish | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Automatically publish stream when ready.
Switches status from READY to ONAIR. ||
|| labels | **object** (map<**string**, **string**>)

New custom labels for the stream as `key:value` pairs.
Maximum 64 labels per stream.
If provided, replaces all existing labels.

The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_.@:/0-9a-zA-Z]* `. No more than 64 per resource. ||
|| on_demand | **[OnDemandParams](#yandex.cloud.video.v1.OnDemandParams)**

On demand stream.
It starts immediately when a signal appears.

Includes only one of the fields `on_demand`, `schedule`.

Stream type. ||
|| schedule | **[ScheduleParams](#yandex.cloud.video.v1.ScheduleParams)**

Scheduled stream.
It starts and finishes at specified time.

Includes only one of the fields `on_demand`, `schedule`.

Stream type. ||
|#

## OnDemandParams {#yandex.cloud.video.v1.OnDemandParams}

On-demand streams start automatically when a video signal is detected
and must be manually stopped when no longer needed.

#|
||Field | Description ||
|| Empty | > ||
|#

## ScheduleParams {#yandex.cloud.video.v1.ScheduleParams}

#|
||Field | Description ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. Scheduled time when the stream should automatically start.
The streaming infrastructure will be prepared at this time
and will begin accepting the video signal. ||
|| finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. Scheduled time when the stream should automatically finish.
The streaming infrastructure will be shut down at this time
and the stream will be marked as FINISHED. ||
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