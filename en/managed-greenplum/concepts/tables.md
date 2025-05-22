---
title: Types of data storage in a {{ GP }} cluster in {{ mgp-full-name }}
description: '{{ GP }} offers two types of table data storage: heap storage and append-optimized storage.'
---

# Types of data storage in {{ GP }}

{{ GP }} offers two [types of table data storage]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-ddl-ddl-storage.html):

* _Heap storage_.

    This type of table supports _row-oriented_ data storage only. Such tables work best for online transaction processing (OLTP), when table data is often updated with `INSERT`, `UPDATE`, or `DELETE` operations.

    All tables created in {{ GP }} use this data storage type by default.

* _Append-optimized storage_.

    Tables of this type support both _row_ and _column_-oriented storage. Tables for row and column-oriented storage are called append-optimized (AO) and append-optimized column-oriented (AOCO) tables, respectively. Both such table types are implemented based on auxiliary heap tables. AO and AOCO tables store data in segment files, which are made up of blocks of arbitrary size.

    AO and AOCO tables are good for online analytical processing (OLAP) of large data arrays, when data is loaded in large batches and mainly accessed by read queries.

    Column-oriented data storage reduces read and write overhead significantly when a query only accesses a small number of columns from the entire table field set. Column-oriented tables also get compressed better. When working with {{ GP }}, we recommend using column-oriented tables with standard compression of level 1 as an analytical DBMS.

    For AO and AOCO tables in {{ mgp-name }} clusters, [hybrid storage](./hybrid-storage.md) is available: with the [{{ YZ }} extension](../operations/extensions/yezzey.md), you can move some of your tables from the cluster storage to a cold storage, and vice versa. Cold storage is a convenient option if you need to store your table data for a long time without using it much. This will make data storage [less costly](../pricing/index.md#rules-storage).

## Creating column-oriented tables {#create-columnar-table}

To create a column-oriented table with compression, provide the parameters with the appropriate settings in the `CREATE TABLE` command:

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
