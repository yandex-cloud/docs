# Managed Service for Redis API, REST: Cluster.GetShard

Returns the specified shard.

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/{clusterId}/shards/{shardName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Redis cluster the shard belongs to.
To get the cluster ID use a [ClusterService.List](../../../managed-redis/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|| shardName | **string**

Required field. Name of Redis shard to return.
To get the shard name use a [ClusterService.ListShards](../../../managed-redis/api-ref/Cluster/listShards#ListShards) request.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|#

## Response {#yandex.cloud.mdb.redis.v1.Shard}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Name of the Redis shard. The shard name is assigned by user at creation time, and cannot be changed.
1-63 characters long. ||
|| clusterId | **string**

Required field. ID of the Redis cluster the shard belongs to. The ID is assigned by MDB at creation time. ||
|#