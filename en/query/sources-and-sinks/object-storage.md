# Reading data from {{ objstorage-name }} using {{ yq-name }} connections

When working with {{ objstorage-full-name }}, it is convenient to use connections for prototyping and initial setup of connections to data.

Sample query for reading data:

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

## Setting up a connection {#create_connection}

To create a connection to {{ objstorage-short-name }}:

{% include [!](../_includes/create-object-storage-connection.md) %}

## Data model {#data_model}

{{ objstorage-short-name }} stores data as binary files. To read data, use the following SQL statement:

```sql
SELECT
    <expression>
FROM
    <connection>.<path>
WITH(
    FORMAT = "<data_format>",
    COMPRESSION = "<compression_format>",
    SCHEMA = (<schema_description>))
WHERE
    <filter>;
```

Where:

* `<connection>`: Name of the storage [connection](#create_connection).
* `<path>`: Path to a file or files in the bucket. Wildcard characters (`*`) are supported.
* `<data_format>`: [Data format](formats.md#formats) in the files.
* `<compression_format>`: File [compression format](formats.md#compression_formats).
* `<schema_description>`: [Data schema description](#schema) in the files.

### Data schema description {#schema}

Data schema description includes the following fields:

- Field name
- Field type
- Attribute indicating a required field

For example, the below data schema describes a required schema field named `Year` of the `Int32` type:

```text
Year Int32 NOT NULL
```

If a field is marked as required (`NOT NULL`) but it is missing from the file being processed, this operation will fail with an error. If a field is marked as optional (`NULL`), no error will occur if that field is missing from the file being processed but the field will take the `NULL` value. The `NULL` keyword in optional fields is optional.

### Automatic output of a data schema {#inferring}

Automatic output of a schema is available for all [data formats](formats.md#formats) except `raw` and `json_as_string`. This is convenient when a schema contains a large number of fields. To avoid entering these fields manually, use the `WITH_INFER` parameter:

```sql
SELECT
    <expression>
FROM
    <connection>.<path>
WITH(
    FORMAT = "<data_format>",
    COMPRESSION = "<compression_format>",
    WITH_INFER="true")
WHERE
    <filter>;
```

Where:

* `<connection>`: Name of the storage [connection](#create_connection).
* `<path>`: Path to a file or files in the bucket. Wildcard characters (`*`) are supported.
* `<data_format>`: [Data format](formats.md#formats) in the files.
* `<compression_format>`: File [compression format](formats.md#compression_formats).


This request will automatically output field names and types.

### Data path formats {#path_format}

{{ yq-full-name }} supports the following paths to data:

{% include [!](../_includes/object-storage-path-format.md) %}

## Example of reading data using connections {#read_example}

Sample query for reading data from {{ objstorage-short-name }}:

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

* `connection`: Name of the connection to {{ objstorage-short-name }}.
* `folder/filename.csv`: Path to the file in the {{ objstorage-short-name }} bucket.
* `SCHEMA`: Data schema description in the file.
