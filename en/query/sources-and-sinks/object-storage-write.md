# Writing data to {{ objstorage-full-name }}

In {{ yq-full-name }}, you can use [connections](#connection-write) or [bindings](#bindings-write) to write data to {{ objstorage-full-name }} buckets.

Query example for writing `JSON` data via a binding:

```sql
INSERT INTO `my_binding`
SELECT
    "value" AS value, "name" AS name
FROM
    $data;
```

For a list of supported data formats and compression algorithms, see [Supported write formats](#write-formats).

## Writing data via connections {#connection-write}

Connections are a convenient way to write data when prototyping or initially configuring data writing. To write data to a bucket, create a [connection](object-storage.md#create_connection) to {{ objstorage-short-name }} and then use the following SQL statement:

```sql
INSERT INTO <connection>.<path>
    WITH
    (
        format='<data_format>',
        compression='<compression_format>'
    )
SELECT
    <expression>
FROM
    <query>
```

Where:

* `<connection>`: {{ objstorage-short-name }} connection name.
* `<path>`: Target path within the bucket.
* `<query>`: {{ yq-name }} source data query.

### Example {#connection-write-example}

Query example for writing data to {{ objstorage-short-name }} via connections:

```sql
INSERT INTO `connection`.`test/`
    WITH
    (
        format='csv_with_names'
    )
SELECT
    "value" AS value, "name" AS name
```

Where:

* `connection`: {{ objstorage-short-name }} connection name.
* `test/`: Target path within the bucket.

## Writing data via bindings {#bindings-write}

If you need to write data regularly, you can use bindings to avoid specifying all data operation details in each query. To write data to a bucket, create a [binding](object-storage-binding.md) in {{ objstorage-short-name }} and then use the following SQL statement:

```sql
INSERT INTO `<binding>`
SELECT
    <expression>
FROM
    <query>
```

Where:

* `<binding>`: {{ objstorage-short-name }} data binding name.
* `<query>`: {{ yq-name }} source data query.

### Example {#bindings-write-example}

Query example for writing data to {{ objstorage-short-name }} via a binding:

```sql
INSERT INTO `test`
SELECT
    "value" AS value, "name" AS name
```

Where:

* `test`: {{ objstorage-short-name }} data binding name.

## Supported write formats {#write-formats}

{% include [!](../_includes/supported-objstorage-write-formats.md) %}
