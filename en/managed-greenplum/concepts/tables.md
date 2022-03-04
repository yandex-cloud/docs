# Types of data storage in {{ GP }}

{{ GP }} lets you use two [table storage models](https://docs.greenplum.org/6-16/admin_guide/ddl/ddl-storage.html):

* _Without clustered indexes_ (heap storage)

    Heap-storage tables only provide _row-oriented_ data storage. They are best suited for online transaction processing (OLTP), when table data is often modified by `INSERT`, `UPDATE`, and `DELETE` operations.

    Heap tables are the default storage type in {{ GP }}.

* _Append-optimized storage_

    Tables with this storage type provide row and _column-oriented_ storage. They are good for analytical processing of large data arrays (OLAP), when data is loaded in large batches and accessed by read-only queries. `UPDATE` and `DELETE` operations are not allowed on append-optimized tables in {{ GP }}.

    Column-oriented table storage offers better query performance when reading and writing data since a query only accesses a small subset of columns in all table fields. Data in such tables is also compressed better.

    When working with {{ GP }}, we recommend using column-oriented tables with standard compression of level 1 as an analytical DBMS.

## Creating column-oriented tables {#create-columnar-table}

To create a column-oriented table that supports compression, pass the parameters responsible for the appropriate settings in the `CREATE TABLE` command:

```sql
CREATE TABLE tableName (...)
WITH (
    appendonly = true,
    orientation = column,
    compresstype = zstd,
    compresslevel = 1
);
```

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
