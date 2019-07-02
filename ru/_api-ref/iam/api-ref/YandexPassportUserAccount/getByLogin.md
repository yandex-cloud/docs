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