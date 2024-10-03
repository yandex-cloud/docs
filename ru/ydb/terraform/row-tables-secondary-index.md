---
title: Создание вторичных индексов в строковых таблицах {{ ydb-short-name }}
description: В инструкции описаны свойства ресурса yandex_ydb_table_index для создания вторичных индексов строковых таблиц {{ ydb-short-name }}.
---

# Создание вторичных индексов строковых таблиц

Для работы с [индексом таблицы](https://ydb.tech/docs/ru/concepts/secondary_indexes) используется ресурс `yandex_ydb_table_index`.

{% note info %}

При изменении вторичного индекса старый индекс удаляется, а новый — создается.

{% endnote %}

## Описание ресурса yandex_ydb_table_index {#ttable_index_description}

Пример использования ресурса `yandex_ydb_table_index`:

```tf
resource "yandex_ydb_table_index" "ydb_table_index" {
  table_path        = "test_dir/test_table_3_col" # пример пути относительно корня базы
  connection_string = yandex_ydb_database_serverless.database1.ydb_full_endpoint # пример подключения к БД
  name              = "my_index"
  type              = "global_sync" # "global_async"
  columns           = ["a", "b"]
  cover             = ["c"]
}
```

Поддерживаются следующие поля:
| **Название поля** | **Тип** | **Описание** |
| --- | --- | --- |
|`table_path`|`string`|Путь до таблицы. Указывается, если не задан `table_id`|
|`connection_string`|`string`|Строка соединения с базой данных. Указывается, если не задан `table_id`|
|`table_id`|`string`|{{ TF }}-идентификатор таблицы. Указывается, если не задан `table_path` или `connection_string`|
|`name`|`string`<br>`required`|Имя индекса|
|`type`|`string`<br>`required`|Тип индекса [global_sync / global_async](https://ydb.tech/docs/ru/yql/reference/syntax/create_table#secondary_index)|
|`columns`|`list(string)`<br>`required`|Упорядоченный список имен колонок, участвующих в индексе|
|`cover`|`list(string)`<br>`required`|Список дополнительных колонок для покрывающего индекса|
