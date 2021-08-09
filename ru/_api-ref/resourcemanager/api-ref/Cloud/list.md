---
editable: false
---

# Метод list
Возвращает список доступных ресурсов Cloud.
 

 
## HTTP-запрос {#https-request}
```
GET https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/resource-manager/api-ref/Cloud/list#query_params) , сервис вернет значение [nextPageToken](/docs/resource-manager/api-ref/Cloud/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/resource-manager/api-ref/Cloud/list#query_params) равным значению поля [nextPageToken](/docs/resource-manager/api-ref/Cloud/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Cloud.name](/docs/resource-manager/api-ref/Cloud#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "clouds": [
    {
      "id": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "organizationId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
clouds[] | **object**<br><p>Ресурс Cloud. Подробнее см. в разделе <a href="/docs/resource-manager/concepts/resources-hierarchy#cloud">Облако как ресурс Яндекс.Облака</a>.</p> 
clouds[].<br>id | **string**<br><p>Идентификатор облака.</p> 
clouds[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
clouds[].<br>name | **string**<br><p>Имя облака. Длина имени должна быть от 3 до 63 символов.</p> 
clouds[].<br>description | **string**<br><p>Описание облака. Длина описания должна быть от 0 до 256 символов.</p> 
clouds[].<br>organizationId | **string**<br><p>Идентификатор организации, которой принадлежит облако.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/resource-manager/api-ref/Cloud/list#query_params">pageSize</a>, используйте <a href="/docs/resource-manager/api-ref/Cloud/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/resource-manager/api-ref/Cloud/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/resource-manager/api-ref/Cloud/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 