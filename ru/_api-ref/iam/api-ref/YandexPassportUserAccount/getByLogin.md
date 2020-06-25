---
editable: false
---

# Метод getByLogin
Возвращает указанный ресурс YandexPassportUserAccount.
 

 
## HTTP-запрос {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/yandexPassportUserAccounts:byLogin
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
login | Обязательное поле. Логин для запрашиваемого ресурса YandexPassportUserAccount.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",

  //  включает только одно из полей `yandexPassportUserAccount`, `samlUserAccount`
  "yandexPassportUserAccount": {
    "login": "string",
    "defaultEmail": "string"
  },
  "samlUserAccount": {
    "federationId": "string",
    "nameId": "string",
    "attributes": "object"
  },
  // конец списка возможных полей

}
```
В настоящее время представляет только [аккаунт Яндекс.Паспорта](/docs/iam/concepts/#passport).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор аккаунта пользователя</p> 
yandexPassportUserAccount | **object**<br>Ресурс YandexPassportUserAccount. <br> включает только одно из полей `yandexPassportUserAccount`, `samlUserAccount`<br><br><p>Ресурс YandexPassportUserAccount. Подробнее см. в разделе <a href="/docs/iam/concepts/#passport">Аккаунт Яндекс.Паспорта</a>.</p> 
yandexPassportUserAccount.<br>login | **string**<br><p>Логин аккаунта Яндекс.Паспорта.</p> 
yandexPassportUserAccount.<br>defaultEmail | **string**<br><p>Email используемый по умолчанию для пользователя с аккаунтом Яндекс.Паспорта.</p> 
samlUserAccount | **object**<br>Пользователь федерации. <br> включает только одно из полей `yandexPassportUserAccount`, `samlUserAccount`<br><br><p>Пользователь федерации. Подробнее см. в разделе <a href="/docs/iam/concepts/users/saml-federations">SAML-совместимые федерации</a>.</p> 
samlUserAccount.<br>federationId | **string**<br><p>Обязательное поле. Идентификатор федерации, которой принадлежит пользователь.</p> <p>Максимальная длина строки в символах — 50.</p> 
samlUserAccount.<br>nameId | **string**<br><p>Обязательное поле. Идентификатор имени пользоваетля федерации. Идентификатор имени должен быть уникальным в федерации. Длина 1-256 символов.</p> <p>Длина строки в символах должна быть от 1 до 256.</p> 
samlUserAccount.<br>attributes | **object**<br><p>Дополнительные атрибуты пользователя.</p> 