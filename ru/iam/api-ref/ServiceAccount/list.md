---
editable: false
---

# Метод list
Возвращает список доступных ресурсов ServiceAccount в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка сервисных аккаунтов. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/iam/api-ref/ServiceAccount/list#query_params), сервис вернет значение [nextPageToken](/docs/iam/api-ref/ServiceAccount/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/iam/api-ref/ServiceAccount/list#query_params) равным значению поля [nextPageToken](/docs/iam/api-ref/ServiceAccount/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [ServiceAccount.name](/docs/iam/api-ref/ServiceAccount#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "serviceAccounts": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
serviceAccounts[] | **object**<br><p>Ресурс ServiceAccount. Дополнительные сведения см. в разделе <a href="/docs/iam/concepts/users/service-accounts">Сервисные аккаунты</a>.</p> 
serviceAccounts[].<br>id | **string**<br><p>Идентификатор сервисного аккаунта.</p> 
serviceAccounts[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит сервисный аккаунт.</p> 
serviceAccounts[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
serviceAccounts[].<br>name | **string**<br><p>Имя сервисного аккаунта. Имя должно быть уникальным в облаке. Длина 3-63 символов.</p> 
serviceAccounts[].<br>description | **string**<br><p>Описание сервисного аккаунта. Длина описания должна быть от 0 до 256 символов.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/iam/api-ref/ServiceAccount/list#query_params">pageSize</a>, используйте <a href="/docs/iam/api-ref/ServiceAccount/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/iam/api-ref/ServiceAccount/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/iam/api-ref/ServiceAccount/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 