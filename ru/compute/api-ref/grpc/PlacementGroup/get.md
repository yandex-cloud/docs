---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/PlacementGroup/get.md
---

# Compute Cloud API, gRPC: PlacementGroupService.Get

Returns the specified placement group.

To get the list of all available placement groups, make a [List](/docs/compute/api-ref/grpc/PlacementGroup/list#List) request.

## gRPC request

**rpc Get ([GetPlacementGroupRequest](#yandex.cloud.compute.v1.GetPlacementGroupRequest)) returns ([PlacementGroup](#yandex.cloud.compute.v1.PlacementGroup))**

## GetPlacementGroupRequest {#yandex.cloud.compute.v1.GetPlacementGroupRequest}

```json
{
  "placement_group_id": "string"
}
```

#|
||Field | Description ||
|| placement_group_id | **string**

ID of the placement group to return.

To get a placement group ID make a [PlacementGroupService.List](/docs/compute/api-ref/grpc/PlacementGroup/list#List) request. ||
|#

## PlacementGroup {#yandex.cloud.compute.v1.PlacementGroup}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  // Includes only one of the fields `spread_placement_strategy`, `partition_placement_strategy`
  "spread_placement_strategy": "SpreadPlacementStrategy",
  "partition_placement_strategy": {
    "partitions": "int64"
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| id | **string**

ID of the placement group. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the placement group belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the placement group.
The name is unique within the folder. ||
|| description | **string**

Description of the placement group. 0-256 characters long. ||
|| labels | **string**

Placement group labels as `key:value` pairs. ||
|| spread_placement_strategy | **[SpreadPlacementStrategy](#yandex.cloud.compute.v1.SpreadPlacementStrategy)**

Anti-affinity placement strategy (`spread`). Instances are distributed
over distinct failure domains.

Includes only one of the fields `spread_placement_strategy`, `partition_placement_strategy`.

Placement strategy. To specify a placement strategy, send the corresponding
field containing approriate structure. ||
|| partition_placement_strategy | **[PartitionPlacementStrategy](#yandex.cloud.compute.v1.PartitionPlacementStrategy)**

Includes only one of the fields `spread_placement_strategy`, `partition_placement_strategy`.

Placement strategy. To specify a placement strategy, send the corresponding
field containing approriate structure. ||
|#

## SpreadPlacementStrategy {#yandex.cloud.compute.v1.SpreadPlacementStrategy}

This is an empty structure that must be passed to explicitly
specify the required placement strategy.

#|
||Field | Description ||
|| Empty | > ||
|#

## PartitionPlacementStrategy {#yandex.cloud.compute.v1.PartitionPlacementStrategy}

#|
||Field | Description ||
|| partitions | **int64** ||
|#