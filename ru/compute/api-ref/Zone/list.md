# Метод list
Возвращает список зон доступности.
 

 
## HTTP-запрос
`GET /compute/v1/zones`
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/Zone/list#query_params), сервис вернет значение [nextPageToken](/docs/compute/api-ref/Zone/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/compute/api-ref/Zone/list#query_params) равным значению поля [nextPageToken](/docs/compute/api-ref/Zone/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
zones | **object**<br>Зона доступности. Дополнительные сведения см. в разделе [Зоны доступности](/docs/overview/concepts/geo-scope).
zones.<br>id | **string**<br>Только для вывода. Идентификатор зоны доступности.
zones.<br>regionId | **string**<br>Только для вывода. Идентификатор региона.
zones.<br>status | **string**<br>Только для вывода. Статус зоны доступности.   - UP: Зона доступна. Вы можете обращаться к ресурсам в этой зоне.  - DOWN: Зона недоступна.<br>`UP`<br>`DOWN`<br>
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/compute/api-ref/Zone/list#query_params), используйте [pageToken](/docs/compute/api-ref/Zone/list#query_params) в качестве значения параметра [pageToken](/docs/compute/api-ref/Zone/list#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [pageToken](/docs/compute/api-ref/Zone/list#query_params), для перебора страниц результатов.