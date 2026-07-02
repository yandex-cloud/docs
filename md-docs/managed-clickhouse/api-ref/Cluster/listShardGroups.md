[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for ClickHouse®](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Cluster](index.md) > ListShardGroups

# Managed Service for ClickHouse API, REST: Cluster.ListShardGroups

Retrieves a list of shard groups that belong to specified cluster.

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/shardGroups
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster that the shard group belongs to.
To get the cluster ID, make a [ClusterService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.
If the number of available results is larger than `pageSize`, the service returns a [ListClusterShardGroupsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse) that can be used to get the next page of results in subsequent list requests.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token.
To get the next page of results, set `pageToken` to the [ListClusterShardGroupsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse) returned by the previous list request.

The maximum string length in characters is 100. ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse}

**HTTP Code: 200 - OK**

```json
{
  "shardGroups": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| shardGroups[] | **[ShardGroup](#yandex.cloud.mdb.clickhouse.v1.ShardGroup)**

List of ClickHouse cluster's shard groups. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.
If the number of results is larger than [ListClusterShardGroupsRequest.pageSize](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsRequest), use the `nextPageToken` as the value for the [ListClusterShardGroupsRequest.pageToken](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsRequest) parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## ShardGroup {#yandex.cloud.mdb.clickhouse.v1.ShardGroup}

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