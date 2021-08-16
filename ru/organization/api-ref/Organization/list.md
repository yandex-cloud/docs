---
editable: false
---

# Method list
Retrieves the list of Organization resources.
 

 
## HTTP request {#https-request}
```
GET https://organization-manager.api.cloud.yandex.net/organization-manager/v1/organizations
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/organization-manager/api-ref/Organization/list#query_params), the service returns a [nextPageToken](/docs/organization-manager/api-ref/Organization/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. Set [pageToken](/docs/organization-manager/api-ref/Organization/list#query_params) to the [nextPageToken](/docs/organization-manager/api-ref/Organization/list#responses) returned by a previous list request to get the next page of results.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on the [Organization.name](/docs/organization-manager/api-ref/Organization#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "organizations": [
    {
      "id": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "title": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
organizations[] | **object**<br><p>An Organization resource. For more information, see <a href="/docs/organization/enable-org">Organization</a>.</p> 
organizations[].<br>id | **string**<br><p>ID of the organization.</p> 
organizations[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
organizations[].<br>name | **string**<br><p>Name of the organization. 3-63 characters long.</p> 
organizations[].<br>description | **string**<br><p>Description of the organization. 0-256 characters long.</p> 
organizations[].<br>title | **string**<br><p>Display name of the organization. 0-256 characters long.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/organization-manager/api-ref/Organization/list#query_params">pageSize</a>, use the <a href="/docs/organization-manager/api-ref/Organization/list#responses">nextPageToken</a> as the value for the <a href="/docs/organization-manager/api-ref/Organization/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/organization-manager/api-ref/Organization/list#responses">nextPageToken</a> to continue paging through the results.</p> 