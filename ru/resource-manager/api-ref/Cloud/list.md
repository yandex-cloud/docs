# Метод list
Возвращает список доступных ресурсов Cloud.
 

 
## HTTP-запрос
`GET /resource-manager/v1/clouds`
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/resource-manager/api-ref/Cloud/list#query_params), сервис вернет значение [nextPageToken](/docs/resource-manager/api-ref/Cloud/list#responses), которое можно использовать для получения следующей страницы. Допустимые значения от 0 до 1000 включительно. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/resource-manager/api-ref/Cloud/list#query_params) равным значению поля [nextPageToken](/docs/resource-manager/api-ref/Cloud/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Cloud.name](/docs/resource-manager/api-ref/Cloud#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.  Максимальная длина — 1000 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
clouds | **object**<br><p>Ресурс Cloud. Дополнительные сведения см. в разделе <a href="/docs/resource-manager/concepts/resources-hierarchy#cloud">Облако как ресурс Яндекс.Облака</a>.</p> 
clouds.<br>id | **string**<br><p>Идентификатор облака.</p> 
clouds.<br>createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
clouds.<br>name | **string**<br><p>Имя облака. Длина имени должна быть от 3 до 63 символов.</p> 
clouds.<br>description | **string**<br><p>Описание облака. Длина описания должна быть от 0 до 256 символов.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/resource-manager/api-ref/Cloud/list#query_params">pageSize</a>, используйте <a href="/docs/resource-manager/api-ref/Cloud/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/resource-manager/api-ref/Cloud/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/resource-manager/api-ref/Cloud/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 