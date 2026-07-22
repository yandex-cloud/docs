[Документация Yandex Cloud](../../index.md) > [Yandex Query](../index.md) > Источники и приемники данных > Форматы данных и алгоритмы сжатия

# Форматы данных и алгоритмы сжатия

Ниже описаны поддерживаемые в Yandex Query форматы данных и алгоритмы сжатия.

## Поддерживаемые форматы данных {#formats}

В Yandex Query Language поддерживаются следующие форматы данных:

* [`csv_with_names`](#csv-with-names);
* [`tsv_with_names`](#tsv-with-names);
* [`json_list`](#json-list);
* [`json_each_row`](#json-each-row);
* [`raw`](#raw);
* [`json_as_string`](#json-as-string);
* [`parquet`](#parquet).

### Формат csv_with_names {#csv-with-names}

Формат основан на [CSV](https://ru.wikipedia.org/wiki/CSV). Данные размещаются в колонках, разделенных запятыми. Первая строка файла содержит имена колонок.

Пример данных:
```text
Year,Manufacturer,Model,Price
1997,Ford,E350,3000.00
1999,Chevy,"Venture «Extended Edition»",4900.00
```

{% cut "Пример запроса" %}

```sql
SELECT 
    * 
FROM <соединение>.<путь> 
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


### Формат tsv_with_names {#tsv-with-names}

Формат основан на [TSV](https://ru.wikipedia.org/wiki/TSV). Данные размещаются в колонках, разделенных символами табуляции с кодом `0x9`. Первая строка файла содержит имена колонок.

Пример данных:
```text
Year    Manufacturer    Model   Price
1997    Ford    E350    3000.00
1999    Chevy   "Venture «Extended Edition»"    4900.00
```

{% cut "Пример запроса" %}

```sql
SELECT 
    * 
FROM <соединение>.<путь> 
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

### Формат json_list {#json-list}

Формат основан на [JSON-представлении](https://ru.wikipedia.org/wiki/JSON) данных. Каждый файл должен содержать список объектов в корректном JSON-представлении.

Пример корректных данных (данные представлены в виде списка объектов JSON):
```json
[
    { "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 },
    { "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
]
```

Пример некорректных данных, в котором объекты не объединены в список:

```json
{ "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 }
{ "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
```

### Формат json_each_row {#json-each-row}

Формат основан на [JSON-представлении](https://ru.wikipedia.org/wiki/JSON) данных. Каждая строка файла должна содержать объект в корректном JSON-представлении. Объекты не объединяются в JSON-список. Такой формат используется при передаче данных через потоковые системы, например [Yandex Data Streams](../../data-streams/concepts/index.md).

Пример корректных данных (на каждой отдельной строке находится отдельный объект в формате JSON, но эти объекты не объединены в список):
```json
{ "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 },
{ "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
```

{% cut "Пример запроса" %}

```sql
SELECT 
    * 
FROM <соединение>.<путь> 
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

### Формат raw {#raw}

Формат позволяет считывать содержимое файлов без преобразований. Полученные данные можно обработать средствами [YQL](https://ydb.tech/docs/ru//yql/reference/udf/list/string), разделив на строки и столбцы.

Используйте этот формат, если встроенных возможностей разбора исходных данных в Yandex Query недостаточно.

{% cut "Пример запроса" %}

```sql
SELECT 
    * 
FROM <соединение>.<путь> 
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

```text
Year,Manufacturer,Model,Price
1997,Ford,E350,3000.00
1999,Chevy,\"Venture «Extended Edition»\",4900.00
```

{% endcut %}

### Формат json_as_string {#json-as-string}

Формат основан на [JSON-представлении](https://ru.wikipedia.org/wiki/JSON) данных. Он не разбивает входной JSON-документ на поля, а представляет каждую строку файла в виде одного объекта JSON. Используйте этот формат, если список полей может изменяться в разных сообщениях.

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
FROM <соединение>.<путь> 
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

### Формат parquet {#parquet}

Формат позволяет считывать содержимое файлов [Apache Parquet](https://parquet.apache.org).

Поддерживаются следующие алгоритмы сжатия внутри файлов Parquet:

* без сжатия;
* `SNAPPY`;
* `GZIP`;
* `LZO`;
* `BROTLI`;
* `LZ4`;
* `ZSTD`;
* `LZ4_RAW`.


{% cut "Пример запроса" %}

```sql
SELECT 
    * 
FROM <соединение>.<путь> 
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

## Пример чтения данных {#read-example}

Пример запроса для чтения данных из Yandex Object Storage:
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
|`connection`| Название соединения с Yandex Object Storage|
|`folder/filename.csv`| Путь к файлу в бакете Yandex Object Storage|
|`SCHEMA`| Описание схемы данных в файле|

## Поддерживаемые алгоритмы сжатия {#compression}

### Чтение {#compression-read}

В Yandex Query поддерживаются следующие алгоритмы сжатия данных для чтения:

|Формат сжатия|Название в Query|
|--|--|
|[Gzip](https://ru.wikipedia.org/wiki/Gzip)|gzip|
|[Zstd](https://ru.wikipedia.org/wiki/Zstandard)|zstd|
|[LZ4](https://ru.wikipedia.org/wiki/LZ4)|lz4|
|[Brotli](https://ru.wikipedia.org/wiki/Brotli)|brotli|
|[Bzip2](https://ru.wikipedia.org/wiki/Bzip2)|bzip2|
|[Xz](https://ru.wikipedia.org/wiki/XZ)|xz|

Формат Parquet поддерживает собственные алгоритмы сжатия. Yandex Query позволяет читать данные в формате Parquet с использованием следующих алгоритмов:

|Формат сжатия|Название в Query|
|--|--|
|[Raw](https://github.com/apache/parquet-format/blob/master/Compression.md)|raw|
|[Snappy](https://en.wikipedia.org/wiki/Snappy_(compression))|snappy|

### Запись в Yandex Object Storage {#write-objstorage}

В настоящий момент поддерживается запись в следующих форматах:

|Формат данных|Название в Query|
|--|--|
|[CSV](https://ru.wikipedia.org/wiki/CSV)|[csv_with_names](formats.md#csv-with-names)|
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

### Запись в Yandex Data Streams {#write-yds}

В Data Streams можно выполнять запись только в виде байтового потока, который интепретируется на принимающей стороне. 

Настройки форматов файлов и алгоритмов сжатия при записи в Data Streams не применяются.