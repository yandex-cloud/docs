---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Stream/performAction.md
---

# Video API, gRPC: StreamService.PerformAction

Performs a specific action on a stream, such as publishing or stopping.
Actions change the stream's state without modifying its content or metadata.

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

Required field. ID of the stream on which to perform the action. ||
|| publish | **[PublishAction](#yandex.cloud.video.v1.PublishAction)**

Publish the stream, changing its status from READY to ONAIR.
This makes the stream available for watching.

Includes only one of the fields `publish`, `stop`.

Specifies which action to perform on the stream (exactly one must be chosen). ||
|| stop | **[StopAction](#yandex.cloud.video.v1.StopAction)**

Stop the stream, changing its status to FINISHED.
This terminates the streaming session and releases resources.

Includes only one of the fields `publish`, `stop`.

Specifies which action to perform on the stream (exactly one must be chosen). ||
|#

## PublishAction {#yandex.cloud.video.v1.PublishAction}

Parameters for the publish action.
The action changes the stream's status from READY to ONAIR.

#|
||Field | Description ||
|| Empty | > ||
|#

## StopAction {#yandex.cloud.video.v1.StopAction}

Parameters for the stop action.
The action changes the stream's status to FINISHED.

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

ID of the stream on which the action is being performed.
This identifier can be used to track the action operation
and to verify that the action is being applied to the correct stream. ||
|#

## Stream {#yandex.cloud.video.v1.Stream}

Entity representing a live video stream.
A stream is a real-time video broadcast linked to a specific stream line.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the stream. ||
|| channel_id | **string**

Identifier of the channel where the stream is created and managed. ||
|| line_id | **string**

Identifier of the stream line to which this stream is linked. ||
|| title | **string**

Title of the stream displayed in interfaces and players. ||
|| description | **string**

Detailed description of the stream content and context. ||
|| thumbnail_id | **string**

Identifier of the thumbnail image used to represent the stream visually. ||
|| status | enum **StreamStatus**

Current status of the stream.

- `STREAM_STATUS_UNSPECIFIED`: The stream status is not specified.
- `OFFLINE`: The stream is offline and not broadcasting.
- `PREPARING`: The system is preparing the infrastructure for receiving the video signal.
- `READY`: The infrastructure is ready to launch the stream.
- `ONAIR`: The stream is currently broadcasting live.
- `FINISHED`: The stream has completed and is no longer broadcasting. ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the stream was initiated. ||
|| publish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the stream was published (switched to ONAIR status). ||
|| finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the stream was completed. ||
|| auto_publish | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Controls automatic publishing of the stream when it's ready.
When set to true, automatically switches status from READY to ONAIR. ||
|| on_demand | **[OnDemand](#yandex.cloud.video.v1.OnDemand)**

On-demand stream starts immediately when a video signal appears.

Includes only one of the fields `on_demand`, `schedule`.

Specifies the stream scheduling type. ||
|| schedule | **[Schedule](#yandex.cloud.video.v1.Schedule)**

Scheduled stream starts and finishes at specified time.

Includes only one of the fields `on_demand`, `schedule`.

Specifies the stream scheduling type. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the stream was initially created in the system. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the last modification to the stream or its metadata. ||
|| labels | **object** (map<**string**, **string**>)

Custom user-defined labels as `key:value` pairs.
Maximum 64 labels per stream.
Used for organization, filtering, and metadata purposes.
Labels can be used for organization, filtering, and metadata purposes. ||
|#

## OnDemand {#yandex.cloud.video.v1.OnDemand}

Represents an on-demand stream type.
This type of stream must be started and finished explicitly by the user.
It begins broadcasting immediately when a video signal is detected.

#|
||Field | Description ||
|| Empty | > ||
|#

## Schedule {#yandex.cloud.video.v1.Schedule}

Represents a scheduled stream type.
This type of stream starts and finishes automatically at specified time.

#|
||Field | Description ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Scheduled time when the stream should automatically start. ||
|| finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Scheduled time when the stream should automatically finish. ||
|#