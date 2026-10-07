[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Valkey™](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Cluster](index.md) > GetShard

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

Required field. ID of the Valkey cluster the shard belongs to.
To get the cluster ID use a [ClusterService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|| shardName | **string**

Required field. Name of Valkey shard to return.
To get the shard name use a [ClusterService.ListShards](listShards.md#ListShards) request.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|#

## Response {#yandex.cloud.mdb.redis.v1.Shard}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string",
  "isHa": "boolean"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the Valkey shard. The shard name is assigned by user at creation time, and cannot be changed.
1-63 characters long. ||
|| clusterId | **string**

ID of the Valkey cluster the shard belongs to. The ID is assigned by MDB at creation time. ||
|| isHa | **boolean**

Indicates whether the shard topology is highly available as defined by the Yandex Cloud SLA for managed databases. ||
|#