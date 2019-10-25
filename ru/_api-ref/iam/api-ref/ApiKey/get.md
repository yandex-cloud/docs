---
editable: false
---

# Метод get
Возвращает указанный API-ключ.
 
Чтобы получить список доступных API-ключ, используйте запрос [list](/docs/iam/api-ref/ApiKey/list).
 
## HTTP-запрос {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/apiKeys/{apiKeyId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
apiKeyId | Обязательное поле. Идентификатор возвращаемого API-ключа. Чтобы получить идентификатор ключа, используйте запрос [list](/docs/iam/api-ref/ApiKey/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "serviceAccountId": "string",
  "createdAt": "string",
  "description": "string"
}
```
Ресурс ApiKey.
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор API-ключа.</p> 
serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, которому принадлежит API-ключ.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
description | **string**<br><p>Описание API-ключа. Длина описания должна быть от 0 до 256 символов.</p> 