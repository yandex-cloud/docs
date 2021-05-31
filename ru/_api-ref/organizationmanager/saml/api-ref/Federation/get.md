---
editable: false
---

# Метод get
Возвращает указанную федерацию.
 
Чтобы получить список доступных федераций, используйте запрос [list](/docs/organization-manager/api-ref/Federation/list).
 
## HTTP-запрос {#https-request}
```
GET https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/federations/{federationId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
federationId | Идентификатор возвращаемой федерации. Чтобы получить идентификатор федерации, используйте запрос [list](/docs/organization-manager/api-ref/Federation/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
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
```
Федерация. Дополнительные сведения см. в разделе [SAML-совместимые федерации удостоверений](/docs/iam/concepts/users/identity-federations).
 
Поле | Описание
--- | ---
id | **string**<br><p>Обязательное поле. Идентификатор федерации.</p> <p>Максимальная длина строки в символах — 50.</p> 
organizationId | **string**<br><p>Идентификатор организации, которому принадлежит федерация.</p> 
name | **string**<br><p>Обязательное поле. Имя федерации.</p> <p>Значение должно соответствовать регулярному выражению `` \|[a-z][-a-z0-9]{1,61}[a-z0-9] ``.</p> 
description | **string**<br><p>Описание федерации.</p> <p>Максимальная длина строки в символах — 256.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
cookieMaxAge | **string**<br><p>Время жизни файлов cookie в браузере в секундах. Если время жизни cookie не истекло, то консоль управления сразу аутентифицирует пользователя и отправляет на главную страницу.</p> <p>Допустимые значения — от 600 seconds до 43200 seconds включительно.</p> 
autoCreateAccountOnLogin | **boolean** (boolean)<br><p>Добавлять новых пользователей автоматически при успешной аутентификации. Пользователи становится членами организации автоматически, но остальные роли надо будет назначить самостоятельно.</p> <p>Если значение `false` , то пользователь, которого не добавили в облако, не сможет войти, даже если пройдет аутентификацию на вашем сервере.</p> 
issuer | **string**<br><p>Обязательное поле. Идентификатор IdP-сервера, который будет использоваться для аутентификации. Этот же идентификатор сервер IdP указывает в ответе после того, как пользователь проходит аутентификацию.</p> <p>Максимальная длина строки в символах — 8000.</p> 
ssoBinding | **string**<br><p>Тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.</p> <p>Привязка — это отображение сообщения протокола SAML на стандартные форматы сообщений и / или протоколы связи.</p> <ul> <li>POST: Привязка HTTP POST.</li> <li>REDIRECT: Привязка перенаправлением HTTP.</li> <li>ARTIFACT: Привязка артефактом HTTP.</li> </ul> 
ssoUrl | **string**<br><p>Обязательное поле. URL для Single sign-on. Укажите здесь ссылку на страницу для входа в IdP.</p> <p>Максимальная длина строки в символах — 8000.</p> 
securitySettings | **object**<br><p>Настройки безопасности федерации.</p> <p>Настройки безопасности федерации.</p> 
securitySettings.<br>encryptedAssertions | **boolean** (boolean)<br><p>Включить шифрование утверждений.</p> 
caseInsensitiveNameIds | **boolean** (boolean)<br><p>Использовать нечувствительные к регистру Name ID пользователей.</p> 