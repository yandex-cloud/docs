---
editable: false
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Config/list.md
---

# Load Testing API, REST: Config.list
Retrieves the list of configs in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/api/v1/configs
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>ID of the folder to list configs in.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/load-testing/user/api-ref/Config/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/load-testing/user/api-ref/Config/list#responses">nextPageToken</a> returned by a previous list request.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "configs": [
    {
      "id": "string",
      "folderId": "string",
      "yamlString": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
configs[] | **object**<br><p>List of configs in the specified folder.</p> 
configs[].<br>id | **string**<br><p>ID of the test config. Generated at creation time.</p> 
configs[].<br>folderId | **string**<br><p>ID of the folder that the config belongs to.</p> 
configs[].<br>yamlString | **string**<br><p>Config content in YAML format.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/load-testing/user/api-ref/Config/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/load-testing/user/api-ref/Config/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 