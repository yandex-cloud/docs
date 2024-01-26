# Data transformations

Transformation is converting data using special transformer functions. These functions are executed on a data stream, applied to each data change item, and transform them. A transformer can be run at both the metadata and data levels.

You can set up data transformations when [creating](../operations/transfer.md#create) or [updating](../operations/transfer.md#update) a transfer.

Data can only be transformed if the source and target are of different [types](../concepts/index.md#connectivity-matrix).

Transformers are set as a list. When activating a transfer, a transformation plan is made for the tables that match the specified criteria. Transformers are applied to the tables in the sequence specified in the list.

## Transformer types {#transformers-types}

Some transformers may have limitations and only apply to some source-target pairs. The list of transformers will be updated moving forward. Currently, the following types are available:

{% include [list-of-transformers](../../_includes/data-transfer/list-of-transformers.md) %}

### Renaming tables {#rename-tables}

You can set rules for renaming tables by specifying the current names of the tables in the source and new names for these tables in the target.

### Columns filter {#columns-filter}

You can set up a list of table columns to transfer:

1. List the tables to filter using lists of included and excluded tables.
1. List the columns to transfer to the target tables using lists of included and excluded columns.

### Data masking {#data-mask}

You can hash data as follows:

1. List the tables to mask data in using lists of included and excluded tables.
1. Specify the name of the column for data masking (a regular expression). For each column, set a salt value (a string of the password type). This string will be used in the `HMAC(sha256, salt)` function applied to the column data.

### Splitting tables into subtables {#subtable-splitting}

A transfer splits the `X` table into multiple tables (`X_1`, `X_2`, …, `X_n`) based on data. If a row was located in the `X` table before it was split, it is now in the `X_i` table, where `i` is determined by the column list and split string parameters.

> Example:
> If the column list has two columns, `month of birth` and `gender`, specified and the split string states `@`, information about an employee whose name is John and who was born on February 11, 1984, from the `Employees` table will get to a new table named `Employees@February@male`.

To partition tables:

1. Use lists of included and excluded tables to list the required tables.
1. Specify the columns in the tables to be partitioned.
1. Specify the split string to be used for merging components in a new table name.

### Replacing primary keys {#replace-primary-key}

To override primary keys, specify a list of included and excluded tables and a list of columns to be used as primary keys.

### Converting column values to strings {#convert-to-string}

To convert column values to string values, specify a list of included and excluded tables and a list of columns. The values will be converted depending on the source type:

| Source type | Format |
|--------------|---------------------------------------------------|
| Any | Serialized JSON format |
| Date | String in `2006-01-02` format |
| DateTime | String in `2006-01-02T15:04:05.999999999Z07:00` format |

### Sharding {#shard}

Set the number of shards for particular tables and a list of columns whose values will be used for calculating a hash to determine a shard.

### String filter for APPEND-ONLY sources {#append-only-sources}

This filter only applies to transfers with queues ({{ KF }}) as a data source. When running a transfer, only the strings meeting the specified criteria remain in a changefeed.

1. List the tables to filter data in using lists of included and excluded tables.
1. Set a filtering criterion. This can be comparison operators for numeric, string, and Boolean values, comparison to NULL, and checking whether a substring is part of a string.

Filtering criteria are specified by a set of rules separated by the `AND` keyword. Acceptable operators are `>`, `>=`, `<`, `<=`, `=`, `!=`, `~` (a substring is part of a string), `!~` (a substring is not part of a string). All columns listed in the filter must be present in the table being filtered.
Here is an example of a filter string:
```
aid > 0 AND id >= 10 AND f > 1000.1 AND f <= 1000.5 AND d != 3.14 AND i < 0 AND bi >= -9223372036854775808 AND biu <= 9223372036854775807 AND da > 1999-01-04 AND da <= 2000-03-04 AND ts > 2000-01-01T00:00:00 AND c != 'a' AND str ~ 'hello' AND t !~ 'bye-bye' AND nil = NULL AND val != NULL
```

