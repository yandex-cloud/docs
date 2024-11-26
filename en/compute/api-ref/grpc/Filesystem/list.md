---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/Filesystem/list.md
---

# Compute Cloud API, gRPC: FilesystemService.List

Lists filesystems in the specified folder.

## gRPC request

**rpc List ([ListFilesystemsRequest](#yandex.cloud.compute.v1.ListFilesystemsRequest)) returns ([ListFilesystemsResponse](#yandex.cloud.compute.v1.ListFilesystemsResponse))**

## ListFilesystemsRequest {#yandex.cloud.compute.v1.ListFilesystemsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list filesystems in.

To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListFilesystemsResponse.next_page_token](#yandex.cloud.compute.v1.ListFilesystemsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListFilesystemsResponse.next_page_token](#yandex.cloud.compute.v1.ListFilesystemsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.

Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
2. `<operator>` is a logical operator, one of `=`, `!=`, `IN`, `NOT IN`.
3. `<value>` represents a value.
String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash). ||
|| order_by | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
The default sorting order is ascending ||
|#

## ListFilesystemsResponse {#yandex.cloud.compute.v1.ListFilesystemsResponse}

```json
{
  "filesystems": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| filesystems[] | **[Filesystem](#yandex.cloud.compute.v1.Filesystem)**

List of filesystems in the specified folder. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListFilesystemsRequest.page_size](#yandex.cloud.compute.v1.ListFilesystemsRequest), use `next_page_token` as the value
for the [ListFilesystemsRequest.page_token](#yandex.cloud.compute.v1.ListFilesystemsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
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