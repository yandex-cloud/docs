# Запись данных в Yandex Object Storage

В Yandex Query для записи данных в бакет Yandex Object Storage можно использовать [соединения](#connection-write) или [привязки к данным](#bindings-write).

Пример записи данных в формате `JSON` с использованием привязки к данным:

```sql
INSERT INTO `my_binding`
SELECT
    "value" AS value, "name" AS name
FROM
    $data;
```

Список поддерживаемых форматов и алгоритмов сжатия данных приведен в разделе [Поддерживаемые форматы записи](#write-formats).

## Запись данных через соединение {#connection-write}

Запись данных с помощью соединений удобно использовать для прототипирования и первоначальной настройки работы с записью данных. Для записи данных в бакет создайте [соединение](object-storage.md#create_connection) к Object Storage и используйте SQL-выражение:

```sql
INSERT INTO <соединение>.<путь>
    WITH
    (
        format='<формат_данных>',
        compression='<формат_сжатия>'
    )
SELECT
    <выражение>
FROM
    <запрос>
```

Где:

* `<соединение>` — название соединения с Object Storage.
* `<путь>` — путь внутри бакета, куда будут записаны данные.
* `<запрос>` — запрос-источник данных Query.

### Пример {#connection-write-example}

Пример запроса для записи данных в Object Storage с использованием соединения:

```sql
INSERT INTO `connection`.`test/`
    WITH
    (
        format='csv_with_names'
    )
SELECT
    "value" AS value, "name" AS name
```

Где:

* `connection` — название соединения с Object Storage.
* `test/`— путь внутри бакета, куда будут записаны данные.

## Запись данных через привязки к данными {#bindings-write}

Если записывать данные нужно регулярно, то удобно делать это с помощью привязок к данным. При этом нет необходимости указывать все детали работы с этими данными в каждом запросе. Для записи данных в бакет создайте [привязку к данным](object-storage-binding.md) в Object Storage и используйте SQL-выражение:

```sql
INSERT INTO `<привязка>`
SELECT
    <выражение>
FROM
    <запрос>
```

Где:

* `<привязка>` — название привязки к данным в Object Storage.
* `<запрос>` — запрос-источник данных Query.

### Пример {#bindings-write-example}

Пример запроса для записи данных в Object Storage c помощью привязок к данным:

```sql
INSERT INTO `test`
SELECT
    "value" AS value, "name" AS name
```

Где:

* `test` — название привязки к данным в Object Storage.

## Поддерживаемые форматы записи {#write-formats}

В настоящий момент поддерживается запись в следующих форматах:

|Формат данных|Название в Query|
|--|--|
|[CSV](https://ru.wikipedia.org/wiki/CSV)|[csv_with_names](formats.md#csv_with_names)|
|[Parquet](https://en.wikipedia.org/wiki/Apache_Parquet)|[parquet](formats.md#parquet)|

В Query поддерживаются следующие алгоритмы сжатия данных для записи:

|Формат сжатия|Название в Query|
|--|--|
|[Gzip](https://ru.wikipedia.org/wiki/Gzip)|gzip|
|[Zstd](https://ru.wikipedia.org/wiki/Zstandard)|zstd|
|[LZ4](https://ru.wikipedia.org/wiki/LZ4)|lz4|
|[Brotli](https://ru.wikipedia.org/wiki/Brotli)|brotli|
|[Bzip2](https://ru.wikipedia.org/wiki/Bzip2)|bzip2|
|[Xz](https://ru.wikipedia.org/wiki/XZ)|xz|

Формат файлов `parquet` поддерживает собственные внутренние алгоритмы сжатия. Query позволяет записывать данные в формате `parquet` с использованием следующих алгоритмов сжатия:

|Формат сжатия|Название в Query|
|--|--|
|[Snappy](https://ru.wikipedia.org/wiki/Snappy_(библиотека))| Без названия, по умолчанию |