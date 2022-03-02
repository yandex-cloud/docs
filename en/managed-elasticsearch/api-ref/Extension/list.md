---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/api-ref/Extension/list.md
---


# Method list
Returns the list of available extensions for the specified Elasticsearch cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-elasticsearch/v1/clusters/{clusterId}/extensions
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. Required. ID of the cluster to list extensions in.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListBackups requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. Set `page_token` to the `next_page_token` returned by a previous ListBackups request to get the next page of results.  The maximum string length in characters is 100.
 
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
extensions[].<br>id | **string**<br><p>Extension unique ID</p> 
extensions[].<br>clusterId | **string**<br><p>ID of the Elasticsearch cluster the extension belongs to.</p> 
extensions[].<br>version | **string** (int64)<br><p>Extension version</p> 
extensions[].<br>active | **boolean** (boolean)<br><p>Flag is extension active now</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for ListBackups requests, if the number of results is larger than ``page_size`` specified in the request. To get the next page, specify the value of ``next_page_token`` as a value for the ``page_token`` parameter in the next ListBackups request. Subsequent ListBackups requests will have their own ``next_page_token`` to continue paging through the results.</p> 