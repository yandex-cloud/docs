[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Video](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Video](index.md) > PerformAction

# Video API, gRPC: VideoService.PerformAction

Performs a specific action on a video, such as publishing or unpublishing.

## gRPC request

**rpc PerformAction ([PerformVideoActionRequest](#yandex.cloud.video.v1.PerformVideoActionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## PerformVideoActionRequest {#yandex.cloud.video.v1.PerformVideoActionRequest}

```json
{
  "video_id": "string",
  // Includes only one of the fields `publish`, `unpublish`
  "publish": "PublishVideoAction",
  "unpublish": "UnpublishVideoAction"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| video_id | **string**

Required field. ID of the video on which to perform the action.

The maximum string length in characters is 50. ||
|| publish | **[PublishVideoAction](#yandex.cloud.video.v1.PublishVideoAction)**

Publish the video, making it available for watching.
Changes the video's visibility status to PUBLISHED.

Includes only one of the fields `publish`, `unpublish`.

Specifies the action to perform on the video (exactly one must be chosen). ||
|| unpublish | **[UnpublishVideoAction](#yandex.cloud.video.v1.UnpublishVideoAction)**

Unpublish the video, making it unavailable for watching.
Changes the video's visibility status to UNPUBLISHED.

Includes only one of the fields `publish`, `unpublish`.

Specifies the action to perform on the video (exactly one must be chosen). ||
|#

## PublishVideoAction {#yandex.cloud.video.v1.PublishVideoAction}

Parameters for the publish action.

#|
||Field | Description ||
|| Empty | > ||
|#

## UnpublishVideoAction {#yandex.cloud.video.v1.UnpublishVideoAction}

Parameters for the unpublish action.

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