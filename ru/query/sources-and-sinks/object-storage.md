# Чтение данных из {{ objstorage-name }} с помощью соединений с {{ yq-name }}

При работе с {{ objstorage-full-name }} с помощью соединений удобно выполнять прототипирование, первоначальную настройку подключений к данным.

Пример запроса для чтения данных:

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

## Настройка соединения {#create_connection}

Чтобы создать соединение с {{ objstorage-short-name }}:

{% include [!](../_includes/create-object-storage-connection.md) %}

## Модель данных {#data_model}

В {{ objstorage-short-name }} данные хранятся в файлах в бинарном виде. Для чтения данных используйте SQL-выражение:

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

* `object_storage_connection_name` — название [соединения](#create_connection) с хранилищем.
* `file_path` — путь к файлу или файлам внутри бакета. Поддерживаются wildcards `*`.
* `file_format` — [формат данных](formats.md#formats) в файлах.
* `compression` — [формат сжатия](formats.md#compression_formats) файлов.

Если данные хранятся в сжатом состоянии, их необходимо распаковать для обработки. После распаковки разберите данные в соответствии с их форматом хранения внутри файлов.

### Форматы путей к данным {#path_format}

В {{ yq-full-name }} поддерживаются следующие пути к данным:

{% include [!](../_includes/object-storage-path-format.md) %}

## Пример чтения данных c помощью соединений {#read_example}

Пример запроса для чтения данных из {{ objstorage-short-name }}:

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

* `connection` — название соединения с {{ objstorage-short-name }}.
* `folder/filename.csv` — путь к файлу в бакете {{ objstorage-short-name }}.
* `SCHEMA` — описание схемы данных в файле.
