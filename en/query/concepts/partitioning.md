# Data partitioning

{{ objstorage-full-name }} lets you store very large amounts of data. Queries may only affect some of this data. If you describe the markup rules for the structure of your data storage in {{ yq-full-name }}, then you don't even need to read data that isn't required for a query from {{ objstorage-full-name }}. This makes query execution much faster without affecting the results.

For example, data is stored in the following structure of folders:

```
year=2021
    month=01
    month=02
    month=03
year=2022
    month=01
```

In the query below, only the data for February 2021 should be processed, while the other data is not required.

```sql
SELECT
    *
FROM
    objectstorage.'/'
    WITH
    (
        Schema =
        (
            data String,
            year Int,
            month Int
        )
    )
WHERE
    year=2021
    AND month=02
```

If no data partitioning scheme is specified, _all_ stored data is read from {{ objstorage-full-name }}. However, as a result of processing, data for any other period is discarded.

If you explicitly specify the storage structure indicating that data in {{ objstorage-full-name }} is stored in folders by year and month
```sql
SELECT
    *
FROM
    objectstorage.'/'
    WITH
    (
        Schema =
        (
            data String,
            year Int,
            month Int
        ),
        partitioned_by =
        (
            year,
            month
        )
    )
WHERE
    year=2021
    AND month=02
```

when executing a query from {{ objstorage-full-name }}, instead of reading all the data, only data for February 2021 is read. This will greatly reduce the amount of data to handle and speed up data processing while the results of both queries will be identical.

{% note info %}

In the example above, operations with data are performed at the level of [connections](glossary.md#connection). This example is given for illustrative purposes only. We strongly recommend that you work with data using bindings and do not work with connections directly.

{% endnote %}

## Syntax {#syntax}

When working at the connection level, partitioning is set using the `partitioned_by` parameter.

```sql
SELECT
    *
FROM
    <connection>.<path>
WITH
(
    schema=(<field1>, <field2>, <field3>),
    partitioned_by=(field2, field3)
)
```


The `partitioned_by` parameter lists data schema columns used to partition data stored in {{ objstorage-full-name }}. The order of specifying fields in the partitioned_by parameter determines the nesting of {{ objstorage-full-name }} folders.

For example, `partitioned_by=(year, month)` defines the folder structure

```
year=2021
    month=01
    month=02
    month=03
year=2022
    month=01
```

And `partitioned_by=(month, year)` defines a different folder structure

```
month=01
    year=2021
    year=2022
month=02
    year=2021
month=03
    year=2021
```

## Supported data types

Partitioning is only possible by the following set of YQL data types:
- Uint16, Uint32, Uint64
- Int16, Int32, Int64
- String
- Bool

If other data types are used for partitioning, an error is returned.

## Supported storage path formats

Storage path format where each folder's name explicitly specifies a column name is called "[Hive-Metastore format](https://en.wikipedia.org/wiki/Apache_Hive)" or just "Hive format".

This format looks as follows:
```
month=01
    year=2021
    year=2022
month=02
    year=2021
month=03
    year=2021
```

{% note warning %}

The basic partitioning mode in {{ yq-full-name }} only supports Hive format.

{% endnote %}

To specify arbitrary storage paths, use the [Extended data partitioning](partition-projection.md) mode.