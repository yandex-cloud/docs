---
editable: false
---

# Метод list
Получает список пользователей MySQL в указанном кластере.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/{clusterId}/users
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера для вывода списка пользователей MySQL. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-mysql/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-mysql/api-ref/User/list#query_params), сервис вернет значение [nextPageToken](/docs/managed-mysql/api-ref/User/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-mysql/api-ref/User/list#query_params) равным значению поля [nextPageToken](/docs/managed-mysql/api-ref/User/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
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
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
users[] | **object**<br><p>Пользователь MySQL. Подробнее см. в <a href="/docs/managed-mysql/concepts">документации</a>.</p> 
users[].<br>name | **string**<br><p>Имя пользователя MySQL.</p> 
users[].<br>clusterId | **string**<br><p>Идентификатор кластера MySQL, которому принадлежит пользователь.</p> 
users[].<br>permissions[] | **object**<br><p>Набор разрешений, предоставленных пользователю.</p> 
users[].<br>permissions[].<br>databaseName | **string**<br><p>Имя базы данных, к которой предоставляет доступ разрешение.</p> 
users[].<br>permissions[].<br>roles[] | **string**<br><ul> <li>ALL_PRIVILEGES: Все привилегии, которые могут быть предоставлены пользователю.</li> <li>ALTER: Изменение таблиц.</li> <li>ALTER_ROUTINE: Изменение хранимых процедур и функций.</li> <li>CREATE: Создание таблиц или индексов.</li> <li>CREATE_ROUTINE: Создание хранимых процедур.</li> <li>CREATE_TEMPORARY_TABLES: Создание временных таблиц.</li> <li>CREATE_VIEW: Создание представлений.</li> <li>DELETE: Удаление таблиц.</li> <li>DROP: Удаление таблиц или представлений.</li> <li>EVENT: Создание, изменение, удаление или отображение событий для планировщика событий.</li> <li>EXECUTE: Выполнение хранимых процедур.</li> <li>INDEX: Создание и удаление индексов.</li> <li>INSERT: Вставка строк в базу данных.</li> <li>LOCK_TABLES: Использование инструкции LOCK TABLES для таблиц, доступных с привилегией SELECT.</li> <li>SELECT: Получение строк из таблиц.</li> </ul> <p>Некоторые операторы SELECT могут быть разрешены без привилегии SELECT. Привилегия SELECT необходима для всех операторов, считывающих значения столбцов. Подробнее в <a href="https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select">документации MySQL</a>.</p> <ul> <li>SHOW_VIEW: Использование инструкции SHOW CREATE VIEW. Также необходимо для представлений, используемых с EXPLAIN.</li> <li>TRIGGER: Создание, удаление, выполнение или отображение триггеров для таблицы.</li> <li>UPDATE: Обновление строк в базе данных.</li> <li>REFERENCES: Создание внешних ключей для таблиц.</li> </ul> 
users[].<br>globalPermissions[] | **string**<br><ul> <li>REPLICATION_CLIENT: Разрешает использование SHOW MASTER STATUS, SHOW SLAVE STATUS, и SHOW BINARY LOGS.</li> <li>REPLICATION_SLAVE: Разрешает использование SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS и SHOW BINLOG EVENTS.</li> <li>PROCESS: Разрешает использование SHOW ENGINE INNODB STATUS.</li> </ul> 
users[].<br>connectionLimits | **object**<br><p>Набор ограничений на коннекты пользователя.</p> 
users[].<br>connectionLimits.<br>maxQuestionsPerHour | **integer** (int64)<br><p>Максимально допустимое число вопросов в час.</p> <p>Минимальное значение — 0.</p> 
users[].<br>connectionLimits.<br>maxUpdatesPerHour | **integer** (int64)<br><p>Максимально допустимое число апдейтов в час.</p> <p>Минимальное значение — 0.</p> 
users[].<br>connectionLimits.<br>maxConnectionsPerHour | **integer** (int64)<br><p>Максимально допустимое число коннектов в час.</p> <p>Минимальное значение — 0.</p> 
users[].<br>connectionLimits.<br>maxUserConnections | **integer** (int64)<br><p>Максимально допустимое число коннектов.</p> <p>Минимальное значение — 0.</p> 
users[].<br>authenticationPlugin | **string**<br><p>Аутентификационный плагин пользователя.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>CACHING_SHA2_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html">Caching SHA-2 Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-mysql/api-ref/User/list#query_params">pageSize</a>, используйте <a href="/docs/managed-mysql/api-ref/User/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-mysql/api-ref/User/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-mysql/api-ref/User/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 