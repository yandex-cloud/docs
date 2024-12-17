---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/Filesystem/update.md
---

# Compute Cloud API, gRPC: FilesystemService.Update

Updates the specified filesystem.

## gRPC request

**rpc Update ([UpdateFilesystemRequest](#yandex.cloud.compute.v1.UpdateFilesystemRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateFilesystemRequest {#yandex.cloud.compute.v1.UpdateFilesystemRequest}

```json
{
  "filesystem_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "size": "int64"
}
```

#|
||Field | Description ||
|| filesystem_id | **string**

Required field. ID of the filesystem to update.

To get the filesystem ID, make a [FilesystemService.List](/docs/compute/api-ref/grpc/Filesystem/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which attributes of the filesystem should be updated. ||
|| name | **string**

New name of the filesystem. The name must be unique within the folder. ||
|| description | **string**

New description of the filesystem. ||
|| labels | **object** (map<**string**, **string**>)

New filesystem labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels).

Existing set of labels is completely replaced by the provided set, so if you just want
to add or remove a label:
1. Get the current set of labels with a [FilesystemService.Get](/docs/compute/api-ref/grpc/Filesystem/get#Get) request.
2. Add or remove a label in this set.
3. Send the new set in this field. ||
|| size | **int64**

Size of the filesystem, specified in bytes. ||
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
    "filesystem_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "type_id": "string",
    "zone_id": "string",
    "size": "int64",
    "block_size": "int64",
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateFilesystemMetadata](#yandex.cloud.compute.v1.UpdateFilesystemMetadata)**

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

## UpdateFilesystemMetadata {#yandex.cloud.compute.v1.UpdateFilesystemMetadata}

#|
||Field | Description ||
|| filesystem_id | **string**

ID of the filesystem that is being updated. ||
|#

## Filesystem {#yandex.cloud.compute.v1.Filesystem}

A filesystem resource.
For details about the concept, see [documentation](/docs/compute/concepts/filesystem).

#|
||Field | Description ||
|| id | **string**

ID of the filesystem. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the filesystem belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the filesystem. The name is unique within the folder. ||
|| description | **string**

Description of the filesystem. ||
|| labels | **object** (map<**string**, **string**>)

Filesystem labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels). ||
|| type_id | **string**

ID of the filesystem type.

To get a list of available filesystem types, make a [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/grpc/DiskType/list#List) request. ||
|| zone_id | **string**

ID of the availability zone where the filesystem resides.

A filesystem can be attached only to instances residing in the same availability zone. ||
|| size | **int64**

Size of the filesystem, specified in bytes. ||
|| block_size | **int64**

Block size used for the filesystem, specified in bytes. ||
|| status | enum **Status**

Current status of the filesystem.

- `STATUS_UNSPECIFIED`
- `CREATING`: The filesystem is being created.
- `READY`: The filesystem is ready to use.
- `ERROR`: The filesystem encountered a problem and cannot operate.
- `DELETING`: The filesystem is being deleted. ||
|#