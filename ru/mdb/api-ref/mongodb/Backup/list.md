# Метод list
Получение списка ресурсов Backup для указанного каталога.
 

 
## HTTP-запрос
`GET /managed-mongodb/v1/backups`
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
folderId | Обязательное поле. Идентификатор каталога для вывода списка резервных копий. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина — 50 символов.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/mongodb/Backup/list#query_params), сервис вернет значение [nextPageToken](/docs/mdb/api-ref/mongodb/Backup/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/mdb/api-ref/mongodb/Backup/list#query_params) равным значению поля [nextPageToken](/docs/mdb/api-ref/mongodb/Backup/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
backups | **object**<br><p>Ресурс Backup для MongoDB. Подробнее см. в разделе <a href="/docs/mdb/concepts">Взаимосвязь ресурсов сервиса</a>.</p> 
backups.<br>id | **string**<br><p>Идентификатор резервной копии.</p> 
backups.<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит резервная копия.</p> 
backups.<br>createdAt | **string** (date-time)<br><p>Время создания в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> (т. е. когда операция резервного копирования была завершена).</p> 
backups.<br>sourceClusterId | **string**<br><p>Идентификатор кластера MongoDB, для которого была создана резервная копия.</p> 
backups.<br>startedAt | **string** (date-time)<br><p>Время запуска операции резервного копирования.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/mdb/api-ref/mongodb/Backup/list#query_params">pageSize</a>, используйте <a href="/docs/mdb/api-ref/mongodb/Backup/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/mdb/api-ref/mongodb/Backup/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/mdb/api-ref/mongodb/Backup/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 