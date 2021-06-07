---
editable: false
---

# Метод update
Изменяет указанную федерацию.
 

 
## HTTP-запрос {#https-request}
```
PATCH https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/federations/{federationId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
federationId | Идентификатор федерации для обновления. Чтобы получить идентификатор федерации, используйте запрос [list](/docs/organization-manager/api-ref/Federation/list).  Максимальная длина строки в символах — 50.
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
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

 
Поле | Описание
--- | ---
updateMask | **string**<br><p>Маска, определяющая, какие поля указанной федерации будут обновлены.</p> <p>Имена всех обновляемых полей, разделенные запятыми. Только значения указанных полей будут изменены. Остальные останутся нетронутыми. Если поле указано в параметре ``updateMask`` и в запросе не было отправлено значение для этого поля, значение поля будет сброшено на значение по умолчанию. Значение по умолчанию для большинства полей — null или 0.</p> <p>Если в запросе не передается ``updateMask``, значения всех полей будут обновлены. Для полей, указанных в запросе, будут использованы переданные значения. Значения остальных полей будут сброшены на значения по умолчанию.</p> 
name | **string**<br><p>Название федерации. Имя должно быть уникальным в облаке.</p> <p>Значение должно соответствовать регулярному выражению ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
description | **string**<br><p>Описание федерации.</p> <p>Максимальная длина строки в символах — 256.</p> 
cookieMaxAge | **string**<br><p>Время жизни файлов cookie в браузере в секундах. Если время жизни cookie не истекло, то консоль управления сразу аутентифицирует пользователя и отправляет на главную страницу. Значение по умолчанию — ``8h``.</p> <p>Допустимые значения — от 600 seconds до 43200 seconds включительно.</p> 
autoCreateAccountOnLogin | **boolean** (boolean)<br><p>Добавлять новых пользователей автоматически при успешной аутентификации. Пользователи становится членами организации автоматически, но остальные роли надо будет назначить самостоятельно.</p> <p>Если значение ``false`` , то пользователь, которого не добавили в облако, не сможет войти, даже если пройдет аутентификацию на вашем сервере.</p> 
issuer | **string**<br><p>Обязательное поле. Идентификатор IdP-сервера, который будет использоваться для аутентификации. Этот же идентификатор сервер IdP указывает в ответе после того, как пользователь проходит аутентификацию.</p> <p>Максимальная длина строки в символах — 8000.</p> 
ssoBinding | **string**<br><p>Тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки ``POST``.</p> <p>Привязка — это отображение сообщения протокола SAML на стандартные форматы сообщений и / или протоколы связи.</p> <ul> <li>POST: Привязка HTTP POST.</li> <li>REDIRECT: Привязка перенаправлением HTTP.</li> <li>ARTIFACT: Привязка артефактом HTTP.</li> </ul> 
ssoUrl | **string**<br><p>Обязательное поле. URL для Single sign-on. Укажите здесь ссылку на страницу для входа в IdP.</p> <p>Максимальная длина строки в символах — 8000.</p> 
securitySettings | **object**<br><p>Настройки безопасности федерации.</p> <p>Настройки безопасности федерации.</p> 
securitySettings.<br>encryptedAssertions | **boolean** (boolean)<br><p>Включить шифрование утверждений.</p> 
caseInsensitiveNameIds | **boolean** (boolean)<br><p>Использовать нечувствительные к регистру Name ID пользователей.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  включает только одно из полей `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // конец списка возможных полей

}
```
Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор операции.</p> 
description | **string**<br><p>Описание операции. Длина описания должна быть от 0 до 256 символов.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
createdBy | **string**<br><p>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.</p> 
modifiedAt | **string** (date-time)<br><p>Время, когда ресурс Operation последний раз обновлялся. Значение в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
done | **boolean** (boolean)<br><p>Если значение равно ``false`` — операция еще выполняется. Если ``true`` — операция завершена, и задано значение одного из полей ``error`` или ``response``.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля ``metadata``.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля ``response``.</p> 