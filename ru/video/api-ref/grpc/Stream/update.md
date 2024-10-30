---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Stream/update.md
---

# Video API, gRPC: StreamService.Update {#Update}

Update stream.

## gRPC request

**rpc Update ([UpdateStreamRequest](#yandex.cloud.video.v1.UpdateStreamRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateStreamRequest {#yandex.cloud.video.v1.UpdateStreamRequest}

```json
{
  "streamId": "string",
  "fieldMask": "google.protobuf.FieldMask",
  "lineId": "string",
  "title": "string",
  "description": "string",
  "thumbnailId": "string",
  "labels": "string",
  // Includes only one of the fields `onDemand`, `schedule`
  "onDemand": "OnDemandParams",
  "schedule": {
    "startTime": "google.protobuf.Timestamp",
    "finishTime": "google.protobuf.Timestamp"
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| streamId | **string**

ID of the stream. ||
|| fieldMask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the stream are going to be updated. ||
|| lineId | **string**

ID of the line. ||
|| title | **string**

Stream title. ||
|| description | **string**

Stream description. ||
|| thumbnailId | **string**

ID of the thumbnail. ||
|| labels | **string**

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
|| onDemand | **[OnDemandParams](#yandex.cloud.video.v1.OnDemandParams)**

On demand stream. It starts immediately when a signal appears.

Includes only one of the fields `onDemand`, `schedule`.

Stream type. ||
|| schedule | **[ScheduleParams](#yandex.cloud.video.v1.ScheduleParams)**

Schedule stream. Determines when to start receiving the signal or finish time.

Includes only one of the fields `onDemand`, `schedule`.

Stream type. ||
|#

## OnDemandParams {#yandex.cloud.video.v1.OnDemandParams}

#|
||Field | Description ||
|| Empty | > ||
|#

## ScheduleParams {#yandex.cloud.video.v1.ScheduleParams}

#|
||Field | Description ||
|| startTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| finishTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
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
    "streamId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "channelId": "string",
    "lineId": "string",
    "title": "string",
    "description": "string",
    "thumbnailId": "string",
    "status": "StreamStatus",
    "startTime": "google.protobuf.Timestamp",
    "publishTime": "google.protobuf.Timestamp",
    "finishTime": "google.protobuf.Timestamp",
    // Includes only one of the fields `onDemand`, `schedule`
    "onDemand": "OnDemand",
    "schedule": {
      "startTime": "google.protobuf.Timestamp",
      "finishTime": "google.protobuf.Timestamp"
    },
    // end of the list of possible fields
    "createdAt": "google.protobuf.Timestamp",
    "updatedAt": "google.protobuf.Timestamp",
    "labels": "string"
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
|| metadata | **[UpdateStreamMetadata](#yandex.cloud.video.v1.UpdateStreamMetadata)**

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
|| response | **[Stream](#yandex.cloud.video.v1.Stream)**

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

## UpdateStreamMetadata {#yandex.cloud.video.v1.UpdateStreamMetadata}

#|
||Field | Description ||
|| streamId | **string**

ID of the stream. ||
|#

## Stream {#yandex.cloud.video.v1.Stream}

#|
||Field | Description ||
|| id | **string**

ID of the stream. ||
|| channelId | **string**

ID of the channel where the stream was created. ||
|| lineId | **string**

ID of the line to which stream is linked. ||
|| title | **string**

Stream title. ||
|| description | **string**

Stream description. ||
|| thumbnailId | **string**

ID of the thumbnail. ||
|| status | enum **StreamStatus**

Stream status.

- `STREAM_STATUS_UNSPECIFIED`: Stream status unspecified.
- `OFFLINE`: Stream offline.
- `PREPARING`: Preparing the infrastructure for receiving video signal.
- `READY`: Everything is ready to launch stream.
- `ONAIR`: Stream onair.
- `FINISHED`: Stream finished. ||
|| startTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Stream start time. ||
|| publishTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Stream publish time. Time when stream switched to ONAIR status. ||
|| finishTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Stream finish time. ||
|| onDemand | **[OnDemand](#yandex.cloud.video.v1.OnDemand)**

On demand stream. It starts immediately when a signal appears.

Includes only one of the fields `onDemand`, `schedule`.

Stream type. ||
|| schedule | **[Schedule](#yandex.cloud.video.v1.Schedule)**

Schedule stream. Determines when to start receiving the signal or finish time.

Includes only one of the fields `onDemand`, `schedule`.

Stream type. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when stream was created. ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last stream update. ||
|| labels | **string**

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
|#

## OnDemand {#yandex.cloud.video.v1.OnDemand}

If "OnDemand" is used, client should start and finish explicitly.

#|
||Field | Description ||
|| Empty | > ||
|#

## Schedule {#yandex.cloud.video.v1.Schedule}

If "Schedule" is used, stream automatically start and finish at this time.

#|
||Field | Description ||
|| startTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| finishTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#