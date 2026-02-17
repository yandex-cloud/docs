---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-redis/v1/clusters/{clusterId}/shards
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the Redis cluster to list shards in.
            To get the cluster ID use a [ClusterService.List](/docs/managed-redis/api-ref/Cluster/list#List) request.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListClusterShardsResponse.nextPageToken](#yandex.cloud.mdb.redis.v1.ListClusterShardsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
            The maximum value is 1000.
          default: '100'
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListClusterShardsResponse.nextPageToken](#yandex.cloud.mdb.redis.v1.ListClusterShardsResponse) returned by the previous list request.
            The maximum string length in characters is 100.
          type: string
      additionalProperties: false
    body: null
    definitions: null
---

# Managed Service for Redis API, REST: Cluster.ListShards

Retrieves a list of shards.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-redis/v1/clusters/{clusterId}/shards
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Redis cluster to list shards in.
To get the cluster ID use a [ClusterService.List](/docs/managed-redis/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.mdb.redis.v1.ListClusterShardsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListClusterShardsResponse.nextPageToken](#yandex.cloud.mdb.redis.v1.ListClusterShardsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListClusterShardsResponse.nextPageToken](#yandex.cloud.mdb.redis.v1.ListClusterShardsResponse) returned by the previous list request.

The maximum string length in characters is 100. ||
|#

## Response {#yandex.cloud.mdb.redis.v1.ListClusterShardsResponse}

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
|| shards[] | **[Shard](#yandex.cloud.mdb.redis.v1.Shard)**

List of Redis shards. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClusterShardsRequest.pageSize](#yandex.cloud.mdb.redis.v1.ListClusterShardsRequest), use
the `nextPageToken` as the value
for the [ListClusterShardsRequest.pageToken](#yandex.cloud.mdb.redis.v1.ListClusterShardsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Shard {#yandex.cloud.mdb.redis.v1.Shard}

#|
||Field | Description ||
|| name | **string**

Name of the Redis shard. The shard name is assigned by user at creation time, and cannot be changed.
1-63 characters long. ||
|| clusterId | **string**

ID of the Redis cluster the shard belongs to. The ID is assigned by MDB at creation time. ||
|#