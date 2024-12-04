---
title: Sharding in {{ mgp-full-name }}
description: In this tutorial, you will learn about sharding and the distribution key.
---

# Sharding in {{ GP }}

_Sharding_ is a horizontal {{ GP }} cluster scaling strategy where parts of each database table are placed on different segment hosts. Every write or read request in {{ GP }} utilizes all cluster segments.

By default, all tables in {{ GP }} are created with random distribution, i.e., a segment for storing each row is determined randomly. This ensures even data distribution across segments.

## Distribution key {#distribution-key}

To optimize `JOIN` operations on large tables, you can specify a [distribution key]({{ gp.docs.vmware }}/7/greenplum-database/ref_guide-sql_commands-CREATE_TABLE.html) explicitly. In this case, when joining tables by the fields specified in the key, a join operation will be performed locally at the segment level, and the query processing will be faster.

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

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
