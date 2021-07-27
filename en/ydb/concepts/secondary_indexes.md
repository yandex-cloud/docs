---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Secondary indexes

This section is about YDB support for secondary indexes.

YDB automatically creates a primary key index, which is why selection by primary key is always efficient, affecting only the rows needed. Selections by criteria applied to one or more non-key columns typically result in a full table scan. To make these selections efficient, use secondary indexes.

The current version implements a global secondary index. Each index is a hidden table that is updated transactionally when the main table changes. When a user sends an SQL query to insert/modify/delete data, the database transparently generates commands to modify the index table at the query compilation stage. A table may have several secondary indexes, and an index may include several columns (the order of columns in the index matters). One column may consist of several indexes and even be part of a primary key and secondary index at the same time.

##### Specifics and limits

- For a single-shard table without an index, you can run a transaction (both reads and blind writes) that bypasses the planning stage and thus significantly reduce delays. You can't use this optimization when writing data to a table with an index, since you need to ensure data consistency: this is the inevitable price for being able to make a quick read without a full scan. [Learn more about the transaction mechanism ](transactions#distributed-tx).
- `UPSERTs` in a table with a secondary index are no longer blind. This results in a limit of one `UPSERT` per transaction with a table.

#### Building a secondary index online

In YDB, you can build a secondary index and delete an existing secondary index without stopping the service.

For a single table, you can only build one index at a time.

In general, online index building consists of the following stages:

1. Taking a snapshot of a data table and creating an index table marked that writes are available. Immediately after this stage, write transactions become distributed, writing to the main table and the index, respectively. The index is not yet available to the user.
2. Starting the process of reading the snapshot of the main table and writing data to the index. Moreover, measures are taken to resolve the situation when updates at stage 1 change the data written at stage 2 (in other words, "writes to the past" are implemented).
3. Publishing the results and deleting the snapshot. The index is ready to use.

Possible effect on user transactions:

* Immediately after the first build stage, due to the fact that transactions are now distributed, there is an increase in delays.
* During data filling, the index table automatic split function actively works to split index shards for optimal sharding. Enhanced background of OVERLOADED errors is possible.

The rate of data fill is selected to minimize its influence on user transactions. We recommend running the online build process when the load is minimum to get the maximum convergence rate.

For more information, see [Recommendations: secondary indexes](../best_practices/secondary_indexes.md).

See examples of running the index build operation using the CLI in [Using the {{ ydb-short-name }} console client](../quickstart/examples-ydb-cli#zapusk-operacii-dobavleniya-vtorichnogo-indeksa).

