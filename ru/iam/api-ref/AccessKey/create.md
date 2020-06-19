---
editable: false
---

# Метод create
Создает ключ доступа для указанного сервисного аккаунта.
 

 
## HTTP-запрос {#https-request}
```
POST https://iam.api.cloud.yandex.net/iam/aws-compatibility/v1/accessKeys
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
serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта для создания ключа доступа. Чтобы получить идентификатор сервисного аккаунта, используйте запрос <a href="/docs/iam/api-ref/ServiceAccount/list">list</a>. Если параметр не указан, то используется идентификатор субъекта, который сделал запрос.</p> <p>Максимальная длина строки в символах — 50.</p> 
description | **string**<br><p>Описание ключа доступа.</p> <p>Максимальная длина строки в символах — 256.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "accessKey": {
    "id": "string",
    "serviceAccountId": "string",
    "createdAt": "string",
    "description": "string",
    "keyId": "string"
  },
  "secret": "string"
}
```

 
Поле | Описание
--- | ---
accessKey | **object**<br><p>Ресурс AccessKey.</p> <p>Ключ доступа. Дополнительные сведения см. в разделе <a href="/docs/iam/concepts/authorization/access-key">AWS-совместимые ключи доступа</a>.</p> 
accessKey.<br>id | **string**<br><p>Идентификатор ресурса AccessKey. Он используется для управления идентификатором ключа доступа и секретным ключом доступа.</p> 
accessKey.<br>serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, которому принадлежит ключ доступа.</p> 
accessKey.<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
accessKey.<br>description | **string**<br><p>Описание ключа доступа. Длина описания должна быть от 0 до 256 символов.</p> 
accessKey.<br>keyId | **string**<br><p>Идентификатор ключа доступа. Ключ совместим с сервисами AWS.</p> 
secret | **string**<br><p>Секретный ключ доступа. Ключ совместим с сервисами AWS.</p> 