---
editable: false
---

# Method listShards
Retrieves a list of shards.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}/shards
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the MongoDB cluster to list databases in. To get the cluster ID, use a [list](/docs/managed-mongodb/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-mongodb/api-ref/Cluster/listShards#query_params), the service returns a [nextPageToken](/docs/managed-mongodb/api-ref/Cluster/listShards#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-mongodb/api-ref/Cluster/listShards#query_params) to the [nextPageToken](/docs/managed-mongodb/api-ref/Cluster/listShards#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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
shards[] | **object**<br><p>List of MongoDB shards.</p> 
shards[].<br>name | **string**<br><p>Name of the shard.</p> 
shards[].<br>clusterId | **string**<br><p>ID of the cluster that the shard belongs to.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-mongodb/api-ref/Cluster/listShards#query_params">pageSize</a>, use the <a href="/docs/managed-mongodb/api-ref/Cluster/listShards#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mongodb/api-ref/Cluster/listShards#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-mongodb/api-ref/Cluster/listShards#responses">nextPageToken</a> to continue paging through the results.</p> 