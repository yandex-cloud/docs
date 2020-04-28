---
editable: false
---

# Информация о подключении

Возвращает информацию о подключении и таблицах.

## HTTP-запрос {#https-request}
```
GET https://upload.datalens.yandex.net/provider/v1/connection/{connection_id}/info
```

## Path-параметры {#path_params}

Параметр | Описание
--- | ---
connection_id | Идентификатор подключения.

## Заголовки {#headers}

Заголовок | Описание
--- | ---
X-DL-Client-Id | Идентификатор клиента.

## Ответ {#responses}
**HTTP Code: 200 - OK**

```json
{
  "type": "string",
  "version": "string",
  "settings": {},
  "tables": [{
    "name": "string",
    "title": "string",
    "partition_key": [
      "string"
    ],
    "replacing_key": [
      "string"
    ],
    "meta": {
      "lastUploadTime": "2019-09-25T09:35:43.956Z"
    },
    "schema":[{
      "name": "string",
      "nullable": true,
      "title": "string",
      "type": "string"
      }
    ]}
  ]
}

```
 
Поле | Описание
--- | ---
type | **string**<br><p>Тип подключения.</p> 
version | **string**<br><p>Версия подключения.</p>
settings | **object**<br><p>Настройки подключения. Используются на стороне поставки данных. Настройки могут меняться пользователями.</p>
tables[] | **object**<br><p>Информация о таблицах в подключении.</p>
tables[].name | **string**<br><p>Имя таблицы.</p>
tables[].title | **string**<br><p>Заголовок таблицы.</p>
tables[].partition_key[] | **string**<br><p>[Ключ партиционирования](../overview.md#partitioning-key).</p>
tables[].replacing_key[] | **string**<br><p>[Ключ замены данных](../overview.md#replacing-key).</p><br/>Позволяет заменить данные, которые были загружены ранее по этому ключу.
tables[].meta | **object**<br><p>Метаданные таблицы.</p>
tables[].meta.lastUploadTime | **string**<br><p>Дата и время последнего обновления таблицы.<br/>Строка в формате <a href="https://en.wikipedia.org/wiki/ISO_8601">ISO 8601</a>.</p>
tables[].schema[] | **object**<br><p>Схема таблицы.</p>
tables[].schema[].name | **string**<br><p>Имя поля.</p>
tables[].schema[].nullable | **boolean**<br><p>Указывает, может ли поле принимать значение `NULL`.</p>
tables[].schema[].title | **string**<br><p>Заголовок поля.</p>
tables[].schema[].type | **string**<br><p>Тип данных поля. Допустимые типы данных: <ul> <li>`string`</li> <li>`integer`</li> <li>`float`</li> <li>`date`</li> <li>`datetime`</li> <li>`boolean`</li> <li>`geopoint`</li></p>

**HTTP Code: 401 - Unauthorized**

Клиент не авторизовался.

**HTTP Code: 403 - Forbidden**

У клиента не хватает прав на просмотр подключения.

**HTTP Code: 5xx**

Ошибка на стороне сервера.