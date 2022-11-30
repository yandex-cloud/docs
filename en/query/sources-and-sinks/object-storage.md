# Reading data from {{ objstorage-name }} using connections to {{ yq-name }}

When working with {{ objstorage-full-name }}, it's convenient to use connections for prototyping and initial setup of connections to data.

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

To read data from {{ objstorage-full-name }}:

{% include [!](../_includes/create-object-storage-connection.md) %}

## Data model

{{ objstorage-full-name }} stores data as binary files. Data is read using the SQL statement:

```sql
SELECT
    <expression>
FROM
    <object_storage_connection_name>.`<file_path>`
WITH(format=<file_format>, <compression> AS compression)
WHERE
    <filter>;
```

Where:

- `object_storage_connection_name` is the name of the storage connection created in the previous step.
- `file_path` is the path to a file or files in the bucket. `*` wildcards are supported.
- `file_format` is the file [data format](formats.md#formats).
- `compression` is the file [compression format](formats.md#compression_formats).

If compressed data is stored, be sure to unpack it for handling. After unpacking, the data should be parsed based on the format of storing it in files.

### Data path formats {#path_format}

{{yq-full-name}} supports the following paths to data:

{% include [!](../_includes/object-storage-path-format.md) %}

## Example of reading data using connections

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
        int as Year,
        String as Manufacturer,
        String as Model,
        Double as Price
    )
);
```

Where:

|Field|Description|
|--|---|
|`connection`| {{ objstorage-full-name }} connection name|
|`folder/filename.csv`| Path to the file in the {{ objstorage-full-name }} bucket|
|`SCHEMA`| Description of the file data schema|
