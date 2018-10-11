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
zones | **object**<br><p>Зона доступности. Дополнительные сведения см. в разделе <a href="/docs/overview/concepts/geo-scope">Зоны доступности</a>.</p> 
zones.<br>id | **string**<br><p>Только для вывода. Идентификатор зоны доступности.</p> 
zones.<br>regionId | **string**<br><p>Только для вывода. Идентификатор региона.</p> 
zones.<br>status | **string**<br><p>Только для вывода. Статус зоны доступности.</p> <ul> <li>UP: Зона доступна. Вы можете обращаться к ресурсам в этой зоне.</li> <li>DOWN: Зона недоступна.</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/compute/api-ref/Zone/list#query_params">pageSize</a>, используйте <a href="/docs/compute/api-ref/Zone/list#query_params">pageToken</a> в качестве значения параметра <a href="/docs/compute/api-ref/Zone/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/compute/api-ref/Zone/list#query_params">pageToken</a>, для перебора страниц результатов.</p> 