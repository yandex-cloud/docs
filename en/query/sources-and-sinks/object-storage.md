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
    <object_storage_connection_name>.`<file_path>`
WITH(format=<file_format>, <compression> AS compression)
WHERE
    <filter>;
```

Where:

* `object_storage_connection_name`: Name of the storage [connection](#create_connection).
* `file_path`: Path to a file or files in the bucket. `*` wildcards are supported.
* `file_format`: File [data format](formats.md#formats).
* `compression`: File [compression format](formats.md#compression_formats).

If the data is stored in compressed format, make sure to unpack it for handling. After unpacking, parse the data based on the format used to store it within the files.

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
        int as Year,
        String as Manufacturer,
        String as Model,
        Double as Price
    )
);
```

Where:

* `connection`: Name of the connection to {{ objstorage-short-name }}.
* `folder/filename.csv`: Path to the file in the {{ objstorage-short-name }} bucket.
* `SCHEMA`: Data schema description in the file.
