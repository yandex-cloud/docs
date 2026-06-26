# Data formats and compression algorithms

Below you will find the data formats and compression algorithms supported in {{ yq-full-name }}.


### Supported data formats {#formats}
{{ yql-full-name }} supports the following data formats:
- [`csv_with_names`](#csv_with_names).
- [`tsv_with_names`](#tsv_with_names).
- [`json_list`](#json_list).
- [`json_each_row`](#json_each_row).
- [`raw`](#raw).
- [`json_as_string`](#json_as_string).
- [`parquet`](#parquet). 

#### Csv_with_names {#csv_with_names}
This format is based on the [CSV](https://ru.wikipedia.org/wiki/CSV) format. The data is arranged in comma-separated columns with the first row containing column names.

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


#### Tsv_with_names {#tsv_with_names}
This format is based on the [TSV](https://ru.wikipedia.org/wiki/TSV) format. The data is arranged in tab(`0x9`)-separated columns with the first row containing column names.

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

#### Json_list {#json_list}
This format is based on the [JSON](https://ru.wikipedia.org/wiki/JSON) format. With this format, each file must contain a valid JSON object.

Example of valid data presented as a list of JSON objects:
```json
[
    { "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 },
    { "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
]
```

Example of invalid data: each line contains a separate JSON object, but these objects are not combined into a list:

```json
{ "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 }
{ "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
```

#### Json_each_row {#json_each_row}
This format is based on the [JSON](https://en.wikipedia.org/wiki/JSON) format. With this format, each individual line within each file must contain a valid JSON object, without wrapping them into a list. This format is used for data transmission over streaming systems, such as [Yandex Data Streams](../../data-streams/concepts/index.md).

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

#### Raw {#raw}
This format allows reading file contents in raw form. This data can then be split into rows and columns and processed via [YQL]({{ ydb.docs }}/yql/reference/udf/list/string).

Use this format when {{ yq-full-name }}‘s built-in data parsing capabilities are insufficient.

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

#### Json_as_string {#json_as_string}
This format is based on the [JSON](https://ru.wikipedia.org/wiki/JSON) format. Instead of splitting the input JSON document into fields, this format treats each line of the file either as a single JSON object or a single string. It is convenient when the list of fields is not fixed and may change across different messages.

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

#### Parquet {#parquet}
This format allows you to read the contents of [Apache Parquet](https://parquet.apache.org) files.

Data compression algorithms supported in Parquet files:
- No compression
- SNAPPY
- GZIP
- LZO
- BROTLI
- LZ4
- ZSTD
- LZ4_RAW


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

## Data reading example

Sample query for reading data from {{ objstorage-full-name }}.
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

### Reads

{{ yq-full-name }} supports the following compression algorithms for reading data:

|Compression format|Name in {{ yq-name }}|
|--|--|
|[Gzip](https://ru.wikipedia.org/wiki/Gzip)|gzip|
|[Zstd](https://ru.wikipedia.org/wiki/Zstandard)|zstd|
|[LZ4](https://ru.wikipedia.org/wiki/LZ4)|lz4|
|[Brotli](https://ru.wikipedia.org/wiki/Brotli)|brotli|
|[Bzip2](https://ru.wikipedia.org/wiki/Bzip2)|bzip2|
|[Xz](https://ru.wikipedia.org/wiki/XZ)|xz|

While the `parquet` format supports built-in compression algorithms, {{ yq-full-name }} also enables you to write parquet data using these:

|Compression format|Name in {{ yq-name }}|
|--|--|
|[Raw](https://github.com/apache/parquet-format/blob/master/Compression.md)|raw|
|[Snappy](https://en.wikipedia.org/wiki/Snappy_(compression))|snappy|

### Writing to {{ objstorage-full-name }} {#write_objstorage}

{% include [!](../_includes/supported-objstorage-write-formats.md) %}

### Writing to {{ yds-full-name }} {#write_yds}

{% include [!](../_includes/supported-yds-write-formats.md) %}
