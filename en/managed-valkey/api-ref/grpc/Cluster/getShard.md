---
editable: false
---

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

Required field. ID of the Valkey cluster the shard belongs to.
To get the cluster ID use a [ClusterService.List](/docs/managed-redis/api-ref/grpc/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|| shard_name | **string**

Required field. Name of Valkey shard to return.
To get the shard name use a [ClusterService.ListShards](/docs/managed-redis/api-ref/grpc/Cluster/listShards#ListShards) request.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|#

## Shard {#yandex.cloud.mdb.redis.v1.Shard}

```json
{
  "name": "string",
  "cluster_id": "string",
  "is_ha": "bool"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the Valkey shard. The shard name is assigned by user at creation time, and cannot be changed.
1-63 characters long. ||
|| cluster_id | **string**

ID of the Valkey cluster the shard belongs to. The ID is assigned by MDB at creation time. ||
|| is_ha | **bool**

Indicates whether the shard topology is highly available as defined by the Yandex Cloud SLA for managed databases. ||
|#