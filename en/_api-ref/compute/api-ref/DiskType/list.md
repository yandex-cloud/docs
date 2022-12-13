---
editable: false
---

# Compute Cloud API, REST: DiskType.list
Retrieves the list of disk types for the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/diskTypes
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/compute/api-ref/DiskType/list#query_params">pageSize</a>, the service returns a <a href="/docs/compute/api-ref/DiskType/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/compute/api-ref/DiskType/list#query_params">pageToken</a> to the <a href="/docs/compute/api-ref/DiskType/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "diskTypes": [
    {
      "id": "string",
      "description": "string",
      "zoneIds": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
diskTypes[] | **object**<br><p>List of disk types.</p> 
diskTypes[].<br>id | **string**<br><p>ID of the disk type.</p> 
diskTypes[].<br>description | **string**<br><p>Description of the disk type. 0-256 characters long.</p> 
diskTypes[].<br>zoneIds[] | **string**<br><p>Array of availability zones where the disk type is available.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/compute/api-ref/DiskType/list#query_params">pageSize</a>, use the <a href="/docs/compute/api-ref/DiskType/list#responses">nextPageToken</a> as the value for the <a href="/docs/compute/api-ref/DiskType/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/compute/api-ref/DiskType/list#responses">nextPageToken</a> to continue paging through the results.</p> 