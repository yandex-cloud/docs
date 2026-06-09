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

Required field. ID of the stream on which to perform the action.

The maximum string length in characters is 50. ||
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