---
editable: false
---

# Method list
Retrieves the list of available resource presets.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-mysql/v1/resourcePresets
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-mysql/api-ref/ResourcePreset/list#query_params">pageSize</a>, the API returns a <a href="/docs/managed-mysql/api-ref/ResourcePreset/list#responses">nextPageToken</a> that can be used to get the next page of results in the subsequent <a href="/docs/managed-mysql/api-ref/ResourcePreset/list">list</a> requests.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token that can be used to iterate through multiple pages of results.</p> <p>To get the next page of results, set <a href="/docs/managed-mysql/api-ref/ResourcePreset/list#query_params">pageToken</a> to the <a href="/docs/managed-mysql/api-ref/ResourcePreset/list#responses">nextPageToken</a> returned by the previous <a href="/docs/managed-mysql/api-ref/ResourcePreset/list">list</a> request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "resourcePresets": [
    {
      "id": "string",
      "zoneIds": [
        "string"
      ],
      "cores": "string",
      "memory": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
resourcePresets[] | **object**<br><p>List of resource presets.</p> 
resourcePresets[].<br>id | **string**<br><p>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host.</p> 
resourcePresets[].<br>zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
resourcePresets[].<br>cores | **string** (int64)<br><p>Number of CPU cores for a MySQL host created with the preset.</p> 
resourcePresets[].<br>memory | **string** (int64)<br><p>RAM volume for a MySQL host created with the preset, in bytes.</p> 
nextPageToken | **string**<br><p>The token that can be used to get the next page of results.</p> <p>If the number of results is larger than <a href="/docs/managed-mysql/api-ref/ResourcePreset/list#query_params">pageSize</a>, use the <a href="/docs/managed-mysql/api-ref/ResourcePreset/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mysql/api-ref/ResourcePreset/list#query_params">pageToken</a> in the subsequent <a href="/docs/managed-mysql/api-ref/ResourcePreset/list">list</a> request to iterate through multiple pages of results.</p> <p>Each of the subsequent <a href="/docs/managed-mysql/api-ref/ResourcePreset/list">list</a> requests should use the <a href="/docs/managed-mysql/api-ref/ResourcePreset/list#responses">nextPageToken</a> value returned by the previous request to continue paging through the results.</p> <p>The maximum string length in characters is 100.</p> 