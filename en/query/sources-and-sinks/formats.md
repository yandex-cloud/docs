---
title: Data formats and compression algorithms
description: This article describes the data formats and compression algorithms supported in {{ yq-full-name }}.
---

# Data formats and compression algorithms

Below you will find the data formats and compression algorithms supported in {{ yq-full-name }}.

## Supported data formats {#formats}

{{ yql-full-name }} supports the following data formats:

* [`csv_with_names`](#csv-with-names)
* [`tsv_with_names`](#tsv-with-names)
* [`json_list`](#json-list)
* [`json_each_row`](#json-each-row)
* [`raw`](#raw)
* [`json_as_string`](#json-as-string)
* [`parquet`](#parquet).

### Csv_with_names {#csv-with-names}

This format is [CSV](https://ru.wikipedia.org/wiki/CSV)-based and keeps your data in comma-separated columns. The first line in the file contains the column names.

Sample data:
```text
Year,Manufacturer,Model,Price
1997,Ford,E350,3000.00
1999,Chevy,"Venture «Extended Edition»",4900.00
```

{% cut "Query example" %}

```sql
SELECT
    *
FROM <connection>.<path>
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

Query results:

|#|Manufacturer|Model|Price|Year|
|-|-|-|-|-|
|1|Ford|E350|3000|1997|
|2|Chevy|Venture «Extended Edition»|4900|1999


{% endcut %}


### Tsv_with_names {#tsv-with-names}

This format is [TSV](https://ru.wikipedia.org/wiki/TSV)-based and keeps your data in tab-separated columns (the tab char code is `0x9`). The first line in the file contains the column names.

Sample data:
```text
Year    Manufacturer    Model   Price
1997    Ford    E350    3000.00
1999    Chevy   "Venture «Extended Edition»"    4900.00
```

{% cut "Query example" %}

```sql
SELECT
    *
FROM <connection>.<path>
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

Query results:

|#|Manufacturer|Model|Price|Year|
|-|-|-|-|-|
|1|Ford|E350|3000|1997|
|2|Chevy|Venture «Extended Edition»|4900|1999


{% endcut %}

### Json_list {#json-list}

This format is [JSON](https://ru.wikipedia.org/wiki/JSON)-based. Each file must contain a list of objects in a valid JSON representation.

Example of valid data presented as a list of JSON objects:
```json
[
    { "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 },
    { "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
]
```

Example of invalid data, with objects not wrapped into a list:

```json
{ "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 }
{ "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
```

### Json_each_row {#json-each-row}

This format is [JSON](https://en.wikipedia.org/wiki/JSON)-based. Each line in the file must contain an object in a valid JSON representation. These objects are not wrapped into a JSON list. This format is used for data transmission over streaming systems, such as [{{ yds-full-name }}](../../data-streams/concepts/index.md).

Example of valid data: each line contains a separate JSON object, without wrapping them into a list:
```json
{ "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 },
{ "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
```

{% cut "Query example" %}

```sql
SELECT
    *
FROM <connection>.<path>
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

Query results:

|#|Manufacturer|Model|Price|Year|
|-|-|-|-|-|
|1|Ford|E350|3000|1997|
|2|Chevy|Venture «Extended Edition»|4900|1999


{% endcut %}

### Raw {#raw}

This format allows you to read the contents of files without any conversion. This data can then be split into rows and columns and processed via [YQL]({{ ydb.docs }}/yql/reference/udf/list/string).

Use this format when {{ yq-full-name }}'s built-in data parsing capabilities are insufficient.

{% cut "Query example" %}

```sql
SELECT
    *
FROM <connection>.<path>
WITH
(
    format=raw,
    SCHEMA
    (
        Data String
    )
)
```

Query results:

```text
Year,Manufacturer,Model,Price
1997,Ford,E350,3000.00
1999,Chevy,\"Venture «Extended Edition»\",4900.00
```

{% endcut %}

### Json_as_string {#json-as-string}

This format is [JSON](https://ru.wikipedia.org/wiki/JSON)-based. Instead of splitting the input JSON document into fields, it treats each line in the file as a single JSON object. Use this format when the list of fields may change across different messages.

With this format, each file must contain:
- Valid JSON object on each individual line of the file.
- Valid JSON objects wrapped in a list.

Example of valid data presented as a list of JSON objects:
```json
{ "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 }
{ "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
```


{% cut "Query example" %}

```sql
SELECT
    *
FROM <connection>.<path>
WITH
(
    format=json_as_string,
    SCHEMA
    (
        Data Json
    )
)
```

Query results:

|#|Data|
|-|-|
|1|`{"Manufacturer": "Ford", "Model": "E350", "Price": 3000, "Year": 1997}`|
|2|`{"Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900, "Year": 1999}`|


{% endcut %}

### Parquet {#parquet}

This format allows you to read the contents of [Apache Parquet](https://parquet.apache.org) files.

Within Parquet files, the following compression algorithms are supported:

* No compression
* `SNAPPY`
* `GZIP`
* `LZO`
* `BROTLI`
* `LZ4`
* `ZSTD`
* `LZ4_RAW`


{% cut "Query example" %}

```sql
SELECT
    *
FROM <connection>.<path>
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

Query results:

|#|Manufacturer|Model|Price|Year|
|-|-|-|-|-|
|1|Ford|E350|3000|1997|
|2|Chevy|Venture «Extended Edition»|4900|1999


{% endcut %}

## Data reading example {#read-example}

Query example for reading data from {{ objstorage-full-name }}:
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

Where:

|Field|Description|
|--|---|
|`connection`| {{ objstorage-full-name }} connection name|
|`folder/filename.csv`| File path within the {{ objstorage-full-name }} bucket|
|`SCHEMA`| Data schema description in the file|

## Supported compression algorithms {#compression}

### Reading {#compression-read}

{{ yq-full-name }} supports the following compression algorithms for reading data:

|Compression format|Name in {{ yq-name }}|
|--|--|
|[Gzip](https://ru.wikipedia.org/wiki/Gzip)|gzip|
|[Zstd](https://ru.wikipedia.org/wiki/Zstandard)|zstd|
|[LZ4](https://ru.wikipedia.org/wiki/LZ4)|lz4|
|[Brotli](https://ru.wikipedia.org/wiki/Brotli)|brotli|
|[Bzip2](https://ru.wikipedia.org/wiki/Bzip2)|bzip2|
|[Xz](https://ru.wikipedia.org/wiki/XZ)|xz|

While the Parquet format supports built-in compression algorithms, {{ yq-full-name }} also enables you to write Parquet data using these:

|Compression format|Name in {{ yq-name }}|
|--|--|
|[Raw](https://github.com/apache/parquet-format/blob/master/Compression.md)|raw|
|[Snappy](https://en.wikipedia.org/wiki/Snappy_(compression))|snappy|

### Writing to {{ objstorage-full-name }} {#write-objstorage}

{% include [!](../_includes/supported-objstorage-write-formats.md) %}

### Writing to {{ yds-full-name }} {#write-yds}

{% include [!](../_includes/supported-yds-write-formats.md) %}
