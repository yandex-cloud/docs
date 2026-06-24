#### How does {{ SPQR }} process SQL queries? {#sql-queries-parcing}

{{ SPQR }} processes SQL queries depending on their type and context:

* Regular queries: {{ SPQR }} processes the query to determine the table, column, and the value being accessed. This data is compared against pre-defined sharding rules (e.g., by key or range). Based on these rules, the system determines the target shard the request should be sent to.

* Requests with routing settings: Routing of such a request can be affected by virtual parameters that are specified as comments in the SQL query or in the router configuration.

* Transactions: When receiving the `BEGIN TRANSACTION` command, {{ SPQR }} does not execute queries immediately. Instead, it stores all subsequent queries in memory (e.g., `SET` commands). The entire transaction is sent to a specific shard only when a query is received for which the target shard can be clearly identified. This allows for execution of the entire transaction on a single shard.

#### How to perform transactions across multiple shards? {#multi-shard-transactions}

For atomic cross-shard transactions, use two-phase commit (2PC):

1. At the beginning of the session: `SET __spqr__commit_strategy TO '2pc'`.
1. In a separate `COMMIT` operation: Add the `/* __spqr__commit_strategy: 2pc */` virtual parameter.
1. Make sure the shards are set to `max_prepared_transactions > 0`.

  {% note warning %}

  Without 2PC, changes may be applied partially.

  {% endnote %}

`COPY` operations are supported with the `/* __spqr__allow_multishard: true */` virtual parameter.

You can set virtual parameters with comments in SQL or via `SET`.

#### How to explicitly specify which shard to run the query on? {#how-to-specify-shard}

To specify the shard to run a query on, use virtual parameters:

* `/* __spqr__execute_on: <shard_name> */`: Specifies a specific shard to run the query on.

  To find out the shard name, run the `SHOW shards;` SQL query.

* `/* __spqr__auto_distribution: ... */`: Selects a sharding rule for routing.
* `/* __spqr__scatter_query: true */`: Enables sending a query to all shards.

You can set virtual parameters with comments in SQL or via `SET`.

For more information on the query execution settings, see [this SPQR guide](https://docs.pg-sharding.tech/routing/hints#__spqr__target_session_attrs).

#### What transaction commit strategies are supported? {#commit-strategy}

{{ SPQR }} supports single-phase and two-phase commits.

The commit method in a distributed transaction is specified by the `__spqr__commit_strategy` virtual parameter. The possible values are:

* `1pc`: One-stage commit (best-effort commit).
* `2pc`: Two-stage commit.

  For a two-stage commit, use the `/* __spqr__engine_v2: true */` virtual parameter and set the `max_prepared_transactions` {{ PG }} parameter on all shards.

You can set virtual parameters with comments in SQL or via `SET`.

#### How do reference tables work? {#reference-tables}

Data in such tables is replicated across all shards. Queries to them are automatically sent to all nodes using two-stage commit.

#### How to create reference tables? {#how-to-create-reference-table}

Tables that are identical on all shards are created through the coordinator:

```sql
CREATE REFERENCE TABLE table_name (...);
```

Data is automatically replicated to all shards. Queries to them are executed without specifying sharding.

For more information on creating reference tables, see [this SPQR guide](https://docs.pg-sharding.tech/sharding/console/sql_commands#create-reference-table).

#### Does {{ SPQR }} support distributed sequences? {#distributed-sequences}

Yes, {{ SPQR }} guarantees the uniqueness of the autoincrement at the cluster level by using the `CREATE REFERENCE TABLE ... AUTO INCREMENT` command.

#### Is it possible to shard related tables based on a single key? {#single-key-sharding-for-connected-tables}

Yes, {{ SPQR }} allows you to store related data from different tables on a single shard, which simplifies JOIN operations within a shard.

#### How are queries executed without an explicit sharding key? {#queries-with-no-explicit-key}

By default, queries without a sharding key (multishard requests) are prohibited. You can enable them using the `/* __spqr__scatter_query: true */` virtual parameter. The results from each shard are merged, but there is no guarantee of consistency.

You can set virtual parameters with comments in SQL or via `SET`.
