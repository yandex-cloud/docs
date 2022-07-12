---
editable: false
---

# Method listShards
Retrieves a list of shards.
 

 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-redis/v1/clusters/{clusterId}/shards
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Redis cluster to list shards in. To get the cluster ID use a <a href="/docs/managed-redis/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-redis/api-ref/Cluster/listShards#query_params">pageSize</a>, the service returns a <a href="/docs/managed-redis/api-ref/Cluster/listShards#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-redis/api-ref/Cluster/listShards#query_params">pageToken</a> to the <a href="/docs/managed-redis/api-ref/Cluster/listShards#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
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

 
Field | Description
--- | ---
shards[] | **object**<br><p>List of Redis shards.</p> 
shards[].<br>name | **string**<br><p>Name of the Redis shard. The shard name is assigned by user at creation time, and cannot be changed. 1-63 characters long.</p> 
shards[].<br>clusterId | **string**<br><p>ID of the Redis cluster the shard belongs to. The ID is assigned by MDB at creation time.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-redis/api-ref/Cluster/listShards#query_params">pageSize</a>, use the <a href="/docs/managed-redis/api-ref/Cluster/listShards#responses">nextPageToken</a> as the value for the <a href="/docs/managed-redis/api-ref/Cluster/listShards#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-redis/api-ref/Cluster/listShards#responses">nextPageToken</a> to continue paging through the results.</p> 