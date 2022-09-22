---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/api-ref/User/list.md
---

# Method list
Retrieves the list of Elasticsearch users in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/users
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Elasticsearch cluster to list Elasticsearch users in.</p> <p>To get the cluster ID, use a <a href="/docs/managed-elasticsearch/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/managed-elasticsearch/api-ref/User/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token.</p> <p>To get the next page of results, set ``page_token`` to the <a href="/docs/managed-elasticsearch/api-ref/User/list#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "users": [
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
users[] | **object**<br><p>List of Elasticsearch users.</p> 
users[].<br>name | **string**<br><p>Name of the Elasticsearch user.</p> 
users[].<br>clusterId | **string**<br><p>ID of the Elasticsearch cluster the user belongs to.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-elasticsearch/api-ref/User/list#query_params">pageSize</a>, use the ``next_page_token`` as the value for the <a href="/docs/managed-elasticsearch/api-ref/User/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own ``next_page_token`` to continue paging through the results.</p> 