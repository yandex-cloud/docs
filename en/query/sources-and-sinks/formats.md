# Data formats and compression algorithms

Below are the data formats and compression algorithms supported in {{ yq-full-name }}.


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
This format is based on [CSV](https://ru.wikipedia.org/wiki/CSV) format. Data is comma-separated and stored in columns with the first file line containing column names.

Sample data:
```text
Year,Manufacturer,Model,Price
1997,Ford,E350,3000.00
1999,Chevy,"Venture «Extended Edition»",4900.00
```

{% cut "Request example" %}

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
This format is based on [TSV](https://ru.wikipedia.org/wiki/TSV) format. Data is tab-separated (the `0x9` code) and stored in columns with the first file line containing column names.

Sample data:
```text
Year    Manufacturer    Model   Price
1997    Ford    E350    3000.00
1999    Chevy   "Venture «Extended Edition»"    4900.00
```

{% cut "Request example" %}

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
This format is based on a [JSON representation](https://ru.wikipedia.org/wiki/JSON) of data. In this format, each file should contain an object in a correct JSON representation.

Example of correct data (represented as a list of JSON objects):
```json
[
    { "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 },
    { "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
]
```

Example of INCORRECT data (each line contains a separate object in JSON format, but these objects are not represented as a list):

```json
{ "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 }
{ "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
```

#### Json_each_row {#json_each_row}
This format is based on a [JSON representation](https://en.wikipedia.org/wiki/JSON) of data. In this format, each file's individual line must contain an object in a valid JSON representation without combining these objects into a JSON list. This format is used when transferring data via streaming systems, such as [Yandex Data Streams](../../data-streams/concepts/index.md).

Example of correct data (each line contains a separate object in JSON format, but these objects are not represented as a list):
```json
{ "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 },
{ "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
```

{% cut "Request example" %}

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
This format allows reading raw data as is. The data read this way can be processed using [YQL]({{ ydb.docs }}/yql/reference/udf/list/string) tools by splitting it into rows and columns.

Use this format if the built-in features for parsing source data in {{ yq-full-name }} are insufficient.

{% cut "Request example" %}

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
This format is based on a [JSON representation](https://ru.wikipedia.org/wiki/JSON) of data. It does not split an input JSON document into fields. Instead, it represents each file line as a single JSON object (or a single string). This format is convenient if a list of fields is not permanent and may change in different messages.

In this format, each file should contain:
- Object in a valid JSON representation in each file line.
- List of objects in a valid JSON representation.

Example of correct data (represented as a list of JSON objects):
```json
{ "Year": 1997, "Manufacturer": "Ford", "Model": "E350", "Price": 3000.0 }
{ "Year": 1999, "Manufacturer": "Chevy", "Model": "Venture «Extended Edition»", "Price": 4900.00 }
```


{% cut "Request example" %}

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
This format allows you to read the contents of a file in [Apache Parquet](https://parquet.apache.org) format.

Data compression algorithms supported in Parquet files:
- No compression.
- SNAPPY
- GZIP
- LZO
- BROTLI
- LZ4
- ZSTD
- LZ4_RAW


{% cut "Request example" %}

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

## Example of reading data

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
|`folder/filename.csv`| Path to the file in the {{ objstorage-full-name }} bucket|
|`SCHEMA`| Data schema description in the file|

## Supported compression algorithms {#compression}

### Reads

{{ yq-full-name }} supports the following compression algorithms for data reads:

|Compression format|Name in {{ yq-name }}|
|--|--|
|[Gzip](https://ru.wikipedia.org/wiki/Gzip)|gzip|
|[Zstd](https://ru.wikipedia.org/wiki/Zstandard)|zstd|
|[LZ4](https://ru.wikipedia.org/wiki/LZ4)|lz4|
|[Brotli](https://ru.wikipedia.org/wiki/Brotli)|brotli|
|[Bzip2](https://ru.wikipedia.org/wiki/Bzip2)|bzip2|
|[Xz](https://ru.wikipedia.org/wiki/XZ)|xz|

The `parquet` file format supports its own internal compression algorithms. {{ yq-full-name }} enables reading data in `parquet` format using the following compression algorithms:

|Compression format|Name in {{ yq-name }}|
|--|--|
|[Raw](https://ru.wikipedia.org/wiki/Gzip)|raw|
|[Snappy](https://ru.wikipedia.org/wiki/Gzip)|snappy|

### Writing data to {{ objstorage-full-name }} {#write_objstorage}

{% include [!](../_includes/supported-objstorage-write-formats.md) %}

### Writing data to {{ yds-full-name }} {#write_yds}

{% include [!](../_includes/supported-yds-write-formats.md) %}