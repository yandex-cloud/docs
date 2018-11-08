# Метод list
Получает список доступных ресурсов ResourcePreset.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/resourcePresets
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/postgresql/ResourcePreset/list#query_params), сервис вернет значение [nextPageToken](/docs/mdb/api-ref/postgresql/ResourcePreset/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/mdb/api-ref/postgresql/ResourcePreset/list#query_params) равным значению поля [nextPageToken](/docs/mdb/api-ref/postgresql/ResourcePreset/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
resourcePresets | **object**<br><p>Ресурс ResourcePreset для описания настроек конфигурации ресурсов.</p> 
resourcePresets.<br>id | **string**<br><p>Идентификатор ресурса ResourcePreset.</p> 
resourcePresets.<br>zoneIds | **string**<br><p>Идентификаторы зон доступности, в которых доступен данный набор ресурсов.</p> 
resourcePresets.<br>cores | **string** (int64)<br><p>Количество ядер CPU для хоста PostgreSQL, созданного с данным набором ресурсов.</p> 
resourcePresets.<br>memory | **string** (int64)<br><p>Объем оперативной памяти для хоста PostgreSQL, созданного с данным набором ресурсов, в байтах.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/mdb/api-ref/postgresql/ResourcePreset/list#query_params">pageSize</a>, используйте <a href="/docs/mdb/api-ref/postgresql/ResourcePreset/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/mdb/api-ref/postgresql/ResourcePreset/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/mdb/api-ref/postgresql/ResourcePreset/list#responses">nextPageToken</a> для перебора страниц результатов.</p> <p>Максимальная длина строки в символах — 100.</p> 