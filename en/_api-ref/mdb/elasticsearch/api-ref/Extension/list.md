---
editable: false
---

# Method list
Returns the list of available extensions for the specified Elasticsearch cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-elasticsearch/v1/clusters/{clusterId}/extensions
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the cluster to list extensions in.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return.  If the number of available results is larger than [pageSize](/docs/managed-elasticsearch/api-ref/Extension/list#query_params), the API returns a [nextPageToken](/docs/managed-elasticsearch/api-ref/Extension/list#responses) that can be used to get the next page of results in subsequent [list](/docs/managed-elasticsearch/api-ref/Extension/list) requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token that can be used to iterate through multiple pages of results.  To get the next page of results, set [pageToken](/docs/managed-elasticsearch/api-ref/Extension/list#query_params) to the [nextPageToken](/docs/managed-elasticsearch/api-ref/Extension/list#responses) returned by the previous [list](/docs/managed-elasticsearch/api-ref/Extension/list) request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "extensions": [
    {
      "name": "string",
      "id": "string",
      "clusterId": "string",
      "version": "string",
      "active": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
extensions[] | **object**<br><p>Requested list of extensions.</p> 
extensions[].<br>name | **string**<br><p>Name of the extension.</p> 
extensions[].<br>id | **string**<br><p>Unique ID of the extension.</p> 
extensions[].<br>clusterId | **string**<br><p>ID of the Elasticsearch cluster the extension belongs to.</p> 
extensions[].<br>version | **string** (int64)<br><p>Version of the extension.</p> 
extensions[].<br>active | **boolean** (boolean)<br><p>The flag shows whether the extension is active.</p> 
nextPageToken | **string**<br><p>The token that can be used to get the next page of results.</p> <p>If the number of results is larger than <a href="/docs/managed-elasticsearch/api-ref/Extension/list#query_params">pageSize</a>, use the <a href="/docs/managed-elasticsearch/api-ref/Extension/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-elasticsearch/api-ref/Extension/list#query_params">pageToken</a> in the subsequent <a href="/docs/managed-elasticsearch/api-ref/Extension/list">list</a> request to iterate through multiple pages of results.</p> <p>Each of the subsequent <a href="/docs/managed-elasticsearch/api-ref/Extension/list">list</a> requests should use the <a href="/docs/managed-elasticsearch/api-ref/Extension/list#responses">nextPageToken</a> value returned in the previous request to continue paging through the results.</p> 