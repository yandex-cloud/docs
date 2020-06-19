---
editable: false
---

# Метод get
Возвращает указанный ресурс Key.
 
Чтобы получить список доступных ресурсов Key, используйте запрос [list](/docs/iam/api-ref/Key/list).
 
## HTTP-запрос {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/keys/{keyId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
keyId | Обязательное поле. Идентификатор возвращаемого ресурса Key. Чтобы получить идентификатор, используйте запрос [list](/docs/iam/api-ref/Key/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
format | Формат ключа.<ul> <li>PEM_FILE: Формат Privacy-Enhanced Mail (PEM). Значение по умолчанию.</li> </ul> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "createdAt": "string",
  "description": "string",
  "keyAlgorithm": "string",
  "publicKey": "string",

  //  включает только одно из полей `userAccountId`, `serviceAccountId`
  "userAccountId": "string",
  "serviceAccountId": "string",
  // конец списка возможных полей

}
```
Ресурс Key. Подробнее см. в разделе [Авторизованные ключи](/docs/iam/concepts/authorization/key).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор ресурса Key</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
description | **string**<br><p>Описание ресурса Key. Длина 0-256 символов.</p> 
keyAlgorithm | **string**<br>Алгоритм, используемый для создания пары ключей ресурса Key.<br><ul> <li>RSA_2048: RSA с длиной ключа 2048 бит. Значение по умолчанию.</li> <li>RSA_4096: RSA с длиной ключа 4096 бит.</li> </ul> 
publicKey | **string**<br><p>Закрытый ключ из ресурса Key.</p> 
userAccountId | **string** <br> включает только одно из полей `userAccountId`, `serviceAccountId`<br><br><p>Идентификатор аккаунта пользователя, которому принадлежит ресурс Key.</p> 
serviceAccountId | **string** <br> включает только одно из полей `userAccountId`, `serviceAccountId`<br><br><p>Идентификатор сервисного аккаунта, которому принадлежит ресурс Key.</p> 