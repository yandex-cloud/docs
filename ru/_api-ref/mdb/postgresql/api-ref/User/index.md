---
editable: false
---

# User
Набор методов для управления ресурсами User для PostgreSQL.
## JSON-представление {#representation}
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

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает пользователя PostgreSQL в указанном кластере.
[delete](delete.md) | Удаляет указанного пользователя PostgreSQL.
[get](get.md) | Возвращает указанный ресурс User для PostgreSQL.
[grantPermission](grantPermission.md) | Выдает разрешение указанному пользователю PostgreSQL.
[list](list.md) | Получает список ресурсов User для указанного кластера PostgreSQL.
[revokePermission](revokePermission.md) | Отзывает разрешение у указанного пользователя PostgreSQL.
[update](update.md) | Изменяет указанного пользователя PostgreSQL.