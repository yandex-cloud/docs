[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for Valkey™](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Cluster](index.md) > GetShard

# Managed Service for Redis API, gRPC: ClusterService.GetShard

Returns the specified shard.

## gRPC request

**rpc GetShard ([GetClusterShardRequest](#yandex.cloud.mdb.redis.v1.GetClusterShardRequest)) returns ([Shard](#yandex.cloud.mdb.redis.v1.Shard))**

## GetClusterShardRequest {#yandex.cloud.mdb.redis.v1.GetClusterShardRequest}

```json
{
  "cluster_id": "string",
  "shard_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Redis cluster the shard belongs to.
To get the cluster ID use a [ClusterService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|| shard_name | **string**

Required field. Name of Redis shard to return.
To get the shard name use a [ClusterService.ListShards](listShards.md#ListShards) request.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|#

## Shard {#yandex.cloud.mdb.redis.v1.Shard}

```json
{
  "name": "string",
  "cluster_id": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Name of the Redis shard. The shard name is assigned by user at creation time, and cannot be changed.
1-63 characters long. ||
|| cluster_id | **string**

Required field. ID of the Redis cluster the shard belongs to. The ID is assigned by MDB at creation time. ||
|#