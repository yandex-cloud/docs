---
editable: false
---

# Метод create
Создает API-ключ для указанного сервисного аккаунта.
 

 
## HTTP-запрос {#https-request}
```
POST https://iam.api.cloud.yandex.net/iam/v1/apiKeys
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "serviceAccountId": "string",
  "description": "string"
}
```

 
Поле | Описание
--- | ---
serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта для создания API-ключа. Чтобы получить идентификатор сервисного аккаунта, используйте запрос <a href="/docs/iam/api-ref/ServiceAccount/list">list</a>. Если параметр не указан, то используется идентификатор субъекта, который сделал запрос.</p> <p>Максимальная длина строки в символах — 50.</p> 
description | **string**<br><p>Описание API-ключа.</p> <p>Максимальная длина строки в символах — 256.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "apiKey": {
    "id": "string",
    "serviceAccountId": "string",
    "createdAt": "string",
    "description": "string"
  },
  "secret": "string"
}
```

 
Поле | Описание
--- | ---
apiKey | **object**<br><p>Ресурс ApiKey.</p> <p>Ресурс ApiKey.</p> 
apiKey.<br>id | **string**<br><p>Идентификатор API-ключа.</p> 
apiKey.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, которому принадлежит API-ключ.</p> 
apiKey.<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
apiKey.<br>description | **string**<br><p>Описание API-ключа. Длина описания должна быть от 0 до 256 символов.</p> 
secret | **string**<br><p>Секретная часть API-ключа. Этот секретный ключ можно использовать для аутентификации при запросах.</p> 