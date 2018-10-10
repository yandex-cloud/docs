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
diskTypes | **object**<br>Тип диска
diskTypes.<br>id | **string**<br>Только для вывода. Идентификатор типа диска.
diskTypes.<br>description | **string**<br>Только для вывода. Описание типа диска. Длина 0-256 символов.
diskTypes.<br>zoneIds | **string**<br>Только для вывода. Список зон доступности, в которых доступны диски этого типа.
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/DiskType/list#query_params), используйте [nextPageToken](/docs/compute/api-ref/DiskType/list#responses) в качестве значения параметра [pageToken](/docs/compute/api-ref/DiskType/list#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/compute/api-ref/DiskType/list#responses) для перебора страниц результатов.