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
clouds | **object**<br>Ресурс Cloud. Дополнительные сведения см. в разделе [Облако как ресурс Яндекс.Облака](/docs/resource-manager/concepts/resources-hierarchy#cloud).
clouds.<br>id | **string**<br>Только для вывода. Идентификатор облака.
clouds.<br>createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
clouds.<br>name | **string**<br>Имя облака. Длина имени должна быть от 3 до 63 символов.
clouds.<br>description | **string**<br>Описание облака. Длина описания должна быть от 0 до 256 символов.
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/resource-manager/api-ref/Cloud/list#query_params), используйте [nextPageToken](/docs/resource-manager/api-ref/Cloud/list#responses) в качестве значения параметра [pageToken](/docs/resource-manager/api-ref/Cloud/list#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/resource-manager/api-ref/Cloud/list#responses) для перебора страниц результатов.