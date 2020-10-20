---
editable: false
---

# UserAccountService

Набор методов управления пользовательскими аккаунтами. Сейчас используется только 
для [аккаунтов Яндекс.Паспорта](/docs/iam/concepts/#passport).

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс UserAccount. |

## Вызовы UserAccountService {#calls}

## Get {#Get}

Возвращает указанный ресурс UserAccount.

**rpc Get ([GetUserAccountRequest](#GetUserAccountRequest)) returns ([UserAccount](#UserAccount))**

### GetUserAccountRequest {#GetUserAccountRequest}

Поле | Описание
--- | ---
user_account_id | **string**<br>Обязательное поле. Идентификатор запрашиваемого ресурса UserAccount. Максимальная длина строки в символах — 50.


### UserAccount {#UserAccount}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор аккаунта пользователя 
user_account | **oneof:** `yandex_passport_user_account` или `saml_user_account`<br>
&nbsp;&nbsp;yandex_passport_user_account | **[YandexPassportUserAccount](#YandexPassportUserAccount)**<br>Ресурс YandexPassportUserAccount. 
&nbsp;&nbsp;saml_user_account | **[SamlUserAccount](#SamlUserAccount)**<br>Пользователь федерации. 


### YandexPassportUserAccount {#YandexPassportUserAccount}

Поле | Описание
--- | ---
login | **string**<br>Логин аккаунта Яндекс.Паспорта. 
default_email | **string**<br>Email используемый по умолчанию для пользователя с аккаунтом Яндекс.Паспорта. 


### SamlUserAccount {#SamlUserAccount}

Поле | Описание
--- | ---
federation_id | **string**<br>Обязательное поле. Идентификатор федерации, которой принадлежит пользователь. Максимальная длина строки в символах — 50.
name_id | **string**<br>Обязательное поле. Идентификатор имени пользоваетля федерации. Идентификатор имени должен быть уникальным в федерации. Длина 1-256 символов. Длина строки в символах должна быть от 1 до 256.
attributes | **map<string,Attribute>**<br>Дополнительные атрибуты пользователя. 


### Attribute {#Attribute}

Поле | Описание
--- | ---
value[] | **string**<br> 


