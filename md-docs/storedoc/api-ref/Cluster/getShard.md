[Документация Yandex Cloud](../../../index.md) > [Yandex StoreDoc](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Cluster](index.md) > GetShard

# Managed Service for MongoDB API, REST: Cluster.GetShard

Returns the specified shard.

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}/shards/{shardName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the MongoDB cluster that the shard belongs to.
To get the cluster ID use a [ClusterService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|| shardName | **string**

Required field. Name of the MongoDB shard to return.
To get the name of the shard use a [ClusterService.ListShards](listShards.md#ListShards) request.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|#

## Response {#yandex.cloud.mdb.mongodb.v1.Shard}

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

Name of the shard. ||
|| clusterId | **string**

ID of the cluster that the shard belongs to. ||
|#