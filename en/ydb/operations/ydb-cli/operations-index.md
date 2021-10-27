# Working with secondary indexes

This section describes how to manage secondary indexes. A secondary index is added asynchronously. After running the add index command in this mode, the YDB CLI immediately outputs information about the operation and allows the user to continue working.

## Adding a secondary index {#operation-index}

You can use the YDB CLI to create an additional index for a table. In the example below, the `title_index` index is added by the `title, series` pair:

```bash
{{ ydb-cli }} -e <endpoint> -d <database> table index add global --index-name title_index --columns title series
```

The command returns the ID of the build index operation.

```bash
┌────────────────────────────────────────┬───────┬────────┐
| id                                     | ready | status |
├────────────────────────────────────────┼───────┼────────┤
| ydb://buildindex/7?id=1407375091598308 | false |        |
└────────────────────────────────────────┴───────┴────────┘
```

## Getting information about the operation progress {#one-get}

To get information about the progress of the add secondary index operation, you should check its status on a regular basis:

```bash
{{ ydb-cli }} -e <endpoint> -d <database> operation get ydb://buildindex/7?id=1407375091598308
```

Command results:

```bash
┌────────────────────────────────────────┬───────┬─────────┬───────┬──────────┬───────────────────────────────────────────────────────────────┬─────────────┐
| id                                     | ready | status  | state | progress | table                                                         | index       |
├────────────────────────────────────────┼───────┼─────────┼───────┼──────────┼───────────────────────────────────────────────────────────────┼─────────────┤
| ydb://buildindex/7?id=1407375091598308 | true  | SUCCESS | Done  | 100.00%  | /ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj/series | title_index |
└────────────────────────────────────────┴───────┴─────────┴───────┴──────────┴───────────────────────────────────────────────────────────────┴─────────────┘
```

Where:

- `progress` is the percentage of shards in the source table that completed the data transfer.
- `status` is the result of the entire build operation. Displayed when the operation is completed.

## Getting information about all build index operations for the DB {#all-get}

To view all build index operations for the DB:

```bash
{{ ydb-cli }} -e <endpoint> -d <database> operation list buildindex
```

Command results:

```bash
┌────────────────────────────────────────┬───────┬─────────┬───────┬──────────┬───────────────────────────────────────────────────────────────┬─────────────┐
| id                                     | ready | status  | state | progress | table                                                         | index       |
├────────────────────────────────────────┼───────┼─────────┼───────┼──────────┼───────────────────────────────────────────────────────────────┼─────────────┤
| ydb://buildindex/7?id=1407375091598308 | true  | SUCCESS | Done  | 100.00%  | /ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj/series | title_index |
└────────────────────────────────────────┴───────┴─────────┴───────┴──────────┴───────────────────────────────────────────────────────────────┴─────────────┘

Next page token: 0
```

## Canceling the build index operation {#cancel}

To cancel the build index operation:

```bash
{{ ydb-cli }} -e <endpoint> -d <database> operation cancel ydb://buildindex/7?id=1407375091598308
```

After the operation is completed or canceled, it should be erased from the database:

```bash
{{ ydb-cli }} -e <endpoint> -d <database> operation forget ydb://buildindex/7?id=1407375091598308
```

## Deleting an index {#delete-index}

If you don't need an index, you can delete it. Deleting an index is a regular synchronous query. The result is returned as soon as the query is executed.

```bash
{{ ydb-cli }} -e <endpoint> -d <database> table index drop --index-name title_index series
```

