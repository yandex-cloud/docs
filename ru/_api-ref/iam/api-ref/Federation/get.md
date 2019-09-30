---
editable: false
---

# Метод get
Возвращает указанный ресурс федерации.
 
Чтобы получить список доступных ресурсов федераций, используйте запрос [list](/docs/iam/api-ref/Federation/list).
 
## HTTP-запрос {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/saml/federations/{federationId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
federationId | Идентификатор возвращаемого ресурса федерации. Чтобы получить идентификатор федерации, используйте запрос [list](/docs/iam/api-ref/Federation/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
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
```
Ресурс федерация. Дополнительные сведения см. в разделе
[SAML-совместимые федерации](/docs/iam/concepts/users/saml-federations).
 
Поле | Описание
--- | ---
id | **string**<br><p>Обязательное поле. Идентификатор федерации.</p> <p>Максимальная длина строки в символах — 50.</p> 
folderId | **string**<br><p>Обязательное поле. Идентификатор каталога, которому принадлежит федерация.</p> <p>Максимальная длина строки в символах — 50.</p> 
name | **string**<br><p>Обязательное поле. Имя федерации. Имя должно быть уникальным в каталоге. Длина 3-63 символов.</p> <p>Значение должно соответствовать регулярному выражению <code>\|[a-z][-a-z0-9]{1,61}[a-z0-9]</code>.</p> 
description | **string**<br><p>Описание федерации. Длина описания должна быть от 0 до 256 символов.</p> <p>Максимальная длина строки в символах — 256.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
cookieMaxAge | **string**<br><p>Максимальное время жизни токена 'IAM_COOKIE'. Должно быть в интервале от 10 min до 12 часов. Значение по умолчанию: 8 часов.</p> <p>Допустимые значения — от 600 seconds до 43200 seconds включительно.</p> 
autoCreateAccountOnLogin | **boolean** (boolean)<br><p>Автоматически создавать аккаунты для новых пользователей после успешной аутентификации.</p> 
issuer | **string**<br><p>Обязательное поле. Идентификатор IdP-сервера (entity Id).</p> <p>Максимальная длина строки в символах — 8000.</p> 
ssoBinding | **string**<br><p>Тип привязки IdP.</p> <p>Привязка SAML — это отображение сообщения протокола SAML на стандартные форматы сообщений и / или протоколы связи.</p> <ul> <li>BINDING_TYPE_UNSPECIFIED: Не указано.</li> <li>POST: Привязка HTTP POST.</li> <li>REDIRECT: Привязка перенаправлением HTTP.</li> <li>ARTIFACT: Привязка артифактом HTTP.</li> </ul> 
ssoUrl | **string**<br><p>Обязательное поле. Ссылка на страницу для входа в IdP.</p> <p>Максимальная длина строки в символах — 8000.</p> 