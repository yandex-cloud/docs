# Regular incremental copy

This copying is run at certain time intervals. With this method, only the data that has been modified in the source since the previous copy gets into the target. This approach allows you to update the target's data with the minimum possible latency and load on the data source. However, it does not factor in data delete operations in the source. This is more efficient than copying entire tables but less efficient than using transfers of the _{{ dt-type-copy-repl }}_ type.

{% note info %}

You can configure incremental copy for such sources as {{ PG }}, {{ CH }}, and Airbyte.

{% endnote %}

To help you find modified data, a table contains a _key column_ whose values change each time data is added or updated. For the key column, we recommend building an index so that each invocation does not result in a full table scan. If data is only added to the table, the `id` column will do as the key column. If the existing table data is likely to change, we recommend adding the `updated_at` column as the key one with the [date/time]({{ pg.docs.pro }}//postgresql/current/datatype-datetime) data type and write the current time to this column at each data update. The transfer remembers the maximum value of the key column and, when run next time, will only read the data added or updated since the last run.

Key columns can be columns of tables with [numeric]({{ pg.docs.pro }}//postgresql/current/datatype-numeric), [character]({{ pg.docs.pro }}//postgresql/current/datatype-character), or [date/time]({{ pg.docs.pro }}//postgresql/current/datatype-datetime) data type. [UUID]({{ pg.docs.pro }}//postgresql/current/datatype-uuid) will not suit as the data type in this case.

To make sure the results of regular incremental copy are correct, the source table must meet the following conditions:

* The key column values must be strictly increasing and cannot be `null`.
* The key column values must change when adding or updating data.
* The data cannot be deleted. If this is required, save the data to be deleted to another table and deliver it separately.

## Transaction completion timeout {#increment-delay}

A _transaction race_ may occur while incremental copy is in progress. This is a situation when transactions are completed in a sequence different from the one they were run in. As a result, earlier changes may be displayed after those which were made later. In that case, the transfer calculates the key column value based on the more recent changes while ignoring the older ones.

The issue is fixed with a transaction completion timeout. This is a delay between calculating the key column value and obtaining the actual data. When set, the transfer is waiting for the specified number of seconds for all transactions that might change the data in the output range to complete and only after that reads new data from the table.

Make sure the transaction completion timeout is:

* Longer than an average data insert or update transaction. In standard applications, it takes a few seconds to complete these transactions.
* Much shorter than the interval between transfer runs, as it directly impacts the transfer duration.

The recommended and default value is `15` seconds.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
