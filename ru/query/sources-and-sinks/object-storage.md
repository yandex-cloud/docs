# Чтение данных с помощью подключений

При работе с {{ objstorage-full-name }} с помощью подключений удобно выполнять прототипирование, первоначальную настройку подключений к данным.

```sql
SELECT
        *
FROM
    object_storage.`*.tsv`
WITH
(
    format=tsv_with_names,
    SCHEMA
    (
        `timestamp` Uint32,
        action String 
    )
);
```

## Настройка подключения { #create_connection }

Для чтения данных из {{ objstorage-full-name }} необходимо:

{% include [!](../_includes/create-object-storage-connection.md) %}

## Модель данных

Данные хранятся в {{ objstorage-full-name }} хранятся в файлах в бинарном виде. Чтение данных выполняется с помощью SQL-выражения

```sql
SELECT
    <expression>
FROM
    <object_storage_connection_name>.`<file_path>`
WITH(format=<file_format>, <compression> AS compression)
WHERE
    <filter>;
```

Где:

- `object_storage_connection_name` — название подключения к хранилищу, созданного в предыдущем пункте.
- `file_path` — путь к файлу или файлам внутри бакета. Поддерживаются wildcards `*`.
- `file_format` — [формат данных](formats.md#formats) в файлах.
- `compression` — [формат сжатия](formats.md#compression_formats) файлов.

Если данные хранятся в сжатом состоянии, их необходимо распаковать для обработки. После распаковки данные нужно разобрать в соответствии с их форматом хранения внутри файлов.

## Пример чтения данных c помощью подключений

Пример запроса для чтения данных из {{ objstorage-full-name }}.
```sql
SELECT
        *
FROM
    connection.`folder/filename.csv`
WITH(
    format='csv_with_names',
    SCHEMA 
    (
        int as Year,
        String as Manufacturer,
        String as Model,
        Double as Price
    )
);
```

Где:

|Поле|Описание|
|--|---|
|`connection`| Название подключения к {{ objstorage-full-name }}|
|`folder/filename.csv`| Путь к файлу в бакете {{ objstorage-full-name }}|
|`SCHEMA`| Описание схемы данных в файле|
