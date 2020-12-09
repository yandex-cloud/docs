---
editable: false
---

# Method list
Retrieves the list of placement groups in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/diskPlacementGroups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list placement groups in. To get the folder ID, use [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/compute/api-ref/DiskPlacementGroup/list#query_params), the service returns a [nextPageToken](/docs/compute/api-ref/DiskPlacementGroup/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/compute/api-ref/DiskPlacementGroup/list#query_params) to the [nextPageToken](/docs/compute/api-ref/DiskPlacementGroup/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. Currently you can use filtering only on the [DiskPlacementGroup.name](/docs/compute/api-ref/DiskPlacementGroup#representation) field.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "diskPlacementGroups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "zoneId": "string",
      "status": "string",
      "spreadPlacementStrategy": {}
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
diskPlacementGroups[] | **object**<br><p>Lists placement groups for the specified folder.</p> 
diskPlacementGroups[].<br>id | **string**<br><p>ID of the placement group.</p> 
diskPlacementGroups[].<br>folderId | **string**<br><p>ID of the folder that the placement group belongs to.</p> 
diskPlacementGroups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
diskPlacementGroups[].<br>name | **string**<br><p>Name of the placement group. The name is unique within the folder.</p> 
diskPlacementGroups[].<br>description | **string**<br><p>Description of the placement group.</p> 
diskPlacementGroups[].<br>labels | **object**<br><p>Resource labels as `key:value` pairs.</p> 
diskPlacementGroups[].<br>zoneId | **string**<br><p>ID of the availability zone where the placement group resides.</p> 
diskPlacementGroups[].<br>status | **string**<br>Current status of the placement group<br>
diskPlacementGroups[].<br>spreadPlacementStrategy | **object**<br>Distribute instances over distinct failure domains.<br>
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/compute/api-ref/DiskPlacementGroup/list#query_params">pageSize</a>, use <a href="/docs/compute/api-ref/DiskPlacementGroup/list#responses">nextPageToken</a> as the value for the <a href="/docs/compute/api-ref/DiskPlacementGroup/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/compute/api-ref/DiskPlacementGroup/list#responses">nextPageToken</a> to continue paging through the results.</p> 