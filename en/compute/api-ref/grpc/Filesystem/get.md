---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/Filesystem/get.md
---

# Compute Cloud API, gRPC: FilesystemService.Get

Returns the specified filesystem.

To get the list of available filesystems, make a [List](/docs/compute/api-ref/grpc/Filesystem/list#List) request.

## gRPC request

**rpc Get ([GetFilesystemRequest](#yandex.cloud.compute.v1.GetFilesystemRequest)) returns ([Filesystem](#yandex.cloud.compute.v1.Filesystem))**

## GetFilesystemRequest {#yandex.cloud.compute.v1.GetFilesystemRequest}

```json
{
  "filesystem_id": "string"
}
```

#|
||Field | Description ||
|| filesystem_id | **string**

Required field. ID of the filesystem to return.

To get the filesystem ID, make a [FilesystemService.List](/docs/compute/api-ref/grpc/Filesystem/list#List) request. ||
|#

## Filesystem {#yandex.cloud.compute.v1.Filesystem}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "type_id": "string",
  "zone_id": "string",
  "size": "int64",
  "block_size": "int64",
  "status": "Status"
}
```

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
|| labels | **string**

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