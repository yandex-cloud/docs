---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Cluster/getShardGroup.md
---

# Managed Service for ClickHouse API, gRPC: ClusterService.GetShardGroup

Returns the specified shard group.

## gRPC request

**rpc GetShardGroup ([GetClusterShardGroupRequest](#yandex.cloud.mdb.clickhouse.v1.GetClusterShardGroupRequest)) returns ([ShardGroup](#yandex.cloud.mdb.clickhouse.v1.ShardGroup))**

## GetClusterShardGroupRequest {#yandex.cloud.mdb.clickhouse.v1.GetClusterShardGroupRequest}

```json
{
  "cluster_id": "string",
  "shard_group_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster that the shard group belongs to.

To get the cluster ID, make a [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) request. ||
|| shard_group_name | **string**

Required field. Name of the shard group to request information about.

To get the name of a shard group, make a [ClusterService.ListShardGroups](/docs/managed-clickhouse/api-ref/grpc/Cluster/listShardGroups#ListShardGroups) request. ||
|#

## ShardGroup {#yandex.cloud.mdb.clickhouse.v1.ShardGroup}

```json
{
  "name": "string",
  "cluster_id": "string",
  "description": "string",
  "shard_names": [
    "string"
  ]
}
```

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