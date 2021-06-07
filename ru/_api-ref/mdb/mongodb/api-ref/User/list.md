---
editable: false
---

# Метод list
Получает список ресурсов User для указанного кластера MongoDB.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}/users
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера, для которого нужно получить список пользователей MongoDB. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-mongodb/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-mongodb/api-ref/User/list#query_params), сервис вернет значение [nextPageToken](/docs/managed-mongodb/api-ref/User/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-mongodb/api-ref/User/list#query_params) равным значению поля [nextPageToken](/docs/managed-mongodb/api-ref/User/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "users": [
    {
      "name": "string",
      "clusterId": "string",
      "permissions": [
        {
          "databaseName": "string",
          "roles": [
            "string"
          ]
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
users[] | **object**<br><p>Ресурс User для MongoDB. Подробнее см. в разделе <a href="/docs/managed-mongodb/concepts">Developer's Guide</a>.</p> 
users[].<br>name | **string**<br><p>Имя пользователя базы данных MongoDB.</p> 
users[].<br>clusterId | **string**<br><p>Идентификатор кластера MongoDB, к которому принадлежит пользователь.</p> 
users[].<br>permissions[] | **object**<br><p>Набор разрешений, предоставленных пользователю.</p> 
users[].<br>permissions[].<br>databaseName | **string**<br><p>Имя базы данных, к которой предоставляет доступ разрешение.</p> 
users[].<br>permissions[].<br>roles[] | **string**<br><p>Роли MongoDB базы данных ``databaseName``, которые предоставляет разрешение.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-mongodb/api-ref/User/list#query_params">pageSize</a>, используйте <a href="/docs/managed-mongodb/api-ref/User/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-mongodb/api-ref/User/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-mongodb/api-ref/User/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 