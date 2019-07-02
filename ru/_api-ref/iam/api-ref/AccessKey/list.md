---
editable: false
---

# Метод list
Возвращает список ключей доступа для указанного сервисного аккаунта.
 

 
## HTTP-запрос {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/aws-compatibility/v1/accessKeys
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
serviceAccountId | Идентификатор сервисного аккаунта, для которого запрашивается список ключей доступа. Чтобы получить идентификатор сервисного аккаунта, используйте запрос [list](/docs/iam/api-ref/ServiceAccount/list). Если параметр не указан, то используется идентификатор субъекта, который сделал запрос.  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/iam/api-ref/AccessKey/list#query_params), сервис вернет значение [nextPageToken](/docs/iam/api-ref/AccessKey/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/iam/api-ref/AccessKey/list#query_params) равным значению поля [nextPageToken](/docs/iam/api-ref/AccessKey/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "accessKeys": [
    {
      "id": "string",
      "serviceAccountId": "string",
      "createdAt": "string",
      "description": "string",
      "keyId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
accessKeys[] | **object**<br><p>Ключ доступа. Дополнительные сведения см. в разделе <a href="/docs/iam/concepts/authorization/access-key">AWS-совместимые ключи доступа</a>.</p> 
accessKeys[].<br>id | **string**<br><p>Идентификатор ресурса AccessKey. Он используется для управления идентификатором ключа доступа и секретным ключом доступа.</p> 
accessKeys[].<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, которому принадлежит ключ доступа.</p> 
accessKeys[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
accessKeys[].<br>description | **string**<br><p>Описание ключа доступа. Длина описания должна быть от 0 до 256 символов.</p> 
accessKeys[].<br>keyId | **string**<br><p>Идентификатор ключа доступа. Ключ совместим с сервисами AWS.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/iam/api-ref/AccessKey/list#query_params">pageSize</a>, используйте <a href="/docs/iam/api-ref/AccessKey/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/iam/api-ref/AccessKey/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/iam/api-ref/AccessKey/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 