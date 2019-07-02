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
  "yandexPassportUserAccount": {
    "login": "string",
    "defaultEmail": "string"
  }
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор аккаунта пользователя</p> 
yandexPassportUserAccount | **object**<br><p>Ресурс YandexPassportUserAccount. Подробнее см. в разделе <a href="/docs/iam/concepts/#passport">Аккаунт Яндекс.Паспорта</a>.</p> 
yandexPassportUserAccount.<br>login | **string**<br><p>Логин аккаунта Яндекс.Паспорта.</p> 
yandexPassportUserAccount.<br>defaultEmail | **string**<br><p>Email используемый по умолчанию для пользователя с аккаунтом Яндекс.Паспорта.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[get](get.md) | Возвращает указанный ресурс UserAccount.