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

