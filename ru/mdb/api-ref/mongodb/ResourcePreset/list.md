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
resourcePresets | **object**<br>Ресурс ResourcePreset для описания наборов ресурсов.
resourcePresets.<br>id | **string**<br>Идентификатор ресурса ResourcePreset.
resourcePresets.<br>zoneIds | **string**<br>Идентификаторы зон доступности, в которых доступен данный набор ресурсов.
resourcePresets.<br>cores | **string** (int64)<br>Количество ядер CPU для хоста MongoDB, созданного с данным набором ресурсов.
resourcePresets.<br>memory | **string** (int64)<br>Объем оперативной памяти для хоста MongoDB, созданного с данным набором ресурсов, в байтах.
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/mongodb/ResourcePreset/list#query_params), используйте [nextPageToken](/docs/mdb/api-ref/mongodb/ResourcePreset/list#responses) в качестве значения параметра [pageToken](/docs/mdb/api-ref/mongodb/ResourcePreset/list#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/mdb/api-ref/mongodb/ResourcePreset/list#responses) для перебора страниц результатов.