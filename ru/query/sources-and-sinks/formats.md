# Форматы данных и алгоритмы сжатия

Ниже описаны поддерживаемые в {{ yq-full-name }} форматы данных и алгоритмы сжатия.


### Поддерживаемые форматы данных {#formats}
В {{ yql-full-name }} поддерживаются следующие форматы данных:
- [`csv_with_names`](#csv_with_names).
- [`tsv_with_names`](#tsv_with_names).
- [`json_list`](#json_list).
- [`json_each_row`](#json_each_row).
- [`raw`](#raw).
- [`json_as_string`](#json_as_string).
- [`parquet`](#parquet). 

#### Формат csv_with_names {#csv_with_names}
Данный формат основан на формате [CSV](https://ru.wikipedia.org/wiki/CSV). Данные размещены в колонках, разделены запятыми, на первой строке файла находятся имена колонок.

Пример данных:
```
Year,Manufacturer,Model,Price
1997,Ford,E350,3000.00
1999,Chevy,"Venture «Extended Edition»",4900.00
```

{% cut "Пример запроса" %}

```sql
SELECT 
    * 
FROM `connection`.`path` 
WITH
(
    format=csv_with_names, 
    SCHEMA
    (
        Year int, 
        Manufacturer string, 
        Model string, 
        Price double
    )
)
```

Результат выполнения запроса:

|#|Manufacturer|Model|Price|Year|
|-|-|-|-|-|
|1|Ford|E350|3000|1997|
|2|Chevy|Venture «Extended Edition»|4900|1999


{% endcut %}


#### Формат tsv_with_names {#tsv_with_names}
Данный формат основан на формате [TSV](https://ru.wikipedia.org/wiki/TSV). Данные размещены в колонках, разделены символами табуляции (код `0x9`), в первой строке файла находятся имена колонок.

Пример данных:
```
Year    Manufacturer    Model   Price
1997    Ford    E350    3000.00
1999    Chevy   "Venture «Extended Edition»"    4900.00
```

{% cut "Пример запроса" %}

```sql
SELECT 
    * 
FROM `connection`.`path` 
WITH
(
    format=tsv_with_names, 
    SCHEMA
    (
        Year int, 
        Manufacturer string, 
        Model string, 
        Price double
    )
)
```

Результат выполнения запроса:

|#|Manufacturer|Model|Price|Year|
|-|-|-|-|-|
|1|Ford|E350|3000|1997|
|2|Chevy|Venture «Extended Edition»|4900|1999


{% endcut %}

#### Формат json_list {#json_list}
Данный формат основан на [JSON-представлении](https://ru.wikipedia.org/wiki/JSON) данных. В этом формате внутри каждого файла должен находиться объект в корректном JSON-представлении.

Пример корректных данных (данные представлены в виде списка объектов JSON):
```json
[
    { "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 },
    { "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
]
```

Пример НЕкорректных данных (на каждой отдельной строке находится отдельный объект в формате JSON, но эти объекты не объединены в список):

```json
{ "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 }
{ "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
```

#### Формат json_each_row {#json_each_row}
Данный формат основан на [JSON-представлении](https://ru.wikipedia.org/wiki/JSON) данных. В этом формате внутри каждого файла на каждой отдельной строке файла должен находиться объект в корректном JSON-представлении, но эти объекты не объединены в JSON-список. Такой формат используется при передаче данных через потоковые системы, типа [Yandex Data Streams](../../data-streams/concepts/index.md).

Пример корректных данных (на каждой отдельной строке находится отдельный объект в формате JSON, но эти объекты не объединены в список):
```json
{ "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 },
{ "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
```

{% cut "Пример запроса" %}

```sql
SELECT 
    * 
FROM `connection`.`path` 
WITH
(
    format=json_each_row, 
    SCHEMA
    (
        Year int, 
        Manufacturer string, 
        Model string, 
        Price double
    )
)
```

Результат выполнения запроса:

|#|Manufacturer|Model|Price|Year|
|-|-|-|-|-|
|1|Ford|E350|3000|1997|
|2|Chevy|Venture «Extended Edition»|4900|1999


{% endcut %}

#### Формат raw {#raw}
Данный формат позволяет считывать содержимое файлов как есть, в «сыром» виде. Считанные таким образом данные можно обработать средствами [YQL](https://ydb.tech/ru/docs/yql/reference/udf/list/string), разделив на строки и столбцы.

Этот формат стоит использовать, если встроенных возможностей парсинга исходных данных в {{ yq-full-name }} не достаточно.

{% cut "Пример запроса" %}

```sql
SELECT 
    * 
FROM `connection`.`path` 
WITH
(
    format=raw, 
    SCHEMA
    (
        Data String
    )
)
```

Результат выполнения запроса:

```
Year,Manufacturer,Model,Price
1997,Ford,E350,3000.00
1999,Chevy,\"Venture «Extended Edition»\",4900.00
```

{% endcut %}

#### Формат json_as_string {#json_as_string}
Данный формат основан на [JSON-представлении](https://ru.wikipedia.org/wiki/JSON) данных. Данный формат не разбивает входной JSON-документ на поля, а представляет каждую строку файла в виде одного объекта JSON (или одной строки). Такой формат удобен, если список полей не фиксирован и может изменяться в разных сообщениях.

В этом формате внутри каждого файла должен находиться:
- объект в корректном JSON-представлении в каждой отдельной строке файла;
- объекты в корректном JSON-представлении, объединенные в список.

Пример корректных данных (данные представлены в виде списка объектов JSON):
```json
{ "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 }
{ "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
```


{% cut "Пример запроса" %}

```sql
SELECT 
    * 
FROM `connection`.`path` 
WITH
(
    format=json_as_string, 
    SCHEMA
    (
        Data Json
    )
)
```

Результат выполнения запроса:

|#|Data|
|-|-|
|1|`{"Manufacturer": "Ford", "Model": "E350", "Price": 3000, "Year": 1997}`|
|2|`{"Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900, "Year": 1999}`|


{% endcut %}

#### Формат parquet {#parquet}
Данный формат позволяет считывать содержимое файлов в формате [Apache Parquet](https://parquet.apache.org).

Поддерживаемые алгоритмы сжатия данных внутри файлов Parquet:
- Без сжатия
- SNAPPY
- GZIP
- LZO
- BROTLI
- LZ4
- ZSTD
- LZ4_RAW


{% cut "Пример запроса" %}

```sql
SELECT 
    * 
FROM `connection`.`path` 
WITH
(
    format=parquet, 
    SCHEMA
    (
        Year int, 
        Manufacturer string, 
        Model string, 
        Price double
    )
)
```

Результат выполнения запроса:

|#|Manufacturer|Model|Price|Year|
|-|-|-|-|-|
|1|Ford|E350|3000|1997|
|2|Chevy|Venture «Extended Edition»|4900|1999


{% endcut %}

## Пример чтения данных

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
        Year int,
        Manufacturer String,
        Model String,
        Price Double 
    )
);
```

Где:

|Поле|Описание|
|--|---|
|`connection`| Название соединения с {{ objstorage-full-name }}|
|`folder/filename.csv`| Путь к файлу в бакете {{ objstorage-full-name }}|
|`SCHEMA`| Описание схемы данных в файле|

## Поддерживаемые алгоритмы сжатия {#compression}

### Чтение

В {{ yq-full-name }} поддерживаются следующие алгоритмы сжатия данных для чтения:

|Формат сжатия|Название в {{ yq-name }}|
|--|--|
|[Gzip](https://ru.wikipedia.org/wiki/Gzip)|gzip|
|[Zstd](https://ru.wikipedia.org/wiki/Zstandard)|zstd|
|[LZ4](https://ru.wikipedia.org/wiki/LZ4)|lz4|
|[Brotli](https://ru.wikipedia.org/wiki/Brotli)|brotli|
|[Bzip2](https://ru.wikipedia.org/wiki/Bzip2)|bzip2|
|[Xz](https://ru.wikipedia.org/wiki/XZ)|xz|

Формат файлов parquet поддерживает собственные внутренние алгоритмы сжатия. {{ yq-full-name }} позволяет читать данные в формате parquet с использованием следующих алгоритмов сжатия:

|Формат сжатия|Название в {{ yq-name }}|
|--|--|
|[Raw](https://ru.wikipedia.org/wiki/Gzip)|raw|
|[Snappy](https://ru.wikipedia.org/wiki/Gzip)|snappy|

### Запись в {{ objstorage-full-name }} {#write_objstorage}

{% include [!](../_includes/supported-objstorage-write-formats.md) %}

### Запись в {{ yds-full-name }} {#write_yds}

{% include [!](../_includes/supported-yds-write-formats.md) %}