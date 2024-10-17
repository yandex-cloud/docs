---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Cluster/updateShardGroup.md
---

# Managed Service for ClickHouse API, gRPC: ClusterService.UpdateShardGroup {#UpdateShardGroup}

Updates the specified shard group.

## gRPC request

**rpc UpdateShardGroup ([UpdateClusterShardGroupRequest](#yandex.cloud.mdb.clickhouse.v1.UpdateClusterShardGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateClusterShardGroupRequest {#yandex.cloud.mdb.clickhouse.v1.UpdateClusterShardGroupRequest}

```json
{
  "clusterId": "string",
  "shardGroupName": "string",
  "updateMask": "google.protobuf.FieldMask",
  "description": "string",
  "shardNames": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the ClickHouse cluster that contains the shard group to update.

To get the cluster ID, make a [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) request. ||
|| shardGroupName | **string**

Required field. Name of the shard group that should be updated.

To get the name, make a [ClusterService.ListShardGroups](/docs/managed-clickhouse/api-ref/grpc/Cluster/listShardGroups#ListShardGroups) request. ||
|| updateMask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)** ||
|| description | **string**

Updated description of the shard group. 0-256 characters long. ||
|| shardNames[] | **string**

Updated list of shard names that belongs to the shard group. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "clusterId": "string",
    "shardGroupName": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    "clusterId": "string",
    "description": "string",
    "shardNames": [
      "string"
    ]
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateClusterShardGroupMetadata](#yandex.cloud.mdb.clickhouse.v1.UpdateClusterShardGroupMetadata)**

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
|| response | **[ShardGroup](#yandex.cloud.mdb.clickhouse.v1.ShardGroup)**

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

## UpdateClusterShardGroupMetadata {#yandex.cloud.mdb.clickhouse.v1.UpdateClusterShardGroupMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the cluster that contains the shard group being updated. ||
|| shardGroupName | **string**

Name of the shard group that is being updated. ||
|#

## ShardGroup {#yandex.cloud.mdb.clickhouse.v1.ShardGroup}

#|
||Field | Description ||
|| name | **string**

Name of the shard group. ||
|| clusterId | **string**

ID of the ClickHouse cluster that the shard group belongs to. ||
|| description | **string**

Description of the shard group. 0-256 characters long. ||
|| shardNames[] | **string**

List of shard names contained in the shard group. ||
|#