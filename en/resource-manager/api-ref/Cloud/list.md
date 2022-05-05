---
editable: false
sourcePath: en/_api-ref/resourcemanager/api-ref/Cloud/list.md
---

# Method list
Retrieves the list of Cloud resources.
 

 
## HTTP request {#https-request}
```
GET https://resource-manager.{{ api-host }}/resource-manager/v1/clouds
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/resource-manager/api-ref/Cloud/list#query_params), the service returns a [nextPageToken](/docs/resource-manager/api-ref/Cloud/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. Set [pageToken](/docs/resource-manager/api-ref/Cloud/list#query_params) to the [nextPageToken](/docs/resource-manager/api-ref/Cloud/list#responses) returned by a previous list request to get the next page of results.  The maximum string length in characters is 1000.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on the [Cloud.name](/docs/resource-manager/api-ref/Cloud#representation) field. 2. An `=` operator. 3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.  The maximum string length in characters is 1000.
organizationId | ID of the organization to list clouds in. To get the organization ID, use a [list](/docs/organization-manager/api-ref/Organization/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "clouds": [
    {
      "id": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "organizationId": "string",
      "labels": "object"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
clouds[] | **object**<br><p>A Cloud resource. For more information, see <a href="/docs/resource-manager/concepts/resources-hierarchy#cloud">Cloud</a>.</p> 
clouds[].<br>id | **string**<br><p>ID of the cloud.</p> 
clouds[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clouds[].<br>name | **string**<br><p>Name of the cloud. 3-63 characters long.</p> 
clouds[].<br>description | **string**<br><p>Description of the cloud. 0-256 characters long.</p> 
clouds[].<br>organizationId | **string**<br><p>ID of the organization that the cloud belongs to.</p> 
clouds[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/resource-manager/api-ref/Cloud/list#query_params">pageSize</a>, use the <a href="/docs/resource-manager/api-ref/Cloud/list#responses">nextPageToken</a> as the value for the <a href="/docs/resource-manager/api-ref/Cloud/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/resource-manager/api-ref/Cloud/list#responses">nextPageToken</a> to continue paging through the results.</p> 