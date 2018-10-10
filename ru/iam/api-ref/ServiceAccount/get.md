# Метод get
Возвращает указанный ресурс ServiceAccount.
 
Чтобы получить список доступных ресурсов ServiceAccount, используйте
запрос [list](/docs/iam/api-ref/ServiceAccount/list).
 
## HTTP-запрос
`GET /iam/v1/serviceAccounts/{serviceAccountId}`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
serviceAccountId | Обязательное поле. Идентификатор возвращаемого ресурса ServiceAccount. Чтобы получить идентификатор сервисного аккаунта, используйте запрос [list](/docs/iam/api-ref/ServiceAccount/list).  Максимальная длина — 50 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс ServiceAccount. Дополнительные сведения см. в разделе [Сервисные
аккаунты](/docs/iam/concepts/users/service-accounts).
 
Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор сервисного аккаунта.
folderId | **string**<br>Идентификатор каталога, которому принадлежит сервисный аккаунт.
createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
name | **string**<br>Имя сервисного аккаунта. Имя должно быть уникальным в облаке. Длина имени должна быть от 3 до 63 символов.
description | **string**<br>Описание сервисного аккаунта. Длина описания должна быть от 0 до 256 символов.