---
editable: false
---

# Метод list
Retrieves the list of available resource presets.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/resourcePresets
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | The maximum number of results per page to return.  If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/managed-kafka/api-ref/ResourcePreset/list#responses) that can be used to get the next page of results in subsequent list requests.  Максимальное значение — 1000.
pageToken | Page token.  To get the next page of results, set `page_token` to the [nextPageToken](/docs/managed-kafka/api-ref/ResourcePreset/list#responses), returned by a previous list request.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
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

 
Поле | Описание
--- | ---
resourcePresets[] | **object**<br><p>A ResourcePreset resource for describing hardware configuration presets.</p> 
resourcePresets[].<br>id | **string**<br><p>ID of the ResourcePreset resource.</p> 
resourcePresets[].<br>zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
resourcePresets[].<br>cores | **string** (int64)<br><p>Number of CPU cores for a Kafka broker created with the preset.</p> 
resourcePresets[].<br>memory | **string** (int64)<br><p>RAM volume for a Kafka broker created with the preset, in bytes.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-kafka/api-ref/ResourcePreset/list#query_params">pageSize</a>, use <code>next_page_token</code> as the value for the <a href="/docs/managed-kafka/api-ref/ResourcePreset/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <code>next_page_token</code> to continue paging through the results.</p> <p>Максимальная длина строки в символах — 100.</p> 