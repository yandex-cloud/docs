---
editable: false
---

# Method list
Retrieves the list of desktop group resources.
 

 
## HTTP request {#https-request}
```
GET https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktopGroups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list desktop groups in.  To get the folder ID use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/cloud-desktop/api-ref/DesktopGroup/list#query_params), the service returns a [nextPageToken](/docs/cloud-desktop/api-ref/DesktopGroup/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/cloud-desktop/api-ref/DesktopGroup/list#query_params) to the [nextPageToken](/docs/cloud-desktop/api-ref/DesktopGroup/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on [DesktopGroup.name](/docs/cloud-desktop/api-ref/DesktopGroup#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. Value or a list of values to compare against the values of the field.  The maximum string length in characters is 1000.
orderBy | Sorting the list by [DesktopGroup.name](/docs/cloud-desktop/api-ref/DesktopGroup#representation), [DesktopGroup.createdAt](/docs/cloud-desktop/api-ref/DesktopGroup#representation) and [DesktopGroup.status](/docs/cloud-desktop/api-ref/DesktopGroup#representation) fields. The default sorting order is ascending.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "desktopGroups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "status": "string",
      "name": "string",
      "description": "string",
      "resourcesSpec": {
        "memory": "string",
        "cores": "string",
        "coreFraction": "string"
      },
      "networkInterfaceSpec": {
        "networkId": "string",
        "subnetIds": [
          "string"
        ]
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
desktopGroups[] | **object**<br><p>A desktop group resource.</p> 
desktopGroups[].<br>id | **string**<br><p>Desktop group ID.</p> 
desktopGroups[].<br>folderId | **string**<br><p>ID of the folder that the desktop group belongs to.</p> 
desktopGroups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
desktopGroups[].<br>status | **string**<br><p>Status of the desktop group.</p> <ul> <li>CREATING: Desktop group is being created.</li> <li>ACTIVE: Desktop group is ready to use.</li> <li>DELETING: Desktop group is being deleted.</li> </ul> 
desktopGroups[].<br>name | **string**<br><p>Name of the desktop group.</p> 
desktopGroups[].<br>description | **string**<br><p>Description of the desktop group.</p> 
desktopGroups[].<br>resourcesSpec | **object**<br><p>Resource specification of the desktop group.</p> 
desktopGroups[].<br>resourcesSpec.<br>memory | **string** (int64)<br><p>RAM volume, in bytes.</p> <p>The minimum value is 1.</p> 
desktopGroups[].<br>resourcesSpec.<br>cores | **string** (int64)<br><p>Number of CPU cores.</p> <p>The minimum value is 1.</p> 
desktopGroups[].<br>resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
desktopGroups[].<br>networkInterfaceSpec | **object**<br><p>Network interface specification of the desktop group.</p> 
desktopGroups[].<br>networkInterfaceSpec.<br>networkId | **string**<br><p>Required. ID of the network interface specification.</p> <p>The maximum string length in characters is 50.</p> 
desktopGroups[].<br>networkInterfaceSpec.<br>subnetIds[] | **string**<br><p>Required. List of subnet IDs.</p> <p>Must contain at least one element. The maximum string length in characters for each value is 50.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/cloud-desktop/api-ref/DesktopGroup/list#query_params">pageSize</a>, use the <a href="/docs/cloud-desktop/api-ref/DesktopGroup/list#responses">nextPageToken</a> as the value for the <a href="/docs/cloud-desktop/api-ref/DesktopGroup/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/cloud-desktop/api-ref/DesktopGroup/list#responses">nextPageToken</a> to continue paging through the results.</p> 