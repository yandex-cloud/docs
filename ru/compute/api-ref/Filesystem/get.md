---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/Filesystem/get.md
---

# Compute Cloud API, REST: Filesystem.Get {#Get}

Returns the specified filesystem.

To get the list of available filesystems, make a [List](/docs/compute/api-ref/Filesystem/list#List) request.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/filesystems/{filesystemId}
```

## Path parameters

#|
||Field | Description ||
|| filesystemId | **string**

Required field. ID of the filesystem to return.

To get the filesystem ID, make a [FilesystemService.List](/docs/compute/api-ref/Filesystem/list#List) request. ||
|#

## Response {#yandex.cloud.compute.v1.Filesystem}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "typeId": "string",
  "zoneId": "string",
  "size": "string",
  "blockSize": "string",
  "status": "string"
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
|| labels | **string**

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