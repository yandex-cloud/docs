---
editable: false
---

# Метод list
Возвращает список API-ключей для указанного сервисного аккаунта.
 

 
## HTTP-запрос {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/apiKeys
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
serviceAccountId | Идентификатор сервисного аккаунта, для которого запрашивается список API-ключей. Чтобы получить идентификатор сервисного аккаунта, используйте запрос [list](/docs/iam/api-ref/ServiceAccount/list). Если параметр не указан, то используется идентификатор субъекта, который сделал запрос.  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/iam/api-ref/ApiKey/list#query_params) , сервис вернет значение [nextPageToken](/docs/iam/api-ref/ApiKey/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/iam/api-ref/ApiKey/list#query_params) равным значению поля [nextPageToken](/docs/iam/api-ref/ApiKey/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "apiKeys": [
    {
      "id": "string",
      "serviceAccountId": "string",
      "createdAt": "string",
      "description": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
apiKeys[] | **object**<br><p>Ресурс ApiKey.</p> 
apiKeys[].<br>id | **string**<br><p>Идентификатор API-ключа.</p> 
apiKeys[].<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, которому принадлежит API-ключ.</p> 
apiKeys[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
apiKeys[].<br>description | **string**<br><p>Описание API-ключа. Длина описания должна быть от 0 до 256 символов.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/iam/api-ref/ApiKey/list#query_params">pageSize</a>, используйте <a href="/docs/iam/api-ref/ApiKey/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/iam/api-ref/ApiKey/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/iam/api-ref/ApiKey/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 