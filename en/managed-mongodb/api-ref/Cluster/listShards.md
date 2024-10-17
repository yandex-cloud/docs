---
editable: false
sourcePath: en/_api-ref/mdb/mongodb/v1/api-ref/Cluster/listShards.md
---

# Managed Service for MongoDB API, REST: Cluster.ListShards {#ListShards}

Retrieves a list of shards.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}/shards
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the MongoDB cluster to list databases in.
To get the cluster ID, use a [ClusterService.List](/docs/managed-mongodb/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.mongodb.v1.ListClusterShardsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClusterShardsResponse.nextPageToken](#yandex.cloud.mdb.mongodb.v1.ListClusterShardsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListClusterShardsResponse.nextPageToken](#yandex.cloud.mdb.mongodb.v1.ListClusterShardsResponse) returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.mongodb.v1.ListClusterShardsResponse}

**HTTP Code: 200 - OK**

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