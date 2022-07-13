---
editable: false
sourcePath: en/_api-ref/billing/api-ref/Service/list.md
---

# Method list
Retrieves the list of services.
 

 
## HTTP request {#https-request}
```
GET https://billing.{{ api-host }}/billing/v1/services
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on the <a href="/docs/billing/api-ref/Service#representation">Service.id</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/billing/api-ref/Service/list#query_params">pageSize</a>, the service returns a <a href="/docs/billing/api-ref/Service/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/billing/api-ref/Service/list#query_params">pageToken</a> to the <a href="/docs/billing/api-ref/Service/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "services": [
    {
      "id": "string",
      "name": "string",
      "description": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
services[] | **object**<br><p>List of services.</p> 
services[].<br>id | **string**<br><p>ID of the service.</p> 
services[].<br>name | **string**<br><p>Name of the service, e.g. ``Compute Cloud``, ``VPC``.</p> 
services[].<br>description | **string**<br><p>Description of the service.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/billing/api-ref/Service/list#query_params">pageSize</a>, use <a href="/docs/billing/api-ref/Service/list#responses">nextPageToken</a> as the value for the <a href="/docs/billing/api-ref/Service/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/billing/api-ref/Service/list#responses">nextPageToken</a> to continue paging through the results.</p> 