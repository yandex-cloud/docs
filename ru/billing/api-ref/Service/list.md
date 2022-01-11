---
editable: false
sourcePath: en/_api-ref/billing/api-ref/Service/list.md
---


# Method list
Retrieves the list of services.
 

 
## HTTP request {#https-request}
```
GET https://billing.api.cloud.yandex.net/billing/v1/services
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on the [Service.id](/docs/billing/api-ref/Service#representation) field. 2. An `=` operator. 3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.  The maximum string length in characters is 1000.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/billing/api-ref/Service/list#query_params), the service returns a [nextPageToken](/docs/billing/api-ref/Service/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/billing/api-ref/Service/list#query_params) to the [nextPageToken](/docs/billing/api-ref/Service/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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
services[] | **object**<br><p>A Service resource.</p> 
services[].<br>id | **string**<br><p>ID of the service.</p> 
services[].<br>name | **string**<br><p>Name of the service, e.g. ``Compute Cloud``, ``VPC``.</p> 
services[].<br>description | **string**<br><p>Description of the service.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/billing/api-ref/Service/list#query_params">pageSize</a>, use <a href="/docs/billing/api-ref/Service/list#responses">nextPageToken</a> as the value for the <a href="/docs/billing/api-ref/Service/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/billing/api-ref/Service/list#responses">nextPageToken</a> to continue paging through the results.</p> 