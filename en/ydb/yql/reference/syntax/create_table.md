# CREATE TABLE

Create a table with the specified data schema and `PRIMARY KEY` (key column):

```sql
CREATE TABLE table_name (
    column1 type1,
    column2 type2,
    ...
    columnN typeN,
    PRIMARY KEY (column, ...)
)
```

For the key and non-key columns, you can only use [primitive](../types/primitive.md) data types.

It is mandatory to specify the `PRIMARY KEY` with a non-empty list of columns. Those columns become part of the key in the listed order.

**Example**

```sql
CREATE TABLE my_table (
    a Uint64,
    b Bool,
    c Float,
    PRIMARY KEY (b, a)
)
```

## Adding secondary indexes {#si-add}

{% include [add_secondary_index](../../../_includes/add-secondary-index.md) %}

