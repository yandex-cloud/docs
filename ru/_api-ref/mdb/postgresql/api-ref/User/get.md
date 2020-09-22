---
editable: false
---

# Метод get
Возвращает указанный ресурс User для PostgreSQL.
 
Чтобы получить список доступных ресурсов User для PostgreSQL, отправьте запрос [list](/docs/managed-postgresql/api-ref/User/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/users/{userName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-postgresql/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
userName | Обязательное поле. Имя запрашиваемого ресурса User для PostgreSQL. Чтобы получить имя пользователя, используйте запрос [list](/docs/managed-postgresql/api-ref/User/list).  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]* ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
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
```
Ресурс User для PostgreSQL. Подробнее см. в разделе [Developer's Guide](/docs/managed-postgresql/concepts).
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя пользователя PostgreSQL.</p> 
clusterId | **string**<br><p>Идентификатор кластера PostgreSQL, к которому принадлежит пользователь.</p> 
permissions[] | **object**<br><p>Набор разрешений, предоставленных пользователю.</p> 
permissions[].<br>databaseName | **string**<br><p>Имя базы данных, к которой предоставляет доступ разрешение.</p> 
connLimit | **string** (int64)<br><p>Количество доступных пользователю подключений к базе данных.</p> 
settings | **object**<br><p>Настройки PostgreSQL для этого пользователя</p> <p>Пользовательские параметры PostgreSQL</p> 
settings.<br>defaultTransactionIsolation | **string**<br>
settings.<br>lockTimeout | **integer** (int64)<br><p>в миллисекундах.</p> 
settings.<br>logMinDurationStatement | **integer** (int64)<br><p>в миллисекундах.</p> 
settings.<br>synchronousCommit | **string**<br>
settings.<br>tempFileLimit | **integer** (int64)<br><p>в байтах.</p> 
login | **boolean** (boolean)<br><p>Пользователь может войти (по умолчанию True).</p> 
grants[] | **string**<br><p>Пользовательские гранты (GRANT &lt;роль&gt; TO &lt;пользователь&gt;), роль должна быть другим пользователем.</p> <p>Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9_]*</code>.</p> 