---
editable: false
---

# UserAccount
Набор методов управления пользовательскими аккаунтами. Сейчас используется только
для [аккаунтов Яндекс.Паспорта](/docs/iam/concepts/#passport).
## JSON-представление {#representation}
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
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор аккаунта пользователя</p> 
yandexPassportUserAccount | **object** <br> включает только одно из полей `yandexPassportUserAccount`, `samlUserAccount`<br><br><p>Ресурс YandexPassportUserAccount. Подробнее см. в разделе <a href="/docs/iam/concepts/#passport">Аккаунт Яндекс.Паспорта</a>.</p> 
yandexPassportUserAccount.<br>login | **string**<br><p>Логин аккаунта Яндекс.Паспорта.</p> 
yandexPassportUserAccount.<br>defaultEmail | **string**<br><p>Email используемый по умолчанию для пользователя с аккаунтом Яндекс.Паспорта.</p> 
samlUserAccount | **object** <br> включает только одно из полей `yandexPassportUserAccount`, `samlUserAccount`<br><br><p>Пользователь федерации. Подробнее см. в разделе <a href="/docs/iam/concepts/users/saml-federations">SAML-совместимые федерации</a>.</p> 
samlUserAccount.<br>federationId | **string**<br><p>Обязательное поле. Идентификатор федерации, которой принадлежит пользователь.</p> <p>Максимальная длина строки в символах — 50.</p> 
samlUserAccount.<br>nameId | **string**<br><p>Обязательное поле. Идентификатор имени пользоваетля федерации. Идентификатор имени должен быть уникальным в федерации. Длина 1-256 символов.</p> <p>Длина строки в символах должна быть от 1 до 256.</p> 
samlUserAccount.<br>attributes | **object**<br><p>Дополнительные атрибуты пользователя.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[get](get.md) | Возвращает указанный ресурс UserAccount.