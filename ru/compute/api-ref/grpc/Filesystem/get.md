---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/Filesystem/get.md
---

# Compute Cloud API, gRPC: FilesystemService.Get {#Get}

Returns the specified filesystem.

To get the list of available filesystems, make a [List](/docs/compute/api-ref/grpc/Filesystem/list#List) request.

## gRPC request

**rpc Get ([GetFilesystemRequest](#yandex.cloud.compute.v1.GetFilesystemRequest)) returns ([Filesystem](#yandex.cloud.compute.v1.Filesystem))**

## GetFilesystemRequest {#yandex.cloud.compute.v1.GetFilesystemRequest}

```json
{
  "filesystemId": "string"
}
```

#|
||Field | Description ||
|| filesystemId | **string**

Required field. ID of the filesystem to return.

To get the filesystem ID, make a [FilesystemService.List](/docs/compute/api-ref/grpc/Filesystem/list#List) request. ||
|#

## Filesystem {#yandex.cloud.compute.v1.Filesystem}

```json
{
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
```

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