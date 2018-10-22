# Метод get
Возвращает указанный ресурс AccessKey.
 
Чтобы получить список доступных ресурсов AccessKey, используйте
запрос [list](/docs/iam/api-ref/AccessKey/list).
 
## HTTP-запрос
`GET /iam/aws-compatibility/v1/accessKeys/{accessKeyId}`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
accessKeyId | Обязательное поле. Идентификатор запрашиваемого ресурса AccessKey. Чтобы получить идентификатор ключа доступа, используйте запрос [list](/docs/iam/api-ref/AccessKey/list).  Максимальная длина — 50 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс AccessKey — статический ключ доступа.
Используется для авторизации в HTTP API, совместимом с Amazon S3.
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор ресурса AccessKey. Используется для управления учетными данными: идентификатором ключа доступа и секретным ключом доступа.</p> 
serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, которому принадлежит ключ доступа.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
description | **string**<br><p>Описание ключа доступа. Длина описания должна быть от 0 до 256 символов.</p> 
keyId | **string**<br><p>Идентификатор ключа доступа. Ключ совместим с сервисами AWS.</p> 