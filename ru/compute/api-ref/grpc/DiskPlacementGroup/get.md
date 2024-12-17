---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/DiskPlacementGroup/get.md
---

# Compute Cloud API, gRPC: DiskPlacementGroupService.Get

Returns the specified placement group.

## gRPC request

**rpc Get ([GetDiskPlacementGroupRequest](#yandex.cloud.compute.v1.GetDiskPlacementGroupRequest)) returns ([DiskPlacementGroup](#yandex.cloud.compute.v1.DiskPlacementGroup))**

## GetDiskPlacementGroupRequest {#yandex.cloud.compute.v1.GetDiskPlacementGroupRequest}

```json
{
  "disk_placement_group_id": "string"
}
```

#|
||Field | Description ||
|| disk_placement_group_id | **string**

Required field. ID of the placement group to return.
To get the placement group ID, use [DiskPlacementGroupService.List](/docs/compute/api-ref/grpc/DiskPlacementGroup/list#List) request. ||
|#

## DiskPlacementGroup {#yandex.cloud.compute.v1.DiskPlacementGroup}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "zone_id": "string",
  "status": "Status",
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
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| zone_id | **string**

ID of the availability zone where the placement group resides. ||
|| status | enum **Status**

Current status of the placement group

- `STATUS_UNSPECIFIED`
- `CREATING`
- `READY`
- `DELETING` ||
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