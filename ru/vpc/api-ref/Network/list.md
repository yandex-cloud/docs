# Метод list
Возвращает список доступных ресурсов Network в указанном
каталоге.
 

 
## HTTP-запрос
`GET /vpc/v1/networks`
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
folderId | Обязательное поле. Идентификатор каталога для получения списка облачных сетей. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина — 50 символов.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/vpc/api-ref/Network/list#query_params), сервис вернет значение [nextPageToken](/docs/vpc/api-ref/Network/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/vpc/api-ref/Network/list#query_params) равным значению поля [nextPageToken](/docs/vpc/api-ref/Network/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Network.name](/docs/vpc/api-ref/Network#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.  Максимальная длина — 1000 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
networks | **object**<br>Ресурс Network. Дополнительные сведения см. в разделе [Облачные сети](/docs/vpc/concepts/network).
networks.<br>id | **string**<br>Только для вывода. Идентификатор облачной сети.
networks.<br>folderId | **string**<br>Идентификатор каталога, которому принадлежит сеть.
networks.<br>createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
networks.<br>name | **string**<br>Имя облачной сети. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.
networks.<br>description | **string**<br>Описание облачной сети. Длина описания должна быть от 0 до 256 символов.
networks.<br>labels | **object**<br>Метки ресурса в формате ключ-значение. Максимум 64 метки на ресурс.
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/vpc/api-ref/Network/list#query_params), используйте [nextPageToken](/docs/vpc/api-ref/Network/list#responses) в качестве значения параметра [pageToken](/docs/vpc/api-ref/Network/list#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/vpc/api-ref/Network/list#responses), для перебора страниц результатов.