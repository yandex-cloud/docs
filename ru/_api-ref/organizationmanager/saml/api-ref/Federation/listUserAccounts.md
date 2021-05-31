---
editable: false
---

# Метод listUserAccounts
Возвращает список пользователей для указанной федерации.
 

 
## HTTP-запрос {#https-request}
```
GET https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/federations/{federationId}:listUserAccounts
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
federationId | Обязательное поле. Идентификатор федерации для перечисления пользователей.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/organization-manager/api-ref/Federation/listUserAccounts#query_params) , сервис вернет значение [nextPageToken](/docs/organization-manager/api-ref/Federation/listUserAccounts#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/organization-manager/api-ref/Federation/listUserAccounts#query_params) равным значению поля [nextPageToken](/docs/organization-manager/api-ref/Federation/listUserAccounts#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "userAccounts": [
    {
      "id": "string",

      // `userAccounts[]` включает только одно из полей `yandexPassportUserAccount`, `samlUserAccount`
      "yandexPassportUserAccount": {
        "login": "string",
        "defaultEmail": "string"
      },
      "samlUserAccount": {
        "federationId": "string",
        "nameId": "string",
        "attributes": "object"
      },
      // конец списка возможных полей`userAccounts[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
userAccounts[] | **object**<br><p>В настоящее время представляет только <a href="/docs/iam/concepts/#passport">аккаунт Яндекс.Паспорта</a>.</p> 
userAccounts[].<br>id | **string**<br><p>Идентификатор аккаунта пользователя</p> 
userAccounts[].<br>yandexPassportUserAccount | **object**<br>Ресурс YandexPassportUserAccount. <br>`userAccounts[]` включает только одно из полей `yandexPassportUserAccount`, `samlUserAccount`<br><br><p>Ресурс YandexPassportUserAccount. Подробнее см. в разделе <a href="/docs/iam/concepts/#passport">Аккаунт Яндекс.Паспорта</a>.</p> 
userAccounts[].<br>yandexPassportUserAccount.<br>login | **string**<br><p>Логин аккаунта Яндекс.Паспорта.</p> 
userAccounts[].<br>yandexPassportUserAccount.<br>defaultEmail | **string**<br><p>Email используемый по умолчанию для пользователя с аккаунтом Яндекс.Паспорта.</p> 
userAccounts[].<br>samlUserAccount | **object**<br>Пользователь федерации. <br>`userAccounts[]` включает только одно из полей `yandexPassportUserAccount`, `samlUserAccount`<br><br><p>Пользователь федерации. Подробнее см. в разделе <a href="/docs/iam/concepts/users/saml-federations">SAML-совместимые федерации</a>.</p> 
userAccounts[].<br>samlUserAccount.<br>federationId | **string**<br><p>Обязательное поле. Идентификатор федерации, которой принадлежит пользователь.</p> <p>Максимальная длина строки в символах — 50.</p> 
userAccounts[].<br>samlUserAccount.<br>nameId | **string**<br><p>Обязательное поле. Идентификатор имени пользоваетля федерации. Идентификатор имени должен быть уникальным в федерации. Длина 1-256 символов.</p> <p>Длина строки в символах должна быть от 1 до 256.</p> 
userAccounts[].<br>samlUserAccount.<br>attributes | **object**<br><p>Дополнительные атрибуты пользователя.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/organization-manager/api-ref/Federation/listUserAccounts#query_params">pageSize</a>, используйте <a href="/docs/organization-manager/api-ref/Federation/listUserAccounts#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/organization-manager/api-ref/Federation/listUserAccounts#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/organization-manager/api-ref/Federation/listUserAccounts#responses">nextPageToken</a> для перебора страниц результатов.</p> 