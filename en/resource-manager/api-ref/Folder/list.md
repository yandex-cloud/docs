---
editable: false
sourcePath: en/_api-ref/resourcemanager/v1/api-ref/Folder/list.md
---

# Resource Manager API, REST: Folder.list
Retrieves the list of Folder resources in the specified cloud.
 

 
## HTTP request {#https-request}
```
GET https://resource-manager.{{ api-host }}/resource-manager/v1/folders
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
cloudId | <p>Required. ID of the cloud to list folders in. To get the cloud ID, use a <a href="/docs/resource-manager/api-ref/Cloud/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/resource-manager/api-ref/Folder/list#query_params">pageSize</a>, the service returns a <a href="/docs/resource-manager/api-ref/Folder/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. Set <a href="/docs/resource-manager/api-ref/Folder/list#query_params">pageToken</a> to the <a href="/docs/resource-manager/api-ref/Folder/list#responses">nextPageToken</a> returned by a previous list request to get the next page of results.</p> <p>The maximum string length in characters is 2000.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on the <a href="/docs/resource-manager/api-ref/Folder#representation">Folder.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
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
folders[] | **object**<br><p>List of Folder resources.</p> 
folders[].<br>id | **string**<br><p>ID of the folder.</p> 
folders[].<br>cloudId | **string**<br><p>ID of the cloud that the folder belongs to.</p> 
folders[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
folders[].<br>name | **string**<br><p>Name of the folder. The name is unique within the cloud. 3-63 characters long.</p> 
folders[].<br>description | **string**<br><p>Description of the folder. 0-256 characters long.</p> 
folders[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
folders[].<br>status | **string**<br><p>Status of the folder.</p> <ul> <li>ACTIVE: The folder is active.</li> <li>DELETING: The folder is being deleted.</li> <li>PENDING_DELETION: Stopping folder resources and waiting for the deletion start timestamp.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/resource-manager/api-ref/Folder/list#query_params">pageSize</a>, use the <a href="/docs/resource-manager/api-ref/Folder/list#responses">nextPageToken</a> as the value for the <a href="/docs/resource-manager/api-ref/Folder/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/resource-manager/api-ref/Folder/list#responses">nextPageToken</a> to continue paging through the results.</p> 