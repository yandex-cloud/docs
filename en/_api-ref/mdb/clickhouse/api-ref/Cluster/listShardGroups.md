---
editable: false
---

# Method listShardGroups
Retrieves a list of shard groups that belong to specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/shardGroups
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the cluster that the shard group belongs to.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#query_params), the service returns a [nextPageToken](/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#responses) that can be used to get the next page of results in subsequent list requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#query_params) to the [nextPageToken](/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
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
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
shardGroups[] | **object**<br><p>List of ClickHouse Cluster shard groups.</p> 
shardGroups[].<br>name | **string**<br><p>Name of the shard group</p> 
shardGroups[].<br>clusterId | **string**<br><p>ID of the cluster that the shard belongs to.</p> 
shardGroups[].<br>description | **string**<br><p>Description of the ClickHouse cluster shard group. 0-256 characters long.</p> 
shardGroups[].<br>shardNames[] | **string**<br><p>List of shard names contained in shard group</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#query_params">pageSize</a>, use the <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#responses">nextPageToken</a> as the value for the <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#responses">nextPageToken</a> to continue paging through the results.</p> 