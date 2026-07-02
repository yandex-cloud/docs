# Reading data from {{ objstorage-name }} via {{ yq-name }} connections

Using {{ objstorage-full-name }} connections is convenient for prototyping and initial data access configuration.

Query example for reading data:

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

* `<connection>`: Storage [connection](#create_connection) name.
* `<path>`: Path to file(s) within the bucket. Supports the `*` wildcard.
* `<data_format>`: File [data format](formats.md#formats).
* `<compression_format>`: File [compression format](formats.md#compression_formats).
* `<data_schema>`: [Description of data](#schema) stored in files.

### Data schema {#schema}

The data schema includes the following fields:

- Field name
- Field type
- Required flag

For example, the schema below describes a required field `Year` of type `Int32`:

```text
Year Int32 NOT NULL
```

If a `NOT NULL` field is missing from the file being processed, the operation will terminate with an error. If a nullable field is missing from the file being processed, no error will occur, and the field will be set to `NULL`. The `NULL` keyword may be omitted in nullable fields.

### Automatic schema inference {#inferring}

Automatic schema inference is supported for all [data formats](formats.md#formats) except `raw` and `json_as_string`. It is convenient when a schema has many fields. Instead of entering them manually, you can use the `WITH_INFER` hint:

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

* `<connection>`: Storage [connection](#create_connection) name.
* `<path>`: Path to file(s) within the bucket. Supports the `*` wildcard.
* `<data_format>`: File [data format](formats.md#formats).
* `<compression_format>`: File [compression format](formats.md#compression_formats).


This query will automatically infer field names and types.

### Data path formats {#path_format}

{{ yq-full-name }} supports the following data path formats:

{% include [!](../_includes/object-storage-path-format.md) %}

## Example of reading data via connections {#read_example}

Query example for reading data from {{ objstorage-short-name }}:

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

* `connection`: {{ objstorage-short-name }} connection name.
* `folder/filename.csv`: File path within the {{ objstorage-short-name }} bucket.
* `SCHEMA`: Data schema described in the file.
