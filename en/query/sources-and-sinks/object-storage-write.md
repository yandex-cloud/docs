# Writing data to {{ objstorage-full-name }}

Example of writing `JSON` data to {{ objstorage-full-name }}

```sql
INSERT INTO bindings.`my_binding`
SELECT
    "value" as value, "name" as name
FROM
    $data;
```

For a list of supported formats and data compression algorithms, see [Write formats](formats.md#write).

## Writing data using connections

Data is written using SQL statements and generally looks like this:

```sql
INSERT INTO `<connection_name>`.`<bucket_path>`
    WITH
    (
        format='<format>',
        compression='<compression>'
    )
    <expression>
FROM
   <query>
```

Where:

- `connection_name` is the name of connection to {{objstorage-full-name}}.
- `bucket_path` is the path to the bucket that will store data.
- `query` is the {{ yq-full-name }} data source query.

It's convenient to write data using connections for prototyping and initial setup of data write operations.

Before writing data to {{objstorage-full-name}} buckets, create a [connection](object-storage.md) to {{objstorage-full-name}}.


### Example

Sample query to write data to {{ yds-full-name }} using connections

```sql
INSERT INTO `connection`.`test/`
    WITH
    (
        format='csv_with_names'
    )
SELECT
    "value" as value, "name" as name
```

Where:

|Field|Type|Description|
|--|---|---|
|`connection`| |Name of connection to {{ objstorage-full-name }}|
|`test/`| |Path within the {{objstorage-full-name}} bucket to write data to|



## Writing data using data bindings

Data is written using SQL statements and generally looks like this:

```sql
INSERT INTO bindings.`<binding_name>`
    WITH
    (
        format='<format>',
        compression='<compression>'
    )
    <expression>
FROM
   <query>
```

Where:

- `binding_name` is the name of binding to {{objstorage-full-name}} data.
- `query` is the {{ yq-full-name }} data source query.

It's convenient to write data using bindings for regular processes with no need to specify all details of operations with this data.

Before writing data to {{objstorage-full-name}} buckets, create a [binding](object-storage-binding.md) to {{objstorage-full-name}} data.


### Example

Sample query to write data to {{ yds-full-name }} using bindings

```sql
INSERT INTO bindings.`test`
SELECT
    "value" as value, "name" as name
```

Where:

|Field|Type|Description|
|--|---|---|
|bindings| |Keyword indicating that a data write is being performed using bindings|
|`test`| |Name of binding to data in {{ objstorage-full-name }}|

## Supported write formats

{% include [!](../_includes/supported-objstorage-write-formats.md) %}
