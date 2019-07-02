---
editable: false
---

# Метод get
Возвращает указанный ключ доступа.
 
Чтобы получить список доступных ключей доступа, используйте запрос [list](/docs/iam/api-ref/AccessKey/list).
 
## HTTP-запрос {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/aws-compatibility/v1/accessKeys/{accessKeyId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
accessKeyId | Обязательное поле. Идентификатор запрашиваемого ресурса AccessKey. Чтобы получить идентификатор ключа доступа, используйте запрос [list](/docs/iam/api-ref/AccessKey/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "serviceAccountId": "string",
  "createdAt": "string",
  "description": "string",
  "keyId": "string"
}
```
Ключ доступа. Дополнительные сведения см. в разделе [AWS-совместимые ключи доступа](/docs/iam/concepts/authorization/access-key).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор ресурса AccessKey. Он используется для управления идентификатором ключа доступа и секретным ключом доступа.</p> 
serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, которому принадлежит ключ доступа.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
description | **string**<br><p>Описание ключа доступа. Длина описания должна быть от 0 до 256 символов.</p> 
keyId | **string**<br><p>Идентификатор ключа доступа. Ключ совместим с сервисами AWS.</p> 