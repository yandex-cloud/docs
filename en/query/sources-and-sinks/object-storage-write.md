# Writing data to {{ objstorage-full-name }}

In {{ yq-full-name }}, to write data to {{ objstorage-full-name }} buckets, you can use [connections](#connection-write) or [bindings](#bindings-write).

Example of writing `JSON` data using bindings:

```sql
INSERT INTO bindings.`my_binding`
SELECT
    "value" as value, "name" as name
FROM
    $data;
```

For a list of supported formats and data compression algorithms, see [{#T}](#write-formats).

## Writing data using connections {#connection-write}

It is convenient to write data using connections for prototyping and initial setup of data write operations. Before writing data to a bucket, create a [connection](object-storage.md#create_connection) to {{ objstorage-short-name }} and use the following SQL statement:

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

* `connection_name`: Name of the connection to {{ objstorage-short-name }}.
* `bucket_path`: Path within the bucket to write data to.
* `query`: {{ yq-name }} data source query.

### Example {#connection-write-example}

Sample query to write data to {{ objstorage-short-name }} using connections:

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

* `connection`: Name of {{ objstorage-short-name }} connection.
* `test/`: Path within the bucket to write data to.

## Writing data using bindings {#bindings-write}

If you need to make data writes on a regular basis, it is handy to use bindings. This helps avoid entering all the details of handling this data in each query. Before writing data to a bucket, create a [data binding](object-storage-binding.md) in {{ objstorage-short-name }} and use the following SQL statement:

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

* `binding_name`: Name of binding to {{ objstorage-short-name }} data.
* `query`: {{ yq-name }} data source query.

### Example {#bindings-write-example}

Sample query to write data to {{ objstorage-short-name }} using bindings:

```sql
INSERT INTO bindings.`test`
SELECT
    "value" as value, "name" as name
```

Where:

* `bindings`: Keyword indicating that a data write is being performed using bindings.
* `test`: Name of the binding to {{ objstorage-short-name }} data.

## Supported write formats {#write-formats}

{% include [!](../_includes/supported-objstorage-write-formats.md) %}
