---
editable: false
sourcePath: en/_api-ref/compute/api-ref/PlacementGroup/list.md
---

# Compute Cloud API, REST: PlacementGroup.list
Retrieves the list of placement groups in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/placementGroups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>ID of the folder to list placement groups in.</p> <p>To get the folder ID make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/compute/api-ref/PlacementGroup/list#query_params">pageSize</a>, the service returns a <a href="/docs/compute/api-ref/PlacementGroup/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/compute/api-ref/PlacementGroup/list#query_params">pageToken</a> to the <a href="/docs/compute/api-ref/PlacementGroup/list#responses">nextPageToken</a> returned by a previous list request.</p> 
filter | <p>A filter expression that filters resources listed in the response. Currently you can use filtering only on the <a href="/docs/compute/api-ref/PlacementGroup#representation">PlacementGroup.name</a> field.</p> 
 
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

      // `placementGroups[]` includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`
      "spreadPlacementStrategy": {},
      "partitionPlacementStrategy": {
        "partitions": "string"
      },
      // end of the list of possible fields`placementGroups[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
placementGroups[] | **object**<br><p>Lists placement groups in the specified folder.</p> 
placementGroups[].<br>id | **string**<br><p>ID of the placement group. Generated at creation time.</p> 
placementGroups[].<br>folderId | **string**<br><p>ID of the folder that the placement group belongs to.</p> 
placementGroups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
placementGroups[].<br>name | **string**<br><p>Name of the placement group. The name is unique within the folder.</p> 
placementGroups[].<br>description | **string**<br><p>Description of the placement group. 0-256 characters long.</p> 
placementGroups[].<br>labels | **object**<br><p>Placement group labels as ``key:value`` pairs.</p> 
placementGroups[].<br>spreadPlacementStrategy | **object**<br>Anti-affinity placement strategy (`spread`). Instances are distributed over distinct failure domains. <br>`placementGroups[]` includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`<br>
placementGroups[].<br>partitionPlacementStrategy | **object** <br>`placementGroups[]` includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`<br>
placementGroups[].<br>partitionPlacementStrategy.<br>partitions | **string** (int64)<br><p>Acceptable values are 2 to 5, inclusive.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/compute/api-ref/PlacementGroup/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/compute/api-ref/PlacementGroup/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 