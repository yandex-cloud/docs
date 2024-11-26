---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/DiskPlacementGroup/create.md
---

# Compute Cloud API, gRPC: DiskPlacementGroupService.Create

Creates a placement group in the specified folder.

## gRPC request

**rpc Create ([CreateDiskPlacementGroupRequest](#yandex.cloud.compute.v1.CreateDiskPlacementGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateDiskPlacementGroupRequest {#yandex.cloud.compute.v1.CreateDiskPlacementGroupRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "zone_id": "string",
  // Includes only one of the fields `spread_placement_strategy`, `partition_placement_strategy`
  "spread_placement_strategy": "DiskSpreadPlacementStrategy",
  "partition_placement_strategy": {
    "partitions": "int64"
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a placement group in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the placement group. ||
|| description | **string**

Description of the placement group. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|| zone_id | **string**

Required field. ID of the availability zone where the placement group resides.
To get a list of available zones use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request. ||
|| spread_placement_strategy | **[DiskSpreadPlacementStrategy](#yandex.cloud.compute.v1.DiskSpreadPlacementStrategy)**

Distribute disks over distinct failure domains.

Includes only one of the fields `spread_placement_strategy`, `partition_placement_strategy`.

Placement strategy. ||
|| partition_placement_strategy | **[DiskPartitionPlacementStrategy](#yandex.cloud.compute.v1.DiskPartitionPlacementStrategy)**

Distribute disks over partitions.

Includes only one of the fields `spread_placement_strategy`, `partition_placement_strategy`.

Placement strategy. ||
|#

## DiskSpreadPlacementStrategy {#yandex.cloud.compute.v1.DiskSpreadPlacementStrategy}

#|
||Field | Description ||
|| Empty | > ||
|#

## DiskPartitionPlacementStrategy {#yandex.cloud.compute.v1.DiskPartitionPlacementStrategy}

#|
||Field | Description ||
|| partitions | **int64** ||
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
    "disk_placement_group_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "zone_id": "string",
    "status": "Status",
    // Includes only one of the fields `spread_placement_strategy`, `partition_placement_strategy`
    "spread_placement_strategy": "DiskSpreadPlacementStrategy",
    "partition_placement_strategy": {
      "partitions": "int64"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateDiskPlacementGroupMetadata](#yandex.cloud.compute.v1.CreateDiskPlacementGroupMetadata)**

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
|| disk_placement_group_id | **string**

ID of the placement group that is being created. ||
|#

## DiskPlacementGroup {#yandex.cloud.compute.v1.DiskPlacementGroup}

#|
||Field | Description ||
|| id | **string**

ID of the placement group. ||
|| folder_id | **string**

ID of the folder that the placement group belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the placement group.
The name is unique within the folder. ||
|| description | **string**

Description of the placement group. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|| zone_id | **string**

ID of the availability zone where the placement group resides. ||
|| status | enum **Status**

Current status of the placement group

- `STATUS_UNSPECIFIED`
- `CREATING`
- `READY`
- `DELETING` ||
|| spread_placement_strategy | **[DiskSpreadPlacementStrategy](#yandex.cloud.compute.v1.DiskSpreadPlacementStrategy2)**

Distribute disks over distinct failure domains.

Includes only one of the fields `spread_placement_strategy`, `partition_placement_strategy`.

Placement strategy. ||
|| partition_placement_strategy | **[DiskPartitionPlacementStrategy](#yandex.cloud.compute.v1.DiskPartitionPlacementStrategy2)**

Distribute disks over partitions.

Includes only one of the fields `spread_placement_strategy`, `partition_placement_strategy`.

Placement strategy. ||
|#

## DiskSpreadPlacementStrategy {#yandex.cloud.compute.v1.DiskSpreadPlacementStrategy2}

#|
||Field | Description ||
|| Empty | > ||
|#

## DiskPartitionPlacementStrategy {#yandex.cloud.compute.v1.DiskPartitionPlacementStrategy2}

#|
||Field | Description ||
|| partitions | **int64** ||
|#