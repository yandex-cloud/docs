[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for ClickHouse®](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Cluster](index.md) > GetShardGroup

# Managed Service for ClickHouse API, REST: Cluster.GetShardGroup

Returns the specified shard group.

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/shardGroups/{shardGroupName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster that the shard group belongs to.
To get the cluster ID, make a [ClusterService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|| shardGroupName | **string**

Required field. Name of the shard group to request information about.
To get the name of a shard group, make a [ClusterService.ListShardGroups](listShardGroups.md#ListShardGroups) request.

The maximum string length in characters is 63. ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.ShardGroup}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string",
  "description": "string",
  "shardNames": [
    "string"
  ],
  "externalShards": [
    {
      "name": "string",
      "weight": "string",
      "replicas": [
        {
          "host": "string",
          "port": "string",
          "secure": "boolean",
          "user": "string",
          "password": "string",
          "priority": "string"
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
|| clusterId | **string**

ID of the ClickHouse cluster that the shard group belongs to. ||
|| description | **string**

Description of the shard group. 0-256 characters long. ||
|| shardNames[] | **string**

List of shard names contained in the shard group. ||
|| externalShards[] | **[ExternalShard](#yandex.cloud.mdb.clickhouse.v1.ExternalShard)**

List of external shards contained in the shard group. ||
|#

## ExternalShard {#yandex.cloud.mdb.clickhouse.v1.ExternalShard}

#|
||Field | Description ||
|| name | **string**

Name of the external shard. ||
|| weight | **string** (int64)

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
|| port | **string** (int64)

Port to connect to the external replica. If not specified, the default ClickHouse port is used. ||
|| secure | **boolean**

Whether to use a secure (SSL/TLS) connection when connecting to the external replica. ||
|| user | **string**

Name of the user to authenticate with on the external replica. ||
|| password | **string**

Password of the user to authenticate with on the external replica. ||
|| priority | **string** (int64)

Priority of the external replica for load balancing.
The replica with the lowest priority value is preferred when establishing a connection. ||
|#