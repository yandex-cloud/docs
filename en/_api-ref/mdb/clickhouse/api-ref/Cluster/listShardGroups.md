---
editable: false
---

# Method listShardGroups
Retrieves a list of shard groups that belong to specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-clickhouse/v1/clusters/{clusterId}/shardGroups
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster that the shard group belongs to.</p> <p>To get the cluster ID, make a <a href="/docs/managed-clickhouse/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#query_params">pageSize</a>, the service returns a <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token.</p> <p>To get the next page of results, set <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#query_params">pageToken</a> to the <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
shardGroups[] | **object**<br><p>List of ClickHouse cluster's shard groups.</p> 
shardGroups[].<br>name | **string**<br><p>Name of the shard group.</p> 
shardGroups[].<br>clusterId | **string**<br><p>ID of the ClickHouse cluster that the shard group belongs to.</p> 
shardGroups[].<br>description | **string**<br><p>Description of the shard group. 0-256 characters long.</p> 
shardGroups[].<br>shardNames[] | **string**<br><p>List of shard names contained in the shard group.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#query_params">pageSize</a>, use the <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#responses">nextPageToken</a> as the value for the <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#responses">nextPageToken</a> to continue paging through the results.</p> 