---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/v1/api-ref/Extension/list.md
---

# Managed Service for Elasticsearch API, REST: Extension.list
Returns the list of available extensions for the specified Elasticsearch cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/extensions
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster to list extensions in.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-elasticsearch/api-ref/Extension/list#query_params">pageSize</a>, the API returns a <a href="/docs/managed-elasticsearch/api-ref/Extension/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent <a href="/docs/managed-elasticsearch/api-ref/Extension/list">list</a> requests.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token that can be used to iterate through multiple pages of results.</p> <p>To get the next page of results, set <a href="/docs/managed-elasticsearch/api-ref/Extension/list#query_params">pageToken</a> to the <a href="/docs/managed-elasticsearch/api-ref/Extension/list#responses">nextPageToken</a> returned by the previous <a href="/docs/managed-elasticsearch/api-ref/Extension/list">list</a> request.</p> <p>The maximum string length in characters is 100.</p> 
 
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