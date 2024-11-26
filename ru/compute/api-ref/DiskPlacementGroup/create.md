---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/DiskPlacementGroup/create.md
---

# Compute Cloud API, REST: DiskPlacementGroup.Create

Creates a placement group in the specified folder.

## HTTP request

```
POST https://compute.{{ api-host }}/compute/v1/diskPlacementGroups
```

## Body parameters {#yandex.cloud.compute.v1.CreateDiskPlacementGroupRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "zoneId": "string",
  // Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`
  "spreadPlacementStrategy": "object",
  "partitionPlacementStrategy": {
    "partitions": "string"
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create a placement group in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| name | **string**

Name of the placement group. ||
|| description | **string**

Description of the placement group. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|| zoneId | **string**

Required field. ID of the availability zone where the placement group resides.
To get a list of available zones use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request. ||
|| spreadPlacementStrategy | **object**

Distribute disks over distinct failure domains.

Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`.

Placement strategy. ||
|| partitionPlacementStrategy | **[DiskPartitionPlacementStrategy](#yandex.cloud.compute.v1.DiskPartitionPlacementStrategy)**

Distribute disks over partitions.

Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`.

Placement strategy. ||
|#

## DiskPartitionPlacementStrategy {#yandex.cloud.compute.v1.DiskPartitionPlacementStrategy}

#|
||Field | Description ||
|| partitions | **string** (int64) ||
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
  "metadata": {
    "diskPlacementGroupId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "string",
    "zoneId": "string",
    "status": "string",
    // Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`
    "spreadPlacementStrategy": "object",
    "partitionPlacementStrategy": {
      "partitions": "string"
    }
    // end of the list of possible fields
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
|| metadata | **[CreateDiskPlacementGroupMetadata](#yandex.cloud.compute.v1.CreateDiskPlacementGroupMetadata)**

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
|| response | **[DiskPlacementGroup](#yandex.cloud.compute.v1.DiskPlacementGroup)**

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

## CreateDiskPlacementGroupMetadata {#yandex.cloud.compute.v1.CreateDiskPlacementGroupMetadata}

#|
||Field | Description ||
|| diskPlacementGroupId | **string**

ID of the placement group that is being created. ||
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

## DiskPlacementGroup {#yandex.cloud.compute.v1.DiskPlacementGroup}

#|
||Field | Description ||
|| id | **string**

ID of the placement group. ||
|| folderId | **string**

ID of the folder that the placement group belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the placement group.
The name is unique within the folder. ||
|| description | **string**

Description of the placement group. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|| zoneId | **string**

ID of the availability zone where the placement group resides. ||
|| status | **enum** (Status)

Current status of the placement group

- `STATUS_UNSPECIFIED`
- `CREATING`
- `READY`
- `DELETING` ||
|| spreadPlacementStrategy | **object**

Distribute disks over distinct failure domains.

Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`.

Placement strategy. ||
|| partitionPlacementStrategy | **[DiskPartitionPlacementStrategy](#yandex.cloud.compute.v1.DiskPartitionPlacementStrategy2)**

Distribute disks over partitions.

Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`.

Placement strategy. ||
|#

## DiskPartitionPlacementStrategy {#yandex.cloud.compute.v1.DiskPartitionPlacementStrategy2}

#|
||Field | Description ||
|| partitions | **string** (int64) ||
|#