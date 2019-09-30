---
editable: false
---

# Обновление информации о таблице

Обновляет схему и ключ партиционирования таблицы.

## HTTP-запрос {#https-request}
```
POST https://upload.datalens.yandex.net/provider/v1/connection/{connection_id}/{table_name}/definition
```

## Path-параметры {#path_params}

Параметр | Описание
--- | ---
connection_id | Идентификатор подключения.
table_name | Имя таблицы.
 
## Параметры в теле запроса {#body_params}
 
```json
{
  "partition_key": [
    "string"
  ],
  "schema": [
    {
      "name": "string",
      "nullable": true,
      "title": "string",
      "type": "string"
    }
  ]
}
```

 
Поле | Описание
--- | ---
partition_key[] | **object**<br><p>Ключ партиционирования.</p>
schema[] | **object**<br><p>Схема таблицы.</p>
schema[].name | **string**<br><p>Имя поля.</p>
schema[].nullable | **boolean**<br><p>Указывает, может ли поле принимать значение `NULL`.</p>
schema[].title | **string**<br><p>Заголовок поля.</p>
schema[].type | **string**<br><p>Тип данных. Допустимые типы данных: <ul> <li>`string`</li> <li>`integer`</li> <li>`float`</li> <li>`date`</li> <li>`datetime`</li> <li>`boolean`</li> <li>`geopoint`</li></p>

 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json
{
  "old_data_was_dropped": true,
  "old_table_definition": {
    "partition_key": [
      "string"
    ],
    "meta": {
      "lastUploadTime": "2019-09-24T14:27:38.094Z"
    },
    "schema": [
      {
        "name": "string",
        "nullable": true,
        "title": "string",
        "type": "string"
      }
    ],
    "name": "string"
  },
  "new_table_definition": {
    "partition_key": [
      "string"
    ],
    "meta": {
      "lastUploadTime": "2019-09-24T14:27:38.094Z"
    },
    "schema": [
      {
        "name": "string",
        "nullable": true,
        "title": "string",
        "type": "string"
      }
    ],
    "name": "string"
  }
}
```

Поле | Описание
--- | ---
old_data_was_dropped | **boolean**<br><p>Указывает, что старая информация о таблице была удалена.</p> 
old_table_definition | **object**<br><p>Старая информация о таблице.</p>
old_table_definition.partition_key[] | **string**<br><p>Старый ключ партиционирования.</p>
old_table_definition.meta | **object**<br><p>Удаленные метаданные о таблице.</p>
old_table_definition.meta.lastUploadTime | **string**<br><p>Старые дата и время последнего обновления.<br/>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p>
old_table_definition.schema[] | **string**<br><p>Старая схема таблицы.</p>
old_table_definition.schema[].name | **string**<br><p>Имя поля.</p>
old_table_definition.schema[].nullable | **boolean**<br><p>Указывает, может ли поле принимать значение `NULL`.</p>
old_table_definition.schema[].title | **string**<br><p>Заголовок поля.</p>
old_table_definition.schema[].type | **string**<br><p>Тип данных. Допустимые типы данных: <ul> <li>`string`</li> <li>`integer`</li> <li>`float`</li> <li>`date`</li> <li>`datetime`</li> <li>`boolean`</li> <li>`geopoint`</li></p>
old_table_definition.name | **string**<br><p>Имя таблицы.</p>
new_table_definition | **object**<br><p>Информация, которая была добавлена.</p>
new_table_definition.partition_key[] | **string**<br><p>Ноый ключ партиционирования.</p>
new_table_definition.meta | **object**<br><p>Новые метаданные таблицы.</p>
new_table_definition.meta.lastUploadTime | **string**<br><p>Дата и время последнего обновления.<br/>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p>
new_table_definition.schema[] | **string**<br><p>Новая схема таблицы.</p>
new_table_definition.schema[].name | **string**<br><p>Имя поля.</p>
new_table_definition.schema[].nullable | **boolean**<br><p>Указывает, может ли поле принимать значение `NULL`.</p>
new_table_definition.schema[].title | **string**<br><p>Заголовок поля.</p>
new_table_definition.schema[].type | **string**<br><p>Тип данных. Допустимые типы данных: <ul> <li>`string`</li> <li>`integer`</li> <li>`float`</li> <li>`date`</li> <li>`datetime`</li> <li>`boolean`</li> <li>`geopoint`</li></p>
new_table_definition.name | **string**<br><p>Новое имя таблицы.</p>