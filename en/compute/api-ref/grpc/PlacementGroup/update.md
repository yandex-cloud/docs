---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/PlacementGroup/update.md
---

# Compute Cloud API, gRPC: PlacementGroupService.Update

Updates the specified placement group.

## gRPC request

**rpc Update ([UpdatePlacementGroupRequest](#yandex.cloud.compute.v1.UpdatePlacementGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdatePlacementGroupRequest {#yandex.cloud.compute.v1.UpdatePlacementGroupRequest}

```json
{
  "placement_group_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| placement_group_id | **string**

ID of the placement group to update.

To get the placement group ID, use an [PlacementGroupService.List](/docs/compute/api-ref/grpc/PlacementGroup/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the PlacementGroup resource should be updated. ||
|| name | **string**

Name of the placement group. ||
|| description | **string**

Description of the placement group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The existing set of `labels` is completely replaced by the provided set. ||
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
    "placement_group_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    // Includes only one of the fields `spread_placement_strategy`, `partition_placement_strategy`
    "spread_placement_strategy": "SpreadPlacementStrategy",
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
|| metadata | **[UpdatePlacementGroupMetadata](#yandex.cloud.compute.v1.UpdatePlacementGroupMetadata)**

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
|| response | **[PlacementGroup](#yandex.cloud.compute.v1.PlacementGroup)**

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

## UpdatePlacementGroupMetadata {#yandex.cloud.compute.v1.UpdatePlacementGroupMetadata}

#|
||Field | Description ||
|| placement_group_id | **string**

ID of the placement group that is being updated. ||
|#

## PlacementGroup {#yandex.cloud.compute.v1.PlacementGroup}

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
|| labels | **object** (map<**string**, **string**>)

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