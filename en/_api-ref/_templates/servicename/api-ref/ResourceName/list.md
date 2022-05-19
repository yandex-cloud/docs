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
folderId | Required. ID of the folder to list resource names in.  To get the folder ID make a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/service-name/api-ref/ResourceName/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/service-name/api-ref/ResourceName/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resource names listed in the response.  The expression must specify: 1. The field name. Currently you can use filtering only on [ResourceName.name](/docs/service-name/api-ref/ResourceName#representation) field. 2. An `=` operator. 3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. Example of a filter: `name=my-resourcename`.  The maximum string length in characters is 1000.
 
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
resourceNames[] | **object**<br><p>A resource name. For details about the concept, see <a href="/docs/service-name/concepts/resource-name">documentation</a>.</p> 
resourceNames[].<br>id | **string**<br><p>ID of the resource name. Generated at creation time.</p> 
resourceNames[].<br>folderId | **string**<br><p>ID of the folder that the resource name belongs to.</p> 
resourceNames[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resourceNames[].<br>name | **string**<br><p>Name of the resource name. The name is unique within the folder.</p> 
resourceNames[].<br>description | **string**<br><p>Description of the resource name.</p> 
resourceNames[].<br>labels | **object**<br><p>Resource name labels as ``key:value`` pairs.</p> 
resourceNames[].<br>zoneId | **string**<br><p>ID of the availability zone where the resource name resides.</p> 
resourceNames[].<br>status | **string**<br><p>Status of the resource name.</p> <ul> <li>CREATING: Resource name is being created.</li> <li>READY: Resource name is ready to use.</li> <li>ERROR: Resource name encountered a problem and cannot operate.</li> <li>DELETING: Resource name is being deleted.</li> </ul> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/service-name/api-ref/ResourceName/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/service-name/api-ref/ResourceName/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 