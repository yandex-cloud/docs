---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Method list
Retrieves the list of available resource presets.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-redis/v1/resourcePresets
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-redis/api-ref/ResourcePreset/list#query_params), the service returns a [nextPageToken](/docs/managed-redis/api-ref/ResourcePreset/list#responses) that can be used to get the next page of results in subsequent list requests.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-redis/api-ref/ResourcePreset/list#query_params) to the [nextPageToken](/docs/managed-redis/api-ref/ResourcePreset/list#responses) returned by a previous list request.
 
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
      "memory": "string",
      "cores": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
resourcePresets[] | **object**<br><p>A resource preset that describes hardware configuration for a host.</p> 
resourcePresets[].<br>id | **string**<br><p>ID of the resource preset.</p> 
resourcePresets[].<br>zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
resourcePresets[].<br>memory | **string** (int64)<br><p>RAM volume for a Redis host created with the preset, in bytes.</p> 
resourcePresets[].<br>cores | **string** (int64)<br><p>Number of CPU cores for a Redis host created with the preset.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-redis/api-ref/ResourcePreset/list#query_params">pageSize</a>, use the <a href="/docs/managed-redis/api-ref/ResourcePreset/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-redis/api-ref/ResourcePreset/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-redis/api-ref/ResourcePreset/list#responses">nextPageToken</a> to continue paging through the results.</p> 