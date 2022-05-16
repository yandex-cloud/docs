---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/create_table.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/create_table.md
---
# CREATE TABLE


The `CREATE TABLE` call creates a [table]({{ concept_table }}) with the specified data schemaand key columns (`PRIMARY KEY`). It lets you define secondary indexes on the created table.

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


## Additional parameters {#additional}

You can also specify a number of {{ backend_name }}-specific parameters for the table. When creating a table using YQL, such parameters are listed in the ```WITH``` section:

```sql
CREATE TABLE table_name (...)
WITH (
    key1 = value1,
    key2 = value2,
    ...
)
```

Here, key is the name of the parameter and value is its value.

For a list of possible parameter names and their values, see [table description {{ backend_name }}]({{ concept_table }}).

For example, this code will create a table with enabled automatic partitioning by partition size and the preferred size of each partition is 512 MB:

<small>Listing 4</small>

```sql
CREATE TABLE my_table (
    id Uint64,
    title Utf8,
    PRIMARY KEY (id)
)
WITH (
    AUTO_PARTITIONING_BY_SIZE = ENABLED,
    AUTO_PARTITIONING_PARTITION_SIZE_MB = 512
);
```

## Column groups {#column-family}

Columns of the same table can be grouped to set the following parameters:

* `DATA`: A storage type for the data in this column group. Acceptable values: ```ssd```, ```hdd```.
* `COMPRESSION`: A data compression codec. Acceptable values: ```off```, ```lz4```.

By default, all columns are in the same group named ```default```.  If necessary, the parameters of this group can also be redefined.

In the example below, for the created table, the ```family_large``` group of columns is added and set for the ```series_info``` column, and the parameters for the ```default``` group, which is set by default for all other columns, are also redefined.

```sql
CREATE TABLE series_with_families (
    series_id Uint64,
    title Utf8,
    series_info Utf8 FAMILY family_large,
    release_date Uint64,
    PRIMARY KEY (series_id),
    FAMILY default (
        DATA = "ssd",
        COMPRESSION = "off"
    ),
    FAMILY family_large (
        DATA = "hdd",
        COMPRESSION = "lz4"
    )
);
```

