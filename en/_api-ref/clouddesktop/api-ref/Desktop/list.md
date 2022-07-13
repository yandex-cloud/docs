---
editable: false
---

# Method list
Retrieves the list of desktop resources.
 

 
## HTTP request {#https-request}
```
GET https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktops
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to create a DesktopGroup in.</p> <p>To get a folder ID make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/cloud-desktop/api-ref/Desktop/list#query_params">pageSize</a>, the service returns a <a href="/docs/cloud-desktop/api-ref/Desktop/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/cloud-desktop/api-ref/Desktop/list#query_params">pageToken</a> to the <a href="/docs/cloud-desktop/api-ref/Desktop/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/cloud-desktop/api-ref/Desktop#representation">Desktop.name</a> field.</li> <li>An operator. Can be either ``=`` or ``!=`` for single values, ``IN`` or ``NOT IN`` for lists of values.</li> <li>Value or a list of values to compare against the values of the field.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
orderBy | <p>Sorting the list by <a href="/docs/cloud-desktop/api-ref/Desktop#representation">Desktop.name</a>, <a href="/docs/cloud-desktop/api-ref/Desktop#representation">Desktop.createdAt</a> and <a href="/docs/cloud-desktop/api-ref/Desktop#representation">Desktop.status</a> fields. The default sorting order is ascending.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "desktops": [
    {
      "id": "string",
      "folderId": "string",
      "desktopGroupId": "string",
      "createdAt": "string",
      "status": "string",
      "name": "string",
      "resources": {
        "memory": "string",
        "cores": "string",
        "coreFraction": "string"
      },
      "networkInterfaces": [
        {
          "networkId": "string",
          "subnetId": "string"
        }
      ],
      "users": [
        {
          "subjectId": "string"
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
desktops[] | **object**<br><p>List of desktops.</p> 
desktops[].<br>id | **string**<br><p>Desktop ID.</p> 
desktops[].<br>folderId | **string**<br><p>ID of the folder that the desktop belongs to.</p> 
desktops[].<br>desktopGroupId | **string**<br><p>ID of the desktop group that the desktop belongs to.</p> 
desktops[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
desktops[].<br>status | **string**<br><p>Status of the desktop.</p> <ul> <li>CREATING: Desktop is being created.</li> <li>ACTIVE: Desktop is ready to use.</li> <li>DELETING: Desktop is being deleted.</li> </ul> 
desktops[].<br>name | **string**<br><p>Name of the desktop.</p> 
desktops[].<br>resources | **object**<br><p>Resources of the desktop.</p> 
desktops[].<br>resources.<br>memory | **string** (int64)<br><p>The minimum value is 1.</p> 
desktops[].<br>resources.<br>cores | **string** (int64)<br><p>The minimum value is 1.</p> 
desktops[].<br>resources.<br>coreFraction | **string** (int64)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
desktops[].<br>networkInterfaces[] | **object**
desktops[].<br>networkInterfaces[].<br>networkId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
desktops[].<br>networkInterfaces[].<br>subnetId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
desktops[].<br>users[] | **object**
desktops[].<br>users[].<br>subjectId | **string**<br><p>Required. Identity of the access binding.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/cloud-desktop/api-ref/Desktop/list#query_params">pageSize</a>, use the <a href="/docs/cloud-desktop/api-ref/Desktop/list#responses">nextPageToken</a> as the value for the <a href="/docs/cloud-desktop/api-ref/Desktop/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/cloud-desktop/api-ref/Desktop/list#responses">nextPageToken</a> to continue paging through the results.</p> 