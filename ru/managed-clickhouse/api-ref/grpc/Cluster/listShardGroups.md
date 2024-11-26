---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Cluster/listShardGroups.md
---

# Managed Service for ClickHouse API, gRPC: ClusterService.ListShardGroups

Retrieves a list of shard groups that belong to specified cluster.

## gRPC request

**rpc ListShardGroups ([ListClusterShardGroupsRequest](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsRequest)) returns ([ListClusterShardGroupsResponse](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse))**

## ListClusterShardGroupsRequest {#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsRequest}

```json
{
  "cluster_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster that the shard group belongs to.

To get the cluster ID, make a [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the service returns a [ListClusterShardGroupsResponse.next_page_token](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token.

To get the next page of results, set `page_token` to the [ListClusterShardGroupsResponse.next_page_token](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse) returned by the previous list request. ||
|#

## ListClusterShardGroupsResponse {#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse}

```json
{
  "shard_groups": [
    {
      "name": "string",
      "cluster_id": "string",
      "description": "string",
      "shard_names": [
        "string"
      ]
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| shard_groups[] | **[ShardGroup](#yandex.cloud.mdb.clickhouse.v1.ShardGroup)**

List of ClickHouse cluster's shard groups. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListClusterShardGroupsRequest.page_size](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsRequest), use the `next_page_token` as the value for the [ListClusterShardGroupsRequest.page_token](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsRequest) parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#

## ShardGroup {#yandex.cloud.mdb.clickhouse.v1.ShardGroup}

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
|#