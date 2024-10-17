---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/DiskPlacementGroup/get.md
---

# Compute Cloud API, gRPC: DiskPlacementGroupService.Get {#Get}

Returns the specified placement group.

## gRPC request

**rpc Get ([GetDiskPlacementGroupRequest](#yandex.cloud.compute.v1.GetDiskPlacementGroupRequest)) returns ([DiskPlacementGroup](#yandex.cloud.compute.v1.DiskPlacementGroup))**

## GetDiskPlacementGroupRequest {#yandex.cloud.compute.v1.GetDiskPlacementGroupRequest}

```json
{
  "diskPlacementGroupId": "string"
}
```

#|
||Field | Description ||
|| diskPlacementGroupId | **string**

Required field. ID of the placement group to return.
To get the placement group ID, use [DiskPlacementGroupService.List](/docs/compute/api-ref/grpc/DiskPlacementGroup/list#List) request. ||
|#

## DiskPlacementGroup {#yandex.cloud.compute.v1.DiskPlacementGroup}

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "zoneId": "string",
  "status": "Status",
  // Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`
  "spreadPlacementStrategy": "DiskSpreadPlacementStrategy",
  "partitionPlacementStrategy": {
    "partitions": "int64"
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| id | **string**

ID of the placement group. ||
|| folderId | **string**

ID of the folder that the placement group belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the placement group.
The name is unique within the folder. ||
|| description | **string**

Description of the placement group. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|| zoneId | **string**

ID of the availability zone where the placement group resides. ||
|| status | enum **Status**

Current status of the placement group

- `STATUS_UNSPECIFIED`
- `CREATING`
- `READY`
- `DELETING` ||
|| spreadPlacementStrategy | **[DiskSpreadPlacementStrategy](#yandex.cloud.compute.v1.DiskSpreadPlacementStrategy)**

Distribute disks over distinct failure domains.

Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`.

Placement strategy. ||
|| partitionPlacementStrategy | **[DiskPartitionPlacementStrategy](#yandex.cloud.compute.v1.DiskPartitionPlacementStrategy)**

Distribute disks over partitions.

Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`.

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