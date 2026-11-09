Copying with scheduled data updates runs at certain time intervals. With this method, only the data that has been modified in the source since the previous copy gets into the target. This approach allows you to update the target's data with the minimum possible latency and load on the data source. However, it does not factor in data delete operations in the source. Copying only the modified rows allows reducing the amount of transmitted data as compared to copying entire tables.

To help you find modified data, a table contains a _cursor column_ (key column) whose values change each time data is added or updated. For the cursor column, you need to build an index so that each invocation does not result in a full table scan. If data is only added to the table, the `id` column will do as the cursor column. If the existing table data may be modified, we recommend adding the `updated_at` column as the cursor one with the [date/time]({{ pg.docs.pro }}//postgresql/current/datatype-datetime) data type and write the current time to this column at each data update. The transfer remembers the maximum value of the cursor column and, when run next time, will only read the data added or updated since the last run.

{% cut "Configuration recommendations" %}

You can use tables with [numeric]({{ pg.docs.pro }}//postgresql/current/datatype-numeric), [character]({{ pg.docs.pro }}//postgresql/current/datatype-character), or [date/time]({{ pg.docs.pro }}//postgresql/current/datatype-datetime) data type as a cursor column, while, e.g., the [UUID]({{ pg.docs.pro }}//postgresql/current/datatype-uuid) data type will not fit in this case.

To make sure the results of regular incremental copy are correct, the source table must meet the following conditions:

* The cursor column values must be strictly increasing and cannot be `null`.
* The cursor column values must change when adding or updating data.
* The data cannot be deleted. If this is required, save the data to be deleted to another table and transfer it separately.

{% endcut %}
