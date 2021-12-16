---
editable: false
---

# Method listDesktops
Retrieves the list of desktops resources.
 

 
## HTTP request {#https-request}
```
GET https://cloud-desktop.api.cloud.yandex.net/cloud-desktop/v1/desktopGroups/{desktopGroupId}/desktops
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
desktopGroupId | Required. ID of the desktop group.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/cloud-desktop/api-ref/DesktopGroup/listDesktops#query_params), the service returns a [nextPageToken](/docs/cloud-desktop/api-ref/DesktopGroup/listDesktops#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/cloud-desktop/api-ref/DesktopGroup/listDesktops#query_params) to the [nextPageToken](/docs/cloud-desktop/api-ref/DesktopGroup/listDesktops#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on [Desktop.name](/docs/cloud-desktop/api-ref/Desktop#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. Value or a list of values to compare against the values of the field.  The maximum string length in characters is 1000.
orderBy | Sorting the list by [Desktop.name](/docs/cloud-desktop/api-ref/Desktop#representation), [Desktop.createdAt](/docs/cloud-desktop/api-ref/Desktop#representation) and [Desktop.status](/docs/cloud-desktop/api-ref/Desktop#representation) fields. The default sorting order is ascending.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "desktop": [
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
desktop[] | **object**<br><p>A desktop resource.</p> 
desktop[].<br>id | **string**<br><p>Desktop ID.</p> 
desktop[].<br>folderId | **string**<br><p>ID of the folder that the desktop belongs to.</p> 
desktop[].<br>desktopGroupId | **string**<br><p>ID of the desktop group that the desktop belongs to.</p> 
desktop[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
desktop[].<br>status | **string**<br><p>Status of the desktop.</p> <ul> <li>CREATING: Desktop is being created.</li> <li>ACTIVE: Desktop is ready to use.</li> <li>DELETING: Desktop is being deleted.</li> </ul> 
desktop[].<br>name | **string**<br><p>Name of the desktop.</p> 
desktop[].<br>resources | **object**<br><p>Resources of the desktop.</p> 
desktop[].<br>resources.<br>memory | **string** (int64)<br><p>The minimum value is 1.</p> 
desktop[].<br>resources.<br>cores | **string** (int64)<br><p>The minimum value is 1.</p> 
desktop[].<br>resources.<br>coreFraction | **string** (int64)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
desktop[].<br>networkInterfaces[] | **object**<br>
desktop[].<br>networkInterfaces[].<br>networkId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
desktop[].<br>networkInterfaces[].<br>subnetId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
desktop[].<br>users[] | **object**<br>
desktop[].<br>users[].<br>subjectId | **string**<br><p>Required. Identity of the access binding.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/cloud-desktop/api-ref/DesktopGroup/listDesktops#query_params">pageSize</a>, use the <a href="/docs/cloud-desktop/api-ref/DesktopGroup/listDesktops#responses">nextPageToken</a> as the value for the [ListDesktopsDGS Request.page_token] query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/cloud-desktop/api-ref/DesktopGroup/listDesktops#responses">nextPageToken</a> to continue paging through the results.</p> 