# Types of data storage in {{ GP }}

{{ GP }} enables you to use two [types of table data storage]({{ gp.docs.pivotal }}/6-16/admin_guide/ddl/ddl-storage.html):

* _Without clustered indexes_ (heap storage):

   This type of table supports _row-oriented_ data storage only. Such tables work best for online transaction processing (OLTP), when table data is often modified by `INSERT`, `UPDATE`, and `DELETE` operations.

   All tables created in {{ GP }} use this data storage type by default.

* _Append-optimized storage_:

   Tables of this type support both _row_ and _column_-oriented storage. They are good for online analytical processing (OLAP) of large data arrays, when data is loaded in large batches and mainly accessed by read queries.

   Column-oriented data storage reduces read and write overhead significantly when a query only accesses a small number of columns from the entire table field set. Column-oriented tables also get compressed better.

   When working with {{ GP }}, we recommend using column-oriented tables with standard compression of level 1 as an analytical DBMS.

## Creating column-oriented tables {#create-columnar-table}

To create a column-oriented table that supports compression, provide the parameters referring to the appropriate settings in the `CREATE TABLE` command:

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
