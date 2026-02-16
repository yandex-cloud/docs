---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Project/resizeDisk.md
---

# DataSphere API v2, gRPC: ProjectService.ResizeDisk

Resizes project disk

## gRPC request

**rpc ResizeDisk ([ResizeProjectDiskRequest](#yandex.cloud.datasphere.v2.ResizeProjectDiskRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## ResizeProjectDiskRequest {#yandex.cloud.datasphere.v2.ResizeProjectDiskRequest}

```json
{
  "project_id": "string",
  "new_disk_size_gb": "int64"
}
```

#|
||Field | Description ||
|| project_id | **string**

Required field. ID of the project. ||
|| new_disk_size_gb | **int64**

Set new size project disk in gigabytes. ||
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
    "project_id": "string",
    "old_disk_size_gb": "int64",
    "new_disk_size_gb": "int64"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "project_id": "string",
    "disk_size_gb": "double",
    "disk_used_gb": "double",
    "detailed_usage": {
      "user_data_gb": "double",
      "packages_gb": "double",
      "system_data_gb": "double",
      "free_space_gb": "double"
    }
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
|| metadata | **[ResizeProjectDiskMetadata](#yandex.cloud.datasphere.v2.ResizeProjectDiskMetadata)**

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
|| response | **[DiskInfo](#yandex.cloud.datasphere.v2.DiskInfo)**

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

## ResizeProjectDiskMetadata {#yandex.cloud.datasphere.v2.ResizeProjectDiskMetadata}

#|
||Field | Description ||
|| project_id | **string**

ID of the project which resized project disk. ||
|| old_disk_size_gb | **int64**

Old size project disk in gigabytes. ||
|| new_disk_size_gb | **int64**

New size project disk in gigabytes. ||
|#

## DiskInfo {#yandex.cloud.datasphere.v2.DiskInfo}

#|
||Field | Description ||
|| project_id | **string**

ID of the project. ||
|| disk_size_gb | **double**

Project disk size in gigabytes. ||
|| disk_used_gb | **double**

Used project disk in gigabytes. ||
|| detailed_usage | **[DetailedDiskInfo](#yandex.cloud.datasphere.v2.DiskInfo.DetailedDiskInfo)**

Detailed information about the project disk. ||
|#

## DetailedDiskInfo {#yandex.cloud.datasphere.v2.DiskInfo.DetailedDiskInfo}

#|
||Field | Description ||
|| user_data_gb | **double**

Used project disk for user data in gigabytes. ||
|| packages_gb | **double**

Used project disk for packages in gigabytes. ||
|| system_data_gb | **double**

Used project disk for system data in gigabytes. ||
|| free_space_gb | **double**

Free space project disk in gigabytes. ||
|#