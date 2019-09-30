---
editable: false
---

# Метод list
Возвращает список доступных ресурсов федераций в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/saml/federations
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
cloudId | Идентификатор облака для получения списка сервисных аккаунтов. Чтобы получить идентификатор облака, используйте запрос [list](/docs/resource-manager/api-ref/Cloud/list).  Максимальная длина строки в символах — 50.
folderId | Идентификатор каталога для получения списка сервисных аккаунтов. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/iam/api-ref/Federation/list#query_params), сервис вернет значение [nextPageToken](/docs/iam/api-ref/Federation/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/iam/api-ref/Federation/list#query_params) равным значению поля [nextPageToken](/docs/iam/api-ref/Federation/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 50.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Federation.name](/docs/iam/api-ref/Federation#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением    `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "federations": [
    {
      "id": "string",
      "folderId": "string",
      "name": "string",
      "description": "string",
      "createdAt": "string",
      "cookieMaxAge": "string",
      "autoCreateAccountOnLogin": true,
      "issuer": "string",
      "ssoBinding": "string",
      "ssoUrl": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
federations[] | **object**<br><p>Ресурс федерация. Дополнительные сведения см. в разделе <a href="/docs/iam/concepts/users/saml-federations">SAML-совместимые федерации</a>.</p> 
federations[].<br>id | **string**<br><p>Обязательное поле. Идентификатор федерации.</p> <p>Максимальная длина строки в символах — 50.</p> 
federations[].<br>folderId | **string**<br><p>Обязательное поле. Идентификатор каталога, которому принадлежит федерация.</p> <p>Максимальная длина строки в символах — 50.</p> 
federations[].<br>name | **string**<br><p>Обязательное поле. Имя федерации. Имя должно быть уникальным в каталоге. Длина 3-63 символов.</p> <p>Значение должно соответствовать регулярному выражению <code>\|[a-z][-a-z0-9]{1,61}[a-z0-9]</code>.</p> 
federations[].<br>description | **string**<br><p>Описание федерации. Длина описания должна быть от 0 до 256 символов.</p> <p>Максимальная длина строки в символах — 256.</p> 
federations[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
federations[].<br>cookieMaxAge | **string**<br><p>Максимальное время жизни токена 'IAM_COOKIE'. Должно быть в интервале от 10 min до 12 часов. Значение по умолчанию: 8 часов.</p> <p>Допустимые значения — от 600 seconds до 43200 seconds включительно.</p> 
federations[].<br>autoCreateAccountOnLogin | **boolean** (boolean)<br><p>Автоматически создавать аккаунты для новых пользователей после успешной аутентификации.</p> 
federations[].<br>issuer | **string**<br><p>Обязательное поле. Идентификатор IdP-сервера (entity Id).</p> <p>Максимальная длина строки в символах — 8000.</p> 
federations[].<br>ssoBinding | **string**<br><p>Тип привязки IdP.</p> <p>Привязка SAML — это отображение сообщения протокола SAML на стандартные форматы сообщений и / или протоколы связи.</p> <ul> <li>BINDING_TYPE_UNSPECIFIED: Не указано.</li> <li>POST: Привязка HTTP POST.</li> <li>REDIRECT: Привязка перенаправлением HTTP.</li> <li>ARTIFACT: Привязка артифактом HTTP.</li> </ul> 
federations[].<br>ssoUrl | **string**<br><p>Обязательное поле. Ссылка на страницу для входа в IdP.</p> <p>Максимальная длина строки в символах — 8000.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/iam/api-ref/Federation/list#query_params">pageSize</a>, используйте <a href="/docs/iam/api-ref/Federation/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/iam/api-ref/Federation/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/iam/api-ref/Federation/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 