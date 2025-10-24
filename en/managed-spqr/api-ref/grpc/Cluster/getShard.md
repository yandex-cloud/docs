---
editable: false
sourcePath: en/_api-ref-grpc/mdb/spqr/v1/api-ref/grpc/Cluster/getShard.md
---

# Managed Service for SPQR API, gRPC: ClusterService.GetShard

Returns the specified shard.

## gRPC request

**rpc GetShard ([GetClusterShardRequest](#yandex.cloud.mdb.spqr.v1.GetClusterShardRequest)) returns ([Shard](#yandex.cloud.mdb.spqr.v1.Shard))**

## GetClusterShardRequest {#yandex.cloud.mdb.spqr.v1.GetClusterShardRequest}

```json
{
  "cluster_id": "string",
  "shard_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the SPQR cluster that the shard belongs to.
To get the cluster ID use a [ClusterService.List](/docs/managed-spqr/api-ref/grpc/Cluster/list#List) request. ||
|| shard_name | **string**

Required field. Name of the SPQR shard to return.
To get the name of the shard use a [ClusterService.ListShards](/docs/managed-spqr/api-ref/grpc/Cluster/listShards#ListShards) request. ||
|#

## Shard {#yandex.cloud.mdb.spqr.v1.Shard}

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