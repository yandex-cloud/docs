# Чтение данных из {{ objstorage-full-name }}

[{{ objstorage-full-name }}](../../storage/concepts/index.md) позволяет эффективно хранить большие объемы данных в виде древовидной структуры, состоящей из папок и файлов.

{{ yq-full-name }} позволяет считывать содержимое файлов, хранящихся в {{ objstorage-full-name }}, структурировать их и выполнять над ними SQL-запросы.

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

 {% note info %}

 На время технического превью максимальный объем данных, считываемых из {{ objstorage-full-name }} должен быть меньше 1 ГБ.

 {% endnote %}

## Настройка подключения

Для чтения данных из {{ objstorage-full-name }} необходимо:
1. Перейти в интерфейс {{ yq-full-name }} в раздел "Connections" и нажать кнопку "Create".
1. В открывшемся окне в поле `Name` указать название подключения к {{ objstorage-full-name }}.
1. В выпадающем поле `Type` выбрать `Object Storage`.
1. В поле `Bucket auth` выбрать `Public` или `Private`. `Public` означает, что бакет, откуда производится чтение, не защищен авторизацией. `Private` означает, что необходимо использовать данные, указанные в поле `Service Account`, при обращении к бакету.
1. В поле `Service account` выбрать сервисный аккаунт, который будет использоваться для чтения данных, или создать новый, выдав ему права [`storage.viewer`](../../storage/security/index.md).
1. Создать подключение, нажав кнопку `Create`.

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
- `file_format` — [формат данных](#formats) в файлах.
- `compression` — [формат сжатия](#compression_formats) файлов.

Если данные хранятся в сжатом состоянии, их необходимо распаковать для обработки. После распаковки данные нужно разобрать в соответствии с их форматом хранения внутри файлов.

### Поддерживаемые форматы сжатия файлов { #compression_formats }

|Формат сжатия|Название в {{ yq-short-name }}|
|--|--|
|[Gzip](https://ru.wikipedia.org/wiki/Gzip)|gzip|
|[Zstd](https://ru.wikipedia.org/wiki/Zstandard)|zstd|
|[LZ4](https://ru.wikipedia.org/wiki/LZ4)|lz4|
|[Brotli](https://ru.wikipedia.org/wiki/Brotli)|brotli|
|[Bzip2](https://ru.wikipedia.org/wiki/Bzip2)|bzip2|
|[Xz](https://ru.wikipedia.org/wiki/XZ)|xz|

### Поддерживаемые форматы файлов { #formats }
В {{yql-full-name}} поддерживаются следующие форматы файлов:
- [`csv_with_names`](#csv_with_names).
- [`tsv_with_names`](#tsv_with_names).
- [`json_list`](#json_list).
- [`json_each_row`](#json_each_row).
- [`raw`](#raw).
- [`json_each_row`](#json_each_row).
- [`json_as_string`](#json_as_string).
- [`parquet`](#parquet). 

{% if version>0.1 %}
- [`JSONEachRow`](#JSONEachRow).
{% endif %}

#### Формат csv_with_names { #csv_with_names }
Данный формат основан на формате [`CSV`](https://ru.wikipedia.org/wiki/CSV). Данные размещены в колонках, разделены запятыми, на первой строке файла находятся имена колонок.

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


#### Формат tsv_with_names { #tsv_with_names }
Данный формат основан на формате [`TSV`](https://ru.wikipedia.org/wiki/TSV). Данные размещены в колонках, разделены символами табуляции (код `0x9`), в первой строке файла находятся имена колонок.

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

#### Формат json_list { #json_list }
Данный формат основан на [`JSON-представлении`](https://ru.wikipedia.org/wiki/JSON) данных. В этом формате внутри каждого файла должен находиться объект в корректном JSON-представлении.

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

#### Формат json_each_row { #json_each_row }
Данный формат основан на [`JSON-представлении`](https://ru.wikipedia.org/wiki/JSON) данных. В этом формате в каждой строке входного файла находится объект в JSON-представлении.

Пример корректных данных (данные представлены в виде JSON-представления объекта в каждой отдельной строке):
```json
{ "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 }
{ "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
```

#### Формат raw { #raw }
Данный формат позволяет считывать содержимое файлов как есть, в "сыром" виде. Считанные таким образом данные можно обработать средствами [YQL]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/udf/list/string){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/udf/list/string){% endif %}, разделив на строки и столбцы.

Этот формат стоит использовать, если встроенных возможностей парсинга исходных данных в {{yq-full-name}} не достаточно.

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

#### Формат json_each_row { #json_each_row }
Данный формат основан на [`JSON-представлении`](https://ru.wikipedia.org/wiki/JSON) данных. В этом формате внутри каждого файла на каждой отдельной строке файла должен находиться объект в корректном JSON-представлении, но эти объекты не объединены в JSON-список. Такой формат используется при передаче данных через потоковые системы, типа [Yandex Data Streams](../../data-streams/concepts/index.md).

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

#### Формат json_as_string { #json_as_string }
Данный формат основан на [`JSON-представлении`](https://ru.wikipedia.org/wiki/JSON) данных. Данный формат не разбивает входной JSON-документ на поля, а представляет кажду строку файла в виде одного объекта JSON (или одной строки). Такой формат удобен, если список полей не фиксирован и может изменяться в разных сообщениях.

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

#### Формат parquet { #parquet }
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
