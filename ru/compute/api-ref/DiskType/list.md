# Метод list
Возвращает список доступных типов дисков.
 

 
## HTTP-запрос
`GET /compute/v1/diskTypes`
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/DiskType/list#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/DiskType/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/DiskType/list#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/DiskType/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
diskTypes | **object**<br><p>Тип диска</p> 
diskTypes.<br>id | **string**<br><p>Только для вывода. Идентификатор типа диска.</p> 
diskTypes.<br>description | **string**<br><p>Только для вывода. Описание типа диска. Длина 0-256 символов.</p> 
diskTypes.<br>zoneIds | **string**<br><p>Только для вывода. Список зон доступности, в которых доступны диски этого типа.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/compute/api-ref/DiskType/list#query_params">pageSize</a>, используйте <a href="/docs/compute/api-ref/DiskType/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/compute/api-ref/DiskType/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/compute/api-ref/DiskType/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 