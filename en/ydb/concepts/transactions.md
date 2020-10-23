# YDB transactions and queries

This section describes the specifics of YQL implementation for YDB transactions.

## Query language

The main tool for creating, modifying, and managing data in YDB is a declarative query language called YQL. YQL is an SQL dialect that can be considered a database interaction standard. YDB also supports a set of special RPCs that can be used, for example, to manage a tree schema or cluster.

## Transaction modes

By default, YDB transactions are performed in *Serializable* mode. It provides the strictest [isolation level](https://en.wikipedia.org/wiki/Isolation_(database_systems)#Serializable) for custom transactions. This mode guarantees that the result of successful parallel transactions is equal to their specific execution sequence, while there are no [read anomalies](https://en.wikipedia.org/wiki/Isolation_(database_systems)#Read_phenomena) for successful transactions.

If the requirements for the consistency or freshness of data read by a transaction can be lowered, the user can use execution modes with lower guarantees:

* *Online Read-Only*. Each of the reads in the transaction reads data that is most recent at the time of its execution. The consistency of retrieved data depends on the *allow_inconsistent_reads* setting:
    * *false* (consistent reads). In this mode, each individual read returns consistent data, but no consistency between different reads is guaranteed. Reading the same table range twice may return different results.
    * *true* (inconsistent reads). In this mode, even data from separately taken reads may contain inconsistent results.
* *Stale Read Only*. Data reads in a transaction return results with a possible delay (fractions of a second). Each individual read returns consistent data, but no consistency between different reads is guaranteed.

The transaction execution mode is specified in its settings when creating the transaction.

## YQL

The constructs implemented in YQL can be divided into two classes: [data definition language (DDL)](https://en.wikipedia.org/wiki/Data_definition_language) and [data manipulation language (DML)](https://en.wikipedia.org/wiki/Data_manipulation_language).

For more information about what constructs YQL supports, see the [YQL documentation](../yql/reference/overview.md).

Listed below are the features and limitations of YQL support in YDB, which might not be obvious at first glance and are worth noting.

* Multi-statement transactions (transactions made up of a sequence of YQL statements) are supported. Transactions may interact with client software, or in other words, client interactions with the database might look as follows: `BEGIN; make a SELECT; analyze the SELECT results on the client side; ...; make an UPDATE; COMMIT`. We should note that if the transaction body is fully formed before accessing the database, it will be processed more efficiently.
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

For more information about YQL support in YDB, see the [YQL documentation](../yql/reference/overview.md).

## Distributed transactions {#distributed-tx}

A database table in YDB can be sharded by the range of the primary key values. Different table shards can be served by different distributed database servers (including ones in different locations). They can also move independently between servers to enable rebalancing or ensure shard operability if servers or network equipment goes offline.

YDB supports distributed transactions, which are transactions that affect more than one shard of one or more tables.

