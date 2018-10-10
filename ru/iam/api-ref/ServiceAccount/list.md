# Метод list
Возвращает список доступных ресурсов ServiceAccount в указанном
каталоге.
 

 
## HTTP-запрос
`GET /iam/v1/serviceAccounts`
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка сервисных аккаунтов. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина — 50 символов.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/iam/api-ref/ServiceAccount/list#query_params), сервис вернет значение [nextPageToken](/docs/iam/api-ref/ServiceAccount/list#responses), которое можно использовать для получения следующей страницы. Допустимые значения от 0 до 1000 включительно. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/iam/api-ref/ServiceAccount/list#query_params) равным значению поля [nextPageToken](/docs/iam/api-ref/ServiceAccount/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [ServiceAccount.name](/docs/iam/api-ref/ServiceAccount#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.  Максимальная длина — 1000 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
serviceAccounts | **object**<br>Ресурс ServiceAccount. Дополнительные сведения см. в разделе [Сервисные аккаунты](/docs/iam/concepts/users/service-accounts).
serviceAccounts.<br>id | **string**<br>Только для вывода. Идентификатор сервисного аккаунта.
serviceAccounts.<br>folderId | **string**<br>Идентификатор каталога, которому принадлежит сервисный аккаунт.
serviceAccounts.<br>createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
serviceAccounts.<br>name | **string**<br>Имя сервисного аккаунта. Имя должно быть уникальным в облаке. Длина имени должна быть от 3 до 63 символов.
serviceAccounts.<br>description | **string**<br>Описание сервисного аккаунта. Длина описания должна быть от 0 до 256 символов.
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/iam/api-ref/ServiceAccount/list#query_params), используйте [nextPageToken](/docs/iam/api-ref/ServiceAccount/list#responses) в качестве значения параметра [pageToken](/docs/iam/api-ref/ServiceAccount/list#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/iam/api-ref/ServiceAccount/list#responses) для перебора страниц результатов.