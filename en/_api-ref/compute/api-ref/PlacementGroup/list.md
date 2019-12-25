---
editable: false
---

# Method list
Retrieves the list of placement groups in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/placementGroups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | ID of the folder to list placement groups in. To get the folder ID, use [list](/docs/resource-manager/api-ref/Folder/list) request.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/compute/api-ref/PlacementGroup/list#query_params), the service returns a [nextPageToken](/docs/compute/api-ref/PlacementGroup/list#responses) that can be used to get the next page of results in subsequent list requests.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/compute/api-ref/PlacementGroup/list#query_params) to the [nextPageToken](/docs/compute/api-ref/PlacementGroup/list#responses) returned by a previous list request.
filter | A filter expression that filters resources listed in the response. Currently you can use filtering only on the [PlacementGroup.name](/docs/compute/api-ref/PlacementGroup#representation) field.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "placementGroups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "spreadPlacementStrategy": {}
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
placementGroups[] | **object**<br><p>Lists placement groups for the specified folder.</p> 
placementGroups[].<br>id | **string**<br><p>ID of the placement group.</p> 
placementGroups[].<br>folderId | **string**<br><p>ID of the folder that the placement group belongs to.</p> 
placementGroups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
placementGroups[].<br>name | **string**<br><p>Name of the placement group. The name is unique within the folder.</p> 
placementGroups[].<br>description | **string**<br><p>Description of the placement group.</p> 
placementGroups[].<br>labels | **object**<br><p>Resource labels as <code>key:value</code> pairs.</p> 
placementGroups[].<br>spreadPlacementStrategy | **object**<br>Distribute instances over distinct failure domains.<br>
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/compute/api-ref/PlacementGroup/list#query_params">pageSize</a>, use <a href="/docs/compute/api-ref/PlacementGroup/list#responses">nextPageToken</a> as the value for the <a href="/docs/compute/api-ref/PlacementGroup/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/compute/api-ref/PlacementGroup/list#responses">nextPageToken</a> to continue paging through the results.</p> 