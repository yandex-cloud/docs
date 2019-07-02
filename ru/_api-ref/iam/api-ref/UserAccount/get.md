---
editable: false
---

# Метод get
Возвращает указанный ресурс UserAccount.
 

 
## HTTP-запрос {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/userAccounts/{userAccountId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
userAccountId | Обязательное поле. Идентификатор запрашиваемого ресурса UserAccount.  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "yandexPassportUserAccount": {
    "login": "string",
    "defaultEmail": "string"
  }
}
```
В настоящее время представляет только [аккаунт Яндекс.Паспорта](/docs/iam/concepts/#passport).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор аккаунта пользователя</p> 
yandexPassportUserAccount | **object**<br>Ресурс YandexPassportUserAccount.<br><p>Ресурс YandexPassportUserAccount. Подробнее см. в разделе <a href="/docs/iam/concepts/#passport">Аккаунт Яндекс.Паспорта</a>.</p> 
yandexPassportUserAccount.<br>login | **string**<br><p>Логин аккаунта Яндекс.Паспорта.</p> 
yandexPassportUserAccount.<br>defaultEmail | **string**<br><p>Email используемый по умолчанию для пользователя с аккаунтом Яндекс.Паспорта.</p> 