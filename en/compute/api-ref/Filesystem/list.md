---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/Filesystem/list.md
---

# Compute Cloud API, REST: Filesystem.List

Lists filesystems in the specified folder.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/filesystems
```

## Query parameters {#yandex.cloud.compute.v1.ListFilesystemsRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list filesystems in.

To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListFilesystemsResponse.nextPageToken](#yandex.cloud.compute.v1.ListFilesystemsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListFilesystemsResponse.nextPageToken](#yandex.cloud.compute.v1.ListFilesystemsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.

Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
2. `<operator>` is a logical operator, one of `=`, `!=`, `IN`, `NOT IN`.
3. `<value>` represents a value.
String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash). ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
The default sorting order is ascending ||
|#

## Response {#yandex.cloud.compute.v1.ListFilesystemsResponse}

**HTTP Code: 200 - OK**

```json
{
  "filesystems": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "typeId": "string",
      "zoneId": "string",
      "size": "string",
      "blockSize": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| filesystems[] | **[Filesystem](#yandex.cloud.compute.v1.Filesystem)**

List of filesystems in the specified folder. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListFilesystemsRequest.pageSize](#yandex.cloud.compute.v1.ListFilesystemsRequest), use `next_page_token` as the value
for the [ListFilesystemsRequest.pageToken](#yandex.cloud.compute.v1.ListFilesystemsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the filesystem. The name is unique within the folder. ||
|| description | **string**

Description of the filesystem. ||
|| labels | **object** (map<**string**, **string**>)

Filesystem labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels). ||
|| typeId | **string**

ID of the filesystem type.

To get a list of available filesystem types, make a [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/DiskType/list#List) request. ||
|| zoneId | **string**

ID of the availability zone where the filesystem resides.

A filesystem can be attached only to instances residing in the same availability zone. ||
|| size | **string** (int64)

Size of the filesystem, specified in bytes. ||
|| blockSize | **string** (int64)

Block size used for the filesystem, specified in bytes. ||
|| status | **enum** (Status)

Current status of the filesystem.

- `STATUS_UNSPECIFIED`
- `CREATING`: The filesystem is being created.
- `READY`: The filesystem is ready to use.
- `ERROR`: The filesystem encountered a problem and cannot operate.
- `DELETING`: The filesystem is being deleted. ||
|#