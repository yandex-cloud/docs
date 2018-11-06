# Метод list
Получает список доступных ресурсов ResourcePreset.
 

 
## HTTP-запрос
`GET /managed-mongodb/v1/resourcePresets`
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/mongodb/ResourcePreset/list#query_params), сервис вернет значение [nextPageToken](/docs/mdb/api-ref/mongodb/ResourcePreset/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/mdb/api-ref/mongodb/ResourcePreset/list#query_params) равным значению поля [nextPageToken](/docs/mdb/api-ref/mongodb/ResourcePreset/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
resourcePresets | **object**<br><p>Ресурс ResourcePreset для описания наборов ресурсов.</p> 
resourcePresets.<br>id | **string**<br><p>Идентификатор ресурса ResourcePreset.</p> 
resourcePresets.<br>zoneIds | **string**<br><p>Идентификаторы зон доступности, в которых доступен данный набор ресурсов.</p> 
resourcePresets.<br>cores | **string** (int64)<br><p>Количество ядер CPU для хоста MongoDB, созданного с данным набором ресурсов.</p> 
resourcePresets.<br>memory | **string** (int64)<br><p>Объем оперативной памяти для хоста MongoDB, созданного с данным набором ресурсов, в байтах.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/mdb/api-ref/mongodb/ResourcePreset/list#query_params">pageSize</a>, используйте <a href="/docs/mdb/api-ref/mongodb/ResourcePreset/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/mdb/api-ref/mongodb/ResourcePreset/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/mdb/api-ref/mongodb/ResourcePreset/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 