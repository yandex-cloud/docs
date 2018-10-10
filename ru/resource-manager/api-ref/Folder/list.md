# Метод list
Возвращает список доступных ресурсов Folder в указанном облаке.
 

 
## HTTP-запрос
`GET /resource-manager/v1/folders`
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
cloudId | Обязательное поле. Идентификатор облака, для которого запрашивается список каталогов. Чтобы получить идентификатор облака, используйте запрос [list](/docs/resource-manager/api-ref/Cloud/list).  Максимальная длина — 50 символов.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/resource-manager/api-ref/Folder/list#query_params), сервис вернет значение [nextPageToken](/docs/resource-manager/api-ref/Folder/list#responses), которое можно использовать для получения следующей страницы. Допустимые значения от 0 до 1000 включительно. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/resource-manager/api-ref/Folder/list#query_params) равным значению поля [nextPageToken](/docs/resource-manager/api-ref/Folder/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Folder.name](/docs/resource-manager/api-ref/Folder#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.  Максимальная длина — 1000 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
folders | **object**<br>Ресурс Folder. Дополнительные сведения см. в разделе [Каталог как ресурс Яндекс.Облака](/docs/resource-manager/concepts/resources-hierarchy#folder).
folders.<br>id | **string**<br>Только для вывода. Идентификатор каталога.
folders.<br>cloudId | **string**<br>Идентификатор облака, которому принадлежит каталог.
folders.<br>createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
folders.<br>name | **string**<br>Имя каталога. Имя должно быть уникальным в облаке. Длина имени должна быть от 3 до 63 символов.
folders.<br>description | **string**<br>Описание каталога. Длина описания должна быть от 0 до 256 символов.
folders.<br>labels | **object**<br>Метки ресурса в формате ключ-значение. Максимум 64 метки на ресурс.
folders.<br>status | **string**<br>Только для вывода. Статус каталога.  Статус каталога.   - STATUS_UNSPECIFIED: Статус неопределен.  - ACTIVE: Каталог активен.  - DELETING: Каталог удаляется.<br>`ACTIVE`<br>`DELETING`<br>
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/resource-manager/api-ref/Folder/list#query_params), используйте [nextPageToken](/docs/resource-manager/api-ref/Folder/list#responses) в качестве значения параметра [pageToken](/docs/resource-manager/api-ref/Folder/list#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/resource-manager/api-ref/Folder/list#responses) для перебора страниц результатов.