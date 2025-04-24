---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Stream/performAction.md
---

# Video API, gRPC: StreamService.PerformAction

Perform an action on the stream.

## gRPC request

**rpc PerformAction ([PerformStreamActionRequest](#yandex.cloud.video.v1.PerformStreamActionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## PerformStreamActionRequest {#yandex.cloud.video.v1.PerformStreamActionRequest}

```json
{
  "stream_id": "string",
  // Includes only one of the fields `publish`, `stop`
  "publish": "PublishAction",
  "stop": "StopAction"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| stream_id | **string**

Required field. ID of the stream. ||
|| publish | **[PublishAction](#yandex.cloud.video.v1.PublishAction)**

Includes only one of the fields `publish`, `stop`. ||
|| stop | **[StopAction](#yandex.cloud.video.v1.StopAction)**

Includes only one of the fields `publish`, `stop`. ||
|#

## PublishAction {#yandex.cloud.video.v1.PublishAction}

#|
||Field | Description ||
|| Empty | > ||
|#

## StopAction {#yandex.cloud.video.v1.StopAction}

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
    "stream_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "channel_id": "string",
    "line_id": "string",
    "title": "string",
    "description": "string",
    "thumbnail_id": "string",
    "status": "StreamStatus",
    "start_time": "google.protobuf.Timestamp",
    "publish_time": "google.protobuf.Timestamp",
    "finish_time": "google.protobuf.Timestamp",
    "auto_publish": "google.protobuf.BoolValue",
    // Includes only one of the fields `on_demand`, `schedule`
    "on_demand": "OnDemand",
    "schedule": {
      "start_time": "google.protobuf.Timestamp",
      "finish_time": "google.protobuf.Timestamp"
    },
    // end of the list of possible fields
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp",
    "labels": "map<string, string>"
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
|| metadata | **[PerformStreamActionMetadata](#yandex.cloud.video.v1.PerformStreamActionMetadata)**

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

## PerformStreamActionMetadata {#yandex.cloud.video.v1.PerformStreamActionMetadata}

#|
||Field | Description ||
|| stream_id | **string**

ID of the stream. ||
|#

## Stream {#yandex.cloud.video.v1.Stream}

#|
||Field | Description ||
|| id | **string**

ID of the stream. ||
|| channel_id | **string**

ID of the channel where the stream was created. ||
|| line_id | **string**

ID of the line to which stream is linked. ||
|| title | **string**

Stream title. ||
|| description | **string**

Stream description. ||
|| thumbnail_id | **string**

ID of the thumbnail. ||
|| status | enum **StreamStatus**

Stream status.

- `STREAM_STATUS_UNSPECIFIED`: Stream status unspecified.
- `OFFLINE`: Stream offline.
- `PREPARING`: Preparing the infrastructure for receiving video signal.
- `READY`: Everything is ready to launch stream.
- `ONAIR`: Stream onair.
- `FINISHED`: Stream finished. ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Stream start time. ||
|| publish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Stream publish time. Time when stream switched to ONAIR status. ||
|| finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Stream finish time. ||
|| auto_publish | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Automatically publish stream when ready.
Switches status from READY to ONAIR. ||
|| on_demand | **[OnDemand](#yandex.cloud.video.v1.OnDemand)**

On-demand stream. Starts immediately when a signal appears.

Includes only one of the fields `on_demand`, `schedule`.

Stream type. ||
|| schedule | **[Schedule](#yandex.cloud.video.v1.Schedule)**

Schedule stream. Starts or finished at the specified time.

Includes only one of the fields `on_demand`, `schedule`.

Stream type. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when stream was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last stream update. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
|#

## OnDemand {#yandex.cloud.video.v1.OnDemand}

On-demand stream type.
This type of streams should be started and finished explicitly.

#|
||Field | Description ||
|| Empty | > ||
|#

## Schedule {#yandex.cloud.video.v1.Schedule}

Schedule stream type.
This type of streams start and finish automatically at the specified time.

#|
||Field | Description ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#