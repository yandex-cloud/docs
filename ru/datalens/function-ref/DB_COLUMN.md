---
editable: false
---

# DB_COLUMN



#### Синтаксис {#syntax}


```
DB_COLUMN( column_name )
```

#### Описание {#description}

{% note warning %}

Доступность и поведение нативных функций зависят от типа и версии вашей базы данных.

Нативные функции рекомендуется использовать только в том случае, если в {{ datalens-short-name }} нет функции (композиции функций), которая позволяет получить требуемый результат.

{% endnote %}

Возвращает нативную колонку базы данных по ее имени. Поддерживаемые имена колонок и типы их результатов определяются коннектором.

Аргумент `column_name` должен быть константной строкой с одним из значений, поддерживаемых коннектором. В ClickHouse все результаты имеют тип `Строка`, а поддерживаемые значения:
`"_table"`, `"_partition_id"`, `"_file"`, `"_path"`.

В отличие от формул DB_CALL_*, эта формула возвращает ссылку на колонку, а не вызов функции. В ClickHouse доступность виртуальных колонок зависит от движка таблицы и версии сервера: `_partition_id` относится к семейству MergeTree, `_table` — к движку/табличной функции Merge, а `_file` / `_path` — к File/S3.

**Типы аргументов:**
- `column_name` — `Строка`


**Возвращаемый тип**: `Строка`

{% note info %}

Значения аргументов (`column_name`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

```
DB_COLUMN("_partition_id") -- ClickHouse MergeTree: virtual partition id
```

```
DB_COLUMN("_table") -- ClickHouse Merge: source table name
```

```
DB_COLUMN("_file") -- ClickHouse File/S3: source file name
```

```
DB_COLUMN("_path") -- ClickHouse File/S3: source file path
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`.
