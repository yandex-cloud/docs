# Метод list
Возвращает список доступных ресурсов Role.
 

 
## HTTP-запрос
`GET /iam/v1/roles`
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/iam/api-ref/Role/list#query_params), сервис вернет значение [nextPageToken](/docs/iam/api-ref/Role/list#responses), которое можно использовать для получения следующей страницы. Допустимые значения от 0 до 1000 включительно. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/iam/api-ref/Role/list#query_params) равным значению поля [nextPageToken](/docs/iam/api-ref/Role/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
filter | Параметры фильтрации ресурсов в ответе.  Максимальная длина — 1000 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
roles | **object**<br>Ресурс Role. Дополнительные сведения см. в разделе [Роли](/docs/iam/concepts/access-control/roles).
roles.<br>id | **string**<br>Только для вывода. Идентификатор роли.
roles.<br>description | **string**<br>Описание роли. Длина описания должна быть от 0 до 256 символов.
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/iam/api-ref/Role/list#query_params), используйте [nextPageToken](/docs/iam/api-ref/Role/list#responses) в качестве значения параметра [pageToken](/docs/iam/api-ref/Role/list#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/iam/api-ref/Role/list#responses) для перебора страниц результатов.