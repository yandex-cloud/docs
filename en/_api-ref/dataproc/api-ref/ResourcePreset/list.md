---
editable: false
---

# Method list
Retrieves the list of available ResourcePreset resources.
 

 
## HTTP request {#https-request}
```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/resourcePresets
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/data-proc/api-ref/ResourcePreset/list#query_params), the service returns a [nextPageToken](/docs/data-proc/api-ref/ResourcePreset/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/data-proc/api-ref/ResourcePreset/list#query_params) to the [nextPageToken](/docs/data-proc/api-ref/ResourcePreset/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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
resourcePresets[] | **object**<br><p>A ResourcePreset resource for describing hardware configuration presets.</p> 
resourcePresets[].<br>id | **string**<br><p>ID of the ResourcePreset resource.</p> 
resourcePresets[].<br>zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
resourcePresets[].<br>cores | **string** (int64)<br><p>Number of CPU cores for a Data Proc host created with the preset.</p> 
resourcePresets[].<br>memory | **string** (int64)<br><p>RAM volume for a Data Proc host created with the preset, in bytes.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/data-proc/api-ref/ResourcePreset/list#query_params">pageSize</a>, use the <a href="/docs/data-proc/api-ref/ResourcePreset/list#responses">nextPageToken</a> as the value for the <a href="/docs/data-proc/api-ref/ResourcePreset/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/data-proc/api-ref/ResourcePreset/list#responses">nextPageToken</a> to continue paging through the results.</p> <p>The maximum string length in characters is 100.</p> 