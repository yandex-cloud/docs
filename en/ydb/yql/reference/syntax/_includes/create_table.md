---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/create_table.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/create_table.md
---

# CREATE TABLE


The `CREATE TABLE` call creates a table with the specified data schemaand key columns (`PRIMARY KEY`). It lets you define secondary indexes on the created table.

    CREATE TABLE table_name (
        column1 type1,

        column2 type2,
...
columnN typeN,
INDEX index1_name GLOBAL ON ( column ),
INDEX index2_name GLOBAL ON ( column1, column2, ... ),
PRIMARY KEY (column, ...),
FAMILY column_family ()
)
WITH ( key = value, ... )

## Columns {#columns}

For key columns and non-key columns, only [primitive](../../types/primitive.md) data types are allowed.

All columns allow writing `NULL` values, that is, they are [optional](../../types/optional.md).
It is mandatory to specify the `PRIMARY KEY` with a non-empty list of columns. Those columns become part of the key in the listed order.

**Example**

    CREATE TABLE my_table (
        a Uint64,
        b Bool,

        c Float,
PRIMARY KEY (b, a)
)


## Secondary indexes {#secondary_index}

The INDEX construct is used to define a secondary index in a table:

```sql
CREATE TABLE table_name ( 
    ...
    INDEX <Index_name> GLOBAL [SYNC|ASYNC] ON ( <Index_columns> ) COVER ( <Cover_columns> ),
    ...
)
```

where:

* **Index_name** is the unique name of the index to be used to access data.
* **SYNC/ASYNC** indicates synchronous/asynchronous data writes to the index. If not specified, synchronous.
* **Index_columns** is a list of comma-separated names of columns in the created table to be used for a search in the index.
* **Cover_columns** is a list of comma-separated names of columns in the created table, which will be stored in the index in addition to the search columns, making it possible to fetch additional data without accessing the table for it.

**Example**

```sql
CREATE TABLE my_table (
    a Uint64,
    b Bool,
    c Uft8,
    d Date,
    INDEX idx_a GLOBAL ON (d),
    INDEX idx_ca GLOBAL ASYNC ON (b, a) COVER ( c ),
    PRIMARY KEY (a)
)
```

