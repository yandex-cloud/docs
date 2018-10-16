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
folders | **object**<br><p>Ресурс Folder. Дополнительные сведения см. в разделе <a href="/docs/resource-manager/concepts/resources-hierarchy#folder">Каталог как ресурс Яндекс.Облака</a>.</p> 
folders.<br>id | **string**<br><p>Идентификатор каталога.</p> 
folders.<br>cloudId | **string**<br><p>Идентификатор облака, которому принадлежит каталог.</p> 
folders.<br>createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
folders.<br>name | **string**<br><p>Имя каталога. Имя должно быть уникальным в облаке. Длина имени должна быть от 3 до 63 символов.</p> 
folders.<br>description | **string**<br><p>Описание каталога. Длина описания должна быть от 0 до 256 символов.</p> 
folders.<br>labels | **object**<br><p>Метки ресурса в формате <code>ключ:значение</code>. Максимум 64 метки на ресурс.</p> 
folders.<br>status | **string**<br><p>Статус каталога.</p> <p>Статус каталога.</p> <ul> <li>ACTIVE: Каталог активен.</li> <li>DELETING: Каталог удаляется.</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/resource-manager/api-ref/Folder/list#query_params">pageSize</a>, используйте <a href="/docs/resource-manager/api-ref/Folder/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/resource-manager/api-ref/Folder/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/resource-manager/api-ref/Folder/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 