---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/ApiKey/listScopes.md
---

# Identity and Access Management API, REST: ApiKey.listScopes
Retrieves the list of scopes.
 

 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/v1/apiKeys/scopes
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/iam/api-ref/ApiKey/listScopes#query_params">pageSize</a>, the service returns a <a href="/docs/iam/api-ref/ApiKey/listScopes#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/iam/api-ref/ApiKey/listScopes#query_params">pageToken</a> to the <a href="/docs/iam/api-ref/ApiKey/listScopes#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 2000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "scopes": [
    "string"
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
scopes[] | **string**<br><p>List of scopes</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/iam/api-ref/ApiKey/listScopes#query_params">pageSize</a>, use the <a href="/docs/iam/api-ref/ApiKey/listScopes#responses">nextPageToken</a> as the value for the <a href="/docs/iam/api-ref/ApiKey/listScopes#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/iam/api-ref/ApiKey/listScopes#responses">nextPageToken</a> to continue paging through the results.</p> 