---
editable: false
---

# User
Набор методов для управления пользователями MySQL.
## JSON-представление {#representation}
```json 
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
  ],
  "globalPermissions": [
    "string"
  ],
  "connectionLimits": {
    "maxQuestionsPerHour": "integer",
    "maxUpdatesPerHour": "integer",
    "maxConnectionsPerHour": "integer",
    "maxUserConnections": "integer"
  },
  "authenticationPlugin": "string"
}
```
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя пользователя MySQL.</p> 
clusterId | **string**<br><p>Идентификатор кластера MySQL, которому принадлежит пользователь.</p> 
permissions[] | **object**<br><p>Набор разрешений, предоставленных пользователю.</p> 
permissions[].<br>databaseName | **string**<br><p>Имя базы данных, к которой предоставляет доступ разрешение.</p> 
permissions[].<br>roles[] | **string**<br><ul> <li>ALL_PRIVILEGES: Все привилегии, которые могут быть предоставлены пользователю.</li> <li>ALTER: Изменение таблиц.</li> <li>ALTER_ROUTINE: Изменение хранимых процедур и функций.</li> <li>CREATE: Создание таблиц или индексов.</li> <li>CREATE_ROUTINE: Создание хранимых процедур.</li> <li>CREATE_TEMPORARY_TABLES: Создание временных таблиц.</li> <li>CREATE_VIEW: Создание представлений.</li> <li>DELETE: Удаление таблиц.</li> <li>DROP: Удаление таблиц или представлений.</li> <li>EVENT: Создание, изменение, удаление или отображение событий для планировщика событий.</li> <li>EXECUTE: Выполнение хранимых процедур.</li> <li>INDEX: Создание и удаление индексов.</li> <li>INSERT: Вставка строк в базу данных.</li> <li>LOCK_TABLES: Использование инструкции LOCK TABLES для таблиц, доступных с привилегией SELECT.</li> <li>SELECT: Получение строк из таблиц.</li> </ul> <p>Некоторые операторы SELECT могут быть разрешены без привилегии SELECT. Привилегия SELECT необходима для всех операторов, считывающих значения столбцов. Подробнее в <a href="https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select">документации MySQL</a>.</p> <ul> <li>SHOW_VIEW: Использование инструкции SHOW CREATE VIEW. Также необходимо для представлений, используемых с EXPLAIN.</li> <li>TRIGGER: Создание, удаление, выполнение или отображение триггеров для таблицы.</li> <li>UPDATE: Обновление строк в базе данных.</li> <li>REFERENCES: Создание внешних ключей для таблиц.</li> </ul> 
globalPermissions[] | **string**<br><ul> <li>REPLICATION_CLIENT: Разрешает использование SHOW MASTER STATUS, SHOW SLAVE STATUS, и SHOW BINARY LOGS.</li> <li>REPLICATION_SLAVE: Разрешает использование SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS и SHOW BINLOG EVENTS.</li> <li>PROCESS: Разрешает использование SHOW ENGINE INNODB STATUS.</li> </ul> 
connectionLimits | **object**<br><p>Набор ограничений на коннекты пользователя.</p> 
connectionLimits.<br>maxQuestionsPerHour | **integer** (int64)<br><p>Максимально допустимое число вопросов в час.</p> <p>Минимальное значение — 0.</p> 
connectionLimits.<br>maxUpdatesPerHour | **integer** (int64)<br><p>Максимально допустимое число апдейтов в час.</p> <p>Минимальное значение — 0.</p> 
connectionLimits.<br>maxConnectionsPerHour | **integer** (int64)<br><p>Максимально допустимое число коннектов в час.</p> <p>Минимальное значение — 0.</p> 
connectionLimits.<br>maxUserConnections | **integer** (int64)<br><p>Максимально допустимое число коннектов.</p> <p>Минимальное значение — 0.</p> 
authenticationPlugin | **string**<br><p>Аутентификационный плагин пользователя.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>CACHING_SHA2_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html">Caching SHA-2 Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает пользователя MySQL в указанном кластере.
[delete](delete.md) | Удаляет указанного пользователя MySQL.
[get](get.md) | Возвращает указанного пользователя MySQL.
[grantPermission](grantPermission.md) | Предоставляет разрешение указанному пользователю MySQL.
[list](list.md) | Получает список пользователей MySQL в указанном кластере.
[revokePermission](revokePermission.md) | Отзывает разрешение у указанного пользователя MySQL.
[update](update.md) | Изменяет указанного пользователя MySQL.