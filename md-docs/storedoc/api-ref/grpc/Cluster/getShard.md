[Документация Yandex Cloud](../../../../index.md) > [Yandex StoreDoc](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Cluster](index.md) > GetShard

# Managed Service for MongoDB API, gRPC: ClusterService.GetShard

Returns the specified shard.

## gRPC request

**rpc GetShard ([GetClusterShardRequest](#yandex.cloud.mdb.mongodb.v1.GetClusterShardRequest)) returns ([Shard](#yandex.cloud.mdb.mongodb.v1.Shard))**

## GetClusterShardRequest {#yandex.cloud.mdb.mongodb.v1.GetClusterShardRequest}

```json
{
  "cluster_id": "string",
  "shard_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the StoreDoc cluster that the shard belongs to.
To get the cluster ID use a [ClusterService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|| shard_name | **string**

Required field. Name of the StoreDoc shard to return.
To get the name of the shard use a [ClusterService.ListShards](listShards.md#ListShards) request.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|#

## Shard {#yandex.cloud.mdb.mongodb.v1.Shard}

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

Name of the shard. ||
|| cluster_id | **string**

ID of the cluster that the shard belongs to. ||
|| is_ha | **bool**

Indicates whether the shard topology is highly available as defined by the Yandex Cloud SLA for managed databases. ||
|#