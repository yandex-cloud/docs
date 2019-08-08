#  YDB transactions and queries

The main tool for creating, modifying, and managing data in {{ ydb-short-name }} is a declarative query language called [YQL](../yql/reference/quickstart.md). *YQL* is an SQL dialect that can be considered a database interaction standard. YDB also supports a set of special RPCs, which can be used to manage a tree schema or database, for example.

## Transaction modes {#transaction-modes}

The {{ ydb-short-name }} kernel implements the highest level of isolation: [serializable](https://en.wikipedia.org/wiki/Isolation_(database_systems)#Serializable). This means that transactions that are fully carried out in parallel are not subject to any abnormalities. The effects of concurrent executions are the same as serial executions.

You can also decrease the level of isolation by setting `ReadCommitted`, `ReadUncommitted`, and `ReadStale` values with relevant pragma:

* Serializable Read Write is a read/write transaction execution mode with the highest level of isolation. Transactions are completely isolated from each other and each transaction is executed serially.
* Online Read Only is for reading the latest data at the time of reading. Repeatable reads are not supported. You can configure Consistent reads/Inconsistent reads.
* Stale Read Only is for reading data with a possible delay (fractions of a second). Consistent reads.

## Transactions in YQL {#yql}

The constructs implemented in YQL can be divided into two classes: [data definition language (DDL)](https://en.wikipedia.org/wiki/Data_definition_language) and [data manipulation language (DML)](https://en.wikipedia.org/wiki/Data_manipulation_language).

Listed below are the features and limitations of YQL support in {{ ydb-short-name }}, which might not be obvious at first glance and are worth noting:

* Multi-statement transactions (transactions made up of a sequence of YQL statements) are supported. Transactions may interact with client software, or in other words, client interactions with the database might look as follows:

```
BEGIN;
Perform a SELECT statement.
Analyze the SELECT results on the client side. 
...;
Perform UPDATE.
COMMIT
```

We should note that if the transaction body is fully formed before accessing the database, it will be processed more efficiently.

* YDB does not support transactions that combine DDL and DML queries. The traditional [ACID](https://ru.wikipedia.org/wiki/ACID) transaction paradigm only applies to DML queries, meaning that change data. DDL queries must be idempotent, meaning repeatable if an error occurs. If you need to apply an action to a schema, remember that each action is transactional, while a set of actions is not.
* The version of YQL in YDB uses the [Optimistic concurrency control](https://en.wikipedia.org/wiki/Optimistic_concurrency_control) mechanism. Optimistic locking is applied to entities affected during a transaction. When the transaction is complete, the mechanism verifies that the locks have not been invalidated. For the user, locking optimism means that when transactions are competing with one another, the one that finishes first wins. Competing transactions fail with the ```Transaction locks invalidated``` error.
* All changes made during the transaction accumulate in the database server memory and are committed when the transaction completes. If the locks are not invalidated, all the changes accumulated are committed atomically, but if at least one lock is invalidated, none of the changes are committed. The above model involves certain restrictions: changes made by a single transaction must fit inside the available memory, and the transaction "doesn't see" its changes.

A transaction should be formed in such a way so that the first part of the transaction only reads data, while the second part of the transaction only changes data. The query structure then looks as follows:

```yql
SELECT ...;
....
SELECT ...;
UPDATE/REPLACE/DELETE ...;
COMMIT;
```

For more information about YQL support in YDB, see the [YQL documentation](../yql/reference/quickstart.md).

## Distributed transactions {#distributed-transactions}

A database table in {{ ydb-short-name }} can be sharded by the range of the primary key values. Different table shards can be served by different distributed database servers (including ones in different availability zones). They can also move independently between servers to enable rebalancing or ensure shard operability if servers or network equipment goes offline.

{{ ydb-short-name }} supports distributed transactions, which are transactions that affect more than one shard of one or more tables.

