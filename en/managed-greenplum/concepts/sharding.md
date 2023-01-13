# Sharding in {{ GP }}

_Sharding_ is a horizontal {{ GP }} cluster scaling strategy that puts parts of each DB table on different segment hosts. Any write or read request in {{ GP }} utilizes all cluster segments.

By default, all tables in {{ GP }} are created with random distribution meaning that a segment for storing each row is determined randomly. This ensures even data distribution across segments.

## Distribution key {#distribution-key}

To optimize `JOIN` operations on large tables, you can specify a [distribution key](https://docs.greenplum.org/6-16/admin_guide/ddl/ddl-table.html) explicitly. In this case, when joining tables by the fields specified in the key, a join operation is performed locally at the segment level and query processing is faster.

To create a table with a distribution key, pass one or more required fields in the `DISTRIBUTED BY` clause:

```sql
CREATE TABLE tableName
(
    column1 type1,
    column2 type2,
    ...
    columnN typeN
) DISTRIBUTED BY (column1);
```

If you choose a key incorrectly, most of the data might be stored in a single segment. This will degrade cluster performance or shut down the cluster if its host runs out of storage space. Do not select the following as your distribution key:

* Date and time fields.
* Fields that may contain a large number of identical values.
* Fields with a large number of `NULL` values.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
