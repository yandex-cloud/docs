---
editable: false
sourcePath: en/_api-ref/ydb/api-ref/ResourcePreset/list.md
---

# Method list
Returns the list of available resource presets.
 

 
## HTTP request {#https-request}
```
GET https://ydb.{{ api-host }}/ydb/v1/resourcePresets
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListResourcePresets requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. Set `page_token` to the `next_page_token` returned by a previous ListResourcePresets request to get the next page of results.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "resourcePresets": [
    {
      "id": "string",
      "cores": "string",
      "memory": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
resourcePresets[] | **object**<br><p>Requested list of resource presets.</p> 
resourcePresets[].<br>id | **string**<br>
resourcePresets[].<br>cores | **string** (int64)<br>
resourcePresets[].<br>memory | **string** (int64)<br>
nextPageToken | **string**<br><p>This token allows you to get the next page of results for ListResourcePresets requests, if the number of results is larger than ``page_size`` specified in the request. To get the next page, specify the value of ``next_page_token`` as a value for the ``page_token`` parameter in the next ListResourcePresets request. Subsequent ListResourcePresets requests will have their own ``next_page_token`` to continue paging through the results.</p> 