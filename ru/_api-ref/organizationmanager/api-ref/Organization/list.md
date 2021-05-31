---
editable: false
---

# Метод list
Возвращает список доступных организаций.
 

 
## HTTP-запрос {#https-request}
```
GET https://organization-manager.api.cloud.yandex.net/organization-manager/v1/organizations
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/organization-manager/api-ref/Organization/list#query_params) , сервис вернет значение [nextPageToken](/docs/organization-manager/api-ref/Organization/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/organization-manager/api-ref/Organization/list#query_params) равным значению поля [nextPageToken](/docs/organization-manager/api-ref/Organization/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Organization.name](/docs/organization-manager/api-ref/Organization#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "organizations": [
    {
      "id": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "title": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
organizations[] | **object**<br><p>Ресурс &quot;Организация&quot;. Подробнее см. в разделе <a href="/docs/organization/enable-org">Управление организациями</a>.</p> 
organizations[].<br>id | **string**<br><p>Идентификатор организации.</p> 
organizations[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
organizations[].<br>name | **string**<br><p>Имя организации. Длина имени должна быть от 3 до 63 символов.</p> 
organizations[].<br>description | **string**<br><p>Описание организации. Длина описания должна быть от 0 до 256 символов.</p> 
organizations[].<br>title | **string**<br><p>Название организации. Длина описания должна быть от 0 до 256 символов.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListOrganizationsResponse.page_size], используйте <a href="/docs/organization-manager/api-ref/Organization/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/organization-manager/api-ref/Organization/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/organization-manager/api-ref/Organization/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 