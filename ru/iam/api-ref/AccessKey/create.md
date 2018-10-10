# Метод create
Создает ключ доступа для указанного сервисного аккаунта.
 

 
## HTTP-запрос
`POST /iam/aws-compatibility/v1/accessKeys`
 
## Параметры в теле запроса {#body_params}
 
```json 
 {
  "serviceAccountId": "string",
  "description": "string"
}
```

 
Поле | Описание
--- | ---
serviceAccountId | **string**<br>Идентификатор сервисного аккаунта для которого создается ключ доступа. Чтобы получить идентификатор сервисного аккаунта, используйте запрос [list](/docs/iam/api-ref/ServiceAccount/list). Если [serviceAccountId](/docs/iam/api-ref/AccessKey/create#body_params) не указан, то используется идентификатор субъекта, который сделал запрос.  Максимальная длина — 50 символов.
description | **string**<br>Описание ключа доступа. Длина описания должна быть от 0 до 256 символов.  Максимальная длина — 256 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
accessKey | **object**<br>Ресурс AccessKey.  Ресурс AccessKey — статический ключ доступа. Используется для авторизации в HTTP API, совместимом с Amazon S3.
accessKey.<br>id | **string**<br>Только для вывода. Идентификатор ресурса AccessKey. Используется для управления учетными данными: идентификатором ключа доступа и секретным ключом доступа.
accessKey.<br>serviceAccountId | **string**<br>Идентификатор сервисного аккаунта, которому принадлежит ключ доступа.
accessKey.<br>createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
accessKey.<br>description | **string**<br>Описание ключа доступа. Длина описания должна быть от 0 до 256 символов.
accessKey.<br>keyId | **string**<br>Только для вывода. Идентификатор ключа доступа. Ключ совместим с сервисами AWS.
secret | **string**<br>Секретный ключ доступа. Ключ совместим с сервисами AWS.