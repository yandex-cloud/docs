---
editable: false
---

# Метод get
Возвращает указанный ресурс ServiceAccount.
 
Чтобы получить список доступных ресурсов ServiceAccount, используйте запрос [list](/docs/iam/api-ref/ServiceAccount/list).
 
## HTTP-запрос {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts/{serviceAccountId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
serviceAccountId | Обязательное поле. Идентификатор возвращаемого ресурса ServiceAccount. Чтобы получить идентификатор сервисного аккаунта, используйте запрос [list](/docs/iam/api-ref/ServiceAccount/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string"
}
```
Ресурс ServiceAccount. Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор сервисного аккаунта.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит сервисный аккаунт.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя сервисного аккаунта. Имя должно быть уникальным в облаке. Длина 3-63 символов.</p> 
description | **string**<br><p>Описание сервисного аккаунта. Длина описания должна быть от 0 до 256 символов.</p> 