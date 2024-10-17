---
editable: false
sourcePath: en/_api-ref-grpc/mdb/redis/v1/api-ref/grpc/Cluster/getShard.md
---

# Managed Service for Redis API, gRPC: ClusterService.GetShard {#GetShard}

Returns the specified shard.

## gRPC request

**rpc GetShard ([GetClusterShardRequest](#yandex.cloud.mdb.redis.v1.GetClusterShardRequest)) returns ([Shard](#yandex.cloud.mdb.redis.v1.Shard))**

## GetClusterShardRequest {#yandex.cloud.mdb.redis.v1.GetClusterShardRequest}

```json
{
  "clusterId": "string",
  "shardName": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Redis cluster the shard belongs to.
To get the cluster ID use a [ClusterService.List](/docs/managed-redis/api-ref/grpc/Cluster/list#List) request. ||
|| shardName | **string**

Required field. Name of Redis shard to return.
To get the shard name use a [ClusterService.ListShards](/docs/managed-redis/api-ref/grpc/Cluster/listShards#ListShards) request. ||
|#

## Shard {#yandex.cloud.mdb.redis.v1.Shard}

```json
{
  "name": "string",
  "clusterId": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the Redis shard. The shard name is assigned by user at creation time, and cannot be changed.
1-63 characters long. ||
|| clusterId | **string**

ID of the Redis cluster the shard belongs to. The ID is assigned by MDB at creation time. ||
|#