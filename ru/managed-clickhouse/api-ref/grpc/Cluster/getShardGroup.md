---
editable: false
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
To get the cluster ID, make a [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|| shard_group_name | **string**

Required field. Name of the shard group to request information about.
To get the name of a shard group, make a [ClusterService.ListShardGroups](/docs/managed-clickhouse/api-ref/grpc/Cluster/listShardGroups#ListShardGroups) request.

The maximum string length in characters is 63. ||
|#

## ShardGroup {#yandex.cloud.mdb.clickhouse.v1.ShardGroup}

```json
{
  "name": "string",
  "cluster_id": "string",
  "description": "string",
  "shard_names": [
    "string"
  ],
  "external_shards": [
    {
      "name": "string",
      "weight": "google.protobuf.Int64Value",
      "replicas": [
        {
          "host": "string",
          "port": "google.protobuf.Int64Value",
          "secure": "google.protobuf.BoolValue",
          "user": "string",
          "password": "string",
          "priority": "google.protobuf.Int64Value"
        }
      ]
    }
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
|| external_shards[] | **[ExternalShard](#yandex.cloud.mdb.clickhouse.v1.ExternalShard)**

List of external shards contained in the shard group. ||
|#

## ExternalShard {#yandex.cloud.mdb.clickhouse.v1.ExternalShard}

#|
||Field | Description ||
|| name | **string**

Name of the external shard. ||
|| weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Relative weight of the external shard considered when writing data to the cluster.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/operations/table_engines/distributed/). ||
|| replicas[] | **[Replica](#yandex.cloud.mdb.clickhouse.v1.ExternalShard.Replica)**

List of replicas contained in the external shard. ||
|#

## Replica {#yandex.cloud.mdb.clickhouse.v1.ExternalShard.Replica}

#|
||Field | Description ||
|| host | **string**

Name (FQDN) or IP address of the external replica host. ||
|| port | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Port to connect to the external replica. If not specified, the default ClickHouse port is used. ||
|| secure | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether to use a secure (SSL/TLS) connection when connecting to the external replica. ||
|| user | **string**

Name of the user to authenticate with on the external replica. ||
|| password | **string**

Password of the user to authenticate with on the external replica. ||
|| priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Priority of the external replica for load balancing.
The replica with the lowest priority value is preferred when establishing a connection. ||
|#