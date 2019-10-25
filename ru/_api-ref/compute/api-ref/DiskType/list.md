---
editable: false
---

# Метод list
Получает список типов дисков для указанного каталога.
 

 
## HTTP-запрос {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/diskTypes
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/DiskType/list#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/DiskType/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/DiskType/list#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/DiskType/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
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

 
Поле | Описание
--- | ---
diskTypes[] | **object**<br><p>Список типов дисков.</p> 
diskTypes[].<br>id | **string**<br><p>Идентификатор типа диска.</p> 
diskTypes[].<br>description | **string**<br><p>Описание диска. Длина описания должна быть от 0 до 256 символов.</p> 
diskTypes[].<br>zoneIds[] | **string**<br><p>Массив зон доступности, в которых доступен тип диска.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/compute/api-ref/DiskType/list#query_params">pageSize</a>, используйте <a href="/docs/compute/api-ref/DiskType/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/compute/api-ref/DiskType/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/compute/api-ref/DiskType/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 