---
editable: false
---

# Метод list
Возвращает список резервных копий Redis, доступных для указанного каталога.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-redis/v1/backups
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога для вывода списка резервных копий. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-redis/api-ref/Backup/list#query_params), сервис вернет значение [nextPageToken](/docs/managed-redis/api-ref/Backup/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-redis/api-ref/Backup/list#query_params) равным значению поля [nextPageToken](/docs/managed-redis/api-ref/Backup/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "backups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "sourceClusterId": "string",
      "startedAt": "string",
      "sourceShardNames": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
backups[] | **object**<br><p>Описание резервной копии Redis. Подробнее смотрите в <a href="/docs/managed-redis/concepts/backup">документации</a> Managed Service for Redis.</p> 
backups[].<br>id | **string**<br><p>Идентификатор резервной копии.</p> 
backups[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит резервная копия.</p> 
backups[].<br>createdAt | **string** (date-time)<br><p>Время создания в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> (т. е. когда операция резервного копирования была завершена).</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
backups[].<br>sourceClusterId | **string**<br><p>Идентификатор кластера Redis, для которого была создана резервная копия.</p> 
backups[].<br>startedAt | **string** (date-time)<br><p>Время запуска операции резервного копирования в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
backups[].<br>sourceShardNames[] | **string**<br><p>Имена шардов, которые использовались при создании резервной копии.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-redis/api-ref/Backup/list#query_params">pageSize</a>, используйте <a href="/docs/managed-redis/api-ref/Backup/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-redis/api-ref/Backup/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-redis/api-ref/Backup/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 