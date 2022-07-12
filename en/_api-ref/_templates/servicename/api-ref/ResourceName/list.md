---
editable: false
---

# Method list
Retrieves the list of resource names in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://servicename.{{ api-host }}/servicename/v1/resourceNames
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list resource names in.</p> <p>To get the folder ID make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/service-name/api-ref/ResourceName/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/service-name/api-ref/ResourceName/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resource names listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/service-name/api-ref/ResourceName#representation">ResourceName.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name=my-resourcename``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "resourceNames": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "zoneId": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
resourceNames[] | **object**<br><p>List of resource name in the specified folder.</p> 
resourceNames[].<br>id | **string**<br><p>ID of the resource name. Generated at creation time.</p> 
resourceNames[].<br>folderId | **string**<br><p>ID of the folder that the resource name belongs to.</p> 
resourceNames[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceNames[].<br>name | **string**<br><p>Name of the resource name. The name is unique within the folder.</p> 
resourceNames[].<br>description | **string**<br><p>Description of the resource name.</p> 
resourceNames[].<br>labels | **object**<br><p>Resource name labels as ``key:value`` pairs.</p> 
resourceNames[].<br>zoneId | **string**<br><p>ID of the availability zone where the resource name resides.</p> 
resourceNames[].<br>status | **string**<br><p>Status of the resource name.</p> <ul> <li>CREATING: Resource name is being created.</li> <li>READY: Resource name is ready to use.</li> <li>ERROR: Resource name encountered a problem and cannot operate.</li> <li>DELETING: Resource name is being deleted.</li> </ul> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/service-name/api-ref/ResourceName/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/service-name/api-ref/ResourceName/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 