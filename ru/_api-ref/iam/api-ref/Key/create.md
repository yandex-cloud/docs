---
editable: false
---

# Метод create
Создает пару ключей для указанного сервисного аккаунта.
 

 
## HTTP-запрос {#https-request}
```
POST https://iam.api.cloud.yandex.net/iam/v1/keys
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "serviceAccountId": "string",
  "description": "string",
  "format": "string",
  "keyAlgorithm": "string"
}
```

 
Поле | Описание
--- | ---
serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта для создания пары ключей. Чтобы получить идентификатор сервисного аккаунта, используйте запрос <a href="/docs/iam/api-ref/ServiceAccount/list">list</a>. Если параметр не указан, то используется идентификатор субъекта, который сделал запрос.</p> <p>Максимальная длина строки в символах — 50.</p> 
description | **string**<br><p>Описание пары ключей.</p> <p>Максимальная длина строки в символах — 256.</p> 
format | **string**<br><p>Формат ключа.</p> <ul> <li>PEM_FILE: Формат Privacy-Enhanced Mail (PEM). Значение по умолчанию.</li> </ul> 
keyAlgorithm | **string**<br><p>Алгоритм, используемый для создания пары ключей ресурса Key.</p> <ul> <li>RSA_2048: RSA с длиной ключа 2048 бит. Значение по умолчанию.</li> <li>RSA_4096: RSA с длиной ключа 4096 бит.</li> </ul> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "key": {
    "id": "string",
    "createdAt": "string",
    "description": "string",
    "keyAlgorithm": "string",
    "publicKey": "string",

    // `key` включает только одно из полей `userAccountId`, `serviceAccountId`
    "userAccountId": "string",
    "serviceAccountId": "string",
    // конец списка возможных полей`key`

  },
  "privateKey": "string"
}
```

 
Поле | Описание
--- | ---
key | **object**<br><p>Ресурс Key.</p> <p>Ресурс Key. Подробнее см. в разделе <a href="/docs/iam/concepts/authorization/key">Авторизованные ключи</a>.</p> 
key.<br>id | **string**<br><p>Идентификатор ресурса Key</p> 
key.<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
key.<br>description | **string**<br><p>Описание ресурса Key. Длина 0-256 символов.</p> 
key.<br>keyAlgorithm | **string**<br>Алгоритм, используемый для создания пары ключей ресурса Key.<br><ul> <li>RSA_2048: RSA с длиной ключа 2048 бит. Значение по умолчанию.</li> <li>RSA_4096: RSA с длиной ключа 4096 бит.</li> </ul> 
key.<br>publicKey | **string**<br><p>Закрытый ключ из ресурса Key.</p> 
key.<br>userAccountId | **string** <br>`key` включает только одно из полей `userAccountId`, `serviceAccountId`<br><br><p>Идентификатор аккаунта пользователя, которому принадлежит ресурс Key.</p> 
key.<br>serviceAccountId | **string** <br>`key` включает только одно из полей `userAccountId`, `serviceAccountId`<br><br><p>Идентификатор сервисного аккаунта, которому принадлежит ресурс Key.</p> 
privateKey | **string**<br><p>Закрытый ключ из ресурса Key. Этот ключ должен храниться в надежном месте.</p> 