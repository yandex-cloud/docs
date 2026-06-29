---
title: Types of data storage in a {{ mgp-full-name }} cluster
description: '{{ mgp-name }} offers two types of table data storage: heap storage and append-optimized storage.'
---

# Types of data storage in {{ mgp-name }}

{{ mgp-name }} supports the following table storage types:

* _Heap storage_.

    This type of table supports _row-oriented_ data storage only. Such tables work best for online transaction processing (OLTP), when table data is often updated with `INSERT`, `UPDATE`, or `DELETE` operations.

    All tables created in {{ mgp-name }} use this data storage type by default.

    For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-ddl-ddl-storage.html#topic37) and [this {{ CB }} guide]({{ gp.docs.cloudberry }}/operate-with-data/heap-and-ao-table-formats#heap-storage).

* _Append-optimized storage_.

    Tables of this type support both _row_ and _column_-oriented storage. Tables for row and column-oriented storage are called append-optimized (AO) and append-optimized column-oriented (AOCO) tables, respectively. Both such table types are implemented based on auxiliary heap tables. AO and AOCO tables store data in segment files, which are made up of blocks of arbitrary size.

    AO and AOCO tables are good for online analytical processing (OLAP) of large data arrays, when data is loaded in large batches and mainly accessed by read queries.

    Column-oriented data storage reduces read and write overhead significantly when a query only accesses a small number of columns from the entire table field set. Column-oriented tables also get compressed better. When working with {{ mgp-name }}, we recommend using column-oriented tables with standard compression of level 1 as an analytical DBMS.

    For AO and AOCO tables in {{ mgp-name }} clusters, [hybrid storage](./hybrid-storage.md) is available: with the [{{ YZ }} extension](../operations/extensions/yezzey.md), you can move some of your tables from the cluster storage to a cold storage, and vice versa. Cold storage is a convenient option if you need to store your table data for a long time without using it much. This will make data storage [less costly](../pricing/index.md#rules-storage).

    For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-ddl-ddl-storage.html#topic38) and [this {{ CB }} guide]({{ gp.docs.cloudberry }}/operate-with-data/heap-and-ao-table-formats#append-optimized-storage).

* _PAX storage format_. This storage type is only available for {{ CB }} DBMS.

    PAX (Partition Attributes Across) is a format that combines the advantages of row-oriented and column-oriented database storage: table rows are grouped into blocks, while each block's data is stored in columns.

    This format is used to improve query performance, especially in terms of cache efficiency. Therefore, the PAX format is suitable for complex OLAP applications that need to process large volumes of write-heavy data and execute frequent queries.

    PAX format features:

    * Uses a data update and delete method without immediately overwriting the physical file.

    * Uses multi-version concurrency control (MVCC) for efficient concurrency management and read/write isolation. The detail of control is down to individual data files.

    * Supports B-tree indexes, which increase data retrieval speed when processing large volumes of information.

    * Offers several data encoding methods (e.g., RLE and delta encoding) and compression options (e.g., zstd and zlib) with different compression levels. These features help reduce storage volume and optimize read performance.

    * Adds detailed statistics on the data into the data files. These statistics are used for fast data filtering and query optimization.

    For more information, see [this {{ CB }} guide]({{ gp.docs.cloudberry }}/operate-with-data/pax-table-format).

* _Dynamic tables_ This storage type is only available for {{ CB }} DBMS.

    Dynamic tables are database objects similar to materialized views that automatically update data on a schedule and accelerate query execution. Dynamic tables can be created on top of base tables, external tables, or materialized views.

    Dynamic tables are suitable for cases where you need frequent up-to-date queries, such as for financial analysis or operational monitoring. In Lakehouse systems, dynamic table queries work faster than external table queries.

    For more information, see [this {{ CB }} guide]({{ gp.docs.cloudberry }}/performance/use-dynamic-tables).

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

## Use cases {#examples}

* [{#T}](../tutorials/mmy-to-mgp.md)

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

{% include [cloudberry-trademark](../../_includes/mdb/mgp/trademark-cloudberry.md) %}
