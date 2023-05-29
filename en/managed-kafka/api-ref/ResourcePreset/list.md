---
editable: false
sourcePath: en/_api-ref/mdb/kafka/v1/api-ref/ResourcePreset/list.md
---

# Managed Service for Apache Kafka® API, REST: ResourcePreset.list
Retrieves the list of available resource presets.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-kafka/v1/resourcePresets
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-kafka/api-ref/ResourcePreset/list#query_params">pageSize</a>, the service returns a <a href="/docs/managed-kafka/api-ref/ResourcePreset/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token.</p> <p>To get the next page of results, set <a href="/docs/managed-kafka/api-ref/ResourcePreset/list#query_params">pageToken</a> to the <a href="/docs/managed-kafka/api-ref/ResourcePreset/list#responses">nextPageToken</a>, returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
resourcePresets[].<br>id | **string**<br><p>ID of the resource preset.</p> 
resourcePresets[].<br>zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
resourcePresets[].<br>cores | **string** (int64)<br><p>Number of CPU cores for a Kafka broker created with the preset.</p> 
resourcePresets[].<br>memory | **string** (int64)<br><p>RAM volume for a Kafka broker created with the preset, in bytes.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-kafka/api-ref/ResourcePreset/list#query_params">pageSize</a>, use <a href="/docs/managed-kafka/api-ref/ResourcePreset/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-kafka/api-ref/ResourcePreset/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-kafka/api-ref/ResourcePreset/list#responses">nextPageToken</a> to continue paging through the results.</p> <p>The maximum string length in characters is 100.</p> 