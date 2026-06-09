# Compute Cloud API, gRPC: FilesystemService.Create

Creates a filesystem in the specified folder.

## gRPC request

**rpc Create ([CreateFilesystemRequest](#yandex.cloud.compute.v1.CreateFilesystemRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateFilesystemRequest {#yandex.cloud.compute.v1.CreateFilesystemRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "type_id": "string",
  "zone_id": "string",
  "size": "int64",
  "block_size": "int64"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to create a filesystem in.
To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| name | **string**

Name of the filesystem. The name must be unique within the folder.
The value must match the regular expression: ```|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?```. ||
|| description | **string**

Description of the filesystem.
The length must be less than or equal to 256. ||
|| labels | **object** (map<**string**, **string**>)

Filesystem labels as `key:value` pairs.
For details about the concept, see [documentation](../../../../overview/concepts/services.md#labels).
Each map key must match the regular expression: `[a-z][-_./\\@0-9a-z]*`.
Each map value must match the regular expression: `[-_./\\@0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 63.
The number of elements must be less than or equal to 64. ||
|| type_id | **string**

ID of the filesystem type.
To get a list of available filesystem types, make a [yandex.cloud.compute.v1.DiskTypeService.List](../DiskType/list.md#List) request.
The filesystem type cannot be updated after the filesystem creation.
The length must be less than or equal to 50. ||
|| zone_id | **string**

ID of the availability zone where the filesystem resides.
To get a list of available zones, make a [yandex.cloud.compute.v1.ZoneService.List](../Zone/list.md#List) request.
A filesystem can be attached only to virtual machines residing in the same availability zone.
The filesystem availability zone cannot be updated after the filesystem creation.
The length must be less than or equal to 50.
This field is required. ||
|| size | **int64**

Size of the filesystem, specified in bytes.
The size of the filesystem cannot be updated after the filesystem creation.
This field is required. ||
|| block_size | **int64**

Block size used for the filesystem, specified in bytes.
The block size cannot be updated after the filesystem creation.
Default value: 4096. ||
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