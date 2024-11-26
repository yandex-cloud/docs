---
editable: false
sourcePath: en/_api-ref-grpc/resourcemanager/v1/api-ref/grpc/Cloud/delete.md
---

# Resource Manager API, gRPC: CloudService.Delete

Deletes the specified cloud.

## gRPC request

**rpc Delete ([DeleteCloudRequest](#yandex.cloud.resourcemanager.v1.DeleteCloudRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## DeleteCloudRequest {#yandex.cloud.resourcemanager.v1.DeleteCloudRequest}

```json
{
  "cloud_id": "string",
  "delete_after": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| cloud_id | **string**

Required field. ID of the cloud to delete.
To get the cloud ID, use a [CloudService.List](/docs/resource-manager/api-ref/grpc/Cloud/list#List) request. ||
|| delete_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The timestamp after which the process of deleting the cloud should begin.
Until this timestamp, the cloud goes into the PENDING_DELETION state and all resources in this
cloud are stopped. In this state, it is possible to cancel the delete operation without any loss.
After this timestamp, the status of the cloud will become DELETING and the process of deleting
all the resources  of the cloud will be started. If `delete_after` is not specified it will be
(now + 24 hours). To initiate an immediate deletion `delete_after` must be <= now. ||
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
    "cloud_id": "string",
    "delete_after": "google.protobuf.Timestamp",
    "cancelled_by": "string",
    "cancelled_at": "google.protobuf.Timestamp"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Empty"
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
|| metadata | **[DeleteCloudMetadata](#yandex.cloud.resourcemanager.v1.DeleteCloudMetadata)**

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
|| response | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

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

## DeleteCloudMetadata {#yandex.cloud.resourcemanager.v1.DeleteCloudMetadata}

#|
||Field | Description ||
|| cloud_id | **string**

ID of the cloud that is being deleted. ||
|| delete_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The timestamp after which the process of deleting the cloud should begin. ||
|| cancelled_by | **string**

Information about operation cancellation ||
|| cancelled_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#