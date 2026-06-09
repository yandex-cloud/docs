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
|#