---
editable: false
---

# Метод list
Получает список ресурсов User для указанного кластера PostgreSQL.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/users
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера для вывода списка пользователей PostgreSQL. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-postgresql/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-postgresql/api-ref/User/list#query_params), сервис вернет значение [nextPageToken](/docs/managed-postgresql/api-ref/User/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-postgresql/api-ref/User/list#query_params) равным значению поля [nextPageToken](/docs/managed-postgresql/api-ref/User/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
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
          "databaseName": "string"
        }
      ],
      "connLimit": "string",
      "settings": {
        "defaultTransactionIsolation": "string",
        "lockTimeout": "integer",
        "logMinDurationStatement": "integer",
        "synchronousCommit": "string",
        "tempFileLimit": "integer"
      },
      "login": true,
      "grants": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
users[] | **object**<br><p>Ресурс User для PostgreSQL. Подробнее см. в разделе <a href="/docs/managed-postgresql/concepts">Developer's Guide</a>.</p> 
users[].<br>name | **string**<br><p>Имя пользователя PostgreSQL.</p> 
users[].<br>clusterId | **string**<br><p>Идентификатор кластера PostgreSQL, к которому принадлежит пользователь.</p> 
users[].<br>permissions[] | **object**<br><p>Набор разрешений, предоставленных пользователю.</p> 
users[].<br>permissions[].<br>databaseName | **string**<br><p>Имя базы данных, к которой предоставляет доступ разрешение.</p> 
users[].<br>connLimit | **string** (int64)<br><p>Количество доступных пользователю подключений к базе данных.</p> 
users[].<br>settings | **object**<br><p>Настройки PostgreSQL для этого пользователя</p> <p>Пользовательские параметры PostgreSQL</p> 
users[].<br>settings.<br>defaultTransactionIsolation | **string**<br>
users[].<br>settings.<br>lockTimeout | **integer** (int64)<br><p>в миллисекундах.</p> 
users[].<br>settings.<br>logMinDurationStatement | **integer** (int64)<br><p>в миллисекундах.</p> 
users[].<br>settings.<br>synchronousCommit | **string**<br>
users[].<br>settings.<br>tempFileLimit | **integer** (int64)<br><p>в байтах.</p> 
users[].<br>login | **boolean** (boolean)<br><p>Пользователь может войти (по умолчанию True).</p> 
users[].<br>grants[] | **string**<br><p>Пользовательские гранты (GRANT &lt;роль&gt; TO &lt;пользователь&gt;), роль должна быть другим пользователем.</p> <p>Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9_]*</code>.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-postgresql/api-ref/User/list#query_params">pageSize</a>, используйте <a href="/docs/managed-postgresql/api-ref/User/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-postgresql/api-ref/User/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-postgresql/api-ref/User/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 