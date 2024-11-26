---
editable: false
sourcePath: en/_api-ref-grpc/mdb/redis/v1/api-ref/grpc/Cluster/listShards.md
---

# Managed Service for Redis API, gRPC: ClusterService.ListShards

Retrieves a list of shards.

## gRPC request

**rpc ListShards ([ListClusterShardsRequest](#yandex.cloud.mdb.redis.v1.ListClusterShardsRequest)) returns ([ListClusterShardsResponse](#yandex.cloud.mdb.redis.v1.ListClusterShardsResponse))**

## ListClusterShardsRequest {#yandex.cloud.mdb.redis.v1.ListClusterShardsRequest}

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

Required field. ID of the Redis cluster to list shards in.
To get the cluster ID use a [ClusterService.List](/docs/managed-redis/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListClusterShardsResponse.next_page_token](#yandex.cloud.mdb.redis.v1.ListClusterShardsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListClusterShardsResponse.next_page_token](#yandex.cloud.mdb.redis.v1.ListClusterShardsResponse) returned by the previous list request. ||
|#

## ListClusterShardsResponse {#yandex.cloud.mdb.redis.v1.ListClusterShardsResponse}

```json
{
  "shards": [
    {
      "name": "string",
      "cluster_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| shards[] | **[Shard](#yandex.cloud.mdb.redis.v1.Shard)**

List of Redis shards. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClusterShardsRequest.page_size](#yandex.cloud.mdb.redis.v1.ListClusterShardsRequest), use
the `next_page_token` as the value
for the [ListClusterShardsRequest.page_token](#yandex.cloud.mdb.redis.v1.ListClusterShardsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Shard {#yandex.cloud.mdb.redis.v1.Shard}

#|
||Field | Description ||
|| name | **string**

Name of the Redis shard. The shard name is assigned by user at creation time, and cannot be changed.
1-63 characters long. ||
|| cluster_id | **string**

ID of the Redis cluster the shard belongs to. The ID is assigned by MDB at creation time. ||
|#