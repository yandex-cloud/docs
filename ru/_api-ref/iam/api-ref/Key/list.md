---
editable: false
---

# Метод list
Возвращает список доступных ресурсов Key для указанного сервисного аккаунта.
 

 
## HTTP-запрос {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/keys
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
format | Формат ключа.<ul> <li>PEM_FILE: Формат Privacy-Enhanced Mail (PEM). Значение по умолчанию.</li> </ul> 
serviceAccountId | Идентификатор сервисного аккаунта для вывода списка пар ключей. Чтобы получить идентификатор сервисного аккаунта, используйте запрос [list](/docs/iam/api-ref/ServiceAccount/list). Если параметр не указан, то используется идентификатор субъекта, который сделал запрос.  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/iam/api-ref/Key/list#query_params), сервис вернет значение [nextPageToken](/docs/iam/api-ref/Key/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/iam/api-ref/Key/list#query_params) равным значению поля [nextPageToken](/docs/iam/api-ref/Key/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "keys": [
    {
      "id": "string",
      "createdAt": "string",
      "description": "string",
      "keyAlgorithm": "string",
      "publicKey": "string",

      // `keys[]` включает только одно из полей `userAccountId`, `serviceAccountId`
      "userAccountId": "string",
      "serviceAccountId": "string",
      // конец списка возможных полей`keys[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
keys[] | **object**<br><p>Ресурс Key. Подробнее см. в разделе <a href="/docs/iam/concepts/authorization/key">Авторизованные ключи</a>.</p> 
keys[].<br>id | **string**<br><p>Идентификатор ресурса Key</p> 
keys[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
keys[].<br>description | **string**<br><p>Описание ресурса Key. Длина 0-256 символов.</p> 
keys[].<br>keyAlgorithm | **string**<br>Алгоритм, используемый для создания пары ключей ресурса Key.<br><ul> <li>RSA_2048: RSA с длиной ключа 2048 бит. Значение по умолчанию.</li> <li>RSA_4096: RSA с длиной ключа 4096 бит.</li> </ul> 
keys[].<br>publicKey | **string**<br><p>Закрытый ключ из ресурса Key.</p> 
keys[].<br>userAccountId | **string** <br>`keys[]` включает только одно из полей `userAccountId`, `serviceAccountId`<br><br><p>Идентификатор аккаунта пользователя, которому принадлежит ресурс Key.</p> 
keys[].<br>serviceAccountId | **string** <br>`keys[]` включает только одно из полей `userAccountId`, `serviceAccountId`<br><br><p>Идентификатор сервисного аккаунта, которому принадлежит ресурс Key.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/iam/api-ref/Key/list#query_params">pageSize</a>, используйте <a href="/docs/iam/api-ref/Key/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/iam/api-ref/Key/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/iam/api-ref/Key/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 