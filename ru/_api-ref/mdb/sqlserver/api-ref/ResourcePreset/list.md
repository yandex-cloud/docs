---
editable: false
---

# Метод list
Возвращает список доступных наборов вычислительных ресурсов.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1/resourcePresets
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/managed-sqlserver/api-ref/ResourcePreset/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/managed-sqlserver/api-ref/ResourcePreset/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
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
resourcePresets[] | **object**<br><p>Набор вычислительных ресурсов для хостов SQL Server.</p> 
resourcePresets[].<br>id | **string**<br><p>Идентификатор набора вычислительных ресурсов.</p> 
resourcePresets[].<br>zoneIds[] | **string**<br><p>Идентификаторы зон доступности, в которых доступен этот набор вычислительных ресурсов.</p> 
resourcePresets[].<br>cores | **string** (int64)<br><p>Количество процессорных ядер для хоста SQL, созданного с данным набором вычислительных ресурсов.</p> 
resourcePresets[].<br>memory | **string** (int64)<br><p>Объем оперативной памяти для хоста SQL Server, созданного с данным набором вычислительных ресурсов, в байтах.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-sqlserver/api-ref/ResourcePreset/list#query_params">pageSize</a>, используйте `next_page_token` в качестве значения параметра <a href="/docs/managed-sqlserver/api-ref/ResourcePreset/list#query_params">pageToken</a> в следующем запросе. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов.</p> <p>Максимальная длина строки в символах — 100.</p> 