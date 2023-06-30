# Data transformations

Transformation is converting data using special transformer functions. These functions are executed on a data stream, applied to each data change item, and transform them. A transformer can be run at both the metadata and data levels.

You can set up data transformations when [creating](../operations/transfer.md#create) or [updating](../operations/transfer.md#update) a transfer.

Data can only be transformed if the source and target are of different [types](../concepts/index.md#connectivity-matrix).

Transformers are set as a list. When activating a transfer, a transformation plan is made for the tables that match the specified criteria. Transformers are applied to the tables in the sequence specified in the list.

## Transformer types {#transformers-types}

In {{ data-transfer-name }}, you can use rename table and columns filter transformers. The list of transformers will be updated moving forward.

### Renaming tables {#rename-tables}

You can set rules for renaming tables by specifying the current names of the tables in the source and new names for these tables in the target.

### Columns filter {#columns-filter}

You can set up a list of table columns to transfer:

* List the tables to filter using lists of included and/or excluded tables.
* List the columns to transfer to the target tables using lists of included and/or excluded columns.
