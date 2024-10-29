---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/Filesystem/create.md
---

# Compute Cloud API, gRPC: FilesystemService.Create {#Create}

Creates a filesystem in the specified folder.

## gRPC request

**rpc Create ([CreateFilesystemRequest](#yandex.cloud.compute.v1.CreateFilesystemRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateFilesystemRequest {#yandex.cloud.compute.v1.CreateFilesystemRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "typeId": "string",
  "zoneId": "string",
  "size": "int64",
  "blockSize": "int64"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create a filesystem in.

To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the filesystem. The name must be unique within the folder. ||
|| description | **string**

Description of the filesystem. ||
|| labels | **string**

Filesystem labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels). ||
|| typeId | **string**

ID of the filesystem type.

To get a list of available filesystem types, make a [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/grpc/DiskType/list#List) request.

The filesystem type cannot be updated after the filesystem creation. ||
|| zoneId | **string**

Required field. ID of the availability zone where the filesystem resides.

To get a list of available zones, make a [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request.

A filesystem can be attached only to virtual machines residing in the same availability zone.
The filesystem availability zone cannot be updated after the filesystem creation. ||
|| size | **int64**

Required field. Size of the filesystem, specified in bytes.

The size of the filesystem cannot be updated after the filesystem creation. ||
|| blockSize | **int64**

Block size used for the filesystem, specified in bytes.

The block size cannot be updated after the filesystem creation.

Default value: 4096. ||
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
    "filesystemId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "typeId": "string",
    "zoneId": "string",
    "size": "int64",
    "blockSize": "int64",
    "status": "Status"
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
|| metadata | **[CreateFilesystemMetadata](#yandex.cloud.compute.v1.CreateFilesystemMetadata)**

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
|| response | **[Filesystem](#yandex.cloud.compute.v1.Filesystem)**

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

## CreateFilesystemMetadata {#yandex.cloud.compute.v1.CreateFilesystemMetadata}

#|
||Field | Description ||
|| filesystemId | **string**

ID of the filesystem that is being created. ||
|#

## Filesystem {#yandex.cloud.compute.v1.Filesystem}

A filesystem resource.
For details about the concept, see [documentation](/docs/compute/concepts/filesystem).

#|
||Field | Description ||
|| id | **string**

ID of the filesystem. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the filesystem belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the filesystem. The name is unique within the folder. ||
|| description | **string**

Description of the filesystem. ||
|| labels | **string**

Filesystem labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels). ||
|| typeId | **string**

ID of the filesystem type.

To get a list of available filesystem types, make a [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/grpc/DiskType/list#List) request. ||
|| zoneId | **string**

ID of the availability zone where the filesystem resides.

A filesystem can be attached only to instances residing in the same availability zone. ||
|| size | **int64**

Size of the filesystem, specified in bytes. ||
|| blockSize | **int64**

Block size used for the filesystem, specified in bytes. ||
|| status | enum **Status**

Current status of the filesystem.

- `STATUS_UNSPECIFIED`
- `CREATING`: The filesystem is being created.
- `READY`: The filesystem is ready to use.
- `ERROR`: The filesystem encountered a problem and cannot operate.
- `DELETING`: The filesystem is being deleted. ||
|#