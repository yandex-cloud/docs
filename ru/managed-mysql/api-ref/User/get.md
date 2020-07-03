---
editable: false
---

# Метод get
Возвращает указанного пользователя MySQL.
 
Чтобы получить список доступных пользователей MySQL, выполните запрос [list](/docs/managed-mysql/api-ref/User/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1alpha/clusters/{clusterId}/users/{userName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера MySQL.  Максимальная длина строки в символах — 50.
userName | Обязательное поле. Имя пользователя.  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]* ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

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
  ]
}
```
Пользователь MySQL. Подробнее см. в [документации](/docs/managed-mysql/concepts).
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя пользователя MySQL.</p> 
clusterId | **string**<br><p>Идентификатор кластера MySQL, которому принадлежит пользователь.</p> 
permissions[] | **object**<br><p>Набор разрешений, предоставленных пользователю.</p> 
permissions[].<br>databaseName | **string**<br><p>Имя базы данных, к которой предоставляет доступ разрешение.</p> 
permissions[].<br>roles[] | **string**<br><ul> <li>ALL_PRIVILEGES: Все привилегии, которые могут быть предоставлены пользователю.</li> <li>ALTER: Изменение таблиц.</li> <li>ALTER_ROUTINE: Изменение хранимых процедур и функций.</li> <li>CREATE: Создание таблиц или индексов.</li> <li>CREATE_ROUTINE: Создание хранимых процедур.</li> <li>CREATE_TEMPORARY_TABLES: Создание временных таблиц.</li> <li>CREATE_VIEW: Создание представлений.</li> <li>DELETE: Удаление таблиц.</li> <li>DROP: Удаление таблиц или представлений.</li> <li>EVENT: Создание, изменение, удаление или отображение событий для планировщика событий.</li> <li>EXECUTE: Выполнение хранимых процедур.</li> <li>INDEX: Создание и удаление индексов.</li> <li>INSERT: Вставка строк в базу данных.</li> <li>LOCK_TABLES: Использование инструкции LOCK TABLES для таблиц, доступных с привилегией SELECT.</li> <li>SELECT: Получение строк из таблиц.</li> </ul> <p>Некоторые операторы SELECT могут быть разрешены без привилегии SELECT. Привилегия SELECT необходима для всех операторов, считывающих значения столбцов. Подробнее в <a href="https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select">документации MySQL</a>.</p> <ul> <li>SHOW_VIEW: Использование инструкции SHOW CREATE VIEW. Также необходимо для представлений, используемых с EXPLAIN.</li> <li>TRIGGER: Создание, удаление, выполнение или отображение триггеров для таблицы.</li> <li>UPDATE: Обновление строк в базе данных.</li> </ul> 