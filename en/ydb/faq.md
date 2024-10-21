# Questions and answers about {{ ydb-name }}

This page shows answers to the questions about {{ ydb-name }}. For frequently asked questions about {{ ydb-short-name }}, see the [documentation]({{ ydb.docs }}/faq/).

## {{ ydb-name }} databases in Serverless mode

### How do secondary indexes impact the cost of a query?

Operations with indexes are estimated according to the same rules as operations with tables. They are reflected in the request statistics and included in the total indicators that are used to calculate the cost in request units (RUs). For more information, see the [pricing policy for the serverless {{ ydb-short-name }} API](pricing/ru-yql.md).

When reading data from a table using an index, the request statistics will show the number of rows read from the index and their volume.

When adding a new row to a table, a record is also added to each index that exists in this table, with the number of added records and the volume of written data shown in the statistics.

Whenever a table row update occurs, the statistics will reflect a deletion operation for the old record and an insert for the new one for all indexes that include the fields being updated.

When deleting a table row, the statistics will include the deletion of records from all indexes in this table.

### What does the RESOURCE_EXHAUSTED error mean? {#resource-exhausted}

This error means a limit has been reached.

Check the throughput in the {{ ydb-short-name }} cluster settings and increase it, if required. If the issue persists after you increase the throughput limit or the quota is exceeded, contact [support]({{ link-console-support }}).

### What does the ThrottlingException error mean? {#throttling-exception}

The error is related to the exceeding of the [quota](concepts/limits.md#ydb-quotas) for [RU (Request Unit)](concepts/serverless-and-dedicated.md#capacity) consumption per second.

You can change quotas for individual databases in their settings (see [{#T}](operations/manage-databases.md#update-db-serverless)). If you find your cloud quota insufficient, [contact the support service]({{ link-console-support }}).

To prevent users from unscheduled RU consumption, we recommend setting a [limit on maximum consumption](concepts/serverless-and-dedicated.md#capacity).
