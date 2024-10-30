---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mongodb/v1/api-ref/grpc/Cluster/listShards.md
---

# Managed Service for MongoDB API, gRPC: ClusterService.ListShards {#ListShards}

Retrieves a list of shards.

## gRPC request

**rpc ListShards ([ListClusterShardsRequest](#yandex.cloud.mdb.mongodb.v1.ListClusterShardsRequest)) returns ([ListClusterShardsResponse](#yandex.cloud.mdb.mongodb.v1.ListClusterShardsResponse))**

## ListClusterShardsRequest {#yandex.cloud.mdb.mongodb.v1.ListClusterShardsRequest}

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

Required field. ID of the MongoDB cluster to list databases in.
To get the cluster ID, use a [ClusterService.List](/docs/managed-mongodb/api-ref/grpc/Cluster/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClusterShardsResponse.nextPageToken](#yandex.cloud.mdb.mongodb.v1.ListClusterShardsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListClusterShardsResponse.nextPageToken](#yandex.cloud.mdb.mongodb.v1.ListClusterShardsResponse) returned by the previous list request. ||
|#

## ListClusterShardsResponse {#yandex.cloud.mdb.mongodb.v1.ListClusterShardsResponse}

```json
{
  "shards": [
    {
      "name": "string",
      "clusterId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| shards[] | **[Shard](#yandex.cloud.mdb.mongodb.v1.Shard)**

List of MongoDB shards. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClusterShardsRequest.pageSize](#yandex.cloud.mdb.mongodb.v1.ListClusterShardsRequest), use the `nextPageToken` as the value
for the [ListClusterShardsRequest.pageToken](#yandex.cloud.mdb.mongodb.v1.ListClusterShardsRequest) parameter in the next list request. Each subsequent
list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Shard {#yandex.cloud.mdb.mongodb.v1.Shard}

#|
||Field | Description ||
|| name | **string**

Name of the shard. ||
|| clusterId | **string**

ID of the cluster that the shard belongs to. ||
|#