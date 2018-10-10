# Метод list
Возвращает список доступных ресурсов AccessKey для указанного
сервисного аккаунта.
 

 
## HTTP-запрос
`GET /iam/aws-compatibility/v1/accessKeys`
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
serviceAccountId | Идентификатор сервисного аккаунта, для которого запрашивается список ключей доступа. Чтобы получить идентификатор сервисного аккаунта, используйте запрос [list](/docs/iam/api-ref/ServiceAccount/list). Если [serviceAccountId](/docs/iam/api-ref/AccessKey/list#query_params) не указан, то используется идентификатор субъекта, который сделал запрос.  Максимальная длина — 50 символов.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/iam/api-ref/AccessKey/list#query_params), сервис вернет значение [nextPageToken](/docs/iam/api-ref/AccessKey/list#responses), которое можно использовать для получения следующей страницы. Допустимые значения от 0 до 1000 включительно. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/iam/api-ref/AccessKey/list#query_params) равным значению поля [nextPageToken](/docs/iam/api-ref/AccessKey/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
accessKeys | **object**<br>Ресурс AccessKey — статический ключ доступа. Используется для авторизации в HTTP API, совместимом с Amazon S3.
accessKeys.<br>id | **string**<br>Только для вывода. Идентификатор ресурса AccessKey. Используется для управления учетными данными: идентификатором ключа доступа и секретным ключом доступа.
accessKeys.<br>serviceAccountId | **string**<br>Идентификатор сервисного аккаунта, которому принадлежит ключ доступа.
accessKeys.<br>createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
accessKeys.<br>description | **string**<br>Описание ключа доступа. Длина описания должна быть от 0 до 256 символов.
accessKeys.<br>keyId | **string**<br>Только для вывода. Идентификатор ключа доступа. Ключ совместим с сервисами AWS.
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/iam/api-ref/AccessKey/list#query_params), используйте [nextPageToken](/docs/iam/api-ref/AccessKey/list#responses) в качестве значения параметра [pageToken](/docs/iam/api-ref/AccessKey/list#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/iam/api-ref/AccessKey/list#responses) для перебора страниц результатов.