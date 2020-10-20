---
editable: false
---

# YandexPassportUserAccountService

Набор методов для управления ресурсами YandexPassportUserAccount.

| Вызов | Описание |
| --- | --- |
| [GetByLogin](#GetByLogin) | Возвращает указанный ресурс YandexPassportUserAccount. |

## Вызовы YandexPassportUserAccountService {#calls}

## GetByLogin {#GetByLogin}

Возвращает указанный ресурс YandexPassportUserAccount.

**rpc GetByLogin ([GetUserAccountByLoginRequest](#GetUserAccountByLoginRequest)) returns ([UserAccount](#UserAccount))**

### GetUserAccountByLoginRequest {#GetUserAccountByLoginRequest}

Поле | Описание
--- | ---
login | **string**<br>Обязательное поле. Логин для запрашиваемого ресурса YandexPassportUserAccount. 


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


