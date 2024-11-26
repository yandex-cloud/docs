---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mongodb/v1/api-ref/grpc/Cluster/getShard.md
---

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

Required field. ID of the MongoDB cluster that the shard belongs to.
To get the cluster ID use a [ClusterService.List](/docs/managed-mongodb/api-ref/grpc/Cluster/list#List) request. ||
|| shard_name | **string**

Required field. Name of the MongoDB shard to return.
To get the name of the shard use a [ClusterService.ListShards](/docs/managed-mongodb/api-ref/grpc/Cluster/listShards#ListShards) request. ||
|#

## Shard {#yandex.cloud.mdb.mongodb.v1.Shard}

```json
{
  "name": "string",
  "cluster_id": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the shard. ||
|| cluster_id | **string**

ID of the cluster that the shard belongs to. ||
|#