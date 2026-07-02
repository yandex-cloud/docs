[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Filesystem](index.md) > Create

# Compute Cloud API, REST: Filesystem.Create

Creates a filesystem in the specified folder.

## HTTP request

```
POST https://compute.api.cloud.yandex.net/compute/v1/filesystems
```

## Body parameters {#yandex.cloud.compute.v1.CreateFilesystemRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "typeId": "string",
  "zoneId": "string",
  "size": "string",
  "blockSize": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to create a filesystem in.
To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../resource-manager/api-ref/Folder/list.md#List) request.
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
For details about the concept, see [documentation](../../../overview/concepts/services.md#labels).
Each map key must match the regular expression: `[a-z][-_./\\@0-9a-z]*`.
Each map value must match the regular expression: `[-_./\\@0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 63.
The number of elements must be less than or equal to 64. ||
|| typeId | **string**

ID of the filesystem type.
To get a list of available filesystem types, make a [yandex.cloud.compute.v1.DiskTypeService.List](../DiskType/list.md#List) request.
The filesystem type cannot be updated after the filesystem creation.
The length must be less than or equal to 50. ||
|| zoneId | **string**

ID of the availability zone where the filesystem resides.
To get a list of available zones, make a [yandex.cloud.compute.v1.ZoneService.List](../Zone/list.md#List) request.
A filesystem can be attached only to virtual machines residing in the same availability zone.
The filesystem availability zone cannot be updated after the filesystem creation.
The length must be less than or equal to 50.
This field is required. ||
|| size | **string** (int64)

Size of the filesystem, specified in bytes.
The size of the filesystem cannot be updated after the filesystem creation.
This field is required. ||
|| blockSize | **string** (int64)

Block size used for the filesystem, specified in bytes.
The block size cannot be updated after the filesystem creation.
Default value: 4096. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#