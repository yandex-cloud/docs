---
editable: false
---

# Method list
Retrieves the list of Folder resources in the specified cloud.
 

 
## HTTP request {#https-request}
```
GET https://resource-manager.{{ api-host }}/resource-manager/v1/folders
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
cloudId | Required. ID of the cloud to list folders in. To get the cloud ID, use a [list](/docs/resource-manager/api-ref/Cloud/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/resource-manager/api-ref/Folder/list#query_params), the service returns a [nextPageToken](/docs/resource-manager/api-ref/Folder/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. Set [pageToken](/docs/resource-manager/api-ref/Folder/list#query_params) to the [nextPageToken](/docs/resource-manager/api-ref/Folder/list#responses) returned by a previous list request to get the next page of results.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on the [Folder.name](/docs/resource-manager/api-ref/Folder#representation) field. 2. An `=` operator. 3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "folders": [
    {
      "id": "string",
      "cloudId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
folders[] | **object**<br><p>A Folder resource. For more information, see <a href="/docs/resource-manager/concepts/resources-hierarchy#folder">Folder</a>.</p> 
folders[].<br>id | **string**<br><p>ID of the folder.</p> 
folders[].<br>cloudId | **string**<br><p>ID of the cloud that the folder belongs to.</p> 
folders[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
folders[].<br>name | **string**<br><p>Name of the folder. The name is unique within the cloud. 3-63 characters long.</p> 
folders[].<br>description | **string**<br><p>Description of the folder. 0-256 characters long.</p> 
folders[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
folders[].<br>status | **string**<br><p>Status of the folder.</p> <ul> <li>ACTIVE: The folder is active.</li> <li>DELETING: The folder is being deleted.</li> <li>PENDING_DELETION: Stopping folder resources and waiting for the deletion start timestamp.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/resource-manager/api-ref/Folder/list#query_params">pageSize</a>, use the <a href="/docs/resource-manager/api-ref/Folder/list#responses">nextPageToken</a> as the value for the <a href="/docs/resource-manager/api-ref/Folder/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/resource-manager/api-ref/Folder/list#responses">nextPageToken</a> to continue paging through the results.</p> 