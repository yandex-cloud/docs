---
editable: false
sourcePath: en/_api-ref/iam/api-ref/Role/list.md
---


# Method list
Retrieves the list of Role resources.
 

 
## HTTP request {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/roles
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/iam/api-ref/Role/list#query_params), the service returns a [nextPageToken](/docs/iam/api-ref/Role/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/iam/api-ref/Role/list#query_params) to the [nextPageToken](/docs/iam/api-ref/Role/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response.  The maximum string length in characters is 1000.
 
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
roles[] | **object**<br><p>A Role resource. For more information, see <a href="/docs/iam/concepts/access-control/roles">Roles</a>.</p> 
roles[].<br>id | **string**<br><p>ID of the role.</p> 
roles[].<br>description | **string**<br><p>Description of the role. 0-256 characters long.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/iam/api-ref/Role/list#query_params">pageSize</a>, use the <a href="/docs/iam/api-ref/Role/list#responses">nextPageToken</a> as the value for the <a href="/docs/iam/api-ref/Role/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/iam/api-ref/Role/list#responses">nextPageToken</a> to continue paging through the results.</p> 