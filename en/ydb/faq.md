# FAQ about {{ ydb-name }}

This page shows answers to the questions about {{ ydb-name }}. For frequently asked questions about {{ ydb-short-name }}, see the [documentation]({{ ydb.docs }}/faq/).

## {{ ydb-name }} databases in serverless mode {#serverless-ydb}

### How do secondary and vector indexes impact the cost of a request? {#secondary-vector-price}

Operations with indexes are estimated according to the same rules as operations with tables. They are reflected in the request statistics and included in the total indicators used to calculate the cost in request units (RUs). For more information, see the [pricing policy for {{ ydb-short-name }} API serverless mode](pricing/ru-yql.md).

When reading data from a table using an index, the request statistics will show the number of records read from the index and their size.

#### Secondary indexes {#secondary-indexes}

Adding a new row to a table creates a record in each existing secondary index. This action updates the statistics to reflect the increase in both the number of added records and the size of written data.

When you update a table row, the statistics will reflect the operations of deleting the old record and adding the new one for each secondary index that includes the updated fields.

When you delete a table row, the statistics will include the deletion of records from all secondary indexes of this table.

#### Vector indexes {#vector-indexes}

For a single-vector request to an index of the [`vector_kmeans_tree`](https://ydb.tech/docs/ru/dev/vector-indexes?version=main#kmeans-tree-type) type, reading takes several stages:

1. **Navigating the index tree.**  
   At each of the `levels` tree levels, [`KMeansTreeSearchTopSize`](https://ydb.tech/docs/ru/yql/reference/syntax/select/vector_index?version=main#kmeanstreesearchtopsize) clusters (each containing `clusters` subclusters) are selected from the existing clusters.
   As a result, the total number of required readings at this stage is around ${KMeansTreeSearchTopSize} * {levels} * {clusters}$.

1. **Processing final candidates.**  
   At the lowest index tree level, all rows from the selected clusters get processed.
   The number of readings at this stage is around ${KMeansTreeSearchTopSize} * N / {clusters}^{levels}$ (in a balanced tree, where `N` is the total number of rows).
   If you do not use a [covering index](https://ydb.tech/docs/ru/concepts/secondary_indexes#covering), a row will be additionally read from the main table for each candidate record found via the index.

### What does the RESOURCE_EXHAUSTED error mean? {#resource-exhausted}

This error means a limit has been reached.

Check the throughput in the {{ ydb-short-name }} cluster settings and increase it, if required. If the issue persists after you increase the throughput limit or the quota is exceeded, contact [support]({{ link-console-support }}).

### What does the ThrottlingException error mean? {#throttling-exception}

The error is related to the exceeding of the [quota](concepts/limits.md#ydb-quotas) for [RU (Request Unit)](concepts/serverless-and-dedicated.md#capacity) consumption per second.

You can change quotas for an individual database in its settings (see [{#T}](operations/manage-databases.md#update-db-serverless)). If you find your cloud quota insufficient, [contact support]({{ link-console-support }}).

To prevent users from unscheduled RU consumption, we recommend setting a [limit on maximum consumption](concepts/serverless-and-dedicated.md#capacity).
