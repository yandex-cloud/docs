---
editable: false
---

# Метод list
Получает список доступных ресурсов ResourcePreset.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/resourcePresets
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-clickhouse/api-ref/ResourcePreset/list#query_params), сервис вернет значение [nextPageToken](/docs/managed-clickhouse/api-ref/ResourcePreset/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-clickhouse/api-ref/ResourcePreset/list#query_params) равным значению поля [nextPageToken](/docs/managed-clickhouse/api-ref/ResourcePreset/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
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
resourcePresets[] | **object**<br><p>Описание конфигурации ресурсов.</p> 
resourcePresets[].<br>id | **string**<br><p>Идентификатор конфигурации ресурсов.</p> 
resourcePresets[].<br>zoneIds[] | **string**<br><p>Идентификаторы зон доступности, в которых доступен данный набор ресурсов.</p> 
resourcePresets[].<br>cores | **string** (int64)<br><p>Количество ядер CPU для хоста ClickHouse, созданного с данным набором ресурсов.</p> 
resourcePresets[].<br>memory | **string** (int64)<br><p>Объем оперативной памяти для хоста ClickHouse, созданного с данным набором ресурсов, в байтах.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-clickhouse/api-ref/ResourcePreset/list#query_params">pageSize</a>, используйте <a href="/docs/managed-clickhouse/api-ref/ResourcePreset/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-clickhouse/api-ref/ResourcePreset/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-clickhouse/api-ref/ResourcePreset/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 