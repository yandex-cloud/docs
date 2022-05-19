---
editable: false
---

# Method list
Retrieves the list of available resource presets.
 

 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-mysql/v1/resourcePresets
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return.  If the number of available results is larger than [pageSize](/docs/managed-mysql/api-ref/ResourcePreset/list#query_params), the API returns a [nextPageToken](/docs/managed-mysql/api-ref/ResourcePreset/list#responses) that can be used to get the next page of results in the subsequent [list](/docs/managed-mysql/api-ref/ResourcePreset/list) requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token that can be used to iterate through multiple pages of results.  To get the next page of results, set [pageToken](/docs/managed-mysql/api-ref/ResourcePreset/list#query_params) to the [nextPageToken](/docs/managed-mysql/api-ref/ResourcePreset/list#responses) returned by the previous [list](/docs/managed-mysql/api-ref/ResourcePreset/list) request.  The maximum string length in characters is 100.
 
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
resourcePresets[] | **object**<br><p>An object that represents MySQL resource preset. A resource preset defines hardware configuration for cluster hosts.</p> <p>See <a href="/docs/managed-mysql/concepts/instance-types">the documentation</a> for details.</p> 
resourcePresets[].<br>id | **string**<br><p>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host.</p> 
resourcePresets[].<br>zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
resourcePresets[].<br>cores | **string** (int64)<br><p>Number of CPU cores for a MySQL host created with the preset.</p> 
resourcePresets[].<br>memory | **string** (int64)<br><p>RAM volume for a MySQL host created with the preset, in bytes.</p> 
nextPageToken | **string**<br><p>The token that can be used to get the next page of results.</p> <p>If the number of results is larger than <a href="/docs/managed-mysql/api-ref/ResourcePreset/list#query_params">pageSize</a>, use the <a href="/docs/managed-mysql/api-ref/ResourcePreset/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mysql/api-ref/ResourcePreset/list#query_params">pageToken</a> in the subsequent <a href="/docs/managed-mysql/api-ref/ResourcePreset/list">list</a> request to iterate through multiple pages of results.</p> <p>Each of the subsequent <a href="/docs/managed-mysql/api-ref/ResourcePreset/list">list</a> requests should use the <a href="/docs/managed-mysql/api-ref/ResourcePreset/list#responses">nextPageToken</a> value returned by the previous request to continue paging through the results.</p> <p>The maximum string length in characters is 100.</p> 