---
editable: false
---

# Identity and Access Management API, REST: Role.list
Retrieves the list of Role resources.
 

 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/v1/roles
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/iam/api-ref/Role/list#query_params">pageSize</a>, the service returns a <a href="/docs/iam/api-ref/Role/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/iam/api-ref/Role/list#query_params">pageToken</a> to the <a href="/docs/iam/api-ref/Role/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 2000.</p> 
filter | <p>A filter expression that filters resources listed in the response.</p> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "roles": [
    {
      "id": "string",
      "description": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
roles[] | **object**<br><p>List of Role resources.</p> 
roles[].<br>id | **string**<br><p>ID of the role.</p> 
roles[].<br>description | **string**<br><p>Description of the role. 0-256 characters long.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/iam/api-ref/Role/list#query_params">pageSize</a>, use the <a href="/docs/iam/api-ref/Role/list#responses">nextPageToken</a> as the value for the <a href="/docs/iam/api-ref/Role/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/iam/api-ref/Role/list#responses">nextPageToken</a> to continue paging through the results.</p> 