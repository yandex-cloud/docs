---
editable: false
---

# Метод list
Возвращает список федераций в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/federations
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
organizationId | Обязательное поле. Идентификатор организации, для которого запрашивается список федераций. Чтобы получить идентификатор организации, используйте запрос [list](/docs/organization-manager/api-ref/Organization/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/organization-manager/api-ref/Federation/list#query_params), сервис вернет значение [nextPageToken](/docs/organization-manager/api-ref/Federation/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/organization-manager/api-ref/Federation/list#query_params) равным значению поля [nextPageToken](/docs/organization-manager/api-ref/Federation/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 50.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Federation.name](/docs/organization-manager/api-ref/Federation#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "federations": [
    {
      "id": "string",
      "organizationId": "string",
      "name": "string",
      "description": "string",
      "createdAt": "string",
      "cookieMaxAge": "string",
      "autoCreateAccountOnLogin": true,
      "issuer": "string",
      "ssoBinding": "string",
      "ssoUrl": "string",
      "securitySettings": {
        "encryptedAssertions": true
      },
      "caseInsensitiveNameIds": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
federations[] | **object**<br><p>Федерация. Дополнительные сведения см. в разделе <a href="/docs/iam/concepts/users/identity-federations">SAML-совместимые федерации удостоверений</a>.</p> 
federations[].<br>id | **string**<br><p>Обязательное поле. Идентификатор федерации.</p> <p>Максимальная длина строки в символах — 50.</p> 
federations[].<br>organizationId | **string**<br><p>Идентификатор организации, которому принадлежит федерация.</p> 
federations[].<br>name | **string**<br><p>Обязательное поле. Имя федерации.</p> <p>Значение должно соответствовать регулярному выражению `` \|[a-z][-a-z0-9]{1,61}[a-z0-9] ``.</p> 
federations[].<br>description | **string**<br><p>Описание федерации.</p> <p>Максимальная длина строки в символах — 256.</p> 
federations[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
federations[].<br>cookieMaxAge | **string**<br><p>Время жизни файлов cookie в браузере в секундах. Если время жизни cookie не истекло, то консоль управления сразу аутентифицирует пользователя и отправляет на главную страницу.</p> <p>Допустимые значения — от 600 seconds до 43200 seconds включительно.</p> 
federations[].<br>autoCreateAccountOnLogin | **boolean** (boolean)<br><p>Добавлять новых пользователей автоматически при успешной аутентификации. Пользователи становится членами организации автоматически, но остальные роли надо будет назначить самостоятельно.</p> <p>Если значение `false` , то пользователь, которого не добавили в облако, не сможет войти, даже если пройдет аутентификацию на вашем сервере.</p> 
federations[].<br>issuer | **string**<br><p>Обязательное поле. Идентификатор IdP-сервера, который будет использоваться для аутентификации. Этот же идентификатор сервер IdP указывает в ответе после того, как пользователь проходит аутентификацию.</p> <p>Максимальная длина строки в символах — 8000.</p> 
federations[].<br>ssoBinding | **string**<br><p>Тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.</p> <p>Привязка — это отображение сообщения протокола SAML на стандартные форматы сообщений и / или протоколы связи.</p> <ul> <li>POST: Привязка HTTP POST.</li> <li>REDIRECT: Привязка перенаправлением HTTP.</li> <li>ARTIFACT: Привязка артефактом HTTP.</li> </ul> 
federations[].<br>ssoUrl | **string**<br><p>Обязательное поле. URL для Single sign-on. Укажите здесь ссылку на страницу для входа в IdP.</p> <p>Максимальная длина строки в символах — 8000.</p> 
federations[].<br>securitySettings | **object**<br><p>Настройки безопасности федерации.</p> <p>Настройки безопасности федерации.</p> 
federations[].<br>securitySettings.<br>encryptedAssertions | **boolean** (boolean)<br><p>Включить шифрование утверждений.</p> 
federations[].<br>caseInsensitiveNameIds | **boolean** (boolean)<br><p>Использовать нечувствительные к регистру Name ID пользователей.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/organization-manager/api-ref/Federation/list#query_params">pageSize</a>, используйте <a href="/docs/organization-manager/api-ref/Federation/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/organization-manager/api-ref/Federation/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/organization-manager/api-ref/Federation/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 