---
title: Sharding in {{ mgp-full-name }}
description: In this tutorial, you will learn about sharding and the distribution key.
---

# Sharding in {{ mgp-name }}

_Sharding_ is a horizontal {{ mgp-name }} cluster scaling strategy that spreads parts of each database table across different segment hosts. Every write or read request in {{ mgp-name }} utilizes all cluster segments.

## Distribution key {#distribution-key}

To optimize `JOIN` operations on large tables, you can specify a distribution key explicitly. In this case, when joining tables by the fields specified in the key, a join operation will be performed locally at the segment level, and the query processing will be faster.

Learn more about the distribution key in [Greenplum 6]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-sql_commands-CREATE_TABLE.html) and [Cloudberry](https://cloudberry.apache.org/docs/sql-stmts/create-table/).

To create a table with a distribution key, provide one or more required fields in the `DISTRIBUTED BY` clause:

```sql
CREATE TABLE tableName
(
    column1 type1,
    column2 type2,
    ...
    columnN typeN
) DISTRIBUTED BY (column1);
```

If you choose a key incorrectly, most of the data might be stored in a single segment. This will degrade the cluster performance or shut down the segment if its host runs out of storage space. This is why you should not select the following as your distribution key:

* Date and time fields.
* Fields that may contain a large number of identical values.
* Fields with a large number of `NULL` values.

{% note info %}

If you do not specify a distribution key when creating a table, data will be distributed across host segments either by the primary key (if specified) or by the first table field.

{% endnote %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

{% include [cloudberry-trademark](../../_includes/mdb/mgp/trademark-cloudberry.md) %}
