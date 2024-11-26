---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Cluster/createShardGroup.md
---

# Managed Service for ClickHouse API, gRPC: ClusterService.CreateShardGroup

Creates a new shard group in the specified cluster.

## gRPC request

**rpc CreateShardGroup ([CreateClusterShardGroupRequest](#yandex.cloud.mdb.clickhouse.v1.CreateClusterShardGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateClusterShardGroupRequest {#yandex.cloud.mdb.clickhouse.v1.CreateClusterShardGroupRequest}

```json
{
  "cluster_id": "string",
  "shard_group_name": "string",
  "description": "string",
  "shard_names": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the ClickHouse cluster to add a shard group to.

To get the cluster ID, make a [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) request. ||
|| shard_group_name | **string**

Required field. Name for the new shard group. ||
|| description | **string**

Description of the new shard group. 0-256 characters long. ||
|| shard_names[] | **string**

List of shard names that should be put into the new group.

To get the list, make a [ClusterService.ListShardGroups](/docs/managed-clickhouse/api-ref/grpc/Cluster/listShardGroups#ListShardGroups) request. ||
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
    "cluster_id": "string",
    "shard_group_name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    "cluster_id": "string",
    "description": "string",
    "shard_names": [
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateClusterShardGroupMetadata](#yandex.cloud.mdb.clickhouse.v1.CreateClusterShardGroupMetadata)**

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

## CreateClusterShardGroupMetadata {#yandex.cloud.mdb.clickhouse.v1.CreateClusterShardGroupMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the cluster to add a shard group to. ||
|| shard_group_name | **string**

Name of the shard group that is being added. ||
|#

## ShardGroup {#yandex.cloud.mdb.clickhouse.v1.ShardGroup}

#|
||Field | Description ||
|| name | **string**

Name of the shard group. ||
|| cluster_id | **string**

ID of the ClickHouse cluster that the shard group belongs to. ||
|| description | **string**

Description of the shard group. 0-256 characters long. ||
|| shard_names[] | **string**

List of shard names contained in the shard group. ||
|#