---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Cluster/listShardGroups.md
---

# Managed Service for ClickHouse API, gRPC: ClusterService.ListShardGroups {#ListShardGroups}

Retrieves a list of shard groups that belong to specified cluster.

## gRPC request

**rpc ListShardGroups ([ListClusterShardGroupsRequest](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsRequest)) returns ([ListClusterShardGroupsResponse](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse))**

## ListClusterShardGroupsRequest {#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsRequest}

```json
{
  "clusterId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster that the shard group belongs to.

To get the cluster ID, make a [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the service returns a [ListClusterShardGroupsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.

To get the next page of results, set `pageToken` to the [ListClusterShardGroupsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse) returned by the previous list request. ||
|#

## ListClusterShardGroupsResponse {#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse}

```json
{
  "shardGroups": [
    {
      "name": "string",
      "clusterId": "string",
      "description": "string",
      "shardNames": [
        "string"
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
|#