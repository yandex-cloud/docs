---
editable: false
---

# Удаление данных из таблицы
Удаляет данные из таблицы с помощью указанного ключа партиционирования.
 
## HTTP-запрос {#https-request}
```
DELETE https://upload.datalens.yandex.net/provider/v1/connection/{conn_id}/table/{table_name}/data
```
 
## Path-параметры {#path_params}

Параметр | Описание
--- | ---
connection_id | Идентификатор подключения.
table_name | Имя таблицы.

## Параметры в теле запроса {#body_params}

```json
{
  "partitions": [
    {}
  ]
}
```

Поле | Описание
--- | ---
partitions[] | **object**<br><p>[Ключи партиционирования](../overview.md#partitioning-key).</p>

## Ответ {#responses}
**HTTP Code: 200 - OK**

```json
{
  "deleted_partition_keys": [
    [
      "string"
    ]
  ],
  "success": true,
  "request_id": "string",
  "partition_key_columns": [
    "string"
  ],
  "message": "string"
}
```

Поле | Описание
--- | ---
deleted_partition_keys[] | **object**<br><p>Список списков удаленных значений партиций.</p>
success | **boolean**<br><p>Указывает, успешно ли завершилась операция удаления.</p>
request_id | **string**<br><p>Идентификатор запроса на удаление.</p>
partition_key_columns | **string**<br><p>Текущие ключи партиционирования.</p>
message | **string**<br><p>Сообщение от сервера {{ datalens-short-name }}.</p>